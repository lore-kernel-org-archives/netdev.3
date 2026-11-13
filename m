Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794567956;
	b=RY02yzpLJA7eq+boyrC0scz8xDmJHp60RJA1S20mI51HKb3EQ8vmz/EHxNGp6wd+ODuO
	 TRJNsTnnvf7yWNEkgJp1J3th9fUeJBv+kvvStYZDc9hXKFl6PdtPi4zoHlwLc3uytV3Ab
	 zjGNRApH059StYvK929GXYY/+Mk6oJWpRN8USXBcQj6rRIpayIYrps7VhSUjl2HAWYWps
	 L+AebtE21TrQ4Sjxfr9G7ebFXMiubk/hxt2JtBuUrs8eIJnFHr/3BO9yZ6w9c8YfG7IY/
	 y272tjPRZSq/VxgExxTBf8OKWcPgusj1eX+G8Oa6u2KTnlcos/9vQ5Co5IgL2S+QXlw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794567956;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=OAMFRA4MILVUay22QJQKSMwjrT+qbjZ4D1oCAQSCI+c=;
	b=POrJLc6CXwZpWlq0ITvmsU+30GzIko12b7D6tLqn9Myi5+muBQsJNoCTiIiJTyWaUN5q
	 4SBRwDuAUSaXm+vOrw07RsoExq2vFA7FCGTIuHj3fCr02lrVrbQjsEbbJ2WxLfbt9u6us
	 lZxk/LcGvdvB0F1FnCL0C+AmwqQiotIEx9rMoo/5Q9IfjImtu0hvO9xQYMRVV0mnrSpuY
	 Me9wAW+1Z9D2F7M6DXHLtk8q8nh9rW5YW14muJ47S4MQmOckXrwjd48gq0ZM40q90QO6l
	 SkSOGLTcHnydzuqIi3qB4Efefjs9tnYWQbXfTFZFb+cywu+xtWdZGxmyd3hwFknVQIw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jo+ONOyC;
	arc=none smtp.remote-ip=209.85.167.47
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 907B9606A8A1
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 11:05:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 907B9606A8A1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jo+ONOyC
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5c14f7768acso905232e87.3
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 03:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794567955; x=1795172755; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OAMFRA4MILVUay22QJQKSMwjrT+qbjZ4D1oCAQSCI+c=;
        b=jo+ONOyCKDe8UX+n1zi00jnNg9W+sqeTQgmGfNxc8ZvZG9lJQrQIxOxdmEH69xpvFc
         qQD2rOGrv2xNeW2DkLhpbBF1D3SgefvWfrLN2fusVXfW3PT7wuHTpbkpbCOQiN1eMTjn
         IoO5c6VmKi/Lw17SHc58MGSL1JJdUWhL7Rn+Z2it220v4DkWlL/96LVdyZCIteof3BfI
         RzAvber7p1RZyS0cuD9zfNr74B0PrH7YWHfrbCfqOFv96Agu8z5yLQyBjXRX2VT++5+6
         mB3glPsueqCs7cQpeu2P1GVFDXTZpTbXXII2NF9gUCP7FwO23Xq4hf42x16FgN7Ke+tI
         Hs4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794567955; x=1795172755;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OAMFRA4MILVUay22QJQKSMwjrT+qbjZ4D1oCAQSCI+c=;
        b=gdOyLA4CbqWUcEb/eBGkNjAP7r17tD448UGdl40TwM+JD/MOzC0dy+VEAUF/DZtoWf
         d/DEX8MRGGD+7IeVcLUS+EZgs/6jjhdRN6GxB2GDy9p9esIFJMgIP3MxfpzGF03VzM03
         GvI7O3HVWalSllEOJFPxmO2jj3XNR4HpPTdh9HGquzto2gi8chcihCW+jRNDHgxglzz7
         lf80lQYKVs+jcObBwxdYKyTRz4GkcI4AiT9tQYrMFEu9HGNi0D7PdtEeQfvSf86hxesl
         0rvzf+BoL/Kvhr2ncgzk6YpDPIj3/8hvu6X/6lKTVrbQBKztq7fnkIRMF6fbrBNJ6qZn
         RxPw==
X-Forwarded-Encrypted: i=1; AL+hErH1eZr/wUvntVWDeG08Ns6JxxnVcwOl30ROa9pd1IlDWEcx+ygSlIW6nFDnWsfJFeNvSny7+pI=@vger.kernel.org
X-Gm-Message-State: APuU4Z+GazsnbRs5VZdB1uEaOZVQe3kVc9MLC5dBxm2XyQB34EvL4cNn
	jML9v5O16iqVIMFarRQtxZFKaVf6fxaS63K2COwJwq04259agPzqZOxv
X-Gm-Gg: AYBFou1U92KVPGh1gqUdyh9PPVCd/Jy38jE7cPD1aWdw1oDeXiQjD19VrpEoqUsZJoT
	TmOBg1BOuZNGhQNTRHiLzkIeoeSa7pcfY3W41FFjNX20zfOd7QY+ZzCLK0Se5DL/jBNqZdzIFDd
	XMRlpMu05l/T2p7H8IqkId24gQ6FUDkU1YO6QLNKmhYAmYKhbzDePLLihvLIaDJPcjheh8TBVzm
	d8OZrBFtAgBHYVuWkAKbiZk1RQFTsl9g2T2PTchx9vSKia4X5jC89+eePia56Cn+8SJgXrB+9XX
	eN0YvqnK594qFK3Mn0hBscNx9hUsooZYRpCoEDfvgh4SAAOoTnbnT5Vq1pD2UD0RBHhnIcfQrGV
	a6MyB0o3yoG5Yn8ZuR9YuZQJAj1Bw7TeeLCDTkZKzoQm+sUns/hJDhkg+fKFpRESMORGgZUMQ/D
	ydKd+IZisikvSp83PzpmjPERuvMIEc4kGo/LGH5U/mTG8fjzdqK7/+5iNH2ywlVMdNXdTEJyh+8
	xHEYegNU91TxVr0JdOtd3WB//tJZ8TROuf90+TRVohfaTnexfHx+lhlHq8AYFR//spz/vYTl/3F
	4iq0TlNg/ofbIg2xPauqYSUYgVw5ISDcBOiJLkoQzEatQ1s=
X-Received: by 2002:a05:6512:31c3:b0:5c1:4f6f:564c with SMTP id 2adb3069b0e04-5c1709c5b64mr825566e87.39.1794567954595;
        Fri, 13 Nov 2026 03:05:54 -0800 (PST)
Received: from NB-6746.corp.yadro.com ([188.243.183.76])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c17133371asm610997e87.21.2026.11.13.03.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 03:05:54 -0800 (PST)
From: Artem Shimko <a.shimko.dev@gmail.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	maxime.chevallier@bootlin.com,
	pavel@ucw.cz,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-leds@vger.kernel.org
Cc: Artem Shimko <a.shimko.dev@gmail.com>,
	netdev@vger.kernel.org
Subject: [PATCH net-next 2/3] net: phy: dap8211r: add extended register write helper
Date: Fri, 13 Nov 2026 14:05:44 +0300
Message-ID: <20261113110546.173624-3-a.shimko.dev@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261113110546.173624-1-a.shimko.dev@gmail.com>
References: <20261113110546.173624-1-a.shimko.dev@gmail.com>
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

Add dap8211r_write_ext() to write extended registers via the indirect
access registers of the phy.

This will be used to write extended registers of the dap8211r.

No functional change.

Signed-off-by: Artem Shimko <a.shimko.dev@gmail.com>
---
 drivers/net/phy/dap8211r.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/drivers/net/phy/dap8211r.c b/drivers/net/phy/dap8211r.c
index 0bf770f8ebbb..4eb50c26397f 100644
--- a/drivers/net/phy/dap8211r.c
+++ b/drivers/net/phy/dap8211r.c
@@ -88,6 +88,32 @@ static int dap8211r_read_ext(struct phy_device *phydev, u16 reg)
 	return ret;
 }
 
+/**
+ * dap8211r_write_ext() - Write extended register
+ * @phydev: PHY device structure
+ * @reg: Extended register address
+ * @data: Data to write
+ *
+ * Writes a PHY extended register using the indirect access method.
+ * The caller must hold the MDIO bus lock.
+ *
+ * Return: 0 on success, or negative error code
+ */
+static int dap8211r_write_ext(struct phy_device *phydev, u16 reg, u16 data)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+	ret = __phy_write(phydev, DAP8211R_EXT_ADD, reg);
+	if (ret < 0)
+		goto out;
+
+	ret = __phy_write(phydev, DAP8211R_EXT_DATA, data);
+out:
+	phy_unlock_mdio_bus(phydev);
+	return ret;
+}
+
 /**
  * dap8211r_modify_ext() - Modify extended register bits
  * @phydev: PHY device structure
-- 
2.43.0

