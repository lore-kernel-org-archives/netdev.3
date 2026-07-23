Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41ED31F984
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815556; cv=none; b=tnoUls7U+D7/8j1P3G5JMWGCrHsqkvAQ/3iPVinZHLWH/MJDBmVg1nAlQyWV1zSpftvFdQSWX0wfXdFGyKTmu/wfVig3hT1HaTUffvenFYCU7qMjAyKzrdmJOtEkdSoZSdaiJVk7Kp9BsT1K7+6BBG8N2LT8EF5Wsa49Jk9g1nY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815556; c=relaxed/simple;
	bh=f5mefx920iVtjxAk8+at3HpcWineSSgdd/AOxpTL/U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jCHUJsTHW6CJc1I2qMslIAcIuRo9jVxE0Bkqurc0UJYj3/i/dbN/o/ylZSO20ErrADvdyfQZLxkCCz2uXBdc8ki/bwjfOMLpV7EN8GaHKKMa3TMsGi7CQJHKoaMmnFRMS34zqotSzdx9/SdXDOIZoKMP9ZsxpEyuqUdPdKrX3Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PbnZzT6a; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=FEchDZwl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PbnZzT6a";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="FEchDZwl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784815553;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EJSVbQzeC6WNvyzEAD2OPMeMq8tHisEcWft/tom9rFc=;
	b=PbnZzT6aXCJazPlzXzSL80k2NnkFAMsgr24EI4J8z1hJbjLhNoEd0hH3VkXadSRa7h7Zxu
	HwTguKn3zb/iNFeYcNklUAf8eNt3eTEQEm0HRa1deKpSzjSwcKbEolYB0qToryWGaRizBD
	+/GrxS5oXpArK7tyoTnv3P0tNFumwH0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-sDpTwty5OfukggIA2wjFjQ-1; Thu, 23 Jul 2026 10:05:49 -0400
X-MC-Unique: sDpTwty5OfukggIA2wjFjQ-1
X-Mimecast-MFC-AGG-ID: sDpTwty5OfukggIA2wjFjQ_1784815548
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-492488f8583so7217015e9.2
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:05:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784815548; x=1785420348; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EJSVbQzeC6WNvyzEAD2OPMeMq8tHisEcWft/tom9rFc=;
        b=FEchDZwlfCSOHCL/pNDJ8OQC9uxflSvRDwM5cz+5AmZHrTKbR7RiQ5QQ6uI2PXfJe7
         9T3W+AXl9xWBL7/soZYxs6wrvIB+8NbSmfMVIsiBCOy76ihaEct04camzFlcPC2GaoIl
         Vhi3KWxpjb36Rc2pgX7KRei7nNVF8EcKWFNRqZXxb7O6o5wd1YF0GyYuMKktVhIyF4s2
         73sKPf4Wd+r/i3woNyUVfVndp2afoOqOeVqtHm7QdlEWsINIxoH9P5UcfYAXp+CQDh13
         nBwDa/n8I0rHhb+3W7T48Hkw16sPi20qAQcdFOFWJ0maVx8xFgezZOst2HI0RKCUoZKa
         TCiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784815548; x=1785420348;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=EJSVbQzeC6WNvyzEAD2OPMeMq8tHisEcWft/tom9rFc=;
        b=Z4zzqZp1h0fxv0jo1Cqn/WgT3SgCpYnyi0DI6HUlpZEo7ZS9CJmjLyPkF9QFXwLfEU
         hM439z5o9NkMjJI2TzZ4QL0vxneXKaK9agfH5JKHQ+67VIA7yxCqMmrz5Fue/qXD62Sr
         D1BPgMgcoVuh5aY++1ocuMqgyP+/4wsUZ4gArO94DIEkvUYTvKyGIDwHYvaXXht/stYF
         gUh2kItUHp5kc0Qgt5Iwf6ye/DJkLkfIyqZESnKSsDaf0l0z2H+Y7s5yBa2RdwmoNs1O
         uyBz36q1vya/bzr5DIlr7skMdrioXl5pnE8gykHquRZiqi8GC33rF1bWfYcvRwDlUSBz
         7SYQ==
X-Gm-Message-State: AOJu0Yz/HII+qG+MEbzgz1gH0lYMd/q+vFbOnntM0e2ob381kOcpWsR2
	vGXEJeMAcwv6ooMn8jdv8U/nxznTqka0pZplQL34XnvNf3t/mTuEhe1TBDbJ4+KjsktdhIL7wYL
	3pVfPShxzFRfWeqMzB1dn8gF3BXcxLQXpobrmDQBZZ6I+5pyzQ2Gk6RJH8A==
X-Gm-Gg: AR+sD10MOSwQZ72PlGB319RSgealSa3CdNAwuUcbjpM56RfFUmnol2FktpY/Kzvf6Dq
	uksdfXexZvOtfHNUzpIddqv3WfovAMvQEHPRdKE/H96YmGQpivKxa7lA4cI+5WPni7TZz0lDsgq
	0GL26cii1JXbhfrhqdN8TXWuZAOSdUXRz/txZCW82qRI4cj0OigKEO88LXqpMXpFCSCScYeE2Bx
	VkvY3eXVXxXY+zphjAbwTlnkew05ArJqaalLxQpP4WeNGV+uZko5XbsP937vQWpHkOI2xaLh8Pz
	EnqsgJGiMFVAA08B8PXh9NULgBUJ0pwl/oi7+dZdm9VsIpkpYE33AuudW7HwZO4cnmSV8oOYSyO
	wF1e37HYp0Ln14g==
X-Received: by 2002:a05:600c:8b41:b0:490:b8c0:d470 with SMTP id 5b1f17b1804b1-49573cfc9ffmr45276925e9.19.1784815547940;
        Thu, 23 Jul 2026 07:05:47 -0700 (PDT)
X-Received: by 2002:a05:600c:8b41:b0:490:b8c0:d470 with SMTP id 5b1f17b1804b1-49573cfc9ffmr45276385e9.19.1784815547537;
        Thu, 23 Jul 2026 07:05:47 -0700 (PDT)
Received: from fedora.redhat.com ([216.128.14.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a4aae16sm154261685e9.0.2026.07.23.07.05.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 07:05:46 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	corbet@lwn.net,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH iwl-next v4 2/3] i40e: add devlink parameter for Flow Director ATR sample rate
Date: Thu, 23 Jul 2026 17:04:16 +0300
Message-ID: <20260723140510.184819-3-mheib@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260723140510.184819-1-mheib@redhat.com>
References: <20260723140510.184819-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

The i40e driver uses Flow Director ATR to periodically update flow
steering information for active TCP flows. The update frequency is
currently controlled by I40E_DEFAULT_ATR_SAMPLE_RATE and is fixed at
driver build time.

On systems with a large number of queues and high-rate TCP workloads,
the default sampling interval can result in frequent Flow Director
reprogramming for long-lived flows.

The amount of TCP packet reordering observed on some systems is
sensitive to the ATR sampling interval. Increasing the interval reduces
Flow Director programming activity and can significantly reduce the
associated reordering.

Since the optimal sampling interval depends on the workload and system
configuration, a single fixed value is not suitable for all deployments.

Add a devlink parameter to allow administrators to tune the ATR sample
rate at runtime without rebuilding the driver or disabling ATR
functionality entirely.

Signed-off-by: Mohammad Heib <mheib@redhat.com>
---
 Documentation/networking/devlink/i40e.rst     | 20 +++++++++++
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 36 +++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
index 51c887f0dc83..2cea98b631ba 100644
--- a/Documentation/networking/devlink/i40e.rst
+++ b/Documentation/networking/devlink/i40e.rst
@@ -40,6 +40,26 @@ Parameters
 
         The default value is ``0`` (internal calculation is used).
 
+.. list-table:: Driver specific parameters implemented
+    :widths: 5 5 90
+
+    * - Name
+      - Mode
+      - Description
+    * - ``atr_sample_rate``
+      - runtime
+      - Controls how frequently Flow Director ATR updates flow steering
+        information for active TCP flows.
+
+        ATR programs Flow Director entries based on sampled transmitted
+        packets. The sampling interval is specified as the number of
+        transmitted packets between ATR updates.
+
+        Lower values increase Flow Director programming activity, while
+        higher values reduce the update frequency.
+
+        Setting to ``0`` disables ATR sampling (no filters will be programmed)
+        The default value is ``20``.
 
 Info versions
 =============
diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
index 229179ccc131..6df7eb217073 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
@@ -33,12 +33,48 @@ static int i40e_max_mac_per_vf_get(struct devlink *devlink,
 	return 0;
 }
 
+static int i40e_atr_sample_rate_set(struct devlink *devlink,
+				    u32 id,
+				    struct devlink_param_gset_ctx *ctx,
+				    struct netlink_ext_ack *extack)
+{
+	struct i40e_pf *pf = devlink_priv(devlink);
+	u32 sample_rate = ctx->val.vu32;
+
+	WRITE_ONCE(pf->atr_sample_rate, sample_rate);
+	return 0;
+}
+
+static int i40e_atr_sample_rate_get(struct devlink *devlink,
+				    u32 id,
+				    struct devlink_param_gset_ctx *ctx,
+				    struct netlink_ext_ack *extack)
+{
+	struct i40e_pf *pf = devlink_priv(devlink);
+
+	ctx->val.vu32 = READ_ONCE(pf->atr_sample_rate);
+
+	return 0;
+}
+
+enum i40e_dl_param_id {
+	I40E_DEVLINK_PARAM_ID_BASE = DEVLINK_PARAM_GENERIC_ID_MAX,
+	I40E_DEVLINK_PARAM_ID_ATR_SAMPLE_RATE,
+};
+
 static const struct devlink_param i40e_dl_params[] = {
 	DEVLINK_PARAM_GENERIC(MAX_MAC_PER_VF,
 			      BIT(DEVLINK_PARAM_CMODE_RUNTIME),
 			      i40e_max_mac_per_vf_get,
 			      i40e_max_mac_per_vf_set,
 			      NULL),
+	DEVLINK_PARAM_DRIVER(I40E_DEVLINK_PARAM_ID_ATR_SAMPLE_RATE,
+			     "atr_sample_rate",
+			     DEVLINK_PARAM_TYPE_U32,
+			     BIT(DEVLINK_PARAM_CMODE_RUNTIME),
+			     i40e_atr_sample_rate_get,
+			     i40e_atr_sample_rate_set,
+			     NULL),
 };
 
 static void i40e_info_get_dsn(struct i40e_pf *pf, char *buf, size_t len)
-- 
2.53.0

