Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3BA3803C5
	for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 17:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787593866; cv=none; b=Q0tY8FdGf60pbA7DZ9yITKF3mYlVN5yzS2ft2v4Ei7Z3u8FNmNUrl4SaLQ/WqK/aVwvqe4QVOUUkVA6+u+HqFY0HevXN/LkgJd6XQsO0+/I6RDaiYrIhS5b9zkAHlH5+GFb7UgvIcibL4xoDH/obRor9SU0FbDTZgl9BjzoKeRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787593866; c=relaxed/simple;
	bh=Vi3BmT7ZDkiqyokg+wo6JFBFy7A29xrg2kuZJqXCm60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ND3ESDZMl1pP3uCA0GrUinMBZKLu0hZDe0ihQv9d37qVfKE7WVaXIKfmvtls+cFd+1iO4XINZQ4v542GfMxa3wibVyPF++MT02ePf1kQIc4qWCMXfbuJowdhmoYROj1b/hANsBXHkFVwBsGt3Axw898FRLphPxI++LITVjHqHV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LiupDtPl; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LiupDtPl"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-cc16c6dcae2so3554499a12.2
        for <netdev@vger.kernel.org>; Mon, 24 Aug 2026 10:51:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787593865; x=1788198665; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sfnOswr7eo1XQosDaF0vBD6HXJXxp8BEfMaGl2218a4=;
        b=LiupDtPlmaE69qlJIwKRyViHHcNI0rXof9dDweopa0kvNjbRV/tzMqMbFSV80tmCiV
         dxHC15G8jy4c1xHX17ZY1IYT4F+6zWGAlkYTKj2LFPirTEVgwUV+QeymbDwuZiZ5Fa30
         ZHCBKAPxgMB4Kwm9qy6A7Rp4IF11p/s3h3rUBpNsoND6zm5udB1wKCLUOGRe+2LFqjPx
         wgw8eOSIQNdmbWRyJ/lMQwWqonTZ1BeYYHTCx6Jb8IjhDYLrrOPl8vPBuZAG5CfbXH5B
         GTo/373URFUGVrVG4p+N7M+SkOQYv1qiT7Qr5tFpwSwcc2unX3CNB4JIr32zvrqKPUQV
         k2AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787593865; x=1788198665;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sfnOswr7eo1XQosDaF0vBD6HXJXxp8BEfMaGl2218a4=;
        b=lpa7mKmQDz6rh2Pxy6715QhNyzMjXvMhq1pcWHZsaHXsyLHBHF4nYQmZx8K+LXzFxq
         vsZtrRkZKrvfU41bSibEk0/KOGRBI63abSKlvtfOseAAMigG/eqixopdiTkXsMEZ0LmQ
         rL86mi29BwhmGeS66aY+B2Gh948MOsL8JcA7dj6GIXF+E71MUYOx+InObEloM7AyHFSA
         8AAuHnEQdB45qBLiENOl54alD4DPj1bTp0cAKb5G4uqAmjc24yW2+zM38mXLVuGXZCFg
         0NPnTSlAlI7QB4mAp0XYSCofhlUj4+tWvCv80WYLjQrioHJITCrDdzCgHNp/Zau45bPA
         KHpQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpu09ca6foZFMlxZlYYVFFn7WbFjjcJGIF7YpNNyE8QtzNzwEwpFIuh1TRnKG783G782nyiouY=@vger.kernel.org
X-Gm-Message-State: AFuF++nhIiEDaXXQozoWnhSdVy3iX87GOyJY6Wb/UsHACuSHd9EMoC8E
	ifwGN+1Lg82O2DipjNYHvDKh4eACse+YfuLq833BAjIZIv/C72hB+7zL
X-Gm-Gg: AR+sD13AE6UNbKzrfdAfWEslov/sTIFpS1EIwfRBhfmej8tAvdApltvjJj+d8hBKvmI
	r+HD3nUfIon5228oplJtnJ7f5Nvx/QqNw8tvy4ZavfELl0rHO5duff0sBIkLtcuA+2P5TnFrY9D
	9O9uYpY7gNNagV3PeOq8fWfjw7cLiYqBKk2W4Qeonq0eekMQpxibzVT7OppXolihJAsBfVmtJQx
	AGnBaafnfHrS+ai09v4JnmT0lrJ3JRw9mm/cwRI268mzjVIsc8gCYo3vaxxz5DtG9k87h4aZVKj
	YBNpNZuJlefgxRSeQc4V1Y9V8hy9NXUQiAizIgPrx6avngsR1PPPdOzP9qzU5SmZm0CBCxdYQQS
	6KqPlTj5yQ9mMmWoabx2+psZZWJN4NPatXbKQTB71x0gyel0TNZG3L5buFO+wi/6/aX6k+HRQZM
	0m2bjX4K/v3qP2LrgD/svzAMYQj0cVH14hV3iGPLfvET/D0TRwaLb8EqBzjqtQZYR6DUg=
X-Received: by 2002:a05:6a20:d529:b0:3bf:b182:94e with SMTP id adf61e73a8af0-3cd2fe47253mr59858710637.5.1787593864596;
        Mon, 24 Aug 2026 10:51:04 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::4:ddd2])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14186183c0esm41854731c88.12.2026.08.24.10.51.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 10:51:04 -0700 (PDT)
From: Zinc Lim <limzhineng2@gmail.com>
To: Alexander Duyck <alexanderduyck@fb.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Simon Horman <horms@kernel.org>,
	Mohsin Bashir <mohsin.bashr@gmail.com>
Cc: kernel-team@meta.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	zinclim@meta.com,
	Zinc Lim <limzhineng2@gmail.com>
Subject: [PATCH net-next v2 1/6] eth: fbnic: move sensor read logic out of fbnic_mac
Date: Mon, 24 Aug 2026 10:50:54 -0700
Message-ID: <20260824175059.2485048-2-limzhineng2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824175059.2485048-1-limzhineng2@gmail.com>
References: <20260824175059.2485048-1-limzhineng2@gmail.com>
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

