Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23E6375F96
	for <netdev@vger.kernel.org>; Tue,  3 Mar 2026 03:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772507094; cv=none; b=V+PFYbBkHTKtw7+O4sdJwORhxkM5zDlwZNIqXXptJQjR9fZb9JSfuV7GcLVF9x2uteFNVhrbOViP8mRGhVNcg/cWeC1fEVrTEslQC3Lwoehje90L8OHr3Tx6wr6zKqnw+n2RaAKk/50A7AgkUevg4a57TZAyTQxKN1f73oVhHOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772507094; c=relaxed/simple;
	bh=DS37ZtIrZGfCBkLXCBoFV4Vy2v8jIKZx0O9zqzQ8JUA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ggm439rEETAb6K8YFAS7hW3ytQ/5ZkCjLjixIqhTwB/4kMTyRRbwG9qRhvDMt2NaOG/zuNSb1GPZ0j5nxyW0+ejWjrsgJbwcSLpDLV/70xVsXTdEyyQ0LdsmDHC0ujUznftaS6b0Yy2FcQhZMs5Il67CCMYXT2MWg/yD8b0hX64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: esmtpsz19t1772507046t36c9f2fc
X-QQ-Originating-IP: 2LoGqsZ0zODGA3pflDhUi3QC+BweNUK4iq28vijmKHY=
Received: from lap-jiawenwu.trustnetic.com ( [125.120.70.252])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 03 Mar 2026 11:04:04 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8353490627856057035
EX-QQ-RecipientCnt: 18
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Kees Cook <kees@kernel.org>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Joe Damato <joe@dama.to>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Abdun Nihaal <abdun.nihaal@gmail.com>,
	Breno Leitao <leitao@debian.org>,
	Jiawen Wu <jiawenwu@trustnetic.com>
Subject: [PATCH net-next v3 7/9] net: wangxun: delete service_timer before cancel service_work
Date: Tue,  3 Mar 2026 11:03:29 +0800
Message-Id: <20260303030331.24076-8-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.21.0.windows.1
In-Reply-To: <20260303030331.24076-1-jiawenwu@trustnetic.com>
References: <20260303030331.24076-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: McFs54YitxxB+ypTG+xNQodfOi0VXws3wVx1fRkQhmQqOxalJLV1pe9l
	ajg9zAtZVMkF+c04r1drgoHci0a148tzGk+a2SSF7oi6Thqyil1JeTMOH1yUQPopI5hu0/y
	rc7feU/5g+g54t6Qz3/rIm089ySB9vdKrvdyDEZch4QaOzNODQZaG8lXnCAZwL04KUgeMvI
	Iy4bWvXBT3iNIDmzlIe8gxm6g0TkOiHUmr+ssPgwDTMip6V98gTicvj1sNYg3zWTls6Z6ZW
	f1YDjHB6ifDMJMFTN2zQk8fDRqVSCKPdX2XkEUqvxYXP17MeyVJNW30ed4Yq4KdA+jZYdq2
	kxJjbmUjym86FQMMFtPn3KF/wUTfuHltvMvuMVDQqdMBx8Nk6tdDJFcz79RQX6q+BbxXHsu
	8zOpT1JSAA0cd9R/6p5KcB7N6LcDNhhssK2oVG153/BvGu81vZYF/W8c1I0MiW2PI7AEOiY
	5MR7EHqexFBk6xzJnv2RSmtTJZhTGnw3gKxR6PG35DAw43ES3Tw5yzXw3lbImcSy8jJDsaR
	h6y2w0djlB2FCEQp+beywcriCW6pXl1O/DUbaT019TxqPHwactCBuQzwCY02D8362yicNuF
	I/LuG2/ir2CUZZwH4CAMWwiLtbm6f6AwKsKH/rpbmOYJQFWMKT79hxJ4TPMJpcUshBZevZF
	7BcmV8jRb+V/yWOs2gszuLvCyS0W2d3w09x4KYL9+BnYIgc7gi1yxrH2hDn7z5rMCWH+7fm
	n1TAWo8TkC0pTRGI0Q34g+FLg95WEgc7ZaZ9WjR2wXZMVtLD1CAzQ5qOEEpzd0n9Jbh2Y1Y
	7PEIXO22Uo1Dc3oODxnEsCbAVdVdMhBdIz8wBhoxdSZsH3FQpbrWRI+AOG4f/GyDWtGPZvM
	IsRd5LW6D+Ux6XB9r47EcHKyTywvjqXqcCCp5ukxuLGuqIZBs84iM1Pa7KrFnNlG6EU58o4
	sJq8W6/eta1FpGMsYUgN/s9eHClhq3TwBYxhmICZyGiSVdUm2Drtzte0Ndv/ZjJRSRr9gN+
	tMOyz4cDo4d05Z7cBui3OHNsG+IWlGaLG7nNbuKW/DDDSHqRiLHm7H9lR0ZaF3zFhzAZKJI
	JyKZwfR/1PibXMP8ISNYXbqtC01RSa0qQ==
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

When removing the device, timer_delete_sync(&wx->service_timer) is
called in .ndo_stop() after cancel_work_sync(&wx->service_task). This
may cause new work to be queued after device down. So we should delete
service_timer first.

Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
---
 drivers/net/ethernet/wangxun/libwx/wx_vf_common.c | 1 +
 drivers/net/ethernet/wangxun/txgbe/txgbe_main.c   | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index ade2bfe563aa..5565062c7471 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -48,6 +48,7 @@ void wxvf_remove(struct pci_dev *pdev)
 	struct wx *wx = pci_get_drvdata(pdev);
 	struct net_device *netdev;
 
+	timer_delete_sync(&wx->service_timer);
 	cancel_work_sync(&wx->service_task);
 	netdev = wx->netdev;
 	unregister_netdev(netdev);
diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
index ddc7cea9d7c2..01ceaf270b70 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_main.c
@@ -936,6 +936,7 @@ static void txgbe_remove(struct pci_dev *pdev)
 	struct txgbe *txgbe = wx->priv;
 	struct net_device *netdev;
 
+	timer_delete_sync(&wx->service_timer);
 	cancel_work_sync(&wx->service_task);
 
 	netdev = wx->netdev;
-- 
2.48.1

