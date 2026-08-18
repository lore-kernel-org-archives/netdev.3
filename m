Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E23F149C7B
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 02:31:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787020315; cv=none; b=NJ0Z1wxIhxAybtznVy964KGMUxoUpddUrbUQDapdIwsK/OPLJfd3AZA+P7HqdkUy4pyijQ73dhAfVPKc0DrJRbI0/1sTQEZ6Tz7uhxPzPlFTx8B1gjD2roCRM/ggXB4tf74gB6lTlOVfOnPVRAIDmNVb9G2o5cKbHFToEkIeUyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787020315; c=relaxed/simple;
	bh=cnwqki9VaKabIaDmylDoqbBQHsFrOgXi7lOXX3pikZk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O6Of2mz4XDJ2l1aC2BZPfj3ikHUUdKKBoAnt4kiCXG7vxen1eyxsLE7WVB467ktx8Wm/7JuuWgBp60QFkXYream3yUQud2tilfhi9h4qOK+79Bs0U9CGSxcZtvN4H+7ProDpJqpPDMminBZD2arM1DayuJnvnKdI2x/A7fpk8SI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com; spf=pass smtp.mailfrom=trustnetic.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=trustnetic.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trustnetic.com
X-QQ-mid: zesmtpgz1t1787020238te2f5f96c
X-QQ-Originating-IP: B7fOztBtV78a4famvyg5jId7jOiVdEq2av0YdEamRGc=
Received: from w-MS-7E16.trustnetic.com ( [36.24.185.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Aug 2026 10:30:32 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4349593291174078095
EX-QQ-RecipientCnt: 10
From: Jiawen Wu <jiawenwu@trustnetic.com>
To: netdev@vger.kernel.org
Cc: Mengyuan Lou <mengyuanlou@net-swift.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Larysa Zaremba <larysa.zaremba@intel.com>,
	Jiawen Wu <jiawenwu@trustnetic.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v2] net: txgbe: fix MISC interrupt unmasking in non-MSI-X mode and device shutdown
Date: Tue, 18 Aug 2026 10:30:26 +0800
Message-ID: <56A53978B83EEDE9+20260818023026.6631-1-jiawenwu@trustnetic.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:trustnetic.com:qybglogicsvrgz:qybglogicsvrgz6b-0
X-QQ-XMAILINFO: NHHBtKpbeb7pjGOAzbgWJETY+qco1eYss6v3oJcW2ZztLn74P3siSofu
	9FUlm/Ck5mcAHOZKmOUan65GNTULhBLCcou0AiuuN64nM0bOUJ4PVyFRwkat9rhAf0SpbWc
	1ZPXTeeXnEcJz16aT7x65OHTS+iXpNI+lZ0RmaQPLxrsVtseIE61CKS6hfL98qbw+Dk5wZV
	YvAwOc0dnXUr6mjyjf0FGx6I5ZshKuPsUh08C24SAG7WIrFekdMn8Aea6KbRiPAKV2NCc1R
	Agm4WPW1a/wdrSOQE3r+tsjfJVb2ubmqWpb1SpYZt8TZHBz4HnE7efzHa7wo1Wdsq28zuPG
	a6i1/F0WN4Swl+YXP0Dn50BMCizFTOXI0HF6YL6WUzJrlupeVTRNz6taPIde7Bn9AwE/sia
	b16l1BCbRELemPoaQorDx8Y+Q+04JOKhog/hnCO2ypqavTaPHcgp8/KB54X8n88MTb/IxD0
	KR6zpryZcoNh2HcVtOuDW7KrJi+FdGjSRqq3wDsL4aPsmMoUwDuHnrfYTtsywa+XOu6EeoO
	eIIVMYcNCvLXTFbauQSMF7U089KR2tkotM/5nzakNYKZ9Rc9DFVDc4zzNHw8UKG6uf/8X0K
	Tm3HWoRBn32m2YzqcN8X11vHyYoX7ATu+bqswsL8MbaPaIq7PRup4ZyiUHRiIhZ+l/cEq4s
	fLri327/yZdeDyiQzg0kWSNxsuGjvYvtq6Wf+lI78qzaxf4Pytgq9AbC6XRRqJRDnqTpVTG
	ifWZ2rDKC8O8k2BD8Cle3jrcX4cYdf3IszfDJERPReunByxXJV/a/CCEkV73PdnuPTolDeO
	qtYWe/fdr4ngedfA+s+H/j8k++ej9lsBoiUpx5YR5+theqAr+b6Z41IqpfTqCPib6udnHoc
	jeObjavBdzTjQU/afdw8o1ZoyM4tEewKQLHa3zqghhwjICiQfu3TW79hmdxEZUVSWbVWOEa
	24Y85L06ZPICm+mfAdZR97G13F9GjiUqxRCaY3ISXR+arHLFDXuG+har0k/t6nG8oOnxm8w
	W4hG/fbK4Gl328EjHbIudiz8wsXn0WEn6xji48Yked0UaUeC7QgpHkzxiWlKcvvofNzzpu1
	ju4Z51HpSXblVkmc3t7PhQ=
X-QQ-XMRINFO: NyFYKkN4Ny6FuXrnB5Ye7Aabb3ujjtK+gg==
X-QQ-RECHKSPAM: 0

In txgbe_misc_irq_thread_fn(), the driver unmasks the miscellaneous
interrupt at the end of the handler using TXGBE_INTR_MISC(wx) (which
resolves to BIT(wx->num_q_vectors)). While this is correct for MSI-X
mode, it is incorrect for legacy INTx or single MSI modes.

Due to hardware behavior, the WX_PX_MISC_IVAR register is completely
ignored by the hardware when MSI-X is disabled. In non-MSI-X mode, the
hardware forcibly merges all interrupt causes (both Queue and MISC) into
a single bit: BIT(0) of the interrupt register.

Unconditionally unmasking TXGBE_INTR_MISC(wx) (e.g., BIT(1)) in non-MSI-X
mode means the actual MISC interrupt bit (BIT(0)) is not unmasked
promptly at the end of the MISC thread. Instead, it remains masked until
NAPI completes its polling and unmasks the shared BIT(0). This delays the
assertion of subsequent MISC interrupts, preventing timely handling of
events like link state changes.

Fix this by explicitly checking `pdev->msix_enabled` and falling back
to BIT(0) as the interrupt mask for the MISC cause when MSI-X is disabled.

Additionally, unconditionally unmasking the interrupt at the end of the
thread introduces a race condition during device teardown. Guarding the
wx_intr_enable() call with a check for the WX_STATE_DOWN bit, to prevent
re-arming the interrupt during device shutdown.

Fixes: e37546ad1f9b ("net: wangxun: revert the adjustment of the IRQ vector sequence")
Signed-off-by: Jiawen Wu <jiawenwu@trustnetic.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
Changes in v2:
- Add the checking of WX_STATE_DOWN bit before unmasking the interrupt.
- Link to v1: https://lore.kernel.org/all/59215DA27859BC49+20260813073305.360251-1-jiawenwu@trustnetic.com
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
index 8746318ad3bc..5ad1ff7c3ce9 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_irq.c
@@ -164,6 +164,7 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int irq, void *data)
 	struct wx *wx = txgbe->wx;
 	unsigned int nhandled = 0;
 	unsigned int sub_irq;
+	u64 misc_mask;
 	u32 eicr;
 
 	eicr = txgbe->eicr;
@@ -183,7 +184,9 @@ static irqreturn_t txgbe_misc_irq_thread_fn(int irq, void *data)
 		nhandled++;
 	}
 
-	wx_intr_enable(wx, TXGBE_INTR_MISC(wx));
+	misc_mask = wx->pdev->msix_enabled ? TXGBE_INTR_MISC(wx) : BIT(0);
+	if (!test_bit(WX_STATE_DOWN, wx->state))
+		wx_intr_enable(wx, misc_mask);
 	return (nhandled > 0 ? IRQ_HANDLED : IRQ_NONE);
 }
 
-- 
2.51.0

