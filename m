Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCBD934676F
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 01:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785117400; cv=none; b=GkuGBr4wr21MonTtr8TKtuqlaLs3RTzuQPNawR+fepWDF6Qgpodkl+NEhUuxy9awkyz/7vMMI/Gbw8+eX4sfjz+mgUvwjs0qblQsPwJGrIwxaf4Sd7ybGyy8mcquet+rpi15wxdQn4WQqbuT3/9G+kw04ieoOJXxycal13KDACo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785117400; c=relaxed/simple;
	bh=nxK8f6yVcLMgY2eLtsiw3QjFWSy2v/cd+tQ/J9b1ErU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NNhM/vByDYgvJlldycbcxDE/jqEXgTNVFp6DbQ9wTlQfBAWQd2tPLi2vi6CfIUHTHc6GdKLpf1uaSOT5JslVimDpM6VzJrwZP0z3STeQyjHsUsJqOe0mVC/8k2/7yUPGAaMEa/UW7Mdjx/gxZMzZgd/cLut5LVf+NJypG3cLZKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gw6zJTLt; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw6zJTLt"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-74ae4c75b20so1237094137.1
        for <netdev@vger.kernel.org>; Sun, 26 Jul 2026 18:56:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785117397; x=1785722197; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/KEsxawBlLKcLepyrN60rhGB4cDH+dZWZnxegpUWZ1Y=;
        b=Gw6zJTLt8/DO/B+rDYbCH6QXAjo8ED0jUSj+DP+UIWleG6VeCdBBQtKv5kbA/JkoI3
         rPwE+SlQkGHtRL+bdpoxzki9em9C9uaBbS8KeX0skNqp5abFUFWN1yRVP/7SYvEm9KBP
         CqqcYTm3rWY0wBEZuSg+QqiIHizRP0RA2TyPfb9gyJ8AqNpqPcZ8i2JkLA1DUA6Btn8U
         6l+csQAwHCaAGWwq2iJe6tPGagKoFo1OoQP2wknba+l0F9xWl5OGPl6Zk9pOm6cbbjjq
         JgS8/56khLlFVNphSbgDhZL81rsWMnup/aM4EL/pICO97mgrLNbp2F2oqIGQAbPokFuG
         6ABw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785117397; x=1785722197;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/KEsxawBlLKcLepyrN60rhGB4cDH+dZWZnxegpUWZ1Y=;
        b=lrThCe+i8f/H0fEmBW59hXq5R1HIUxUFC27Jntd6v4819qF25WmQJs8i8oYTB+KNm+
         pfzp+LL1IxnSPnp8lCSzTFlRD4sZLMXzue8Pn+17mAwII/0gsYUYeYkX5rjg7Wg0+iS6
         F01JH8JRaXim/sfGaD/R0XvgQZDSotqKXnwNZJa+iWDa+V3SVeaFTQF8qmUQ8N7sYYXN
         LoZnWBEpv585TsShoOg1BHHPkMh05L76pSAKm4YYEABhRnfAKsCPsaynKcXHJDBauqWp
         4Xfv0ZBsQ6g/qsmWTQ7LRV1wyEnELbTpus9zJ4oavacPPLfRNCauEmtOLBNe+yq6lBhf
         8B3Q==
X-Forwarded-Encrypted: i=1; AHgh+RqvG9b//Zaq9bhkRiMf9cpaT3AUT9cBpESSnXsobUIiRF/fkcizb21i8iljOk2yBocKu7CMLAE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5bft6AKmVC+81SzBvWkuSudV+i+sy3dUQ0wFLDDZZ+Uab5rGc
	BHvDf+WP7T8c0g6Ax1Za2bMZ/KPMHk9H5+e/UTxXVtzF4UQ0gb3uCfqv
X-Gm-Gg: AR+sD1379AvNMAwgy7ELN2GCac5KfogElsAvHH8yb0Qm4vMGdAfcf08WLI1NVguPTur
	Z4+mS1AuwKmxQoGMjex7DxmOp0l420viz2CCzO5wHJ+54Av0FVQf4XPI4th/gTs917cDrI198MQ
	GYyn/8FrvzCimVWqGCSQ0ztDuz9G6eNU+wR5K+PDDnwsk4lZsaUZaJMYvQRGunMWgUzJUOCilXe
	xPPR0kfxZ+uxwQB0VvvDpomCy+hNUmBEI0qtcmXDYMiV5vL77JAbM6budcuWYIatzoQWNGO2kb+
	AIuVJY2kKDgY6xNzXCy8BK5UBpyW2iSM2XqRFSqskvgP7D6Z0Tdxv8aB9ceIaUXm/kCpFkaYdfh
	EHC/5VhdwncXTNQQ1Z6EROlmT2aQydFRl1WdDYjLzNBCkp3Q88DmrqNRZ6ANw3eufAp/HvYvAVk
	QDm4D/oec9rx0gAam/Tw==
X-Received: by 2002:a05:6102:c10:b0:737:b102:c1b4 with SMTP id ada2fe7eead31-75049e3e4b5mr3324919137.7.1785117396710;
        Sun, 26 Jul 2026 18:56:36 -0700 (PDT)
Received: from tresc054937.tre-sc.gov.br ([187.65.210.13])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-75036705086sm4545306137.12.2026.07.26.18.56.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Jul 2026 18:56:35 -0700 (PDT)
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 26 Jul 2026 22:56:08 -0300
Subject: [PATCH net v2 1/4] net: dsa: realtek: rtl8365mb: use
 devm_mutex_init for mib_lock
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260726-realtek_mutext-v2-1-5d62ba998791@gmail.com>
References: <20260726-realtek_mutext-v2-0-5d62ba998791@gmail.com>
In-Reply-To: <20260726-realtek_mutext-v2-0-5d62ba998791@gmail.com>
To: Linus Walleij <linusw@kernel.org>, 
 =?utf-8?q?Alvin_=C5=A0ipraga?= <alsi@bang-olufsen.dk>, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Michael Rasmussen <mir@bang-olufsen.dk>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: Luiz Angelo Daros de Luca <luizluca@gmail.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org
X-Mailer: b4 0.15.2

With CONFIG_DEBUG_MUTEXES enabled, mutex_destroy() needs to be called
before the lock is discarded. Use devm_mutex_init() instead so the
cleanup is handled automatically.

Fixes: 4af2950c50c86 ("net: dsa: realtek-smi: add rtl8365mb subdriver for RTL8365MB-VC")
Reviewed-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
---
 drivers/net/dsa/realtek/rtl8365mb_main.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dsa/realtek/rtl8365mb_main.c b/drivers/net/dsa/realtek/rtl8365mb_main.c
index 5ac091bf93c9..aa05375b090a 100644
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
@@ -2567,7 +2572,12 @@ static int rtl8365mb_setup(struct dsa_switch *ds)
 	}
 
 	/* Start statistics counter polling */
-	rtl8365mb_stats_setup(priv);
+	ret = rtl8365mb_stats_setup(priv);
+	if (ret) {
+		dev_err(priv->dev, "failed to setup stats: %pe\n",
+			ERR_PTR(ret));
+		goto out_teardown_irq;
+	}
 
 	return 0;
 

-- 
2.55.0

