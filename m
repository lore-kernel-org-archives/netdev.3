Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACD63EBF1F
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 05:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770875637; cv=none; b=FA/O+Nkia7+yq7gvxpqsYfxBcec+S6n5RfrO8Mf7ZLLIAlqj01OEky/INfH4NMpWAAxloPUVUbBxzsr0UW9bQUlzdY3dn16a3tFUHikMMt7yxMuOdXZtQ50oa7NnoHZNU7ZbeJt2PAGVri7ihwkzbmqlWPnUJVr/QTbKyxoNzck=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770875637; c=relaxed/simple;
	bh=hUmJILCrldbMoz0jfWb4ekQteUhBE7yn54wjaZGOzqs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U+h2nmUoIC+qdZNzJnpoDTbSn2D6UW8NnkCSTogq+vIPGJQseBsMh7VG96vyABuZrlpdXDnmie9Oxo72uZSn8s/y6sMbqvfR/Tip9eS+0SbwD6KVHWrHhGXPZJzJFkkc7vyWPwdjfja6ekjIOkEmQXSqTouIVYsBv8dN4pBLJvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost (unknown [124.16.138.129])
	by APP-03 (Coremail) with SMTP id rQCowACXt97Zao1poJpLCA--.17868S2;
	Thu, 12 Feb 2026 13:53:29 +0800 (CST)
From: Chen Ni <nichen@iscas.ac.cn>
To: kuba@kernel.org,
	netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	arnd@arndb.de,
	Chen Ni <nichen@iscas.ac.cn>
Subject: [PATCH net v2] myri10ge: replace comma with semicolon to fix regression
Date: Thu, 12 Feb 2026 13:50:28 +0800
Message-Id: <20260212055028.3248491-1-nichen@iscas.ac.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowACXt97Zao1poJpLCA--.17868S2
X-Coremail-Antispam: 1UD129KBjvJXoW7CrW5Gw4kJry7XF45ZF18Xwb_yoW8WF4kpa
	y2gayxZF17Jr4rXF48Xw10gFn8KFyYqr9ruryakw4Fgw18J3s7ZF4UKFyrCF4rX3y7Jr1Y
	kFyjyw17XFsIv37anT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvq14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	tVW8ZwCY02Avz4vE14v_GrWl42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr
	1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE
	14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7
	IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E
	87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0x
	ZFpf9x0JUBuWLUUUUU=
X-CM-SenderInfo: xqlfxv3q6l2u1dvotugofq/

This fixes a regression introduced by commit fd24173439c0
("myri10ge: avoid uninitialized variable use"), where a comma was
mistakenly used instead of a semicolon.

Fixes: fd24173439c0 ("myri10ge: avoid uninitialized variable use")
Acked-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Chen Ni <nichen@iscas.ac.cn>
---
Changes in v2:
- Changed subject prefix from [net-next] to [net]
- Added Fixes tag
- Added Acked-by from Arnd Bergmann
---
 drivers/net/ethernet/myricom/myri10ge/myri10ge.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
index 2f0cdbd4e2ac..d9b5d7999370 100644
--- a/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
+++ b/drivers/net/ethernet/myricom/myri10ge/myri10ge.c
@@ -688,9 +688,9 @@ static int myri10ge_get_firmware_capabilities(struct myri10ge_priv *mgp)
 
 	/* probe for IPv6 TSO support */
 	mgp->features = NETIF_F_SG | NETIF_F_HW_CSUM | NETIF_F_TSO;
-	cmd.data0 = 0,
-	cmd.data1 = 0,
-	cmd.data2 = 0,
+	cmd.data0 = 0;
+	cmd.data1 = 0;
+	cmd.data2 = 0;
 	status = myri10ge_send_cmd(mgp, MXGEFW_CMD_GET_MAX_TSO6_HDR_SIZE,
 				   &cmd, 0);
 	if (status == 0) {
@@ -821,9 +821,9 @@ static int myri10ge_change_pause(struct myri10ge_priv *mgp, int pause)
 	int status, ctl;
 
 	ctl = pause ? MXGEFW_ENABLE_FLOW_CONTROL : MXGEFW_DISABLE_FLOW_CONTROL;
-	cmd.data0 = 0,
-	cmd.data1 = 0,
-	cmd.data2 = 0,
+	cmd.data0 = 0;
+	cmd.data1 = 0;
+	cmd.data2 = 0;
 	status = myri10ge_send_cmd(mgp, ctl, &cmd, 0);
 
 	if (status) {
-- 
2.25.1

