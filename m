Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51FE25B0BB
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 08:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791792245; cv=none; b=PaL32I2ISAv+L4d00FS3xhZHFz3SmEKlY3mXVLHLVThH8PVT95jKm8LmJZ5JOcIix1bUxRuK2yhVMo+hxkfr9+Gwt8Cs5fkpJsUFCgBtTOL83JznLlETNvQj1PMhuFW8Uucb/toKZ6xu/ZPDI3MP63ARymE1XWolO9DPW41R1tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791792245; c=relaxed/simple;
	bh=K9em4Tm9ugxQTtAX4IiYzZsiBtvjzXORczke2gHj6ls=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tPxPY6T2SpjUC2aNmRqwnT3AJf/P3V6HtGGOPSU6Dc6+Mi5eO0kDAgqnDwbNkgtyIJHQUluf3Fk9ZzzyvOSJiRlQ7xrg95V4KoydmXQVQigbkTtX9DvR98IhRBMz7gLWGbbjDXvAIdfEGUs8X9g90rh7Uux7erIc6AUBgC3qAus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gfyDNcVc; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gfyDNcVc"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2d71d1cc8b2so8405075ad.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 01:04:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791792243; x=1792397043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Hc3DP5cOmEiiLgrIASB39ibcWyYPqeHj3lgqxS6llMQ=;
        b=gfyDNcVc1tK8o3Z8c1IU5jQEX/X2qXogj8u81JqdEe8ZK3B+KR7D92GsgUtmKb0lUD
         dChA2rO9UKHTMuO0C1dSkPjrR0TUbUcDLweNKwcvcyWYFj1JIO73Xp7OwhPmFvJcHKN2
         i+bsZZxJFSa4mDfG4poBRUUs9RIsL6Vele7JwCCkihV+rW64RBzexXkHUJdGZi/autZx
         G3DxXsrNPBWHizCCR4Y6GS2iIHRd/h251nhwJJ2nKzhXcvR4yO3nJtIDK+kNY92rlRqT
         ho1lcJU6MIe1AzkULoYSYK0XJpoRHe/XvsnbXhpYp6aenTRrXytHFVOUDSOQrIa9iRX9
         ANvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791792243; x=1792397043;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Hc3DP5cOmEiiLgrIASB39ibcWyYPqeHj3lgqxS6llMQ=;
        b=bQ3o3UtGiz2OlJ5iUZcezu4gtidTzJh0e9wgWcZ19Fq9XYdjadT4J5SQ3c3E2+ntU4
         eqxC/AUjWFNHc9t3d2Tq25AUPWZC6Bya/OosIRKgIe7Pidqa9iahDl9dqqClOUri3ia5
         pye1XA2UnlNZpNja+KacdcS5C9C4I8KMcVjEyhJ+jbZOk4oRYhY+UxptxINgwiPYyH6s
         qvbYXKRTn+GrbUOjw1+z+xRAiiFMOYizvyiR4dH/gEkvNX5tGDQcsJ6rWtmLWRtddzLS
         8uMf1WfoU7AnO/edv8gvhlvhvZM4XJCcdZj1gm4LFZzMtxVmPvpi6XTa1iDjKJwZqUBy
         Aorg==
X-Forwarded-Encrypted: i=1; AKwUvByArub5ndDitrXhizgtXQ8NoDlk7PnbdzZFyNPSRvfn0XohEivJ6YbKhbRQIh/jZcEDbR4PrzY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ77vtAFhi/jU9JlJoHOZGXpDYm80CWgVl+XNe+QHH9YoQ23zy8
	48LRpUC6FLOI8QfYud3qvcaHlPfDT/gT98uSXoS+TgF3Y5akd3bRdBOG
X-Gm-Gg: AYBFou2hAYed9zrnPs25VLx5x8km3y414crvJc0nBxmBrq05Hvh30OjM19RVWy+zFD4
	UccfI3013RIoumWRR5LZHD1tK6U4L5CGGJ/TLquDH8aDGHCao/fGwzZI2emPnoRSrKOhjcrMK77
	V86kqvB9W7p6fQmZebJWWKUqYvb+rav3mZJK53nf+9ZMZm8u40ZygrPUEOs8I0mZeJWdw22osLc
	ZCwwyg2Inb6/VkAPGfpyKtlbBuxYBRxlzhLDEw9giyyMVycVOP7eYHBDO3vkPXcpE7x7i4hTrBh
	u2KQEC8SUR8pDoS6KHUnGDOrvEtnJucYp7kNPewsRqPx/g8l3xHt1fdVUFdeIUkfb08Iz17oq1k
	y8iStDsgzLrIHIAr5xh67cHk1WxP1eihYPy0MAAUFkIBsmKrc8quuvs1iiuXTAuQ6VciI2wYlAb
	VaRHoiDxSpiUOAGNaJPGc4qogsfIpiLqPY0JpcwQl3bWICeXU+SsLXU00EVf2oV8rBVsbsmHF3C
	+NQG8PwvC4Q2zZOMiGw5OLAUIc6XtayvmJsKqSN+3cpScvnjw0UkIIIsg==
X-Received: by 2002:a17:902:db0a:b0:2dd:c053:9c71 with SMTP id d9443c01a7336-2e842ac8b2bmr84273155ad.39.1791792242900;
        Mon, 12 Oct 2026 01:04:02 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.24])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e8422da9b1sm40189785ad.66.2026.10.12.01.04.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 12 Oct 2026 01:04:02 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: razor@blackwall.org,
	idosch@nvidia.com
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	horatiu.vultur@microchip.com,
	bridge@lists.linux.dev,
	netdev@vger.kernel.org,
	Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org,
	TencentOS Corvus AI <corvus@tencent.com>
Subject: [PATCH net] net: bridge: don't re-arm the STP port timers on MRP driven ports
Date: Mon, 12 Oct 2026 16:03:53 +0800
Message-ID: <20261012080357.29015-1-juny24602@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jun Yang <junvyyang@tencent.com>

br_set_state() returns without touching p->state when the port is MRP
aware, so br_stp_disable_port() cannot move such a port to
BR_STATE_DISABLED.  The br_port_state_selection() call at the end of
br_stp_disable_port() therefore still processes the port: it is past the
"if (p->state == BR_STATE_DISABLED) continue" test, it is a designated
port (br_become_designated_port() ran a few lines earlier), and if MRP
left it in BR_STATE_BLOCKING then br_make_forwarding() re-arms
p->forward_delay_timer - after the timer_delete() that
br_stp_disable_port() just did.

del_nbp() then frees the port through call_rcu() with the timer still
queued on a timer base, and the timer wheel writes into (and eventually
calls a function pointer out of) freed memory:

  BUG: KASAN: slab-use-after-free in __run_timers (include/linux/list.h:1175 kernel/time/timer.c:1820 kernel/time/timer.c:2356)
  Write of size 8 at addr ffff88800ba32070 by task swapper/1/0
   __run_timers (include/linux/list.h:1175 kernel/time/timer.c:1820 kernel/time/timer.c:2356)
   run_timer_softirq (kernel/time/timer.c:2386 kernel/time/timer.c:2405)
   handle_softirqs (kernel/softirq.c:645)
  Allocated by task 1:
   br_add_if (net/bridge/br_if.c:440 net/bridge/br_if.c:596)
   do_set_master (net/core/rtnetlink.c:3076)
  Freed by task 24:
   kfree (mm/slub.c:6792)
   kobject_put (lib/kobject.c:737)
   rcu_core (kernel/rcu/tree.c:2919)
  Last potentially related work creation:
   __call_rcu_common.constprop.0 (kernel/rcu/tree.c:3181)
   br_del_if (net/bridge/br_if.c:736)
   do_set_master (net/core/rtnetlink.c:3060)
  The buggy address is located 112 bytes inside of
   freed 2048-byte region [ffff88800ba32000, ffff88800ba32800)

Skip the STP forwarding state machine for MRP driven ports, and for good
measure shut the three port timers down in del_nbp() before the port is
handed to call_rcu(), the way commit 2a00517db8de ("bridge: stp: Fix a
potential use-after-free when deleting a bridge") did for the bridge
timers.  timer_shutdown_sync() also makes any later arming attempt a
no-op.

Fixes: 419dba8a49d7 ("net: bridge: Add checks for enabling the STP.")
Cc: stable@kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Assisted-by: tencentos-corvus-ai:hy4-preview
Signed-off-by: Jun Yang <junvyyang@tencent.com>
---
A KASAN reproducer for this issue is available if requested.
---
 net/bridge/br_if.c  | 4 ++++
 net/bridge/br_stp.c | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/net/bridge/br_if.c b/net/bridge/br_if.c
index c52613431f88..ea36da07b56f 100644
--- a/net/bridge/br_if.c
+++ b/net/bridge/br_if.c
@@ -374,6 +374,10 @@ static void del_nbp(struct net_bridge_port *p)
 
 	br_netpoll_disable(p);
 
+	timer_shutdown_sync(&p->message_age_timer);
+	timer_shutdown_sync(&p->forward_delay_timer);
+	timer_shutdown_sync(&p->hold_timer);
+
 	call_rcu(&p->rcu, destroy_nbp_rcu);
 }
 
diff --git a/net/bridge/br_stp.c b/net/bridge/br_stp.c
index c7e7e924f155..5f4bca38a40b 100644
--- a/net/bridge/br_stp.c
+++ b/net/bridge/br_stp.c
@@ -463,6 +463,12 @@ static void br_make_forwarding(struct net_bridge_port *p)
 	if (p->state != BR_STATE_BLOCKING)
 		return;
 
+	/* br_set_state() will not move an MRP driven port out of BLOCKING,
+	 * so arming forward_delay_timer for it only leaks a live timer.
+	 */
+	if (test_bit(BR_MRP_AWARE_BIT, &p->flags))
+		return;
+
 	if (br->stp_enabled == BR_NO_STP || br->forward_delay == 0) {
 		br_set_state(p, BR_STATE_FORWARDING);
 		br_topology_change_detection(br);

base-commit: e6b6078ea1731b05b3b552497b3bce4bf8b014ae
-- 
2.55.0

