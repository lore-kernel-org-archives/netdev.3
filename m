Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9773134F46F
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674683; cv=none; b=Kfbmjo0zyvauNohBd/JCpDHpKFjVXlKiHwsoiQELa+9r/pKRvWR1Z5co/Fa6AWEIzwIifwqg5OYSVV7q0RrK8OpA43WHdhJxwpMer9C4bS6DNy8p3bQlj/GhDkevFdoInC9ZwfV6/wM77SiEI3887PrNSEi7WobaFvw/q9Lyvow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674683; c=relaxed/simple;
	bh=h0zlRFYCYAWkoSgwUwwSA0wIPj1xDikfYhQbz0D7xFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UObxmEc9w58pCWGIJdnFX9BcLL3AXxmO9WegiD8dNI5lheqehDdfFggCAPYw+QcoVKpz9R015dU2pCEaQqwV6jaxayCEO7y+THwHYcXH7l+f2C7F0GIYMReXW7dR5skA2IfF1c1b9fpY3cKm9Da22cPCBkIcp7jKRJxVapQmeII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=l6jIQ6C7; arc=none smtp.client-ip=117.135.210.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="l6jIQ6C7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=XI
	9bzJKhu82tyFu0e8V4QWVv+TywtBWmQMA0cOxWKQo=; b=l6jIQ6C7WRE0ggPP/j
	MwXmC1w65ZBNdclR8rjBlYcdBGLLl1dakgZRF41hP/x9m/RQhd50lsiBO4B0MEDB
	UtVXHHBAuRMJdmNSLHlnqhnwferHzdnPKkdX6/mh0wMoljopOqu8uxllqRNLfyPa
	DU+5f3mmK8TCi2VOtYNywTQmU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-0 (Coremail) with SMTP id _____wCnt5nKhrtqVp7nBQ--.16613S3;
	Tue, 29 Sep 2026 17:37:17 +0800 (CST)
From: Rongguang Wei <clementwei90@163.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	jasowangio@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	kuba@kernel.org,
	Rongguang Wei <weirongguang@kylinos.cn>
Subject: [PATCH v2 1/4] tun: fix inverted error check when re-attaching the filter
Date: Tue, 29 Sep 2026 17:37:09 +0800
Message-Id: <20260929093712.131096-2-clementwei90@163.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260929093712.131096-1-clementwei90@163.com>
References: <20260929093712.131096-1-clementwei90@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wCnt5nKhrtqVp7nBQ--.16613S3
X-Coremail-Antispam: 1Uf129KBjvJXoWxJrW5XF4fGw1kAF45CFW5GFg_yoW8Cw1kpr
	W5WayYqr15Wa48X3ZIyayjvr1aqwnFgayxury8J34Y9F4vgrWjvay5KFWYk3Z8Ar4DA3Z8
	AF1qgrW5Zr1DAF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jzq2_UUUUU=
X-CM-SenderInfo: 5fohzv5qwzvxizq6il2tof0z/xtbC-Q5eyWq7hs7Q6wAA3G

From: Rongguang Wei <weirongguang@kylinos.cn>

tun_attach() returns early when sk_attach_filter() succeeds instead of when
it fails, so a queue attached to a persistent TAP is never published in
tun->tfiles[] while TUNSETIFF still reports success.

Fix the check, so that a failed re-attach aborts the attach, and detach the
filter again if a later step of tun_attach() fails.

Fixes: 54f968d6efdb ("tuntap: move socket to tun_file")
Signed-off-by: Rongguang Wei <weirongguang@kylinos.cn>
---
 v2: roll back the filter attach when a later step of tun_attach() fails
 v1: https://lore.kernel.org/netdev/20260923025653.59348-1-clementwei90@163.com/
---
 drivers/net/tun.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 5a302709a68a..a2fffef3735f 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -728,6 +728,7 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 {
 	struct tun_file *tfile = file->private_data;
 	struct net_device *dev = tun->dev;
+	bool rollback_filter = false;
 	int err;
 
 	err = security_tun_dev_attach(tfile->socket.sk, tun->security);
@@ -754,8 +755,9 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
 		lock_sock(tfile->socket.sk);
 		err = sk_attach_filter(&tun->fprog, tfile->socket.sk);
 		release_sock(tfile->socket.sk);
-		if (!err)
+		if (err)
 			goto out;
+		rollback_filter = true;
 	}
 
 	if (!tfile->detached &&
@@ -817,6 +819,11 @@ static int tun_attach(struct tun_struct *tun, struct file *file,
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

