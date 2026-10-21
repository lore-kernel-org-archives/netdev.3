Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792598161;
	b=rXexb5DzLYJ+ywdHEKCTlg91l0xme2dVlfqPBjQBwCAp41VERpEHRTW/TIroRJpeqn6E
	 8F6cKPW+/p5YfacIaYrVinf3C78W7wcVxMA86cEohgWG9ENmgWHDbacWUVbwNe6mRqZfv
	 zYgbGgOfxKxTz3103fUNeKZEWK2XTrpa3bQINKWN/b3J/WBD7Liql5bhnyxIucE83Pjok
	 XWXBcSZCPe7bW+dyFk6nJy47YFBtpoZELEzukT8bW6lxnUzSfJOYbZ57gCQMBE7hC42Mf
	 y+MCsrXJbHHYAWTyzODI+HMBFEZJK8C7Pa204+o7Bu1MCXZC40vtXfM/xzVyqsw0cmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792598161;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KM9wJY2QfLW07XaMM0Z9rz5ZrePbeyOgedjaYIW3VG0=;
	b=0K08fA6h0imjrIdBI52hxuH6OCLKhiudhOO+brrDRepzmqzlJA2/lNxfOmNC+tZv9nhv
	 QhBGaZo2gzc5c+nvS2zlHvTuE1reMOgm6PZZvl+ytmBQUaTxcyM0C5Y3COxC1Tgaxd/sm
	 QuaPNv3ROP4fuF0DA+jhs0nnl+81pa7OqHrdygR+ldE4m+4gDtbLFmGT2M58Ko7+5oRv8
	 q4IQ34d1kVj6CFybdGsdaXcxmZgk165kDSNmXbAefqxTFX4SBb4Qs3DiCcyoPQ5OYo0uh
	 SibTx76TG6SDOzSshqWj0MLh/BEOSaHpwrUq4xuUgxxHovf5SmnFcSTu8i9Mb9duRkw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZqSnkgBs;
	arc=none smtp.remote-ip=209.85.215.181
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74217606A319
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 15:56:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74217606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ZqSnkgBs
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc147d86bebso587868a12.0
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 08:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792598161; x=1793202961; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KM9wJY2QfLW07XaMM0Z9rz5ZrePbeyOgedjaYIW3VG0=;
        b=ZqSnkgBsxGPV+doojtlxi2+vrjiYRP/sX0oPEg3h45nCgu6mkEWaVzTJ0mAku0TNWz
         RKgvExPE+HC/ZOZDg75xmOofULmINfoPGc2AOACiApq9IAvismwHrv099Xjd07qdhUES
         oyojVKrqcMTcZh+DRYV6GxNqpSnj2Qxy5XkvqKCkKEelwHLGVSfa+bpsdYdOzTMK2Kmq
         Mm9jZ4xmbyDyM6SOrYEQN7oO7ba/xfqotmRY2fZ8JnnmXN/JTRTp3W+4bTedP5cKFS5y
         LK6ygp9mMQ47UIa30/ffEiGkJvdyngQmSoFFeO4KnYgGWF5D3UNrt7QlEdb2gDLYAx2s
         MEUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792598161; x=1793202961;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KM9wJY2QfLW07XaMM0Z9rz5ZrePbeyOgedjaYIW3VG0=;
        b=oT+Yubu8EM7V+NBQkI50gNm98bvpZ5itHZDX7l/qd7vs1SO1BUBOcx7d9Vqj1fgHbq
         JTbWlIPGXaxNKxfHxqWqf7aQn+mWGH2+hxEKJaQWr37QPIIuw0iU6oApo/XRAGlI0tI4
         n+DqsijqIebHPXli8DYyruS+nsUtKQz/s/8+Z+gywaC5lOy+Czj45do2VKjRB3a+DF+9
         d/EXOmT2qn1LjCkpedwgbbrJagLrtif+DwnI/ALrcBuvAS1N7XokqnYFe04XgpnuiU6x
         DtEg2ZF7FOIMGV0+x0U2MHNF0Mw46Brj2WxImXD+NweGPQGwxC+2uvutV88S61vHcVkC
         cIBA==
X-Gm-Message-State: AFq9FYIln4YJthcdJ+SbrREh3PMbIPIcfEsl0QZQEDpLmdVGlpXochu1
	2R/Goh4eahzCv875Kh2NVIx5iAcy8vtuXpiQAfjTK5v71bnItHhKywGf
X-Gm-Gg: AYBFou2tIQIJtFssXwWIJKTJYkiVRNc7gjypfigtcYWCtiNrRm7nD1QCGoV1cRcFgZ6
	Tq8BIZ5OQypp+bxKAEB8BCH7XY5PgzaFZ5sgnymTzZ1pDhCq/3W96mJRDkUOgX8IGcF4QcB8yrz
	XfOjbxR7afFQ1mRyeCXf9Ob5omeIWQnLE8AnXWJf8NvHL4a8umQoBfKadgaTax5dYGEuJK6iL75
	ntz5KRBOqGm2lAPnQWvw68HDHuUQLg9yXhGWEBkB5G82iViK8BC+Nht1xyFY9J4a8ShCxx7woJZ
	RZ78X1+rYNODC4V891rYxu8gnhwFdNK7IFqtKKJov+5NrzdGJeaplgR5pPpXDo/lX01lqMSV0tn
	rGIOT0AebgzubnY3Uv2V6GrAq+GJ9ZCgKUSqlqLdHRlLTnL7W5c6EC+l1xDN9oPA7FLUI0eFpxi
	gvKdlxWO5c8rBUhI8FUSoJ8mQHnK5fdtr8suY7eAcciED59HXpGUF58AdKkfncG6j/mYDMxgkLP
	1xQtnhn35ZWqzWGYycJqYPHdlxuwpDqrEmKeCNIFdNAo0HA4oJ9goHcgjyBK6HvZdUQQvdjU/QJ
	02doIMjjQHvjDyldkrYWUWVnuanJaw==
X-Received: by 2002:a05:6a20:d10e:b0:3e2:3584:c12c with SMTP id adf61e73a8af0-3e26f932cf7mr3364412637.2.1792598160759;
        Wed, 21 Oct 2026 08:56:00 -0700 (PDT)
Received: from localhost.localdomain ([218.253.131.218])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cd6b8745546sm169643a12.30.2026.10.21.08.55.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 21 Oct 2026 08:56:00 -0700 (PDT)
From: Dudu Lu <phx0fer@gmail.com>
To: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [PATCH net] net: xps: re-validate the queue index after switching to the subordinate device
Date: Wed, 21 Oct 2026 23:55:55 +0800
Message-Id: <20261021155555.68167-1-phx0fer@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

__netif_set_xps_queue() reassigns dev to the subordinate device
(netdev_get_tx_queue(dev, index)->sb_dev) but keeps using index, which
was only validated against the ORIGINAL device's queue count.  A
subordinate with fewer TX queues than the parent's index then overflows
sb_dev->_tx[] / the XPS map:

  BUG: KASAN: slab-out-of-bounds in __netif_set_xps_queue+0x178c/0x1ee8
  Write of size 4 at addr ffff000005d3fae0 by task A-26-F1-S2/162
   __netif_set_xps_queue+0x178c/0x1ee8
   netif_set_xps_queue+0x38/0x58
   xps_cpus_store+0x1dc/0x2b8

The store is netdev_queue_numa_node_write() on sub->_tx[index].  The
top-of-function WARN_ON_ONCE(index >= dev->num_tx_queues) only checks the
parent and is a debug assertion.  Re-check index against the device that
is actually indexed once dev has been rebound.

Note this is a different defect from the "reject an out of range traffic
class" guard (4da3b7b8b50f), which bounds tc, not index.

Fixes: ffcfe25bb50f ("net: Add support for subordinate device traffic classes")
Assisted-by: LLM
Signed-off-by: Dudu Lu <phx0fer@gmail.com>
---
Tested base
-----------
Detected on Linux 7.3-rc4 (commit 93f51579e7df), arm64 QEMU guest.
Re-checked against mainline f47d223627f8 (v7.3-341): the affected code
is unchanged between the two, so the bug is still present there.
Checked against linux-next next-20261021 (commit 9a482184d910): the
affected code is unchanged there as well, so the bug is still present in
linux-next too.

Reproducer status
-----------------
A reproducer was written and executed on an arm64 QEMU guest (KASAN); it
fires at the claimed sink, and still fires on a kernel built with 4da3b7b8b50f
applied (identity established by disassembling both kernels: same store, same
target offset #0x160).  The guest has no SR-IOV NIC, so the reproducer stands
in for that hardware with a small module that binds an sb_dev the same way
netdev_bind_sb_channel_queue() does for i40e/ixgbe.  The reproducer source is
not posted here per Documentation/process/security-bugs.rst; it is available on
request.

Triggering conditions
---------------------
CAP_NET_ADMIN to set the XPS mask.  An sb_dev is bound in-tree by
netdev_bind_sb_channel_queue(), which the i40e and ixgbe SR-IOV paths call
when a VF's channel is bound to the PF.  The QEMU guest used for the
reproducer has no SR-IOV NIC, so the sb_dev binding was set up through a
small module; the defect itself is reached in-tree on that hardware.

Notes
-----
Built and checkpatch-clean: this patch was applied on top of 7.3-rc4
(commit 93f51579e7df) and a full arm64 kernel (defconfig) was built with
it -- no new warnings or errors.  scripts/checkpatch.pl reports 0 errors,
0 warnings.

 net/core/dev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/core/dev.c b/net/core/dev.c
index e76762e29360..d5ce25144806 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -2900,6 +2900,14 @@ int __netif_set_xps_queue(struct net_device *dev, const unsigned long *mask,
 		/* If queue belongs to subordinate dev use its map */
 		dev = netdev_get_tx_queue(dev, index)->sb_dev ? : dev;
 
+		/* dev may now be the subordinate device, whose queue
+		 * count can be smaller than the parent's.  index was only
+		 * validated against the parent above, so re-check it before
+		 * it is used to index the (possibly different) dev->_tx[].
+		 */
+		if (index >= dev->real_num_tx_queues)
+			return -EINVAL;
+
 		tc = netdev_txq_to_tc(dev, index);
 		if (tc < 0 || tc >= num_tc)
 			return -EINVAL;
