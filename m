Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0462A436BC0
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 14:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791124851; cv=none; b=qZBHSeIpAipqreMoRBdxCTu8BXZpg2EUOyANToIIfaDqvOZyYa0DeLwbDJZwm99YVnZ8MDBSm7qIUTqObsdjL9VtME1sO/RNthHPGEJT2vDFJowNw/GHhjO57MiyPcltEKhZeJ71lagYJVaOLZVxGRRvZWDluxXixKa8adSwim4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791124851; c=relaxed/simple;
	bh=NwJ3g/xjHBDOVaag4VNt5o7Nw8eoVJzvmV0XjfZWJTw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UIMijm82AFR68sljkxips7Hj7cZ0IDmz+y/52uOZOCMP5QH5uvgZ04X1sbARWttYlz2lnDHpHdb7ypWZPi+/2IGj1Xvx+u+mgoie8NfDs9KzEnPNgFbc0e3zFTswhtfw5+9ke+VeeJbjdBDQpCiRhYtwp/FxDwpmPHxGNX17TW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a1635f7c89so10098285e9.2
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 07:40:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791124848; x=1791729648;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rz6cs/vR0NyABn879K1Wzb/x9NhXjaOpqMscA8F5jZQ=;
        b=ZYY9BtIhcNLKUDKvHKiHuBDqICSVLPNKk9wfL5CS6XYPZq54uQTTitLYJ32KRSPVE5
         6vPq8cKxTUcPVGZ83nrj1PODQFkQESnjcgnbpsb/hEHUXOa82lzkK4zkWfhXTgL5Zz+I
         cJ5XgzZVzfSzoZjggZ/GF/APBuTz6Q5dkUOx8/Z5WNDNtHiMO7xqze46ECBZLF8en05g
         bDQ4FMDRVXOHqtb4mTjrm8i8W7S4rP0FfiwRBX9irReD1rEm+Y7yG4LnBno5Frq6NPo/
         2xUmC8p6hLbpxlUtOAJANw4SPh7K0yYlvYxn7D+ruRv1BtwFGgks0yUweW2Bgjn/19y4
         TseQ==
X-Gm-Message-State: AFuF++kyXi1CNDYvQg/ZMuZEC3Ne8qz67SnWPw633Sru8gXT8NudcSuz
	jpV4XgZQgfOM1HRJiiqoZaNIcwOyGRK/6iojGiWB8THMon13SD5JTg7V
X-Gm-Gg: AYBFou275lr053pmVSpLP9tMpdMmKypGoKOEhH1Pt7HARYEvY2ERcZNGlnIXg/Bzmr7
	Rtm0wBzdxP3cos1BYdT7A083p1M1ml2NW0UYEi5adID5AtHYnOoh06vJqpeY20iBKlfg2YCnMgl
	EgzGp0a6GzqXMXfWmBKJdV5trG8skVHeOyCU3DT6uDzUGhTUS2JynhlYWP4S9bFhS84UjVsflUs
	pJfHEyDKURBMgCNw+dupRZ6g+GpSanunHnpQ/IVU+OQ7E9y+p/DTSuuKjz5BoOAQyOInf/bRmBC
	uhdGw/f/RGSNVS64x2n8LwDMSMzYkKJMq5hfP94a/8hHYO1bLLQoft+ozHGrTRpwemPmDQhsnws
	8gDDajHYsG49JuySZzQOl/3sch0udrJFxtOz/eZtn7fg0R/cHoF/jpH5sJaYm9zDvxe1jo3YRhj
	/d/AQ0UAFxmrfxcmxVAEC3do6W/Kuo4XdzRqAucwrdzfbvhKnNynIhV6GJZu3GKVcd/IZd8NrSN
	Ef70g3e4s3De7gHYWs8asYeyAsgZF5sHg==
X-Received: by 2002:a05:600c:b90:b0:4a1:62b8:9aa1 with SMTP id 5b1f17b1804b1-4a1680b5402mr88402605e9.2.1791124847899;
        Sun, 04 Oct 2026 07:40:47 -0700 (PDT)
Received: from threads.localdomain ([84.68.183.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a027740a2fsm298907685e9.13.2026.10.04.07.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 07:40:47 -0700 (PDT)
From: Lucas Tanure <tanure@linux.com>
To: xianwei.zhao@amlogic.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Kevin Hilman <khilman@baylibre.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-amlogic@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [RFC PATCH 0/6] Add ethernet support for the Amlogic T7
Date: Sun,  4 Oct 2026 15:40:40 +0100
Message-ID: <20261004144046.391444-1-tanure@linux.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The T7 pairs a Synopsys gigabit MAC with the same glue registers the
G12A has, but nothing described it, so the port could not be used.

This adds the binding, the driver support and the device tree nodes, and
enables the port on the Khadas VIM4, which has an external RTL8211F over
RGMII.

What is not like the G12A: the controller reaches DRAM through a
pipeline stage with a gate of its own, sys_ampipe_eth. Nothing else
needs that gate, so clk_disable_unused switches it off and transfers
stop. The T7 therefore gets its own clock list, with the gate as a
fourth entry, and the driver requires it. The MMC controllers on this
SoC have the same arrangement, and that fix is already upstream.

Tested on next-20261002 on a VIM4, with "clk: meson: t7: keep the memory
fabric clocks running" (clk-meson-next) applied on top. That patch is
needed before any DMA on this SoC works. With unused clocks being
disabled normally, the port comes up at 1Gbit/s, 930Mbit/s sustained
receive, and no MAC error counters move.

This overlaps with Xianwei Zhao's "[PATCH v2 0/3] t7: add some nodes for
Amlogc t7.", which defines amlogic,t7-dwmac with the axg fallback,
snps,dwmac-4.00 and three clocks. On my board the MAC reports Synopsys
ID 0x51, which is DWMAC_CORE_5_10 in common.h, and the port does not
survive the unused clock sweep without the pipeline gate. I am sending
this so the code is on the list, not to race, and I will drop or rebase
whatever overlaps once we agree. Patch 1 is the oneOf rewrite Conor
asked for on that thread.

Lucas Tanure (6):
  dt-bindings: net: amlogic,meson-dwmac: spell out the compatible
    combinations
  dt-bindings: net: amlogic,meson-dwmac: add amlogic,t7-dwmac
  net: stmmac: dwmac-meson8b: add support for the Amlogic T7
  arm64: dts: amlogic: t7: add the ethernet pinctrl nodes
  arm64: dts: amlogic: t7: add the ethernet controller
  arm64: dts: amlogic: t7: khadas-vim4: enable the ethernet port

 .../bindings/net/amlogic,meson-dwmac.yaml     | 77 ++++++++++++----
 .../amlogic/amlogic-t7-a311d2-khadas-vim4.dts | 28 ++++++
 arch/arm64/boot/dts/amlogic/amlogic-t7.dtsi   | 87 +++++++++++++++++++
 .../ethernet/stmicro/stmmac/dwmac-meson8b.c   | 19 ++++
 4 files changed, 196 insertions(+), 15 deletions(-)


base-commit: f0406245cb9855e6318335a8a223551354291a46
-- 
2.56.0

