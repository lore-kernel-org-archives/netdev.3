Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5870823EAB4;
	Thu,  4 Jun 2026 06:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780555754; cv=none; b=BcvNjykhLbV3NdkLb/81q818PBEMYlrP8pCesuzwefdoeUp9Sdb4ISxkenAMrB2+tMe/r2BBoYYy+ucIGTAmVKEOUwSZVjiXK7zwe7rCFodAlujOAP3ZX7wrIFbMfHg/tzNnCKbFoLHI9qA//idYpZtfmpH553X7qLJGbBxGmPA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780555754; c=relaxed/simple;
	bh=JpyqooivJdjNE3jKQT2tqH5f4eKJTCVAMKFgcUxXdoY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=eH7xgWPQlC7UJ/vyW1B18T6+zN6f951moJmXYyRvn3l2mQl/OAXaxlzuMgCQnO0ThZi6BmJqR0i0vfl654wJqhARUlMwQAA1O25t0aYBEAsIw0lp3fGboZsXNf4eXymIZpx0FnjqPCgGy3JitgK9iaoHdXazVFV9jy7uaTUxC+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=IpFywxfx; arc=none smtp.client-ip=220.197.31.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="IpFywxfx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=1x
	4jrzaczNfj01i95gQ7WeXi4BNP+sXCZMohEU4DDP4=; b=IpFywxfxo4ftn/3XDm
	8VmOepU9flMI3I+NkKjvwAZUMjs3TV5y75Ys6OT9RayZIP5Zs6nnAIRIBqDGXpcT
	So+zXVcEgzo4qcmLaprMnjylphAfTF7ikbBtg4dTYpucse+R3xlzvvrc9LpO+ml0
	tb2XTwYlyJB8QvJYWBxDSU85o=
Received: from 163.com (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAXpAOoHyFqmrOtAQ--.52491S2;
	Thu, 04 Jun 2026 14:48:11 +0800 (CST)
From: w15303746062@163.com
To: Manivannan Sadhasivam <mani@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Luca Weiss <luca@lucaweiss.eu>,
	Bjorn Andersson <andersson@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>
Subject: [PATCH v2] net: qrtr: fix refcount saturation and potential UAF in qrtr_port_remove
Date: Thu,  4 Jun 2026 14:48:01 +0800
Message-Id: <20260604064801.1180388-1-w15303746062@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAXpAOoHyFqmrOtAQ--.52491S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxCFyDZFy5Kw15Zw1fZr1UZFb_yoW5ArW7pr
	W0yFs0y3ykGrn2kF4Ika18Ga40vF1rJrZxGFZ3Cws5ZFn3Aw13Aw4Fy34Y9FyUGFZ3JrWv
	vF1DCrs09FyqvFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYbyZUUUUU=
X-CM-SenderInfo: jzrvjiatxuliiws6il2tof0z/xtbC4wzVuWohH6zgXgAA3F

From: Mingyu Wang <25181214217@stu.xidian.edu.cn>

In qrtr_port_remove(), the socket reference count is decremented via
__sock_put() before the port is removed from the qrtr_ports XArray and
before the RCU grace period elapses.

This breaks the fundamental RCU update paradigm. It exposes a race
window where a concurrent RCU reader (such as qrtr_reset_ports() or
qrtr_port_lookup()) can obtain a pointer to the socket from the XArray,
and attempt to call sock_hold() on a socket whose reference count has
already dropped to zero.

This exact race condition was hit during syzkaller fuzzing, leading to
the following refcount saturation warning and a potential Use-After-Free:

  refcount_t: saturated; leaking memory.
  WARNING: CPU: 3 PID: 1273 at lib/refcount.c:22 refcount_warn_saturate+0xae/0x1d0
  Modules linked in: qrtr(+) bochs drm_shmem_helper ...
  Call Trace:
   <TASK>
   qrtr_reset_ports net/qrtr/af_qrtr.c:768 [inline] [qrtr]
   __qrtr_bind.isra.0+0x48b/0x570 net/qrtr/af_qrtr.c:805 [qrtr]
   qrtr_bind+0x17d/0x210 net/qrtr/af_qrtr.c:901 [qrtr]
   kernel_bind+0xe4/0x120 net/socket.c:3592
   qrtr_ns_init+0x1a6/0x380 net/qrtr/ns.c:715 [qrtr]
   qrtr_proto_init+0x3b/0xff0 net/qrtr/af_qrtr.c:169 [qrtr]
   do_one_initcall+0xf5/0x5e0 init/main.c:1283
   ...
   </TASK>

Fix this by deferring the reference count decrement until after the
xa_erase() and the synchronize_rcu() complete.

(Note: The v1 of this patch incorrectly replaced __sock_put() with
sock_put(). As Simon Horman pointed out, the callers of qrtr_port_remove()
still hold a reference to the socket, so freeing the socket memory here
would lead to a subsequent UAF in the caller. Thus, the __sock_put() is
kept, but only repositioned to close the RCU race.)

Fixes: bdabad3e363d ("net: Add Qualcomm IPC router")
Signed-off-by: Mingyu Wang <25181214217@stu.xidian.edu.cn>
---
v1: https://lore.kernel.org/netdev/20260530082243.1123402-1-w15303746062@163.com/

Changes in v2:
- Reverted the change from __sock_put() to sock_put() to avoid UAF
  in callers like qrtr_release(), as suggested by Simon Horman.
- Removed misleading "memory leak" wording from commit message.
- Corrected the Fixes tag to point to the initial commit introducing
  the race (bdabad3e363d).

 net/qrtr/af_qrtr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 7cec6a7859b0..db823177e636 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -707,13 +707,13 @@ static void qrtr_port_remove(struct qrtr_sock *ipc)
 	if (port == QRTR_PORT_CTRL)
 		port = 0;
 
-	__sock_put(&ipc->sk);
-
 	xa_erase(&qrtr_ports, port);
 
 	/* Ensure that if qrtr_port_lookup() did enter the RCU read section we
 	 * wait for it to up increment the refcount */
 	synchronize_rcu();
+
+	__sock_put(&ipc->sk);
 }
 
 /* Assign port number to socket.
-- 
2.34.1

