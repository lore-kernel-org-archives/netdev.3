Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8DB33E37C
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 23:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790638783; cv=none; b=p138WV1h3GipQ72ujxJ9YhUSZ7Id8ned5gha1jeGrxNBXzhK0TUTuFRmevynKwLSv2rwqCJndXVQQfoq/RYxZVZZtWzX2W0Lcq9LJKVZCgFIfCsw/914NRhfIHUwYcDbu1ZexZZUp0ceKdWEzTQ1MoDbrMemQNF0kF7CfadxRDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790638783; c=relaxed/simple;
	bh=SMUYBNvZ1TBz9JB+dROyPugyw36vhX1GhTOQdMAJyVA=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=mto5WIHC+2fwOTX2+PoFeimYILLoaBJUUhEz9c/I/w7qhAMoYFJq7P+8CPVNse6U4zS5qxuJ0KPJICU4Qr7EFgSMUApGrWH7oe+a9Vs6OetQ2m2TfZ+tqWObB8Z9D4T4Uf0AKE+z5steil0JQQ1TLT44JmsIguFQGiCJyLJR9oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MaLBSyw8; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaLBSyw8"
Received: by mail-yx2-f13.google.com with SMTP id 956f58d0204a3-671563fb8beso3463097d50.3
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 16:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790638781; x=1791243581; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=aNaA1YyNbE6hdhbOU/GkMr/78/F0J2C4894zroJcEPE=;
        b=MaLBSyw8GsAAY8Lh3moUwrN1r2OAYv28tTPdYG3Y1n8DZMDujUYaYpzjglzrkqtKFJ
         /zb8LP8XBDnDQGRy5EYmTlxEw1MI3nMre1gC1NbhaZ1gsr4+IvugKX2nnFnyvC3JT+x1
         hEw6XWQoKle7JAOCNpiDh+KG5eNHiqaaKq3RWqcagn+53dSls0UTQvTE1yLVVYuoCkfg
         XfWQs1UnModmAzRK5qs4PVUkPgbHOBVGtknXIKPJr1ZxqsNxrgxo6pVaeqtF0FDr4Ovn
         UzYfjtup2oUj3sC0H2hldYZgMD/fQO75VdbL4vEgKtwaWivHeb+DiGJPT6v2poB9bATi
         fI0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790638781; x=1791243581;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=aNaA1YyNbE6hdhbOU/GkMr/78/F0J2C4894zroJcEPE=;
        b=EJDTSNza33gYyVcHPdooOOkQ4d5kcqkJ4dPD24U7nCjsiJsAVU5rOhD2xAMt1MwHrM
         3tgi0DcUOvUF9ei/Ww5f+nUwAgl/KYs/NgvL60WcEiRFD1ppi+Vcuv6ZLsmxoGDEh2h9
         f95cnHbiSt44rUs1prX8BgpZzGLUwJvrw3qxM2iYsfnHxVy48SVZrHx01LoeEGo99gJu
         I4cWg3Spw4o5bsRY8y6AtAPhmNTpqNW7S4cVU4uOb9NSJntR4J6qTi2wMuZpujqkTalL
         /tTHDMf6XeMvVbWSmnyhe2tjVV/iS7BE+0Tlr1A6K8Bs3wVrJ6dq2kjrRJ0TGyA6VyCw
         4C8w==
X-Forwarded-Encrypted: i=1; AKwUvBz0Vub6O3svcRKhDY4TJB9s+hBf7MfMwTlLJEzxFox3yIFPw7cLzJfUpXid6lBgc5AOAZyBKIo=@vger.kernel.org
X-Gm-Message-State: AFq9FYJVBAE9r8QuMaVI4J2DFxTDjwJBqs3UMWiJvetGR5rpgoEmbFch
	SvaqkO/5oi8Ubp5ozoRqWv/MQrZKNFp+MqFl9HzXihry0ddw3suxNj7O
X-Gm-Gg: AYBFou2l5qT7SwIahFNpp2ivlAmlLtRUtR8Ygtvpdsh0zxDs6fFXggXpHOi8BcO4Qjk
	Ml4gs49hiwjA1IhkTLXhfFjVSzthKW4Tl2t5QCM3CbvsnEecipPdd+C8dRt8ctFNEHoziNRCgrL
	4OrHrTRT3ryozuKzyQjedlcqZTXWJZD9nqk6DJq+bUxW0005XSQ4K3lzxz28SwGGerpa2NU47Tf
	QMIdHL6pNsXx9kcN7JAI9WmYyJlD5qhAvLInCWnCMehi9XDp282/dIGPgg64YfCjCavQsBK+TFv
	CbnbDgsnh0CvEQKbM1xsXzLTwuc8BOYEyFdwnCucp/zGFDAFyp3uvTzo51QtY+xARG6RfMvjNfZ
	kdraX6/OHOlOeOXfsiM6t6CXP/Kg21dgjho97vE17U39h5QqCaZRxJm7t6X6475CtAgqWx03oMf
	Ir6ejitzlHjc/ANLJiMuv224GPPktH5qHbdcPAKOECSs8hBfyNVRqIkuDMp/lRzGzhz6BT6j2AM
	UzlWrrx0spxjIqI+3c1lojKPO/O3cwFMzDYkTZok8lQDCanv+I6
X-Received: by 2002:a05:690e:11cb:b0:675:3363:676b with SMTP id 956f58d0204a3-67533636f78mr3016402d50.46.1790638776388;
        Mon, 28 Sep 2026 16:39:36 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6740ef22b3csm5297470d50.10.2026.09.28.16.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 16:39:35 -0700 (PDT)
Date: Mon, 28 Sep 2026 19:39:35 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wang Zhan <wang.zhan@smartx.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 keyong.sun@smartx.com, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Jason Wang <jasowangio@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Aaron Conole <aconole@redhat.com>, 
 Eelco Chaudron <echaudro@redhat.com>, 
 Ilya Maximets <i.maximets@ovn.org>, 
 dev@openvswitch.org, 
 Daniel Borkmann <daniel@iogearbox.net>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Alice Mikityanska <alice@isovalent.com>, 
 David Laight <david.laight.linux@gmail.com>, 
 Wang Zhan <wang.zhan@smartx.com>
Message-ID: <willemdebruijn.kernel.17cae5207b64e@gmail.com>
In-Reply-To: <20260928044102.1004310-4-wang.zhan@smartx.com>
References: <20260928044102.1004310-1-wang.zhan@smartx.com>
 <20260928044102.1004310-4-wang.zhan@smartx.com>
Subject: Re: [PATCH net-next v3 3/5] net: gso: support bounded TCP
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
> GSO skb into several GSO skbs which fit the device limits.  That needs the
> GSO engine to group several MSS segments into one output skb, so let
> callers bound the number of MSS segments each output skb carries and pass
> the bound through the existing __skb_gso_segment() entry point.  Ordinary
> callers use zero for no limit.
> 
> Without a bound, skb_segment() groups several MSS into one output skb only
> for a device which advertises NETIF_F_GSO_PARTIAL or for a skb with a
> frag_list which can be split into uniform pieces, and falls back to one
> segment per skb otherwise.  A caller which passes a bound asks for the
> grouping regardless, so the block which makes that decision is skipped
> when max_segs is set.  Callers which pass no bound keep it, and the bounded
> path only runs for skbs which carry no frag_list.
> 
> The output stays a GSO skb: gso_size is the original MSS and gso_segs is
> the number of MSS it holds, so a downstream device can still perform
> ordinary TSO.  Store the bound in the existing skb_gso_cb scratch context,
> alongside the call-local data_offset and mac_offset fields, so that the
> segmentation methods keep their signature.  A zero max_segs value means
> that no bound is active; it is not a persistent skb flag.
> 
> Assisted-by: LLM
> Signed-off-by: Wang Zhan <wang.zhan@smartx.com>
> 
> ---
> v3:
> - drop the tcp_gso_segment() exception: the caller keeps the features
> - cap the bound with GSO_MAX_SEGS instead of U16_MAX
> - drop the reset of the field in the output skbs: every caller initializes it
> - note in the kernel-doc that a bound is for TCP GSO skbs only
> - note at the frag_list gate that a bound must not go with a frag_list skb
> v2: https://lore.kernel.org/20260918084651.3022878-3-wang.zhan@smartx.com/
> v1: https://lore.kernel.org/20260917063854.2011613-3-wang.zhan@smartx.com/

> @@ -4839,7 +4840,13 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
>  	csum = !!can_checksum_protocol(features, proto);
>  
>  	if (sg && csum && !gso_by_frags)  {
> -		if (!(features & NETIF_F_GSO_PARTIAL)) {
> +		/*
> +		 * A call with max_segs set groups the MSS segments below,
> +		 * and the frag_list split in this block does not carry the
> +		 * bound, so a bound must not be passed for a skb with a
> +		 * frag_list.
> +		 */

To me this comment confuses rather than helps.

For one, it refers to "the bound" without any context.

Probably just drop.

> +		if (!max_segs && !(features & NETIF_F_GSO_PARTIAL)) {
>  			struct sk_buff *iter;
>  			unsigned int frag_len;
>  

