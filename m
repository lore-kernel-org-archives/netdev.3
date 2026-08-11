Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2981542B318
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786440571; cv=none; b=m3VQtsR+OvoY881M8BRm9e3bmjmdM0OUljEQDooUEPTyNTfz+Kvj3S3nIMiBWJxtew8XygxE8/KRqpe2SexkEzSk7hVGAJwne5btsiYR1ScswKoq8Vn14QdCGrZj7Cp+jQyd00h0tUDB8XuVvnRC+fAWqPd/xeMXcNaYU8JN9F8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786440571; c=relaxed/simple;
	bh=LbEGillG3O+kjyj0YMNED85u22Je+WjmMyS6VfSjF38=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YvRePYIWGi1p2wjtIAo8GMs+sFRk4IGKEoQTyfi9Bsz9epq0v2BmLn2ishOygSHi3YhHRPAXcW8Stmk8LLArTZeaM7YUgWrMnw2Ndoo7MtV9FDQFjqQ0nGomoJl27oE+hhUo45LOSl4jtBCgP8BDmoWf3PJpC+k1+Wd1KfDyOb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BTq0VKlU; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BTq0VKlU"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-498028b3d5eso32249165e9.1
        for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 02:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786440562; x=1787045362; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=5mpB2vpD+uaY+L+h47uF+iOxZ8EZmM0AVQF+rKLz4B8=;
        b=BTq0VKlUYk/CAF56VcxgB8DVG2Dhtb3Mqq3bvyvaII2icEd4ceQctCRANCr/sC2qZj
         FARjtBMOariMjPZVKidFl8Y/yk9ikVX4TmH2N74NZMHcLfWzvOZCA/h9NZdZSbRs6iod
         nY22UZXjWr49QA4Qg4zBjloXcx9BuayXRbjMDGXV+J3xLA/aORJuaW4Wf4wv6cC/gnOA
         1CfhL/3AEAvyxScReFIS+2PH9tCs9b9i+uNq+fSKwKlVr7KiXuZ4hO2UhbJ7l1EkjEy8
         G90HTSxlti8Jbcg4z/pQtVgNG2c74bmwvEcLAy8rCAW2CC6p0o5m8gNWImqfMLg8XFGd
         GnQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786440562; x=1787045362;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5mpB2vpD+uaY+L+h47uF+iOxZ8EZmM0AVQF+rKLz4B8=;
        b=SCMiVfCSCGCuvRooLzB13fiqFwfpl9rgxBsxAhcLh+te8uwI2sk5zD66YG+3GBXHqz
         04+9dBCiQdgpr0Lj1b0JWbLmSeRRDVd+UnmYgki7ONgTDkKlerKqGoV5FiXLbOyDI+Q1
         dTQnJ6dNdcPuTtbA6717wzOPi/THFv84a76lzDvUEZ2su7KSmsuO3dnydf0uD979Vugc
         eqmM1dpP89CrLvBAQPyOyWuafAjzIg2VDz9MCy21h1yXuBgvV2CcsCEipjPPGID0epjB
         cM8z7ksnO//SZezNumfOhyusa8QxE1zLWQFGVyyHjdQ2e4LfRy6QB99o64ZYSOJveeLA
         tr5g==
X-Forwarded-Encrypted: i=1; AHgh+RoccCG2sCBhLnWQbw1SERSOt5FH0tMPhLNOMZ+9jd0gPKEOA3t3cgJCI8JUG0HZCllcVVwkhBg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzimeOCHLSTjfCIAwhqUwIsq79xdiLW0r2tpIwc7WwApis8Br+W
	1V1YBKVFvVlyEbvyoGWPaDCX2G2OPXiI+YRZMWGQ7w8Le/0TEYBSSjTl
X-Gm-Gg: AR+sD12I9QVkgcE6LQKnOocK4forlSQNw2XtC7OVVxjLYY7FWTLTTorzXyjClj0jjKH
	M6XxKEGNZ4bYZAXe0U4OYXgG5CGRPpu9PcfOQuHBLa7QozNCJMD/EbpKX1gOqwDFS0R+wjDMeXR
	qHmDKygBNdaEI5TpAmzU/zHZkzqxIvmORpXNBhFHyUwJR4cbkbO7wQV2LIDZssX1LK0LvAjNffu
	NU5FfgR7VEBiSMlURS2bpgRMHGL7mI7asIlB7TXaJlOSRt0QNC1U8OHOE2sDBnYl9jvIlqbsLlJ
	X0ws5UZCWiwhyoie3qCA3vmNrCwCSfmg4shInC5QOb4iBgvhMorMXChhq/UQHXyZL+uCy8ej3qi
	LF3Hgv4030cXexuHhZJLRjdPPHWchF3Hm1dFx/xByynLbXGD8P+RvU1AOZsfQxz3zMAcn8m9zQ5
	mpcaFDfcR5h1MgOkMwT3AkH/tbEILNvf/iLOS+ynlAARvWNN73f1whHtg6ZDYvkIajbrI9I5CAA
	HYZiPRCs7SIu/22+Egab7R3Vh+yZfLiNqTLYNgrjJhG5vbd9TpS16GXhlKr
X-Received: by 2002:a05:600c:4fcf:b0:499:7219:122f with SMTP id 5b1f17b1804b1-4997843073emr24510875e9.4.1786440561565;
        Tue, 11 Aug 2026 02:29:21 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4997402a89bsm56135735e9.0.2026.08.11.02.29.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 02:29:20 -0700 (PDT)
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
Subject: [PATCH net-next v13 09/12] net: phylink: add .pcs_link_down PCS OP
Date: Tue, 11 Aug 2026 11:28:34 +0200
Message-ID: <20260811092843.673837-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260811092843.673837-1-ansuelsmth@gmail.com>
References: <20260811092843.673837-1-ansuelsmth@gmail.com>
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
index 39d742c90db7..ef9ccec0cd81 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -990,6 +990,12 @@ static void phylink_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
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
@@ -1701,6 +1707,9 @@ static void phylink_link_down(struct phylink *pl)
 
 	pl->mac_ops->mac_link_down(pl->config, pl->act_link_an_mode,
 				   pl->cur_interface);
+
+	phylink_pcs_link_down(pl->pcs);
+
 	phylink_info(pl, "Link is Down\n");
 }
 
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index ca9dfc142388..ea554c0d41f8 100644
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

