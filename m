Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92F637B016
	for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 07:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785051068; cv=pass; b=U5jpuADAK+fTDnW1l8+LTWVjwUQ5UNIJOaPwMlac+Z0KAVGgHeWlpwhIevAqhJH609WOAzV3e+25iyK+ZFw0k75K/XlpBHUpcvyQYoHeKQd89kFlkNQNbPt6UGPUa+ofRLpjFbEtAD/bYDl25KKQuLYy9g28IcaOpqc5F8YdUeQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785051068; c=relaxed/simple;
	bh=i0lh72d2nmu3uu3VDQoHujJQG0QNixt9o8QmQUrkaDc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CHecj8tBUd0whn9Qmyz2+UosVT8wGqxXxLXvgpTw1daq2FiZOFYRWBSeGrNDxX/xBpC5bnTN3uv2+ptjg9KWWyxWnQUF2bT4LQ/E9yA5yHAfKCg9m+pKKlSrGPvGzlxvERekuBWhJy3bWGSwTrpDKfItLZJ+qeW7gVtkFb2WB4c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZrK5Lp6W; arc=pass smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZrK5Lp6W"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-848761b5897so989500b3a.3
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 00:31:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785051065; cv=none;
        d=google.com; s=arc-20260327;
        b=PmNoRq3EgGQt8RnYIkNlF0GnTsdvTqt/ocD5q8PDDKNDRSPeF/XD7gFwgDqz6HjWKU
         7B94GALMLpmidFJZ8zr6in3nfDySygb0fiZIltFIPdKfMC0jbEWwoVkgRRba6ll5z8bx
         YBuMeeaqHX1NsxXuOg1TeVh2aDFctaOCXGWd5DC21vVEibqGcTy95yUTBvHG9ftqt4Fn
         YMPT1CdCPYEzFI1MwtP0c16jONNKIAhxG4w5AcUlw7kZrH2S6eko0jOV0xRhb49sBR6R
         XHxlYRITEXagZ4REdAZZ2z9L6Pbbivc+hOleA95C1V6OFmYeALGEIkEJ0+ZD8crCVSzL
         2UqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LZTVSxKYFzxJZaYDAFPYkohl9eRKYUawYCXhr4l0HQQ=;
        fh=PjvDRRT2T/55wM2M7x8Aiz3+zH74VXuwqYislFpXmPg=;
        b=KxrVVL2dIL93TDZfFs0wkgsnkaHw0O4rJ9yYihxyGVk682WSlf42YDDExWS0ceXdCW
         21GrFCceb0Zj94zvSPAtuZ9RrQgKvx4MBWJBKf66yYrQzu4qrKc6Bc6YQccu20+MNHKG
         rQkbi7MV2W+RWZOxdoPOAxHWnNV7VB/Bu2y+JVO+H5WygGzc2/iyZhSu7dhqeaj+7Jt0
         QM9cX1esD6ObRNIJ3d7PEtpyhTMs5fntkA1giYQr0sg0llH6qP1lHQt7t31yRClYRm5X
         +jy86sCJQWbby9iePDcMafaO7QQ5w+NlNz0R8/uFxKpOcdT66JpmjB3xHyfTWSZgx9kr
         S9AA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785051065; x=1785655865; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=LZTVSxKYFzxJZaYDAFPYkohl9eRKYUawYCXhr4l0HQQ=;
        b=ZrK5Lp6WqJQ4AYEUExlJ96qEozJu712C5w53xvpoTOGRL96QqYfaHp2RmF753iN5bo
         SpbMiuR/Rrr6NF/cirypL9oH5ccFJu5bTk5LzZmmXhUqeg7FVeM4fTLlYxpoITkSGNR3
         I2Um1YzhaO7tB+9iew+TAmbV46K8WlZPKgh13IKI/eze+xalGjRmg2DPm7Yb1PTuegy/
         MxmXX75YGz7gvyBYyFHTMjrtevUQ63b9cQ+XCIYw2mH1awAMLl2FHoDGAuf6Q59GTmyB
         e/a4KhMt4VrfzGIH4psfiIcGyicDjqv+g4+ML8pvR1lnV4M+UuNinfYSKlsY9SespX06
         E0fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785051065; x=1785655865;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=LZTVSxKYFzxJZaYDAFPYkohl9eRKYUawYCXhr4l0HQQ=;
        b=EhX/hpqywKq2pIIlwulrO1X0Rn312240aKEQ2OXotpXeHJoupcIcN8dB1kReLL/J9N
         2GcbL8BqQQxTvKavhQ3z8k+dh+n4eh3yPKVjN4TuLc+x0Qjx1fGi4vYox/rT/ORba1UH
         U6FcmAHr6GMNBr+jbsxUblNV6r6fM6hDbVMo4JW0sDkro4vlK/iA5er+Ba/SS026ByrW
         I0PdH9eS0HaRjs1gn3uME5mAgQZ1wk1Sz1hRgWyl6o3Q516muuw815uJKJu+rFMNfVpZ
         9SzZ9Wsf3PBSKtTNgp0WF1yStKHj1VTx3Ih524lyBqLbQbmZ71jwFXdXqVszc7SL0tzx
         EBPg==
X-Forwarded-Encrypted: i=1; AHgh+RpBq0TwpEVa9BQOtG52aDU9VVxEhXQV2J/WJ2a1N5R5IrsDo3nztFATyEo7p49W3CpewYTUJaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhZwyo3I+E/WTFYFr8gEVRjBdrqQIdGBLxN60H8sn74PoBsT0G
	AUJXL7F0ZkBWLyJcGX7bT/VM60MfMNHHe03CUWonmCGDX0ze6tTGNtzJBAAZlMiwQbBK24ysZ7o
	FKX7vp2XeqtYFbSpkr0YaMXd3B5Z/pPg=
X-Gm-Gg: AR+sD12UsmB30Ti6j1hFQD+XIGi+VxdFiTIvkJQuQ4ShdgiCwx5B6Pt8xwywh4pLBMn
	p+v0ejzH8ZQHWyLtxCpFZfdYrpj2QKS8iNivrBnGwsvqd6CXraskcBp2D2SCk6SpfsUWXSdvRkP
	1GO3LvO0g3uwYySLBP80pr0M4TONpBIKn2vNGbQRpvFO7Judj0DLsTsBCG6T06+EaVT/H9Uq4jX
	FcHC8VcyDJdQ5vn3rcmU6lPoie0D84Xsq4Yrz8BRZzOk62ojseX7pqnfKI2oQ==
X-Received: by 2002:a05:6a00:4213:b0:84c:4d9a:ae42 with SMTP id
 d2e1a72fcca58-84e59498487mr3719808b3a.27.1785051064667; Sun, 26 Jul 2026
 00:31:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260523-af-alg-harden-v1-2-c76755c3a5c5@gmail.com>
 <20260603133312.12848-1-freude@linux.ibm.com> <amOGWwdjnJqyxH5L@codewreck.org>
 <20260724160034.GB2032@sol> <amOTjPW__CNZui3_@codewreck.org>
 <CAFLxGvy+ec3nQLrQtwFZgGELhT2pKBDnHdD0pMvEGh-Mf3rjgQ@mail.gmail.com>
 <20260725220443.GA41199@quark> <20260725230922.GB41199@quark>
In-Reply-To: <20260725230922.GB41199@quark>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Sun, 26 Jul 2026 09:30:50 +0200
X-Gm-Features: AUfX_mwtxGS7a6c5QzhlmY01HvejyEPiuukikmfTBc_9wA_H1fyNyxlq8igMsLA
Message-ID: <CAFLxGvzT7jO+dxLSUgw0SOViuV7suY+Tz8m-RE6DBVfF-WbRUA@mail.gmail.com>
Subject: Re: [PATCH 2/3] AF_ALG: Drop support for off-CPU cryptography
To: Eric Biggers <ebiggers@kernel.org>
Cc: Dominique Martinet <asmadeus@codewreck.org>, demiobenour@gmail.com, 
	Harald Freudenberger <freude@linux.ibm.com>, acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, ardb@kernel.org, axboe@kernel.dk, 
	corbet@lwn.net, davem@davemloft.net, edumazet@google.com, 
	herbert@gondor.apana.org.au, horms@kernel.org, io-uring@vger.kernel.org, 
	irogers@google.com, james.clark@linaro.org, jolsa@kernel.org, kuba@kernel.org, 
	kuniyu@google.com, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, peterz@infradead.org, 
	skhan@linuxfoundation.org, willemb@google.com, linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jul 26, 2026 at 1:09=E2=80=AFAM Eric Biggers <ebiggers@kernel.org> =
wrote:
> > You've only mentioned that it "can" be used in this way in upstream.
> > Can you confirm that it *is* used, and with an actual upstream algorith=
m
> > name, and if so which one(s)?  And if so, would you also be able to
> > share whether this is for dm-crypt or not?  We should remember that
> > dm-crypt accepts keys directly and AF_ALG is not needed to use it.
>
> We'd also need to know whether the user (if there is one) requires
> unprivileged use.
>
> Hopefully not: these sorts of hardware crypto drivers have lots of bugs.
> Indeed, the CAAM "cbc(paes)" doesn't validate the key length correctly,
> leaks DMA mappings, concurrent requests race with each other, etc...

Uff, you're right. There are some nasty bugs.
I guess nobody noticed so far because the algorithm is only used a few time=
s
at bootup (as root).

--=20
Thanks,
//richard
