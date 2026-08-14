Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10FF3B9DA2
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 14:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786716684; cv=none; b=GrGjQjnou7udgwE8+KaUy7W1qbdSpA8itfaD90pGF6c99mbpqfyHI9vr5t6t8y6FI0PDEvA9Km2g+5Ls1ySVEsuQA2cHRCc2+YBjdDKVfL14a0nTyHR0uhzsUY1Irja7Sx8ls9vw+7efOslrSTC8TnN4dr/uRr4eqv8gAq81MOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786716684; c=relaxed/simple;
	bh=esHp+c46NHWZqA28j+A1hShu8h8QA8zkHE3mnLSTAGM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=IvZD1SOyNeZT+X+r1x6uQqq+UHJsJzqtZ/FpSGzfAt85s0TJTcjGg5SV8WJp+zGeD3IlzT8efLQcUUUIqWdkLTu749DZsc3wrug61KMizsjJC/E/X7igKszY6zn8HDHDAByb6w4GkBsI3kCGeJHHzXu5CzhJTXbc2atIocwr1ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N2fyyG4P; arc=none smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N2fyyG4P"
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-669944f60b3so1249542d50.1
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 07:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786716681; x=1787321481; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=a6Tr53R1oyo5DF6Qa5INdwaCZq7w4p85RVWoodqQmV8=;
        b=N2fyyG4PK+eV6k0QED0gabpFP8ZTevaXgAI+1p1WurVlMt1KzCF07m7y79XBGRwnf3
         TI/QK0HyGl9djAfsvktTO/+uEnjhgpFvFBHUjejr43vnNwzFYoxWhq149Fo9kRmZltX3
         4zMKpy9EH3VkslEXO9rKb0aXr0v9FQdAdf2s5OYWjqFMbe5qGbxoAD6LOwoD4+IbACGp
         XFHNMOR8v1leC1CY81LXLBhcEBxOaWpdssEg1IFLam6JfU2Jyl7Lg4fL9JWGodNLEF3C
         KXUXHZRPG8w/ZJcS2HCdZHBkTQVYmNtTxsGXaohjEyfY5tAiUn2Pg2RKKE4TV65iWupL
         6k8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786716681; x=1787321481;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=a6Tr53R1oyo5DF6Qa5INdwaCZq7w4p85RVWoodqQmV8=;
        b=p3E39XnbKp2F62W2a2NY6xzIWcDAfHM0FOvMGMoB3jI19LKYVxilrR9+EK4I3w8DV7
         E/o077xF7qRt/6s6b0ImoLJ4NBHuW8YvDg5ldhOiaRKKHA2FlBUGbbu7IY34s4Vqf0an
         f8HRA7cJPDL/+Y6UQRuV4+8SvKSTuPKS7GUEV/hgkC1+yP8RBtSmKVIp6qmoYXkrOs9m
         kzkGFNsQUt+0Jj4TEWS37vGIR1BEnRXCzkRGDEh0TR1HfpJ5OxsWjWUwb3wQuNAHdFlB
         2CAE3oSLH9VimrRixes9VswJDRqNImOE7F0CpPxuJwGn0hSkoPVQVoL8rkNiAX8PuF7q
         qz/A==
X-Forwarded-Encrypted: i=1; AHgh+RoumUQNExqA/et5L2G3CG8qAAWva/aT+tmhMfCFd2bxb3UDaSuq3oh+KwaDkxjlZPinrOW9iOI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxDkVMWsCmU4AJP/Q2JrYBLnkAiPmS22DH+F2axCCZNZzFyCKQN
	JgvIL0AgQctFEfZY5PN1egb+JwbhwV8ab/Mb4FP82AnPq2tuBz8ZQhqC
X-Gm-Gg: AR+sD12TVM6Yf/53h66jIrG/hcpQzsnn6iPd05YjUI8lm/IkYW3CPJgP5/KO12bWkjI
	OPXzhs4Zg7mwdWc6spi0d+pPncN3gT+GElqGWMYWLN2GeqWy1nfJX5qrv0pgxdDIOBP9ijVxXSl
	HG5roS0PEgF1mjdD5I1xoA/T9KYaNTYLrg7WG2R/SnqvBnnmG89YyalyTN8lDvwBj+RY4mRTBvF
	RLlM9Ov3t6rEgXUmLSyFwOztjNVwpQ8uTOlFkuifDSzCBukD4fo2lbn9AufpelYtDu+XWQMonuR
	zkj8Kac7vP4uBy/fD6muQAnD0aH3hCRMXle+NBM9vS27xdfOA9sMznl8n9StdamlkKQr0iSJI5m
	SZqD3FKKuD8XfI+K2qjyb6ADxRDexi6x4ROgCwYq/PAHS/rHsSiHW6DrM1FpsrG1O6YRsCS645m
	mv5lE41k2msyGQImV7maQlUi5lQk8uPNwJzoDr91gcx3qF4DFTcZmjn7Gm5nwPkTixopR7R5Ji1
	PCsBOw6yE+l06gIUW42sYE/YhlxXu6IPmWPV9QNLKT5lmA=
X-Received: by 2002:a05:690e:1c0a:b0:66c:4163:c4e6 with SMTP id 956f58d0204a3-66c72c75dc1mr2777139d50.26.1786716681408;
        Fri, 14 Aug 2026 07:11:21 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66c79390cd0sm895319d50.19.2026.08.14.07.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 07:11:19 -0700 (PDT)
Date: Fri, 14 Aug 2026 10:11:19 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: =?UTF-8?B?Wmhhb3BpbmcgU2h1ICjoiJLlj6zlubMp?= <Zhaoping.Shu@mediatek.com>, 
 "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>
Cc: "kuniyu@google.com" <kuniyu@google.com>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>, 
 "imv4bel@gmail.com" <imv4bel@gmail.com>, 
 "eilaimemedsnaimel@gmail.com" <eilaimemedsnaimel@gmail.com>, 
 "alice@isovalent.com" <alice@isovalent.com>, 
 =?UTF-8?B?SFcgSGUgKOS9leS8nyk=?= <HW.He@mediatek.com>, 
 =?UTF-8?B?SGFpanVuIExpdSAo5YiY5rW35YabKQ==?= <haijun.liu@mediatek.com>, 
 =?UTF-8?B?SXZlbiBZYW5nICjpmLPlhYkp?= <Iven.Yang@mediatek.com>, 
 "horms@kernel.org" <horms@kernel.org>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 =?UTF-8?B?WGlheXUgWmhhbmcgKOW8oOWkj+Wuhyk=?= <Xiayu.Zhang@mediatek.com>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "willemb@google.com" <willemb@google.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
 =?UTF-8?B?TGFtYmVydCBXYW5nICjnjovkvJ8p?= <Lambert.Wang@mediatek.com>, 
 "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>, 
 "davem@davemloft.net" <davem@davemloft.net>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 "sd@queasysnail.net" <sd@queasysnail.net>, 
 "ncardwell@google.com" <ncardwell@google.com>
Message-ID: <willemdebruijn.kernel.82fd3c4505e2@gmail.com>
In-Reply-To: <ddb39bf238a544cb5c8a178dd0fc6e5cb682bbb1.camel@mediatek.com>
References: <20260813014056.160533-1-zhaoping.shu@mediatek.com>
 <willemdebruijn.kernel.1372b82f50882@gmail.com>
 <0e1f71c4417099399eda78fd2a082b2444e42af9.camel@mediatek.com>
 <CAF=yD-+AF1aW5D5H_QPKE1yxyU2wLxOmT8c2Fm4CJsPY=BjW-g@mail.gmail.com>
 <ddb39bf238a544cb5c8a178dd0fc6e5cb682bbb1.camel@mediatek.com>
Subject: Re: [PATCH net v3] net: gro: Fix nesting of TCP GSO SKBs in
 skb_gro_receive_list()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

> > > > Would it be better to test skb_is_gso(skb) and only skip fraglist
> > > > GRO
> > > > for HW-GRO skbs, rather than disabling it for all skbs?
> > > 
> > > Yes, for tethering packets, HW-GRO skbs are aggregated by
> > > skb_gro_receive(), while others go through fraglist GRO. However,
> > > care
> > > must be taken to avoid packets arriving out of order. I will work
> > > on
> > > it and submit V4.
> > 
> > Oh right.
> > 
> > As long as the choice is only between fraglist GRO or not fraglist
> > (rather than GRO or bypass GRO), it should not introduce any new
> > reordering concerns.
> > 
> > But the decision cannot be made based on skb_is_gso(skb) of an
> > arriving skb. Because when such a HW-GRO skb arrives a SW GRO context
> > in fraglist mode may already have been opened, and it is too late to
> > convert that to non-fraglist.
> > 
> > So essentially HW-GRO and fraglist are mutually exclusive.
> > 
> > > > 
> > > > If treating the features as mutually exclusive, another option
> > > > would
> > > > be to replace these datapath checks with disabling one at
> > > > configuration
> > > > time, in netdev_fix_features.
> > > > 
> > > 
> > > If V4 work well, there will be no need to check netdev->features.
> > > Linux kernel GRO will be more robust and able to handle scenarios
> > > where both NETIF_F_GRO_HW and NETIF_F_GRO_FRAGLIST are enabled.
> > 
> > What is your plan for v4?
> Based on kernel 7.2.0.rc7 code:
> Add logic in tcp4/6_check_fraglist_gro() as follow:
> if an arriving skb is the first packet in the GRO list.
> 	NAPI_GRO_CB(skb)->is_flist = !sk && !skb_is_gso(skb);
> 
> /*
> * Otherwise, the arriving skb is not the first packet, which means
> * that struct sk_buff *p exists.
> */
> if (!skb_is_gso(skb) || !NAPI_GRO_CB(p)->is_flist) {
> 	/* Aggregate the skb using p's GRO method. */
> 	NAPI_GRO_CB(skb)->is_flist = NAPI_GRO_CB(p)->is_flist;
> } else {
> 	NAPI_GRO_CB(skb)->is_flist = 0;
> 	/* Flush p and start a new GRO list using the non-fraglist
> method. */
> }
> 
> Another code change in
> tcp_gro_receive() {
> 	...
> 	if (unlikely(NAPI_GRO_CB(p)->is_flist)) {
> 		...
> 		/* if aggregate method changed, flush current gro list
> */
> 		flush |= NAPI_GRO_CB(skb)->is_flist != NAPI_GRO_CB(p)-
> >is_flist;
> 		if (flush || skb_gro_receive_list())
> 			...
> 	}
> }
> 
> After this change:
> - NETIF_F_GRO_HW and NETIF_F_GRO_FRAGLIST are no longer mutually
> exclusive.
> - In tethering scenarios, TCP fraglist GRO applies only to consecutive
> non-GSO skbs(!skb_is_gso(skb)).
>   others will adopt skb_gro_receive() path.
> 
> Please provide some suggestions on the changes above. Should I prepare
> V4 patch based on these changes?

Thanks. This sounds good to me.

The risk is that GRO might be less effective at coalescing, if HW-GRO
and non HW-GRO packets alternate regularly.

The alternative to make HW-GRO and fraglist GRO mutually exclusive
does not have that problem, but on the flipside cannot use the fraglist
optimization (esp for forwarding path).

So no free lunch. Either works.
