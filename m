Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E33B3CDBB5;
	Fri, 28 Aug 2026 10:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787914676; cv=none; b=WTEOnD0v73axnLcc/AdAo4AVAegJJV3+w2Nw+CeTVnT01Ji6ZKngJP4iWWjPqoHN3GdQc4RQc3PTftE2r05KBSO6rvbFIvRIa0ts3+OVTuzBNWF7R3udOwm+Uzh8I89J+TT6i2tYp/WG6VuMu5fScAO/TwDfVK0EnQsbCn+znhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787914676; c=relaxed/simple;
	bh=c4RExR98qOMlT+Dt1Gcf8gzVscLZ/1NRkrOaLqWAGEA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LH1qylMpoPmOfI3UccNBj2d+EPS5ufen/Njtfir/fO3Ib6Iyo42uzhn5yLDjXcGuYcheAPh5KZwHeNihl+9CTOfAM3+SWueFLeD0EkmT/lz37Io+UKYjtu8k/kjSqmv++Wf3cOqwyN6HBAFozyJaEkcfL9BcWYSeB/9RpDw7s9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.241.250])
	by APP-01 (Coremail) with SMTP id qwCowABnO++UaZFqrmi9Bg--.42916S2;
	Fri, 28 Aug 2026 18:57:25 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: pch_gbe: Propagate device restart errors from resume
Date: Fri, 28 Aug 2026 18:57:22 +0800
Message-ID: <20260828105722.29952-1-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowABnO++UaZFqrmi9Bg--.42916S2
X-Coremail-Antispam: 1UD129KBjvJXoW7uw13urW7XF1kCr4UWr1UGFg_yoW8AFyDpa
	1DGayrKr97Jw47WF4kGw1UX3W5ua18K3y7GFy7CwsYg3WfAFykKrWrtryYvF1vyrW8JFyS
	vry7Zw4rWFs8JaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26r4j6ryUM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j
	6F4UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr
	1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r12
	6r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI
	0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y
	0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxV
	WUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1l
	IxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUf8nOUUU
	UU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

pch_gbe_up() can fail while allocating the IRQ or receive and transmit
buffers.  The resume path ignores that result and attaches the netdevice
even though restart did not complete.

Return the restart error, leave the netdevice detached, and restore the
PHY and PCI device to the suspended resource state.  pch_gbe_up()
already frees allocations made before its failure.

The issue was identified via static analysis and manually reviewed.

Fixes: 77555ee72282 ("net: Add Gigabit Ethernet driver of Topcliff PCH")

Assisted-by: LLM
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
index 88c5c52e0e38..737bdc9d569e 100644
--- a/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
+++ b/drivers/net/ethernet/oki-semi/pch_gbe/pch_gbe_main.c
@@ -2449,7 +2449,7 @@ static int pch_gbe_resume(struct device *device)
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct pch_gbe_adapter *adapter = netdev_priv(netdev);
 	struct pch_gbe_hw *hw = &adapter->hw;
-	u32 err;
+	int err;
 
 	err = pci_enable_device(pdev);
 	if (err) {
@@ -2462,8 +2462,14 @@ static int pch_gbe_resume(struct device *device)
 	/* Clear wake on lan control and status */
 	pch_gbe_mac_set_wol_event(hw, 0);
 
-	if (netif_running(netdev))
-		pch_gbe_up(adapter);
+	if (netif_running(netdev)) {
+		err = pch_gbe_up(adapter);
+		if (err) {
+			pch_gbe_phy_power_down(hw);
+			pci_disable_device(pdev);
+			return err;
+		}
+	}
 	netif_device_attach(netdev);
 
 	return 0;
-- 
2.43.0

