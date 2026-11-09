Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794235664;
	b=l6LGpTBcql1Y8j7QBj3Ijg7O9QlqB9QFW9cAktLgdeom4eg94OK8hqW7f1VCeI327YJo
	 kgrVth2JMa+0X6Jz2t7S9817CtIQDt/QLfq/8gcncNKx/9TKvhWTztvpKsnjaUPs/9y/h
	 QbQrNj409HHxTrOVcVAEFeTcWHW3BUX/rz1zfKIKu5n4nckWVHcE5Y8gctBJH80CaGDoP
	 TB1XVgzVUctvebI2dTfF0B8H27fkf+hKNq61v5Fc8E+HbwXsa7wrAqeUmzUx3rMFeGP9q
	 k9bNnZpIFgL1cbMu3bkIxRVglBolGri60vFNU8JF7yMnimvlo3nuqrcQT1W0xXW+j8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794235664;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=8BjfBvvBITs0v8vpJBTpPDcN60M30b+tl6LUSDLYEFY=;
	b=sqmb+obuOxe3E4lc9JQROjIvmWkGI/xTvFpXIclgVch06+/BaeOmkeHDcg/VmItPkFhc
	 yiZgss6vWM4efczYFhE+A2POxJIKMTCmfD75tJfvIqBv97r8yqkAm5JKDH91mNk6VLK/w
	 T/nRF857Qi+zSQAxcD2G4a1fuzREI/4gntifyepCoA3oBFduKTaPmC9447150+ufvbDik
	 aNHUV4cqKk9+uVpgZLHC5NwzLF3zBxWTlkNynqEEN91pMPOLSSR0yL/7NlVQBiGb0q2Fm
	 igSrp7eSyHUP0QeNksabW7/0SqysfvjiQcyBcmhGrtGapWySMEIJLEUf/0d9ejwrjlw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T+qVH9bO;
	arc=none smtp.remote-ip=209.85.214.182
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46ED606D803
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 14:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A46ED606D803
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=T+qVH9bO
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2eb0f1b592bso3328335ad.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 06:47:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794235663; x=1794840463; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8BjfBvvBITs0v8vpJBTpPDcN60M30b+tl6LUSDLYEFY=;
        b=T+qVH9bOyUcTzDcway48pCmwpWUfpZPavCJZ3yrePOD9wIRZIigPmfpFCW6z28tvaf
         AvJJ6NX2oIL63z3W44FqeXoXezQGEsCiYenen7cqF+AZLFG2RS/Bq8UObNwHpAdVb0km
         UWaAeQLkp/UV7WpqEfZnfA+f6gFqaQUINiukPpViF19AzGaxLImRVe7xaNz6vhsBR9XK
         JCwOibXmHp1pXFwMRlgqP3muI/gw4IBfB9uvzhAAGbFyiPTMdNaBPN+yD+P+nnRPk6yu
         Dcql4IZCCcAVAPjK82ltbtjYv2pccTsglh+ykwgBVlfE7Aouz7gdGwGXLJk0LYiqz0cI
         mtyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794235663; x=1794840463;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8BjfBvvBITs0v8vpJBTpPDcN60M30b+tl6LUSDLYEFY=;
        b=HfL6HNgTTL1NOTDPxFXVJS0Rt3gjUND3IxNMB5f2PFpjH/2vlWaf9+BLE6v6SQVDVy
         vYVyjo7PxA4MR4qUL6HjB9D0/cB9qAEPwgFWlq1GxZKwO4+vVeK/353dWu0vF6TgNgAn
         7xy3lpps8e+EFfiQ3h6qxPpv7Iss7hADML0jZa+G9fSdNv7oe2DhFq+XmkDRIpNiLHLZ
         tHfUXsxJoTwvhhRYWHnHvz5w/4WhtOt1lML+RfY867r583gcj7gnoFEGOf6d70QAjsZs
         Z54Q7JVNIBzGT9wJnPz6WopqcgWIzg92SdKk9/GyEbQ3pzZxkbkqn38lrHhUS0WWBqzs
         7Xdw==
X-Gm-Message-State: APuU4Z/VJH+gTshLtd7Esbx1uA4bEpbx2NiaG+5e1awoD9hJg7DounMk
	6Nz4huXmMVQ8icM+x2fIjHSvQzsQVqYx1efb4JXQQf8YCv6o3pfvxSqLyk9/lijW
X-Gm-Gg: AYBFou0MSl7w3lJBNc1Ga8UjWvqtGmnwgTBxE5NJujG+hBXUapdBIU2rTe6+Kp2YmFz
	ChXBY/E/Tpo+aHYQBQ4yBLpQmI9C9ssDT9ayiijXG/UdyXeiLcXfYGiYBFb0ZtQgIAe+4Wci5xe
	ZPthGmmXKG8WG4hnMMeeWS6dgFtU/iU8Ffi4XoRMFsWtBUJRep+5tmnVG1DgchOHAQe4/Z70asK
	RGLxDzcRyxwdYEutNcNkVDQmCbMWjzYu7tEAUjIBz77OxjqLk0wKRCtN2ccCK/KsMIgTSAhDJ7+
	nVd5ER/ziiQPcwFa+yRvXzSzTr2+w2kJLbB7yjQl8gSLCopvdaV6EOL0c8G4Hof5boLUJeR+K8Z
	tB0C7G4aUN6fj5PEMtuiN0TTBq19yFAI7G3WiEF+d9C9PfAU/hteJUpt0ljotAaetCWQiFgrZrX
	uuPfhlJRew1/A/B7LTyboQ1Tqji5PlXg4zX9/uwP+HuujbbqxIQe0zLqmnAo46hSF+X8DK3byaH
	+Efh03CxjuIS+CJgOvJi7oOPPrd+6hGyhUSN3rdUIiP+1KtDxs4xn43PXrW5wdTYTzm6QbsxHgR
	EfYSxu4mHLpHZqtP4VJSraqbNWb4AXeIPgLVvjA8xl5kcFNKGKr2AA==
X-Received: by 2002:a17:902:e80a:b0:2e9:a090:dd69 with SMTP id d9443c01a7336-2ed83777169mr42173915ad.39.1794235662770;
        Mon, 09 Nov 2026 06:47:42 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed8146de34sm12511945ad.5.2026.11.09.06.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 06:47:42 -0800 (PST)
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
Subject: [PATCH net-next v2] net: dsa: motorcomm: Free the MIB block on port teardown
Date: Mon,  9 Nov 2026 22:46:50 +0800
Message-ID: <20261109144705.1737460-1-mmyangfl@gmail.com>
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
.port_teardown(), is not true, thus free the MIB block in
.port_teardown(), so the next setup allocates zeroed blocks.

Not carrying a fix tag since there are no known multi-chip yt921x users.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
v2:
 - free the block on the error path
v1: https://lore.kernel.org/r/20261108101648.1308271-1-mmyangfl@gmail.com
 drivers/net/dsa/motorcomm/chip.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index 33e5fc127244..7e86d992bd97 100644
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
-	struct yt921x_mib *pm = pp->mib;
+	struct yt921x_mib *pm;
 	int res;
 
-	if (!pm && (BIT(port) & yt921x_info_ports_mask(info))) {
-		pm = devm_kzalloc(dev, sizeof(*pm), GFP_KERNEL);
+	if (BIT(port) & yt921x_info_ports_mask(info)) {
+		pm = kvzalloc_obj(*pm);
 		if (!pm)
 			return -ENOMEM;
 		pp->mib = pm;
@@ -2019,20 +2018,15 @@ static int yt921x_dsa_port_setup(struct dsa_switch *ds, int port)
 		pm->port = pp;
 		u64_stats_init(&pm->syncp);
 		INIT_DELAYED_WORK(&pm->work, yt921x_mib_poll);
-		/* Start disabled, so that the enable below always pairs with
-		 * either this disable or the one from a previous teardown
-		 */
-		disable_delayed_work_sync(&pm->work);
 	}
 
 	mutex_lock(&priv->reg_lock);
 	res = yt921x_port_setup(priv, port);
 	mutex_unlock(&priv->reg_lock);
-	if (res)
+	if (res) {
+		yt921x_dsa_port_teardown(ds, port);
 		return res;
-
-	if (pm)
-		enable_delayed_work(&pm->work);
+	}
 
 	return 0;
 }
-- 
2.53.0

