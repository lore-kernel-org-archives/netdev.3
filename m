Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 795B7342CB4
	for <netdev@vger.kernel.org>; Sat, 18 Jul 2026 05:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784354381; cv=none; b=N7ww3bshRxCcyEnoGhnZHoI4N3EnfBByKKlK71eH1FGHnJTCm0mShpGy4lbxIK/t4rNHr2QH3BFZvMpUKJXd9RdJ0IjTkQ9SC7TocnQKXkEpN2gszJqCSwf/WRYoCd+FwgmRKOaJvFBIuxwFDW9GE0hLZrwnJkqNniuWTerYPFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784354381; c=relaxed/simple;
	bh=WwnllD/mXuvB0IkE8YIa1I8h+3mzONccwh5at7FCJB8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=FgCIEVCnjaKElE7HRgVVhNTA2LQO0wgnKRXMvHKxplaVA+jU84VJcVphuHRTZPR3OUlDrObyq+uzkEI8WvYl8uje/yAcPf9nKVeYXOxQuP3MEZyS7iv4KLUXGnCTOL96+niJqwv4rLM7IgEkOBrz/1rEOpaW8M6NcpQuh7Mlm+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=r57EDrSX; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="r57EDrSX"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-6679d88abdcso5573530d50.2
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 22:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784354379; x=1784959179; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=X0DkQ5DXc4HMZaFOZgUFvbIdU0uSFY1GVEzfBo4fxgI=;
        b=r57EDrSXHj+5UPCvFU4zLUOBDe/sR8Z/+m9ZP6x/ZgyDqCSNHeDMJ8fQFC/SZzhP1Y
         cPG2LSNR8OWwqsh5HfK9aBwa2SGF3UCXwZMAx5lhAzDHrncNaoYli2ew0Qk4eH/w16Zk
         NFQS7h+U36nQ7m+/bZiDoRTLc24lrbd8F2KJUrzf7GgQSGPhbejKyAxxwGkqDsIRAMLm
         mVfcj+Pt+2RnUSOqyDwaoPZ4f+rwSLzsfxV9W6fBs5eVnTbgvdxy8pvnBFoqJIA/J0Le
         /Jfv49fucKPJyuwiQMOFevSmSuMEnb00Cws16ly8YfUC/3q4BildYAhbQsfwgBkEctqt
         YOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784354379; x=1784959179;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=X0DkQ5DXc4HMZaFOZgUFvbIdU0uSFY1GVEzfBo4fxgI=;
        b=JzIj5mC9GVshzKYS4bZjT6zBeUjjDy4c8vk9LyfSL54G3PU3knS/nLSd8DKGCnSpt4
         L9tFxmZh57MzS14MQoDKoqu1Y6qYrep34FtyG0KRFQvjuTJ8HQ99ZsCHJcNwnasksHiz
         j/zO7bZtUG6CRQLEIv10LANW4pawdZxAlO3vBVgXWANtsfTCtFomZezLMS7dNT7qJudS
         IbGSx5N7XS+Fz3NKmc9tdESKyAUZtMHYJsQnT933iDbFYnA2ypy3dTwl2Dts5SpXLSs1
         1j2sQ/vGEX+dEZH+b08Tp8/DJqOrwvE32TzpLMQDOj1LUQcomV/C5awDE5pTOKlNOnsK
         Qugw==
X-Gm-Message-State: AOJu0Yz8SvvblW+yUSWmVhApT4zRYQP30zRfySzadKXsUmNb25nYU3pJ
	7SA5WqoiDFOw460bRM/cqJfxF72FuhqzGbnT5jtSSyifFdF6IMlV9yh4al3k93lz
X-Gm-Gg: AfdE7clkk09kcjn/hShiJiKh9hTTheTohHttIglczkzCPkv5aLgby5MzF29OjqghPPY
	juyHkteET4Tmp9s4IO2It7eWnPbh5Ch/XsSn/NfosbAC39wI8Cz2lw/+f2J/S6Muu/Bx6+bF9bE
	JYIlFlXmlsBDUJlt3vZ5Td5pcsy6czhCAzkPu7/zdSfhC0BXRQwQ+MPEiE+irDqi8XrWjudsWvB
	xf7lI4G2VWaz9wFQp9QpR/vtDQ4KM1SKJ/njRpufB4X3vAHsNiX/w274CrRgxs/de4XoU0sTe4F
	haTuAQCGwRo8Ig53FWRAblNIoFiORyupoumcyytpnnQMoMZeFLhl5R7Xk0QeWuw57B7FisDALag
	3acQShVZQZ4F63qn+b3ld2z8fQ8I5xkwLHNNuZutHhnCPrKZv+Kx7k0FxYNvjRq/TN55r0yOOOA
	+7ZrWMbT2uPAT8p5D/0Q==
X-Received: by 2002:a53:c58b:0:b0:667:b6a3:c21b with SMTP id 956f58d0204a3-6683bc36b8emr1264477d50.46.1784354379333;
        Fri, 17 Jul 2026 22:59:39 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6683b80d194sm3081824d50.10.2026.07.17.22.59.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 22:59:38 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sat, 18 Jul 2026 02:59:05 -0300
Subject: [PATCH net-next] net: dsa: realtek: rtl8365mb: use devm_mutex_init
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260718-realtek_mutext-v1-1-1cd7beb20ae6@gmail.com>
X-B4-Tracking: v=1; b=H4sIACgWW2oC/yWM2wrCMBQEf6Xss4EkVCv+iojEdNXjJZbkVAql/
 27Ux2F3ZkZhFhbsmhmZbynyShXcqkG8hnShkb4yvPUb27mtyQwP5f34HJWTmtYF23muY+9bVGn
 IPMv0C+6RqCbVFw7/pYynG6N+e1iWD6vjajZ8AAAA
X-Change-ID: 20260718-realtek_mutext-41a072e5cd24
To: Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luiz Angelo Daros de Luca <luizluca@gmail.com>
X-Mailer: b4 0.15.2

mutex_destroy() is needed while debugging mutex. Instead of calling it
directly on driver .remove(), just use devm.

Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 15 ++++++++++++---
 drivers/net/dsa/realtek/rtl83xx.c        | 14 +++++++++++---
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 5ac091bf93c9..c787fdb75413 100644
--- a/drivers/net/dsa/realtek/rtl8365mb_main.c
+++ b/drivers/net/dsa/realtek/rtl8365mb_main.c
@@ -1988,16 +1988,19 @@ static void rtl8365mb_get_stats64(struct dsa_switch *ds, int port,
 	spin_unlock(&p->stats_lock);
 }
 
-static void rtl8365mb_stats_setup(struct realtek_priv *priv)
+static int rtl8365mb_stats_setup(struct realtek_priv *priv)
 {
 	struct rtl8365mb *mb = priv->chip_data;
 	struct dsa_switch *ds = &priv->ds;
 	struct dsa_port *dp;
+	int ret;
 
 	/* Per-chip global mutex to protect MIB counter access, since doing
 	 * so requires accessing a series of registers in a particular order.
 	 */
-	mutex_init(&mb->mib_lock);
+	ret = devm_mutex_init(priv->dev, &mb->mib_lock);
+	if (ret)
+		return ret;
 
 	dsa_switch_for_each_available_port(dp, ds) {
 		struct rtl8365mb_port *p = &mb->ports[dp->index];
@@ -2010,6 +2013,8 @@ static void rtl8365mb_stats_setup(struct realtek_priv *priv)
 		 */
 		INIT_DELAYED_WORK(&p->mib_work, rtl8365mb_stats_poll);
 	}
+
+	return 0;
 }
 
 static void rtl8365mb_stats_teardown(struct realtek_priv *priv)
@@ -2567,7 +2572,11 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	}
 
 	/* Start statistics counter polling */
-	rtl8365mb_stats_setup(priv);
+	ret = rtl8365mb_stats_setup(priv);
+	if (ret) {
+		dev_err(priv->dev, "failed to setup stats\n");
+		goto out_teardown_irq;
+	}
 
 	return 0;
 
diff --git a/drivers/net/dsa/realtek/rtl83xx.c b/drivers/net/dsa/realtek/rtl83xx.c
index 90843d52c5a8..35df809a5951 100644
--- a/drivers/net/dsa/realtek/rtl83xx.c
+++ b/drivers/net/dsa/realtek/rtl83xx.c
@@ -156,9 +156,17 @@ rtl83xx_probe(struct device *dev,
 	if (!priv)
 		return ERR_PTR(-ENOMEM);
 
-	mutex_init(&priv->map_lock);
-	mutex_init(&priv->vlan_lock);
-	mutex_init(&priv->l2_lock);
+	ret = devm_mutex_init(dev, &priv->map_lock);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = devm_mutex_init(dev, &priv->vlan_lock);
+	if (ret)
+		return ERR_PTR(ret);
+
+	ret = devm_mutex_init(dev, &priv->l2_lock);
+	if (ret)
+		return ERR_PTR(ret);
 
 	rc.lock_arg = priv;
 	priv->map = devm_regmap_init(dev, NULL, priv, &rc);

---
base-commit: ce6b4d3216b63f902bb8e9695ee6c10c83415f65
change-id: 20260718-realtek_mutext-41a072e5cd24

Best regards,
--  
Luiz Angelo Daros de Luca <luizluca@gmail.com>

