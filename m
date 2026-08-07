Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C733FE64A
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 09:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096794; cv=none; b=EPVq8CvkynNsVfdBV0U3Sj7tAi6xtEJX57XQ31paW5ynNxqrvtQTZR2wIml+soFDRDp7OblOKIqxhg9Wv3u4ABXA5bexeAnt7Nqbwm1IyQ1Q2QcfL8diK+y4TikFOECgR/uCQwxEF4ftu3KUlAUGtqOUUKn7L1S4UNOJkSTUHjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096794; c=relaxed/simple;
	bh=vAMujusWBTM741d7RAiPKT9Iib9nEaiW1Xpf0HvbAm4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8kn/zkfuEEMwHi61479YFKKPmAysKWHyps/85BJBPaJbaOhEQg3yFczfcVPj6KjaDqalkRpg6ACu2mCF9rwoh3gabVD+sr6EeXAqh4ATx6Too0jKXjmtYaEpB/oNwcQB0kDRCTEdZPXVyfBWyhdC8AcKcVmHZHsIcEklokWJpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MoGuHjwl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MoGuHjwl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1786096792;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jUqI+WEShIkI1sR1+RONA2PEu9DsOmlQV/su8ACFp1w=;
	b=MoGuHjwloGIcp6Cw4Xc1CHYRv/hai8qujkKs6ell3xOvENMUEx//V0IEDiwNGaN34P7Imd
	tr+8h5Awfg5GUmwXNEYykbwf8Y/wwwj5IsC0h5Mkgv1a+yQOX0DngIlE1tu5XSy6Zv0kTu
	yjB1d3vlPzW4lw4GVnz+2W4o4bnxi+w=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-rW-EyCUhNlac1B4rvtr5Rw-1; Fri,
 07 Aug 2026 05:59:37 -0400
X-MC-Unique: rW-EyCUhNlac1B4rvtr5Rw-1
X-Mimecast-MFC-AGG-ID: rW-EyCUhNlac1B4rvtr5Rw_1786096776
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A36081956044;
	Fri,  7 Aug 2026 09:59:35 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.32.215])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 21A2730001A2;
	Fri,  7 Aug 2026 09:59:31 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Min Li <min.li@microchip.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org
Subject: [PATCH net-next v3 1/2] dpll: zl3073x: update all DPLL channels on ref_sync_set
Date: Fri,  7 Aug 2026 11:59:25 +0200
Message-ID: <20260807095926.386923-2-ivecera@redhat.com>
In-Reply-To: <20260807095926.386923-1-ivecera@redhat.com>
References: <20260807095926.386923-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

zl3073x_dpll_input_pin_ref_sync_set() excludes the sync source from
automatic reference selection by setting its priority to NONE, but
currently only does this on the single DPLL channel whose pin_priv
was passed to the callback.

Since input pins are registered with every DPLL channel, the datasheet
recommends covering all channels to prevent the sync source from
remaining a selectable candidate on the other channels. This is
a preparation for the following patch which changes the DPLL core to
invoke pin-level set callbacks only through the pin owner's reference
instead of iterating over all registered DPLL devices.

Replace the single-channel priority write with a list_for_each_entry()
loop over all DPLL channels. Each channel's lock is acquired
individually for its read-modify-write sequence. The guard(mutex) is
replaced with explicit mutex_lock/mutex_unlock to allow releasing the
owner's lock before iterating, avoiding nested locking of the same
mutex class. A change notification is sent for the sync pin if any
channel's priority was actually modified.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 58 ++++++++++++++++++++++++++++++-------
 1 file changed, 48 insertions(+), 10 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 0488ae6ac486c8..83bd3027dbaa1e 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -263,9 +263,10 @@ zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
 	u8 mode, ref_id, sync_ref_id;
 	struct zl3073x_chan chan;
 	struct zl3073x_ref ref;
+	bool sync_ntf = false;
 	int rc;
 
-	guard(mutex)(&zldpll->lock);
+	mutex_lock(&zldpll->lock);
 
 	ref_id = zl3073x_input_pin_ref_get(pin->id);
 	sync_ref_id = zl3073x_input_pin_ref_get(sync_pin->id);
@@ -285,17 +286,20 @@ zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
 		if (sync_freq > 8000) {
 			NL_SET_ERR_MSG(extack,
 				       "sync frequency must be 8 kHz or less");
-			return -EINVAL;
+			rc = -EINVAL;
+			goto unlock;
 		}
 		if (ref_freq < 1000) {
 			NL_SET_ERR_MSG(extack,
 				       "clock frequency must be 1 kHz or more");
-			return -EINVAL;
+			rc = -EINVAL;
+			goto unlock;
 		}
 		if (ref_freq <= sync_freq) {
 			NL_SET_ERR_MSG(extack,
 				       "clock frequency must be higher than sync frequency");
-			return -EINVAL;
+			rc = -EINVAL;
+			goto unlock;
 		}
 
 		zl3073x_ref_sync_pair_set(&ref, sync_ref_id);
@@ -308,20 +312,54 @@ zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
 
 	rc = zl3073x_ref_state_set(zldev, ref_id, &ref);
 	if (rc)
-		return rc;
+		goto unlock;
 
-	/* Exclude sync source from automatic reference selection by setting
-	 * its priority to NONE. On disconnect the priority is left as NONE
-	 * and the user must explicitly make the pin selectable again.
+	/* All code paths accessing per-channel reference priorities are
+	 * serialized by the subsystem dpll_lock, so it is safe to release
+	 * our lock here before iterating over the other channels.
 	 */
-	if (state == DPLL_PIN_STATE_CONNECTED) {
+	mutex_unlock(&zldpll->lock);
+
+	if (state != DPLL_PIN_STATE_CONNECTED)
+		return 0;
+
+	/* The datasheet recommends excluding the sync source from automatic
+	 * reference selection by setting its priority to NONE on all DPLL
+	 * channels. This is advisory - the ref sync pair is already
+	 * configured, so a failure here is not fatal. On disconnect the
+	 * priority is left as NONE and the user must explicitly make the
+	 * pin selectable again.
+	 */
+	list_for_each_entry(zldpll, &zldev->dplls, list) {
+		u8 prio;
+
+		mutex_lock(&zldpll->lock);
+
 		chan = *zl3073x_chan_state_get(zldev, zldpll->id);
+		prio = zl3073x_chan_ref_prio_get(&chan, sync_ref_id);
+		if (prio == ZL_DPLL_REF_PRIO_NONE) {
+			mutex_unlock(&zldpll->lock);
+			continue; /* Ref is already non-selectable */
+		}
+
 		zl3073x_chan_ref_prio_set(&chan, sync_ref_id,
 					  ZL_DPLL_REF_PRIO_NONE);
-		return zl3073x_chan_state_set(zldev, zldpll->id, &chan);
+		if (zl3073x_chan_state_set(zldev, zldpll->id, &chan))
+			dev_warn(zldev->dev,
+				 "Failed to set ref prio on DPLL%u\n",
+				 zldpll->id);
+		else
+			sync_ntf = true;
+
+		mutex_unlock(&zldpll->lock);
 	}
+	if (sync_ntf)
+		__dpll_pin_change_ntf(sync_pin->dpll_pin);
 
 	return 0;
+unlock:
+	mutex_unlock(&zldpll->lock);
+	return rc;
 }
 
 static int
-- 
2.54.0

