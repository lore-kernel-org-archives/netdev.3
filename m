Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4A87373BF3
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 03:44:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785210259; cv=none; b=h1y8ofoSYkfofIARnU/2GIIj30e49OX3RJNkr5T1zLNbJAdjq06VOT1cD2hy2RIALoRoLZCDyHTQouJwIJfNb7ztRpx+1YX3C2UqwZGPoInxY9oN0sQT0u7EcfgSF/0vnTKW38cJDjsvbBy2XR9cYNGuppFmaNrCJPCm3FpqVW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785210259; c=relaxed/simple;
	bh=LXCOZc8iKG6d3HKClBpT9vSypzLia1diK5SaIeJjjr0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=RUzBUXwXhur+ouJumz04adeQ70InujUp7xoUtOUFfmSTgk+mLSjw+ZZxzGuzgTVVxkIkc2aM1kwmlZKhIpGZuH+RoTetQDO8DsI/e38u3I+dDLyq/1CZDN5K2B/FMiUd9aXJrxG71uTXB8Y2Fca9vzjq1+DWQTVQ/OvuoPV61Sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrUjmW1w; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrUjmW1w"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-84e04df8c46so3460212b3a.2
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 20:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785210258; x=1785815058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bFCShoItN/TUIoYv9aqWRxgBizW2Phydpbvdl6mLclk=;
        b=KrUjmW1wMob41gQj7nSYHnR850pxrX9/HskbrBZaiV43IvxEiyPNyDNlNAP2F+RYi+
         rG+IcZzeYwI0x+IfJD5OqU5bARrLihlcxkUTprBKLOX799xzqqwGVAsV6Gpmk4cvJk8B
         a0iICl1CBGiXBmqtQchAjKTHX9HCS/WUC5mChRWMd22+qNblck/ZIJHL6L2JTTLccJmi
         toxfPhqedwNG801/HQDEKOfjwmLOqSXHneNlT/WoFDWS5hmswo3MZ+aA5I4OK6wrZpuO
         a0phTZlb3QSG3GgdyVa+RT4X2U9uAb2SUBCk1stzxYxspRn69gUHbrkuKgStMeYro2lQ
         qLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785210258; x=1785815058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bFCShoItN/TUIoYv9aqWRxgBizW2Phydpbvdl6mLclk=;
        b=VpeORHAeoEpr4g6PUYN3cJqFlE+CWZugjZLY/CO9uV+1QThe7CiPzI6eKImU8pQI3j
         0M2qa37rDx0T0CsXjOkA6X1tbwcT99odGWvmvftPuUCR3Ai9qyUfM42PXIa4yl7es2WA
         8IArqQNBRw4IB7PHOqWbEKa6bYxH+OMLgKr5eMk9LPsUZ1nAKNZMeqYpK0At2h9tOvv0
         CFJalQrGxLxzNUaoT6aNKoVKjJUzNK7PJjnQbQBWqaRqnl0jikI8ik7MB1r5tb7DB5j6
         zTIT20rvnNNKXl0ZSKSk212tPzp6fJGmI6KWBO9n5iLC352RxJW920KkeyajR/0yD4iB
         8FYw==
X-Forwarded-Encrypted: i=1; AHgh+RoXc78uG9YY1xxO8dBwJDuYifr7hk1qCR70wxfnaGUVO1DR2oGPTV3A56OsLzVunTQwPciBVeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3Xi1/vsqAdiPvjCzIVQRnS5qLjUaD7TACOwA6TlxhPWGQfa0l
	VhveA1eZDS5HgX0qSiWhRXjTmcg50KDLkRCwPQlF8cYvPuZJLq2i5n7z
X-Gm-Gg: AR+sD11TbiKLXAD9CdqHEHD+oi1nAFmYmxmyHGxRdAyEvWugQXbwR4YJMqO1k3o65Bx
	7puljcZnGHaXndORYguuuwdMXhxcht8vQdzKEDl01HgHlbU+IygMo7iDg/e4x2T9rCOqucbJoQJ
	M/Ktsn4JrHNH5LRBZ5vxadREnzG5sy6uWVcuRxH1K/xwgH9RYjJ7Wwr/lSfZG6AclLZ6YLmWJRl
	aym9C/hPlih0qJx9d6aebMXRJ/cUFnc2kcopo/KJoZ4yE8W7IvZnba95eO/SOHNmaHqUkbiQyr6
	bcpSVfdhign6HuACDJ7X5j9RlsVbidVJiAmK0mp8n17UFsHFECQFQh3KW4nheHAXKMzRvdV7aMI
	46xTrrdVGj7KSrPelbaXXpIXQ+jNyOlOBVKTRtbbF1fQH8zhl3gS7HCtbTE7076FjNNo0XCRqf/
	/m
X-Received: by 2002:a05:6a00:1d83:b0:845:4d71:8d15 with SMTP id d2e1a72fcca58-84e9331e137mr666205b3a.37.1785210257868;
        Mon, 27 Jul 2026 20:44:17 -0700 (PDT)
Received: from server227.. ([39.170.101.209])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84e5341e69esm3740869b3a.43.2026.07.27.20.44.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 20:44:17 -0700 (PDT)
From: Zxyan Zhu <zxyan0222@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zxyan Zhu <zxyan0222@gmail.com>
Subject: Re: [PATCH net-next] net: stmmac: dwxgmac2: configure INTM for per-channel interrupt routing
Date: Tue, 28 Jul 2026 11:43:03 +0800
Message-Id: <20260728034303.1432292-1-zxyan0222@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260727181617.19604f9c@kernel.org>
References: <20260727181617.19604f9c@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 27 Jul 2026 18:16:17 -0700 Jakub Kicinski wrote:
> On Thu, 23 Jul 2026 15:50:50 +0200 Maxime Chevallier wrote:
> > Same logic as in dwmac4, this looks good to me,
> 
> Is this a fix tho? The commit message reads like DMA irqs are
> completely ignored. But neither this commit nor 6ccf12ae111e
> really explain much to an outsider..

Thanks for the review.

The commit message does a poor job of explaining the actual impact,
so let me clarify.

I've verified on hardware with XGMAC and multi-MSI enabled. The
results are definitive:

  INTM=00 (default):
    - 5.4 million interrupts on the common IRQ line in 3 seconds
    - ~1.8 million IRQ_NONE returns per second

  INTM=01:
    - 0 interrupts on the common IRQ line
    - Per-channel IRQs work normally
    - 10G line rate works correctly

The behavior is that with INTM=00, sbd_intr_o is also asserted for
each DMA completion event. The common IRQ handler
stmmac_mac_interrupt() only processes MAC-layer events (LPI, PMT,
timestamps) and returns IRQ_NONE for DMA completion events, causing
the interrupt storm. With INTM=01, sbd_intr_o is not asserted for
DMA transfer completion events, which is the correct mode for
per-channel interrupt routing.

Regarding net vs net-next: XGMAC multi-MSI has never worked correctly
since it was introduced, so this is not a regression. The same
INTM=1 configuration for GMAC4 was merged via net-next (6ccf12ae111e
"net: stmmac: use interrupt mode INTM=1 for multi-MSI"). I'm leaning
toward net-next for consistency, but since this makes multi-MSI
completely non-functional without it, I'd appreciate your opinion on
whether net is more appropriate.
