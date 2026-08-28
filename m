Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 707BF36F8E5
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 09:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908886; cv=none; b=KlRJwFtfJcxbBxZelSd6cB7WdNLcOsPh80vol08HBn5yNA1QEPSUf3m+2W3EMQ5a2oePIJmTyVbVmNdExr4LOnH9ckprCFi8IFSuf7ijXXZUpqiw36IRjv5bIgwkHxnycPftaZQtLVOWQN1fy1u2cd7z4POZE0u/1n27I04Utbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908886; c=relaxed/simple;
	bh=gCDgYIAqpTUqwpKTh4+l7//IeCxLcoBCbnVmd8f97XM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MqhrbQ0rZdjqH2cLzOEC+3f9B7WG3KI2zrCxf3qb3s8rS2qogbKgxoPWyWOgVK88xQNGMXagautljMT6BAAxQ7N0rPIhBgzqFz6/4XjSejorPWUzQTGxqjo+HIrzxSl3tjnJLNr/gNtfvq5O16ZjnWc2xK6xSHTZLEM2J3qCayE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iit.org.ua; spf=pass smtp.mailfrom=iit.org.ua; dkim=pass (2048-bit key) header.d=iit.org.ua header.i=@iit.org.ua header.b=JnsD00QM; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=iit.org.ua
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iit.org.ua
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iit.org.ua header.i=@iit.org.ua header.b="JnsD00QM"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-496bb7cdf51so8602225e9.2
        for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 02:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=iit.org.ua; s=google; t=1787908881; x=1788513681; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HsKeJOW+Bil94wXqWOPmt1KLTCbx937cutH9eBfGqgA=;
        b=JnsD00QMv8XsWFB1SohOlyXty5hjNtl/pZRJU4BToYPAYyo6xc1TlOFSA3mGtWt+M5
         ovZzC4V/GlC99P7Tw2XGkD06rdv1gpIfFSGscDZ8l8+/V5w8mpjp1FXkar91E0pOHkXR
         0nN4X5AjvWq+MOCMU7ZS8NbG1OwltCnz4ZcJMzVklaWE3Td7pttynoIRHR7KVn4aljUQ
         5fBW19dQ599uk8qKsAxPOnJ17NAkicWX6PIXUkKJuEn3a5MqDjJ9OfqfIAAVhS0zYu88
         CArsUJ5tmJzqX1Okp6+N3C7vIoFv05rGEmB/GgBcD9HCzi1wJv1z9sVMPlHPsbv7t0Wy
         7yOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787908881; x=1788513681;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HsKeJOW+Bil94wXqWOPmt1KLTCbx937cutH9eBfGqgA=;
        b=ZWHyYoIZl9txWb+Xv7SAuG2oqYSrQkcEBBmxOGEaqFcb6rnt4bV49tBhDELiJk5lHa
         BMvUvHW8dxHYXHVGDx/Qkz2c9h/ZoO0RVzxComks+2nIxSdrwJoHoaJsNdzfsg5R/rhJ
         VHPdz4P9bdRxSiiMFKvDFPfHj1g55HatZAOmZAd8VGKG5vc5GiMxWOB//cQI/g4xacsN
         MH8JxV3GA1fM+gfLPDUVHRSmR+g1XcLbNeP/QT1AO3mTgC301EueeMd3JkVlwCthNt15
         UwGbYX5WXTjQz53Bg+nZEr9UHT7jhsBdpMAjHES4PAM1JzOXFkSTFI4ZU/ln1y2zRM51
         omNg==
X-Forwarded-Encrypted: i=1; AHgh+RrQhG+wB+tICVBK0TXfXQfqxrMEKF3OaII3wpyG1kAFS4h9U0mYXjUGLFdlWLUIh9jDq5Tp5l0=@vger.kernel.org
X-Gm-Message-State: AFuF++lehXvLBrWwBRNMbQwi5iLGpz8c078Cks3Zknv9YQurC+eNxwmJ
	8y7tBaFN0bIETciuQiE8rbJFj9sEuehXYWk16MkU3wvYpfYy2peuWjExfnaHTAgJud8=
X-Gm-Gg: AR+sD137WXNBEI4B5YcJpPtbwvrvF0RToY9xRqFK/6jp2wL7IroV4/9ghBZrb7wNxrW
	bj70zoQtudOXhjQvIZUzLgaRh3GWiPf+eAXwv/Jm6jF0oIkeZuRkcJXvN3VrCKPDotOZSAiLCvz
	w1iCASwFCISNhxnhuDRlYq3qS6DRs1n4ZDkG6oX4yvdCMmzLBJ3ozyXlYZbvVdCkDLOUdeAboOE
	OiHOvjJ9paz0M3dz//nin9Naz0MWcrYZgaKapGaR7k+/SXR/LkSdzmtrL+zg1TTibk973TQhJnA
	tcHlcQtwlSTTIoiAmt3F/NHJmRJv2DKKleYI/8NM/xQtLi+Wu8k2SjjysCnPsFNN03kIhUExEB3
	DrznMXJkxIYNRFf3gk2db7j3zmeTwnmWf3ytWgDL4jF2FN8G9XEO+9UblnTwQxCjhATn5kAJ8N+
	5lYjqJ9ML4E9nfWPKgePficdwIWFk+q+y7Y+Qz1Hh2Ar44nsMVb0iKxA==
X-Received: by 2002:a05:600c:1394:b0:499:83f1:398 with SMTP id 5b1f17b1804b1-49b91c47b6bmr66784225e9.9.1787908881460;
        Fri, 28 Aug 2026 02:21:21 -0700 (PDT)
Received: from archbtw ([212.1.106.18])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b497fa9c5sm111484255e9.4.2026.08.28.02.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 02:21:20 -0700 (PDT)
From: Stepan Svatenko <ssvatenko@iit.org.ua>
To: Raju.Rangoju@amd.com,
	PrashanthKumar.K.R@amd.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Stepan Svatenko <ssvatenko@iit.org.ua>
Subject: [PATCH net 0/2] amd-xgbe: fix two PHY/IRQ lifecycle bugs found on SolidRun Bedrock V3000
Date: Fri, 28 Aug 2026 12:20:21 +0300
Message-ID: <20260828092023.105405-1-ssvatenko@iit.org.ua>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These two bugs were found while debugging SFP-related failures on a
SolidRun Bedrock V3000 (AMD Ryzen Embedded V3C48), on kernels 6.15.5,
6.18 and 7.0. Both are longstanding (dating back to when the affected
code was originally added) and independent of each other, but touch
related PHY/IRQ lifecycle paths in the same driver, so sending them
together:

  1/2 fixes a self-deadlock: xgbe_phy_sfp_detect() holds
      xgbe_phy_comm_lock across a call chain that can re-enter the
      driver's own MDIO read/write callbacks, which take the same
      mutex. Triggered by removing an SFP module while an external
      PHY is attached; confirmed hung via the kernel hung-task
      detector (368s+ blocked).

  2/2 fixes an IRQ leak: xgbe_phy_start() can return an error after
      already registering its AN/PCS interrupt, without freeing it
      or clearing state, if xgbe_phy_config_aneg() fails (e.g.
      against a non-functional SFP module). Any later retry then
      hits -EBUSY requesting the same still-registered IRQ forever,
      with no recovery short of a power cycle.

Both were hardware-tested on a SolidRun Bedrock V3000 running 6.15.5
with these fixes applied: repeated SFP insert/remove and interface
up/down cycles, including with a non-functional module, no longer
trigger the hang or the -EBUSY loop. The code paths touched by both
patches are byte-for-byte unchanged between 6.15.5 and the tree this
series is generated against, so the same fix applies directly here.

Stepan Svatenko (2):
  amd-xgbe: fix comm_ownership mutex deadlock on SFP module removal
  amd-xgbe: fix an_irq leak causing permanent -EBUSY on PHY (re)start

 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c   | 14 ++++++-
 drivers/net/ethernet/amd/xgbe/xgbe-phy-v2.c | 41 ++++++++++++++++-----
 2 files changed, 45 insertions(+), 10 deletions(-)

--
2.55.0
