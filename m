Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CB249CF58
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 21:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792099606; cv=none; b=fo5sdcM0cjIe5VMQ+H5ciT1Y12ljZMvGDiJOws+AhGR20A8/bkQyfz+w06w8J1sxE6zDzgumH2u9R4Rb1SImx6liF2A8GCUSH7d4J/vM6n03+6UYZD9Ovs7/k2FNQR23yPRDAP+LANH9fdBWMRcWzjYAW090WTbMigQC/U2oi0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792099606; c=relaxed/simple;
	bh=QS86cP2jeKO3QD9IJvJ0mNN/2zilA88TzDA5iVLys4U=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=ic4LHIuIBy+1hvi4ayn2pTafWfXXxSj3ONVberjwdd6e6XxmEwRGadEk0UIWsx19j4OKbRqBwgwiYjXqzcfmbDzUDnwUia5VGaUmICWinbiVU2mc5H2yhUSzY3ageEH+c1DhFct3jtvcwwXfXvJV6YkSqcXJpZcxHOFOMCIvw08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ijVAN3wF; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ijVAN3wF"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-9906a5410f5so433976241.0
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 14:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792099604; x=1792704404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ec1N28EW3e8V/XLxfU8wagiB6gXU9eqk+o0V3gsUUvM=;
        b=ijVAN3wFzD174ru+cTLi+6Y2k25KLb9t7alD3m9iRWaNsh3qG7/lXhG1PdGkhV9EaA
         Oqda3YGpK2oOBWAls3vwTFc0QpTQVmtlIsAchjHrHXSNzpXxx15i17O9LiZcywiDo8IL
         1cN8U+K0XcJkKdQiScTc0ZZai8OSfqOfe89eaWluq5TnAoxCnsxcdbCHHa9LYXbkQh6E
         EIH2vpR1jRQjRO7tKb28tIi6AubX2+eNV+R2Te7+uOLIy3AzAH25FtEN6rasEWZXaTcr
         GQekDkA8RMuttajYBt6ykyqtXZaL2Sp56+YlozkOe7rZtaY45hxNNA/WxiqbOX3McYiV
         7LgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792099604; x=1792704404;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ec1N28EW3e8V/XLxfU8wagiB6gXU9eqk+o0V3gsUUvM=;
        b=TC3rCXy8UYj9HjAL60BUVg1FFgtU3CaRbd3ayz5CPY8oxJORA2vtKd4DY3loYDUecY
         Qlbtx3vg4gL+6xb69nw3bFFW87mAsPKs/91t5ICllWC8Q4NB2yZDUEcVeDchX3RIybDy
         sjcAOdNFzJcup2WNh3F7nogb4E+spfybfbetBn7a0+3cQJKAPcCR6cyhJHM2vugOsGtD
         YqHyUDFYgQhhILyxZXx7KZWL57dzHIWldzPag0D9kfmnKKwU9yGGD9c/45MRw3orHwXI
         gG1JBFIy5pCVg4pbvzqsR+dSOGhlRcH0qEBI//oXlznyNIp22a1U4wsZnLt5+C8P5kox
         grPw==
X-Forwarded-Encrypted: i=1; AKwUvBy1US92+oGrxKeYWfsazYe8uJeVmB9yF8yd/SKzwybZiGlEOKKcOAVnHyXxzgnUzveblam0XWU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJxncR8nRISYPV3o4IxV5R2D3WfrNDt4TqcT0jQVbSnhw4/7oOr
	NvRgZ0x0kiihV5VJuFARgdbnr5ET/iou7s4dPAj/qKcEyedOyTMLSvxHBFsp5w==
X-Gm-Gg: AYBFou1OPznP8dajEBTGCqDO/GhZmy+daOkZbDtW2DFq9R5x05IEAm+GV84pxBdK2fx
	WDuwSVjJyxEx2DmVe9XZDeOdRxY8uWV6yj1Rsl6z4J/Qrww1qgtQ3SwCMwLjCj8jFuDeAWspVwV
	dj4u13pfNHEz2GAMMRnCLjO3SkVWUYp0KtZOcGieNrOC1GcKFLUwWTgd4VcM/8nl6JjCIQKeUby
	fIA5LqBsRANsHqD7RMTfGbjW9aRKYVqwr5U2ieew4fHo+jqbtWjsLo/5aGjxzA18uo2w5SvOVfe
	+y6wtrHDO+88shYdCMEp9EZe2uB4iwOciv3MjEs7jtrNdtyzevgnX3IwleosE3a28EeUmbICFV1
	cFOmdY9K1ZOAuUmrW3QkQ+93pJf5kQ6IaCPYStpoZAXiZPk6cbR+rBWtef8dmbWJbp6yLbLANYf
	yMbtkCuu/Tz0G5vm+PTHPYKLhDcbhgKjMio3B+Pa5dkDfbIyWyXGfo8OMIgYee7LfpXC8KOdVqg
	bqMUto5lI5n13SFLoDIoiR/9enSjKizr3BKDzFjy5NKwPbAVJb7d4N5aR1CowCy2qOkALIAN5Ud
	negymIlTqsleBR0si2EyShXd1hYQG9H6I1uXvw==
X-Received: by 2002:a67:fe55:0:b0:7cc:a4b:b0e3 with SMTP id ada2fe7eead31-7cc180c844dmr328649137.13.1792099603741;
        Thu, 15 Oct 2026 14:26:43 -0700 (PDT)
Received: from gmail.com (111.46.245.35.bc.googleusercontent.com. [35.245.46.111])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cc1983af93sm750073137.8.2026.10.15.14.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 14:26:43 -0700 (PDT)
Date: Thu, 15 Oct 2026 17:26:42 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>, 
 netdev@vger.kernel.org
Cc: memxor@gmail.com, 
 Willem de Bruijn <willemb@google.com>
Message-ID: <willemdebruijn.kernel.24e409bbd8822@gmail.com>
In-Reply-To: <20261015151033.591439-1-daniel@iogearbox.net>
References: <20261015151033.591439-1-daniel@iogearbox.net>
Subject: Re: [PATCH net-next] net: Port skb_segment tests of the test_bpf
 module to KUnit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Daniel Borkmann wrote:
> The old test_bpf module is going away, therefore port the two test
> cases which were added in 76db8087c4c9 ("net: bpf: add a test for
> skb_segment in test_bpf module") as well as cf204a718357 ("bpf,
> testing: Introduce 'gso_linear_no_head_frag' skb_segment test")
> into the net_test.c to retain coverage. With it in place:
> 
>   # Subtest: gso_test_func
>   ok 1 no_gso
>   ok 2 linear
>   ok 3 frags
>   ok 4 frags_pure
>   ok 5 gso_partial
>   ok 6 frag_list
>   ok 7 frag_list_pure
>   ok 8 frag_list_non_uniform
>   ok 9 frag_list_head_frag
>   ok 10 frag_list_no_head_frag
>   ok 11 gso_by_frags
>   ok 12 resegment
>   ok 13 resegment_multi
>   ok 14 resegment_tail
>   ok 15 resegment_one_mss
>   # gso_test_func: pass:15 fail:0 skip:0 total:15
> 
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Willem de Bruijn <willemb@google.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>

Thanks!
