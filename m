Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 872E8451068
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 12:36:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788439008; cv=none; b=sZTMP/6cBEcC6uB77bXI0X8QL1GAy8ha2U5Uw+LGG2cvSweXjxkV/L+dV1j/RsgIXbif9WdBjHDfDae0xOWEsKFv8sMtJdjagqT5zp158W4yWtYxuEpuvFQMBop484Kznts1s4QQS1fyJgoE0Wcu5arv9rNr69lGWEJgUYe9ZT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788439008; c=relaxed/simple;
	bh=Fv0jj5bcuxEsIvZjyqFqSNgLYx8CZ5l6EULRDYLFhHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jMnUX+pjGsaHh0wpHOIVobTNoGEtj8KbULoJK/O/n5JsEYixw/5Ltu4F5X9Dexn5Z1YupTe/Q2lCIujE0nRLePUd9xDQaMkwMTGAFt8DqTtMxQvB63A/o/blLZQ/R3aeUkap+pJWOQQ6ZSrjxCG3CLQhV9KzsUnwDsq/nr96k9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=DjggmBSq; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="DjggmBSq"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-48436251906so2409551f8f.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 05:36:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788439004; x=1789043804; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Fv0jj5bcuxEsIvZjyqFqSNgLYx8CZ5l6EULRDYLFhHw=;
        b=DjggmBSqfEjor5fgztnvhO9V/ph5vfHOnBuf18jeX9Ru7MpOp64/dJDTUrnvmrV2uK
         whIs0VfyUG1FfIYiCrivwGcwhy2d8Z0heEs6L2d+/7svT6boCRltFKG2UHTvINfkZGvg
         MbdR8d96263xfp7hk+h18E0SITICwgYZPgJUL+rXFWlsa6sA99bo7IzSBfDaw5nKWPEl
         ErCqFafW2Q7Z+lzHnKlqPuKvxYSbMy+9GtDx9MytCMPqGKItc80d+js5FVeom08E7Ihi
         h2HV/BVHLMGaMw5qPxr5iyUhu8al0pFfRq9eyppX7+iSftaf115aK2TLWUrqOoml51OO
         Axlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788439004; x=1789043804;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Fv0jj5bcuxEsIvZjyqFqSNgLYx8CZ5l6EULRDYLFhHw=;
        b=pdZOHcdnI966N1MLlJunHfwoJYAoZp9labf8B5zRCGgR3YafxkJtPOWHS/Cw3Jsbqn
         0P/GNljS4ibl3ojJJUx4nklCVzZE6c1Oh0e+jE4qfhbYsHtK6E4/bjFywpKT9em8uHnN
         IoSiU3ww39WBIkPmHwuo/mAuOEjl7YE0ROCKgTwITc1GQDTwZBKkstTmsnEkym7iPaQ6
         S/PooyGRvM1h+aK76bqHFypyFSOOgaRykJ7uItmQ8D/iK1Sn3tRQgwf12FxA2QPPr0mK
         IP+6A+R1VOTBKHc5iaKtRaoAmXZe1rzHT9wMC8ogxIWCLQcBx69NPaL31LM580FgCtJB
         QlcQ==
X-Forwarded-Encrypted: i=1; AKwUvBxw4t0YtPPI8KVNJkVUZDDnYp4338M3CttpKBV3o2Lf2EnilaH5IxRuonwt3y9Rqh86N+h8sWg=@vger.kernel.org
X-Gm-Message-State: AFuF++kvBIWY7glvSPHoZmG/oJo7xdqlwXDvpF2X+QLToO8FebCqE7sM
	fwt4x+k42Kd4nZNZx5djFwsAtBi1+Biqw27ukS8/LwVETA/S9UztauhSCXYt/76Ehts=
X-Gm-Gg: AYBFou0HMrp+D3vrzWlwDob7aA8dK2scAOAZUW1Kii29zV3fg/WQtXmhQs+phZOrBuB
	jLZlv3ZhpP5AWFihhZXjmaFyzBoVJdnbL4x72f61slUgrI5gNw9LapqtjvxnuRJ4PGl1357OIP/
	7EANbNbHkoowNxQAf5xIjcxB5poW/zzu07YxSXiE3i59RWQY4Omy5mI0oQY+w36Xi/U4N1rnCmE
	vrz88Oay7ENP5ZP6bJIuKMJjG8kRGOu3tBQBeQkTS7pSBvkvCrJig395Wm4M0WGnmI98w2kQSVl
	Tq7X2hBCKQBHltJ7+Kx4orOMI7H5xDl3QrTfpCFuyEzRzPYbTzvN71dS5284nreOirCFVkaDTHk
	TbLpi7llWQi1ea0jcI+HTlYaQf3iGc7IG3YBjiIfP7Xern3ZLPCsK0/nIiEgM9WHz539L7/Lgp9
	wh5Q0th6PG5ZH07B9i5hxi06kuKGfxnvQFq254Dgo=
X-Received: by 2002:a5d:5f92:0:b0:47f:8f8f:db74 with SMTP id ffacd0b85a97d-48488f06da6mr21869264f8f.12.1788439004237;
        Thu, 03 Sep 2026 05:36:44 -0700 (PDT)
Received: from remote-01 ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-484492cf550sm13718528f8f.37.2026.09.03.05.36.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 05:36:43 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: andrew@lunn.ch
Cc: theo.lebrun@bootlin.com,
	conor.dooley@microchip.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	vineeth.karumanchi@amd.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: macb: reject an unknown link speed in the taprio setup
Date: Thu,  3 Sep 2026 12:36:38 +0000
Message-ID: <20260903123638.23712-1-f@lex.la>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cb6da9c8-aea0-4740-9709-d718462481e9@lunn.ch>
References: <20260902080528.2211468-1-f@lex.la> <20260902080528.2211468-3-f@lex.la> <cb6da9c8-aea0-4740-9709-d718462481e9@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Can ethtool_validate_speed() be used?

No: it accepts SPEED_UNKNOWN by definition, and zero as well, so it
lets through exactly the values this check rejects.
