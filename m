Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794120767;
	b=Tbf7qaVy1jL6YRejQp/mxoir+17omrSPBieUdMXvIid+gz0lk8Y19GVZHdGkO/7bvV9e
	 a2nPYKXBPv5S/XxKvTKwHi3dPhyxO89uqrMSyDV5ceLXUGgiM1+LVcd0fA/EDcshZjDlF
	 GyVAWqBeZxud+Upsovsbst4LDZytk62tRXxCaXvhPkKx/nusxZdlLTBKcUdky4DLgE4sl
	 TwLQTedAYp/+A33pnTkBOOR5oWmxLl3SEC3ZLCsUh4nPVGQuqwqStBls3x+G7UCbh2Acz
	 HW9O5k9r85yvS/17R9JmQ/cEEZoQNdX1dkyLXyfbFGeueFyXnAUY4/oduNfZkUjbbLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794120767;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 X-CFilter-Loop:Received:DKIM-Signature:X-Forwarded-Encrypted:
	 X-Received:X-Received:Received:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=3WlWk2JC18GIhSQsWjrKzpKLV3e7ocI2JTFms6WNUGw=;
	b=eQko9UrI6ilSTYoIMfucuaVnyOhfGDSl8v+BaAU8+K0ah+uKCNAEWB2E4rDwBi3/tg0a
	 ojqwIWABIgAv74ecl+jLGsubC9gPpKovLs1Bjd2RclH5IRSA33tBaZrk5N66Kv5uVr1zI
	 tVtMqZMhcfOJ3HIUEbtcvKWglKRjMhfDCRFNOdQOzQrPlc3VrgmC2ulKu3I/k4fRxCSR4
	 gOYoBE3AO0oA4wZDvCrOWk1FOmQthSdWYM78aO1hPYblGf9UxaQYxQ10z1Wme7Cacjfpx
	 OONQkqPlRkMqNNTOTDdeS3IfPwLgYjU3VICz5CJCQ6zNrfXptSC/hs14z0Os9l53hEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=gxMmt0E2;
	arc=none smtp.remote-ip=209.85.221.225
Received: from mail-vk1-f225.google.com (mail-vk1-f225.google.com [209.85.221.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9B5606A31A
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 06:52:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F9B5606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=gxMmt0E2
Received: by mail-vk1-f225.google.com with SMTP id 71dfb90a1353d-5c9e7731b34so198038e0c.2
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 22:52:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794120766; x=1794725566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=3WlWk2JC18GIhSQsWjrKzpKLV3e7ocI2JTFms6WNUGw=;
        b=pNiReG2KqRJZ3nBMf8dKlAK85bKS29ghewawMET1cJpsqv5qn5p8xjamQIhj7Dbj+7
         ElKEn8rE2FKQmKyMTYQAt3M1GcI2tZZUFASNKjGh6qdYT6qGZluVo6J5ZDqLmmsAx9wd
         j9bO4Rf2b08bimcYctOxLiEFxybOWoni5YWm4x0JPoTDJVQmnjKOXebQy4VgCsMQ4R+2
         v+21uPS0OVREmSMn9sMLg0gPzhIbnM/BuVH9FkrIDHDRLEjFSD4rOJDmPl6O3SqALat6
         Vn/1a+TEBKOmB1WtDjH/hVutu/1iqPMdlOfHPn5+8sN3jf7vWZjvbMGN0zy5RH3g7zPI
         Hwhw==
X-Forwarded-Encrypted: i=1; AL+hErGMBiEIlI2XUTaJyXYaaWtzI6RnZl8byVM9oKWa2HcC6rCamk+a952mX163gP3rS4pJF3xJTXg=@vger.kernel.org
X-Gm-Message-State: APuU4Z9xEZpCs40PcJNtbZJAEp3KzQL3BBi2QNsP+mfABVinCXuFKh/Q
	saamuHeFEM2Dzue9TXXooyaxWc8f+dip7KN7qU9P5XIp6+Si0NzNeheOTlYE6O5gSQ3AuGA4qtn
	FvQZlU5y4j9Mc9QtYjtPi+QkUGTNPqFakA6NfVa951oRGoeK1fArb6t98S4nIWqZZvgmXXItRle
	of5BBtPkw78qUUEVD4AtqAn0xTIHXIZF4yEHzn43w1MJ5v0/P4XAIhzULvKacTAxanRIgTlMdOb
	bk8/eRsPn5i5Q==
X-Gm-Gg: AYBFou3CQI3Cdk2VbnhO7WOzgLEDDP/4CHiYRoMSj4bTUfkqLhSexI/xwKZ+z1c+6BJ
	gMCvb8IUzq7D37abt4VCuW8WbVk5tKlGZpgxHjCN4Od+Qrv2BRK0AOCFGWPSvC0+b/jb7e9RdYF
	/MNQj3BzLbtMzk4RyXTIuAEpNuKr5hLVzgRyiNOEKXwxAFmQg2ohDnb4A6ApsMSUL0xTMqF9CQF
	AV3m0t8Zj83hjJqJ1GenLjIWXsfTxRnP9y2ZJV6zzZVi3py9nXTjCtHdDOfT/dxVqw68TLvKNfb
	mAzHLkQ1oUuQYE+khyaXg4K5/aIRsuefXOmRWYb/eTd3kzSMfg5P2A977jWHDuPiEqllZ3VeJwi
	FdpsxV+JgvjVUg23tshdJqvWMsyoT+e29e5fYV2Ki1NdFKeYN8gKeceXC2h6kADvYSLu2u2EtGo
	V8PnRysOGnC6srYbxNODZH8RcEIqfTXCYEktk=
X-Received: by 2002:a05:6122:e22f:b0:5ea:9843:fc3e with SMTP id 71dfb90a1353d-5ece73577e2mr316106e0c.19.1794120765922;
        Sat, 07 Nov 2026 22:52:45 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-5ece66aff6asm8930e0c.19.2026.11.07.22.52.45
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 07 Nov 2026 22:52:45 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-36f479b9819so570669eec.1
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 22:52:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794120764; x=1794725564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3WlWk2JC18GIhSQsWjrKzpKLV3e7ocI2JTFms6WNUGw=;
        b=gxMmt0E2rtaA5AQ/r4g9DYEi9gNLGKDSj4frYkJSBZvHynreYOe9DRU7A+zhyWgMtP
         aI0Kn+2skPq935zgviGCotVRvTQ/Ck/t779HZfsk5s2xvM+j9UguETpVkEEFBcODGrcf
         hI+Wwqp61JF94xDQxkYCYQsvCtHZQlH0rJmLg=
X-Forwarded-Encrypted: i=1; AKwUvBySK1Roj+2YMcHBNzbEF8DOkfETwpN9PUUvSc2LtUb36Rah7QYHu2pnd7twSuY8cJlIGUYfU0o=@vger.kernel.org
X-Received: by 2002:a05:7022:f10c:b0:143:2968:564c with SMTP id a92af1059eb24-1b39fea7271mr1019627c88.26.1794120764105;
        Sat, 07 Nov 2026 22:52:44 -0800 (PST)
X-Received: by 2002:a05:7022:f10c:b0:143:2968:564c with SMTP id a92af1059eb24-1b39fea7271mr1019606c88.26.1794120763382;
        Sat, 07 Nov 2026 22:52:43 -0800 (PST)
Received: from pc-hpe-top-git-sendmail-server.dhcp.broadcom.net ([192.19.234.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3755e8a27sm3497993c88.7.2026.11.07.22.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 22:52:42 -0800 (PST)
From: Pavan Chebbi <pavan.chebbi@broadcom.com>
To: michael.chan@broadcom.com,
	kuba@kernel.org
Cc: andrew+netdev@lunn.ch,
	andrew.gospodarek@broadcom.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	Pavan Chebbi <pavan.chebbi@broadcom.com>
Subject: [PATCH net 0/4] tg3: Bug fixes
Date: Sun,  8 Nov 2026 12:25:22 +0530
Message-ID: <20261108065526.710152-1-pavan.chebbi@broadcom.com>
X-Mailer: git-send-email 2.52.0
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This patchset has 4 fixes.  The first patch restores probe on 57766 when
the 31-bit coherent DMA mask cannot be set.  The second patch makes NCSI
PLL lock on the TLP clock to fix WOL at 1G speed on 5720.  The third
patch fixes ethtool -i display on 5719/5720 when NCSI component is
missing.  The fourth one fixes a possible heap overflow in the NVRAM
write path.

Pavan Chebbi (3):
  tg3: Don't fail probe if 31-bit coherent DMA mask is unsupported
  tg3: Select PLL clock when preparing for shutdown
  tg3: Skip querying for management FW when no NCSI present

Shravya KN (1):
  tg3: Fix heap overflow in unbuffered NVRAM write path

 drivers/net/ethernet/broadcom/tg3.c | 48 ++++++++++++++++++++++++-----
 drivers/net/ethernet/broadcom/tg3.h |  6 +++-
 2 files changed, 45 insertions(+), 9 deletions(-)

-- 
2.52.0

