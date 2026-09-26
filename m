Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CA533F5BE
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 09:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790413250; cv=none; b=G5Wa1Liq1VwKl39dtYxue9U4tsjlLY/IPCV+76E2pnXGaA3FyGFr0mBCFp/iLZWUPtxtIbiNNB7D8HPkoiDVpbhJtDtax04wGcOPHL7TFY+V9SRxUPrO1kLQscHOIIg51t+tetjL5tHK3YYb9KyCaSnIUHPrydJVUXjzQLEWn5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790413250; c=relaxed/simple;
	bh=4cRsFsDt6Up/vvP7T3bPTI/3VbP0v8lPFsiVG9KdPO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WrBkZwFMMygmVAdKmVnC932LPksdCJknHtixgOpDYefYZtpk60KQFcNLzj6kJF40hPCs6v8sLuzkwRUBC4X85dEGhOUwzjpe3LisfQxwr5syQOi6X7SO0AxCb2prakV2AOoudOeHpG8CKhU2OC8x+Dwpil1yoJXemtT4vF27laA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ao9tJSUY; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ao9tJSUY"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3411e0ace58so2016336eec.0
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 02:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790413248; x=1791018048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=quXvg9Bk9ON8ryc8ejCwrUBsOB74NdxZSH8xzj0H2yc=;
        b=Ao9tJSUY5UWrChQkjecfKzAHceCqAJqcHPHnVptM5/oPo7hZx/440Ym5dcchkSBIgd
         uEadDVepBbWQqRbGlqnydQanPqmDLG/7U126orBGJVJ2wSz9waxfUUho31eoA0wmi/Ns
         pXDb0L7hNzKh0GyhkbITJ68T+Zn7QnU7JvfmDJZztxoxjmFbhd2CkIhSK2xOmWXiYAm7
         QL8MxdK7vP23DAeuTSRBf2jJEljVtWj3z0Yih6o/gb7MDQogrkQlBeQCOzUDAJQzZCYd
         UpawKeDsMwYMkfQY73FXhPXsUweKZZbrngrFmvzlnLp2vju+gom7EArcQu8+Vl33ztpu
         sj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790413248; x=1791018048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=quXvg9Bk9ON8ryc8ejCwrUBsOB74NdxZSH8xzj0H2yc=;
        b=WXYKVVL2KxStII1L+B0dR+lBQfmS+WhdY9wKtEqNGOrG9MavTGXA1spJ3tWZLrvxam
         OOzaAbb8Dyhzzu/562Yuus4r4/v5ZhrYT6UoCwcoOxrNwVoO3gI30hqxz+g1xQaht6RO
         N+qmi4JtzPfuSkMEZdE3SgoOKwumXQiVD/hpN8ben/zv/sQnmHRK2+nK3wXszNSs7WoI
         z1wfK3uFDNX4aKqP4XX9klWMSrDN632M2tlHuCguNpp9hYlwG014z7Pm4QB7iBLyxswH
         KGUx14+NP7xeQf9aa+jlIAnMno05ZmqGnbJowiL26oP0mBUb2qSp0R66dBXeG+yXJjVT
         aa8Q==
X-Gm-Message-State: AFq9FYKwgJ4n6Lemi+cdjZETPFDJqCva0e4N+JCaYtFJlVtJPI4idyrI
	uFZIXf4WUpI3kvgjNsG5hEZWjy3xs07sWi6M5jnmTe44CzWqfUSnPPkw
X-Gm-Gg: AYBFou2H+YZE+It1RwRSkKnuI0aO78dARpfeyWNmWWGQzLhG7xiwp2Sw+p6TB0vD1z7
	mpOM66jOMnSlej8O0Xz6tcqLKkczCKEgDPoDkGs5E4khPtDorjLV00BbEJDIn+91mcPdE0niy4+
	kgWoYDsXAhnMdV4xQ97mBSPBa7Ufr+HQBfiboItHiRh9heO8uAHXuQJcYl56BNLkqUHHiUNxUko
	IPeasxdlWkr2sXlHhbPRewy8ZZHabsrMbTXsvoAh9y66iSbdj+hXwnrv4nAT+q5M13eIWnjiNcg
	mM+eKBJh7xQzgWGugKzIPEFC05KKJgCaaU+dVznXo6VLZt1ew4t/yR9DJl5M+97q6Koceg3l8wV
	UE7pop10rKUndrwXxgg6RP3WBQ81c67/sPGv+k+x+t2AH8GiCnI6VSZxFL2Cr8Xa7duYLta6eyb
	bzKPWgPFTFqutHrcRvyM8BCpd0//jnNX/Cvp0q3Xy1pzbMSbYNl4uKDn5me9S0AnGXCqcWAaa4b
	1ANswWfnIVUh2uj+6oBIBlHHhzQ0BL5
X-Received: by 2002:a05:7301:152a:b0:339:7c91:21f4 with SMTP id 5a478bee46e88-34273252770mr2697961eec.34.1790413247517;
        Sat, 26 Sep 2026 02:00:47 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34144173a2asm13336250eec.6.2026.09.26.02.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 02:00:45 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Mei <xmei5@asu.edu>,
	co+2cf741c3005abc20@bugs.sh,
	stable@vger.kernel.org
Subject: [PATCH net] net: team: stop reusing skb after queue override
Date: Sat, 26 Sep 2026 17:00:39 +0800
Message-ID: <20260926090039.1714460-1-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dev_queue_xmit() consumes the skb regardless of its return value, but
team_queue_override_transmit() treats a non-zero result as if no handoff
occurred.  An AF_PACKET sendto() can therefore make team_xmit() pass a
freed skb to another override port or the mode fallback when the port qdisc
drops the packet.

Report the handoff decision separately from transmit success and stop after
the first override port.  This preserves the existing success and drop
accounting.

  BUG: KASAN: slab-use-after-free in sk_skb_reason_drop
  Read of size 4 at addr ffff88800d5e979c by task poc/131
  Call Trace:
  ...
  sk_skb_reason_drop (net/core/skbuff.c:1220 net/core/skbuff.c:1249)
  team_dummy_transmit (drivers/net/team/team_core.c:502)
  team_xmit (drivers/net/team/team_core.c:1869)
  __dev_direct_xmit (net/core/dev.c:4990)
  packet_xmit (net/packet/af_packet.c:286)
  packet_sendmsg (net/packet/af_packet.c:3140,3172)
  __sys_sendto (net/socket.c:800,815,2281)
  __x64_sys_sendto (net/socket.c:2288,2284)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  Freed by task 131:
  ...
  __tcf_kfree_skb_list (net/sched/sch_generic.c:59)
  __dev_queue_xmit (net/core/dev.c:4353,4884)
  team_xmit (drivers/net/team/team_core.c:832,1867)
  __dev_direct_xmit (net/core/dev.c:4990)
  packet_xmit (net/packet/af_packet.c:286)
  packet_sendmsg (net/packet/af_packet.c:3140,3172)
  __sys_sendto (net/socket.c:800,815,2281)
  __x64_sys_sendto (net/socket.c:2288,2284)
  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
  Kernel panic - not syncing: KASAN: panic_on_warn set ...

Fixes: 8ff5105a2b9d ("team: add support for queue override by setting queue_id for port")
Reported-by: <co+2cf741c3005abc20@bugs.sh>
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/team/team_core.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index beffbe450612..59dd94271ff1 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -820,7 +820,8 @@ static struct list_head *__team_get_qom_list(struct team *team, u16 queue_id)
 /*
  * note: already called with rcu_read_lock
  */
-static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb)
+static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb,
+					 bool *tx_success)
 {
 	struct list_head *qom_list;
 	struct team_port *port;
@@ -829,8 +830,8 @@ static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb)
 		return false;
 	qom_list = __team_get_qom_list(team, skb->queue_mapping);
 	list_for_each_entry_rcu(port, qom_list, qom_list) {
-		if (!team_dev_queue_xmit(team, port, skb))
-			return true;
+		*tx_success = !team_dev_queue_xmit(team, port, skb);
+		return true;
 	}
 	return false;
 }
@@ -1864,8 +1865,7 @@ static netdev_tx_t team_xmit(struct sk_buff *skb, struct net_device *dev)
 	bool tx_success;
 	unsigned int len = skb->len;
 
-	tx_success = team_queue_override_transmit(team, skb);
-	if (!tx_success)
+	if (!team_queue_override_transmit(team, skb, &tx_success))
 		tx_success = READ_ONCE(team->ops.transmit)(team, skb);
 	if (tx_success) {
 		struct team_pcpu_stats *pcpu_stats;
-- 
2.55.0

