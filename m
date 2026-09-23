Received: from mail-yx2-f43.google.com (mail-yx2-f43.google.com [74.125.224.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15933391E74
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 16:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790182213; cv=none; b=Gc/iTEUlwccTDgkGH7jWwTLEyhAH+RvuUsFAmhJb+d7BS62gPFumjh4txwlIKhTYnb1H6CasDvFagNwXt2rNaKu9zIeaZhobXJGpTCqRUL+CnVMkeut+kzWYSL5sJbO/k+ak6n+aa9xqc2I6FexsqjZ2+CR0POonmPGgh3uhNUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790182213; c=relaxed/simple;
	bh=UBzO7eNe1wHCCGYU37KkFkjNJsONyzSjGX0ydd0jcIk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=u4FuT0MIidCwygHVGnFORkq5IVjXuKWeyaH9p+MI0kxnnp/E2UHyG88bhcoJt9M3cGS/JHjbQv2+xJeNKyypTjZ5AOGlNA4sHih8sQuJU6N3QY9zmPYCink1UtgzpHxdMPbuJn6ehhMvi5/miWPzxxFcLFvDEm9tXFb+7dyrIU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aItUJCWs; arc=none smtp.client-ip=74.125.224.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aItUJCWs"
Received: by mail-yx2-f43.google.com with SMTP id 00721157ae682-85d4ddd179eso17111007b3.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 09:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790182211; x=1790787011; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=YvBYJg7FWevPxhCdOXQ2FxAbLc0WRMhT0L3rE2LGCJM=;
        b=aItUJCWsIFfbrref37T3jE4fGzmxF8711nY0CFF9SI5Noz0lFp5fjAYgciVPEc1Ah7
         tyU8Kf/SPjEPrEWqs7Kv3f6wodnr5hbWdTLj4O7OaEAuWSwqDrjIUM7OLZjLgaUMhCFL
         B3BrGT6sdNj8sKqlHV6aq0avACJJfmCsbn0SW6EZs5ETUiS/dyoNLnQSr0zn1QzLh6f+
         YsaLXxq9SCVHLqjHGmMGTtpsUYY4Aei+AGk5hyyuPRbHiBOxqCLW9AYSN4BuBxz5Hx4C
         M0KCwGOazlSTaX7oB+0E3BZc67tWXlAf2gaAfShsWJDjOmgTdh/CdI4wI62dg6nDd9aB
         o3dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790182211; x=1790787011;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=YvBYJg7FWevPxhCdOXQ2FxAbLc0WRMhT0L3rE2LGCJM=;
        b=TnLaVoUJ1f4gTJSVoSxCIGmu6x6wDBfTn+j6EubQfy9Dnfye84q9MfQZ+IyCDn2PAQ
         JnlvL7+JxenFCK2CM62MNw6ZJkLlBb0GCVQyGkfilOjBJN4jTUCnXdqTMpgB8xX9IqOE
         xcIseKU4cbSv9mMgSKQuWctk/9dvf9TA8VW0vFeET0PI0BWFAYwdKGhayTCWIPGCw6Jm
         /Q83K9NYfq0filpvagKFcHdMmZBVIiF6NDp8/+Y+CPBkW0MgVG0HJhJTXZZWTMbHs5wf
         ntPkXPOVSVc85oThuf2A2RgXSawpTherf6bBNr+WZCuyMmF9MiV4tQOqldzjfMjyL0vk
         boYw==
X-Forwarded-Encrypted: i=1; AKwUvBw2BaMaFV8MOPrA5PkhYmdyS/NIQqRPDGJ5w6JW8J1Q/l1h0YsYoCnNEGHHTpKYcyD5bNma0IQ=@vger.kernel.org
X-Gm-Message-State: AFuF++lm0IdYGz6KV4vj95bkLgguPKcEd0JgTInFoNQHRa3Qm5wFd9kp
	sqDd5ghdNQphQ3g/lZ/tZwbk9XBXRQSGGjm7YR7wCS5tJOpL61mhZ6o87ucHzQ==
X-Gm-Gg: AYBFou1xKkESPCTquCCB5ddvzgRLo8Y3cjtJYpFTh21m8uHULOZPHqgCLdoXvuHdk01
	jCzXEZNGk5MEDsM0HI6I63uZW45leNcVVVNleFLKbeG3IZJ7RvOhEIig9Ld+PVUpYrFIRyILkD6
	vr2GdhI6oi0m8kIZMHT5y2yqKnkRHg4xkQgdrRLsCrJAF+MQv1Z1g55fLcnCpudhSZ96Ua8VDYk
	N/kvtC0NndnQS3rQjovtOBLF3iYG1IsizSc+cNs2pP0qYRZHvnNaRNZ0Ftmm9sJsFc14GPnSfD3
	CGZJpAph2PPjF+Ce4NiJj2C6u1QxNvTGc2zRKOHcWE8zezy+sfCPTcQ0ZM4eRh0CYsMEylLgcaN
	GTiL6pkF9nTcP1CaYn2GgFcLC1yyaF8x9AubUeXFydE+LN7Om8+sBbSQS/yqyquRdkqJfP4Hg2H
	rE0BOtgAgUb576nPTbTIuTHSJ6R8y3bonne2AouctnCAObASe+arfqmTfBB72j0kxlgU3Ku5q7G
	xp+jPZbALPJDIdyCbDimSu65g9xdNmLTKd0Mdes21KPXsakBRXoTT1HmvrROAU=
X-Received: by 2002:a05:690c:f05:b0:893:cf3a:f84d with SMTP id 00721157ae682-8a459705721mr27828947b3.24.1790182210787;
        Wed, 23 Sep 2026 09:50:10 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a4665df063sm12659367b3.41.2026.09.23.09.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 09:50:10 -0700 (PDT)
Date: Wed, 23 Sep 2026 12:50:09 -0400
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
Message-ID: <willemdebruijn.kernel.3a0e7cb98a0bc@gmail.com>
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
 
> @@ -117,6 +119,7 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
>  
>  	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
>  	SKB_GSO_CB(skb)->encap_level = 0;
> +	SKB_GSO_CB(skb)->max_segs = min_t(unsigned int, max_segs, U16_MAX);

Can this use GSO_MAX_SEGS rather than U16_MAX.
>  
>  	skb_reset_mac_header(skb);
>  	skb_reset_mac_len(skb);
> diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> index dbbe10277d51d..9c0d140236bc6 100644
> --- a/net/core/skbuff.c
> +++ b/net/core/skbuff.c
> @@ -4793,6 +4793,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  	struct sk_buff *segs = NULL;
>  	struct sk_buff *tail = NULL;
>  	struct sk_buff *list_skb = skb_shinfo(head_skb)->frag_list;
> +	unsigned int max_segs = SKB_GSO_CB(head_skb)->max_segs;
>  	unsigned int mss = skb_shinfo(head_skb)->gso_size;
>  	bool gso_by_frags = mss == GSO_BY_FRAGS;
>  	unsigned int doffset = head_skb->data - skb_mac_header(head_skb);
> @@ -4839,7 +4840,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  	csum = !!can_checksum_protocol(features, proto);
>  
>  	if (sg && csum && !gso_by_frags)  {
> -		if (!(features & NETIF_F_GSO_PARTIAL)) {
> +		if (!max_segs && !(features & NETIF_F_GSO_PARTIAL)) {
>  			struct sk_buff *iter;
>  			unsigned int frag_len;
>  
> @@ -4874,7 +4875,10 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  		 * now.
>  		 */
>  		DEBUG_NET_WARN_ON_ONCE(len / mss > GSO_MAX_SEGS);
> -		partial_segs = min(len / mss, GSO_MAX_SEGS);
> +		if (max_segs)
> +			partial_segs = min(len / mss, max_segs);
> +		else
> +			partial_segs = min(len / mss, GSO_MAX_SEGS);
>  		if (partial_segs > 1)
>  			mss *= partial_segs;
>  		else
> @@ -4975,6 +4979,12 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  
>  		__copy_skb_header(nskb, head_skb);
>  
> +		/*
> +		 * max_segs is a per-call limit, so output skbs must not
> +		 * inherit it from the input skb.
> +		 */
> +		SKB_GSO_CB(nskb)->max_segs = 0;
> +

cb has to be treated as uninitialized between layers. All callers of
__skb_gso_segment should (re)initialize this field. Is it necessary to
clear it here. Note that we do not do that for any other cb fields.
