Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D97315785
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 01:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176509; cv=none; b=BurmzAHCDGh2x/Z+yrV+1UXFy+zJcgq/2eWUTiVXZY6NF+tcUXEJUv4258pN7ttlbz2GPSld7R5kEr9wQgUZsD65m0CHbP1NDNMCZ8VZEmTOrlf1ek5ANWKECiNQjaMwf/jiOB5Dk3EWVBUrI1s7Kp0aubd1ZiZJRJv53ryDjBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176509; c=relaxed/simple;
	bh=uVvlkd3r7AzFL0bwoPRshRxUVPE5PJY2DyGjC0onaAw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RRX/S3+hifFEl5tN1mEMABwyJPGQ3TUWjtsRAV/E0OE26eexvBDtqAbUceL89sm440zAdwAOoq3XuszNDIbbhCzBf0rUySLct2QIvThqwsMwHZgxLtVJRZpbczFa0RtHHda+IjER94CijtwgwDq2j4PFrps+nVi+btYWR0sey4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g03UzGRQ; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g03UzGRQ"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469b35611so80688b3a.0
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 18:28:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789176506; x=1789781306; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5Ohl5GXWK7z9PSL07FA+1qnT/VjHf89JQfhIV3tvy2o=;
        b=g03UzGRQ9ZwuOM24HyaKxUOZBtLeszngZetHR/AM1wKRhPNdOc8dRDPwVpOuKaR/lb
         P/w3KGQ/fATjOO3sU1bmsrbdbr5GvPHjKRjWT5Jnp3UdMvdvpZk+3j2BsJFY/+CVlKhT
         66ko0/1OzzCC3zyHvTgsrYRZ5U65thM+N9vsz0SSh7YMIOYaT8l9JIg7MlXpbwV7xMvm
         IQKM36WfZ48cwoia5ZgwYRQPDyeRP2xCL+/YNGWsRTKkvda27Z2YcgcNt2Hqk6LWo4AR
         tnPSEndhX+ucn9QwLf2dP0T4cjVk2joD8XgvfsJke9bkvBsqe76dEgqvtdu53i4zAyoQ
         7CwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789176506; x=1789781306;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5Ohl5GXWK7z9PSL07FA+1qnT/VjHf89JQfhIV3tvy2o=;
        b=PUzTho6RImyfYb1Mlk3gSuKgGKRS7JsCngOITYRSmiz1ZM2HW7vswtkLTiwrLvn/ns
         f9u9eli+sj2NClLS2ZmLM5WJaye+1m6NTfwck6k85oJ+Bg6Dp//NpgjEDxTU+XETWXK+
         v5ptPrWWOWwyDZDdet6vRoLavcOqi7hSwVN+/hJyeY8CeYfu8pCSvoQjcMvlLLGQQtVd
         28xLdY5L1HEuRVoShG1+ZMOy18eA0g1bH3F8SZeME46vaEXhujUV59m/nbB1fmKAeG4X
         3nrbI2daD5GoBh911KaJ4F/fN2+K/kuDaAJetFyAzT6yoZzuWotuRY/mijocJVxMj8Ym
         pZTQ==
X-Forwarded-Encrypted: i=1; AKwUvBwnruyoOkrqc3YsNDEtFQwJwgzgF16Q6VOnWAuKa8U5z1RNlHb3pg46SHtFaR3/1xkDvQzreVo=@vger.kernel.org
X-Gm-Message-State: AFuF++lG1RjtVBq0zm7lXBWqe2zeNqmHZ5SOyyIEhNjkCgh2G50I5dQd
	Dqw89VcyMYYg4QHpzZH3sZoX+z09biqNxi8NBNtlZtBtr5dHmIPPsiY=
X-Gm-Gg: AYBFou1yEwoveWw1bUNm+F4sIflrXr6AjOW2uhNFH0aU6DPrxUR60qzJ4gDKq1yX7Pt
	VoN7eL49jMdcQXxXe/X8V85QDZk54NjaCkzRWMaDyBRubCJS+eKadoa7UfTtgQhdGcFVY6tQJ4G
	B28in1HYCIcVEYToX5j2KlPHHmFlc4nOWPSoBrOmLFajbjb8abMbjKkO03eXNtjKKY8h1S0nfQy
	KKOob0BC1fq48mJjMQ5b65ro8yMg6jwwlKQZ1dmBHiEMrAvgdQkoVXhUPZeqkYkCkslZ0vS7ZcY
	SsrMWJajeTH6HNhgMv6qLP7Ysq9f6ZAa7QGMJfi5B0c43GWjcKbe3jRLluKk05d30DBnkboEiuw
	XQoE8uSCu+P0WP+lu5ZRn3vPngioehNnhytYxD/nOraO1jXwl+jmQknHaXWpysYLWjMivdBdYe7
	RuFaz7FsCGAXE/alyHpivEd+h64LiuIxcqACx1U2dgfKDujEWHG6n/GAF5LAJj+idFwIhhOb2XP
	3j89xfHcLNuQEUC9SpOBJrrXr1JahJTQ7I=
X-Received: by 2002:a05:6a00:94fd:b0:84e:89a:b8ec with SMTP id d2e1a72fcca58-86cca73e429mr1155632b3a.11.1789176506482;
        Fri, 11 Sep 2026 18:28:26 -0700 (PDT)
Received: from ydg-Zenbook-14-UM3406GA ([211.230.25.193])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b291c1601sm1805850b3a.31.2026.09.11.18.28.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 18:28:25 -0700 (PDT)
From: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	donggeunyoo.kernel@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH net] net: phy: qca808x: handle the active-high LED polarity mode
Date: Sat, 12 Sep 2026 10:28:19 +0900
Message-ID: <20260912012819.2072067-1-donggeunyoo.kernel@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit a274465cc3be ("net: phy: support 'active-high' property for PHY
LEDs") added PHY_LED_ACTIVE_HIGH but did not cover qca808x, so
qca808x_led_polarity_set() returns -EINVAL for it. phy_probe() propagates
that, leaving the mdio device unbound and phy_attach_direct() falling back
to the genphy driver.

Accepting the mode alone is not enough: led_polarity_mode records
active_low, so an explicit 'active-high' node stores 0, while
qca808x_config_init() re-asserts QCA808X_LED_ACTIVE_HIGH only for -1. The
bit does not survive the reset phy_init_hw() runs first, so the LED would
come up active-low.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260908105959.70453-1-donggeunyoo.kernel%40gmail.com
Cc: stable@vger.kernel.org
Fixes: a274465cc3be ("net: phy: support 'active-high' property for PHY LEDs")
Signed-off-by: Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Assisted-by: Claude:claude-fable-5 checkpatch sparse
---
Supersedes [PATCH net v3 3/3] (20260908105959.70453-4-donggeunyoo.kernel@gmail.com);
1/3 and 2/3 are in mainline. Andrew Lunn's Reviewed-by on v3 3/3 is dropped --
this changes behavior.

Compile-tested only (W=1, sparse). I have no QCA808x hardware, and there is no
KUnit suite or MDIO mock under drivers/net/phy to exercise the MMD7 write
without it.
 drivers/net/phy/qcom/qca808x.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/qcom/qca808x.c b/drivers/net/phy/qcom/qca808x.c
index 8eb51b1a006c..68fd4d0fe31b 100644
--- a/drivers/net/phy/qcom/qca808x.c
+++ b/drivers/net/phy/qcom/qca808x.c
@@ -200,8 +200,8 @@ static int qca808x_config_init(struct phy_device *phydev)
 	struct qca808x_priv *priv = phydev->priv;
 	int ret;
 
-	/* Default to LED Active High if active-low not in DT */
-	if (priv->led_polarity_mode == -1) {
+	/* Set LED Active High unless active-low was requested in DT */
+	if (priv->led_polarity_mode != 1) {
 		ret = phy_set_bits_mmd(phydev, MDIO_MMD_AN,
 				       QCA808X_MMD7_LED_POLARITY_CTRL,
 				       QCA808X_LED_ACTIVE_HIGH);
@@ -603,6 +603,9 @@ static int qca808x_led_polarity_set(struct phy_device *phydev, int index,
 		case PHY_LED_ACTIVE_LOW:
 			active_low = true;
 			break;
+		case PHY_LED_ACTIVE_HIGH:
+			active_low = false;
+			break;
 		default:
 			return -EINVAL;
 		}
-- 
2.53.0

