Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7D348382E
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792146650; cv=none; b=VqzXor0Fxu1U+6SrggVeJzoO8Xc/mzjacOKyBwCLXsMaRC8X1BQlvkFJaOXT2DSB7VEL2z2LdtL56HP2h2xzekT8W+/7QpFgBMN6Q2KkrXVMQEca5FfqNHaH7jURy8KtgZ+qCSL1Cxse5bI0tH9xVP3tOsvGoksEm1o2iWuMtLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792146650; c=relaxed/simple;
	bh=BU4GHjU/addW49Fi5owY8SmKZGnqIixi6vq82uwwdHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=O531VPb3Gb1UDoVpeG2jLzMraAJJfPMQGdij1CZhzBdZmekmxu34A2ZsFA8R9a0HY9zT4QKvHVcb4uVyyIvIk8ET7EvQXPlHEdomtKxlQ+NTtyyqVDiIUQkc8ZMEh7zHRvfp+sldG5WQE1llUH+RL8XMMPgXF47uj6bShh4hnME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7BFCT/E; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7BFCT/E"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-c2acc1e170cso1062674466b.1
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 03:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792146647; x=1792751447; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5k/Nx254skplKaHZfy+hhUKCjKjMi13IPnfogdi4XtM=;
        b=S7BFCT/EMivHs3GpxR8g2OGgep6n7aljN6TgWLs4Dkcw063iO/HCfXTfx+SbQJfv6h
         VONgebflpBCSV+6JvBMvwSEQOt9PqWNOYQue1ZYUAah7pF6eK48nb+qTfTbIaLtK7wCQ
         6KiuACMDYnGEvOs1eDqgoIwsb3yur7GCeau/zbSId599Jb5dejMKtr54BigTL0ND0T2P
         ifwIheMZecu00LspxeNEy4HD0/yDnVRFa5rBnVIwDKBuQz9iubwDLzhutgMfN2KLUyxl
         3Jn7GTptQtVEaNy8u5PnS+HeqcMyGK0ZIqvk8jVrncOAqoCPOuLqjsqTCdRm31e+ND6l
         OMdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792146647; x=1792751447;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5k/Nx254skplKaHZfy+hhUKCjKjMi13IPnfogdi4XtM=;
        b=LDBAaZBmR9QUpbn2kQoWZUegl7oIQ94P5xlzoGIs6oFOPZ1R86Ju71tldtftxP7sB6
         cSxBrIkgn5znUu+jBL+wSQ4rRcFAFTUUnbNYXPFEuuQeaIAc3UTiX7VmlWXCdv3h0+aw
         35mX3ux8sU8e2pE8uGLuZp1BRW0zGqmN39Z8V4wadHj4ECCBTfJaf1r+eT5M+ZU0Klsh
         VWXdCfkwcVUiSR/wMng6yEeDaacdedSYj2qDxRy2MgUcrpo9btXz6vx4iHuSaYo90ggk
         gFdi0LhvsAzgB9gFOt67dJC1kKgr8DCpYd8EKeyhevByS6crr6xv5+NTA2M1lwuVtYTK
         hEFw==
X-Gm-Message-State: AFq9FYJQGmrawjt5JPqNLCdDY0ETHVrfsTyblKUtivierSEpl4C1Bgo2
	+rfVA809LGS16pVpKAnDU+rSMgMGEC3tnYZ40SQJHoMc3iC6Vqix4Ppx
X-Gm-Gg: AYBFou3gxfQ0ZBI5BtqWgXJv45ZjVliOX0o5K9xoIGtwd9/cEobawDBK0R+KyXvbMSy
	pFycMtY8df2O5iYf9x6clh2NO43YlFbL72FkUYwjUoB7kE9N0geeRfxvmU+LU63Qa4esp8T5Gft
	ULGMAaSh7g2fkjWrVrxFzdPHVTLkHUQ5xz8a6LcZ7Fql8U71TRQyASIg2l0HUC9zCbudg080SaD
	QekeN9uiyvfhb4eueosPeEkLalsWqeOghG/6j1EHEWe+1cM2ZCMzuKcNcJa70r6U2BJsO4MTgWZ
	y9ufvPJWr/aRFzKKjlk6Y5vFeFbnhyt5WzrrvzRwRC/4SuDF3qSnEtEg0sgT6bfOECtUpx7qZfc
	j/5pFvNKCFYBydJvLRSxu3rkMgMIirmqN1GRoW/KYi2K1G/KJDURxKMo9li5pjEOvq4dFF5T6u4
	QCah1UsmYmc+LBgeq6c0y4nlza4NUDyoRA/p0HTmhKG6AAQ3HGZomJl9K2fhcaZmwyXjMjEFTZn
	0HeNS1I1eNo
X-Received: by 2002:a17:907:d1b:b0:c29:4a1f:76be with SMTP id a640c23a62f3a-c31aa013b5bmr2062189666b.20.1792146647503;
        Fri, 16 Oct 2026 03:30:47 -0700 (PDT)
Received: from localhost.localdomain ([193.107.16.241])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c40912ce133sm60613866b.31.2026.10.16.03.30.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 03:30:47 -0700 (PDT)
From: Dmitry Yashin <dmt.yashin@gmail.com>
Date: Fri, 16 Oct 2026 15:29:37 +0500
Subject: [PATCH v2 5/5] arm64: dts: rockchip: add FIT-PCIE-SATA overlay
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-ok3568-c-v2-5-068d68430e6d@gmail.com>
References: <20261016-ok3568-c-v2-0-068d68430e6d@gmail.com>
In-Reply-To: <20261016-ok3568-c-v2-0-068d68430e6d@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Johannes Berg <johannes@sipsolutions.net>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Heiko Stuebner <heiko@sntech.de>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, Dmitry Yashin <dmt.yashin@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792146625; l=2276;
 i=dmt.yashin@gmail.com; s=20260930; h=from:subject:message-id;
 bh=BU4GHjU/addW49Fi5owY8SmKZGnqIixi6vq82uwwdHk=;
 b=L6u76hvhoFC1VxSmQLMBau5CcR67ge6OIBk/TdlLnbx3Gjxy2lnT5flh1/HFTDlutOvBF0orb
 uvcNsyj5RxQDcjFvDJgMbKc0qpdj8XXPdVnnu+FBW8dVEo/93Pokamp
X-Developer-Key: i=dmt.yashin@gmail.com; a=ed25519;
 pk=vBe9jaaOEH5bQEvfzb1tWOlz3AMIcXCu/GL/CdlwJco=

FIT-PCIE-SATA V1.0 is an adapter that included with OK3568-C board
and allows to connect SATA drives to the device.

Add overlay to use combphy2 in SATA mode.

Signed-off-by: Dmitry Yashin <dmt.yashin@gmail.com>
---
 arch/arm64/boot/dts/rockchip/Makefile                    |  5 +++++
 .../boot/dts/rockchip/rk3568-ok3568-c-fit-pcie-sata.dtso | 16 ++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/arch/arm64/boot/dts/rockchip/Makefile b/arch/arm64/boot/dts/rockchip/Makefile
index 48c83f79f83b..45e94a44107e 100644
--- a/arch/arm64/boot/dts/rockchip/Makefile
+++ b/arch/arm64/boot/dts/rockchip/Makefile
@@ -155,6 +155,7 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-mecsbc.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-nanopi-r5c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-nanopi-r5s.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-odroid-m1.dtb
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-ok3568-c-fit-pcie-sata.dtbo
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-ok3568-c.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-photonicat.dtb
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-qnap-ts233.dtb
@@ -275,6 +276,10 @@ dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3368-lion-haikou-haikou-video-demo.dtb
 rk3368-lion-haikou-haikou-video-demo-dtbs := rk3368-lion-haikou.dtb \
 	rk3368-lion-haikou-video-demo.dtbo
 
+dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3568-ok3568-c-fit-pcie-sata.dtb
+rk3568-ok3568-c-fit-pcie-sata-dtbs := rk3568-ok3568-c.dtb \
+	rk3568-ok3568-c-fit-pcie-sata.dtbo
+
 dtb-$(CONFIG_ARCH_ROCKCHIP) += rk3399-puma-haikou-haikou-video-demo.dtb
 rk3399-puma-haikou-haikou-video-demo-dtbs := rk3399-puma-haikou.dtb \
 	rk3399-puma-haikou-video-demo.dtbo
diff --git a/arch/arm64/boot/dts/rockchip/rk3568-ok3568-c-fit-pcie-sata.dtso b/arch/arm64/boot/dts/rockchip/rk3568-ok3568-c-fit-pcie-sata.dtso
new file mode 100644
index 000000000000..474488ea994b
--- /dev/null
+++ b/arch/arm64/boot/dts/rockchip/rk3568-ok3568-c-fit-pcie-sata.dtso
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
+/*
+ * FIT-PCIE-SATA V1.0 is an adapter that included with OK3568-C
+ * board and allows to connect SATA drives to the device.
+ */
+
+/dts-v1/;
+/plugin/;
+
+&pcie2x1 {
+	status = "disabled";
+};
+
+&sata2 {
+	status = "okay";
+};

-- 
2.56.0

