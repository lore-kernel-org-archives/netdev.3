Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9864049C4B7
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 22:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790893506; cv=none; b=aUXUk0KZWbJZpbvZh5XrqbTHDhZyfXguI2hrcRu4c7wxlYDX/eZ/eFlDUQz5BvtJmCALAeGQHy//wNo5jrE0mB2y4FmeEL3M3ADqYJjMIwOegDVAwJe3B1ZuvcwHXZGHqKaVj9wZJeHljHwTYPa0M2KK8GhzM6+AFv3IaCv3V4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790893506; c=relaxed/simple;
	bh=uzL7hJPkbhGa/e3E/qZBFsPV3iW4ZGmQnvy5N3488qQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ab7BmxLlHZdnR+kAYoRjrZSJsEprC54R0VNwJJs/beZm6lHcQx+qGYtNIfVwePJR0HrCh0P4pE8eRT1lf6laErbSEXkKlJqmNDuwq7BD6HxuYB1UrKK/EZFrx43jutBrdxDSqbPvxv6MLQQlhUFYmsENQmeM3PMlMY5kO8+e0tU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Vfbv9B0G; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Vfbv9B0G"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790893503; x=1822429503;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=uzL7hJPkbhGa/e3E/qZBFsPV3iW4ZGmQnvy5N3488qQ=;
  b=Vfbv9B0G0BEbMGXx/83jA0Wjbzmm+I0dkNcfGzMx0f/NgxBF1KPzmRdI
   fNJX0UW9Pbi63AW8JAvgi9mjyLRuGB8G+SMH61cr1r0YyUTgGd1RV9SUX
   0RKhAD2+g/K2lsE+4FYjmboNFXzrVAjQ+CNvQorZz8T7r85cn7LJ/cV2j
   09yLbanwX8wKYSUdA9OgVmv1l15AeHIoOQ07m9XJGcLw3uGvteYIHlc0n
   DkzjCtD+thBjtm9UWWgDWMRP2gt448XoQKKs7wpTLlfkmARm6fILpmsl+
   TpIfbVx7SGbyt+F254skjPVQnzP8GFZplIkuP3OvVlNrolWfetdIrqgkz
   Q==;
X-CSE-ConnectionGUID: kGqLZJxjSaG6hA1d1Rqd/g==
X-CSE-MsgGUID: nNEAX6QNSVq3RcaVD2jZSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90567718"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="90567718"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 15:24:58 -0700
X-CSE-ConnectionGUID: qGwW0CtPTJekOR6q2ZWaXQ==
X-CSE-MsgGUID: 4O5llblLQHy1Tloy4MwGJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="279863773"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 01 Oct 2026 15:24:59 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	anthony.l.nguyen@intel.com,
	florian.bezdeka@siemens.com,
	meng.ding@siemens.com,
	p@1g4.org,
	tkusters@aweta.nl,
	pulehui@huawei.com,
	dima.ruinskiy@intel.com,
	Simon Horman <horms@kernel.org>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH net 4/6] e1000e: fix IRQ leak when request_irq() fails in e1000_request_msix()
Date: Thu,  1 Oct 2026 15:24:37 -0700
Message-ID: <20261001222443.3500206-5-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261001222443.3500206-1-anthony.l.nguyen@intel.com>
References: <20261001222443.3500206-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jiayuan Chen <jiayuan.chen@linux.dev>

An internal syzbot instance reported the warning below.

comedi (comedi_parport) lets userspace request_irq() an arbitrary IRQ
number and can thus grab one of e1000e's MSI-X vectors. When
e1000_request_msix() then fails partway through, it returned without
freeing the vectors it had already requested; pci_disable_msix() later
tears those descriptors down while their irqaction is still attached,
leaking the /proc/irq entry.

Free the already requested IRQs on the error path.

genirq: Flags mismatch irq 28. 00200000 (eth1-tx-0) vs. 00200000 (comedi_parport)

remove_proc_entry: removing non-empty directory 'irq/27', leaking at least 'eth1-rx-0'
WARNING: fs/proc/generic.c:742 at remove_proc_entry+0x436/0x560, CPU#3: ip/445
Modules linked in:
CPU: 3 UID: 0 PID: 445 Comm: ip Not tainted 7.1.0+ #284 PREEMPT
RIP: 0010:remove_proc_entry (fs/proc/generic.c:742 (discriminator 4))
PKRU: 55555554
Call Trace:
<TASK>
unregister_irq_proc (kernel/irq/proc.c:406)
free_desc (kernel/irq/irqdesc.c:482)
irq_free_descs (kernel/irq/irqdesc.c:874 kernel/irq/irqdesc.c:865)
irq_domain_free_irqs (kernel/irq/irqdomain.c:1917)
msi_domain_free_locked.part.0 (kernel/irq/msi.c:1619 kernel/irq/msi.c:1645)
msi_domain_free_irqs_all_locked (kernel/irq/msi.c:1632)
pci_msi_teardown_msi_irqs (drivers/pci/msi/irqdomain.c:28)
pci_free_msi_irqs (drivers/pci/msi/msi.c:925)
pci_disable_msix (drivers/pci/msi/api.c:200 drivers/pci/msi/api.c:193)
e1000_request_irq (drivers/net/ethernet/intel/e1000e/netdev.c:2028)
e1000e_open (drivers/net/ethernet/intel/e1000e/netdev.c:4681)
__dev_open (net/core/dev.c:1702)
netif_change_flags (net/core/dev.c:9806)
do_setlink.isra.0 (net/core/rtnetlink.c:3207 (discriminator 1))
rtnetlink_rcv_msg (net/core/rtnetlink.c:7068)
netlink_rcv_skb (net/netlink/af_netlink.c:2556)

Fixes: 4662e82b2cb4 ("e1000e: add support for new 82574L part")
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Assisted-by: Claude:claude-opus-4-8
Reviewed-by: Dima Ruinskiy <dima.ruinskiy@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/netdev.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index 844f31ab37ad..746a39586999 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -2111,7 +2111,7 @@ void e1000e_set_interrupt_capability(struct e1000_adapter *adapter)
 static int e1000_request_msix(struct e1000_adapter *adapter)
 {
 	struct net_device *netdev = adapter->netdev;
-	int err = 0, vector = 0;
+	int err = 0, vector = 0, i;
 
 	if (strlen(netdev->name) < (IFNAMSIZ - 5))
 		snprintf(adapter->rx_ring->name,
@@ -2123,7 +2123,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
 			  e1000_intr_msix_rx, 0, adapter->rx_ring->name,
 			  netdev);
 	if (err)
-		return err;
+		goto err_free;
 	adapter->rx_ring->itr_register = adapter->hw.hw_addr +
 	    E1000_EITR_82574(vector);
 	adapter->rx_ring->itr_val = adapter->itr;
@@ -2139,7 +2139,7 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
 			  e1000_intr_msix_tx, 0, adapter->tx_ring->name,
 			  netdev);
 	if (err)
-		return err;
+		goto err_free;
 	adapter->tx_ring->itr_register = adapter->hw.hw_addr +
 	    E1000_EITR_82574(vector);
 	adapter->tx_ring->itr_val = adapter->itr;
@@ -2148,11 +2148,16 @@ static int e1000_request_msix(struct e1000_adapter *adapter)
 	err = request_irq(adapter->msix_entries[vector].vector,
 			  e1000_msix_other, 0, netdev->name, netdev);
 	if (err)
-		return err;
+		goto err_free;
 
 	e1000_configure_msix(adapter);
 
 	return 0;
+
+err_free:
+	for (i = vector - 1; i >= 0; i--)
+		free_irq(adapter->msix_entries[i].vector, netdev);
+	return err;
 }
 
 /**
-- 
2.47.1

