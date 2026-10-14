Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CED367B6D;
	Wed, 14 Oct 2026 08:19:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791966001; cv=none; b=olX166OWfH1EI/RmKkcV8C5FrowFAqY0j80EsfRHheiDNIkQvQXtX71R6nHKEYfDiRQi/PF1xPtokGG12N2iixldgYw7J4PudsWthziYbnODb0SVmW8iQSDySnZgeGFvr/4wim/n8ai+0HJoq/c0wpNZM2P0aje1kap3Nw1pgO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791966001; c=relaxed/simple;
	bh=YWdefOrNuo70YCUjavlZQMojcTPN86cVTlkXPYkcqZY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rlj1zCoIuVtjwYlcUozA1Hr0NqYd1Ves00X9/na3PR4ylT65G/0iNCTm8z3Wto9206UXx1W63dCk6LwJXHmFoRUMwPKaIGFc7pvT8n1bDfddzGBGyP+Rc4tExkXYu/0VDIdedhYwWBNbwCMimyrYn5VHbFncTdypHNdq3khp4nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=oOtkcn8H; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="oOtkcn8H"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 69E8J8cG41418052, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1791965948; bh=O/xXSxes9in+zrpNBQUt6RjOdePKZN9GhHIcUqpTd1Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:
	 Content-Transfer-Encoding:Content-Type;
	b=oOtkcn8HP44XjlvIb3HMBqXiUUNff1VhENXi4P4MXj1HG3mF8au/b7YX48pYFH51z
	 dlHWHWlDyDPTpgNPPQDY2PfslBTLVWo35E7osecH+LC0C7B4nfADypFManysg5/k/1
	 ez5IWSQ7nRyxvRIUbDwqYGLs3+c/sAiUGSSYxqX5nZDRi1fpc6bVU1L4n5+6SCKUkr
	 a7FLWbk75G6UhhtkXNnmdCynYqJa5CL7nZq9r/0p9soU82c5Lu+YGmWpjvGlGWl8hE
	 OG8qVSu0aUaESNg5mrDIihS0OJgg9Pk/haVGX4Zqsi63jasV6GnqrZDWHZLbhamtpk
	 Mm8GM30eTP+1w==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 69E8J8cG41418052
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 14 Oct 2026 16:19:08 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.49; Wed, 14 Oct 2026 16:19:06 +0800
Received: from fc44.realtek.com.tw (172.22.241.7) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server id
 15.2.2562.49 via Frontend Transport; Wed, 14 Oct 2026 16:19:06 +0800
From: Chih Kai Hsu <hsu.chih.kai@realtek.com>
To: <davem@davemloft.net>, <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
	<linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
	<edumazet@google.com>, <bjorn@mork.no>, <pabeni@redhat.com>,
	<hsu.chih.kai@realtek.com>, <andrew+netdev@lunn.ch>, <mail@birger-koblitz.de>
Subject: [PATCH net-next v7 00/10] r8152: refactor and extend RTL8157/8159 support
Date: Wed, 14 Oct 2026 16:18:54 +0800
Message-ID: <20261014081904.6491-1-nic_swsd@realtek.com>
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
and PHY access sequences from RTL8156.  This series separates the shared
callbacks by chip generation and adds the missing RTL8157/RTL8159
functionality: dedicated unload and change_mtu callbacks, TGPHY register
access via phy_read/phy_write pointers in struct rtl_ops, flow control
patch support through rtl_fc_pause_pkt_en(), and UPS support via
r8157_ups_en().

v7:
- Patch #1: split r8156_init() by chip generation rather than per
  chip. RTL8156 and RTL8156B share r8156_init(), and RTL8157 and
  RTL8159 share r8157_init(), since their sequences are near-identical.
  The few differences are selected with switch (tp->version).
  r8156b_init() and r8159_init() are gone.

- Patch #2: apply the new init writes to the merged r8156_init() and
  r8157_init().

- Patch #3:
  - The RTL8159 QFN68/QFN100 differences become cases of the version
    switches in r8157_init(), and the QFN68-only u2phy backup restore
    write falls through to the common u3phy backup write.
  - Report the number of retries (i - 1) in the "Needed %d retries to
    read package" warning.
  - Update the commit message.

- Patch #4:
  - Share the exit-OOB and enter-OOB sequences of RTL8156, RTL8156B,
    RTL8157 and RTL8159 through r8156_exit_oob() and r8156_enter_oob(),
    as RTL8152B and RTL8153 do.
  - Serve RTL8156 and RTL8156B (VER_10/11/12/13/15) with a single
    rtl8156_enable() instead of adding rtl8156b_enable(). The
    r8156_fc_parameter() call stays behind a version check, so it is
    no longer dropped.
  - Retitle and update the commit message.

- Patch #5: adapt to the shared r8156_exit_oob() and r8156_enter_oob().
  Update the commit message.

- Patch #7: r8156_exit_oob() now calls tp->rtl_ops.change_mtu() instead
  of rtl8156_change_mtu(), so that rtl8157_up() gets
  rtl8157_change_mtu(). Update the commit message.

- Patch #9: apply rtl_fc_pause_pkt_en() in the merged r8156_init().
  AUTO_SPEEDUP is still cleared there for RTL8156B only. Update the
  commit message.

- Patch #10: replace r8156_ups_en() with r8157_ups_en() in the merged
  r8157_init() only. Update the commit message.

v6:
- Patch #1: make it a pure split of r8156_init() per chip, plus the
  wait_autoload_done() helper, with no functional change. The new
  init writes it used to carry move to patch #2. Also convert
  r8152b_init() to wait_autoload_done().

- Patch #2 (new): add the new init writes for RTL8156B/8157/8159,
  taken out of patch #1.

- Patch #3:
  - Fix the "Needed %d retries" warning in __rtl_get_pkg_det() to
    trigger only when a retry was actually needed (i != 1).
  - Reword the commit message.

- Patch #6:
  - r8159_hw_phy_cfg() ends with rtl_eee_enable(tp, tp->eee_en) so
    that the configured state is applied in both directions.
  - Reword the commit message.

- Patch #8:
  - A TGPHY busy timeout no longer sets RTL8152_INACCESSIBLE.
    wait_tgphy_cmd_ready() logs and returns the poll error, as the
    ADV command channel does, and returns -ENODEV only if the device
    is already marked inaccessible.
  - Drop the RTL8152_INACCESSIBLE exceptions from the LAN_ON
    WARN_ON_ONCE() checks in hw_phy_cfg, which are no longer needed.
  - Narrow the commit message to what the patch does and list what is
    left to a follow-up series: the remaining callers, the MII library
    callbacks, and the recovery from a TGPHY timeout.

- Patch #9:
  - Explain the symptom, that RTL8157/RTL8159 could keep sending pause
    frames indefinitely, and add Fixes tags for RTL8156, RTL8157 and
    RTL8159.
  - Keep the FC patch in r8156b_init() split from the AUTO_SPEEDUP
    clearing, and call rtl_fc_pause_pkt_en() right before it.

- Patch #10: note in the commit message that a backup-restore timeout
  in r8157_ups_en() follows what r8159_init() does for the same wait
  (mark the device inaccessible and log, without queuing a reset), and
  that recovery is left to a follow-up series.

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

Chih Kai Hsu (10):
  r8152: split r8156_init by generation and factor out
    wait_autoload_done
  r8152: add new init writes for RTL8156/8156B/8157/8159
  r8152: split RTL_VER_17 into QFN68 and QFN100 package variants
  r8152: split rtl8156_enable/up/down into per-generation functions
  r8152: fix up and down register settings for RTL8156/8156B/8157/8159
  r8152: split r8157_hw_phy_cfg into RTL8157 and RTL8159 variants
  r8152: add rtl8157_unload and rtl8157_change_mtu
  r8152: add TGPHY register access for RTL8157 and RTL8159
  r8152: extract rtl_fc_pause_pkt_en() and apply it to RTL8156/8157/8159
  r8152: enable UPS for RTL8157 and RTL8159 QFN68

 drivers/net/usb/r8152.c | 1600 ++++++++++++++++++++++++++++++---------
 1 file changed, 1222 insertions(+), 378 deletions(-)

-- 
2.34.1

