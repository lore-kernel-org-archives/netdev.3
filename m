Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.231.64
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098049;
	b=DsC3oSi/UUGZOhz7OH7aOPUxFq7ZFFFZaqSo+yzYE1hQukpytGs4SzFrhck1Rl22mgcj
	 c9rO5P3D/NC/LjMKmVdDjHuDie6DdIuP4wpKKbi+dkI9XsoXUqjrPd63Gd/Qt7A0klTb5
	 d8ejOpl5q0rftLkcOWTJPoFYGS9a6C/4NIXln88JwcNhF+4M4vcascTYxuOqdgBTikk75
	 8j8fyi3xRo7s6jmwi0CGvOHW96aFFm5I2g2wf/Q/wCsO2nHde1kTRRQvVlDpI2jSFEzWt
	 bhpcCnCCBJ4rCzOAIz4cjZ4EjApLtdYuEGg4xJtG8EqBEvNZwnaZ1brg0QyNl9fILPA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098049;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=KNgfDwC+3+GosfqLGHUx6kr+kkAHjH7KEB5LS7CnCmM=;
	b=PetSQUn+j+XjJDUH3wzRpAYyLCl1MVomp15ZMKppeaERnXuWvlWaFkbrDlcLcTHOTEm1
	 yjNfrmuVRkOFY9YEVeaO6XWtOnCmx+pJZi5TNxjN6tMsYFZiO7m3dwM6Qbvb55wQrm9ym
	 Umvuhq550qB/h1XN5T+TlLNXOLklO1CEBRJgfoAZM4LYYVhhEDGuvOqJYJHK/gWGu8Y0F
	 u16NKXRlnzmjEbZ77n6X7HUCh7afieheh36GsuOfHJ7QRt/HmFYEYA8tbwS1eKLtLeA/a
	 Th3luKocySLwDGE1OBkPdb215HDIlApn/sWBO1MvlLHArHefilPOJcf6lhXZ2j5Uctg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MQKmLPZJ;
	arc=none smtp.remote-ip=74.125.231.64
Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7836E606A329
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 10:47:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7836E606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MQKmLPZJ
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-4511f6a63edso633755fac.1
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 03:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793098048; x=1793702848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=KNgfDwC+3+GosfqLGHUx6kr+kkAHjH7KEB5LS7CnCmM=;
        b=MQKmLPZJuqcgyjnXyDxD/97XlTCvnNhUq2zFaKUbbWiYi5z8O2IpZhAHn1GVymp1kQ
         j7DW2bgalslQl2+/IGXCfHhSmtQVVPaA6O70ssIj7KARyNJBZbsgHbCx4Shs4gu3brlc
         t67KQMtNaVjBi1eL7CetaAX/3mubCTVDxvLcqwpKpczazzxFIBYEMWlCPoQAhTBbIKC8
         DbqYiw8tnf+mQQxH1FH4ktcyxqC5N72wt8W+RfCxikmlQIOW4pq1QhGK3kZg2FueRDbY
         /GM7m1trkNTyAzWVJAHYIzdstugpuQx7HBV5fuBZCkIVzQGbdIV/rpykyrYbNK5QmXkK
         NZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793098048; x=1793702848;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KNgfDwC+3+GosfqLGHUx6kr+kkAHjH7KEB5LS7CnCmM=;
        b=mtYHVltteHAIEDM3qXMgPo+rRe0RJCgqDoCHDkwa6LbeaadYTqG3b6pGw3iSXodGe0
         6eS34NpVG9pvE0b1OQ1W2LdV6pao7jWm21O5QTaIoJng/Up6uEwbeCHFqymRnn7gzN+l
         ns+V8WIiwIbve2Von9Dc0yii2EAjS8iw+AWZzxiB0b2E/wh0z8/0EfrXcnc7S2qCq/YT
         85NSzKwCyGNJeVxhpG5loFA3u+0cqsQ63wszzzjrgbdtR9YUF8OZW2DQBsJrohQdhMCP
         ff8HGibr23jJxK9nRpZXQsnKM5U50h7QNO7yt+4ybbQ1KEApjlam80O9VcupkstwOehP
         6pwQ==
X-Gm-Message-State: AFq9FYKruyvJY5dqqmUqfHx24Quukr7F4tXbuVXUcsNMfgD+mODYS3g1
	OX9lpGWmzkSj2wZhycXIfZZIlC7qgGio2iv93ISlHy83vjmszY2Otsvo
X-Gm-Gg: AYBFou2bTU2cy1WKXMISWZ9WOkNq3foLW8N0glhm6A7B3EBzerigrXi2q7NUu4bvfx6
	K15qrq0FHYh4Qvu8PjS9ECBIBMyAL4ebvP8RQJ0NLcclASV9a/x+aZIt4kHrDhMuKOT9vBNXPQL
	gtOlAIpqPI0O9hjf75ruJeK2ZlEu81iKerelBRrnaRIIvDSe8lWpq0RzyjHSJ9FQk1fKDJtonlP
	VLgKC7HToJ5lPeVkoeJ2RTZGrCLGby9gZ0bV7B/vnLdXjqQLFyPElS7riP7uSydF3mpkqwASgBt
	yinNfdOsGBTu4vg6mLD3Q+4bDLAI+Y7QK7X3xGqDVa1EgL/KIm3+E+xIFDa6IY55az0Lloz1dCT
	unsGZ2wFf7wPLOgR0Kk4roHIfARzDzJW30KG7W7wvUkTxPu2rGQuA0l9McJVqRDDZUAxeC6ivvv
	VLHZYJAMMAtaSeWNpHw6wmwsiLorcgW80YxLBlrxoMNrmiIjMqZzgMWSArvOGetgTNtIYsew6sq
	RWURUqMgvium65TaDRX881FLsqSYjtu1Q5/kuja73bLOdmrhPMLoDonovt1yoPVoD/aYIIhebCJ
	2BysvyObUpryeQ7OQozNLr9mS3Y3oTFMEokuh5WC2v01F6ZE3dwsQfhmdUcYNybINkUjMw==
X-Received: by 2002:a05:6870:658a:b0:4a7:df5e:d6ee with SMTP id 586e51a60fabf-4a83f53b9aemr5207325fac.45.1793098048302;
        Tue, 27 Oct 2026 03:47:28 -0700 (PDT)
Received: from localhost.localdomain ([14.116.239.36])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a842e89b77sm6597299fac.2.2026.10.27.03.47.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:47:26 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Ido Schimmel <idosch@nvidia.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Petr Machata <petrm@nvidia.com>,
	Ferruh Yigit <ferruh.yigit@amd.com>,
	Antoine Tenart <atenart@redhat.com>,
	Seungwon Bae <qotmddnjs@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v4 1/2] vxlan: reject adding a remote to a nexthop fdb entry
Date: Tue, 27 Oct 2026 18:47:12 +0800
Message-ID: <20261027104713.328028-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

FDB entries backed by a nexthop group must not carry a remote
destination list.  vxlan_fdb_update_existing() currently appends a
remote via vxlan_fdb_append() on an NLM_F_APPEND request with a
multicast or zero MAC even when the entry is backed by a nexthop,
breaking that invariant through three different callers:

- "bridge fdb append" with a dst on a nexthop entry;
- "ip link set dev vx0 type vxlan remote <ip>" (vxlan_changelink());
- "bridge vni add" on a vnifilter device
  (vxlan_update_default_fdb_entry()); this includes a plain
  "bridge vni add vni N" without a group, which falls back to the
  device's default remote, and a unicast group.
All three reach the append block with nhid == 0 and a PERMANENT
state, so they pass the earlier nexthop checks.

There is no crash and no leak: the appended remote is freed with the
entry, and the transmit path ignores it (vxlan_xmit() follows the
nexthop whenever f->nh is set).  But the stray remote changes
deletion semantics: __vxlan_fdb_delete() destroys the whole fdb entry
when the matched remote is the only one on the list, so removing it
via "bridge fdb del ... dst <remote>" or "ip link set ... remote
0.0.0.0" tears down the nexthop entry, not just the stray remote.
The entry state is also misreported: vxlan_fdb_notify(), RTM_GETNEIGH
dumps and the switchdev FDB programming all prefer the remote list
over the nexthop, so user space sees the dead remote while the
datapath follows the nexthop group.

Reject the combination at the top of vxlan_fdb_update_existing(),
next to the existing nexthop guards, so a refused request has no side
effects.

Also move the non-unicast NLM_F_REPLACE rejection to the same place;
it previously returned -EOPNOTSUPP only after the entry state and
flags had been rewritten, skipping both the notification pass and
the err_notify rollback.

Note the resulting behavior change for the rtnetlink callers:
operations that previously succeeded while silently attaching a
remote to a nexthop entry now fail with extack
"Cannot add a remote to a nexthop fdb entry".

Add test cases to fib_nexthops.sh in the same fashion as the sibling
fix, commit 98fc57d16744 ("vxlan: reject dynamic fdb entries that
reference a nexthop id").

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 1274e1cc4226 ("vxlan: ecmp support for mac fdb entries")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---

v4: Also move the non-unicast REPLACE rejection before the entry is
    modified (the same half-update class, pre-existing), describe the
    stray remote's effect on __vxlan_fdb_delete() instead of calling
    it "unused", and note that a plain "bridge vni add" or a unicast
    group hits the check too (sashiko review of v2).

v3: Describe the actual consequence and add fib_nexthops.sh test
    cases as requested by Ilya Maximets.

v2: Move the check before the entry state/flags update, next to the
    other nexthop guards (reported by sashiko, confirmed by Jakub).

 drivers/net/vxlan/vxlan_core.c              | 26 +++++++++++++--------------
 tools/testing/selftests/net/fib_nexthops.sh | 18 ++++++++++++++++++
 2 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/drivers/net/vxlan/vxlan_core.c b/drivers/net/vxlan/vxlan_core.c
index 3390e341d1e58..13143085065f6 100644
--- a/drivers/net/vxlan/vxlan_core.c
+++ b/drivers/net/vxlan/vxlan_core.c
@@ -1002,6 +1016,22 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 		return -EOPNOTSUPP;
 	}
 
+	if (rcu_access_pointer(f->nh) &&
+	    (flags & NLM_F_APPEND) &&
+	    (is_multicast_ether_addr(f->key.eth_addr) ||
+	     is_zero_ether_addr(f->key.eth_addr))) {
+		NL_SET_ERR_MSG(extack,
+			       "Cannot add a remote to a nexthop fdb entry");
+		return -EOPNOTSUPP;
+	}
+
+	if ((flags & NLM_F_REPLACE) &&
+	    (is_multicast_ether_addr(f->key.eth_addr) ||
+	     is_zero_ether_addr(f->key.eth_addr))) {
+		NL_SET_ERR_MSG(extack, "Cannot replace non-unicast fdb entries");
+		return -EOPNOTSUPP;
+	}
+
 	/* Do not allow an externally learned entry to take over an entry added
 	 * by the user.
 	 */
@@ -1018,22 +1048,18 @@ static int vxlan_fdb_update_existing(struct vxlan_dev *vxlan,
 	}
 
 	if ((flags & NLM_F_REPLACE)) {
-		/* Only change unicasts */
-		if (!(is_multicast_ether_addr(f->key.eth_addr) ||
-		      is_zero_ether_addr(f->key.eth_addr))) {
-			if (nhid) {
-				rc = vxlan_fdb_nh_update(vxlan, f, nhid, extack);
-				if (rc < 0)
-					return rc;
-			} else {
-				rc = vxlan_fdb_replace(f, ip, port, vni,
-						       ifindex, &oldrd);
-			}
-			notify |= rc;
+		/* Only change unicasts; non-unicast replace is rejected
+		 * before any state is modified.
+		 */
+		if (nhid) {
+			rc = vxlan_fdb_nh_update(vxlan, f, nhid, extack);
+			if (rc < 0)
+				return rc;
 		} else {
-			NL_SET_ERR_MSG(extack, "Cannot replace non-unicast fdb entries");
-			return -EOPNOTSUPP;
+			rc = vxlan_fdb_replace(f, ip, port, vni,
+					       ifindex, &oldrd);
 		}
+		notify |= rc;
 	}
 	if ((flags & NLM_F_APPEND) &&
 	    (is_multicast_ether_addr(f->key.eth_addr) ||

diff --git a/tools/testing/selftests/net/fib_nexthops.sh b/tools/testing/selftests/net/fib_nexthops.sh
index 431d7bed76224..bdc23205bde4c 100755
--- a/tools/testing/selftests/net/fib_nexthops.sh
+++ b/tools/testing/selftests/net/fib_nexthops.sh
@@ -547,6 +547,15 @@ ipv6_fdb_grp_fcnal()
 	run_cmd "$BRIDGE fdb append 02:02:00:00:00:17 dev vx10 dst 2001:db8:91::11 self dynamic"
 	log_test $? 255 "Fdb mac append with nexthop group and dynamic state"
 
+	# fdb entries with a nexthop group cannot take a remote append
+	run_cmd "$BRIDGE fdb add 00:00:00:00:00:00 dev vx10 nhid 102 self static"
+	run_cmd "$BRIDGE fdb append 00:00:00:00:00:00 dev vx10 dst 2001:db8:91::11 self"
+	log_test $? 255 "Fdb append with nexthop group"
+
+	# fdb entries with a nexthop group cannot be replaced with a non-unicast MAC
+	run_cmd "$BRIDGE fdb replace 00:00:00:00:00:00 dev vx10 dst 2001:db8:91::11 self permanent"
+	log_test $? 255 "Fdb replace with nexthop group"
+
 	run_cmd "$IP -6 ro add 2001:db8:101::1/128 nhid 66"
 	log_test $? 2 "Route add with fdb nexthop"
 
@@ -697,6 +706,15 @@ ipv4_fdb_grp_fcnal()
 	run_cmd "$BRIDGE fdb append 02:02:00:00:00:17 dev vx10 dst 10.0.0.3 self dynamic"
 	log_test $? 255 "Fdb mac append with nexthop group and dynamic state"
 
+	# fdb entries with a nexthop group cannot take a remote append
+	run_cmd "$BRIDGE fdb add 00:00:00:00:00:00 dev vx10 nhid 102 self static"
+	run_cmd "$BRIDGE fdb append 00:00:00:00:00:00 dev vx10 dst 10.0.0.3 self"
+	log_test $? 255 "Fdb append with nexthop group"
+
+	# fdb entries with a nexthop group cannot be replaced with a non-unicast MAC
+	run_cmd "$BRIDGE fdb replace 00:00:00:00:00:00 dev vx10 dst 10.0.0.3 self permanent"
+	log_test $? 255 "Fdb replace with nexthop group"
+
 	run_cmd "$IP ro add 172.16.0.0/22 nhid 16"
 	log_test $? 2 "Route add with fdb nexthop"
 
-- 
2.43.7
