Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793172654;
	b=npHpwQ8jab5X0wGVDSnwgXdWlAC3AIVhnaYlK/Lh3O32/C3XD31mncgFQWhW0acGoWFU
	 vkBM1ksf/CfF3Za32MEKLjb0gkJNl3vIbHwSuS1XA/1gwaoy5KJSJ4RT85Avdrdg3M+0C
	 1ceBHci2US+vZe8qaGCrtHKASPSxKdEVFa8tXwBzcyH7sQwP28bvCHdXvOkMSlMnZs8fG
	 VPWW17kb5e5MAKxtnOcJGIN3LRvKcHAymVKLC9J4gBy5noHYkyfdUxFAHnNE0f22T16UC
	 4tL6eGdd8holVu2EreweosggQo6JdoiksqZMRdUTv1Oy0fCnSeanaj7ehXoYT6Bo0Ag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793172654;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=94kzz6GGJdMjFdi0mDx2nMqMBoR4dk5VY7WfJdM579Q=;
	b=qwf+Q5XiJubjNLCv63oz+lWDrNnYxLjF0QYOvpQeNfZzsfDUXWg+h50wnsXWZTlZyZyi
	 FlCs2nnoj1QBAZ6E7KM1NlfgRK+NsOAjwY1kn+Q8TJjk+9b3GPs9IjP917qS+xc2Km0gx
	 QCs2CUUbEFO1Ojh2jDdFTKbc5htUA9bkqVro3KRraA3VDQ1yn934g2gUaJGADgBJj2WD1
	 Z89gLjDAEhzudhwbJSmdv+zBNOeJAsQ7QoypGkZa8fc8X6+Bk9Hawg2GEp4jcahvWV05t
	 Yfte9+mDENRvablplF0nSCMrSql+ZRP8dS/Woxrcrl7YsYmg754bZAuBgPLbhOW6ttA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WZ+z9Wo4;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAD0660A2630
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 07:30:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CAD0660A2630
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WZ+z9Wo4
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e0d1da913so495581f8f.1
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 00:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793172652; x=1793777452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=94kzz6GGJdMjFdi0mDx2nMqMBoR4dk5VY7WfJdM579Q=;
        b=WZ+z9Wo4PRZTAGCy4/qGkMlH8XOdWPx9Xrv6zXEpt5KnGpDgkYcu+uMAjerL1vkGII
         VHnG0MVP4H/rTJ/X/OdQsKRtUu8VODHK1q64n9Pi58WUZNItaTJxNfMqxWhmEJRNGtRL
         ADwW1Gw0IOj4bGPB6ZVOoqfIy3BKLZyYHe17ZRGhpvAI/mvwxYGLZUrNwJWM0lmTJv4B
         Rk6oTqozF14YkxhK9Ilw1ErvZdih4ZL1DYnqX0hn7dIfTH4Cid1nWM9goMONKyIOTn6P
         LjoTfwHsl+ONKpDbjVl742eKS37dHsaz/ZqZk42Zjv4hKwe9ZoDEIA3krMdJOe2HXT03
         Xtvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793172652; x=1793777452;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=94kzz6GGJdMjFdi0mDx2nMqMBoR4dk5VY7WfJdM579Q=;
        b=RhjXk3ihCSNnNrc1RVP8ipUf48kqzed7VAeDFyrO7p8bUqH5N4Mq6JI8CeMmc5c8Qy
         bCNObsuvDucE+9eWRdC5E4UACSwIVugje3vHQRzWz+PM9yd6Emoc1E/utI7v1RbvVvxc
         bChFBY7W1cbpYxTwkJRKZgfubAbmCc8mz1N+xBPnFh+I5L17ko0XJvjqib0CnRytQTqE
         sCbMqlX2af3XwUguQuULgvta3YdZxQfg0l4N+XpwMZwRo3QWyjEUW5iwO2LiKabvMFrY
         WDzCFWnXVcLC73Fw6yIWla6c1fJfKcQbKBrwX9ndiDOSMa1KocnOJGpjTAGAKIAb5E9J
         KtdQ==
X-Forwarded-Encrypted: i=1; AKwUvBy3N8JtDR5zSxcpG3czurrAraVhJdKLCRVcbi99XYierIJoBBPkSqk6gmsOQHRsh162durrpG0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJeEYIBRJ9CdmjhSWSP5NACg2EKUki0pZFs98nLVgzSBkiGJyl7
	+W/j0Uj8s5kJSWtzYG2roYX8PFONiJs9XbP47awkR8+lhsjgPcxSJbxZ
X-Gm-Gg: AYBFou3law6LgSSkrjhL+aFEUHsz5PgJvtktLBDv+a3BFEqlt+SBr3uZ9jp55XlKemv
	rL3hlS6xZmtSuEyZ4J7pjIZS497DhRmnanC3zdYLp0U8gLNADKLn7/bx2bWSUd7yeV4+KrfzNmx
	yBR80JyEqyc21qXyy7xdcb+frP88qpP3dmOIVZW82A9elR5hrHQTlxUR6FFjIyaWuQ4KqJtK7Ss
	t0wuitAAU3JTz5hTLMRwTmT3UB2Pdc9x6Duu7LFuVLEEyBm8iswCaWo911U7lQkWJl/557g+t+q
	nXTnVpUF1KzVGAs7iFNtTXXYuP1Pp9I+/kD8Thblh6FeqtbYXI5+4vQSgXqSJ6g3aEqjsu8F6dE
	b2Xl57KPDjqIFv4PUdna6nV95FoTW8Pvu5QbX+AuM0tD3j1by6/Qmwk0h2pWcgm2sF8qQqN+y0K
	3yl3KSh6zYBGhhGmhSRbnHZAZODYYk5aMtMzkRftYE+xc/BCSJVhT6eNygq75OVcYWh1LQXtWrX
	qVVNc8hcYR7InZSLqgr7g6zDJiaUYHI0bQWnfGH0W2aorJot2dH/FL9cxpW65XVDOpSotlfnR9Y
	gBmRIiqqnn0Tx0oKo8UyBpAuMDfY97Jl71gKoZsH9P99Ua2n7nYWYzGZUeXsd+rE4oHrsG/7Zz1
	Jf/1Bq8BeqVHtuuaqoGY89QekLvF57RZIIA==
X-Received: by 2002:a05:6000:1081:b0:48d:f5c1:dc24 with SMTP id ffacd0b85a97d-48e55a377d4mr9182155f8f.6.1793172652133;
        Wed, 28 Oct 2026 00:30:52 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (93-34-92-187.ip49.fastwebnet.it. [93.34.92.187])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-48e542ed998sm12083088f8f.13.2026.10.28.00.30.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 00:30:51 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v3 4/4] net: phy: as21xxx: handle odd firmware on loading
Date: Wed, 28 Oct 2026 08:30:22 +0100
Message-ID: <20261028073024.25175-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261028073024.25175-1-ansuelsmth@gmail.com>
References: <20261028073024.25175-1-ansuelsmth@gmail.com>
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

Even if firmware for AS21xxx should be always u16 aligned, we can't assume
this will be the same forever. Better address this by simply validate the
index before reading out of bound from the data buffer.

A zero padded buffer will be passed to the AS21xxx mailbox in such case.

Fixes: 830877d89edc ("net: phy: Add support for Aeonsemi AS21xxx PHYs")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/as21xxx.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/as21xxx.c b/drivers/net/phy/as21xxx.c
index 81e9827873bf..655127a656c4 100644
--- a/drivers/net/phy/as21xxx.c
+++ b/drivers/net/phy/as21xxx.c
@@ -323,9 +323,11 @@ static int aeon_firmware_boot(struct phy_device *phydev, const u8 *data,
 		return -EINVAL;
 	}
 
-	/* Firmware is always aligned to u16 */
+	/* Firmware should be u16 aligned, zero-pad a trailing odd byte */
 	for (i = 0; i < size; i += 2) {
-		val = data[i + 1] << 8 | data[i];
+		val = data[i];
+		if (i + 1 < size)
+			val |= data[i + 1] << 8;
 
 		ret = phy_write_mmd(phydev, MDIO_MMD_VEND1,
 				    VEND1_GLB_REG_MDIO_INDIRECT_LOAD, val);
-- 
2.55.0

