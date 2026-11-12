Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794459196;
	b=5gysVUfX8u/iLeyCAMSTDjxbTvXXWzG2wIvzFShFBMTUI9WQSxTqrxDxE98bwiVK8yAC
	 h9UKv13Uen/0f4NwSU8CPCPyHjWiWkTY2DVBv1hqfxtJ9sRfdvVxEwusdQ9moJjXYbKHm
	 l/mMvmer99P0qDMqzRhbsKaYth/Cajfwm6C8ooGxz+Hb5xOBV4LUzPLJnDnjTSCW5LYfc
	 d482a7fwzRNFR2WL2KrvmTlpcpO/ygCr3+ucOJ47HneTpcUFtYP+VLz537zPP32recgGb
	 +5+1wdT/oD3Shrpumd39ePeUoSw6sPEEXATR9dmDeXtvNYUDA3fWNY1kISLL1p2gJbQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794459196;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=okVYeTchHlDUEjmkDX7ZVgbGf0M4gnLDhPB3TlMpvoc=;
	b=Asn9XYaPc6uaE/5cNRl0F4JUPIOVkTSy/YAhNzBH+ms4foTamvnEaRCoAHZAyN1XOItx
	 GenQZ+8fNLDBfKfJHRN2rXB9qT1fIM0VORPwSHTEI42sXtDAKQWVq/dGUsQkgNsHSJN9I
	 FLjBSgEfE1BF46qRxz5al61rAOHMNx89D5WDp4hPTSomh3axywZUljZfIVq/On7553UTM
	 +s1wRohz1Y97p9c86/yr+4EyvSeeJ24vRV0SODXwLwaT91q0o8VOPB0Sih9tNqXwyuiTV
	 uafoUDUbIrDRRJD67RO5MlmlcwgfguQztnAIHWDSRGsawsTsvktrJqk3wQZ9SvB9Q/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SVtxpz89;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF02606A321
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 04:53:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4CF02606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SVtxpz89
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3720addb068so6928771eec.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 20:53:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794459195; x=1795063995; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=okVYeTchHlDUEjmkDX7ZVgbGf0M4gnLDhPB3TlMpvoc=;
        b=SVtxpz89LpCz0Tgds0uaXOB3UJsHC+opDCR1WU5CKGLUSqG/R+coHloRScN84FEcLb
         TTPo92+QufxonZ70vN7wfefkyasmRUa/OtzzFwcOZ4azOWHCdIXfYeJZEr7LbXQ8+vGS
         WqzqFm+n77qI6PmNcic9xu8XTPFdX2xV/o0aI2zn3BSv/n4OMJUQhGGxOPkZQLtTuoFf
         M/MZtcvCwqr1ji2MBvBFEq6S1K17WNR7YXIBMxizwQG53avfW9LTLatdiARXjgwWKXMp
         v8TpOdqGH7fzLRHTCpoQg++NPK9TTmVH2iFsqqpxBdtE3et71pQEIeKr8aEg4fUUCqB+
         NTcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794459195; x=1795063995;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=okVYeTchHlDUEjmkDX7ZVgbGf0M4gnLDhPB3TlMpvoc=;
        b=me61O+GzqbA5czuXgVN087fvmnlbAp4lmU/2NaJwdeSosov76MgMMIXkbzyRSit7V8
         4QFFZD4oIA65z20OkgIvxcaa/hG9BNT9SY1Qb12isnoq4kZCulv8bO8WzPa7xwn07N0w
         DIAkj2CJW9KtK1yvrZESoA/+GMXUO466oZ1yO1mdnmW9/ep0YS67rjT9MC6g73fYdd4A
         MqdiI67VbZsx/02OEPUfp55bFHs6UkAs0UsRK1ZTPAwgauq8SIlnP04l/ALsqOtsdks9
         1Jw2hXZTaGxO7W8S1mYUzrMx3nVk+IxVm9ErbQfzNlLtwBId/XJPtlrfzN2VTRR22tci
         ypnw==
X-Gm-Message-State: APuU4Z9VtP6YeiD0A3/TpPI/2gOtjbX6H9w7WGi8rcQwtFOyTjxsh2+k
	ehd1QGBbbZJZOdnjZpYZzg+s2NsVprC+UWXkowZCTcww3pjuv5YnqTj9Iyzbyw==
X-Gm-Gg: AYBFou2NaRkFD4rYGS/W6dZ3+GDalMRxgd6z2VuDnioLK+EmHWzy6W4WIt+3NxDPoxP
	YkjhPgqfEp5DJCP4VD3hs1e/H0Wjns/SdOR0w50r8pKbfIr76MmaliVXx30+quwp1ef1ZO44P5r
	ZGChiVOvZ1ceM0T47ZoIbY66pgrtl0X03gHniR7oXKj/eqhNQng8APDBDUNPIHVnmXoJq4m6cre
	3RcORcQsEDKpIeljU/Bupef7sffq6g6XZDBO6ovZV5L4x8NHGs7ZZ5/V0rK0zNRiExAqhm9N22n
	ZKst37AQ3cuUl40Fv75j3sNRPwMYf4ANR15HSmpAXtiStUUEMWP1JtA9VvMH0evP3f07n6djcOF
	II+z3hCbsH8fN/UG9NzB4FBK9np5wl743a5Vc0xxTClyCBWJfrR23XJiOtLxBHlAj0hjLykHhJk
	kUSqNIKLHCtl0dVGH4HgD8vNtQaIdX5lmsMx+CrVoFGShvWTW6OhyNTZKbg5mNLVlE0EdAT1Hv/
	ZD9csXYR1CMLEGDhBUgFl5rfSidzJCpaB5cCiJXnwxoR8HJwApU4Dy22ZnHSZrGcxhrlhzCSa8W
	55aHoQ30
X-Received: by 2002:a05:693c:40c7:b0:36a:15ee:c20e with SMTP id 5a478bee46e88-37686755924mr5584133eec.33.1794459195125;
        Wed, 11 Nov 2026 20:53:15 -0800 (PST)
Received: from eldorado ([2600:8802:b00:1f88::287])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37520cfdfc6sm23921585eec.17.2026.11.11.20.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 20:53:13 -0800 (PST)
From: Florian Fainelli <f.fainelli@gmail.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <f.fainelli@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Jijie Shao <shaojijie@huawei.com>,
	Simon Horman <horms@kernel.org>,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	David Yang <mmyangfl@gmail.com>,
	Herbert Valerio Riedel <hvr@gnu.org>,
	Jeff Garzik <jeff@garzik.org>,
	Danny Kukawka <danny.kukawka@bisect.de>,
	Mugunthan V N <mugunthanvnm@ti.com>,
	Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH net v2 00/12] net: au1000: Bug fixes
Date: Wed, 11 Nov 2026 20:52:42 -0800
Message-ID: <20261112045301.3669532-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This patch series contains bug fixes that were found during code
inspection and also during fixing the open/close/open issue that was met
on the MTX-1 platform.

These patches were tested on a Meshcube MTX-1 board using targeted tests
to ensure the multicast and open/close/open bugs were fixed.

 Changes since v1:
• Rebased onto current net and added the Alchemy PROM Ethernet-address
  lifetime fix needed to boot MTX-1.
• Reset the MAC after PHY/MDIO teardown, since final MDIO accesses can
  re-enable it. Avoid accessing MAC control registers when its clock is
  already disabled.
• Use sleepable polling for MDIO write completion instead of millisecond
  busy-waits.
• Correct TX reclaim ordering by advancing tx_tail when submission
  reclaims a completed descriptor. Consume transmitted skbs outside the
  lock using an IRQ-safe helper.
• Restore receive filtering before enabling RX, holding the address-list
  and device locks to keep the programmed filter consistent.
• Rework startup ordering to resume the PHY synchronously, initialize
  the MAC, then start the PHY state machine. Clear cached link state on
  open and use acknowledged link/duplex state under the device lock.
• Move the LAN83C183 recovery-delay patch before the MAC/PHY sequencing
  change.
• Add a TX length check to prevent oversized packets from overflowing
  the DMA bounce buffer.

Rebuilt the kernel and root filesystem and regression-tested on MTX-1.
All 11 boot-smoke checks passed, including 15 down/up cycles across
normal, promiscuous and all-multicast modes, opened/closed and
never-opened removal/rebind, and connectivity recovery. No kernel
warnings or errors were detected.

Florian Fainelli (12):
  net: au1000: recycle RX descriptors on allocation failure
  net: au1000: clear all-multicast mode when restoring hash filtering
  net: au1000: disconnect the PHY before freeing the MDIO bus
  net: au1000: report MDIO transaction timeouts
  net: au1000: serialize TX completion with packet submission
  net: au1000: assign a valid MAC address without platform data
  net: au1000: fix buffer descriptor free list insertion
  net: au1000: restore receive filtering before enabling RX
  net: au1000: restore RX buffer addresses when restarting the MAC
  net: phy: smsc: wait for LAN83C183 power-down recovery
  net: au1000: keep the MAC stopped until the PHY link is ready
  net: au1000: reject frames larger than the TX bounce buffer

 drivers/net/ethernet/amd/au1000_eth.c | 140 ++++++++++++++++++++------
 drivers/net/phy/Kconfig               |   2 +-
 drivers/net/phy/smsc.c                |  26 +++++
 3 files changed, 134 insertions(+), 34 deletions(-)

-- 
2.53.0

