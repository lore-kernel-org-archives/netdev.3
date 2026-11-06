Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.80
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793928894;
	b=htX7eYiUQHlPbD4iQ3Ev0UGVoOmfRwwvmIZH3CA0i22qRxHvib3Kk2yUR0E6JMhD4F1Q
	 VDhSVD1hEfOHlorA91BJvtfhEuNYtV0HB7U6KLswkBDmS46WBPYvWGmnQbOfo52GLFdct
	 IUMdaxCP+iDxZ24SM2XLFIh+xcE9/PZUpiG/mbTTCnLu11ptzJTnfnsLRMGLUF07VVg8I
	 z6DInmAq91OWoeZXVV3s9dCyzS84hWoDOMxGyvC4r5MvIBD9R60oMghAgmrFzGuKpJray
	 yQOffuvAgG1krfegWEGMcjtGS9kLN8T+WjX+FY00/KLEwoqr/yRjSFCBOL9KPvwqOZw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793928894;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:X-B4-Tracking:
	 X-Change-ID:To:Cc:X-Mailer;
	bh=37zF0J9YNQQfNg00zUsp96qSKKkGdLAWq7jkYoSVkEw=;
	b=d4jSpR2co8DRH6ibYHwl2+Rr0N1s+nOWfiFHmlD4Qc/yOTyzRwJoYdkegvIeY9CqB4ai
	 274i9hpccyfzYDzD9+MrUAW+T76tYgvmHk2uPwckShDILGZISQn2hmKzkcchWNWnZ96TR
	 CDM93F4Sl0iJ8RRjbmMs2RsIcW/x9ZB1Q2MIMUCHF6VaKGp+nlak5hcU5LqQezJyNKs/t
	 WP8mQVsvqQvQokM/3NnPNqM+gZYaUZlni4ZSlqILHEp7lLTRByiE7L6Py1W5eR2u0hV+J
	 YJ04Y6ON+XFqm0vuhhCLokS0r1OdGR9ktV9nw/41uYOl31KM7v+9WoQXuKmTQN9ZSpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=e3YSw8Ew;
	arc=none smtp.remote-ip=95.215.58.80
Received: from mta1.migadu.com (out-80.mta1.migadu.com [95.215.58.80])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFC1606A31B
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 01:34:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FFC1606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=e3YSw8Ew
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=YOPsIY4Tuyad8OkdA/iv+lBNUq8frqmfosXKiJVdAj4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793928890; v=1; x=1794533690;
 b=e3YSw8EwtMVJjgbTlXMguKv8bj5d1A7SL9MNQ4ZICLgvMkJBXAC+F0IS6vbsvXjXMQGhZlLK
 wQNXvKWBwZMYcOI3CIUBUjJIy99LFhumPQFKsZioBIYA5pFYy62jcLHotcEoL9IkMSQOzqucl/c
 ys2p2/Ev/tMtOH6H8/tSkHzk=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta11.migadu.com with ESMTPS id 81f11a3f24812833;
	Fri, 06 Nov 2026 01:34:50 +0000
X-Mizu-Trace-ID: 81f11a3f24812833
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Fri, 06 Nov 2026 09:34:32 +0800
Subject: [PATCH net RESEND v5] bonding: fix slave_cnt leak on XDP error
 paths
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
Message-Id: <20261106-bond_slave_cnt-v5-1-40857a722b6c@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XPwW7DIAwG4FepOI8JMCFkpx3W6w7rcaoqIGZFq
 8gUItSqyruXccrGzbb8/ZbvJOEcMJGX3Z3MmEMKUyxN97Qj7mziF9Iwlp4IJhTTrKd2iuMpXUz
 Gk4sL1Rp77TrPjB1IQT8z+nCtgZ8k4vI7+9gf9u9v5FjKc0jLNN/quczrUk0emPifnDnlFBQOn
 fXSKO9fv2+XEKf07GLNymLrofGieCZQ9MCkM6AaD1vffJah+K4fPVhwXjjbeLnxXDZeFj9yqZU
 0MKBif/y6rg8NFsCzfAEAAA==
X-Change-ID: 20260807-bond_slave_cnt-88e78c5f0ab9
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jussi Maki <joamaki@gmail.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
 Eric Dumazet <edumazet@kernel.org>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.16.0

From: Hangbin Liu <liuhangbin@kylinos.cn>

When bond_enslave() succeeds up to the XDP setup stage, slave_cnt is
already incremented. If XDP setup subsequently fails, the error paths
jump directly to err_sysfs_del, bypassing the slave_cnt decrement.

This causes slave_cnt to drift upward on each failed enslaving attempt,
which would lead to unbalanced traffic distribution with round-robin
mode.

Add an error out to make sure slave_cnt gets decreased correctly.

Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
This issue is found during code review. The reproducer is from
Eric's patch

  ip link add bond0 type bond mode balance-rr
  ip link set bond0 xdpdrv obj xdp_dummy.bpf.o sec xdp
  for i in 0 1 2; do
    ip link add d$i type dummy
    ip link set d$i master bond0   # fails: Slave does not support XDP
  done

num_slaves read via SIOCBONDINFOQUERY is 3 before this patch, 0 after.

For Sashiko:

This patch only focuses on fixing the bond_slave_cnt leak issue.

1. `bond_xdp_xmit()` may call the slave's `ndo_xdp_xmit` before checking
whether `slave->netdev_ops->ndo_xdp_xmit` exists. This is a separate issue
and I will address it in another patch.
2. `bond_slave_ns_maddrs_add()` and device promiscuous/allmulti error
handling are also separate issues, which I will fix separately.

PS: I'm working on a restruct of bond_enslave to fix all these issues.
---
Changes in v5:
- Re-post, no code change.
- Link to v4: https://lore.kernel.org/r/20260914-bond_slave_cnt-v4-1-d14864a39e60@kylinos.cn

Changes in v4:
- Revert to v1 version as the bond_select_active_slave() just under
  slave_cnt increase also calls bond_update_slave_arr() (sashiko)
- re-run all bonding selftests with debug kernel, all passed.
- Link to v3: https://lore.kernel.org/r/20260907-bond_slave_cnt-v3-1-57df3b3cf2cb@kylinos.cn

Changes in v3:
- move the slave_cnt increasement before bond_update_slave_arr() (selftest)
- run all bonding selftests on debug kernel to make sure no regression (Jakub)
- Link to v2: https://lore.kernel.org/r/20260903-bond_slave_cnt-v2-1-02e27304ca36@kylinos.cn

Changes in v2:
- move the slave_cnt increasement after XDP setup (Nikolay Aleksandrov)
- balance-xor mode is not affected, not mention it (Nikolay Aleksandrov)
- Link to v1: https://lore.kernel.org/r/20260902-bond_slave_cnt-v1-1-36e95bf4a6ff@kylinos.cn
---
 drivers/net/bonding/bond_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index a1c156c145b2..34f1b8083fbb 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2305,7 +2305,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
 				     "Slave does not support XDP");
 			res = -EOPNOTSUPP;
-			goto err_sysfs_del;
+			goto err_slave_cnt;
 		}
 	} else if (bond->xdp_prog) {
 		struct netdev_bpf xdp = {
@@ -2319,14 +2319,14 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
 				     "Slave has XDP program loaded, please unload before enslaving");
 			res = -EOPNOTSUPP;
-			goto err_sysfs_del;
+			goto err_slave_cnt;
 		}
 
 		res = dev_xdp_propagate(slave_dev, &xdp);
 		if (res < 0) {
 			/* ndo_bpf() sets extack error message */
 			slave_dbg(bond_dev, slave_dev, "Error %d calling ndo_bpf\n", res);
-			goto err_sysfs_del;
+			goto err_slave_cnt;
 		}
 		if (bond->xdp_prog)
 			bpf_prog_inc(bond->xdp_prog);
@@ -2348,6 +2348,9 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	return 0;
 
 /* Undo stages on error */
+err_slave_cnt:
+	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt - 1);
+
 err_sysfs_del:
 	bond_sysfs_slave_del(new_slave);
 

---
base-commit: fafbc4051123d5459ea6950899cec08ed946e278
change-id: 20260807-bond_slave_cnt-88e78c5f0ab9

Best regards,
--  
Hangbin Liu <liuhangbin@kylinos.cn>

