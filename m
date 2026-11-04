Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793815177;
	b=M6U9yiEgiJS77fOwzGSGWhFyfFtd/GgCPJuapqXyrdsAi9c0yxYM2J9E37hLTi/zM9x7
	 2Omt/C1bH7pHC8qLhwwM6B3fbtoK71hVPw0tvnUltLjYqT9Dple7WjiZIi4YVWvIESAFU
	 Mab2ztXULApBcB4TcEyccBIOynAgb6SQZI/6qXEqdMnefQpz/58cwf5nrUXAxst0Ph7x8
	 t+NGcwXmWXW7kLBXbrIzlgN86gn9DpmHgnrsdePNliqDdaIrf3SdPwU7ODL7tEEVSTmyd
	 52Yps4+JmwI6p20Qp8O58YkMAMiCOAZhe2xjP+CtZs64xwkJi2nLUbn+mqwp6jf1t6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793815177;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Subject:From:To:Cc:
	 Date:Message-ID:In-Reply-To:References:User-Agent:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=e4nHy+K5oryhprQG9Gu5JRUGcNvfAn2s5nlbyb3Rin0=;
	b=Sl2cZPd6kxiyi0H6Ch25jAF58rmNJb4AQxkrNTlvSHn73g0WmOKTMHfWuWjEFFiB04T0
	 diYbRKSxpq8y5+xT4JhEVt7OwQyerKAnITqEgY8dkX2D0LppdPHpdl91Hq/Yik9b5N7dm
	 Z/vOviKvOCNfNDPqpJcYxw18L/OpcuC18THdN7LVR02/jvmG75E7hCWy5Dia8hiELkztG
	 nRS/jhIPRBZnGU3ievgn9niWG30Jj6Ues3Fx+BFolP0WE3KRB1Ts/4cGWP7ce1eezN5bf
	 akChYIvb1qpmDacYInoG0D3pV8K11p3D8Y6Pi5R8N0GXxOZASUb6IhTHP0PT64LDA1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iZ0uuZH9;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4D5606B0AF
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 17:59:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AB4D5606B0AF
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iZ0uuZH9
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cc4dbda1e5dso418000a12.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 09:59:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793815176; x=1794419976; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=e4nHy+K5oryhprQG9Gu5JRUGcNvfAn2s5nlbyb3Rin0=;
        b=iZ0uuZH9krn/5x+l1DLBrAUmpNVHCMbjpjp+A+JL9M4JyiZRC5T1oOIyy9geA2Veun
         V+z56fBqjCn2nLlGUFxHfGD3SlxJvXA/Fy6npwV37Y9FjHC62MoaNuJOt8/Gi4MYeJVv
         z54X30yAZni8yPXKS5eWKgWko2lPs0RG+auPjM5yW8WVipfaJEYen2k5rC82tZCIGVX3
         HzEZm08fa1w/HfBUKf4FgqVCIbUASVTi7FWFUv8+ndQWP5/quV15vp05zJiRxxBXJO0F
         Jl5VdfTiKYEt4rgRRPhNijoxS1W3HFE65J5aCNwfUk2CVdI+UfrRN+Ortz1Al9nyaHRG
         gecQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793815176; x=1794419976;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :references:in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=e4nHy+K5oryhprQG9Gu5JRUGcNvfAn2s5nlbyb3Rin0=;
        b=agsYz+zklN8ow7BnSThpIo6pgsGRGd4IPHFUnSNX15GIwWf+gfUN4NTfTbxomsKsjD
         j3PAC1EfH/KL9QYjRIeTt3NA7HIdmUFcAN8bocZYHOBlIalHKsdLD/vZczjRSteFKHu9
         gqHWUVzpLxUqYatLaEQ5S07ZfSnZ4l7apeWLknbronINkf1x9C2hh8kRKyetKXEpTtbu
         8XJnZ8s2mPuiQ8DC8XKCrena5r3dhMOTmOn2c9PtlMKyZ75FwVuE5megsdr+bYlWgiWg
         i9f4PzSpM9TSX/FY9J8yLnhBdrn9FObayaE1yBODgXDGrUN8U3jOORsDDLsNHBES3L6p
         esxA==
X-Gm-Message-State: APuU4Z+RMWMqNw5Rv5oy4pVUpLRigGx3Nidm+imwvBFGt0FSmH4U54r/
	i355X4B6JZ4Jh4IrN0AzcOAZEP9udc97FeFIwhQRMZt3ulFgdT25rpUjrx467Q==
X-Gm-Gg: AYBFou1L3jr/arPNXeebCs60wmW7dqnuQ4R9JTB1R8dNCrZmC0YfCk1SOGhLmuFqFtE
	fBTEkV5tkktYxxNhBvP6g636MOWHV1XnaC/qq2AXh/titd3qd6SatMNGU7H4rtx0V6l2NFmj26g
	qVsmYQDQiz72uTsrPRRpZTlgjtlIWGe+YYaOickRbB232nGLXME38xDL8cWvwnwZOm3bx/r00yD
	UlLnGrvl4paf50Qm4hvnP5RYVQd29M28E3IaAY3Vb9nl0SOcJpFSMqYqQcxHyOIfmdnPD3d8ONX
	fyo56daeJM+AOnqqTA2ceZOAOauHqaAZWnXetV7/QkalsCK8xKF/wbCQX931kgigzc2TeHpZFJR
	EB6hTVuDQYS0WQZMz8+p+3A6cxEVuFrsx5cIkAS94Ykz7JWkTMHELOdietofRpkzKsFkLKRY09c
	wEA39IgLbBtYTWMQf5cxxCHqSmr1Fe4ZySBQBSDZEot8/bD2TqB8hHhp9BbQjxUEm7wSDzIjkwC
	8xD1RqyG8TN3Lm/msKI8Mzj4ic1xUU7CwzWWJt9LPedqRQOcfcV8GXsmqvX2eM3psxCCdkfzOWf
	8ndOWDaIRGgOLvbb7o7ubK1pACYX5lG0I987tzl9eVTe7fTIN3QlH9kN+9xags331hbBz42bEAw
	ATdkWElJaXEo0XQq5pfX8WP9HzmKi6/KOROyJl3EL9P3VGQ==
X-Received: by 2002:a17:90b:53c7:b0:3ac:7e3a:1033 with SMTP id 98e67ed59e1d1-3ae897c5e5dmr14219508a91.59.1793815175869;
        Wed, 04 Nov 2026 09:59:35 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c1:38c:400:22f5:2de:b9c3:f27c])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0b31d2b5esm35401a91.15.2026.11.04.09.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 09:59:35 -0800 (PST)
Subject: [net PATCH 5/5] fbnic: Wait for the outbound flush to complete on
 mailbox teardown
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 horms@kernel.org, kernel-team@meta.com, kuba@kernel.org, pabeni@redhat.com
Date: Wed, 04 Nov 2026 09:59:33 -0800
Message-ID: 
 <179381517319.9644.1165591016149104577.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <179381496288.9644.9775319757787890210.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <179381496288.9644.9775319757787890210.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

The fbnic_mbx_reset_desc_ring function drops bus mastering and arms the
outbound flush for its ring: the write flush for the Rx ring and the
read flush for the Tx ring. Nothing waits for that flush to finish.
The fbnic_mbx_clean_desc_ring function goes straight on to unmap and
free the ring's buffers, so a device read of a Tx buffer, or a write to
an Rx buffer, can still be outstanding after the buffer is gone. With
an IOMMU it can also target an IOVA that has been unmapped or reused.

The PUL link reset status register reports when each direction's flush
has drained. Poll the done bit for the ring's direction after arming
the flush and before freeing its buffers. The flush only has to retire
what the outbound path already holds; the 1ms cap keeps a wedged device
from spinning.

Every caller of the fbnic_mbx_clean function runs with the datapath
already down, which matters because the read flush covers all
outstanding reads, not just the mailbox ones. A device that has lost
its link reads back as all ones, so the done bit appears set and the
poll ends on the first pass.

Fixes: 3b12f00ddd08 ("fbnic: Gate AXI read/write enabling on FW mailbox")
Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/ethernet/meta/fbnic/fbnic_csr.h |    4 ++++
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c  |   16 ++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
index 414871a94104..c371ac9f78c1 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_csr.h
@@ -956,6 +956,10 @@ enum {
 
 /* PUL User Registers */
 #define FBNIC_CSR_START_PUL_USER	0x31000	/* CSR section delimiter */
+#define FBNIC_PUL_USER_IP_LINK_RST_STATUS \
+					0x31030		/* 0xc40c0 */
+#define FBNIC_PUL_USER_IP_LINK_RST_STATUS_AW_FLUSH_DONE	CSR_BIT(7)
+#define FBNIC_PUL_USER_IP_LINK_RST_STATUS_AR_FLUSH_DONE	CSR_BIT(8)
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG	0x3103d		/* 0xc40f4 */
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH_MODE	CSR_BIT(20)
 #define FBNIC_PUL_OB_TLP_HDR_AW_CFG_FLUSH	CSR_BIT(19)
diff --git a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
index 49b8813a3564..e00d626f6438 100644
--- a/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
+++ b/drivers/net/ethernet/meta/fbnic/fbnic_fw.c
@@ -7,6 +7,7 @@
 #include <linux/dev_printk.h>
 #include <linux/dma-mapping.h>
 #include <linux/gfp.h>
+#include <linux/iopoll.h>
 #include <linux/types.h>
 
 #include "fbnic.h"
@@ -176,10 +177,25 @@ static void fbnic_mbx_unmap_and_free_msg(struct fbnic_dev *fbd, int mbx_idx,
 
 static void fbnic_mbx_clean_desc_ring(struct fbnic_dev *fbd, int mbx_idx)
 {
+	u32 flush_done, val;
 	int i;
 
 	fbnic_mbx_reset_desc_ring(fbd, mbx_idx);
 
+	/* Arming the flush only starts it. Wait for the outbound path to
+	 * retire the requests it still holds before the buffers they may
+	 * target are unmapped and freed. A lost link reads back as all ones,
+	 * which ends the poll on the first pass.
+	 */
+	flush_done = mbx_idx == FBNIC_IPC_MBX_RX_IDX ?
+		     FBNIC_PUL_USER_IP_LINK_RST_STATUS_AW_FLUSH_DONE :
+		     FBNIC_PUL_USER_IP_LINK_RST_STATUS_AR_FLUSH_DONE;
+	if (read_poll_timeout_atomic(fbnic_rd32, val, val & flush_done, 2,
+				     1000, false, fbd,
+				     FBNIC_PUL_USER_IP_LINK_RST_STATUS))
+		dev_warn(fbd->dev, "Outbound flush did not complete: %08x\n",
+			 val);
+
 	for (i = FBNIC_IPC_MBX_DESC_LEN; i--;)
 		fbnic_mbx_unmap_and_free_msg(fbd, mbx_idx, i);
 }


