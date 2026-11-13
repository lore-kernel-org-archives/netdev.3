Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.89
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578689;
	b=JRu8KNJwSjfywfAf13ezb87QUpayXCe08qYFMudFA0ycYTDa1cyRWGa+UeUfv6c/H8vd
	 xBccJKi0+i8QKfbQyzVw4xeYghlpyhahagZIIEs2pLQYfScogVLizSuXtHDN9wwdU+Tu7
	 fJ/HCBk6cD8gHdDFm2VMASQiC5JZgwFpePRKX7n/5jO0ka9OPhQQfGGmPr5IVSYEAAPrY
	 MRN++GnTh4oGJgDs5EdU6u20wPk/a2vhkZ4IT7TGmyM+oqo60cbY7plP62Y+/0aYCs2Ap
	 XLSdBQCgCXzIKwRKh7fi+Lu0RIXzkvRlERPoyj7O6DxbjoOTlS75cduMph/3cLKCGTA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578689;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=BsarNdDcELDCRT4vRowZfLgwyV4i1A1v6qpcoSVNtx8=;
	b=YqLaj6bGIk36PDhyVKv942cr6tPIfrNkRKO0+nKLcjasHOf/799iPFUuTxKVP2kY9tET
	 cGSatj8pYADuJPjcpuv8+LZMsqMpX/0Vhz3Ictm30l7YtkFEnz30618sZ9b4jJ6W2AqG0
	 TyfW0jdje/QsglDh4KNkwWw3eVjss0yXp+5ODbDeywGytUJ/zUA6G+bkoJKq1jdzzXn9U
	 8D7TaOVkxB8SgG+jPgixnwFnts/R7htFT3THVkWf5mnuDt2hrA0g/skbFTAIhDyBy/cak
	 G9Vo0F7Hoyv0sRrY3ITjY0makahcmt8TwcNlloqyDqBbXuOyiBTSimvK/raUZytP7ow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=O9azDaxF;
	arc=none smtp.remote-ip=95.215.58.89
Received: from mta1.migadu.com (out-89.mta1.migadu.com [95.215.58.89])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 377A0606A32D
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 14:04:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 377A0606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=O9azDaxF
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ZOfYh6YPB2Sv6k4DdDXOwO25Wt/mi8Pvf9+HOTqR3EY=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794578687; v=1; x=1795183487;
 b=O9azDaxFQiNr+oLOhYhRPRNUyuZ/gTpr63cgMQ/hII4gKKW3OcJeYJK+YR9ATKrztuonxP0V
 yoKG58moblLbZ+gIIsTM1mzt8qwz6tUNVJq9dD/HTz6HFWldxXTMPo7B6Fkr+ruI3YYXWxK33op
 EELDNlevPUwJH+wlhiMXH4bU=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id d5dff555396fe74e;
	Fri, 13 Nov 2026 14:04:47 +0000
X-Mizu-Trace-ID: d5dff555396fe74e
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Fri, 13 Nov 2026 22:04:16 +0800
Subject: [PATCH net-next 1/6] bonding: check XDP support before enslaving
 changes state
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
Message-Id: <20261113-bond_enslave_restruct-v1-1-364c549e78db@kylinos.cn>
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

The XDP capability checks (ndo_bpf/ndo_xdp_xmit) and the slave XDP
program count check in bond_enslave() run after the slave has already
been opened, attached and made visible to the datapath. In particular
the slave can become bond->curr_active_slave, or be published via
bond->slave_cnt, before we verify that slave_dev->netdev_ops->ndo_xdp_xmit
exists, so bond_xdp_xmit() may call a NULL ndo_xdp_xmit.

Move both checks to the validation section at the top of bond_enslave(),
before the first state change. On failure nothing has been mutated yet,
so the function can return directly. The dev_xdp_propagate() setup is
left in place for now and still uses the same error path.

Error messages and errno values are unchanged (-EOPNOTSUPP with the
same netlink extack strings), and the success path is unaffected
beyond running the read-only checks earlier.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 drivers/net/bonding/bond_main.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 9249a79a168e..340af4c3fa20 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1948,6 +1948,23 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		return -EPERM;
 	}
 
+	/* Check XDP support before any state change, so a slave without
+	 * XDP can never become visible to bond_xdp_xmit().
+	 */
+	if (bond->xdp_prog) {
+		if (!slave_ops->ndo_bpf || !slave_ops->ndo_xdp_xmit) {
+			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
+				     "Slave does not support XDP");
+			return -EOPNOTSUPP;
+		}
+
+		if (dev_xdp_prog_count(slave_dev) > 0) {
+			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
+				     "Slave has XDP program loaded, please unload before enslaving");
+			return -EOPNOTSUPP;
+		}
+	}
+
 	/* set bonding device ether type by slave - bonding netdevices are
 	 * created with ether_setup, so when the slave type is not ARPHRD_ETHER
 	 * there is a need to override some of the type dependent attribs/funcs.
@@ -2311,15 +2328,8 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		unblock_netpoll_tx();
 	}
 
-	if (!slave_dev->netdev_ops->ndo_bpf ||
-	    !slave_dev->netdev_ops->ndo_xdp_xmit) {
-		if (bond->xdp_prog) {
-			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
-				     "Slave does not support XDP");
-			res = -EOPNOTSUPP;
-			goto err_dec_slave_cnt;
-		}
-	} else if (bond->xdp_prog) {
+	/* XDP capability and prog-count were already validated above */
+	if (bond->xdp_prog) {
 		struct netdev_bpf xdp = {
 			.command = XDP_SETUP_PROG,
 			.flags   = 0,
@@ -2327,13 +2337,6 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 			.extack  = extack,
 		};
 
-		if (dev_xdp_prog_count(slave_dev) > 0) {
-			SLAVE_NL_ERR(bond_dev, slave_dev, extack,
-				     "Slave has XDP program loaded, please unload before enslaving");
-			res = -EOPNOTSUPP;
-			goto err_dec_slave_cnt;
-		}
-
 		res = dev_xdp_propagate(slave_dev, &xdp);
 		if (res < 0) {
 			/* ndo_bpf() sets extack error message */

-- 
2.56.0

