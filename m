Received: from out28-100.mail.aliyun.com (out28-100.mail.aliyun.com [115.124.28.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9778445AFA;
	Fri,  4 Sep 2026 09:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788515684; cv=none; b=Q8rlrDcJG9bPwc9G1WnAyRCjBz2V9epFxxyEcs2sDWTaGdjvvqY21uZuklIktZUzkXdWcZGj7qRIVSwyo4ia7pwZXJlC+uh9jjr66xFTdA+ToGFN82alOCf7nhP4w66L7zaY4wjnNw8OOOXNcwhnoDEnrjD8lSG1jcre3vEuv3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788515684; c=relaxed/simple;
	bh=mU0fFXdPTJbc3b/WLqHz1gd0VFk+jogC/ayuWKc5S7g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hPZ9kaAKRi8l5Dja4+wfetFJ9tHs6noe50hlw/YPUvkD9b9HzyLiiO6dRHSHkcwjd+223Azwo9Oucx7300AIi10vhvySLmBNI9gS+mVxeLxcdS8DlV0QEWxfhRqbr364v8Z3cUSofUuyFGhk12CKYaZWa+U+ekJ8jPd8WshTLCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com; spf=pass smtp.mailfrom=motor-comm.com; arc=none smtp.client-ip=115.124.28.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=motor-comm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=motor-comm.com
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.09302282|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.126401-0.00112462-0.872474;FP=11706182926721394356|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037026024;MF=kyle.switch@motor-comm.com;NM=1;PH=DS;RN=16;RT=16;SR=0;TI=SMTPD_---.j5Qgq5s_1788515677;
Received: from motor-comm.com(mailfrom:kyle.switch@motor-comm.com fp:SMTPD_---.j5Qgq5s_1788515677 cluster:ay29)
          by smtp.aliyun-inc.com;
          Fri, 04 Sep 2026 17:54:37 +0800
From: Kyle Switch <kyle.switch@motor-comm.com>
To: andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mmyangfl@gmail.com,
	horms@kernel.org,
	linux@armlinux.org.uk,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com,
	jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com,
	sijia.huang@gl-inet.com
Subject: [PATCH net-next v5 4/6] net: dsa: motorcomm: introduce mib_init to control MIB polling initialization
Date: Fri,  4 Sep 2026 17:54:14 +0800
Message-Id: <20260904095416.1692962-4-kyle.switch@motor-comm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260904095416.1692962-1-kyle.switch@motor-comm.com>
References: <20260904095416.1692962-1-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a mib_init flag to indicate whether MIB polling has been
successfully initialized. This prevents the driver from attempting
to clean up MIB-related resources on removal for switch families
that do not support MIB polling, which would otherwise trigger
errors or crashes.

Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>
---
 drivers/net/dsa/motorcomm/chip.c | 2 ++
 drivers/net/dsa/motorcomm/chip.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/net/dsa/motorcomm/chip.c b/drivers/net/dsa/motorcomm/chip.c
index f74a44048fb1..df5c0b995fde 100644
--- a/drivers/net/dsa/motorcomm/chip.c
+++ b/drivers/net/dsa/motorcomm/chip.c
@@ -4559,6 +4559,7 @@ static int yt921x_dsa_setup(struct dsa_switch *ds)
 
 		pp->index = i;
 		INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);
+		pp->mib_init = true;
 	}
 
 	mutex_lock(&priv->reg_lock);
@@ -4771,6 +4772,7 @@ static void yt921x_mdio_remove(struct mdio_device *mdiodev)
 	for (size_t i = ARRAY_SIZE(priv->ports); i-- > 0; ) {
 		struct yt921x_port *pp = &priv->ports[i];
 
+		if (pp->mib_init)
 			disable_delayed_work_sync(&pp->mib_read);
 	}
 
diff --git a/drivers/net/dsa/motorcomm/chip.h b/drivers/net/dsa/motorcomm/chip.h
index 65f9e6234678..6c89e3d304fa 100644
--- a/drivers/net/dsa/motorcomm/chip.h
+++ b/drivers/net/dsa/motorcomm/chip.h
@@ -943,6 +943,7 @@ struct yt921x_port {
 	struct yt921x_mib mib;
 	u64 rx_frames;
 	u64 tx_frames;
+	bool mib_init;
 
 #if IS_ENABLED(CONFIG_NET_DSA_YT921X_LEDS)
 	unsigned char led_duty;
-- 
2.25.1

