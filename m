Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4DC756B851
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 22:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788908265; cv=none; b=JbHY5Y6RPh11fc56hjRsQOVDEOpLiTObdEKConjByPNz30RpZsEepH7rvKqJhEKpLiiXyDUmRBM/S1F07mYBCCwPVFezkjbBUevvPXsXOEIxcK6mYKKvSKhTdz4i54sHCRQ0BpOsAOjq6j/3fkO0LJ4cKjtVmbEUapcZjAkBi5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788908265; c=relaxed/simple;
	bh=Vi3BmT7ZDkiqyokg+wo6JFBFy7A29xrg2kuZJqXCm60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdmSSrM4LOs8n/ypDNNNBo1m2K0EOmxQyaOG7UhgzUTkQI62tzSAWMgBxmna73Zu0i1iXBd0ITXr4nmLCt/jayLSWDVh60g5Ik85Xi/IuTIbwBd7GSLGsmNESi8bpU5pg+KdwDGxTcKPRcMKjwrSEsDwtyEkW3j7gDhXrAGPhA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NovJKql0; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NovJKql0"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-39266382df6so4249668a91.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 15:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788908262; x=1789513062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sfnOswr7eo1XQosDaF0vBD6HXJXxp8BEfMaGl2218a4=;
        b=NovJKql00yphvqYTYk+iBhd0giPXHuSlsfwsN0tLS1X0BbjQ95nIlOwU9ABoTfCxia
         Ml+BjY8y6jrRbF53fHP0ST7jkXc7mWgVCWAwbZe/VQymBEsq0MeHQWOQAhrhhRG8UtTO
         c1pdLvJEW3MgaNK5U4sxYf8QQt8RgcB5dcddD1D7/OOIHFBTZrdVk35M0v9uOfWaBR7z
         mTfuH9dgwsolA3w1rfiVJm5gzinUTrc7gjaBQc+2NXNJ/H7rmFXPUbc3acVWaH3UtyAJ
         WO1NywkZQYMzOKolNnA5/+Oc+LhiTsJjDPwwHqfWYGEpr+vmY0PQF5zuW7SZdve7o9+K
         ELLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788908262; x=1789513062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sfnOswr7eo1XQosDaF0vBD6HXJXxp8BEfMaGl2218a4=;
        b=Dut5CF8A2B2Uv5Usga044Jqf2lEIfhYB7wBD1/fsxkL5wCxpuHTj1HW3+tYT4sJ2I5
         3Uh2gg5RqrRQn+5rJQKzAQKv2k3AihnGZZwtMVvLyDpzHR7ajr6+h5Fs4LiLZDHPS+07
         Naqkqgl1fKIWJRXHosyNx1adzLgGP7jMWYGbEQPAIA4ZOoQJbGeWYPL6AbuIFclm4vSx
         T33ZTq9c7BQoqgjW3Bd4DHXPBL39VFgqAcjT9M8Zew8AF+dzffu5+I86VgiS5U2AIXU0
         sAcl0LtEfCj+ycejyM+Kf1WT8IRoeE4q7Aaoq9QmFraRlHYFtQCd3K6jkyoMc9TGt3Ux
         vHWw==
X-Forwarded-Encrypted: i=1; AKwUvBxUIkWIb3MPpt2YP9f4UfZjoUhg6IOp0feO83EGTYqSy2LrkLGHy6CnmiPttSSFXSPXVmGAnIw=@vger.kernel.org
X-Gm-Message-State: AFuF++mF0LmIwOYWXvyMzqGkimU3T6pSjTNMusUcJnmzYG1w3UDufVNl
	Dx1cmaB0KOFdLbCcp1XPNF+Hu3qz346j5T7aTW0ZIYnuCWabpBwGBjwk
X-Gm-Gg: AYBFou2r6CNpjftM1WewBQg5qbCHU9RNxFNKHnRAP0x/8t5wnLzbqu7FOk091RganDG
	e3elz4ssWHPcTwmkya6t9kEPuzNrSIoP0Ypya0tiHxUVoL5/MqGN1WxynDdrVUEI6sTwJB+Sl9w
	jGFmVRufJeEXKRR9yY+RJAt1CT+FqJDIlvUpnfxKoOIhTUz+mj0PN9x8h7KhTXSyr6cpJG3czHl
	ncGwxLf9ldOqCiqiB3KYz7DLQ1pVLSyhxYXOEgQp+VC7Q6735XiWINjHrF+7xbDfVpLXdcFjgQZ
	vpkuosBOvo23C65c3tf0DdKT6JxDzXIaQu7iyDq37bdWfdTpP0L2if+H92jk5BvgXWZQWZWiV4w
	Ep3TjQtAnvUZu77dYadQE+I5pL+9P+CBR/TJ7MBl2GDCBHrWmKX7f0uOSBVu/Agf5yNwPetA9IA
	xhcz+eh2feEco4oq0jz3h3qV/LGKM7zgqEKow+Lcc/btHtVDxI3setLK3Fap0qv/Db80Y=
X-Received: by 2002:a17:90b:2b8c:b0:398:9be6:f995 with SMTP id 98e67ed59e1d1-39b262aaf48mr51243967a91.20.1788908261877;
        Tue, 08 Sep 2026 15:57:41 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::6:91c1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-143243f780csm35210942c88.13.2026.09.08.15.57.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 15:57:41 -0700 (PDT)
From: Zinc Lim <limzhineng2@gmail.com>
To: alexanderduyck@fb.com,
	kuba@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	linux@roeck-us.net,
	horms@kernel.org,
	mohsin.bashr@gmail.com
Cc: kernel-team@meta.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	zinclim@meta.com,
	limzhineng2@gmail.com
Subject: [PATCH net-next v3 1/6] eth: fbnic: move sensor read logic out of fbnic_mac
Date: Tue,  8 Sep 2026 15:57:32 -0700
Message-ID: <20260908225737.3034403-2-limzhineng2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260908225737.3034403-1-limzhineng2@gmail.com>
References: <20260908225737.3034403-1-limzhineng2@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sensor read lived behind the fbnic_mac get_sensor op, but it is only
ever used by the hwmon subsystem. Move the read into fbnic_hwmon.c and
call it directly there, closer to where it is used, and drop the
now-unused get_sensor op from struct fbnic_mac. No functional change.

Signed-off-by: Zinc Lim <limzhineng2@gmail.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c | 56 ++++++++++++++++++-
 drivers/net/ethernet/meta/fbnic/fbnic_mac.c   | 55 ------------------
 drivers/net/ethernet/meta/fbnic/fbnic_mac.h   |  2 -
 3 files changed, 54 insertions(+), 59 deletions(-)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
index def8598aceec..6c8c66ab86c1 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_hwmon.c
@@ -28,15 +28,67 @@ static umode_t fbnic_hwmon_is_visible(const void *drvdata,
 	return 0;
 }
 
+static int fbnic_hwmon_sensor_read(struct fbnic_dev *fbd, int id, long *val)
+{
+	struct fbnic_fw_completion *fw_cmpl;
+	int err = 0;
+	s32 *sensor;
+
+	fw_cmpl = fbnic_fw_alloc_cmpl(FBNIC_TLV_MSG_ID_TSENE_READ_RESP);
+	if (!fw_cmpl)
+		return -ENOMEM;
+
+	switch (id) {
+	case FBNIC_SENSOR_TEMP:
+		sensor = &fw_cmpl->u.tsene.millidegrees;
+		break;
+	case FBNIC_SENSOR_VOLTAGE:
+		sensor = &fw_cmpl->u.tsene.millivolts;
+		break;
+	default:
+		err = -EINVAL;
+		goto exit_free;
+	}
+
+	err = fbnic_fw_xmit_tsene_read_msg(fbd, fw_cmpl);
+	if (err) {
+		dev_err(fbd->dev,
+			"Failed to transmit TSENE read msg, err %d\n",
+			err);
+		goto exit_free;
+	}
+
+	if (!wait_for_completion_timeout(&fw_cmpl->done, 10 * HZ)) {
+		dev_err(fbd->dev, "Timed out waiting for TSENE read\n");
+		err = -ETIMEDOUT;
+		goto exit_cleanup;
+	}
+
+	/* Handle error returned by firmware */
+	if (fw_cmpl->result) {
+		err = fw_cmpl->result;
+		dev_err(fbd->dev, "%s: Firmware returned error %d\n",
+			__func__, err);
+		goto exit_cleanup;
+	}
+
+	*val = *sensor;
+exit_cleanup:
+	fbnic_mbx_clear_cmpl(fbd, fw_cmpl);
+exit_free:
+	fbnic_fw_put_cmpl(fw_cmpl);
+
+	return err;
+}
+
 static int fbnic_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
 			    u32 attr, int channel, long *val)
 {
 	struct fbnic_dev *fbd = dev_get_drvdata(dev);
-	const struct fbnic_mac *mac = fbd->mac;
 	int id;
 
 	id = fbnic_hwmon_sensor_id(type);
-	return id < 0 ? id : mac->get_sensor(fbd, id, val);
+	return id < 0 ? id : fbnic_hwmon_sensor_read(fbd, id, val);
 }
 
 static const struct hwmon_ops fbnic_hwmon_ops = {
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
index 53b7a938b4c2..fba2e2efaeb8 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.c
@@ -899,60 +899,6 @@ fbnic_mac_get_rmon_stats(struct fbnic_dev *fbd, bool reset,
 			    TMI_STAT_TX_PACKET_9217_MAX_BYTES);
 }
 
-static int fbnic_mac_get_sensor_asic(struct fbnic_dev *fbd, int id,
-				     long *val)
-{
-	struct fbnic_fw_completion *fw_cmpl;
-	int err = 0;
-	s32 *sensor;
-
-	fw_cmpl = fbnic_fw_alloc_cmpl(FBNIC_TLV_MSG_ID_TSENE_READ_RESP);
-	if (!fw_cmpl)
-		return -ENOMEM;
-
-	switch (id) {
-	case FBNIC_SENSOR_TEMP:
-		sensor = &fw_cmpl->u.tsene.millidegrees;
-		break;
-	case FBNIC_SENSOR_VOLTAGE:
-		sensor = &fw_cmpl->u.tsene.millivolts;
-		break;
-	default:
-		err = -EINVAL;
-		goto exit_free;
-	}
-
-	err = fbnic_fw_xmit_tsene_read_msg(fbd, fw_cmpl);
-	if (err) {
-		dev_err(fbd->dev,
-			"Failed to transmit TSENE read msg, err %d\n",
-			err);
-		goto exit_free;
-	}
-
-	if (!wait_for_completion_timeout(&fw_cmpl->done, 10 * HZ)) {
-		dev_err(fbd->dev, "Timed out waiting for TSENE read\n");
-		err = -ETIMEDOUT;
-		goto exit_cleanup;
-	}
-
-	/* Handle error returned by firmware */
-	if (fw_cmpl->result) {
-		err = fw_cmpl->result;
-		dev_err(fbd->dev, "%s: Firmware returned error %d\n",
-			__func__, err);
-		goto exit_cleanup;
-	}
-
-	*val = *sensor;
-exit_cleanup:
-	fbnic_mbx_clear_cmpl(fbd, fw_cmpl);
-exit_free:
-	fbnic_fw_put_cmpl(fw_cmpl);
-
-	return err;
-}
-
 static const struct fbnic_mac fbnic_mac_asic = {
 	.init_regs = fbnic_mac_init_regs,
 	.get_link = fbnic_mac_get_link,
@@ -966,7 +912,6 @@ static const struct fbnic_mac fbnic_mac_asic = {
 	.get_rmon_stats = fbnic_mac_get_rmon_stats,
 	.link_down = fbnic_mac_link_down_asic,
 	.link_up = fbnic_mac_link_up_asic,
-	.get_sensor = fbnic_mac_get_sensor_asic,
 };
 
 /**
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
index 10f30e0e8f69..bde2daa65645 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_mac.h
@@ -137,8 +137,6 @@ struct fbnic_mac {
 
 	void (*link_down)(struct fbnic_dev *fbd);
 	void (*link_up)(struct fbnic_dev *fbd, bool tx_pause, bool rx_pause);
-
-	int (*get_sensor)(struct fbnic_dev *fbd, int id, long *val);
 };
 
 int fbnic_mac_init(struct fbnic_dev *fbd);
-- 
2.53.0-Meta

