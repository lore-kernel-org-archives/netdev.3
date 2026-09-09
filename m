Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878E5538D97
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 11:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951996; cv=none; b=Md9ulLAnA7Zn+bx0bOYNhaVd9A7q7nKXskxH06IzrHJDW/uE3wJt/rUoV8lHxucDXERrBghIW5Py/7sfBgPTDXwf3f8592Btbg0R6/tzO/3TelabqnLh/YrDE4/iV5PZE00GcuaTHXjtuki3bGyjMXVkTu3o1sUwsRC4b5NRVjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951996; c=relaxed/simple;
	bh=rWAys0+HIWsiGqZtXhkqNKObTT9MbSHAj3J81e68H/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=auQ/8ovBUb2Eb8UvkMW+nwZwCifuNTGtx4CwciHDk9Wkf222AI4fR8ZUEbB12DsAkgT7Y9iUVzEHXU5SQ0ug4KGVk/GbFgVkZxesifRhKO6cXcb76wXXr0RWXM2qXrvFqDy1IfJVyHK0KhZeLpH4tPnt6NKYP0ukCneb2JThpEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pMuyNdJ0; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pMuyNdJ0"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccafb752so914227a91.0
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 04:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788951990; x=1789556790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=whHN3y9KIP6ye1VdRkpwr53aJIX9j72oYHTkN7oNo34=;
        b=pMuyNdJ0n5VHYzHMsMM0imwb7Aw4Lv+s8E2k7SvMoHrPkh4X1K66pXeKW3m5hM70Wj
         N2pm+8RA5V3Upr8/ltF/t3ABJHlGS0XAe5STISvK0h1tbPbd0JdE2k3sY9zO/FGjKl9x
         b/tQyUCPw4hFzrBDrtnJTl8oVmoJEhitgPwWquhpYO9TAV0Utr/dlpWLQ4xin87AOm26
         IUSf7n8NMElU78Nv9TeWV26Y4OiDcKJkj7DtS6dz4bzWBkWy4uIxwlUPMlr/ZdV496Uz
         LCHZMTX5JJs5dipxoQvTk+k/xDv/6zqz3q5j1KUOiVg2FN9ciB3pGXE7061UqXdzEpvY
         XB8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788951990; x=1789556790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=whHN3y9KIP6ye1VdRkpwr53aJIX9j72oYHTkN7oNo34=;
        b=clsaQ/HZ4Ch3OH3sheVfgLOWO2KPXCzl5MLa/t75v6fdssyFHyfbMyYjE5IJ8Qp4nQ
         KXCVkF/XfNlIYrLhl2pTq5a2v+0IeyAuabjCNIiBGGFXy3ohvA7Nrty/22NZ5hX5UDOG
         LaoAB0O3Bb3KbAYIbX18ruFSTYdyVv9CkXJISn7udXX+ik5b8V1s2ZALaEfIkaoq9Mnl
         YQJ8vZNI2BTeBrLuKfg9bYw9XJ3546ep7KE+oatfdNG3Ho0Yo7R0vub1jtIdZxvGjV+o
         iwHRbduyX3W/89VD8+mUa9J6Zqwr05t7x33FymUWVNx5YVoJN/8VD94JT0lemigEqb4n
         LyYg==
X-Forwarded-Encrypted: i=1; AKwUvByw4d599rRQeAcl/RGIBw9be7F3HyUvqlXwgISneISs/88Miv881lm12oms2+f9ush/2zI4f6I=@vger.kernel.org
X-Gm-Message-State: AFuF++kPzKSQGMcuhefp3Mq8WwG6PxggRhjRWfFHJvGJ4egouApOOzID
	WDP6TeOa1dFZ5/T1957wq0tk/TRFowzvVM6A/kJ8cMGhZ9XHXhAGOJRS
X-Gm-Gg: AYBFou09tOV+DwWmgw0FgXZhEJyiCGYFM3xa4bpoV5FsZ67cEUPH1cvKJPMfyC408GE
	g5A9/HFVYSkQywdJCtrtR1RnTlkUNNuF1KrwipnHMUmnaUIHV1oL5/+xxNpZoNhKe010tB5lQvQ
	BTqkPMMqnbWExvKYz89ChbJZffqFrh5Y0mSXoMAF1cChMiqoO5bCcwUw7M5eeE0OU/3io456C2Y
	Nn9c8zhr7x1eQobUQZ3HNCOJgpQSU4vHbxDIDvPQ1qAA6Zgf5xs9bD+sIPvmC75BYuCRajBesBl
	xs4QWS4tRBigavEVVs7RaVjVGqnqcldmDLJT8rgCmw5WCVE2WzWOm5/nVb9vTB32XsI3+BPxUVc
	GvJuX+uLJh1I2Or/cpN6e3KWziGMJ7FAFX9wfZRAgXE3QeP16jrc7PcUTdqOOjgo37x49AC+fiI
	1j4s2wGa94N+NfAZRPqmjod0ERgRfdMWWuc9Df1FCubMoO33G3OK5XkEdajngZa4tQEa+iUFEQ8
	tWYvQdiCCK9L7ecePiUb7dt
X-Received: by 2002:a17:90b:5485:b0:396:b918:c2a with SMTP id 98e67ed59e1d1-39bac34a3cemr7994615a91.12.1788951989646;
        Wed, 09 Sep 2026 04:06:29 -0700 (PDT)
Received: from LAPTOP-450UDG4J ([223.185.135.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b25f88475sm31962556a91.1.2026.09.09.04.06.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 04:06:29 -0700 (PDT)
From: Yogesh Gaur <yogeshgaur.83@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Javen Xu <javen_xu@realsil.com.cn>,
	Yogesh Gaur <yogeshgaur.83@gmail.com>
Subject: [PATCH net] r8169: don't enable chip LTR when the platform has not enabled LTR
Date: Wed,  9 Sep 2026 16:35:54 +0530
Message-ID: <20260909110554.1977-1-yogeshgaur.83@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rtl_enable_ltr() programs the MAC to generate LTR messages - ALDPS_LTR_EN,
LTR_SNOOP_EN, LTR_OBFF_LOCK_EN, plus LINK_SPEED_CHANGE_EN on
RTL8125/RTL8126/RTL8127 - and rtl_hw_aspm_clkreq_enable() calls it on
every ASPM enable, then goes on to let the chip trigger L1.2.

The only gate is tp->aspm_manageable, which records that the OS is allowed
to control ASPM. It says nothing about LTR. LTR is a separate PCIe
capability that only works if every device on the path to the root port
supports it. The PCI core determines that in pci_configure_ltr() and
records the result by setting LTR Mechanism Enable in the endpoint's
Device Control 2 register; per PCIe r6.0 sec 7.5.3.16 a function must not
issue LTR messages while that bit is clear.

So on a platform whose hierarchy has no LTR path, the driver now tells the
chip to start sending LTR messages nothing will honour, and ties ALDPS -
the PHY's link-down power saving - to them. A report against RTL8125B
(rev 05, firmware rtl8125b-2_0.0.2) in a mini PC shows the effect: 291
link down/up transitions in one eight-hour boot, with repeated downshifts
to 100Mbps, against four transitions at boot and then a stable link on the
kernel before the LTR change.

Read the endpoint's LTR Mechanism Enable bit and leave the chip's LTR
machinery alone when the platform did not enable it.
pcie_capability_read_word() zeroes its output on error, so an unreadable
capability takes the same safe path.

Fixes: 9ab94a32af70 ("r8169: enable LTR support")
Closes: https://bugzilla.redhat.com/show_bug.cgi?id=2529752
Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index ec4fc21fa21f..c1ff4e898570 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -3037,6 +3037,16 @@ static void rtl_disable_exit_l1(struct rtl8169_private *tp)
 
 static void rtl_enable_ltr(struct rtl8169_private *tp)
 {
+	u16 ctl2;
+
+	/* The chip must not issue LTR messages unless the platform enabled
+	 * LTR on the whole path up to the root port. The PCI core discovers
+	 * that in pci_configure_ltr() and reflects it in LTR Mechanism Enable.
+	 */
+	pcie_capability_read_word(tp->pci_dev, PCI_EXP_DEVCTL2, &ctl2);
+	if (!(ctl2 & PCI_EXP_DEVCTL2_LTR_EN))
+		return;
+
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_80:
 		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
-- 
2.55.0.windows.5

