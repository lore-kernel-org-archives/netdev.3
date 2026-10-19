Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=198.54.127.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792447819;
	b=4CukWHt261hRvUkeIjYPz5WsqhdI8dpi9a9rBUd/kIQHzAPVeqmFxN3Z9z/igRA81yc6
	 /7aM2cCA3hUzh7HmLXWk78pC+vG4yTA8OeLnUd0ufciGebbkdUNXHZJjaAKaAdBt6/1Fz
	 S7M0lkClD0nOVIxrDgfUFesv2R93t4RzS4lezS8SnF8Qf+WDkzsBPrmBpVqnawuyRfCLV
	 GhAWYhEwyA4UUuo4iu7B2+gSkjE2w5ozPcc0vi1clotdzv4WJWoAmiZLz2eCTMKaI+5Ef
	 MXusS5CNxg2dUpAVqBGRfnLOy3IhJPagVywofTTQJ8WCtrnLjMsbsw6eBSQs62HaYAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792447819;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-Envelope-From;
	bh=A9M+eQGTgrKJjVISHFIRHuM3Rvm+gb3HgdVuKPjSkV0=;
	b=5Vk1mX2AYytAkse+11HPQ9ImyDEsgsW6LXzcxVjoOrLEb242wEdTm1K842PngVtqtN0s
	 sm0rHaFVtoGLwdJKunvt4Dni1J4XotIfsJRY/lrhGnemM2W0C9h6dg7vYvuUTQAqb6Yle
	 MYHgCazjtCQJ2PlddT5lPpj0th0U40SvBwb1gYDO1p3Rcj68AeDTKD0nvTo2623dULocr
	 mOVQjSOwT9slot61Ek72wCNn4NcKPS3hsLK87RpD4U9IGwD8PeOiQxa76M7hY96Vydu7a
	 SPVwSlTLY+t1efhSo7YKUx3QGuSoVccOKpOizy7SIIKdMwuGk/Bjb3G4LIfSz09k8mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=r-sc.ca;
	spf=pass smtp.mailfrom=r-sc.ca;
	dkim=pass header.d=r-sc.ca header.i=@r-sc.ca header.a=rsa-sha256 header.s=spacemail header.b=PZdai8wY;
	arc=none smtp.remote-ip=198.54.127.157
Received: from out-2z4y-a157.jellyfish.systems (out-2z4y-a157.jellyfish.systems [198.54.127.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6F1F606A31D
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 22:10:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6F1F606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=r-sc.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=r-sc.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=r-sc.ca header.i=@r-sc.ca header.a=rsa-sha256 header.s=spacemail header.b=PZdai8wY
Received: from DESKTOP-290OH2S (d207-6-150-133.bchsia.telus.net [207.6.150.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.spacemail.com (Postfix) with ESMTPSA id 4j7qV854FLz6tkL;
	Mon, 19 Oct 2026 22:10:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=r-sc.ca;
	s=spacemail; t=1792447809;
	bh=A9M+eQGTgrKJjVISHFIRHuM3Rvm+gb3HgdVuKPjSkV0=;
	h=From:To:Cc:Subject:Date:From;
	b=PZdai8wYQayJZfOy5O+qN3ZhLQejDrw8jwduUTMX+f5P1pD0FIuj8ny1NC1YqVX8l
	 9KlchquCstkf6woO0H0stvGHQQ6DYQNSEEemH+k5jL7XcN3QAE9kvzC34nzjYAoSbu
	 KX4HBHkCHudILQoC1WNNAgebFNp71twgBm0HkHQ1WvUQ3HihbyzM8VdIs2URBVghjd
	 ny4+c5PKDR/Yuf8nP6phY22X5M2fTfOtpBbBTB0YuSxwWriyn+JoG5r7wQ0rYcyeeH
	 +Tyy98Qm6GmXJhhZU+SND8etd08NhFTR+3mlp28zSGprcBrYDjBMq+gvvgIhOsuU92
	 COIDyZ+JgFLAQ==
From: Ross Cawston <ross@r-sc.ca>
To: netdev@vger.kernel.org
Cc: kory.maincent@bootlin.com,
	github@szelinsky.de,
	o.rempel@pengutronix.de,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	Ross Cawston <ross@r-sc.ca>
Subject: [PATCH net v2] net: pse-pd: don't enable a PI again while disabling it
Date: Mon, 19 Oct 2026 15:08:34 -0700
Message-ID: <20261019220835.613-1-ross@r-sc.ca>
X-Mailer: git-send-email 2.55.0.windows.5
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
X-Envelope-From: ross@r-sc.ca

With software power control, _pse_pi_disable() frees the power budget
of the PI and then retries the power delivery of the PIs waiting for
power in its power domain: those that are admin enabled, have a PD
detected, and are not enabled in hardware. On an admin disable or a
disconnection, the PI being disabled is one of them, as its admin state
or PD detection is only cleared after _pse_pi_disable() returns, so it
is enabled again right away:

- an admin disable of a port with a PD keeps the port powered, and the
  next admin enable allocates its budget a second time
- a disconnection enables the now empty port again, with a new budget
  allocation that is never freed: when the port reports the
  disconnection again, its PD detection is already cleared

Move the retry out of _pse_pi_disable() into its callers:
pse_pi_disable() and the disconnection handling of pse_set_config_isr()
retry after they clear the admin state or the PD detection, and
pse_disable_pi_pol() retries as before.

The problem was found while testing the budget on a switch with two
Realtek RTL8239 PSE controllers, whose driver (not in mainline yet) uses
the static budget strategy like the TPS23881. Before this change,
"ethtool --set-pse <port> c33-pse-admin-control disable" left a port
with a PD powered, and the budget allocated in the power domain grew
with every disable and every unplug. With it, the port stays off, and
the allocated budget is back to 0 after a disable and after an unplug.
Tested on that switch with OpenWrt's 6.18 kernel; the change for
mainline is the same apart from context and is build-tested.

Fixes: ffef61d6d273 ("net: pse-pd: Add support for budget evaluation strategies")
Signed-off-by: Ross Cawston <ross@r-sc.ca>
---
Changes in v2:
- Move the retry of the power domain out of _pse_pi_disable() into its
  callers, instead of splitting out a __pse_pi_disable() without it
  (Kory)
- Keep the retry after pse_disable_pi_pol(): without it, PIs turned off
  for a PI of higher priority stay off even when their budget wasn't
  needed (Sashiko). That the retry powers such a PI again right away is
  left for a separate patch.

v1: https://lore.kernel.org/netdev/20261018182005.1193-1-ross@r-sc.ca/

 drivers/net/pse-pd/pse_core.c | 22 +++++++++++++++-------
 1 file changed, 15 insertions(+), 7 deletions(-)

diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.c
index a5e6d7b26b9..c71acfd5337 100644
--- a/drivers/net/pse-pd/pse_core.c
+++ b/drivers/net/pse-pd/pse_core.c
@@ -469,9 +469,6 @@ static int _pse_pi_disable(struct pse_controller_dev *pcdev, int id)
 
 	pse_pi_deallocate_pw_budget(&pcdev->pi[id]);
 
-	if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d))
-		pse_pw_d_retry_power_delivery(pcdev, pcdev->pi[id].pw_d);
-
 	return 0;
 }
 
@@ -493,6 +490,8 @@ static int pse_disable_pi_pol(struct pse_controller_dev *pcdev, int id)
 	ret = _pse_pi_disable(pcdev, id);
 	if (ret)
 		notifs |= ETHTOOL_PSE_EVENT_SW_PW_CONTROL_ERROR;
+	else if (pse_pw_d_is_sw_pw_control(pcdev, pcdev->pi[id].pw_d))
+		pse_pw_d_retry_power_delivery(pcdev, pcdev->pi[id].pw_d);
 
 	ntf.notifs = notifs;
 	ntf.id = id;
@@ -709,8 +708,11 @@ static int pse_pi_disable(struct regulator_dev *rdev)
 	pi = &pcdev->pi[id];
 	mutex_lock(&pcdev->lock);
 	ret = _pse_pi_disable(pcdev, id);
-	if (!ret)
+	if (!ret) {
 		pi->admin_state_enabled = 0;
+		if (pse_pw_d_is_sw_pw_control(pcdev, pi->pw_d))
+			pse_pw_d_retry_power_delivery(pcdev, pi->pw_d);
+	}
 
 	mutex_unlock(&pcdev->lock);
 	return 0;
@@ -1229,10 +1231,16 @@ static int pse_set_config_isr(struct pse_controller_dev *pcdev, int id,
 				ret = 0;
 		}
 	} else if (notifs & ETHTOOL_C33_PSE_EVENT_DISCONNECTION) {
-		if (pcdev->pi[id].admin_state_enabled &&
-		    pcdev->pi[id].isr_pd_detected)
+		struct pse_pi *pi = &pcdev->pi[id];
+		bool disable = pi->admin_state_enabled && pi->isr_pd_detected;
+
+		/* Cleared first, so that the retry doesn't enable it again */
+		pi->isr_pd_detected = false;
+		if (disable) {
 			ret = _pse_pi_disable(pcdev, id);
-		pcdev->pi[id].isr_pd_detected = false;
+			if (!ret)
+				pse_pw_d_retry_power_delivery(pcdev, pi->pw_d);
+		}
 	}
 
 	return ret;
-- 
2.55.0.windows.5

