Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3A637C93C
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 19:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787426503; cv=none; b=cW0tKh6pSoi+i2crVu8MtDc5KZVeeyffVpwtEMTvqAyU0LBAFlnnq/onAx4M9sfnfsbT5aujdIO26TgfYv1uNQunIxkdbFMEhL7Snedllvri/oH41SK4JmHpm6GcVQGh5qC6HhqkAgLOlWf3buNJL2rsaWrQWAGOsHLnpkADzM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787426503; c=relaxed/simple;
	bh=EQ/CiktIOdrT3DfT1y+Xu8OAQ7mbOHX71ojJtPNIRSA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=qo2oriABP7UG3SAE8qau87Bc35dlufB+rdxZffyw06DJ6hfL6IdG5lXD+DL3JK5yMQqfBEexinHGHP948W/w8YzVasgGs8BR9gHdXIcXU5rTXQqay/TGJ18X8V3jT6EwvSszQuumznTXkvCAb8THvY0GCEMtMz75Dk25+9WuWZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jFbw3UO2; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jFbw3UO2"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-7dbcb505578so26594007b3.3
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 12:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787426501; x=1788031301; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=J3xhjkaPiGXWVStIU8MUoTIjnF0+Oc+0nyvWG6A2JMo=;
        b=jFbw3UO2Ca7RgFX5bRxsOMsxsUmBZcSy31QJ+8/8uBhKtfZ6Nt4J4LKW/nvc+MsrEv
         gt3NI6EdrhMSo0rZIXkBJPI6nm2XXM0Dc3mQghriiqMCqgXcp7KwdfFcFEtR8j0p0hvF
         tISPgDv8dv+FgbGyMywNmXKxoAeN27MvUDWm/EklbktJOQz8db1ApNG/f3O/p/Ay98Th
         50atqOkwRl1gOLT/cKWRM6kk6p14nM3dwVZ7xQKpDN3q/8Gv1m4Q2VttdWUaid63/f4R
         l6/LlxlMhcjjTeUlaWwsPLccPOAP7LXRfb5x9WhxhwfCNUvb7+bDfoy5vjVgj9PqInVC
         Cwgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787426501; x=1788031301;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=J3xhjkaPiGXWVStIU8MUoTIjnF0+Oc+0nyvWG6A2JMo=;
        b=TMEEh9Xm9tGhwAMhbdl13EQ0D9txT5tUPyTWijEfmW7fzLhwZwp+809wTTg3HyrL+O
         7eDzU+49zXughZOYDEFXgYaWtdo1Jd4d/ZvHmNfszpZhqIwbt7fPBxcIsBxqJJr51yYM
         B481Tltwti5nVZWGsc/dXDZRXnAXwHAXtaStkIipRs8QFJXNccexo6TM+wny3pNMeW37
         8TkJRFelBe1AekWyOFYz7S5/OX0ATbPfHKbCmEeBE6xTOSlb64BS9EN+bnQdonlNluBc
         nLCInGc5umpOd/+7iuqUSWdcF9WIdNSjVOXjkLL6P7Iat/MqmCHDew3T9QYHo5KaI2R3
         f5Cw==
X-Forwarded-Encrypted: i=1; AHgh+Rpmj0Qw+cYSj7Lb8exXOM9evJ2ww4Ug8F5YAfsZ0dkH0fps+5YgVOM9SblfUd4pE29qizZXQhc=@vger.kernel.org
X-Gm-Message-State: AFuF++kVL967ZLn7OfxWWQ1/qHs5+MjBV8QQNm0b9qj4lazPhf3gbkch
	jJOalbjK6xoSf+feZB2GUTF6rLvhqYKkwpYfYv9591o9AewEoiX8W0dd
X-Gm-Gg: AR+sD12+VNMriRGksPua2UmTQQcWUBqHXUI7Ju82O4DGbKTdfR7uq2Wh93pXsMaaeh4
	UZ/LB7QKSNM5ChkrNGoP+mc5CrAO4wtBC2QHRlttVAL7V++hypFXg8GSkmCUmOakKUi7HWCyqvC
	es85gAOBfIXSDxpwz3DZvZKldLiYIHyNEbteli84UzfeLfCMBe1Yfqbu3MmxmBRfSiTALBHLeFF
	mGlXb/Xsw7nXz4W6xnWpFK8+RJjVAeX3VHQBjNTWD1CNUlLYVjU2fzbZaT5jBw0P9MXlmZkjvPP
	BJpgDBE2v5B7Q7/cHBtqlI0rZdyVOPq+xdqEm7WmR8EjXd3ZegplcBNUYmVP8yeuO1gGDytwFS6
	h4XzvdJ123DPV7ZCi99qyB1FJ8CnV3Y8AzsTuU0LfgS4Wp2krAJZ5bwM+eYb8apzmhRaVi+yOqu
	fMrFJd/YPvdrR5hkla3mII998kaMQ+gjYRALWKgTm+Sv8FidAbDVN+mTTpI5jt+wrhO2r1lU/DY
	kAtwm4LDgNdCL7eLDZMXknumAINXVMZCJnpxeJSMmw=
X-Received: by 2002:a05:690c:e287:20b0:81e:45a6:bd53 with SMTP id 00721157ae682-849f2a37ec1mr45088907b3.8.1787426501039;
        Sat, 22 Aug 2026 12:21:41 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-84cab851290sm13290407b3.35.2026.08.22.12.21.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 12:21:40 -0700 (PDT)
Date: Sat, 22 Aug 2026 15:21:39 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Junnan Zhang <zhangjn_dev@163.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "David S . Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, 
 "Michael S . Tsirkin" <mst@redhat.com>, 
 Hangbin Liu <liuhangbin@gmail.com>, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 zhangjn_dev@163.com, 
 Junnan Zhang <zhangjn11@chinatelecom.cn>, 
 Shouxin Sun <sunshx@chinatelecom.cn>
Message-ID: <willemdebruijn.kernel.2d3e4407199d8@gmail.com>
In-Reply-To: <20260821085722.24036-1-zhangjn_dev@163.com>
References: <20260821085722.24036-1-zhangjn_dev@163.com>
Subject: Re: [PATCH] net/packet: fix network header offset for non-VLAN raw
 packets on VLAN subinterfaces
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Junnan Zhang wrote:
> From: Junnan Zhang <zhangjn11@chinatelecom.cn>
> 
> AF_PACKET SOCK_RAW reserves dev->hard_header_len bytes of headroom. For
> VLAN subinterfaces, hard_header_len includes VLAN tag space (18 bytes)

Does it?

vlan_dev_init:

        dev->hard_header_len = real_dev->hard_header_len;

> while min_header_len is the real Ethernet header length (14 bytes). When

Which device did you observe this with?

> userspace sends a standard untagged Ethernet frame through a VLAN
> subinterface, packet_parse_headers() only corrects network_header for
> VLAN-tagged frames. For non-VLAN frames it leaves network_header at
> hard_header_len, so the IP header is found 4 bytes too late and
> inet_gso_segment() fails with -EINVAL.

Which path did you observe generating these untagged packets through
a VLAN interface?

> 
> Set network_header to min_header_len for non-VLAN SOCK_RAW frames on
> Ethernet devices whose hard_header_len exceeds min_header_len, so the
> L3/L4 header positions match the actual on-the-wire frame.
> 
> This fix is placed before skb_probe_transport_header() so that both the
> transport header probe (which uses skb_network_offset() as nhoff) and
> subsequent GSO see the right L3/L4 offsets. It complements
> commit 01fdecc0480d ("net: packet: fix wrong transport_header when sending VLAN-tagged frame")
> which only covers VLAN-tagged frames.
> 
> Fixes: dfed913e8b55 ("net/af_packet: add VLAN support for AF_PACKET SOCK_RAW GSO")
> Signed-off-by: Junnan Zhang <zhangjn11@chinatelecom.cn>
> Signed-off-by: Shouxin Sun <sunshx@chinatelecom.cn>
> Signed-off-by: Junnan Zhang <zhangjn_dev@163.com>
> ---
>  net/packet/af_packet.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> index 1168bd6b09cd..4669320f551b 100644
> --- a/net/packet/af_packet.c
> +++ b/net/packet/af_packet.c
> @@ -1935,6 +1935,7 @@ static int packet_rcv_spkt(struct sk_buff *skb, struct net_device *dev,
>  static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
>  {
>  	int depth;
> +	bool has_vlan;

nit: confusing variable, combining test on packet and device.
>  
>  	/* On TX skb->data is the L2 header; anchor it for all socket types. */
>  	skb_reset_mac_header(skb);
> @@ -1943,11 +1944,23 @@ static void packet_parse_headers(struct sk_buff *skb, struct socket *sock)
>  	    sock->type == SOCK_RAW)
>  		skb->protocol = dev_parse_header_protocol(skb);
>  
> +	has_vlan = likely(skb->dev->type == ARPHRD_ETHER) &&
> +		   eth_type_vlan(skb->protocol);
> +
> +	/* For non-VLAN raw frames on devices whose hard_header_len includes
> +	 * VLAN tag space (e.g. VLAN subinterfaces), the network header must be
> +	 * at the actual L2/L3 boundary, not hard_header_len, so that both the
> +	 * transport header probe below and subsequent GSO see the right L3.
> +	 */
> +	if (!has_vlan && sock->type == SOCK_RAW &&
> +	    likely(skb->dev->type == ARPHRD_ETHER) &&

nit: repeat test, also included in that has_vlan

> +	    skb->dev->min_header_len < skb->dev->hard_header_len)
> +		skb_set_network_header(skb, skb->dev->min_header_len);
> +
>  	skb_probe_transport_header(skb);
>  
>  	/* Move network header to the right position for VLAN tagged packets */
> -	if (likely(skb->dev->type == ARPHRD_ETHER) &&
> -	    eth_type_vlan(skb->protocol) &&
> +	if (has_vlan &&
>  	    vlan_get_protocol_and_depth(skb, skb->protocol, &depth) != 0)
>  		skb_set_network_header(skb, depth);
>  }
> -- 
> 2.43.0
> 


