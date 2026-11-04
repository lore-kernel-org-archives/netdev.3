Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793760823;
	b=B/GQ9M6b2O/b/cCe+/wmlZF2G8mW2DL6J4si3CtfSworRWsVkAOJD4YZqs/J0YOdetWM
	 WKl/HhQ3BkPE73Uj3gEHtc1O8yHIGq2SSy4IsIatyvTq/e4tuNxz1jRbwfBW93hCYdpzF
	 FiOGCCqiKHWGjRadvY84C1hVcVfaIOzb/cjQSDZdeUmdqQuYxu4DuKroF6QENEcPZh7eQ
	 JTixmrouci0hgYqgCgo7Bsk5Fj/NOe3ZnPPa3g/H9Lgg39bBYNy24Xtad1RKL4rquWiGz
	 tfPVdE1TMAPTeTV4Hbl9ATJViqekOEFVjaIN1jvIvAKdhQOpofcIoSr906ct6TKnDjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793760823;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=pzzn/OZqyWunDAXh2LnA7PjhOwzn2ho40vKo9gOv0hI=;
	b=ymxJE+gZ+Mkgao7aJVF5IWfo3k3pCOT+Ua3VxK7p+zfelglV8jR6Xq048scf5vK0r0T5
	 Dx5qXwGfF5GhIwBJv4xpRi368BQBuO9AfpzrXbSrbuKIrjmNcaOv1aao+eATBRqBpMYID
	 n32bimTgEVvJtTCO/LH5f93glpmxK9cuX7fWfPotaeM+h0ukpuUBWQfPlnav7KdNtJRrw
	 37j4PKSiFlc9k5QgcxjeNgH2Y2MvkRKVwk4dBRXeuw41GeGteJCwOl8f21dEGSF2l2Vsn
	 JQHxL2poLBhf30qdzSN8CBLEUOcU7+oOQdXk045ENQ0ZRjN+at+LPbNUwLgVtjSxGgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="zUDe5I/W";
	arc=none smtp.remote-ip=209.85.221.170
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76200606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 02:53:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76200606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zUDe5I/W
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-5eac319a6c2so157097e0c.0
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 18:53:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793760822; x=1794365622; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=pzzn/OZqyWunDAXh2LnA7PjhOwzn2ho40vKo9gOv0hI=;
        b=zUDe5I/WZ7Q+PrpPiWgFiejkEgveefDT3+axKAQ/l9lnrzmh5PwsPKBx/BBwVec2mZ
         z5NrQhyAAOumLo/NowxfTJ8NZi67zgaqeFpjRzJfcIJe7ETrYikRPmVsH1efhYLK5tXu
         HRbdP/KMLyk4HQv0cokt676vpVYNHljY7R20nW0GTk8ejpQQtBxE/LtAMCXdagNC9vcO
         4dwP8IvkAlgnD9RETvPAAP9jxMEMObrm+KXthwZbAcJ1FihA/skfTrigKh4Yvi/pA/y0
         3MSO9OTGptD7Wcq/doJb9udkyPrKpHVlVD624D+O2o2IBBQWEfzzTSSgwfzYouImRzxo
         AzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793760822; x=1794365622;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=pzzn/OZqyWunDAXh2LnA7PjhOwzn2ho40vKo9gOv0hI=;
        b=Ba2MoncGgFw8/Dna6h4ffUChfNMSa9flAZe3QUzq23ZFFrJ2DVtnf1ffFDaiR9Jb10
         UcJMrybwJfNgCHLE302QscZO/6ynPln5jNlwMcSTgDe+07+aFwGAZd2FjGTFwRbMdHVB
         6tQNr3uSDO23j/4pPDPSIjRtO2r+hgjaaRTZSy7s9e33ozeFeqhpHyNN3E2ihksi9JlV
         H9FCXTy7POPWfJwHXLe8HeAmI8uFCvQ2TVEMIUIXf4iWxQViN1g6S3TkMPCtrFAJyZ8w
         fPx9sfOT+r4AYWWAMtUZOuM+Uj5kkocHX5F0bp5BPhp+OSgae3ZEdi64CE6cM1dp0YWD
         sn4w==
X-Forwarded-Encrypted: i=1; AKwUvBx0akmzm/F/4i0dYEgKvxR0vzY0KvIcitNejNQy/PBMJf5IihVwb1ppk8lfWFmn7BiBxvdnVlY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/0CwMQNHYL6yaJUoMKDLipb9Jo1l68hbitkJBf6lmv3js+oT4H
	m57pWJilu39gPBGkNV0hcxXkFDKbXU3LoHVaLctFyKeK0MK4CNbJl17I
X-Gm-Gg: AYBFou2pkOclfBZ7DER3LvWtjyELw7V+ahuepRCTz4doaaLq1qt3ILaNqgR0o29/njW
	G5MYbTyRrnGmqI/5nYu86sAXpibiL1qhCDz1xdmA7XR/LDCE01zToPtKTCSbrftETSIY+mgrOsq
	64CEos/E2AwD3g4tIcUw7lGdiNkPqBSldrYUI3744bowl2eyCVEnasiAQWB8dZbE9B8Tf0x5dPQ
	4X4m3z4WLehi0dQqllMytuaqlR2kKoAA9y3B2tsjc+5aQ0NSmdMdRYCIfyENLxgjDb1NEau3DBR
	D+pCSsBcrH4t8wDpdtsOl70v/vUkIQF7nPBFnU92aAECbEil1sDpupMU++vKGeNn0WM1A4kER+z
	FJpZxVfjEIE8l6cs1wyQxkxsL2WAMV3ExA0wz7QbIIgY4V/JtDCPLflcwfCJ/7o/nP8U0QRq++K
	DBp2yx7Rjczei3J1l9rasmRuZyUjeEaU2QLNEdLZDIGoGkFqhobJFTMGeZ7Gu1kPZw+4SSBqEsH
	G30PeuY/fkq6FyOw0a4h7rR8lntGVdAtefPtITi0be8fdRHcciUKVtxW938tvGOefS0DZUytNCM
	E5xcRv/3epgB+OqMIQwfUULfwj1MZGQcHGLuy44ejdLVJfUCsfHrMbb+qoX26tPSfdQp7ngLMet
	B2y62NVrU2O8OY+nsK3e128Dg5NOMoTk+MpJ7pX+LlHxtsQgI21hnnx87pcACBpjkz9A6xl88
X-Received: by 2002:a05:6122:398b:b0:5ea:ddfd:3e99 with SMTP id 71dfb90a1353d-5ec68976e2amr6444630e0c.10.1793760822398;
        Tue, 03 Nov 2026 18:53:42 -0800 (PST)
Received: from gmail.com (223.230.150.34.bc.googleusercontent.com. [34.150.230.223])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca8d9fe6dsm681849e0c.9.2026.11.03.18.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 18:53:41 -0800 (PST)
Date: Tue, 03 Nov 2026 21:53:41 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Josef Bacik <josef@toxicpanda.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Fernando Fernandez Mancera <fmancera@suse.de>, 
 Mina Almasry <almasrymina@google.com>, 
 David Laight <david.laight.linux@gmail.com>, 
 netdev@vger.kernel.org, 
 xen-devel@lists.xenproject.org, 
 Josef Bacik <josef@toxicpanda.com>
Message-ID: <willemdebruijn.kernel.6099d613565@gmail.com>
In-Reply-To: <20261103-b4-skbuff-bug-on-followups-v3-11-54ad0ab57614@toxicpanda.com>
References: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
 <20261103-b4-skbuff-bug-on-followups-v3-11-54ad0ab57614@toxicpanda.com>
Subject: Re: [PATCH net-next v3 11/15] net: skbuff: don't run off frag_list in
 skb_segment()
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

Josef Bacik wrote:
> skb_segment() keeps going until it has segmented head_skb->len bytes.
> It takes the data from head_skb and then from each member of the
> frag_list.  If head_skb->len counts data that this walk can't find, the
> walk runs out of members while it still owes data and dereferences a
> NULL list_skb.  There are two ways to get there:
> 
>  - head_skb->len is bigger than what head_skb and its frag_list hold.
>  - A member has a frag_list of its own.  head_skb->len counts those
>    bytes, but for each member the walk only looks at the linear part and
>    frags[].
> 
> No path in the tree is known to build a GSO skb like either.  GRO
> flushes instead of chaining an skb that already has a frag_list.  IP
> reassembly does nest frag_lists, but a reassembled skb isn't GSO.
> 
> Check list_skb in the three places where the walk moves on to it, and
> fail the segmentation with -EINVAL.  The KUnit cases in the next patch
> hit the NULL pointer dereference without this patch, and at least one of
> them hits it again with any one of the three checks taken out.
> 
> Without SG the payload is copied by helpers that check the length
> themselves and recurse into a nested frag_list.  That path still fails
> for a len that is too big, and still segments a nested frag_list.
> 
> Found by the Sashiko AI review of the BUG_ON() series.
> 
> Link: https://lore.kernel.org/all/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com/
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
