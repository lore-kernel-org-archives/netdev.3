Received: from zg8tmtyylji0my4xnjqumte4.icoremail.net (zg8tmtyylji0my4xnjqumte4.icoremail.net [162.243.164.118])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 120E932860B
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 12:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.243.164.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778068957; cv=none; b=kbWJmB4DKEqIIM6ArrLRDODINOnesIeGDETs8yG3amHMUfeURggjzO/gTnCfeyMZ5yhlBZlvJBbCNfvXeU5K3tCRaz3B5DAueKNpiFKZd8HK9fSLNHLXnjatQKASbLMkRNEgrqxRrk/3IGR7oKMJH8rpXILcFaCnOAz4Ow6Eg30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778068957; c=relaxed/simple;
	bh=JevKvqEoCV5HOOmeRsFLrsJ/B/S3ZF7ioy1uOuAeA5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=uu2ZgACl4ROC8OerU8AW/pPP0ly0hj5qRPryKgfPJdrnyuwYa8HXLU8ublmWnpqLgtpcuuk4rS7BrM6RFzlYi2bCJS7laDxdg6XMEi9Eb0j5++a2UX0DZInVk0huSOBM1W8qgfXsKLtId01XvCLsPg5oeICWYcO9aUBof8+p83c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn; spf=pass smtp.mailfrom=std.uestc.edu.cn; dkim=fail (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b=ZVk0Z7gS reason="key not found in DNS"; arc=none smtp.client-ip=162.243.164.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=std.uestc.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=std.uestc.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=std.uestc.edu.cn header.i=@std.uestc.edu.cn header.b="ZVk0Z7gS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=std.uestc.edu.cn; s=dkim; h=Received:From:To:Cc:Subject:Date:
	Message-ID:MIME-Version:Content-Transfer-Encoding; bh=YCH4/Oh1h7
	ugBA6on6GNy/JNOCllkQ7/BlsuNW96NkU=; b=ZVk0Z7gS0L/4t9eVt3A/Klsrvu
	QKPsOpkS0vVuVt+3oNgGjUy1I2MLsjt1Wfuu8BtxwH8MlrQLQNUnD7rtAE6tgqHO
	LS55AqeB8sQg9Cptdi+D28eQt2YW+Su84c2R1A5gK3hs+/fP9nM6gbmXsMdEHiMP
	ZcuFbX3ICfYKk11gM=
Received: from hotaru.tailb307d0.ts.net (unknown [183.94.22.109])
	by hzbj-edu-front-4.icoremail.net (Coremail) with SMTP id BrQMCkAmzLe1LftporfvAQ--.14752S2;
	Wed, 06 May 2026 20:01:58 +0800 (CST)
From: Quan Sun <2022090917019@std.uestc.edu.cn>
To: netdev@vger.kernel.org,
	maxime.chevallier@bootlin.com,
	andrew@lunn.ch
Cc: kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Quan Sun <2022090917019@std.uestc.edu.cn>
Subject: [PATCH net] net: ethtool: fix NULL pointer dereference in phy_reply_size
Date: Wed,  6 May 2026 20:01:31 +0800
Message-ID: <20260506120131.767679-1-2022090917019@std.uestc.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:BrQMCkAmzLe1LftporfvAQ--.14752S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyDZFW3ZFWkWFyrZFyUtrb_yoW8XFWxpr
	W5AFWFqr97twnrXr17Jw4rCryYkFs7C3W3ta4jkw1fZr13WrW8Xr45Kr10gayrZrZ5ua4j
	qF4Fqas0v3ZrCFUanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUU9G14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVWxJr
	0_GcWlnxkEFVAIw20F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_JrI_JrylYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1lc2xSY4AK67AK6ryUMxAIw28IcxkI7VAKI48JMx
	C20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAF
	wI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20x
	vE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v2
	0xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxV
	W8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUbFksDUUUUU==
X-CM-SenderInfo: asqsjiyzqzilqqrzq21wgo3vxvwfhvlgxou0/

In phy_prepare_data(), the strings rep_data->name and rep_data->drvname
are allocated using kstrdup(). However, the return values of these
allocations are not checked.

If kstrdup() fails to allocate memory, it returns NULL. The function
phy_prepare_data() will still return 0 (success). Subsequently, the
handler ethnl_default_doit() continues the execution flow and calls
phy_reply_size() to calculate the size of the reply message. This
unconditionally executes strlen(rep_data->name), leading to a kernel
NULL pointer dereference and panic.

Fix this by properly checking the return values of kstrdup() for both
`name` and `drvname`, and returning -ENOMEM if the allocation fails.

Signed-off-by: Quan Sun <2022090917019@std.uestc.edu.cn>
---
 net/ethtool/phy.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ethtool/phy.c b/net/ethtool/phy.c
index d4e6887055ab1..6cf3df1df8659 100644
--- a/net/ethtool/phy.c
+++ b/net/ethtool/phy.c
@@ -88,8 +88,17 @@ static int phy_prepare_data(const struct ethnl_req_info *req_info,
 		return -EOPNOTSUPP;
 
 	rep_data->phyindex = phydev->phyindex;
+
 	rep_data->name = kstrdup(dev_name(&phydev->mdio.dev), GFP_KERNEL);
+	if (!rep_data->name)
+		return -ENOMEM;
+
 	rep_data->drvname = kstrdup(phydev->drv->name, GFP_KERNEL);
+	if (!rep_data->drvname) {
+		kfree(rep_data->name);
+		return -ENOMEM;
+	}
+
 	rep_data->upstream_type = pdn->upstream_type;
 
 	if (pdn->upstream_type == PHY_UPSTREAM_PHY) {
-- 
2.43.0

