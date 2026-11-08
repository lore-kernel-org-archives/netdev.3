Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794133019;
	b=lUB7UkCCAGoF7mF/gwO75VPCQvjjGdlSw5IHhK+FbDKeIBBmNc/473phPfB9DlEhVbGV
	 y/3BDU5YjALrfg+V7aHoNY8zaz8zUbvZ0Kn9nyxZWu5nrbtMjieaggZSNVNKtWNosGBNr
	 H4bMb/13gPVenmP7tR8Om1IHtBXxAKnd0sbK/TR8ikJhdMfvwXIK3hlcxk/8gtdVlPqiw
	 aFfr7m0vCnkwbacYmEi9e49S6OrFqOJAuwXCu5fqIeEV/187AlunJ63iw3LbjRPrROcfI
	 55pIdloeUuYreotV+FbgU8wbiLjXfHjqYt+g/CH/MQXqaV0lVbH8eRstvmeb0+UzpCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794133019;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=p7p1/+70L7MAnnd+Xm29YcpgFCKWlXPU/TBYjgHj2QM=;
	b=WNKUUOuvziqSRzeMHhCPMIpMr1DzyfOAp3UNyQDQ9dxmndqoT/4HSEa7WdjEAMN+2UJU
	 0hiLDIvMoCypJM/nXYU9XMarFSpjtsVnTlJOIo3y3SmUnvh6jmx5P3R69mNg0u+pur5HA
	 f8Ty4UqGssovuEJUR7cMHnShTPNTzYjYPKGT9JMtDh8PBqTbEI6EOgHUxv+rcIGPEDDUD
	 OIJGQETLhuvD84XkzkEgBnCIrYtB5kSTd+QYSkGUpbFxHiVQH9U5EZdB+uCQff7VIMTO9
	 NVyHpRVEAUKXcMIlUB4+AHZEOskLQtCAZUM1tvpbIA3uu6ETYbKvSmxO3D56TJyxdMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="XYU3/dg+";
	arc=none smtp.remote-ip=209.85.216.42
Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82411606A321
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 10:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82411606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=XYU3/dg+
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-3b0d0b80fb9so6331a91.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 02:16:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794133019; x=1794737819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p7p1/+70L7MAnnd+Xm29YcpgFCKWlXPU/TBYjgHj2QM=;
        b=XYU3/dg+ov+8qUPBLbB4lsmzLgl/CBTKJSY2E4K83cM/N8KjsyCQIFk5cX3AyZRgGe
         AIeEAe7Hy8mTxaP/E9O/t9Nii9FqRajzm3Zs2Of+tU0KQvhLImZO8cxa4GsyLQy4epDN
         W/Vhx+oq/ryMvntkxwpfHOh1J2ODs2lAJ6Izau5vdz9FF+6TIjWwP0lnL+weX1e/1ZBk
         7MQfOSurzZAZHG60+ro7Fa3rWXODOS9Bx85W6Be0rzJ06GJPeCU2+kgN4EVRcpHnSdND
         bQ2YzCNtkylq/I519KwMg3OIopeT80lCX3JBx0fHf+a8g6QSK2QeEt6tPDCDsphHUz09
         aBug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794133019; x=1794737819;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p7p1/+70L7MAnnd+Xm29YcpgFCKWlXPU/TBYjgHj2QM=;
        b=Rfz/wspArVOxv1S/Oh/qEQV8Kc+gqG/3s2IX/408UxEE+qQVPzXTCOrex6wzj5Gz4M
         +QB4CY38mZPm6pvEdOEqd1ubTI6SHur49/fZKelS4tleaWSBSmTASYLsRJ/MPtHUVIH0
         fZu8Ufy5FrwD38Ba4wwE3Mczp4V7GtXULgGtONrJ4XkJJDFoNUjiXitBFWBXaTxLG5ti
         a50W9+/E6ue79IuO9QOtoI1DgEkC9IXfXtvnwPNDvBUWIAjqPjlbO3GQtX31lgNvp3jL
         IbFT3G15MDI1jz7mwIqtYexqHhPktpzvbdUuvy9gLUBfSKBFJTOaJ0G5aZS6VRzHu6ki
         BpOQ==
X-Gm-Message-State: APuU4Z9xDjRg70UJxBT9NuXPqxCpg23UcpuH00TJDRC2m4qTCCqrHY0N
	QoGdqkmFXzlNvfViTnWxB45TxhnZWIf3FzOeKiCdDc73QGxEoqfiybfoIKQBKw==
X-Gm-Gg: AYBFou1rFsaKLsdYnR2s2B40OOzmjJuO06rXcsjy976GXiMYBs+PWOLx0ULZ+w4/94J
	JviJjbkn1JLFr26d0NNU7xYkMIee7IXs/smqWloXZT4HPOONnsAJeM/oKx8uBusq1hEUjzsOec+
	4ZKbRzFr2cUJpLX8T8338ChV6/AWI7CktSGHkuSoUi8JQnYnF8l7Y6iBXygPNK95Q2Z5AbDHyRJ
	LbsuKM4n3psWeBe5hI3XHMo3KtscXNP87xk/WZKWkUgcvkuL9bsNbUtkW7zBscvWZfzhQyRDEx4
	p1ofFgU5nXAZkJN69/OEqjRNkPMCBz2ZQgJkvThKg8zF6FZE38n3a+XMFE4vQST1yiHCX/EL6B6
	Y3UNMTjnXMpkYb37BxL+SFfLPlxLxmegDx+/dyA4P0k97cD960+wwM2fkeE6MCjODfu9jgmNYxf
	ZlgpxaV2322s5VnyFCfppCPols1Ycz6uLYJa4hku7NZSNd+UQSE32puvzUpkbB1ekkJ/RbgKs22
	fy30PvqTOcEbQq+rYQezkhP6Ke0IvzC4cQ0A8UAAnhjieXIVB7FrSi2R/Hp4sCsDgNjFws2ajS4
	vcrRZjFDiv/urPQB/P6+hsQ7L5zxHz7Lz3JEcNkImsG1D+0IBFTUnQ==
X-Received: by 2002:a17:90b:1c82:b0:3b0:9cc6:62c1 with SMTP id 98e67ed59e1d1-3b12d6034cemr805671a91.63.1794133018785;
        Sun, 08 Nov 2026 02:16:58 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b139d0a166sm337295a91.3.2026.11.08.02.16.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 02:16:58 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: dsa: motorcomm: Free the MIB block on port teardown
Date: Sun,  8 Nov 2026 18:15:45 +0800
Message-ID: <20261108101648.1308271-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

.setup() can run again within one registration: removing another switch
from the tree tears the whole tree down, and re-probing sets every
member switch up again.

The hardware reset at the start of .setup() brings the MIB counters back
to zero, but a MIB block kept across that cycle still holds the old
software buffer, so the next yt921x_mib_read() treats the small value as
a 32-bit wrap and adds 2^32 to every counter it extends.

The old claim, get_stats64() not being synchronized with
.port_teardown(), is not true, so free the MIB block in
.port_teardown(), which pairs with every successful .port_setup()
including the error unwinds, so the next setup allocates zeroed blocks.
Not carrying a fix tag since there are no known multi-chip yt921x users.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/motorcomm/chip.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 33e5fc127244..fd737c3e2e18 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -1994,11 +1994,11 @@ static void yt921x_dsa_port_teardown(struct dsa_switch *ds, int port)
 	struct yt921x_port *pp = &priv->ports[port];
 	struct yt921x_mib *pm = pp->mib;
 
-	/* get_stats64() might not be synchronized with port_teardown(), hold
-	 * the MIB block till the device teardown
-	 */
-	if (pm)
+	if (pm) {
 		disable_delayed_work_sync(&pm->work);
+		pp->mib = NULL;
+		kvfree(pm);
+	}
 }
 
 static int yt921x_dsa_port_setup(struct dsa_switch *ds, int port)
@@ -2006,12 +2006,11 @@ static int yt921x_dsa_port_setup(struct dsa_switch *ds, int port)
 	struct yt921x_priv *priv = dsa_to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
 	const struct yt921x_info *info = priv->info;
-	struct device *dev = yt921x_priv_to_device(priv);
 	struct yt921x_mib *pm = pp->mib;
 	int res;
 
 	if (!pm && (BIT(port) & yt921x_info_ports_mask(info))) {
-		pm = devm_kzalloc(dev, sizeof(*pm), GFP_KERNEL);
+		pm = kvzalloc_obj(*pm);
 		if (!pm)
 			return -ENOMEM;
 		pp->mib = pm;
@@ -2019,10 +2018,6 @@ static int yt921x_dsa_port_setup(struct dsa_switch *ds, int port)
 		pm->port = pp;
 		u64_stats_init(&pm->syncp);
 		INIT_DELAYED_WORK(&pm->work, yt921x_mib_poll);
-		/* Start disabled, so that the enable below always pairs with
-		 * either this disable or the one from a previous teardown
-		 */
-		disable_delayed_work_sync(&pm->work);
 	}
 
 	mutex_lock(&priv->reg_lock);
@@ -2031,9 +2026,6 @@ static int yt921x_dsa_port_setup(struct dsa_switch *ds, int port)
 	if (res)
 		return res;
 
-	if (pm)
-		enable_delayed_work(&pm->work);
-
 	return 0;
 }
 
-- 
2.53.0

