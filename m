Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B4239BFE7
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 07:50:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484263; cv=none; b=SiBPvmu2PCN1d5uMCb5aW+5+kkGb5quiSRx8AujmRJ8OhtyTtryKFJlI50hbCEljgDniTVF4Vn/vFIdBHCk1nsEe9rGyg1O+Ryv/BDcgqdoZSXLuCXANjzdEcAwlQF+UgCGIbDivTOxZMyD8eJXaYs8q2Qhg2FH24aQ9t4RPOG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484263; c=relaxed/simple;
	bh=RWOkC5nXgh1PUrdl4SHvHqagr95MkQ9gEp+jP/ww+QQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g8urTYzeoP81JCbmUK6oW0LZlpHAc5ZZJP4P+eoOgAa5wEMQhMf+FiSoPYgvR+A0+S2wp140qpQYixXrYkig9fGHjclr5in8MH5tcYuuyH7IxOgfJZ7LLwbLWzXfVCumzQc0CFkf91yBe1nynYdmgIWOGfAESe0xLNX8P7ufLDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz1t1785484207tc916363f
X-QQ-Originating-IP: zr7hujDnyRDSNdbtBu4ehtsEp74E2B5BH52nOU9B+FA=
Received: from localhost.localdomain ( [122.235.139.83])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 31 Jul 2026 15:50:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8670660619835643158
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
Subject: [PATCH net-next 1/5] net: libwx: fix suspend/resume for wxvf
Date: Fri, 31 Jul 2026 15:49:54 +0800
Message-Id: <20260731074958.19333-2-mengyuanlou@net-swift.com>
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
X-QQ-XMAILINFO: NGLdZXNFPGMVvhuzKicP7NGYsezD8E6qnfWXVFkTTcG2ktYEfeTpdWxn
	9kPOd0g4ebnCryE8YI18wNvdEycmT8gIKIu2gliI7p4Pj43VYcEwvM9ZUdQdCnRKfJ3swMn
	s7Y/owda/EZWdOyHTS630by1qiNIXOe+ETJ3tHGfhh3SzsUBHU0ELyo0S0VmAwQIAG9bCFF
	UWaNggmoOcbQ9RNcJ6uEM56qQ2yqVRKP+lrhMYEz2VKYQdb1Sxj62rzZi7EBGOaisipgntW
	LcKd0hnDda5CS/oAkEHXI3JEWYVuoUMNdgm2G7GyRWIVg0/DSdesO6Se01Sy9HyeATtkM1V
	6t2UHkP50DCJzRv+y1s1AgnxH58kWnrVg477E72djjJzNaEzA8XIUW0uskHt6Ti+BRYq8FX
	TVsCsSBj9qKxiK39+YYTgvfQExDtaAv5Q/GXAV2T2+hlhFeGfbmiwXzSEx3P26S4f9tsLDy
	Si8CwzCs8+BMRjBXFDzHQoNX6hjVI1xZ2/LjaFNsOuLd58xgAI+UBtVX9MwrPLT9IEu97u4
	g42Ywz/fn3SHX9/ngU9LCMXi4oiqjwhypizmdIO0cUzizXsntM38YbIr75kyaGaO2WEFUH4
	rk+W4T95WB27Jb/WoaBsjloydhV9/C1DGYyxJofbxxwYom1OI2Tm2FyRhy2Q5w+b1vbyLs8
	Cuc8sMlh0UoA+ip7dgwWRmEKtrRA52cnrSznMOz06nAAcRIHkPf+z4Fh9M7gL6cNtF6LBK5
	0fk1bWqrda1haCTkklRt5weAH8QUpPdzaFPZVWidK4htx4FWX1gVtybKrhKjGwAW1QXEX7w
	JNnQXFpQD4v5jCknGB0QUr5xyexKcLh9H2XbDHUhm2ZwmKCdsDsXW8CaTLLNlbFJ7ka3O8C
	LK15awbprITl/AaMBCzkC56hsgxIfE+EAYbnRQ9E7sLVv49vbbenK+ouHHUkZWiSySvoRy9
	/REr3zGNmZkjTSZDMqqkyncVLJEarsPlA/dL7NeEWkeeDWBAzh1+QeufHRrJF01NM6NBy7o
	lA9iIBPURChHBp1TgVLKbdQn06vrDf1cGeqdoFqXOULDMfhzgIgAsOXgBWjPQhYcwxGvpUx
	qCuyir6Sjim55r53OZRxT4CnIXEtp0lGCgpjPaFPH/kv0X4gnphJKE=
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

Fix the suspend/resume sequence by:
* protecting the open/close path with RTNL,
* closing the netdev before releasing interrupt resources,
* re-enabling the PCI device and restoring bus mastering during resume,
* rebuilding the interrupt scheme, and
* reopening the interface when it was running before suspend.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../net/ethernet/wangxun/libwx/wx_vf_common.c | 21 +++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index 26de78e9a69e..e8448783df3e 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -16,9 +16,13 @@ int wxvf_suspend(struct device *dev_d)
 	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct wx *wx = pci_get_drvdata(pdev);
 
+	rtnl_lock();
 	netif_device_detach(wx->netdev);
+	if (netif_running(wx->netdev))
+		wxvf_close(wx->netdev);
 	wx_clear_interrupt_scheme(wx);
 	pci_disable_device(pdev);
+	rtnl_unlock();
 
 	return 0;
 }
@@ -34,12 +38,25 @@ int wxvf_resume(struct device *dev_d)
 {
 	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct wx *wx = pci_get_drvdata(pdev);
+	int err = 0;
+
+	err = pci_enable_device_mem(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "Cannot enable PCI device from suspend\n");
+		return err;
+	}
 
 	pci_set_master(pdev);
-	wx_init_interrupt_scheme(wx);
+	rtnl_lock();
+	err = wx_init_interrupt_scheme(wx);
+	if (!err && netif_running(wx->netdev))
+		err = wxvf_open(wx->netdev);
+	rtnl_unlock();
+	if (err)
+		return err;
 	netif_device_attach(wx->netdev);
 
-	return 0;
+	return err;
 }
 EXPORT_SYMBOL(wxvf_resume);
 
-- 
2.30.1

