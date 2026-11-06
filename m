Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=18.194.254.142
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793964422;
	b=G5BH+SF4tXaNflOXaz9NBet2ULAUpi39ffCDg4Uv1UlTBFJ8s69hL0g4z2i8AqcQ9XwO
	 3ctj6xVQ2ufoimFittSZJCIiV80002QdmVkBMwElRKeSpLi9oNPWcTBKcoiyTvYvier4D
	 hqs3gyFaBuS4wcEQB1YwwVdY3m3Xw2JTftNjK04nn6ROXRAZ3wIgX7dapKovi9elXk/pA
	 KjwLllR7Dvf47zlm751k6SNTZ8AUhAlij141ucq6IM3X5C2sj2ROFdiqH7RFCcF95FVnT
	 Kg/bVO8IJrGBF3KC47Rl4I0rLjHZd+Bp5X8X1c2fQLA9S2apvRuhswdwWmdo3bdzm0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793964422;
	h=DMARC-Filter:X-QQ-mid:X-QQ-Originating-IP:Received:X-QQ-SSF:
	 X-QQ-GoodBg:X-BIZMAIL-ID:EX-QQ-RecipientCnt:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-QQ-SENDSIZE:Feedback-ID:X-QQ-XMAILINFO:
	 X-QQ-XMRINFO:X-QQ-RECHKSPAM;
	bh=9pZkdeVJl7R8SXcoQCcXrYP4kUb4kP91dWdpJkr349g=;
	b=TAe2HFCiD9XetYSd6/+Mc7yycJl+3iGi3An71VZnpgQuStmLApMTp5UXmYrk2gQdh2tM
	 E745M+WIFhp3UwVGW6nJ3GC9mMZgTWolAqXplNRm5oEkUBW/PpFjuzpTlYrq8eVg7XwT2
	 Fx3JNdfbXAX5Ve4nKdzxwa8PaIVfW4P+qfK0AcWI3/D1sq/NbKwdYxopVLbCqReFJv4zf
	 WGsJFW+hEVD/AFgqe0fgaqeT1aADh3xaShpHHlLVqCehjZ2d5F+nWmwPYlVWyP8trRJPV
	 zDa3pel030HWCaGmotw2Onr3XNbpVg9PIkf61Bt3sz9cS+c5EeoH8OfBGPIBz2oAVNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mucse.com;
	spf=pass smtp.mailfrom=mucse.com;
	arc=none smtp.remote-ip=18.194.254.142
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18DAB606A338;
	Fri,  6 Nov 2026 11:26:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18DAB606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mucse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mucse.com
X-QQ-mid: esmtpgz11t1793964349ta682decf
X-QQ-Originating-IP: JONAMwfQXG1DB2Jgg0lA0PU+BNlRVHnDTsOBoSHteQY=
Received: from nic-Precision-5820-Tower.tail7b ( [203.174.112.180])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 06 Nov 2026 19:25:46 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14686409550492991758
EX-QQ-RecipientCnt: 10
From: Dong Yibo <dong100@mucse.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	dong100@mucse.com,
	yaojun@mucse.com
Subject: [PATCH net-next 4/5] net: rnpgbe: Allow changing the primary MAC address
Date: Fri,  6 Nov 2026 19:25:44 +0800
Message-ID: <425F4F0858D134DD+20261106112544.44210-1-dong100@mucse.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <FB722C2F25FE9005+20261106112420.43050-1-dong100@mucse.com>
References: <FB722C2F25FE9005+20261106112420.43050-1-dong100@mucse.com>
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
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:mucse.com:qybglogicsvrgz:qybglogicsvrgz3a-1
X-QQ-XMAILINFO: MQjKimNqHmey8MTT4ZNphzZA84gT8MZchVwAbeHs2ByLhtnwq8+rpgDv
	BGQRXUG6RP9SE/PUJzWuZEvJN5xdBlM4dQV95KnSi5RVJItB0TAsQzLcn3ZNoi/R3vrouX8
	hHELz7BOUjbWUarLqAVZt98HgOV+fIY+yaub6p8krqc3FoS6gBISUUSjW50Hi6duiEkf26m
	AQmM0YOPJC/yHZEjNHxa4yM5cPJGuxhpcLSBkB1WbOuQbHaG8khaXYke+3pVw4N4REVBwgb
	ZSjOCvNZaxEIkqLkhk6cTkIrjzBZsO7pX6icdCv1Cp3wd45w2Cae3o2AHYVqcSMhnlMAELW
	aVylDYaEasUrBXV9r8hmCE1DjmEIgEBkUjL6yycd1XbV/SlIs/tuvYqC2O9LgPel54kQJTe
	zElBB0WikOfVkZx7y7HV1NeO+6ivtm54TxLyIt91m3EI8/djsIXzNDkgkR08P6bhqMn3/MD
	+pm28RfFzaHi1mDP9C/3oE1WWjVLLWlPgnFZpPS/RTLHTxNP8VcbnKUDBk1wi/vq4/18u6R
	kT6NTsMQ/YZORI7V81YTOyF9EgplMVil1nMBvAfKvW5Xke2KQuaI0pqcTrc8/PLFstOpQGU
	gitso4Z0v+vgjs+owJqkBLGnQ1sxmBjQkZEzQOm8p3NyldSV3Rv5Dcd2ANPXx6L4ah5XD7H
	IjZbIHa9bb2/f9itX49ATLL4KRo8G+7o6Kkr5413FtAHFfdZ6wuLD5nH6hR7ENMIGDYYPWN
	+xOSV8Yl381T5u3ounIkWHiFkYKnanyCfsV3cyJFZNQ2rWphTmNwcHjF7397ocl8OR9/F5m
	bzg41fR5U2D3sjrRE8jNvgcLqR7rbRkZf05nYdh+tEDEr30g4EPdB7dRpS5Vq1hafg+AdnC
	q0VFJhWBnVUeh9sf/4dt4pm4n98xXa2e1854NqivqXVUlHxQ9WZ7PiCn9MpmO3wnLrdn+zx
	hp1KMrfVxVrWCehv1OGsZLgTGGq6jS4LzPAh0KuLTQraSP+F2IN7lmKLkTivejuudq2d2qV
	vITVEo7Y9KU8g6bcmxzPIk/4xQT56dkevAdxFwhSVq0m9+8N1Rcscj15p7Xnq0NTFSCgqHu
	IUkdEMyQlaEngKN2NiKanc=
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
X-QQ-RECHKSPAM: 0

Add ndo_set_mac_address support to change the primary MAC address
while the interface is up or down. Validate the new address with the
standard Ethernet helpers, then update the primary receive address
filter and the netdev address.

Signed-off-by: Dong Yibo <dong100@mucse.com>
---
 drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h    |  1 +
 .../net/ethernet/mucse/rnpgbe/rnpgbe_chip.c   | 23 +++++++++++++++++++
 .../net/ethernet/mucse/rnpgbe/rnpgbe_main.c   |  4 +++-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
index 83267d475257..8574377e3a22 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe.h
@@ -269,6 +269,7 @@ int rnpgbe_init_hw(struct mucse_hw *hw, int board_type);
 int rnpgbe_set_rx_mode(struct net_device *netdev,
 		       struct netdev_hw_addr_list *uc,
 		       struct netdev_hw_addr_list *mc);
+int rnpgbe_set_mac_address(struct net_device *netdev, void *addr);
 void rnpgbe_set_link(struct mucse_hw *hw, bool linkup);
 
 extern const struct ethtool_ops rnpgbe_ethtool_ops;
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
index a6ab94bd1578..7505c9f6c79d 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_chip.c
@@ -232,6 +232,29 @@ static void rnpgbe_clear_rar(struct mucse_hw *hw, u32 index)
 	mucse_hw_wr32(hw, RNPGBE_RX_RAR_LOW(index), 0);
 }
 
+/**
+ * rnpgbe_set_mac_address - Change the interface's primary MAC address
+ * @netdev: network interface
+ * @addr: socket address containing the new MAC address
+ *
+ * Return: 0 on success, negative errno for an invalid address
+ */
+int rnpgbe_set_mac_address(struct net_device *netdev, void *addr)
+{
+	struct mucse *mucse = netdev_priv(netdev);
+	struct sockaddr *sa = addr;
+	int err;
+
+	err = eth_prepare_mac_addr_change(netdev, addr);
+	if (err)
+		return err;
+
+	rnpgbe_set_rar(&mucse->hw, 0, sa->sa_data);
+	eth_commit_mac_addr_change(netdev, addr);
+
+	return 0;
+}
+
 int rnpgbe_set_rx_mode(struct net_device *netdev,
 		       struct netdev_hw_addr_list *uc,
 		       struct netdev_hw_addr_list *mc)
diff --git a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
index 31871b244882..09d499dc10ee 100644
--- a/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
+++ b/drivers/net/ethernet/mucse/rnpgbe/rnpgbe_main.c
@@ -160,6 +160,8 @@ static const struct net_device_ops rnpgbe_netdev_ops = {
 	.ndo_stop		 = rnpgbe_close,
 	.ndo_start_xmit		 = rnpgbe_xmit_frame,
 	.ndo_set_rx_mode_async = rnpgbe_set_rx_mode,
+	.ndo_set_mac_address	 = rnpgbe_set_mac_address,
+	.ndo_validate_addr	 = eth_validate_addr,
 	.ndo_get_stats64	 = rnpgbe_get_stats64,
 };
 
@@ -253,7 +255,7 @@ static int rnpgbe_add_adapter(struct pci_dev *pdev,
 
 	netdev->netdev_ops = &rnpgbe_netdev_ops;
 	netdev->ethtool_ops = &rnpgbe_ethtool_ops;
-	netdev->priv_flags |= IFF_UNICAST_FLT;
+	netdev->priv_flags |= IFF_UNICAST_FLT | IFF_LIVE_ADDR_CHANGE;
 	rnpgbe_sw_init(mucse);
 	err = rnpgbe_reset_hw(hw);
 	if (err) {
-- 
2.50.1

