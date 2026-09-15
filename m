Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A1EC4749C2
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 09:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789462988; cv=none; b=HeljVH/+633F+b79xLpsxyTLlJ323E1cBtSTy2+VSIi4F2WjdrAqp/SvSleJDMyDPL+7Zcl+dDieKyUY87UdX5gE/hRoRYBXsD3ppn8xshtNceGgXlgYkdTU43BBYc06OXzzb1+PlxIUP4E7Bapl4Tc0jJvZ3tDerqzVRPstUUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789462988; c=relaxed/simple;
	bh=XhnIuLY9QZPb73XxQY1kYoiboxL1H7iH8fgi2qcNuTI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UTe2+sleclYSZCiW0AFMVFe7PrlAWIynDgvDCqS8Qn/fNvmYq78SfGnSGtdzxAG8Xxy3fQLjjUK9ufOb5hWQmQ4gILDQ8XUaMhe0xFaGp2drSFe/hNomzL8hVDWkeU8vvIJFqUpm9gsUIcMh342sBPDCXQb6ynuG1AKkuLo2UJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=O3MRHIyN; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="O3MRHIyN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Fn
	xrd90trm4ENDqPwGfwLpJyRkpE+Bwk0RgU2aNf/2Q=; b=O3MRHIyN25C53mDO8D
	t55uRYAK8l9P4jghR444KFNnwbyme4biVfqqcjKrpVOHon7L5VX9f6rxtieXwDZe
	bbrsrrBu8fywqj4CY/g9mPU1ybGMbi3eata70g70+oPE+hEtj9iwgo/Sz50VxhlW
	D2zGUF1VP8uGEu++FLH2NdbxQ=
Received: from kylin-ERAZER-H610M.. (unknown [])
	by gzga-smtp-mtada-g0-3 (Coremail) with SMTP id _____wD39yOPCalqkjtQAw--.46534S2;
	Tue, 15 Sep 2026 17:02:09 +0800 (CST)
From: Yun Lu <luyun_611@163.com>
To: jv@jvosburgh.net,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: razor@blackwall.org,
	maheshb@google.com,
	netdev@vger.kernel.org
Subject: [PATCH net] bonding: 3ad: select a port when the TX array is empty
Date: Tue, 15 Sep 2026 17:02:07 +0800
Message-ID: <20260915090207.110987-1-luyun_611@163.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD39yOPCalqkjtQAw--.46534S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxXrWrAFW8CF43Aw1rtFyDGFg_yoWrtFWrpF
	45JFyfCr4DAF42q3W2yF40kws8u34xAFy3WFZxGryDAFs0gr1q9FW2g340vryUJrZ5CFy7
	XFsIq3s09F4DArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jb73kUUUUU=
X-CM-SenderInfo: pox130jbwriqqrwthudrp/xtbCxBFrOmqpCZHR2QAA3X

From: Yun Lu <luyun@kylinos.cn>

During 802.3ad bond bring-up, userspace can observe carrier up while
ARP requests still fail to transmit. This can happen even though the
active aggregator already has ports eligible for transmission.

Commit 23de0d7b6f0e ("bonding: pair enable_port with
slave_arr_updates") made port enablement request an array rebuild, but
the rebuild remains asynchronous. The 802.3ad state machine enables a
port before queueing slave_arr_work. Until the worker publishes the new
usable_slaves array, the transmit path drops packets. RTNL contention
can prolong this window because the worker retries later.

When ordinary 802.3ad skb transmission finds an empty usable array,
select a port directly from the active aggregator. Hold mode_lock across
the counting and selection passes so aggregator reselection cannot expose
the intermediate state where all is_active flags are clear. The caller's
RCU read lock protects the slave lifetime.

Use the same bond_slave_can_tx() eligibility and list order as the array
path, so hash selection remains equivalent when the eligible set is
stable. Skip the fallback in netpoll context because TX may be re-entered
while mode_lock is already held.

Fixes: ee6377147409 ("bonding: Simplify the xmit function for modes that use xmit_hash")
Signed-off-by: Yun Lu <luyun@kylinos.cn>
---
 drivers/net/bonding/bond_main.c | 66 +++++++++++++++++++++++++++++++--
 1 file changed, 62 insertions(+), 4 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index a9bff7663eec..2cf280bf134f 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -5233,11 +5233,11 @@ static struct slave *bond_xmit_3ad_xor_slave_get(struct bonding *bond,
 	unsigned int count;
 	u32 hash;
 
-	hash = bond_xmit_hash(bond, skb);
 	count = slaves ? READ_ONCE(slaves->count) : 0;
 	if (unlikely(!count))
 		return NULL;
 
+	hash = bond_xmit_hash(bond, skb);
 	slave = slaves->arr[hash % count];
 	return slave;
 }
@@ -5289,9 +5289,65 @@ static bool bond_should_broadcast_neighbor(struct sk_buff *skb,
 	return false;
 }
 
-/* Use this Xmit function for 3AD as well as XOR modes. The current
- * usable slave array is formed in the control path. The xmit function
- * just calculates hash and sends the packet out.
+/* Called with RCU and bond->mode_lock held. */
+static bool bond_3ad_slave_is_eligible(struct slave *slave)
+{
+	const struct aggregator *agg;
+
+	agg = rcu_dereference(SLAVE_AD_INFO(slave)->port.aggregator);
+	return agg && agg->is_active && bond_slave_can_tx(slave);
+}
+
+/* Called with RCU held when the transmit array has not caught up with
+ * the 802.3ad state machine. Do not enable ports here: use the same
+ * eligibility checks as bond_update_slave_arr().
+ */
+static struct slave *bond_3ad_xmit_fallback(struct bonding *bond, u32 hash)
+{
+	struct slave *selected = NULL;
+	unsigned int eligible = 0;
+	unsigned int target;
+	struct list_head *iter;
+	struct slave *slave;
+
+	/* Netpoll can re-enter TX while the state machine holds mode_lock.
+	 * Keep the existing empty-array drop behavior in that context.
+	 */
+	if (unlikely(netpoll_tx_running(bond->dev)))
+		return NULL;
+
+	/* Aggregator selection temporarily clears all is_active flags. Keep
+	 * both loops under mode_lock to avoid observing that intermediate
+	 * state. The caller's RCU read lock protects the selected slave.
+	 */
+	spin_lock_bh(&bond->mode_lock);
+	bond_for_each_slave_rcu(bond, slave, iter)
+		if (bond_3ad_slave_is_eligible(slave))
+			eligible++;
+
+	if (!eligible)
+		goto out;
+
+	target = hash % eligible;
+	bond_for_each_slave_rcu(bond, slave, iter) {
+		if (!bond_3ad_slave_is_eligible(slave))
+			continue;
+
+		if (!target) {
+			selected = slave;
+			break;
+		}
+		target--;
+	}
+
+out:
+	spin_unlock_bh(&bond->mode_lock);
+	return selected;
+}
+
+/* Use this Xmit function for 3AD as well as XOR modes. The usable slave
+ * array is formed in the control path.  In 3AD mode, fall back to the
+ * current port state while an empty array awaits an update.
  */
 static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff *skb,
 				     struct net_device *dev)
@@ -5302,6 +5358,8 @@ static netdev_tx_t bond_3ad_xor_xmit(struct sk_buff *skb,
 
 	slaves = rcu_dereference(bond->usable_slaves);
 	slave = bond_xmit_3ad_xor_slave_get(bond, skb, slaves);
+	if (unlikely(!slave) && BOND_MODE(bond) == BOND_MODE_8023AD)
+		slave = bond_3ad_xmit_fallback(bond, bond_xmit_hash(bond, skb));
 	if (likely(slave))
 		return bond_dev_queue_xmit(bond, skb, slave->dev);
 
-- 
2.43.0

