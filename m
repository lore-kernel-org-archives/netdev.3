Received: from mail-ed2-f35.google.com (mail-ed2-f35.google.com [74.125.228.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89CA5372E6
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790200761; cv=none; b=TW2X/taQK347tw0TwbSQXIteELGXoai/LEz1kudqI0ZUTrKPLDf9bwXy8De5teYwkvaBCGJDZP1AGVSLOuADYPwv47ctFIeCdV9G9+DP4NaamrNJPdG5hUkU0ju2CoV7g35O4zfWooa97q9zoA2C4SxH3Ircv4lPVqoP9to5YlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790200761; c=relaxed/simple;
	bh=J0Sp6wjcAdOKyksqDGpihJARjQeZGq+KnET565qCRCs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q3HT2RIrSLsNhqhrApoNWGFICbXUIp7a5csoEpqfByewfnoztpYdDoy9420fVfd6t7lErFW3e+q+FqGsZNoWxhXRt/i+ZaNGYBv7vPGpbGUytcnQ6QAqRM0iFNqwfwHyBSLg7rwFhoadlVE7UIn0odZ9YGGZQutX0GqP2QBTmXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eOmGdNsL; arc=none smtp.client-ip=74.125.228.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eOmGdNsL"
Received: by mail-ed2-f35.google.com with SMTP id 4fb4d7f45d1cf-6aa1da63791so2136478a12.1
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790200758; x=1790805558; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Xa8czIzRcUPMoGOkxR49jFfVVsSrtHuSDR475Y+48CY=;
        b=eOmGdNsLbMaF4I1p8Pfk8SYPYu3hc+b6WyuQoUUQNu7TbHPgWT7Tj1O/hiXG0KzJBM
         dn7UtNBhHUy79XSE3uXX8MCHId/h2G/MI2WqRdDs9jiw4p5oxFb3CRBOUI+5StkFL8hh
         4ZK5Lit4q8XFLsp4saBX/e66yZrwPpRE9lLtgAkt7fU0liRyXcngSVRzTaWE7zszXkKs
         vvHXbuQXvwrEdC/zems4pxDs5U9gyOF5xpkFRbPbLlbaZmVds3p3QTPuN6aSYJgytm3c
         mrdqXzTn2+GW1jY6SbF/OFVBNohWhdfMbrsAwAGfGbfus2oQlPsRhE6Kdtex5+1D12B2
         9u/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790200758; x=1790805558;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Xa8czIzRcUPMoGOkxR49jFfVVsSrtHuSDR475Y+48CY=;
        b=2gn6o6kZm8YIdDHleJYLIAxRDS6hPAK3CNb7In1pPv3MFro6h3TSzZSxd+CqQZMtzW
         WTzrR8xvB8AAXNPfuKs6VU+MGy7K8yz66ZojAD34Ii0FOrHiAF8hNzE0shJmqdhbRQPp
         flwAbXZts7MTJrM6ga2jPDds/hxVYjH+5z5G7xvWjX31E6K6nBvrHqUqFUbsKJBI3QuW
         ownE01EJ1W8vdP9dQj0bL9fh3KJrfh4RqdYxBiXpFxU/6WzQruXyDs9YixY2nQgM+CUF
         s8ZrSuN+4B7soDBHW3abvqgC+m6jY8NiGkQ+vCxHALST+ESIOO8UtIpw6Yv6AAN/eVTd
         p9Xg==
X-Gm-Message-State: AFuF++knghMtlk5VGuaz43Tj7y/0MEBjRXKmp7QP8LPU4FHMtqqnr3LQ
	t3DllBEsw9JGFCEW/9odY9hYYrvb5ziaF1ozdw1SC06BOlz9JdbkP2vbhGHrMKDDKHvO1g==
X-Gm-Gg: AYBFou26lX8luQmMtG0Kgl4KnpqDxink2b4joaZ4AXL4EMgQ36jpymxORRf4wizYfCd
	tpHtPBWIQjUACHap+ksC4NQXaj9sAeYeACxchaLFmpMSfPPYgAgoftNwiHmI0ZXkxE0kCIuMwHJ
	4SvpMIN7YQQEfKrdAf+HWqZOSKZ3W0eDL7ADahLM6QFHN6KC1h/wpAEMgDjmi7GQR5kddrcojK4
	CYorRTRBgBqqypsAVqv5PIfJvFREHKXW9/kAf4TQf/X+opKzKciHDQvcGvb4/JqNOR6H9BPNVOz
	zvqmUpVkPh8PW0OzcIUUEWnh3xunMairJlDhT6oUaZavx/uhVO+mR6zL9sLkEubpPKYZknojm/+
	n/oTe7UV4rqUumbxWBtqFy20PLTizI+5MlqxEFrlpQNdbno7LiBz4RU3OyYCPFRr3fAYkLMu45e
	+wN++FaUXc10/JrO0KzRqydoUyByLz7rVE7UHOz31WLcQ7u+riQYZuHfhKmwoo9KC7fyAjMkGg1
	lHgJIYHwwZCzPy4a/dQQnmvKDzw88uPcertYyxg9PvUC8CEF0cmc51c6NJZJ1qiOzjTMNTnWW+/
	a3tgdTfR0PyNrMmsnUoNeeoPRXrvE08Hiqi80oscdA==
X-Received: by 2002:a17:907:97cd:b0:c25:5d2:acf0 with SMTP id a640c23a62f3a-c2ac241f82emr35605966b.8.1790200757992;
        Wed, 23 Sep 2026 14:59:17 -0700 (PDT)
Received: from localhost.localdomain (83-233-130-25.cust.bredband2.com. [83.233.130.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2aae6dcf0dsm197647666b.61.2026.09.23.14.59.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 14:59:17 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: [RFC PATCH net-next v3 3/5] net: dsa: qca8k: support QCA8337 internal PHY CPU links
Date: Wed, 23 Sep 2026 23:58:55 +0200
Message-ID: <20260923215858.1653-4-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.45.2.windows.1
In-Reply-To: <20260923215858.1653-1-yongzhao.derek@gmail.com>
References: <20260923215858.1653-1-yongzhao.derek@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ziyang Huang <hzyitc@outlook.com>

A PHY-to-PHY CPU link connects the SoC PHY directly to an internal
switch PHY. The QCA8337 supports header mode on these ports, and
existing phylink callbacks already handle their internal interfaces.

Allow QCA8337 CPU port selection to fall back to ports 1 through 5 after
checking the dedicated MAC-only ports. Preserve the preference for CPU
ports 0 and 6 across all switch models, limiting the internal-port
fallback to QCA8337. Support for QCA8327 internal CPU links remains an
open question in this RFC. Include internal CPU PHYs when selecting the
PHY access method, without altering the handling of MAC-only or external
user ports.

This enables a single internal CPU PHY configured with an explicit
phy-handle and phy-mode = "internal". The conduit interface uses its own
PHY on the opposite side of the MDI connection. Existing single-CPU DSA
forwarding uses the selected port for default flooding and membership
without extra routing changes.

Adapted from the OpenWrt PHY-to-PHY CPU link patch, narrowing the MDIO
filter adjustments to preserve handling for external user ports.

[yongzhao: preserve external user-port handling on port 6 and limit
 internal CPU PHY support to QCA8337]

Assisted-by: LLM
Signed-off-by: Ziyang Huang <hzyitc@outlook.com>
Signed-off-by: Yongzhao Chen <yongzhao.derek@gmail.com>
---
 drivers/net/dsa/qca/qca8k-8xxx.c | 18 +++++++++++++-----
 1 file changed, 13 insertions(+), 5 deletions(-)

diff --git a/drivers/net/dsa/qca/qca8k-8xxx.c b/drivers/net/dsa/qca/qca8k-8xxx.c
index d8564001c..07640ce4a 100644
--- a/drivers/net/dsa/qca/qca8k-8xxx.c
+++ b/drivers/net/dsa/qca/qca8k-8xxx.c
@@ -1019,7 +1019,8 @@ qca8k_setup_mdio_bus(struct qca8k_priv *priv)
 			return ret;
 		}
 
-		if (!dsa_is_user_port(priv->ds, reg))
+		if (!dsa_is_user_port(priv->ds, reg) &&
+		    !(reg > 0 && reg < 6 && dsa_is_cpu_port(priv->ds, reg)))
 			continue;
 
 		of_get_phy_mode(port, &mode);
@@ -1095,16 +1096,23 @@ qca8k_setup_mac_pwr_sel(struct qca8k_priv *priv)
 static int qca8k_find_cpu_port(struct dsa_switch *ds)
 {
 	struct qca8k_priv *priv = ds->priv;
+	int port;
 
-	/* Find the connected cpu port. Valid port are 0 or 6 */
 	if (dsa_is_cpu_port(ds, 0))
 		return 0;
 
-	dev_dbg(priv->dev, "port 0 is not the CPU port. Checking port 6");
-
 	if (dsa_is_cpu_port(ds, 6))
 		return 6;
 
+	/* Internal PHY CPU port selection is currently enabled for QCA8337. */
+	if (priv->switch_id != QCA8K_ID_QCA8337)
+		return -EINVAL;
+
+	/* An internal PHY can provide a PHY-to-PHY CPU link. */
+	for (port = 1; port < 6; port++)
+		if (dsa_is_cpu_port(ds, port))
+			return port;
+
 	return -EINVAL;
 }
 
@@ -1856,7 +1864,7 @@ qca8k_setup(struct dsa_switch *ds)
 
 	cpu_port = qca8k_find_cpu_port(ds);
 	if (cpu_port < 0) {
-		dev_err(priv->dev, "No cpu port configured in both cpu port0 and port6");
+		dev_err(priv->dev, "No CPU port configured");
 		return cpu_port;
 	}
 
-- 
2.43.0

