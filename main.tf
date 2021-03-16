provider "alicloud" {
  region = "cn-beijing"
  version = "=1.118.0"
}

resource "alicloud_pvtz_zone" "zone" {
  name = "foo.test.com"
}

resource "alicloud_vpc" "first" {
  name       = "the-first-vpc"
  cidr_block = "172.16.0.0/12"
}
resource "alicloud_vpc" "second" {
  name       = "the-second-vpc"
  cidr_block = "172.16.0.0/16"
}

resource "alicloud_pvtz_zone_attachment" "zone-attachment" {
  zone_id = alicloud_pvtz_zone.zone.id
  vpc_ids = [alicloud_vpc.first.id, alicloud_vpc.second.id]
}

resource "alicloud_pvtz_zone_record" "this" {
  zone_id = alicloud_pvtz_zone.zone.id
  rr = "www"
  type = "A"
  value = "2.2.2.2"
  ttl = "60"
}

