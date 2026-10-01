Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D83E45FFA4
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 18:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790879026; cv=none; b=Q08F/QYUNsa4AVt3nfcNyuRsujtG1cfF/ARKpKqbTto7vZr/AgYgmVv/hn8+3P9Bagpye7KP14ceOCNf6UP2TijcPTDohrWA6rBQ303l4H10MKlxrlofv34K/o6SeuH+FJhF2g5zLjtaB6mgpuGJTBp0oR0rfbtrMovJicPfG2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790879026; c=relaxed/simple;
	bh=MEoqzNpXKXk8yl7o+JNwo1gEmPQgDW5rKLd5WiXbrMY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DyCVm78bIyekAXqz2EsIQKvWCt2HpZdukbS1eIRthY6euapXtSZngBMks1Clt8gxrbDYX/oBXIQ2nIbgAO9wtqJUIv34MEs79gT5EJ321zYam4/5yKzME0EzUZP03JtRBvIsvBW9iXQxg+vrlTK2jgffU9OWoqrbvZ4tyteN7WI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f0zWO1lR; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f0zWO1lR"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33bfb26865fso6735773eec.2
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 11:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790879019; x=1791483819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vO88UioSE3d4VQ/pH+4CdBfLiNkTmP6WB0IbPHbTxWo=;
        b=f0zWO1lRi94kOahkW6gfLulgXbtgi9gH6JGRfg6mhok+LUqrKs4CBNn06ukee1l8ix
         EvoJXPrj7h/Rg2ica5BsAKH/ZRG+t+sugp3hmNukZODuwmq54CQioXPDmrnfIbOGXgpB
         YZ0HybIAGaEBR+0AFxfn1E4LCWWQSCZaZfmGw94MzPV95QH6vfhfqSIWFpP4XR+pYpJC
         BlYxCNUopsm0LJcwffjDrzQ09desDdjzq8OfBZAVPoo7rduKJUxtXuGBKVtJ7j3H3dW/
         Uru1Re1xrRu9/7i1T7MfLKOFs97k9SQGihh0/Bg95l+LHo8PhngDg6BNoXOXWp6IqVYV
         PWqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790879019; x=1791483819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=vO88UioSE3d4VQ/pH+4CdBfLiNkTmP6WB0IbPHbTxWo=;
        b=vdeGpMgrgjmI2qnamGvKbefs76zhiPC24x8iKp4qw9OhxQ5DDJ94bFKRqz7gjBc32z
         YX3oSXsNTxcJU4oW8MED773+b496fskvm/vLne2PZeeHaHg34JuQHecPR01vIDpELmnD
         5HlbzIEubfZRH2HG8+QYH7SRimR/s5/m5kNxlyxT3f63SHd+1io0W+hPJhzFAA5ImNYj
         bBZKiWb7yctaw2TkpIqLyft+13WKciBlP+da4xlwBKpnGo2V2TcTtNKjPHvzZi3Ozzz+
         drap4n+Vu0hMnH91TBS4L8t1EGzEkYBGz9ytM/kp3yklGyIsPspJbW/Z1AL5+1ysxEzT
         x2Uw==
X-Gm-Message-State: AFuF++nUVPFLlDceyTtaijgi6ZosC3/93aDOIqoVhsOhcmQo8+dow9tQ
	ZFSjj9ppx5ExDPoO7pzV5c9IEZcoQx6DFKqkmbonH0Txy2x/rtg1Z13Y
X-Gm-Gg: AYBFou2kqXzlkyAlWsMiQDU7s/1QPa9jLOwwW5ZwzdaSMWk/1lHoqOJWRYVuT85wFnT
	XSTHXCghw0YNb00K75DGoEtflteucIf7wzL9l4pv63RPkiXMnaCTdsC/YaaC13cQuPJpcJXoHWi
	5Ej5NCt/e7NFscdWoLglJsMk7MsdbQYjd+vZEIWpCyvQe6Zlp0e8RUlLYbXghWu06xyKmdBrTq7
	Em9WOFy7wGHrrfaIi3GpD7Qow5/PzN5ot7h06TQIE9kgzRjZIuilA3yTnY1XpMcDJr2uXevCqR4
	i43FrZwY8siM/aI4tGGIM5uKoj3JTHCWDk3YpCSrD3XVL+I8i3drv6YjqBFAvf6iR3kJAo/Oa3M
	nSGRKxV+kp/ELxCUQBh19muOWD/8dhCbNlBE3jfLTjieWVj3hogyFfOs4+XMHFZM5JhT3poUdhb
	R19nvslDbX9lPjYRTAPXyvWSu1dplgjiqw5Yl64NpSAMzejBx+OXuyACjozzUxIYHRHKI2ELemh
	tneQFOdt25h0osxpITlBS8JCvOqcHWQpA==
X-Received: by 2002:a05:7301:1401:b0:34b:c0ff:765a with SMTP id 5a478bee46e88-34f06673554mr104019eec.0.1790879018716;
        Thu, 01 Oct 2026 11:23:38 -0700 (PDT)
Received: from 192.168.50.3 ([198.176.50.208])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34f14f303e3sm189671eec.5.2026.10.01.11.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 11:23:38 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	co+2cf741c3005abc20@bugs.sh,
	Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2 1/2] net: team: stop reusing skb after queue override
Date: Fri,  2 Oct 2026 02:23:25 +0800
Message-ID: <20261001182326.572045-2-bestswngs@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261001182326.572045-1-bestswngs@gmail.com>
References: <20260926090039.1714460-1-bestswngs@gmail.com>
 <20261001182326.572045-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A nonzero dev_queue_xmit() result does not return ownership of the skb.
When an override port's qdisc drops it, the queue override helper used to
try another port or the mode transmit op with the freed skb.

Return the handoff decision separately from transmit success. Select only
the first override port under RCU and stop after handing it the skb,
regardless of the lower transmit result. Keep the existing success and
drop accounting.

  BUG: KASAN: slab-use-after-free in sk_skb_reason_drop
  Write of size 4 by task poc/5040
  sk_skb_reason_drop (net/core/skbuff.c:1240)
  dev_kfree_skb_any_reason (net/core/dev.c:3470)
  ab_transmit (drivers/net/team/team_mode_activebackup.c:49)
  team_xmit (drivers/net/team/team_core.c:1849)
  __dev_direct_xmit (net/core/dev.c:4934)
  Freed by task 5040:
  __tcf_kfree_skb_list (net/sched/sch_generic.c:43)
  __dev_queue_xmit (net/core/dev.c:4831)
  team_xmit (drivers/net/team/team_core.c:1846)
  Kernel panic - not syncing: KASAN: panic_on_warn set ...

Cc: stable@vger.kernel.org
Fixes: 8ff5105a2b9d ("team: add support for queue override by setting queue_id for port")
Reported-by: <co+2cf741c3005abc20@bugs.sh>
Assisted-by: LLM
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 drivers/net/team/team_core.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index feaa75fbf8fc2..3bf7c80f1d8e5 100644
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
@@ -828,11 +829,11 @@ static bool team_queue_override_transmit(struct team *team, struct sk_buff *skb)
 	if (!team->queue_override_enabled || !skb->queue_mapping)
 		return false;
 	qom_list = __team_get_qom_list(team, skb->queue_mapping);
-	list_for_each_entry_rcu(port, qom_list, qom_list) {
-		if (!team_dev_queue_xmit(team, port, skb))
-			return true;
-	}
-	return false;
+	port = list_first_or_null_rcu(qom_list, struct team_port, qom_list);
+	if (!port)
+		return false;
+	*tx_success = !team_dev_queue_xmit(team, port, skb);
+	return true;
 }
 
 static void __team_queue_override_port_del(struct team *team,
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

