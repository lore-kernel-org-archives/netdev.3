Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AF33515D9
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 02:11:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785118278; cv=none; b=qNkpa7AeWzozEqTpxB2nSftqUESpW8D+gH8mAlYGxYnXKHM1pXq0aDyjQpDh2deINmG9caO59AkAZiKX8KPJR/qn+k0LaRANyDBMruTG8fBLhgNCtRPWly++QIN9h2X2hn6MqaSQPatrdNZeQs+IFl5JUqa28yNkZEUcrwRfMnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785118278; c=relaxed/simple;
	bh=idqaJ1zW0f6pRD3+LKzzW42z3MhH+7aIMsIbm9yfVyo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kQjmXJ+a1KBwO+yitNsQe/60HD7cGYhoT0qKHGgInfcTQv72RFW7kRqBD/6Ygt7UYt8XpwLW6qBv7uvc1g89snbZNkYv3L1ztxuU27cu4yUGs9hPLNFJarPSmUfwl8QRrhBPOVR/Et5DB9OCg2Q2RUdjevgtKTKBiSeMhWJHGOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FreEkvKx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FreEkvKx"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8485bd28dd0so2247627b3a.2
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 19:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785118277; x=1785723077; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JN7LEuMudq1mUi6BCPF5860crqnrJNZXCJN217lSS6A=;
        b=FreEkvKxYyBSh24XgGQnTaPeCALufyAFCQoQMpWWPEv7o8Ln4DNDfoPB+rVNAKnNwZ
         JrKEH3N0smbDvqcvs8zA9yddLjLxXneTNfz/smnkvAT9SKQW3M1knNSLeh6GvmaMRK+l
         yXNbzwfenBBBl8B0puqF/K8cbPY6GDOlTuUsHmZky1703G2MUKPCZf62GmP53gh+/6vQ
         OW5CTUAvEnqTH2MQE/5zSiAiELSnkTJ1nGZaDdzm8hDWhc2NFqAsQA/gmKVZdnAyMHmv
         w+KEDumEfdT5VUAOIpfepwS9ikmDStqTxkmVuur2YayPLesN2LzGVtlUJ60c6kUPX0Ps
         cxeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785118277; x=1785723077;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JN7LEuMudq1mUi6BCPF5860crqnrJNZXCJN217lSS6A=;
        b=CsfYLbDqeHwQJ3QGMTHPeptmce2+x7+M3cs554nUM2Ef8WEgCLQVDT8/XVUcbS2ApF
         cq5OFLIHZ+wS/pnMY65NShEXWpMDd3f2dM5o8SW81G++TmtAbxFarbN8NXRljgbeEYeI
         gBpiNegQe/5MxhusurKmbOf2DwB79LqWUweAXqBzBYLSSjM56NQBB0y7cDmd0t9cpl3X
         3W2GJtdXL27CkxvLyD51pMEZo769uu+W7Kk1kM+imhATL3uu90UaHkSnfRVroLpwmE8t
         1i2yxfI+ZOvOZfdbvJMn6FZvLc9BWU+T/uMiOMxBNiBr1KEvLLJwR7z7+wx91rlHqfOv
         9zfw==
X-Forwarded-Encrypted: i=1; AHgh+RqrqWsipyQvpq/9be1deQj9auMV80i0Clp5DNaxLC7KYbnURf3BwSiGbyntrL4lJZzZJhBCDiU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLd4AifY7F2QKPmm1VUyh6gHP/YOUcH+0adECzWQpj5SQ9yRNC
	wjfKKSko/x53OLoKhu0NqliMT+whv/0Vj68knSLdLjCSzbHRg1O3wA5V
X-Gm-Gg: AR+sD1326f7COc/IdySAY1QrAQAVpZMdrEs6BY41wm1drDoCV1tB1+ku7XZn8p8PxM2
	p+gye3wmYpgEnPBTY+M3CF59YgnYUPPc/pdVNjqS1BdyfykyvqzW2t4xDvHio3LGRUllS62BfhO
	vf074Ab2gyK2nWk4SfQBFFNko+CPDr+XeqC5oo/C+7ZWHRok/HIPDYbM6sB9YMOY5nS2PRlxx4F
	p9Jf7RV8Um4x3Mopu6GkEOWY4SFB0iMVU6OqY+dEGmwggOtiytPQJIdVl2qWCPfMoiQFn48JMKQ
	d4kIfo1DMdjbJp9ijLULJARvA2AuMJmB6i9z60jQOb82Iqoh+CgjeRHWlB+yEBiUB8iGAxIS6IU
	h82qhe4jwMaF5jbdVW3oNA+xXkHz28kV0LxJxJQQ5Stl/xXskf+zUesRQ+sUBP/UKFQoDVSpeNe
	OkY6aL8VEo6igQJXSSi0hY7+w=
X-Received: by 2002:a05:6a21:8282:b0:3c0:9c1a:8936 with SMTP id adf61e73a8af0-3c67e131180mr5856351637.62.1785118276966;
        Sun, 26 Jul 2026 19:11:16 -0700 (PDT)
Received: from attina.synaptics-inc.local ([199.33.119.15])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13e53094d65sm19162200c88.13.2026.07.26.19.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 19:11:16 -0700 (PDT)
From: Gavin Gao <attinagaoxu@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	heiko@sntech.de
Cc: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	richardcochran@gmail.com,
	nicolas.frattaroli@collabora.com,
	sebastian.reichel@collabora.com,
	sashal@kernel.org,
	alchark@gmail.com,
	chaoyi.chen@rock-chips.com,
	attinagaoxu@gmail.com,
	amadeus@jmu.edu.cn,
	rmk+kernel@armlinux.org.uk,
	horms@kernel.org,
	alok.a.tiwari@oracle.com,
	david.wu@rock-chips.com,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: [PATCH net-next 2/3] arm64: dts: rockchip: Add RK3576 GMAC 25M refout clocks
Date: Mon, 27 Jul 2026 10:10:46 +0800
Message-ID: <20260727021048.3375444-3-attinagaoxu@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260727021048.3375444-1-attinagaoxu@gmail.com>
References: <20260727021048.3375444-1-attinagaoxu@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

RK3576 provides REFCLKO25M_GMAC0_OUT and REFCLKO25M_GMAC1_OUT clocks
for the two GMAC instances.

Describe these clocks with the clk_mac_25m_refout clock name so boards
using RGMII output clock mode can let the MAC driver manage the 25 MHz
reference output.

Signed-off-by: Gavin Gao <attinagaoxu@gmail.com>
---
 arch/arm64/boot/dts/rockchip/rk3576.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3576.dtsi b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
index 70e67d4dccb8..f1125c2f88ab 100644
--- a/arch/arm64/boot/dts/rockchip/rk3576.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3576.dtsi
@@ -1692,10 +1692,10 @@ gmac0: ethernet@2a220000 {
 			reg = <0x0 0x2a220000 0x0 0x10000>;
 			clocks = <&cru CLK_GMAC0_125M_SRC>, <&cru CLK_GMAC0_RMII_CRU>,
 				 <&cru PCLK_GMAC0>, <&cru ACLK_GMAC0>,
-				 <&cru CLK_GMAC0_PTP_REF>;
+				 <&cru CLK_GMAC0_PTP_REF>, <&cru REFCLKO25M_GMAC0_OUT>;
 			clock-names = "stmmaceth", "clk_mac_ref",
 				      "pclk_mac", "aclk_mac",
-				      "ptp_ref";
+				      "ptp_ref", "clk_mac_25m_refout";
 			interrupts = <GIC_SPI 293 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 298 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq", "eth_wake_irq";
@@ -1739,10 +1739,10 @@ gmac1: ethernet@2a230000 {
 			reg = <0x0 0x2a230000 0x0 0x10000>;
 			clocks = <&cru CLK_GMAC1_125M_SRC>, <&cru CLK_GMAC1_RMII_CRU>,
 				 <&cru PCLK_GMAC1>, <&cru ACLK_GMAC1>,
-				 <&cru CLK_GMAC1_PTP_REF>;
+				 <&cru CLK_GMAC1_PTP_REF>, <&cru REFCLKO25M_GMAC1_OUT>;
 			clock-names = "stmmaceth", "clk_mac_ref",
 				      "pclk_mac", "aclk_mac",
-				      "ptp_ref";
+				      "ptp_ref", "clk_mac_25m_refout";
 			interrupts = <GIC_SPI 301 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 306 IRQ_TYPE_LEVEL_HIGH>;
 			interrupt-names = "macirq", "eth_wake_irq";
-- 
2.55.0
