Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794415246;
	b=np9ANwrQgteLcVT1HAasm29+Zb6XHpUcCmf3R/kolceLw/o4PNzO7osT7zraKf4iDk9z
	 WpgNyjrhespqlldmCbbsAFHTZ+UIWurL0PZVZ5tRzurK47VyROj58W6GWxmO7SMvtXhcU
	 Dp/8ex9PI4yUOJry6QwQrk1OWqsZkU5ewkfT+1Aq4ImOpYS+gC1tefAD5jImFCBOcE0qg
	 oOj8P+9r2cvpIYjD9NAzVBlpihPBxa+N2Lj8GzcbRADeL9kytBAxi262lrZvzrFcv9z17
	 cBprrT18qH8VvyZP7kVW9S29aXKOAGR9uzWPK6nxEDJCSRKk8qtoZYyEe0Gbv1UnJeg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794415246;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=4UXdJhb2DeSA3nX65h3c9Ro7JbdiHIOP89nBTrO6qaY=;
	b=p62bYs7NFYf1LKGbq5FXkWjt5sMauUYMU/R85aq80mSHWcAW1NsXaePWFpZ/puLmglmd
	 us5DMb3MeP3Iy3NWxY98171NNZytABSA9et6F3mPyOwKfxxX5G9WsJtjupxQLU5GFtFse
	 MqoVqXsDGTOZQcqJV5PiK3bkmj2UQmOfk2rCrtrH4z4reLCLkpfLRYFJC1w6oRFQGg11s
	 pnBokVW+Z+UaixxTBR6H63KNxEhYwgX0GppJcmV/9TLQ36Wn15ZzfwrnVUQbU3+lmTg57
	 i2X+dPDUUBWSUkwI2JTJRM7MJbzLG+E6vyF/wGF3GPy35y5fAwTu4Lvx7hOEBzlnnyA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b="Q/WfYdTS";
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FC0606A32D
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 16:40:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B1FC0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Q/WfYdTS
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1794415244;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4UXdJhb2DeSA3nX65h3c9Ro7JbdiHIOP89nBTrO6qaY=;
	b=Q/WfYdTS4bdVLnmjBMGy1O9Lfxw9eni8J+OxeqnuVT1I5MIa8yiLZcN6x7QsstCNRcViJG
	UtEqhDh6NrblEs/JFndoEhmYRcMvx4StVaZoKXf+aN8il7BGDe6buWJ+Ik8ek3NmTkzSr/
	SJugt4vwEYnoogDlebdp2dxBbA8RTZU=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-202-8oyxtDaRMGC08USG0k2hVg-1; Wed,
 11 Nov 2026 11:40:38 -0500
X-MC-Unique: 8oyxtDaRMGC08USG0k2hVg-1
X-Mimecast-MFC-AGG-ID: 8oyxtDaRMGC08USG0k2hVg_1794415235
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 0ABF4180061D;
	Wed, 11 Nov 2026 16:40:35 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 15DB3410;
	Wed, 11 Nov 2026 16:40:28 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Min Li <min.li@microchip.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Karol Kolacinski <karol.kolacinski@intel.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Petr Oros <poros@redhat.com>
Subject: [PATCH net-next v2 1/9] ice: dpll: notify TSPLL lock status from the periodic work only
Date: Wed, 11 Nov 2026 17:40:12 +0100
Message-ID: <20261111164021.273409-2-ivecera@redhat.com>
In-Reply-To: <20261111164021.273409-1-ivecera@redhat.com>
References: <20261111164021.273409-1-ivecera@redhat.com>
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
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

ice_dpll_tspll_state_on_dpll_set() notifies the TSPLL device from a
callback of the TIME_REF pin. This pin belongs to an external DPLL and the
DPLL core is going to run its callbacks under a lock of the pin's owner,
which does not cover the TSPLL device.

Only update dpll_state in the callback, so a device get reports the new
state right away, and leave prev_dpll_state to
ice_dpll_periodic_work_e825(), which then sends the notification. It now
arrives up to 500 ms later and after the reply to the request.

Refresh dpll_state on every run of the work, as the state written by the
callback can be transient and the lock status can return to
prev_dpll_state before the next run. No notification is sent in this case.

Reviewed-by: Petr Oros <poros@redhat.com>
Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
Changes in v2:
- Merged the two comments in ice_dpll_tspll_state_on_dpll_set() (Sashiko)
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index ade1fb3dd06743..0877827a6521cc 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -2914,7 +2914,6 @@ ice_dpll_tspll_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
 	struct ice_dpll_pin *p = pin_priv;
 	struct ice_pf *pf = p->pf;
 	enum ice_clk_src clk_src;
-	bool changed = false;
 	struct ice_dpll *tp;
 	int ret;
 
@@ -2939,23 +2938,16 @@ ice_dpll_tspll_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
 
 		new_state = ice_dpll_tspll_lock_status_get(pf, false);
 
-		/* Sync the cached lock state to what we just observed from HW
-		 * so ice_dpll_periodic_work_e825() (cached path) does not emit
-		 * a spurious UNLOCKED notification between now and the next
-		 * PTP monitor tick.
+		/* Sync the cached lock state to what we just observed from HW.
+		 * ice_dpll_periodic_work_e825() reads it (cached path),
+		 * compares it with prev_dpll_state and sends the notification.
+		 * dpll_state lets a device get report it right away.
 		 */
 		WRITE_ONCE(pf->ptp.tspll_locked,
 			   new_state == DPLL_LOCK_STATUS_LOCKED);
-
-		if (tp->prev_dpll_state != new_state) {
-			tp->dpll_state = new_state;
-			tp->prev_dpll_state = new_state;
-			changed = true;
-		}
+		tp->dpll_state = new_state;
 	}
 	mutex_unlock(&pf->dplls.lock);
-	if (changed)
-		__dpll_device_change_ntf(tp->dpll);
 	/* TSPLL reconfiguration may complete before lock is reacquired.
 	 * PTP periodic monitoring tracks and restores the final lock state.
 	 */
@@ -3372,8 +3364,8 @@ static void ice_dpll_periodic_work_e825(struct ice_pf *pf)
 	mutex_lock(&pf->dplls.lock);
 	new_state = ice_dpll_tspll_lock_status_get(pf, true);
 
+	tp->dpll_state = new_state;
 	if (tp->prev_dpll_state != new_state) {
-		tp->dpll_state = new_state;
 		tp->prev_dpll_state = new_state;
 		changed = true;
 	}
-- 
2.56.0

