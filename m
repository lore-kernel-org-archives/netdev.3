Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E75333688C
	for <netdev@vger.kernel.org>; Sat, 25 Jul 2026 01:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784943738; cv=none; b=Ik6fNhYXMBqXZiH6w4fPaivnaU7JvIPOOl2jO2k7zL0wcQPKGlc62Lt99r8hXZHfdU1ZR7hHALnu5KcbYclPt+wgZemuwXHNuMaXtV2ohPY516jYbQIPupJNknCuuEZcFlrpnOf03KdQFZW82Az39M9UmsWc7ZhNNfccWichx30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784943738; c=relaxed/simple;
	bh=19XGmO15zF6usEn28WPHzig700N3WmR00YQb7QL22jk=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=VBnuCujhO3GNdQwLAbOtadz3yWJgAM9piJ4t2p2RqnuxwtlD3TpwXtAk9CBwOBke5/jfFQ2IBixgmneyJLBh71ivsosYa4kmIDn/V9TI3EZO6QHEoPL5hrAU430j6bZKd6Ze45vCS8lb99AojVRnCeAzkHdXqhf42IjQIz0mCIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=DLrif1Hm; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="DLrif1Hm"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=YiDKPnH/OtVa0PvJKe0RMBDsgnZKx4Oc1GcCu6aJrB0=;
	b=DLrif1HmXfMFNoaMQdsAOY9mFIcoefEDdF+kQeyE5jTYtC1hevdG7RT2l+AtCqjBaM8sbEyay
	VW1K21godx27kOdSMFFzWfvtjysgstr0i2lUPpCZ8b8F1t1EaKusTLOcS/WjPv3w5hSw1b0MFDp
	O6kHfEQ5nOrhG8t8WruA2oI=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4h6S6P4q0KzpStj;
	Sat, 25 Jul 2026 09:33:01 +0800 (CST)
Received: from kwepemr100001.china.huawei.com (unknown [7.202.195.168])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D53140561;
	Sat, 25 Jul 2026 09:42:11 +0800 (CST)
Received: from [10.136.112.147] (10.136.112.147) by
 kwepemr100001.china.huawei.com (7.202.195.168) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 25 Jul 2026 09:42:10 +0800
Message-ID: <e857b453-3fda-4457-9c93-9eae376157d5@h-partners.com>
Date: Sat, 25 Jul 2026 09:42:09 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] vlan: fix skb_under_panic and races when toggling
 HW VLAN offload
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Ido Schimmel <idosch@nvidia.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>, <eric.dumazet@gmail.com>,
	gaoxingwang <gaoxingwang1@huawei.com>, huyizhen <huyizhen2@huawei.com>
References: <20260724035419.1473174-1-edumazet@google.com>
 <c05bb9fd-e7ac-472d-83e3-c289f81e717c@h-partners.com>
 <CANn89iKtaD6-ABj5-FnKGpHcRAtAOkiYUn1yzNa4GHTrpH28hw@mail.gmail.com>
 <f9136972-bc6a-4156-9a74-265c204fb1dc@h-partners.com>
 <CANn89iLO_STTESJwU-shGJGZ7BbrFaePb64ePfr=J7bffV4WXA@mail.gmail.com>
 <b00519e7-9c43-4867-baeb-f7ed1303424a@h-partners.com>
 <CANn89iJWJD_KXpeDOne2ujeznOADV8O=rU5+jdqQF6YMEkNkJg@mail.gmail.com>
Content-Language: en-US
From: xietangxin <xietangxin@h-partners.com>
In-Reply-To: <CANn89iJWJD_KXpeDOne2ujeznOADV8O=rU5+jdqQF6YMEkNkJg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemr100001.china.huawei.com (7.202.195.168)



On 7/24/2026 6:43 PM, Eric Dumazet wrote:
> On Fri, Jul 24, 2026 at 12:24 PM xietangxin <xietangxin@h-partners.com> wrote:
>>
>>
>>
>> On 7/24/2026 5:39 PM, Eric Dumazet wrote:
>>> On Fri, Jul 24, 2026 at 11:29 AM xietangxin <xietangxin@h-partners.com> wrote:
>>>>
>>>>
>>>>
>>>> On 7/24/2026 4:40 PM, Eric Dumazet wrote:
>>>>> On Fri, Jul 24, 2026 at 10:13 AM xietangxin <xietangxin@h-partners.com> wrote:
>>>>>>
>>>>>>
>>>>>> Hi Eric,
>>>>>>
>>>>>> While testing this backport in our local environment, we hit a similar
>>>>>> skb_under_panic issue when layering macvlan on top of a VLAN device.
>>>>>>
>>>>>> macvlan does't sync vlan's need_headroom, so skb head align to 16 bytes.
>>>>>> when skb arrive vlan, call vlan_header_ops -> vlan_dev_hard_header,
>>>>>> push VLAN_HLEN 4 + ETH_LEN 14 to skb, oops.
>>>>>>
>>>>>> Call trace
>>>>>> ==========
>>>>>> [  103.088286] skbuff: skb_under_panic: text:ffff800080d2159c len:114 put:14 head:ffff0000d2055800 data:ffff0000d20557fe tail:0x70 end:0x6c0 dev:macvlan
>>>>>> [  103.088344] ------------[ cut here ]------------
>>>>>> [  103.088346] kernel BUG at net/core/skbuff.c:214!
>>>>>> [  103.088350] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
>>>>>> [  103.098003] CPU: 3 UID: 0 PID: 160 Comm: kworker/3:3 Kdump: loaded Not tainted 7.2.0-rc4+ #56 PREEMPTLAZY
>>>>>> [  103.099007] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>>>>>> [  103.099725] Workqueue: mld mld_ifc_work
>>>>>> [  103.100169] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>>>> [  103.100898] pc : skb_panic+0x58/0x68
>>>>>> [  103.101310] lr : skb_panic+0x58/0x68
>>>>>> [  103.101738] sp : ffff800083d1b950
>>>>>> [  103.109858] Call trace:
>>>>>> [  103.110161]  skb_panic+0x58/0x68 (P)
>>>>>> [  103.110578]  skb_push+0x58/0x60
>>>>>> [  103.110971]  eth_header+0x3c/0xe0
>>>>>> [  103.111359]  vlan_dev_hard_header+0x7c/0x1a8 [8021q]
>>>>>> [  103.111904]  macvlan_hard_header+0x38/0x60 [macvlan]
>>>>>> [  103.112455]  neigh_resolve_output.part.0+0xa8/0x168
>>>>>> [  103.113081]  neigh_resolve_output+0x4c/0x90
>>>>>> [  103.113639]  ip6_finish_output2+0x2c0/0x858
>>>>>> [  103.114182]  ip6_finish_output+0x23c/0x398
>>>>>> [  103.114741]  ip6_output+0x90/0x250
>>>>>> [  103.115211]  NF_HOOK.constprop.0+0x54/0x118
>>>>>> [  103.115699]  mld_sendpack+0x1cc/0x3d0
>>>>>> [  103.116202]  mld_send_cr+0x1cc/0x318
>>>>>> [  103.116696]  mld_ifc_work+0x38/0x128
>>>>>>
>>>>>>
>>>>>> Reproducer
>>>>>> ==========
>>>>>> ip link add veth0 type veth peer name veth1
>>>>>> ip link set veth0 up
>>>>>> ip link set veth1 up
>>>>>>
>>>>>> ip link add link veth0 name vlan_test type vlan id 10 reorder_hdr off
>>>>>> ip link set vlan_test up
>>>>>>
>>>>>> # macvlan does't sync vlan's need_headroom,
>>>>>> ip link add link vlan_test name macvlan type macvlan
>>>>>> ip link set macvlan up
>>>>>>
>>>>>> ethtool -K veth0 tx-vlan-hw-insert off
>>>>>>
>>>>>> # skb_under_panic
>>>>>> ip -6 addr add fe80::1/64 dev macvlan
>>>>>
>>>>> Thanks for testing and for providing a clean repro.
>>>>>
>>>>> This definitely is a bug in macvlan :/, I am pretty sure it can be
>>>>> stacked on top of devices that have a non zero needed_headroom.
>>>>>
>>>>> Maybe the bug was hidden because skb->head was properly reallocated
>>>>> for such lower devices incurring an expensive kmalloc()/kfree().
>>>>>
>>>>>
>>>>> diff --git a/drivers/net/macvlan.c b/drivers/net/macvlan.c
>>>>> index c40fa331836bb2395267914807542ae5094e1a3c..0fb619413d94c89e472efed4a6a9f0dd7fb69940
>>>>> 100644
>>>>> --- a/drivers/net/macvlan.c
>>>>> +++ b/drivers/net/macvlan.c
>>>>> @@ -950,6 +950,7 @@ static int macvlan_init(struct net_device *dev)
>>>>>         dev->lltx               = true;
>>>>>         netif_inherit_tso_max(dev, lowerdev);
>>>>>         dev->hard_header_len    = lowerdev->hard_header_len;
>>>>> +       dev->needed_headroom    = lowerdev->needed_headroom;
>>>>>         macvlan_set_lockdep_class(dev);
>>>>>
>>>>>         vlan->pcpu_stats = netdev_alloc_pcpu_stats(struct vlan_pcpu_stats);
>>>>> @@ -1824,6 +1825,7 @@ static int macvlan_device_event(struct
>>>>> notifier_block *unused,
>>>>>         case NETDEV_FEAT_CHANGE:
>>>>>                 list_for_each_entry(vlan, &port->vlans, list) {
>>>>>                         netif_inherit_tso_max(vlan->dev, dev);
>>>>> +                       vlan->dev->needed_headroom = dev->needed_headroom;
>>>>>                         netdev_update_features(vlan->dev);
>>>>>                 }
>>>>>                 break;
>>>> Hi Eric,
>>>>
>>>> I tested this patch with two reproducers, and it indeed fixes.
>>>> However, are there other similar issues where devices on vlan?
>>>
>>> Tell me :)
>>>
>>> At least our selftests passed.
>>>
>>> Note that many devices have belts and suspenders. They use
>>> skb_cow(skb, min_headroom) or pskb_expand_head(), because we have
>>> numerous bugs yet to be fixed.
>> Hi Eric,
>>
>> I ran few tests on other devices over vlan,
>> and ipvlan triggers the exact same skb_under_panic issue.
>> I haven't tested many devices, and there might be others.
>>
>> Call trace
>> ==========
>> [  113.414244] skbuff: skb_under_panic: text:ffff800080d2159c len:114 put:14 head:ffff0000c716d000 data:ffff0000c716cffe tail:0x70 end:0x6c0 dev:ipvlan_test
>> [  113.414286] ------------[ cut here ]------------
>> [  113.414288] kernel BUG at net/core/skbuff.c:214!
>> [  113.414290] Internal error: Oops - BUG: 00000000f2000800 [#1]  SMP
>> [  113.424840] CPU: 1 UID: 0 PID: 315 Comm: kworker/1:4 Kdump: loaded Not tainted 7.2.0-rc4+ #59 PREEMPTLAZY
>> [  113.425832] Hardware name: QEMU KVM Virtual Machine, BIOS 0.0.0 02/06/2015
>> [  113.426573] Workqueue: mld mld_ifc_work
>> [  113.427039] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> [  113.427788] pc : skb_panic+0x58/0x68
>> [  113.428224] lr : skb_panic+0x58/0x68
>> [  113.428638] sp : ffff800083d1b950
>> [  113.437079]  skb_panic+0x58/0x68 (P)
>> [  113.437558]  skb_push+0x58/0x60
>> [  113.437949]  eth_header+0x3c/0xe0
>> [  113.438344]  vlan_dev_hard_header+0xa0/0x1d0 [8021q]
>> [  113.438913]  ipvlan_hard_header+0x34/0x58 [ipvlan]
>> [  113.439491]  neigh_resolve_output.part.0+0xa8/0x168
>> [  113.440027]  neigh_resolve_output+0x4c/0x90
>> [  113.440505]  ip6_finish_output2+0x2c0/0x858
>> [  113.440976]  ip6_finish_output+0x23c/0x398
>> [  113.441442]  ip6_output+0x90/0x250
>> [  113.441835]  NF_HOOK.constprop.0+0x54/0x118
>> [  113.442305]  mld_sendpack+0x1cc/0x3d0
>> [  113.442726]  mld_send_cr+0x1cc/0x318
>> [  113.443157]  mld_ifc_work+0x38/0x128
>>
>> Reproducer
>> ==========
>> ip link add veth0 type veth peer name veth1
>> ip link set veth0 up
>> ip link set veth1 up
>>
>> ip link add link veth0 name vlan_test type vlan id 10 reorder_hdr off
>> ip link set vlan_test up
>>
>> ip link add link vlan_test name ipvlan_test type ipvlan mode l2
>> ip link set ipvlan_test up
>>
>> ethtool -K veth0 tx-vlan-hw-insert off
>>
>> ip -6 addr add fe80::1/64 dev ipvlan_test
> 
> I am not surprised, ipvlan has been copy/pasted from macvlan :)
> 
> diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan_main.c
> index ed46439a9f4eb1dd8bfaf6c83476ba4f2aff31bc..7513c005a5121676d3f8edb0898492ad434a9fab
> 100644
> --- a/drivers/net/ipvlan/ipvlan_main.c
> +++ b/drivers/net/ipvlan/ipvlan_main.c
> @@ -146,6 +146,7 @@ static int ipvlan_init(struct net_device *dev)
>         dev->lltx = true;
>         netif_inherit_tso_max(dev, phy_dev);
>         dev->hard_header_len = phy_dev->hard_header_len;
> +       dev->needed_headroom = phy_dev->needed_headroom;
> 
>         netdev_lockdep_set_classes(dev);
> 
> @@ -773,6 +774,7 @@ static int ipvlan_device_event(struct
> notifier_block *unused,
>         case NETDEV_FEAT_CHANGE:
>                 list_for_each_entry(ipvlan, &port->ipvlans, pnode) {
>                         netif_inherit_tso_max(ipvlan->dev, dev);
> +                       ipvlan->dev->needed_headroom = dev->needed_headroom;
>                         netdev_update_features(ipvlan->dev);
>                 }
>                 break;
Hi Eric,

It works fine.
Thanks for the quick fix!
-- 
Best regards,
Tangxin Xie

