Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0547327877D;
	Mon, 26 Jan 2026 06:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769408589; cv=none; b=LodmbGSmqFFkrF8WC2tgyWcygI72JuqyModcyeyUK+futWBLhjtOeHgD9KGJZIfH5XetTxRPzptn9xf164e4z0q8haaE3vWv0Xxu4wfHz3x8tooJY0oa8eX8wHsC6rLJRNfvPkf3TOUVP0gA61bjJusvkLYR3PFuiQwEk7FsDD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769408589; c=relaxed/simple;
	bh=hPpGrhBm7dswjrLDv/THjvYEQrlbFx3TtA9jAFW1hNQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZpAOkaYfPfok+BEM8wKjyYB7Emn015AvdfH0HzQAY9cJzsgRDQJNxrCn7Uth2bFUzNRt5TVMKtE7SfxoeaG/zfi3Q4aJZwHOxIH4Kt16c0l+4/YozL0CMkuqhEPkwOb2QANaVDBpmugBjSWAMFc149pInvtOk6muo6RHSDKoR/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=bfP+VeGp; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="bfP+VeGp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=/4
	b01nswZlIsKdbMEMUcNlPloW0gjn+e2EWs/AY2u78=; b=bfP+VeGpXawUJ1U7qg
	Jm3JxskRS5QeC8yy1hMayXe2ucmppG65A7loKbkJ5M5e2MeOCJEqxIVWivEyMCmR
	L20w5FcKGqZ+1v+4knbDsfagFstECVUU0cxmKmVFL2U7AL4Qz1HhhYyju+PC5aOE
	7EX0NVO0M7xDgucwox96Nclc8=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id _____wCHzzkJCHdpL7kRIg--.5216S10;
	Mon, 26 Jan 2026 14:22:18 +0800 (CST)
From: Slark Xiao <slark_xiao@163.com>
To: loic.poulain@oss.qualcomm.com,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mani@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	slark_xiao@163.com
Subject: [net-next v8 8/8] net: wwan: mhi_wwan_ctrl: Add NMEA channel support
Date: Mon, 26 Jan 2026 14:21:58 +0800
Message-Id: <20260126062158.308598-9-slark_xiao@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260126062158.308598-1-slark_xiao@163.com>
References: <20260126062158.308598-1-slark_xiao@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCHzzkJCHdpL7kRIg--.5216S10
X-Coremail-Antispam: 1Uf129KBjvdXoWrKrW3Xw48Gr4fGr4kur1rJFb_yoWfKrgE9w
	1kXF9rJrW3J347KFsF9F13urWfK3W0qF4kXFnaqr9Yv347XFyfWw1kZF4Dtr9F9r17CF9r
	urnxWayFyw4fWjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRi4rW5UUUUU==
X-CM-SenderInfo: xvod2y5b0lt0i6rwjhhfrp/xtbCwBtApGl3CBt1MQAA32

For MHI WWAN device, we need a match between NMEA channel and
WWAN_PORT_NMEA type. Then the GNSS subsystem could create the
gnss device succssfully.

Signed-off-by: Slark Xiao <slark_xiao@163.com>
Reviewed-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
---
 drivers/net/wwan/mhi_wwan_ctrl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wwan/mhi_wwan_ctrl.c b/drivers/net/wwan/mhi_wwan_ctrl.c
index e9f979d2d851..e13c0b078175 100644
--- a/drivers/net/wwan/mhi_wwan_ctrl.c
+++ b/drivers/net/wwan/mhi_wwan_ctrl.c
@@ -263,6 +263,7 @@ static const struct mhi_device_id mhi_wwan_ctrl_match_table[] = {
 	{ .chan = "QMI", .driver_data = WWAN_PORT_QMI },
 	{ .chan = "DIAG", .driver_data = WWAN_PORT_QCDM },
 	{ .chan = "FIREHOSE", .driver_data = WWAN_PORT_FIREHOSE },
+	{ .chan = "NMEA", .driver_data = WWAN_PORT_NMEA },
 	{},
 };
 MODULE_DEVICE_TABLE(mhi, mhi_wwan_ctrl_match_table);
-- 
2.25.1

