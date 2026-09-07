Received: from mta1.migadu.com (out-225.mta1.migadu.com [95.215.58.225])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0987175A6C
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.225
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788764893; cv=none; b=Rk0/iK1NarqwVtWRPPdYhhIWmUXu2a6Bp7betzGtzQ2Ux3P12kKPu0VvbyKp6fXQ/e8hN/xkFZmJz3bVf5os0034GktU/E5u5k/mQDO5+WHY9rp6o4nZdvYglura0JJ2SNoeRyC3Xjf5KdGm1KjDX/NLhsQOXNpf6LINkQQUz8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788764893; c=relaxed/simple;
	bh=nV5+II1fALDOgMZJw5NeP0syCJgew30SZ/qsXoP2ri8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CB7hpU2kuOxmOT1CWnIxkGF9Aqeo/BAEcumNbu/0fg9aM0rd2aYVlQijXSlcCb5+RGd85721YN5K8i1alEa3rvvow2kQxy0qpkgaY79vVdYs6zZreVZXf95YJUanUFYEP60D7kBhjE0dQ5B5Ev/ndJcKaeOHoLZng2CZfC0Dpo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=t7/oRxAy; arc=none smtp.client-ip=95.215.58.225
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="t7/oRxAy"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=nV5+II1fALDOgMZJw5NeP0syCJgew30SZ/qsXoP2ri8=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788764889; v=1; x=1789369689;
 b=t7/oRxAyb8OVWEHLBww5ojvoT6l7bKkuIYYfJm3HAJPvSVbjC6vNY+I2iljacK+esk9rHlBT
 TTA4TYQF8d31yNMJBn9nWMdDsC1yDMYEbw584eaWvFtAWaZt6mRO9t1ehVWAMEAuLFBbenN+vdS
 wfiUZ2ZRv803x++b/fkEBUHE=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7c224f9ee2c31f1d;
	Mon, 07 Sep 2026 07:08:09 +0000
X-Mizu-Trace-ID: 7c224f9ee2c31f1d
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Mon, 07 Sep 2026 15:07:53 +0800
Subject: [PATCH net v3] bonding: fix slave_cnt leak on XDP error paths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-bond_slave_cnt-v3-1-57df3b3cf2cb@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNywrDIBREf6XcdS1GE2O66n+UEoy5NtKgRYM0h
 Px7xVUfy5nhnNkgYrAY4XzYIGCy0XqXAz8eQE/K3ZHYMWdglAkqaUsG78Y+ziphr91CpMRW6sZ
 QNXSQoWdAY19FeAWHC9xyOdm4+LCWk1SVqfg6yn59qSIV4QK7ZjC1EsZcHutsnY8n7YorsU+e/
 /Es85QhazmtteLii9/3/Q2wy7CP8gAAAA==
X-Change-ID: 20260807-bond_slave_cnt-88e78c5f0ab9
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Jussi Maki <joamaki@gmail.com>, 
 Nikolay Aleksandrov <razor@blackwall.org>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

When bond_enslave() succeeds up to the XDP setup stage, slave_cnt is
already incremented. If XDP setup subsequently fails, the error paths
jump directly to err_sysfs_del, bypassing the slave_cnt decrement.

This causes slave_cnt to drift upward on each failed enslaving attempt,
which would lead to unbalanced traffic distribution with round-robin
mode.

Fix it by moving the slave_cnt increase after XDP setup.

Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
Changes in v3:
- move the slave_cnt increasement before bond_update_slave_arr() (selftest)
- run all bonding selftests on debug kernel to make sure no regression (Jakub)
- Link to v2: https://lore.kernel.org/r/20260903-bond_slave_cnt-v2-1-02e27304ca36@kylinos.cn

Changes in v2:
- move the slave_cnt increasement after XDP setup (Nikolay Aleksandrov)
- balance-xor mode is not affected, not mention it (Nikolay Aleksandrov)
- Link to v1: https://lore.kernel.org/r/20260902-bond_slave_cnt-v1-1-36e95bf4a6ff@kylinos.cn
---
 drivers/net/bonding/bond_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index a9bff7663eec..1514a8ba0888 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2284,7 +2284,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		}
 	}
 
-	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
 	netdev_compute_master_upper_features(bond->dev, true);
 	bond_set_carrier(bond);
 
@@ -2332,6 +2331,9 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			bpf_prog_inc(bond->xdp_prog);
 	}
 
+	/* Increase the slave count before rebuilding the slave arrays. */
+	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
+
 	/* broadcast mode uses the all_slaves to loop through slaves. */
 	if (bond_mode_can_use_xmit_hash(bond) ||
 	    BOND_MODE(bond) == BOND_MODE_BROADCAST)

---
base-commit: 38b6be101006d3e7af972999f45d4f1e8250587a
change-id: 20260807-bond_slave_cnt-88e78c5f0ab9

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

