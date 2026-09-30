Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B4363D3498
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 19:52:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790797928; cv=none; b=jswGfSn4F1jKwvLu4rCBCxOWT92zv7SbCwnk55kjCGtosmFNJAZtiCw7y3cH7LBjTj8TSdMLBJtcAlCwofIpqoPVSNScmM6rprOzPQ1kcEWC7QTnK3ASxgH86Jz6XnKxgfgJ786DPyv1iM1T/kLPGumam5540igP60hAajP3AyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790797928; c=relaxed/simple;
	bh=nJ89Sy3OIv2fjeX4A5ZdXyY+RDPM3pl8eMeJhtFGHEo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=FDJwRgJUZR9r/LXNDzFOhUmdjGh8J5W3fFo9+zdKnvxNR7FFWws0Ecp7jp/lsdxW1UcNTyH0j3t69p4LtLlKM1bErO/8aisuh93YdFyo7IDZlKYcAVV9n5jkv/8CFCYSsogtHHex6OvPY+zu3zRLozs8Wg4/1O6ZLGgvGNxRS8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PwSE4h+y; arc=none smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwSE4h+y"
Received: by mail-yx2-f41.google.com with SMTP id 956f58d0204a3-6756acdc3a8so2242168d50.1
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 12:52:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790797923; x=1791402723; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7UswZ1kfk2nEf1n36gb9N0khFHCB4Tmf/Ok6wJ369P8=;
        b=PwSE4h+yUblwOI8d4cSAy77P5mOz4GgaP+16wWvj5aOmYdWxuBsQxlSq+ENHefdCsF
         arJrfHIxxkvJnuLDTlNn7oSL9YD8jx9qLAK7mz2+oPtf+FEHnlK0iI0wOf6e8boVqCL/
         uKGbWotMRx7hYElJ9VNuPAtV0/rrrh/6++vytyJLRpdgOLQmfgqyXpjD48naYCn8jXax
         ePo1keCltiYDuQcPpmXX19Kd+J/yqV0DqQXFhBhFDcg3jcUMkvVR421LnIALbs0j3HoG
         TndegiMMrqmWPJIfdJMLDTt1MDDDtVEXUB0HQ5UVypL6+XaROfgdMETse3Zzaunxl/6J
         jdbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790797923; x=1791402723;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7UswZ1kfk2nEf1n36gb9N0khFHCB4Tmf/Ok6wJ369P8=;
        b=yLHH5wg7iVZmOUTG43aFExcKVPHfgLhjMIUwFyp3kB1NUaz4PD3WgrwehNrN6tHycp
         5qIRHwRkgWvwx6R9NXcWTnCojLG6jgVf87fZG4o6/Q33n5lYg27kg6yqMgNd9/Y2O72e
         3OpAMEF16UXaqtj6zGnWrVINdSjGLY4Dlo65tNZ+2/SExZIiubsaxzV7sRN5tqAhVFwF
         Pg1I0/UlYk2Do2a8UzFi1iGp207SwdX0VSvy0I8YxzsNIHsF+mCQJePWrKsmB3J8mowQ
         9lNw4vysP3YNEBL+4x2dLUVG+PRe51myw8mN4nDFqmvo2fdX5C5GPQYzWAc0QB1nkVRt
         t9dA==
X-Forwarded-Encrypted: i=1; AKwUvByMs7Ff5eVuKqzjdSBLKf4UKPuB4qZppDcID2Ql8d2bDDHYfeGgnAxWpYm922oX1QNuIzmmBEU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJtA8AuEa3L6VYEspZNdAfX6YAQeqsW6RJHda/Zr2DSaJvDnbIX
	pSGiDs/SGw2NsuIW646ywChnWqjzBmFVyqieq0ZAphcr8/e8IfnfT1d5
X-Gm-Gg: AYBFou1+/Af3wWVVoLgrRUeubAD269jyiVMkLh+8zhsRiZ7qsPUbnKssW+tBSr+ge9O
	TZXrgtiaB7rwYZOEXTUm3Y4X830X1mTr1GoHnuTZD9/OPo5nr8ZmMZcBnWhNQPAbGBtoKSPImgP
	SXc7PaUGzTxggLdK80Xvjus+aBzkaUWwPG5lxzKzjFs9a1pskRIs8NdMtGW4kLlv4NyVCI9M1VU
	AYgcaa0wIjaIGvWvB4upi9OsIzoDg/MMqg6zG/e6QoHndjdkB0qXwCj9NsElZz8flPLNUddsR+x
	6JcxNzORn7YDHXyGeC3KyKQSjWw//Hk1WBm2hglGQZDjYObjetTo79vvV/PPiO9GXtU94brdXQ/
	RUKGw6xpujPhd4aM788zMNZqB7o673lSjqqgj8F8RdWqA/sv8iNTBEodifWfkbnbtjAdbv4dZqp
	/dIMirPQ/Np/8jytPxe7dUtdgx+lyBIIpNKgSBVPJiqhW+sMTnJT4artQalOS6SYFbcxb3cGm+h
	qAgRtIpUVJ/w2IrFvFHX9eb1gLxsyu4yHfJLpZGv+UqWmdVGJ7d
X-Received: by 2002:a05:690e:b4f:b0:675:39f6:9bbe with SMTP id 956f58d0204a3-67683446df8mr1125080d50.56.1790797922734;
        Wed, 30 Sep 2026 12:52:02 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67691a15e97sm188948d50.20.2026.09.30.12.52.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 12:52:02 -0700 (PDT)
Date: Wed, 30 Sep 2026 15:52:01 -0400
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
Message-ID: <willemdebruijn.kernel.30c9628e9a7f6@gmail.com>
In-Reply-To: <20260930111526.2183107-4-wang.zhan@smartx.com>
References: <20260930111526.2183107-1-wang.zhan@smartx.com>
 <20260930111526.2183107-4-wang.zhan@smartx.com>
Subject: Re: [PATCH net-next v4 3/5] net: gso: support re-segmentation of TCP
 GSO skbs
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
> The re-segmentation added by the next patch splits an oversized TCP GSO skb
> into several GSO skbs which fit the device limits.  That needs the GSO
> engine to group several MSS segments into one output skb, so let callers
> set the number of MSS segments each output skb may carry and pass it
> through the existing __skb_gso_segment() entry point.  Ordinary callers
> pass zero for no limit.
> 
> Without max_segs, skb_segment() groups several MSS into one output skb only
> for a device which advertises NETIF_F_GSO_PARTIAL or for a skb with a
> frag_list which can be split into uniform pieces, and falls back to one
> segment per skb otherwise.  A caller which sets max_segs asks for the
> grouping regardless, so the block which makes that decision is skipped.
> Callers which pass zero keep it, and the re-segmentation path only runs for
> an unencapsulated TCP skb without a frag_list.
> 
> The output stays a GSO skb: gso_size is the original MSS and gso_segs is
> the number of MSS it holds, so a downstream device can still perform
> ordinary TSO.  Store max_segs in the existing skb_gso_cb scratch context,
> alongside the call-local data_offset and mac_offset fields, so that the
> segmentation methods keep their signature.  A zero max_segs value means
> that no limit is active; it is not a persistent skb flag.
> 
> Assisted-by: LLM

Reviewed-by: Willem de Bruijn <willemb@google.com>

If respinning, consider asking the LLM to rewrite commit messages to be
more concise.

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

Not new with this series, nor high priority, so only if respinning:

Consider adding

@@ -5121,7 +5121,7 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
                }
 
                if (tail->len - doffset <= gso_size)
-                       skb_shinfo(tail)->gso_size = 0;
+                       skb_gso_reset(tail);
                else if (tail != segs)

Because packets looped into the Rx path will sometimes have their
gso_segs used without first checking gso_size /  skb_is_gso. For instance
in ip_rcv_core __IP_ADD_STATS.

Additionally for patch 5/5, consider one testcase that resegments, but for
which the last skb is not a GSO skb.

> diff --git a/net/openvswitch/datapath.c b/net/openvswitch/datapath.c
> index 21870341432552..e793aead68372d 100644
> --- a/net/openvswitch/datapath.c
> +++ b/net/openvswitch/datapath.c
> @@ -375,7 +375,7 @@ static int queue_gso_packets(struct datapath *dp, struct sk_buff *skb,
>  	int err;
>  
>  	BUILD_BUG_ON(sizeof(*OVS_CB(skb)) > SKB_GSO_CB_OFFSET);
> -	segs = __skb_gso_segment(skb, NETIF_F_SG, false);
> +	segs = __skb_gso_segment(skb, NETIF_F_SG, false, 0);
>  	if (IS_ERR(segs))
>  		return PTR_ERR(segs);
>  	if (segs == NULL)
> -- 
> 2.47.3
> 


