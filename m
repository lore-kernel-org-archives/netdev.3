Received: from mail-wm2-f6.google.com (mail-wm2-f6.google.com [74.125.225.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 011F63AFAE4
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 21:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789506827; cv=none; b=ME9kmmsC+LPkn4KqK1VsONrVMORnfNLuMFgXuC3fH+oQhcVt1dS4gyKZyJV/bgJbT529dE3B89be2iOHIRf7v1WcT7Vj0YG/hc9k+jDGlhGvivt8DYyqTDSdCOBfQKEVr1qn6XRatDu6jW8u1Ho8KEiqKMtlnGH6TBDRD2KSif0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789506827; c=relaxed/simple;
	bh=fHmjTzy57JCxJPO3ez8hokC6PJGYWuA4v3xxL2WEZAY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LiL24QcmmfPv5PGHWBBCPrSWHyR26nAlunAOaEH6n8OG8qqPxZZaIKLZbS8Qfq/UotTMjEekjRJb3Nlr5GThu2oaNT8qdkHTcO5Qwy4+aGdZlQvPhRm+v/2EHJaCbZ8KsEVPUagVvTtajsiLoa7Idgee/fwzzOjcQP2qZn1Q2RA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=74.125.225.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ovn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm2-f6.google.com with SMTP id 5b1f17b1804b1-499c930cb9cso15051185e9.0
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 14:13:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789506824; x=1790111624;
        h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=J1EWEdVsCBQk76T0fxpMg82Yd0Qx0k9r3IEM8Nyqb00=;
        b=PDgg9zY7GFgO95mKGhHDo1+XcHo7/DNEdveVYKSjDuhF4T1K6UxysEbnbEFDf6PiHh
         rk7TZt3KFsu+Jj9uMCO6k+EJJPv5JnY71ZJZJEBqFHBCwajyjKEI9DhWZXkUs/5laVS7
         DRgsaQDDXs+yMt7gkJfDMdqsTCUoj0l19vNTwTcUiE6oIjUIAf+5Cbr2w4MsEIC/soZi
         NJ6W6n4S817/jftja036u1DGgobHGK2yVhNJqjIuFwG+DsUt0Y4Ugi8NXDpKsCb8Os3i
         v+hctkF8rpztiFKyMtPlNAnRXG5AK9+At0vdf1b3h5uInDWa5JC2wFIXe8dL7hIQ6HF/
         br2g==
X-Forwarded-Encrypted: i=1; AKwUvBz+YqgzvBeRWOZrmtQQ0Guzk6RBhnt+jmbVPo1lXZI5CgDI7qs3jGqBSMbTL5050soPe2hw1O8=@vger.kernel.org
X-Gm-Message-State: AFuF++n77KWihXq4aZQpJplYrmKvA9jk1z+Vbf3oH4cxkT1Cw4CxpQAG
	KNgMWBs4aKUxXKGGuEkldXAFNuMCo7fXNCr8YnHUnAwmYZvHchPZpKzR
X-Gm-Gg: AYBFou1ywrjGLahNs7y0wmEH0vaJaC6AkSVD7rFQTPjj9aGYa/5exIMTOInue9qU614
	ckjWXASO3qPozBxpvyBculzxTmtXzqYSgFDLuq5aYQRDtHCv7v/35OuTpcfQk74Bw4a2BTcApCH
	jA79KKOXv6Gs2nFvTtB5cUHP//N8wubE090xiE0scMn+chEccNuzg2DpkNd/zLNNkgykNfbON2J
	RLOL8YAYwCTFDorRci9kWZtMQzLIt1le9krnSEAi74WApDMAUWftQboJx60kZs/Jv8Ahf0YN4jx
	Ni6L0jAiLxtNy74ivAkjsoLJKZIhhUCbrBz6lsDNUD8OoJNWymASSfxgaAcgbtQYLDgLdTqxIP3
	1nTJhdELOvrtdua0uKBSQSH9J7QW/O9RHQb44vR9yiA0Q7XNDm0+ITIbprXqin7CSPqxyw3vxt8
	Z6f81UtX2fSU7SkGYkIEkZsDO25Nv/BgeSUh0H4ukllpXUS21nZBaL6Yaz1lznjmdp1EXEKAB88
	rkhGIefsVPKZmZ2srAn9eQtOzMDlReIbbhT
X-Received: by 2002:a05:600c:4745:b0:49e:799e:c1c3 with SMTP id 5b1f17b1804b1-49e7a6868a8mr101385745e9.17.1789506824025;
        Tue, 15 Sep 2026 14:13:44 -0700 (PDT)
Received: from [192.168.88.241] (37-48-53-4.nat.epc.tmcz.cz. [37.48.53.4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4870bf414c3sm1321506f8f.30.2026.09.15.14.13.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 14:13:43 -0700 (PDT)
Message-ID: <de0fd2e5-8509-406c-9f92-cb644c42229d@ovn.org>
Date: Tue, 15 Sep 2026 23:13:41 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] openvswitch: reject a negative transport length in
 the IPv6 L4 checksum update
To: Norbert Szetei <norbert@doyensec.com>, netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>, Eelco Chaudron <echaudro@redhat.com>,
 Ilya Maximets <i.maximets@ovn.org>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 dev@openvswitch.org, linux-kernel@vger.kernel.org,
 David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>
References: <114FAFBD-F7BC-46AE-AF9F-0D15124F130E@doyensec.com>
Content-Language: en-US
From: Ilya Maximets <i.maximets@ovn.org>
Autocrypt: addr=i.maximets@ovn.org; keydata=
 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
In-Reply-To: <114FAFBD-F7BC-46AE-AF9F-0D15124F130E@doyensec.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 9/15/26 9:55 PM, Norbert Szetei wrote:
> update_ipv6_checksum() computes
> 
> 	int transport_len = skb->len - skb_transport_offset(skb);
> 
> and gates the L4 access on
> 
> 	if (likely(transport_len >= sizeof(struct tcphdr)))
> 
> sizeof yields size_t, so transport_len is converted to unsigned and every
> negative value passes the guard.  inet_proto_csum_replace16() then reads
> the transport checksum field out of bounds, and writes the updated value
> back to the same address:
> 
>   BUG: KASAN: slab-use-after-free in inet_proto_csum_replace16+0x445/0x470
>   Read of size 2 at addr ffff888131a4cb06 by task ovs_ipv6_oob/696
>   CPU: 3 UID: 1000 PID: 696 Comm: ovs_ipv6_oob Tainted: G N 7.3.0-rc2+ #338
>   Call Trace:
>    inet_proto_csum_replace16+0x445/0x470
>    set_ipv6_addr+0x3dd/0x460
>    do_execute_actions+0x6a3d/0x7c40
>    ovs_execute_actions+0xfd/0x480
>    ovs_packet_cmd_execute+0xc38/0xf20
>    genl_rcv_msg+0x59e/0x870
>    netlink_rcv_skb+0x18b/0x450
>    genl_rcv+0x2d/0x40
>    netlink_unicast+0x6bc/0xa20
> 
>   The buggy address belongs to the object at ffff888131a4c980
>    which belongs to the cache skbuff_small_head of size 704
>   The buggy address is located 390 bytes inside of
>    freed 704-byte region [ffff888131a4c980, ffff888131a4cc40)
> 
> ipv6_find_hdr() walks the extension header chain, skipping each header
> by the length that header itself declares, and ipv6_optlen() returns up
> to 2048.  The last skip is never checked against skb->len, and
> parse_ipv6hdr() installs the result as the transport header.

Hi, Norbert.

This looks like something that needs to be fixed in the ipv6_find_hdr().
IMO, this function should not return an offset that doesn't exist in the
packet, i.e. we should not be able to find what's not in there.

CC: David and Ido.

In general, we should be able to trust the skb_transport_offset(),
otherwise there could be other issues all over the place, not only in
openvswitch.

Best regards, Ilya Maximets.

> 
> Reject a negative length.
> 
> Fixes: ccb1352e76cf ("net: Add Open vSwitch kernel components.")
> Cc: stable@vger.kernel.org
> Assisted-by: LLM
> Signed-off-by: Norbert Szetei <norbert@doyensec.com>
> ---
> Reproducer available on request.
> 
>  net/openvswitch/actions.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
> index dc5ff859f114..4fdc08cca058 100644
> --- a/net/openvswitch/actions.c
> +++ b/net/openvswitch/actions.c
> @@ -360,6 +360,9 @@ static void update_ipv6_checksum(struct sk_buff *skb, u8 l4_proto,
>  {
>  	int transport_len = skb->len - skb_transport_offset(skb);
>  
> +	if (unlikely(transport_len < 0))
> +		return;
> +
>  	if (l4_proto == NEXTHDR_TCP) {
>  		if (likely(transport_len >= sizeof(struct tcphdr)))
>  			inet_proto_csum_replace16(&tcp_hdr(skb)->check, skb,

