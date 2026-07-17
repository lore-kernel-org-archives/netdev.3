Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9297C3CF694
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 06:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784271331; cv=none; b=EuPa08rkcgei17q581SUCK3+r7b43SMtWjDK8xcd2E6jEUJEYwfqxNXvK9COIaPx2mGwxLGenQKQAgvwdtQDjqERQ0wbJnoVjZk2aiIDN/O8/VWLNnlKQLNIBxeZ6qN9nmE9P/rXlX865rVmessCLYBPVD05MicdrVefCOZn1AI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784271331; c=relaxed/simple;
	bh=2r+f9uPZ1R4h4a0Uh06IGRRG0WQkscQ8w3n3d26beRo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=INkc0nGCRArWz9WKIHVT36xU1sBWglpV5jlfnduwwMaOM2pQLJjUeOULyL/6iaCuyLhoHqV4MoqoN32+KRPUzz6d4HnA/ipBYXy2EBC21TkVbwLipygQmEk0OM+tGPCY8rFaIc5uG/9F8SJ2GBmBRqZyrlzCJ9kcvqmZTPeQ56E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pzsszMCX; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pzsszMCX"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4954a32cf1eso913535e9.3
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 23:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784271325; x=1784876125; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=USxuj5cdXcSxjhj0RWDyCY2SPnAhuicY80xMgRrTLdI=;
        b=pzsszMCXQwQ6w+pscj95dpEQUhE5WyzSVzqsxzDjLFdg5wYvKLnUNrHHlBtUqi5XlA
         Zgq2ao2rYQw4Wqy94XZ9y6jhMy8WXeBPd4Q4WNHi3JKKWmvSPFzx5eYsxLuaxULmEYKo
         WcAJLdQz/HE0VrLuiYwtnuCejzwF1Vv3sM9xuV6gIZLlndaFPXhG+/J+PO/17J8ojRQF
         09dsjDIf7YDKl+TsJ3oB+3hIeZsWiGcAcDkybO2UvJEF3cSnbSHWx3TDzU0J9a52Btze
         mN7GkT3A4KRtSHEN6NubQOeHjnK5uth/2qlGYUHZMtgL2xc3BsmkE+V1PbvGM2AqDBT7
         GpmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784271325; x=1784876125;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=USxuj5cdXcSxjhj0RWDyCY2SPnAhuicY80xMgRrTLdI=;
        b=BgMMGvOkQf+VMKA/5U8AeAMG7JR39rs6sMzXwMnsuPmwWSH4cFL/NgRySjZuIixVVv
         0ethqb2VFuwKUBhdmSB68xqOjGPjpCQQVQfq3I1eT+F6Z1TmyBfXuzTwS88fqwb1szUC
         UptEm187oNG8BPXCmFeAtFkA7f7ukBdSVzhd0DU1lL0GyPOtc2DzQIyxa7nvYRQ/hrmf
         KV84nRY9+IeYuVoo7Cim9qM89itFzAPp/M/g4p/ZFxpygmAI+zbbpymPfm69SsnoncH6
         qkztz+MnwUv0TMnMbNacXO5wZ66YXWtVn7JSNS0fUQrz3mzJz7bU2M5a7bfklu5GYfwj
         YJNA==
X-Forwarded-Encrypted: i=1; AHgh+RrcNeJZqg7ROn1Ys8QOfoH3g48YZFWgoUv/tWCn/VGkm1mIwTPm09oZBKPw8Na+LuqZf4p6R6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYqBITrQSYlZnyeeSdS7JFnMMTduTDKMfCIa2lL65JjjDg0A6h
	YOiX3N8YKNSJAt7Z36I69qGUbxlzJKCzJl22UQHP/71GIFoWp9gJJZNR
X-Gm-Gg: AfdE7cnWELOInOQJ8dh0BpMDZcD+pyUPh/lxkdrn5XbnxElsH/2Qd4Iz9CCNcvLqfrX
	sFToTJ/wBwjNLT9d28HuM5YcsahwGQwmj17NjKgvvpWX07bynDqrrgpKhEaO8JpQZCvdubv3uFm
	yk/OeuRUQ4U95lTo+Q8rbMTD3gDQNDTii35ZYUeBg6JU06E9rKace1wqYeFfJf/ISOl3VIA3/bY
	BAdUKkFwoYtPHh82xegV7xqlqUYeT+26d75t6c1DFqy42O4lJbc3vOj3iTkICu86/9JwvuPfOPd
	JCvXzK8FcKQhtbFAezhXpp+Hlqcoh4cYUVOac9PXydSHKhDgung321cmqXFDj7NGN2T5OnADBrX
	ZroJ9AgK51s5BwNNP0vuM887Cr+Ki2GXrnmaf2yvZAfy9hXHeofVGPZc3GO6e31Fzo2qTpWyl02
	drZCIDRRxx6xu3IN6L/kcaJvGGFcNEfHWNXE8JOaMfh3IPKnbz1MqZ1xIEJDwxHQLCDgxayo8KP
	hWXb8gp
X-Received: by 2002:a05:600c:3b05:b0:493:bb23:152a with SMTP id 5b1f17b1804b1-4954a508804mr12738645e9.34.1784271325219;
        Thu, 16 Jul 2026 23:55:25 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain (host-95-248-227-210.retail.telecomitalia.it. [95.248.227.210])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-495499f3f99sm24260835e9.0.2026.07.16.23.55.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 23:55:24 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
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
	Saravana Kannan <saravanak@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	Maxime Chevallier <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v9 09/12] net: phylink: add .pcs_link_down PCS OP
Date: Fri, 17 Jul 2026 08:54:09 +0200
Message-ID: <20260717065448.1498335-10-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260717065448.1498335-1-ansuelsmth@gmail.com>
References: <20260717065448.1498335-1-ansuelsmth@gmail.com>
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
---
 drivers/net/phy/phylink.c |  9 +++++++++
 include/linux/phylink.h   | 12 ++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 1d83b31874fb..e36a6647d7e8 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -1037,6 +1037,12 @@ static void phylink_pcs_link_up(struct phylink_pcs *pcs, unsigned int neg_mode,
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
@@ -1738,6 +1744,9 @@ static void phylink_link_down(struct phylink *pl)
 
 	pl->mac_ops->mac_link_down(pl->config, pl->act_link_an_mode,
 				   pl->cur_interface);
+
+	phylink_pcs_link_down(pl->pcs);
+
 	phylink_info(pl, "Link is Down\n");
 }
 
diff --git a/include/linux/phylink.h b/include/linux/phylink.h
index 15e6b1a39dfe..ecf4c384fd31 100644
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
+ * pcs_link_up() - tear down link between MAC and PCS
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

