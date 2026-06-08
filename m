Received: from mail-yx1-f53.google.com (mail-yx1-f53.google.com [74.125.224.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B39322768
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 20:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780950103; cv=none; b=r4z9DirY3MGNuYSS5TFY1bGh56Iu7b/VsTMI4g/3qhyiwaew7AHicNdj8zVAc+Mv6vSSZS1qeDT1C4bM70uB9pUktGbKNjYS4atsN1Zc/cFzCeh31kPX/ygJu8wrE0NLLApM9j96DG8+PjzD634nZlwk+Zo5xai78fDODzxGUUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780950103; c=relaxed/simple;
	bh=TQvLeMle3iThPhD2LwwMaOnyVvv73DGaNa704sNNXSw=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=LgVS2UaihqEEwH9Sz4x2aHwgq+VpVA+wdm88wRtEuv8TUWADNG6+Tt0nh3uTV58zz5yq5nCquBgKDHffU3uXJRzZkyhwR57bU8C7SUk9wtSlbMz63H+yp5NlG+mhkaU3Ac3C9AT4UeYUFBTpJbxPWeFilyHhvVNQchtI4WqsqhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WTi+XRue; arc=none smtp.client-ip=74.125.224.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WTi+XRue"
Received: by mail-yx1-f53.google.com with SMTP id 956f58d0204a3-6607048fa62so4765282d50.1
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 13:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780950101; x=1781554901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yBeFDiSsP0+XuJEQ3J66Bl3Z9nLc7UmOrcHp2ajL6d0=;
        b=WTi+XRue0IUUcjKvPAfa6sYbr2sPCsplUZl4b/38VIGjMUeQVEdILRdyckC079rWrL
         iUttI7QflsJC5BMiodOwonh6WZ5h0UZG0AcHmYfBLHZCvUrECBF8HsLeJ2wXu4CXYkNM
         66otcRcxVCnkJikAwWBnqtKnDjYOhDeKAz47LvCiMTlAAkV9W5KPW2HI4REQLvVoPuuw
         rwbg/vobnd6e1hF+PONTQJ9IfwfCyiMDPoFi5q/atIAa2Anwd1dxwA6yHNpQ59mdt/qW
         k8VL4DG+YHryea+Obi8hIvdYj8TD6ZeEZAIUonFPuV1Xg+t1wBJXn5BjGOQ66jf7KtoF
         eMmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780950101; x=1781554901;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yBeFDiSsP0+XuJEQ3J66Bl3Z9nLc7UmOrcHp2ajL6d0=;
        b=dsUqXgJ9/qXQr82LdfZcOYgd4GTKRNoyuOF5fOqrAFoAUbjwUw6ZQXsCqmXGNNMT+Z
         +NtEOJA3GjFvqwLTjLBV2LrbtDVKuXDIdszbjvnm4P6UVWcxih2Pjlhgn0z6uDspgHIm
         0tcqbqqyVVDD3B1RhT6O22epG1sd/IdIKRZq+d4nc8qMErrH+u+XIVr1QZSbaGIOITHA
         hppM7mtmU4BeneTRucrL/1rnVlxdQrRWA6ek3MWqWKt7TDEgSeeieLFQCFAy/P4FQ/d9
         N5x0BMy/q3m0pYmlhbmE1/JKNr4JFWoIcBfdnY+iQbUlbPtF/LW7nXz7N1fDb+jrYZAD
         M7Mw==
X-Gm-Message-State: AOJu0YyxuJUgvxytzj4HdVWrtgDBFYsjNxPjf9KMh2Zy8BM8q0repfVA
	fGFHkv1u66yo20XhIHydpk1bRW6aJ3sQF4lgxU1IPBukq/+bQolBi+2q
X-Gm-Gg: Acq92OH+8jcynSeVGPdwukGyZBW2N5jybHA6EqMQruJj+p1ZrQuBQrlsWjf4K2Do6VK
	rQd5izJc8pszu90Q1o/zUSLVVOARAH//E0IKNZOnnQcpYfYKwYhXK3cskKqMTRULj/Ju1esTiAh
	fRQupi0HTbHfUZNEIOe+zPp8bn+SO+9fFM9jrEPZ717ps0LxU5D2RI5aRt8aYg1r95zjaybR7EQ
	10AM9fji7Lhfj/URmYAFeh92gYAvwOZAjPLJ2TGztBIwVWwYkO0lmktfI7AFtZataG7hAY13Rfx
	d+C25fYmJY7AyplJGctZ2m8MgQPOKQbdv0fAS4DXy7uGOeDQgmVApzihuCbjYt+BWkZM42gIkrW
	Cz6E43RjwBVpGc3U8iOTBsGDPcWe983xQYuxB2f3VGnKHsK6Cy3rYluR++evp2XjlFtkHVPu5Px
	rN8A1Mfz+aerckKwcq2LxflJtJbGhxWDKaZ1EXIjfYk3nYoYFvvti8OBAwHgtTJVuTeomIhOtt7
	+EoMsTFh4xLAECzNHGu91dNcUmQ
X-Received: by 2002:a53:be49:0:b0:650:39d6:6983 with SMTP id 956f58d0204a3-66106ea5c57mr11748818d50.5.1780950100763;
        Mon, 08 Jun 2026 13:21:40 -0700 (PDT)
Received: from gmail.com (141.139.145.34.bc.googleusercontent.com. [34.145.139.141])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-660d64ba680sm9909300d50.21.2026.06.08.13.21.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 13:21:39 -0700 (PDT)
Date: Mon, 08 Jun 2026 16:21:39 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 davem@davemloft.net
Cc: netdev@vger.kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 andrew+netdev@lunn.ch, 
 horms@kernel.org, 
 willemdebruijn.kernel@gmail.com, 
 Jakub Kicinski <kuba@kernel.org>
Message-ID: <willemdebruijn.kernel.753e66b6c929@gmail.com>
In-Reply-To: <20260608173305.372987-1-kuba@kernel.org>
References: <20260608173305.372987-1-kuba@kernel.org>
Subject: Re: [PATCH net-next 0/2] selftests: drv-net: so_txtime: trivial fixes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> I noticed that so_txtime is only passing on NIPA setups which are
> looped within a single host. The cross-machine cases just flat out
> fail. The initial bug is obvious - the test does not deploy the binary.
> But even with that I think more work would be needed to sync the
> time / adjust the expectations for a dual-machine test.
> 
> Feel free to nack / take over, this series is admittedly achieving
> very little in practice. The test will still not be usable on dual-host.

Thanks for these initial fixes.

I have indeed focused on vng and physical prod, where I cannot deploy
kselftests as is, run them a bit differently. And evidently missed
important parts as a result.

Let me spin up some cloud instances instead and iron out these kinks.
 
> Jakub Kicinski (2):
>   selftests: drv-net: so_txtime: remember to deploy the binaries
>   selftests: drv-net: so_txtime: check IP versions
> 
>  tools/testing/selftests/drivers/net/so_txtime.py | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
> 
> -- 
> 2.54.0
> 


