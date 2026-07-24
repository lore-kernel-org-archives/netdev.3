Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1AD352034
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 08:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784880802; cv=none; b=RkfKOfQ/PRE7vzYyrZYzfuPQNELeufQz7xWm4AaX3syLUDAgrLf6+nzWYw3ds9Plh4hXYqByp8otccvIvjjk44EmqweQIh4IfhTZGQasEN5p7CMS7v+jgitZYFxKGGeqDNBavUp7iJZ6PJ6TcnpUGO8Z6RZDjOJSRSbDG2DAUmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784880802; c=relaxed/simple;
	bh=2/WQmAyq78z+aoW7mJVHkd4nYYvqNuAGeezmdDazd3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E/CzFZi4aGXaOpYKIIliG4YhhALHXPvpyzbiE02E5HK2XzxK0c74YJpfCUCUlJSnkH4goXsIvLM9g7o6L8+96OnITFiXqIClvNleb1CZqJK3O2wtplauRdpsg1D3VZgEvrg9Of82bBUUzhA4rEkIEuzuet8FT8jWxp9bcSUcDPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=UmAC+t4L; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="UmAC+t4L"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=vfsUTvBFh7EdrMt0DG6BU6THNFQgADAOEqhxQFGlXps=;
	b=UmAC+t4LC4F9ONNBZl6NijrKb3OmCew28GraeXaB4uYc6TvsCfjecOc2Bvcx6U3wQhUaYSCjG
	xhGBZyQW76E56WK0meaKvnW9/mDUborIhwwv//B+7cILaZZ68DHlC7VdVr+T/yGxsAmTjLQMhBQ
	1sRqlkTR7noAqrULWTpWoa4=
Received: from mail.maildlp.com (unknown [172.19.162.197])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4h60ql6JTzz1prKd;
	Fri, 24 Jul 2026 16:03:47 +0800 (CST)
Received: from kwepemr100001.china.huawei.com (unknown [7.202.195.168])
	by mail.maildlp.com (Postfix) with ESMTPS id CC45E40579;
	Fri, 24 Jul 2026 16:13:13 +0800 (CST)
Received: from [10.136.112.147] (10.136.112.147) by
 kwepemr100001.china.huawei.com (7.202.195.168) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 24 Jul 2026 16:13:12 +0800
Message-ID: <c05bb9fd-e7ac-472d-83e3-c289f81e717c@h-partners.com>
Date: Fri, 24 Jul 2026 16:13:12 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] vlan: fix skb_under_panic and races when toggling
 HW VLAN offload
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
	<davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	<eric.dumazet@gmail.com>, gaoxingwang <gaoxingwang1@huawei.com>, huyizhen
	<huyizhen2@huawei.com>
References: <20260724035419.1473174-1-edumazet@google.com>
Content-Language: en-US
From: xietangxin <xietangxin@h-partners.com>
In-Reply-To: <20260724035419.1473174-1-edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemr100001.china.huawei.com (7.202.195.168)



On 7/24/2026 11:54 AM, Eric Dumazet wrote:
> Toggling hardware VLAN TX offload (NETIF_F_HW_VLAN_CTAG_TX or
> NETIF_F_HW_VLAN_STAG_TX) on a lower device invokes vlan_transfer_features(),
> which dynamically changed vlandev->hard_header_len.
> 
> This causes two issues:
> 1. Lockless TX paths (e.g. packet_snd in af_packet.c, ip6_finish_output2)
>    read dev->hard_header_len without holding RTNL lock. Mutating
>    hard_header_len dynamically under RTNL creates a data race where upper
>    layers reserve insufficient headroom based on a stale hard_header_len,
>    resulting in skb_under_panic when vlan_dev_hard_header() is called.
> 2. In addition, vlan_transfer_features() updated hard_header_len without
>    updating header_ops, causing a mismatch between allocated headroom
>    and header creation.
> 
> Always setting dev->hard_header_len = real_dev->hard_header_len and
> dev->needed_headroom = real_dev->needed_headroom + VLAN_HLEN unconditionally
> ensures:
> - dev->hard_header_len remains 100% static and immutable at real_dev->hard_header_len,
>   eliminating all dynamic runtime updates and data races on hard_header_len.
> - Upper layers allocating skbs via LL_RESERVED_SPACE() will always reserve
>   sufficient headroom for software VLAN tag insertion (real_dev->hard_header_len +
>   real_dev->needed_headroom + VLAN_HLEN).
> - AF_PACKET SOCK_RAW network header offsets remain correctly aligned at
>   real_dev->hard_header_len.
> - vlan_header_ops is used unconditionally.
> 
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Reported-by: Tangxin Xie <xietangxin@h-partners.com>
> Closes: https://lore.kernel.org/netdev/99d678ae-c7b2-4b44-b534-b8320679deb3@h-partners.com/
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> ---
> v2: apply the VLAN_HLEN provision on needed_headroom
> v1: https://lore.kernel.org/netdev/20260723092203.5b1470f5@kernel.org/T/#t
> 
>  net/8021q/vlan_dev.c | 37 +++++--------------------------------
>  1 file changed, 5 insertions(+), 32 deletions(-)
> 
> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> index ec2569b3f8dac629027b4344bc89402decf026d1..aaf2051a434cfef30d52e0434a9c372142f49195 100644
> --- a/net/8021q/vlan_dev.c
> +++ b/net/8021q/vlan_dev.c
> @@ -502,26 +502,6 @@ static const struct header_ops vlan_header_ops = {
> 	.parse_protocol = vlan_parse_protocol,
>  };
> 
> -static int vlan_passthru_hard_header(struct sk_buff *skb, struct net_device *dev,
> -					 unsigned short type,
> -					 const void *daddr, const void *saddr,
> -					 unsigned int len)
> -{
> -	struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
> -	struct net_device *real_dev = vlan->real_dev;
> -
> -	if (saddr == NULL)
> -		saddr = dev->dev_addr;
> -
> -	return dev_hard_header(skb, real_dev, type, daddr, saddr, len);
> -}
> -
> -static const struct header_ops vlan_passthru_header_ops = {
> -	.create	 = vlan_passthru_hard_header,
> -	.parse	 = eth_header_parse,
> -	.parse_protocol = vlan_parse_protocol,
> -};
> -
>  static const struct device_type vlan_type = {
> 	.name	= "vlan",
>  };
> @@ -580,14 +560,9 @@ static int vlan_dev_init(struct net_device *dev)
> 	dev->fcoe_ddp_xid = real_dev->fcoe_ddp_xid;
>  #endif
> 
> -	dev->needed_headroom = real_dev->needed_headroom;
> -	if (vlan_hw_offload_capable(real_dev->features, vlan->vlan_proto)) {
> -		dev->header_ops 	 = &vlan_passthru_header_ops;
> -		dev->hard_header_len = real_dev->hard_header_len;
> -	} else {
> -		dev->header_ops 	 = &vlan_header_ops;
> -		dev->hard_header_len = real_dev->hard_header_len + VLAN_HLEN;
> -	}
> +	dev->needed_headroom = real_dev->needed_headroom + VLAN_HLEN;
> +	dev->header_ops 	 = &vlan_header_ops;
> +	dev->hard_header_len = real_dev->hard_header_len;
> 
> 	dev->netdev_ops = &vlan_netdev_ops;
> 
> @@ -1029,10 +1004,8 @@ static void vlan_transfer_features(struct net_device *dev,
> 
> 	netif_inherit_tso_max(vlandev, dev);
> 
> -	if (vlan_hw_offload_capable(dev->features, vlan->vlan_proto))
> -		vlandev->hard_header_len = dev->hard_header_len;
> -	else
> -		vlandev->hard_header_len = dev->hard_header_len + VLAN_HLEN;
> +	vlandev->needed_headroom = dev->needed_headroom + VLAN_HLEN;
> +	vlandev->hard_header_len = dev->hard_header_len;
> 
>  #if IS_ENABLED(CONFIG_FCOE)
> 	vlandev->fcoe_ddp_xid = dev->fcoe_ddp_xid;
> --
> 2.55.0.229.g6434b31f56-goog
> 
Hi Eric,

While testing this backport in our local environment, we hit a similar
skb_under_panic issue when layering macvlan on top of a VLAN device.

macvlan does't sync vlan's need_headroom, so skb head align to 16 bytes.
when skb arrive vlan, call vlan_header_ops -> vlan_dev_hard_header,
push VLAN_HLEN 4 + ETH_LEN 14 to skb, oops.

Call trace
==========
[  103.088286] skbuff: skb_under_panic: text:ffff800080d2159c len:114 put:14 head:ffff0000d2055800 data:ffff0000d20557fe tail:0x70 end:0x6c0 dev:macvlan
[  103.088344] ------------[ cut here ]------------
[  103.088346] kernel BUG at net/core/skbuff.c:214!
[  103.088350] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
[  103.098003] CPU: 3 UID: 0 PID: 160 Comm: kworker/3:3 Kdump: loaded Not tainted 7.2.0-rc4+ #56 PREEMPTLAZY
[  103.099007] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
[  103.099725] Workqueue: mld mld_ifc_work
[  103.100169] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[  103.100898] pc : skb_panic+0x58/0x68
[  103.101310] lr : skb_panic+0x58/0x68
[  103.101738] sp : ffff800083d1b950
[  103.109858] Call trace:
[  103.110161]  skb_panic+0x58/0x68 (P)
[  103.110578]  skb_push+0x58/0x60
[  103.110971]  eth_header+0x3c/0xe0
[  103.111359]  vlan_dev_hard_header+0x7c/0x1a8 [8021q]
[  103.111904]  macvlan_hard_header+0x38/0x60 [macvlan]
[  103.112455]  neigh_resolve_output.part.0+0xa8/0x168
[  103.113081]  neigh_resolve_output+0x4c/0x90
[  103.113639]  ip6_finish_output2+0x2c0/0x858
[  103.114182]  ip6_finish_output+0x23c/0x398
[  103.114741]  ip6_output+0x90/0x250
[  103.115211]  NF_HOOK.constprop.0+0x54/0x118
[  103.115699]  mld_sendpack+0x1cc/0x3d0
[  103.116202]  mld_send_cr+0x1cc/0x318
[  103.116696]  mld_ifc_work+0x38/0x128


Reproducer
==========
ip link add veth0 type veth peer name veth1
ip link set veth0 up
ip link set veth1 up

ip link add link veth0 name vlan_test type vlan id 10 reorder_hdr off
ip link set vlan_test up

# macvlan does't sync vlan's need_headroom,
ip link add link vlan_test name macvlan type macvlan
ip link set macvlan up

ethtool -K veth0 tx-vlan-hw-insert off

# skb_under_panic
ip -6 addr add fe80::1/64 dev macvlan

-- 
Best regards,
Tangxin Xie

