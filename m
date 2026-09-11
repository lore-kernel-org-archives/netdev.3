Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D588742C512
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 22:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789167290; cv=none; b=LVbwLDuKWoSQvO4vJgob81yodzWLEne1tXYrGLSP4ivmHmGk9iN367VDwKWXzIjTYvZbq8RJvOoFV4XYxVwqKP7JtjQHdbw+P8jsakKKJOqRN1L7TAQIxe/ngrIhYWQWP/rY3RneCLWA/sacbZ4i72PA/dP8aYohJbe+Bfwy/b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789167290; c=relaxed/simple;
	bh=Knp/omcxHZjUeiGAM1oWy8zX3ZBEfkEUke0tYS6i/Bo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sko1TD08DMRTolykKf89iaIUMTvraYCJBwYxAKwB8rwLD5pl7rbf6SaiTTtO7Rb7cfxBX6vSPWEDDJCLpGqgF3Dx1eEXmHhQFATKjdGAT2x7/evqg0OojaJpaQrmjWvNVD4q8kU3t4lr/pyFZGI77fi2cMeHqKc8zSVbq2pdJF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1z/OJSu; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1z/OJSu"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d1fb0cf5eso3032385e9.3
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 15:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789167287; x=1789772087; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=4x6skfRoPug9nQpkDIHkliB3IJCFQOtgzSpXl6Smj9I=;
        b=k1z/OJSu5AYJIyndWA7WiPuWrKEDJU7OX1SrJ6WL7DEFuL011xSCSrdj2DurFPEgaY
         95R/87DW32O+quw80NiyKmI4iv61TZfnoOpdPyLv/Lhth74QQElxLuywo7NLFmDl74J5
         oM2ydP+OwihHiDRL1azTt5eTR5VFeB1xrkBukoK1QBTcWw4xHeejcr/CD0jqDoQ/gS0e
         w9xAlooAfrH2QaJjVOFCAzf32Xxp1a8l6Ox7t5qRh2oV3Sj1VeePkgLzTYgwls+sYfQE
         FcqzkdHG3ZI0bXbw7hOT/dkLyz0BzNhCj5l1qEj001oRPrWdz6MOShQRgwvtS4cUPe+0
         PzgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789167287; x=1789772087;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=4x6skfRoPug9nQpkDIHkliB3IJCFQOtgzSpXl6Smj9I=;
        b=DOeKtPUlSSW0w546hDbp9qJxs5wn0TNigg0GbKhs5Z8f7i9FTHRv1vrVIiLLsiHkM6
         KStuYkiZGCki1OETKG5PeXxju6bWf/5SD2cHBJpWSnzPM5/371aBP5Sc/SXycLs4Xc5H
         jKgj8gIKoPdkLzt7LT5PYlmOgqzYbcfBsF8vZE2GrNujCKGIlWIZTRTUWa7ovFNlHcVq
         qRSDNA89o/w9nS6VPQ5uM/m1Pik6x/m6lkqy7Omh7IDIvZXbqhSymTOFkHJCckqc/8Su
         GHmsckgmQsdzmdjfmA6q70vBCjsSv//G2ppMysQLiJNeD7EYYsqtt4PfGf03lARsigwW
         RiMA==
X-Forwarded-Encrypted: i=1; AKwUvBwNZAmF/K6al7LlcETfCZdRcJzGP7+LNjYLCFbNc+Ih8zkf521tZx0v7+lS4p+uN3Mv1467P/4=@vger.kernel.org
X-Gm-Message-State: AFuF++kr/1zCWvjEx1KasZZtqnMtaqd7liT+NWkEsr8SAP/Iv6NzNE+f
	KI29/W/HnExUxJmoorQfMZj1faaQqQvrrvwX+3hGB0sBriNGyWc4Qats
X-Gm-Gg: AYBFou0+M43TTIban+Sft9NiFDtoLORDs+ZWT44jyWIUxbqdJ2btNFtvQxkVjgoCuKu
	R/5oivTkXSPMWXx0egjIhMRsYSrBSR1ExgrHINrDQbrTXUW1Y16XNC8SlIxbDmEY4FhAcg+EyjD
	ExScWY4Zwy/TC1acpwTJgC5RNGta25wOhTwVnH76jisOZMWH0VX7EFN9PFEiTCQyoUawlD4KJ17
	4QtMECqkJQ5tx78ii/J0gVjEKrhDzWHftkN9Z9kRVu3kuLogygauiMvHmgBwWcVkZoCh842xWF9
	UGoAYbNpNqwsv5N4lrpNBYYo5tRZkkM9wGbhNd+Xy3MzhVns8hIoSekV6NYS5X9O1x7Emh4G5Df
	8F/bg/1UvRSDprUj0e19HTdTZsz0ZA51LgzbbF+xvrU9eohWLATHm/lnYN2gDo1r2HNMk0YK5oG
	sV3+Ypf8wNHikUKRuRdlDSMD+4n8IvJbhgENZK37MeYDGK3Q9EZlpajjRohq5fzlQrvAQ66Q2pu
	bvNLhMxW+xZXoZjkjyyXVs7i8DqusTe9igUQ0yKQ6Mh/3zz6qbjWBXUmWU8cZs=
X-Received: by 2002:a05:600c:a107:b0:49e:663c:c69f with SMTP id 5b1f17b1804b1-49e663cc929mr90961875e9.15.1789167287028;
        Fri, 11 Sep 2026 15:54:47 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-26-252-140.retail.telecomitalia.it. [79.26.252.140])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-49e6221ffb0sm77593685e9.3.2026.09.11.15.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:54:46 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Lee Jones <lee@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	"Chester A. Unal" <chester.a.unal@arinc9.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	mfd@lists.linux.dev,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v21 7/9] MAINTAINERS: add myself as maintainer for Airoha AN8855 Switch
Date: Sat, 12 Sep 2026 00:53:31 +0200
Message-ID: <20260911225414.225980-8-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911225414.225980-1-ansuelsmth@gmail.com>
References: <20260911225414.225980-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add myself as maintainer for AN8855 DSA driver and all the related
subdriver (mfd, mdio, phy, nvmem)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 MAINTAINERS | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 878ecf1fdf27..95072863b236 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -759,6 +759,22 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/net/airoha,en7581-eth.yaml
 F:	drivers/net/ethernet/airoha/
 
+AIROHA AN8855 DSA DRIVER
+M:	Christian Marangi <ansuelsmth@gmail.com>
+L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	linux-mediatek@lists.infradead.org (moderated for non-subscribers)
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/mfd/airoha,an8855.yaml
+F:	Documentation/devicetree/bindings/net/airoha,an8855-phy.yaml
+F:	Documentation/devicetree/bindings/net/dsa/airoha,an8855-switch.yaml
+F:	Documentation/devicetree/bindings/nvmem/airoha,an8855-efuse.yaml
+F:	drivers/mfd/airoha-an8855.c
+F:	drivers/net/dsa/an8855.c
+F:	drivers/net/dsa/an8855.h
+F:	drivers/net/phy/air_an8855.c
+F:	drivers/nvmem/an8855-efuse.c
+
 AIROHA PCIE PHY DRIVER
 M:	Lorenzo Bianconi <lorenzo@kernel.org>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
-- 
2.53.0

