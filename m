Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0A0381EB4;
	Thu,  8 Oct 2026 16:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791476481; cv=none; b=DhrenYn/3lhZ2+yO07RhgXIqWfhWZC8diV3kEkWixgVbMJ3cYVc6bvw9e/5GAS4/KR18Cxz1UYSZMDm22LqOEE9F8E1AP7/j7geXfEh8hKYmwCXvDLJngJ3RqmYyulci+rS+EJ1AgL56G0K6EcNpFmw1khtpvUUkRwb/y/ykgxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791476481; c=relaxed/simple;
	bh=vJJATCc4xQHEhqhlD65ChApZ63uTPiWF+TCISQhJer8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=L07ZgeoSi2xt7mQjdikayngqz7EwND3YNzDsDwzViHKK+JLYF0j/xE7NJzDqKyYsKkt0EaKCO+E4zCjXU4czYavH5wD5n/vDGqVZQidBZLfn+JtLpGo0kowNOViztB0RGKegipdPCMyriJSldEPLcSatOcfJNPRt5c4+WmuHBA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from fc87d0ffb700.home.arpa (unknown [36.110.52.2])
	by APP-03 (Coremail) with SMTP id rQCowABXVzXzwsdqZfMNCg--.11577S2;
	Fri, 09 Oct 2026 00:21:07 +0800 (CST)
From: Haotian Zhang <vulab@iscas.ac.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: winbond-840: release IRQ on alloc_ringdesc() error path
Date: Fri,  9 Oct 2026 00:21:09 +0800
Message-Id: <20261008162109.2678143-1-vulab@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowABXVzXzwsdqZfMNCg--.11577S2
X-Coremail-Antispam: 1UD129KBjvJXoWxJrW8Cry3Kry7XF4fXFWfAFb_yoW8WF18p3
	yUXa40vrykXF1kGa1vyw1vgFW5Ca1xKrWrWry0v34furn8tr12k3yrKFyj9w1rA3ykGa13
	tryDZ34xurZ8GaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkSb7Iv0xC_Kw4lb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I2
	0VC2zVCF04k26cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rw
	A2F7IY1VAKz4vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xII
	jxv20xvEc7CjxVAFwI0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4
	A2jsIEc7CjxVAFwI0_Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI
	64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r106r15McIj6I8E87Iv67AKxVWUJVW8Jw
	Am72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lc7CjxVAaw2AFwI0_JF0_Jw1l
	42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJV
	WUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAK
	I48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4j6F
	4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY
	6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjxUqHqcDUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwUOA2rHpl1KVgAAsF

netdev_open() registers the shared IRQ with request_irq() and then calls
alloc_ringdesc().  When alloc_ringdesc() fails, the error path jumps to
out_err, which only calls netif_device_attach() and returns.  The IRQ
handler stays registered forever: net/core/dev.c never calls ndo_stop
when ndo_open fails, so netdev_close(), the only place that frees the
IRQ, is never reached.  The leaked handler is also left enabled on an
uninitialised device.

Add a separate out_err_free_irq label that releases the IRQ before
returning the allocation error, mirroring the cleanup already used by
the sibling de2104x driver.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Assisted-by: DeepSeek-V4.1-Flash
Signed-off-by: Haotian Zhang <vulab@iscas.ac.cn>
---
 drivers/net/ethernet/dec/tulip/winbond-840.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/dec/tulip/winbond-840.c b/drivers/net/ethernet/dec/tulip/winbond-840.c
index a5581f1d0141..2ce05a63b289 100644
--- a/drivers/net/ethernet/dec/tulip/winbond-840.c
+++ b/drivers/net/ethernet/dec/tulip/winbond-840.c
@@ -639,7 +639,7 @@ static int netdev_open(struct net_device *dev)
 
 	i = alloc_ringdesc(dev);
 	if (i)
-		goto out_err;
+		goto out_err_free_irq;
 
 	spin_lock_irq(&np->lock);
 	netif_device_attach(dev);
@@ -655,6 +655,8 @@ static int netdev_open(struct net_device *dev)
 	np->timer.expires = jiffies + 1*HZ;
 	add_timer(&np->timer);
 	return 0;
+out_err_free_irq:
+	free_irq(irq, dev);
 out_err:
 	netif_device_attach(dev);
 	return i;
-- 
2.25.1

