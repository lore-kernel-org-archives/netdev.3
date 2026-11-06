Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793967026;
	b=PFMcztbRKrPw9fwwQapScV8j9o5aSmohkuOAvpYlwhR9zL9KaeUoWZ60ZKq+St9tVrH1
	 jEhnzYhUy8hmd4xlWj7uD6X3vPXiwNIiPhqzSHul9CKof8ipX9NQuj6aAMdXPlcX7Fb+y
	 Vnidi5YByShBNKfIy6+83nhS5/OE+Th7OOjCFuLb0ieJp97xPpOwOdmTlLZiPO53+SAL1
	 1Ub7UPMeNC8LfrLsWRc60wNq+RYcmhK/RG+Ol4L8ksrCtAyd5jhGNsrarzO/JWWJUawA6
	 v6dHphG+2NjXWOyxQQDJ42Lz1S5irsrp2lFMoB3+EpGiAYwqDwsV4UtvZ+Nm8V7AX7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793967026;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=f4YoYCSVK4gZhUunSADNV3O618EXpW3G+wBkhi6O/wU=;
	b=GiMmBlByZl778PuqUKBibBuRd0A6laZMdvL8r3dc6DLZZ00z7hHy3nx1xcTwNswm1Kmu
	 BtTpimTsIBXUJ8BJ6X/sgF2rF6svVgLSwgW4LqJoA5SeckYD2dRXuS2gi+q51X5UPVDVW
	 q2cYAR4KWVJqoruPBIk8xOjQe9IOPEnLmwMqFmaqjTDQ+CRw2pDp8aDIjPIE9Tgw4SboZ
	 WlOOz0QmhysfjGNwEctuWe+bxvY/anOXZFV6fq8IZpfhOz6ceUBtfEFz/Z5jRcDBjiM/m
	 8+zTULniTtOa1QEr0frwDQIIeJYUCq6MkYTC21nWYa02Qgo7rVYWTEteDCne8GNLVEA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ULWkDaMu;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA47606D80A
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 12:10:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FA47606D80A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ULWkDaMu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793967024;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=f4YoYCSVK4gZhUunSADNV3O618EXpW3G+wBkhi6O/wU=;
	b=ULWkDaMucnor3ykVJbtcFOkI71PJUg+dQH7xhUxK1GVZhIdrcW86lLOxuEXX3gx5jCkBHe
	ZfvX4dySaXAo0+t24sAL5eY78BDTN0OuE237YtCDwhYEOTykgS8o4KvrOA62RAimGSvYSr
	CW3zfEeXIDJDf4xCJRRUyruIz+qJBtw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-44-TerawikSOku60RoOmgG7pA-1; Fri,
 06 Nov 2026 07:10:23 -0500
X-MC-Unique: TerawikSOku60RoOmgG7pA-1
X-Mimecast-MFC-AGG-ID: TerawikSOku60RoOmgG7pA_1793967020
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6ADE91956057;
	Fri,  6 Nov 2026 12:10:20 +0000 (UTC)
Received: from ivecera-thinkpadp16vgen1.tpbc.csb (headnet04.pony-001.prod.iad2.dc.redhat.com [10.2.32.116])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2711318001CA;
	Fri,  6 Nov 2026 12:10:13 +0000 (UTC)
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
Subject: [PATCH net-next 01/10] ice: dpll: notify TSPLL lock status from the periodic work only
Date: Fri,  6 Nov 2026 13:09:56 +0100
Message-ID: <20261106121005.1327603-2-ivecera@redhat.com>
In-Reply-To: <20261106121005.1327603-1-ivecera@redhat.com>
References: <20261106121005.1327603-1-ivecera@redhat.com>
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
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

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

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_dpll.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_dpll.c b/drivers/net/ethernet/intel/ice/ice_dpll.c
index ade1fb3dd06743..bdbcf7af296eb4 100644
--- a/drivers/net/ethernet/intel/ice/ice_dpll.c
+++ b/drivers/net/ethernet/intel/ice/ice_dpll.c
@@ -2914,7 +2914,6 @@ ice_dpll_tspll_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
 	struct ice_dpll_pin *p = pin_priv;
 	struct ice_pf *pf = p->pf;
 	enum ice_clk_src clk_src;
-	bool changed = false;
 	struct ice_dpll *tp;
 	int ret;
 
@@ -2947,15 +2946,12 @@ ice_dpll_tspll_state_on_dpll_set(const struct dpll_pin *pin, void *pin_priv,
 		WRITE_ONCE(pf->ptp.tspll_locked,
 			   new_state == DPLL_LOCK_STATUS_LOCKED);
 
-		if (tp->prev_dpll_state != new_state) {
-			tp->dpll_state = new_state;
-			tp->prev_dpll_state = new_state;
-			changed = true;
-		}
+		/* ice_dpll_periodic_work_e825() compares the state with
+		 * prev_dpll_state and sends the notification.
+		 */
+		tp->dpll_state = new_state;
 	}
 	mutex_unlock(&pf->dplls.lock);
-	if (changed)
-		__dpll_device_change_ntf(tp->dpll);
 	/* TSPLL reconfiguration may complete before lock is reacquired.
 	 * PTP periodic monitoring tracks and restores the final lock state.
 	 */
@@ -3372,8 +3368,8 @@ static void ice_dpll_periodic_work_e825(struct ice_pf *pf)
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

