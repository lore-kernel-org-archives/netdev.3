Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42BD83C3789
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 12:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788264485; cv=none; b=fq/qfX2uZHVntr+dGL6kkLVSdrN1LUoQc6hTHG1PFGh/Uhk4b+otRcOaZvTQf2AHoUhM/0lUI5q4JGteC+skHM8wCzsa5AQiaCTzsAMM9NQjTm2KquPI3TiE5c2TJfVNtrzevR7WzYJ6brjHDFlK9cbjgyF1p6U8DegOuUzTog0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788264485; c=relaxed/simple;
	bh=o5Egp9yNwXpcCqrJLh2gmihEga63VBYdsEigTCjApRk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hyAlI8u+CNk2vDRoXQJIqfwvqBYyRSwY2myo08wnYNHOAcp5tEEJ5RzgjEztGniHGuRlN7ntqTVaZRg/S+AwXIKd/FtXgIbcAEEpQslK7CsYhIZsZx0SyOU4oUOEazG9egFrWV2bg1n5pK+YL6q6YpfKRd4n/wzAylsroZktsk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr; spf=pass smtp.mailfrom=ajou.ac.kr; dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b=DEpEL3lu; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ajou.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ajou.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ajou.ac.kr header.i=@ajou.ac.kr header.b="DEpEL3lu"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2d9db539a54so438045ad.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 05:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ajou.ac.kr; s=google; t=1788264482; x=1788869282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OQLp2qcl9BqKOUtBIxO1nk5z5lFh8LVeO8TWdXgzcQg=;
        b=DEpEL3luiE4MUR7b1N9KH7PpFFXQQSnocXKa4I//EKuvSOzbleXjjeIBTMJfqdxSSU
         59E48Ke9B7N7R2wKJ45tx7XOYXgeSMfctO+doNo6hJaBWDpUTf5mFdibdHkAeKynoUK8
         zizMKjCdb3mh4cKkjXToPNhc/QqNiveuGM6GI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788264482; x=1788869282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OQLp2qcl9BqKOUtBIxO1nk5z5lFh8LVeO8TWdXgzcQg=;
        b=E47lsU0JRbDzItwwjTWbGT2afzNbzGQgiwutcHC1fBAfu9nRz1FqUfEoFuD4xs27rx
         KRYOoVerRNuI006HiV6KW5XE6UALJmSWV3vwpfXhgX5dFWpeE5bk3McWRVcK2pK15Ees
         ChqA9D4BnGlziHfDoNb+zOcJTTOm+mrK3972d/wQNZG62gvgLHoyDCEH7z88aEQ9BR3b
         blq24DRZijvpXazXNZPuaoWFksowgMwiEeBSahL5UOCG6mnNog0PlS9bkF9eBccuXG1F
         M5T5PWM+e9VKz5byqHwbE07NJuWUwAWGvV1ZLzEmaI7P7TP8tGDmCzDoXUp8Ws6xwsn7
         rboQ==
X-Forwarded-Encrypted: i=1; AKwUvBzgjFGNJ3V5l5SN3fxZpl26T6KwKCQZyiSaf0XUXLiWzS3JxAAKB+AkFSRi82d1RH0k39hGcPs=@vger.kernel.org
X-Gm-Message-State: AFuF++m+uDlGPqk2uUJrXatxBr64V47zEebhD8InHPOv0RmbM49lclQ8
	1ZnVw4nw37wTnds4TA/wwIZC4dQpo2a3mP6jdyvn6CSCqjnC92QScHbw44CMdzDM+QA=
X-Gm-Gg: AR+sD10vBeVDVkfpLzjJTLtiwjwHDcjmeM/kJ+oMGKhbwdveR9vhJqTY0kyZIqLKjHM
	pB8eXSappZxUIAXwmEHYxKv0IphKE3ClOZrsYyayjMbLcZAHjUdQjK+ssvThYgGRmgUbogQtOwu
	q7eL6AofKxD4azZBCxPGaSCZd3WSLzZa1MrFk9OpHf88IeZvfp17LB8SRh/Ou+rZF858qZCoB3U
	sUs0tQ5jcdcAdSnSvI25J28raYsblMxOYTYRaeQmkCA/ulnG3/1Po1HcAhDJN9BYaXzD2DGAxyh
	+I0KOUs0uorq7mNYsODLEazUJMwAIMJT+EPr9CPbXg9PFyTMY4U3112F/DBCpu8dgle/jhdwXX4
	eUHrQ4zW5xzE1xnxSJncqWncdRJZl7QtXKmWFp4DROFDRvRI9f9gmcs/cTgibAHdHcrOayh8hOe
	4GWXmf6t8l9cbVhsbhJQADvlT2AKgJuILrkdVZIVAC4IMfb4RE/486VCGd6FuT/BEsI4HZf6XRl
	NPq/ENc/NFJeVCPPBsb64V/eEjbtDU1DhRqSX4qLnI=
X-Received: by 2002:a17:903:1aab:b0:2d9:e1b:73ee with SMTP id d9443c01a7336-2d94a760fc8mr105012655ad.8.1788264482200;
        Tue, 01 Sep 2026 05:08:02 -0700 (PDT)
Received: from DESKTOP-2P4OM44.localdomain ([175.195.197.184])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75986aea3sm50325765ad.52.2026.09.01.05.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 05:08:01 -0700 (PDT)
From: qotmddnjs <qotmddnjs@ajou.ac.kr>
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
Subject: [PATCH net v2] vxlan: reject dynamic fdb entries that reference a nexthop id
Date: Tue,  1 Sep 2026 21:07:40 +0900
Message-ID: <20260901120740.105374-1-qotmddnjs@ajou.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Seungwon Bae <qotmddnjs@ajou.ac.kr>

An fdb entry that references a nexthop id cannot roam and therefore has no
reason to be aged out, even though vxlan_snoop() keeps refreshing its
timestamp.  Nevertheless, such an entry can currently be created (or an
existing nexthop entry updated) with a dynamic state, which places it on
the aging list.

struct nexthop.fdb_list is a per-nexthop global list of the vxlan fdb
entries that reference an fdb-nexthop.  It is manipulated by vxlan under
the per-device vxlan->hash_lock only.  When two vxlan devices reference the
same fdb-nexthop, their entries share one nh->fdb_list, but each device
takes only its own hash_lock.  vxlan_cleanup() - the aging timer - then
runs in softirq with only its device's hash_lock and calls
vxlan_fdb_destroy() -> list_del_rcu(&f->nh_list), racing a concurrent
list_add_tail_rcu()/list_del_rcu() driven from the other device.  The
shared list is corrupted and a freed struct vxlan_fdb is left linked on
nh->fdb_list, a use-after-free later consumed by vxlan_fdb_nh_flush().

On CONFIG_DEBUG_LIST/KASAN this reproduces as:

  list_del corruption. next->prev should be ..., but was dead000000000122.
  __list_del_entry_valid_or_report <- vxlan_fdb_destroy <- vxlan_cleanup
  <- run_timer_softirq
  BUG: KASAN: slab-use-after-free in vxlan_fdb_destroy

Since a nexthop fdb entry must not be aged out in the first place, reject
making it dynamic, both when it is created and when an existing entry is
updated.  vxlan_cleanup() skips NUD_PERMANENT/NUD_NOARP entries, so this
guarantees nexthop fdb entries are never touched by the softirq aging
path, and nh->fdb_list ends up manipulated under RTNL only, removing the
race entirely.

Extend the vxlan fdb-nexthop selftests to cover the rejection on add,
replace and append.

Verified with a KASAN + CONFIG_DEBUG_LIST kernel and an unprivileged
(userns+netns) reproducer that previously ran two vxlan devices churning
dynamic add + aging-delete on a shared fdb-nexthop: before the change the
dynamic nexthop adds succeed and produce hundreds of list_del corruptions
plus a slab-use-after-free; after the change the adds are rejected with
-EINVAL and the run is clean (0 corruptions, 0 KASAN reports).

Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Seungwon Bae <qotmddnjs@ajou.ac.kr>
---
Found with AI assistance; treated as public per
Documentation/process/security-bugs.rst. A reproducer is available
privately on request.

Changes in v2:
- Reject making a nexthop fdb dynamic (on add and update) instead of
  adding a lock around nh->fdb_list, per review feedback: a nexthop fdb
  cannot roam, so it should never be aged out; this removes the softirq
  racer and leaves nh->fdb_list manipulated under RTNL only.
- Add fib_nexthops.sh selftest coverage (add/replace/append rejection).
- Add Fixes tag.
v1: https://lore.kernel.org/netdev/20260901050253.47197-1-qotmddnjs@ajou.ac.kr/
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

