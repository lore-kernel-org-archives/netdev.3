Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30466387590
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 08:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459836; cv=none; b=fOmbUI7I8YerX9XQ6NdVQHuSdBx3cGFIPCzV4jbYDiJNH3UmEXEQwClao3/OSpG5YMElgEg2nQTuKAhITjRp2D3TlPyvn7V90xoKLTmEMI1IaXMrBTHr2VcNTAPSeDw/pogB9QnCzBUtHt3xX4mymrtX65nRMP6bQBfaWNRZOG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459836; c=relaxed/simple;
	bh=Fg/UOYCqOAErurKdRS1w3bl8OU8Z0eji77SSiyx26Zw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=VNHGVb6qfNNnk6Nkt8ozx3JIJEN6jpoghbk3sdal+6RWUE0bG25bRNa7bligc+qOgMZHlxzuY7Jk6EK1N/JmhbdCrX0XWLEnc7lH97i3iZZWi0SgnW6k/Li2F6du1suiIqZpAhP0dVy4jkWtKCpEltxlMuUTwReZ7phQ3Nc2UEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUKpu7hO; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUKpu7hO"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747ed1368so28793575ad.1
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 01:10:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789459834; x=1790064634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=AwbPDrXYNDMt3RqOHL+ae9V5b1oGuxYSFTMBTjsuwrM=;
        b=WUKpu7hOmIEVJ+uFO3AYSh461WZPfAe7qjEHv9n5xF/zevDjq9dLcp4ahYtaPGBKGb
         B1iJj0WJIY01uKtcEYerdRjFm0QFk8hGc7I+mTfeqkjwXrM/RppOFj8yQi12I6kJbgHS
         FS+TpylIM0Aih0+QxFVcfjimNWGHH+QXrzwejuBQ3oDMJ942oBRJ+cW9C4QL7W0/IUXI
         WSVyqcGlO32m1amHPbZbRehbfTb8H60YXFrrC2/NUVhfzr37l/+64z/VnEUJM2fjvoPu
         0SL6cFerO5V5i8p2DzUbMwZFyRGRmRI/DmDVYSf71URVOWJMwEMZ7BN2YfVTgNFSXFdo
         StAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789459834; x=1790064634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=AwbPDrXYNDMt3RqOHL+ae9V5b1oGuxYSFTMBTjsuwrM=;
        b=D0BHzAPBKyvdUWN68wf9TPwGYgV+N6kY1Z2W2gU1rlM4kbtZ0dVEXtDVX9qkm3jvPJ
         7qJlG/XzZ7hPg2qv+I1zBOvHUFlyEudVMO/IukhqfGzZpNFOKeVcq4AZ0gftfndCvWvw
         HDEEE9hiI9brCspbnb5Ep1PbyCCHsFF+H3Ep7EypGGCzi1VVbPXRwCqcqfaV14J/AwTS
         AadZOVYxFYc+NJz5jc62QOMkA8CzjnR3k/GbY3yTsnc5yfi9aB7/8B/ts+LHBz3SXlnd
         vYuABhbPRt3ddRWcJLdIXeFsnDptwkQfTkwsVWiV9vS+bmzMLGBK0M+rK/TzyV+dOMyj
         iJLQ==
X-Forwarded-Encrypted: i=1; AKwUvBxIXSWMr4Wk+rUSiKO6mIfZNEE49KCXk5q+zlxeIBxp465iR5FkTT+6jdckajAl/lULqhlXktM=@vger.kernel.org
X-Gm-Message-State: AFuF++lgvQNRYVhjXthZOdex3rtxP61RTcgj4JFgmb5TczJmjmptMFGD
	9GLlHxHQm1tX2EYQvV7qxnoWSnqkhbjF/0NQIgKKr2S/64471wJDzi+k
X-Gm-Gg: AYBFou3UJd9uywJkUeD9tViCBKdkBJltTsWNDnthF8D34SVWsqb9AifIIle4asnPkix
	ZRe8w5NQdn0Ptpvx04xdkJVLmX3rWGlFnv7nTQXIIv+uAI58yAwXxrVS22BKUfu9HKx9byX0++y
	A0O6JJFeJkG2s/0/OgPxXa9F52AXtF0DvOnSAHyvKbV1PN+IuK7lqotfB5uCIqekaNvDLgghit8
	y5/wCsrYaDQbVSqLaSdt3tOacq76wUbLffaZThuUxr0Q6ct0Z98g05PmbmV/50nzx7D4So6UW5s
	bAh0uvlHvXAfgGXZ5yYtWUBGjTO8X/7e1e8v5M+DpcRbmKUGnsqOqQcHoCiRRxrWxar+CsUo1r3
	P1i6y124Vd/oOkJ/h6TotE/x9Jc9cko1Mon5qkwe021YRG/xZJumxYlcATjwoAQtzYBviF6JEy8
	DBXWR3V7xFYRNUrQbXj9iBDpFCGslwV/GPtOGnukRwfHviOVdMU9IKK8o69IoxWCyhLHKeuoQNX
	4sqqemO0WGc2oGFUuvJp0wk/cSHWQ==
X-Received: by 2002:a17:903:198d:b0:2db:2427:97d5 with SMTP id d9443c01a7336-2dd6c5bbbbamr132010185ad.4.1789459834271;
        Tue, 15 Sep 2026 01:10:34 -0700 (PDT)
Received: from localhost.localdomain ([103.120.31.178])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4f5833fsm38624583eec.23.2026.09.15.01.10.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 15 Sep 2026 01:10:33 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Subject: [PATCH bpf-next v6] xsk: Fix circular locking dependency between &net->xdp.lock, &xs->mutex, and netdev_lock_ops
Date: Tue, 15 Sep 2026 13:40:23 +0530
Message-ID: <20260915081023.7433-1-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a circular locking dependency involving &net->xdp.lock,
&port->pnodes_lock, netdev_lock_ops(), and &xs->mutex:

-> #3 (&net->xdp.lock):
       xsk_notifier+0x3d/0x2c0 net/xdp/xsk.c:2106
       ipvlan_device_event+0x310/0x4e0 drivers/net/ipvlan/ipvlan_main.c:834
       unregister_netdevice_many_notify+0x808/0x18b0 net/core/dev.c:12518

-> #2 (&port->pnodes_lock):
       ipvlan_device_event+0x85/0x4e0 drivers/net/ipvlan/ipvlan_main.c:795
       notifier_call_chain+0xb5/0x410 kernel/notifier.c:85

-> #1 (&dev_instance_lock_key / netdev_lock_ops):
       netdev_lock_ops include/net/netdev_lock.h:42 [inline]
       xsk_bind+0x331/0x11d0 net/xdp/xsk.c:1627

-> #0 (&xs->mutex):
       xsk_diag_fill net/xdp/xsk_diag.c:113 [inline]
       xsk_diag_dump+0x2e0/0x4e0 net/xdp/xsk_diag.c:166

The cycle exists through the following dependency chain:
1. xsk_bind() acquired netdev_lock_ops() while holding &xs->mutex (#1).
2. Device unregistration in ipvlan_device_event() acquired
   &port->pnodes_lock (#2) and called xsk_notifier(), which acquired
   &net->xdp.lock (#3).
3. Both xsk_diag_dump() and xsk_notifier() acquire &xs->mutex while
   holding &net->xdp.lock (#0).

Break the circular dependency at its source in xsk_bind() by acquiring
netdev_lock_ops() before &xs->mutex. To preserve the exact errno precedence
(-EBUSY vs -ENODEV) without requiring the mutex to read sxdp_ifindex, we
look up the net_device first. If the device exists, we lock netdev_lock_ops()
and then &xs->mutex, evaluating the socket state safely. The cleanup path
is adjusted to unlock in reverse order, ensuring device references are
correctly maintained or dropped.

This single lock reordering fully eliminates the &xs->mutex ->
netdev_lock_ops() edge, resolving the 4-lock cycle without introducing
concurrency regressions in the diagnostic dump or notifier paths.

Fixes: 975b11ae9077 ("xsk: add socket allocate, create and bind")
Reported-by: syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aa48b5fe7bfda62d1682
Signed-off-by: Khawar Ahemad <ahemadkhawar123@gmail.com>
---
v5 -> v6:
- Abandon the two-phase xsk_notifier() and xsk_diag_dump() decoupling from
  v3-v5, which introduced a Use-After-Free during concurrent xsk_release(),
  and an O(N^2) list traversal complexity in xsk_diag_dump().
- Break the cycle at its root in xsk_bind() by acquiring netdev_lock_ops()
  before &xs->mutex, fully removing the &xs->mutex -> netdev_lock_ops edge.
- Look up the net_device before locking &xs->mutex to preserve the original
  -EBUSY vs -ENODEV errno precedence without any behavioural change.
- Link to v5: https://lore.kernel.org/bpf/20260902041257.58374-1-ahemadkhawar123@gmail.com/

v4 -> v5:
- Rebase cleanly on latest bpf-next master.
- Link to v4: https://lore.kernel.org/bpf/20260826174744.3394-1-ahemadkhawar123@gmail.com/

v3 -> v4:
- Rebase cleanly on latest bpf-next master to resolve merge conflict.
- Update commit message to accurately describe the full 4-lock dependency
  chain (&net->xdp.lock, &port->pnodes_lock, netdev_lock_ops, &xs->mutex).
- Link to v3: https://lore.kernel.org/bpf/20260826173019.2917-1-ahemadkhawar123@gmail.com/

v2 -> v3:
- Fix direct AB-BA lock inversion in xsk_notifier() by performing device
  queue sweeps via xsk_get_pool_from_qid() outside &net->xdp.lock.
- Eliminate &net->xdp.lock -> &xs->mutex in xsk_diag_dump() by taking a
  temporary socket reference and releasing the lock before xsk_diag_fill().
- Link to v2: https://lore.kernel.org/bpf/20260826162110.99879-1-ahemadkhawar123@gmail.com/

v1 -> v2:
- Avoid reordering locks in xsk_bind() to preserve errno precedence.
- Link to v1: https://lore.kernel.org/bpf/20260825152152.86092-1-ahemadkhawar123@gmail.com/

 net/xdp/xsk.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7855ee09c4..0a4106e98b 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -1612,20 +1612,22 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 		return -EINVAL;
 
 	rtnl_lock();
+
+	dev = dev_get_by_index(sock_net(sk), sxdp->sxdp_ifindex);
+	if (dev)
+		netdev_lock_ops(dev);
+
 	mutex_lock(&xs->mutex);
 	if (xs->state != XSK_READY) {
 		err = -EBUSY;
 		goto out_release;
 	}
 
-	dev = dev_get_by_index(sock_net(sk), sxdp->sxdp_ifindex);
 	if (!dev) {
 		err = -ENODEV;
 		goto out_release;
 	}
 
-	netdev_lock_ops(dev);
-
 	if (!xs->rx && !xs->tx) {
 		err = -EINVAL;
 		goto out_unlock;
@@ -1762,18 +1764,20 @@ static int xsk_bind(struct socket *sock, struct sockaddr_unsized *addr, int addr
 	}
 
 out_unlock:
-	if (err) {
-		dev_put(dev);
-	} else {
+	if (!err) {
 		/* Matches smp_rmb() in bind() for shared umem
 		 * sockets, and xsk_is_bound().
 		 */
 		smp_wmb();
 		WRITE_ONCE(xs->state, XSK_BOUND);
 	}
-	netdev_unlock_ops(dev);
 out_release:
 	mutex_unlock(&xs->mutex);
+	if (dev) {
+		netdev_unlock_ops(dev);
+		if (err)
+			dev_put(dev);
+	}
 	rtnl_unlock();
 	return err;
 }
-- 
2.54.0 (Apple Git-157)

