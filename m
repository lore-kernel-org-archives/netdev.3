Received: from mail-yx2-f13.google.com (mail-yx2-f13.google.com [74.125.224.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C8B638B7DD
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 20:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790023001; cv=none; b=QHUUgar5TkapCgrBfVr6ktmdcXgyk1Nqs7ciM1thhrImksIYwrZw8I8DSEQfRzu4mz7tRcLDvOzQtiJ8yViBgBi/EXyoDxs/fxNjIYOrzf2/sQssYnPIOXCW7xB16F1A5MmNRl0od75VC3p2ulnnpVKBcLj1N69/PWp2fv3IxOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790023001; c=relaxed/simple;
	bh=dmEauoCiaAlWlhb1/A2yKF4r4V3fFIH+2z6Df6dyJGo=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=CNgBKLJMw6f4fua01LxTs9gyZa5ghFN72sgO0I0YgcZqBByKCLqizp8z00cwTPNNBc/A4GBgXemhcL38G1PEtTNOWgpKrz9dRj+J77G26e8NqdRQl9j6BYJktx85Cr8hFqtxPgyR3xkMSY+xUU0NQqq7rUy6QKoOoLYfhF55938=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s0hj0DRA; arc=none smtp.client-ip=74.125.224.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s0hj0DRA"
Received: by mail-yx2-f13.google.com with SMTP id 00721157ae682-85d46e4cdccso22086387b3.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 13:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790022999; x=1790627799; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=4o6O2twLKiU2dp3ijpF1x/3M3V1HAc1dKcHv0/luByU=;
        b=s0hj0DRAwSagOm+JJK4sMqjQ8+xN++GLO5YLzzCzEvL2TASX1R2OoixsBvOXHTkqKk
         /kN2ANsFi4fG4GZ78nbCNjv5P1EU+D1C1LjgrUCG4NeVvIBzFeKXdAKsOolfaVRb13Na
         oWC/1znDhSAJXVFSAQcgNOmewERolq0Ej1CjAwm211sYfhhuIqFSFIxdW2ZnDltYNky9
         1nKssklenz1R1QTTSrX0fIHFXo85K+wi0VSdL6w6wX99PJBKbmFv7uezktuOIjSUUaWj
         37ViU/Wdl6b9vHihsLZOodxmedws4jtJhK3uEVbrj0OwFc5oDUu5pjOjKzHGMrYJ2TX/
         wETw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790022999; x=1790627799;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4o6O2twLKiU2dp3ijpF1x/3M3V1HAc1dKcHv0/luByU=;
        b=USSjl24OoaVGkY5PDTogHENtzoIrb5MYoHcrmKrTEOn05A12HTgp+IfmCZcgZyFQ/W
         5GJtBjRCocHtoLpMAR33Vdkl59TiIN9s3pJNOG5tdv40s/gOAwIouV0htKOQWGu7oZ0V
         p1Rh1QDs4Ym56CssNLiernuqQVVbR4VIBaIypm4j4I0gmskLkQZi0v0qJyJO756md0Gv
         XIimDgk6SFiRe8Mb+eWjfkji3ZK9j0lpFfU6OVlVqVQm2/687a5GkI1kr9mgozG+tUR2
         FyoAveN3gfosAOJ/SuFFbDurmbM9Xcs72WzJ10tmzRDyKWCBGVeskXb/Rm7dJ+4J1x7G
         Af7w==
X-Forwarded-Encrypted: i=1; AKwUvBy89WL9MGyIQBGCRF6e54pNR48ZaVDubUPXaJyIaxtUm8NEqAwXGA1bVnETz7iVjtLpx79+DeU=@vger.kernel.org
X-Gm-Message-State: AFuF++lxyy0D55xYbL5nDJ7QXojJz4PiG/cd+M+l3bvbPyVOKt/osfwO
	DmuUMCnV7PJdHAFPEW7x2DAHk1PexjGeXkalNLUlj5veIMrbliVndxpz
X-Gm-Gg: AYBFou0GWBvxPGnh3XObm36KrUUHPIBhVYcRsOABrMpPXdradDPGhYokoDGqPtMWF9E
	aM5vqmVPpklydltPjSFxqq3ZK47n64U4xGC6TaVa9YGqyD+txSc71KG1IzmRF1w198F2bRdB2y7
	EADFu1e0rvMEg9HSqXcQjSmtv4L5epvmJ942AJpgUv7xvb4wqmyvrrfRyYSP2RnWbEggQK0B4qe
	vI9LxlSdcP6u2w7SqYVvDT8kpE6hbWel9cmDKiCiHPnq6a857uBPPaL3hbhzf1lcmD2L1aRZsq1
	bd6SQBQjomkl0g3Ne+uBsYAEQ1QK+poICZhMISIrIwi87/eUg0MAIz0Ak59D7NWMgZ0XHztrkHW
	uXknAb10ACc/e8HV4m2WSK2/sEK9RGTU73C7nxbBmb5n3ntfO7qtPgRZI5MnMHBnb6f6X8LQZiB
	YIeWvSSKKp8MBYaWNrQoKvt478vjPlkWRNyoqH5oJiLkrOl2URMqtl6jrFfjZfAaYXJhTeCx3H4
	h/+W0qmcH7pR+OVpOeOiBdzVfDMBiaili89buMjcU58ueJEsezC
X-Received: by 2002:a05:690c:7011:b0:89b:6beb:1147 with SMTP id 00721157ae682-89b6beb159bmr30196867b3.52.1790022999243;
        Mon, 21 Sep 2026 13:36:39 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8a23fa14369sm1188727b3.45.2026.09.21.13.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 13:36:38 -0700 (PDT)
Date: Mon, 21 Sep 2026 16:36:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Wang Zhan <wang.zhan@smartx.com>, 
 netdev@vger.kernel.org, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
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
 Wang Zhan <wang.zhan@smartx.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 Jason Wang <jasowangio@gmail.com>, 
 Neal Cardwell <ncardwell@google.com>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Alice Mikityanska <alice@isovalent.com>
Message-ID: <willemdebruijn.kernel.2984a0c37a5cf@gmail.com>
In-Reply-To: <20260920131231.3610688-1-wang.zhan@smartx.com>
References: <20260918084651.3022878-1-wang.zhan@smartx.com>
 <20260918084651.3022878-3-wang.zhan@smartx.com>
 <willemdebruijn.kernel.7b2e4c8d0d45@gmail.com>
 <20260920131231.3610688-1-wang.zhan@smartx.com>
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
> On Sat, 19 Sep 2026 11:35:17 -0400 Willem de Bruijn wrote:
> > > -		struct sk_buff *segs = __skb_gso_segment(skb, features, false);
> > > +		struct sk_buff *segs;
> > >  		struct sk_buff *next;
> > > +		segs = __skb_gso_segment(skb, features, false, 0);
> >
> > irrelevant?
> 
> Not unrelated: with the extra argument that line is 82 columns, so the
> initializer moved to its own line.  The call itself is unchanged.
> 
> > > +	unsigned int max_segs = SKB_GSO_CB(head_skb)->max_segs;
> >
> > could this be computed inside skb_segment, rather than having to be
> > passed through SKB_GSO_CB. I haven't checked, but it would simplify.
> 
> I tried it: https://github.com/zwtop/linux/pull/3
> 
> It does read better, but whether to resegment is the caller's choice: the
> qdiscs strip the GSO bits to get one packet per segment (sch_netem.c:443),
> and a device-derived limit groups that output instead - which sch_netem then
> drops, because skb_checksum_help() on the first segment rejects a GSO skb
> (sch_netem.c:538, net/core/dev.c:3626). 

So this is a rare netem edge case we need to handle.

In the hot path, we should be able to defer the decision whether to
segment entirely or segment to the capabilities of the device to
skb_segment itself.

> The features cannot tell the two
> cases apart either: gso_features_check() clears the same bits for an
> over-limit skb (net/core/dev.c:3843).

I wonder if we can refine this instead.

> So the bound stays an input from the caller.




