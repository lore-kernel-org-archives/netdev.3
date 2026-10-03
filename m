Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87D303A9DB2;
	Sat,  3 Oct 2026 09:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791020346; cv=none; b=WXp9+Op+F/7LhVd1jwn1QwVPLQoOFtWPc0Y5t6iXjDVFZ7YlfmDb47n+ibmaYOvhnVyrPxlQgT04f6DxeGAt9yFoXDiTV84B3me33QAriHG14BryL4TsXpWZQDr4Aw9qda8wvxGWUEYdcZQEKI0fBV9s+LO/pCD02M7uAlsvgu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791020346; c=relaxed/simple;
	bh=lfJOnW8dwrulCJ3fLtiALRb+yMxarM6N3w1MRgPkU30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oYydyv7pNxaXXPhqgXq0kSq9TdhctrHiPLxlrp9CJntLobNBetCrH1x1a9E4HbzA/lb7US03RPBCNbsqLX4/vfd50rC7JdXGUVZ5xJBeQW4hDJUMRd9fCcNeVi/x1AhEm+WKj5gQDYDAbs0OBBzb18AIvM91DR13miJKdwWdLmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=P9GKNpfs; arc=none smtp.client-ip=220.197.31.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="P9GKNpfs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=Ut
	yYF+w0ZNzhSxef8YqnOEHcpNsRkHSyxTHCosQDB60=; b=P9GKNpfsMbhuhkHKSe
	VTxkoRCNqHAMOEAtSvYCctnatU9DVAVKTcy6e6nFD9F4bdvVi7veTBLtljM/0aEx
	gtRZhxHFqUrW4IehIv0ATq5jr2k34gwbxHsw+zN6kvawDfSYIJNF3OR0vvsfS0wM
	fOsAv9jwDXT54lVd8uuCOY0Ew=
Received: from pc.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wDH7vQRzcBqcMTKCA--.43824S2;
	Sat, 03 Oct 2026 17:38:25 +0800 (CST)
From: Jiale Yao <yaojiale02@163.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Jason Wang <jasowangio@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>
Subject: [PATCH net] tun: Drain eBPF RCU callbacks on module exit
Date: Sat,  3 Oct 2026 17:38:21 +0800
Message-Id: <20261003093822.544964-1-yaojiale02@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDH7vQRzcBqcMTKCA--.43824S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7JFWUKFy5trW5XFy8uFyUJrb_yoWkZFX_Kr
	yIvr9rGr4DGan7KF1Ykr43Zr98ua4Y9FyFqrsaq3y3J3y8Zrn8uwn5Zrn3AryUGrWxAF9I
	krnrGFyxu3929jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7sRMXo7PUUUUU==
X-CM-SenderInfo: x1dryxhdohiji6rwjhhfrp/xtbC8BFCfGrAzRFPpQAA3D

Replacing or clearing a TUN eBPF program defers its destruction to
tun_prog_free(). In the device teardown path, tun_free_netdev() can queue
this callback as a private destructor. The rcu_barrier() in
netdev_run_todo() runs before private destructors, so it cannot drain the
new callback.

After the last file or persistent-device reference is released, tun can
therefore unload before the callback runs. Drain outstanding callbacks at
the end of module cleanup so they cannot execute from freed module text.

Fixes: 96f84061620c ("tun: add eBPF based queue selection method")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
---
 drivers/net/tun.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 5a302709a68a..bde5032bf4f4 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -3855,6 +3855,7 @@ static void __exit tun_cleanup(void)
 	misc_deregister(&tun_miscdev);
 	rtnl_link_unregister(&tun_link_ops);
 	unregister_netdevice_notifier(&tun_notifier_block);
+	rcu_barrier();
 }
 
 /* Get an underlying socket object from tun file.  Returns error unless file is
-- 
2.34.1

