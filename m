Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=203.205.221.210
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794043237;
	b=t1E8IKo/WjSiGQbQrpZtDGT5hmHtJwyU3xH3XTBEi20L6P70kKNNa2yQj1F1fMR6HWUz
	 esmg+MWSSVQNHeDttxbXRDg6xaia0mcfukMVa0zuBSEqUPHvwYDiqG4lCphfypdvcKn1b
	 Pnk/hy4NkF3veuu0LtQg7o//AC/zInll8gckanvFxmRt/RTpgXRg4MnHHYeucVZTpCu2K
	 uiZIBUCgQcH/c+1YQe4iCEIpLmqF7bPSC3hezHMT2wVPDbFfgB/1XEWNmWUce5cSn3CSH
	 0xQlWXdU+hsQtB18TPHg8l8Jcsj/ZzFI6HxRAkLQb28D11X0qvzCgpVWJjySac31JtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794043237;
	h=DMARC-Filter:DKIM-Signature:Received:X-QQ-mid:Message-ID:
	 X-QQ-XMAILINFO:X-QQ-XMRINFO:From:To:Cc:Subject:Date:X-OQ-MSGID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=A6UbKZCMgriPlaD6Kz7Kl460tfoMnXRX6Nyh8soMsMQ=;
	b=RkbokKfap5gKhZ7GxQdLgD1bEoP2ASpPX8BdysHFZa1dFfZxkfrzfSDn5zXbh59LAO2q
	 fvwbStwm9GlWNjFSAG3TLsLnOcr4AqF7yxMFi/08FbldxH/zT2EZms66AXz3tSf6eZ3cE
	 avq2gHpJUNwXiH7rxSTZOAfrGZ2SuTI5xzh0vN5Ohq8KZFfzKIjsUqEKc/rzN5rnoiTFN
	 dqfBx8MTutohmBqGANMHiQ4L9DEBvJwQzk+x6bF4Ho/1zmrdN+XRivuqJxKrxfnrMWfgm
	 xNo9fchk1tiyazKDdl+agp1iR/ugzje824162lj4wOhfykfESuc/1TAUT9AVmsyXLaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=qq.com;
	spf=pass smtp.mailfrom=qq.com;
	dkim=pass header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=K91E7eTN;
	arc=none smtp.remote-ip=203.205.221.210
Received: from out203-205-221-210.mail.qq.com (out203-205-221-210.mail.qq.com [203.205.221.210])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8EB606A326;
	Sat,  7 Nov 2026 09:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C8EB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.a=rsa-sha256 header.s=s201512 header.b=K91E7eTN
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1794043232; bh=A6UbKZCMgriPlaD6Kz7Kl460tfoMnXRX6Nyh8soMsMQ=;
	h=From:To:Cc:Subject:Date;
	b=K91E7eTN+jXj2VlgWiXK3ecGi0xQ+HcJ2Nv3mT+pIfd8l/4qUW7gkKEmSWhbs4KCI
	 G2nJfaq5yxAIOz47pxoYsTvU1tIavef0HPIRgmeT8PHeIMGuCgo/nXOpZjnrbGODgR
	 bmJSU7+j9HkeRp4jM+N6OnEOAS1IdaZN6ipgGcds=
Received: from shuai-VMware-Virtual-Platform ([223.88.55.29])
	by newxmesmtplogicsvrszb51-1.qq.com (NewEsmtp) with SMTP
	id 51D9B684; Sat, 07 Nov 2026 17:20:29 +0800
X-QQ-mid: xmsmtpt1794043229tfvlwln6b
Message-ID: <tencent_C7E2CBFD5E5A8E8541FEA08915F742EC6405@qq.com>
X-QQ-XMAILINFO: OATpkVjS499uQSbS2qJCSs0rmQFJxuiBoK7fOLlZYCNUA+Blxpz9HtEHmsRCoK
	 NH+cghPuT6BROPA1Wo0i/y1yScnCmq7fJCh/5FVSeiUEP4gHeogVxFC+1Ue3N/QzuMnfl7VrmI/C
	 JivkbzvwyaSxqyEa6C6HhqL4bUHKbie3aGZx4PtNeHCWBTdjFSbXwVFLchqjiz0o4VOnbky1t5+/
	 Kp2vPWNAhwxvFpvbLYFOqUyTjDBfxWEi5BrKud+BUYFfDpHslaYpi2z0vzJ1dd2GTIoJPXcVKZcH
	 5H2zI7yhc/bOg5dvQdqFmZ8oVHFLqhac0BOjfGkVuib7/jC/jm6QGNrHa7cqJEGe21/BjaBkZQ0C
	 nWGTe9EeAAFPTCIu0IT14VXJa5gqbi1Y/zCKzmRIOKXFTnD2BkFS7GbNsNaVDrqe4NaersfIQBne
	 Z3wgGVLf6qNPR4v1kIJlDEZptU/JxM5enkKc7xmLTkQ44SweaC5Ub206iXonPgZVV0iC9Wc67yen
	 TgHIvgpS5zTdGn0z/kr1a6Kw7ppdZOptzCYCh5Nkp+MnblX9RyoFrIFaCnzA2AfjIRZ3wShi2eAD
	 Mc2REI2YvPYb1z3UwR0B8sLdwjGLcFelg/IdSQo7pTjB+uwDhGESyYafCzTzXM/J2KSxl6/pMAL7
	 gqIKZ9XtcTAL3t5ZtRqJYYSwB8B9TQ/eyJSR7XYjuvI53BkYpp00onnEohkG4zbjO8sFGtg8WU15
	 C/cTc8Os4CsU2NzRg5NAfYiHADPXHx864ZTGML3oPknFuthFNaP7JvKzj0ZFRzQhlgJzhEanUVIi
	 X8Iw/PnmBkDp2E/YFiYiUolGUGBUv6NzrCHwDHkw1s6y7k+uu2rX8w2ucFEIN1TmHCtr27NT9V1c
	 HS2cRnRo3+F/KXqopVoUhnBM1U0UKSvi3mjr0M5Czg4WBqzKS8SReZS2+PmfjZdSATeJs34WR5uT
	 p6318eJMddo6Yle4fPDvzBjXYxwfrB3N4UeeJa5z2k9RFk0CSZTNIobjVgPIg4FEJB1Xu+Vbearc
	 glLoLg/urQIOjroZ/ILhPd1/tYAvVFSEK/7gcL8RsQ4GiOYf4f1BBtQleFpmWL0NYSSgEDLr9Skw
	 YLnIobTdvQvrcE52s=
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
From: Shuai Liu <847807867@qq.com>
To: Jakub Kicinski <kuba@kernel.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+b3fca27eb4005f0111f4@syzkaller.appspotmail.com,
	Shuai Liu <847807867@qq.com>
Subject: [PATCH] netdevsim: fix NULL deref in port attrs after unbind
Date: Sat,  7 Nov 2026 17:20:09 +0800
X-OQ-MSGID: <20261107092009.599797-1-847807867@qq.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The new_port and del_port device attributes call nsim_drv_port_add() and
nsim_drv_port_del(), which fetch the driver private data with
dev_get_drvdata().  If the device has been unbound from the driver, that
private data is NULL and priv_to_devlink() turns it into a bogus pointer,
so a write to either attribute faults in devl_lock():

  BUG: unable to handle page fault for address: fffffffffffffeb0
  RIP: 0010:__lock_acquire
  Call Trace:
   ...
   nsim_drv_port_add
   new_port_store

sriov_numvfs_store() already guards against this by taking device_lock()
and checking dev_get_drvdata().  Do the same in new_port_store() and
del_port_store().  Holding device_lock() also prevents the private data
from going away between the check and its use.

Fixes: 794b2c05ca1c ("netdevsim: extend device attrs to support port addition and deletion")
Reported-by: syzbot+b3fca27eb4005f0111f4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b3fca27eb4005f0111f4
Signed-off-by: Shuai Liu <847807867@qq.com>
---
Tested with the syzbot C reproducer on x86-64 QEMU using a KASAN +
lockdep kernel: without this patch the kernel panics in
nsim_drv_port_add() with a page fault at 0xffffffffffffef0; with it, the
write to new_port returns -ENOENT, the concurrent create/unbind/delete
race loop completes without a report, and adding/deleting a port on a
bound device still works.

AI assistance disclosure: the root-cause analysis and the draft patch
were produced with an AI coding assistant from the syzbot report; the
change was compiled, checkpatch-tested and runtime-verified as described
above.
---
 drivers/net/netdevsim/bus.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/net/netdevsim/bus.c b/drivers/net/netdevsim/bus.c
index b792ee10b1c1..abcd0f38d85c 100644
--- a/drivers/net/netdevsim/bus.c
+++ b/drivers/net/netdevsim/bus.c
@@ -93,8 +93,13 @@ new_port_store(struct device *dev, struct device_attribute *attr,
 		return -EINVAL;
 	}
 
-	ret = nsim_drv_port_add(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF, port_index,
-				addr_set ? eth_addr : NULL);
+	device_lock(dev);
+	ret = -ENOENT;
+	if (dev_get_drvdata(dev))
+		ret = nsim_drv_port_add(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF,
+					port_index, addr_set ? eth_addr : NULL);
+	device_unlock(dev);
+
 	return ret ? ret : count;
 }
 
@@ -115,7 +120,13 @@ del_port_store(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
-	ret = nsim_drv_port_del(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF, port_index);
+	device_lock(dev);
+	ret = -ENOENT;
+	if (dev_get_drvdata(dev))
+		ret = nsim_drv_port_del(nsim_bus_dev, NSIM_DEV_PORT_TYPE_PF,
+					port_index);
+	device_unlock(dev);
+
 	return ret ? ret : count;
 }
 
-- 
2.53.0

