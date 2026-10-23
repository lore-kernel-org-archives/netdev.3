Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.229.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792741978;
	b=vMhwnPxbizSHsiATsPVtCPO6UCy6TcRzGABbDIrBWDlteo8LNZjvXVOW9C5uqDllVhca
	 hci5M2583NVpK/fP/qQACHfJf+2DB2K9xzO0zfyJxPUxNiJ4xYK0pSvk6Qg/rtYwscMUa
	 1z26oZiskriAdDo2y/Ufum1VasPH0ODVIlaXJqLu+UVgzeMaE3a5jD+IHleUuJ7P3VNCj
	 uDBOIT2H8rAvElCy6F4Z2HVKAQY2iI7aekzLfwhTFmRaHJYzVBBrwLt7c4dO02/NBpL3+
	 cwoLnVO5VhFCGl2UCB1MmTr6d9+huxITTus6LVnBH8fPWwXcsgww+9wM/mDsAFaOuKQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792741978;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=m6NACu8GwCde3sJ9HWwodKjqPsu0GwIqcYBIIRb4XxU=;
	b=02TUdbhaluVH+HCJ1aJ6VFmXr9RHTDLW+Ppk/MQv/BW6xzExi3A3AaEafZ8XjHZlvDIo
	 UuDavlWNuherGaeu8a0W1pe9eJFImuqmBlrI+An+gMRK7mGXWiW1ehCACRnw/akepwv6k
	 yVl4qQRYXmP6gYotUcYo3p1PnMLH2/B7sYRhU0d93LrFWB36u3QxPMnELDr9HmaodBqYb
	 MR7tMw3qxZ7nJ0XFdfJr+WmuBgHc1jTTXqh8J32GpMzmuhQj46fuXoZRiwrihwBZ/aeqZ
	 qNBTCXI8uHXVzCtnMIyABYvwIPkMTZWrcWpDK2peBoLY9DOC0JxBK4u43guMuiuiKdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H3ZAV2DL;
	arc=none smtp.remote-ip=74.125.229.9
Received: from mail-dy2-f9.google.com (mail-dy2-f9.google.com [74.125.229.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CECAD606A31B
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 07:52:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CECAD606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=H3ZAV2DL
Received: by mail-dy2-f9.google.com with SMTP id 5a478bee46e88-34cbc588a31so274623eec.1
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 00:52:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792741977; x=1793346777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=m6NACu8GwCde3sJ9HWwodKjqPsu0GwIqcYBIIRb4XxU=;
        b=H3ZAV2DLQCmcE9jz0z0t+ovC4iz5nkpjv4HoLg+uNtq/jyiLujnwqKWxu8tXFrmQdU
         oo5kdpzi3HSNG/f05gbf5QnIfNtN90/PnxNDK+12+qBNSJyRcAmu+4b3qT/pEYBJydev
         wyCh0dsHj+jAxAzf7Phmuhu9EvlfUtIJ+xcAJjQQZxZ0VjULKN5A5Y69EGtqSNphllPx
         KVEqxtdHI+v+gppHZiD2tyFBlDQNcKzjRmYuObACjixJTdx2JHCozSFh5zT9lHq7KwYB
         BSHmyIaGDXS4/cWyWpOQ9Ln4jMM3HZYdGj49n9Dpm3tN01ARjlu+mUUppoRToIf4pUm0
         YZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792741977; x=1793346777;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m6NACu8GwCde3sJ9HWwodKjqPsu0GwIqcYBIIRb4XxU=;
        b=xIecd0Z0qTWH+gk0PStxD7xF+nJkmFyg4lNHrO1GFvL5EyzSgM2YAGxqtFnvEft1Vq
         3T0LipW1KmORSxnXUrv7UOcda2loRNhTNlx7rV0iVrxYm6uwPc/QG2tqr13+YIkeXAW/
         7sIBseVa157ihvWKAE8KBV8dMYAxxudWhiCs9xQQAum22tNdqeyIr6UozRoj4QQOf2+Q
         Sif5ai9gYeRGoQY++ZUb1VKrDCZtCgFpwL5SuATLBXP8cAiZFgs+EPo5La5zQWvGlY5V
         oeXzidiO1MWsDuN+mtGCUpzdBSdi56l3G4ViSWYIoVKrP781Eq2FddZw+m8uIu40vOZ9
         R1UQ==
X-Forwarded-Encrypted: i=1; AKwUvBxDlVk3bmi+dv8eIjkCPi31KjvvwdVgXi/Rn6D0jvc+WLHjWS+r0cQcj82ER3/gTiz86WsBCmc=@vger.kernel.org
X-Gm-Message-State: AFq9FYIWYoQRsuKilnOV6p/W1AqC4qfeytUe4d6tnB/QxfkjUm7yOwb1
	mdm94tzb1hf+k26uSdtUEYU8Y5Rnzp0tzRzAXHbkPclwTFwH1sDJqxBD
X-Gm-Gg: AYBFou3zZoKJPylbLpPv0P+1HMSq+f/PinNynh+GZoqkm9MpaFxlbNiwgwxzQ7OvcZ3
	6ArJXbXUNvwHjJ4L6mcqTh1uGjjWlJ+WhHQefG49aH4IGeaj6lfUFxrwb05x8l/gJETsEFoi1Vb
	+1s1MSFFDguctDy0oIDWrOb3pyibmFB3Fzv/wW3+6ozEapTg0gdQyQSRkgHQTzvsHfU7DNYUJi/
	pNBBSXZKMt9HYKl/kdNIF91m0hxtte4Az9HIBbfGjCnHq+wQ4QosVucUY0JTYWuT5goPkr36hwL
	WJiZ//KnudkdAc++dUVqFsNASGmy5H7B30j17h6qadz1doPxSpJlSSVsbxzWHxLAuTtquJEoxm1
	NqK3vRC/IXsyBzJbKPfQd+ZDHkK+osZgzBA3Ezo60V9ydQJaU9jC6zuYFuziUDOzykzr6nTCzfF
	FImic9XRXQ72o2UuGQ2o/JG8Ve463WGsAt+UrswlvsnwliUqEQzj1hTeNLLp6EhAaA55u/twhX2
	b7U2o0JIbixWk19V5zsdORRdNadYL4F1sF41QX16rFvZW2Ezc2T6Q==
X-Received: by 2002:a05:701b:2302:b0:143:2968:564c with SMTP id a92af1059eb24-195c627d93fmr1822085c88.26.1792741976804;
        Fri, 23 Oct 2026 00:52:56 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-195eae0e830sm4122132c88.10.2026.10.23.00.52.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 00:52:56 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Coia Prant <coiaprant@gmail.com>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2 0/4] net: pcs: xpcs: fix runtime PM and clock lifecycle
Date: Fri, 23 Oct 2026 15:52:11 +0800
Message-ID: <20261023075214.1793922-2-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
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

This series fixes the runtime PM and CSR clock lifecycle in the DW XPCS
platform driver, a misleading error message in the Rockchip glue driver,
and the MAINTAINERS coverage for the platform driver and its binding.

The issue was found while using pcs-xpcs-plat.c as a reference for the
Rockchip XPCS glue driver (pcs-xpcs-rk.c). On Rockchip the CSR clock
(PCLK_XPCS) is required for register access, which exposed two problems
in the generic platform driver:

  - it calls pm_runtime_set_active() before runtime PM is enabled and
    before the clock is prepared/enabled, so a later suspend tries to
    disable a clock that was never enabled;

  - with CONFIG_PM disabled, the runtime resume path is compiled out
    and the CSR clock is never enabled at all.

Patch 1 fixes the initial runtime PM status and registers a devm action
that force-suspends the device on teardown, so the clock does not leak
when the driver is removed while runtime-active.

Patch 2 handles !CONFIG_PM builds by preparing/enabling the CSR clock
manually and disabling it in the cleanup action. It also switches to
RUNTIME_PM_OPS() and pm_ptr(), which are no-ops when CONFIG_PM is
enabled, so that the runtime callbacks stay referenced and .pm is NULL
in !CONFIG_PM builds. Because the CSR clock is optional and both cases
are handled in the driver, Kconfig is left untouched and no PM
dependency is added.

Patch 3 rewords the cleanup action error message in the Rockchip glue
driver, which was merged into mainline today and currently mentions only
the EEE clock even though the action also tears down runtime PM.

Patch 4 lists pcs-xpcs-plat.c and its DT binding under the DW XPCS
entry. pcs-xpcs-plat.c currently only matches the ETHERNET PHY LIBRARY
entry, and the binding is only matched by the generic DT and networking
rules, so the entry does not cover the whole driver.

No upstream platform currently enables pcs-xpcs-plat with a real CSR
clock dependency, so neither runtime issue is reachable in mainline
today. Because of that, no Fixes: or Cc: stable tags are included, as
discussed in the v1 thread.

The patches touch code that is already in mainline: the platform driver
has been there since f6bb3e9d98c2, and the Rockchip glue driver was
merged today. They are fixes to existing code, not new drivers or new
features.

Changes in v2:
  - drop Fixes: and Cc: stable, and state in the commit messages that
    no upstream platform can trigger the issue;
  - add a note on Kconfig: the CSR clock is optional, so there is no
    need to select or depend on PM for all platforms;
  - add a fix for the Rockchip glue driver error message;
  - add MAINTAINERS coverage for pcs-xpcs-plat.c and its binding.

Thread v1: https://lore.kernel.org/all/20260704214808.1566710-1-coiaprant@gmail.com/
---
Coia Prant (4):
  net: pcs: xpcs-plat: fix runtime PM initialization
  net: pcs: xpcs-plat: fix clock lifecycle for !CONFIG_PM builds
  net: pcs: xpcs-rk: fix cleanup action error message
  MAINTAINERS: list DW XPCS platform driver and binding under XPCS entry

 MAINTAINERS                     |  2 ++
 drivers/net/pcs/pcs-xpcs-plat.c | 62 ++++++++++++++++++++++++++++-----
 drivers/net/pcs/pcs-xpcs-rk.c   |  2 +-
 3 files changed, 56 insertions(+), 10 deletions(-)

-- 
2.47.3

