Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC53A4AA57F
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 14:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345029; cv=none; b=t2fUE83A/saZClwDVJoOeqCfnyW4btLO0zo0Sueyzmk42w0Yy0/ArNEi5Z1+3J75krztrythPSv3YmZJxfBBC9nW8TVBJHXbfWhU9ZItatjMbiW1orvPAXJH+VuKmFCI8vwZmbLuxZB0Ryl7/PY947F1iUx23Rd+STqs1cEaUg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345029; c=relaxed/simple;
	bh=HRSfvabNiucZeklsxwJ53/66sDBOCW9Yt/3lAFnkhLg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=B3LSJviVPcoU/8E5624n3HfzaQTp1mi0GIrhnZx8jYUx07w4y9N5+gmvSoCnQ3J5R5Y8i7ASbuqYCcIqbCVyjdakGCxh4lCWsFJZzDFnyuR3nQ1n4SrxqpESt9O9/7G5anT1Q2lx0IWkqhmE8DXapePhwyu28I8W+CyaE9cBr6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qhlApKHr; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qhlApKHr"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843f22dcb8so739062f8f.0
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 07:03:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790345024; x=1790949824; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qzFEC3aTbGnpQkHithoqa18oO/Ij/6Vz720R55NWgd4=;
        b=qhlApKHrvjRFH8Egd6S9Jkn4rqGzAezFq1Uq8Nf+ot+yRgL2hzCKRbIcMEp77q10PZ
         7KWLUbldM6Mj3O5K2jvCelUDQU6o5Pe8pMcVmGkS3dm0EdIX0AZh8INpI/g8XJzMOvUp
         kfvAmMW0fBi4jxH2dLjLZHn4tFoRpiZ9Vc6K8T+l8cAlh8Fbt4zi+RX7D2FqN6mro2EI
         ctz8uOxZr9jYY7u6olOPOWPfWguBuw68XrA/6uvI9/srJTx37pMlcS4eN0E8T0YVbmFc
         e0pnsUaAaMEjhHgCRwG9N/P98CFrdFqPkRo4l+BthNVPT+LW/Y5CIQWE6u8FjEWpW9Ip
         GnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790345024; x=1790949824;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qzFEC3aTbGnpQkHithoqa18oO/Ij/6Vz720R55NWgd4=;
        b=m4E+ZEsF3Dtf8Gn480leMG0745NtBPJ6ksRg/XAAmIfkZNOo+IgtUskF9AqfUcfWAH
         xfixQsxIXQSwES1HBY/pkAmjvaGSBSQQOE80/3VtOO84kQw+zAbAvOBeMPUAI/2Ebuas
         fbNxD4GMVzwz4JrszUFkRGjyTqbK4UZAnVvBdTXnEcbRZ1Fh9+Mgk23Ah/1/yZTMzWcK
         fhKSfH+HdyjSzz14XvnUbA+/cmivF4H7qBV5dLsL0VIgoFHbWUdqlWw2iVE5DIMZL84x
         jiuv41a/hxGRnSOWTDvae/T+Sd6HuGtlnJ8BLOinrVJq3GzHo1St0p4mqoIz/tBSxIeQ
         0ZRw==
X-Forwarded-Encrypted: i=1; AKwUvBxAXVHYlyFgINau3bfr45phaWuS8f307vGIivR77l+tXCVSzQD5pcv1Az/TkMN14B+bHPgEIsY=@vger.kernel.org
X-Gm-Message-State: AFuF++mxtD6zG1NMwzmFIAR8JvYogM1QgXYalBEeawYpjGhM7TTygHj5
	0d6I//zyPHssNeERM9LwzJ5DgNkJKe9oTqK3QX8FAandeDagaCZFwLgF
X-Gm-Gg: AYBFou3BRt1UE584Z4AStUyDwCwQQ7DP27XpT9RNRW3J82nZMXM1HBczNqrdL05RGWr
	HOeTzf0anxpN7RdxEkEgH+ZsTsYV0QUBTgymyzxTtXjA2jaLf6bsfuz7r9qnwWjFqAqlmtinmyk
	RgvdasZ79atnTw59HLi0g0N6lEyUdhluOpcmtT96t2U2EQVijojm2DNzqnqp54TrSFeoiuBZD4Y
	U+g5ILjdqIAkqQIESieZVrWRyqiU4BQaJ/P8rrzTnGUxlAois55EEP5mmsQuA0RDiFHPMA4gMVy
	GZ1IohT7A3zOVmpcfrk7lzfTPKmd0W7stYFpnZ3hcJWMBX0RzOMlWj4hej+tVvmV+t7y6OjwHU6
	t6qsukQsY61A6xt47JwJd8sIiSJxpRkQQVjZVflwGPvHKCtEFIoQ3TwVq53VyMuXmC5U+az9sLl
	B3gokTBOPYsXYYU5Q0yyCuBqTeaVB4/Cx/fqw+us83HwgrHnLlBjj6TdXB3rAk45Tj6AYP+1KQc
	evT4QmxongJKjlp/+Utb/IGkVM4IQ0gLQpJpGvUsYI9DHRU4FKNtGQAJaW+eKZsC0gfRIC0GAuc
	MOpLKM4M4PkGGWmZpnQ+iw==
X-Received: by 2002:a05:6000:4201:b0:488:8411:1d08 with SMTP id ffacd0b85a97d-48884111e4bmr551965f8f.48.1790345023466;
        Fri, 25 Sep 2026 07:03:43 -0700 (PDT)
Received: from Lord-Beerus.station ([31.27.155.43])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a355c65sm7522431f8f.19.2026.09.25.07.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:03:42 -0700 (PDT)
From: Stefano Radaelli <stefano.radaelli21@gmail.com>
X-Google-Original-From: Stefano Radaelli <stefano.r@variscite.com>
To: Frank Li <Frank.Li@nxp.com>,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org
Cc: pierluigi.p@variscite.com,
	Stefano Radaelli <stefano.r@variscite.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	Shawn Guo <shawnguo@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Joseph Guo <qijian.guo@nxp.com>,
	Josua Mayer <josua@solid-run.com>,
	Ernest Van Hoecke <ernest.vanhoecke@toradex.com>,
	Mehmet Fide <mehmet.fide@screeningeagle.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Markus Niebel <Markus.Niebel@ew.tq-group.com>,
	Maud Spierings <maudspierings@gocontroll.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Stefan Eichenberger <eichest@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH v1 11/11] ARM: dts: imx6ul: Enable Variscite i.MX6UL board DTBs
Date: Fri, 25 Sep 2026 16:02:28 +0200
Message-ID: <3fc9181ea762490c53451b366e3723d61d46a56e.1790344389.git.stefano.r@variscite.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1790344389.git.stefano.r@variscite.com>
References: <cover.1790344389.git.stefano.r@variscite.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Stefano Radaelli <stefano.r@variscite.com>

Add Makefile targets for the VAR-SOM-6UL and DART-6UL board variants
based on i.MX6UL, i.MX6ULL and i.MX6ULZ.

Keep the existing Concerto DTB targets enabled alongside the new
carrier, storage, wireless and audio combinations.

Signed-off-by: Stefano Radaelli <stefano.r@variscite.com>
---
 arch/arm/boot/dts/nxp/imx/Makefile | 92 +++++++++++++++++++++++++++++-
 1 file changed, 91 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/nxp/imx/Makefile b/arch/arm/boot/dts/nxp/imx/Makefile
index c5caca92ea10..cdca939b10a9 100644
--- a/arch/arm/boot/dts/nxp/imx/Makefile
+++ b/arch/arm/boot/dts/nxp/imx/Makefile
@@ -377,6 +377,36 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ul-tx6ul-mainboard.dtb \
 	imx6ul-var-som-concerto.dtb \
 	imx6ul-var-som-concerto-full.dtb \
+	imx6ul-var-dart-emmc-sd-card-wm8731-6ulcustomboard.dtb \
+	imx6ul-var-dart-emmc-sd-card-6ulcustomboard.dtb \
+	imx6ul-var-dart-emmc-wifi-brcm-wm8731-6ulcustomboard.dtb \
+	imx6ul-var-dart-emmc-wifi-brcm-6ulcustomboard.dtb \
+	imx6ul-var-dart-emmc-wifi-iw61x-6ulcustomboard.dtb \
+	imx6ul-var-dart-nand-sd-card-wm8731-6ulcustomboard.dtb \
+	imx6ul-var-dart-nand-sd-card-6ulcustomboard.dtb \
+	imx6ul-var-dart-nand-wifi-brcm-wm8731-6ulcustomboard.dtb \
+	imx6ul-var-dart-nand-wifi-brcm-6ulcustomboard.dtb \
+	imx6ul-var-dart-nand-wifi-iw61x-6ulcustomboard.dtb \
+	imx6ul-var-som-emmc-sd-card-wm8731-concerto-board.dtb \
+	imx6ul-var-som-emmc-sd-card-concerto-board.dtb \
+	imx6ul-var-som-emmc-wifi-brcm-wm8731-concerto-board.dtb \
+	imx6ul-var-som-emmc-wifi-brcm-concerto-board.dtb \
+	imx6ul-var-som-emmc-wifi-iw61x-concerto-board.dtb \
+	imx6ul-var-som-nand-sd-card-wm8731-concerto-board.dtb \
+	imx6ul-var-som-nand-sd-card-concerto-board.dtb \
+	imx6ul-var-som-nand-wifi-brcm-wm8731-concerto-board.dtb \
+	imx6ul-var-som-nand-wifi-brcm-concerto-board.dtb \
+	imx6ul-var-som-nand-wifi-iw61x-concerto-board.dtb \
+	imx6ul-var-som-emmc-sd-card-wm8731-symphony-board.dtb \
+	imx6ul-var-som-emmc-sd-card-symphony-board.dtb \
+	imx6ul-var-som-emmc-wifi-brcm-wm8731-symphony-board.dtb \
+	imx6ul-var-som-emmc-wifi-brcm-symphony-board.dtb \
+	imx6ul-var-som-emmc-wifi-iw61x-symphony-board.dtb \
+	imx6ul-var-som-nand-sd-card-wm8731-symphony-board.dtb \
+	imx6ul-var-som-nand-sd-card-symphony-board.dtb \
+	imx6ul-var-som-nand-wifi-brcm-wm8731-symphony-board.dtb \
+	imx6ul-var-som-nand-wifi-brcm-symphony-board.dtb \
+	imx6ul-var-som-nand-wifi-iw61x-symphony-board.dtb \
 	imx6ull-14x14-evk.dtb \
 	imx6ull-colibri-aster.dtb \
 	imx6ull-colibri-emmc-aster.dtb \
@@ -417,8 +447,68 @@ dtb-$(CONFIG_SOC_IMX6UL) += \
 	imx6ull-uti260b.dtb \
 	imx6ull-var-som-concerto.dtb \
 	imx6ull-var-som-concerto-full.dtb \
+	imx6ull-var-dart-emmc-sd-card-wm8731-6ulcustomboard.dtb \
+	imx6ull-var-dart-emmc-sd-card-6ulcustomboard.dtb \
+	imx6ull-var-dart-emmc-wifi-brcm-wm8731-6ulcustomboard.dtb \
+	imx6ull-var-dart-emmc-wifi-brcm-6ulcustomboard.dtb \
+	imx6ull-var-dart-emmc-wifi-iw61x-6ulcustomboard.dtb \
+	imx6ull-var-dart-nand-sd-card-wm8731-6ulcustomboard.dtb \
+	imx6ull-var-dart-nand-sd-card-6ulcustomboard.dtb \
+	imx6ull-var-dart-nand-wifi-brcm-wm8731-6ulcustomboard.dtb \
+	imx6ull-var-dart-nand-wifi-brcm-6ulcustomboard.dtb \
+	imx6ull-var-dart-nand-wifi-iw61x-6ulcustomboard.dtb \
+	imx6ull-var-som-emmc-sd-card-wm8731-concerto-board.dtb \
+	imx6ull-var-som-emmc-sd-card-concerto-board.dtb \
+	imx6ull-var-som-emmc-wifi-brcm-wm8731-concerto-board.dtb \
+	imx6ull-var-som-emmc-wifi-brcm-concerto-board.dtb \
+	imx6ull-var-som-emmc-wifi-iw61x-concerto-board.dtb \
+	imx6ull-var-som-nand-sd-card-wm8731-concerto-board.dtb \
+	imx6ull-var-som-nand-sd-card-concerto-board.dtb \
+	imx6ull-var-som-nand-wifi-brcm-wm8731-concerto-board.dtb \
+	imx6ull-var-som-nand-wifi-brcm-concerto-board.dtb \
+	imx6ull-var-som-nand-wifi-iw61x-concerto-board.dtb \
+	imx6ull-var-som-emmc-sd-card-wm8731-symphony-board.dtb \
+	imx6ull-var-som-emmc-sd-card-symphony-board.dtb \
+	imx6ull-var-som-emmc-wifi-brcm-wm8731-symphony-board.dtb \
+	imx6ull-var-som-emmc-wifi-brcm-symphony-board.dtb \
+	imx6ull-var-som-emmc-wifi-iw61x-symphony-board.dtb \
+	imx6ull-var-som-nand-sd-card-wm8731-symphony-board.dtb \
+	imx6ull-var-som-nand-sd-card-symphony-board.dtb \
+	imx6ull-var-som-nand-wifi-brcm-wm8731-symphony-board.dtb \
+	imx6ull-var-som-nand-wifi-brcm-symphony-board.dtb \
+	imx6ull-var-som-nand-wifi-iw61x-symphony-board.dtb \
 	imx6ulz-14x14-evk.dtb \
-	imx6ulz-bsh-smm-m2.dtb
+	imx6ulz-bsh-smm-m2.dtb \
+	imx6ulz-var-dart-emmc-sd-card-wm8731-6ulcustomboard.dtb \
+	imx6ulz-var-dart-emmc-sd-card-6ulcustomboard.dtb \
+	imx6ulz-var-dart-emmc-wifi-brcm-wm8731-6ulcustomboard.dtb \
+	imx6ulz-var-dart-emmc-wifi-brcm-6ulcustomboard.dtb \
+	imx6ulz-var-dart-emmc-wifi-iw61x-6ulcustomboard.dtb \
+	imx6ulz-var-dart-nand-sd-card-wm8731-6ulcustomboard.dtb \
+	imx6ulz-var-dart-nand-sd-card-6ulcustomboard.dtb \
+	imx6ulz-var-dart-nand-wifi-brcm-wm8731-6ulcustomboard.dtb \
+	imx6ulz-var-dart-nand-wifi-brcm-6ulcustomboard.dtb \
+	imx6ulz-var-dart-nand-wifi-iw61x-6ulcustomboard.dtb \
+	imx6ulz-var-som-emmc-sd-card-wm8731-concerto-board.dtb \
+	imx6ulz-var-som-emmc-sd-card-concerto-board.dtb \
+	imx6ulz-var-som-emmc-wifi-brcm-wm8731-concerto-board.dtb \
+	imx6ulz-var-som-emmc-wifi-brcm-concerto-board.dtb \
+	imx6ulz-var-som-emmc-wifi-iw61x-concerto-board.dtb \
+	imx6ulz-var-som-nand-sd-card-wm8731-concerto-board.dtb \
+	imx6ulz-var-som-nand-sd-card-concerto-board.dtb \
+	imx6ulz-var-som-nand-wifi-brcm-wm8731-concerto-board.dtb \
+	imx6ulz-var-som-nand-wifi-brcm-concerto-board.dtb \
+	imx6ulz-var-som-nand-wifi-iw61x-concerto-board.dtb \
+	imx6ulz-var-som-emmc-sd-card-wm8731-symphony-board.dtb \
+	imx6ulz-var-som-emmc-sd-card-symphony-board.dtb \
+	imx6ulz-var-som-emmc-wifi-brcm-wm8731-symphony-board.dtb \
+	imx6ulz-var-som-emmc-wifi-brcm-symphony-board.dtb \
+	imx6ulz-var-som-emmc-wifi-iw61x-symphony-board.dtb \
+	imx6ulz-var-som-nand-sd-card-wm8731-symphony-board.dtb \
+	imx6ulz-var-som-nand-sd-card-symphony-board.dtb \
+	imx6ulz-var-som-nand-wifi-brcm-wm8731-symphony-board.dtb \
+	imx6ulz-var-som-nand-wifi-brcm-symphony-board.dtb \
+	imx6ulz-var-som-nand-wifi-iw61x-symphony-board.dtb
 
 imx7d-colibri-emmc-aster-panel-cap-touch-7inch-parallel-dtbs := \
 	imx7d-colibri-emmc-aster.dtb \
-- 
2.47.3

