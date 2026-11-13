Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.215
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794578720;
	b=AtUGbjJwe9eR8fFEugQo0zJTVinLigEXaLhhtCk78zDLBu3rcpul5UW52KtbD4uYFMdP
	 fARuQ4KEB1905ayNA9oCSe6zYAIwfRq7qI4Q4YVLvQ0sjj16QRq5Y7DH8R9D7d/ffxxPy
	 g4rP13+qpjS9GepkVC2M2KOqkWYjrrFtVYmCOyaC+RRkc0gd2NXw5T7TXupgWAgQonfQ3
	 yIT2e4v+EQ4FzbffDf37MzCpoB6Ys496M6RyDmxF/0m6yolJj9UfDNxmEmGun0kUt7vUq
	 ukeHclWqv/Kh+A9gTP7IrzgKMbU27ymdNwPwCJ+10IjhlivttV+VBKX6VmwFfOcv49g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794578720;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=SlpQ/7a9Yqm+ZiMx7oXq59cdcuwXe5p5JRNVxMV8F3c=;
	b=hI7g5GAQCu/ykOSrPGVuOK65Pg/VbHkb4LtIvIbqfHTRmnAtNZ+LkZwEXeLoVx8jMAxz
	 9ItGQv+Be5/xrT0jT9Nnv6kNv1zRxztbFYQKlqxxDrcDauePNVPZk2Wjk/Wq3SDy3bmzZ
	 w8a5aBDkq/1pKzb1NO6y5v1RrygD/qP2XhIw+ycv0J33bkK7+3j3PKwAKoChLWw+2pEps
	 l+Hmu0YpCHgGAv9d9We5eCXSGEaCiCEZgJWKMHA/6F0HnviWgKAvcmVUqdjgyLEy774CE
	 bzKwxRFsa2a/fsUy8JjHAh1YyAiytSTo/uMnjaWY6PiOD0Xskx8QLBhBq4C23Dgbygg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Tv5bjAT4;
	arc=none smtp.remote-ip=91.218.175.215
Received: from mta0.migadu.com (out-215.mta0.migadu.com [91.218.175.215])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E610606A880
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 14:05:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E610606A880
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Tv5bjAT4
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=lORxiaT4S+dXvPTgqqdRAwscXD8NtfpinPOcyAdcH5Q=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794578718; v=1; x=1795183518;
 b=Tv5bjAT4weVjQ9z63Hu5CwWTzbxTRke6D2N4TZtYYcTz876t/1ylOuh7AD4pHJv54OGrWXIv
 ObGJVk/89fbuIoyWMAZKjR5SbgBJhmwYRYoWGU4KCj6zrMFB4iSjFe9YitxBQuzZWOwsi68QfQL
 3KFgSGAsJxd/H/H1xhomaf5Q=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta10.migadu.com with ESMTPS id 22ebd3595901d641;
	Fri, 13 Nov 2026 14:05:14 +0000
X-Mizu-Trace-ID: 22ebd3595901d641
X-Migadu-Flow: FLOW_OUT
From: Hangbin Liu <hangbin.liu@linux.dev>
Date: Fri, 13 Nov 2026 22:04:17 +0800
Subject: [PATCH net-next 2/6] bonding: finish XDP setup before publishing
 the slave
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
Message-Id: <20261113-bond_enslave_restruct-v1-2-364c549e78db@kylinos.cn>
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

bond_enslave() currently runs the fallible XDP setup
(dev_xdp_propagate()) after the slave has already been published:
slave_cnt is incremented, ns maddrs are added and the active slave
may have been selected. If XDP setup then fails, the error path
jumps to err_sysfs_del and leaks:

  - the promiscuity/allmulti increments and synced addresses applied
    to the slave earlier in the function, which are only undone on
    an immediate allmulti failure,
  - the ns maddrs added just before the failure, which no enslave
    error path ever removes.

Move dev_xdp_propagate() to the last fallible step, right after the
promiscuity/allmulti/address-sync block and before
WRITE_ONCE(bond->slave_cnt), so that no handled fallible call
follows the publication of the slave and a failure can no longer
leak slave_cnt or ns maddrs.

bond_xdp_set_features() is moved along with this reordering so XDP
features are updated before the slave is published. Route the XDP
failure through a new err_set_xdp label that undoes the promiscuity,
allmulti and address-sync state, mirroring what __bond_release_one()
does.

Signed-off-by: Hangbin Liu <liuhangbin@kylinos.cn>
---
 drivers/net/bonding/bond_main.c | 52 +++++++++++++++++++++++++----------------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 340af4c3fa20..80b6c18ee9c2 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2313,22 +2313,11 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		}
 	}
 
-	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
-	netdev_compute_master_upper_features(bond->dev, true);
-	bond_set_carrier(bond);
-
-	/* Needs to be called before bond_select_active_slave(), which will
-	 * remove the maddrs if the slave is selected as active slave.
+	/* XDP capability and prog-count were already validated above.
+	 * Setup runs as the last fallible step before the slave is
+	 * published, so no undo of this block can ever be needed and
+	 * a failure here cannot leak slave_cnt or ns maddrs.
 	 */
-	bond_slave_ns_maddrs_add(bond, new_slave);
-
-	if (bond_uses_primary(bond)) {
-		block_netpoll_tx();
-		bond_select_active_slave(bond);
-		unblock_netpoll_tx();
-	}
-
-	/* XDP capability and prog-count were already validated above */
 	if (bond->xdp_prog) {
 		struct netdev_bpf xdp = {
 			.command = XDP_SETUP_PROG,
@@ -2341,19 +2330,35 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 		if (res < 0) {
 			/* ndo_bpf() sets extack error message */
 			slave_dbg(bond_dev, slave_dev, "Error %d calling ndo_bpf\n", res);
-			goto err_dec_slave_cnt;
+			goto err_set_xdp;
 		}
 		if (bond->xdp_prog)
 			bpf_prog_inc(bond->xdp_prog);
 	}
 
+	bond_xdp_set_features(bond_dev);
+
+	/* Must called before bond_update_slave_arr() or bond_select_active_slave() */
+	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt + 1);
+	netdev_compute_master_upper_features(bond->dev, true);
+	bond_set_carrier(bond);
+
+	/* Needs to be called before bond_select_active_slave(), which will
+	 * remove the maddrs if the slave is selected as active slave.
+	 */
+	bond_slave_ns_maddrs_add(bond, new_slave);
+
+	if (bond_uses_primary(bond)) {
+		block_netpoll_tx();
+		bond_select_active_slave(bond);
+		unblock_netpoll_tx();
+	}
+
 	/* broadcast mode uses the all_slaves to loop through slaves. */
 	if (bond_mode_can_use_xmit_hash(bond) ||
 	    BOND_MODE(bond) == BOND_MODE_BROADCAST)
 		bond_update_slave_arr(bond, NULL);
 
-	bond_xdp_set_features(bond_dev);
-
 	slave_info(bond_dev, slave_dev, "Enslaving as %s interface with %s link\n",
 		   bond_is_active_slave(new_slave) ? "an active" : "a backup",
 		   new_slave->link != BOND_LINK_DOWN ? "an up" : "a down");
@@ -2363,8 +2368,15 @@ int bond_enslave(struct net_device *bond_dev, struct net_device *slave_dev,
 	return 0;
 
 /* Undo stages on error */
-err_dec_slave_cnt:
-	WRITE_ONCE(bond->slave_cnt, bond->slave_cnt - 1);
+err_set_xdp:
+	if (!bond_uses_primary(bond)) {
+		if (bond_dev->flags & IFF_PROMISC)
+			dev_set_promiscuity(slave_dev, -1);
+		if (bond_dev->flags & IFF_ALLMULTI)
+			dev_set_allmulti(slave_dev, -1);
+		if (bond_dev->flags & IFF_UP)
+			bond_hw_addr_flush(bond_dev, slave_dev);
+	}
 
 err_sysfs_del:
 	bond_sysfs_slave_del(new_slave);

-- 
2.56.0

