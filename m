Received: from mail-pj2-f7.google.com (mail-pj2-f7.google.com [74.125.227.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859DC4CDDE8
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 20:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790107528; cv=none; b=KtE9ExNsHySkhDA3JAlv5Jsuvn7CU65BPCaGkuuUM/3N1jS16HTl53XteotRftw1037oKCq82Gngsi8Y/nit34PdxZ2oB4pHAMQK2X8TaL199zybYE5Z1M/f2PqUeoeTzK5JGUEueBuusF8eGj2LZYR0WoZL2/InkrCFWdbYvnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790107528; c=relaxed/simple;
	bh=fh2Uu82ejF0DtKt0brgXH//fEo0R202bASP2cymwUFU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o8lNO7ajf1ChRX4aNB/fp03Syg3b9i0vnWzs0+2I5IIiSb1Q/u3qLVSlp12LLX+H9omg6V8sbqAWEjyvoroxaFYO5RpGhg70ia0hih7jOFmSnFZ7SbuMMHJEE0kB+k4nmtDsSziHZF/9GCvElry0CzuQre/ET+WYk85yl87GB4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UdSVq3K+; arc=none smtp.client-ip=74.125.227.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UdSVq3K+"
Received: by mail-pj2-f7.google.com with SMTP id d9443c01a7336-2d903e972efso1031845ad.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 13:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790107512; x=1790712312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bdJAnLwrz+/OjIyJtnetxy2JKy8P0MsUYxFs2QuKaus=;
        b=UdSVq3K+yojQHpnGmXGkAEkPTwJMk03Ajk4hF9OLMwsODOjQCbvDf+WSAgGPzHIWq2
         nRgmIJdoOtiaRZUQPD/DhCTuMORzVe9/jqNUoQDo7z8ZzIP1FdXm3Jbo7tZViUWx/m31
         mfF3kkwqEvFh+8FkrYN59yqQKqKabszHdHIUpi3BwZZ4l9FlpmJHXUFjaMmFfT8kaew/
         dqm+gs3l9v5N45jo9WZ/YYs9i92/yVuHWd1nTp1K2lPxtAkEO6cXxCakPlh1XJj13VRM
         YMCFM8YYrgdAsN6HoQjVmGG1cS7BIFlI4ER2QtgfLQl7oyIKbQBmNofZOf90LUkmEbNL
         KdyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790107512; x=1790712312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=bdJAnLwrz+/OjIyJtnetxy2JKy8P0MsUYxFs2QuKaus=;
        b=txMymNDQ9oOE5MBVS1UtJMZdmOAPsS1R4jpwjydNoMx1QFZZ4UhEjKlcxV7uxqIGOo
         iYXbN+2SG4eSRClCoJjsNzaHrpWd6qfihE+lQRUsDJ5g/A1qYtWtYZXtOM6qQLAK1c+M
         NpeDKjMUqdC5JIo2TIa5SQchpStfPZYrRHGaCnruahR2CWeNI6shKhmWEZBN3nA10mch
         S5YLmaeygOXCPYkUS9oFlUFnb5+ueYXNPWNmIOySAlXcYONkepw5ow2WsvJOJvxL02WG
         bgSkvzI3HwKJ1KjVQ2RsL8NGNSCf0PtL1kB8beXZf6sLh0lDFGFiVK/cGgs4U3d+BijZ
         v2+A==
X-Forwarded-Encrypted: i=1; AKwUvByMAKbJxy/jkabM9cBWWpK7jZhuqYR9ki4wI3Q6FbvfV41dIB7XAFhbpjBHl9eq4M190dwQxvM=@vger.kernel.org
X-Gm-Message-State: AFuF++kHyq+0mOffnKxUTnevN+tEq3B5xNuB+PAoY+4bW64vpunzPf1K
	nROMoQ0vOszdKY7dXnhA5m+jmFupHA/20D+w4kjtc/dm9gl0ne1s7hCG
X-Gm-Gg: AYBFou1OmUlTFtWzVlS2Zyb27xqyLcLmLVDmor5cyAJFOvmxMpkMzVgYkbR0AaJynLc
	GauxMuVryr9QdsO8/lEsK7yTd+lXnh05u0UJ1ATK62uWhB9yxOGUfHJol3FCqPtfaxw+WVuxH2K
	KHmdVAsM+3ZWH9rIKg31cUfk+buckA9RDA/4SmZ52CLf46KD15+DvJgm+Yv5oKECJ5I3w1dJMHp
	k+Vqtkf8TJ6aEJFFWx0zbgmJHxxoC5uzs9f8cDWEkg2tjTYkOSN3X/Op7DXei4IKOXarlg2b7PF
	sItnjLOUaO9JBo32MBNi4Bibn5GpMSyyL3AQAVa4b/eLAg92On8BsUiAqY+33+hrMGH8Z2ZuaZm
	4rqpUCMlxz59yJQWqqm/cDL/lYNtVtMlVQWGQuTpHFeqsbJuQ2D31QTm1lvoyrexAoOyRn0XHJ1
	pukt1mzXI1CgDBw7b/4x4ewt+189xE2YEL7WOGU+MWYCRfU2WBEF2+KcsbK9vqXBxnQHhr
X-Received: by 2002:a17:903:234e:b0:2dc:fcfc:bdeb with SMTP id d9443c01a7336-2df69d3649amr4211185ad.22.1790107512560;
        Tue, 22 Sep 2026 13:05:12 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2df6a5eea15sm654515ad.64.2026.09.22.13.05.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:05:11 -0700 (PDT)
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
Subject: [PATCH net-next v10 11/11] MAINTAINERS: add entry for Rockchip XPCS driver
Date: Wed, 23 Sep 2026 04:03:35 +0800
Message-ID: <20260922200336.2201212-12-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260922200336.2201212-1-coiaprant@gmail.com>
References: <20260922200336.2201212-1-coiaprant@gmail.com>
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

