Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D153C1F94F;
	Mon, 15 Jun 2026 07:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781506847; cv=none; b=CrB/276ITa82RFGKwHcMG6sXZdTINf5mI0FgKNOWOKBF8VQX+sKjfpbfRWvkOaHTI5znRtk6y2F4fPmS3KT1mLLuBy7J1TIp7Hh9K/UymuZAUxPC1GsbDKrCWXXyAfTT/kH/t2iKWC7tqmC35jD8g8ee1hg6oDCDLPPPxkL9Rus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781506847; c=relaxed/simple;
	bh=lUk4QNKurARVea8fPnvI+bouDgrGde9yYR2grZyoqaA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jIFWPvQbWT1kjGowQiJGaZqovKF5iaJCqb9BgiDygFmyc+jOMOv1ExLQPQIc8LJnv0yONNpPUsM0cvX3NAI3SBm+TWtBU0Ftyd0hptQKP47QXfM8fwnXtH58Z6x7OvT56gthtxBHYZn+PIp/qvREkNiXEelmwR6lvQ7vVLKNMKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowACX_uEXoy9q_hqUEw--.34794S2;
	Mon, 15 Jun 2026 15:00:39 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Kees Cook <kees@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: pengpeng@iscas.ac.cn
Subject: [PATCH] net: ehea: unwind probe_port sysfs file on failure
Date: Mon, 15 Jun 2026 15:00:31 +0800
Message-ID: <20260615070033.43461-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowACX_uEXoy9q_hqUEw--.34794S2
X-Coremail-Antispam: 1UD129KBjvdXoW7XFWDJw4rXrWkAw13Zry5urg_yoWDurXEkw
	13ZF95Ja18J34rKFy7tw42grWS9Fyqgr1rAr4UKayfJF17XwsrZr93AwnxXr1Du3y8uFy5
	CFnrXryak34jkjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4AFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVW8JVWx
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcSsGvfC2KfnxnUUI43ZEXa7VUbUPED
	UUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

ehea_create_device_sysfs() creates probe_port and then remove_port. If
the second device_create_file() fails, the helper returns the error but
leaves probe_port installed even though probe treats the sysfs setup as
failed.

Remove probe_port on the remove_port creation failure path so the helper
leaves no partial sysfs state behind.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/ethernet/ibm/ehea/ehea_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ehea/ehea_main.c b/drivers/net/ethernet/ibm/ehea/ehea_main.c
index ff67c4fd66a3..bfc8699a05b9 100644
--- a/drivers/net/ethernet/ibm/ehea/ehea_main.c
+++ b/drivers/net/ethernet/ibm/ehea/ehea_main.c
@@ -3216,6 +3216,8 @@ static int ehea_create_device_sysfs(struct platform_device *dev)
 		goto out;
 
 	ret = device_create_file(&dev->dev, &dev_attr_remove_port);
+	if (ret)
+		device_remove_file(&dev->dev, &dev_attr_probe_port);
 out:
 	return ret;
 }
-- 
2.50.1 (Apple Git-155)

