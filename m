Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2AF44F56C
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 13:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791726624; cv=none; b=bQ4O/up14sTxkzrKQgDa02iRsbgbbAk7sBNu8QAULy4n4au8Kh4SOAB7gny2woQtFfHlSVXfucEeX/fZRhA5f67+WKd658cs34id5BQLcixXMCiJSQBD5SGjXp+dAwTj4QQdTGHwgOhLHPAj2nxI8hAwt/hHpY8DhTEzkjwuP88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791726624; c=relaxed/simple;
	bh=d9mIhBPv+JjDkqCK/EZVr08dsL+ukbR1sULMDiHoe80=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CKbSsh8++7cX2fkQidd2/2vJbM88O1/5bSTiCQJqH1fka2ACqVZqVCwmiJQQhrMiz8dtnXextgdeGPJp8/rTp0HjXW5TEDetmyDIysjMyUFtQQNm/phr+iqX3jwgmy8S6Dm+WdAPjS8zzs14uTtdBdQ75X85XTjkdXEveqna0zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TLbnShfA; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=BzHqafLX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLbnShfA";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="BzHqafLX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1791726621;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6dYLvfVc8Rv+oqmerSW0nLfcnT5kypXV4jGxHwKDvdE=;
	b=TLbnShfA67YctU94WaYQETKfcvfJmA1Qjfj/FguMh5INh9817TS3cixYKu6c3jKgOboHBH
	KN3qZLN6DvyTyEVtTwZyGP0plv82fcaG5lmmdTIYZUHYfD/c2K8PbqbABHng0hU7BSuXCX
	dpWUqVqgF1ogVldvw3gOZLkpLuwPTEo=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-ZQO7U6wKPxiumBIuAqiPNg-1; Sun, 11 Oct 2026 13:50:20 +0000
X-MC-Unique: ZQO7U6wKPxiumBIuAqiPNg-1
X-Mimecast-MFC-AGG-ID: ZQO7U6wKPxiumBIuAqiPNg_1791726619
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4a1721559b4so13157705e9.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 06:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1791726619; x=1792331419; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6dYLvfVc8Rv+oqmerSW0nLfcnT5kypXV4jGxHwKDvdE=;
        b=BzHqafLXG33ZjWCRg5DTgsSh5U7dnmofS7G2HrBT1h4eDpS/GaZtvGIeLXu5Fu5ix+
         NElLMVjFrcBLGfrU6K+K2CRYBdAUFv9lTq6JEXhKkwbIhAOwLGSriew4mkvZaW0c7LZO
         edHVl4vSkzuimwZX9iO7gm9QjlGaNfg1JVw54LMEOFAhD3QkEJIcyy2JRz95S3K7+6da
         cCcX+shLM0B/Wh+J3wfTATbozTm+Sgas7iqSBCE5eH6dM8uCJabhhqKcN5DLtuUXe8y0
         1yBQmO1GxzHTdt7ModgSTJKv+vY+BZmDfF+wN5t8k1WuhCAEucBYPdyWVDHfPr3Ecoe6
         irzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791726619; x=1792331419;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6dYLvfVc8Rv+oqmerSW0nLfcnT5kypXV4jGxHwKDvdE=;
        b=nBx7g/09E4dUw9pWb7B7BvejPGU/qbWBP0i/XACiCr12KCC2R8E4padYXW1h3QpGo9
         UGLPUEsEY+UWUVBo1IzfjfnIpbDFgLvx698sBUOomKLaRwOA42QHyRXnbvRjbPy7ypl0
         4qdtW39vdkN0bhOf+hQWE1l636ufyiRIp6rJqaChVlT+Oo8BeVoCpD8+z9VhbfIS9caW
         pbBdBqgtAnt7QNFCrBmru+3+72mBgOD1vEwsnNc7IUe+HmmjYAWI9GPNOj3KM2qVCtWA
         LteZDftiCA479G3EwmrgUdzczBRFEc41aiiixua12D5uSuUWr5TNu+Pga1xeK1XGs3oQ
         JlCA==
X-Gm-Message-State: AFq9FYKXD65tKaWBBHdtcN/NJB+Z99vbOSmazF20f2qkr7xT6to9gako
	ggFozo9ylP+rLJN0kqeG7BqDJ+siyRzEP61rNenHVnD1NGAHMmZMTPoezaDBT0gZa+wm6DqiQDf
	DU2UVX8Vhrj49JI35LQ4EQsS/wZdYzM/Dvvvu5illpFoxsOI3+Iw3iyqtLLMF8bc7iJAB
X-Gm-Gg: AYBFou1RGssnjwuKRTmTyR4NvuWDFaI1yKsl6hReG8yH3YozQea4RN0jTAlg8FW+1U4
	+qO2egoTz5dg2mKB+PjFKhdqiLJGwtbgZ8uyjgaGm1mATLpVKY8B1GhYfgHklWQknscxxEvQyjt
	aGIZxr8ndtEvhUTCnqLqGo0/NcZ4LZ777humwNSgkbYMh+qzqlXieFmX0pkrli3cSe887mPR/w5
	By0oTbgVQd6VJwIhLxthJqRcrN9Yx6PUUeBpwmJ4EyFXn/66SRcFoYyRT52QxkVr7l8Zjb1LGqW
	7AxrJS3rhBnAk20xWtErItswCORxof1uSeLg5l2Vo1xcmhc++CItVrNyBsep7bccJol7AaPabyX
	FGAmo7zOc6uuPeX4YnPdV6E1EruHo3p0T
X-Received: by 2002:a05:600c:c16f:b0:49f:ed8c:6cad with SMTP id 5b1f17b1804b1-4a18e4ca869mr117267715e9.19.1791726619133;
        Sun, 11 Oct 2026 06:50:19 -0700 (PDT)
X-Received: by 2002:a05:600c:c16f:b0:49f:ed8c:6cad with SMTP id 5b1f17b1804b1-4a18e4ca869mr117267405e9.19.1791726618767;
        Sun, 11 Oct 2026 06:50:18 -0700 (PDT)
Received: from mheib-thinkpadp16vgen1.rmtil.csb ([216.128.14.202])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a19f249692sm13334125e9.3.2026.10.11.06.50.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 06:50:18 -0700 (PDT)
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
Subject: [PATCH iwl-next v6 2/2] i40e: add devlink parameter for Flow Director ATR sample rate
Date: Sun, 11 Oct 2026 16:49:52 +0300
Message-ID: <20261011134952.54887-3-mheib@redhat.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261011134952.54887-1-mheib@redhat.com>
References: <20261011134952.54887-1-mheib@redhat.com>
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

