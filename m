Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C31BA2D2381
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 12:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783945626; cv=none; b=OuGXCGfGLzovypZby89co0Ue8qUD/O4oP7TXI6VkAoEBVTygv55aqUC7vjoUejCbIp9BX/B27s/dJoPCWHrFxcQ0lDxabYK7qFFar6VYEcpu27QwQN2DOIjesz/vOxGXgExBN6F1+zOT12GFiAEbTWnb5AvI/CiWk3xGLAhQ1Kc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783945626; c=relaxed/simple;
	bh=aAQ9TGF3vnuDznL6xhsgPJvoddDRdSCCX/EXbMDjw50=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jVin72furAf4qUCiFSFYihBWCt3ataIFuGJexdzD8vmrEnUUDVAcl74x//CM8uy+nbCgNTYHX7gGYJDjVau50MTss4TP7QTRqr1IOYs47qm+YtSlB+cPBE0N5/Y1pf/xIF6INB3+VlJXuJeq/w2MJCn5Z/snyqug275mreVgSMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 22f54d367eb611f1aa26b74ffac11d73-20260713
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12,REQID:d46f3a1f-eea8-4828-8e0b-4cf31634a630,IP:10,
	URL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:10
X-CID-INFO: VERSION:1.3.12,REQID:d46f3a1f-eea8-4828-8e0b-4cf31634a630,IP:10,UR
	L:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:r
	elease,TS:10
X-CID-META: VersionHash:e7bac3a,CLOUDID:a5d25b4174b065d7e0afea624a40bd84,BulkI
	D:2606291530521UT10222,BulkQuantity:3,Recheck:0,SF:10|38|64|66|78|80|81|82
	|83|102|127|841|865|898|1209,TC:nil,Content:0|15|52,EDM:-3,IP:-2,URL:99|1,
	File:nil,RT:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO
	,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 22f54d367eb611f1aa26b74ffac11d73-20260713
X-User: zhaochenguang@kylinos.cn
Received: from [192.168.111.102] [(223.70.159.239)] by mailgw.kylinos.cn
	(envelope-from <zhaochenguang@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_128_GCM_SHA256 128/128)
	with ESMTP id 2019260973; Mon, 13 Jul 2026 20:26:56 +0800
Message-ID: <d4dab051-0426-4920-895b-ac231e9a508c@kylinos.cn>
Date: Mon, 13 Jul 2026 20:27:08 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] ipv6: honor per-interface proxy_ndp in
 forward and NA paths
To: Jakub Kicinski <kuba@kernel.org>,
 Chenguang Zhao <chenguang.zhao@linux.dev>
Cc: Nicolas Dichtel <nicolas.dichtel@6wind.com>, dsahern@kernel.org,
 idosch@nvidia.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org,
 chenguang.zhao@linux.dev
References: <20260623085600.396401-1-zhaochenguang@kylinos.cn>
 <20260629061831.1211922-1-chenguang.zhao@linux.dev>
 <dd26c96a-8c9b-4dc3-8eb8-a1c6a8842aab@6wind.com>
 <20260629154649.1a7b7f2a@kernel.org>
Content-Language: en-US
From: Chenguang Zhao <zhaochenguang@kylinos.cn>
In-Reply-To: <20260629154649.1a7b7f2a@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Thanks for the question.

Yes, I do find this useful; it is not only about cleaning up an
inconsistency found by tooling.

The common deployment for proxy NDP is to enable it only on the
upstream/WAN interface, not globally, for example:

  # host with eth0 (WAN) and eth1 (LAN / containers / VPN)
  sysctl -w net.ipv6.conf.eth0.proxy_ndp=1
  ip -6 neigh add proxy 2001:db8::10 dev eth0

This is what Documentation and most guides describe (ndppd, Docker
IPv6, VPN/VPS setups that need to answer NS for addresses that live
behind another interface). Operators usually avoid
net.ipv6.conf.all.proxy_ndp=1 so proxying is not enabled on every
interface.

With that setup today:

  - ndisc_recv_ns() already honors idev->cnf.proxy_ndp, so NS replies
    work as expected;
  - ip6_forward() / ndisc_recv_na() only look at
    net->ipv6.devconf_all->proxy_ndp, so the forward/local-delivery
    and NA handling for proxied addresses still require the global
    knob.

So per-interface proxy_ndp is only half-effective unless
all.proxy_ndp is also set. The XXX comments look like that gap was
known when proxy_ndp was introduced; idev is available on these paths
now, so I want the remaining paths to match the NS path and the
documented per-interface usage.

I did use code review assistance while looking at IPv6 NDP, but the
motivation for sending the patch is the incomplete per-interface
behavior above, not just "make the checks look the same".

Applying this patch only adds per-interface control for IPv6 proxy NDP

to enable finer-grained configuration, and it should have negligible

impact on existing systems with the global IPv6 proxy NDP enabled.

Chenguang

Thanks

在 2026/6/30 06:46, Jakub Kicinski 写道:
> On Mon, 29 Jun 2026 15:59:00 +0200 Nicolas Dichtel wrote:
>> Le 29/06/2026 à 08:18, Chenguang Zhao a écrit :
>>> ndisc_recv_ns() has always checked both devconf_all and idev->cnf for
>>> proxy_ndp, but ip6_forward() and ndisc_recv_na() only looked at the
>>> global setting. The original commit left XXX comments in these paths
>>> likely because idev was not available there at the time; ip6_forward()
>>> now obtains idev from IP6CB(skb)->iif.
>>>
>>> Honor per-interface proxy_ndp in both places to match the NS path and
>>> allow setups that only enable proxy_ndp on specific interfaces.
>>>
>>> In ip6_forward(), idev is looked up via the ingress interface (iif) while
>>> pneigh_lookup() uses skb->dev. For ND packets this is correct because
>>> vrf_ip6_rcv() does not modify skb->dev for neighbour discovery frames,
>>> so both refer to the ingress interface.
>>>
>>> Signed-off-by: Chenguang Zhao <zhaochenguang@kylinos.cn>
>>> ---
>>> v2:
>>>  Per Ido's review, the following changes were made in v2:
>>>  - Target net-next instead of net
>>>  - Drop Fixes tag
>>>  - Expand commit message: XXX comment history, idev vs skb->dev for ND packets
>>>  - Fix subject prefix
>>>
>>> v1:
>>>  - https://lore.kernel.org/all/20260623085600.396401-1-zhaochenguang@kylinos.cn/
>>>
>>>  net/ipv6/ip6_output.c | 4 ++--
>>>  net/ipv6/ndisc.c      | 4 ++--
>>>  2 files changed, 4 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
>>> index 368e4fa3b43c..c4ca4a813479 100644
>>> --- a/net/ipv6/ip6_output.c
>>> +++ b/net/ipv6/ip6_output.c
>>> @@ -579,8 +579,8 @@ int ip6_forward(struct sk_buff *skb)
>>>  		return -ETIMEDOUT;
>>>  	}
>>>  
>>> -	/* XXX: idev->cnf.proxy_ndp? */
>>> -	if (READ_ONCE(net->ipv6.devconf_all->proxy_ndp) &&
>>> +	if ((READ_ONCE(net->ipv6.devconf_all->proxy_ndp) ||
>>> +	     (idev && READ_ONCE(idev->cnf.proxy_ndp))) &&  
>> As stated by Ido, this changes a 20 years old user-visible behavior. It suddenly
>> may enable proxy NDP on a system.
>> I was thinking that this kind of change was prohibited.
> Chenguang Zhao, is this a change you find useful or are you just
> acting on an AI-generated port about inconsistency in behavior?
> Could you please explain your use case / deployment scenario?
