Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB4D3C0A1F;
	Fri, 17 Jul 2026 06:42:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784270567; cv=none; b=YZ9cX5o6Ropw0ybc8rzj1NM+E2tnjCYVEZbXe/MFAuul6+E0yo+MA8bSVYrSNgOvXhg51iYGyxgqBDuOUHFT4BxEFvujpRWddBKtxIKV50I/Eup9AzYkN4QXqBgY5cODZqpL0g5y4laGELzWWlqnzcBTjm05RZiUgsGUZabdYTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784270567; c=relaxed/simple;
	bh=CFRpqR2Y/dbwD2cRB9vc9G0i4ipGwq63+fMNdspnsyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YshAhpQUTjExn9QOMIGlGnBbOjKA+nKkOK+HQbySpRi0x36pNAt3WyiwFGxA4m0+Y1jTzvH+/zKlCkcL0/1tNyxxKqWkH3rebd2cem0K6vcePjJdEch2t7sdTgkB/OcVm1e2MtSDvrxyuESi8K5CzV9J4FoCOAmis0tCd4ujucw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com; spf=pass smtp.mailfrom=h-partners.com; dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b=SgFZu27o; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=h-partners.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=h-partners.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=h-partners.com header.i=@h-partners.com header.b="SgFZu27o"
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Qz53QuRGTC/OOUgyUrobL4bIkQT5P+B5SvyQZ1n0hso=;
	b=SgFZu27oYwv3rnhH0jZO0MSgaGgjZaIEC/xWH1YKkTaGyHxq6898sQ0F3ugm0NhBOHxwuHqDe
	sVhXeBjMI3b1Kx8zENkQuN7hjhNrc4sl8JhC6BBzrcjj2LwUbDyYvb9GIBV2FxNfjrYcvWggnQW
	hftvy2VAPJxk8mpNdUJdCto=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4h1g8h3kZpzpStj;
	Fri, 17 Jul 2026 14:33:24 +0800 (CST)
Received: from kwepemr100001.china.huawei.com (unknown [7.202.195.168])
	by mail.maildlp.com (Postfix) with ESMTPS id 6E1054058F;
	Fri, 17 Jul 2026 14:42:20 +0800 (CST)
Received: from [10.136.112.147] (10.136.112.147) by
 kwepemr100001.china.huawei.com (7.202.195.168) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Fri, 17 Jul 2026 14:42:19 +0800
Message-ID: <d6be3b25-3db3-491c-93d8-7e014427f380@h-partners.com>
Date: Fri, 17 Jul 2026 14:42:19 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [BUG] vlan: skb_under_panic when toggling NETIF_F_HW_VLAN_CTAG_TX
 on lower device
To: Eric Dumazet <edumazet@google.com>
CC: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	John Fastabend <john.r.fastabend@intel.com>, Jesse Gross <jesse@nicira.com>,
	<gaoxingwang1@huawei.com>, huyizhen <huyizhen2@huawei.com>
References: <99d678ae-c7b2-4b44-b534-b8320679deb3@h-partners.com>
 <CANn89i+z6ECLND1o8oD10re_zGJg73JCOr3dnV9AADeG40K=_Q@mail.gmail.com>
 <CANn89iKOb0003aqdxJw65F0_xaLOkM-45MZv+CUmQ13-NGoGOA@mail.gmail.com>
Content-Language: en-US
From: xietangxin <xietangxin@h-partners.com>
In-Reply-To: <CANn89iKOb0003aqdxJw65F0_xaLOkM-45MZv+CUmQ13-NGoGOA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 kwepemr100001.china.huawei.com (7.202.195.168)



On 7/16/2026 9:06 PM, Eric Dumazet wrote:
> On Thu, Jul 16, 2026 at 2:53 PM Eric Dumazet <edumazet@google.com> wrote:
>>
>> On Thu, Jul 16, 2026 at 2:20 PM xietangxin <xietangxin@h-partners.com> wrote:
>>>
>>> [BUG] vlan: skb_under_panic when toggling NETIF_F_HW_VLAN_CTAG_TX on lower device
>>>
>>> Hi all,
>>>
>>> We encountered a skb_under_panic triggered by toggling
>>> NETIF_F_HW_VLAN_CTAG_TX on the lower device while a VLAN device is
>>> up and sending traffic.
>>>
>>> Call trace
>>> ==========
>>>
>>>  skbuff: skb_under_panic: text:ffffc0d2900283d8 len:74 put:14
>>>   head:ffff334820249c00 data:ffff334820249bfe tail:0x48 end:0xc0 dev:vlan4
>>>  ------------[ cut here ]------------
>>>  kernel BUG at net/core/skbuff.c:116!
>>>  Internal error: Oops - BUG: 00000000f2000800 [#1] SMP
>>>  Call trace:
>>>   skb_panic+0xcc/0xd0
>>>   __skb_checksum+0x0/0x480
>>>   eth_header+0x48/0x1a0
>>>   vlan_dev_hard_header+0xd0/0x284
>>>   neigh_connected_output+0x16c/0x20c
>>>   ip6_finish_output2+0x4b4/0xd74
>>>   __ip6_finish_output.part.0+0x1ac/0x3b0
>>>   ip6_finish_output+0x160/0x200
>>>   ip6_output+0x13c/0x294
>>>   ndisc_send_skb+0x41c/0x6f0
>>>   ndisc_send_rs+0xac/0x3b0
>>>   addrconf_rs_timer+0x42c/0x660
>>>   call_timer_fn+0x54/0x290
>>>   expire_timers+0x26c/0x420
>>>
>>> Reproducer
>>> ==========
>>>
>>>  # Create veth pair (NETIF_F_HW_VLAN_CTAG_TX is ON by default)
>>>  ip link add veth0 type veth peer name veth1
>>>  ip link set veth0 up
>>>  ip link set veth1 up
>>>
>>>  # Turn off HW VLAN TX offload on lower device
>>>  ethtool -K veth0 tx-vlan-hw-insert off
>>>
>>>  # Create VLAN device on veth0
>>>  # At this point: header_ops = &vlan_header_ops, hard_header_len = 18
>>>  ip link add link veth0 name veth0.10 type vlan id 10 reorder_hdr off
>>>  ip addr add 192.168.10.1/24 dev veth0.10
>>>  ip link set veth0.10 up
>>>
>>>  # Turn HW VLAN TX offload back ON on lower device
>>>  # This triggers NETDEV_FEAT_CHANGE -> vlan_transfer_features()
>>>  # hard_header_len changes from 18 to 14, but header_ops is NOT updated
>>>  ethtool -K veth0 tx-vlan-hw-insert on
>>>
>>>  # When a packet is sent through veth0.10
>>>  # - skb is allocated based on hard_header_len=14 -> ~16 bytes
>>>  # - vlan_dev_hard_header() pushes VLAN_HLEN(4) + ETH_HLEN(14) = 18 bytes
>>>  # - skb_under_panic!
>>>
>>>
>>> Any feedback or guidance would be greatly appreciated.
>>
>> This rings a bell, I thought we already fixed this issue long ago :/
>>
>> I would suggest we always add VLAN_HLEN even if not (yet) needed.
>>
>> diff --git a/net/8021q/vlan.c b/net/8021q/vlan.c
>> index 2b74ed56eb166d52c3351768d9dfedc7b2c8ec2d..d7f90b3b2bb3aadb2c466891720a7f407d0bc34b
>> 100644
>> --- a/net/8021q/vlan.c
>> +++ b/net/8021q/vlan.c
>> @@ -323,10 +323,7 @@ static void vlan_transfer_features(struct net_device *dev,
>>
>>         netif_inherit_tso_max(vlandev, dev);
>>
>> -       if (vlan_hw_offload_capable(dev->features, vlan->vlan_proto))
>> -               vlandev->hard_header_len = dev->hard_header_len;
>> -       else
>> -               vlandev->hard_header_len = dev->hard_header_len + VLAN_HLEN;
>> +       vlandev->hard_header_len = dev->hard_header_len + VLAN_HLEN;
>>
>>  #if IS_ENABLED(CONFIG_FCOE)
>>         vlandev->fcoe_ddp_xid = dev->fcoe_ddp_xid;
>>
>> A kind-of-similar change is needed in net/8021q/vlan_dev.c
> 
> The second part would be a nice cleanup, unless I am missing something.
> 
> diff --git a/net/8021q/vlan_dev.c b/net/8021q/vlan_dev.c
> index 7aa3af8b10ead0384bbb2e767883b63a37be5fa2..dfd907e2ede2dcb0b6120e1fa5b6bb4d30bfb28a
> 100644
> --- a/net/8021q/vlan_dev.c
> +++ b/net/8021q/vlan_dev.c
> @@ -496,26 +496,6 @@ static const struct header_ops vlan_header_ops = {
>         .parse_protocol = vlan_parse_protocol,
>  };
> 
> -static int vlan_passthru_hard_header(struct sk_buff *skb, struct
> net_device *dev,
> -                                    unsigned short type,
> -                                    const void *daddr, const void *saddr,
> -                                    unsigned int len)
> -{
> -       struct vlan_dev_priv *vlan = vlan_dev_priv(dev);
> -       struct net_device *real_dev = vlan->real_dev;
> -
> -       if (saddr == NULL)
> -               saddr = dev->dev_addr;
> -
> -       return dev_hard_header(skb, real_dev, type, daddr, saddr, len);
> -}
> -
> -static const struct header_ops vlan_passthru_header_ops = {
> -       .create  = vlan_passthru_hard_header,
> -       .parse   = eth_header_parse,
> -       .parse_protocol = vlan_parse_protocol,
> -};
> -
>  static const struct device_type vlan_type = {
>         .name   = "vlan",
>  };
> @@ -575,13 +555,8 @@ static int vlan_dev_init(struct net_device *dev)
>  #endif
> 
>         dev->needed_headroom = real_dev->needed_headroom;
> -       if (vlan_hw_offload_capable(real_dev->features, vlan->vlan_proto)) {
> -               dev->header_ops      = &vlan_passthru_header_ops;
> -               dev->hard_header_len = real_dev->hard_header_len;
> -       } else {
> -               dev->header_ops      = &vlan_header_ops;
> -               dev->hard_header_len = real_dev->hard_header_len + VLAN_HLEN;
> -       }
> +       dev->header_ops      = &vlan_header_ops;
> +       dev->hard_header_len = real_dev->hard_header_len + VLAN_HLEN;
> 
>         dev->netdev_ops = &vlan_netdev_ops;
Hi Eric,

Thanks for the suggestion. I tested both parts of your patch locally
and can confirm the skb_under_panic no longer reproduces.

your diff is against an older tree. After commit
cd1c188db109 ("vlan: defer real device state propagation to netdev_work"),
vlan_transfer_features() has been moved to vlan_dev.c.

Could you post a formal patch?
-- 
Best regards,
Tangxin Xie

