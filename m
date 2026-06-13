Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F3C3033D6
	for <netdev@vger.kernel.org>; Sat, 13 Jun 2026 20:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781381449; cv=none; b=FQ9RXPg7IGUByq43MWPMAe3AXHnUb+ODHNWhUnIe6P60HtX9WVgct06NQSPUPcrTCphTRa8gtk1h4YVjKJyWGdZelOJLeD1XVjBNxU8FdgQK6YAaYoMgPgLGEzNDlncgY/f+EZl0zKtyd0tQGOxxxzcyWb52T46cRyseSRJsL2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781381449; c=relaxed/simple;
	bh=hIwZ98wdyz5Z3WynC8kedtzD3QGzK176gvhUplBf3c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cp2hWVAwOzg27u3/gEFCqYg8560HQOuAYPsHYla2D3wXkyAKdWdfkZcpNNpRqnM7cpSRGwmooA8WwfW6x4w9ezD+UUwqr3Qan+q9shcNRQ5NMUFM0Mc/i5+adr0J+BwmOzxJYJGPhXSIDOLsY+wdx1BYW+JGakihjVDmuITihPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JcJfzkHk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JcJfzkHk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46A431F00A3D;
	Sat, 13 Jun 2026 20:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781381447;
	bh=KjUaeoCK4UcdkXyIGEv6ZVHLHgMJ8W+Juf6AeoDotNQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JcJfzkHkDAjlzJE5/hex2mqQtRLLNXgxWN268TVYQ0JDRoPusmMV6QaLxKRGtVFFC
	 bxS0VmAlE7nheVBEr4B9H+VUu2P3PmzJqCOTjLQ9Nn8XpE84WJeL3+LCfqVnpmzPLC
	 7RuxLRPSs7o7ttjStuZ7N5rdXljdI/XnwSxd460469+pAHUjaEJ2XeA014Nqvl9wot
	 pLfxlX0RbTnJQMmmY9Adxp9SaEYxuWSmZ6f3FsSbC6APmDkuPIFMXOIGaGrtvVKntM
	 Z8YFlzFzeJLdAtPNlhvHLZZ0EDqH8+bJDqUHaY8HowUYR3veeynMnWV0bed2Sfd33G
	 YWhPRZK5njjTQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	3chas3@gmail.com,
	mitch@sfgoth.com,
	linux-atm-general@lists.sourceforge.net,
	dwmw2@infradead.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 8/9] atm: remove unused ATM PHY operations
Date: Sat, 13 Jun 2026 13:10:31 -0700
Message-ID: <20260613201032.77274-9-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613201032.77274-1-kuba@kernel.org>
References: <20260613201032.77274-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PHY operations are vestiges of the SAR/framer split used by the
removed PCI/SBUS ATM adapters:

 - atmdev_ops::phy_put / ::phy_get (register accessors) are never called
   by the core and solos-pci only listed them as NULL
 - struct atmphy_ops and atm_dev::phy have no users at all - nothing
   assigns or dereferences them

Remove all of them. atm_dev::phy_data is kept: solos-pci repurposes it
to stash its per-port channel index.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/atmdev.h  | 12 ------------
 drivers/atm/solos-pci.c |  2 --
 2 files changed, 14 deletions(-)

diff --git a/include/linux/atmdev.h b/include/linux/atmdev.h
index 96ce36e02247..fe21d2f547b5 100644
--- a/include/linux/atmdev.h
+++ b/include/linux/atmdev.h
@@ -107,8 +107,6 @@ static inline struct sock *sk_atm(struct atm_vcc *vcc)
 
 struct atm_dev {
 	const struct atmdev_ops *ops;	/* device operations; NULL if unused */
-	const struct atmphy_ops *phy;	/* PHY operations, may be undefined */
-					/* (NULL) */
 	const char	*type;		/* device type name */
 	int		number;		/* device index */
 	void		*dev_data;	/* per-device data */
@@ -138,20 +136,10 @@ struct atmdev_ops { /* only send is required */
 			    void __user *arg);
 #endif
 	int (*send)(struct atm_vcc *vcc,struct sk_buff *skb);
-	void (*phy_put)(struct atm_dev *dev,unsigned char value,
-	    unsigned long addr);
-	unsigned char (*phy_get)(struct atm_dev *dev,unsigned long addr);
 	int (*proc_read)(struct atm_dev *dev,loff_t *pos,char *page);
 	struct module *owner;
 };
 
-struct atmphy_ops {
-	int (*start)(struct atm_dev *dev);
-	int (*ioctl)(struct atm_dev *dev,unsigned int cmd,void __user *arg);
-	void (*interrupt)(struct atm_dev *dev);
-	int (*stop)(struct atm_dev *dev);
-};
-
 struct atm_skb_data {
 	struct atm_vcc	*vcc;		/* ATM VCC */
 	unsigned long	atm_options;	/* ATM layer options */
diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
index 9c246b956c30..fc0e91a1029e 100644
--- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -1180,8 +1180,6 @@ static const struct atmdev_ops fpga_ops = {
 	.close =	pclose,
 	.ioctl =	NULL,
 	.send =		psend,
-	.phy_put =	NULL,
-	.phy_get =	NULL,
 	.proc_read =	NULL,
 	.owner =	THIS_MODULE
 };
-- 
2.54.0

