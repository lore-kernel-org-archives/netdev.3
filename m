Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA474156DA
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 09:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787738027; cv=none; b=FV9kj+R8Bt7GnslgeevIUtTTkXIi+puS1lFlYlqUJTxvp/AK+3t3KPONsDU6NukEkAUfIZxw9NvjfuXXx6LjMbpy5dtCf7LQco3mCzJvtKNiVZ+qA8HbR/qL/5FoyapwRyck/glxb2/2RJMYMtLWiHdEyms1HVLBQ2F9qGWGc0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787738027; c=relaxed/simple;
	bh=N9Dy0V/raQYFb0VUoogg5mLm5yzJJyKI3xz6iUr0UfM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=d2dzhHO5hULfnkBuObxKsAqI0f7i79w5TVQoRvowdv2q2cuuY5e6/8+C0gOTMOqMBegzAjI6WzXhv0mg4WAEDkfKy3Dz0tMvG7NhN8GQZFRcnKzcM2/qX/0M0cd/s0/WCaG74e+IUHSai3GVbICg4qBwDh9wNqM0CWlZEkXfrsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpgz8t1787737969tfa91bf1b
X-QQ-Originating-IP: Zwqgiwh2VkfQq4ApU7OVbZGq83fWM5kw1HmFAvgWhCs=
Received: from localhost.localdomain ( [122.233.170.62])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Aug 2026 17:52:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3171394264072839390
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
Subject: [PATCH net] net: libwx: Fix PM suspend/resume flow for VF drivers
Date: Wed, 26 Aug 2026 17:52:43 +0800
Message-Id: <20260826095243.16939-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: NJV4ECYAIEtcAbnHUJu9TllPoqeNhHEH5nAUndzLhs8cCbRcb42dGo5x
	UsYc8PqJidFfHnbFZBcQEO5owXTrdAUN4PhMCFR4vvCjRGmDRTvxg/as5evBXXH+hKxgUjc
	ptRtiy528YG7jrwD+4M2fDC10Uu+cx83wHqWl+RX8nvMSeZZDL3ha3+AeSRcxuQgVrlWNZV
	kk6S0vwT7kNQMCkYU8S+C8b/n4bTaAMXahozb68ZEx9hNddyJw2k6ZoW6eF68fT792y73kF
	V3mChYIpo4aTIAijioQGZtSWPqrj6sT/kvqCT4gY2yBPqUkIIRDSD42KwBTLcsI0sueK0IN
	6e87k9Dy8lDnRFzE1u61/B4Y0NzHqFmV2KP/t+Svnp0LrjBte5Ci63k9Zs0mAemK4aQsDmI
	pvgYyVOY9hkbkrxZMc3a98JdT+C+Pd6wOmvQttUj0FkydPaZqSuEY/Y3T2Z+iZOR8iKcMf6
	0j4B/OvTSQh+egkMmmwTNeeApHquixBuH3Nxv8AMpYHBgZocwUsCUNCZ2aGpeV/RwnnYWGU
	TjEeEFataFQghJdAaQxcfusKoHCaenmL1Z9pgJnc/eexp6xLVpebu13mrY/BhFxaHPompzm
	5AJrD8GK0OqMQHZgsGOFPqOa62YaV3RLdFBWAVWfTz5fxSFZbjZnH9yabKbVOXYGfIgwr6r
	ibaV89R9jp+ZtIu2PYCdzDVgWhYOvsFHKmEn8FNQW96rBLSjbwfh6Z0UFlKm+wH8WAXRg35
	dPXVHm/PXv8iBHG4PvG6xZAgpspiUVW5ZrXrOLAvx2tQkr+wBzVv5H6YKQ+3JbZr3c8K34L
	jOwLiWAIFxRygN4R9gzCkNm7CXBGIwdXEcz2TJkb7l+42RND5RbD46EJ6sO10fHi5CZJZlU
	zMKAbA0fhQJDJPP51zbVBHRVhRQVmZcp588T0YM9AU7OSlEnBqmkD27Wn+q4XyIsjZBx60U
	PWPTB1SOdjgZV9DHdFJOhjue+6/dha6Kzmbs5PqH3opzitus3WbixmHDCRdwRH4ndKBSL4i
	5DUBPYHp/BBMBcioLHB2hsguIepZSPLpeZ8IaJFrt19SB3W8o+8kwc+6XaYROL7Mh7poLp3
	EGzwcMbljkZt3dJHEoZuR5SbdBp94P+0Q==
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
X-QQ-RECHKSPAM: 0

Currently, wxvf_suspend() and wxvf_resume() do not acquire the RTNL
lock during device state transitions, which can lead to race conditions
with network interface configuration operations. Furthermore, the VF PM
callbacks lack proper hardware re-initialization and error handling,
leading to potential unhandled errors during PM resume and missing
dependency tracking between VF and PF devices.

Fix these issues with the following changes:

1. Hold rtnl_lock() around suspend and resume paths to synchronize netdev
   state modifications with RTNL core operations.
2. In wxvf_suspend(), close the netdevice before disabling PCI device and
   clearing interrupt schemes to ensure clean resource teardown.
3. In wxvf_resume(), check PCI device enablement errors and perform proper
   error unwinding if interrupt scheme re-initialization or interface open
   fails.
4. Add device links between VF and its parent PF device in probe() for both
   ngbevf and txgbevf to enforce correct power management ordering.

Fixes: 377d180bd71c ("net: wangxun: add txgbevf build")
Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
 .../net/ethernet/wangxun/libwx/wx_vf_common.c | 30 ++++++++++++++++++-
 .../net/ethernet/wangxun/ngbevf/ngbevf_main.c |  5 ++++
 .../ethernet/wangxun/txgbevf/txgbevf_main.c   |  5 ++++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index 26de78e9a69e..2352cf12b289 100644
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
@@ -34,12 +38,36 @@ int wxvf_resume(struct device *dev_d)
 {
 	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct wx *wx = pci_get_drvdata(pdev);
+	int err;
+
+	err = pci_enable_device_mem(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "Cannot enable PCI device from suspend\n");
+		return err;
+	}
 
 	pci_set_master(pdev);
-	wx_init_interrupt_scheme(wx);
+	rtnl_lock();
+
+	err = wx_init_interrupt_scheme(wx);
+	if (err)
+		goto err_pci;
+
+	if (netif_running(wx->netdev)) {
+		err = wxvf_open(wx->netdev);
+		if (err)
+			goto err_clear_int;
+	}
 	netif_device_attach(wx->netdev);
+	rtnl_unlock();
 
 	return 0;
+err_clear_int:
+	wx_clear_interrupt_scheme(wx);
+err_pci:
+	rtnl_unlock();
+	pci_disable_device(pdev);
+	return err;
 }
 EXPORT_SYMBOL(wxvf_resume);
 
diff --git a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
index d79cf8d8484f..69bbfd95597c 100644
--- a/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
+++ b/drivers/net/ethernet/wangxun/ngbevf/ngbevf_main.c
@@ -171,6 +171,11 @@ static int ngbevf_probe(struct pci_dev *pdev,
 		goto err_pci_release_regions;
 	}
 
+	if (!device_link_add(&pdev->dev, &pdev->physfn->dev,
+			     DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER))
+		dev_warn(&pdev->dev, "Failed to create device link to PF %s\n",
+			 pci_name(pdev->physfn));
+
 	SET_NETDEV_DEV(netdev, &pdev->dev);
 
 	wx = netdev_priv(netdev);
diff --git a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
index 8b16b900820a..3868b70ad152 100644
--- a/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
+++ b/drivers/net/ethernet/wangxun/txgbevf/txgbevf_main.c
@@ -228,6 +228,11 @@ static int txgbevf_probe(struct pci_dev *pdev,
 		goto err_pci_release_regions;
 	}
 
+	if (!device_link_add(&pdev->dev, &pdev->physfn->dev,
+			     DL_FLAG_PM_RUNTIME | DL_FLAG_AUTOREMOVE_CONSUMER))
+		dev_warn(&pdev->dev, "Failed to create device link to PF %s\n",
+			 pci_name(pdev->physfn));
+
 	SET_NETDEV_DEV(netdev, &pdev->dev);
 
 	wx = netdev_priv(netdev);
-- 
2.30.1

