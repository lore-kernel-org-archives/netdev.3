Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A15A472F83
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 16:03:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791302601; cv=none; b=AIKmWvnWNRYNtlaUv3xOKRxdBTMBVUAO7jg5m1Yp9ZlrR6wmpIQF5TXgMSpvSgDiCWNVzBZezOIVkUYQj1RXPt/kOba9TCgdQ1iHQKrvake++wBjWGMMRv5FbOvTQncGAV660wxs8oEHAsd7Adb0EY5orPh/5KLoPjYPIYhWtFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791302601; c=relaxed/simple;
	bh=tRVWPINyjJdLoLNnFQLSCFJ69aEwcAX1O7+rRp+bsrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QCjVrzGhmyjDTFSI7FOdWFpDpFbDpujdBuhyQ1HvJ1HYsq7LHOqWTL070E5rW2ij2KXNlOnwp+K/+wbLiOm+/3sznVVwi+sa+Et/sEULEpif6NpJZd7z0NDHVGuqpI2UcRrR7oCilOz0FMb9QXBHLmCjsFRuocZmCtPcSEMavmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ItV+2PGU; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ItV+2PGU"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6afbc363efeso3741356a12.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 09:03:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791302598; x=1791907398; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tRVWPINyjJdLoLNnFQLSCFJ69aEwcAX1O7+rRp+bsrI=;
        b=ItV+2PGUXWlL9Fs0o/lVgpThK3lCIS/pSY1ob71U5KrNWhyU87rAAJooMXrVHdkyxT
         ySLhJGSgKllAG+USLOv5KToriJBSO/zusK+cYpBtIK4R2yQ/Clskv3Fs9PX9C0SHRXFn
         pGdSrqtjcqRmYtI4XK6F1Zu8gCJvw2wP59jiKD7P3idqlgNf7sOjYjlAX2eZoh2Hq9l2
         fyvXaUj1AUv+y/8ggFjFrJy/Cx0iITtlv0JgSqfcSo1uaIxl5fS6QYbfzNJTp/JREORB
         10q2k9RzOzgfcMzGwPyulKaW3jic8LuLvuvg5Meya/XRO40HzZqFGpxLNdnxolDVw7N1
         I8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791302598; x=1791907398;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tRVWPINyjJdLoLNnFQLSCFJ69aEwcAX1O7+rRp+bsrI=;
        b=PYdRWRfKB/TVM2wDRZ2qKQG/vQU81ynAoQw8m4c+1OzlUmrGerB2UTedB//9H07Skz
         H2OIJTVOndw3ZsAGflIsv0CBhDfX7iYEulhyYarTzf4LnBYAhtSDprmGa2My0hUfB4w2
         9xnCnSYKa3TiZa1liK60nasKg0AOjTLV9p4s//CJUayLVpRuUhZBn4D9cz4Foa3h+Nen
         WhxirhFD1NxCR2+siW8FS/V4E/bHEurSARMi0t+iG225RVvnvN3NDVal1K4KhuO3LmZh
         TySbYJ0EpYIVPMlyDCDnkRTuA807YjUxU4BJaKI3BYOTcEZGQ5oEN55f8Armb+nqs281
         l9Tw==
X-Gm-Message-State: AFq9FYKF2L0q9mZ2NgWnT7D+V5JNrO/Bp0igN+EtEuMcr6BoDkhECeXs
	ytx7JiBwKMd2tGDvAli6etfZJArsWjlsQOGdUZ+MhvAw+ksVputlC2lM
X-Gm-Gg: AYBFou0Oxi9ja8Zu3Inp5cdYGxmPc9ANaHaWAQycsfLoFtmGDvFAFX+EW7njIecKUAr
	daeTWE6o3WFSjTszxvOnNK/BjQeyJUHTU/XB/a5zDkBt9L4M3fnXfL9N9KPNCN0WjpwFvpGbBdh
	aDKRPxufFbutDtwJzVuUketK7iEPBGvaOLEYf6LY2zy5MOrIyFbe114jh7BdePCMokBbyWztfFa
	sN98FwQkgZ946wjCTajbBwh4d87m964d28+d+/4QV2R+UmsTYS4vUTiK0tIe+dfjrwQLcxCgyoq
	HTJOvrZ7MMutMnhOfLxCJmGC6IUYvO8yszL+nv1q+zwTy8XBxgaFUkpgdoFSXTyuSbPLgZMGmXa
	FWepm5n+BTwWv/fEYcOwE+w+ACrOI2sO+5OUweRH2x0wwPkpfBYfxP5KAN5t7JWy30yDf4rZaV7
	smaU7B5LmiMWI1BbdP992A4bQdxLe6sskV56ulEZ2Zt9vYVz6Cai26bmbRgkIhp1CWqjKIBNlca
	hkzWLFp+1weji2bnRUIsSc2qXauxrkkyGCFO07SmOcN4AfP7Ge20CyeAUZaIMXzeWTyv/t/JksU
	MNB4Hh5RYXCiDO7sFVAnTPF/9sYfeZig+g==
X-Received: by 2002:a05:6402:24c7:b0:6ac:9a44:d3fd with SMTP id 4fb4d7f45d1cf-6afad8eb9bbmr8191161a12.16.1791302598082;
        Tue, 06 Oct 2026 09:03:18 -0700 (PDT)
Received: from localhost.localdomain (94-255-221-162.cust.bredband2.com. [94.255.221.162])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6afb021a5e9sm5040641a12.29.2026.10.06.09.03.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 09:03:17 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v2] net: phy: qca83xx: read resolved QCA8337 link status
Date: Tue,  6 Oct 2026 18:03:04 +0200
Message-ID: <20261006160304.1563-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <179113606534.434549.7144959528343737840@kernel.org>
References: <20261003173210.1235-1-yongzhao.derek@gmail.com> <179113606534.434549.7144959528343737840@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Thanks for the review. I have prepared v3 with the following changes.

For the idle error counter, QCA8337 data sheet 80-Y0619-3 Rev. D,
Table 5-352, page 325 confirms that reads consume the count. My MDIO
model reproduces the loss with v2. The revision keeps
genphy_read_status(), so a steady autonegotiated link no longer causes
the extra MII_STAT1000 read. Reads on link transitions remain as in
the generic path.

For MSFAIL, page 324 confirms that the bit clears on read. The model
reproduces the reported difference when a one-shot fault and AN complete
are visible together. I have not established whether QCA8337 can reach
that combination on hardware. Keeping genphy_read_status() restores
the master/slave-before-LPA order and the generic error handling.

For MDI-X control, I confirmed that QCA8337 has no configuration path
that writes the crossover setting. The revision clears mdix_ctrl to
ETH_TP_MDI_INVALID after each successful status read, including steady
polls, while retaining the MDI-X status report. It does not add a
configuration callback or change the generic ethtool setter.

The revised model checks and arm64 W=1 object build pass. v3 has not
been tested on hardware. I will send it separately.

Thanks,
Yongzhao Chen

pw-bot: cr
