Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 920D63BFACC
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 14:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785767990; cv=pass; b=o3IyvheOtN8zLbjJcle3izfmgNPhhg9AI2ASlq65JMvXgYAjQIZbN03LV/tn5NO6OI0+PMRetTZIk4rwZ7YJENWK8D50bd4LHTApirx628k4s99P/hUGz6lbGXHHQ8Mgs2QVPeKKv6MReLFk4SPD1hkp6ENou3y40r9DUPtqphE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785767990; c=relaxed/simple;
	bh=CN2tqOeF18mqBmxa6FYRH35DCRAH19HtnfFGMYWnYXI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O/BYhUDvkOhsKWHA1UXRt4s8VJ410Mqo/E4NKMruJfAaGSgdn+ZDLgbw5IjQ7meKjRHXIUZszFK2vidl4b1DFAZSZyPcoXgUzhr/vwtTa/rJDsjPKZEf1FAxSI7V+kKWR7F+ECsBNC/U8V06p9MJoeer63ca2leufvpdZJFqIEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n04UzDFn; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n04UzDFn"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b15c6fb864so2889111e87.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 07:39:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785767988; cv=none;
        d=google.com; s=arc-20260327;
        b=AWjvFQbXXf8NcxR8VFDhXPlELNMHZ124CT/a4b13P7nW90IgtiXBqVElfLvi2v2EEA
         iT6xMt1qlb29hXD24s1qcm+DKXcj7t6xWdqI3I/rddHGkszGru/wu4nPn9mkcARcWnJo
         9PINaSP+QIWy8GOGzMhO3VrbM0aYU4vU2r7bUxoz/bV+lqzjzMKFPtJ0pXzB58j3pH4E
         F5S+qiwPHPWDxfmqAxFDgu4ZLggdNNKMOcj4jFz05+stNn9HCxTcGV48MLSBsyrejM0a
         jnBI8dTlNKZjYcN5upySB0ToBTkXp8QWGCvC2Bv/zuaaamHnQyWCOrlLlFazYELlZqDF
         /AEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=CN2tqOeF18mqBmxa6FYRH35DCRAH19HtnfFGMYWnYXI=;
        fh=qTJ97NipnjeZk7+Mbp2EVEbFd3npwi30j1ohFCtHkYs=;
        b=l1xI8MORj3pqN8BMiyqhJmQYPRmcGMhnwsLpI2eaPAtDGckmMJRSrdhEmcVxnMA0uB
         em/1MYvd9T0TTO86SbjHad4JXiaq9CsxBShl27l7v9Cheutg066pasuCNcBM90fy8MsM
         jFF2yF6nCn1IwBHWbLzzOMOQcUq+zEenVt2SLviM+vrRmS2m5NkXMG5KXjUw5cZ5IpiA
         n3deTZeguyW0BB99L6FJEV9TbLF/vYJZ4jIhTHVj8n3h1J7Vkp0z3jiYV3+0jmKThEFU
         Q7pmDnk90YiE2U54NO7yl9qqvgHv/TDptMNfzE3B26NiB2EVrGaBaemE1vPuL5RMOMWP
         lV1A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785767988; x=1786372788; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=CN2tqOeF18mqBmxa6FYRH35DCRAH19HtnfFGMYWnYXI=;
        b=n04UzDFneZd6D50JMRVNcbTPJZg5Q2qyUH3kOtk6vjf+0+EScPbKDiScsyCTMuy8JU
         LUqOUdzT85zv1GOhlQhDT/Eb7+jRWP6cWpQMeqIPnqdM6WgkLujM48WJSBpo78H6Zvk6
         1VplOpJFoaKkpQ675IEr5giLvEAHLEZvDe5zyjS/TQh0bU3EZp0XUOuccwz0z90jfScT
         TAl/wHeYXLkXfU6GLtM2AwWc1VKTjygfk6efmmrWFk3UjUFtxAgJcDwom4pEIfj1qLe1
         L3udC9TOwyzlFhFs4jp2g1lCIWZLCckMbulBrXGT7x36ib4/GJ00q7Kchl2MRgZX1sGW
         7bZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785767988; x=1786372788;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CN2tqOeF18mqBmxa6FYRH35DCRAH19HtnfFGMYWnYXI=;
        b=O8IDAKXmRW3g0myu8BVC+UMdny6GKHUOUBJeT3a78wu5pAVwLs7PeMW8u9ZPbkEAsx
         GsJihTbxejltmaU/ilozrwJ8mrwyRZGPVpK+uEUUQvWLAIvj2EWnvaRJSzzi8wWrHtup
         TQFlVL0eYJ0vFTVqA5a8C2+pgkz8eVj95PhgkuS8fohD+lwJR2cufzwR3akT7i/j/jJo
         LBSmi8hg+nfmBeVWFrDetgrXCW6F3PLbpsnH7ftNgBlh8L2KjtuogUvvRf8+1y5J0mC6
         H1hLPjUtF+jC2WwR74hTZGA15rHDlWYFEgaHr/PlOnPHyICaZuH+3z7oKwns75b0pjs5
         rCCA==
X-Forwarded-Encrypted: i=1; AHgh+RpEdrYbltqJZplrFHsrBt8zn+FU/28uCLax6Qcfvjjv5On0999nfQB2KiQLIweX3kuAA/k0GpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzawUxkkE1tYXgXqw1eo80rhWtcjmEEM6Mn6sc8aHbEXPvrjcwY
	1dZmpVs3E6HdBALb+aC9omZTKJqvWm1s15XWg5iaHVVnnaXnVsQfSbuP2mEju9GqhDCpD2EBbNk
	tqnuD42V/StnolA7TU6xG5lh8Uvxlgm8=
X-Gm-Gg: AR+sD11bffUR8WowEOmUL1kq+EMZVAmjTB2croLis2w2rBoCRCEZ97Pq/OBv7CMCxHw
	QoTVyWq6MWCHV9pd8EgTMFGgjkmBJU3I2l0qenILxcyxIhZu0srOLYEUvCKFf4puP3s8DUjSQG1
	E0vc2pT5wWXhLTMe2hc83afEHsyKMmseJsIspG8Tzb3Yym43TOHetF0ksr088DcwPszTQY6SBJY
	aq6m5sRPTl1itmsEzRFYIqaCTCvtKxWGwnWSg9AjBdKC4UVALxwno/V721LpeEumTezy6eM3q9m
	syooEkSQdCr6PASZZkIh18xdfW0K8K+kOUs3pVVQVKa2lV/NU/3j0aA=
X-Received: by 2002:ac2:5469:0:b0:5b0:1b78:495d with SMTP id
 2adb3069b0e04-5b2e4f33494mr1391887e87.24.1785767987448; Mon, 03 Aug 2026
 07:39:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260802-ax88179a-v5-0-dcb9fea4acd4@birger-koblitz.de>
 <20260803073348.2190800-1-neuromoments@gmail.com> <82acabcc-7b98-468a-a989-cb95f620fe5f@birger-koblitz.de>
In-Reply-To: <82acabcc-7b98-468a-a989-cb95f620fe5f@birger-koblitz.de>
From: Yuan Xu <neuromoments@gmail.com>
Date: Mon, 3 Aug 2026 22:39:34 +0800
X-Gm-Features: AUfX_myjX7GDgrIeULe-K48CEOfoy1w7o9fv1P7L3dnRt5PLqS6agmUIH9ZF7WQ
Message-ID: <CAMdPb80_Y8Chkoo4a+VJQz3yPa5YkKWHvAvXYjb=06BveBjP6w@mail.gmail.com>
Subject: Re: [PATCH net-next v5 00/13] ax88179_178a: Add support for
 AX88179A-based chips
To: Birger Koblitz <mail@birger-koblitz.de>
Cc: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, hkallweit1@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux@armlinux.org.uk, netdev@vger.kernel.org, pabeni@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Birger,

I really appreciate all the work you=E2=80=99ve put into this!

I=E2=80=99ll apply the fix and run additional tests this weekend. I=E2=80=
=99ll report back
with the traces and any reproducible differences if I find them.

Thanks,
Jianhui
