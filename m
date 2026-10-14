Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D27B43AFAE0
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 04:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791953786; cv=none; b=ETytZLR6zBcBUJvz+Upamw/ASMJouxgWmfm0W/nYSjpQouMCdLiGDRj+5JNLfuQxE57gMOebb2aP5jCkR8woFqXBmZd//HA8yYNBXhr1+Ozj5sR4Q9LTTR/2HvLV43b69fQ3S2EHOq1kOAy2YSNi63901/fylTO6gfe+1CiOfSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791953786; c=relaxed/simple;
	bh=WjQH6eF1riN+Hdn/Ak1ts4FChWpGKVUmHOzzJk7eT5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IIAAzf0jtO4PFVntL87Wdi375Jfv4X6pWmCOwx/0EyGNySgxgYvPeS22B0PWSyf6CD3HjWTlQIRoisQ0ocAGLIDAh5NiQP0D/PjTh+LpPhv3p6BRrc/8Sw1oM5lPnRywl1kqE1vbnUVuUUebueJHohSNb651DYkjfsiCe4LSji8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fdRVC+SW; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fdRVC+SW"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-353804b591eso6494394eec.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 21:56:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791953784; x=1792558584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WjQH6eF1riN+Hdn/Ak1ts4FChWpGKVUmHOzzJk7eT5E=;
        b=fdRVC+SWYM8ZLJ165A3wGZaw8opLHoA0K+UmYdypp+Cmd/Ztex9ifE4hrWWSXMH1Sw
         mH7zN9u3SXhBs3Vvhgda9GCZh6dCojN9NRrd8hlpT051Gvc55yoc8mdlzSCDXcH62C+R
         Gg0dyDwzvRrRXOTAFDJKHy+7/CYhnf6cWf+EwHxZZOteALETiPMcP2pMjpSNexiHFg5c
         WMYMeqSbtgtXVWKGKRmaqDFwCPG+SjO7mUZaYLbbg4M3/iacpSYKhcYC/Ht6PUVYyelW
         uSCtYJTRALKDoDuvoJVxlzTlI3dfTL6nNS5fmCPS6BVO7RGNG8fGl4RMl75FKXdXNpaU
         V5Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791953784; x=1792558584;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=WjQH6eF1riN+Hdn/Ak1ts4FChWpGKVUmHOzzJk7eT5E=;
        b=zhqkp1KIIMDXdKVuYchF9rQzCYAzU2l24brpVz1UK+AwHJgIDhejJtldN2mIJM2r8d
         IxQF615Pwn+UXwvQc2MLZnEgBtzLer4Qm6VqBbTgOm3iu8Tw1e4lidCiEld9e+Cj1X5B
         JXfHcvKDMTtMRRt/RM3k5wjotp6qupNTBw6nYVYd+LPiSWcGU8L6sdHCnCDKUI6RLUXD
         8IdcVZEl1d0nLD3oKtYITcoCrZg7rVMmCbnXhijBKcbTK9xLfECN4O4Zz6pWQFQQ3S8/
         xTnFdXUtjvgcRUc9qmq7QtyU8R2qzXmNbvY3nbQEW73JJ1iZYeGfOPr05xYZs8jNHwWq
         0gqQ==
X-Forwarded-Encrypted: i=1; AKwUvBw7+lS7xrQsNIOe5/QtM5E+3G07n+vmASKNo/h52FT/MvZp9LRzFx5XFEyoB++e2GKho1chXKg=@vger.kernel.org
X-Gm-Message-State: AFq9FYIENS2Zv1gACg2A9bWC+a9Q5rGH7DEOF8HfY2gaMfuo2tynQXAP
	7XRKO4uM9PvGM3qTlBvvMqTy08CwoIP6mJMKsmFQrUBuR0hXn4WLfy4u
X-Gm-Gg: AYBFou3Jg99Q+ia2vmbmg90gYlq2A8JIkd14VyLY2oOHZwzmf2Yb+bMYU4tLhLi4Wkt
	PjplqWdB2QcCIhpod9BpU8BQ0pkvRywN33F+1Ul8n6GCBxz9fe+8RO1jwbM8PjT74uj/+acBUxP
	PXjEjlz40oBtGIzYjL6cAvFLeAPaBR1vGHyGgmxypt39wYDrDFisHXbahaRH3F8XRBUyYvzDAHg
	v6g+QSel0gUs4SsZTmzOjfATQNyK3Qqm2JRC8vUSR3JieE3obbuNAJ6gEeML5oSw4uMO9KMmPXA
	emLnAn91HABmLqrg6x2Szm7Q2pFWEh33LHyFmUGRHQlGGzLQYhnKYGoHSwKD1rSYgfbe3YgWOZw
	8VCBqTsPB3jI0Rp364aBV1DVrzjFF7NJWeS4x12IoCMTdOAVohZfz1vDe/orRAsk1AFcE+Gj4Rz
	3snRQjDbJNvI7WhcLSWTziJ93DPxvdhv8WCV/QFxqFsJZDuCno16GWverMvpwk7sKcmlHuddmG6
	OY1plj5UW3j
X-Received: by 2002:a05:7301:dd8a:b0:35d:ea6f:b85e with SMTP id 5a478bee46e88-35dea6fb98cmr1093412eec.1.1791953783690;
        Tue, 13 Oct 2026 21:56:23 -0700 (PDT)
Received: from online.mioffice.cn ([2408:8607:1b00:8:a73d:31e0:8b98:4eee])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-359789fde97sm33473630eec.20.2026.10.13.21.56.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 21:56:22 -0700 (PDT)
From: Pengfei Zhang <zhangfeionline@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Jose Abreu <Jose.Abreu@synopsys.com>,
	EricChan <chenchuangyu@xiaomi.com>,
	Simon Horman <horms@kernel.org>,
	zhangpengfei16@xiaomi.com,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: stmmac: xgmac: do not treat TBU as a TX event
Date: Wed, 14 Oct 2026 12:56:07 +0800
Message-ID: <20261014045607.3421104-1-zhangfeionline@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <179194881415.434549.5017437610608933310@kernel.org>
References: <179194881415.434549.5017437610608933310@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> [Severity: Medium]
> Can the XDP_TX and ndo_xdp_xmit path stall permanently on XGMAC in
> shared-IRQ mode when the TX coalesce timer is disabled?

This is not caused by this patch. It needs a very specific setup: XDP
TX traffic, tx-usecs set to 0, and tx-frames too large to be reached
below STMMAC_TX_THRESH. With that setup the same stall can already
happen on XGMAC with per-channel MSI today, because
stmmac_xdp_xmit_xdpf() only sets IC on a tx_coal_frames boundary and
has no fallback when the TX timer is disabled.

I will look at fixing that in the XDP TX path with a separate patch,
but it is independent of this one.

> [Severity: Medium]
> This isn't a bug introduced by this patch, but does
> dwmac4_dma_interrupt() in dwmac4_lib.c have the same sticky TBU
> problem?

Yes, it looks like it does, especially since commit 6ccf12ae111e
("net: stmmac: use interrupt mode INTM=1 for multi-MSI") moved the TBU
check out of the NIS block. I only have XGMAC hardware at the moment,
so I kept this patch to XGMAC. I will send a separate patch for dwmac4
once I can test it on dwmac4 hardware.
