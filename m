Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=12.32.117.8
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793850270;
	b=xoHcCcQFmNjae+lZcQk2gGE9sTRIN0ujCFzuEBUuTRyjYe7lIoSlU3FfnFVHNwYi0UQh
	 OcIBzLJRbIvV0fYHyXdbyfstMcS9xJ9V9x4vn4T3SqkoCcNf3m8V5r27BHwNmE9mzj2EN
	 l8r4VRnXdZgWPyogu7fePY80X8sfE+yj0rzHHTHOsJYCmFhKW55/lapuNcNZ3hG1DbXn/
	 dVGaPoqW5buSGWXK4X4GzJk7rsMpthZBXrVse0KqqmIZZsDYxwl4FND5m864tqPFjcGq6
	 gZ/Fpb6537Hihk+dyZL1zmkr070iYDHj0FTmaAY/M+uGKZOIAWpjQd/5kDueOQt+ung==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793850270;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Yv4CFRfYhTDZJQC0Nu/Mj4ytdwvBE7+Es+AyVxo95dg=;
	b=PLJGkXMWRlQA3b3bSoIFyXzUywfVSGcYKbI5eaI6mY+lrH5S75Xz2Ga8iIGlGO9ATBw+
	 cEx2uIy9xlQFYIFSQbWPeIgUeSyyO4y0a3hvFsNrdKvJqYrsnj/pPM2Dbd0Cm43XIsCIV
	 q3ALBDCh/P9BOY/SihYHkQfz8ga3TXOanuKMGd9dzzpg2Fau5uGZqPQSNmjzoaoGg1jlu
	 3AwqVnpe3HVQK7fML6qS1jfgnQnNPo8n132kAcEZTZpRsIanawgwogUTBkJ8HUo6VIEi+
	 ReRv+84anCl6AWuYOz8man4Xr/oyhK7EN4JObXm0+LOuWQIRbJ8UwQj28crhMnVr62A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=chelsio.com;
	spf=pass smtp.mailfrom=chelsio.com;
	arc=none smtp.remote-ip=12.32.117.8
Received: from stargate.chelsio.com (unknown [12.32.117.8])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D9E8606A337
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 03:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2D9E8606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=chelsio.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chelsio.com
Received: from mehrangarh-blr-asicdesigners-com.asicdesigners.com (mehrangarh.blr.asicdesigners.com [10.193.185.169])
	by stargate.chelsio.com (8.14.7/8.14.7) with ESMTP id 6A53hj3o002480;
	Wed, 4 Nov 2026 19:44:12 -0800
From: Potnuri Bharat Teja <bharat@chelsio.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
        pabeni@redhat.com, andrew+netdev@lunn.ch, bharat@chelsio.com,
        harshitha.vr@chelsio.com
Subject: [PATCH net-next v5 REPOST 02/12] cxgb4: rework the interrupt handling framework
Date: Thu,  5 Nov 2026 08:15:39 -0500
Message-Id: <20261105131549.547554-3-bharat@chelsio.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20261105131549.547554-1-bharat@chelsio.com>
References: <20261105131549.547554-1-bharat@chelsio.com>
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

The slow interrupt path used a per module handler that walked a table
of (mask, message) pairs with t4_handle_intr_status() and printed a
message for every bit it found set.  Each module handler open coded
the read, report and clear sequence, and there was no way to express
that a cause bit should be handled by inspecting a sub-register, or
that a bit is only fatal when it is also enabled.

Replace it with a data driven framework:

  struct intr_info describes one cause register: its name, the cause
  and enable register offsets, the mask of fatal bits, a table of
  struct intr_details for decoding individual bits, and an optional
  table of struct intr_action entries naming a function to call for a
  given cause bit.

  t4_handle_intr() implements the common read, report, dispatch and
  clear sequence once, so a module handler reduces to describing its
  registers and any nested cause registers it owns.

The module interrupt handlers now return bool rather than void so a
fatal condition propagates back to t4_slow_intr_handler() instead of
being signalled out of band, and t4_slow_intr_handler() takes a
verbose flag controlling whether individual cause bits are decoded
and logged.

This changes the interrupt path for all supported adapters.  No
functional change is intended for T4, T5 or T6 beyond the wording of
the messages emitted.

Signed-off-by: Potnuri Bharat Teja <bharat@chelsio.com>
---
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |    2 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   |    2 +-
 drivers/net/ethernet/chelsio/cxgb4/sge.c      |    4 +-
 drivers/net/ethernet/chelsio/cxgb4/t4_hw.c    | 4435 ++++++++++++++---
 4 files changed, 3790 insertions(+), 653 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
index f20f4bc58492..acdeab77352f 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4.h
@@ -1788,7 +1788,7 @@ struct fw_filter_wr;
 
 void t4_intr_enable(struct adapter *adapter);
 void t4_intr_disable(struct adapter *adapter);
-int t4_slow_intr_handler(struct adapter *adapter);
+int t4_slow_intr_handler(struct adapter *adap, bool verbose);
 
 int t4_wait_dev_ready(void __iomem *regs);
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
index 1ced6df6eac8..5189016c3ef6 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
@@ -682,7 +682,7 @@ static irqreturn_t t4_nondata_intr(int irq, void *cookie)
 		t4_write_reg(adap, MYPF_REG(PL_PF_INT_CAUSE_A), v);
 	}
 	if (adap->flags & CXGB4_MASTER_PF)
-		t4_slow_intr_handler(adap);
+		t4_slow_intr_handler(adap, true);
 	return IRQ_HANDLED;
 }
 
diff --git a/drivers/net/ethernet/chelsio/cxgb4/sge.c b/drivers/net/ethernet/chelsio/cxgb4/sge.c
index 9fccb8ea9bcd..4fe6c10d50e0 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/sge.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/sge.c
@@ -4193,7 +4193,7 @@ static irqreturn_t t4_intr_msi(int irq, void *cookie)
 	struct adapter *adap = cookie;
 
 	if (adap->flags & CXGB4_MASTER_PF)
-		t4_slow_intr_handler(adap);
+		t4_slow_intr_handler(adap, true);
 	process_intrq(adap);
 	return IRQ_HANDLED;
 }
@@ -4208,7 +4208,7 @@ static irqreturn_t t4_intr_intx(int irq, void *cookie)
 	struct adapter *adap = cookie;
 
 	t4_write_reg(adap, MYPF_REG(PCIE_PF_CLI_A), 0);
-	if (((adap->flags & CXGB4_MASTER_PF) && t4_slow_intr_handler(adap)) |
+	if (((adap->flags & CXGB4_MASTER_PF) && t4_slow_intr_handler(adap, true)) |
 	    process_intrq(adap))
 		return IRQ_HANDLED;
 	return IRQ_NONE;             /* probably shared interrupt */
diff --git a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
index 29d7b786e51e..f2fd835f3110 100644
--- a/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
+++ b/drivers/net/ethernet/chelsio/cxgb4/t4_hw.c
@@ -4261,804 +4261,3935 @@ int t4_restart_aneg(struct adapter *adap, unsigned int mbox, unsigned int port)
 	return t4_wr_mbox(adap, mbox, &c, sizeof(c), NULL);
 }
 
-typedef void (*int_handler_t)(struct adapter *adap);
+struct intr_details {
+	u32 mask;
+	const char *msg;
+};
+
+struct intr_action {
+	u32 mask;
+	int arg;
+	bool (*action)(struct adapter *adap, int arg, bool verbose);
+};
 
+#define NONFATAL_IF_DISABLED 1
 struct intr_info {
-	unsigned int mask;       /* bits to check in interrupt status */
-	const char *msg;         /* message to print or NULL */
-	short stat_idx;          /* stat counter to increment or -1 */
-	unsigned short fatal;    /* whether the condition reported is fatal */
-	int_handler_t int_handler; /* platform-specific int handler */
+	const char *name;       /* name of the INT_CAUSE register */
+	int cause_reg;          /* INT_CAUSE register */
+	int enable_reg;         /* INT_ENABLE register */
+	u32 fatal;              /* bits that are fatal */
+	int flags;		/* hints */
+	int skip_clear;		/* 1 if it should not be cleared */
+	const struct intr_details *details;
+	const struct intr_action *actions;
 };
 
-/**
- *	t4_handle_intr_status - table driven interrupt handler
- *	@adapter: the adapter that generated the interrupt
- *	@reg: the interrupt status register to process
- *	@acts: table of interrupt actions
- *
- *	A table driven interrupt handler that applies a set of masks to an
- *	interrupt status word and performs the corresponding actions if the
- *	interrupts described by the mask have occurred.  The actions include
- *	optionally emitting a warning or alert message.  The table is terminated
- *	by an entry specifying mask 0.  Returns the number of fatal interrupt
- *	conditions.
- */
-static int t4_handle_intr_status(struct adapter *adapter, unsigned int reg,
-				 const struct intr_info *acts)
+static void clear_int_cause_reg(struct adapter *adap, const struct intr_info *ii)
 {
-	int fatal = 0;
-	unsigned int mask = 0;
-	unsigned int status = t4_read_reg(adapter, reg);
+	u32 cause;
 
-	for ( ; acts->mask; ++acts) {
-		if (!(status & acts->mask))
+	cause = t4_read_reg(adap, ii->cause_reg);
+	if (cause == 0)
+		return;
+
+	t4_write_reg(adap, ii->cause_reg, cause);
+	(void)t4_read_reg(adap, ii->cause_reg);
+}
+
+static char intr_alert_char(u32 cause, u32 enable, u32 fatal)
+{
+	if (cause & fatal)
+		return '!';
+	if (cause & enable)
+		return '*';
+	return '-';
+}
+
+static void t4_show_intr_info(struct adapter *adap, const struct intr_info *ii,
+			      u32 cause, u32 enable)
+{
+	u32 fatal, leftover;
+	const struct intr_details *details;
+	char alert;
+
+	if (ii->flags & NONFATAL_IF_DISABLED)
+		fatal = ii->fatal & enable;
+	else
+		fatal = ii->fatal;
+	alert = intr_alert_char(cause, enable, fatal);
+	dev_alert(adap->pdev_dev, "%c %s 0x%x = 0x%08x, E 0x%08x, F 0x%08x\n",
+		  alert, ii->name, ii->cause_reg, cause, enable, fatal);
+
+	leftover = cause;
+	for (details = ii->details; details && details->mask != 0; details++) {
+		u32 msgbits = details->mask & cause;
+
+		if (msgbits == 0)
 			continue;
-		if (acts->fatal) {
-			fatal++;
-			dev_alert(adapter->pdev_dev, "%s (0x%x)\n", acts->msg,
-				  status & acts->mask);
-		} else if (acts->msg && printk_ratelimit())
-			dev_warn(adapter->pdev_dev, "%s (0x%x)\n", acts->msg,
-				 status & acts->mask);
-		if (acts->int_handler)
-			acts->int_handler(adapter);
-		mask |= acts->mask;
-	}
-	status &= mask;
-	if (status)                           /* clear processed interrupts */
-		t4_write_reg(adapter, reg, status);
-	return fatal;
+		alert = intr_alert_char(msgbits, enable, ii->fatal);
+		dev_alert(adap->pdev_dev, "  %c [0x%08x] %s\n", alert, msgbits,
+			  details->msg);
+		leftover &= ~msgbits;
+	}
+	if (leftover != 0 && leftover != cause)
+		dev_alert(adap->pdev_dev, "  ? [0x%08x]\n", leftover);
 }
 
+/*
+ * Returns true for fatal error.
+ */
+static bool t4_handle_intr(struct adapter *adap, const struct intr_info *ii,
+			   u32 additional_cause, bool verbose)
+{
+	u32 cause, enable, active, fatal;
+	const struct intr_action *action;
+	bool rc;
+
+	cause = t4_read_reg(adap, ii->cause_reg);
+	enable = t4_read_reg(adap, ii->enable_reg);
+
+	if (verbose && cause != 0)
+		t4_show_intr_info(adap, ii, cause, enable);
+	fatal = cause & ii->fatal;
+	if (ii->flags & NONFATAL_IF_DISABLED)
+		fatal &= enable;
+	active = (cause & enable) | additional_cause;
+	if (active == 0)
+		return false;
+
+	rc = fatal != 0;
+	for (action = ii->actions; action && action->mask != 0; action++) {
+		if (!(action->mask & active))
+			continue;
+		rc |= action->action(adap, action->arg, verbose);
+	}
+
+	/* clear only if register doesn't have a sub-register to check on */
+	if (!ii->skip_clear) {
+		t4_write_reg(adap, ii->cause_reg, cause);
+		(void)t4_read_reg(adap, ii->cause_reg);
+	}
+	return rc;
+}
 /*
  * Interrupt handler for the PCIE module.
  */
-static void pcie_intr_handler(struct adapter *adapter)
+static bool pcie_intr_handler(struct adapter *adap, int arg, bool verbose)
+{
+	static const struct intr_details sysbus_intr_details[] = {
+		{ RNPP_F, "RXNP array parity error" },
+		{ RPCP_F, "RXPC array parity error" },
+		{ RCIP_F, "RXCIF array parity error" },
+		{ RCCP_F, "Rx completions control array parity error" },
+		{ RFTP_F, "RXFT array parity error" },
+		{ 0 }
+	};
+	static const struct intr_info sysbus_intr_info = {
+		.name = "PCIE_CORE_UTL_SYSTEM_BUS_AGENT_STATUS",
+		.cause_reg = PCIE_CORE_UTL_SYSTEM_BUS_AGENT_STATUS_A,
+		.enable_reg = PCIE_CORE_UTL_SYSTEM_BUS_AGENT_INTERRUPT_ENABLE_A,
+		.fatal = RFTP_F | RCCP_F | RCIP_F | RPCP_F | RNPP_F,
+		.flags = 0,
+		.details = sysbus_intr_details,
+		.actions = NULL,
+	};
+	static const struct intr_details pcie_port_intr_details[] = {
+		{ TPCP_F, "TXPC array parity error" },
+		{ TNPP_F, "TXNP array parity error" },
+		{ TFTP_F, "TXFT array parity error" },
+		{ TCAP_F, "TXCA array parity error" },
+		{ TCIP_F, "TXCIF array parity error" },
+		{ RCAP_F, "RXCA array parity error" },
+		{ OTDD_F, "outbound request TLP discarded" },
+		{ RDPE_F, "Rx data parity error" },
+		{ TDUE_F, "Tx uncorrectable data error" },
+		{ 0 }
+	};
+	static const struct intr_info pcie_port_intr_info = {
+		.name = "PCIE_CORE_UTL_PCI_EXPRESS_PORT_STATUS",
+		.cause_reg = PCIE_CORE_UTL_PCI_EXPRESS_PORT_STATUS_A,
+		.enable_reg = PCIE_CORE_UTL_PCI_EXPRESS_PORT_INTERRUPT_ENABLE_A,
+		.fatal = TPCP_F | TNPP_F | TFTP_F | TCAP_F | TCIP_F | RCAP_F |
+			 OTDD_F | RDPE_F | TDUE_F,
+		.flags = 0,
+		.details = pcie_port_intr_details,
+		.actions = NULL,
+	};
+	static const struct intr_details pcie_intr_details[] = {
+		{ MSIADDRLPERR_F, "MSI AddrL parity error" },
+		{ MSIADDRHPERR_F, "MSI AddrH parity error" },
+		{ MSIDATAPERR_F, "MSI data parity error" },
+		{ MSIXADDRLPERR_F, "MSI-X AddrL parity error" },
+		{ MSIXADDRHPERR_F, "MSI-X AddrH parity error" },
+		{ MSIXDATAPERR_F, "MSI-X data parity error" },
+		{ MSIXDIPERR_F, "MSI-X DI parity error" },
+		{ PIOCPLPERR_F, "PCIe PIO completion FIFO parity error" },
+		{ PIOREQPERR_F, "PCIe PIO request FIFO parity error" },
+		{ TARTAGPERR_F, "PCIe target tag FIFO parity error" },
+		{ CCNTPERR_F, "PCIe CMD channel count parity error" },
+		{ CREQPERR_F, "PCIe CMD channel request parity error" },
+		{ CRSPPERR_F, "PCIe CMD channel response parity error" },
+		{ DCNTPERR_F, "PCIe DMA channel count parity error" },
+		{ DREQPERR_F, "PCIe DMA channel request parity error" },
+		{ DRSPPERR_F, "PCIe DMA channel response parity error" },
+		{ HCNTPERR_F, "PCIe HMA channel count parity error" },
+		{ HREQPERR_F, "PCIe HMA channel request parity error" },
+		{ HRSPPERR_F, "PCIe HMA channel response parity error" },
+		{ CFGSNPPERR_F, "PCIe config snoop FIFO parity error" },
+		{ FIDPERR_F, "PCIe FID parity error" },
+		{ INTXCLRPERR_F, "PCIe INTx clear parity error" },
+		{ MATAGPERR_F, "PCIe MA tag parity error" },
+		{ PIOTAGPERR_F, "PCIe PIO tag parity error" },
+		{ RXCPLPERR_F, "PCIe Rx completion parity error" },
+		{ RXWRPERR_F, "PCIe Rx write parity error" },
+		{ RPLPERR_F, "PCIe replay buffer parity error" },
+		{ PCIESINT_F, "PCIe core secondary fault" },
+		{ PCIEPINT_F, "PCIe core primary fault" },
+		{ UNXSPLCPLERR_F, "PCIe unexpected split completion error" },
+		{ 0 }
+	};
+	static const struct intr_details t5_pcie_intr_details[] = {
+		{ IPGRPPERR_F, "Parity errors observed by IP" },
+		{ NONFATALERR_F, "PCIe non-fatal error" },
+		{ READRSPERR_F, "Outbound read error" },
+		{ TRGT1GRPPERR_F, "PCIe TRGT1 group FIFOs parity error" },
+		{ IPSOTPERR_F, "PCIe IP SOT buffer SRAM parity error" },
+		{ IPRETRYPERR_F, "PCIe IP replay buffer parity error" },
+		{ IPRXDATAGRPPERR_F, "PCIe IP Rx data group SRAMs parity error" },
+		{ IPRXHDRGRPPERR_F, "PCIe IP Rx header group SRAMs parity error" },
+		{ PIOTAGQPERR_F, "PIO tag queue FIFO parity error" },
+		{ MAGRPPERR_F, "MA group FIFO parity error" },
+		{ VFIDPERR_F, "VFID SRAM parity error" },
+		{ FIDPERR_F, "FID SRAM parity error" },
+		{ CFGSNPPERR_F, "config snoop FIFO parity error" },
+		{ HRSPPERR_F, "HMA channel response data SRAM parity error" },
+		{ HREQRDPERR_F, "HMA channel read request SRAM parity error" },
+		{ HREQWRPERR_F, "HMA channel write request SRAM parity error" },
+		{ DRSPPERR_F, "DMA channel response data SRAM parity error" },
+		{ DREQRDPERR_F, "DMA channel write request SRAM parity error" },
+		{ CRSPPERR_F, "CMD channel response data SRAM parity error" },
+		{ CREQRDPERR_F, "CMD channel read request SRAM parity error" },
+		{ MSTTAGQPERR_F, "PCIe master tag queue SRAM parity error" },
+		{ TGTTAGQPERR_F, "PCIe target tag queue FIFO parity error" },
+		{ PIOREQGRPPERR_F, "PIO request group FIFOs parity error" },
+		{ PIOCPLGRPPERR_F, "PIO completion group FIFOs parity error" },
+		{ MSIXDIPERR_F, "MSI-X DI SRAM parity error" },
+		{ MSIXDATAPERR_F, "MSI-X data SRAM parity error" },
+		{ MSIXADDRHPERR_F, "MSI-X AddrH SRAM parity error" },
+		{ MSIXADDRLPERR_F, "MSI-X AddrL SRAM parity error" },
+		{ MSIXSTIPERR_F, "MSI-X STI SRAM parity error" },
+		{ MSTTIMEOUTPERR_F, "Master timeout FIFO parity error" },
+		{ MSTGRPPERR_F, "Master response read queue SRAM parity error" },
+		{ 0 }
+	};
+	struct intr_info pcie_intr_info = {
+		.name = "PCIE_INT_CAUSE",
+		.cause_reg = PCIE_INT_CAUSE_A,
+		.enable_reg = PCIE_INT_ENABLE_A,
+		.fatal = 0x9fffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = NULL,
+		.actions = NULL,
+	};
+	static const struct intr_details pcie_intr_cause_ext_details[] = {
+		{ IPFORMQPERR_F, "PCIe IP FormQ Buffer PERR" },
+		{ IPFORMQCERR_F, "PCIe IP FormQ Buffer CERR" },
+		{ TRGT1GRPCERR_F, "TRGT1 Group FIFOs CERR" },
+		{ IPSOTCERR_F, "PCIe IP SOT Buffer SRAM CERR" },
+		{ IPRETRYCERR_F, "PCIe IP Replay Buffer CERR" },
+		{ IPRXDATAGRPCERR_F, "PCIe IP Rx Data Group SRAMs CERR" },
+		{ IPRXHDRGRPCERR_F, "PCIe IP Rx Header Group SRAMs CERR" },
+		{ A0ARBRSPORDFIFOPERR_F, "A0 Arbiter Response Order FIFO Parity Error" },
+		{ HRSPCERR_F, "Master HMA Channel Response Data SRAM CERR" },
+		{ HREQRDCERR_F, "Master HMA Channel Read Request SRAM CERR" },
+		{ HREQWRCERR_F, "Master HMA Channel Write Request SRAM CERR" },
+		{ DRSPCERR_F, "Master DMA Channel Response Data SRAM CERR" },
+		{ DREQRDCERR_F, "Master DMA Channel Read Request SRAM CERR" },
+		{ DREQWRCERR_F, "Master DMA Channel Write Request SRAM CERR" },
+		{ CRSPCERR_F, "Master CMD Channel Response Data SRAM CERR" },
+		{ ARSPPERR_F, "Master ARM Channel Response Data SRAM PERR" },
+		{ AREQRDPERR_F, "Master ARM Channel Read Request SRAM PERR" },
+		{ AREQWRPERR_F, "Master ARM Channel Write Request SRAM PERR" },
+		{ PIOREQGRPCERR_F, "PIO Request Group FIFOs CERR" },
+		{ ARSPCERR_F, "Master ARM Channel Response Data SRAM CERR" },
+		{ AREQRDCERR_F, "Master ARM Channel Read Request SRAM CERR" },
+		{ AREQWRCERR_F, "Master ARM Channel Write Request SRAM CERR" },
+		{ MARSPPERR_F, "INIC MA Ctrl and Data Rsp Perr" },
+		{ INICMAWDATAORDPERR_F, "INIC Ma Arb Write Ord Data Fifo Perr" },
+		{ EMUPERR_F, "CFG EMU SRAM PERR" },
+		{ ERRSPPERR_F, "CFG EMU SRAM CERR" },
+		{ MSTGRPCERR_F, "Master Data Path and Response Read Queue SRAM CERR" },
+		{ 0 }
+	};
+	struct intr_info pcie_int_cause_ext = {
+		.name = "PCIE_INT_CAUSE_EXT",
+		.cause_reg = PCIE_INT_CAUSE_EXT_A,
+		.enable_reg = PCIE_INT_ENABLE_EXT_A,
+		.fatal = IPFORMQPERR_F | A0ARBRSPORDFIFOPERR_F | ARSPPERR_F | AREQRDPERR_F |
+			 AREQWRPERR_F | MARSPPERR_F | INICMAWDATAORDPERR_F | EMUPERR_F,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = pcie_intr_cause_ext_details,
+		.actions = NULL,
+	};
+	static const struct intr_details pcie_intr_cause_x8_details[] = {
+		{ X8TGTGRPPERR_F, "x8 TGT Group FIFOs parity error" },
+		{ X8IPSOTPERR_F, "PCIe x8 IP SOT Buffer SRAM PERR" },
+		{ X8IPRETRYPERR_F, "PCIe x8 IP Replay Buffer PERR" },
+		{ X8IPRXDATAGRPPERR_F, "PCIe x8 IP Rx Data Group SRAMs PERR" },
+		{ X8IPRXHDRGRPPERR_F, "PCIe x8 IP Rx Header Group SRAMs PERR" },
+		{ X8IPCORECERR_F, "x8 IP SOT, Retry, RxData, RxHdr SRAM CERR" },
+		{ X8MSTGRPPERR_F, "x8 Master Data Path and Response Read Queue SRAM PERR" },
+		{ X8MSTGRPCERR_F, "x8 Master Data Path and Response Read Queue SRAM CERR" },
+		{ 0 }
+	};
+	struct intr_info pcie_int_cause_x8 = {
+		.name = "PCIE_INT_CAUSE_X8",
+		.cause_reg = PCIE_INT_CAUSE_X8_A,
+		.enable_reg = PCIE_INT_ENABLE_X8_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = pcie_intr_cause_x8_details,
+		.actions = NULL,
+	};
+	bool fatal = false;
+
+	if (is_t4(adap->params.chip)) {
+		fatal |= t4_handle_intr(adap, &sysbus_intr_info, 0, verbose);
+		fatal |= t4_handle_intr(adap, &pcie_port_intr_info, 0, verbose);
+
+		pcie_intr_info.details = pcie_intr_details;
+	} else {
+		pcie_intr_info.details = t5_pcie_intr_details;
+	}
+	fatal |= t4_handle_intr(adap, &pcie_intr_info, 0, verbose);
+	if (is_t7(adap->params.chip)) {
+		fatal |= t4_handle_intr(adap, &pcie_int_cause_ext, 0, verbose);
+		fatal |= t4_handle_intr(adap, &pcie_int_cause_x8, 0, verbose);
+	}
+
+	return fatal;
+}
+
+/*
+ * TP interrupt handler.
+ */
+static bool tp_intr_handler(struct adapter *adap, int arg, bool verbose)
+{
+	static const struct intr_details tp_intr_details[] = {
+		{ 0x3fffffff, "TP parity error" },
+		{ FLMTXFLSTEMPTY_F, "TP out of Tx pages" },
+		{ 0 }
+	};
+	static const struct intr_details t7_tp_intr_details[] = {
+		{ FLMTXFLSTEMPTY_F, "Offload memory manager Tx free list empty" },
+		{ TPCERR_F, "TP modules flagged Correctable Error" },
+		{ OTHERPERR_F, "TP Other modules (Core, TM, FLM, MMGR, DB) Parity Error" },
+		{ TPEING1PERR_F, "TP-ESide Ingress1 Parity Error" },
+		{ TPEING0PERR_F, "TP-ESide Ingress0 Parity Error" },
+		{ TPEEGPERR_F, "TP-ESide Egress Parity Error" },
+		{ TPCPERR_F, "TP-CSide Parity Error" },
+		{ 0 }
+	};
+	struct intr_info tp_intr_info = {
+		.name = "TP_INT_CAUSE",
+		.cause_reg = TP_INT_CAUSE_A,
+		.enable_reg = TP_INT_ENABLE_A,
+		.fatal = 0x7fffffdf,
+		.skip_clear = 1,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = NULL,
+		.actions = NULL,
+	};
+	static const struct intr_details tp_cerr_cause_details[] = {
+		{ TPCEGDATAFIFO_F, "TPCSide Egress Data FIFO" },
+		{ TPCLBKDATAFIFO_F, "TPCSide Loopback Data FIFO" },
+		{ RSSLKPSRAM_F, "RSS Lookup SRAM" },
+		{ SRQSRAM_F, "SRQ SRAM" },
+		{ ARPDASRAM_F, "ARP DA SRAM" },
+		{ ARPSASRAM_F, "ARP SA SRAM" },
+		{ ARPGRESRAM_F, "ARP GRE SRAM" },
+		{ ARPIPSECSRAM1_F, "ARP IPSec SRAM0" },
+		{ ARPIPSECSRAM0_F, "ARP IPSec SRAM1" },
+		{ 0 }
+	};
+	static const struct intr_info tp_cerr_cause = {
+		.name = "TP_CERR_CAUSE",
+		.cause_reg = TP_CERR_CAUSE_A,
+		.enable_reg = TP_CERR_ENABLE_A,
+		.fatal = 0,
+		.flags = 0,
+		.details = tp_cerr_cause_details,
+		.actions = NULL,
+	};
+	static const struct intr_details tp_c_perr_details[] = {
+		{ DMXFIFOOVFL_F, "Demux FIFO Overflow" },
+		{ URX2TPCDDPINTF_F, "ULPRX to TPC DDP Interface and FIFO" },
+		{ TPCDISPTOKENFIFO_F, "TPC Dispatch Token FIFO" },
+		{ TPCDISPCPLFIFO3_F, "TPC Dispatch CPL FIFO Ch3" },
+		{ TPCDISPCPLFIFO2_F, "TPC Dispatch CPL FIFO Ch2" },
+		{ TPCDISPCPLFIFO1_F, "TPC Dispatch CPL FIFO Ch1" },
+		{ TPCDISPCPLFIFO0_F, "TPC Dispatch CPL FIFO Ch0" },
+		{ URXPLDINTFCRC3_F, "ULPRX to TPC Payload Interface CRC Error Ch3" },
+		{ URXPLDINTFCRC2_F, "ULPRX to TPC Payload Interface CRC Error Ch2" },
+		{ URXPLDINTFCRC1_F, "ULPRX to TPC Payload Interface CRC Error Ch1" },
+		{ URXPLDINTFCRC0_F, "ULPRX to TPC Payload Interface CRC Error Ch0" },
+		{ DMXDBFIFO_F, "Demux DB FIFO" },
+		{ DMXDBSRAM_F, "Demux DB SRAM" },
+		{ DMXCPLFIFO_F, "Demux CPL FIFO" },
+		{ DMXCPLSRAM_F, "Demux CPL SRAM" },
+		{ DMXCSUMFIFO_F, "Demux Checksum FIFO" },
+		{ DMXLENFIFO_F, "Demux Length FIFO" },
+		{ DMXCHECKFIFO_F, "Demux Check CRC16 FIFO" },
+		{ DMXWINFIFO_F, "Demux Winner FIFO" },
+		{ EGTOKENFIFO_F, "Egress Token FIFO Parity Error" },
+		{ EGDATAFIFO_F, "Egress FIFO Parity Error" },
+		{ UTX2TPCINTF3_F, "ULPTX to TPC Interface Parity Error Ch3" },
+		{ UTX2TPCINTF2_F, "ULPTX to TPC Interface Parity Error Ch2" },
+		{ UTX2TPCINTF1_F, "ULPTX to TPC Interface Parity Error Ch1" },
+		{ UTX2TPCINTF0_F, "ULPTX to TPC Interface Parity Error Ch0" },
+		{ LBKTOKENFIFO_F, "Loopback Token FIFO Parity Error" },
+		{ LBKDATAFIFO_F, "Loopback FIFO Parity Error" },
+		{ 0 }
+	};
+	static const struct intr_info tp_c_perr_cause = {
+		.name = "TP_C_PERR_CAUSE",
+		.cause_reg = TP_C_PERR_CAUSE_A,
+		.enable_reg = TP_C_PERR_ENABLE_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = tp_c_perr_details,
+		.actions = NULL,
+	};
+	static const struct intr_details tp_e_eg_perr_details[] = {
+		{ MPSLPBKTOKENFIFO_F, "MPS Loopback Token FIFO parity error" },
+		{ MPSMACTOKENFIFO_F, "MPS MAC Token FIFO parity error" },
+		{ DISPIPSECFIFO3_F, "Ch3 Dispatch IPSec FIFO parity error" },
+		{ DISPTCPFIFO3_F, "Ch3 Dispatch TCP FIFO parity error" },
+		{ DISPIPFIFO3_F, "Ch3 Dispatch IP FIFO parity error" },
+		{ DISPETHFIFO3_F, "Ch3 Dispatch ETH FIFO parity error" },
+		{ DISPGREFIFO3_F, "Ch3 Dispatch GRE FIFO parity error" },
+		{ DISPCPL5FIFO3_F, "Ch3 Dispatch CPL5 FIFO parity error" },
+		{ DISPIPSECFIFO2_F, "Ch2 Dispatch IPSec FIFO parity error" },
+		{ DISPTCPFIFO2_F, "Ch2 Dispatch TCP FIFO parity error" },
+		{ DISPIPFIFO2_F, "Ch2 Dispatch IP FIFO parity error" },
+		{ DISPETHFIFO2_F, "Ch2 Dispatch ETH FIFO parity error" },
+		{ DISPGREFIFO2_F, "Ch2 Dispatch GRE FIFO parity error" },
+		{ DISPCPL5FIFO2_F, "Ch2 Dispatch CPL5 FIFO parity error" },
+		{ DISPIPSECFIFO1_F, "Ch1 Dispatch IPSec FIFO parity error" },
+		{ DISPTCPFIFO1_F, "Ch1 Dispatch TCP FIFO parity error" },
+		{ DISPIPFIFO1_F, "Ch1 Dispatch IP FIFO parity error" },
+		{ DISPETHFIFO1_F, "Ch1 Dispatch ETH FIFO parity error" },
+		{ DISPGREFIFO1_F, "Ch1 Dispatch GRE FIFO parity error" },
+		{ DISPCPL5FIFO1_F, "Ch1 Dispatch CPL5 FIFO parity error" },
+		{ DISPIPSECFIFO0_F, "Ch0 Dispatch IPSec FIFO parity error" },
+		{ DISPTCPFIFO0_F, "Ch0 Dispatch TCP FIFO parity error" },
+		{ DISPIPFIFO0_F, "Ch0 Dispatch IP FIFO parity error" },
+		{ DISPETHFIFO0_F, "Ch0 Dispatch ETH FIFO parity error" },
+		{ DISPGREFIFO0_F, "Ch0 Dispatch GRE FIFO parity error" },
+		{ DISPCPL5FIFO0_F, "Ch0 Dispatch CPL5 FIFO parity error" },
+		{ 0 }
+	};
+	static const struct intr_info tp_e_eg_perr_cause = {
+		.name = "TP_E_EG_PERR_CAUSE",
+		.cause_reg = TP_E_EG_PERR_CAUSE_A,
+		.enable_reg = TP_E_EG_PERR_ENABLE_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = tp_e_eg_perr_details,
+		.actions = NULL,
+	};
+	static const struct intr_details tp_e_in0_perr_details[] = {
+		{ DMXISSFIFO_F, "Demux ISS FIFO parity error" },
+		{ DMXERRFIFO_F, "Demux Error FIFO parity error" },
+		{ DMXATTFIFO_F, "Demux Attributes FIFO parity error" },
+		{ DMXTCPFIFO_F, "Demux TCP Fields FIFO parity error" },
+		{ DMXMPAFIFO_F, "Demux MPA FIFO parity error" },
+		{ DMXOPTFIFO_F, "Demux TCP Options FIFO parity error" },
+		{ INGTOKENFIFO_F, "Demux Ingress Token FIFO parity error" },
+		{ DMXPLDCHKOVFL1_F, "Ch1 PLD TxCheck FIFO Overflow" },
+		{ DMXPLDCHKFIFO1_F, "Ch1 PLD TxCheck FIFO parity error" },
+		{ DMXOPTFIFO1_F, "Ch1 Options buffer parity error" },
+		{ DMXMPAFIFO1_F, "Ch1 MPA FIFO parity error" },
+		{ DMXDBFIFO1_F, "Ch1 DB FIFO parity error" },
+		{ DMXATTFIFO1_F, "Ch1 Attribute FIFO parity error" },
+		{ DMXISSFIFO1_F, "Ch1 ISS FIFO parity error" },
+		{ DMXTCPFIFO1_F, "Ch1 TCP Fields FIFO parity error" },
+		{ DMXERRFIFO1_F, "Ch1 Error FIFO parity error" },
+		{ MPS2TPINTF1_F, "Ch1 MPS2TP Interface parity error" },
+		{ DMXPLDCHKOVFL0_F, "Ch0 PLD TxCheck FIFO Overflow" },
+		{ DMXPLDCHKFIFO0_F, "Ch0 PLD TxCheck FIFO parity error" },
+		{ DMXOPTFIFO0_F, "Ch0 Options buffer parity error" },
+		{ DMXMPAFIFO0_F, "Ch0 MPA FIFO parity error" },
+		{ DMXDBFIFO0_F, "Ch0 DB FIFO parity error" },
+		{ DMXATTFIFO0_F, "Ch0 Attribute FIFO parity error" },
+		{ DMXISSFIFO0_F, "Ch0 ISS FIFO parity error" },
+		{ DMXTCPFIFO0_F, "Ch0 TCP Fields FIFO parity error" },
+		{ DMXERRFIFO0_F, "Ch0 Error FIFO parity error" },
+		{ MPS2TPINTF0_F, "Ch0 MPS2TP Interface parity error" },
+		{ 0 }
+	};
+	static const struct intr_info tp_e_in0_perr_cause = {
+		.name = "TP_E_IN0_PERR_CAUSE",
+		.cause_reg = TP_E_IN0_PERR_CAUSE_A,
+		.enable_reg = TP_E_IN0_PERR_ENABLE_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = tp_e_in0_perr_details,
+		.actions = NULL,
+	};
+	static const struct intr_details tp_e_in1_perr_details[] = {
+		{ DMXPLDCHKOVFL3_F, "Ch3 PLD TxCheck FIFO Overflow" },
+		{ DMXPLDCHKFIFO3_F, "Ch3 PLD TxCheck FIFO parity error" },
+		{ DMXOPTFIFO3_F, "Ch3 Options buffer parity error" },
+		{ DMXMPAFIFO3_F, "Ch3 MPA FIFO parity error" },
+		{ DMXDBFIFO3_F, "Ch3 DB FIFO parity error" },
+		{ DMXATTFIFO3_F, "Ch3 Attribute FIFO parity error" },
+		{ DMXISSFIFO3_F, "Ch3 ISS FIFO parity error" },
+		{ DMXTCPFIFO3_F, "Ch3 TCP Fields FIFO parity error" },
+		{ DMXERRFIFO3_F, "Ch3 Error FIFO parity error" },
+		{ MPS2TPINTF3_F, "Ch3 MPS2TP Interface parity error" },
+		{ DMXPLDCHKOVFL2_F, "Ch2 PLD TxCheck FIFO Overflow" },
+		{ DMXPLDCHKFIFO2_F, "Ch2 PLD TxCheck FIFO parity error" },
+		{ DMXOPTFIFO2_F, "Ch2 Options buffer parity error" },
+		{ DMXMPAFIFO2_F, "Ch2 MPA FIFO parity error" },
+		{ DMXDBFIFO2_F, "Ch2 DB FIFO parity error" },
+		{ DMXATTFIFO2_F, "Ch2 Attribute FIFO parity error" },
+		{ DMXISSFIFO2_F, "Ch2 ISS FIFO parity error" },
+		{ DMXTCPFIFO2_F, "Ch2 TCP Fields FIFO parity error" },
+		{ DMXERRFIFO2_F, "Ch2 Error FIFO parity error" },
+		{ MPS2TPINTF2_F, "Ch2 MPS2TP Interface parity error" },
+		{ 0 }
+	};
+	static const struct intr_info tp_e_in1_perr_cause = {
+		.name = "TP_E_IN1_PERR_CAUSE",
+		.cause_reg = TP_E_IN1_PERR_CAUSE_A,
+		.enable_reg = TP_E_IN1_PERR_ENABLE_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = tp_e_in1_perr_details,
+		.actions = NULL,
+	};
+	static const struct intr_details tp_other_perr_details[] = {
+		{ DMARBTPERR_F, "DMARBT MA Rsp Interface parity Error" },
+		{ MMGRCACHEDATASRAM_F, "TP MMGR Cache Data SRAM" },
+		{ MMGRCACHETAGFIFO_F, "TP MMGR Cache Tag FIFO" },
+		{ DBL2TLUTPERR_F, "TP DB Lookup Table" },
+		{ DBTXTIDPERR_F, "TP DB FIFOs" },
+		{ DBEXTPERR_F, "TP DB Extended Opcode FIFO" },
+		{ DBOPPERR_F, "TP DB Opcode FIFO" },
+		{ TMCACHEPERR_F, "TP TM Cache SRAM" },
+		{ TPPROTOSRAM_F, "TP Protocol SRAM" },
+		{ HSPSRAM_F, "HighSpeed SRAM" },
+		{ RATEGRPSRAM_F, "Rate Group SRAM" },
+		{ TXFBSEQFIFO_F, "Tx Feedback Sequence Number FIFO" },
+		{ CMDATASRAM_F, "Cache Data SRAM" },
+		{ CMTAGFIFO_F, "Cache Tag FIFO" },
+		{ RFCOPFIFO_F, "RCF Opcode FIFO" },
+		{ DELINVFIFO_F, "Delete Invalid FIFO" },
+		{ RSSCFGSRAM_F, "RSS Config or Round-Robin SRAM" },
+		{ RSSKEYSRAM_F, "RSS Key SRAM" },
+		{ RSSLKPSRAM_F, "RSS Lookup SRAM" },
+		{ SRQSRAM_F, "SRQ SRAM" },
+		{ ARPDASRAM_F, "ARP DA SRAM" },
+		{ ARPSASRAM_F, "ARP SA SRAM" },
+		{ ARPGRESRAM_F, "ARP GRE SRAM" },
+		{ ARPIPSECSRAM1_F, "ARP IPSec SRAM0" },
+		{ ARPIPSECSRAM0_F, "ARP IPSec SRAM1" },
+		{ 0 }
+	};
+	static const struct intr_info tp_o_perr_cause = {
+		.name = "TP_O_PERR_CAUSE",
+		.cause_reg = TP_O_PERR_CAUSE_A,
+		.enable_reg = TP_O_PERR_ENABLE_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = tp_other_perr_details,
+		.actions = NULL,
+	};
+	bool fatal;
+
+	if (is_t7(adap->params.chip)) {
+		tp_intr_info.details = t7_tp_intr_details;
+		fatal = t4_handle_intr(adap, &tp_intr_info, 0, verbose);
+		fatal |= t4_handle_intr(adap, &tp_cerr_cause, 0, verbose);
+		fatal |= t4_handle_intr(adap, &tp_c_perr_cause, 0, verbose);
+		fatal |= t4_handle_intr(adap, &tp_e_eg_perr_cause, 0, verbose);
+		fatal |= t4_handle_intr(adap, &tp_e_in0_perr_cause, 0, verbose);
+		fatal |= t4_handle_intr(adap, &tp_e_in1_perr_cause, 0, verbose);
+		fatal |= t4_handle_intr(adap, &tp_o_perr_cause, 0, verbose);
+	} else {
+		tp_intr_info.details = tp_intr_details;
+		fatal = t4_handle_intr(adap, &tp_intr_info, 0, verbose);
+	}
+
+	clear_int_cause_reg(adap, &tp_intr_info);
+	return fatal;
+}
+
+/*
+ * SGE interrupt handler.
+ */
+static bool sge_intr_handler(struct adapter *adap, int arg, bool verbose)
+{
+	static const struct intr_details sge_int1_details[] = {
+		{ PERR_FLM_CREDITFIFO_F, "SGE FLM credit FIFO parity error" },
+		{ PERR_IMSG_HINT_FIFO_F, "SGE IMSG hint FIFO parity error" },
+		{ PERR_HEADERSPLIT_FIFO3_F | PERR_HEADERSPLIT_FIFO2_F,
+			"SGE header split FIFO parity error" },
+		{ PERR_PAYLOAD_FIFO3_F | PERR_PAYLOAD_FIFO2_F,
+			"SGE payload FIFO parity error" },
+		{ PERR_PC_RSP_F, "SGE PC response parity error" },
+		{ PERR_PC_REQ_F, "SGE PC request parity error" },
+		{ 0x003c0000, "SGE DBP PC response FIFO parity error" },
+		{ PERR_DMARBT_F, "SGE DMA RBT parity error" },
+		{ PERR_FLM_DBPFIFO_F, "SGE FLM DBP FIFO parity error" },
+		{ PERR_FLM_MCREQ_FIFO_F, "SGE FLM MC request FIFO parity error" },
+		{ PERR_FLM_HINTFIFO_F, "SGE FLM hint FIFO parity error" },
+		{ 0x00003c00, "SGE align control FIFO parity error" },
+		{ 0x000003c0, "SGE EDMA FIFO parity error" },
+		{ 0x0000003c, "SGE PD FIFO parity error" },
+		{ PERR_ING_CTXT_MIFRSP_F, "SGE Ingress context MIF response parity error" },
+		{ PERR_EGR_CTXT_MIFRSP_F, "SGE Egress context MIF response parity error" },
+		{ 0 }
+	};
+	static const struct intr_info sge_int1_info = {
+		.name = "SGE_INT_CAUSE1",
+		.cause_reg = SGE_INT_CAUSE1_A,
+		.enable_reg = SGE_INT_ENABLE1_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = sge_int1_details,
+		.actions = NULL,
+	};
+	static const struct intr_details t7_sge_int2_details[] = {
+		{ TF_FIFO_PERR_F, "SGE TF FIFO parity error" },
+		{ PERR_EGR_DBP_TX_COAL_F, "SGE egress DBP TX coal parity error" },
+		{ PERR_DBP_FL_FIFO_F, "SGE DBP FL FIFO parity error" },
+		{ DEQ_LL_PERR_F, "SGE linked list SRAM parity error" },
+		{ ENQ_PERR_F, "SGE enq tag SRAM parity error" },
+		{ DEQ_OUT_PERR_F, "SGE tbuf deq output FIFO parity error" },
+		{ BUF_PERR_F, "SGE tbuf main buffer parity error" },
+		{ PERR_CONM_SRAM_F, "SGE CONM SRAM parity error" },
+		{ PERR_ISW_IDMA3_FIFO_F | PERR_ISW_IDMA2_FIFO_F |
+		  PERR_ISW_IDMA1_FIFO_F | PERR_ISW_IDMA0_FIFO_F,
+		  "SGE ISW IDMA FIFO parity error" },
+		{ PERR_ISW_DBP_FIFO_F, "SGE ISW DBP FIFO parity error" },
+		{ PERR_ISW_GTS_FIFO_F, "SGE ISW GTS FIFO parity error" },
+		{ PERR_ITP_EVR_F, "SGE ITP EVR parity error" },
+		{ PERR_FLM_CNTXMEM_F, "SGE FLM context memory parity error" },
+		{ PERR_FLM_L1CACHE_F, "SGE FLM L1 cache parity error" },
+		{ SGE_IPP_FIFO_PERR_F, "SGE IPP FIFO parity error" },
+		{ PERR_DBP_HP_FIFO_F, "SGE DBP HP FIFO parity error" },
+		{ PERR_DB_FIFO_F, "SGE doorbell FIFO parity error" },
+		{ PERR_ING_CTXT_CACHE_F | PERR_EGR_CTXT_CACHE_F,
+		  "SGE context cache parity error" },
+		{ PERR_BASE_SIZE_F, "SGE base size parity error" },
+		{ 0 }
+	};
+	static const struct intr_details t6_sge_int2_details[] = {
+		{ PERR_DBP_HINT_FL_FIFO_F, "SGE DBP hint FL FIFO parity error" },
+		{ PERR_EGR_DBP_TX_COAL_F, "SGE egress DBP TX coal parity error" },
+		{ PERR_DBP_FL_FIFO_F, "SGE DBP FL FIFO parity error" },
+		{ DEQ_LL_PERR_F, "SGE tbuf dequeue linked list SRAM parity error" },
+		{ ENQ_PERR_F, "SGE tbuf enqueue tag SRAM parity error" },
+		{ DEQ_OUT_PERR_F, "SGE tbuf dequeue output FIFO parity error" },
+		{ BUF_PERR_F, "SGE tbuf main buffer parity error" },
+		{ PERR_CONM_SRAM_F, "SGE CONM SRAM parity error" },
+		{ PERR_ISW_IDMA1_FIFO_F, "SGE ISW IDMA FIFO parity error" },
+		{ PERR_ISW_IDMA0_FIFO_F, "SGE ISW IDMA FIFO parity error" },
+		{ PERR_ISW_DBP_FIFO_F, "SGE ISW DBP FIFO parity error" },
+		{ PERR_ISW_GTS_FIFO_F, "SGE ISW GTS FIFO parity error" },
+		{ PERR_ITP_EVR_F, "SGE ITP EVR parity error" },
+		{ PERR_FLM_CNTXMEM_F, "SGE FLM context memory parity error" },
+		{ PERR_FLM_L1CACHE_F, "SGE FLM L1 cache parity error" },
+		{ PERR_DBP_HINT_FIFO_F, "SGE DBP hint FIFO parity error" },
+		{ PERR_DBP_HP_FIFO_F, "SGE DBP high priority FIFO parity error" },
+		{ PERR_DB_FIFO_F, "SGE DBP merge DB FIFO parity error" },
+		{ PERR_ING_CTXT_CACHE_F, "SGE ingress context cache parity error" },
+		{ PERR_EGR_CTXT_CACHE_F, "SGE egress context cache parity error" },
+		{ PERR_BASE_SIZE_F, "SGE base size parity error" },
+		{ 0 }
+	};
+	struct intr_info sge_int2_info = {
+		.name = "SGE_INT_CAUSE2",
+		.cause_reg = SGE_INT_CAUSE2_A,
+		.enable_reg = SGE_INT_ENABLE2_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = NULL,
+		.actions = NULL,
+	};
+	static const struct intr_details sge_int3_details[] = {
+		{ ERR_FLM_DBP_F,
+			"DBP pointer delivery for invalid context or QID" },
+		{ ERR_FLM_IDMA1_F | ERR_FLM_IDMA0_F,
+			"Invalid QID or header request by IDMA" },
+		{ ERR_FLM_HINT_F, "FLM hint is for invalid context or QID" },
+		{ ERR_PCIE_ERROR3_F, "SGE PCIe error for DBP thread 3" },
+		{ ERR_PCIE_ERROR2_F, "SGE PCIe error for DBP thread 2" },
+		{ ERR_PCIE_ERROR1_F, "SGE PCIe error for DBP thread 1" },
+		{ ERR_PCIE_ERROR0_F, "SGE PCIe error for DBP thread 0" },
+		{ ERR_TIMER_ABOVE_MAX_QID_F,
+			"SGE GTS with timer 0-5 for IQID > 1023" },
+		{ ERR_CPL_EXCEED_IQE_SIZE_F,
+			"SGE received CPL exceeding IQE size" },
+		{ ERR_INVALID_CIDX_INC_F, "SGE GTS CIDX increment too large" },
+		{ ERR_ITP_TIME_PAUSED_F, "SGE ITP error" },
+		{ ERR_CPL_OPCODE_0_F, "SGE received 0-length CPL" },
+		{ ERR_DROPPED_DB_F, "SGE DB dropped" },
+		{ ERR_DATA_CPL_ON_HIGH_QID1_F | ERR_DATA_CPL_ON_HIGH_QID0_F,
+			"SGE IQID > 1023 received CPL for FL" },
+		{ ERR_BAD_DB_PIDX3_F | ERR_BAD_DB_PIDX2_F | ERR_BAD_DB_PIDX1_F |
+			ERR_BAD_DB_PIDX0_F, "SGE DBP pidx increment too large" },
+		{ ERR_ING_PCIE_CHAN_F, "SGE Ingress PCIe channel mismatch" },
+		{ ERR_ING_CTXT_PRIO_F,
+			"Ingress context manager priority user error" },
+		{ ERR_EGR_CTXT_PRIO_F,
+			"Egress context manager priority user error" },
+		{ DBFIFO_HP_INT_F, "High priority DB FIFO threshold reached" },
+		{ DBFIFO_LP_INT_F, "Low priority DB FIFO threshold reached" },
+		{ REG_ADDRESS_ERR_F, "Undefined SGE register accessed" },
+		{ INGRESS_SIZE_ERR_F, "SGE illegal ingress QID" },
+		{ EGRESS_SIZE_ERR_F, "SGE illegal egress QID" },
+		{ 0x0000000f, "SGE context access for invalid queue" },
+		{ 0 }
+	};
+	static const struct intr_details t6_sge_int3_details[] = {
+		{ ERR_FLM_DBP_F,
+			"DBP pointer delivery for invalid context or QID" },
+		{ ERR_FLM_IDMA1_F | ERR_FLM_IDMA0_F,
+			"Invalid QID or header request by IDMA" },
+		{ ERR_FLM_HINT_F, "FLM hint is for invalid context or QID" },
+		{ ERR_PCIE_ERROR3_F, "SGE PCIe error for DBP thread 3" },
+		{ ERR_PCIE_ERROR2_F, "SGE PCIe error for DBP thread 2" },
+		{ ERR_PCIE_ERROR1_F, "SGE PCIe error for DBP thread 1" },
+		{ ERR_PCIE_ERROR0_F, "SGE PCIe error for DBP thread 0" },
+		{ ERR_TIMER_ABOVE_MAX_QID_F,
+			"SGE GTS with timer 0-5 for IQID > 1023" },
+		{ ERR_CPL_EXCEED_IQE_SIZE_F,
+			"SGE received CPL exceeding IQE size" },
+		{ ERR_INVALID_CIDX_INC_F, "SGE GTS CIDX increment too large" },
+		{ ERR_ITP_TIME_PAUSED_F, "SGE ITP error" },
+		{ ERR_CPL_OPCODE_0_F, "SGE received 0-length CPL" },
+		{ ERR_DROPPED_DB_F, "SGE DB dropped" },
+		{ ERR_DATA_CPL_ON_HIGH_QID1_F | ERR_DATA_CPL_ON_HIGH_QID0_F,
+			"SGE IQID > 1023 received CPL for FL" },
+		{ ERR_BAD_DB_PIDX3_F | ERR_BAD_DB_PIDX2_F | ERR_BAD_DB_PIDX1_F |
+			ERR_BAD_DB_PIDX0_F, "SGE DBP pidx increment too large" },
+		{ ERR_ING_PCIE_CHAN_F, "SGE Ingress PCIe channel mismatch" },
+		{ ERR_ING_CTXT_PRIO_F,
+			"Ingress context manager priority user error" },
+		{ ERR_EGR_CTXT_PRIO_F,
+			"Egress context manager priority user error" },
+		{ DBP_TBUF_FULL_F, "SGE DBP tbuf full" },
+		{ FATAL_WRE_LEN_F,
+			"SGE WRE packet less than advertized length" },
+		{ REG_ADDRESS_ERR_F, "Undefined SGE register accessed" },
+		{ INGRESS_SIZE_ERR_F, "SGE illegal ingress QID" },
+		{ EGRESS_SIZE_ERR_F, "SGE illegal egress QID" },
+		{ 0x0000000f, "SGE context access for invalid queue" },
+		{ 0 }
+	};
+	struct intr_info sge_int3_info = {
+		.name = "SGE_INT_CAUSE3",
+		.cause_reg = SGE_INT_CAUSE3_A,
+		.enable_reg = SGE_INT_ENABLE3_A,
+		.fatal = 0,
+		.flags = 0,
+		.details = NULL,
+		.actions = NULL,
+	};
+	static const struct intr_details sge_int4_details[] = {
+		{ ERR_ISHIFT_UR1_F | ERR_ISHIFT_UR0_F, "SGE ishift underrun" },
+		{ BAR2_EGRESS_LEN_OR_ADDR_ERR_F, "SGE BAR2 PL access length or alignment error" },
+		{ ERR_CPL_EXCEED_MAX_IQE_SIZE1_F | ERR_CPL_EXCEED_MAX_IQE_SIZE0_F,
+		  "SGE CPL exceeds max IQE size" },
+		{ ERR_WR_LEN_TOO_LARGE3_F | ERR_WR_LEN_TOO_LARGE2_F |
+		  ERR_WR_LEN_TOO_LARGE1_F | ERR_WR_LEN_TOO_LARGE0_F,
+		  "SGE WR length too large" },
+		{ ERR_LARGE_MINFETCH_WITH_TXCOAL3_F | ERR_LARGE_MINFETCH_WITH_TXCOAL2_F |
+		  ERR_LARGE_MINFETCH_WITH_TXCOAL1_F | ERR_LARGE_MINFETCH_WITH_TXCOAL0_F,
+		  "SGE invalid MinFetchBurst with TxCoalesce" },
+		{ COAL_WITH_HP_DISABLE_ERR_F, "SGE coalesce with HP disable error" },
+		{ BAR2_EGRESS_COAL0_ERR_F, "SGE BAR2 PL access addr offset 0" },
+		{ BAR2_EGRESS_SIZE_ERR_F, "SGE BAR2 illegal egress QID access" },
+		{ FLM_PC_RSP_ERR_F, "SGE FLM PC response error" },
+		{ ERR_TH3_MAX_FETCH_F | ERR_TH2_MAX_FETCH_F |
+		  ERR_TH1_MAX_FETCH_F | ERR_TH0_MAX_FETCH_F,
+		  "SGE max fetch violation" },
+		{ ERR_RX_CPL_PACKET_SIZE1_F | ERR_RX_CPL_PACKET_SIZE0_F,
+		  "SGE CPL length mismatch error" },
+		{ ERR_BAD_UPFL_INC_CREDIT3_F | ERR_BAD_UPFL_INC_CREDIT2_F |
+		  ERR_BAD_UPFL_INC_CREDIT1_F | ERR_BAD_UPFL_INC_CREDIT0_F,
+		  "SGE upfl credit wrap error" },
+		{ ERR_PHYSADDR_LEN0_IDMA1_F | ERR_PHYSADDR_LEN0_IDMA0_F,
+		  "SGE CPL_RX_PHYS_ADDR length 0 error" },
+		{ ERR_FLM_INVALID_PKT_DROP1_F | ERR_FLM_INVALID_PKT_DROP0_F,
+		  "SGE IDMA packet drop due to invalid FLM context" },
+		{ ERR_UNEXPECTED_TIMER_F, "SGE unexpected timer error" },
+		{ 0 }
+	};
+	static const struct intr_info sge_int4_info = {
+		.name = "SGE_INT_CAUSE4",
+		.cause_reg = SGE_INT_CAUSE4_A,
+		.enable_reg = SGE_INT_ENABLE4_A,
+		.fatal = 0,
+		.flags = 0,
+		.details = sge_int4_details,
+		.actions = NULL,
+	};
+	static const struct intr_details t7_sge_int5_details[] = {
+		{ ERR_T_RXCRC_F, "SGE RxCRC error" },
+		{ PERR_MC_RSPDATA_F, "SGE MC response data parity error" },
+		{ PERR_PC_RSPDATA_F, "SGE PC response data parity error" },
+		{ PERR_PD_RDRSPDATA_F, "SGE PD read response data parity error" },
+		{ PERR_U_RXDATA_F, "SGE U Rx data parity error" },
+		{ PERR_UD_RXDATA_F, "SGE UD Rx data parity error" },
+		{ PERR_UP_DATA_F, "SGE uP data parity error" },
+		{ PERR_CIM2SGE_RXDATA_F, "SGE CIM2SGE Rx data parity error" },
+		{ PERR_IMSG_PD_FIFO_F, "SGE IMSG PD FIFO parity error" },
+		{ PERR_ULPTX_FIFO1_F | PERR_ULPTX_FIFO0_F, "SGE ULPTX FIFO parity error" },
+		{ PERR_IDMA2IMSG_FIFO3_F | PERR_IDMA2IMSG_FIFO2_F |
+		  PERR_IDMA2IMSG_FIFO1_F | PERR_IDMA2IMSG_FIFO0_F,
+		  "SGE IDMA2IMSG FIFO parity error" },
+		{ PERR_POINTER_DATA_FIFO3_F | PERR_POINTER_DATA_FIFO2_F |
+		  PERR_POINTER_DATA_FIFO1_F | PERR_POINTER_DATA_FIFO0_F,
+		  "SGE pointer data FIFO parity error" },
+		{ PERR_POINTER_HDR_FIFO3_F | PERR_POINTER_HDR_FIFO2_F |
+		  PERR_POINTER_HDR_FIFO1_F | PERR_POINTER_HDR_FIFO0_F,
+		  "SGE pointer header FIFO parity error" },
+		{ PERR_PAYLOAD_FIFO1_F | PERR_PAYLOAD_FIFO0_F,
+		  "SGE payload FIFO parity error" },
+		{ PERR_MGT_BAR2_FIFO_F, "SGE MGT BAR2 FIFO parity error" },
+		{ PERR_HEADERSPLIT_FIFO1_F | PERR_HEADERSPLIT_FIFO0_F,
+		  "SGE header split FIFO parity error" },
+		{ PERR_HINT_DELAY_FIFO_F, "SGE hint delay FIFO parity error" },
+		{ 0 }
+	};
+	static const struct intr_details t6_sge_int5_details[] = {
+		{ ERR_T_RXCRC_F, "SGE T RxCRC parity error" },
+		{ PERR_MC_RSPDATA_F, "SGE MC response data parity error" },
+		{ PERR_PC_RSPDATA_F, "SGE PC response data parity error" },
+		{ PERR_U_RXDATA_F | PERR_UD_RXDATA_F, "SGE ULP Rx data parity error" },
+		{ PERR_UP_DATA_F, "SGE uP data parity error" },
+		{ PERR_CIM2SGE_RXDATA_F, "SGE CIM2SGE Rx data parity error" },
+		{ PERR_HINT_DELAY_FIFO1_F | PERR_HINT_DELAY_FIFO0_F,
+		  "SGE hint delay FIFO parity error" },
+		{ PERR_IMSG_PD_FIFO_F, "SGE IMSG PD FIFO parity error" },
+		{ PERR_ULPTX_FIFO1_F | PERR_ULPTX_FIFO0_F,
+		  "SGE ULPTX FIFO parity error" },
+		{ PERR_IDMA2IMSG_FIFO1_F | PERR_IDMA2IMSG_FIFO0_F,
+		  "SGE IDMA2IMSG FIFO parity error" },
+		{ PERR_POINTER_DATA_FIFO1_F | PERR_POINTER_DATA_FIFO0_F,
+		  "SGE pointer data FIFO parity error" },
+		{ PERR_POINTER_HDR_FIFO1_F | PERR_POINTER_HDR_FIFO0_F,
+		  "SGE pointer header FIFO parity error" },
+		{ PERR_PAYLOAD_FIFO1_F | PERR_PAYLOAD_FIFO0_F,
+		  "SGE payload FIFO parity error" },
+		{ PERR_EDMA_INPUT_FIFO3_F | PERR_EDMA_INPUT_FIFO2_F |
+		  PERR_EDMA_INPUT_FIFO1_F | PERR_EDMA_INPUT_FIFO0_F,
+		  "SGE EDMA input FIFO parity error" },
+		{ PERR_MGT_BAR2_FIFO_F, "SGE MGT BAR2 FIFO parity error" },
+		{ PERR_HEADERSPLIT_FIFO1_F | PERR_HEADERSPLIT_FIFO0_F,
+		  "SGE header split FIFO parity error" },
+		{ PERR_CIM_FIFO1_F | PERR_CIM_FIFO0_F, "SGE CIM FIFO parity error" },
+		{ PERR_IDMA_SWITCH_OUTPUT_FIFO1_F | PERR_IDMA_SWITCH_OUTPUT_FIFO0_F,
+		  "SGE IDMA switch output FIFO parity error" },
+		{ 0 }
+	};
+	struct intr_info sge_int5_info = {
+		.name = "SGE_INT_CAUSE5",
+		.cause_reg = SGE_INT_CAUSE5_A,
+		.enable_reg = SGE_INT_ENABLE5_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = NULL,
+		.actions = NULL,
+	};
+	static const struct intr_details sge_int6_details[] = {
+		/* T7+ */
+		{ 0xe0000000, "SGE fatal DEQ0 DRDY error" },
+		{ 0x1c000000, "SGE fatal OUT0 DRDY error" },
+		{ IMSG_DBG3_STUCK_F | IMSG_DBG2_STUCK_F |
+		  IMSG_DBG1_STUCK_F | IMSG_DBG0_STUCK_F,
+		  "SGE IMSG stuck due to insufficient credits" },
+		/* T6 + */
+		{ ERR_DB_SYNC_F, "SGE doorbell sync failed" },
+		{ ERR_GTS_SYNC_F, "SGE GTS sync failed" },
+		{ FATAL_LARGE_COAL_F, "SGE BAR2 payload too large" },
+		{ PL_BAR2_FRM_ERR_F, "SGE BAR2 framing error" },
+		{ SILENT_DROP_TX_COAL_F, "SGE silent drop of Tx coal WR" },
+		{ ERR_INV_CTXT4_F, "SGE context access for invalid queue thread 4" },
+		{ ERR_BAD_DB_PIDX4_F, "SGE doorbell pidx too large thread 4" },
+		{ ERR_BAD_UPFL_INC_CREDIT4_F, "SGE upfl credit wrap thread 4" },
+		{ FATAL_TAG_MISMATCH_F, "SGE doorbell tag mismatch" },
+		{ FATAL_ENQ_CTL_RDY_F, "SGE enq_ctl_fifo overflow" },
+		{ ERR_PC_RSP_LEN3_F | ERR_PC_RSP_LEN2_F |
+		  ERR_PC_RSP_LEN1_F | ERR_PC_RSP_LEN0_F,
+		  "SGE PCIe response error for DBP threads" },
+		{ FATAL_ENQ2LL_VLD_F, "SGE tbuf fatal_enq2ll_vld" },
+		{ FATAL_LL_EMPTY_F, "SGE tbuf fatal_ll_empty" },
+		{ FATAL_OFF_WDENQ_F, "SGE tbuf fatal_off_wdenq" },
+		{ 0x00000018, "SGE tbuf fatal_deq1_drdy" },
+		{ 0x00000006, "SGE tbuf fatal_out1_drdy" },
+		{ FATAL_DEQ_F, "SGE tbuf fatal_deq" },
+		{ 0 }
+	};
+	static const struct intr_info sge_int6_info = {
+		.name = "SGE_INT_CAUSE6",
+		.cause_reg = SGE_INT_CAUSE6_A,
+		.enable_reg = SGE_INT_ENABLE6_A,
+		.fatal = 0x3c30ff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = sge_int6_details,
+		.actions = NULL,
+	};
+	static const struct intr_details sge_int7_details[] = {
+		{ HINT_FIFO_FULL_F, "SGE hint FIFO full" },
+		{ CERR_HINT_DELAY_FIFO_F, "SGE hint delay FIFO ECC error" },
+		{ COAL_TIMER_FIFO_PERR_F, "SGE coalescing timer FIFO parity error" },
+		{ CMP_FIFO_PERR_F, "SGE CMP FIFO parity error" },
+		{ SGE_IPP_FIFO_CERR_F, "SGE IPP FIFO ECC error" },
+		{ CERR_ING_CTXT_CACHE_F | CERR_EGR_CTXT_CACHE_F,
+		  "SGE context cache ECC error" },
+		{ IMSG_CNTX_PERR_F, "SGE IMSG context parity error" },
+		{ PD_FIFO_PERR_F, "SGE PD FIFO parity error" },
+		{ IMSG_512_FIFO_PERR_F, "SGE IMSG 512 FIFO parity error" },
+		{ CPLSW_FIFO_PERR_F, "SGE CPLSW FIFO parity error" },
+		{ IMSG_FIFO_PERR_F, "SGE IMSG FIFO parity error" },
+		{ CERR_ITP_EVR_F, "SGE ITP EVR ECC error" },
+		{ CERR_CONM_SRAM_F, "SGE CONM SRAM ECC error" },
+		{ CERR_FLM_CNTXMEM_F, "SGE FLM context memory ECC error" },
+		{ CERR_FUNC_QBASE_F, "SGE function queue base ECC error" },
+		{ IMSG_CNTX_CERR_F, "SGE IMSG context ECC error" },
+		{ PD_FIFO_CERR_F, "SGE PD FIFO ECC error" },
+		{ IMSG_512_FIFO_CERR_F, "SGE IMSG 512 FIFO ECC error" },
+		{ CPLSW_FIFO_CERR_F, "SGE CPLSW FIFO ECC error" },
+		{ IMSG_FIFO_CERR_F, "SGE IMSG FIFO ECC error" },
+		{ 0x0000001e, "SGE header split FIFO ECC error" }, // Bits 4:1
+		{ CERR_FLM_L1CACHE_F, "SGE FLM L1 cache ECC error" },
+		{ 0 }
+	};
+	static const struct intr_info sge_int7_info = {
+		.name = "SGE_INT_CAUSE7",
+		.cause_reg = SGE_INT_CAUSE7_A,
+		.enable_reg = SGE_INT_ENABLE7_A,
+		.fatal = CERR_HINT_DELAY_FIFO_F | COAL_TIMER_FIFO_PERR_F | CMP_FIFO_PERR_F |
+			 IMSG_CNTX_PERR_F | PD_FIFO_PERR_F | IMSG_512_FIFO_PERR_F |
+			 CPLSW_FIFO_PERR_F | IMSG_FIFO_PERR_F,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = sge_int7_details,
+		.actions = NULL,
+	};
+	static const struct intr_details sge_int8_details[] = {
+		{ TRACE_RXPERR_F, "SGE trace packet parity error" },
+		{ U3_RXPERR_F | U2_RXPERR_F | U1_RXPERR_F | U0_RXPERR_F,
+		  "SGE ULP interface parity error" },
+		{ T3_RXPERR_F | T2_RXPERR_F | T1_RXPERR_F | T0_RXPERR_F,
+		  "SGE TP interface parity error" },
+		{ 0 }
+	};
+	static const struct intr_info sge_int8_info = {
+		.name = "SGE_INT_CAUSE8",
+		.cause_reg = SGE_INT_CAUSE8_A,
+		.enable_reg = SGE_INT_ENABLE8_A,
+		.fatal = 0xffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = sge_int8_details,
+		.actions = NULL,
+	};
+	bool fatal;
+	u32 v;
+
+	int chip = CHELSIO_CHIP_VERSION(adap->params.chip);
+
+	if (chip <= CHELSIO_T5) {
+		sge_int3_info.details = sge_int3_details;
+		sge_int2_info.details = t6_sge_int2_details;
+		sge_int5_info.details = t6_sge_int5_details;
+	} else if (chip == CHELSIO_T6) {
+		sge_int3_info.details = t6_sge_int3_details;
+		sge_int2_info.details = t6_sge_int2_details;
+		sge_int5_info.details = t6_sge_int5_details;
+	} else {
+		sge_int3_info.details = t6_sge_int3_details;
+		sge_int2_info.details = t7_sge_int2_details;
+		sge_int5_info.details = t7_sge_int5_details;
+	}
+
+	fatal = false;
+	fatal |= t4_handle_intr(adap, &sge_int1_info, 0, verbose);
+	fatal |= t4_handle_intr(adap, &sge_int2_info, 0, verbose);
+	fatal |= t4_handle_intr(adap, &sge_int3_info, 0, verbose);
+	fatal |= t4_handle_intr(adap, &sge_int4_info, 0, verbose);
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T5)
+		fatal |= t4_handle_intr(adap, &sge_int5_info, 0, verbose);
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T6)
+		fatal |= t4_handle_intr(adap, &sge_int6_info, 0, verbose);
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7) {
+		fatal |= t4_handle_intr(adap, &sge_int7_info, 0, verbose);
+		fatal |= t4_handle_intr(adap, &sge_int8_info, 0, verbose);
+	}
+
+	v = t4_read_reg(adap, SGE_ERROR_STATS_A);
+	if (v & ERROR_QID_VALID_F) {
+		dev_err(adap->pdev_dev, "SGE error for QID %u\n", ERROR_QID_G(v));
+		if (v & UNCAPTURED_ERROR_F)
+			dev_err(adap->pdev_dev, "SGE UNCAPTURED_ERROR set (clearing)\n");
+		t4_write_reg(adap, SGE_ERROR_STATS_A, ERROR_QID_VALID_F | UNCAPTURED_ERROR_F);
+	}
+
+	return fatal;
+}
+
+/*
+ * CIM interrupt handler.
+ */
+static bool cim_intr_handler(struct adapter *adap, int arg, bool verbose)
+{
+	static const struct intr_details cim_host_T7_intr_details[] = {
+		{ CORE7ACCINT_F, "CIM slave core 7 access interrupt "},
+		{ CORE6ACCINT_F, "CIM slave core 6 access interrupt "},
+		{ CORE5ACCINT_F, "CIM slave core 5 access interrupt "},
+		{ CORE4ACCINT_F, "CIM slave core 4 access interrupt "},
+		{ CORE3ACCINT_F, "CIM slave core 3 access interrupt "},
+		{ CORE2ACCINT_F, "CIM slave core 2 access interrupt "},
+		{ CORE1ACCINT_F, "CIM slave core 1 access interrupt "},
+		{ TIMER1INT_F, "CIM TIMER0 interrupt" },
+		{ TIMER0INT_F, "CIM TIMER0 interrupt" },
+		{ PREFDROPINT_F, "CIM control register prefetch drop" },
+		{ 0}
+	};
+	static const struct intr_details cim_host_intr_details[] = {
+		/* T6+ */
+		{ PCIE2CIMINTFPARERR_F, "CIM IBQ PCIe interface parity error" },
+
+		/* T5+ */
+		{ MA_CIM_INTFPERR_F, "MA2CIM interface parity error" },
+		{ PLCIM_MSTRSPDATAPARERR_F,
+			"PL2CIM master response data parity error" },
+		{ NCSI2CIMINTFPARERR_F, "CIM IBQ NC-SI interface parity error" },
+		{ SGE2CIMINTFPARERR_F, "CIM IBQ SGE interface parity error" },
+		{ ULP2CIMINTFPARERR_F, "CIM IBQ ULP_TX interface parity error" },
+		{ TP2CIMINTFPARERR_F, "CIM IBQ TP interface parity error" },
+		{ OBQSGERX1PARERR_F, "CIM OBQ PCIE_RX parity error" },
+		{ OBQSGERX0PARERR_F, "CIM OBQ SGE_RX parity error" },
+
+		/* T4+ */
+		{ TIEQOUTPARERRINT_F, "CIM TIEQ outgoing FIFO parity error" },
+		{ TIEQINPARERRINT_F, "CIM TIEQ incoming FIFO parity error" },
+		{ MBHOSTPARERR_F, "CIM mailbox host read parity error" },
+		{ MBUPPARERR_F, "CIM mailbox uP parity error" },
+		{ IBQTP0PARERR_F, "CIM IBQ TP0 parity error" },
+		{ IBQTP1PARERR_F, "CIM IBQ TP1 parity error" },
+		{ IBQULPPARERR_F, "CIM IBQ ULP parity error" },
+		{ IBQSGELOPARERR_F, "CIM IBQ SGE_LO parity error" },
+		{ IBQSGEHIPARERR_F | IBQPCIEPARERR_F,   /* same bit */
+			"CIM IBQ PCIe/SGE_HI parity error" },
+		{ IBQNCSIPARERR_F, "CIM IBQ NC-SI parity error" },
+		{ OBQULP0PARERR_F, "CIM OBQ ULP0 parity error" },
+		{ OBQULP1PARERR_F, "CIM OBQ ULP1 parity error" },
+		{ OBQULP2PARERR_F, "CIM OBQ ULP2 parity error" },
+		{ OBQULP3PARERR_F, "CIM OBQ ULP3 parity error" },
+		{ OBQSGEPARERR_F, "CIM OBQ SGE parity error" },
+		{ OBQNCSIPARERR_F, "CIM OBQ NC-SI parity error" },
+		{ TIMER1INT_F, "CIM TIMER0 interrupt" },
+		{ TIMER0INT_F, "CIM TIMER0 interrupt" },
+		{ PREFDROPINT_F, "CIM control register prefetch drop" },
+		{ 0}
+	};
+	struct intr_info cim_host_intr_info = {
+		.name = "CIM_HOST_INT_CAUSE",
+		.cause_reg = CIM_HOST_INT_CAUSE_A,
+		.enable_reg = CIM_HOST_INT_ENABLE_A,
+		.fatal = 0,
+		.flags = 0,
+		.details = NULL,
+		.actions = NULL,
+	};
+	static const struct intr_details cim_host_upacc_intr_details[] = {
+		{ CONWRERRINT_F, "CIM condition write error "},
+		{ EEPROMWRINT_F, "CIM EEPROM came out of busy state" },
+		{ TIMEOUTMAINT_F, "CIM PIF MA timeout" },
+		{ TIMEOUTINT_F, "CIM PIF timeout" },
+		{ RSPOVRLOOKUPINT_F, "CIM response FIFO overwrite" },
+		{ REQOVRLOOKUPINT_F, "CIM request FIFO overwrite" },
+		{ BLKWRPLINT_F, "CIM block write to PL space" },
+		{ BLKRDPLINT_F, "CIM block read from PL space" },
+		{ SGLWRPLINT_F,
+			"CIM single write to PL space with illegal BEs" },
+		{ SGLRDPLINT_F,
+			"CIM single read from PL space with illegal BEs" },
+		{ BLKWRCTLINT_F, "CIM block write to CTL space" },
+		{ BLKRDCTLINT_F, "CIM block read from CTL space" },
+		{ SGLWRCTLINT_F,
+			"CIM single write to CTL space with illegal BEs" },
+		{ SGLRDCTLINT_F,
+			"CIM single read from CTL space with illegal BEs" },
+		{ BLKWREEPROMINT_F, "CIM block write to EEPROM space" },
+		{ BLKRDEEPROMINT_F, "CIM block read from EEPROM space" },
+		{ SGLWREEPROMINT_F,
+			"CIM single write to EEPROM space with illegal BEs" },
+		{ SGLRDEEPROMINT_F,
+			"CIM single read from EEPROM space with illegal BEs" },
+		{ BLKWRFLASHINT_F, "CIM block write to flash space" },
+		{ BLKRDFLASHINT_F, "CIM block read from flash space" },
+		{ SGLWRFLASHINT_F, "CIM single write to flash space" },
+		{ SGLRDFLASHINT_F,
+			"CIM single read from flash space with illegal BEs" },
+		{ BLKWRBOOTINT_F, "CIM block write to boot space" },
+		{ BLKRDBOOTINT_F, "CIM block read from boot space" },
+		{ SGLWRBOOTINT_F, "CIM single write to boot space" },
+		{ SGLRDBOOTINT_F,
+			"CIM single read from boot space with illegal BEs" },
+		{ ILLWRBEINT_F, "CIM illegal write BEs" },
+		{ ILLRDBEINT_F, "CIM illegal read BEs" },
+		{ ILLRDINT_F, "CIM illegal read" },
+		{ ILLWRINT_F, "CIM illegal write" },
+		{ ILLTRANSINT_F, "CIM illegal transaction" },
+		{ RSVDSPACEINT_F, "CIM reserved space access" },
+		{0}
+	};
+	static const struct intr_info cim_host_upacc_intr_info = {
+		.name = "CIM_HOST_UPACC_INT_CAUSE",
+		.cause_reg = CIM_HOST_UPACC_INT_CAUSE_A,
+		.enable_reg = CIM_HOST_UPACC_INT_ENABLE_A,
+		.fatal = 0xbfffeeff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = cim_host_upacc_intr_details,
+		.actions = NULL,
+	};
+	static const struct intr_info cim_pf_host_intr_info = {
+		.name = "CIM_PF_HOST_INT_CAUSE",
+		.cause_reg = MYPF_REG(CIM_PF_HOST_INT_CAUSE_A),
+		.enable_reg = MYPF_REG(CIM_PF_HOST_INT_ENABLE_A),
+		.fatal = 0,
+		.flags = 0,
+		.details = NULL,
+		.actions = NULL,
+	};
+	static const struct intr_details cim_perr_cause_details[] = {
+		{ T7_MA_CIM_INTFPERR_F, "MA2CIM interface parity error" },
+		{ T7_MBHOSTPARERR_F, "Mailbox Host Read parity error" },
+		{ MAARBINVRSPTAG_F, "MA Arbiter Invalid Response Tag (Fatal)" },
+		{ MAARBFIFOPARERR_F, "MA Arbiter FIFO Parity Error" },
+		{ SEMSRAMPARERR_F, "Semaphore logic SRAM Parity Error" },
+		{ RSACPARERR_F, "RSA Code SRAM Parity Error" },
+		{ RSADPARERR_F, "RSA Data SRAM Parity Error" },
+		{ T7_PLCIM_MSTRSPDATAPARERR_F, "PL2CIM Master response data parity error" },
+		{ T7_PCIE2CIMINTFPARERR_F, "IBQ PCIE intf parity error" },
+		{ T7_NCSI2CIMINTFPARERR_F, "IBQ NCSI intf parity error" },
+		{ T7_SGE2CIMINTFPARERR_F, "IBQ SGE Intf Parity error" },
+		{ T7_ULP2CIMINTFPARERR_F, "IBQ ULP_TX intf parity error" },
+		{ T7_TP2CIMINTFPARERR_F, "IBQ TP intf parity error" },
+		{ CORE7PARERR_F, "Slave Core7 parity error" },
+		{ CORE6PARERR_F, "Slave Core6 parity error" },
+		{ CORE5PARERR_F, "Slave Core5 parity error" },
+		{ CORE4PARERR_F, "Slave Core4 parity error" },
+		{ CORE3PARERR_F, "Slave Core3 parity error" },
+		{ CORE2PARERR_F, "Slave Core2 parity error" },
+		{ CORE1PARERR_F, "Slave Core1 parity error" },
+		{ GFTPARERR_F, "GFT block Memory parity error" },
+		{ MPSRSPDATAPARERR_F, "MPS lookup interface Response parity error" },
+		{ ER_RSPDATAPARERR_F, "Expansion ROM/Flash Interface Response Parity Error" },
+		{ FLOWFIFOPARERR_F, "SGE FlowID Prefetch FIFO Parity Error" },
+		{ OBQSRAMPARERR_F, "OBQ SRAM Parity Error" },
+		{ TIEQOUTPARERR_F, "TIE Queue Outgoing FIFO parity error" },
+		{ TIEQINPARERR_F, "TIE Queue Incoming FIFO parity error" },
+		{ PIFRSPPARERR_F, "PIF Response interface FIFO Parity error" },
+		{ PIFREQPARERR_F, "PIF Request interface FIFO Parity error" },
+		{ 0 }
+	};
+	static const struct intr_info cim_perr_cause = {
+		.name = "CIM_PERR_CAUSE",
+		.cause_reg = CIM_PERR_CAUSE_A,
+		.enable_reg = CIM_PERR_ENABLE_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = cim_perr_cause_details,
+		.actions = NULL,
+	};
+	u32 val, fw_err;
+	bool fatal;
+
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7)
+		cim_host_intr_info.details = cim_host_T7_intr_details;
+	else
+		cim_host_intr_info.details = cim_host_intr_details;
+	/*
+	 * When the Firmware detects an internal error which normally wouldn't
+	 * raise a Host Interrupt, it forces a CIM Timer0 interrupt in order
+	 * to make sure the Host sees the Firmware Crash.  So if we have a
+	 * Timer0 interrupt and don't see a Firmware Crash, ignore the Timer0
+	 * interrupt.
+	 */
+	fw_err = t4_read_reg(adap, PCIE_FW_A);
+	val = t4_read_reg(adap, CIM_HOST_INT_CAUSE_A);
+	if (val & TIMER0INT_F && (!(fw_err & PCIE_FW_ERR_F) ||
+				  PCIE_FW_EVAL_G(fw_err) != PCIE_FW_EVAL_CRASH)) {
+		t4_write_reg(adap, CIM_HOST_INT_CAUSE_A, TIMER0INT_F);
+	}
+
+	fatal = (fw_err & PCIE_FW_ERR_F) != 0;
+	fatal |= t4_handle_intr(adap, &cim_host_intr_info, 0, verbose);
+	fatal |= t4_handle_intr(adap, &cim_host_upacc_intr_info, 0, verbose);
+	fatal |= t4_handle_intr(adap, &cim_pf_host_intr_info, 0, verbose);
+	if (is_t7(adap->params.chip))
+		fatal |= t4_handle_intr(adap, &cim_perr_cause, 0, verbose);
+
+	return fatal;
+}
+
+/*
+ * ULP RX interrupt handler.
+ */
+static bool ulprx_intr_handler(struct adapter *adap, int arg, bool verbose)
+{
+	static const struct intr_details ulprx_intr_details[] = {
+		/* T5+ */
+		{ SE_CNT_MISMATCH_1_F, "ULPRX SE count mismatch in channel 1" },
+		{ SE_CNT_MISMATCH_0_F, "ULPRX SE count mismatch in channel 0" },
+
+		/* T4+ */
+		{ CAUSE_CTX_1_F, "ULPRX channel 1 context error" },
+		{ CAUSE_CTX_0_F, "ULPRX channel 0 context error" },
+		{ 0x007fffff, "ULPRX parity error" },
+		{ 0 }
+	};
+	static const struct intr_details t6_ulprx_int_cause_details[] = {
+		{ SE_CNT_MISMATCH_1_F, "SE count mismatch in channel1" },
+		{ SE_CNT_MISMATCH_0_F, "SE count mismatch in channel 0" },
+		{ CAUSE_CTX_1_F, "Context access error on channel 1" },
+		{ CAUSE_CTX_0_F, "Context access error on channel 0" },
+		{ CAUSE_FF_F, "filp-flop based fifos" },
+		{ CAUSE_APF_1_F, "Arb prefetch memory, channel 1" },
+		{ CAUSE_APF_0_F, "Arb prefetch memory, channel 0" },
+		{ CAUSE_AF_1_F, "Arb fetch memory, channel 1" },
+		{ CAUSE_AF_0_F, "Arb fetch memory, channel 0" },
+		{ CAUSE_DDPDF_1_F, "ddp_data_fifo Fifo, channel 1" },
+		{ CAUSE_DDPMF_1_F, "ddp_msg_fifo Fifo, channel 1" },
+		{ CAUSE_MEMRF_1_F, "mem_req_fifo_d Fifo, channel 1" },
+		{ CAUSE_PRSDF_1_F, "prsr_data_fifo Fifo, channel 1" },
+		{ CAUSE_DDPDF_0_F, "ddp_data_fifo Fifo, channel 0" },
+		{ CAUSE_DDPMF_0_F, "ddp_msg_fifo Fifo, channel 0" },
+		{ CAUSE_MEMRF_0_F, "mem_req_fifo_d Fifo, channel 0" },
+		{ CAUSE_PRSDF_0_F, "prsr_data_fifo Fifo, channel 0" },
+		{ CAUSE_PCMDF_1_F, "Pcmd Fifo, channel 1" },
+		{ CAUSE_TPTCF_1_F, "tpt_ctl_fifo Fifo, channel 1" },
+		{ CAUSE_DDPCF_1_F, "ddp_ctl_fifo Fifo, channel 1" },
+		{ CAUSE_MPARF_1_F, "mpar_ctl_fifo Fifo, channel 1" },
+		{ CAUSE_MPARC_1_F, "mpac_ctl_fifo Fifo, channel 1" },
+		{ CAUSE_PCMDF_0_F, "Pcmd Fifo, channel 0" },
+		{ CAUSE_TPTCF_0_F, "tpt_ctl_fifo Fifo, channel 0" },
+		{ CAUSE_DDPCF_0_F, "ddp_ctl_fifo Fifo, channel 0" },
+		{ CAUSE_MPARF_0_F, "mpar_ctl_fifo Fifo, channel 0" },
+		{ CAUSE_MPARC_0_F, "mpac_ctl_fifo Fifo, channel 0" },
+		{ 0 }
+	};
+	static const struct intr_details t7_ulprx_int_cause_details[] = {
+		{ CERR_PCMD_FIFO_3_F, "PCMD FIFO correctable Error3" },
+		{ CERR_PCMD_FIFO_2_F, "PCMD FIFO correctable Error2" },
+		{ CERR_PCMD_FIFO_1_F, "PCMD FIFO correctable Error1" },
+		{ CERR_PCMD_FIFO_0_F, "PCMD FIFO correctable Error0" },
+		{ CERR_DATA_FIFO_3_F, "DDP Data FIFO correctable Error3" },
+		{ CERR_DATA_FIFO_2_F, "DDP Data FIFO correctable Error2" },
+		{ CERR_DATA_FIFO_1_F, "DDP Data FIFO correctable Error1" },
+		{ CERR_DATA_FIFO_0_F, "DDP Data FIFO correctable Error0" },
+		{ SE_CNT_MISMATCH_3_F, "SE count mismatch in channel3" },
+		{ SE_CNT_MISMATCH_2_F, "SE count mismatch in channel2" },
+		{ T7_SE_CNT_MISMATCH_1_F, "SE count mismatch in channel1" },
+		{ T7_SE_CNT_MISMATCH_0_F, "SE count mismatch in channel 0" },
+		{ T7_ENABLE_CTX_3_F, "Context access error on channel 3" },
+		{ T7_ENABLE_CTX_2_F, "Context access error on channel 2" },
+		{ T7_ENABLE_CTX_1_F, "Context access error on channel 1" },
+		{ T7_ENABLE_CTX_0_F, "Context access error on channel 0" },
+		{ T7_ENABLE_ALN_SDC_ERR_3_F, "SDC error reported by aligner in channel3" },
+		{ T7_ENABLE_ALN_SDC_ERR_2_F, "SDC error reported by aligner in channel2" },
+		{ T7_ENABLE_ALN_SDC_ERR_1_F, "SDC error reported by aligner in channel1" },
+		{ T7_ENABLE_ALN_SDC_ERR_0_F, "SDC error reported by aligner in channel0" },
+		{ 0 }
+	};
+	struct intr_info ulprx_intr_info = {
+		.name = "ULP_RX_INT_CAUSE",
+		.cause_reg = ULP_RX_INT_CAUSE_A,
+		.enable_reg = ULP_RX_INT_ENABLE_A,
+		.fatal = T7_ENABLE_ALN_SDC_ERR_3_F | T7_ENABLE_ALN_SDC_ERR_2_F |
+			 T7_ENABLE_ALN_SDC_ERR_1_F | T7_ENABLE_ALN_SDC_ERR_0_F,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = NULL,
+		.actions = NULL,
+	};
+	static const struct intr_details ulprx_int_cause_2_details[] = {
+		{ ULPRX2MA_INTFPERR_F, "SDC error reported by ULPRX2MA interface parity checker" },
+		{ ALN_SDC_ERR_1_F, "SDC error reported by aligner in channel 1" },
+		{ ALN_SDC_ERR_0_F, "SDC error reported by aligner in channel 0" },
+		{ PF_UNTAGGED_TPT_1_F, "Parity error from Untagged TPT prefetch fifo channel 1" },
+		{ PF_UNTAGGED_TPT_0_F, "Parity error from Untagged TPT prefetch fifo channel 0" },
+		{ PF_PBL_1_F, "Parity error from PBL prefetch fifo channel 1" },
+		{ PF_PBL_0_F, "Parity error from PBL prefetch fifo channel 0" },
+		{ DDP_HINT_1_F, "DDP hint fifo Perr in channel 1" },
+		{ DDP_HINT_0_F, "DDP hint fifo Perr in channel 0" },
+		{ 0 }
+	};
+	static const struct intr_info ulprx_intr2_info = {
+		.name = "ULP_RX_INT_CAUSE_2",
+		.cause_reg = ULP_RX_INT_CAUSE_2_A,
+		.enable_reg = ULP_RX_INT_ENABLE_2_A,
+		.fatal = 0,
+		.flags = 0,
+		.details = ulprx_int_cause_2_details,
+		.actions = NULL,
+	};
+	static const struct intr_details ulprx_int_cause_pcmd_details[] = {
+		{ CAUSE_PCMD_SFIFO_3_F, "Small FIFOs, channel 3" },
+		{ CAUSE_PCMD_FIFO_3_F, "pcmd_ctl_fifo, channel 3" },
+		{ CAUSE_PCMD_DDP_HINT_3_F, "ddp_hint_ctl_fifo FIFO, channel 3" },
+		{ CAUSE_PCMD_TPT_3_F, "tpt_ctl_fifo FIFO, channel 3" },
+		{ CAUSE_PCMD_DDP_3_F, "ddp_ctl_fifo FIFO, channel 3" },
+		{ CAUSE_PCMD_MPAR_3_F, "mpar_ctl_fifo FIFO, channel 3" },
+		{ CAUSE_PCMD_MPAC_3_F, "mpac_ctl_fifo FIFO, channel 3" },
+		{ CAUSE_PCMD_SFIFO_2_F, "Small FIFOs, channel 2" },
+		{ CAUSE_PCMD_FIFO_2_F, "pcmd_ctl_fifo, channel 2" },
+		{ CAUSE_PCMD_DDP_HINT_2_F, "ddp_hint_ctl_fifo FIFO, channel 2" },
+		{ CAUSE_PCMD_TPT_2_F, "tpt_ctl_fifo FIFO, channel 2" },
+		{ CAUSE_PCMD_DDP_2_F, "ddp_ctl_fifo FIFO, channel 2" },
+		{ CAUSE_PCMD_MPAR_2_F, "mpar_ctl_fifo FIFO, channel 2" },
+		{ CAUSE_PCMD_MPAC_2_F, "mpac_ctl_fifo FIFO, channel 2" },
+		{ CAUSE_PCMD_SFIFO_1_F, "Small FIFOs, channel 1" },
+		{ CAUSE_PCMD_FIFO_1_F, "pcmd_ctl_fifo, channel 1" },
+		{ CAUSE_PCMD_DDP_HINT_1_F, "ddp_hint_ctl_fifo FIFO, channel 1" },
+		{ CAUSE_PCMD_TPT_1_F, "tpt_ctl_fifo FIFO, channel 1" },
+		{ CAUSE_PCMD_DDP_1_F, "ddp_ctl_fifo FIFO, channel 1" },
+		{ CAUSE_PCMD_MPAR_1_F, "mpar_ctl_fifo FIFO, channel 1" },
+		{ CAUSE_PCMD_MPAC_1_F, "mpac_ctl_fifo FIFO, channel 1" },
+		{ CAUSE_PCMD_SFIFO_0_F, "Small FIFOs, channel 0" },
+		{ CAUSE_PCMD_FIFO_0_F, "pcmd_ctl_fifo, channel 0" },
+		{ CAUSE_PCMD_DDP_HINT_0_F, "ddp_hint_ctl_fifo FIFO, channel 0" },
+		{ CAUSE_PCMD_TPT_0_F, "tpt_ctl_fifo FIFO, channel 0" },
+		{ CAUSE_PCMD_DDP_0_F, "ddp_ctl_fifo FIFO, channel 0" },
+		{ CAUSE_PCMD_MPAR_0_F, "mpar_ctl_fifo FIFO, channel 0" },
+		{ CAUSE_PCMD_MPAC_0_F, "mpac_ctl_fifo FIFO, channel 0" },
+		{ 0 }
+	};
+	static const struct intr_info ulprx_int_cause_pcmd = {
+		.name = "ULP_RX_INT_CAUSE_PCMD",
+		.cause_reg = ULP_RX_INT_CAUSE_PCMD_A,
+		.enable_reg = ULP_RX_INT_ENABLE_PCMD_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = ulprx_int_cause_pcmd_details,
+		.actions = NULL,
+	};
+	static const struct intr_details ulprx_int_cause_data_details[] = {
+		{ CAUSE_DATA_SNOOP_3_F, "Snoop FIFO, channel 3" },
+		{ CAUSE_DATA_SFIFO_3_F, "Small FIFO, channel 3" },
+		{ CAUSE_DATA_FIFO_3_F, "data_ctl_fifo FIFO, channel 3" },
+		{ CAUSE_DATA_DDP_3_F, "ddp_ctl_fifo FIFO, channel 3" },
+		{ CAUSE_DATA_CTX_3_F, "ctx_ctl_fifo FIFO, channel 3" },
+		{ CAUSE_DATA_PARSER_3_F, "parser_ctl_fifo FIFO, channel 3" },
+		{ CAUSE_DATA_SNOOP_2_F, "Snoop FIFO, channel 2" },
+		{ CAUSE_DATA_SFIFO_2_F, "Small FIFO, channel 2" },
+		{ CAUSE_DATA_FIFO_2_F, "data_ctl_fifo FIFO, channel 2" },
+		{ CAUSE_DATA_DDP_2_F, "ddp_ctl_fifo FIFO, channel 2" },
+		{ CAUSE_DATA_CTX_2_F, "ctx_ctl_fifo FIFO, channel 2" },
+		{ CAUSE_DATA_PARSER_2_F, "parser_ctl_fifo FIFO, channel 2" },
+		{ CAUSE_DATA_SNOOP_1_F, "Snoop FIFO, channel 1" },
+		{ CAUSE_DATA_SFIFO_1_F, "Small FIFO, channel 1" },
+		{ CAUSE_DATA_FIFO_1_F, "data_ctl_fifo FIFO, channel 1" },
+		{ CAUSE_DATA_DDP_1_F, "ddp_ctl_fifo FIFO, channel 1" },
+		{ CAUSE_DATA_CTX_1_F, "ctx_ctl_fifo FIFO, channel 1" },
+		{ CAUSE_DATA_PARSER_1_F, "parser_ctl_fifo FIFO, channel 1" },
+		{ CAUSE_DATA_SNOOP_0_F, "Snoop FIFO, channel 0" },
+		{ CAUSE_DATA_SFIFO_0_F, "Small FIFO, channel 0" },
+		{ CAUSE_DATA_FIFO_0_F, "data_ctl_fifo FIFO, channel 0" },
+		{ CAUSE_DATA_DDP_0_F, "ddp_ctl_fifo FIFO, channel 0" },
+		{ CAUSE_DATA_CTX_0_F, "ctx_ctl_fifo FIFO, channel 0" },
+		{ CAUSE_DATA_PARSER_0_F, "parser_ctl_fifo FIFO, channel 0" },
+		{ 0 }
+	};
+	static const struct intr_info ulprx_int_cause_data = {
+		.name = "ULP_RX_INT_CAUSE_DATA",
+		.cause_reg = ULP_RX_INT_CAUSE_DATA_A,
+		.enable_reg = ULP_RX_INT_ENABLE_DATA_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = ulprx_int_cause_data_details,
+		.actions = NULL,
+	};
+	static const struct intr_details ulprx_int_cause_arb_details[] = {
+		{ CAUSE_ARB_PBL_PF_3_F, "pbl_pf_ctl_fifo FIFO, channel 3" },
+		{ CAUSE_ARB_PF_3_F, "pf_ctl_fifo FIFO, channel 3" },
+		{ CAUSE_ARB_TPT_PF_3_F, "tpt_pf_ctl_fifo FIFO, channel 3" },
+		{ CAUSE_ARB_F_3_F, "f_ctl_fifo FIFO, channel 3" },
+		{ CAUSE_ARB_PBL_PF_2_F, "pbl_pf_ctl_fifo FIFO, channel 2" },
+		{ CAUSE_ARB_PF_2_F, "pf_ctl_fifo FIFO, channel 2" },
+		{ CAUSE_ARB_TPT_PF_2_F, "tpt_pf_ctl_fifo FIFO, channel 2" },
+		{ CAUSE_ARB_F_2_F, "f_ctl_fifo FIFO, channel 2" },
+		{ CAUSE_ARB_PBL_PF_1_F, "pbl_pf_ctl_fifo FIFO, channel 1" },
+		{ CAUSE_ARB_PF_1_F, "pf_ctl_fifo FIFO, channel 1" },
+		{ CAUSE_ARB_TPT_PF_1_F, "tpt_pf_ctl_fifo FIFO, channel 1" },
+		{ CAUSE_ARB_F_1_F, "f_ctl_fifo FIFO, channel 1" },
+		{ CAUSE_ARB_PBL_PF_0_F, "pbl_pf_ctl_fifo FIFO, channel 0" },
+		{ CAUSE_ARB_PF_0_F, "pf_ctl_fifo FIFO, channel 0" },
+		{ CAUSE_ARB_TPT_PF_0_F, "tpt_pf_ctl_fifo FIFO, channel 0" },
+		{ CAUSE_ARB_F_0_F, "f_ctl_fifo FIFO, channel 0" },
+		{ 0 }
+	};
+	static const struct intr_info ulprx_int_cause_arb = {
+		.name = "ULP_RX_INT_CAUSE_ARB",
+		.cause_reg = ULP_RX_INT_CAUSE_ARB_A,
+		.enable_reg = ULP_RX_INT_ENABLE_ARB_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = ulprx_int_cause_arb_details,
+		.actions = NULL,
+	};
+	static const struct intr_details ulprx_int_cause_interface_details[] = {
+		{ CAUSE_ULPRX2SBT_RSPPERR_F, "ULPRX2SBT_RspPerr" },
+		{ CAUSE_ULPRX2MA_RSPPERR_F, "ULPRX2MA_RspPerr" },
+		{ CAUSE_PIO_BUS_PERR_F, "Pio_Bus_Perr" },
+		{ CAUSE_PM2ULP_SNOOPDATA_3_F, "PM2ULP_SnoopData, channel 3" },
+		{ CAUSE_PM2ULP_SNOOPDATA_2_F, "PM2ULP_SnoopData, channel 2" },
+		{ CAUSE_PM2ULP_SNOOPDATA_1_F, "PM2ULP_SnoopData, channel 1" },
+		{ CAUSE_PM2ULP_SNOOPDATA_0_F, "PM2ULP_SnoopData, channel 0" },
+		{ CAUSE_TLS2ULP_DATA_3_F, "TLS2ULP_Data, channel 3" },
+		{ CAUSE_TLS2ULP_DATA_2_F, "TLS2ULP_Data, channel 2" },
+		{ CAUSE_TLS2ULP_DATA_1_F, "TLS2ULP_Data, channel 1" },
+		{ CAUSE_TLS2ULP_DATA_0_F, "TLS2ULP_Data, channel 0" },
+		{ CAUSE_TLS2ULP_PLENDATA_3_F, "TLS2ULP_PLenData, channel 3" },
+		{ CAUSE_TLS2ULP_PLENDATA_2_F, "TLS2ULP_PLenData, channel 2" },
+		{ CAUSE_TLS2ULP_PLENDATA_1_F, "TLS2ULP_PLenData, channel 1" },
+		{ CAUSE_TLS2ULP_PLENDATA_0_F, "TLS2ULP_PLenData, channel 0" },
+		{ CAUSE_PM2ULP_DATA_3_F, "Pm2Ulp_Data, channel 3" },
+		{ CAUSE_PM2ULP_DATA_2_F, "Pm2Ulp_Data, channel 2" },
+		{ CAUSE_PM2ULP_DATA_1_F, "Pm2Ulp_Data, channel 1" },
+		{ CAUSE_PM2ULP_DATA_0_F, "Pm2Ulp_Data, channel 0" },
+		{ CAUSE_TP2ULP_PCMD_3_F, "Tp2Ulp_Pcmd, channel 3" },
+		{ CAUSE_TP2ULP_PCMD_2_F, "Tp2Ulp_Pcmd, channel 2" },
+		{ CAUSE_TP2ULP_PCMD_1_F, "Tp2Ulp_Pcmd, channel 1" },
+		{ CAUSE_TP2ULP_PCMD_0_F, "Tp2Ulp_Pcmd, channel 0" },
+		{ 0 }
+	};
+	static const struct intr_info ulprx_int_cause_intf = {
+		.name = "ULP_RX_INT_CAUSE_INTERFACE",
+		.cause_reg = ULP_RX_INT_CAUSE_INTERFACE_A,
+		.enable_reg = ULP_RX_INT_ENABLE_INTERFACE_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = ulprx_int_cause_interface_details,
+		.actions = NULL,
+	};
+	bool fatal = false;
+
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) <= CHELSIO_T5)
+		ulprx_intr_info.details = ulprx_intr_details;
+	else if (CHELSIO_CHIP_VERSION(adap->params.chip) <= CHELSIO_T6)
+		ulprx_intr_info.details = t6_ulprx_int_cause_details;
+	else
+		ulprx_intr_info.details = t7_ulprx_int_cause_details;
+
+	fatal |= t4_handle_intr(adap, &ulprx_intr_info, 0, verbose);
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) < CHELSIO_T7) {
+		fatal |= t4_handle_intr(adap, &ulprx_intr2_info, 0, verbose);
+	} else {
+		fatal |= t4_handle_intr(adap, &ulprx_int_cause_pcmd, 0, verbose);
+		fatal |= t4_handle_intr(adap, &ulprx_int_cause_data, 0, verbose);
+		fatal |= t4_handle_intr(adap, &ulprx_int_cause_arb, 0, verbose);
+		fatal |= t4_handle_intr(adap, &ulprx_int_cause_intf, 0, verbose);
+	}
+
+	return fatal;
+}
+
+/*
+ * ULP TX interrupt handler.
+ */
+static bool ulptx_intr_handler(struct adapter *adap, int arg, bool verbose)
+{
+	static const struct intr_details ulptx_intr_details[] = {
+		{ PBL_BOUND_ERR_CH3_F, "ULPTX channel 3 PBL out of bounds" },
+		{ PBL_BOUND_ERR_CH2_F, "ULPTX channel 2 PBL out of bounds" },
+		{ PBL_BOUND_ERR_CH1_F, "ULPTX channel 1 PBL out of bounds" },
+		{ PBL_BOUND_ERR_CH0_F, "ULPTX channel 0 PBL out of bounds" },
+		{ 0x0fffffff, "ULPTX parity error" },
+		{ 0 }
+	};
+	static const struct intr_details t6_ulptx_int_cause_details[] = {
+		{ PBL_BOUND_ERR_CH3_F | PBL_BOUND_ERR_CH2_F |
+		  PBL_BOUND_ERR_CH1_F | PBL_BOUND_ERR_CH0_F,
+		  "PBL address out of bounds" },
+		{ SGE2ULP_FIFO_PERR_SET3_F | SGE2ULP_FIFO_PERR_SET2_F |
+		  SGE2ULP_FIFO_PERR_SET1_F | SGE2ULP_FIFO_PERR_SET0_F,
+		  "SGE2ULP fifo parity error" },
+		{ CIM2ULP_FIFO_PERR_SET3_F | CIM2ULP_FIFO_PERR_SET2_F |
+		  CIM2ULP_FIFO_PERR_SET1_F | CIM2ULP_FIFO_PERR_SET0_F,
+		  "CIM2ULP fifo parity error" },
+		{ CQE_FIFO_PERR_SET3_F | CQE_FIFO_PERR_SET2_F |
+		  CQE_FIFO_PERR_SET1_F | CQE_FIFO_PERR_SET0_F,
+		  "CQE fifo parity error" },
+		{ PBL_FIFO_PERR_SET3_F | PBL_FIFO_PERR_SET2_F |
+		  PBL_FIFO_PERR_SET1_F | PBL_FIFO_PERR_SET0_F,
+		  "PBL fifo parity error" },
+		{ CMD_FIFO_PERR_SET3_F | CMD_FIFO_PERR_SET2_F |
+		  CMD_FIFO_PERR_SET1_F | CMD_FIFO_PERR_SET0_F,
+		  "Command fifo parity error" },
+		{ LSO_HDR_SRAM_PERR_SET3_F | LSO_HDR_SRAM_PERR_SET2_F |
+		  LSO_HDR_SRAM_PERR_SET1_F | LSO_HDR_SRAM_PERR_SET0_F,
+		  "LSO hdr parity error" },
+		{ 0 }
+	};
+	struct intr_info ulptx_intr_info = {
+		.name = "ULP_TX_INT_CAUSE",
+		.cause_reg = ULP_TX_INT_CAUSE_A,
+		.enable_reg = ULP_TX_INT_ENABLE_A,
+		.fatal = 0x0fffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = NULL,
+		.actions = NULL,
+	};
+	static const struct intr_details ulptx_int_cause_1_details[] = {
+		{ PBL_BOUND_ERR_CH3_F | PBL_BOUND_ERR_CH2_F |
+		  PBL_BOUND_ERR_CH1_F | PBL_BOUND_ERR_CH0_F,
+		  "PBL address out of bounds (configured PBL_ULIMIT/LLIMIT)" },
+		{ SGE2ULP_FIFO_PERR_SET3_F | SGE2ULP_FIFO_PERR_SET2_F |
+		  SGE2ULP_FIFO_PERR_SET1_F | SGE2ULP_FIFO_PERR_SET0_F,
+		  "SGE2ULP FIFO parity error" },
+		{ CIM2ULP_FIFO_PERR_SET3_F | CIM2ULP_FIFO_PERR_SET2_F |
+		  CIM2ULP_FIFO_PERR_SET1_F | CIM2ULP_FIFO_PERR_SET0_F,
+		  "CIM2ULP FIFO parity error" },
+		{ CQE_FIFO_PERR_SET3_F | CQE_FIFO_PERR_SET2_F |
+		  CQE_FIFO_PERR_SET1_F | CQE_FIFO_PERR_SET0_F,
+		  "CQE FIFO parity error" },
+		{ PBL_FIFO_PERR_SET3_F | PBL_FIFO_PERR_SET2_F |
+		  PBL_FIFO_PERR_SET1_F | PBL_FIFO_PERR_SET0_F,
+		  "PBL FIFO parity error" },
+		{ CMD_FIFO_PERR_SET3_F | CMD_FIFO_PERR_SET2_F |
+		  CMD_FIFO_PERR_SET1_F | CMD_FIFO_PERR_SET0_F,
+		  "Command FIFO parity error" },
+		{ LSO_HDR_SRAM_PERR_SET3_F | LSO_HDR_SRAM_PERR_SET2_F |
+		  LSO_HDR_SRAM_PERR_SET1_F | LSO_HDR_SRAM_PERR_SET0_F,
+		  "LSO HDR parity error" },
+		{ TLS_DSGL_PARERR3_F | TLS_DSGL_PARERR2_F |
+		  TLS_DSGL_PARERR1_F | TLS_DSGL_PARERR0_F,
+		  "TLS Glue DSGL FIFO parity error" },
+		{ 0 }
+	};
+	static const struct intr_info ulptx_intr_info1 = {
+		.name = "ULP_TX_INT_CAUSE_1",
+		.cause_reg = ULP_TX_INT_CAUSE_1_A,
+		.enable_reg = ULP_TX_INT_ENABLE_1_A,
+		.fatal = 0x0fffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = ulptx_int_cause_1_details,
+		.actions = NULL,
+	};
+	static const struct intr_details ulptx_int_cause_2_details[] = {
+		{ EDMA_IN_FIFO_PERR_SET3_F | EDMA_IN_FIFO_PERR_SET2_F |
+		  EDMA_IN_FIFO_PERR_SET1_F | EDMA_IN_FIFO_PERR_SET0_F,
+		  "EDMA input FIFO parity error" },
+		{ ALIGN_CTL_FIFO_PERR_SET3_F | ALIGN_CTL_FIFO_PERR_SET2_F |
+		  ALIGN_CTL_FIFO_PERR_SET1_F | ALIGN_CTL_FIFO_PERR_SET0_F,
+		  "Align control FIFO parity error" },
+		{ SGE_FIFO_PERR_SET3_F | SGE_FIFO_PERR_SET2_F |
+		  SGE_FIFO_PERR_SET1_F | SGE_FIFO_PERR_SET0_F,
+		  "SGE FIFO parity error" },
+		{ STAG_FIFO_PERR_SET3_F | STAG_FIFO_PERR_SET2_F |
+		  STAG_FIFO_PERR_SET1_F | STAG_FIFO_PERR_SET0_F,
+		  "STAG FIFO parity error" },
+		{ MAP_FIFO_PERR_SET3_F | MAP_FIFO_PERR_SET2_F |
+		  MAP_FIFO_PERR_SET1_F | MAP_FIFO_PERR_SET0_F,
+		  "MAP FIFO parity error" },
+		{ DMA_FIFO_PERR_SET3_F | DMA_FIFO_PERR_SET2_F |
+		  DMA_FIFO_PERR_SET1_F | DMA_FIFO_PERR_SET0_F,
+		  "DMA FIFO parity error" },
+		{ FSO_HDR_SRAM_PERR_SET3_F | FSO_HDR_SRAM_PERR_SET2_F |
+		  FSO_HDR_SRAM_PERR_SET1_F | FSO_HDR_SRAM_PERR_SET0_F,
+		  "FSO HDR memory parity error" },
+		{ T10_PI_SRAM_PERR_SET3_F | T10_PI_SRAM_PERR_SET2_F |
+		  T10_PI_SRAM_PERR_SET1_F | T10_PI_SRAM_PERR_SET0_F,
+		  "T10 PI memory parity error" },
+		{ 0 }
+	};
+	static const struct intr_info ulptx_intr_info2 = {
+		.name = "ULP_TX_INT_CAUSE_2",
+		.cause_reg = ULP_TX_INT_CAUSE_2_A,
+		.enable_reg = ULP_TX_INT_ENABLE_2_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = ulptx_int_cause_2_details,
+		.actions = NULL,
+	};
+	static const struct intr_details ulptx_int_cause_3_details[] = {
+		{ GF_SGE_FIFO_PARERR3_F | GF_SGE_FIFO_PARERR2_F |
+		  GF_SGE_FIFO_PARERR1_F | GF_SGE_FIFO_PARERR0_F,
+		  "GF SGE interface FIFO parity error" },
+		{ DEDUPE_SGE_FIFO_PARERR3_F | DEDUPE_SGE_FIFO_PARERR2_F |
+		  DEDUPE_SGE_FIFO_PARERR1_F | DEDUPE_SGE_FIFO_PARERR0_F,
+		  "DeDupe SGE interface FIFO parity error" },
+		{ GF3_DSGL_FIFO_PARERR_F | GF2_DSGL_FIFO_PARERR_F |
+		  GF1_DSGL_FIFO_PARERR_F | GF0_DSGL_FIFO_PARERR_F,
+		  "GF DSGL FIFO parity error" },
+		{ DEDUPE3_DSGL_FIFO_PARERR_F | DEDUPE2_DSGL_FIFO_PARERR_F |
+		  DEDUPE1_DSGL_FIFO_PARERR_F | DEDUPE0_DSGL_FIFO_PARERR_F,
+		  "DeDupe DSGL FIFO parity error" },
+		{ XP10_SGE_FIFO_PARERR_F, "XP10 SGE FIFO parity error (Ch0)" },
+		{ DSGL_PAR_ERR_F, "XP10 DSGL interface parity error" },
+		{ CDDIP_INT_F, "XP10 decompression interrupt" },
+		{ CCEIP_INT_F, "XP10 compression interrupt" },
+		{ TLS_SGE_FIFO_PARERR3_F | TLS_SGE_FIFO_PARERR2_F |
+		  TLS_SGE_FIFO_PARERR1_F | TLS_SGE_FIFO_PARERR0_F,
+		  "TLS Glue SGE FIFO parity error" },
+		{ ULP2SMARBT_RSP_PERR_F, "ULP2SMARBT response data/CTL parity error" },
+		{ ULPTX2MA_RSP_PERR_F, "ULP2MA response data/CTL parity error" },
+		{ PCIE2ULP_PERR3_F | PCIE2ULP_PERR2_F |
+		  PCIE2ULP_PERR1_F | PCIE2ULP_PERR0_F,
+		  "PCIE2ULP EDMA response parity error" },
+		{ CIM2ULP_PERR_F, "CIM2ULP command parity error (all ports)" },
+		{ 0 }
+	};
+	static const struct intr_info ulptx_intr_info3 = {
+		.name = "ULP_TX_INT_CAUSE_3",
+		.cause_reg = ULP_TX_INT_CAUSE_3_A,
+		.enable_reg = ULP_TX_INT_ENABLE_3_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = ulptx_int_cause_3_details,
+		.actions = NULL,
+	};
+	static const struct intr_details ulptx_int_cause_4_details[] = {
+		{ 0xffff0000, "DMA fifo parity error"},
+		{ 0x0000ff00, "core cmd fifo lb error"},
+		{ XP10_2_ULP_PERR_F, "XP10 to ULP parity error" },
+		{ ULP_2_XP10_PERR_F, "ULP to XP10 parity error" },
+		{ CMD_FIFO_LB1_F | CMD_FIFO_LB0_F,
+		  "Command FIFO LB error" },
+		{ TF_TP_PERR_F, "TF TP parity error" },
+		{ TF_SGE_PERR_F, "TF SGE parity error" },
+		{ TF_MEM_PERR_F, "TF memory parity error" },
+		{ TF_MP_PERR_F, "TF MP parity error" },
+		{ 0 }
+	};
+	static const struct intr_info ulptx_intr_info4 = {
+		.name = "ULP_TX_INT_CAUSE_4",
+		.cause_reg = ULP_TX_INT_CAUSE_4_A,
+		.enable_reg = ULP_TX_INT_ENABLE_4_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = ulptx_int_cause_4_details,
+		.actions = NULL,
+	};
+	static const struct intr_details ulptx_int_cause_5_details[] = {
+		{ DEDUPE_PERR3_F | DEDUPE_PERR2_F |
+		  DEDUPE_PERR1_F | DEDUPE_PERR0_F,
+		  "DeDupe parity error" },
+		{ GF_PERR3_F | GF_PERR2_F |
+		  GF_PERR1_F | GF_PERR0_F,
+		  "GF parity error" },
+		{ SGE2ULP_INV_PERR_F, "SGE2ULP invalid parity error" },
+		{ T7_PL_BUSPERR_F, "PL bus parity error" },
+		{ TLSTX2ULPTX_PERR3_F | TLSTX2ULPTX_PERR2_F |
+		  TLSTX2ULPTX_PERR1_F | TLSTX2ULPTX_PERR0_F,
+		  "TLS to ULP parity error" },
+		{ XP10_2_ULP_PL_PERR_F, "XP10 to ULP PL parity error" },
+		{ ULP_2_XP10_PL_PERR_F, "ULP to XP10 PL parity error" },
+		{ 0 }
+	};
+	static const struct intr_info ulptx_intr_info5 = {
+		.name = "ULP_TX_INT_CAUSE_5",
+		.cause_reg = ULP_TX_INT_CAUSE_5_A,
+		.enable_reg = ULP_TX_INT_ENABLE_5_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = ulptx_int_cause_5_details,
+		.actions = NULL,
+	};
+	static const struct intr_details ulptx_int_cause_6_details[] = {
+		{ DDR_HDR_FIFO_PERR_SET3_F | DDR_HDR_FIFO_PERR_SET2_F |
+		  DDR_HDR_FIFO_PERR_SET1_F | DDR_HDR_FIFO_PERR_SET0_F,
+		  "DDR HDR FIFO parity error" },
+		{ PRE_MP_RSP_PERR_SET3_F | PRE_MP_RSP_PERR_SET2_F |
+		  PRE_MP_RSP_PERR_SET1_F | PRE_MP_RSP_PERR_SET0_F,
+		  "Pre-MP response parity error" },
+		{ PRE_CQE_FIFO_PERR_SET3_F | PRE_CQE_FIFO_PERR_SET2_F |
+		  PRE_CQE_FIFO_PERR_SET1_F | PRE_CQE_FIFO_PERR_SET0_F,
+		  "Pre-CQE FIFO parity error" },
+		{ RSP_FIFO_PERR_SET_F, "Response FIFO parity error" },
+		{ 0 }
+	};
+	static const struct intr_info ulptx_intr_info6 = {
+		.name = "ULP_TX_INT_CAUSE_6",
+		.cause_reg = ULP_TX_INT_CAUSE_6_A,
+		.enable_reg = ULP_TX_INT_ENABLE_6_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = ulptx_int_cause_6_details,
+		.actions = NULL,
+	};
+	static const struct intr_details ulptx_int_cause_7_details[] = {
+		{ TLS_SGE_FIFO_CORERR3_F | TLS_SGE_FIFO_CORERR2_F |
+		  TLS_SGE_FIFO_CORERR1_F | TLS_SGE_FIFO_CORERR0_F,
+		  "TLS SGE FIFO correctable error" },
+		{ LSO_HDR_SRAM_CERR_SET3_F | LSO_HDR_SRAM_CERR_SET2_F |
+		  LSO_HDR_SRAM_CERR_SET1_F | LSO_HDR_SRAM_CERR_SET0_F,
+		  "LSO HDR SRAM correctable error" },
+		{ CORE_CMD_FIFO_CERR_SET_CH3_LB1_F | CORE_CMD_FIFO_CERR_SET_CH2_LB1_F |
+		  CORE_CMD_FIFO_CERR_SET_CH1_LB1_F | CORE_CMD_FIFO_CERR_SET_CH0_LB1_F,
+		  "Core command FIFO LB1 correctable error" },
+		{ CORE_CMD_FIFO_CERR_SET_CH3_LB0_F | CORE_CMD_FIFO_CERR_SET_CH2_LB0_F |
+		  CORE_CMD_FIFO_CERR_SET_CH1_LB0_F | CORE_CMD_FIFO_CERR_SET_CH0_LB0_F,
+		  "Core command FIFO LB0 correctable error" },
+		{ CQE_FIFO_CERR_SET3_F | CQE_FIFO_CERR_SET2_F |
+		  CQE_FIFO_CERR_SET1_F | CQE_FIFO_CERR_SET0_F,
+		  "CQE FIFO correctable error" },
+		{ PRE_CQE_FIFO_CERR_SET3_F | PRE_CQE_FIFO_CERR_SET2_F |
+		  PRE_CQE_FIFO_CERR_SET1_F | PRE_CQE_FIFO_CERR_SET0_F,
+		  "Pre-CQE FIFO correctable error" },
+		{ 0 }
+	};
+	static const struct intr_info ulptx_intr_info7 = {
+		.name = "ULP_TX_INT_CAUSE_7",
+		.cause_reg = ULP_TX_INT_CAUSE_7_A,
+		.enable_reg = ULP_TX_INT_ENABLE_7_A,
+		.fatal = 0,
+		.flags = 0,
+		.details = ulptx_int_cause_7_details,
+		.actions = NULL,
+	};
+	static const struct intr_details ulptx_int_cause_8_details[] = {
+		{ MEM_RSP_FIFO_CERR_SET3_F | MEM_RSP_FIFO_CERR_SET2_F |
+		  MEM_RSP_FIFO_CERR_SET1_F | MEM_RSP_FIFO_CERR_SET0_F,
+		  "Memory response FIFO correctable error" },
+		{ PI_SRAM_CERR_SET3_F | PI_SRAM_CERR_SET2_F |
+		  PI_SRAM_CERR_SET1_F | PI_SRAM_CERR_SET0_F,
+		  "PI SRAM correctable error" },
+		{ PRE_MP_RSP_CERR_SET3_F | PRE_MP_RSP_CERR_SET2_F |
+		  PRE_MP_RSP_CERR_SET1_F | PRE_MP_RSP_CERR_SET0_F,
+		  "Pre-MP response correctable error" },
+		{ DDR_HDR_FIFO_CERR_SET3_F | DDR_HDR_FIFO_CERR_SET2_F |
+		  DDR_HDR_FIFO_CERR_SET1_F | DDR_HDR_FIFO_CERR_SET0_F,
+		  "DDR HDR FIFO correctable error" },
+		{ CMD_FIFO_CERR_SET3_F | CMD_FIFO_CERR_SET2_F |
+		  CMD_FIFO_CERR_SET1_F | CMD_FIFO_CERR_SET0_F,
+		  "Command FIFO correctable error" },
+		{ GF_SGE_FIFO_CORERR3_F | GF_SGE_FIFO_CORERR2_F |
+		  GF_SGE_FIFO_CORERR1_F | GF_SGE_FIFO_CORERR0_F,
+		  "GF SGE FIFO correctable error" },
+		{ DEDUPE_SGE_FIFO_CORERR3_F | DEDUPE_SGE_FIFO_CORERR2_F |
+		  DEDUPE_SGE_FIFO_CORERR1_F | DEDUPE_SGE_FIFO_CORERR0_F,
+		  "DeDupe SGE FIFO correctable error" },
+		{ RSP_FIFO_CERR_SET_F, "Response FIFO correctable error" },
+		{ 0 }
+	};
+	static const struct intr_info ulptx_intr_info8 = {
+		.name = "ULP_TX_INT_CAUSE_8",
+		.cause_reg = ULP_TX_INT_CAUSE_8_A,
+		.enable_reg = ULP_TX_INT_ENABLE_8_A,
+		.fatal = 0,
+		.flags = 0,
+		.details = ulptx_int_cause_8_details,
+		.actions = NULL,
+	};
+
+	bool fatal = false;
+
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) == CHELSIO_T6)
+		ulptx_intr_info.details = t6_ulptx_int_cause_details;
+	else
+		ulptx_intr_info.details = ulptx_intr_details;
+
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7) {
+		fatal |= t4_handle_intr(adap, &ulptx_intr_info1, 0, verbose);
+		fatal |= t4_handle_intr(adap, &ulptx_intr_info2, 0, verbose);
+		fatal |= t4_handle_intr(adap, &ulptx_intr_info3, 0, verbose);
+		fatal |= t4_handle_intr(adap, &ulptx_intr_info4, 0, verbose);
+		fatal |= t4_handle_intr(adap, &ulptx_intr_info5, 0, verbose);
+		fatal |= t4_handle_intr(adap, &ulptx_intr_info6, 0, verbose);
+		fatal |= t4_handle_intr(adap, &ulptx_intr_info7, 0, verbose);
+		fatal |= t4_handle_intr(adap, &ulptx_intr_info8, 0, verbose);
+	} else {
+		fatal |= t4_handle_intr(adap, &ulptx_intr_info, 0, verbose);
+		if (CHELSIO_CHIP_VERSION(adap->params.chip) > CHELSIO_T4)
+			fatal |= t4_handle_intr(adap, &ulptx_intr_info2, 0, verbose);
+	}
+	return fatal;
+}
+
+static bool pmtx_dump_dbg_stats(struct adapter *adap, int arg, bool verbose)
 {
-	static const struct intr_info sysbus_intr_info[] = {
-		{ RNPP_F, "RXNP array parity error", -1, 1 },
-		{ RPCP_F, "RXPC array parity error", -1, 1 },
-		{ RCIP_F, "RXCIF array parity error", -1, 1 },
-		{ RCCP_F, "Rx completions control array parity error", -1, 1 },
-		{ RFTP_F, "RXFT array parity error", -1, 1 },
+	int i;
+	u32 data[17];
+
+	t4_read_indirect(adap, PM_TX_DBG_CTRL_A, PM_TX_DBG_DATA_A, &data[0],
+			 ARRAY_SIZE(data), PM_TX_DBG_STAT0_A);
+	for (i = 0; i < ARRAY_SIZE(data); i++) {
+		dev_alert(adap->pdev_dev, "  - PM_TX_DBG_STAT%u (0x%x) = 0x%08x\n", i,
+			  PM_TX_DBG_STAT0_A + i, data[i]);
+	}
+
+	return false;
+}
+
+static bool pm_indirect_intr_handler(struct adapter *adap,
+				     const struct intr_info *ii, int pm_tx,
+				     bool verbose)
+{
+	u32 enable, cause, active, fatal;
+	bool rc;
+
+	if (pm_tx) {
+		t4_read_indirect(adap, PM_TX_DBG_CTRL_A, PM_TX_DBG_DATA_A, &enable, 1,
+				 ii->enable_reg);
+		t4_read_indirect(adap, PM_TX_DBG_CTRL_A, PM_TX_DBG_DATA_A, &cause, 1,
+				 ii->cause_reg);
+	} else {
+		t4_read_indirect(adap, PM_RX_DBG_CTRL_A, PM_RX_DBG_DATA_A, &enable, 1,
+				 ii->enable_reg);
+		t4_read_indirect(adap, PM_RX_DBG_CTRL_A, PM_RX_DBG_DATA_A, &cause, 1,
+				 ii->cause_reg);
+	}
+	if (verbose && cause != 0)
+		t4_show_intr_info(adap, ii, cause, enable);
+
+	fatal = cause & ii->fatal;
+	if (ii->flags & NONFATAL_IF_DISABLED)
+		fatal &= enable;
+
+	/* Only enabled causes are reported, but the full cause register is
+	 * written back below, so that a bit which is asserted while its
+	 * interrupt is disabled does not stay latched.
+	 */
+	active = cause & enable;
+	if (active == 0)
+		return false;
+	rc = fatal != 0;
+
+	if (pm_tx)
+		t4_write_indirect(adap, PM_TX_DBG_CTRL_A, PM_TX_DBG_DATA_A,
+				  &cause, 1, ii->cause_reg);
+	else
+		t4_write_indirect(adap, PM_RX_DBG_CTRL_A, PM_RX_DBG_DATA_A,
+				  &cause, 1, ii->cause_reg);
+
+	return rc;
+}
+
+/*
+ * PM TX interrupt handler.
+ */
+static bool pmtx_intr_handler(struct adapter *adap, int arg, bool verbose)
+{
+	static const struct intr_details t7_pmtx_int_cause_fields[] = {
+		{ MASTER_PERR_F, "PM_TX master parity error" },
+		{ T7_ZERO_C_CMD_ERROR_F, "PM_TX PCMD with zero length error" },
+		{ OESPI_COR_ERR_F, " oespi FIFO Correctable Error" },
+		{ ICSPI_COR_ERR_F, " icspi FIFO Correctable Error" },
+		{ ICSPI_OVFL_F, " icspi FIFO overflow" },
+		{ T7_PCMD_LEN_OVFL0_F, "PMTX channel 0 pcmd too large" },
+		{ T7_PCMD_LEN_OVFL1_F, "PMTX channel 1 pcmd too large" },
+		{ T7_PCMD_LEN_OVFL2_F, "PMTX channel 2 pcmd too large" },
+		{ PCMD_LEN_OVFL3_F, "PMTX channel 2 pcmd too large" },
+		{ T7_ZERO_C_CMD_ERROR_F, "PMTX 0-length pcmd" },
+		{ 0x00f00000, "PM_TX PCMD length larger than oespi capacity" },
+		{ 0x000f0000, "PM_TX icspi 2x FIFO Rx framing error" },
+		{ 0x0000f000, "PM_TX icspi FIFO Tx framing error" },
+		{ 0x00000f00, "PM_TX oespi FIFO Rx framing error" },
+		{ 0x000000f0, "PM_TX oespi FIFO Tx framing error" },
+		{ 0x0000000f, "PM_TX oespi 2x FIFO Tx framing error" },
+		{ 0 }
+	};
+	static const struct intr_details pmtx_int_cause_fields[] = {
+		{ PCMD_LEN_OVFL0_F, "PMTX channel 0 pcmd too large" },
+		{ PCMD_LEN_OVFL1_F, "PMTX channel 1 pcmd too large" },
+		{ PCMD_LEN_OVFL2_F, "PMTX channel 2 pcmd too large" },
+		{ ZERO_C_CMD_ERROR_F, "PMTX 0-length pcmd" },
+		{ 0x0f000000, "PMTX icspi FIFO2X Rx framing error" },
+		{ 0x00f00000, "PMTX icspi FIFO Rx framing error" },
+		{ 0x000f0000, "PMTX icspi FIFO Tx framing error" },
+		{ 0x0000f000, "PMTX oespi FIFO Rx framing error" },
+		{ 0x00000f00, "PMTX oespi FIFO Tx framing error" },
+		{ 0x000000f0, "PMTX oespi FIFO2X Tx framing error" },
+		{ OESPI_PAR_ERROR_F, "PMTX oespi parity error" },
+		{ DB_OPTIONS_PAR_ERROR_F, "PMTX db_options parity error" },
+		{ ICSPI_PAR_ERROR_F, "PMTX icspi parity error" },
+		{ C_PCMD_PAR_ERROR_F, "PMTX c_pcmd parity error" },
+		{ 0 }
+	};
+	static const struct intr_action pmtx_int_cause_actions[] = {
+		{ 0x7fffffff, -1, pmtx_dump_dbg_stats },
+		{ 0 },
+	};
+	struct intr_info pmtx_int_cause = {
+		.name = "PM_TX_INT_CAUSE",
+		.cause_reg = PM_TX_INT_CAUSE_A,
+		.enable_reg = PM_TX_INT_ENABLE_A,
+		.fatal = 0xc1ffffff,
+		.flags = 0,
+		.skip_clear = 1,
+		.details = NULL,
+		.actions = pmtx_int_cause_actions,
+	};
+	static const struct intr_details pmtx_perr_cause_details[] = {
+		{ ICSPI_OVFL_F, "icspi FIFO Overflow" },
+		{ OSPI_OVERFLOW3_TX_F, " OSPI overflow on channel 3 error." },
+		{ OSPI_OVERFLOW2_TX_F, " OSPI overflow on channel 2 error." },
+		{ OSPI_OVERFLOW1_TX_F, " OSPI overflow on channel 1 error." },
+		{ OSPI_OVERFLOW0_TX_F, " OSPI overflow on channel 0 error." },
+		{ T7_BUNDLE_LEN_OVFL_EN_F, "This bit indicates bundle_len_ovfl_err." },
+		{ T7_M_INTFPERREN_F, "This bit indicates Parity error from MA interfaces." },
+		{ T7_1_SDC_ERR_F,
+			"SDC Error reported by Check PCMD which carries CRC16 from TP-CSide." },
+		{ MC_WCNT_FIFO_PERR_F, "MC Interface Write count FIFO Parity error" },
+		{ MC_WDATA_FIFO_PERR_F, "MC Interface Write Data FIFO Parity error" },
+		{ MC_RCNT_FIFO_PERR_F, "MC Interface Read count FIFO Parity error" },
+		{ MC_RDATA_FIFO_PERR_F, "MC Interface Read Data FIFO Parity error" },
+		{ TOKEN_PAR_ERROR_F, "c_pcmd, Token FIFO par error" },
+		{ BUNDLE_LEN_PAR_ERROR_F, "oespi par error" },
+		{ OESPI_PAR_ERROR_F, "oespi par error" },
+		{ DB_OPTIONS_PAR_ERROR_F, "db_options par error" },
+		{ ICSPI_PAR_ERROR_F, "icspi par error" },
+		{ C_PCMD_TOKEN_PAR_ERROR_F, "c_pcmd par error" },
+		{ 0 }
+	};
+	static const struct intr_info pmtx_perr_cause = {
+		.name = "PM_TX_PERR_CAUSE",
+		.cause_reg = PM_TX_PERR_CAUSE_A,
+		.enable_reg = PM_TX_PERR_ENABLE_A,
+		.fatal = 0xffffffff,
+		.flags = 0,
+		.details = pmtx_perr_cause_details,
+		.actions = NULL,
+	};
+
+	bool fatal;
+
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7)
+		pmtx_int_cause.details = t7_pmtx_int_cause_fields;
+	else
+		pmtx_int_cause.details = pmtx_int_cause_fields;
+
+	fatal = t4_handle_intr(adap, &pmtx_int_cause, 0, verbose);
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7)
+		fatal |= pm_indirect_intr_handler(adap, &pmtx_perr_cause, 1, verbose);
+
+	clear_int_cause_reg(adap, &pmtx_int_cause);
+	return fatal;
+}
+
+/*
+ * PM RX interrupt handler.
+ */
+static bool pmrx_intr_handler(struct adapter *adap, int arg, bool verbose)
+{
+	static const struct intr_details t7_pmrx_int_cause_fields[] = {
+		{ MASTER_PERR_F, "PM_RX master parity error" },
+		{ 0x18000000, "PMRX ospi overflow" },
+		{ BUNDLE_LEN_OVFL_F, "PMRX bundle len FIFO overflow" },
+		{ SDC_ERR_F, "PMRX SDC error" },
+		{ ZERO_E_CMD_ERROR_F, "PMRX 0-length pcmd" },
+		{ 0x003c0000, "PMRX iespi FIFO2X Rx framing error" },
+		{ 0x0003c000, "PMRX iespi Rx framing error" },
+		{ 0x00003c00, "PMRX iespi Tx framing error" },
+		{ 0x00000300, "PMRX ocspi Rx framing error" },
+		{ 0x000000c0, "PMRX ocspi Tx framing error" },
+		{ 0x00000030, "PMRX ocspi FIFO2X Tx framing error" },
+		{ 0 }
+	};
+	static const struct intr_details pmrx_int_cause_fields[] = {
+		/* T6+ */
+		{ 0x18000000, "PMRX ospi overflow" },
+		{ MA_INTF_SDC_ERR_F, "PMRX MA interface SDC parity error" },
+		{ BUNDLE_LEN_PARERR_F, "PMRX bundle len FIFO parity error" },
+		{ BUNDLE_LEN_OVFL_F, "PMRX bundle len FIFO overflow" },
+		{ SDC_ERR_F, "PMRX SDC error" },
+
+		/* T4+ */
+		{ ZERO_E_CMD_ERROR_F, "PMRX 0-length pcmd" },
+		{ 0x003c0000, "PMRX iespi FIFO2X Rx framing error" },
+		{ 0x0003c000, "PMRX iespi Rx framing error" },
+		{ 0x00003c00, "PMRX iespi Tx framing error" },
+		{ 0x00000300, "PMRX ocspi Rx framing error" },
+		{ 0x000000c0, "PMRX ocspi Tx framing error" },
+		{ 0x00000030, "PMRX ocspi FIFO2X Tx framing error" },
+		{ OCSPI_PAR_ERROR_F, "PMRX ocspi parity error" },
+		{ DB_OPTIONS_PAR_ERROR_F, "PMRX db_options parity error" },
+		{ IESPI_PAR_ERROR_F, "PMRX iespi parity error" },
+		{ E_PCMD_PAR_ERROR_F, "PMRX e_pcmd parity error"},
+		{ 0 }
+	};
+	struct intr_info pmrx_int_cause = {
+		.name = "PM_RX_INT_CAUSE",
+		.cause_reg = PM_RX_INT_CAUSE_A,
+		.enable_reg = PM_RX_INT_ENABLE_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.skip_clear = 1,
+		.details = NULL,
+		.actions = NULL,
+	};
+	static const struct intr_details pm_rx_int_cause_2_details[] = {
+		{ CACHE_SRAM_ODD_CERR_F, "Cache Data Odd SRAM Correctable Error" },
+		{ CACHE_SRAM_EVEN_CERR_F, "Cache Data Even SRAM Correctable Error" },
+		{ CACHE_LRU_LEFT_CERR_F, "Cache LRU Left SRAM Correctable Error" },
+		{ CACHE_LRU_RIGHT_CERR_F, "Cache LRU Right SRAM Correctable Error" },
+		{ CACHE_ISLAND_CERR_F, "Cache Island SRAM Correctable Error" },
+		{ OCSPI_CERR_F, "ocspi FIFO Correctable Error" },
+		{ IESPI_CERR_F, "iespi FIFO Correctable Error" },
+		{ OCSPI2_RX_FRAMING_ERROR_F, "ocspi FIFO channel 2 Rx/wr framing error" },
+		{ OCSPI3_RX_FRAMING_ERROR_F, "ocspi FIFO channel 3 Rx/wr framing error" },
+		{ OCSPI2_TX_FRAMING_ERROR_F, "ocspi FIFO channel 2 Tx/rd framing error" },
+		{ OCSPI3_TX_FRAMING_ERROR_F, "ocspi FIFO channel 3 Tx/rd framing error" },
+		{ OCSPI2_OFIFO2X_TX_FRAMING_ERROR_F, "ocspi 2x FIFO 2 Tx/rd framing error" },
+		{ OCSPI3_OFIFO2X_TX_FRAMING_ERROR_F, "ocspi 2x FIFO 3 Tx/rd framing error" },
+		{ 0 }
+	};
+	static const struct intr_info pmrx_int_cause2 = {
+		.name = "PM_RX_INT_CAUSE_2",
+		.cause_reg = PM_RX_INT_CAUSE_2_A,
+		.enable_reg = PM_RX_INT_ENABLE_2_A,
+		.fatal = 0x0000003f,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = pm_rx_int_cause_2_details,
+		.actions = NULL,
+	};
+	static const struct intr_details pm_rx_perr_cause_details[] = {
+		{ T7_SDC_ERR_F, "SDC error. CRC provided by TP and PM didn't match." },
+		{ T7_MA_INTF_SDC_ERR_F, "MA intf SDC perr" },
+		{ E_PCMD_PERR_F, "ulp_rx 2 pm_rx PCMD interface parity error." },
+		{ CACHE_RSP_DFIFO_PERR_F, "Cache Response Data FIFO Parity error" },
+		{ CACHE_SRAM_ODD_PERR_F, "Cache Odd SRAM error" },
+		{ CACHE_SRAM_EVEN_PERR_F, "Cache Even SRAM error" },
+		{ CACHE_RSVD_PERR_F, "Cache Reserved Parity error" },
+		{ CACHE_LRU_LEFT_PERR_F, "Cache LRU Left SRAM error" },
+		{ CACHE_LRU_RIGHT_PERR_F, "Cache LRU Rigth SRAM error" },
+		{ CACHE_RSP_CMD_PERR_F, "Cache Response Command FIFO error" },
+		{ CACHE_SRAM_CMD_PERR_F, "Cache SRAM Command FIFO error" },
+		{ CACHE_MA_CMD_PERR_F, "Cache MA Command FIFO error" },
+		{ CACHE_TCAM_PERR_F, "Cache TCAM Parity error" },
+		{ CACHE_ISLAND_PERR_F, "Cache island SRAM Parity error" },
+		{ MC_WCNT_FIFO_PERR_F, "MC Interface Write count FIFO Parity error" },
+		{ MC_WDATA_FIFO_PERR_F, "MC Interface Write Data FIFO Parity error" },
+		{ MC_RCNT_FIFO_PERR_F, "MC Interface Read count FIFO Parity error" },
+		{ MC_RDATA_FIFO_PERR_F, "MC Interface Read Data FIFO Parity error" },
+		{ TOKEN_FIFO_PERR_F, "Token FIFO Parity error" },
+		{ T7_BUNDLE_LEN_PARERR_F, "Bundle len fifo had parity error." },
+		{ OCSPI_PAR_ERROR_F, "ocspi par error vector" },
+		{ DB_OPTIONS_PAR_ERROR_F, "db_options par error" },
+		{ IESPI_PAR_ERROR_F, "iespi par error" },
+		{ E_PCMD_PAR_ERROR_F, "e_pcmd par error" },
+		{ 0 }
+	};
+	static  const struct intr_info pmrx_perr_cause = {
+		.name = "PM_RX_PERR_CAUSE",
+		.cause_reg = PM_RX_PERR_CAUSE_A,
+		.enable_reg = PM_RX_PERR_ENABLE_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = pm_rx_perr_cause_details,
+		.actions = NULL,
+	};
+
+	bool fatal = false;
+
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7) {
+		pmrx_int_cause.details = t7_pmrx_int_cause_fields;
+		fatal = t4_handle_intr(adap, &pmrx_int_cause, 0, verbose);
+		fatal |= pm_indirect_intr_handler(adap, &pmrx_int_cause2, 0, verbose);
+		fatal |= pm_indirect_intr_handler(adap, &pmrx_perr_cause, 0, verbose);
+	} else {
+		pmrx_int_cause.details = pmrx_int_cause_fields;
+		fatal = t4_handle_intr(adap, &pmrx_int_cause, 0, verbose);
+	}
+
+	clear_int_cause_reg(adap, &pmrx_int_cause);
+	return fatal;
+}
+
+/*
+ * CPL switch interrupt handler.
+ */
+static bool cplsw_intr_handler(struct adapter *adap, int arg, bool verbose)
+{
+	static const struct intr_details cplsw_int_cause_fields[] = {
+		/* t7+ */
+		{ PERR_CPL_128TO128_3_F, "CPLSW 128TO128 FIFO3 parity error" },
+		{ PERR_CPL_128TO128_2_F, "CPLSW 128TO128 FIFO2 parity error" },
+		/* T5+ */
+		{ PERR_CPL_128TO128_1_F, "CPLSW 128TO128 FIFO1 parity error" },
+		{ PERR_CPL_128TO128_0_F, "CPLSW 128TO128 FIFO0 parity error" },
+
+		/* T4+ */
+		{ CIM_OP_MAP_PERR_F, "CPLSW CIM op_map parity error" },
+		{ CIM_OVFL_ERROR_F, "CPLSW CIM overflow" },
+		{ TP_FRAMING_ERROR_F, "CPLSW TP framing error" },
+		{ SGE_FRAMING_ERROR_F, "CPLSW SGE framing error" },
+		{ CIM_FRAMING_ERROR_F, "CPLSW CIM framing error" },
+		{ ZERO_SWITCH_ERROR_F, "CPLSW no-switch error" },
+		{ 0 }
+	};
+	static const struct intr_info cplsw_int_cause = {
+		.name = "CPL_INTR_CAUSE",
+		.cause_reg = CPL_INTR_CAUSE_A,
+		.enable_reg = CPL_INTR_ENABLE_A,
+		.fatal = CIM_OP_MAP_PERR_F | TP_FRAMING_ERROR_F | SGE_FRAMING_ERROR_F |
+			 CIM_FRAMING_ERROR_F | ZERO_SWITCH_ERROR_F,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = cplsw_int_cause_fields,
+		.actions = NULL,
+	};
+
+	return t4_handle_intr(adap, &cplsw_int_cause, 0, verbose);
+}
+
+#define T4_LE_FATAL_MASK (PARITYERR_F | UNKNOWNCMD_F | REQQPARERR_F)
+#define T5_LE_FATAL_MASK (T4_LE_FATAL_MASK | VFPARERR_F)
+#define T6_LE_PERRCRC_MASK (PIPELINEERR_F | CLIPTCAMACCFAIL_F | \
+			    SRVSRAMACCFAIL_F | CLCAMCRCPARERR_F | \
+			    CLCAMINTPERR_F | SSRAMINTPERR_F | \
+			    SRVSRAMPERR_F | VFSRAMPERR_F | \
+			    TCAMINTPERR_F | TCAMCRCERR_F | \
+			    HASHTBLMEMACCERR_F | MAIFWRINTPERR_F | \
+			    HASHTBLMEMCRCERR_F)
+#define T6_LE_FATAL_MASK (T6_LE_PERRCRC_MASK | T6_UNKNOWNCMD_F | \
+			  TCAMACCFAIL_F | HASHTBLACCFAIL_F | \
+			  CMDTIDERR_F | CMDPRSRINTERR_F | \
+			  TOTCNTERR_F | CLCAMFIFOERR_F | CLIPSUBERR_F)
+#define T7_LE_FATAL_MASK (T6_LE_FATAL_MASK | CACHESRAMPERR_F | CACHEINTPERR_F)
+
+/*
+ * LE interrupt handler.
+ */
+static bool le_intr_handler(struct adapter *adap, int arg, bool verbose)
+{
+	static const struct intr_details le_intr_details[] = {
+		{ REQQPARERR_F, "LE request queue parity error" },
+		{ UNKNOWNCMD_F, "LE unknown command" },
+		{ ACTRGNFULL_F, "LE active region full" },
+		{ PARITYERR_F, "LE parity error" },
+		{ LIPMISS_F, "LE LIP miss" },
+		{ LIP0_F, "LE 0 LIP error" },
+		{ 0 }
+	};
+	static const struct intr_details t6_le_intr_details[] = {
+		{ CACHEINTPERR_F, "Parity error in cache module" },
+		{ CACHESRAMPERR_F, "Parity error in data sram " },
+		{ CLIPSUBERR_F, "LE CLIP CAM reverse substitution error" },
+		{ CLCAMFIFOERR_F, "LE CLIP CAM internal FIFO error" },
+		{ CTCAMINVLDENT_F, "Invalid IPv6 CLIP TCAM entry" },
+		{ TCAMINVLDENT_F, "Invalid IPv6 TCAM entry" },
+		{ TOTCNTERR_F, "LE total active < TCAM count" },
+		{ CMDPRSRINTERR_F, "LE internal error in parser" },
+		{ CMDTIDERR_F, "Incorrect tid in LE command" },
+		{ T6_ACTRGNFULL_F, "LE active region full" },
+		{ T6_ACTCNTIPV6TZERO_F, "LE IPv6 active open TCAM counter -ve" },
+		{ T6_ACTCNTIPV4TZERO_F, "LE IPv4 active open TCAM counter -ve" },
+		{ T6_ACTCNTIPV6ZERO_F, "LE IPv6 active open counter -ve" },
+		{ T6_ACTCNTIPV4ZERO_F, "LE IPv4 active open counter -ve" },
+		{ HASHTBLACCFAIL_F, "Hash table read error (proto conflict)" },
+		{ TCAMACCFAIL_F, "LE TCAM access failure" },
+		{ T6_UNKNOWNCMD_F, "LE unknown command" },
+		{ T6_LIP0_F, "LE found 0 LIP during CLIP substitution" },
+		{ T6_LIPMISS_F, "LE CLIP lookup miss" },
+		{ T6_LE_PERRCRC_MASK, "LE parity/CRC error" },
+		{ 0 }
+	};
+	struct intr_info le_intr_info = {
+		.name = "LE_DB_INT_CAUSE",
+		.cause_reg = LE_DB_INT_CAUSE_A,
+		.enable_reg = LE_DB_INT_ENABLE_A,
+		.fatal = 0xf801fff9,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = NULL,
+		.actions = NULL,
+	};
+
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) <= CHELSIO_T5) {
+		le_intr_info.details = le_intr_details;
+		le_intr_info.fatal = T5_LE_FATAL_MASK;
+	} else {
+		le_intr_info.details = t6_le_intr_details;
+		if (CHELSIO_CHIP_VERSION(adap->params.chip) < CHELSIO_T7)
+			le_intr_info.fatal = T6_LE_FATAL_MASK;
+		else
+			le_intr_info.fatal = T7_LE_FATAL_MASK;
+	}
+
+	return t4_handle_intr(adap, &le_intr_info, 0, verbose);
+}
+
+/*
+ * MPS interrupt handler.
+ */
+static bool mps_intr_handler(struct adapter *adap, int arg, bool verbose)
+{
+	static const struct intr_details mps_rx_perr_intr_details[] = {
+		{ 0xffffffff, "MPS Rx parity error" },
+		{ 0 }
+	};
+	static const struct intr_info mps_rx_perr_intr_info = {
+		.name = "MPS_RX_PERR_INT_CAUSE",
+		.cause_reg = MPS_RX_PERR_INT_CAUSE_A,
+		.enable_reg = MPS_RX_PERR_INT_ENABLE_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = mps_rx_perr_intr_details,
+		.actions = NULL,
+	};
+	static const struct intr_details mps_rx_func_intr_details[] = {
+		{ MTU_ERR3_F, "MTU error interrupt enable bit for loopback group 3" },
+		{ MTU_ERR2_F, "MTU error interrupt enable bit for loopback group 2" },
+		{ MTU_ERR1_F, "MTU error interrupt enable bit for loopback group 1" },
+		{ MTU_ERR0_F, "MTU error interrupt enable bit for loopback group 0" },
+		{ DBG_LEN_ERR_F, "Oring of len error in traffic transfer b/w internal modules" },
+		{ DBG_SPI_ERR_F, "Oring of spi error in traffic transfer b/w internal modules" },
+		{ DBG_SE_CNT_ERR_F, "Oring of se cnt error in traffic transfer" },
+		{ DBG_SPI_LEN_SE_CNT_ERR_F, "Oring of all se_cnt|len|spi errors" },
+		{ 0 }
+	};
+	static const struct intr_info mps_rx_func_intr_info = {
+		.name = "MPS_RX_FUNC_INT_CAUSE",
+		.cause_reg = MPS_RX_FUNC_INT_CAUSE_A,
+		.enable_reg = MPS_RX_FUNC_INT_ENABLE_A,
+		.fatal = 0,
+		.flags = 0,
+		.details = mps_rx_func_intr_details,
+		.actions = NULL,
+	};
+	static const struct intr_details mpsrx_int_cause_2_details[] = {
+		{ CRYPTO2MPS_RX0_PERR_F | CRYPTO2MPS_RX1_PERR_F |
+			CRYPTO2MPS_RX2_PERR_F | CRYPTO2MPS_RX3_PERR_F,
+			"Crypto to MPS RX interface parity error" },
+		{ INIC2MPS_TX1_PERR_F | INIC2MPS_TX0_PERR_F,
+			"INIC to MPS TX interface parity error" },
+		{ XGMAC2MPS_RX1_PERR_F | XGMAC2MPS_RX0_PERR_F,
+			"XGMAC to MPS RX interface parity error" },
+		{ RX_FINAL_TF_FIFO_PERR_F,
+			"Final RX token FIFO output parity error" },
+		{ MPS_DWRR_FIFO_PERR_F,
+			"MPS DWRR MTU FIFO parity error" },
+		{ MAC_TF_FIFO_PERR_F,
+			"MAC token FIFO parity error" },
+		{ MAC2MPS_PT3_PERR_F | MAC2MPS_PT2_PERR_F |
+			MAC2MPS_PT1_PERR_F | MAC2MPS_PT0_PERR_F,
+			"MAC to MPS interface parity error" },
+		{ TP_LPBK_FIFO_PERR_F, "TP loopback FIFO parity error" },
+		{ TP_LPBK_TF_PERR_F, "Loopback token FIFO parity error" },
+		{ 0 }
+	};
+	static const struct intr_info mps_rx_perr_intr_info2 = {
+		.name = "MPS_RX_PERR_INT_CAUSE2",
+		.cause_reg = MPS_RX_PERR_INT_CAUSE2_A,
+		.enable_reg = MPS_RX_PERR_INT_ENABLE2_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = mpsrx_int_cause_2_details,
+		.actions = NULL,
+	};
+	static const struct intr_details mpsrx_int_cause_3_details[] = {
+		{ FIFO_REPL_CH3_CERR_F | FIFO_REPL_CH2_CERR_F |
+		  FIFO_REPL_CH1_CERR_F | FIFO_REPL_CH0_CERR_F,
+		  "Replication FIFO ECC error" },
+		{ VLAN_FILTER_RAM_CERR_F, "VLAN filter SRAM ECC error" },
+		{ MPS_RX_TD_STAT_FIFO_PERR_CH3_F | MPS_RX_TD_STAT_FIFO_PERR_CH2_F |
+		  MPS_RX_TD_STAT_FIFO_PERR_CH1_F | MPS_RX_TD_STAT_FIFO_PERR_CH0_F,
+		  "MPS RX TD status descriptor FIFO parity error" },
+		{ RPLCT_HDR_FIFO_IN_PERR_CH3_F | RPLCT_HDR_FIFO_IN_PERR_CH2_F |
+		  RPLCT_HDR_FIFO_IN_PERR_CH1_F | RPLCT_HDR_FIFO_IN_PERR_CH0_F,
+		  "MPS RX replication header input FIFO parity error" },
+		{ ID_FIFO_IN_PERR_CH3_F | ID_FIFO_IN_PERR_CH2_F |
+		  ID_FIFO_IN_PERR_CH1_F | ID_FIFO_IN_PERR_CH0_F,
+		  "MPS RX replication ID input FIFO parity error" },
+		{ DESC_HDR2_PERR_CH3_F | DESC_HDR2_PERR_CH2_F |
+		  DESC_HDR2_PERR_CH1_F | DESC_HDR2_PERR_CH0_F,
+		  "MPS RX replication descriptor/header2 FIFO parity error" },
+		{ FIFO_REPL_PERR_CH3_F | FIFO_REPL_PERR_CH2_F |
+		  FIFO_REPL_PERR_CH1_F | FIFO_REPL_PERR_CH0_F,
+		  "Replication FIFO parity error" },
+		{ MPS_RX_TD_PERR_CH3_F | MPS_RX_TD_PERR_CH2_F |
+		  MPS_RX_TD_PERR_CH1_F | MPS_RX_TD_PERR_CH0_F,
+		  "MPS RX TD input FIFO parity error" },
+		{ 0 }
+	};
+	static const struct intr_info mps_rx_perr_intr_info3 = {
+		.name = "MPS_RX_PERR_INT_CAUSE3",
+		.cause_reg = MPS_RX_PERR_INT_CAUSE3_A,
+		.enable_reg = MPS_RX_PERR_INT_ENABLE3_A,
+		.fatal = 0x00ffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = mpsrx_int_cause_3_details,
+		.actions = NULL,
+	};
+	static const struct intr_details mpsrx_int_cause_4_details[] = {
+		{ VNI_MULTICAST_FIFO_ECC_ERR_CH3_F | VNI_MULTICAST_FIFO_ECC_ERR_CH2_F,
+		  "RX out VNI multicast SRAM ECC error" },
+		{ HASH_SRAM_CLS_ENG1_F | HASH_SRAM_CLS_ENG0_F,
+		  "Classification engine hash SRAM ECC error" },
+		{ CLS_TCAM_SRAM_CLS_ENG1_F | CLS_TCAM_SRAM_CLS_ENG0_F,
+		  "Classification engine TCAM SRAM ECC error" },
+		{ CLS_TCAM_CRC_SRAM_CLS_ENG1_F | CLS_TCAM_CRC_SRAM_CLS_ENG0_F,
+		  "Classification engine TCAM CRC SRAM ECC error" },
+		{ DWRR_CH_FIFO_ECC_ERR_F, "DWRR output FIFO ECC error" },
+		{ MAC_RX_FIFO_ECC_ERR_F, "MAC RX FIFO ECC error" },
+		{ LPBK_RX_FIFO_ECC_ERR_F, "Loopback RX FIFO ECC error" },
+		{ CRS_DATA_STORE_N_FWD_CH3_F | CRS_DATA_STORE_N_FWD_CH2_F |
+		  CRS_DATA_STORE_N_FWD_CH1_F | CRS_DATA_STORE_N_FWD_CH0_F,
+		  "CRS store and forward FIFO ECC error" },
+		{ TRACE_FWD_FIFO_CERR_CH3_F | TRACE_FWD_FIFO_CERR_CH2_F |
+		  TRACE_FWD_FIFO_CERR_CH1_F | TRACE_FWD_FIFO_CERR_CH0_F,
+		  "Trace packet forward FIFO ECC error" },
+		{ TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH3_F | TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH2_F |
+		  TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH1_F | TRANSPARENT_ENCAP_FWD_FIFO_CERR_CH0_F,
+		  "Transparent encap forward FIFO ECC error" },
+		{ PTP_TRACE_FWD_FIFO_CERR_CH3_F | PTP_TRACE_FWD_FIFO_CERR_CH2_F |
+		  PTP_TRACE_FWD_FIFO_CERR_CH1_F | PTP_TRACE_FWD_FIFO_CERR_CH0_F,
+		  "PTP packet forward FIFO ECC error" },
+		{ 0 }
+	};
+	static const struct intr_info mps_rx_perr_intr_info4 = {
+		.name = "MPS_RX_PERR_INT_CAUSE4",
+		.cause_reg = MPS_RX_PERR_INT_CAUSE4_A,
+		.enable_reg = MPS_RX_PERR_INT_ENABLE4_A,
+		.fatal = 0,
+		.flags = 0,
+		.details = mpsrx_int_cause_4_details,
+		.actions = NULL,
+	};
+	static const struct intr_details mpsrx_int_cause_5_details[] = {
+		{ MPS2CRYP_RX_FIFO3_PERR_F | MPS2CRYP_RX_FIFO2_PERR_F |
+		  MPS2CRYP_RX_FIFO1_PERR_F | MPS2CRYP_RX_FIFO0_PERR_F,
+		  "MPS to Crypto RX interface FIFO parity error" },
+		{ VNI_MULTICAST_SRAM2_PERR_F | VNI_MULTICAST_SRAM1_PERR_F |
+		  VNI_MULTICAST_SRAM0_PERR_F,
+		  "VNI multicast SRAM parity error" },
+		{ MAC_MULTICAST_SRAM4_PERR_F | MAC_MULTICAST_SRAM3_PERR_F |
+		  MAC_MULTICAST_SRAM2_PERR_F | MAC_MULTICAST_SRAM1_PERR_F |
+		  MAC_MULTICAST_SRAM0_PERR_F,
+		  "MAC multicast SRAM parity error" },
+		{ MEM_WRAP_IPSEC_HDR_UPD_FIFO3_PERR_F | MEM_WRAP_IPSEC_HDR_UPD_FIFO2_PERR_F |
+		  MEM_WRAP_IPSEC_HDR_UPD_FIFO1_PERR_F | MEM_WRAP_IPSEC_HDR_UPD_FIFO0_PERR_F,
+		  "IPsec header update storing FIFO parity error" },
+		{ MEM_WRAP_CR2MPS_RX_FIFO3_PERR_F | MEM_WRAP_CR2MPS_RX_FIFO2_PERR_F |
+		  MEM_WRAP_CR2MPS_RX_FIFO1_PERR_F | MEM_WRAP_CR2MPS_RX_FIFO0_PERR_F,
+		  "IPsec storing FIFO parity error" },
+		{ MEM_WRAP_NON_IPSEC_FIFO3_PERR_F | MEM_WRAP_NON_IPSEC_FIFO2_PERR_F |
+		  MEM_WRAP_NON_IPSEC_FIFO1_PERR_F | MEM_WRAP_NON_IPSEC_FIFO0_PERR_F,
+		  "Non-IPsec storing FIFO parity error" },
+		{ MEM_WRAP_TP_DB_REQ_FIFO3_PERR_F | MEM_WRAP_TP_DB_REQ_FIFO2_PERR_F |
+		  MEM_WRAP_TP_DB_REQ_FIFO1_PERR_F | MEM_WRAP_TP_DB_REQ_FIFO0_PERR_F,
+		  "TP DB request storing FIFO parity error" },
+		{ MEM_WRAP_CNTRL_FIFO3_PERR_F | MEM_WRAP_CNTRL_FIFO2_PERR_F |
+		  MEM_WRAP_CNTRL_FIFO1_PERR_F | MEM_WRAP_CNTRL_FIFO0_PERR_F,
+		  "Header flit storing FIFO parity error" },
+		{ 0 }
+	};
+	static const struct intr_info mps_rx_perr_intr_info5 = {
+		.name = "MPS_RX_PERR_INT_CAUSE5",
+		.cause_reg = MPS_RX_PERR_INT_CAUSE5_A,
+		.enable_reg = MPS_RX_PERR_INT_ENABLE5_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = mpsrx_int_cause_5_details,
+		.actions = NULL,
+	};
+	static const struct intr_details mpsrx_int_cause_6_details[] = {
+		{ T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO3_PERR_F | T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO2_PERR_F |
+		  T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO1_PERR_F | T7_MEM_WRAP_IPSEC_HDR_UPD_FIFO0_PERR_F,
+		  "IPsec header update storing FIFO parity error" },
+		{ MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO3_PERR_F | MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO2_PERR_F |
+		  MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO1_PERR_F | MEM_WRAP_CR2MPS_UPDTD_HDR_FIFO0_PERR_F,
+		  "IPsec updated header only storing FIFO parity error" },
+		{ MEM_WRAP_CR2MPS_RX_FIFO3_PERR_F | MEM_WRAP_CR2MPS_RX_FIFO2_PERR_F |
+		  MEM_WRAP_CR2MPS_RX_FIFO1_PERR_F | MEM_WRAP_CR2MPS_RX_FIFO0_PERR_F,
+		  "IPsec storing FIFO parity error" },
+		{ MEM_WRAP_NON_IPSEC_FIFO3_PERR_F | MEM_WRAP_NON_IPSEC_FIFO2_PERR_F |
+		  MEM_WRAP_NON_IPSEC_FIFO1_PERR_F | MEM_WRAP_NON_IPSEC_FIFO0_PERR_F,
+		  "Non-IPsec storing FIFO parity error" },
+		{ MEM_WRAP_TP_DB_REQ_FIFO3_PERR_F | MEM_WRAP_TP_DB_REQ_FIFO2_PERR_F |
+		  MEM_WRAP_TP_DB_REQ_FIFO1_PERR_F | MEM_WRAP_TP_DB_REQ_FIFO0_PERR_F,
+		  "TP DB request storing FIFO parity error" },
+		{ MEM_WRAP_CNTRL_FIFO3_PERR_F | MEM_WRAP_CNTRL_FIFO2_PERR_F |
+		  MEM_WRAP_CNTRL_FIFO1_PERR_F | MEM_WRAP_CNTRL_FIFO0_PERR_F,
+		  "Header flit storing FIFO parity error" },
+		{ 0 }
+	};
+	static const struct intr_info mps_rx_perr_intr_info6 = {
+		.name = "MPS_RX_PERR_INT_CAUSE6",
+		.cause_reg = MPS_RX_PERR_INT_CAUSE6_A,
+		.enable_reg = MPS_RX_PERR_INT_ENABLE6_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = mpsrx_int_cause_6_details,
+		.actions = NULL,
+	};
+	static const struct intr_details t7_mpstx_int_cause_details[] = {
+		{ T7_PORTERR_F, "Tx received a frame for TP destined to a disable port" },
+		{ T7_FRMERR_F, "Framing error in received Data from TP or  Data to MAC" },
+		{ T7_SECNTERR_F, "SOP-EOP count error in received Data from TP or Data to MAC" },
+		{ T7_BUBBLE_F, "Valid is deasserted between SOP and EOP" },
+		{ TX_TF_FIFO_PERR_F, "Parity error of TX token fifo" },
+		{ TX_FIFO_PERR_F, "Parity error of TX MPS2MAC underrun fifo" },
+		{ 0x0003c000, "Parity error of fifo storing non-ipsec +1 flit ipsec pkt" },
+		{ 0x00003fc0, "Interface parity error on TP/Crypto to MPS TX" },
+		{ NCSI2MPS_F, "interface Parity Error on ncsi2mps_tx_ch3" },
+		{ NCSIFIFO_F, "Parity Error in mps_tx_arbiter input FIFO (from NCSI)" },
+		{ 0x0000000f, "Parity Error in mps_tx_arbiter input FIFO (from TP)" },
+		{ 0 }
+	};
+	static const struct intr_details mps_tx_intr_details[] = {
+		{ PORTERR_F, "MPS Tx destination port is disabled" },
+		{ FRMERR_F, "MPS Tx framing error" },
+		{ SECNTERR_F, "MPS Tx SOP/EOP error" },
+		{ BUBBLE_F, "MPS Tx underflow" },
+		{ TXDESCFIFO_V(TXDESCFIFO_M), "MPS Tx desc FIFO parity error" },
+		{ TXDATAFIFO_V(TXDATAFIFO_M), "MPS Tx data FIFO parity error" },
+		{ NCSIFIFO_F, "MPS Tx NC-SI FIFO parity error" },
+		{ TPFIFO_V(TPFIFO_M), "MPS Tx TP FIFO parity error" },
+		{ 0 }
+	};
+	struct intr_info mps_tx_intr_info = {
+		.name = "MPS_TX_INT_CAUSE",
+		.cause_reg = MPS_TX_INT_CAUSE_A,
+		.enable_reg = MPS_TX_INT_ENABLE_A,
+		.fatal = 0x0fffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = NULL,
+		.actions = NULL,
+	};
+	static const struct intr_details mpstx_int_cause_2_details[] = {
+		{ TX_FIFO_PERR_F, "ECC error of TX MPS2MAC underrun fifo" },
+		{ 0x0000000f, "ECC error of fifo storing non-ipsec +1 flit ipsec pkt" },
 		{ 0 }
 	};
-	static const struct intr_info pcie_port_intr_info[] = {
-		{ TPCP_F, "TXPC array parity error", -1, 1 },
-		{ TNPP_F, "TXNP array parity error", -1, 1 },
-		{ TFTP_F, "TXFT array parity error", -1, 1 },
-		{ TCAP_F, "TXCA array parity error", -1, 1 },
-		{ TCIP_F, "TXCIF array parity error", -1, 1 },
-		{ RCAP_F, "RXCA array parity error", -1, 1 },
-		{ OTDD_F, "outbound request TLP discarded", -1, 1 },
-		{ RDPE_F, "Rx data parity error", -1, 1 },
-		{ TDUE_F, "Tx uncorrectable data error", -1, 1 },
+	static const struct intr_info mps_tx_intr_info2 = {
+		.name = "MPS_TX_INT2_CAUSE",
+		.cause_reg = MPS_TX_INT2_CAUSE_A,
+		.enable_reg = MPS_TX_INT2_ENABLE_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = mpstx_int_cause_2_details,
+		.actions = NULL,
+	};
+	static const struct intr_info mps_tx_intr_info3 = {
+		.name = "MPS_TX_INT3_CAUSE",
+		.cause_reg = MPS_TX_INT3_CAUSE_A,
+		.enable_reg = MPS_TX_INT3_ENABLE_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = NULL,
+		.actions = NULL,
+	};
+	static const struct intr_info mps_tx_intr_info4 = {
+		.name = "MPS_TX_INT4_CAUSE",
+		.cause_reg = MPS_TX_INT4_CAUSE_A,
+		.enable_reg = MPS_TX_INT4_ENABLE_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = NULL,
+		.actions = NULL,
+	};
+	static const struct intr_details mps_trc_intr_details[] = {
+		{ MISCPERR_F, "MPS TRC misc parity error" },
+		{ PKTFIFO_V(PKTFIFO_M), "MPS TRC packet FIFO parity error" },
+		{ FILTMEM_V(FILTMEM_M), "MPS TRC filter parity error" },
+		{ 0 }
+	};
+	static const struct intr_info mps_trc_intr_info = {
+		.name = "MPS_TRC_INT_CAUSE",
+		.cause_reg = MPS_TRC_INT_CAUSE_A,
+		.enable_reg = MPS_TRC_INT_ENABLE_A,
+		.fatal = MISCPERR_F | PKTFIFO_V(PKTFIFO_M) | FILTMEM_V(FILTMEM_M),
+		.flags = NONFATAL_IF_DISABLED,
+		.details = mps_trc_intr_details,
+		.actions = NULL,
+	};
+	static const struct intr_details t7_mps_trc_intr_details[] = {
+		{ T7_TRCPLERRENB_F, "TRC PL error" },
+		{ T7_MISCPERR_F, "TRC header register parity error" },
+		{ 0x0000ff00, "TRC packet FIFO parity error" },
+		{ 0x000000ff, "TRC filter memory parity error" },
 		{ 0 }
 	};
-	static const struct intr_info pcie_intr_info[] = {
-		{ MSIADDRLPERR_F, "MSI AddrL parity error", -1, 1 },
-		{ MSIADDRHPERR_F, "MSI AddrH parity error", -1, 1 },
-		{ MSIDATAPERR_F, "MSI data parity error", -1, 1 },
-		{ MSIXADDRLPERR_F, "MSI-X AddrL parity error", -1, 1 },
-		{ MSIXADDRHPERR_F, "MSI-X AddrH parity error", -1, 1 },
-		{ MSIXDATAPERR_F, "MSI-X data parity error", -1, 1 },
-		{ MSIXDIPERR_F, "MSI-X DI parity error", -1, 1 },
-		{ PIOCPLPERR_F, "PCI PIO completion FIFO parity error", -1, 1 },
-		{ PIOREQPERR_F, "PCI PIO request FIFO parity error", -1, 1 },
-		{ TARTAGPERR_F, "PCI PCI target tag FIFO parity error", -1, 1 },
-		{ CCNTPERR_F, "PCI CMD channel count parity error", -1, 1 },
-		{ CREQPERR_F, "PCI CMD channel request parity error", -1, 1 },
-		{ CRSPPERR_F, "PCI CMD channel response parity error", -1, 1 },
-		{ DCNTPERR_F, "PCI DMA channel count parity error", -1, 1 },
-		{ DREQPERR_F, "PCI DMA channel request parity error", -1, 1 },
-		{ DRSPPERR_F, "PCI DMA channel response parity error", -1, 1 },
-		{ HCNTPERR_F, "PCI HMA channel count parity error", -1, 1 },
-		{ HREQPERR_F, "PCI HMA channel request parity error", -1, 1 },
-		{ HRSPPERR_F, "PCI HMA channel response parity error", -1, 1 },
-		{ CFGSNPPERR_F, "PCI config snoop FIFO parity error", -1, 1 },
-		{ FIDPERR_F, "PCI FID parity error", -1, 1 },
-		{ INTXCLRPERR_F, "PCI INTx clear parity error", -1, 1 },
-		{ MATAGPERR_F, "PCI MA tag parity error", -1, 1 },
-		{ PIOTAGPERR_F, "PCI PIO tag parity error", -1, 1 },
-		{ RXCPLPERR_F, "PCI Rx completion parity error", -1, 1 },
-		{ RXWRPERR_F, "PCI Rx write parity error", -1, 1 },
-		{ RPLPERR_F, "PCI replay buffer parity error", -1, 1 },
-		{ PCIESINT_F, "PCI core secondary fault", -1, 1 },
-		{ PCIEPINT_F, "PCI core primary fault", -1, 1 },
-		{ UNXSPLCPLERR_F, "PCI unexpected split completion error",
-		  -1, 0 },
+	static const struct intr_info t7_mps_trc_intr_info = {
+		.name = "MPS_TRC_INT_CAUSE",
+		.cause_reg = T7_MPS_TRC_INT_CAUSE_A,
+		.enable_reg = T7_MPS_TRC_INT_ENABLE_A,
+		.fatal = T7_TRCPLERRENB_F | T7_MISCPERR_F | PKTFIFO_V(PKTFIFO_M) |
+			 FILTMEM_V(FILTMEM_M),
+		.flags = NONFATAL_IF_DISABLED,
+		.details = t7_mps_trc_intr_details,
+		.actions = NULL,
+	};
+	static const struct intr_details t7_trc_int_cause2_details[] = {
+		{ 0x0001e000, "TRC Tx2Rx down-converter correctable error" },
+		{ 0x00001800, "TRC MPS2MAC down-converter correctable error" },
+		{ 0x00000600, "TRC MAC2MPS down-converter correctable error" },
+		{ 0x000001e0, "TRC Tx2Rx down-converter parity error" },
+		{ 0x00000018, "TRC MAC2MPS down-converter parity error" },
+		{ 0x00000006, "TRC MPS2MAC down-converter parity error" },
 		{ 0 }
 	};
-
-	static struct intr_info t5_pcie_intr_info[] = {
-		{ MSTGRPPERR_F, "Master Response Read Queue parity error",
-		  -1, 1 },
-		{ MSTTIMEOUTPERR_F, "Master Timeout FIFO parity error", -1, 1 },
-		{ MSIXSTIPERR_F, "MSI-X STI SRAM parity error", -1, 1 },
-		{ MSIXADDRLPERR_F, "MSI-X AddrL parity error", -1, 1 },
-		{ MSIXADDRHPERR_F, "MSI-X AddrH parity error", -1, 1 },
-		{ MSIXDATAPERR_F, "MSI-X data parity error", -1, 1 },
-		{ MSIXDIPERR_F, "MSI-X DI parity error", -1, 1 },
-		{ PIOCPLGRPPERR_F, "PCI PIO completion Group FIFO parity error",
-		  -1, 1 },
-		{ PIOREQGRPPERR_F, "PCI PIO request Group FIFO parity error",
-		  -1, 1 },
-		{ TARTAGPERR_F, "PCI PCI target tag FIFO parity error", -1, 1 },
-		{ MSTTAGQPERR_F, "PCI master tag queue parity error", -1, 1 },
-		{ CREQPERR_F, "PCI CMD channel request parity error", -1, 1 },
-		{ CRSPPERR_F, "PCI CMD channel response parity error", -1, 1 },
-		{ DREQWRPERR_F, "PCI DMA channel write request parity error",
-		  -1, 1 },
-		{ DREQPERR_F, "PCI DMA channel request parity error", -1, 1 },
-		{ DRSPPERR_F, "PCI DMA channel response parity error", -1, 1 },
-		{ HREQWRPERR_F, "PCI HMA channel count parity error", -1, 1 },
-		{ HREQPERR_F, "PCI HMA channel request parity error", -1, 1 },
-		{ HRSPPERR_F, "PCI HMA channel response parity error", -1, 1 },
-		{ CFGSNPPERR_F, "PCI config snoop FIFO parity error", -1, 1 },
-		{ FIDPERR_F, "PCI FID parity error", -1, 1 },
-		{ VFIDPERR_F, "PCI INTx clear parity error", -1, 1 },
-		{ MAGRPPERR_F, "PCI MA group FIFO parity error", -1, 1 },
-		{ PIOTAGPERR_F, "PCI PIO tag parity error", -1, 1 },
-		{ IPRXHDRGRPPERR_F, "PCI IP Rx header group parity error",
-		  -1, 1 },
-		{ IPRXDATAGRPPERR_F, "PCI IP Rx data group parity error",
-		  -1, 1 },
-		{ RPLPERR_F, "PCI IP replay buffer parity error", -1, 1 },
-		{ IPSOTPERR_F, "PCI IP SOT buffer parity error", -1, 1 },
-		{ TRGT1GRPPERR_F, "PCI TRGT1 group FIFOs parity error", -1, 1 },
-		{ READRSPERR_F, "Outbound read error", -1, 0 },
+	static const struct intr_info t7_mps_trc_intr_info2 = {
+		.name = "MPS_TRC_INT_CAUSE2",
+		.cause_reg = MPS_TRC_INT_CAUSE2_A,
+		.enable_reg = MPS_TRC_INT_ENABLE2_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = t7_trc_int_cause2_details,
+		.actions = NULL,
+	};
+	static const struct intr_details mps_stat_intr_details[] = {
+		{ PLREADSYNCERR_F, "MPS pl read sync error" },
+		{ 0 }
+	};
+	static const struct intr_info mps_stat_intr_info = {
+		.name = "MPS_STAT_INT_CAUSE",
+		.cause_reg = MPS_STAT_INT_CAUSE_A,
+		.enable_reg = MPS_STAT_INT_ENABLE_A,
+		.fatal = 0,
+		.flags = 0,
+		.details = mps_stat_intr_details,
+		.actions = NULL,
+	};
+	static const struct intr_details mps_stat_sram_intr_details[] = {
+		{ 0xffffffff, "MPS statistics SRAM parity error" },
+		{ 0 }
+	};
+	static const struct intr_info mps_stat_sram_intr_info = {
+		.name = "MPS_STAT_PERR_INT_CAUSE_SRAM",
+		.cause_reg = MPS_STAT_PERR_INT_CAUSE_SRAM_A,
+		.enable_reg = MPS_STAT_PERR_INT_ENABLE_SRAM_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = mps_stat_sram_intr_details,
+		.actions = NULL,
+	};
+	static const struct intr_details mps_stat_tx_intr_details[] = {
+		{ 0xffffff, "MPS statistics Tx FIFO parity error" },
+		{ 0 }
+	};
+	static const struct intr_info mps_stat_tx_intr_info = {
+		.name = "MPS_STAT_PERR_INT_CAUSE_TX_FIFO",
+		.cause_reg = MPS_STAT_PERR_INT_CAUSE_TX_FIFO_A,
+		.enable_reg = MPS_STAT_PERR_INT_ENABLE_TX_FIFO_A,
+		.fatal = 0xffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = mps_stat_tx_intr_details,
+		.actions = NULL,
+	};
+	static const struct intr_details mps_stat_rx_intr_details[] = {
+		{ 0xffffff, "MPS statistics Rx FIFO parity error" },
+		{ 0 }
+	};
+	static const struct intr_info mps_stat_rx_intr_info = {
+		.name = "MPS_STAT_PERR_INT_CAUSE_RX_FIFO",
+		.cause_reg = MPS_STAT_PERR_INT_CAUSE_RX_FIFO_A,
+		.enable_reg = MPS_STAT_PERR_INT_ENABLE_RX_FIFO_A,
+		.fatal = 0xffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = mps_stat_rx_intr_details,
+		.actions = NULL,
+	};
+	static const struct intr_details mps_cls_intr_details[] = {
+		{ T7_PLERRENB_F, "PL error"},
+		{ CIM2MPS_INTF_PAR_F, "cim2mps interface parity"},
+		{ TCAM_CRC_SRAM_F, "tcam crc sram parity error"},
+		{ HASHSRAM_F, "MPS hash SRAM parity error" },
+		{ MATCHTCAM_F, "MPS match TCAM parity error" },
+		{ MATCHSRAM_F, "MPS match SRAM parity error" },
+		{ 0 }
+	};
+	static const struct intr_info mps_cls_intr_info = {
+		.name = "MPS_CLS_INT_CAUSE",
+		.cause_reg = MPS_CLS_INT_CAUSE_A,
+		.enable_reg = MPS_CLS_INT_ENABLE_A,
+		.fatal = MATCHSRAM_F | MATCHTCAM_F | HASHSRAM_F,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = mps_cls_intr_details,
+		.actions = NULL,
+	};
+	static const struct intr_details mps_stat_sram1_intr_details[] = {
+		{ 0xff, "MPS statistics SRAM1 parity error" },
 		{ 0 }
 	};
+	static const struct intr_info mps_stat_sram1_intr_info = {
+		.name = "MPS_STAT_PERR_INT_CAUSE_SRAM1",
+		.cause_reg = MPS_STAT_PERR_INT_CAUSE_SRAM1_A,
+		.enable_reg = MPS_STAT_PERR_INT_ENABLE_SRAM1_A,
+		.fatal = 0xffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = mps_stat_sram1_intr_details,
+		.actions = NULL,
+	};
 
-	int fat;
+	bool fatal = false;
 
-	if (is_t4(adapter->params.chip))
-		fat = t4_handle_intr_status(adapter,
-				PCIE_CORE_UTL_SYSTEM_BUS_AGENT_STATUS_A,
-				sysbus_intr_info) +
-			t4_handle_intr_status(adapter,
-					PCIE_CORE_UTL_PCI_EXPRESS_PORT_STATUS_A,
-					pcie_port_intr_info) +
-			t4_handle_intr_status(adapter, PCIE_INT_CAUSE_A,
-					      pcie_intr_info);
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7)
+		mps_tx_intr_info.details = t7_mpstx_int_cause_details;
 	else
-		fat = t4_handle_intr_status(adapter, PCIE_INT_CAUSE_A,
-					    t5_pcie_intr_info);
+		mps_tx_intr_info.details = mps_tx_intr_details;
+
+	fatal |= t4_handle_intr(adap, &mps_rx_perr_intr_info, 0, verbose);
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) > CHELSIO_T6) {
+		fatal |= t4_handle_intr(adap, &mps_rx_func_intr_info, 0, verbose);
+		fatal |= t4_handle_intr(adap, &mps_rx_perr_intr_info2, 0, verbose);
+		fatal |= t4_handle_intr(adap, &mps_rx_perr_intr_info3, 0, verbose);
+		fatal |= t4_handle_intr(adap, &mps_rx_perr_intr_info4, 0, verbose);
+		fatal |= t4_handle_intr(adap, &mps_rx_perr_intr_info5, 0, verbose);
+		fatal |= t4_handle_intr(adap, &mps_rx_perr_intr_info6, 0, verbose);
+	}
+	fatal |= t4_handle_intr(adap, &mps_tx_intr_info, 0, verbose);
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) > CHELSIO_T6) {
+		fatal |= t4_handle_intr(adap, &mps_tx_intr_info2, 0, verbose);
+		fatal |= t4_handle_intr(adap, &mps_tx_intr_info3, 0, verbose);
+		fatal |= t4_handle_intr(adap, &mps_tx_intr_info4, 0, verbose);
+		fatal |= t4_handle_intr(adap, &t7_mps_trc_intr_info, 0, verbose);
+		fatal |= t4_handle_intr(adap, &t7_mps_trc_intr_info2, 0, verbose);
+	} else {
+		fatal |= t4_handle_intr(adap, &mps_trc_intr_info, 0, verbose);
+	}
+	fatal |= t4_handle_intr(adap, &mps_stat_intr_info, 0, verbose);
+	fatal |= t4_handle_intr(adap, &mps_stat_sram_intr_info, 0, verbose);
+	fatal |= t4_handle_intr(adap, &mps_stat_tx_intr_info, 0, verbose);
+	fatal |= t4_handle_intr(adap, &mps_stat_rx_intr_info, 0, verbose);
+	fatal |= t4_handle_intr(adap, &mps_cls_intr_info, 0, verbose);
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) > CHELSIO_T4) {
+		fatal |= t4_handle_intr(adap, &mps_stat_sram1_intr_info, 0,
+				verbose);
+	}
 
-	if (fat)
-		t4_fatal_err(adapter);
+	t4_write_reg(adap, MPS_INT_CAUSE_A, is_t4(adap->params.chip) ? 0 :
+		     t4_read_reg(adap, MPS_INT_CAUSE_A));
+	t4_read_reg(adap, MPS_INT_CAUSE_A);     /* flush */
+
+	return fatal;
 }
 
-/*
- * TP interrupt handler.
+/**
+ *	t4_ddr_indirect_rw - read indirectly ddr register
+ *	@adap: adapter
+ *	@vals: where the read register values are stored
+ *	@reg : indirect register to read
+ *	@idx : index of MC - (0/1)
+ *	@rw : 0 - read, 1 - write
  */
-static void tp_intr_handler(struct adapter *adapter)
+static void t4_ddr_indirect_rw(struct adapter *adap, u32 *vals, unsigned int reg, int idx,
+			       bool rw)
 {
-	static const struct intr_info tp_intr_info[] = {
-		{ 0x3fffffff, "TP parity error", -1, 1 },
-		{ FLMTXFLSTEMPTY_F, "TP out of Tx pages", -1, 1 },
-		{ 0 }
-	};
+	unsigned int addr_reg, data_reg;
 
-	if (t4_handle_intr_status(adapter, TP_INT_CAUSE_A, tp_intr_info))
-		t4_fatal_err(adapter);
+	addr_reg = MC_T7_REG(MC_IND_ADDR_A, idx);
+	data_reg = MC_T7_REG(MC_IND_DATA_A, idx);
+
+	t4_write_reg(adap, addr_reg, reg);
+
+	if (rw)
+		t4_write_reg(adap, data_reg, *vals);
+	else
+		*vals = t4_read_reg(adap, data_reg);
 }
 
-/*
- * SGE interrupt handler.
- */
-static void sge_intr_handler(struct adapter *adapter)
+static bool mc_ddrphy_intr_handler(struct adapter *adap, int idx, bool verbose)
 {
-	u32 v = 0, perr;
-	u32 err;
+	char rname[32];
+	u32 status, enable, mask, fatal;
 
-	static const struct intr_info sge_intr_info[] = {
-		{ ERR_CPL_EXCEED_IQE_SIZE_F,
-		  "SGE received CPL exceeding IQE size", -1, 1 },
-		{ ERR_INVALID_CIDX_INC_F,
-		  "SGE GTS CIDX increment too large", -1, 0 },
-		{ ERR_CPL_OPCODE_0_F, "SGE received 0-length CPL", -1, 0 },
-		{ DBFIFO_LP_INT_F, NULL, -1, 0, t4_db_full },
-		{ ERR_DATA_CPL_ON_HIGH_QID1_F | ERR_DATA_CPL_ON_HIGH_QID0_F,
-		  "SGE IQID > 1023 received CPL for FL", -1, 0 },
-		{ ERR_BAD_DB_PIDX3_F, "SGE DBP 3 pidx increment too large", -1,
-		  0 },
-		{ ERR_BAD_DB_PIDX2_F, "SGE DBP 2 pidx increment too large", -1,
-		  0 },
-		{ ERR_BAD_DB_PIDX1_F, "SGE DBP 1 pidx increment too large", -1,
-		  0 },
-		{ ERR_BAD_DB_PIDX0_F, "SGE DBP 0 pidx increment too large", -1,
-		  0 },
-		{ ERR_ING_CTXT_PRIO_F,
-		  "SGE too many priority ingress contexts", -1, 0 },
-		{ INGRESS_SIZE_ERR_F, "SGE illegal ingress QID", -1, 0 },
-		{ EGRESS_SIZE_ERR_F, "SGE illegal egress QID", -1, 0 },
-		{ 0 }
+	struct intr_info ii = {
+		.name = &rname[0],
+		.fatal = 0xffffff,
+		.details = NULL,
+		.actions = NULL,
 	};
 
-	static struct intr_info t4t5_sge_intr_info[] = {
-		{ ERR_DROPPED_DB_F, NULL, -1, 0, t4_db_dropped },
-		{ DBFIFO_HP_INT_F, NULL, -1, 0, t4_db_full },
-		{ ERR_EGR_CTXT_PRIO_F,
-		  "SGE too many priority egress contexts", -1, 0 },
+	snprintf(rname, sizeof(rname), "MC%u_DDRCTL_INT_CAUSE", idx);
+
+	/* read status, enable, mask regs */
+	t4_ddr_indirect_rw(adap, &status, MC_DWC_DDRPHYA_MASTER0_BASE0_PHYINTERRUPTSTATUS_A,
+			   idx, 0);
+	t4_ddr_indirect_rw(adap, &enable, MC_DWC_DDRPHYA_MASTER0_BASE0_PHYINTERRUPTENABLE_A,
+			   idx, 0);
+	t4_ddr_indirect_rw(adap, &mask, MC_DWC_DDRPHYA_MASTER0_BASE0_PHYINTERRUPTMASK_A, idx, 0);
+
+	status &= enable;
+	if (verbose && status != 0)
+		t4_show_intr_info(adap, &ii, status, enable);
+	fatal = status & ii.fatal;
+	if (fatal != 0 && ii.flags & NONFATAL_IF_DISABLED)
+		fatal &= enable;
+	if (status == 0)
+		return false;
+
+	/* clearing the ddr register */
+	mask = ~mask;
+	t4_ddr_indirect_rw(adap, &mask, MC_DWC_DDRPHYA_MASTER0_BASE0_PHYINTERRUPTCLEAR_A, idx, 1);
+
+	return true;
+}
+
+static bool mc_ddrctl_intr_handler(struct adapter *adap, int idx, bool verbose)
+{
+	static const struct intr_details mc_p_ddrctl_int_cause_details[] = {
+		{ HIF_WDATA_PTR_ADDR_ERR_INTR_DCH1_CAUSE_F,
+			"HIF write request (channel 1) invalid address" },
+		{ HIF_RDATA_CRC_ERR_INTR_DCH1_CAUSE_F,
+			"HIF read data (channel 1) CRC error" },
+		{ HIF_RDATA_ADDR_ERR_INTR_DCH1_CAUSE_F,
+			"HIF read request (channel 1) invalid address" },
+		{ HIF_WDATA_PTR_ADDR_ERR_INTR_DCH0_CAUSE_F,
+			"HIF write request (channel 0) invalid address" },
+		{ HIF_RDATA_CRC_ERR_INTR_DCH0_CAUSE_F, "HIF read data (channel 0) CRC error" },
+		{ HIF_RDATA_ADDR_ERR_INTR_DCH0_CAUSE_F,
+			"HIF read request (channel 0) invalid address" },
 		{ 0 }
 	};
 
-	perr = t4_read_reg(adapter, SGE_INT_CAUSE1_A);
-	if (perr) {
-		v |= perr;
-		dev_alert(adapter->pdev_dev, "SGE Cause1 Parity Error %#x\n",
-			  perr);
-	}
+	int i = idx;
+	bool fatal = false;
+	char rname[32];
+	struct intr_info ii = {
+		.name = &rname[0],
+		.fatal = 0x0003f,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = mc_p_ddrctl_int_cause_details,
+		.actions = NULL,
+	};
 
-	perr = t4_read_reg(adapter, SGE_INT_CAUSE2_A);
-	if (perr) {
-		v |= perr;
-		dev_alert(adapter->pdev_dev, "SGE Cause2 Parity Error %#x\n",
-			  perr);
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) > CHELSIO_T6) {
+		snprintf(rname, sizeof(rname), "MC%u_DDRCTL_INT_CAUSE", i);
+		ii.cause_reg = MC_T7_REG(MC_P_DDRCTL_INT_CAUSE_A, i);
+		ii.enable_reg = MC_T7_REG(MC_P_DDRCTL_INT_ENABLE_A, i);
+		fatal = t4_handle_intr(adap, &ii, 0, verbose);
 	}
+	return fatal;
+}
 
-	if (CHELSIO_CHIP_VERSION(adapter->params.chip) >= CHELSIO_T5) {
-		perr = t4_read_reg(adapter, SGE_INT_CAUSE5_A);
-		/* Parity error (CRC) for err_T_RxCRC is trivial, ignore it */
-		perr &= ~ERR_T_RXCRC_F;
-		if (perr) {
-			v |= perr;
-			dev_alert(adapter->pdev_dev,
-				  "SGE Cause5 Parity Error %#x\n", perr);
-		}
-	}
+static bool mc_perr_intr_handler(struct adapter *adap, int i, bool verbose)
+{
+	static const struct intr_details mc_p_par_intr_details[] = {
+		{ ECC_UE_PAR_CAUSE_F, "MC UE ECC Error on Read data Interrupt Cause status" },
+		{ ECC_CE_PAR_CAUSE_F, "MC CE ECC Error on Read data Interrupt Cause status" },
+		{ FIFOR_PAR_CAUSE_F, "LOGIC (register)FIFOR parity error" },
+		{ RDATA_FIFOR_PAR_CAUSE_F, "Read data fifo block parity error" },
+		{ 0 }
+	};
+	static const struct intr_details t7_mc_p_par_cause_details[] = {
+		{ HIF_WDATA_Q_PARERR_DCH1_CAUSE_F, "HIF write data FIFO parity error" },
+		{ DDRCTL_ECC_CE_PAR_DCH1_CAUSE_F, "DDRCTL ECC CE Interrupt parity error" },
+		{ DDRCTL_ECC_CE_PAR_DCH0_CAUSE_F, "DDRCTL ECC CE Interrupt parity error" },
+		{ DDRCTL_ECC_UE_PAR_DCH1_CAUSE_F, "DDRCTL ECC UE Interrupt parity error" },
+		{ DDRCTL_ECC_UE_PAR_DCH0_CAUSE_F, "DDRCTL ECC UE Interrupt parity error" },
+		{ WDATARAM_PARERR_DCH1_CAUSE_F, "DDRCTL WDATARAM channel 1 parity error" },
+		{ WDATARAM_PARERR_DCH0_CAUSE_F, "DDRCTL WDATARAM channel 0 parity error" },
+		{ BIST_ADDR_FIFO_PARERR_CAUSE_F, "BIST address FIFO parity error" },
+		{ BIST_ERR_ADDR_FIFO_PARERR_CAUSE_F, "BIST error address FIFO parity error" },
+		{ HIF_WDATA_Q_PARERR_DCH0_CAUSE_F,
+			"HIF write data FIFO for channel 0 parity error" },
+		{ HIF_RSPDATA_Q_PARERR_DCH1_CAUSE_F,
+			"HIF read data FIFO for channel 1 parity error" },
+		{ HIF_RSPDATA_Q_PARERR_DCH0_CAUSE_F,
+			"HIF read data FIFO for channel 0 parity error" },
+		{ HIF_WDATA_MASK_FIFO_PARERR_DCH1_CAUSE_F,
+			"HIF write data mask FIFO for channel 1 parity error" },
+		{ HIF_WDATA_MASK_FIFO_PARERR_DCH0_CAUSE_F,
+			"HIF write data mask FIFO for channel 0 parity error" },
+		{ 0 }
+	};
 
-	v |= t4_handle_intr_status(adapter, SGE_INT_CAUSE3_A, sge_intr_info);
-	if (CHELSIO_CHIP_VERSION(adapter->params.chip) <= CHELSIO_T5)
-		v |= t4_handle_intr_status(adapter, SGE_INT_CAUSE3_A,
-					   t4t5_sge_intr_info);
-
-	err = t4_read_reg(adapter, SGE_ERROR_STATS_A);
-	if (err & ERROR_QID_VALID_F) {
-		dev_err(adapter->pdev_dev, "SGE error for queue %u\n",
-			ERROR_QID_G(err));
-		if (err & UNCAPTURED_ERROR_F)
-			dev_err(adapter->pdev_dev,
-				"SGE UNCAPTURED_ERROR set (clearing)\n");
-		t4_write_reg(adapter, SGE_ERROR_STATS_A, ERROR_QID_VALID_F |
-			     UNCAPTURED_ERROR_F);
+	bool fatal;
+	char rname[32];
+	struct intr_info ii = {
+		.name = &rname[0],
+		.fatal = 0xffffffff,
+		.flags = 0,
+		.details = NULL,
+		.actions = NULL,
+	};
+
+	snprintf(rname, sizeof(rname), "MC%u_PAR_CAUSE", i);
+	if (is_t4(adap->params.chip)) {
+		ii.details = mc_p_par_intr_details;
+		ii.cause_reg = MC_PAR_CAUSE_A;
+		ii.enable_reg = MC_PAR_ENABLE_A;
+	} else if (CHELSIO_CHIP_VERSION(adap->params.chip) < CHELSIO_T7) {
+		ii.details = mc_p_par_intr_details;
+		ii.cause_reg = MC_REG(MC_P_PAR_CAUSE_A, i);
+		ii.enable_reg = MC_REG(MC_P_PAR_ENABLE_A, i);
+	} else {
+		ii.details = t7_mc_p_par_cause_details;
+		ii.cause_reg = MC_T7_REG(T7_MC_P_PAR_CAUSE_A, i);
+		ii.enable_reg = MC_T7_REG(T7_MC_P_PAR_ENABLE_A, i);
 	}
+	ii.flags = NONFATAL_IF_DISABLED;
+	fatal = t4_handle_intr(adap, &ii, 0, verbose);
 
-	if (v != 0)
-		t4_fatal_err(adapter);
+	return fatal;
 }
 
-#define CIM_OBQ_INTR (OBQULP0PARERR_F | OBQULP1PARERR_F | OBQULP2PARERR_F |\
-		      OBQULP3PARERR_F | OBQSGEPARERR_F | OBQNCSIPARERR_F)
-#define CIM_IBQ_INTR (IBQTP0PARERR_F | IBQTP1PARERR_F | IBQULPPARERR_F |\
-		      IBQSGEHIPARERR_F | IBQSGELOPARERR_F | IBQNCSIPARERR_F)
-
-/*
- * CIM interrupt handler.
- */
-static void cim_intr_handler(struct adapter *adapter)
-{
-	static const struct intr_info cim_intr_info[] = {
-		{ PREFDROPINT_F, "CIM control register prefetch drop", -1, 1 },
-		{ CIM_OBQ_INTR, "CIM OBQ parity error", -1, 1 },
-		{ CIM_IBQ_INTR, "CIM IBQ parity error", -1, 1 },
-		{ MBUPPARERR_F, "CIM mailbox uP parity error", -1, 1 },
-		{ MBHOSTPARERR_F, "CIM mailbox host parity error", -1, 1 },
-		{ TIEQINPARERRINT_F, "CIM TIEQ outgoing parity error", -1, 1 },
-		{ TIEQOUTPARERRINT_F, "CIM TIEQ incoming parity error", -1, 1 },
-		{ TIMER0INT_F, "CIM TIMER0 interrupt", -1, 1 },
-		{ 0 }
-	};
-	static const struct intr_info cim_upintr_info[] = {
-		{ RSVDSPACEINT_F, "CIM reserved space access", -1, 1 },
-		{ ILLTRANSINT_F, "CIM illegal transaction", -1, 1 },
-		{ ILLWRINT_F, "CIM illegal write", -1, 1 },
-		{ ILLRDINT_F, "CIM illegal read", -1, 1 },
-		{ ILLRDBEINT_F, "CIM illegal read BE", -1, 1 },
-		{ ILLWRBEINT_F, "CIM illegal write BE", -1, 1 },
-		{ SGLRDBOOTINT_F, "CIM single read from boot space", -1, 1 },
-		{ SGLWRBOOTINT_F, "CIM single write to boot space", -1, 1 },
-		{ BLKWRBOOTINT_F, "CIM block write to boot space", -1, 1 },
-		{ SGLRDFLASHINT_F, "CIM single read from flash space", -1, 1 },
-		{ SGLWRFLASHINT_F, "CIM single write to flash space", -1, 1 },
-		{ BLKWRFLASHINT_F, "CIM block write to flash space", -1, 1 },
-		{ SGLRDEEPROMINT_F, "CIM single EEPROM read", -1, 1 },
-		{ SGLWREEPROMINT_F, "CIM single EEPROM write", -1, 1 },
-		{ BLKRDEEPROMINT_F, "CIM block EEPROM read", -1, 1 },
-		{ BLKWREEPROMINT_F, "CIM block EEPROM write", -1, 1 },
-		{ SGLRDCTLINT_F, "CIM single read from CTL space", -1, 1 },
-		{ SGLWRCTLINT_F, "CIM single write to CTL space", -1, 1 },
-		{ BLKRDCTLINT_F, "CIM block read from CTL space", -1, 1 },
-		{ BLKWRCTLINT_F, "CIM block write to CTL space", -1, 1 },
-		{ SGLRDPLINT_F, "CIM single read from PL space", -1, 1 },
-		{ SGLWRPLINT_F, "CIM single write to PL space", -1, 1 },
-		{ BLKRDPLINT_F, "CIM block read from PL space", -1, 1 },
-		{ BLKWRPLINT_F, "CIM block write to PL space", -1, 1 },
-		{ REQOVRLOOKUPINT_F, "CIM request FIFO overwrite", -1, 1 },
-		{ RSPOVRLOOKUPINT_F, "CIM response FIFO overwrite", -1, 1 },
-		{ TIMEOUTINT_F, "CIM PIF timeout", -1, 1 },
-		{ TIMEOUTMAINT_F, "CIM PIF MA timeout", -1, 1 },
-		{ 0 }
+static bool mc_ecc_intr_handler(struct adapter *adap, int i, bool verbose)
+{
+	unsigned int ctl_reg;
+	unsigned int ecc_regs[] = {
+		MC_REGB_DDRC_CH0_ECCCTL_A,
+		MC_REGB_DDRC_CH1_ECCCTL_A,
 	};
+	int ch;
 
-	u32 val, fw_err;
-	int fat;
+	for (ch = 0; ch < ARRAY_SIZE(ecc_regs); ch++) {
+		t4_ddr_indirect_rw(adap, &ctl_reg, ecc_regs[ch], i, 0);
 
-	fw_err = t4_read_reg(adapter, PCIE_FW_A);
-	if (fw_err & PCIE_FW_ERR_F)
-		t4_report_fw_error(adapter);
+		if (ctl_reg & ECC_CORRECTED_ERR_INTR_EN_F)
+			ctl_reg |= ECC_CORRECTED_ERR_CLR_F;
 
-	/* When the Firmware detects an internal error which normally
-	 * wouldn't raise a Host Interrupt, it forces a CIM Timer0 interrupt
-	 * in order to make sure the Host sees the Firmware Crash.  So
-	 * if we have a Timer0 interrupt and don't see a Firmware Crash,
-	 * ignore the Timer0 interrupt.
-	 */
+		if (ctl_reg & ECC_UNCORRECTED_ERR_INTR_EN_F)
+			ctl_reg |= ECC_UNCORRECTED_ERR_CLR_F;
 
-	val = t4_read_reg(adapter, CIM_HOST_INT_CAUSE_A);
-	if (val & TIMER0INT_F)
-		if (!(fw_err & PCIE_FW_ERR_F) ||
-		    (PCIE_FW_EVAL_G(fw_err) != PCIE_FW_EVAL_CRASH))
-			t4_write_reg(adapter, CIM_HOST_INT_CAUSE_A,
-				     TIMER0INT_F);
+		t4_ddr_indirect_rw(adap, &ctl_reg, ecc_regs[ch], i, 1);
+	}
 
-	fat = t4_handle_intr_status(adapter, CIM_HOST_INT_CAUSE_A,
-				    cim_intr_info) +
-	      t4_handle_intr_status(adapter, CIM_HOST_UPACC_INT_CAUSE_A,
-				    cim_upintr_info);
-	if (fat)
-		t4_fatal_err(adapter);
+	return true;
 }
 
 /*
- * ULP RX interrupt handler.
+ * EDC/MC interrupt handler.
  */
-static void ulprx_intr_handler(struct adapter *adapter)
+static bool mem_intr_handler(struct adapter *adap, int idx, bool verbose)
 {
-	static const struct intr_info ulprx_intr_info[] = {
-		{ 0x1800000, "ULPRX context error", -1, 1 },
-		{ 0x7fffff, "ULPRX parity error", -1, 1 },
+	static const char name[4][5] = { "EDC0", "EDC1", "MC0", "MC1" };
+	unsigned int count_reg, v;
+	static int i;
+	static const struct intr_details mem_intr_details[] = {
+		{ ECC_UE_INT_CAUSE_F, "Uncorrectable ECC data error(s)" },
+		{ ECC_CE_INT_CAUSE_F, "Correctable ECC data error(s)" },
+		{ PERR_INT_CAUSE_F, "FIFO parity error" },
 		{ 0 }
 	};
-
-	if (t4_handle_intr_status(adapter, ULP_RX_INT_CAUSE_A, ulprx_intr_info))
-		t4_fatal_err(adapter);
-}
-
-/*
- * ULP TX interrupt handler.
- */
-static void ulptx_intr_handler(struct adapter *adapter)
-{
-	static const struct intr_info ulptx_intr_info[] = {
-		{ PBL_BOUND_ERR_CH3_F, "ULPTX channel 3 PBL out of bounds", -1,
-		  0 },
-		{ PBL_BOUND_ERR_CH2_F, "ULPTX channel 2 PBL out of bounds", -1,
-		  0 },
-		{ PBL_BOUND_ERR_CH1_F, "ULPTX channel 1 PBL out of bounds", -1,
-		  0 },
-		{ PBL_BOUND_ERR_CH0_F, "ULPTX channel 0 PBL out of bounds", -1,
-		  0 },
-		{ 0xfffffff, "ULPTX parity error", -1, 1 },
+	static const struct intr_details t7_mc_intr_details[] = {
+		{ DDRPHY_INT_CAUSE_F, "DDR PHY IP interrupts" },
+		{ DDRCTL_INT_CAUSE_F, "DDR Controller IP interrupt cause" },
+		{ T7_ECC_UE_INT_CAUSE_F, "Uncorrectable ECC data error(s)" },
+		{ T7_ECC_CE_INT_CAUSE_F, "Correctable ECC data error(s)" },
+		{ PERR_INT_CAUSE_F, "FIFO parity error" },
+		{ 0 }
+	};
+	struct intr_action t7_mc_intr_actions[] = {
+		{ DDRPHY_INT_CAUSE_F, i, mc_ddrphy_intr_handler },
+		{ DDRCTL_INT_CAUSE_F, i, mc_ddrctl_intr_handler },
+		{ T7_ECC_CE_INT_CAUSE_F, i, mc_ecc_intr_handler },
+		{ T7_ECC_UE_INT_CAUSE_F, i, mc_ecc_intr_handler },
+		{ PERR_INT_CAUSE_F, i, mc_perr_intr_handler },
+		{ 0 }
+	};
+	struct intr_action mc_intr_actions[] = {
+		{ PERR_INT_CAUSE_F, i, mc_perr_intr_handler },
 		{ 0 }
 	};
 
-	if (t4_handle_intr_status(adapter, ULP_TX_INT_CAUSE_A, ulptx_intr_info))
-		t4_fatal_err(adapter);
+	char rname[32];
+	struct intr_info ii = {
+		.name = &rname[0],
+		.fatal = PERR_INT_CAUSE_F | ECC_UE_INT_CAUSE_F,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = NULL,
+		.actions = NULL,
+	};
+	bool fatal = false;
+
+	i = (idx == MEM_MC0 || idx == MEM_MC1) ? idx - 2 : idx;
+	switch (idx) {
+	case MEM_EDC1:
+		fallthrough;
+	case MEM_EDC0:
+		snprintf(rname, sizeof(rname), "EDC%u_INT_CAUSE", i);
+		if (is_t4(adap->params.chip)) {
+			ii.cause_reg = EDC_REG(EDC_INT_CAUSE_A, i);
+			ii.enable_reg = EDC_REG(EDC_INT_ENABLE_A, i);
+			ii.details = mem_intr_details;
+			count_reg = EDC_REG(EDC_ECC_STATUS_A, i);
+		} else {
+			ii.cause_reg = EDC_T5_REG(EDC_H_INT_CAUSE_A, i);
+			ii.enable_reg = EDC_T5_REG(EDC_H_INT_ENABLE_A, i);
+			ii.details = mem_intr_details;
+			count_reg = EDC_T5_REG(EDC_H_ECC_STATUS_A, i);
+		}
+		ii.skip_clear = 1;
+		fatal |= t4_handle_intr(adap, &ii, 0, verbose);
+		break;
+	case MEM_MC1:
+		if (is_t4(adap->params.chip) || is_t6(adap->params.chip))
+			return false;
+		fallthrough;
+	case MEM_MC0:
+		snprintf(rname, sizeof(rname), "MC%u_INT_CAUSE", i);
+		if (is_t4(adap->params.chip)) {
+			ii.cause_reg = MC_INT_CAUSE_A;
+			ii.enable_reg = MC_INT_ENABLE_A;
+			ii.details = mem_intr_details;
+			ii.actions = mc_intr_actions;
+			count_reg = MC_ECC_STATUS_A;
+		} else if (CHELSIO_CHIP_VERSION(adap->params.chip) < CHELSIO_T7) {
+			ii.cause_reg = MC_REG(MC_P_INT_CAUSE_A, i);
+			ii.enable_reg = MC_REG(MC_P_INT_ENABLE_A, i);
+			ii.details = mem_intr_details;
+			ii.actions = mc_intr_actions;
+			count_reg = MC_REG(MC_P_ECC_STATUS_A, i);
+		} else {
+			ii.cause_reg = MC_T7_REG(T7_MC_P_INT_CAUSE_A, i);
+			ii.enable_reg = MC_T7_REG(T7_MC_P_INT_ENABLE_A, i);
+			ii.details = t7_mc_intr_details;
+			ii.fatal = PERR_INT_CAUSE_F | T7_ECC_UE_INT_CAUSE_F;
+			ii.actions = t7_mc_intr_actions;
+		}
+		ii.skip_clear = 1;
+		fatal |= t4_handle_intr(adap, &ii, 0, verbose);
+
+		break;
+	}
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) < CHELSIO_T7 || idx <= MEM_EDC1) {
+		v = t4_read_reg(adap, count_reg);
+		if (v != 0) {
+			if (ECC_UECNT_G(v) != 0) {
+				dev_alert(adap->pdev_dev,
+					  "%s: %u uncorrectable ECC data error(s)\n",
+					  name[idx], ECC_UECNT_G(v));
+			}
+			if (ECC_CECNT_G(v) != 0) {
+				if (idx <= MEM_EDC1)
+					t4_edc_err_read(adap, idx);
+				dev_warn_ratelimited(adap->pdev_dev,
+						     "%s: %u correctable ECC data error(s)\n",
+						     name[idx], ECC_CECNT_G(v));
+			}
+			t4_write_reg(adap, count_reg, 0xffffffff);
+		}
+	}
+	clear_int_cause_reg(adap, &ii);
+	return fatal;
 }
 
-/*
- * PM TX interrupt handler.
- */
-static void pmtx_intr_handler(struct adapter *adapter)
-{
-	static const struct intr_info pmtx_intr_info[] = {
-		{ PCMD_LEN_OVFL0_F, "PMTX channel 0 pcmd too large", -1, 1 },
-		{ PCMD_LEN_OVFL1_F, "PMTX channel 1 pcmd too large", -1, 1 },
-		{ PCMD_LEN_OVFL2_F, "PMTX channel 2 pcmd too large", -1, 1 },
-		{ ZERO_C_CMD_ERROR_F, "PMTX 0-length pcmd", -1, 1 },
-		{ PMTX_FRAMING_ERROR_F, "PMTX framing error", -1, 1 },
-		{ OESPI_PAR_ERROR_F, "PMTX oespi parity error", -1, 1 },
-		{ DB_OPTIONS_PAR_ERROR_F, "PMTX db_options parity error",
-		  -1, 1 },
-		{ ICSPI_PAR_ERROR_F, "PMTX icspi parity error", -1, 1 },
-		{ PMTX_C_PCMD_PAR_ERROR_F, "PMTX c_pcmd parity error", -1, 1},
-		{ 0 }
-	};
+static bool ma_wrap_status(struct adapter *adap, int arg, bool verbose)
+{
+	u32 v = t4_read_reg(adap, MA_INT_WRAP_STATUS_A);
+
+	dev_alert(adap->pdev_dev,
+		  "MA address wrap-around error by client %u to address %#x\n",
+		  MEM_WRAP_CLIENT_NUM_G(v), MEM_WRAP_ADDRESS_G(v) << 4);
+	t4_write_reg(adap, MA_INT_WRAP_STATUS_A, v);
 
-	if (t4_handle_intr_status(adapter, PM_TX_INT_CAUSE_A, pmtx_intr_info))
-		t4_fatal_err(adapter);
+	return false;
 }
 
 /*
- * PM RX interrupt handler.
+ * MA interrupt handler.
  */
-static void pmrx_intr_handler(struct adapter *adapter)
+static bool ma_intr_handler(struct adapter *adap, int arg, bool verbose)
 {
-	static const struct intr_info pmrx_intr_info[] = {
-		{ ZERO_E_CMD_ERROR_F, "PMRX 0-length pcmd", -1, 1 },
-		{ PMRX_FRAMING_ERROR_F, "PMRX framing error", -1, 1 },
-		{ OCSPI_PAR_ERROR_F, "PMRX ocspi parity error", -1, 1 },
-		{ DB_OPTIONS_PAR_ERROR_F, "PMRX db_options parity error",
-		  -1, 1 },
-		{ IESPI_PAR_ERROR_F, "PMRX iespi parity error", -1, 1 },
-		{ PMRX_E_PCMD_PAR_ERROR_F, "PMRX e_pcmd parity error", -1, 1},
+	static const struct intr_action ma_intr_actions[] = {
+		{ MEM_WRAP_INT_CAUSE_F, 0, ma_wrap_status },
+		{ 0 },
+	};
+	static const struct intr_details ma_int_cause_details[] = {
+		{ MEM_TO_INT_CAUSE_F, " MA Timeout Error Interrupt Cause status"},
+		{ MEM_PERR_INT_CAUSE_F, " MA Address PARITY Error Interrupt Cause status" },
+		{ MEM_WRAP_INT_CAUSE_F, "MA Address WRAP Around Interrupt Cause status" },
+		{ 0 }
+	};
+	static const struct intr_info ma_intr_info = {
+		.name = "MA_INT_CAUSE",
+		.cause_reg = MA_INT_CAUSE_A,
+		.enable_reg = MA_INT_ENABLE_A,
+		.fatal = MEM_WRAP_INT_CAUSE_F | MEM_PERR_INT_CAUSE_F,
+		.flags = NONFATAL_IF_DISABLED,
+		.skip_clear = 1,
+		.details = ma_int_cause_details,
+		.actions = ma_intr_actions,
+	};
+	static const struct intr_details t7_ma_parity_error_status1_details[] = {
+		{ 0x00000f80, "Arbiter Write data queue parity error" },
+		{ 0x0000007c, "Arbiter Read data queue parity error" },
+		{ T7_TP_DMARBT_PAR_ERROR_F, "TP DMARBT Command, Tag logic queue parity error" },
+		{ T7_LOGIC_FIFO_PAR_ERROR_F, "Command, Tag logic queue parity error" },
+		{ 0 }
+	};
+	static const struct intr_details t6_ma_parity_error_status1_details[] = {
+		{ TP_DMARBT_PAR_ERROR_F, "TP DMARBT Command, Tag logic queue parity error" },
+		{ LOGIC_FIFO_PAR_ERROR_F, "Command, Tag logic queue parity error" },
+		{ 0x3c000000, "Arbiter Write data queue parity error" },
+		{ 0x03c00000, "Arbiter Read data queue parity error" },
+		{ 0x003ff800, "Client Write data queue parity error" },
+		{ 0x000007ff, "Client Read data queue parity error" },
+		{ 0 }
+	};
+	struct intr_info ma_perr_status1 = {
+		.name = "MA_PARITY_ERROR_STATUS1",
+		.cause_reg = MA_PARITY_ERROR_STATUS1_A,
+		.enable_reg = MA_PARITY_ERROR_ENABLE1_A,
+		.fatal = 0,
+		.flags = 0,
+		.details = NULL,
+		.actions = NULL,
+	};
+	static const struct intr_details t7_ma_parity_error_status2_details[] = {
+		{ 0x00007fff, "Client Write data queue parity error" },
+		{ 0 }
+	};
+	static const struct intr_details ma_parity_error_status2_details[] = {
+		{ ARB4_PAR_WRQUEUE_ERROR_F, "ARB3 Write data queue parity error" },
+		{ ARB4_PAR_RDQUEUE_ERROR_F, "ARB3 Read data queue parity error" },
+		{ 0 }
+	};
+	static  struct intr_info ma_perr_status2 = {
+		.name = "MA_PARITY_ERROR_STATUS2",
+		.cause_reg = MA_PARITY_ERROR_STATUS2_A,
+		.enable_reg = MA_PARITY_ERROR_ENABLE2_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = NULL,
+		.actions = NULL,
+	};
+	static const struct intr_details t7_ma_parity_error_status3_details[] = {
+		{ 0x00007fff, "Client Write data queue parity error" },
+		{ 0 }
+	};
+	static  struct intr_info ma_perr_status3 = {
+		.name = "MA_PARITY_ERROR_STATUS3",
+		.cause_reg = MA_PARITY_ERROR_STATUS3_A,
+		.enable_reg = MA_PARITY_ERROR_ENABLE3_A,
+		.fatal = 0xffffffff,
+		.flags = 0,
+		.details = t7_ma_parity_error_status3_details,
+		.actions = NULL,
+	};
+	static const struct intr_details ma_write_error_details[] = {
+		{ 0xffff0000, "Client write command timeout error" },
+		{ 0x00007fff, "Client write data queue timeout error" },
 		{ 0 }
 	};
+	static  struct intr_info ma_write_error_info = {
+		.name = "MA_WRITE_TIMEOUT_ERROR_STATUS",
+		.cause_reg = MA_WRITE_TIMEOUT_ERROR_STATUS_A,
+		.enable_reg = MA_WRITE_TIMEOUT_ERROR_ENABLE_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = ma_write_error_details,
+		.actions = NULL,
+	};
+	static const struct intr_details ma_read_error_details[] = {
+		{ 0xffff0000, "Client read command timeout error" },
+		{ 0x00007fff, "Client read data queue timeout error" },
+		{ 0 }
+	};
+	static  struct intr_info ma_read_error_info = {
+		.name = "MA_READ_TIMEOUT_ERROR_STATUS",
+		.cause_reg = MA_READ_TIMEOUT_ERROR_STATUS_A,
+		.enable_reg = MA_READ_TIMEOUT_ERROR_ENABLE_A,
+		.fatal = 0,
+		.flags = 0,
+		.details = ma_read_error_details,
+		.actions = NULL,
+	};
 
-	if (t4_handle_intr_status(adapter, PM_RX_INT_CAUSE_A, pmrx_intr_info))
-		t4_fatal_err(adapter);
+	bool fatal;
+
+	fatal = false;
+
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) >= CHELSIO_T7) {
+		ma_perr_status1.details = t7_ma_parity_error_status1_details;
+		ma_perr_status2.details = t7_ma_parity_error_status2_details;
+	} else {
+		ma_perr_status1.details = t6_ma_parity_error_status1_details;
+		ma_perr_status2.details = ma_parity_error_status2_details;
+	}
+
+	fatal |= t4_handle_intr(adap, &ma_intr_info, 0, verbose);
+	fatal |= t4_handle_intr(adap, &ma_perr_status1, 0, verbose);
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) > CHELSIO_T6)
+		fatal |= t4_handle_intr(adap, &ma_perr_status3, 0, verbose);
+	else if (CHELSIO_CHIP_VERSION(adap->params.chip) > CHELSIO_T4)
+		fatal |= t4_handle_intr(adap, &ma_perr_status2, 0, verbose);
+	fatal |= t4_handle_intr(adap, &ma_write_error_info, 0, verbose);
+	fatal |= t4_handle_intr(adap, &ma_read_error_info, 0, verbose);
+
+	clear_int_cause_reg(adap, &ma_intr_info);
+	return fatal;
 }
 
 /*
- * CPL switch interrupt handler.
+ * SMB interrupt handler.
  */
-static void cplsw_intr_handler(struct adapter *adapter)
-{
-	static const struct intr_info cplsw_intr_info[] = {
-		{ CIM_OP_MAP_PERR_F, "CPLSW CIM op_map parity error", -1, 1 },
-		{ CIM_OVFL_ERROR_F, "CPLSW CIM overflow", -1, 1 },
-		{ TP_FRAMING_ERROR_F, "CPLSW TP framing error", -1, 1 },
-		{ SGE_FRAMING_ERROR_F, "CPLSW SGE framing error", -1, 1 },
-		{ CIM_FRAMING_ERROR_F, "CPLSW CIM framing error", -1, 1 },
-		{ ZERO_SWITCH_ERROR_F, "CPLSW no-switch error", -1, 1 },
+static bool smb_intr_handler(struct adapter *adap, int arg, bool verbose)
+{
+	static const struct intr_details smb_int_cause_details[] = {
+		{ MSTTXFIFOPARINT_F, "Master has Parity Error in Tx Fifo" },
+		{ MSTRXFIFOPARINT_F, "Master has Parity Error in Rx Fifo" },
+		{ SLVFIFOPARINT_F, "Slave  has Parity Error in Fifo" },
+		{ SLVUNEXPBUSSTOPINT_F, "Slave get Unexpected BusStop" },
+		{ SLVUNEXPBUSSTARTINT_F, "Slave get Unexpected BusStart" },
+		{ SLVCOMMANDCODEINVINT_F, "Slave get Invalid Command Code" },
+		{ SLVBYTECNTERRINT_F, "Slave get Erroneous ByteCount value" },
+		{ SLVUNEXPACKMSTINT_F, "Slave get Unexpected Ack from Master" },
+		{ SLVUNEXPNACKMSTINT_F, "Slave get Unexpected Nack from Master" },
+		{ SLVNOBUSSTOPINT_F, "Slave did not get Bus Stop" },
+		{ SLVNOREPSTARTINT_F, "Slave has no Repeated Start" },
+		{ SLVRXADDRINT_F, "Slave has Address Error" },
+		{ SLVRXPECERRINT_F, "Slave has Pec Error" },
+		{ SLVPREPTOARPINT_F, "PL has invalid request" },
+		{ SLVTIMEOUTINT_F, "Slave has timed out" },
+		{ SLVERRINT_F, "Slave detected error during the current transfer" },
+		{ SLVDONEINT_F, "Slave has completed the current transaction" },
+		{ SLVRXRDYINT_F, "Slave has received bytes to be processed by uP" },
+		{ MSTTIMEOUTINT_F, "Master has timed out" },
+		{ MSTNACKINT_F, "Master has detected a NAck on the transfer" },
+		{ MSTLOSTARBINT_F, "Master has lost arbitration all the timeline" },
+		{ MSTDONEINT_F, "Master has completed the current transaction" },
 		{ 0 }
 	};
+	static const struct intr_info smb_int_cause = {
+		.name = "SMB_INT_CAUSE",
+		.cause_reg = SMB_INT_CAUSE_A,
+		.enable_reg = SMB_INT_ENABLE_A,
+		.fatal = SLVFIFOPARINT_F | MSTRXFIFOPARINT_F | MSTTXFIFOPARINT_F,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = smb_int_cause_details,
+		.actions = NULL,
+	};
 
-	if (t4_handle_intr_status(adapter, CPL_INTR_CAUSE_A, cplsw_intr_info))
-		t4_fatal_err(adapter);
+	return t4_handle_intr(adap, &smb_int_cause, 0, verbose);
 }
 
 /*
- * LE interrupt handler.
+ * NC-SI interrupt handler.
  */
-static void le_intr_handler(struct adapter *adap)
+static bool ncsi_intr_handler(struct adapter *adap, int arg, bool verbose)
 {
-	enum chip_type chip = CHELSIO_CHIP_VERSION(adap->params.chip);
-	static const struct intr_info le_intr_info[] = {
-		{ LIPMISS_F, "LE LIP miss", -1, 0 },
-		{ LIP0_F, "LE 0 LIP error", -1, 0 },
-		{ PARITYERR_F, "LE parity error", -1, 1 },
-		{ UNKNOWNCMD_F, "LE unknown command", -1, 1 },
-		{ REQQPARERR_F, "LE request queue parity error", -1, 1 },
+	static const struct intr_details ncsi_int_cause_fields[] = {
+		/* t7+ */
+		{ CIM2NC_PERR_F, " CIM to NC parity error" },
+		/* t6+ */
+		{ CIM_DM_PRTY_ERR_F, "NC-SI CIM parity error" },
+		{ MPS_DM_PRTY_ERR_F, "NC-SI MPS parity error" },
+		{ TXFIFO_PRTY_ERR_F, "NC-SI Tx FIFO parity error" },
+		{ RXFIFO_PRTY_ERR_F, "NC-SI Rx FIFO parity error" },
 		{ 0 }
 	};
-
-	static struct intr_info t6_le_intr_info[] = {
-		{ T6_LIPMISS_F, "LE LIP miss", -1, 0 },
-		{ T6_LIP0_F, "LE 0 LIP error", -1, 0 },
-		{ CMDTIDERR_F, "LE cmd tid error", -1, 1 },
-		{ TCAMINTPERR_F, "LE parity error", -1, 1 },
-		{ T6_UNKNOWNCMD_F, "LE unknown command", -1, 1 },
-		{ SSRAMINTPERR_F, "LE request queue parity error", -1, 1 },
-		{ HASHTBLMEMCRCERR_F, "LE hash table mem crc error", -1, 0 },
+	static const struct intr_info ncsi_int_cause = {
+		.name = "NCSI_INT_CAUSE",
+		.cause_reg = NCSI_INT_CAUSE_A,
+		.enable_reg = NCSI_INT_ENABLE_A,
+		.fatal = RXFIFO_PRTY_ERR_F | TXFIFO_PRTY_ERR_F |
+			 MPS_DM_PRTY_ERR_F | CIM_DM_PRTY_ERR_F |
+			 CIM2NC_PERR_F,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = ncsi_int_cause_fields,
+		.actions = NULL,
+	};
+	static const struct intr_details ncsi_xgmac0_int_cause_details[] = {
+		{ XAUIPCSDECERR_F, "RGMII PCS DEC Error" },
+		{ RGMIIRXFIFOOVERFLOW_F, "RGMII receive FIFO over flow" },
+		{ RGMIIRXFIFOUNDERFLOW_F, "RGMII receive FIFO under flow" },
+		{ RXPKTSIZEERROR_F, "Receive over size packet" },
+		{ WOLPATDETECTED_F, "WOL pattern detected" },
+		{ 0x000e0000, "Tx FIFO parity error" },
+		{ 0x0001c000, "Rx FIFO parity error" },
+		{ TXFIFO_UNDERRUN_F, "Tx FIFO underrun" },
+		{ RXFIFO_OVERFLOW_F, "Rx FIFO overflow" },
+		{ 0x00000f00, "XAUI SERDES BIST error" },
+		{ 0x000000f0, "XAUI SERDES receive low signal change" },
+		{ XAUIPCSCTCERR_F, "XAUI PCS CTC FIFO error" },
+		{ XAUIPCSALIGNCHANGE_F, "XAUI PCS alignment change" },
+		{ RGMIILINKSTSCHANGE_F, "RGMII link status change" },
+		{ XGM_INT_F, "XGM Core embedded interrupt (2nd level)" },
 		{ 0 }
 	};
+	static const struct intr_info ncsi_xgmac0_int_cause = {
+		.name = "NCSI_XGMAC0_INT_CAUSE",
+		.cause_reg = NCSI_XGMAC0_INT_CAUSE_A,
+		.enable_reg = NCSI_XGMAC0_INT_ENABLE_A,
+		.fatal = 0x000fc00,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = ncsi_xgmac0_int_cause_details,
+		.actions = NULL,
+	};
+	bool fatal = false;
 
-	if (t4_handle_intr_status(adap, LE_DB_INT_CAUSE_A,
-				  (chip <= CHELSIO_T5) ?
-				  le_intr_info : t6_le_intr_info))
-		t4_fatal_err(adap);
+	fatal |= t4_handle_intr(adap, &ncsi_int_cause, 0, verbose);
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) > CHELSIO_T6)
+		fatal |= t4_handle_intr(adap, &ncsi_xgmac0_int_cause, 0, verbose);
+	return fatal;
 }
 
 /*
- * MPS interrupt handler.
- */
-static void mps_intr_handler(struct adapter *adapter)
-{
-	static const struct intr_info mps_rx_intr_info[] = {
-		{ 0xffffff, "MPS Rx parity error", -1, 1 },
+ * MAC interrupt handler.
+ */
+static bool mac_intr_handler(struct adapter *adap, int port, bool verbose)
+{
+	static const struct intr_details mac_int_cause_cmn_details[] = {
+		{ 0x3fffc0, "HSS PLL lock error " },
+		{ FLOCK_ASSERTED_F, "frequency lock coming out of DPLL sub-block is asserted" },
+		{ FLOCK_LOST_F, "frequency lock coming out of DPLL sub-blocki is lost." },
+		{ PHASE_LOCK_ASSERTED_F, "PHASE LOCK from DPLL sub-block is asserted" },
+		{ PHASE_LOCK_LOST_F, "PHASE LOCK from DPLL sub-block is lost." },
+		{ LOCK_ASSERTED_F, "Lock from frac_n PLL inside t7_clk module is asserted" },
+		{ LOCK_LOST_F, "Lock from frac_n PLL inside t7_clk module is lost " },
 		{ 0 }
 	};
-	static const struct intr_info mps_tx_intr_info[] = {
-		{ TPFIFO_V(TPFIFO_M), "MPS Tx TP FIFO parity error", -1, 1 },
-		{ NCSIFIFO_F, "MPS Tx NC-SI FIFO parity error", -1, 1 },
-		{ TXDATAFIFO_V(TXDATAFIFO_M), "MPS Tx data FIFO parity error",
-		  -1, 1 },
-		{ TXDESCFIFO_V(TXDESCFIFO_M), "MPS Tx desc FIFO parity error",
-		  -1, 1 },
-		{ BUBBLE_F, "MPS Tx underflow", -1, 1 },
-		{ SECNTERR_F, "MPS Tx SOP/EOP error", -1, 1 },
-		{ FRMERR_F, "MPS Tx framing error", -1, 1 },
-		{ 0 }
+	static const struct intr_info mac_int_cause_cmn = {
+		.name = "MAC_INT_CAUSE_CMN",
+		.cause_reg = MAC_INT_CAUSE_CMN_A,
+		.enable_reg = MAC_INT_EN_CMN_A,
+		.fatal = 0,
+		.flags = 0,
+		.details = mac_int_cause_cmn_details,
+		.actions = NULL,
 	};
-	static const struct intr_info t6_mps_tx_intr_info[] = {
-		{ TPFIFO_V(TPFIFO_M), "MPS Tx TP FIFO parity error", -1, 1 },
-		{ NCSIFIFO_F, "MPS Tx NC-SI FIFO parity error", -1, 1 },
-		{ TXDATAFIFO_V(TXDATAFIFO_M), "MPS Tx data FIFO parity error",
-		  -1, 1 },
-		{ TXDESCFIFO_V(TXDESCFIFO_M), "MPS Tx desc FIFO parity error",
-		  -1, 1 },
-		/* MPS Tx Bubble is normal for T6 */
-		{ SECNTERR_F, "MPS Tx SOP/EOP error", -1, 1 },
-		{ FRMERR_F, "MPS Tx framing error", -1, 1 },
+	static const struct intr_details mac_perr_int_cause_mtip_details[] = {
+		{ PERR_MAC0_TX_F, "MTIP MAC TX memory for MAC 0 (the 200G MAC for port 0)" },
+		{ PERR_MAC1_TX_F, "MTIP MAC TX memory for MAC 1 (the 200G MAC for port 1)" },
+		{ PERR_MAC2_TX_F, "MTIP MAC TX memory for MAC 2 (the 10-100G MAC for port 0)" },
+		{ PERR_MAC3_TX_F, "MTIP MAC TX memory for MAC 3 (the 10-100G MAC for port 1)" },
+		{ PERR_MAC4_TX_F, "MTIP MAC TX memory for MAC 4 (the 10-100G MAC for port 2)" },
+		{ PERR_MAC5_TX_F, "MTIP MAC TX memory for MAC 5 (the 10-100G MAC for port 3)" },
+		{ PERR_MAC0_RX_F, "MTIP MAC RX memory for MAC 0 (the 200G MAC for port 0)" },
+		{ PERR_MAC1_RX_F, "MTIP MAC RX memory for MAC 1 (the 200G MAC for port 1)" },
+		{ PERR_MAC2_RX_F, "MTIP MAC RX memory for MAC 2 (the 10-100G MAC for port 0)" },
+		{ PERR_MAC3_RX_F, "MTIP MAC RX memory for MAC 3 (the 10-100G MAC for port 1)" },
+		{ PERR_MAC4_RX_F, "MTIP MAC RX memory for MAC 4 (the 10-100G MAC for port 2)" },
+		{ PERR_MAC5_RX_F, "MTIP MAC RX memory for MAC 5 (the 10-100G MAC for port 3)" },
+		{ PERR_MAC_STAT_RX_F, "MTIP MAC RX statistics memory (1 for all 4 10-100G MACs)" },
+		{ PERR_MAC_STAT_TX_F, "MTIP MAC TX statistics memory (1 for all 4 10-100G MACs)" },
+		{ PERR_MAC_STAT_CAP_F, "MTIP MAC stat capture memory (1 for all 4 100G MACs)" },
 		{ 0 }
 	};
-	static const struct intr_info mps_trc_intr_info[] = {
-		{ FILTMEM_V(FILTMEM_M), "MPS TRC filter parity error", -1, 1 },
-		{ PKTFIFO_V(PKTFIFO_M), "MPS TRC packet FIFO parity error",
-		  -1, 1 },
-		{ MISCPERR_F, "MPS TRC misc parity error", -1, 1 },
+	static const struct intr_info mac_perr_cause_mtip = {
+		.name = "MAC_PERR_INT_CAUSE_MTIP",
+		.cause_reg = MAC_PERR_INT_CAUSE_MTIP_A,
+		.enable_reg = MAC_PERR_INT_EN_MTIP_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = mac_perr_int_cause_mtip_details,
+		.actions = NULL,
+	};
+	static const struct intr_details ios_intr_cause_quad0_details[] = {
+		{ Q0_MAILBOX_INT_ASSERT_F, "Etopus Quad0 Mailbox interrupt cause" },
+		{ 0x00f00000, "Etopus Quad0 training failure" },
+		{ 0x000f0000, "Etopus Quad0 training complete" },
+		{ 0x0000f000, "Etopus Quad0 AN TX interrupt" },
+		{ 0x00000f00, "Etopus Quad0 signal detect assertion" },
+		{ 0x000000f0, "Etopus Quad0 CDR LOL assertion" },
+		{ 0x0000000f, "Etopus Quad0 LOS signal assertion" },
 		{ 0 }
 	};
-	static const struct intr_info mps_stat_sram_intr_info[] = {
-		{ 0x1fffff, "MPS statistics SRAM parity error", -1, 1 },
+	static const struct intr_details ios_intr_cause_quad1_details[] = {
+		{ Q1_MAILBOX_INT_ASSERT_F, "Etopus Quad1 Mailbox interrupt cause" },
+		{ 0x00f00000, "Etopus Quad1 training failure" },
+		{ 0x000f0000, "Etopus Quad1 training complete" },
+		{ 0x0000f000, "Etopus Quad1 AN TX interrupt" },
+		{ 0x00000f00, "Etopus Quad1 signal detect assertion" },
+		{ 0x000000f0, "Etopus Quad1 CDR LOL assertion" },
+		{ 0x0000000f, "Etopus Quad1 LOS signal assertion" },
 		{ 0 }
 	};
-	static const struct intr_info mps_stat_tx_intr_info[] = {
-		{ 0xfffff, "MPS statistics Tx FIFO parity error", -1, 1 },
+	static const struct intr_info mac_ios_int_cause_quad0 = {
+		.name = "MAC_IOS_INTR_CAUSE_QUAD0",
+		.cause_reg = MAC_IOS_INTR_CAUSE_QUAD0_A,
+		.enable_reg = MAC_IOS_INTR_EN_QUAD0_A,
+		.fatal = 0,
+		.flags = 0,
+		.details = ios_intr_cause_quad0_details,
+		.actions = NULL,
+	};
+	static const struct intr_info mac_ios_int_cause_quad1 = {
+		.name = "MAC_IOS_INTR_CAUSE_QUAD1",
+		.cause_reg = MAC_IOS_INTR_CAUSE_QUAD1_A,
+		.enable_reg = MAC_IOS_INTR_EN_QUAD1_A,
+		.fatal = 0,
+		.flags = 0,
+		.details = ios_intr_cause_quad1_details,
+		.actions = NULL,
+	};
+	static const struct intr_details mac_intr_details[] = {
+		{ TXFIFO_PRTY_ERR_F, "MAC Tx FIFO parity error" },
+		{ RXFIFO_PRTY_ERR_F, "MAC Rx FIFO parity error" },
 		{ 0 }
 	};
-	static const struct intr_info mps_stat_rx_intr_info[] = {
-		{ 0xffffff, "MPS statistics Rx FIFO parity error", -1, 1 },
+	static const struct intr_details t7_mac_int_cause_details[] = {
+		{ MAC2MPS_PERR_CAUSE_F, "MPS2MAC Data parity error per port" },
+		{ MAC_PPS_INT_CAUSE_F, "One second interrupt based on PTP timer" },
+		{ MAC_TX_TS_AVAIL_INT_CAUSE_F,
+			"Time stamp is available for the last IEEE 1588 event frame" },
+		{ MAC_PATDETWAKE_INT_CAUSE_F, "Wake up pattern match packet received" },
+		{ MAC_MAGIC_WAKE_INT_CAUSE_F, "Magic packet received" },
+		{ MAC_SIGDETCHG_INT_CAUSE_F, "Signal Detect Change" },
+		{ MAC_PCS_LINK_GOOD_CAUSE_F, "PCS link good (xaui pcsr or 1g)" },
+		{ MAC_PCS_LINK_FAIL_CAUSE_F, "PCS Failure (xaui pcsr or 1g)" },
+		{ RXFIFOOVERFLOW_F, "RX Fifo Over flow error" },
+		{ MAC_REM_FAULT_INT_CAUSE_F, "Remote fault received by XGMAC" },
+		{ MAC_LOC_FAULT_INT_CAUSE_F, "Local fault received by XGMAC" },
+		{ MAC_LINK_DOWN_INT_CAUSE_F, "Link is down" },
+		{ MAC_LINK_UP_INT_CAUSE_F, "Link is up" },
+		{ MAC_AN_DONE_INT_CAUSE_F, "Autonegotiation complete" },
+		{ MAC_AN_PGRD_INT_CAUSE_F, "An page received" },
+		{ MAC_TXFIFO_ERR_INT_CAUSE_F, "Tx FIFO parity error" },
+		{ MAC_RXFIFO_ERR_INT_CAUSE_F, "Rx FIFO parity error" },
 		{ 0 }
 	};
-	static const struct intr_info mps_cls_intr_info[] = {
-		{ MATCHSRAM_F, "MPS match SRAM parity error", -1, 1 },
-		{ MATCHTCAM_F, "MPS match TCAM parity error", -1, 1 },
-		{ HASHSRAM_F, "MPS hash SRAM parity error", -1, 1 },
+	static const struct intr_details mac_perr_int_cause_details[] = {
+		{ T6_PERR_PKT_RAM_F, "WoL packet data memory" },
+		{ T6_PERR_MASK_RAM_F, "WoL mask memory" },
+		{ T6_PERR_CRC_RAM_F, "WoL CRC memory" },
 		{ 0 }
 	};
 
-	int fat;
+	char name[32];
+	struct intr_info ii;
+	bool fatal = false;
 
-	fat = t4_handle_intr_status(adapter, MPS_RX_PERR_INT_CAUSE_A,
-				    mps_rx_intr_info) +
-	      t4_handle_intr_status(adapter, MPS_TX_INT_CAUSE_A,
-				    is_t6(adapter->params.chip)
-				    ? t6_mps_tx_intr_info
-				    : mps_tx_intr_info) +
-	      t4_handle_intr_status(adapter, MPS_TRC_INT_CAUSE_A,
-				    mps_trc_intr_info) +
-	      t4_handle_intr_status(adapter, MPS_STAT_PERR_INT_CAUSE_SRAM_A,
-				    mps_stat_sram_intr_info) +
-	      t4_handle_intr_status(adapter, MPS_STAT_PERR_INT_CAUSE_TX_FIFO_A,
-				    mps_stat_tx_intr_info) +
-	      t4_handle_intr_status(adapter, MPS_STAT_PERR_INT_CAUSE_RX_FIFO_A,
-				    mps_stat_rx_intr_info) +
-	      t4_handle_intr_status(adapter, MPS_CLS_INT_CAUSE_A,
-				    mps_cls_intr_info);
+	if (is_t4(adap->params.chip)) {
+		snprintf(name, sizeof(name), "XGMAC_PORT%u_INT_CAUSE", port);
+		ii.name = &name[0];
+		ii.cause_reg = PORT_REG(port, XGMAC_PORT_INT_CAUSE_A);
+		ii.enable_reg = PORT_REG(port, XGMAC_PORT_INT_EN_A);
+		ii.fatal = MAC2MPS_PERR_CAUSE_F | TXFIFO_PRTY_ERR_F | RXFIFO_PRTY_ERR_F;
+		ii.flags = NONFATAL_IF_DISABLED;
+		ii.details = mac_intr_details;
+		ii.actions = NULL;
+	} else if (CHELSIO_CHIP_VERSION(adap->params.chip) < CHELSIO_T7) {
+		snprintf(name, sizeof(name), "MAC_PORT%u_INT_CAUSE", port);
+		ii.name = &name[0];
+		ii.cause_reg = T5_PORT_REG(port, MAC_PORT_INT_CAUSE_A);
+		ii.enable_reg = T5_PORT_REG(port, MAC_PORT_INT_EN_A);
+		ii.fatal = MAC2MPS_PERR_CAUSE_F | TXFIFO_PRTY_ERR_F | RXFIFO_PRTY_ERR_F;
+		ii.flags = 0;
+		ii.details = mac_intr_details;
+		ii.actions = NULL;
+	} else {
+		snprintf(name, sizeof(name), "T7_MAC_PORT%u_INT_CAUSE", port);
+		ii.name = &name[0];
+		ii.cause_reg = T7_PORT_REG(port, T7_MAC_PORT_INT_CAUSE_A);
+		ii.enable_reg = T7_PORT_REG(port, T7_MAC_PORT_INT_EN_A);
+		ii.fatal = MAC2MPS_PERR_CAUSE_F | TXFIFO_PRTY_ERR_F | RXFIFO_PRTY_ERR_F;
+		ii.flags = NONFATAL_IF_DISABLED;
+		ii.details = t7_mac_int_cause_details;
+		ii.actions = NULL;
+	}
+	fatal |= t4_handle_intr(adap, &ii, 0, verbose);
+	if (is_t4(adap->params.chip))
+		return fatal;
+
+	snprintf(name, sizeof(name), "MAC_PORT%u_PERR_INT_CAUSE", port);
+
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) > CHELSIO_T6) {
+		ii.name = &name[0];
+		ii.cause_reg = T7_PORT_REG(port, T7_MAC_PORT_PERR_INT_CAUSE_A);
+		ii.enable_reg = T7_PORT_REG(port, T7_MAC_PORT_PERR_INT_EN_A);
+		ii.fatal = 0xffffffff;
+		ii.flags = NONFATAL_IF_DISABLED;
+		ii.details = mac_perr_int_cause_details;
+		ii.actions = NULL;
+	} else {
+		ii.name = &name[0];
+		ii.cause_reg = T5_PORT_REG(port, MAC_PORT_PERR_INT_CAUSE_A);
+		ii.enable_reg = T5_PORT_REG(port, MAC_PORT_PERR_INT_EN_A);
+		ii.fatal = 0xffffffff;
+		ii.flags = NONFATAL_IF_DISABLED;
+		ii.details = NULL;
+		ii.actions = NULL;
+	}
+	fatal |= t4_handle_intr(adap, &ii, 0, verbose);
+	if (is_t5(adap->params.chip))
+		return fatal;
+
+	snprintf(name, sizeof(name), "MAC_PORT%u_PERR_INT_CAUSE_100G", port);
+
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) > CHELSIO_T6) {
+		ii.name = &name[0];
+		ii.cause_reg = T7_PORT_REG(port, T7_MAC_PORT_PERR_INT_CAUSE_100G_A);
+		ii.enable_reg = T7_PORT_REG(port, T7_MAC_PORT_PERR_INT_EN_100G_A);
+		ii.fatal = 0xffffffff;
+		ii.flags = NONFATAL_IF_DISABLED;
+		ii.details = NULL;
+		ii.actions = NULL;
+	} else {
+		ii.name = &name[0];
+		ii.cause_reg = T5_PORT_REG(port, MAC_PORT_PERR_INT_CAUSE_100G_A);
+		ii.enable_reg = T5_PORT_REG(port, MAC_PORT_PERR_INT_EN_100G_A);
+		ii.fatal = 0xffffffff;
+		ii.flags = NONFATAL_IF_DISABLED;
+		ii.details = NULL;
+		ii.actions = NULL;
+	}
+	fatal |= t4_handle_intr(adap, &ii, 0, verbose);
+	if (is_t6(adap->params.chip))
+		return fatal;
+
+	fatal |= t4_handle_intr(adap, &mac_int_cause_cmn, 0, verbose);
+	fatal |= t4_handle_intr(adap, &mac_perr_cause_mtip, 0, verbose);
+	fatal |= t4_handle_intr(adap, &mac_ios_int_cause_quad0, 0, verbose);
+	fatal |= t4_handle_intr(adap, &mac_ios_int_cause_quad1, 0, verbose);
 
-	t4_write_reg(adapter, MPS_INT_CAUSE_A, 0);
-	t4_read_reg(adapter, MPS_INT_CAUSE_A);                    /* flush */
-	if (fat)
-		t4_fatal_err(adapter);
+	return fatal;
 }
 
-#define MEM_INT_MASK (PERR_INT_CAUSE_F | ECC_CE_INT_CAUSE_F | \
-		      ECC_UE_INT_CAUSE_F)
+static bool pl_timeout_status(struct adapter *adap, int arg, bool verbose)
+{
+	dev_alert(adap->pdev_dev, "    PL_TIMEOUT_STATUS 0x%08x 0x%08x\n",
+		  t4_read_reg(adap, PL_TIMEOUT_STATUS0_A),
+		  t4_read_reg(adap, PL_TIMEOUT_STATUS1_A));
+
+	return false;
+}
 
 /*
- * EDC/MC interrupt handler.
+ * PL interrupt handler.
  */
-static void mem_intr_handler(struct adapter *adapter, int idx)
+static bool plpl_intr_handler(struct adapter *adap, int arg, bool verbose)
 {
-	static const char name[4][7] = { "EDC0", "EDC1", "MC/MC0", "MC1" };
-
-	unsigned int addr, cnt_addr, v;
+	static const struct intr_details plpl_int_cause_fields[] = {
+		{ FATALPERR_F, "Fatal parity error" },
+		{ PERRVFID_F, "VFID_MAP parity error" },
+		{ 0 }
+	};
+	static const struct intr_details t5_plpl_int_cause_fields[] = {
+		{ PL_BUSPERR_F, "Bus parity error" },
+		{ FATALPERR_F, "Fatal parity error" },
+		{ INVALIDACCESS_F, "Global reserved memory access" },
+		{ TIMEOUT_F,  "Bus timeout" },
+		{ PLERR_F, "Module reserved access" },
+		{ 0 }
+	};
+	static const struct intr_action plpl_int_cause_actions[] = {
+		{ TIMEOUT_F, 0, pl_timeout_status },
+		{ 0 },
+	};
+	struct intr_info plpl_int_cause = {
+		.name = "PL_PL_INT_CAUSE",
+		.cause_reg = PL_PL_INT_CAUSE_A,
+		.enable_reg = PL_PL_INT_ENABLE_A,
+		.fatal = FATALPERR_F,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = NULL,
+		.actions = NULL,
+	};
 
-	if (idx <= MEM_EDC1) {
-		addr = EDC_REG(EDC_INT_CAUSE_A, idx);
-		cnt_addr = EDC_REG(EDC_ECC_STATUS_A, idx);
-	} else if (idx == MEM_MC) {
-		if (is_t4(adapter->params.chip)) {
-			addr = MC_INT_CAUSE_A;
-			cnt_addr = MC_ECC_STATUS_A;
-		} else {
-			addr = MC_P_INT_CAUSE_A;
-			cnt_addr = MC_P_ECC_STATUS_A;
-		}
+	if (is_t4(adap->params.chip)) {
+		plpl_int_cause.fatal |= PERRVFID_F;
+		plpl_int_cause.details = plpl_int_cause_fields;
 	} else {
-		addr = MC_REG(MC_P_INT_CAUSE_A, 1);
-		cnt_addr = MC_REG(MC_P_ECC_STATUS_A, 1);
+		plpl_int_cause.fatal |= INVALIDACCESS_F;
+		plpl_int_cause.details = t5_plpl_int_cause_fields;
+		plpl_int_cause.actions = plpl_int_cause_actions;
 	}
 
-	v = t4_read_reg(adapter, addr) & MEM_INT_MASK;
-	if (v & PERR_INT_CAUSE_F)
-		dev_alert(adapter->pdev_dev, "%s FIFO parity error\n",
-			  name[idx]);
-	if (v & ECC_CE_INT_CAUSE_F) {
-		u32 cnt = ECC_CECNT_G(t4_read_reg(adapter, cnt_addr));
-
-		t4_edc_err_read(adapter, idx);
-
-		t4_write_reg(adapter, cnt_addr, ECC_CECNT_V(ECC_CECNT_M));
-		if (printk_ratelimit())
-			dev_warn(adapter->pdev_dev,
-				 "%u %s correctable ECC data error%s\n",
-				 cnt, name[idx], str_plural(cnt));
-	}
-	if (v & ECC_UE_INT_CAUSE_F)
-		dev_alert(adapter->pdev_dev,
-			  "%s uncorrectable ECC data error\n", name[idx]);
+	return t4_handle_intr(adap, &plpl_int_cause, 0, verbose);
+}
 
-	t4_write_reg(adapter, addr, v);
-	if (v & (PERR_INT_CAUSE_F | ECC_UE_INT_CAUSE_F))
-		t4_fatal_err(adapter);
+/* similar to t4_port_reg */
+static u32 t7_tlstx_reg(u8 instance, u8 channel, u32 reg)
+{
+	return instance * (CRYPTO_1_BASE_ADDR - CRYPTO_0_BASE_ADDR) +
+		TLS_TX_CH_REG(reg, channel);
 }
 
 /*
- * MA interrupt handler.
+ * CRYPTO (aka TLS_TX) interrupt handler.
  */
-static void ma_intr_handler(struct adapter *adap)
+static bool tlstx_intr_handler(struct adapter *adap, int idx, bool verbose)
 {
-	u32 v, status = t4_read_reg(adap, MA_INT_CAUSE_A);
+	static const struct intr_details tlstx_int_cause_fields[] = {
+		{ KEX_CERR_F, "KEX SRAM Correctable error" },
+		{ KEYLENERR_F, "IPsec Key length error" },
+		{ INTF1_PERR_F, "Input Interface1 parity error" },
+		{ INTF0_PERR_F, "Input Interface0 parity error" },
+		{ KEX_PERR_F, "KEX SRAM Parity error" },
+		{ 0 }
+	};
+	struct intr_info ii = {
+		.fatal = KEX_PERR_F | INTF0_PERR_F | INTF1_PERR_F | KEYLENERR_F,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = tlstx_int_cause_fields,
+		.actions = NULL,
+	};
+	char name[32];
+	int ch;
+	bool fatal = false;
 
-	if (status & MEM_PERR_INT_CAUSE_F) {
-		dev_alert(adap->pdev_dev,
-			  "MA parity error, parity status %#x\n",
-			  t4_read_reg(adap, MA_PARITY_ERROR_STATUS1_A));
-		if (is_t5(adap->params.chip))
-			dev_alert(adap->pdev_dev,
-				  "MA parity error, parity status %#x\n",
-				  t4_read_reg(adap,
-					      MA_PARITY_ERROR_STATUS2_A));
-	}
-	if (status & MEM_WRAP_INT_CAUSE_F) {
-		v = t4_read_reg(adap, MA_INT_WRAP_STATUS_A);
-		dev_alert(adap->pdev_dev, "MA address wrap-around error by "
-			  "client %u to address %#x\n",
-			  MEM_WRAP_CLIENT_NUM_G(v),
-			  MEM_WRAP_ADDRESS_G(v) << 4);
-	}
-	t4_write_reg(adap, MA_INT_CAUSE_A, status);
-	t4_fatal_err(adap);
+	for (ch = 0; ch < NUM_TLS_TX_CH_INSTANCES; ch++) {
+		snprintf(name, sizeof(name), "tlstx%u_ch%u_int_cause", idx, ch);
+		ii.name = &name[0];
+		ii.cause_reg = t7_tlstx_reg(idx, ch, TLS_TX_CH_INT_CAUSE_A);
+		ii.enable_reg = t7_tlstx_reg(idx, ch, TLS_TX_CH_INT_ENABLE_A);
+		fatal |= t4_handle_intr(adap, &ii, 0, verbose);
+	}
+
+	return fatal;
 }
 
 /*
- * SMB interrupt handler.
- */
-static void smb_intr_handler(struct adapter *adap)
-{
-	static const struct intr_info smb_intr_info[] = {
-		{ MSTTXFIFOPARINT_F, "SMB master Tx FIFO parity error", -1, 1 },
-		{ MSTRXFIFOPARINT_F, "SMB master Rx FIFO parity error", -1, 1 },
-		{ SLVFIFOPARINT_F, "SMB slave FIFO parity error", -1, 1 },
+ * hma interrupt handler.
+ */
+static bool hma_intr_handler(struct adapter *adap, int idx, bool verbose)
+{
+	static const struct intr_details hma_int_cause_fields[] = {
+		{ GK_UF_INT_CAUSE_F, "Gatekeeper underflow" },
+		{ IDTF_INT_CAUSE_F, "Invalid descriptor fault" },
+		{ OTF_INT_CAUSE_F, "Offset translation fault" },
+		{ RTF_INT_CAUSE_F, "Region translation fault" },
+		{ PCIEMST_INT_CAUSE_F, "PCIe master access error" },
+		{ MAMST_INT_CAUSE_F, "MA master access error" },
+		{ PERR_INT_CAUSE_F, "FIFO parity error" },
 		{ 0 }
 	};
+	static const struct intr_info hma_int_cause = {
+		.name = "HMA_INT_CAUSE",
+		.cause_reg = HMA_INT_CAUSE_A,
+		.enable_reg = HMA_INT_ENABLE_A,
+		.fatal = 0xffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = hma_int_cause_fields,
+		.actions = NULL,
+	};
 
-	if (t4_handle_intr_status(adap, SMB_INT_CAUSE_A, smb_intr_info))
-		t4_fatal_err(adap);
+	return t4_handle_intr(adap, &hma_int_cause, 0, verbose);
 }
 
 /*
- * NC-SI interrupt handler.
- */
-static void ncsi_intr_handler(struct adapter *adap)
-{
-	static const struct intr_info ncsi_intr_info[] = {
-		{ CIM_DM_PRTY_ERR_F, "NC-SI CIM parity error", -1, 1 },
-		{ MPS_DM_PRTY_ERR_F, "NC-SI MPS parity error", -1, 1 },
-		{ TXFIFO_PRTY_ERR_F, "NC-SI Tx FIFO parity error", -1, 1 },
-		{ RXFIFO_PRTY_ERR_F, "NC-SI Rx FIFO parity error", -1, 1 },
+ * CRYPTO_KEY interrupt handler.
+ */
+static bool cryptokey_intr_handler(struct adapter *adap, int idx, bool verbose)
+{
+	static const struct intr_details cryptokey_int_cause_fields[] = {
+		{ MA_FIFO_PERR_F, "MA arbiter FIFO parity error" },
+		{ MA_RSP_PERR_F, "MA response IF parity error" },
+		{ ING_CACHE_DATA_PERR_F, "Ingress key cache data parity error" },
+		{ ING_CACHE_TAG_PERR_F, "Ingress key cache tag parity error" },
+		{ LKP_KEY_REQ_PERR_F, "Ingress key req parity error" },
+		{ LKP_CLIP_TCAM_PERR_F, "Ingress LKP CLIP TCAM parity error" },
+		{ LKP_MAIN_TCAM_PERR_F, "Ingress LKP main TCAM parity error" },
+		{ EGR_KEY_REQ_PERR_F, "Egress key req or FIFO3 parity error" },
+		{ EGR_CACHE_DATA_PERR_F, "Egress key cache data parity error" },
+		{ EGR_CACHE_TAG_PERR_F, "Egress key cache tag parity error" },
+		{ CIM_PERR_F, "CIM interface parity error" },
+		{ MA_INV_RSP_TAG_F, "MA invalid response tag" },
+		{ ING_KEY_RANGE_ERR_F, "Ingress key range error" },
+		{ ING_MFIFO_OVFL_F, "Ingress MFIFO overflow" },
+		{ LKP_REQ_OVFL_F, "Ingress lookup FIFO overflow" },
+		{ EOK_WAIT_ERR_F, "EOK wait error" },
+		{ EGR_KEY_RANGE_ERR_F, "Egress key range error" },
+		{ EGR_MFIFO_OVFL_F, "Egress MFIFO overflow" },
+		{ SEQ_WRAP_HP_OVFL_F, "Sequence wrap (hi-pri)" },
+		{ SEQ_WRAP_LP_OVFL_F, "Sequence wrap (lo-pri)" },
+		{ EGR_SEQ_WRAP_HP_F, "Egress sequence wrap (hi-pri)" },
+		{ EGR_SEQ_WRAP_LP_F, "Egress sequence wrap (lo-pri)" },
 		{ 0 }
 	};
+	static const struct intr_info cryptokey_int_cause = {
+		.name = "CRYPTO_KEY_INT_CAUSE",
+		.cause_reg = CRYPTO_KEY_INT_CAUSE_A,
+		.enable_reg = CRYPTO_KEY_INT_ENABLE_A,
+		.fatal = 0xfffffff0,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = cryptokey_int_cause_fields,
+		.actions = NULL,
+	};
 
-	if (t4_handle_intr_status(adap, NCSI_INT_CAUSE_A, ncsi_intr_info))
-		t4_fatal_err(adap);
+	return t4_handle_intr(adap, &cryptokey_int_cause, 0, verbose);
 }
 
 /*
- * XGMAC interrupt handler.
- */
-static void xgmac_intr_handler(struct adapter *adap, int port)
-{
-	u32 v, int_cause_reg;
+ * GCACHE interrupt handler.
+ */
+static bool gcache_intr_handler(struct adapter *adap, int idx, bool verbose)
+{
+	static const struct intr_details gcache_int_cause_fields[] = {
+		{ GC1_SRAM_RSP_DATAQ_PERR_INT_CAUSE_F, "GC1 SRAM rsp dataq perr" },
+		{ GC0_SRAM_RSP_DATAQ_PERR_INT_CAUSE_F, "GC0 SRAM rsp dataq perr" },
+		{ GC1_WQDATA_FIFO_PERR_INT_CAUSE_F, "GC1 wqdata FIFO perr" },
+		{ GC0_WQDATA_FIFO_PERR_INT_CAUSE_F, "GC0 wqdata FIFO perr" },
+		{ GC1_RDTAG_QUEUE_PERR_INT_CAUSE_F, "GC1 rdtag queue perr" },
+		{ GC0_RDTAG_QUEUE_PERR_INT_CAUSE_F, "GC0 rdtag queue perr" },
+		{ GC1_SRAM_RDTAG_QUEUE_PERR_INT_CAUSE_F, "GC1 SRAM rdtag queue perr" },
+		{ GC0_SRAM_RDTAG_QUEUE_PERR_INT_CAUSE_F, "GC0 SRAM rdtag queue perr" },
+		{ GC1_RSP_PERR_INT_CAUSE_F, "GC1 rsp perr" },
+		{ GC0_RSP_PERR_INT_CAUSE_F, "GC0 rsp perr" },
+		{ GC1_LRU_UERR_INT_CAUSE_F, "GC1 lru uerr" },
+		{ GC0_LRU_UERR_INT_CAUSE_F, "GC0 lru uerr" },
+		{ GC1_TAG_UERR_INT_CAUSE_F, "GC1 tag uerr" },
+		{ GC0_TAG_UERR_INT_CAUSE_F, "GC0 tag uerr" },
+		{ GC1_LRU_CERR_INT_CAUSE_F, "GC1 lru cerr" },
+		{ GC0_LRU_CERR_INT_CAUSE_F, "GC0 lru cerr" },
+		{ GC1_TAG_CERR_INT_CAUSE_F, "GC1 tag cerr" },
+		{ GC0_TAG_CERR_INT_CAUSE_F, "GC0 tag cerr" },
+		{ GC1_CE_INT_CAUSE_F, "GC1 correctable error" },
+		{ GC0_CE_INT_CAUSE_F, "GC0 correctable error" },
+		{ GC1_UE_INT_CAUSE_F, "GC1 uncorrectable error" },
+		{ GC0_UE_INT_CAUSE_F, "GC0 uncorrectable error" },
+		{ GC1_CMD_PAR_INT_CAUSE_F, "GC1 cmd perr" },
+		{ GC1_DATA_PAR_INT_CAUSE_F, "GC1 data perr" },
+		{ GC0_CMD_PAR_INT_CAUSE_F, "GC0 cmd perr" },
+		{ GC0_DATA_PAR_INT_CAUSE_F, "GC0 data perr" },
+		{ ILLADDRACCESS1_INT_CAUSE_F, "GC1 illegal address access" },
+		{ ILLADDRACCESS0_INT_CAUSE_F, "GC0 illegal address access" },
+		{ 0 }
+	};
+	static const struct intr_info gcache_int_cause = {
+		.name = "GCACHE_INT_CAUSE",
+		.cause_reg = GCACHE_INT_CAUSE_A,
+		.enable_reg = GCACHE_INT_ENABLE_A,
+		.fatal = 0xffffc0ff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = gcache_int_cause_fields,
+		.actions = NULL,
+	};
+	bool fatal = false;
 
-	if (is_t4(adap->params.chip))
-		int_cause_reg = PORT_REG(port, XGMAC_PORT_INT_CAUSE_A);
-	else
-		int_cause_reg = T5_PORT_REG(port, MAC_PORT_INT_CAUSE_A);
+	fatal |= t4_handle_intr(adap, &gcache_int_cause, 0, verbose);
 
-	v = t4_read_reg(adap, int_cause_reg);
+	return fatal;
+}
 
-	v &= TXFIFO_PRTY_ERR_F | RXFIFO_PRTY_ERR_F;
-	if (!v)
-		return;
+static u32 get_perr_ucause(struct adapter *adap, const struct intr_info *ii)
+{
+	u32 cause;
 
-	if (v & TXFIFO_PRTY_ERR_F)
-		dev_alert(adap->pdev_dev, "XGMAC %d Tx FIFO parity error\n",
-			  port);
-	if (v & RXFIFO_PRTY_ERR_F)
-		dev_alert(adap->pdev_dev, "XGMAC %d Rx FIFO parity error\n",
-			  port);
-	t4_write_reg(adap, PORT_REG(port, XGMAC_PORT_INT_CAUSE_A), v);
-	t4_fatal_err(adap);
+	cause = t4_read_reg(adap, ii->cause_reg);
+	cause &= t4_read_reg(adap, ii->enable_reg);
+	return cause;
 }
 
-/*
- * PL interrupt handler.
- */
-static void pl_intr_handler(struct adapter *adap)
+static uint32_t
+t4_perr_to_ic(struct adapter *adap, uint32_t perr)
 {
-	static const struct intr_info pl_intr_info[] = {
-		{ FATALPERR_F, "T4 fatal parity error", -1, 1 },
-		{ PERRVFID_F, "PL VFID_MAP parity error", -1, 1 },
-		{ 0 }
-	};
+	u32 mask;
 
-	if (t4_handle_intr_status(adap, PL_PL_INT_CAUSE_A, pl_intr_info))
-		t4_fatal_err(adap);
+	if (adap->params.arch.nchan > 2)
+		mask = MAC0_F | MAC1_F | MAC2_F | MAC3_F;
+	else
+		mask = MAC0_F | MAC1_F;
+	return (perr & mask ? perr | mask : perr);
+}
+
+static uint32_t t7_perr_to_ic1(uint32_t perr)
+{
+	u32 cause = 0;
+
+	if (perr & T7_PL_PERR_ULP_TX_F)
+		cause |= T7_ULP_TX_F;
+	if (perr & T7_PL_PERR_SGE_F)
+		cause |= T7_SGE_F;
+	if (perr & T7_PL_PERR_HMA_F)
+		cause |= T7_HMA_F;
+	if (perr & T7_PL_PERR_CPL_SWITCH_F)
+		cause |= T7_CPL_SWITCH_F;
+	if (perr & T7_PL_PERR_ULP_RX_F)
+		cause |= T7_ULP_RX_F;
+	if (perr & T7_PL_PERR_PM_RX_F)
+		cause |= T7_PM_RX_F;
+	if (perr & T7_PL_PERR_PM_TX_F)
+		cause |= T7_PM_TX_F;
+	if (perr & T7_PL_PERR_MA_F)
+		cause |= T7_MA_F;
+	if (perr & T7_PL_PERR_TP_F)
+		cause |= T7_TP_F;
+	if (perr & T7_PL_PERR_LE_F)
+		cause |= T7_LE_F;
+	if (perr & T7_PL_PERR_EDC1_F)
+		cause |= T7_EDC1_F;
+	if (perr & T7_PL_PERR_EDC0_F)
+		cause |= T7_EDC0_F;
+	if (perr & T7_PL_PERR_MC1_F)
+		cause |= T7_MC1_F;
+	if (perr & T7_PL_PERR_MC0_F)
+		cause |= T7_MC0_F;
+	if (perr & T7_PL_PERR_PCIE_F)
+		cause |= T7_PCIE_F;
+	if (perr & T7_PL_PERR_UART_F)
+		cause |= T7_UART_F;
+	if (perr & T7_PL_PERR_PMU_F)
+		cause |= PMU_F;
+	if (perr & T7_PL_PERR_MAC_F)
+		cause |= MAC0_F | MAC1_F | MAC2_F | MAC3_F;
+	if (perr & T7_PL_PERR_SMB_F)
+		cause |= SMB_F;
+	if (perr & T7_PL_PERR_SF_F)
+		cause |= SF_F;
+	if (perr & T7_PL_PERR_PL_F)
+		cause |= PL_F;
+	if (perr & T7_PL_PERR_NCSI_F)
+		cause |= NCSI_F;
+	if (perr & T7_PL_PERR_MPS_F)
+		cause |= MPS_F;
+	if (perr & T7_PL_PERR_MI_F)
+		cause |= MI_F;
+	if (perr & T7_PL_PERR_DBG_F)
+		cause |= DBG_F;
+	if (perr & T7_PL_PERR_I2CM_F)
+		cause |= I2CM_F;
+	if (perr & T7_PL_PERR_CIM_F)
+		cause |= CIM_F;
+
+	return cause;
+}
+
+static uint32_t t7_perr_to_ic2(uint32_t perr)
+{
+	u32 cause = 0;
+
+	if (perr & T7_PL_PERR_CRYPTO_KEY_F)
+		cause |= CRYPTO_KEY_F;
+	if (perr & T7_PL_PERR_CRYPTO1_F)
+		cause |= CRYPTO1_F;
+	if (perr & T7_PL_PERR_CRYPTO0_F)
+		cause |= CRYPTO0_F;
+	if (perr & T7_PL_PERR_GCACHE_F)
+		cause |= GCACHE_F;
+
+	return cause;
 }
 
-#define PF_INTR_MASK (PFSW_F)
-#define GLBL_INTR_MASK (CIM_F | MPS_F | PL_F | PCIE_F | MC_F | EDC0_F | \
-		EDC1_F | LE_F | TP_F | MA_F | PM_TX_F | PM_RX_F | ULP_RX_F | \
-		CPL_SWITCH_F | SGE_F | ULP_TX_F | SF_F)
-
 /**
  *	t4_slow_intr_handler - control path interrupt handler
- *	@adapter: the adapter
+ *	@adap: the adapter
+ *	@verbose: increased verbosity, for debug
  *
  *	T4 interrupt handler for non-data global interrupt events, e.g., errors.
  *	The designation 'slow' is because it involves register reads, while
  *	data interrupts typically don't involve any MMIOs.
  */
-int t4_slow_intr_handler(struct adapter *adapter)
-{
-	/* There are rare cases where a PL_INT_CAUSE bit may end up getting
-	 * set when the corresponding PL_INT_ENABLE bit isn't set.  It's
-	 * easiest just to mask that case here.
-	 */
-	u32 raw_cause = t4_read_reg(adapter, PL_INT_CAUSE_A);
-	u32 enable = t4_read_reg(adapter, PL_INT_ENABLE_A);
-	u32 cause = raw_cause & enable;
+int t4_slow_intr_handler(struct adapter *adap, bool verbose)
+{
+	static const struct intr_details pl_int_cause_fields[] = {
+		{ MC1_F, "MC1" },
+		{ UART_F, "UART" },
+		{ ULP_TX_F, "ULP TX" },
+		{ SGE_F, "SGE" },
+		{ HMA_F, "HMA" },
+		{ CPL_SWITCH_F, "CPL Switch" },
+		{ ULP_RX_F, "ULP RX" },
+		{ PM_RX_F, "PM RX" },
+		{ PM_TX_F, "PM TX" },
+		{ MA_F, "MA" },
+		{ TP_F, "TP" },
+		{ LE_F, "LE" },
+		{ EDC1_F, "EDC1" },
+		{ EDC0_F, "EDC0" },
+		{ MC_F, "MC0" },
+		{ PCIE_F, "PCIE" },
+		{ PMU_F, "PMU" },
+		{ MAC3_F, "MAC3" },
+		{ MAC2_F, "MAC2" },
+		{ MAC1_F, "MAC1" },
+		{ MAC0_F, "MAC0" },
+		{ SMB_F, "SMB" },
+		{ SF_F, "SF" },
+		{ PL_F, "PL" },
+		{ NCSI_F, "NC-SI" },
+		{ MPS_F, "MPS" },
+		{ MI_F, "MI" },
+		{ DBG_F, "DBG" },
+		{ I2CM_F, "I2CM" },
+		{ CIM_F, "CIM" },
+		{ 0 }
+	};
+	static const struct intr_action pl_int_cause_actions[] = {
+		{ ULP_TX_F, -1, ulptx_intr_handler },
+		{ SGE_F, -1, sge_intr_handler },
+		{ CPL_SWITCH_F, -1, cplsw_intr_handler },
+		{ ULP_RX_F, -1, ulprx_intr_handler },
+		{ PM_RX_F, -1, pmrx_intr_handler },
+		{ PM_TX_F, -1, pmtx_intr_handler },
+		{ MA_F, -1, ma_intr_handler },
+		{ TP_F, -1, tp_intr_handler },
+		{ LE_F, -1, le_intr_handler },
+		{ EDC0_F, MEM_EDC0, mem_intr_handler },
+		{ EDC1_F, MEM_EDC1, mem_intr_handler },
+		{ MC0_F, MEM_MC0, mem_intr_handler },
+		{ MC1_F, MEM_MC1, mem_intr_handler },
+		{ PCIE_F, -1, pcie_intr_handler },
+		{ MAC0_F, 0, mac_intr_handler },
+		{ MAC1_F, 1, mac_intr_handler },
+		{ MAC2_F, 2, mac_intr_handler },
+		{ MAC3_F, 3, mac_intr_handler },
+		{ SMB_F, -1, smb_intr_handler },
+		{ PL_F, -1, plpl_intr_handler },
+		{ NCSI_F, -1, ncsi_intr_handler },
+		{ MPS_F, -1, mps_intr_handler },
+		{ CIM_F, -1, cim_intr_handler },
+		{ 0 }
+	};
+	static const struct intr_info pl_int_cause = {
+		.name = "PL_INT_CAUSE",
+		.cause_reg = PL_INT_CAUSE_A,
+		.enable_reg = PL_INT_ENABLE_A,
+		.fatal = 0,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = pl_int_cause_fields,
+		.actions = pl_int_cause_actions,
+	};
+	static const struct intr_info pl_perr_cause = {
+		.name = "PL_PERR_CAUSE",
+		.cause_reg = PL_PERR_CAUSE_A,
+		.enable_reg = PL_PERR_ENABLE_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = pl_int_cause_fields,
+		.actions = NULL,
+	};
+	static const struct intr_details t7_pl_int_cause_fields[] = {
+		{ T7_FLR_F, "FLR" },
+		{ T7_SW_CIM_F, "SW CIM" },
+		{ T7_ULP_TX_F, "ULP TX" },
+		{ T7_SGE_F, "SGE" },
+		{ T7_HMA_F, "HMA" },
+		{ T7_CPL_SWITCH_F, "CPL Switch" },
+		{ T7_ULP_RX_F, "ULP RX" },
+		{ T7_PM_RX_F, "PM RX" },
+		{ T7_PM_TX_F, "PM TX" },
+		{ T7_MA_F, "MA" },
+		{ T7_TP_F, "TP" },
+		{ T7_LE_F, "LE" },
+		{ T7_EDC1_F, "EDC1" },
+		{ T7_EDC0_F, "EDC0" },
+		{ T7_MC1_F, "MC1" },
+		{ T7_MC0_F, "MC0" },
+		{ T7_PCIE_F, "PCIE" },
+		{ T7_UART_F, "UART" },
+		{ PMU_F, "PMU" },
+		{ MAC3_F, "MAC3" },
+		{ MAC2_F, "MAC2" },
+		{ MAC1_F, "MAC1" },
+		{ MAC0_F, "MAC0" },
+		{ SMB_F, "SMB" },
+		{ SF_F, "SF" },
+		{ PL_F, "PL" },
+		{ NCSI_F, "NC-SI" },
+		{ MPS_F, "MPS" },
+		{ MI_F, "MI" },
+		{ DBG_F, "DBG" },
+		{ I2CM_F, "I2CM" },
+		{ CIM_F, "CIM" },
+		{ 0 }
+	};
+	static const struct intr_action t7_pl_int_cause_actions[] = {
+		{ T7_ULP_TX_F, -1, ulptx_intr_handler },
+		{ T7_SGE_F, -1, sge_intr_handler },
+		{ T7_HMA_F, -1, hma_intr_handler },
+		{ T7_CPL_SWITCH_F, -1, cplsw_intr_handler },
+		{ T7_ULP_RX_F, -1, ulprx_intr_handler },
+		{ T7_PM_RX_F, -1, pmrx_intr_handler},
+		{ T7_PM_TX_F, -1, pmtx_intr_handler},
+		{ T7_MA_F, -1, ma_intr_handler },
+		{ T7_TP_F, -1, tp_intr_handler },
+		{ T7_LE_F, -1, le_intr_handler },
+		{ T7_EDC0_F, MEM_EDC0, mem_intr_handler },
+		{ T7_EDC1_F, MEM_EDC1, mem_intr_handler },
+		{ T7_MC0_F, MEM_MC0, mem_intr_handler },
+		{ T7_MC1_F, MEM_MC1, mem_intr_handler },
+		{ T7_PCIE_F, -1, pcie_intr_handler },
+		{ MAC0_F, 0, mac_intr_handler},
+		{ MAC1_F, 1, mac_intr_handler},
+		{ MAC2_F, 2, mac_intr_handler},
+		{ MAC3_F, 3, mac_intr_handler},
+		{ SMB_F, -1, smb_intr_handler},
+		{ PL_F, -1, plpl_intr_handler },
+		{ NCSI_F, -1, ncsi_intr_handler},
+		{ MPS_F, -1, mps_intr_handler },
+		{ CIM_F, -1, cim_intr_handler },
+		{ 0 }
+	};
+	static const struct intr_info t7_pl_int_cause = {
+		.name = "PL_INT_CAUSE",
+		.cause_reg = PL_INT_CAUSE_A,
+		.enable_reg = PL_INT_ENABLE_A,
+		.fatal = 0,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = t7_pl_int_cause_fields,
+		.actions = t7_pl_int_cause_actions,
+	};
+	static const struct intr_details t7_pl_int_cause2_fields[] = {
+		{ CRYPTO_KEY_F, "CRYPTO KEY" },
+		{ CRYPTO1_F, "CRYPTO1" },
+		{ CRYPTO0_F, "CRYPTO0" },
+		{ GCACHE_F, "GCACHE" },
+		{ 0 }
+	};
+	static const struct intr_action t7_pl_int_cause2_actions[] = {
+		{ CRYPTO_KEY_F, -1, cryptokey_intr_handler },
+		{ CRYPTO1_F, 1, tlstx_intr_handler },
+		{ CRYPTO0_F, 0, tlstx_intr_handler },
+		{ GCACHE_F, -1, gcache_intr_handler },
+		{ 0 }
+	};
+	static const struct intr_info t7_pl_int_cause2 = {
+		.name = "PL_INT_CAUSE2",
+		.cause_reg = PL_INT_CAUSE2_A,
+		.enable_reg = PL_INT_ENABLE2_A,
+		.fatal = 0,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = t7_pl_int_cause2_fields,
+		.actions = t7_pl_int_cause2_actions,
+	};
+	static const struct intr_details t7_pl_perr_cause_fields[] = {
+		{ T7_PL_PERR_CRYPTO_KEY_F, "CRYPTO KEY" },
+		{ T7_PL_PERR_CRYPTO1_F, "CRYPTO1" },
+		{ T7_PL_PERR_CRYPTO0_F, "CRYPTO0" },
+		{ T7_PL_PERR_GCACHE_F, "GCACHE" },
+		{ T7_PL_PERR_ULP_TX_F, "ULP TX" },
+		{ T7_PL_PERR_SGE_F, "SGE" },
+		{ T7_PL_PERR_HMA_F, "HMA" },
+		{ T7_PL_PERR_CPL_SWITCH_F, "CPL Switch" },
+		{ T7_PL_PERR_ULP_RX_F, "ULP RX" },
+		{ T7_PL_PERR_PM_RX_F, "PM RX" },
+		{ T7_PL_PERR_PM_TX_F, "PM TX" },
+		{ T7_PL_PERR_MA_F, "MA" },
+		{ T7_PL_PERR_TP_F, "TP" },
+		{ T7_PL_PERR_LE_F, "LE" },
+		{ T7_PL_PERR_EDC1_F, "EDC1" },
+		{ T7_PL_PERR_EDC0_F, "EDC0" },
+		{ T7_PL_PERR_MC1_F, "MC1" },
+		{ T7_PL_PERR_MC0_F, "MC0" },
+		{ T7_PL_PERR_PCIE_F, "PCIE" },
+		{ T7_PL_PERR_UART_F, "UART" },
+		{ T7_PL_PERR_PMU_F, "PMU" },
+		{ T7_PL_PERR_MAC_F, "MAC" },
+		{ T7_PL_PERR_SMB_F, "SMB" },
+		{ T7_PL_PERR_SF_F, "SF" },
+		{ T7_PL_PERR_PL_F, "PL" },
+		{ T7_PL_PERR_NCSI_F, "NC-SI" },
+		{ T7_PL_PERR_MPS_F, "MPS" },
+		{ T7_PL_PERR_MI_F, "MI" },
+		{ T7_PL_PERR_DBG_F, "DBG" },
+		{ T7_PL_PERR_I2CM_F, "I2CM" },
+		{ T7_PL_PERR_CIM_F, "CIM" },
+		{ 0 }
+	};
+	static const struct intr_info t7_pl_perr_cause = {
+		.name = "PL_PERR_CAUSE",
+		.cause_reg = PL_PERR_CAUSE_A,
+		.enable_reg = PL_PERR_ENABLE_A,
+		.fatal = 0xffffffff,
+		.flags = NONFATAL_IF_DISABLED,
+		.details = t7_pl_perr_cause_fields,
+		.actions = NULL,
+	};
+	bool fatal = false;
+	u32 perr;
+
+	if (CHELSIO_CHIP_VERSION(adap->params.chip) < CHELSIO_T7) {
+		perr = get_perr_ucause(adap, &pl_perr_cause);
+		fatal |= t4_handle_intr(adap, &pl_perr_cause, 0, verbose);
+		fatal |= t4_handle_intr(adap, &pl_int_cause,
+				t4_perr_to_ic(adap, perr), verbose);
+		t4_write_reg(adap, pl_perr_cause.cause_reg, perr);
+		(void)t4_read_reg(adap, pl_perr_cause.cause_reg);
+	} else {
+		perr = get_perr_ucause(adap, &t7_pl_perr_cause);
+		fatal |= t4_handle_intr(adap, &t7_pl_perr_cause, 0, verbose);
+		fatal |= t4_handle_intr(adap, &t7_pl_int_cause,
+				t7_perr_to_ic1(perr), verbose);
+		fatal |= t4_handle_intr(adap, &t7_pl_int_cause2,
+				t7_perr_to_ic2(perr), verbose);
+		t4_write_reg(adap, t7_pl_perr_cause.cause_reg, perr);
+		(void)t4_read_reg(adap, t7_pl_perr_cause.cause_reg);
+	}
 
-	if (!(cause & GLBL_INTR_MASK))
-		return 0;
-	if (cause & CIM_F)
-		cim_intr_handler(adapter);
-	if (cause & MPS_F)
-		mps_intr_handler(adapter);
-	if (cause & NCSI_F)
-		ncsi_intr_handler(adapter);
-	if (cause & PL_F)
-		pl_intr_handler(adapter);
-	if (cause & SMB_F)
-		smb_intr_handler(adapter);
-	if (cause & XGMAC0_F)
-		xgmac_intr_handler(adapter, 0);
-	if (cause & XGMAC1_F)
-		xgmac_intr_handler(adapter, 1);
-	if (cause & XGMAC_KR0_F)
-		xgmac_intr_handler(adapter, 2);
-	if (cause & XGMAC_KR1_F)
-		xgmac_intr_handler(adapter, 3);
-	if (cause & PCIE_F)
-		pcie_intr_handler(adapter);
-	if (cause & MC_F)
-		mem_intr_handler(adapter, MEM_MC);
-	if (is_t5(adapter->params.chip) && (cause & MC1_F))
-		mem_intr_handler(adapter, MEM_MC1);
-	if (cause & EDC0_F)
-		mem_intr_handler(adapter, MEM_EDC0);
-	if (cause & EDC1_F)
-		mem_intr_handler(adapter, MEM_EDC1);
-	if (cause & LE_F)
-		le_intr_handler(adapter);
-	if (cause & TP_F)
-		tp_intr_handler(adapter);
-	if (cause & MA_F)
-		ma_intr_handler(adapter);
-	if (cause & PM_TX_F)
-		pmtx_intr_handler(adapter);
-	if (cause & PM_RX_F)
-		pmrx_intr_handler(adapter);
-	if (cause & ULP_RX_F)
-		ulprx_intr_handler(adapter);
-	if (cause & CPL_SWITCH_F)
-		cplsw_intr_handler(adapter);
-	if (cause & SGE_F)
-		sge_intr_handler(adapter);
-	if (cause & ULP_TX_F)
-		ulptx_intr_handler(adapter);
-
-	/* Clear the interrupts just processed for which we are the master. */
-	t4_write_reg(adapter, PL_INT_CAUSE_A, raw_cause & GLBL_INTR_MASK);
-	(void)t4_read_reg(adapter, PL_INT_CAUSE_A); /* flush */
-	return 1;
+	return fatal;
 }
 
 /**
@@ -5078,19 +8209,28 @@ void t4_intr_enable(struct adapter *adapter)
 {
 	u32 val = 0;
 	u32 whoami = t4_read_reg(adapter, PL_WHOAMI_A);
-	u32 pf = CHELSIO_CHIP_VERSION(adapter->params.chip) <= CHELSIO_T5 ?
-			SOURCEPF_G(whoami) : T6_SOURCEPF_G(whoami);
+	u32 pf = (CHELSIO_CHIP_VERSION(adapter->params.chip) <= CHELSIO_T5
+		  ? SOURCEPF_G(whoami)
+		  : T6_SOURCEPF_G(whoami));
 
 	if (CHELSIO_CHIP_VERSION(adapter->params.chip) <= CHELSIO_T5)
 		val = ERR_DROPPED_DB_F | ERR_EGR_CTXT_PRIO_F | DBFIFO_HP_INT_F;
-	t4_write_reg(adapter, SGE_INT_ENABLE3_A, ERR_CPL_EXCEED_IQE_SIZE_F |
-		     ERR_INVALID_CIDX_INC_F | ERR_CPL_OPCODE_0_F |
-		     ERR_DATA_CPL_ON_HIGH_QID1_F | INGRESS_SIZE_ERR_F |
-		     ERR_DATA_CPL_ON_HIGH_QID0_F | ERR_BAD_DB_PIDX3_F |
-		     ERR_BAD_DB_PIDX2_F | ERR_BAD_DB_PIDX1_F |
-		     ERR_BAD_DB_PIDX0_F | ERR_ING_CTXT_PRIO_F |
-		     DBFIFO_LP_INT_F | EGRESS_SIZE_ERR_F | val);
-	t4_write_reg(adapter, MYPF_REG(PL_PF_INT_ENABLE_A), PF_INTR_MASK);
+	else
+		val = ERR_PCIE_ERROR0_F | ERR_PCIE_ERROR1_F | FATAL_WRE_LEN_F;
+
+	val |=	ERR_CPL_EXCEED_IQE_SIZE_F |
+		ERR_INVALID_CIDX_INC_F | ERR_CPL_OPCODE_0_F |
+		ERR_DATA_CPL_ON_HIGH_QID1_F | INGRESS_SIZE_ERR_F |
+		ERR_DATA_CPL_ON_HIGH_QID0_F | ERR_BAD_DB_PIDX3_F |
+		ERR_BAD_DB_PIDX2_F | ERR_BAD_DB_PIDX1_F |
+		ERR_BAD_DB_PIDX0_F | ERR_ING_CTXT_PRIO_F |
+		DBFIFO_LP_INT_F | EGRESS_SIZE_ERR_F;
+
+	t4_write_reg(adapter, SGE_INT_ENABLE3_A, val);
+	if (CHELSIO_CHIP_VERSION(adapter->params.chip) >= CHELSIO_T7)
+		t4_write_reg(adapter, SGE_INT_ENABLE4_A, 0xffffffff);
+	t4_write_reg(adapter, MYPF_REG(PL_PF_INT_ENABLE_A), PFSW_F | PFCIM_F);
+	t4_set_reg_field(adapter, PL_INT_ENABLE_A, SF_F | I2CM_F, 0);
 	t4_set_reg_field(adapter, PL_INT_MAP0_A, 0, 1 << pf);
 }
 
@@ -5106,9 +8246,6 @@ void t4_intr_disable(struct adapter *adapter)
 {
 	u32 whoami, pf;
 
-	if (pci_channel_offline(adapter->pdev))
-		return;
-
 	whoami = t4_read_reg(adapter, PL_WHOAMI_A);
 	pf = CHELSIO_CHIP_VERSION(adapter->params.chip) <= CHELSIO_T5 ?
 			SOURCEPF_G(whoami) : T6_SOURCEPF_G(whoami);
-- 
2.39.1

