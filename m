Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793784536;
	b=M5VPhq+uyJ5nGVG8moXftxaTQiI/7ZlT9SXa2SikOW547zQE4+fQ6T4h6Fsszd62yqTE
	 Wk7ALy+J7tuuHJrRHPqlgM4rEue1vjYXWEFU7F8CwHar93g9p15Hc7Y7GuOJa21MZnXTt
	 iLCGRcaFeVRZuzaWC9xQNOJtC4dsJZ98Ap+le0KRKPF/nTc2DOec5G9QCb48RfMWhGiCv
	 xBEEh1sQaNZvnNXwKZXb9G9dHYOCbCcE53P4Y1Dxne5FHIE5XqMaB2F62Nc10hoMdv3WW
	 oyiAzWAgpvYwP6LTKuRzGKViECriqe4sTz8IkbjVEI1kLWqil2IOt+Ir6NYMqV+oUTw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793784536;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=XomczbqO81jksJLTiYfHxljFLLWvatmb0xlxuK0Ew7w=;
	b=K5B/u4U3LV26C0QDBS9P8Pdo1LgwtZkm6EwiCw3kPd3KN5ROacXemdV/OuN0UGn5u57X
	 xOem8LmrwUj2OZ/n55sIilcg4pixj+YhpE6AjHQbLKPmVlNTEsAHLj03s/V1UoEb8AaEn
	 QlU2KIoXUzzwG7KAFQHElzJwPyT5SCjBdCULErUyDVzIFAPZLlf6uflvf3y4aiRh9ihQU
	 Ktpuom/Xu2Wk9Cy7zOpHAB8umBS7TIX+9reaVODhhH+qXveE6c9C3yBu8mMbiY7uAK4Ro
	 Kn/j/2dr5epmDX/PdAGnjGZKFOTrn9SfII/avzRpc6Cl22Bl7RSrxIw90nm7n24YGog==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLfMpCQa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5AD1606A331
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 09:28:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iLfMpCQa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1C501F0093A;
	Wed,  4 Nov 2026 09:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793784535;
	bh=XomczbqO81jksJLTiYfHxljFLLWvatmb0xlxuK0Ew7w=;
	h=From:To:Cc:Subject:Date;
	b=iLfMpCQaC5ijo7rZpH/q5m4DdJwurSWbepYDna/1js+8MdWMflqsyncCBdustGaR0
	 r2DYdpbZip58VShrbVnvXhr99UbYtAywbDOl52vl2q5EnGYaaGeL9D338adf+weQjX
	 Vb8IeS3pDi4196sb6MdIng/k/pAaFkrHL8denFvXUjiRLMa4dycTkug4xfQn/HLVYE
	 8wh1FmoBFqs82Uq4LJG//arkiIJKcjE0gbofEBBdV2oJX0mADxN4nsKCNDHKgJNTPV
	 VfPJUQ+eJBwZlDk/f1kCQXlvZaqhfTgbIGV/im6WLJ2PC52ujMy9bbaxAHlT41M/8l
	 pR+Gw7YDv04SQ==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Yun Lu <luyun@kylinos.cn>
Subject: [PATCH net] bonding: fix slave_cnt leak on XDP enslave failure
Date: Wed,  4 Nov 2026 10:28:51 +0100
Message-ID: <20261104092851.688361-1-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
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

bond_enslave() increments bond->slave_cnt before setting up XDP on the
new slave. If that setup fails (slave has no XDP support, already has
an XDP program, or dev_xdp_propagate() fails), the error path jumps to
err_sysfs_del, which never decrements slave_cnt.

Each failed enslave therefore leaves slave_cnt one too high:
- SIOCBONDINFOQUERY reports a wrong num_slaves,
- balance-rr picks slave ids beyond the end of the slave list, so
  bond_get_slave_by_id() falls back to the first usable slave and
  transmit is skewed toward it.

Reproducer:

  ip link add bond0 type bond mode balance-rr
  ip link set bond0 xdpdrv obj xdp_dummy.bpf.o sec xdp
  for i in 0 1 2; do
    ip link add d$i type dummy
    ip link set d$i master bond0   # fails: Slave does not support XDP
  done

num_slaves read via SIOCBONDINFOQUERY is 3 before this patch, 0 after.

Add an err_dec_slave_cnt label ahead of err_sysfs_del and use it from
the three XDP failure paths, which are the only failures after the
increment.

Fixes: 9e2ee5c7e7c3 ("net, bonding: Add XDP support to the bonding driver")
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Yun Lu <luyun@kylinos.cn>
---
Discovered while reviewing https://lore.kernel.org/netdev/20261104064409.281303-1-luyun_611@163.com/

 drivers/net/bonding/bond_main.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 7019e5d8fdc8..7a394d0eb186 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2305,7 +2305,7 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
 				     "Slave does not support XDP");
 			res = -EOPNOTSUPP;
-			goto err_sysfs_del;
+			goto err_dec_slave_cnt;
 		}
 	} else if (bond->xdp_prog) {
 		struct netdev_bpf xdp = {
@@ -2319,14 +2319,14 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
 				     "Slave has XDP program loaded, please unload before enslaving");
 			res = -EOPNOTSUPP;
-			goto err_sysfs_del;
+			goto err_dec_slave_cnt;
 		}
 
 		res = dev_xdp_propagate(slave_dev, &xdp);
 		if (res < 0) {
 			/* ndo_bpf() sets extack error message */
 			slave_dbg(bond_dev, slave_dev, "Error %d calling ndo_bpf\n", res);
-			goto err_sysfs_del;
+			goto err_dec_slave_cnt;
 		}
 		if (bond->xdp_prog)
 			bpf_prog_inc(bond->xdp_prog);
@@ -2348,6 +2348,9 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	return 0;
 
 /* Undo stages on error */
+err_dec_slave_cnt:
+	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt - 1);
+
 err_sysfs_del:
 	bond_sysfs_slave_del(new_slave);
 
-- 
2.53.0

