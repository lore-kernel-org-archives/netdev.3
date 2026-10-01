Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E43544AE102;
	Thu,  1 Oct 2026 09:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790845945; cv=none; b=E4yy5emR3d6EJjDG0A+9TEE4CP0wgO3wvaYqlCGoVHlHq9VR9xZ5hjwYeuh6mQ11DFTRMltXtUyculgS20v5Jf6mdXro237gXLQ9A64R0eM6sXv9M17n5Y9pj8FlDuxMjTYjzmaXOFnqw/fhklx6AYtWMAy8VnMNrYnhIyWtAUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790845945; c=relaxed/simple;
	bh=Tvse7y/kiFC4s9yyXtgLc7aSWY67jBWEv43X92o85zU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=esN23yNT7LA3fg5jrj1W55vzEuwnqotIDJjNISfPDps0wMhcTQNBtZ/5TtjwNMT4TfGrziFMrTvazmtbbXtZgL8Ar7VCWdO7H5/V+UASJYmKgWbBqjrLNf136S7HsS+mBycZMrEhS75AONCofh0N4YVyTPsBPyaCmRArbj+LjJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ourWhv3a; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ourWhv3a"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 6919BknaE2836515, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1790845906; bh=rXW1fD3yKWjJe/bdc7Cp1HYXXo685wbPkaroMZUNX4w=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=ourWhv3a4ggVFtWh3QuWNzD6AGHI3b62A6RvH+Iwq40fm5lB4MDnvkp61tDODIOkR
	 5PEKUBA6QpnYHjm/daxp/7bohUEjlGRAnuhgxqid4EEXsc+HUDRfbuZT7kOiwhAsCL
	 N0ERGZqXOLX478aiLB+qf1SEbU8j52juj+epA9MyHXfnqKkS+G6mbdkempjY8wHB4m
	 zCN09Z8hEPCI2H7m8d0bIfPjjs8nLPxHcIBZ1GzRlQBMwHogjh0crT60aq7q24zKkF
	 EzIqGCnAfeMIg48v/LOR5wL4vRKIsPiXhasDUhwIbLVSJ1kU3baM1IjIR/DRqgl37t
	 o2ssUY3i1pkCQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 6919BknaE2836515
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 1 Oct 2026 17:11:46 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 17:11:46 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Thu, 1 Oct 2026 17:11:46 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Thu, 1 Oct 2026 17:11:46 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>
Subject: [PATCH net-next v5 0/9] r8152: refactor and extend RTL8157/8159 support
Date: Thu, 1 Oct 2026 17:11:35 +0800
Message-ID: <20261001091144.28191-1-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

RTL8157 and RTL8159 have different init, enable, up/down, hw_phy_cfg,
and PHY access sequences from RTL8156.  This series splits the shared
callbacks into per-chip variants and adds the missing RTL8157/8159
functionality: dedicated unload and change_mtu callbacks, TGPHY register
access via phy_read/phy_write pointers in struct rtl_ops, flow control
patch support through rtl_fc_pause_pkt_en(), and UPS support via
r8157_ups_en().

v5:
- Patch #1: in r8157_init()/r8159_init(), call
  r8156b_wait_loading_flash() before wait_autoload_done(). Document
  in the commit message that the "Bulk In End" bit is cleared in
  r8157_init(), and drop the claim about the FC-timer block.

- Patch #2: accept the package read only if the full word was returned,
  warn when a retry was needed, and print an unknown package as
  0x%04x. Say "firmware" instead of "PHY tuning" in the commit
  message.

- Patch #3: make it a pure split with no functional change. Its
  register fixes move to the new patch #4.

- Patch #4 (new): fix up and down register settings for
  RTL8156/8156B/8157/8159.

- Patch #5: document the new RTL8159 PHY tuning parameters in the
  commit message.

- Patch #6: add Fixes tags.

- Patch #7:
  - A TGPHY busy timeout now sets RTL8152_INACCESSIBLE and returns
    -ENODEV.
  - sram_write() returns the data-write result.
  - The PHY firmware version checks, the BMCR reset poll,
    rtl8152_set_speed(), the pause parameters and the PHY patch
    handshake handle PHY access failures.
  - SIOCGMIIREG returns 0 with val_out set on success, or the error.
  - Commit message rewritten.

- Patch #8: drop the "no link" case, since the caller checks the link.
  An unknown speed now disarms the pause limit. Commit message
  rewritten.

- Patch #9: wait for the backup-restore flag with a timeout in
  r8157_ups_en(). Rename USB_FW_USE_VER to USB_FW_USB_VER.

v4:
- Patch #1: make wait_autoload_done() bail out immediately on
  RTL8152_INACCESSIBLE instead of waiting out the full 10 second
  timeout.
- Patch #6: propagate PHY access failures instead of ignoring them.
  ocp_reg_read()/ocp_reg_write() and every helper built on top of them
  (sram_read/write, sram2_read/write, the ocp_reg_*_bits and MDIO bit
  helpers) now return int and stop silently operating on stale data
  when a TGPHY access times out.

v3:
Rebase on top of latest net-next to resolve merge conflicts.

v2:
- For patch #1, use read_poll_timeout() to replace the manual
  for-loop polling.
- For patch #2 and #3, rewrite the commit message.

Chih Kai Hsu (9):
  r8152: split r8156_init per chip and add missing init writes
  r8152: split RTL_VER_17 into QFN68 and QFN100 package variants
  r8152: split rtl8156_enable/up/down into per-chip-family functions
  r8152: fix up and down register settings for RTL8156/8156B/8157/8159
  r8152: split r8157_hw_phy_cfg into RTL8157 and RTL8159 variants
  r8152: add rtl8157_unload and rtl8157_change_mtu
  r8152: add TGPHY register access for RTL8157 and RTL8159
  r8152: extract rtl_fc_pause_pkt_en() and apply it to RTL8156/8157/8159
  r8152: enable UPS for RTL8157 and RTL8159 QFN68

 drivers/net/usb/r8152.c | 1888 ++++++++++++++++++++++++++++++---------
 1 file changed, 1451 insertions(+), 437 deletions(-)

-- 
2.34.1

