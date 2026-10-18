Received: from out-2uec-a123.jellyfish.systems (out-2uec-a123.jellyfish.systems [63.250.43.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14B80415B8B
	for <netdev@vger.kernel.org>; Sun, 18 Oct 2026 18:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=63.250.43.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792348919; cv=none; b=rkoOIbnZ5wwFSScfmb2M992VNq/A9Ur5StRdgcFa8F9rtTkzHovhNQdYAdMQELC3bjAXD2qgy8dw5uRRki3mzkXpg35Sj0WuMcno+ltG4CRiZRyoTV+IVuvfssG5/Cma0dpkZDkaT2xZ3xDKcMWf5om+ncsdaLlEbx/bRT08x3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792348919; c=relaxed/simple;
	bh=mMK4tLG8AXUJVkPzZBKZ2dl6GSCVDxsdDhKNGqxqbWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cnd1AbCshw9ar1iND7BkhUMcxIXhZ7XRqBkBa7X6R5opKsI9HGQbHF1mE78yLQBA25zEXjE/gr2VyZ+ss0nMJbFaVjjfCPyQXJ9w/K7dd2SZlzETgc+z66okRuaNPeGk5gkvtyjeaa1lefrJScVJvOVAcWiow5OEGdxKY0dEMYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=r-sc.ca; spf=pass smtp.mailfrom=r-sc.ca; dkim=pass (2048-bit key) header.d=r-sc.ca header.i=@r-sc.ca header.b=JljUaImh; arc=none smtp.client-ip=63.250.43.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=r-sc.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-sc.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=r-sc.ca header.i=@r-sc.ca header.b="JljUaImh"
Received: from DESKTOP-290OH2S (d207-6-150-133.bchsia.telus.net [207.6.150.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4j76S66yPtz2x99;
	Sun, 18 Oct 2026 18:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-sc.ca;
	s=spacemail; t=1792347656;
	bh=ucpIWshOnDVtoREAA0gEPeno03hiXuXiUZO0nTBdeFU=;
	h=From:To:Cc:Subject:Date:From;
	b=JljUaImhqyDCxQCb6KqlG1P4Pv74oVf2fiukLKZjwFm46kWCGgbff4MH00xkYiEct
	 xXTp3+Q9nQivnvN+weIF3vuTqufUFrBWitqd1qv7kGp8Sa/8jv+ZGRdwXY6do9n1Cc
	 P3F1t9lj9/hwLXs9NldjbT6u3YiEFWB1o1Tl9z2ecgBVfSfXCJrcnevLYrU98E6uhZ
	 BUAzVMuXsfP1gaPzMzJ3o3Z3ejSA1+wQ9OfoTzFQrZu/rMSBxbsmi6spzImzo1vlrz
	 CQiMTe0PjLPu+e5ZSLcgdVzPIKTObcahFNwKB6u24SxqeXo769H4V8Md5M3AELU4Sb
	 ZqU6iwU7oqWdA==
From: Ross Cawston <ross@r-sc.ca>
To: netdev@vger.kernel.org
Cc: o.rempel@pengutronix.de,
	kory.maincent@bootlin.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Ross Cawston <ross@r-sc.ca>
Subject: [PATCH net] net: pse-pd: don't enable a PI again while disabling it
Date: Sun, 18 Oct 2026 11:20:05 -0700
Message-ID: <20261018182005.1193-1-ross@r-sc.ca>
X-Mailer: git-send-email 2.55.0.windows.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Envelope-From: ross@r-sc.ca

With software power control, _pse_pi_disable() frees the power budget
of the PI and then retries the power delivery of the PIs waiting for
power in its power domain: those that are admin enabled, have a PD
detected, and are not enabled in hardware. The PI being disabled is one
of them, as its admin state and PD detection are only cleared after
_pse_pi_disable() returns, so it is enabled again right away:

- an admin disable of a port with a PD keeps the port powered, and the
  next admin enable allocates its budget a second time
- a disconnection enables the now empty port again, with a new budget
  allocation that is never freed: when the port reports the
  disconnection again, its PD detection is already cleared
- a PI disabled to free budget for a PI of higher priority is enabled
  again with the budget it just freed, so priorities never take effect

Clear the admin state and the PD detection before disabling the PI,
and don't retry the power domain in pse_disable_pi_pol(), whose freed
budget is meant for the PI being allocated. That PI stays waiting for
power and is retried when budget is freed later.

The problem was found, and this fix written, with an AI coding
assistant, while testing the budget on a switch with two Realtek RTL8239
PSE controllers, whose driver (not in mainline yet) uses the static
budget strategy like the TPS23881. Before this change, "ethtool
--set-pse <port> c33-pse-admin-control disable" left a port with a PD
powered, and the budget allocated in the power domain grew with every
disable and every unplug. With it, the port stays off, and the allocated
budget is back to 0 after a disable and after an unplug. Tested on that
switch with OpenWrt's 6.18 kernel; the change for mainline is the same
apart from context and is build-tested.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Signed-off-by: Ross Cawston <ross@r-sc.ca>
---
 drivers/net/pse-pd/pse_core.c | 50 ++++++++++++++++++++++++++++-------
 1 file changed, 41 insertions(+), 9 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index a5e6d7b26b9..b46e3a13a31 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -448,14 +448,14 @@ static void pse_pi_deallocate_pw_budget(struct pse_pi *pi)
 }
 
 /**
- * _pse_pi_disable - Call disable operation. Assumes the PSE lock has been
- *		     acquired.
+ * __pse_pi_disable - Call disable operation and free the power budget of the
+ *		      PI. Assumes the PSE lock has been acquired.
  * @pcdev: a pointer to the PSE
  * @id: index of the PSE control
  *
  * Return: 0 on success and failure value on error
  */
-static int _pse_pi_disable(struct pse_controller_dev *pcdev, int id)
+static int __pse_pi_disable(struct pse_controller_dev *pcdev, int id)
 {
 	const struct pse_controller_ops *ops = pcdev->ops;
 	int ret;
@@ -469,6 +469,29 @@ static int _pse_pi_disable(struct pse_controller_dev *pcdev, int id)
 
 	pse_pi_deallocate_pw_budget(&pcdev->pi[id]);
 
+	return 0;
+}
+
+/**
+ * _pse_pi_disable - Disable a PI, then retry the power delivery of the PIs
+ *		     waiting for power in its power domain. Assumes the PSE
+ *		     lock has been acquired.
+ * @pcdev: a pointer to the PSE
+ * @id: index of the PSE control
+ *
+ * The caller must have cleared the admin state or the PD detection of the
+ * PI first, or the retry enables the PI again.
+ *
+ * Return: 0 on success and failure value on error
+ */
+static int _pse_pi_disable(struct pse_controller_dev *pcdev, int id)
+{
+	int ret;
+
+	ret = __pse_pi_disable(pcdev, id);
+	if (ret)
+		return ret;
+
 	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d))
 		pse_pw_d_retry_power_delivery(pcdev, pcdev->pi[id].pw_d);
 
@@ -490,7 +513,10 @@ static int pse_disable_pi_pol(struct pse_controller_dev *pcdev, int id)
 
 	dev_dbg(pcdev->dev, "Disabling PI %d to free power budget\n", id);
 
-	ret = _pse_pi_disable(pcdev, id);
+	/* The power freed is for the PI being allocated, and this PI waits
+	 * for power again: no retry of the power domain here.
+	 */
+	ret = __pse_pi_disable(pcdev, id);
 	if (ret)
 		notifs |= ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR;
 
@@ -703,14 +729,18 @@ static int pse_pi_disable(struct regulator_dev *rdev)
 {
 	struct pse_controller_dev *pcdev = rdev_get_drvdata(rdev);
 	struct pse_pi *pi;
+	bool enabled;
 	int id, ret;
 
 	id = rdev_get_id(rdev);
 	pi = &pcdev->pi[id];
 	mutex_lock(&pcdev->lock);
+	/* Disabled before _pse_pi_disable() retries the power domain */
+	enabled = pi->admin_state_enabled;
+	pi->admin_state_enabled = 0;
 	ret = _pse_pi_disable(pcdev, id);
-	if (!ret)
-		pi->admin_state_enabled = 0;
+	if (ret)
+		pi->admin_state_enabled = enabled;
 
 	mutex_unlock(&pcdev->lock);
 	return 0;
@@ -1229,10 +1259,12 @@ static int pse_set_config_isr(struct pse_controller_dev *pcdev, int id,
 				ret = 0;
 		}
 	} else if (notifs & ETHTOOL_C33_PSE_EVENT_DISCONNECTION) {
-		if (pcdev->pi[id].admin_state_enabled &&
-		    pcdev->pi[id].isr_pd_detected)
-			ret = _pse_pi_disable(pcdev, id);
+		bool pd_detected = pcdev->pi[id].isr_pd_detected;
+
+		/* Gone before _pse_pi_disable() retries the power domain */
 		pcdev->pi[id].isr_pd_detected = false;
+		if (pcdev->pi[id].admin_state_enabled && pd_detected)
+			ret = _pse_pi_disable(pcdev, id);
 	}
 
 	return ret;
-- 
2.55.0.windows.5

