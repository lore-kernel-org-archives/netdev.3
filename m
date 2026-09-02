Received: from mta0.migadu.com (out-132.mta0.migadu.com [91.218.175.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966A838655D
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 05:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788326500; cv=none; b=Txy0R7oKlCj9zDWSle2WHVUgka5mKGtHwR8KKSdx8QnvpFpWkZ0X9yQ+UoipmhCo8BvBf7ISfFMPo8DKIeGmEhEG30VoyCLN+UTiZQquh23ySntwtQEkEnnRCImFmrydMdLx1kfFDHW/Ls7MUMCz2fbAvEr1KBuFL8tzPwOu8lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788326500; c=relaxed/simple;
	bh=f6+f493aMYuc/Qg8lsOD/q9BpPs3SvnuHJTjLCHX4XQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=jyGy1XX6n85CwC0lpwzOSvXcPcPEdHoXPYE9XlC8IpgXqeeht9+PUh/EbHdl2w/CKQrstjyitjK0YDL5T7shKiGj+z1XD59MRPdLLCT5+j4KLeouq6H1CRhFq0e8vc5inNdLOaMYPv2nBXzroWulElyPm+nqBliFfK31WOmT+mI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=i8n4E1RF; arc=none smtp.client-ip=91.218.175.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="i8n4E1RF"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=f6+f493aMYuc/Qg8lsOD/q9BpPs3SvnuHJTjLCHX4XQ=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788326495; v=1; x=1788931295;
 b=i8n4E1RFiOkpMJA4E1S38TnIfXJiMDdb8PG5o1mfp8Qimh4id2WL2NSkCqY/mC0Sm2UL2JzI
 u/f0XEyoPKsaPIUHo5GsdEs0dQNDiYabxVRXRqEoDeNIuX23bMFxqTAKzyNkAYCZrtY9ofkDFh1
 Nzv1+m/Us69YIPfB/D++6bFQ=
X-Envelope-To: netdev@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 92b0b4cd37434ed7;
	Wed, 02 Sep 2026 05:21:25 +0000
X-Mizu-Trace-ID: 92b0b4cd37434ed7
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Wed, 02 Sep 2026 13:21:12 +0800
Subject: [PATCH net] bonding: fix slave_cnt leak on XDP error paths
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260902-bond_slave_cnt-v1-1-36e95bf4a6ff@kylinos.cn>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MQQqAIBBA0avIrBNMqKyrRITZVAMxhoYE4d2Tl
 m/x/wsRA2GEQbwQMFEkzwV1JcAdlneUtBaDVrpVRnVy8bzO8bQJZ8e3NAY745pN2aWHEl0BN3r
 +4QiMN0w5f0gzaW9lAAAA
X-Change-ID: 20260807-bond_slave_cnt-88e78c5f0ab9
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Daniel Borkmann <daniel@iogearbox.net>, Jussi Maki <joamaki@gmail.com>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>
X-Mailer: b4 0.14.3

From: Hangbin Liu <liuhangbin@kylinos.cn>

When bond_enslave() succeeds up to the XDP setup stage, slave_cnt is
already incremented. If XDP setup subsequently fails, the error paths
jump directly to err_sysfs_del, bypassing the slave_cnt decrement.

This causes slave_cnt to drift upward on each failed enslaving attempt,
which would lead to unbalanced traffic distribution with round-robin and
balance-xor mode.

Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 drivers/net/bonding/bond_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 947d92a669b6..0305a017e327 100644
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
base-commit: 70f3995830d3f1e79faa14eb0605914f778feca9
change-id: 20260807-bond_slave_cnt-88e78c5f0ab9

Best regards,
-- 
Hangbin Liu <liuhangbin@kylinos.cn>

