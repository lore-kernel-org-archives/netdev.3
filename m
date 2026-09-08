Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1374CC26B
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 09:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788861547; cv=none; b=IgothoK1Q3FDi94idSZ+rcRMkR0CHLNAfZAiWTbhyhJ03yTuk/fSxJga8i8s4kZKW0Idwp9jbsstZZ8ABICmWLkwQ9DkHfOvP95Wt5+ZAJrtcsB/vsBLw6Li6nau+IyHwKFKvkdKZVfy50yr107a/3hcEjZ9jsFicXgXeVceKuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788861547; c=relaxed/simple;
	bh=91FkxL0gPhBCBhEnEVacAfBJPAeZkrr36IvNsfoA3ns=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qPfm9NP2MVq6CCzp4lIUm5HT6u1Z81OI1eUxRkwKFVx6eviIc06A+7SVhfX79j01Hz78TD8GQMoZSHTwDQJkowAP5DKecp8bVla5mpo3US63iYMW5Rrrllprny9rRPZuuKrubdux9U3AXn1N4qQOgLlE1fcDW8xZDnP9zA6Zl2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: zesmtpsz8t1788861489t680b7fe1
X-QQ-Originating-IP: QOgetrXFwhKb8m2/wUOXQP5r3nDJD4GNyXlseqNxhoQ=
Received: from localhost.localdomain ( [36.24.66.61])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Sep 2026 17:58:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9323279030110979488
EX-QQ-RecipientCnt: 11
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
	hramamurthy@google.com,
	Mengyuan Lou <mengyuanlou@net-swift.com>
Subject: [PATCH net-next v4] net: libwx: rework VF PM suspend/resume flow
Date: Tue,  8 Sep 2026 17:58:01 +0800
Message-Id: <20260908095801.61346-1-mengyuanlou@net-swift.com>
X-Mailer: git-send-email 2.30.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:net-swift.com:qybglogicsvrgz:qybglogicsvrgz5b-1
X-QQ-XMAILINFO: Nu6yyyTWZ0S9I1f7GuyPO9pOpzJNxrRd1+DeGFCnjHcw5hQz9kzoIOxO
	WYor3nBR/TrLdOgl56KfZqzPiJu9QUyBX16XCBSOMqaEO0aq25k7BU+cLnC8OATUfbSi3Y4
	ViKF/s8jzex31WAWJzUxZfTAW7/pRau8UpHtcVwhaAh+lmr/b9EcOSwx0B7IVqCYg8okJ3D
	KSwYpfK/O2FluJNZXSsA5PgUdi8g02vRCn3TgXe+K6X7bdHv1WuZZsTgwZKWwNyytLzy1W5
	27mWrKOzuZJxaBp2wzLOt0wNNLoWyxDQpT0ur+rlrHlGxXlsSvlAKJ3NYbHB3rFntr203BG
	j1ySc1ki+4EW2WrPyGZcVdMHccgyIpEbsq59kQa71jDFYhT1myC7R+T3f3HquWxgRvEBQsd
	yloO8t+5IMNpGCD/NMvio/bBx5e8UdgYnG+vRiv9sXojfzsFuWDBYpruFcqhh9+fwErhGM1
	ShRtvEXux9yDTmu5Y2EULKeKJ+Nl6x2PId4Sv+Cw8ZnrJ1OKZ5jFgVWpSe0e0ZY+mtz02P9
	Q1WbHon27cvbN261TsMU/0BlC5KLoOkfMHKSn/XboeoD98++3/lJc+EH2Mg+KmBkmlDvT5G
	qHgmuwZl/Ac/1JVGLgZMb4vYpCBskoPfld/FDRq633nJeSGBzzvqu9Nqsr8zsImvLRShzeq
	jrDhdbBW3ASEJoY9CQ9YwqsBLRm4hAuPFbKeWm8IjEspVyojw36nA9WtcRLxAQAR8SxWP/k
	iYHmsFBrcIUItScw6MZjfKi+SlVliNeqvY75V8CLdEoKzG5PNSlJtga4QYV9t3ft3/Usq40
	DthDzvSZVFHSb5vgJXy8g0JZM3GyWfRMugyQdJzVbJoSaareUFNkiqV3zKjNsWfGQiAdyiB
	aodM2ip/wEUoUXAywc6AtLMEgDev4/zvmb0DBmNUmxb9IfnQ5aZvXVMMFV+A3o4BjYjScaG
	CqObY+8hcNb3A+tnbwqfR1uJ0ccXcBt+/dkEhCkTCt00F5HxJvu4hvJqKVMVXvqj4nI0ONC
	HyG2o7Q3BGjU7azJCvrXqWKkC9CETF/Q84ee14jd88uFjfjTo5DBOvKa43mgICZO+OP934w
	e90rRThV6SErdx3RYuEX8s=
X-QQ-XMRINFO: MSVp+SPm3vtSI1QTLgDHQqIV1w2oNKDqfg==
X-QQ-RECHKSPAM: 0

Rework wxvf_suspend() and wxvf_resume() to normalize VF netdevice
lifecycle handling during power management transitions and improve
robustness against potential resource race conditions.

Previously, VF driver power management did not fully synchronize
netdevice states under rtnl_lock and lacked clean unwinding during
state transitions.
Refactor the suspend and resume sequence as follows:
- In wxvf_suspend(), ensure netdevice close operations execute under
  rtnl_lock when the device is running, and record the running state via
  WX_STATE_WAS_RUNNING. Flush pending service timers and tasks to
  guarantee no subtasks run after PCI teardown.
- In wxvf_resume(), defer queue and interrupt re-initialization to a
  dedicated reset subtask (wxvf_reopen_subtask) using WX_FLAG_NEED_REOPEN.
- Unconditionally restore the interrupt scheme in wxvf_reopen_subtask() so
  that non-running interfaces retain valid MSI-X configuration upon
  subsequent open requests.
- Guard against concurrent administrative DOWN requests during the
  deferral window by checking netif_running() prior to invoking
  wxvf_open().
- Properly synchronize core netdev states (__LINK_STATE_START / IFF_UP)
  and fire notifications if reopening fails.

Signed-off-by: Mengyuan Lou <mengyuanlou@net-swift.com>
---
Changelogs:
v4:
- Refactor patch description and subject to focus on PM flow rework for
  net-next instead of bug fixes, removing the Fixes tag.
- Unconditionally restore the interrupt scheme in wxvf_reopen_subtask()
  to fix NULL msix_entry dereference on previously admin-DOWN interfaces.
- Add WX_FLAG_NEED_REOPEN guard in wxvf_link_config_subtask() to block
  mailbox and register operations before reopening completes.
- Validate netif_running() under rtnl_lock() in wxvf_reopen_subtask()
  before invoking wxvf_open() to respect administrative DOWN events
  during deferral.
- Synchronize core netdev flags (__LINK_STATE_START and IFF_UP) and
  trigger DOWN notifications on wxvf_reopen_subtask() failure paths.
- Flushed service timer and work synchronously during suspend to avoid
  tasks running after PCI device teardown.
v3: https://lore.kernel.org/netdev/20260904085216.43469-1-mengyuanlou@net-swift.com/
- Fix DMA-after-free and UAF races in wxvf_suspend() by invoking
  wxvf_close() when running, ensuring DMA engines are stopped and
  NAPI/IRQs/rings are cleanly freed before clearing PCI state.
- Replace manual resource allocation in wxvf_resume() with deferred
  reopening via WX_FLAG_NEED_REOPEN, scheduling wxvf_reopen_subtask() to
  run full wxvf_open() sequence under rtnl_lock().
- Move timer/work synchronization after rtnl_lock() release in
  wxvf_suspend() to prevent service tasks from re-arming the timer.
- Add error unwinding in wxvf_reopen_subtask() to set WX_STATE_DOWN,
  clear bus mastering, and log errors if reopen fails.
- Skip wxvf_link_config_subtask() when WX_STATE_DOWN is set to prevent
  link updates on downed interfaces.
v2: https://lore.kernel.org/netdev/20260829091423.83097-1-mengyuanlou@net-swift.com/
- Refactored the suspend and resume logic to eliminate full netdevice
  close/open cycles in favor of lightweight interrupt and queue manipulation:
  * In wxvf_suspend(), replaced wxvf_close() with explicit queue stopping
    (netif_tx_disable), carrier drop, NAPI disabling (wx_napi_disable_all), IRQ
    releasing (wx_free_irq), and resource freeing (wx_free_resources).
  * In wxvf_resume(), replaced wxvf_open() with granular resource allocation
    (wx_setup_resources), MSI-X IRQ requesting (wx_request_msix_irqs_vf),
    and deferred hardware reconfiguration via WX_FLAG_NEED_DO_RESET flag.
- Dropped the addition of device_link_add() to parent PF in ngbevf and txgbevf
  probe() paths to keep the patch focused strictly on libwx PM suspend/resume flow.
v1: https://lore.kernel.org/netdev/20260826095243.16939-1-mengyuanlou@net-swift.com/
---
 drivers/net/ethernet/wangxun/libwx/wx_lib.c   |  3 +-
 drivers/net/ethernet/wangxun/libwx/wx_type.h  |  2 +
 .../net/ethernet/wangxun/libwx/wx_vf_common.c | 87 ++++++++++++++++++-
 3 files changed, 88 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/wangxun/libwx/wx_lib.c b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
index ed5aad7857bd..de09a6704477 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_lib.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_lib.c
@@ -3381,7 +3381,8 @@ EXPORT_SYMBOL(wx_set_ring);
 
 void wx_service_event_schedule(struct wx *wx)
 {
-	if (!test_bit(WX_STATE_DOWN, wx->state) &&
+	if ((!test_bit(WX_STATE_DOWN, wx->state) ||
+	     test_bit(WX_FLAG_NEED_REOPEN, wx->flags)) &&
 	    !test_and_set_bit(WX_STATE_SERVICE_SCHED, wx->state))
 		queue_work(system_power_efficient_wq, &wx->service_task);
 }
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_type.h b/drivers/net/ethernet/wangxun/libwx/wx_type.h
index a05a8c1f4049..2f4119a83c87 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_type.h
+++ b/drivers/net/ethernet/wangxun/libwx/wx_type.h
@@ -1224,6 +1224,7 @@ enum wx_state {
 	WX_STATE_SERVICE_SCHED,
 	WX_STATE_DISABLED,
 	WX_STATE_RES_FREED,
+	WX_STATE_WAS_RUNNING,
 	WX_STATE_NBITS		/* must be last */
 };
 
@@ -1288,6 +1289,7 @@ enum wx_flags {
 	WX_FLAG_NEED_MODULE_RESET,
 	WX_FLAG_NEED_UPDATE_LINK,
 	WX_FLAG_NEED_DO_RESET,
+	WX_FLAG_NEED_REOPEN,
 	WX_FLAG_RX_MERGE_ENABLED,
 	WX_FLAG_TXHEAD_WB_ENABLED,
 	WX_FLAG_NEED_PCIE_RECOVERY,
diff --git a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
index 26de78e9a69e..7d52da8e6af1 100644
--- a/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
+++ b/drivers/net/ethernet/wangxun/libwx/wx_vf_common.c
@@ -16,8 +16,18 @@ int wxvf_suspend(struct device *dev_d)
 	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct wx *wx = pci_get_drvdata(pdev);
 
+	rtnl_lock();
 	netif_device_detach(wx->netdev);
+	if (netif_running(wx->netdev)) {
+		set_bit(WX_STATE_WAS_RUNNING, wx->state);
+		wxvf_close(wx->netdev);
+	}
 	wx_clear_interrupt_scheme(wx);
+	rtnl_unlock();
+
+	timer_delete_sync(&wx->service_timer);
+	cancel_work_sync(&wx->service_task);
+	pci_clear_master(pdev);
 	pci_disable_device(pdev);
 
 	return 0;
@@ -34,11 +44,19 @@ int wxvf_resume(struct device *dev_d)
 {
 	struct pci_dev *pdev = to_pci_dev(dev_d);
 	struct wx *wx = pci_get_drvdata(pdev);
+	int err;
 
-	pci_set_master(pdev);
-	wx_init_interrupt_scheme(wx);
-	netif_device_attach(wx->netdev);
+	err = pci_enable_device_mem(pdev);
+	if (err) {
+		dev_err(&pdev->dev, "Cannot enable PCI device from suspend\n");
+		return err;
+	}
 
+	pci_set_master(pdev);
+	rtnl_lock();
+	mod_timer(&wx->service_timer, jiffies + HZ);
+	set_bit(WX_FLAG_NEED_REOPEN, wx->flags);
+	rtnl_unlock();
 	return 0;
 }
 EXPORT_SYMBOL(wxvf_resume);
@@ -388,6 +406,10 @@ static void wxvf_link_config_subtask(struct wx *wx)
 {
 	struct net_device *netdev = wx->netdev;
 
+	if (test_bit(WX_STATE_DOWN, wx->state) ||
+	    test_bit(WX_FLAG_NEED_REOPEN, wx->flags))
+		return;
+
 	wxvf_watchdog_update_link(wx);
 	if (wx->link) {
 		if (netif_carrier_ok(netdev))
@@ -403,10 +425,69 @@ static void wxvf_link_config_subtask(struct wx *wx)
 	}
 }
 
+static void wxvf_reopen_subtask(struct wx *wx)
+{
+	u32 msgbuf = 0;
+
+	if (!test_bit(WX_FLAG_NEED_REOPEN, wx->flags))
+		return;
+
+	rtnl_lock();
+	/* try get mbx lock to make sure we can communicate with the PF */
+	if (wx_read_mbx_vf(wx, &msgbuf, 1)) {
+		rtnl_unlock();
+		return;
+	}
+
+	if (wx_init_interrupt_scheme(wx)) {
+		dev_err(&wx->pdev->dev, "Failed to initialize interrupt scheme\n");
+		goto hard_failure;
+	}
+
+	if (test_bit(WX_STATE_WAS_RUNNING, wx->state)) {
+		if (!netif_running(wx->netdev))
+			goto finish_success;
+
+		if (wxvf_open(wx->netdev))
+			goto open_failed;
+	}
+
+finish_success:
+	clear_bit(WX_FLAG_NEED_REOPEN, wx->flags);
+	clear_bit(WX_STATE_WAS_RUNNING, wx->state);
+	netif_device_attach(wx->netdev);
+	rtnl_unlock();
+	return;
+open_failed:
+	wx_clear_interrupt_scheme(wx);
+hard_failure:
+	clear_bit(WX_FLAG_NEED_REOPEN, wx->flags);
+	clear_bit(WX_STATE_WAS_RUNNING, wx->state);
+	set_bit(WX_STATE_DOWN, wx->state);
+
+	if (netif_running(wx->netdev)) {
+		struct net_device *netdev = wx->netdev;
+
+		/* Can't use dev_close() here because wxvf_close() was
+		 * already called during suspend. Manually clear state
+		 * and send notifications instead.
+		 */
+		call_netdevice_notifiers(NETDEV_GOING_DOWN, netdev);
+		call_netdevice_notifiers(NETDEV_DOWN, netdev);
+		netdev->flags &= ~IFF_UP;
+		clear_bit(__LINK_STATE_START, &netdev->state);
+	}
+
+	rtnl_unlock();
+	pci_disable_device(wx->pdev);
+	dev_err(&wx->pdev->dev, "Failed to fully resume device\n");
+}
+
 static void wxvf_service_task(struct work_struct *work)
 {
 	struct wx *wx = container_of(work, struct wx, service_task);
 
+	wxvf_reopen_subtask(wx);
 	wxvf_link_config_subtask(wx);
 	wxvf_reset_subtask(wx);
 	wx_service_event_complete(wx);
-- 
2.30.1

