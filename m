Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A994950B8CC
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 14:09:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792418952; cv=none; b=OspGRDnHIsQBKYFU4yxcuS7dPAdVvdlt0viEE75YgbTG/Wl9CRZtXsNCtqLspEVrxysmMAyZzc2XoWdYBHIsvGujd/sb+f8wEC1gvsgxfTESaZToafVFT7bO6AlJkj/dNIF+24ib9SY5KgAViShvPI+Hq/bnDPGAY27hxNPcSr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792418952; c=relaxed/simple;
	bh=Bb1oQJJb8bBWJ50lmw1B7ERzmHGFObf98zGv2XjADM4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hgzxUHWI1huTpxDyCoPfgVYhcf59pmw4KcmaffWxUsFndfKS579T0pP957aSdeJH8uIbdltZa9AzC8bXfS2pr1wisyUVDChx5TZzFaJrMclYofRefB8unfw9IuIsCeiQpVuedkCL1iammRK/0xFrA/B313uvC6tuv92rU6A+Nd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GHNV5Iot; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=U880YE9c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GHNV5Iot";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="U880YE9c"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792418949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZRK1BzG8yA6E0e6lr2UnuvkDmeyhqnlz73tj/pxCJpU=;
	b=GHNV5IotV6lRYajcLNGOZzHF2rsu+QcGVpusAG458LO2dTYMcHFIQbXmksc7M87J7oLm57
	KfGfkUXoYM20yxYV3tBc/qyoLJeaJq7i1LYnHfbYs8vC2/Prz28hutgwR/B3EPRuA7t8Ym
	GJgxl0m8mkxOuNDv/6cXLcv8TL0JqYw=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-595-in-3KJMlMoOQEKJBe3mr7w-1; Mon, 19 Oct 2026 14:09:02 +0000
X-MC-Unique: in-3KJMlMoOQEKJBe3mr7w-1
X-Mimecast-MFC-AGG-ID: in-3KJMlMoOQEKJBe3mr7w_1792418941
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a0284121c6so16644675e9.3
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1792418941; x=1793023741; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZRK1BzG8yA6E0e6lr2UnuvkDmeyhqnlz73tj/pxCJpU=;
        b=U880YE9cNEgLsv1io2MgYfbdDp01nkckTeHKw7tYZ+fQOGodlAnJFYEY4xu82k2+BT
         mqEn5wyvMnS2jK77hMsZFKy7dI0jQbj7hJECK3rSV3oI5srXkxBUOENAPSmh60bF2J5X
         2/JuHoJk8pKH0HLWRAc5cSBmT8O0TQZK0OzqA5yxHrJMOB7VqZYQysXiLm6Ivplr3Iae
         0b7UUfKwadTwyErOaSvP2u3+eddIEg63Jv3Xql3+gsceK/iux0Hpntey1DXqhn70rTeD
         DACKcMyG/YuBI5UeFIskD/nTVzqiE3M06hUIsnEjm4YX5lnyrVpVZAtrJn5GDcDwrl4F
         kqdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792418941; x=1793023741;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZRK1BzG8yA6E0e6lr2UnuvkDmeyhqnlz73tj/pxCJpU=;
        b=qggYGBwmaQlX/o5egzkZL2Y00KfHq/UBCLckqX0Rcc/OifZvZHy+d0ZBU7j9a3vs7/
         PoSlbDo1Ma/wybkocpp8HRhEfgXd14uLZcQq/wLRdv5XVBavddM14cQtEjVp8R3zN3Ag
         PdssxFShK+Lk5v5oM3jucqmSMAhFnVfZfe4Tgzk9JAlk8QEcBjUsK9PrrphwNnbuURAL
         iFa6CNhZhyZF4fr3J0yQXcnkqSI+cOmmISl9/BAbhMGGKTtuEOTVfGe7ZR1GsxDrJTy9
         qmcs7y6YHqIv4keGwJo5gOSLLlHAbLlO3FEZFhUZl8Bd+bDh8VbdGdeyTIOWEoxIy94M
         DdSA==
X-Forwarded-Encrypted: i=1; AKwUvBwMcwm7IGaF9HkiCYcpLQRAezib3X7k/wQvOMKOhHAEGB5Qq5x+W3Y7Y1ko2y5xAs95kwJTX8Q=@vger.kernel.org
X-Gm-Message-State: AFq9FYJaWLhhhKEGCZ3U6jgVjtGdZ2iB3W9ilw9YtHmyFwiK40pXjenJ
	SP6vmDFnutvHXAdmrVEfFvDtLLTI581i7WgYQvqZwTH6sP0SZoAG2iQ1o/ieXwN6FaIQ2aDa+XR
	CzTCSN38UpP83LuHS3u1HtEU2BIC8krTdzuaSi3qnyXaRI2TDrB2clzMzog==
X-Gm-Gg: AYBFou2MXWaEP1l9JnjkqAv+14qJ8SrZfKZuVxe5zYAJrA2PpVHfBybe5Ad9xOHXFCT
	5Z+ZOZLwNPkZwq+Asuw5BHwn1sf7qeiL4TXD0jNgfNQ3M8ZwUleVhZ6qLMowgf8jpfgmePTfpUA
	xK4qGy2ulrpf7wrQl74TxKzZAluCJ9eeg5EbnbbjrCH5ifnL2/+q18PbzuLZt290fMfAZhl9DrQ
	HFn+eGZwlqk4WVLHf5A4mw5UZ/vuSOKWj/Jc77VHET0uLAWFlE0Of0koNAs37nij1M+oOboN/X6
	E/eKJruq4QioUYpD69Xkb4OsrTWkpIBcq4+f8J9CC+huW2DGWmc2b/yV+VzdU7QQC5i4sqCCsgt
	HJg/3C5ve7LrNq8XCZD/qYPLc3cUeX6AFE1/uu9d6f3NKHPrlIVfcYtuwFupPhdsugSxOPIHH1g
	==
X-Received: by 2002:a05:600c:314f:b0:4a1:e6c5:e44c with SMTP id 5b1f17b1804b1-4a1e6c5e47amr69109505e9.10.1792418940816;
        Mon, 19 Oct 2026 07:09:00 -0700 (PDT)
X-Received: by 2002:a05:600c:314f:b0:4a1:e6c5:e44c with SMTP id 5b1f17b1804b1-4a1e6c5e47amr69108755e9.10.1792418940267;
        Mon, 19 Oct 2026 07:09:00 -0700 (PDT)
Received: from [192.168.188.234] (ip232-47-231-195.pool-bba.aruba.it. [195.231.47.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1df164777sm193091345e9.5.2026.10.19.07.08.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Oct 2026 07:08:59 -0700 (PDT)
Message-ID: <8696d555-0428-49f3-ab03-e052a7d51213@redhat.com>
Date: Mon, 19 Oct 2026 16:08:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] ip_tunnel: reserve headroom for the encap header
 before pushing it
To: Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>,
 Ido Schimmel <idosch@nvidia.com>, Christian Ehrig <cehrig@cloudflare.com>,
 Alexei Starovoitov <ast@kernel.org>, Tom Herbert <tom@herbertland.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261010223601.1193655-1-theodorlarionov@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20261010223601.1193655-1-theodorlarionov@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 10/11/26 00:36, Theodor Arsenij Larionov Trichkine wrote:
> ip_tunnel_xmit() and ip_md_tunnel_xmit() push the FOU/GUE header in
> ip_tunnel_encap() before skb_cow_head() reserves headroom and unshares
> the header. A packet redirected into the tunnel by tc mirred or an nft
> netdev fwd only has the headroom of the device it came from, and
> fou_build_udp() hits skb_under_panic(). With a mirred mirror, the push
> overwrites the Ethernet header of the original packet instead.
> 
> Reproducer, run in an unprivileged user and network namespace:
> 
>    ip link add dummy0 type dummy
>    ip addr add 10.2.2.1/24 dev dummy0
>    ip link set dummy0 up
>    ip link add ipip0 type ipip local 10.1.1.1 remote 10.1.1.2 \
>            encap gue encap-sport auto encap-dport 5555 encap-remcsum
>    ip link set ipip0 up
>    tc qdisc add dev dummy0 clsact
>    tc filter add dev dummy0 egress matchall \
>            action mirred egress redirect dev ipip0
>    # send a UDP packet to 10.2.2.2
> 
> skbuff: skb_under_panic: text:ffffffffad28b5cf len:49 put:8 head:ffff888010217740 data:ffff88801021773c tail:0x2d end:0x180 dev:ipip0
> kernel BUG at net/core/skbuff.c:214!
> Call Trace:
>   <TASK>
>   skb_push+0xcc/0xf0
>   fou_build_udp+0x2f/0x380
>   gue_build_header+0xfa/0x150
>   ip_tunnel_xmit+0x87f/0x21c0
>   ipip_tunnel_xmit+0x472/0x4f0
>   dev_hard_start_xmit+0x139/0x680
>   __dev_queue_xmit+0x11e4/0x3520
>   sch_frag_xmit_hook+0x10a/0x190
>   tcf_dev_queue_xmit+0x44/0x60
>   tcf_mirred_to_dev+0xbf8/0x1060
>   tcf_mirred_act+0x612/0x11b0
>   tcf_action_exec+0x1d9/0x8b0
>   mall_classify+0x16d/0x1e0
>   __tcf_classify.constprop.0+0x121/0x710
>   tcf_classify+0x8d/0xc0
>   tc_run+0x342/0x590
>   __dev_queue_xmit+0x9a7/0x3520
>   neigh_resolve_output+0x44c/0x780
>   ip_finish_output2+0x6e8/0x16f0
>   __ip_finish_output.part.0+0x1bb/0x350
>   ip_output+0x2ad/0x4a0
>   ip_send_skb+0x195/0x1f0
>   udp_send_skb+0x758/0xcc0
>   udp_sendmsg+0x1634/0x2050
>   </TASK>
> 
> Call skb_cow_head() for the encap length at the start of both
> functions. ip_tunnel_xmit() reads tunnel->encap once, so a concurrent
> changelink cannot change the length between the reservation and the
> push. The GRE callers and ip6_tunnel already reserve this headroom.
> 
> Fixes: 56328486539d ("net: Changes to ip_tunnel to support foo-over-udp encapsulation")
> Fixes: ac931d4cdec3 ("ipip,ip_tunnel,sit: Add FOU support for externally controlled ipip devices")
> Signed-off-by: Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>
> ---
> Found with a syzkaller-based fuzzer.
> 
> syzbot has an older report with the same title, fixed by c88f8d5cd95f
> ("sit: update dev->needed_headroom in ipip6_tunnel_bind_dev()"). This
> is a different path: redirected packets do not get needed_headroom.
> 
> Tested on net af32da41b032: the reproducer above and an nft netdev
> egress fwd variant no longer crash, and a GUE ipip tunnel between two
> namespaces still passes traffic.
> 
>   net/ipv4/ip_tunnel.c | 23 +++++++++++++++++++++--
>   1 file changed, 21 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/ip_tunnel.c b/net/ipv4/ip_tunnel.c
> index e6bcf01411d0..38ab3c3bf5c9 100644
> --- a/net/ipv4/ip_tunnel.c
> +++ b/net/ipv4/ip_tunnel.c
> @@ -579,6 +579,7 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
>   	struct rtable *rt = NULL;
>   	struct flowi4 fl4;
>   	__be16 df = 0;
> +	int encap_hlen;
>   	u8 tos, ttl;
>   	bool use_cache;
>   
> @@ -587,6 +588,11 @@ void ip_md_tunnel_xmit(struct sk_buff *skb, struct net_device *dev,
>   		     ip_tunnel_info_af(tun_info) != AF_INET))
>   		goto tx_error;
>   	key = &tun_info->key;
> +	encap_hlen = ip_encap_hlen(&tun_info->encap);
> +	if (encap_hlen < 0)
> +		goto tx_error;
> +	if (skb_cow_head(skb, encap_hlen))
> +		goto tx_dropped;

This looks like the wrong solution?!? I suggest instead adding the needed
skb_cow_head() in {fou,gue}_build_header().

/P

