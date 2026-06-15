Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDD03B27DA
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 19:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781552664; cv=none; b=ZmB2+FnJnGiwuNadckae1TpuVq+18MyCef3mekdZu1Z1JW9lc4OgV4lDazVffn1uh0jKiAiUJ2hHBPlhr91CiSXqF9TmSftJvELJCiDEN8GqAEgfzcotWSPP5yAtv1Sbhb6rWFZcrbFZZkFM5aWKH2zExLUcklVEJ8+tRDBEkhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781552664; c=relaxed/simple;
	bh=lsnQbP08v2He5GZptCkD5vProN6YUlhl+6oEVt4jRWk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W0ooOkJy9uw2D6NWP2jH3SnU47q7Pc4mDSfg/N26NO6d0uIRjOg2O+M5AeXjRgB0Ic9njdtjkcQuZRAsqRp3sIAwwEhlM8IXR3zKZAEQNZ7o+8cAuFBgKym5rMcRwNtx6+JXlQLAaaYs8u6an/B9r0s0lDzdkH6qgqYizRyd8Lg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q1jvn9JA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q1jvn9JA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D03661F00A3D;
	Mon, 15 Jun 2026 19:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781552663;
	bh=6HgOp3TeKVWJZWSzUpcYmBXo3cvKi00BBAOH8MRDuxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Q1jvn9JAm1mrhga56DCOFfaeDxQcqDSHHorjZ4lKxrSu78x2gBG71V4w1OnYWeYno
	 DnnSfrvY6bKwu5m7Xcc/jJ3OuJNunkj74rTHsRRGWDwIBb0TXMpfm4ICJLjNNgpXlz
	 CVvuQI2QmJGjiJqZ9hsxMeOrNXpYWXUvOkjKAshCUFtl/URaQO0tMbunI6l34b786W
	 V6HCuNmS0Z4Bjs0b4xkBC4rdYfboBWY5TouWIGs8dKz9HqD1kBWVu1EsPZrSUiGwYZ
	 G69wTTIz3dFc5h24nBLmhrTB/JmrajQ27am3FtjrHn97MAQOEjjFOoanjopLgyXwRb
	 nyJz7QYTJhDpQ==
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
Subject: [PATCH net-next v2 6/9] atm: remove the unused change_qos device operation
Date: Mon, 15 Jun 2026 12:44:13 -0700
Message-ID: <20260615194416.752559-7-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260615194416.752559-1-kuba@kernel.org>
References: <20260615194416.752559-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

atmdev_ops::change_qos() was the hook for renegotiating the traffic
parameters of an already-connected VCC, driven from SO_ATMQOS on a
connected socket (and previously from the SVC as_modify path, now gone).
None of the ATM drivers left in tree implement it - solos-pci only listed
change_qos = NULL - so atm_change_qos() always returned -EOPNOTSUPP.

Drop the operation and return -EOPNOTSUPP directly.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 include/linux/atmdev.h  |  1 -
 drivers/atm/solos-pci.c |  1 -
 net/atm/common.c        | 25 ++-----------------------
 3 files changed, 2 insertions(+), 25 deletions(-)

diff --git a/include/linux/atmdev.h b/include/linux/atmdev.h
index 59477676063c..218c05f2ec54 100644
--- a/include/linux/atmdev.h
+++ b/include/linux/atmdev.h
@@ -143,7 +143,6 @@ struct atmdev_ops { /* only send is required */
 	void (*phy_put)(struct atm_dev *dev,unsigned char value,
 	    unsigned long addr);
 	unsigned char (*phy_get)(struct atm_dev *dev,unsigned long addr);
-	int (*change_qos)(struct atm_vcc *vcc,struct atm_qos *qos,int flags);
 	int (*proc_read)(struct atm_dev *dev,loff_t *pos,char *page);
 	struct module *owner;
 };
diff --git a/drivers/atm/solos-pci.c b/drivers/atm/solos-pci.c
index 4ad170a858ee..9c246b956c30 100644
--- a/drivers/atm/solos-pci.c
+++ b/drivers/atm/solos-pci.c
@@ -1182,7 +1182,6 @@ static const struct atmdev_ops fpga_ops = {
 	.send =		psend,
 	.phy_put =	NULL,
 	.phy_get =	NULL,
-	.change_qos =	NULL,
 	.proc_read =	NULL,
 	.owner =	THIS_MODULE
 };
diff --git a/net/atm/common.c b/net/atm/common.c
index 650814d0a56c..44a0179d4586 100644
--- a/net/atm/common.c
+++ b/net/atm/common.c
@@ -673,28 +673,6 @@ __poll_t vcc_poll(struct file *file, struct socket *sock, poll_table *wait)
 	return mask;
 }
 
-static int atm_change_qos(struct atm_vcc *vcc, struct atm_qos *qos)
-{
-	int error;
-
-	/*
-	 * Don't let the QoS change the already connected AAL type nor the
-	 * traffic class.
-	 */
-	if (qos->aal != vcc->qos.aal ||
-	    qos->rxtp.traffic_class != vcc->qos.rxtp.traffic_class ||
-	    qos->txtp.traffic_class != vcc->qos.txtp.traffic_class)
-		return -EINVAL;
-	error = adjust_tp(&qos->txtp, qos->aal);
-	if (!error)
-		error = adjust_tp(&qos->rxtp, qos->aal);
-	if (error)
-		return error;
-	if (!vcc->dev->ops->change_qos)
-		return -EOPNOTSUPP;
-	return vcc->dev->ops->change_qos(vcc, qos, ATM_MF_SET);
-}
-
 static int check_tp(const struct atm_trafprm *tp)
 {
 	/* @@@ Should be merged with adjust_tp */
@@ -753,8 +731,9 @@ int vcc_setsockopt(struct socket *sock, int level, int optname,
 		error = check_qos(&qos);
 		if (error)
 			return error;
+		/* QoS cannot be renegotiated on an already connected VCC. */
 		if (sock->state == SS_CONNECTED)
-			return atm_change_qos(vcc, &qos);
+			return -EOPNOTSUPP;
 		if (sock->state != SS_UNCONNECTED)
 			return -EBADFD;
 		vcc->qos = qos;
-- 
2.54.0

