Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 383143D1CCA
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 08:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790755713; cv=none; b=LTLkjwO5lcIv9M42eNuVSiKt7o/21YeiD4DFEm5JYAJRZOit0RWveMU7cTvP4GNVPu9Sh7f5E7bZStEaYoOr34wj4gU39qlb+VNYJMm3JXuIubUNaTIF6nz8N3fSk3t8HChnQY6aO/1Q7b4EjUhNpwj9cVCW/B/bfTYmD50SIi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790755713; c=relaxed/simple;
	bh=ec9oBPsDvtrcVKnja3YC47KILh4vTpIdVApfA5xe5NE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=by7BUMPD5kXYtqRx571AomRNotNMNJPFjxDM7dnO+NiEb5M9r0otBGmmqoi/MBeBmpg/t/MkRDlemCaCX9I0Pzyfm2Z0+bLbujtl3y2abjVQ8CwHelePIYHxEf6AI2EATYUl7mGfdaHnuIlASL8MRr0Ctnj9DpWrDzvC9EEq+lQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=NlM8XIea; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="NlM8XIea"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=vd
	O8s6IajSPfTuxxIgw90cZJuY11G/ENUkoEMyMlmZQ=; b=NlM8XIeaT7Ty/TeeuI
	0qQULRsCiaYNYW4oVgYnIXZjnS1BEoffxCWZ/50frBDer0l63WGYH2n0IF22vbvd
	6CwDX2zcJsDaT2esaQoshPmxiTq6WWr3yoA9J1EpeA7IULmoEk2Dmxv+yAOi0Eeq
	zIPrlaIs608L2GO776WPGYVWs=
Received: from localhost.localdomain (unknown [])
	by gzsmtp1 (Coremail) with SMTP id PCgvCgBnNiBTw7xqRdh1Bw--.20247S4;
	Wed, 30 Sep 2026 16:07:52 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH net v3 2/3] tun: fix inverted error check when re-attaching the filter
Date: Wed, 30 Sep 2026 16:07:45 +0800
Message-Id: <20260930080746.135017-3-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260930080746.135017-1-clementwei90@163.com>
References: <20260930080746.135017-1-clementwei90@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PCgvCgBnNiBTw7xqRdh1Bw--.20247S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7AFWfCF4DGFykWFy5ZrWkWFg_yoW8uFy5pF
	W5Wayjqr15Ga48Xwn8Aayjvr1aqw12gay7urykX345uFsYgrZ0vay5KFWruF1qyrW8Z3W5
	Zr1UKrWaqr1kAFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jqeHDUUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC4RjQPGq8w1g6ZwAA3F

From: Rongguang Wei <weirongguang@kylinos.cn>

tun_attach() returns early when sk_attach_filter_kern() succeeds instead of
when it fails, so a queue attached to a persistent TAP is never published
in tun->tfiles[] while TUNSETIFF still reported success.

Fix the check, so that a failed re-attach aborts the attach, and detach the
filter again if a later step of tun_attach() fails.

This has to come after the patch that keeps a kernel copy of the program:
with the check fixed but the program still read from the caller's address
space, a re-attach that used to succeed without installing any filter would
fail with -EFAULT or -EINVAL.

Fixes: 54f968d6efdb ("tuntap: move socket to tun_file")
Link: https://lore.kernel.org/netdev/179027275318.2160803.4185895144088175048@kernel.org/
Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 drivers/net/tun.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 22fb34e745bd..c796048742f9 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -757,6 +757,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 {
 	struct tun_file *tfile = file->private_data;
 	struct net_device *dev = tun->dev;
+	bool rollback_filter = false;
 	int err;
 
 	err = security_tun_dev_attach(tfile->socket.sk, tun->security);
@@ -783,8 +784,9 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 		lock_sock(tfile->socket.sk);
 		err = sk_attach_filter_kern(&tun->fprog_kern, tfile->socket.sk);
 		release_sock(tfile->socket.sk);
-		if (!err)
+		if (err)
 			goto out;
+		rollback_filter = true;
 	}
 
 	if (!tfile->detached &&
@@ -846,6 +848,11 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 	WRITE_ONCE(tun->numqueues, tun->numqueues + 1);
 	tun_set_real_num_queues(tun);
 out:
+	if (err && rollback_filter) {
+		lock_sock(tfile->socket.sk);
+		sk_detach_filter(tfile->socket.sk);
+		release_sock(tfile->socket.sk);
+	}
 	return err;
 }
 
-- 
2.25.1


No virus found
		Checked by Hillstone Network AntiVirus

