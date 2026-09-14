Received: from mta0.migadu.com (out-231.mta0.migadu.com [91.218.175.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDA51332EC1
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 03:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789355399; cv=none; b=HtGjWDfGqSoRdQvL2mF8PAJLayxDyjS/ge4/BsgBjFzGxsX2/E8L0xGCUuXeCXCb/RebiypS9DnEsa4zJX6YBrFHKPL+ipTLD+6ghWHoy3hWJFpqoW5qI0Z98IyK44rLpqodInebi301VWZKEHEJMgrjDPl3AQPxW1sBuahI5o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789355399; c=relaxed/simple;
	bh=x/tlIljtHGaFtS3P5GHlgvAiIORLGAfsGhOXJcwnhL0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=AsivZDFQBC7fvyeSoX5zU1jDfgRVLiMYaFmDGyof/sN226SlzWWZEpaO9IAGBuFoKF5VAXyBpX6UES1MmVsWw68v8Cxf9oadL3fSd3qt6SMxXjTgwFCZ8qz4GXhvdGAMqL/VNXCNZvNxo+7Us2t3+V3hZ7HW/mQvnNgNiUK6dXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jXTseMJL; arc=none smtp.client-ip=91.218.175.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jXTseMJL"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=x/tlIljtHGaFtS3P5GHlgvAiIORLGAfsGhOXJcwnhL0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789355391; v=1; x=1789960191;
 b=jXTseMJLVp8W4g1LiZKvA19lpBMXNr6h0PgyKXgwInP9AuOm7b5plYTQEvqxeF4+ej5tBjF8
 yDiELf82g7Vunw13F9YjLO9oTX1H22bCtHDTG5uHhJniP3o0EtwKk74BQ+PLYRSAmJDTTcMJ9Sw
 aVap5p64XoEv8lzNKsB3/kmc=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id febf35c63c55aa0e;
	Mon, 14 Sep 2026 03:09:51 +0000
X-Mizu-Trace-ID: febf35c63c55aa0e
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Mon, 14 Sep 2026 11:09:35 +0800
Subject: [PATCH net v4] bonding: fix slave_cnt leak on XDP error paths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-bond_slave_cnt-v4-1-d14864a39e60@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XPQQrDIBAF0KsU17UYTaLpqvcoJagZG2nQokEaQ
 u5ecZU2yz/D+8OsKEKwENH1tKIAyUbrXQ71+YT0KN0TsB1yRpTQlgjCsfJu6OMkE/TazVgI4EI
 3hkjVoYzeAYz9lMI7cjCjRx6ONs4+LOVIqsqq9HWE/velCleYtdA1ytSyNeb2WibrfLxoV7oS3
 Xt28DR7QoFyRmotWXvwbO8P/ySWfcMHwxTThmr147dt+wIcKFkAMgEAAA==
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

Add an error out to make sure slave_cnt gets decreased correctly.

Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
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
index a9bff7663eec..577d85c83804 100644
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
base-commit: e6b6078ea1731b05b3b552497b3bce4bf8b014ae
change-id: 20260807-bond_slave_cnt-88e78c5f0ab9

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

