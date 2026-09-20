Received: from mail-pz2-f7.google.com (mail-pz2-f7.google.com [74.125.228.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0617947043E
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 17:03:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789923822; cv=none; b=PCSROHQgoKhfvd4ecL2NWdBv9YfhJbToMv+R1ncBEqg1UY1nT0zqvbxt4bT8Q0FgGPyevrXgH0EQeTkenWKd6PZR3Uaa9qlpUHv1AzITE3FSD0ywNvvn1Mf87JPQivSH/iMxYXSVG9VfBLiNraaMdf7zHrdCZZLT7Z3SnXL7gj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789923822; c=relaxed/simple;
	bh=fh2Uu82ejF0DtKt0brgXH//fEo0R202bASP2cymwUFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H5Ns7pJWthYGC7CpBYENMcRNjyP7RPiYS5HM/VZKJTd+Id0SZIX13s9iOdtnB6nSXO7bMxloaOwQPF63CrK+6DwuDstoaoRNEdJTBEKNFsLoL3uZ/C/65kF11LbjaN4kRuxpEV81t7zy6yrhU1g8sL7l2zjctPH8cEKW3R/BkJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oc83AY8i; arc=none smtp.client-ip=74.125.228.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oc83AY8i"
Received: by mail-pz2-f7.google.com with SMTP id 41be03b00d2f7-cc1ddb3ba3eso1282835a12.1
        for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 10:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789923820; x=1790528620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bdJAnLwrz+/OjIyJtnetxy2JKy8P0MsUYxFs2QuKaus=;
        b=oc83AY8i9T/s9qJHtWjS7WM5I+B091jAet7u0+bXr9FQqfwIodge9hUq9UiLscPAqk
         5f+gKg4eDY6xTVI87ijf+GjtNtOwipxKUUKyjFx+aSpaTeNiHWbg2cwzNbhp7eBM/IgM
         kS2UKmP68ZLuhqZuRrIgnxZg/1B5Vg+hLXyBBuizT4dXwyp5gY6RPHROz3M1ezRzG+11
         dUCRrllW2S06FDnmrrdLC1wdzCHubXyrYznDxlNFnNDa70NbvxTqRLVV+6FuJEEH+0Yf
         YSGQGO8kAiIQ69MC+VivyyokeeM+0ljcpGdA5eqGcDRNncpnh9vSE3BcMOL1IzJwe6HW
         5xDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789923820; x=1790528620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bdJAnLwrz+/OjIyJtnetxy2JKy8P0MsUYxFs2QuKaus=;
        b=m9TiH2mQCTj4AR99IIBF6KaQvha6lvI/zrsBns+ohbXPez6p5uZY5AUdgSHQucpHsC
         SvBwWhC5Zwpea5Jdu1xGSJIteTZu2wqyTGPg+pwkX9F49MjSm9RY1vkIX8CUNXH/GHRU
         y/Z3z5l0+Ciq2fv+x7L0IoZzdmmBv7Cqk2/w1Qqc4fllpVgaOVG1bH6vynnq1NhcmbDL
         Ctp+ebPGrD6/XXxvpKn+kaox3Zxk54NzUbO9OMSXMi3UMmh705SLKZU3ZiIibFaW0pD8
         p1BBKEvqhwFh7pi4dF3FytJ1TYRAV+3rNSVrw8Xmnzq1W0Z/Ms/0/asrY8ueBmgSdMKc
         4gGg==
X-Forwarded-Encrypted: i=1; AKwUvBxv6FkhUmnGSDgW3XeL4ngRHx+3HY+n7ti1fkallhZgr6VrHFqrC6tADUX7i0etgN6rkL5qMsw=@vger.kernel.org
X-Gm-Message-State: AFuF++nAUA/9M8ONSwxCVkxc5nVsON0FSqeWLz+FDU9sdzH+MxEQl6Qe
	pYB/woRmvFl0hBzoXiLo4F9zl+AMba6wP6uLFInVUZgK1rPRJISfpWZo
X-Gm-Gg: AYBFou2h+hY6aSzRFHWMY6j4jtOWlG+jF3ZgElDbkhoNH4B5j106JGcP1dOs6WgmyF/
	fcriPDoY4+h+1eLElEHLP2iOkXy5Xa/9/z99W/Y9iA+y/xx7QqIwShnOfWINsLZaRS6jsHBSfed
	/Pb2bLlMM1ZPUegBSzNuSpnWCTa+DHgq8wvyUXLiIBSXTMaL/eZBCnyCkU7zmpCRIAWScKPNfDu
	0rFKCYPqiv1Q50IbPVrG7Mi65rTx3AktKiG5j1SMnDNJsA2L9LtLWBsRZU1BECGyws4lTtm1k9e
	Udxe7xqz25pb+PUjRKN7Uxq8lKURfmYUUaIIlhiWbZ9u1YT+2RHBhsSfktrKuD8HS0YQLHArp0d
	Ls7Cvxzp796LcOXRn/Rxqf/JXt3d0+KOvk2L/VEa5Tuwl/So+1FET+bA90tczEAyfv87YzuovOh
	BpDl2CfgLCOXKGjB9Y7Y1PBHJh5Zg4k/FA/Lh/3eeNBcpKXd7Df8KBjTTyNon3zJEp3HMbuQ==
X-Received: by 2002:aa7:88d0:0:b0:878:3538:8f80 with SMTP id d2e1a72fcca58-87835389b2bmr4633099b3a.46.1789923820049;
        Sun, 20 Sep 2026 10:03:40 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877a9d07425sm2140646b3a.42.2026.09.20.10.03.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 10:03:39 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Vinod Koul <vkoul@kernel.org>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Romain Gantois <romain.gantois@bootlin.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Coia Prant <coiaprant@gmail.com>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Russell King <linux@armlinux.org.uk>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	David Heidelberg <david@ixit.cz>,
	netdev@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-phy@lists.infradead.org,
	linux-renesas-soc@vger.kernel.org
Subject: [PATCH net-next v9 11/11] MAINTAINERS: add entry for Rockchip XPCS driver
Date: Mon, 21 Sep 2026 01:01:15 +0800
Message-ID: <20260920170116.3624104-12-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260920170116.3624104-1-coiaprant@gmail.com>
References: <20260920170116.3624104-1-coiaprant@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a MAINTAINERS entry for the Rockchip RK3568 XPCS platform driver
and its device tree binding.

Include the relevant mailing lists (netdev and linux-rockchip) so that
future patches are properly distributed.

Signed-off-by: Coia Prant <coiaprant@gmail.com>
---
 MAINTAINERS | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index cc3cae2e378b3..085589b8ba65e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23740,6 +23740,15 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/rockchip,rk3576-sai.yaml
 F:	sound/soc/rockchip/rockchip_sai.*
 
+ROCKCHIP XPCS DRIVER
+M:	Coia Prant <coiaprant@gmail.com>
+L:	netdev@vger.kernel.org
+L:	linux-rockchip@lists.infradead.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/net/pcs/rockchip,rk3568-xpcs.yaml
+F:	drivers/net/pcs/pcs-xpcs-rk.c
+F:	include/linux/pcs/pcs-xpcs-rk.h
+
 ROCKER DRIVER
 M:	Jiri Pirko <jiri@resnulli.us>
 L:	netdev@vger.kernel.org
-- 
2.47.3

