Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 914683BADA9
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 09:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782898775; cv=none; b=i/rKxfQZg3DApofoYCnDgrWCWgvzVngtwkKwlUVzMQmC9jH3IfOG0casYme+DfbdnOljXxtYmZRFrNF/RrGE82isnFp/5BKzShZgZ3zU4Uacc9w7UqiVoIF9J/28KqqcxWnFajZyxNB2KnZfpcTuHHouKrdk4ptnrC9+2zuDdWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782898775; c=relaxed/simple;
	bh=6tsdNqYfR2mQnCMoVuwXT9io3x8jWvThGYkClVjMlbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W1npSd2h/Un0762Knpx9RNNrlH30qDlAJjHi3RDXkuQMaVNq6BKaCM4daEXj6hBd5Kf2Mdn4qmdvhGS1YKCjGy3C15sVwwut6suDF7NBj9bp7zhB4LVNREtTF8XJlmxbQir1YmP4j5AWjeqdCyhJ0S1WKb1dwUi7Q2+kKbxjNyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=X7W/Ugm5; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lYwFk460; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X7W/Ugm5";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lYwFk460"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782898773;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4f6w2MoA+XP+TjGC5G5VS3oEg0ZAwkShPaC9GG0r1lM=;
	b=X7W/Ugm5nXTfttxcu2MeYhbT3ciR5gzfFYliOsxFOXBfuPlLxBvav6u8cP4ILTrEL8jfTJ
	nlyCsOjFKmLQ+KDfWHUOw1/rrMPz2kyBbl4LJ2uB5DU7rM09WuOi1jqd9kzB0cnwVZuPeC
	rP1kxydmNFMb4qna4iI6vou0g+Ifd2Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-I3nfO0zLOgOFN0g540SZ1g-1; Wed, 01 Jul 2026 05:39:32 -0400
X-MC-Unique: I3nfO0zLOgOFN0g540SZ1g-1
X-Mimecast-MFC-AGG-ID: I3nfO0zLOgOFN0g540SZ1g_1782898771
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-490c56e2576so4016835e9.3
        for <netdev@vger.kernel.org>; Wed, 01 Jul 2026 02:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1782898771; x=1783503571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4f6w2MoA+XP+TjGC5G5VS3oEg0ZAwkShPaC9GG0r1lM=;
        b=lYwFk460hSniP/XJelhLOiRRvwlBB/nx/2gwhCUXxz6MBq2omSJG6tHfTKA726zPiT
         g5ZboXdUZOJO8FR6+fVPmu6mLCS4z0lGekWh7lBrA83T5Eqdlv2AS6P12zpuZY98vevf
         BKdZ8Xt+jFec6d5xlOFC/0zVB9zZGEi3MZJZRDBZluh9ywsrHaxEqGjssY7OZt05zDuw
         a6YPhEq68MMuZoWnXPmCUZLLQ/Dw3ohBpw2y92WcTQ/5MDu515rTappscRq37ZBqsvKK
         s4fFkbdKvt1sWRmuoQi7zMpbKuZ04LCpRtTOHxyjVgcs+s+IciztJ3gNJijT9959zFbs
         I0Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782898771; x=1783503571;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4f6w2MoA+XP+TjGC5G5VS3oEg0ZAwkShPaC9GG0r1lM=;
        b=IW3i3LQsReau6vYkzO9i9KOg5xww08ILksTTAk1BIcxlpvqFL47YVWPcPMHwXZWbSN
         VulRvwy9MJyM+Ghqd1uEt/5TFZLDALEz0rMtQNoY8BZgOa/0ToP09b83nLUy/+DXEEuT
         MDHYzkro1B+VVW+cti2GchC0lBFdNIe50N+Ff13IJBO2/O+P//XZoRCsnf+8wYwDn6nO
         loeNlyQ76L9W9xU4w/Y8u/wyoXfW4QeBzb/twv37LX2y8KCElahBZDfk3idn7+hckpsp
         UuSV1e2F772WyEp1rLthBbMRuxYijCO+CL4TwJMZVVKVJfRf0SZsHhfqhBc60Pdts63i
         Gg+g==
X-Gm-Message-State: AOJu0Yy9jLqSiPT3+Onn8lwcUB0X2YDp2WEhU9j2s1c/Onq6z83Ol9Qe
	B8d7RoTf26nzjWCouN7OmNY1ZaY68h8+gQic0el+C+lbPYz8mvz0Sn9dI0wzZzJMZXFW+QoOsxr
	nlj/RwxuDj8J8wbdRJwWIEb/c6RAe8LTRQ/pWDNfWvEW1YtEd+T6K7M1QTA==
X-Gm-Gg: AfdE7ckltvjjUXx2mhpTcPXsl0wloJRMvjW90CrXbuBtG2hsT+8I9pCJv+tB+sB8aOr
	4a2ZsxHh4iah7TdQwVbvv7CzVyeC8m6+PGp+2ozhnjeeBAG3O5ltUJkJWfVdAMAEJ/KxxUgr5f6
	jjPjkiKVxOEvoBUElZ4FXGBs+ERwsiSrSk+VsbtrUUV3aS0wU882z9xm4Bnl0IsC4jSdBrkMjY7
	zb3kR/mUgwO5d+BWHNIVggZJsD+n/oNrA146tOYIw74Ada0CkNOvYsU/0UJ6NSTNjyHzvB6a02o
	9U2SxvgPQl0/SEgBG9f/SfxshE/2ke6s0eOvTHqW+748wQjQOxpG9J5qph6ifUvNchQWEFE559V
	X+8gcPX4glYCVcOsNT2uV9llL
X-Received: by 2002:a05:600d:111:b0:493:bfea:2786 with SMTP id 5b1f17b1804b1-493c2b9f630mr9812985e9.32.1782898771283;
        Wed, 01 Jul 2026 02:39:31 -0700 (PDT)
X-Received: by 2002:a05:600d:111:b0:493:bfea:2786 with SMTP id 5b1f17b1804b1-493c2b9f630mr9812745e9.32.1782898770918;
        Wed, 01 Jul 2026 02:39:30 -0700 (PDT)
Received: from fedora.redhat.com ([216.128.14.135])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-475641e4cdesm16547001f8f.13.2026.07.01.02.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jul 2026 02:39:30 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	corbet@lwn.net,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH iwl-next v3 2/2] i40e: add devlink parameter for Flow Director ATR sample rate
Date: Wed,  1 Jul 2026 12:38:30 +0300
Message-ID: <20260701093830.948756-2-mheib@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260701093830.948756-1-mheib@redhat.com>
References: <20260701093830.948756-1-mheib@redhat.com>
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
index 229179ccc131..cf487efdd803 100644
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
+	pf->atr_sample_rate = sample_rate;
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
+	ctx->val.vu32 = pf->atr_sample_rate;
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

