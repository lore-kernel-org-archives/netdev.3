Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DB53D7D9B
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 08:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787213484; cv=none; b=tZG01Fcyj0RQwwuIYpBjzO0uFvjqsczdDySiO2JThVAAu+2t/Fl6Y4+u6HTPk5khHVFg3mwQxGUwu25gg2S7n/GKspqH3rFAZzrZ/spLOkZ25R0ehensaRmIX0vm9dQHLoT6I1y/2KhSwUGa2fnaT9n/b6YMRf9/rQ0TPm5M7BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787213484; c=relaxed/simple;
	bh=P6E2uzQS5N8TocTbhrbiyXllvRLrFmbikO030oY/FOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pSwU7f1Ff5NIOy7xrYUow+PjjV7sOnJVLcK6dxhWcBgzUmd5NgnZky2m/pfl5SE28RiySmV1FbixU/4VXz/bdTNedbRc/WHytepsVoQc6y9MpBlSaoDIcA1Mct1zZAk8GsZO1w6x3fbnMQq17v8UTXzWLTt2y1yKu7rGK7sY56I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=pVM/brkA; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="pVM/brkA"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso2337831a91.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 01:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1787213482; x=1787818282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MB8m7xPk9xDED44AnOKc9Q8QGPIxLYopBtCaEAuCkz4=;
        b=pVM/brkArLGuoxX+rqJ3q0l6rqA2h7QWIzhlyWghEKwbSNMVRWPDYtp3rZKFiREbQQ
         rXjck8w0u+fHaoSpcJM6BRm6J8zy17CfBoQAgnIrzjYlnDD/MUC7MScA5GoiwNpZBcIv
         uK77cdRMt2m2545VQrkqGwCOw64FCuoW3YLbTOtfwpcvca33HLF5RbEM7aiKNZlrMRxZ
         OerpoxxcNY5Fx99K1gUAnmjo3O1FtpqyO8Lrpzw4QFDGeONPusxU1MKTFDa6G+S5atZ4
         ozivOYCSo0Oc/KPo1vDDYj5ylEvJvjB5KIXtbr6e5VN+m+aYsMoLbdq/ix5fyUyzj52U
         bxMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787213482; x=1787818282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MB8m7xPk9xDED44AnOKc9Q8QGPIxLYopBtCaEAuCkz4=;
        b=HmMBHhq9YVcqVkVSsooUzv5jnjW+g6FEUNMfnM3VifHydOZuuaPEep+PGAJDeSbrze
         rWQS7LZGHPxMIB5xVO2SfTk8QAud+gG8Jwji169aXj5Fid3D7b8to+kUmA8dL6AHuUXu
         vcClt/uHKkzUjjWRCFVGdCfYOoZQkg3vATY2igxgwjgXaQXaWVmJ+nsmGPGgwmBPvaRe
         Rf2nSb3pZCcbBb1cGXlRP7Os57ju2YKE4IHiIfwbsw3fTDtwv2OaOF7WMfGjAfFXIJuR
         Bn4PVCxTMXnFhQxQ/9vB7ljapoqrkmBXxvPBQ7lNOyDsow1vSkp+ddPLgdDsSlns82kl
         fYuQ==
X-Gm-Message-State: AFuF++mg0QAnbtYyvBlGDXO1Kp+UIeR7wQQvE2HSs29dY/FkhaS+u0T/
	CONzBNbR1pwW1rjfmzxWn+8BdKd9LossE5isNRzM8oHOA7xq0H1smPBP07RlZLQ5pQ==
X-Gm-Gg: AR+sD10Qm68S9sLoQKkUJTUYiFeDMhX3QLL93B2ztmRzE0rd4rVcwkLlFv9Sj61x+gF
	xaBiv5AFP5Y/TbkwlL7mjw/M9IG3GyT4moK1kqu+O9JLxd3T9PRoE+LLw6G56gCC35NkK3+GP0L
	zycRaPh4rfPk5fpt71Mpm6VCZpF+/7umlXI2MUXM+izL+HeWuP7cYDUGGTNmD3eUTx8C4rj449I
	JDPatIM87m8Y4g9CtTWIUIM/dg1/gQQcEjN6+fVWHGqAAcJuwXIUBdEVWfh/kUG8nkLxjrlug3r
	tz2jKJNuhI5XuJJGZDAXrrsauoymONPsFol/kwCqC2NEqpplcgYSEO2iGKyyuTmy3DLBDgRtYu9
	cfHE6sCM3mg7/zZZ4DF/zl1oCAQuFngL3OLVQKNvTFv8goCdqBBUqYW3tZra0MjAcdgQ6MlS2R5
	onvlCk7iUK3vf2pMZ9reExBWiR2ttAWDmPG/Vh6Fsh8CBGtqLEy5cHjK/n+5uu+eqkenW5XzSbD
	/XGZxHwpee6H+2y7Foi0Z3k9rlkDoWP17PD/Ka2RnjXiA==
X-Received: by 2002:a17:90b:1d49:b0:38e:9045:babe with SMTP id 98e67ed59e1d1-39580eade6amr21409224a91.7.1787213482156;
        Thu, 20 Aug 2026 01:11:22 -0700 (PDT)
Received: from xps.tailc0aff1.ts.net (149-169-99-5.nat.asu.edu. [149.169.99.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327bef7a0easm16870891eec.12.2026.08.20.01.11.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 01:11:21 -0700 (PDT)
From: Xiang Mei <xmei5@asu.edu>
To: Subash Abhinov Kasiviswanathan <subash.a.kasiviswanathan@oss.qualcomm.com>,
	Sean Tranchetti <sean.tranchetti@oss.qualcomm.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+4638111fe2a12980@bugs.sh,
	Xiang Mei <xmei5@asu.edu>
Subject: [PATCH net] net: qualcomm: rmnet: set skb->dev for deaggregated MAP commands
Date: Thu, 20 Aug 2026 01:11:11 -0700
Message-ID: <20260820081111.1586932-1-xmei5@asu.edu>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rmnet_map_deaggregate() allocates each sub-frame with alloc_skb() and
leaves skb->dev NULL. __rmnet_map_ingress_handler() assigns
skb->dev = ep->egress_dev only on the data path, but a MAP command frame
is dispatched to rmnet_map_command() before that, so rmnet_map_send_ack()
runs netif_tx_lock(skb->dev) on a NULL device. An unprivileged user
reaches this by unsharing a user+net namespace, creating an rmnet link
over a tap device with INGRESS_DEAGGREGATION and INGRESS_MAP_COMMANDS,
and writing an aggregated frame carrying a flow-control command to the
tap fd.

Assign port->dev before dispatch: the command was received on the real
device tracked by port->dev and the ACK must egress on that same device.
The non-deaggregated path already has skb->dev == real_dev.

  BUG: KASAN: null-ptr-deref in _raw_spin_lock (kernel/locking/spinlock.c:158)
  Write of size 4 at addr 00000000000004b4 by task exploit/144
  Call Trace:
   _raw_spin_lock (kernel/locking/spinlock.c:158)
   netif_tx_lock (net/sched/sch_generic.c:497)
   rmnet_map_command (drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c:67)
   rmnet_rx_handler (drivers/net/ethernet/qualcomm/rmnet/rmnet_handlers.c:125)
   __netif_receive_skb_core.constprop.0 (net/core/dev.c:6103)
   ...
   __netif_receive_skb_one_core (net/core/dev.c:6214)
   netif_receive_skb (net/core/dev.c:6474)
   tun_get_user (drivers/net/tun.c:1966)
   tun_chr_write_iter (drivers/net/tun.c:2012)
   vfs_write (fs/read_write.c:687)
   ksys_write (fs/read_write.c:739)
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  Kernel panic - not syncing: Fatal exception in interrupt

Fixes: 378e25357ac7 ("net: qualcomm: rmnet: Remove unnecessary device assignment")
Reported-by: co+4638111fe2a12980@bugs.sh
Closes: https://lore.kernel.org/netdev/ijg79FFMfIvKJbivdJEKvTO90Q9dTvyBkJck@bugs.sh/T/#u
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Xiang Mei <xmei5@asu.edu>
---
 drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
index add0f5ade2e6..3944925566fc 100644
--- a/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
+++ b/drivers/net/ethernet/qualcomm/rmnet/rmnet_map_command.c
@@ -79,6 +79,8 @@ void rmnet_map_command(struct sk_buff *skb, struct rmnet_port *port)
 	unsigned char command_name;
 	unsigned char rc = 0;
 
+	skb->dev = port->dev;
+
 	/* Command data immediately follows the MAP header */
 	cmd = (struct rmnet_map_control_command *)(map_header + 1);
 	command_name = cmd->command_name;
-- 
2.43.0

