Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB1A438034
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 13:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791465544; cv=none; b=U1u87Blx4BEwiCKtt0bYtcwlh+ChwlXX50GpP95prviqe0jPHtFIESD/vOYOAayNOvKLzp7LtSOlBlqoVuqdBU9IhypfAYD/0um8ZzojupEy/QA/IjYsTGvMVJ0oZf2Vx02ThxvqKI+sb02g7aw0uCkxMu743ZELxcJfBGQkM2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791465544; c=relaxed/simple;
	bh=d9mIhBPv+JjDkqCK/EZVr08dsL+ukbR1sULMDiHoe80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SroYbErwNvK4U6swNNBHyGcEANWdOzRGKxudmpKitDFe/8n+mV0SqID7/l6g42C7yA+3xmHl9VkBWdRSDeOiWIL1PEvk0o1xD/SB/XRtSeukZkN0gqEdFCehK9NOu7ZC75sMxn8yTqn42nZOCc3iBubLPp1nPU85CJgnEqTX75U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GiwXsRcu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=qmV1McfC; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GiwXsRcu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="qmV1McfC"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791465542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6dYLvfVc8Rv+oqmerSW0nLfcnT5kypXV4jGxHwKDvdE=;
	b=GiwXsRcuaLb7BSNXBEPdBCDfeZyhcNPbWAxsdxYLBqBwpmqhpncY4vCt4Uffjn//oebZVb
	+L28j6YtoY6nURcSgk6R23mHOvgNiBxxCABsTCSoeCr1ZhLJnm3HxHc/NU4qFds1oAUPAh
	5lp5qkSg8fLANAZ7x7bds6dOcmgfVQ0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-WOntbC6DP0e8CJ767F9nJg-1; Thu, 08 Oct 2026 09:19:00 -0400
X-MC-Unique: WOntbC6DP0e8CJ767F9nJg-1
X-Mimecast-MFC-AGG-ID: WOntbC6DP0e8CJ767F9nJg_1791465539
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49fcc575709so52755465e9.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 06:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791465539; x=1792070339; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6dYLvfVc8Rv+oqmerSW0nLfcnT5kypXV4jGxHwKDvdE=;
        b=qmV1McfCA/gMU7gQ5HnZ3YZQ+jrq5oo1eERQSb+nuyHI4XstgHh/KiJOqZG8PTwG/R
         nWdgPXhbmTJk+w/S42YZa+jJeQwNw497ucgfDMf9KUlU79sHQgdfY5hOiAfyAAAxOSdD
         nUmJTop73ArTkZGGWU/FMAOJ4i9IWke50BhHyO+FTNzDF/4gawOB/mE+5L1SaoSN+m6E
         J+16E2+xqiR71tR0T/JUSUV5qEDCMEojxt6MWv99Yuv4DOdHtSz9iB4dxlbFfgK/zCZe
         TDh3XVJ6/9u/NX/hM3gJnkDdXkgno6Cl33N6aY6c6Qbl5Twh/AR48VGs1qGifh7STT+5
         VagQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791465539; x=1792070339;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6dYLvfVc8Rv+oqmerSW0nLfcnT5kypXV4jGxHwKDvdE=;
        b=nF5Isoq0aP00LIzPsU9m+oQHLrJqkYFZk8t2vZfbCO1LlargHZ8mqOgWJF18gtIU8x
         DlgwXuLbUOIhVuNYlB5LZTbAPJ8MOTq4OUoKZYIAmHwuujikF8HecXY+lXcUWlgEeYru
         /bSP4c3Su44arbVRacPPVHgCqeAEZjFcPv+n6dqbV7qjRVQQpj+wT3J+v2GE0Zjq6/8R
         t9hF8FqmQ6r0foh1ukJP+lRfpEK2W8b8YzGrpts76GzXKKXAKGUvdhO0HYy5h2OZghmm
         kmfrUKtHw/0DjXcR08FreSDErn/D4bsMcnt6u7a/7no4SoQaW78QYcd6dlO1C8PcidEt
         fzYA==
X-Gm-Message-State: AFuF++n8aprcDY1uCXKgkSBHaUgaGuqExn4pg5kpyJDTiB2D8NgGJF6W
	0Z/8QMv41HuKMCM2bbYfRUJdqEOUz6jNcvAfOMmgpGMF9QYujQErU3eXfE1ztmqOdvUiy+0OhcP
	GxvIMP3Uu0Lnz+NykVXV0uFYV0+DF0wmlo86p1T/Wjl/8gTGxrdVo1ZAKmA==
X-Gm-Gg: AYBFou2q+IedAvQ9wIum+Epz8Btm45hd/X14NncLweenO0sMl7KLxbim7+jbRNfjQvc
	GmMVSofI8268zUSYIlA10gmO70dXZY9hyx17uIczehpDjMD5j21zgM5bSVtiZrERzM55tIUmm/d
	U8/+uW9GBH7YEmu+QjyxMFRq8+QRoyMISXCBck1ESKzkXCUyDKOn9OYm9NlTbqUrNF/yAb/AK8A
	xdm47GgoCacNVO24qyjmno74jrOZJGiUyhv1dQJ9BBUKMqRZjLiEsXT7DyAK9iSjBb/SQvc6PKI
	nqSmWg1ditXBoxPTex+OHEYQit5pYHcT1bG54VsO1PGeUAyS1f4OYv710e7ZAAgHxJ++MfMXPq4
	EU6TKeKc885VRvznTca+DgI4QX75ljZN2
X-Received: by 2002:a05:600c:3b9a:b0:4a0:1feb:de6a with SMTP id 5b1f17b1804b1-4a18045a4ccmr129984605e9.30.1791465538951;
        Thu, 08 Oct 2026 06:18:58 -0700 (PDT)
X-Received: by 2002:a05:600c:3b9a:b0:4a0:1feb:de6a with SMTP id 5b1f17b1804b1-4a18045a4ccmr129983965e9.30.1791465538539;
        Thu, 08 Oct 2026 06:18:58 -0700 (PDT)
Received: from mheib-thinkpadp16vgen1.rmtil.csb ([216.128.14.248])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843e3356sm62947465e9.14.2026.10.08.06.18.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 06:18:58 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH iwl-next v5 2/2] i40e: add devlink parameter for Flow Director ATR sample rate
Date: Thu,  8 Oct 2026 16:18:24 +0300
Message-ID: <20261008131824.248508-3-mheib@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261008131824.248508-1-mheib@redhat.com>
References: <20261008131824.248508-1-mheib@redhat.com>
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
 Documentation/networking/devlink/i40e.rst     | 21 +++++++++
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 46 +++++++++++++++++++
 2 files changed, 67 insertions(+)

diff --git a/Documentation/networking/devlink/i40e.rst b/Documentation/networking/devlink/i40e.rst
index 51c887f0dc83..d280c17fe987 100644
--- a/Documentation/networking/devlink/i40e.rst
+++ b/Documentation/networking/devlink/i40e.rst
@@ -40,6 +40,27 @@ Parameters
 
         The default value is ``0`` (internal calculation is used).
 
+.. list-table:: Driver specific parameters implemented
+    :widths: 5 5 90
+
+    * - Name
+      - Mode
+      - Notes
+    * - ``atr_sample_rate``
+      - runtime
+      - Controls how frequently Flow Director ATR updates flow steering
+        information for active TCP flows.
+
+        ATR programs Flow Director entries based on sampled TCP packets
+        per Tx queue. The sampling interval is the number of TCP packets
+        transmitted on each queue between ATR updates.
+
+        Lower values increase Flow Director programming activity, while
+        higher values reduce the update frequency.
+
+        Setting to ``0`` disables ATR sampling (no filters will be programmed).
+
+        The default value is ``20``.
 
 Info versions
 =============
diff --git a/drivers/net/ethernet/intel/i40e/i40e_devlink.c b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
index 229179ccc131..8af2487776f2 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_devlink.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_devlink.c
@@ -33,12 +33,58 @@ static int i40e_max_mac_per_vf_get(struct devlink *devlink,
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
+
+	/* Setting rate to 0 disables sampling but does not remove
+	 * existing ATR entries. Flush them so stale filters do not
+	 * persist on devices without HW ATR eviction.
+	 */
+	if (!sample_rate) {
+		set_bit(__I40E_FD_ATR_AUTO_DISABLED, pf->state);
+		set_bit(__I40E_FD_FLUSH_REQUESTED, pf->state);
+	}
+
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
2.56.0

