Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA7337189C
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 21:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788211363; cv=none; b=SzZWtfd//FkTRyhsLyCxSCsL3Vh+d5qeZ04m6YEcsMBvDXSq+vmK2StpJbBGHTqaDRJ0se9gSSAxJhTZsyT47O+YQ6F31gO0wUvk3JLHsiKmvhQeKt8iqg+AKQjxdhJSZITnXG1p0iqdpTaRumIWQZ/a/OEC/VDzg+sYSk/e9vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788211363; c=relaxed/simple;
	bh=Vi3BmT7ZDkiqyokg+wo6JFBFy7A29xrg2kuZJqXCm60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKChO//t2Vgbb0sAD57+9MEp8MdGNvEgyBBcR9bersY78WT2PTG7u0kq77cQwZMPzAzkSP2KmOrWirz1lEASSCe+FulfKDAyBmg61OIGuxwlIJRynZq8Ot/8tRSLI3VjN3CQXMbXXRQW71VrhIC28kdQBosOEWU6127bASaL+1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cg0VjcUA; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cg0VjcUA"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc11a905ba5so209424a12.2
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788211361; x=1788816161; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sfnOswr7eo1XQosDaF0vBD6HXJXxp8BEfMaGl2218a4=;
        b=cg0VjcUA3pLPu9JrlwsAekoYNmHvnS0VVpBiV1/xrFmBYrEcnPOHo03hjd5HelaJ0S
         o9FZJo3zHuyFJXGLfOXLgpmA5mSV7ShPfsuCkrXX4lRkUoMTlBGxw1z/bPlBcRW7Oyao
         HhG8hN/6G8FI0vfjq2cdykgX/lxyLR+fELXxiztq6breemxMQRZ60Qk0WKLcjhZQle4Q
         nsW/XgmVuDXdLgFhG3tOEp6vkEC8+ig5sWCd0xSw3r2y6ZrZ2Bw60rv/rFKZhx2QEFzB
         N25fRIYj6gNYEOs4S1gEpb7yf2tnZydx0Zr73z3SRKKjz0nicu4DmJhCGC/6Cr6mPGnV
         +oJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788211361; x=1788816161;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sfnOswr7eo1XQosDaF0vBD6HXJXxp8BEfMaGl2218a4=;
        b=sIe16Gje5dHL+Uypsf3W5jbMcuA2dRXIvtoDLI++sQVtkOiNhv5GsqmhXSYM0FsIg/
         xgAI3SVS/Ze/oPfH9yvm1B+uTBzT9yHBH8H6K4fq7UHMsqVhpIav7nvD7TobXBU7y0tH
         vGjz+lU0XyyVRLfoYgey37R0X/5masVNCVUSpm1zKGOTUQwbw9ApiT/X99MpIjGFbVdv
         JbGwYlncs3WYWWGqEKl9euk+1fkjs7knOq2CtMHKxkL67I67ifCkvxw9XfCDbtUZQa8C
         MBnQiFB1i6Mv1XGuUTAFd7Xzj9te/nXtw/pw/nvswaVpw03hR82783ezbg/wWTSeKMlB
         vo/g==
X-Forwarded-Encrypted: i=1; AHgh+RoN094BYIhPYiHDhj6SgH0+sSAEX10j/NjqzEBghjTT6dfscnzHEgNqaNhCodBd+WwkXBRvEvg=@vger.kernel.org
X-Gm-Message-State: AFuF++lOm9RvsCjPZpwDUXQjHgN23diL5BFp6SG3M33TGlUiz4rGMQ0h
	XeEBzsNmrpqqFrWCl438jVKd+KqL8TQSfMoCxFRjw6Kx1yCrlm2PYIFs
X-Gm-Gg: AR+sD1215bOkQ99MJACmtrxBqVZ3Lc0Dwf16OendOafgzr/GYHmNTwAQSfJvFIV/vDe
	iYJOZR4J4DqERtsCCfyS826pFH6kV/QQeZLE+j/wakeW28LCjFrm9x8iY7hArrOH0MewU6DYxM4
	BpLyztxzp8EE5vSukLoBG3fwyQnJGcYA2S8iVAnbVI9j9EqHSeO+3YM7hAQ0/6yyk3QxpL2W9Pw
	NupqjMhnXzszaZzKF+Gyd2LaK2V3aHb/A0b6t4LiuSIWb3yx0mZPITAlxVi8540tgTzN4/LJ1J1
	Qy8lerQ3EAY8t9c5DmugLh7GfRmbhFKoT+X3cUrci1zpOR4SRr6FjzXt1Q9lVVDT2iSxKbD+CRK
	Fmq5ss2Od/3Hex4ba6sppAs58o67RRRijlKdmBSjqUTOHCTQAzgOZOpLtmFwiLpj15tZe4CXsj3
	IYkEwTGgZOQnamWBTO1DY2ZCLSq2ynaWtchDrxjZOmQS9zXXutPdPS3bX6MxotY6CAp+kROPdMd
	NI9eg==
X-Received: by 2002:a05:6a21:8901:b0:3d3:adbf:777c with SMTP id adf61e73a8af0-3d3adbf8147mr26713171637.24.1788211361126;
        Mon, 31 Aug 2026 14:22:41 -0700 (PDT)
Received: from localhost ([2620:10d:c090:500::6:bac7])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3286f9e2a95sm31080594eec.23.2026.08.31.14.22.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:22:40 -0700 (PDT)
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
Subject: [PATCH net-next v2 1/6] eth: fbnic: move sensor read logic out of fbnic_mac
Date: Mon, 31 Aug 2026 14:22:29 -0700
Message-ID: <20260831212234.1212971-2-limzhineng2@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260831212234.1212971-1-limzhineng2@gmail.com>
References: <20260831212234.1212971-1-limzhineng2@gmail.com>
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

