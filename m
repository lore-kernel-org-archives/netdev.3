Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A53E636B91E
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 00:55:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788224155; cv=none; b=VdsdjY1USqIPdGqMYn73tT0Ht8CWAMJoYLiBSpSsD7XXQA91uUdLtxfVih5l1LyTfirqj/iKZSeXO/fGNd35NW0s/pED5xtLlDNKQF11eAe7qWG9l0MQqdpK1Npb25mGZaB0QgQRNARn8gEIvVl7MllRS+0udRJefCZeFnjDOXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788224155; c=relaxed/simple;
	bh=XhMM5ef4Vu9YBrHJ72mJEuhVZJSa4hLeC6iHmXRRKpA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ROGCZS0Eel5Kril/JWlyGkrfqTf9p6jCsTQhqvZQrxuo3+9WtwM3DasMHKP6KxkWPCczusjzIUxZtqCT/w8JRzThNtdksj4EebnfTHNLxFq+Gvco31DBTjHYvl7ayeCfdQkCXvtZfKdaTYM5/QhqGHe8N0nRdc4y2L90/VYHIPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YfeZNmaj; arc=none smtp.client-ip=209.85.216.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YfeZNmaj"
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-396638f9a18so7022723a91.2
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 17:55:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788224153; x=1788828953; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=gBdwXRlmGqLiaHWb6PAGULtQ9tao/Kbiks7gdvjVfRs=;
        b=YfeZNmaj1wRFDkSVQBYAUpsARVqMaL/4XCh0mhf9A90C+4WJ4oJyeWZr8SC1I5xD/9
         bZFo0x4dbV6lFpXxHTcllzSLu4zAc583at+zeH2awK6rYV1D4Dbrbr/YDWfS8p6SVFGw
         8TsUVayFUN+YAxb928XRNPwNbm/3Qqt9EsAgZHD/M/JiUPIfvT+2jJypEPyKG8yqduh/
         J4pXYr5rFneGUghBLFcH4+BolZwpIegOBbSX0OJVjlCw+6JpPvRNDBTYfAFokEMOtvz6
         Gmid/FZhua505zrhWSaR0P4Dz0H/wXUJjiID3PnC9EP2vNewklP7waw5Qxn+lcIru0BU
         eLsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788224153; x=1788828953;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gBdwXRlmGqLiaHWb6PAGULtQ9tao/Kbiks7gdvjVfRs=;
        b=qSNaA8FGFW5rubPRmIU0fsYu4u+vL6G1xYge9A/oZQhsW72lmkQ1xNynfkBM4wa1cm
         iE3HK6q3oIKkCC8uQBOZF42OCW56keu+qDV9y1JfLphgwSnf+Cp2OkRaZ6U+87Uomt0n
         mXxqdxRCFTGFepVOy8GeM9Ttf7IID+Amt4kIF1hXl70hwRfHrVulsmwARJd2UcsQn95j
         nMGRo0XcUsz+mNFkW3Oh9Z1nv4YcsrMSom37i4eCaDRiJQ0e/n+T6c1uxfL6a5Jwi1B8
         YESFrg+cUgycsTm+8tqBbK0d0HUve9stgr9bAwT979z8qH6WNzZJJvU2S5ydFsmCQmOX
         8T+w==
X-Forwarded-Encrypted: i=1; AKwUvBzTMS4A7lDuOsydwTj0Ab+6sGoKUqoXndg0P8yzrmqlp/SHKd0NlvkIiLNW61/VHDlNPUNHOyk=@vger.kernel.org
X-Gm-Message-State: AFuF++kwqSZ3OgEo8vR6+TGU8IWetKvFjgeoENS1h43sGyPiCwQYaVvC
	f5KJW9A/YsMVHFonQ/L1Z46JVU/+ruOw0poDcHtYrnkoP6jUIVW+kRfr6TSqPO/S996cmM74iaK
	EvHBQkg==
X-Received: from pjzo11.prod.google.com ([2002:a17:90b:c8b:b0:38e:ba48:b0cc])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:1c02:b0:398:c8ef:3644
 with SMTP id 98e67ed59e1d1-398c8ef37c7mr14135831a91.15.1788224152484; Mon, 31
 Aug 2026 17:55:52 -0700 (PDT)
Date: Tue,  1 Sep 2026 00:55:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260901005550.2042357-1-kuniyu@google.com>
Subject: [PATCH v1 net] net: Remove conflicting altnames for dying netns in __dev_change_net_namespace().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Johannes Berg <johannes@sipsolutions.net>
Cc: Simon Horman <horms@kernel.org>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, 
	syzbot+74f338e09f1ef3ee6457@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

syzbot reported the warning in cfg80211_pernet_exit(). [0]

The repro does the following:

  1. create two device in root netns and non-root netns
  2. assign the same altname for the two devices
  3. remove the non-root netns

Since commit 7663d522099e ("net: check for altname conflicts
when changing netdev's netns"), cfg80211_switch_netns() and
cfg802154_switch_netns() fail if init_net has a device with the
conflicting altname.

default_device_exit_net() had the same issue and commit d09486a04f5d
("net: fix removing a namespace with conflicting altnames") fixed it.

cfg80211_pernet_exit() and cfg802154_pernet_exit() need the same fix.

Let's generalise the fix by removing conflicting altnames for dying
netns in __dev_change_net_namespace().

[0]:
cfg80211_switch_netns(rdev, &init_net)
WARNING: net/wireless/core.c:1871 at cfg80211_pernet_exit+0xd5/0x120 net/wireless/core.c:1871, CPU#1: kworker/u8:9/1160
Modules linked in:
CPU: 1 UID: 0 PID: 1160 Comm: kworker/u8:9 Not tainted syzkaller #0 PREEMPT(full)
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Workqueue: netns cleanup_net
RIP: 0010:cfg80211_pernet_exit+0xd5/0x120 net/wireless/core.c:1871
Code: e8 03 42 80 3c 20 00 74 08 4c 89 f7 e8 b4 ef 0e f7 4d 8b 36 49 81 fe 20 10 4a 90 74 12 e8 03 3d 9f f6 eb 85 e8 fc 3c 9f f6 90 <0f> 0b 90 eb cc e8 f1 3c 9f f6 eb 05 e8 ea 3c 9f f6 5b 41 5c 41 5e
RSP: 0018:ffffc900057a78f0 EFLAGS: 00010293
RAX: ffffffff8b287154 RBX: ffff88807ba72780 RCX: ffff8880213e8000
RDX: 0000000000000000 RSI: 00000000ffffffef RDI: 0000000000000000
RBP: 00000000ffffffef R08: ffffffff9024cc67 R09: 0000000000000000
R10: fffff52000af4eb0 R11: fffffbfff204998d R12: dffffc0000000000
R13: ffffffff904a1080 R14: ffff888144ed0008 R15: ffff888144ed0e20
FS:  0000000000000000(0000) GS:ffff888124de6000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005642de0a8a70 CR3: 000000007a40c000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 ops_exit_list net/core/net_namespace.c:200 [inline]
 ops_undo_list+0x43d/0x8d0 net/core/net_namespace.c:253
 cleanup_net+0x572/0x810 net/core/net_namespace.c:706
 process_one_work kernel/workqueue.c:3387 [inline]
 process_scheduled_works+0xc3d/0x1630 kernel/workqueue.c:3470
 worker_thread+0xa47/0xfb0 kernel/workqueue.c:3551
 kthread+0x38b/0x480 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Fixes: 36fbf1e52bd3 ("net: rtnetlink: add linkprop commands to add and delete alternative ifnames")
Reported-by: syzbot+74f338e09f1ef3ee6457@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a96219e.04428c52.29b18.0001.GAE@google.com/T/
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/dev.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/net/core/dev.c b/net/core/dev.c
index 38336858c168..290e0f099e6b 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -12703,7 +12703,7 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 			       const char *pat, int new_ifindex,
 			       struct netlink_ext_ack *extack)
 {
-	struct netdev_name_node *name_node;
+	struct netdev_name_node *name_node, *tmp;
 	struct net *net_old = dev_net(dev);
 	char new_name[IFNAMSIZ] = {};
 	int err, new_nsid;
@@ -12749,13 +12749,19 @@ int __dev_change_net_namespace(struct net_device *dev, struct net *net,
 	}
 	/* Check that none of the altnames conflicts. */
 	err = -EEXIST;
-	netdev_for_each_altname(dev, name_node) {
-		if (netdev_name_in_use(net, name_node->name)) {
-			NL_SET_ERR_MSG_FMT(extack,
-					   "An interface with the altname %s exists in the target netns",
-					   name_node->name);
-			goto out;
+	netdev_for_each_altname_safe(dev, name_node, tmp) {
+		if (!netdev_name_in_use(net, name_node->name))
+			continue;
+
+		if (!check_net(net_old)) {
+			__netdev_name_node_alt_destroy(name_node);
+			continue;
 		}
+
+		NL_SET_ERR_MSG_FMT(extack,
+				   "An interface with the altname %s exists in the target netns",
+				   name_node->name);
+		goto out;
 	}
 
 	/* Check that new_ifindex isn't used yet. */
@@ -13210,7 +13216,6 @@ static struct pernet_operations __net_initdata netdev_net_ops = {
 
 static void __net_exit default_device_exit_net(struct net *net)
 {
-	struct netdev_name_node *name_node, *tmp;
 	struct net_device *dev, *aux;
 	/*
 	 * Push all migratable network devices back to the
@@ -13234,10 +13239,6 @@ static void __net_exit default_device_exit_net(struct net *net)
 		if (netdev_name_in_use(&init_net, fb_name))
 			snprintf(fb_name, IFNAMSIZ, "dev%%d");
 
-		netdev_for_each_altname_safe(dev, name_node, tmp)
-			if (netdev_name_in_use(&init_net, name_node->name))
-				__netdev_name_node_alt_destroy(name_node);
-
 		err = dev_change_net_namespace(dev, &init_net, fb_name);
 		if (err) {
 			pr_emerg("%s: failed to move %s to init_net: %d\n",
-- 
2.55.0.897.gb25b4bd76c-goog

