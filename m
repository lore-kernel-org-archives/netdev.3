Received: from mail-yx2-f16.google.com (mail-yx2-f16.google.com [74.125.224.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66C4636729C
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 15:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789832120; cv=none; b=olpPXur7sc/2/yz0GCot8X84vCrAEaSrlItI55P//SeUDXja+PRpf/pAtXP1AF/H41iEeaQbDkPAgR4a6xSts9940ruIDp5aAIn+/ynC55cMsDLcsQDB8tXnajNdNKcTn0H/WXfMiTyoNcNayWuNEbMTnAe1suxrDEhCfGvCmsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789832120; c=relaxed/simple;
	bh=WH3lnF7bcuqcDts/1VF2zcED6ty2u4Vh0PquDicuSaY=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=gHSaBz7A9m+ocCY1Xk1FS8ZDi35J05KoNUt/QvmmCafnUKgMjA9MsaW6rsNaQUS6VcL/w+M0L7PNfB8B8qXhWJ6KIQ6HxMN67nZXqsXZ+WI/pHnHa6k7xj5psQEcPIhFpkSnc17BN8IbFhrXOMFSc4zM5i6exwDUUM6SDnS/wpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XBGyQTx7; arc=none smtp.client-ip=74.125.224.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XBGyQTx7"
Received: by mail-yx2-f16.google.com with SMTP id 956f58d0204a3-66e56a1fe83so1529587d50.2
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 08:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789832118; x=1790436918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=hS1BB+4whiIt4x+WEfY/p96wA2SgN83kVVDI05Xparo=;
        b=XBGyQTx7XsT1ukQCKhPl9jIihCrp5QEc0PjFLkiYuApayQlsYu0Q7s621Kgd44tK6T
         9y5GTZ/FEG6gJpcESnmA/zKCzZ9DHn1sdIDnU/sre5rZr0kIDf1hqKgkFn0q+HQS4j4L
         4aVN1fvuGRqXTm0Xf/83hSarDiYXa9tzTkBV1uhb0jVjU7uDfvH7wrH1buMIbHmd9++d
         mcUyIg9/wmJcERpBnLgchgfsoISNqE/z4OGks3hmAXQs/wu1ml6YEb0Sbdv6MD7c3fET
         dPxoOsL5UWE8BC58nFXKlcsWxia+ttMQ2QZhHASbvhZJ+xz7l9XTKIRooJiviKSxWj5d
         zg4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789832118; x=1790436918;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hS1BB+4whiIt4x+WEfY/p96wA2SgN83kVVDI05Xparo=;
        b=C8QZorg5tl259SSDzDmwpXfBjnQjjcnInqNibNNnzNoncj4KpOUxfuGQ++FyNjYOR1
         VMm/SR+i77pF9i3l4mTdtlDijn3hLaTtZdE9eUskoHPOeAmxSG9b0cnaPY33sQqCiWt3
         DFMtJMv7RTLjxe8m7Yw/oFx/f+Zah1f/Nr8dsG6ELf/q/vNwLErd55biYPLogp/cVasI
         qYtMjP/WEEWc5ZZt4Qa/bRBgsebzGY18kcUXH1JorVtnhiGGvrWzglgnel3m//PbsIlG
         nZ1W5UA6qfjAGSh/4uq8zkqgy0cVt+WQUYGgGdjBTSD2shFdumascwCEopkw0dKSGFiV
         GFWw==
X-Forwarded-Encrypted: i=1; AKwUvByUtJggJ3LD0M2lxaZ1mfSEZA4IQaguLSOuFC/FOpsfII+rRAycgmfcXQMqV/qhC6pHJE3impc=@vger.kernel.org
X-Gm-Message-State: AFuF++nOSUMFiU+Hp0UKG9I9naFp8rzV1rQnqCHgkEcUGQoPaG1tNPbm
	i0dfozDyJarKmh7qRnqzpoAAvTRA6c9wm0vkTjtsUzrW+PEAikhAEy6TUJ0K4g==
X-Gm-Gg: AYBFou2CA4gmyI25GHOfq4TnG+CgAGZMHy95A1jCt7RjXeiKwDj8g5aQPBvLAMunku3
	L22SApVsJxpmHMZEn+SjkW52eKaQxnCRCKeLmuH5NPVxuLEfhScXYOYSZO6fniT3QH4pQvXlr1w
	7R+niHC44logBiE5JdKDZ7J0Bx7cWiPw2ky9ESwOtszlxXnEJjcVLXziaIFN6ysau/dGvlnjR6U
	VNH4yPgA6T3NkQYaCYRiC1CY5uRky/Pt02SAiw6UhD7Ucf43Pyd/7JI86WA9OlS/hBjxHgiSASI
	Q7zZ8ZWudo81cNCedYetTPkdnDcRsuwmtCBZHRRXeweIrwpVKJe6irj/asgDNyt/0X1jqiTIaKJ
	3TUswB+Hl65avlOVv6N29BqW4t+KuTu0HLMBapbSmhxnG5/np6Ga86TUTc/hNgbF1+BIwTacPmF
	IbbGre+T86HPuo+8TBpyBTI8vIDU4J/WTfJezHA6afTtuAxsfXIFAMMntnrRnYDVYE3ASN+Y220
	82MC/Enq4ApmAy9+ZvZANSbRMnMCQv42rKmcQaYbDW2vm4xnFdX
X-Received: by 2002:a53:d3c3:0:b0:66f:c1be:318b with SMTP id 956f58d0204a3-6717fe37a21mr1440184d50.98.1789832118219;
        Sat, 19 Sep 2026 08:35:18 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-672990d0173sm1353627d50.11.2026.09.19.08.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 08:35:17 -0700 (PDT)
Date: Sat, 19 Sep 2026 11:35:17 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wang Zhan <wang.zhan@smartx.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 keyong.sun@smartx.com, 
 Ilya Maximets <i.maximets@ovn.org>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 dev@openvswitch.org, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Jason Wang <jasowangio@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Alice Mikityanska <alice@isovalent.com>, 
 Wang Zhan <wang.zhan@smartx.com>
Message-ID: <willemdebruijn.kernel.7b2e4c8d0d45@gmail.com>
In-Reply-To: <20260918084651.3022878-3-wang.zhan@smartx.com>
References: <20260918084651.3022878-1-wang.zhan@smartx.com>
 <20260918084651.3022878-3-wang.zhan@smartx.com>
Subject: Re: [PATCH net-next v2 2/4] net: gso: support bounded TCP
 segmentation
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Wang Zhan wrote:
> The bounded resegmentation added by the next patch splits an oversized TCP
> GSO skb into several GSO skbs which fit the device limits. That needs the
> GSO engine to group several MSS segments into one output skb, so let
> callers bound the number of MSS segments each output skb carries and pass
> the bound through the existing __skb_gso_segment() entry point. Ordinary
> callers use zero for no limit.
> 
> skb_segment() only groups several MSS into one output skb when the device
> advertises NETIF_F_GSO_PARTIAL, or when the skb has a frag_list which can
> be split into uniform pieces, and falls back to one segment per skb
> otherwise. A caller which passes a bound asks for that grouping
> regardless, so the frag_list check is skipped when max_segs is set. Every
> other caller keeps it, and the bounded path is only used for skbs which do
> not carry a frag_list.
> 
> The output stays a GSO skb: gso_size is the original MSS and gso_segs is
> the number of MSS it holds, so a downstream device can still perform
> ordinary TSO. Store the bound in the existing skb_gso_cb scratch context,
> alongside the call-local data_offset and mac_offset fields, so that the
> segmentation methods keep their signature. A zero max_segs value means
> that no bound is active; it is not a persistent skb flag. Clear the value
> when each output skb copies the input header so the temporary limit is not
> propagated to the next GSO call.
> 
> Assisted-by: LLM
> Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
> 
> ---
> v2:
> - wrap the tap.c declaration and skb_gso_cb comment to 80 columns
> v1: https://lore.kernel.org/20260917063854.2011613-3-wang.zhan@smartx.com/
> ---
>  drivers/net/tap.c          |  3 ++-
>  include/net/gso.h          |  6 ++++--
>  include/net/udp.h          |  2 +-
>  net/core/gso.c             |  5 ++++-
>  net/core/skbuff.c          | 14 ++++++++++++--
>  net/ipv4/tcp_offload.c     |  3 ++-
>  net/openvswitch/datapath.c |  2 +-
>  7 files changed, 26 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/net/tap.c b/drivers/net/tap.c
> index ff67d99deb39e..bc111495ebbce 100644
> --- a/drivers/net/tap.c
> +++ b/drivers/net/tap.c
> @@ -278,9 +278,10 @@ rx_handler_result_t tap_handle_frame(struct sk_buff **pskb)
>  	if (q->flags & IFF_VNET_HDR)
>  		features |= tap->tap_features;
>  	if (netif_needs_gso(skb, features)) {
> -		struct sk_buff *segs = __skb_gso_segment(skb, features, false);
> +		struct sk_buff *segs;
>  		struct sk_buff *next;
>  
> +		segs = __skb_gso_segment(skb, features, false, 0);

irrelevant?

> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index dbbe10277d51d..9c0d140236bc6 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4793,6 +4793,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  	struct sk_buff *segs = NULL;
>  	struct sk_buff *tail = NULL;
>  	struct sk_buff *list_skb = skb_shinfo(head_skb)->frag_list;
> +	unsigned int max_segs = SKB_GSO_CB(head_skb)->max_segs;

could this be computed inside skb_segment, rather than having to be
passed through SKB_GSO_CB. I haven't checked, but it would simplify.

>  	unsigned int mss = skb_shinfo(head_skb)->gso_size;
>  	bool gso_by_frags = mss == GSO_BY_FRAGS;
>  	unsigned int doffset = head_skb->data - skb_mac_header(head_skb);
