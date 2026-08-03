Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AE4B397E8E
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 12:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785758584; cv=none; b=Bx0/cM/mmEhQ8ZLAilrbh3eWYlMt7xRnqShiSGWxqxHgUFDDf3eEytF76udI0ywQ2iozebCD0q7AU4MtJK5NQZMWn9jKTaVqc9CfRnoIpbZmjfL3utKobZhpgcArtoejNU24QvL6yzOpDF4eWdbjrTmr67bTOMcMrGzyi7FECbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785758584; c=relaxed/simple;
	bh=bcCdMqPbAlKoFoIztDHxpCYpppnI4cd6ETy78QzD1HU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eiJxkEduDJRgYaqBf+KcsLjhV08RxG5EyENnLDPc2D5JEwfasMxNSZ8vbpRVQKhGRsQbr6xFc6Bq5/SLAKvO0iGWY/BvO1mW/+SNLtjs3LdlygqTQ2FwhnOTGSJe3oPPW8mAFwjkBIv5uVdjJAjNB1UqHqeQgC5loWWBIC7fPck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ce60LZL1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ce60LZL1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785758581;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NUIrWk7jm/9ZGBGW0uXzNDgkuZ+7kcDiX4WTkeop4QQ=;
	b=Ce60LZL1x/GlkEeEQ9DEu2cGuy+FVCQwtJZ9BaLqof62Z5eo6vxPlb96cJYoiSCk1GJO5y
	eUT9oZYGO0q6Jhz4ETzajtno9mH4PVjrc7hKOEIhsc2pQ8oKDwqG8O54RIEBAQJnkFpDug
	Sl3Da5s18gXZJqaT+srGk1nUZruxPqc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-396-8LIUlc1UMmyXeO_IW7PCiQ-1; Mon,
 03 Aug 2026 08:02:56 -0400
X-MC-Unique: 8LIUlc1UMmyXeO_IW7PCiQ-1
X-Mimecast-MFC-AGG-ID: 8LIUlc1UMmyXeO_IW7PCiQ_1785758575
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A87918001E6;
	Mon,  3 Aug 2026 12:02:54 +0000 (UTC)
Received: from p16v.redhat.com (unknown [10.44.33.235])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3BEC5424;
	Mon,  3 Aug 2026 12:02:50 +0000 (UTC)
From: Ivan Vecera <ivecera@redhat.com>
To: netdev@vger.kernel.org
Cc: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Paolo Abeni <pabeni@redhat.com>,
	Petr Oros <poros@redhat.com>,
	Prathosh Satish <Prathosh.Satish@microchip.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] dpll: zl3073x: update all DPLL channels on ref_sync_set
Date: Mon,  3 Aug 2026 14:02:44 +0200
Message-ID: <20260803120245.56046-2-ivecera@redhat.com>
In-Reply-To: <20260803120245.56046-1-ivecera@redhat.com>
References: <20260803120245.56046-1-ivecera@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

zl3073x_dpll_input_pin_ref_sync_set() excludes the sync source from
automatic reference selection by setting its priority to NONE, but
currently only does this on the single DPLL channel whose pin_priv
was passed to the callback.

Since input pins are registered with every DPLL channel, the priority
update must cover all channels to prevent the sync source from
remaining a selectable candidate on the other channels. This is
a preparation for the following patch which changes the DPLL core to
invoke pin-level set callbacks only through the pin owner's reference
instead of iterating over all registered DPLL devices.

Replace the single-channel priority write with a list_for_each_entry()
loop over all DPLL channels. Each channel's lock is acquired
individually for its read-modify-write sequence. The guard(mutex) is
replaced with explicit mutex_lock/mutex_unlock to allow releasing the
owner's lock before iterating, avoiding nested locking of the same
mutex class.

Signed-off-by: Ivan Vecera <ivecera@redhat.com>
---
 drivers/dpll/zl3073x/dpll.c | 46 +++++++++++++++++++++++++++----------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/dpll/zl3073x/dpll.c b/drivers/dpll/zl3073x/dpll.c
index 0488ae6ac486c8..1ea924a9b986b2 100644
--- a/drivers/dpll/zl3073x/dpll.c
+++ b/drivers/dpll/zl3073x/dpll.c
@@ -265,7 +265,7 @@ zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
 	struct zl3073x_ref ref;
 	int rc;
 
-	guard(mutex)(&zldpll->lock);
+	mutex_lock(&zldpll->lock);
 
 	ref_id = zl3073x_input_pin_ref_get(pin->id);
 	sync_ref_id = zl3073x_input_pin_ref_get(sync_pin->id);
@@ -285,17 +285,20 @@ zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
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
@@ -308,20 +311,39 @@ zl3073x_dpll_input_pin_ref_sync_set(const struct dpll_pin *dpll_pin,
 
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
+	 */
+	mutex_unlock(&zldpll->lock);
+
+	/* The datasheet recommends excluding the sync source from automatic
+	 * reference selection by setting its priority to NONE on all DPLL
+	 * channels. This is advisory - the ref sync pair is already
+	 * configured, so a failure here is not fatal. On disconnect the
+	 * priority is left as NONE and the user must explicitly make the
+	 * pin selectable again.
 	 */
 	if (state == DPLL_PIN_STATE_CONNECTED) {
-		chan = *zl3073x_chan_state_get(zldev, zldpll->id);
-		zl3073x_chan_ref_prio_set(&chan, sync_ref_id,
-					  ZL_DPLL_REF_PRIO_NONE);
-		return zl3073x_chan_state_set(zldev, zldpll->id, &chan);
+		list_for_each_entry(zldpll, &zldev->dplls, list) {
+			mutex_lock(&zldpll->lock);
+			chan = *zl3073x_chan_state_get(zldev, zldpll->id);
+			zl3073x_chan_ref_prio_set(&chan, sync_ref_id,
+						  ZL_DPLL_REF_PRIO_NONE);
+			if (zl3073x_chan_state_set(zldev, zldpll->id, &chan))
+				dev_warn(zldev->dev,
+					 "Failed to set ref prio on DPLL%u\n",
+					 zldpll->id);
+			mutex_unlock(&zldpll->lock);
+		}
 	}
 
 	return 0;
+unlock:
+	mutex_unlock(&zldpll->lock);
+	return rc;
 }
 
 static int
-- 
2.54.0

