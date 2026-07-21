Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97745367B63
	for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784669313; cv=none; b=shtssD23KrUtxg8YasS3BKX5eDj75UhDUsaONYtKxVx1wm+yBpjSIjqTLWETgJSEGah7C7cUBEmqTxsFB5S/vgVP0Wo0M3vYwBbojVrqAnU47A+d/pfDK7wMEUMw3PR3xNHqN48jy35PoUJgYg2HIWZKgX3LLEQHDN9rGz7Q4D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784669313; c=relaxed/simple;
	bh=HboMcYGMtnD56tcUaSlwCUoEiipjssw2OLR1zNCFDEM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=rigOljvR8Tmy9PsvVBTT+dYoCEQMqVzz8KZocUi+RWqBpCsUmwgXBOHg6FfRkc6sDXsvqjUD4KB0Utszl21dmhurO6SaWA2ITUCurCbQSYd+SRqXv+GdXSQDTaXNHembYqMtSJEQXto0Iwt4iorM7QK5eRQwm6gQQ19OlWWqFPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pUV+NYwp; arc=none smtp.client-ip=74.125.225.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pUV+NYwp"
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-495501e57beso10920655e9.1
        for <netdev@vger.kernel.org>; Tue, 21 Jul 2026 14:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784669294; x=1785274094; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=HboMcYGMtnD56tcUaSlwCUoEiipjssw2OLR1zNCFDEM=;
        b=pUV+NYwphf9W445DN1dJ8R3tBAAlnimDF2jzWM4LFDLgMIk2coiFdwV6nOMaH/j4nR
         yRX5WTIm9cl9Lcq6LRADdGuMbB7p1ilkLzSeIv/VODL2aZmI37hOqj65yBVjlwKotPlu
         Xp/E+iOFVjjjovhtTLzn6z8bJm3miUNInYu4MiuGmA61k8C5OiatalU+pewLxnWjVbkz
         FMVTay5ZpeZnn9thVldb9Zdrko/tmVe63xZ9Znuyrl1gpNAV9uhSQc87UiuCbIbhtWQs
         Wb/pL4inyH2FY0ZFbHsC4g+Fz6PLFNQlZDDckriFnm3y3GHtrgpUu7DlCfKji3JT62Do
         jh7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784669294; x=1785274094;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HboMcYGMtnD56tcUaSlwCUoEiipjssw2OLR1zNCFDEM=;
        b=EGRNGpVXiTSNQcrwvQGPkH9785eNorNNRpTSaDZ5p8iuw8rICMy+iKi0zq6LK+XCxi
         DGD1LKYz3vt1syi5seMDfk4EMFf4DkeF3SmlEs9flIMnsyfKIaImCFaZK0LoPuUanUZ8
         zAp4+51ARe6i//EcVQB+949FOwx4SRhzkHOo40NmoJHNW9ndpfuu8m5fIvVcnaXP8F5w
         Hl9SDtj92Mawv59EZcrBGEUtP0hqyxPRuaKiyCKyJJNoBaK5lAsbV72Y2lQYvKpW9PKM
         ZOYXHxhCXAxTzm3nXc8pv0Zm1ulHDHYIcDDZwU46DA1eyPurj1cjTe1sauUzON5PkbaC
         RBMg==
X-Forwarded-Encrypted: i=1; AHgh+Rpf2HvJPvl4M08mrcrIawypZOYVjRB08uRrUVJFBeT3S1TyCJ+otwikSWDPAUsdo6spuPH1gkY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLgGDH9juP199hNVglXHMUA0ZN4gsjyOW8/kU5lU3HK5X9pTe7
	2lzJWRzNrO+cHVFEjgrVJ5KrOUUtB+OhyQNeji5/NvHeIOF2uUkGJBd/
X-Gm-Gg: AfdE7cmexAqren0Iq1INmUtq6V4u68LkGBQXyAgehDFMaUFlkrjStfW0bVeKe5BvIhw
	DgGxlLF7eh7jo3pN7slopncfYFo/0D3Nc2daTc/kVrMqRAtRMXHOTJ9fb+5iheK1oCBJOsJZtsY
	tro1MANzOiNfMHDlsA5A/qbxRNDZe2x6q8jqmS66A5wD8i7cpyv0ZnpG6jaz1QzQFnGCXn8+iHS
	9nRluOr/bXE86hVk9fgCCE+Pdfc5oub+xT3lWpEOZCsi+NE0xoN8DmkfaqkgEjrgYEWSDdCkT1V
	cvX109wZhRrZ7KxtE6evSEqNa+gGr8V2iN6lLiv178BzJ0ciPZJtcwsW+upO4SvThcKqt5ajRUW
	T4el9pjlKvVmE+NCIBgYSDp9+LhNWStNdSrH67WTzDUBiMzpZVpejitGHwfuNO35QiD6DYzz/GZ
	6qBofvpu+FBkAkpyfLVTwgrEP93s2WsnS/nAEIk6kbk2R+jc+KmGDtaT9NjSCNpLruEWMQK4wO8
	j2QbRSGoby2QEdZgQVdvIrnCbVQF7WuhmBBHDRq6br3
X-Received: by 2002:a05:600c:4e94:b0:495:522f:d994 with SMTP id 5b1f17b1804b1-495522fda7amr177340205e9.0.1784669294194;
        Tue, 21 Jul 2026 14:28:14 -0700 (PDT)
Received: from localhost (nat-icclus-192-26-29-3.epfl.ch. [192.26.29.3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-495653698bcsm87109195e9.2.2026.07.21.14.28.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 14:28:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 21 Jul 2026 23:28:13 +0200
Message-Id: <DK4KGR25SLFD.3S54RZY16RYQU@gmail.com>
Cc: "Matt Fleming" <matt@readmodwrite.com>, <ast@kernel.org>,
 <daniel@iogearbox.net>, <andrew+netdev@lunn.ch>, <davem@davemloft.net>,
 <edumazet@google.com>, <pabeni@redhat.com>, <horms@kernel.org>,
 <hawk@kernel.org>, <john.fastabend@gmail.com>, <sdf@fomichev.me>,
 <lorenzo@kernel.org>, <toke@toke.dk>, <bpf@vger.kernel.org>,
 <netdev@vger.kernel.org>, <stable@vger.kernel.org>,
 <kernel-team@cloudflare.com>, <mfleming@cloudflare.com>
Subject: Re: [PATCH bpf v2] veth: convert frag_list skbs before running XDP
From: "Kumar Kartikeya Dwivedi" <memxor@gmail.com>
To: "Jakub Kicinski" <kuba@kernel.org>
X-Mailer: aerc 0.21.0
References: <20260720140545.461747-1-matt@readmodwrite.com>
 <178465260565.839953.7972365481675163007.git-patchwork-notify@kernel.org>
 <20260721141438.0b7a9594@kernel.org>
In-Reply-To: <20260721141438.0b7a9594@kernel.org>

On Tue Jul 21, 2026 at 11:14 PM CEST, Jakub Kicinski wrote:
> On Tue, 21 Jul 2026 16:50:05 +0000 patchwork-bot+netdevbpf@kernel.org
> wrote:
>> Hello:
>>
>> This patch was applied to bpf/bpf.git (master)
>> by Kumar Kartikeya Dwivedi <memxor@gmail.com>:
>
> Kumar, this looks like a networking patch.
> Also the kdoc is missing a returns statement.

Sorry about that, I had the feeling it should be tagging net instead.
I tossed it from the bpf tree.
