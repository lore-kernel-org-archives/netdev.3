Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578802;
	b=wIsMF2Pr6prv0o1r8SOzrO+yziYOSCXplg1Hu3ckw+dXhmZwYusgq+7I5AJqTxadyYQb
	 dpy4FPWK/3IfuJEdBSSOCjnX3J/NyFOFjirotgEJqmCHnaH4VYqCqVLVvFnF3gmFAwda9
	 RSofU9f8WSC+IajQZoAW3XQvwrJZq7t73tKXordcsla6ZKmYxlM/EZ2uSLmcrQG2KsS7E
	 SL46TQUEnbYt3RZO5y5X6zQqRr/mpYESP29JUdkQk8nQ9MMNsqD2GmVeKMnHhLnU1fFPk
	 D9GyFhI8/HtiiqLNvPobWmBWBfGLzZIgEgXwifks2n76rum8zVJmn9O9b8+QQkLs2Qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578802;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=7f9bU/O3D+ruldPY+B0WgXy7NAz35uXsO9r/E1V0JMU=;
	b=e1Ano1w4/nuSc5lyXglnV7YqjwrnFWpDb0A0zLbxZytNuTM91kwofNWzBA86Z6xIuNYV
	 kevK5efZIHwHI86M6SZ7Wpq3XIpMN3YiH7bfvr9SKKuaa3iv4RgIlFB1zzIkkUrJ5zfng
	 xPt2b/92uCxmA/vznbEmUofkRnuRxtopltmc3Ytrsr+u147vi4ium+t0Ij3V3vBomPDGy
	 kT0/0/2YpUhZgpmI6GD28sN9ekwAm0/jJiviZRKujfRdMjGafgf/C9ZNQRvYp72NC2PsB
	 jvm3fFrYjcs3HWwY9CAo4B97LxqxVsSUAAd/qy9Oo0xyOzOpL1GBXBdTHJwinaaSRjg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZE7sH7DZ;
	arc=none smtp.remote-ip=91.218.175.9
Received: from mta0.migadu.com (out-9.mta0.migadu.com [91.218.175.9])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6925606A32E
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 14:06:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6925606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=ZE7sH7DZ
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=b5LPlkeB/6xMio1zmdhb8ss8/a+9v/3+hmivnjp4xNU=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794578799; v=1; x=1795183599;
 b=ZE7sH7DZtyH8E0lIKKyNtzX89EgawHU0egfmGScivh0HC3MHMyNfFBJYtbga2RdTczT5Q+DU
 6615FT0vCi27fIfkB4BEeMKbsIvTmZAxoszEQDC9AXCtdHR92tWUtMeU4qmG7r1qNR0I1iEF6wS
 36bCUyNXYLHenzFdf1oGAKHc=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id d5599e53cf4d0115;
	Fri, 13 Nov 2026 14:06:39 +0000
X-Mizu-Trace-ID: d5599e53cf4d0115
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Fri, 13 Nov 2026 22:04:21 +0800
Subject: [PATCH net-next 6/6] bonding: factor out bond_enslave_validate
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
Message-Id: <20261113-bond_enslave_restruct-v1-6-364c549e78db@kylinos.cn>
References: <20261113-bond_enslave_restruct-v1-0-364c549e78db@kylinos.cn>
In-Reply-To: <20261113-bond_enslave_restruct-v1-0-364c549e78db@kylinos.cn>
To: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>
Cc: Hangbin Liu <hangbin.liu@linux.dev>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Hangbin Liu <hangbin.liu@linux.dev>
X-Mailer: b4 0.16.0

From: Hangbin Liu <liuhangbin@kylinos.cn>

bond_enslave() is a long linear function whose flow is hard to see
behind the inline blocks. Factor out bond_enslave_validate to do
all read-only checks.

Failures return directly, no undo needed at that point.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 drivers/net/bonding/bond_main.c | 36 +++++++++++++++++++++++++++---------
 1 file changed, 27 insertions(+), 9 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 5e36612cfaec..8f97b0e2c0b3 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1935,17 +1935,16 @@ static void bond_publish_slave(struct bonding *bond, struct slave *slave)
 		bond_update_slave_arr(bond, NULL);
 }
 
-/* enslave device <slave> to bond device <master> */
-int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
-		 struct netlink_ext_ack *extack)
+/* Fail-fast validation of the slave and the bond.  Everything here
+ * reads state only, so a failure needs no undo.  Must stay ahead of
+ * the first mutation in bond_enslave().
+ */
+static int bond_enslave_validate(struct net_device *bond_dev,
+				 struct net_device *slave_dev,
+				 struct netlink_ext_ack *extack)
 {
 	struct bonding *bond = netdev_priv(bond_dev);
-	const struct net_device_ops *slave_ops = slave_dev->netdev_ops;
-	int orig_fail_over_mac = bond->params.fail_over_mac;
-	struct slave *new_slave = NULL, *prev_slave;
-	bool alb_initialized = false;
-	struct sockaddr_storage ss;
-	int res = 0, i;
+	int res;
 
 	if (slave_dev->type == ARPHRD_CAN) {
 		BOND_NL_ERR(bond_dev, extack,
@@ -2010,6 +2009,25 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			return res;
 	}
 
+	return 0;
+}
+
+/* enslave device <slave> to bond device <master> */
+int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
+		 struct netlink_ext_ack *extack)
+{
+	struct bonding *bond = netdev_priv(bond_dev);
+	const struct net_device_ops *slave_ops = slave_dev->netdev_ops;
+	int orig_fail_over_mac = bond->params.fail_over_mac;
+	struct slave *new_slave = NULL, *prev_slave;
+	bool alb_initialized = false;
+	struct sockaddr_storage ss;
+	int res = 0, i;
+
+	res = bond_enslave_validate(bond_dev, slave_dev, extack);
+	if (res)
+		return res;
+
 	/* set bonding device ether type by slave - bonding netdevices are
 	 * created with ether_setup, so when the slave type is not ARPHRD_ETHER
 	 * there is a need to override some of the type dependent attribs/funcs.

-- 
2.56.0

