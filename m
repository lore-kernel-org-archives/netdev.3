Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792794162;
	b=wlSThmpr1nKJ67m/e/b3h0MLQXMEmtywO2oi1PYmpfrk30T+jQWaHIaX7xo849ixo14z
	 aWsP6N1l4Bw9JolppfMy2NKlNkFDagHpPymMcEIqw94yM/SwqlNeLJYAJyWWnYOa9HTC/
	 XF5/ThwpM2xIWyUBoW5+si80oO9cmflQT08+tWhYVwMD7PJYVXeT1kjdXD2D7HEQ95ON3
	 Eny99xvpPKicfKEtYdWQfz84Z4j2Eowj5TbgiV2D86dhD8kXpLjVofkdETiKFrbUVVdHV
	 bi0m7UUC7XgFEEQFTimX2SYgwExDX4lp77iY1XeKHnTuvfUl7g3iYmJIHLaCWRqGScw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792794162;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Q1W46OPgAt9joxMOYea2YyHywf96+oj/d/dmNWLKpVg=;
	b=z7JGYUM0vXW6ssJwWmDLgKjfgcA9++/23PM3EFjVX+6TXX/+TBsxMWNH7QNNE8+KXtpB
	 9QmTltol8zhHXk0qdTtMS0l0l0ZnMIGJZ189mGFhdVOWuSw9uVTGyvw9OAz1K17Hhj1pi
	 GcI3wagR9fF2uFHTBe1XWyoftf5zHDf7v0MMaEaOcq3XWIs27lkAupIvIaQayFO5Pv4Tw
	 gVRf2gjm/NeOqE1Yv5zsHbGTl6VK08Vc3VZX5JLx9GSZzxZJb9MXkRizkVp0cuzpspMi8
	 dCFEUjWaISIVEb+VJKVB0CJWGk1sa1C+1gOXB44uGcBtTTl2Nnu9gKXRtMNTol0/i5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B8AJ4dmu;
	arc=none smtp.remote-ip=209.85.217.54
Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C332606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 22:22:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C332606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=B8AJ4dmu
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-7cc53938a8fso872670137.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 15:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792794161; x=1793398961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Q1W46OPgAt9joxMOYea2YyHywf96+oj/d/dmNWLKpVg=;
        b=B8AJ4dmuWlT9qXcFr0RWPFPctJWRBGNbSnvESvPKmb7FkIA42fvQhOw04ibYOGRQW2
         v0yehyndQU84JxpP+DoGlWW1+fG0WPLjkB6NRsxHFhY5H3AlA1Hcn4A4X7N2PCk87dYG
         59UIRwgPaip/vHWNiuigsbsvYwclp8kpzLqAt6C/HzHK8Gi3lFu84xaHI03t/7oqcakx
         m7gEUN/ct6ckInlmaTdXCx/Qa9MQhZi3M8zAVXs6DgXbxzJiCd056FdFdbQ94082LL+g
         rcpV0+Cc3OA8fPMeVtnd0bnyRA8wH17JceL7uTRLL9/9kfb+yiU0crqcyxt4hX51CWuw
         Ms1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792794161; x=1793398961;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Q1W46OPgAt9joxMOYea2YyHywf96+oj/d/dmNWLKpVg=;
        b=gtDZFGHMU/K1AbxSix8XysY9zFc60Durr6twgWb0agVJ8PHWU7U6P2/5jqcsUaZDM9
         xFGrutqmVTZoCLnlhIx5AdXetQ4NjqoBhzjI7d1q7NxMWCzJ5fy+mTmyiy9Ur+3Veyh/
         df3yMFgY728xEfDmtGPTxUC3xNkBKR9wpXVSsreUr52Hiprl+LvUXqJYfsXgccgASMmc
         6KBXvUScxBXiTUWkZeCtAlO/LV73rsb3dlM7TO4c2nBX1zbrC7rG63G20e8v7rbcd2uv
         eiG5TfCmkNHtN7wpXBXQekOyDqOoI2oDyrIcoFc/snSMbDjdLv54SkbNAUCAs5FVHmGs
         /dEg==
X-Forwarded-Encrypted: i=1; AKwUvByD7j7XtwkGsg67g0LpOr9Sd+gUHHsiGbOPduntrnTupqzp1YSc5zLK38gIogOukewujVV4mXg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLquBGLAXTxCktcCKSCi9HjtaNeF6iUEB3bpqrIXlelns85G8PA
	tb+i06QMYBXq3YkSLmPMi75p3It/9MdHVpt7X6K6tecqM2y3TjKwL9D90tQn3g==
X-Gm-Gg: AYBFou0MgHRU79Ja8w/6T3Ikfei1NRHBrZmcmfw6AOLRjzfbvJ2eIC1I8gdBDLvClW5
	9Qf+f5S6h1hHv/Kv4Ce7qrUsGEnMWULH3Kf74dHjRwYn4QHmuN08P8W0bCgCcuGHtBktkdnK4K3
	gOkJT72Ss0N7MptG8ROgs7c8lQBoLPkYKZdnmJGPdWb616wPHrXi8v51/jRHi8QnCki9rHdkmok
	APhj0abHpjj0N+oB9MECIp8/ZxF2qZMJagl3d9gYVDeQ983iiZJwtpIi5XHJ6VSuDAUTdcHX8m7
	kv28CG58FCSKcv+mnfaQGtaWnaUU/x8N3Z0/4i3Ry+HfJsbJOWaKaDG2SHHCq+PoRkP1e78d+Uu
	FtCRwVl7L1dhAw+zC1zslxeyeD1tJ7iVEwGQ/LjHB/kXXC5V/qVZyy5KPl2H6hT8rduMpgbQ7zg
	LYLiIiFPcIYZLA9PxtMW/Fuv9sxjRzA7mRyhzS6+aZuiP8U1/lLAV7wx0+aHsEPGIW3tl5W51Um
	cpsueiIyfgvwFAwWWtiI5uhpGrPVjUNUgr0UFva66LdaEaJFlNSvRKSms6X90v2dZJPA7JtsFl+
	X1TQItEgN3dqwPxtg92GWzKl1ySXRMd7ljaWPkehqA0+7WI0PEN5b6n3VXTdWkMYgMJF7yUc2FE
	I13DhC//07/EPVnPchBo=
X-Received: by 2002:a05:6102:605c:b0:7a4:da60:acfb with SMTP id ada2fe7eead31-7ce5ccbf6bcmr177737137.8.1792794161075;
        Fri, 23 Oct 2026 15:22:41 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-9910e80e2d6sm812613241.12.2026.10.23.15.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 15:22:40 -0700 (PDT)
Date: Fri, 23 Oct 2026 18:22:40 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Rongguang Wei <clementwei90@163.com>, 
 netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com, 
 jasowangio@gmail.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 Rongguang Wei <weirongguang@kylinos.cn>
Message-ID: <willemdebruijn.kernel.71ffde9540c8@gmail.com>
In-Reply-To: <20261023092239.186665-3-clementwei90@163.com>
References: <20261023092239.186665-1-clementwei90@163.com>
 <20261023092239.186665-3-clementwei90@163.com>
Subject: Re: [PATCH net v7 2/2] selftests: net: add TAP socket filter attach
 tests
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

Rongguang Wei wrote:
> From: Rongguang Wei <weirongguang@kylinos.cn>
> 
> reattach_filter_without_user_buffer() attaches a filter, makes the buffer
> the program was copied from unreadable, detaches the queue and attaches it
> again. It then attaches a second queue from a fresh socket, which starts
> without a filter of its own, so a clear IFF_NOFILTER shows that the filter
> was installed again from the kernel copy.
> 
> attach_filter_bad_len_keeps_program() checks that a TUNATTACHFILTER with a
> bad length leaves the installed program and the filter state that
> TUNGETIFF reports alone, and that a queue attached afterwards still gets
> the filter.  attach_filter_bad_prog_keeps_program() refuses a program with
> a valid length and instructions that bpf_check_classic() rejects, and
> checks that the program installed before is left in place.
> 
> attach_filter_nofilter_flag() and detach_filter_clears_reattach() cover the
> ways to attach a queue without a filter.
> 
> Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>

Reviewed-by: Willem de Bruijn <willemb@google.com>
