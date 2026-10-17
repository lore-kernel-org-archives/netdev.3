Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 866BA3DCD83
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 05:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792215928; cv=none; b=skdGOQewxtWaALvKBgSX1mFrySURT/LGdh1hh3fCVkM/Bi5fWAiUT6QyUZp+YRZZJKeYyCEtaNJC3GBp2ucUOTbdfN+5v/XkOU2puMUBsSaHqAEzXQDEgWgHekMFNZCMddDY3ImS55D27qE8Ex43PsV6cqMpXP5NKsS9TpFr6sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792215928; c=relaxed/simple;
	bh=77hqLc9J7JNzbmg7AMorhPOB16l5fiuXalMgNBngkQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lHCOLQ2o1uQ3l7mFFXvwus7V3GN53oFQGnVSddYB1TaMD1WIxtWgPMIlpJQjC9Vyx11xjzTNuQx8DG3qAop20k8ZjdsenMf7bpfPEB6+Up7mawOh+pZCKj/EFO7uYoq80QKGTFf4Ti/ULcr2rtd8ccN1gYtXqV3FvlUDb76KARY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kaDuDKG1; arc=none smtp.client-ip=74.125.228.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kaDuDKG1"
Received: by mail-pz2-f6.google.com with SMTP id 41be03b00d2f7-cd613507bd1so78697a12.0
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 22:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792215926; x=1792820726; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yY8SyQWcSYsDi8cm3rA+aW2F8vWLi9p/feyMtYn7Pcg=;
        b=kaDuDKG136hNm5tp9UX79/0FF1Mun9gn5tmDLxEe7NWNGc9+4IcOncJ+C/GjIyg04q
         RPCYATQtAX9SbZx/GtS6I9J1cVFL1tJG5A/edKXOhyvhu/Q/kKOS1lWE8CsR5h4nHi4j
         a6n7WQmPTBRijHwci0inGaeNd9wtE4udu5AUzD9JInrxqAl1ntepN2swaLZqEI6m5L7f
         d0HWj/1NhmpCkGj6GwtQJX8w0ciDDVdKRIXHkg8Wv67s6arF3zu4b6MjM6oPjAG1BcxO
         k2IMrIvJVZ2JQFKNjQz/9ppY2BE2t2hiw3xMrWqQqgzSbCnsVblJlAT1Y3hDfZBhynlj
         MeQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792215926; x=1792820726;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yY8SyQWcSYsDi8cm3rA+aW2F8vWLi9p/feyMtYn7Pcg=;
        b=TEJyRR4im8+Ui8EGjtnL+dWJrR67T8GmsR6E6F34hAY/+hBR6+JlRKpQWBjvICt9hC
         rJAxg50NgrAKUJrWVccsW+ldOQVzvqugl1uWvMoMBmIkic3dtiOP5LwYbqaCGufM4DRy
         HSMEobN9RzKAAwl3/YrfK4BOn3y2G3x6QDDRB9DMXf13qE5kK54sq3Bgjnn3fY5O2IGG
         mZtrgye6kjeTPdwNqGlVQARWSzkjKdgSaBoTFXYxds/FrzbrXHBd8qxAPuRD7lez05vQ
         vduZ7xOMonFFR4BzS0eOqU9D46mtwMCcFBmYMpLY2y5cIwAGkmG0RtJqXhj2bRij+d3n
         NCkw==
X-Forwarded-Encrypted: i=1; AKwUvBwxtyGwh6wjyBBC65SRIuEPzbWrnocIiOwQ8jXzj+k8kYPhTAmO8K1tvfUHm3unhNuMlpqSnKs=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjUi8pgKEa4bjWKKMLXl/vj6Tt8HGr6PXxGTEwq5xf4lMg/Hmd
	5ilhig7wR4oM6jNPiUL1fmVCBjHSBuJJKetjGclK0frN+SnBJgFI9b6S
X-Gm-Gg: AYBFou0UvFoBHEgMOpbiLOkwj1G8yi6K4n6lZhwoGLdyZDGXRs3iP+gxcqIehf3xrzm
	G+iTND1Q+HgO/yVaWG3kL5Z2MwWCz0uXpVQU/oYAb83X4nCD5VzZSeUeSrXdYXyZDcOtSvfLDH1
	DtjDEHpfUmBAk1vX9jQXf+gjtLwF2iI1vM88+T4ZHymsM6BXF/GO49hEkZ5aTblfoNVGrnbzM0X
	Bpg1HrTG6xD3U2iwHt7yNySXCrpiDL9rJSN5eLiet4J1zK3FJp3iSsdIr+BVY4qNnNxUO/WJ3h+
	4zSRDFRY3UQ2MuV8Bk4+ZE2Ts+uBJItXVAaSCfJ1VbUY8KAMCbvW741OL2yEB5O0DTOHEyUCbw2
	udMAHkxNmCTpeLtdnD6RXdjA+qb26xDxzcmSN0ioOnS8M22/S/wS8yBFG/u8ji2oZJlai1A5jVr
	mGge/nTOZs/K/Y9lrEB/OyD5v4tIzsQiOCjex9dpVbwnR+UitJZUMieQloyLgs5EwaPCk0
X-Received: by 2002:a05:6a00:4146:b0:87d:430:1437 with SMTP id d2e1a72fcca58-8a04be6035cmr1481735b3a.38.1792215925893;
        Fri, 16 Oct 2026 22:45:25 -0700 (PDT)
Received: from server.lan ([168.138.199.194])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-89f57269315sm1958225b3a.23.2026.10.16.22.45.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 22:45:25 -0700 (PDT)
From: Coia Prant <coiaprant@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>,
	netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	David Wu <david.wu@rock-chips.com>,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Coia Prant <coiaprant@gmail.com>
Subject: [PATCH net-next v12 6/6] MAINTAINERS: add entry for Rockchip XPCS driver
Date: Sat, 17 Oct 2026 13:44:04 +0800
Message-ID: <20261017054406.1828061-7-coiaprant@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261017054406.1828061-1-coiaprant@gmail.com>
References: <20261017054406.1828061-1-coiaprant@gmail.com>
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
index 65e8a4b5c90b1..2f0f46eabcf54 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23757,6 +23757,15 @@ S:	Maintained
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

