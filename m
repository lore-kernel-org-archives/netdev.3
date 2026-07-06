Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DFE83F99EA
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783330472; cv=none; b=aF0ipLVO+mxFLhRrc49C5VSEyVjruSTJCRGpMQeN6n4YbkgdDVf0sL+azVmzRtZqZJnDl3QT0cmftlr2oEKXy4RE2BRIShbjlhokTgMXF0mt745xZRJexexfvV4VdoRmub01wvN8msz5q+6ChzeOH/AztfPGRfoG+kFfySkmz/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783330472; c=relaxed/simple;
	bh=zN5L/AvLHOKTBwFT3Fz0jxTEkQaIAaC1B4ZN3xSGxX0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XylTA4ELMve6lV+scd20eTkzDki0Mx8T6Qwr4DwFglHDmvZNaeb5gZU/CMqPetoVS+uzlSHQhL2Y2va/bvSkuUc7Y0eInAu5QIDi+xg1M/u8ZGBR9aaf6hZY5flExzD3DvVVpK7REEVQXjjFtL8sqI8Lm91Zkt7UyN2cSUy6uHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kSWa0fNv; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kSWa0fNv"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783330455;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=sZQ9WVA3JaDoSNxxquL3VaiwxpdZMD31OCMRpHRYFNE=;
	b=kSWa0fNvyjaywtoMVp+u+KAjN8DAHiHu93/cUYcmO8Up8UwIU6DzyOrSmhkwXStNm2uBJl
	E9Xc0gSSpIsRoN6Lx1bo+7ccdCiFNikFuhI+3waKm/38WIrnBRbUPMUNyR6NAZvTVG74AL
	iyM4ItoKsIInulhQ4BZK8odRufM8MKg=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Qingfang Deng <qingfang.deng@linux.dev>,
	Kees Cook <kees@kernel.org>,
	Felix Fietkau <nbd@nbd.name>,
	Eric Woudstra <ericwouds@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-ppp@vger.kernel.org
Subject: [RFC net-next] pppoe: fix stale device name shown in procfs
Date: Mon,  6 Jul 2026 17:34:02 +0800
Message-ID: <20260706093404.407667-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In pppoe_seq_show(), the device name is currently read from
po->pppoe_pa.dev, which contains the name at the time the socket was
connected. If the lower network device is renamed afterwards, reading
/proc/net/pppoe will still print the old name.

Fix this by reading the name directly from the bound net_device via the
po->pppoe_dev pointer. Note that the pointer can be cleared when the
socket is being released, so a NULL check is required.

Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 drivers/net/ppp/pppoe.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
index 4a018acb5262..5bf526c596b6 100644
--- a/drivers/net/ppp/pppoe.c
+++ b/drivers/net/ppp/pppoe.c
@@ -960,6 +960,7 @@ static int pppoe_recvmsg(struct socket *sock, struct msghdr *m,
 #ifdef CONFIG_PROC_FS
 static int pppoe_seq_show(struct seq_file *seq, void *v)
 {
+	struct net_device *dev;
 	struct pppox_sock *po;
 	char *dev_name;
 
@@ -969,7 +970,10 @@ static int pppoe_seq_show(struct seq_file *seq, void *v)
 	}
 
 	po = v;
-	dev_name = po->pppoe_pa.dev;
+	dev = READ_ONCE(po->pppoe_dev);
+	if (!dev)
+		goto out;
+	dev_name = dev->name;
 
 	seq_printf(seq, "%08X %pM %8s\n",
 		po->pppoe_pa.sid, po->pppoe_pa.remote, dev_name);
-- 
2.43.0

