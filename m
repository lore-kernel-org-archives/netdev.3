Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B685630E0E9
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 02:07:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783562841; cv=none; b=UgcyDLcztc/LcRMhHMF8/BWhlu++l+CzC0nlc9rhdRwVc5Gq3b27beY918kDymCqdrN/u4EbzcjSewVV4Oy7utGbB4JU76rS7eAP2vb92f7kUb5+w/lk+1yhT5KWVcUOGOheoA/xLO2lofUYZoTn7TeYjnyF8q/98ht7et3C/Go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783562841; c=relaxed/simple;
	bh=PoPEUr6KS0Je/aVdiGP+sFxqtUXWh++lbWgpLTbivR8=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=XD3JvOlbLzPayRTAsTclziYyF4eVB7W79GQOeUrsuomXSEW9tRTrFo5r+KJyFRF/K2AIRWu7iMLJ/okNiGqMcW+1gA8U5sxQkiYixBUv6Rp6LGd72rYQ9vhYhUq9TAEoL3lTXvQXK5cV32GfsxS4g0KgegNLKYArQAM7LocAdI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ma4wp730; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ma4wp730"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-80cbb0688c8so21107487b3.1
        for <netdev@vger.kernel.org>; Wed, 08 Jul 2026 19:07:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783562839; x=1784167639; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DiPeyVYQaEiVqx7WKQEaIVABISxwCwD67P0r37Z1zdw=;
        b=Ma4wp730Sv4nNZnOHmCCC5/vyV55tWljs0zgQoSeoykBlsnAflLTdnjsTTDuGU2Wnf
         CQs0kQSNDkM042f9UhB3aPhz+i9u6QV5+Zxfm4hWJAfwhNpr2wjbWo2C/jlW9OeQ+VBx
         7pzOfEYDvgpN3PJ3vPPK6j2yXNx8JiD1io3b18sTdsoAr0w0IJegiKmPXdNSOOyfnw95
         Ck+wyXHkH8jP7lP9CaDWkwH7xU6T0Ss6CmlHXzDKvgYtyLs0imYvY/BKEsHdzQgsDXT4
         O8GnH1tn/cnijR8c9ypE/5pHaq6badb5OxaW5oR8dZsaQECB3zGSjJ+n/F5cI9FVunJe
         osmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783562839; x=1784167639;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DiPeyVYQaEiVqx7WKQEaIVABISxwCwD67P0r37Z1zdw=;
        b=JhBcJeYt96lZtUFOwURSiiJ9aOGKLbdKrhKujLlwbFiG3BdPI0PNOLRxxyZbNFNz8H
         HRYlBmNFZ66YxDT+nkcUwn+vw6qWcAiRMfk3LCw2e/HMqmwk7bFb1570HNf4x2Vvawlr
         /ju3RpoH8onOzBmyu5ssqdO2WWRqyDZCc8Mvt6ZauAWTg8987eyN2UgOw3vfVRV1vATy
         xvwNBD9YnlqXxVgpwHBWGWKSfXPfkknePUGhpAM2/rm56L3UIME54rN3ggTo/ddrMDQu
         K97TSgQLZIwdEgSJ/abh8DSYOjuF3ySe642HsQlJsmEEHOI1JxVZcxJHtE1cpNmHMPEJ
         5etg==
X-Forwarded-Encrypted: i=1; AHgh+RrpJctQO08rkGXy9A6/WQFRAKLdmY99Iu7sVosQj57STZHRpXQcpI3oD8YMLeg5D5CUoFi8BqI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVA7moRo5lGgCn7ZUzT8No9mkEJblppQKDGSC0OSRoZS/B4TvE
	QTIJzchblwOcrN9sS1+9zLEX9E7jROGzfA0zKlW5gja9YWB5/OdnQVnq
X-Gm-Gg: AfdE7cmCc/+xhysm+/zgD6sj2zEm6VTolzwNUXiHu8VOii/XYukAUxuYKss2reegrWx
	4YanEtJbt34o/B1zRXPMc6dJZydR8h929V50EhcN7ayri8yHANKXlDA+dcLNGJVAWWtTfEioMCe
	Up12UMDTCKPCpsKkaOc+Sxek83DjN/1drpHkx9yGGpavbgSvbrxVm9TwluEkyweoGDyxlRWaXeI
	2ONolKb3cqxZQOpIzoaZ+Is2xnypjKviHDCm4cWI3hLfCuqyT2eUhVENHIq6KiGmpt644M9s5gK
	/0Xr2yf7dJTA0GEX5AKS4ZV4rwO4Ema1tYtjVfohJ4P9jQXPI0BBxzfdSpHQJQCSFE5oSjofq7I
	YJzFO7mrdTCL9XrsRHA4WrlNf5SquviQuJMex9/KEON1GdRuuJ/pliJ50a0wFhRca/twdOdAU8P
	H/pN3QTM/EqzMpWF2pWdIiWdbkwTNXN7TnkODBLD/ohRgk3ZnjiHHvoDSlXFGTKMogBQ==
X-Received: by 2002:a05:690c:4b90:b0:814:608a:acb4 with SMTP id 00721157ae682-81dbeb5f73emr38829227b3.27.1783562838726;
        Wed, 08 Jul 2026 19:07:18 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81e6be904a4sm6869687b3.7.2026.07.08.19.07.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 19:07:18 -0700 (PDT)
Date: Wed, 08 Jul 2026 22:07:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Shiming Cheng <shiming.cheng@mediatek.com>, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 matthias.bgg@gmail.com, 
 angelogioacchino.delregno@collabora.com, 
 willemb@google.com, 
 daniel.zahka@gmail.com, 
 alice@isovalent.com, 
 sd@queasysnail.net, 
 eilaimemedsnaimel@gmail.com, 
 imv4bel@gmail.com, 
 nbd@nbd.name, 
 dsahern@kernel.org, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org, 
 steffen.klassert@secunet.com, 
 lena.wang@mediatek.com, 
 shiming.cheng@mediatek.com
Message-ID: <willemdebruijn.kernel.2801a1401793d@gmail.com>
In-Reply-To: <20260709014704.3625-1-shiming.cheng@mediatek.com>
References: <20260709014704.3625-1-shiming.cheng@mediatek.com>
Subject: Re: [PATCH v7] net: gro: fix double aggregation of flush-marked skbs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Reminder to mark patches [PATCH net v7]

(or PATCH net-next when targeting that tree)

Shiming Cheng wrote:
> Commit 0ab03f353d36 ("net-gro: Fix GRO flush when receiving a GSO
> packet.") added a flush check to skb_gro_receive(), but
> skb_gro_receive_list() lacks the same validation.
> 
> As a result, packets marked with NAPI_GRO_CB(skb)->flush may still be
> re-aggregated.
> 
> This allows already-GRO'd packets with existing frag_list to be
> re-aggregated into a new GRO session, corrupting the frag_list chain
> structure. When skb_segment() attempts to unpack these malformed packets,
> it encounters invalid state and triggers a kernel panic.
> 
> Scenario (Tethering/Device forwarding):
>   1. Driver: Generated aggregated packet P1 via LRO with frag_list
>   2. Dev A: Receives aggregated fraglist packet and flush flag set
>   3. Dev A: Re-enters GRO, skb_gro_receive_list() is called
>   4. Missing flush check allows re-aggregation despite flush flag
>   5. Frag_list chain becomes corrupted (loops or dangling refs)
>   6. Dev B: TX path calls skb_segment(), crashes on corrupted frag_list
> 
> Root cause in skb_segment():
>   The check at line ~4891:
>     if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
>         (skb_headlen(list_skb) == len || sg)) {
> 
>   When frag_list is corrupted by double aggregation, when list_skb is
>   a NULL pointer from skb->next, skb_headlen(list_skb) dereference
>   NULL/corrupted pointers occurs.
> 
> Call Trace:
>  skb_headlen(NULL skb)
>  skb_segment
>  tcp_gso_segment
>  tcp4_gso_segment
>  inet_gso_segment
>  skb_mac_gso_segment
>  __skb_gso_segment
>  skb_gso_segment
>  validate_xmit_skb
>  validate_xmit_skb_list
>  sch_direct_xmit
>  qdisc_restart
>  __qdisc_run
>  qdisc_run
>  net_tx_action
> 
> Fix: Add NAPI_GRO_CB(skb)->flush validation to the early-return check in
> skb_gro_receive_list(), matching the defensive programming pattern of
> skb_gro_receive().
> 
> Fixes: 3a1296a38d0c ("net: Support GRO/GSO fraglist chaining.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Shiming Cheng <shiming.cheng@mediatek.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
