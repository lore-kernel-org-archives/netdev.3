Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793760706;
	b=EqspNRqhC91QGG9NErcJr+Q43AvUfZo02cKf2ASQpMfCCjV0rATrxizOMJVD4/HEoiIk
	 FVX7MrKl/SduxI6gG//87SnW+2+z5IYVkCsduf9qsQcxuHMxYcbcFBpLq8owCij6J8TyD
	 DkQpVXm8SwkaOvhYV0ByHt1RVVn/lxJJOXGK/Y3FGtfktRaiuGAbPnEVxsV0PtdVthlkK
	 DeqQYRE/y6lYfgZlmWd/QqLEMNdQ4xswj/S2IToki2X49zU4RXT4sKalBge9zJE4Q0gze
	 OTtGg7z7wA8TD7qTH7D5dSmCH8RuF3aksMP1gx2QJajA2ogtDaFLdHGc1qqdAy8Qf+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760706;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9zI6mjH3mnyzlCPDbKl42DHdCmQQNhpnWJ2Db2Xyrgc=;
	b=tmz0dxGozdsXxTcMJwk1uCVLQSzkRSb0+9oRpblke6IlMMDN+68exNdoG+gofTLQBhmS
	 vS1c7vN91nU8RzztjhOgzMlgDe9B0KwFxERC41LkTWAWWlXM6bHDrrNQthmUa2kKWVbUc
	 Nfi2TZQu32xcql097KwIcHu8F8QewqlzZuyg5vXSPv1GEWWjZtGKpaql4o9EImiGePbCN
	 NsNiXmNOBnId8eZbd+N+LpSrWhl5SZfEY3XPxIXkAWwE9MnO8ldMSJdx3kuDQUX+scn9F
	 1bvztgggmEptYV0n9NIwHMTwz1lhlQ4HHKXXx7i30p7yym70EmdU9Fr+ksjzStgdl7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yTnTfxrq;
	arc=none smtp.remote-ip=209.85.217.45
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAC48606A333
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 02:51:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAC48606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=yTnTfxrq
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-7cc53938a8fso98775137.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 18:51:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793760705; x=1794365505; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9zI6mjH3mnyzlCPDbKl42DHdCmQQNhpnWJ2Db2Xyrgc=;
        b=yTnTfxrquZhkFrcH8o0eldH0xWq8SFTM17xu48IvHT3ql8/DX5//t3hDwEQrL2RPA2
         uTahCkjiQmFxe0dkfpfADlgF/HTM4NSDjjBEi6lwUJLAXwz8pUDf/i4I8d4AAxCeLuPu
         pp8kt/F+7OmUkXMv977HHW/u2mmkR3LcJm213GcMePH0JRGZ6H2n0KcToIkD2eQz0yI+
         Str9jMcn+vhf9G02BEsPae4Y2WY531e2lE7vy29n3FbN+r0ObA0uUgKOoQaxI4p212KA
         8Laz/8MVhiGNeBtsZ5r8T5UZckLMu24qb0MO9k534s3OMKh18F7Gryd5oDuAqAhYk/WE
         AQcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793760705; x=1794365505;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9zI6mjH3mnyzlCPDbKl42DHdCmQQNhpnWJ2Db2Xyrgc=;
        b=RXbmlNH5F4dj0RzPCyqilymifUJIpy6qoiyGE9ZivOD0WScLsdOMZ35OKODO9uD8nn
         Tcu1kZjB+lw0ooyZ1WTBl9ncyfCYzspH8SJosK2wQZ9sZycHaulzgUBDl0kg9q7N2Dhe
         aOPXqUCjyXCw/J/Y5CbgkP8owYRI+GsguflQiI4urzbDZBmXsj1VJ/csNwOrvbu9vNYy
         s8n6Ur46frCuRkhsOluQdGx1Vxs/9oYIHshqOsNo3uWNoii0InHeyxSwokpeIs6LbiYq
         c4U/37RoXYlTOTtkdux4wvdy7pXHO0jVkIw68Ei0fYlFIsxzDvgGS5Wcx094xDzvGzD5
         avCA==
X-Forwarded-Encrypted: i=1; AKwUvBwikUJn6mJibIP6v79AtJo/BpoBPVtkRi7Gz3TFvOZyuqzVCxfpby5WNGZN9Dhjx3+zsEpDvFM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9XBowdVBH8RB1d109SGucfXN4AOdB4L8KgpWSrHaSZbfnBMvBi
	EPvGOSj5eELRu8OQ/suz6heEg0jBejTW0Dsh3VlMQNaPLXEIi+PHcB2K1Aam8Q==
X-Gm-Gg: AYBFou1/hAThqYwOPDkYZB0XrsDxn0Wdx3Mj0K8ALure8oRFLRSGiOps3NZJYFhDDSR
	EfXVaM3ec/UWt07JYul18Ox4yhoR6DKwofkbIDJX7khARZw0T/u+QMIX0QrAM6R6l/Yth5b31Tm
	YgniYSflDpkxeESpKkEIPSPuhnftAPN+yTljxubgeptuFRL7huROvGH8GW1NiGdahU+YL4Lb1bD
	uCqchEOgfJrncroNi4pn2EukFWv6J3jLJr0VLC8MLbLiHAoLJ1UNtHXSv3sJi3VV6KdqCPhMD1+
	UgbRc1e6IWEBhrKVo+bQDcrKAOfEzfQfEwAYWdQ/pdMuwlzg/5X4n25eGEQA4gdNnj0JUh4KoY2
	eKNXhbL3k6tlk14rN8GAh4FFpKHz7pUnmwFyIj1sMbQ6QDeC7jhN4D3ZPTtbJySPV2Qfv51Hiez
	K1yysmRn6jpan95YIo0miFItafrgGUp2toPHQa6dnAw4yCnR73gZjrdB/Hh1/O6R3YlNEHob6a3
	sXfgyk6dKu2Mh2Nj4i6af6a/yUxyqwK9TQA0xIab98KgrKPPcMJ7iE1Jo9FcDKV36vcXWwZjrMX
	PBKoNYj7K3YdaLyY14ZOFl3mb7dgUHITYjvLyJq1uat+gHIJn8BzbFpw2pbBE/70SPnJkrgO9er
	Rmusoce7vi09+4x+80pBQVG5DkZTqGzKIbq5iVIxE/Dx6SYZHtkweclXVNZeRkQHiaozrGOA=
X-Received: by 2002:a05:6102:8099:b0:7cc:bc0:b2d0 with SMTP id ada2fe7eead31-7d072d59168mr5914546137.33.1793760704860;
        Tue, 03 Nov 2026 18:51:44 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d26fd3e101sm696118137.3.2026.11.03.18.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 18:51:44 -0800 (PST)
Date: Tue, 03 Nov 2026 21:51:43 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Alexander Duyck <alexander.duyck@gmail.com>, 
 netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 horms@kernel.org, 
 kernel-team@meta.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 tactii@gmail.com
Message-ID: <willemdebruijn.kernel.2de9d4f8c5034@gmail.com>
In-Reply-To: <179372577673.49909.11253315483074546903.stgit@ahduyck-xeon-server.home.arpa>
References: <179372577673.49909.11253315483074546903.stgit@ahduyck-xeon-server.home.arpa>
Subject: Re: [net PATCH] net: Segment CHECKSUM_UNNECESSARY GSO skbs other than
 fraglist
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Alexander Duyck wrote:
> From: Alexander Duyck <alexanderduyck@fb.com>
> 
> The netif_needs_gso function lets a GSO skb reach the device unsegmented
> when it is CHECKSUM_PARTIAL or CHECKSUM_UNNECESSARY. The second case was
> added for FCoE, whose transmit path marked CRC offload that way at the
> time. Commit 253aab0597d9 ("fcoe: Use CHECKSUM_PARTIAL to indicate CRC
> offload") moved FCoE back to CHECKSUM_PARTIAL but left the exemption in
> place, with nothing left that needed it. Fraglist GSO, added later, is
> its only user today, as its segments already carry valid checksums.
> 
> A TCP GSO skb can still arrive as CHECKSUM_UNNECESSARY without being
> fraglist. Hardware LRO builds its aggregates that way, for example mlx5
> sets SKB_GSO_TCPV4 or SKB_GSO_TCPV6 and CHECKSUM_UNNECESSARY, without
> SKB_GSO_DODGY. IP forwarding and bridging turn LRO off, but a tc mirred
> redirect does not, so such an skb can be sent out another device. It
> has no csum_start and its TCP checksum field is whatever the aggregate
> left there. Drivers that only set up TSO for CHECKSUM_PARTIAL, such as
> fbnic, i40e and ice, then send the whole skb as one oversized frame
> with a bad checksum.
> 
> Have the validate_xmit_skb function mark any CHECKSUM_UNNECESSARY GSO
> skb other than fraglist as CHECKSUM_NONE, which means the same on
> transmit. The netif_needs_gso function then segments it in software,

tcp[46]_gso_segment convert to CHECKSUM_PARTIAL and then
tcp_gso_segment will send it on to hardware if skb_gso_ok with
NETIF_F_GSO_ROBUST.

> and the __skb_gso_segment function unshares the header before the
> protocol code rewrites the L4 checksum field. The callers of the
> netif_needs_gso function that decide on segmentation for themselves,
> such as tap, are left as they are.
> 
> Found by code inspection. In QEMU with an emulated fbnic, TCPv4 and
> TCPv6 GSO skbs built this way each went out as a single 11 KB frame
> with a bad TCP checksum. With this change they are segmented into
> MSS-sized frames with valid checksums.
> 
> Fixes: 253aab0597d9 ("fcoe: Use CHECKSUM_PARTIAL to indicate CRC offload")
> Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

With the above aside. Not important enough to respin imho.

> ---
>  net/core/dev.c |   11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/net/core/dev.c b/net/core/dev.c
> index f32353b0467c..28b4a652d037 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -4207,6 +4207,17 @@ static struct sk_buff *validate_xmit_skb(struct sk_buff *skb, struct net_device
>  	if (unlikely(!skb))
>  		goto out_null;
>  
> +	/* Only fraglist GSO, whose segments already carry valid checksums,
> +	 * can be handed to a device as CHECKSUM_UNNECESSARY. Any other GSO
> +	 * skb has no csum_start for the device to segment from. NONE means
> +	 * the same on transmit, and has netif_needs_gso() segment it in
> +	 * software.
> +	 */
> +	if (unlikely(skb->ip_summed == CHECKSUM_UNNECESSARY &&
> +		     skb_is_gso(skb) &&
> +		     !(skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST)))
> +		skb->ip_summed = CHECKSUM_NONE;
> +

It's unfortunate that we need to add yet another branch in the hot path.
But I also do not see a good alternative.

>  	features = netif_skb_features(skb);
>  	skb = validate_xmit_vlan(skb, features);
>  	if (unlikely(!skb))
> 
> 


