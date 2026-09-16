Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECB1155409C
	for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 23:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789602767; cv=none; b=iXusgmdQrhGlz8Z+C6BXHMilSHbHiUoLfB8sQILSkssI4r+av8nqGQiMrG9faYeU388dScFPlU7sCN9q5aledQTg0E9GU+S+cRqzapodKIjSbuqKNTrXrOvsjqJg47Q3cdfPVybqBXVM8+QcN0+xqowUxTmcvZWJT64kfTiHEqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789602767; c=relaxed/simple;
	bh=b2ZTj/hqac5Bu490z9HWnfJ2mMnQbukUiSmhlGwiJTE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ML1QryORWPy4+7QeyvRWB/NVmdi9ZDgj/ycON51mrLS5Fsjx/oF3GvXgYWCiOUuDS63DmXOrbMrpoUV5QgmrAwwy8UhtUwDPvvci1aR0tFtgMUrdq3xZ15TsNh9K59m0u7Cii5L4EnPa/PAfM8U+nTTJ7gjPjEBjUZ0rKwzoZhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ffRDvdQd; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffRDvdQd"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-485933b2522so178335f8f.0
        for <netdev@vger.kernel.org>; Wed, 16 Sep 2026 16:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789602759; x=1790207559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3dUdIXrb4EJhWqsgdcMtWptyH7euJr+vzXL7VI47qrw=;
        b=ffRDvdQdJdSdEZbHdezewo5XgwqPANFkGDS9y+f9rcNfBHbocxxaRI/YSlX29itUTj
         RjT31LKJ50H6Id2lOoTrgsxL7ylFAZ1R94lO/+ztniZmSdvBxWOYKI/q0sIi+EJoG+Fp
         huYbqfw+eWpQF9EkQhe3DkzA7kcJjYcJr8qEbieiXh1gTqeE8JIroc26ef9V0HLLxofa
         jHEXyWI9yGlLTtoQCRS3nbeGgz0HOS3wGPHFmrqGS6Pibcon9j4CCOM9A1xO/tKEh9Pr
         zVwfYmtUW0z3gsihfQNWp68YGlWsY2qdjxAJCpOPb+bxNL80wdYVlJKd5QttjeydAplZ
         bozw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789602759; x=1790207559;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=3dUdIXrb4EJhWqsgdcMtWptyH7euJr+vzXL7VI47qrw=;
        b=nb3pAJdVrME3LTo/UjFWaoKQUaQ1dpQAEsfyJn01AbH1iuFwX6MvvYRuzHKwUZCuEB
         RBGfG5+ceVH80T13NEamL41E7iJJxSBenBK4mDCxfCz/8VEFtv0QfUji/ufYg6fDGjPa
         vrJ8BwHXMUMd8tMuEH2kyjaLzXqEa/YTxisgjL17pCpIX+VdnuBUGUiUfoTMV5XlG2iD
         R3RsCAXoMxplazfMkrwrx7G3jp+jxkwhu+mWEoAR9mMjFxmFeWlk2gHpWVTvb2qPLRzq
         x1YQOcjHMwE/j8IlakcSCeKBNmgalDMnXEPR5QKzG0vSePXVl60zcBsBge2Ugp8waWY3
         DcyQ==
X-Forwarded-Encrypted: i=1; AKwUvBwmbzQUsGIj3F0+qZR/4Ty6IyhU8NGCgjOPZYxpHrhOCLLkRVqoavvS/RwLxzFXdLOEsVP67Bo=@vger.kernel.org
X-Gm-Message-State: AFuF++nCnLSze+3gF8lOpBP5oCxYn2B+2Wso5pvbldzcYt5TYt4130ij
	hmHX33Mp1pz81WzoIlkjWSq3ABQ9cq5EFSz7uc3uNnYdk0cpzSqRr+eW
X-Gm-Gg: AYBFou0goQBWG9SNZsiilauIlC8guvsEuGOqeSL7tCn/q76R0KvnHhGCm8fjCaItyNU
	IIsz0Y4rg++EZ1qj9VPgh/Dex1FD/HhpNqFSEfg8+eBL/tMSIL/7rww6M3aKUs2xEQo5Jm4/h35
	lGRNN2O6cn+yXG0CD0HY0KP8U+U7ojaxe5TlnE1D2opoS6JdOOyDWwWApgfyEePep67gOWtMkEp
	LKZLUeAIsW82tiLNEYt9Dnw6icXweKOXdH6/+3Hlhd4z6jpSVg4xnwCuUX7MnJcACkDXH58UwcP
	ZpVzfJITgD53AyPi3B+JI2yOSyAPElDSqxPOBe8b2k+/sRqTknayDrKFedqidivBfXDXggSF7I0
	honW+10x2WTZYLXMjf2izYxuviZEflb3zWZOzLZ9z63oQqNGnjJ3Cukjx/3RsRjgBeSsgvEENzQ
	8rRI3JTkf5SfZ6AuwL2tV3ZObQYFrYgSEf15c9xtbG6wf3hUjnyRRIc6CjACNcLvnrUkzPciped
	t7v0ASztFdsD0bVAPbFHeOm6ZhLeSsXA78ojmPl1qbw37+Nd9MAmKae9oLPpHjV
X-Received: by 2002:a05:6000:186e:b0:487:1413:c644 with SMTP id ffacd0b85a97d-487152180efmr1035266f8f.30.1789602758928;
        Wed, 16 Sep 2026 16:52:38 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-79-26-252-140.retail.telecomitalia.it. [79.26.252.140])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-4870bef7687sm11861104f8f.1.2026.09.16.16.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Sep 2026 16:52:37 -0700 (PDT)
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
	Randy Dunlap <rdunlap@infradead.org>,
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
Subject: [PATCH net-next v16 09/12] net: phylink: add .pcs_link_down PCS OP
Date: Thu, 17 Sep 2026 01:51:35 +0200
Message-ID: <20260916235200.20712-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916235200.20712-1-ansuelsmth@gmail.com>
References: <20260916235200.20712-1-ansuelsmth@gmail.com>
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
index fb3fb522769b..4edad9b3c169 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -989,6 +989,12 @@ static void phylink_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
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
index f06eb8b6f94a..f03c1dc0a4a1 100644
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
2.55.0

