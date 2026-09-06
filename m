Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FA13C0A17
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 17:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788716176; cv=none; b=H+br6BI6RIp07mWP5ds+0wad85bJnpWPq7TTD7DJh4KeGEZKEtXdVNNlS9H4BFUW6yhjZvFR6aApHwRG249+L9R7vtyjjVR7hJ0UgKyVT24MwXSsttDms+zeGfnN2jstkQmTAQqZJwW5FpbfcXii3rYJMIhirwAvy+NeXLa0IqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788716176; c=relaxed/simple;
	bh=3/zJNHWWWtK/uof2pKE8ZIxAIpYgy2Ej9DgxfoSv1Aw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BYK644XjTjaaEV7cujADGkFaeI9gmmaX0zhx8bUvSrVynecymgX8m2XvPBFpGag0IZKRkltbnvz25p1kk3uJYoljkQHu+yXMvDejxFmBb72LEOnQvHuxWDESgir/8o3PNSsG5IRwxEJOnhqVBnlq97cvQqf7/ykcOJmH/Dgi62I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hCLMB+C8; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hCLMB+C8"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-49d036e0e99so6644985e9.1
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 10:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788716170; x=1789320970; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j2ehGMYuyDOWYVENzei92wq0tc1bXeRoq6FhwwzkxNU=;
        b=hCLMB+C8jpSFl3FQNMOEuK5QsqMofOEW8CW+QK3+1Oeqo7TpzbGpvjppKbunke8V30
         PTXdTccGebnP0y6Ubr8bpWuxAXwcSqfsrembXSnR42JvySC6BWYz4eYufHxI1V1fyG3D
         uYdyNJldoqur5kGUHTrccxSOT/uaY93K5IbDC22tw6YPVrI4Av/Oh4xeYLkWNu4Rjclm
         F/ElFUstP2McpAKet2Thod7hkOIx2YLHK8AsbBUydOz3y64B2iATYf75GGMPcRoRPpQZ
         K53hzipwReaeaxOMXfNi6yTGnAb/38iHJ19II8A80IderTQn671vPIHtS5zst+gsfbsY
         LlCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788716170; x=1789320970;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j2ehGMYuyDOWYVENzei92wq0tc1bXeRoq6FhwwzkxNU=;
        b=WrFIjGxW7wSsm9Lq9pE+GFJ3OPhpwV1vGVEVVVWZgiVVnNi8UiZr60nad5LcaVCSzY
         nvRiHyFrHen35LuLz9DwyNxtkVuoMHpcEjw47BXA/DX3LlxhfAZMtzAPbiTPep7ixf1j
         NWB6Q9zLOjcJRKRnncd8FlpcSPnX/zKC1jy/4p+7XFfSiaMHaTkn+Kw2IqqwM3m4no7F
         em9RkijU1+LxjKSpqW+IocZkt4EgfBG0UcZsLBgmtptiVEvl66kaO85J62xZB1hDKJuH
         htqm6MQ7eVwmNHG9+KznFvBpvWZnHpDNa4jFZ/xf0B/FC7WMuuFOki4c4jtpYc1imYhM
         qoyg==
X-Gm-Message-State: AFuF++lY60ycQRmudYc538vmY+kmLZeE9JynI3gZ9xzGspUQJ2iVgEEm
	FrSD7i31iXpYU8gfXht7DQ2nnkgMLiFfRsdGfdkuq612s61QI35s8BKR6nXGpXwioA==
X-Gm-Gg: AYBFou3i+D2yc66RXCaUP8fanpRafKL+r85yOWSOG+RdkrvTvKAtQcE8bivefK7cohq
	0hz+WQ/Ptu1QzYm3cE89e2JDlnUPbqA9lZ5r3pDj+5nz3U/b2jReMDjxzFbAU+QcqUsBGcWJZcI
	DkhdKOiy/BG9IPG329R1fUd5Sdls9SDQg1V2zc3F1l88YwbnMyRef3+gpgz/09X+aGRv57dPY2O
	eliw4u4zv+RyPiejspS6Hr+wAcBhY4wukBnYAGpIlS/6QT44OCeiVxTHLV7C1+4ZtX3ApQT7Sn5
	fJSkRmJYZVT4F36o7H0dZGUWXpatS8SY2xx5Ah5xFgpqFXvoQaOCohPjJVrqJ2XaIr1+KIIwLOS
	s5jHHqRyv1JJLBSsivIaw81yKm2rak/+Wl4lpIlSdv0bwLXt5KeI3mDBJFE8VezeDfK8og+Zom8
	XKHCpIQbOcnnpk34UQJw5Pk2/i35tMH7k5lP0KPvcAZowLxNiRxFA=
X-Received: by 2002:a05:600c:3e1a:b0:49c:fc6c:bdff with SMTP id 5b1f17b1804b1-49cfc6cc078mr141942975e9.22.1788716169788;
        Sun, 06 Sep 2026 10:36:09 -0700 (PDT)
Received: from fedora ([46.8.219.5])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-485883953cfsm18857331f8f.13.2026.09.06.10.36.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 10:36:09 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: netdev@vger.kernel.org
Cc: Vitaliy Sochnev <sochnev.v.74@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: phy: air_en8811h: simplify en8811h_probe() trailing return
Date: Sun,  6 Sep 2026 20:35:57 +0100
Message-ID: <20260906193557.35115-1-sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

en8811h_clk_provider_setup() is now the last statement in the
function, so the intermediate "if (ret) return ret; return 0;" is
redundant.

Signed-off-by: Vitaliy Sochnev <sochnev.v.74@gmail.com>
---
 drivers/net/phy/air_en8811h.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index ec7c44ca68e7..99221ee87977 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -1168,11 +1168,7 @@ static int en8811h_probe(struct phy_device *phydev)
 
 	priv->phydev = phydev;
 	/* Co-Clock Output */
-	ret = en8811h_clk_provider_setup(&phydev->mdio.dev, &priv->hw);
-	if (ret)
-		return ret;
-
-	return 0;
+	return en8811h_clk_provider_setup(&phydev->mdio.dev, &priv->hw);
 }
 
 static int an8811hb_config_serdes_polarity(struct phy_device *phydev)
-- 
2.55.0

