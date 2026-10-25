Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792944532;
	b=2+Otddvh56OapTdsIiGrgKc3Zo1+lXRyv/+HVy4ymDN4ZJtmQpihsKUQ2P4QSsn51PFR
	 DV7P81c8BO85D5MFdpDEdACoG0jf5MDFC8bR5CBQWoNO4G3hUjryOat8BSggM/1KS6yRv
	 sqS92oz+U4Ebgkcy0KHBLvssYtf2eiHU6REEjrim/hvLVFMBJarcNwKD1/b2YpXO5kEDY
	 Bvcsou5cjVfQFXDBGxa/vInNM7QBgUMtH9t6EvaSgC+ybzZ4UPoUWRD48ySybfmHRYxm5
	 SNyLCGpiUHBRnasRL+bLExSlApvhPdWMP5KLSUnt2O93qfOiX78sm2g7uufLOYxiCxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792944532;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=5bsFb1VGF6oWmE/SaHObYdwjauVdSsHZobYqpgFT4fg=;
	b=KpijpsXBfNUDOqJMg/CSBTpDrlyU27JI0fI7ejVeoqp5MqSNkGk0w7tRCKxi8Nd+4E4/
	 JAAikpR1zOtIzJDAIdcDdremXVNrNmva+6Bt/qYRkQ4eI4XOjeYGx0iDVBgjhcUoKy/fD
	 bLaNjowYZHYmeOagCVjd5FiOQXoKhdog/1sojmTZFJUl9bdtfNK8XQh75zYGOWadszJu5
	 0nx9QTCcQ7Y8S7lLSg5wDMq2xs7lxuYlHkDNnQVNx/MtDGkWasRFo6a1Dc2rrtYWEYGOd
	 SMvqHSFcQkRsF7DaBNEck3qyXwpqRlHQtQmhTEGEZqsyveocynvxwd8YS8m3XugRJYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=exSmZb4+;
	arc=none smtp.remote-ip=74.125.82.53
Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B5A606A33D
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 16:08:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 59B5A606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=exSmZb4+
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-156cbe59524so1362342c88.1
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 09:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792944531; x=1793549331; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5bsFb1VGF6oWmE/SaHObYdwjauVdSsHZobYqpgFT4fg=;
        b=exSmZb4+Kw/kxqqpDCYdKTZy7cTyRv6ROKOOKXPRoAjBll5aml/FiU0qd78qRCr46V
         hBvBAKzCyQEe0CPsezteuFWs4H4TuL2+Irsy0SMiU2CdIdj5H7t8AP40PnczFjz106CB
         giwqCpQlfq1Om6b93qLEUlrD1/rpW689+tbjhKX/4zRmFh/GGLGGexJu4W6dicjNBD98
         j2QcTlfLMjcHDbKuMcUB0qtl0oxYTiZ4TVj8O+YFoVRGkLAsuyVVY+gXN+BLxeHCm2rr
         0wKTiwU/+z3WB74m3g0erDteWlyV5jX4hcDrNRDsFvZa6qjEN7Cf3o5N6MmlI2Riy51t
         DM0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792944531; x=1793549331;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5bsFb1VGF6oWmE/SaHObYdwjauVdSsHZobYqpgFT4fg=;
        b=LwsiACKd7yx0AYjGigdH1p3+QLV7WW0DCn2eCRmjsK5UcYOjYrzJV2493UVpKsuAgs
         EzvZMVhUAYvEmaHz2LQpWJbDgsvfNPE+Nk858ATmBGlUozcV8Npt4kMwqnpUO5fiwmOq
         dEA4lLQIgg6zxYNihoyIej/flB2smo1T2HgscM//ogaDn9rAWruybUIXQnUFe5jWtfzN
         WV72vvzrS9BXwkFVEL7h0CGWjG6zjEggd2eM7KBUF5RM8MSVtUSXaPEweRh/mCorqpmb
         pulp4Ftc5Dtm64GY6UmfC9ulDpRQsBq9u6bVQEULZ9Bm21/oRsG7FWOxqYpcBTDNKbx6
         fdVA==
X-Forwarded-Encrypted: i=1; AKwUvByjgi0jsb4/P5jBhaHyQzHOhm1O+OFE4Nmvdza6gRJ0NyWt0G5NxoKo9AW21L8olWpcmPGShj4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIvywrloziPfvxjbBX1ADY3lcM3/rTEcMmC8FNZS3dK/2GI1wA1
	ZvwaETu2+VVJ8nNONtfQKtH0+FxXXyFxhhvWuIJ0xzbj0lb2Ryr/J/IU
X-Gm-Gg: AYBFou1Ao9lkAh/HwpeDJmNa/EwM4N7doX9eWG0rlKEeo5LKqvGrP/JDnZ3GmsouHi8
	PjCRFr2+jKZxhipMJkIt0U1d3/ApEBGxKaFwrXnZ7uKVAXtiknpfeGJv0ednrT0A48qXIireSfm
	OdtJlAhmP1FqnQaEJeoGiCoazGGyr+SUS6WedhvJQFRQdhWCOdOhWqKcJd/5R4EygnXWxTko7vl
	+uCwgIJ/g0BIFFTLuwD0RGA2kv1XpEqTo9BfxZa/OIAiH+PjoK5AD06OyCYXwCXJpWBMt2S82CO
	0mFM3f93yEWkcuCWpoejkU6/H5z9JobB4IVAmZIK7G3SnVGScP2LZi0eGNIq3qE2yoyW4XTHXtx
	cPv41KLhEVJbw1+cOuu6nVw024OFnQRBHrnYZoh5+BgEsN+Vl4pA/yAmFssyUfku3vAuyyTWKxE
	XthgthAAViHgGCzOxcxvjfiq8CL8zOp26a+EKYI4fuDfq4c75I56TfqyE7knL2NBmPDTARc9tqp
	4FUJhkiq5wwEvjQz8z+4GYBaZ12kfbIw2RagQ/CpudowzyGp4IFTgruEkyoYD+V23/D+5RWQQ1v
	jqQErf1cdVOfvOFyD7qZ
X-Received: by 2002:a05:7022:1087:b0:17d:7b45:f905 with SMTP id a92af1059eb24-19937025befmr6506534c88.31.1792944531413;
        Sun, 25 Oct 2026 09:08:51 -0700 (PDT)
Received: from obadmin-Precision-3680.atlascopco.group ([136.226.232.166])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-19894d59f90sm16330421c88.3.2026.10.25.09.08.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 09:08:51 -0700 (PDT)
From: Sahaj Chaudhari <sahaj123.sc@gmail.com>
To: Hangbin Liu <hangbin.liu@linux.dev>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] selftests/net: test network sysctl extremes
Date: Sun, 25 Oct 2026 21:39:27 +0530
Message-ID: <20261025160927.3934600-2-sahaj123.sc@gmail.com>
In-Reply-To: <atXJLy6iTh5vbe9D@fedora>
References: <20261014041446.2821085-1-sahaj123.sc@gmail.com> <atXJLy6iTh5vbe9D@fedora>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Hangbin,

Thanks for asking. C was a choice, not a requirement; I agree shell is
clearer for simple sysctl toggles. This test also searches accepted bounds
for each value in a sysctl vector, verifies writes, restores the original
vector, exercises loopback, and checks kernel log records. I chose C to
make the numeric and error handling explicit. My shell prototype was
unreliable in QEMU when parsing the vectors and reading /dev/kmsg; I don't
mean that shell could not be made to handle those cases.

I've narrowed the test to tcp_rmem and tcp_wmem; UDP is now only a
transport smoke check. I recognize the C implementation is sizeable, so
if you think that complexity isn't warranted for this coverage, I'm open
to simplifying or folding the test into an existing one.

Thanks,
Sahaj
