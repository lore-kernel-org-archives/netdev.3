Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F1269CE6
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 07:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484265; cv=none; b=QDCUBs681gGQsxFR7O5hRcpZxS4E+DEhYWdLNODQDcSGQH1EtwrRXm6lli2JozamA5bcoTxSYOz1oiUOcxXpXsFDfq5XTKNCbj3W+YnY4HxqNqpt0CM4zyhMzzpVNvFPfz1NZrsjvNOS8uNkXivSiO7oLWKhjD6kgcRuWtCkJe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484265; c=relaxed/simple;
	bh=ezIPY5/4UepUWaO3RkW7gYe8rIwVtuenowFSmIe9ay8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IntCl0/L5EXoaZAEWJJvs16YKGrgqdsX0mnKvJLjG1yBsbFuRes8Ykqpw17cCaJc2jfiMVZQSrgDucgU1eePs6gQWnXVH2dX6ctwTD3S2rOpqDvfx1kFJncKvq95HYT3gweDNjCkq9rYF4fEOfQmd03vb5G8gm7S4aCAHEgqmYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz1t1785484214tfdaf04f0
X-QQ-Originating-IP: NHCyV86M4/8HhqW/sZU4SiQFTen4ARrpxyaM+eeQzPI=
Received: from localhost.localdomain ( [122.235.139.83])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Jul 2026 15:50:13 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8541116831911288244
EX-QQ-RecipientCnt: 10
From: Mengyuan Lou <mengyuanlou@net-swift.com>
To: netdev@vger.kernel.org
Cc: jiawenwu@trustnetic.com,
	duanqiangwen@net-swift.com,
	linglingzhang@net-swift.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next 4/5] net: Wangxun: add support for basic qstats
Date: Fri, 31 Jul 2026 15:49:57 +0800
Message-Id: <20260731074958.19333-5-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20260731074958.19333-1-mengyuanlou@net-swift.com>
References: <20260731074958.19333-1-mengyuanlou@net-swift.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: MWN2NjqHd6+N5UVzbGiqohpVj03ZhfnLpgg91wZQqIvkvba+Celx0KGQ
	F6oPg+f8RQao4paV1KSw5poUemBBrH5zOKy0a8dUBDWjIyNGcNpE3CJRBxnpzMho9f9R/vs
	R9rV/3KQOIVjTQOskMiFWvXzuKEfc9SoishgJIrJhvbyl9pNjRRXGa/+EmHvbIEb78hSCvn
	6RTnTk3aNM0tn1tKBJJuTHkLiGsJu+eeZUx7pCiOkkGIjz6sRgCh03GsF8IQfKP11tGF8am
	zuv1iUbX21qidcbAgVB0jtlEgFt6opv4UGegAfEjCGq9KxO70r45HE8Gd1ybbEM1Qk63WlM
	lyoDUakxKV3mrKQUsjTTRcZJXnABGghHvujb4fBCtbXXNCdYrN/VLM4MVQ+2Zsk7bgYQPTm
	ExSe4CpN8T9ffxFxlDydQd3okK5Fk+Y1LKBNj0kP55pxDf/kOT2IDWS+LTqD+rm+XyT32iI
	GL3wWGUOAEIvOzRcp0wf/C8qxt03euCa5EL+xgx+usBXh8X394JB0jjJmaua/4f2SxnIGQs
	C0LcX9wQxdN8fKPpCL7kNS6dv92VnMoXBfZo6kBBqAekbSgfyn9vUrCLmAf8govszuIk6zm
	EV4VgGhQQ13YM9jTlO4CE9H5GlFwM2ptb5IN6lJxSncC4Br+X9cqHldtBezJhsdFC5XJOR6
	upd+CVwKOt+kVIAqqLnWUWUineUqkUFFGFtlElyg8wylbQF2Rh0q074k9M/lkGWtzd/optS
	D2HOLtW1Du8uC5V5B63hc12RfYLpiDgMP0ceAbHO7sTNEGbSzdtfTdvAY8v0aer1oTxjK2X
	sLKhOJPhArszIQUlYD96Zdb7qs0mPl06ZAGspYqPvWaUbzlhpDfoNCd0SiFd6SlXVLh1PN5
	rwyjQB70mFRR6OvLiubkm+JVRimhaS3LJRcM4pkVze0P15wAjwPnCPYREHRCMU69pCjgqpZ
	TUxblvpRRumKxkKxsN3T3h5s77fBKvfZVJHE7LXOUVTMby3uHZLf+7dgtG+gRfelByKajle
	BYi8bWn1N0TIYcUhEiI7Fk5bCWpa4q5YcGFpzkrVjB6k1bL4+YLLgFHJeXEngsiPRp+YGlP
	Ejqhaa+hO0YnZfkFDwYeqN/pEh5ZEhQ6r8hE9KVHPmKv+u7wXe0Orj38hbrcDhEoFjgFwPw
	byCgshynB9cDvrZtsSxmBYWqVdPRXkr662REBJ3J7rjBrpg=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

Implement netdev_stat_ops and export the basic per-queue stats
for ngbe, ngbevf, txgbe and txgbevf.
This allows to report per-queue statistics through
the standard networking infrastructure, making them available via
interfaces such as the qstats-get Netlink API.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 drivers/net/ethernet/wangxun/ngbe/ngbe_main.c       | 1 +
 drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c   | 1 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c     | 1 +
 drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c | 1 +
 4 files changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
index a16221995909..d965f7af1697 100644
--- a/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
+++ b/drivers/net/ethernet/wangxun/ngbe/ngbe_main.c
@@ -700,6 +700,7 @@ static int ngbe_probe(struct pci_dev *pdev,
 	wx->driver_name = ngbe_driver_name;
 	ngbe_set_ethtool_ops(netdev);
 	netdev->netdev_ops = &ngbe_netdev_ops;
+	wx_set_stat_ops(netdev);
 
 	netdev->features = NETIF_F_SG | NETIF_F_IP_CSUM |
 			   NETIF_F_TSO | NETIF_F_TSO6 |
diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
index d79cf8d8484f..b6bab050837a 100644
--- a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
+++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
@@ -190,6 +190,7 @@ static int ngbevf_probe(struct pci_dev *pdev,
 	wx->driver_name = KBUILD_MODNAME;
 	wx_set_ethtool_ops_vf(netdev);
 	netdev->netdev_ops = &ngbevf_netdev_ops;
+	wx_set_stat_ops(netdev);
 
 	/* setup the private structure */
 	err = ngbevf_sw_init(wx);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index c277863baf67..7f3d72e53fd3 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -745,6 +745,7 @@ static int txgbe_probe(struct pci_dev *pdev,
 	wx->driver_name = txgbe_driver_name;
 	txgbe_set_ethtool_ops(netdev);
 	netdev->netdev_ops = &txgbe_netdev_ops;
+	wx_set_stat_ops(netdev);
 	netdev->udp_tunnel_nic_info = &txgbe_udp_tunnels;
 
 	/* setup the private structure */
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
index 8b16b900820a..2dd119bd52e5 100644
--- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
@@ -255,6 +255,7 @@ static int txgbevf_probe(struct pci_dev *pdev,
 	wx->driver_name = KBUILD_MODNAME;
 	wx_set_ethtool_ops_vf(netdev);
 	netdev->netdev_ops = &txgbevf_netdev_ops;
+	wx_set_stat_ops(netdev);
 
 	/* setup the private structure */
 	err = txgbevf_sw_init(wx);
-- 
2.30.1

