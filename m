Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC3C492521
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 16:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785342283; cv=none; b=kWIdINsBTyrSpvbakyCtQ6B3JN9mDUWXcie6CdJMCIGwOdUh8fVnba1YBIvPBeJDa+Kpiy6Bgx/VI1tkNw8eu0ampksfV+RnpnhhLPnyTVPceuXPaiAOfk0cJizRFaT6L0enJ8ael4UmZER/SwR8djOY5X77bmwcNtHmh8zF20A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785342283; c=relaxed/simple;
	bh=Q/G5u+F1YPfjVkOjYrnaZEupITI/nU5HIXk8pouwVAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sUYRCOOHh7odRQoBEHYEv4xMoDcNsuh2C8P9bWeC1c9t9OWgE1PqzQBg/FVfEt2shBQYA4dLE8OaXFTdhxMzoXmZaBtqs1p4SP4tnxy5838Pja7mi3NkQkm75qTE08QCp7K+akWFVI41U5ytikiCB4u/UMUBb6OT0TV5NNv99sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=btpoD48G; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="btpoD48G"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5b159850b16so1059766e87.3
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 09:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785342278; x=1785947078; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Q/G5u+F1YPfjVkOjYrnaZEupITI/nU5HIXk8pouwVAk=;
        b=btpoD48GmlsjCf+rhF6xeL6uB34oLNW7zprOncdh8k4DrZQ6gbSTf7kb8ia3NtYKXb
         3WDMaQ7kQQwSYVsHJRWRDRblRcFCi5IHD5OqJD8HqepGVrZDpzXyI6Qw/PICMmL3A7YD
         UymoHLBlU62ILYh7X/MFefRNr2yfbL16012kEk2j8tiw4h2oADoBgZkdu2AxfPL01nNz
         1RvLfF9yz7glxAknTTJ8MteORJap1o0su8uNlZ0vWUcamG3vJ094Z7x05g2muw8nLv9m
         qthBigP9Z1RVi2LE3SAhLgC0jBTUypnpx8CZ/ZkrBTf8rCV8Wi2EYF+G3ycjgDhh/bxo
         ideg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785342278; x=1785947078;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Q/G5u+F1YPfjVkOjYrnaZEupITI/nU5HIXk8pouwVAk=;
        b=ZeMz39hzH/HYCPsGrhhxWgt9qiXjvgvG5HAPajcCc2BelNTeqPLI3f/DOiFbysw8vr
         QbH0Hzd/hXkioUYU3pVdcgX60Qc6vtRhdtpf5kQx1PRepWoBWh3OIQ0Z2/F5iqPtp9Pi
         jvww7QFoAZN993PEp3uY0k1b+XqiAyolXXrCD6ckoRycd/rfuMy+Z34gM3RseJwOy6U7
         wOwhONPPKwdTgaMY1oNbAf8VwTuOciMfi9mpo/ZJTQJFmz3CQIER4M0+/FgD8LmwhEnS
         zu2njaHebxA3Hcap7dsdGIb3fKhrhH9pQDl4ueskpuvJCga1lLHNV2S0DLhLeL+TvAs4
         +K0g==
X-Forwarded-Encrypted: i=1; AHgh+RpGTI+agQiECUvRK3Sg2yStYzyNYutuXNnTPsx+lyjI40qTQAzOjik2n2gpxx4E+xsuegOPYhI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz94U1mWSn1RvBcLgI/S8+/CE08LfXiuK1thbvbtkmbg8gpFCIz
	/H//+077+dpKtW0ipxnT1gpks67UGEGaheLyvCmWi1GSNHsvDEYRDXzo
X-Gm-Gg: AR+sD12j8UR8e/t6vwYMlRX7kAU5C+DOvTHJnRGrJb5IL5csvOuuSzdIqoG5IWgt5/K
	3RQ5iVoKwkyTyMpXbeFpKydsxFTFfZL2r15NMTh1ehYw8j6y1jpHZncFNfWXTFVZyZO7++eiGwa
	Z7+/3IhSsGZkFC6Lb6Fg/IAS5pCNrKPwvzRvnbzNRGAjuOCOgaJI9RphTTUW8yEf+kMoZ6+VaQq
	/a0m2TAEQm9Ql8kj08ZtA03k/7L4p6yZtprAvq6888Vs4ZnhcbfcE3QWOTIsq52CDu5BlL2SmL6
	NFuXjqOr1vZ9JJ9ylXfMo3l/kWAIfkZe+zkqvr0xJluQLyaHb1k+mK2/ZQh2tPlW7TCmJXe0q8M
	QijJqpwefbmlkfVOKywbH4ZGwV6iL/4v1XUOKI12Vm64uAlRXenzw22QesblCQ2ibCQvt9Rr7Jg
	GQhiFPooeH1XSNEk8y7IyJTTwdFJ12Pio7LUkpy4C47smIEKoztX+++wkibYpvr2iotQclHmPTb
	w9T2Ou2cwD8G2v8JoFbkdH0Qb2GpIXL5YQvRYK+5vqC
X-Received: by 2002:a05:6512:1082:b0:5b1:5afc:1727 with SMTP id 2adb3069b0e04-5b2d02740a3mr1609157e87.57.1785342278007;
        Wed, 29 Jul 2026 09:24:38 -0700 (PDT)
Received: from pc.tail250202.ts.net ([87.110.86.243])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2d7697770sm495965e87.15.2026.07.29.09.24.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 09:24:37 -0700 (PDT)
From: Janis Edvarts Lacis <janislacis06@gmail.com>
To: enjou1224z@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	kuba@kernel.org,
	milkory@outlook.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	vega@nebusec.ai
Subject: Re: [PATCH net 1/1] net/sched: reject overly deep qdisc hierarchies
Date: Wed, 29 Jul 2026 19:24:36 +0300
Message-ID: <20260729162436.119656-1-janislacis06@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <99183398d8534a2bd65e8819cde9dae92dd97114.1785304107.git.milkory@outlook.com>
References: <99183398d8534a2bd65e8819cde9dae92dd97114.1785304107.git.milkory@outlook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This appears to introduce a new qdisc hierarchy depth limit of 7, how was this value chosen as the 'too deep' level?
