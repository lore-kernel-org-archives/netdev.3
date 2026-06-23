Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5467D3ACA79;
	Tue, 23 Jun 2026 06:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782195366; cv=none; b=KrY550VP3e6r04KLlV8nlZMWkIlnqAkyc7Ptgb00gnrAundVimGWhG0PLlKY4K+js2zRRNrqdVSXvIMDNWAhSNB9qBkR1Vfh/JUYFnhEQGQ9KAFdVWQ4P+oQzeFap8RhbKF8mTK8zrt5ozFwBLtg5ndWy6P0tXhRgsWXiLynynY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782195366; c=relaxed/simple;
	bh=dltAV1c0sfR46UqvP8RllgnPbtkyfse/asDFH0vbGjk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nioQtPt9PTTj7qV1O1C6E8WvnprH0F0KW1cdUEHRaaNAs/xI/TQlGYEnwWO3gWXMEUn2NZq3VgFPT6JjPS3eshIs7kcNwqjuSYHBJxLNLawzSxGRMSzCJPnhGq1qsYl1IpsNMpjTF+UbC8ord6dFcGS2pv7JjZQlRKPUVWo1HDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-05 (Coremail) with SMTP id zQCowADHINSVJDpqLTTKFA--.5253S2;
	Tue, 23 Jun 2026 14:15:49 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Doug Berger <opendmb@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH net] net: bcmgenet: report MDIO busy timeout
Date: Tue, 23 Jun 2026 14:15:24 +0800
Message-ID: <20260623061524.51411-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:zQCowADHINSVJDpqLTTKFA--.5253S2
X-Coremail-Antispam: 1UD129KBjvdXoWruw1Duw1xCF15KFW3CFyUZFb_yoWkKrX_Ww
	4vqF9rGw48KFyqkw42yr45A34I9FWqvr1kua4I9ryaga9xZw17Zws5Ary5AryDWFWxZF98
	Jw1aya4fA34I9jkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUba8FF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUtVWrXwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628v
	n2kIc2xKxwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7x
	kEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E
	67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUCVW8Jw
	CI42IY6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWU
	CwCI42IY6I8E87Iv67AKxVW8JVWxJwCI42IY6I8E87Iv6xkF7I0E14v26r4UJVWxJrUvcS
	sGvfC2KfnxnUUI43ZEXa7VUbUPEDUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

bcmgenet_mii_wait() waits for the UNIMAC MDIO command busy bit to clear,
but ignores wait_event_timeout() and always returns success.

Return -ETIMEDOUT when the busy bit remains set for the whole wait
period so MDIO callers see the failed transaction instead of continuing
as if the bus were idle.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/ethernet/broadcom/genet/bcmmii.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/genet/bcmmii.c b/drivers/net/ethernet/broadcom/genet/bcmmii.c
index a4e0d5a68268..92b5997d00b2 100644
--- a/drivers/net/ethernet/broadcom/genet/bcmmii.c
+++ b/drivers/net/ethernet/broadcom/genet/bcmmii.c
@@ -439,10 +439,12 @@ static int bcmgenet_mii_wait(void *wait_func_data)
 {
 	struct bcmgenet_priv *priv = wait_func_data;
 
-	wait_event_timeout(priv->wq,
-			   !(bcmgenet_umac_readl(priv, UMAC_MDIO_CMD)
-			   & MDIO_START_BUSY),
-			   HZ / 100);
+	if (!wait_event_timeout(priv->wq,
+				!(bcmgenet_umac_readl(priv, UMAC_MDIO_CMD)
+				& MDIO_START_BUSY),
+				HZ / 100))
+		return -ETIMEDOUT;
+
 	return 0;
 }
 
-- 
2.50.1 (Apple Git-155)

