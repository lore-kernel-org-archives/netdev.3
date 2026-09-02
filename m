Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 433C34A9D54
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 16:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788364821; cv=none; b=bgdn1ENyYl+Xk7IdEcTCGKJ2yqy+Pg2GWx3dzb287muf3cz172xYB+/X//2lh2QTA/YG9xRX08BuNduZuqGKJMnxrQsHgW+U3sX/k0/WJJHT1X+frPVLONLmIQmdOIWa8BeT6q/08zJsbMpLl2jPxeERqiYXQU8dI8yIqqBh5x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788364821; c=relaxed/simple;
	bh=n/Zk7kfVfTs+vnFJat95rrNmdJq5Mr397u5VOT6F1zE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jrdY9l+uh0yvG9RzVmJ3KDavHU0oWefbo+hXas8ELm39kUaPbXOAYH9lX8e2zSYA7YlSCXQXmH0rFAr2k5QKpJ0YTPOgQ7m/jIBJHroabe6DZE8F2lmk2gVw7samiVRC6WW3tErnubPsnqc9Ko1wjV58oXo6aEyUJHUVSBevS4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr; spf=pass smtp.mailfrom=ajou.ac.kr; dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b=mJfGrMVr; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ajou.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b="mJfGrMVr"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2d58efc7356so16141545ad.1
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 09:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google; t=1788364819; x=1788969619; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=aAh7tWHEmqOf5EXSkkVLuXbK+rgxGiOqwP75KDeQuy8=;
        b=mJfGrMVrQbinahOPQ4qmoOCE+6QErHlP2VYxgpsTa6ao1gD4iJfPFfcxPGZCb2bqYZ
         FeO32tZDwJ4GmhlIVZNRU4uJxN/iFcboAjEW32NKrkSCcev8XgOfXvVb1eB/flb8o9Q7
         MYnAcsTD6/zlEMleZcZ4svonHth9Dcmq9TXXc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788364819; x=1788969619;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aAh7tWHEmqOf5EXSkkVLuXbK+rgxGiOqwP75KDeQuy8=;
        b=HZ4L8DWse00CMqx9u5ZSo7302vEu2Frz8S1W/nwrNhbnm5tS0NToNqaki5GLX4d21C
         4TZpatRuwC1tdyj7tLmZAd8Vr2Fo2oGqOXVNO37tNq+MVrksq04UChJMVNGkiGAkdxn4
         8t6qhTbo4eJc5mYlML8Yl7JQw0ST79I0gjVgo8yG7+dbSQ2MAmPfE4TizD0/dh/sYgMt
         r5iSR1Ta9XoRIJ5W2KFWElSNnVLEnxMAyx9j5z8qvQJFrYYFg4raHF9AN+TwJwWEFfha
         IvoK7aZXJNajchA4O3QZPGqM24/4SP/7vzg9Pjf+OMMjbvz621E9SwSgpC2sIuJM3FLn
         yOeg==
X-Forwarded-Encrypted: i=1; AKwUvBx4KtqVIxl91qkoKN6E2/OsSEdfP9c0idQhPfnRrHXInUtr7wxLXYOfojApNTh5DO+3lP3djAs=@vger.kernel.org
X-Gm-Message-State: AFuF++kJU+1bNZivWlUnf8snCLdKPWb1cJko3AuA/NOEVvKa47J2T0P1
	rTeMbqKe0ag3v4ckaR44pLpJF4l3MHWh/GYa2zxrxfFRmLDbli364GPXJsgxw3XUAmE=
X-Gm-Gg: AYBFou1J9JrLmP9oCWZ4q56v/+cG2zEXjN6em3v4J2Na580+QS1I+rTVpbR3OWiTMgU
	6/XlbFNw2G+HE+SzCqWZQ5Mrf6/D4f1SGAdhYRWSFrpwkfgnYd90RiD8Gc5mPGD65QyWdnbNK98
	evcGmhBzv+8QmnSw3+fZFvYs9F2/TwewD+wTTUNfT9NKyzGj1/pM2S0nfqSTbf2FmjSvxhuxg3Y
	OOkcxZL/AsTzTDXhJJPrC14A1LhdazaCzGOX+DDi0pRh1eqw/PaZPEBGufMyCziaoo2q6Nbdg7t
	cUCG0+cStAul0VEEUMqngm/PKbV2BnsUefr1fiKHYg+GYOZAJrn1iZs1ohmDq8rulfW/O0xFluO
	NOR8jOV9P+xDkOiNOvi8d43WrU3Eb/StAWfDdcMN+gRqrhkN5olRBYxQBbtIPcCmQP1QFVmXF+B
	xkQjse78qX9zHGYq/sbXxxLeoB+PYqiYOLs0BdnHV8yz2PqjlDg7ujUADaD74tE5/yoUksKfQhy
	zREk0o14rXxEyGBb5G4yUCZP9b6xQEjr8aUcbRns2k=
X-Received: by 2002:a17:902:f78c:b0:2c9:df1b:e948 with SMTP id d9443c01a7336-2daec5dfa20mr91006295ad.4.1788364813891;
        Wed, 02 Sep 2026 09:00:13 -0700 (PDT)
Received: from DESKTOP-2P4OM44.localdomain ([175.195.197.183])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dadd35dac1sm15536475ad.16.2026.09.02.09.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 09:00:13 -0700 (PDT)
From: Seungwon Bae <qotmddnjs@ajou.ac.kr>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	shuah@kernel.org
Cc: horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Seungwon Bae <qotmddnjs@ajou.ac.kr>
Subject: [PATCH net v3] vxlan: reject dynamic fdb entries that reference a nexthop id
Date: Thu,  3 Sep 2026 00:59:56 +0900
Message-ID: <20260902155956.296699-1-qotmddnjs@ajou.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit cited in the Fixes tag allowed VXLAN FDB entries to point to
FDB nexthops so that overlay traffic could be load balanced across
multiple VTEPs. Such entries can only be configured from user space,
cannot be learned and cannot roam. They only make sense with a user space
control plane such as E-VPN where data plane learning is disabled.

Despite that, the VXLAN driver does not currently prevent such entries
from being configured with the "dynamic" flag. The per-nexthop FDB list
is only protected by the per-device hash lock, which is not sufficient
when two VXLAN devices point to the same FDB nexthop and therefore share
the list. Aging runs in softirq context without RTNL, so an entry deleted
by one device can race with an addition or deletion from the other,
leading to list corruption:

  list_del corruption. next->prev should be ffff8881069d9548, but was
  dead000000000122. (next=ffff8881069d9448)
  WARNING: CPU: 0 PID: 90 at lib/list_debug.c:65
  __list_del_entry_valid_or_report+0x1aa/0x210
  ...
   vxlan_fdb_destroy+0x5b8/0xad0
   vxlan_cleanup+0x328/0x450
   call_timer_fn+0x2a/0x1c0
   run_timer_softirq+0x18c/0x210
  BUG: KASAN: slab-use-after-free in vxlan_fdb_destroy

Fix this by rejecting the bogus configuration of dynamic FDB entries that
point to FDB nexthops, both when created and when an existing entry is
updated. As such, the per-nexthop FDB list is only ever mutated under the
RTNL lock. Add test cases to make sure that this does not regress in the
future.

Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Seungwon Bae <qotmddnjs@ajou.ac.kr>
---
Found with AI assistance; treated as public per
Documentation/process/security-bugs.rst. A reproducer is available
privately on request.

Changes in v3:
- Reword the commit message to explain why rejecting dynamic nexthop
  FDB entries is safe (per Ido). No code change from v2.
Changes in v2:
- Reject making a nexthop fdb dynamic (on add and update) instead of
  locking nh->fdb_list; a nexthop fdb cannot roam so it must not age,
  leaving nh->fdb_list mutated under RTNL only.
- Add fib_nexthops.sh selftest coverage; add Fixes tag.
v1: https://lore.kernel.org/netdev/20260901050253.47197-1-qotmddnjs@ajou.ac.kr/
v2: https://lore.kernel.org/netdev/20260901120740.105374-1-qotmddnjs@ajou.ac.kr/
 drivers/net/vxlan/vxlan_core.c              | 11 ++++++++
 tools/testing/selftests/net/fib_nexthops.sh | 28 +++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index ac88d1c85..93bf7c535 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -996,6 +996,12 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 		return -EOPNOTSUPP;
 	}
 
+	if (rcu_access_pointer(f->nh) &&
+	    !(state & (NUD_PERMANENT | NUD_NOARP))) {
+		NL_SET_ERR_MSG(extack, "Cannot make a nexthop fdb dynamic");
+		return -EOPNOTSUPP;
+	}
+
 	/* Do not allow an externally learned entry to take over an entry added
 	 * by the user.
 	 */
@@ -1257,6 +1263,11 @@ static int vxlan_fdb_add(struct ndmsg *ndm, struct nlattr *tb[],
 	if (err)
 		return err;
 
+	if (nhid && !(ndm->ndm_state & (NUD_PERMANENT | NUD_NOARP))) {
+		NL_SET_ERR_MSG(extack, "A nexthop fdb cannot be dynamic");
+		return -EINVAL;
+	}
+
 	if (vxlan->default_dst.remote_ip.sa.sa_family != ip.sa.sa_family)
 		return -EAFNOSUPPORT;
 
diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 3d3471267..431d7bed7 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -533,6 +533,20 @@ ipv6_fdb_grp_fcnal()
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:14 dev vx10 nhid 61 self"
 	log_test $? 255 "Fdb mac add with nexthop"
 
+	# fdb entries with a nexthop group cannot be aged out
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:15 dev vx10 nhid 102 self static"
+	log_test $? 0 "Fdb mac add with nexthop group and static state"
+
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:16 dev vx10 nhid 102 self dynamic"
+	log_test $? 255 "Fdb mac add with nexthop group and dynamic state"
+
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:17 dev vx10 nhid 102 self"
+	run_cmd "$BRIDGE fdb replace 02:02:00:00:00:17 dev vx10 dst 2001:db8:91::11 self dynamic"
+	log_test $? 255 "Fdb mac replace with nexthop group and dynamic state"
+
+	run_cmd "$BRIDGE fdb append 02:02:00:00:00:17 dev vx10 dst 2001:db8:91::11 self dynamic"
+	log_test $? 255 "Fdb mac append with nexthop group and dynamic state"
+
 	run_cmd "$IP -6 ro add 2001:db8:101::1/128 nhid 66"
 	log_test $? 2 "Route add with fdb nexthop"
 
@@ -669,6 +683,20 @@ ipv4_fdb_grp_fcnal()
 	run_cmd "$BRIDGE fdb add 02:02:00:00:00:14 dev vx10 nhid 12 self"
 	log_test $? 255 "Fdb mac add with nexthop"
 
+	# fdb entries with a nexthop group cannot be aged out
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:15 dev vx10 nhid 102 self static"
+	log_test $? 0 "Fdb mac add with nexthop group and static state"
+
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:16 dev vx10 nhid 102 self dynamic"
+	log_test $? 255 "Fdb mac add with nexthop group and dynamic state"
+
+	run_cmd "$BRIDGE fdb add 02:02:00:00:00:17 dev vx10 nhid 102 self"
+	run_cmd "$BRIDGE fdb replace 02:02:00:00:00:17 dev vx10 dst 10.0.0.3 self dynamic"
+	log_test $? 255 "Fdb mac replace with nexthop group and dynamic state"
+
+	run_cmd "$BRIDGE fdb append 02:02:00:00:00:17 dev vx10 dst 10.0.0.3 self dynamic"
+	log_test $? 255 "Fdb mac append with nexthop group and dynamic state"
+
 	run_cmd "$IP ro add 172.16.0.0/22 nhid 16"
 	log_test $? 2 "Route add with fdb nexthop"
 
-- 
2.43.0

