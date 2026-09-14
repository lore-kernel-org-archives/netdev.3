Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FA7483BC7
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 13:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789390881; cv=none; b=ReAjSuc4AK5yQvW62v1Wn/cLj2rnp4dvyYW/IayWx63fKzrdW7DPu+2GbB5NE3eZEhepw6WT65tj3wXEcDLhsdbLadsk1k/pmksQ7A+t545TmfcuOTq7577fSCuiqcYPIawbA7MTjtJrPLva0Oiq08UDBSDPj2XPFPMylTNQtEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789390881; c=relaxed/simple;
	bh=vV1KBM/CzTDp19ZJa/oiYxMhH5ShLnt22gZbgeuW7m4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lAn4JwytNNWXuNs4XQl/oXtREEv3vjJ9XmCZXnw5ycdl9MU1t3fER4PoJEd0pR1uN5ANqZIHj5oXZcJ8qXBVbzsTGdRLyc45cAZZiFsQ9uCKgwykSxvX4nYIi4X0bnjkLJo7mUOM9ViZHB7cnSfS+U7oEBjJys2nktAgpWTeNWs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TF0eK80g; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TF0eK80g"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-398b3b189e0so1472118a91.2
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 06:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789390879; x=1789995679; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w0zMSPeSGbDLM5HJhTpgpS0ZmvGUDQ4KNMTTEqPdWPg=;
        b=TF0eK80gA3gFcmV3dQ5bk2kCRl4kAgbfbgFlVe5g783KyZDzIyaAN4YimDh679psxB
         oAxM9KdlVBCkUjAOjAsZCdtgdG9Uw+AaSkzW7MqCGnr3nk+jWEFhH3jRz1aqUOja7Qs8
         JEe6NQcD6kCSFy94uccTCrZX0uxNJgM2jjSqrpghMqhM88JbYxM0sAFE4ug/zhIggAup
         zQee4WjUbxRF5f4oaSEzmtTEgdgoh7Nk93eCmwPTtLv3/MxuRP6Gnwfmu0GHzz7bAHzr
         6+ubMaUhf5yKbCsoGrfSfBx5q9O0SHz7ntNQw7f8Lg2TytZpKf0LBzbXz2cuTuxLV019
         Nb7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789390879; x=1789995679;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=w0zMSPeSGbDLM5HJhTpgpS0ZmvGUDQ4KNMTTEqPdWPg=;
        b=HiQI3+M38S/RB8UoRXEoXJAG3Klr1868i39GUsppYXQiKomBbLc1JVVclJlaNQpiAr
         rZqDqyMjbxThUWdM7rfiHIb7Zl9soAV/0JU22HWZ9Psh0xVN0E58eLTAJ6QpF8bIVkzH
         ZIeosDVcG8T9KSR8mBHrKw1zj9oNpS0yRDJ2D/evBlbhPW3CavZuoRJ9cvaKtGACL2uY
         AxTDUTdnuKIC9UvAz93sM0XBUi+hrt6szMHejCWoE2VK1b9O4JRZphM2BbO0a0+/qoQC
         GjJDgwlU+KBqBdMN5x1haIcdKlD+6T4qioSH9lag+LfeK38czabVNLCcwJyrEjeGcG3C
         Q7PQ==
X-Forwarded-Encrypted: i=1; AKwUvByhl2cbDj+QOlWjZotNLCTv1TzlyJPlavetOufMSJTwjTx8DqarDkJLvyj0q18EoM8aOxhy6ws=@vger.kernel.org
X-Gm-Message-State: AFuF++kDKOS6/e3ZD7XITvBVs1WXyZEAwGPKH0AsSlKawhJyezI2yrN0
	T3PHDZ7jygGX4VfzjEjo/OGaECqVw4tP6PL29zUXH8hxZWOKzEPnjXep
X-Gm-Gg: AYBFou34EH9Owh/AjYMBLeqDM8/Kk/0L0sWOQreA8lhERAIjKRYYXvXx0OrYll1FgIx
	aIr+yariqjPQhlY7bDKCiqVxYmJwQlLM4l/d/BWOk5kUgoHgm/4yUF/Bq8SYchK7ujz1aD6fSTh
	2zo0vHYuLZ9M3/oTa5ek7441g94U9VcOdv/DdPNSyum9rylBmxArDas7bo2N5StEZuv0rOk9os/
	LFaqrbC5VdvyEQnTwHpET0H8sDx/l7aFgF8BX+6wdsJTx12mcD7/1Ri0Wj2J02QZvKjyUpZL950
	Qjdnx1OkBerC5qqm/Foq0whYiHVis3TDw6u5IbOa4CBDdmMSifWRnOsFNaRt0O/oAhyZV3m2uzo
	i1SNp2vzmSfOkx1Y0qNJ6zy08A6CXnrtNeAEzh+yil0NIvwMa4Vi7nyk5tfKOQKabVEKOstTXyT
	AE7h8IsjLvo0P/cNSzrgjBbUYZ/4rO+WB2UPrtHhYnJ1AxqwvX669oTXOUlwxEX4edFtHjqConG
	IRNZR/UXUy6xKVh8J581b1s
X-Received: by 2002:a17:90b:5624:b0:38e:67e1:15b with SMTP id 98e67ed59e1d1-39debf93f0dmr5392681a91.6.1789390878954;
        Mon, 14 Sep 2026 06:01:18 -0700 (PDT)
Received: from LAPTOP-450UDG4J ([223.185.135.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d950913a6sm21081467a91.6.2026.09.14.06.01.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 06:01:17 -0700 (PDT)
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
Subject: [PATCH net v4] r8169: don't enable chip LTR when the platform has not enabled LTR
Date: Mon, 14 Sep 2026 18:30:49 +0530
Message-ID: <20260914130050.304-1-yogeshgaur.83@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <20260911131352.2036-1-yogeshgaur.83@gmail.com>
References: <20260911131352.2036-1-yogeshgaur.83@gmail.com>
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
supports it. The PCI core works that out in pci_configure_ltr() and
records the result in pci_dev->ltr_path; per PCIe r6.0 sec 7.5.3.16 a
function must not issue LTR messages while LTR Mechanism Enable is clear.

So on a platform whose hierarchy has no LTR path, the driver tells the
chip to start sending LTR messages nothing will honour, and ties ALDPS -
the PHY's link-down power saving - to them. A report against RTL8125B
(rev 05, firmware rtl8125b-2_0.0.2) in a mini PC shows the effect: 291
link down/up transitions in one eight-hour boot, with repeated downshifts
to 100Mbps, against four transitions at boot and then a stable link on
the kernel before the LTR change.

Gate the chip's LTR programming on pci_dev->ltr_path. That field exists
only when CONFIG_PCIEASPM is enabled, so the test needs a preprocessor
guard rather than IS_ENABLED(). With CONFIG_PCIEASPM=n the PCI core's
pci_configure_ltr() is a stub and LTR is enabled nowhere, so the chip
must not issue LTR messages in that configuration either.

Note this does change CONFIG_PCIEASPM=n builds, which used to program
chip LTR unconditionally: pci_disable_link_state() is a stub that returns
success there, so tp->aspm_manageable ends up set.

Fixes: 9ab94a32af70 ("r8169: enable LTR support")
Assisted-by: LLM
Signed-off-by: Yogesh Gaur <yogeshgaur.83@gmail.com>
---
v4:
 - Drop closes line.
v3: https://lore.kernel.org/all/20260911131352.2036-1-yogeshgaur.83@gmail.com/
v2: https://lore.kernel.org/all/20260910130140.910-1-yogeshgaur.83@gmail.com/
v1: https://lore.kernel.org/all/20260909110554.1977-1-yogeshgaur.83@gmail.com/

NOT VERIFIED ON HARDWARE. The causal claim above is
reasoned from the register writes.

Compile-tested only: drivers/net/ethernet/realtek/r8169_main.o, x86_64
defconfig + R8169=m, built W=1 clean with both CONFIG_PCIEASPM=y and
CONFIG_PCIEASPM=n.

 drivers/net/ethernet/realtek/r8169_main.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index ec4fc21fa21f..c305a8f19551 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -3037,6 +3037,18 @@ static void rtl_disable_exit_l1(struct rtl8169_private *tp)
 
 static void rtl_enable_ltr(struct rtl8169_private *tp)
 {
+	/* The chip must not issue LTR messages unless LTR is enabled for the
+	 * whole path up to the root port. pci_configure_ltr() works that out
+	 * and records the result in pci_dev->ltr_path, which exists only with
+	 * CONFIG_PCIEASPM; without it the PCI core never enables LTR anywhere.
+	 */
+#ifdef CONFIG_PCIEASPM
+	if (!tp->pci_dev->ltr_path)
+		return;
+#else
+	return;
+#endif
+
 	switch (tp->mac_version) {
 	case RTL_GIGA_MAC_VER_80:
 		r8168_mac_ocp_write(tp, 0xcdd0, 0x9003);
-- 
2.55.0.windows.5

