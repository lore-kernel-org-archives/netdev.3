Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D42409E12
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 10:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785407117; cv=none; b=MDERIKL4qkfpYo8X2WM5OZaTmQYgHmD9sco6JmgOpQORBBAb6QWyQdfkz3wuuGLWi8IlULoPX1qiBZwjr0Yav/SZOBev7MzqhJMq9wM7Z3cakIyxUvEx4lUQhoz0lqHrOXHHP2yK7HYiYLUVC3XV4JFYEPnvhkl6ixyE165UScY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785407117; c=relaxed/simple;
	bh=WmLmaj/+135XQeOqxQ4nLKeY20lGfUqmJfpxUJfBxfw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b0IERXh35iLrcPVUQBU27xyFYCIrvVy+4X0Vu3t0RScfvvznDY7OBdDjhdH/RTaMHOv4JL3VxAoCE5nAc5gsqfN0tgcSwBROa2957n8oauNTngJeUclQEdM3TsxbOw46QpW3Rf9Fu5jMgeaNP/9d8XWvqPiCIaPNndyESo7uU1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b2xX5ciW; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b2xX5ciW"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4954a9e8490so3247685e9.1
        for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 03:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785407113; x=1786011913; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lXt/uOqbphj4V91HISks6B4J5Xr/iPtpqYGyXndRE6o=;
        b=b2xX5ciWmz7hf3U3U0urTMiDqdMxfjj0y35LL1pxVuosraDnkNnDEpRxVM7u30IGm6
         0dcyxDTBg8MtumvB1EuUJuygkLz6tBVmbMuJDnBRor/lINWIF/irPVEU79/ILsx0LuUb
         zRWcbFgbqZPUUyNEgWPgAs/gUr0un8Ii2XjhBl2FKZOCKY1+FVKf/jlzZjnnB1pGAjl3
         zKgguJBpjU7tPPOgOO3GvT+e7fUaUKCGa1ivbVvF/QcnPzJqrggkiQDmKlXzXkFby6ev
         +FF6aFiSVDIJiUWvVG3Swf/mIAomEycXaEPANguIHE6KpjA33znNipNKgnID606onZrv
         onxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785407113; x=1786011913;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lXt/uOqbphj4V91HISks6B4J5Xr/iPtpqYGyXndRE6o=;
        b=Ey6QU5D2VW+OIkIZkQS7D4S9lUmSi4JmcJ7gWpQxq1cyRJzQ1lbQIcSNWT9OEesBi+
         WbX2tdH3CefbUZxYgbFEM45v2odbmPg3v0GN2x/lpEKJiirlMmPK4fo1+U2Qo8YUlbIH
         3BY1Tr1kC5iRx8Gusi0v0VI88uizQMSetoZBOsEzUEsYBMy12MxAVAyBxl9u1zuWXCDn
         iFWiSwlgQ26lBjh/D770I6xafkXRRitTDcWH9j2hVszcGIRKQoNujxqwYufc4p66rRQF
         Qld/N4RknqcnXeLnomEQeeKggL5iah7aG011PHaoQy9C+WJQNeowoRwwr5VKk9GUDFd+
         vOaw==
X-Forwarded-Encrypted: i=1; AHgh+RofwIVsmIPUbMNtR228gvGhd9jGI3HNxH7SJe2TCoBB7CUJyHAQKXeSIe5+10jp7edhJ1g8u/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx6mfEnaADzWCSShFlVIem98OxqmKWXYUKkA4XUYmuKh8E7PhII
	dFJNuGprgXydDdfIs6D5zsvFnEtih1jwTxoIwAyxvU2k3ASZForBETjq
X-Gm-Gg: AR+sD10ofdxNv0HvpPw2yvcCFAzPCwqqjooyXqLGPSCtJm9j/E+hEPrzRmRkrSuPZjM
	F6aetQbsA4KPyPP28Hmz6wzaKFmOuIna9BwQm06dDFS6Go58BQFJM59af/IsBtCMBVlFpdOY9Cb
	JSXK223u5hlXCN+Vs78BHBwzaCcTaShDgxREM/feRcWTvHjYRUeuPjbCLCtbpiisd/Vg/4oCoT3
	mmEOfKI2CFmP1QZ4VbsBScnObCswUZ1M4zJY6pa9LaDuPAg5qXedGH3Ya9V/lbQ1Km6LLVL84p9
	UGo/O9a7jNQIIaoz9RXPg7LdfewYNhebf+By/IAgojatDledrkmTMgE49dm+R8CY5aajvmzkwVL
	GoaMWLmA8C1icCD24lQlz7eC89jsgWbTWB+m4hyvYrddI/J7QIA1InArWO0IPANWjTssHJT2Z4V
	RowGbdnuSh7t2FltWqW9j0T7SOOpywY2IMN1hqwmz5BEtY/g49i0UfH+jZ5WkE3D7ZaPI4FLNqh
	3qEkOVQT/wlEQpqXr834MUTgOBoWb9+UiSLBaxtGxdVAeKzgiGkaw==
X-Received: by 2002:a05:600c:45d5:b0:495:6022:5a23 with SMTP id 5b1f17b1804b1-49801f2b8c2mr20936175e9.19.1785407112977;
        Thu, 30 Jul 2026 03:25:12 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-11-254-126.retail.telecomitalia.it. [87.11.254.126])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-498011fd5fesm44720295e9.7.2026.07.30.03.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jul 2026 03:25:12 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	llvm@lists.linux.dev
Subject: [PATCH net-next v10 08/11] net: phylink: add .pcs_link_down PCS OP
Date: Thu, 30 Jul 2026 12:24:19 +0200
Message-ID: <20260730102444.1967900-9-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260730102444.1967900-1-ansuelsmth@gmail.com>
References: <20260730102444.1967900-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Permit for PCS driver to define specific operation to tear down the link
between the MAC and the PCS.

This might be needed for some PCS that reset counter or require special
reset to correctly work if the link needs to be restored later.

On phylink_link_down() call, the additional phylink_pcs_link_down() will
be called after .mac_link_down to tear down the link.

PCS driver will need to define .pcs_link_down to make use of this.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
 drivers/net/phy/phylink.c |  9 +++++++++
 include/linux/phylink.h   | 12 ++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index d38820543ae4..f45bdb8c3647 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1041,6 +1041,12 @@ static void phylink_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 		pcs->ops->pcs_link_up(pcs, neg_mode, interface, speed, duplex);
 }
 
+static void phylink_pcs_link_down(struct phylink_pcs *pcs)
+{
+	if (pcs && pcs->ops->pcs_link_down)
+		pcs->ops->pcs_link_down(pcs);
+}
+
 static void phylink_pcs_disable_eee(struct phylink_pcs *pcs)
 {
 	if (pcs && pcs->ops->pcs_disable_eee)
@@ -1742,6 +1748,9 @@ static void phylink_link_down(struct phylink *pl)
 
 	pl->mac_ops->mac_link_down(pl->config, pl->act_link_an_mode,
 				   pl->cur_interface);
+
+	phylink_pcs_link_down(pl->pcs);
+
 	phylink_info(pl, "Link is Down\n");
 }
 
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 15e6b1a39dfe..4af8598b819a 100644
--- a/include/linux/phylink.h
+++ b/include/linux/phylink.h
@@ -528,6 +528,7 @@ struct phylink_pcs {
  * @pcs_an_restart: restart 802.3z BaseX autonegotiation.
  * @pcs_link_up: program the PCS for the resolved link configuration
  *               (where necessary).
+ * @pcs_link_down: tear down link between MAC and PCS.
  * @pcs_disable_eee: optional notification to PCS that EEE has been disabled
  *		     at the MAC.
  * @pcs_enable_eee: optional notification to PCS that EEE will be enabled at
@@ -555,6 +556,7 @@ struct phylink_pcs_ops {
 	void (*pcs_an_restart)(struct phylink_pcs *pcs);
 	void (*pcs_link_up)(struct phylink_pcs *pcs, unsigned int neg_mode,
 			    phy_interface_t interface, int speed, int duplex);
+	void (*pcs_link_down)(struct phylink_pcs *pcs);
 	void (*pcs_disable_eee)(struct phylink_pcs *pcs);
 	void (*pcs_enable_eee)(struct phylink_pcs *pcs);
 	int (*pcs_pre_init)(struct phylink_pcs *pcs);
@@ -690,6 +692,16 @@ void pcs_an_restart(struct phylink_pcs *pcs);
 void pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
 		 phy_interface_t interface, int speed, int duplex);
 
+/**
+ * pcs_link_down() - tear down link between MAC and PCS
+ * @pcs: a pointer to a &struct phylink_pcs.
+ *
+ * This call will be made just after mac_link_down() to inform the PCS the
+ * link has gone down. PCS should be configured to stop processing packets
+ * for transmission and reception.
+ */
+void pcs_link_down(struct phylink_pcs *pcs);
+
 /**
  * pcs_disable_eee() - Disable EEE at the PCS
  * @pcs: a pointer to a &struct phylink_pcs
-- 
2.53.0

