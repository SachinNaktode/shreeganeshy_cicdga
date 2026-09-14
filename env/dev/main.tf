module "rg" {
  source = "../../childmodule/rg"
  rg     = var.rg

}
module "vnet" {
  depends_on = [module.rg]
  source     = "../../childmodule/vnet"
  vnet       = var.vnet

}

module "subnet" {
  depends_on = [module.vnet]
  source     = "../../childmodule/subnet"
  subnet     = var.subnet

}

module "nsg" {
  depends_on = [module.rg]
  source     = "../../childmodule/nsg"
  nsg        = var.nsg

}

module "pip" {
  depends_on = [module.rg]

  source = "../../childmodule/pip"
  pip    = var.pip

}

module "nic" {
  source = "../../childmodule/nic"

  nic = {
    for key, value in var.nic : key => merge(
      value,
      {
        subnet_id = module.subnet.subnet_id[key]
      }
    )
  }
}

module "vm" {
  source = "../../childmodule/vm"
  vm = {
    for key, value in var.vm : key => merge(
      value,
      {
        nic_id = module.nic.nic_id[key]
      }
    )
  }
}