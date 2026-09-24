Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7832E36D9E7
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 13:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790257895; cv=none; b=kRr/yRGFxmHRowFbZmeINqB5mdT9y0ZjWv5/qJ2+mA7QPUX1BdG4jIFHu1u+n/uSJr+dLWqlakjfHLQ48wVr2KwF+6rxJmApiCAZTyWq18nzO326cPnPwPGa6UjdwN437gi0f/ZlrV2kpf1dv+yq4arCmvcp/Qs88waAqwiYoY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790257895; c=relaxed/simple;
	bh=t5Wpp+R6LXu2QFtUVal1E1+IOI54rGsNMSUJETFP1x4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kH56lLfz/riw7K9I1cv6yqRo8Yz9KAEn2FDFPLVTU5nffy0MgB6CvqanHjsihwyQ/0Y90ywHFc+h5Cg0zYFbl3gzwUTfeG/sc3gUdrw81MxayDBAyfpQw9xXSd+/7TJOuQEuWgUo8KcqtD0xuy8Fbc1YiPrsbhi7duH6fVmLID0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QFSdZ2hv; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFSdZ2hv"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4843378fb37so1229950f8f.3
        for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 06:51:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790257889; x=1790862689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6HASGHD+lRj0S4qpBGA5C8WQuEbo4NLHpp5wcEzg5F0=;
        b=QFSdZ2hvscJH4ULY8Q8T5gNztDEm9JUdfhufK02Xe4ufffb+HyojzEB1ymXyHQRkwF
         eeK2IG2/tPUG7dasTVYa4kIb5b6QSAiOehTjHfHG3ik1QydUDS8SQ3RCM6eOIc9HOTpn
         oqzhTzM0XZRF12NtZujV7o7npAvmNALwt2BiuglYtTQBuea/VgTqqeDsojFeU+CfLFml
         /HOB3umd0cg/CnCy0e4TbTrkxqeIe1CRmdI8DcitBWb2Ac5/D70yD+AKvCw9MVLOlYer
         MEeE/iheerP+yuRSaa+VhRLPOrA4Jir88Z2yGiUS6gZRRtFU5ztd8IvYthAfklC/p538
         HFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790257889; x=1790862689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6HASGHD+lRj0S4qpBGA5C8WQuEbo4NLHpp5wcEzg5F0=;
        b=R3Q+N3D9uYGFIj0X1rXlVjS+SFFewrS7HkifnCI+kaaBXFskTkIbBr1BbrICBGyQII
         emwec1G0d65U+frf7+8s9r47cxLdTzDlh0nPq4GDeSEciom2tgD9K0CqGp8wGAzX8l+y
         ZeC5XhaI+ovmupImT1l8v93Od0r6DsHvinntUWr1xqohDph15mWJkcxv1GY2NHNjmLVR
         Ms7Ha2+b+8MbyWsWdn7Ueyga8dy4jGSLKl3W1QQ7JtaIWkAJyRQMJddWsAlMdYAKSB9V
         0SWzWq5JD+8+G+moevV6QU3e1LasmgaXFjDr6E+xNzd2pi76TDRPlRtfLE81vbwP+a4w
         QA0Q==
X-Gm-Message-State: AFuF++lP5wIgfK3r0vB3h4EPhq0oNRoYxvOqRjDyc7p6Iw1ki2zMf+LR
	6zC0NEr7zRaJlmoO1dRcx1+ir44apRtx2H7STCRT5tIF/r8oy2zp2U2auXzJuXgr
X-Gm-Gg: AYBFou2kqKfKr4hRoCmpGErBRr650KApBjnP0g2s+hdrou2o67NCDXKXUZRU/Bk78sJ
	ZF75MGXpktfNM4tkhQuTmkwpXuaKARVSDd9lKNrGwDYd3NS2PI0Pw2lb2M7rprrzobWc7mPtbaC
	Ikutj4W1tFGwYrOiLD/OaIVPoCe2uTr49e9GJnARvszR1/rFG0RwTm+clSk8mvD1QvBgpxk1WfH
	NbW+2KMjFQ0drc8nIfcX8subvQJfoyp2iPBnFgTO8TAo7D98/OMlrTU/n2fgSwnw12MVY8pNWlo
	0upsAN4hLtbhS0hbWqg4v5qAF6LNkSUDe/PnaHUFDVqTLhDJj56U6hDnWiYJRzsgZdsfzcmESNG
	tvNwQxH97o3IUsq1hRcA3ZNV39dnw0zLkhUeUbxEnYUte8QHTOwZ4f/lVpdZiEMBLOS61mq9RmD
	Em+4YjYXBXmxEn6U0ij9L9X7HX2q3bngO4XZnrkukF7wEB2ZiJYjgiZJJo0D672PpUi5bSGSWkv
	mXZevP2zwhiguT1qZhDdX4HIyO48bRs+5D/4ARP
X-Received: by 2002:a05:6000:4816:b0:487:11db:9866 with SMTP id ffacd0b85a97d-488716b7ca3mr3656273f8f.57.1790257889326;
        Thu, 24 Sep 2026 06:51:29 -0700 (PDT)
Received: from fedora-tap.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868889376sm12060660f8f.33.2026.09.24.06.51.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:51:28 -0700 (PDT)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: netdev@vger.kernel.org
Cc: radhey.shyam.pandey@amd.com,
	michal.simek@amd.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux@armlinux.org.uk,
	daniel@iogearbox.net,
	andybnac@gmail.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH net v2 4/4] net: axienet: reprogram the link settings after a DMA error reset
Date: Thu, 24 Sep 2026 16:51:16 +0300
Message-ID: <20260924135116.185161-5-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20260924135116.185161-1-maimon.sagi@gmail.com>
References: <20260924135116.185161-1-maimon.sagi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

axienet_dma_err_handler() resets the DMA engine, which resets the AXI
Ethernet core with it.  The handler then restores RCW1, the interrupt
enable mask, the MAC address, the multicast filter and lp->options, but
not the link speed field of XAE_EMMC_OFFSET, and it writes XAE_FCC with
only XAE_FCC_FCRX_MASK, discarding whatever pause configuration had been
negotiated.

axienet_mac_link_up() is the only code that programs the link speed and
the negotiated pause bits, and phylink calls it only when the link state
changes.  Nothing about the reset is visible to phylink, so it is never
called again: the MAC keeps its reset-default link speed while software
still believes the negotiated one is in effect, and on a 10 or 100 Mb/s
link frames are clocked at the wrong rate until an unrelated link flap
happens to rerun axienet_mac_link_up().  axienet_open() avoids this only
because it runs phylink_start() after axienet_device_reset().

Tell phylink the link was lost with phylink_mac_change(), so it takes
the link down and back up and calls axienet_mac_link_up() with the
current settings, under its own locking.  Do it after the final
axienet_setoptions(), which also writes XAE_FCC, so the negotiated pause
settings are the ones left in place - the same order as in
axienet_open().  Skip it under the same conditions as the queue wake:
axienet_stop() stops phylink, and a resume restarts it.

The link going down and up is visible, which seems right: the MAC has
been reset.  A frame may still leave at the reset-default speed in the
short window before phylink runs; the reset has just dropped everything
that was in flight anyway.

This was reported by the Sashiko AI review bot.

Tested on an AXI Ethernet MAC behind a PCIe endpoint: traffic passes,
including across ten down/up cycles made with traffic running, with this
series applied.  The DMA error path itself was not exercised.

Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ethernet driver")
Assisted-by: LLM sparse
Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index f16dbfc7dc93..d53f7dc7bd22 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2801,8 +2801,15 @@ static void axienet_dma_err_handler(struct work_struct *work)
 	 * device was detached for suspend: axienet_stop() and axienet_open()
 	 * own the queue state then.
 	 */
-	if (!READ_ONCE(lp->stopping) && netif_device_present(ndev))
+	if (!READ_ONCE(lp->stopping) && netif_device_present(ndev)) {
+		/* The reset also cleared the link speed and pause settings,
+		 * which only axienet_mac_link_up() programs.  Have phylink take
+		 * the link down and up again so that it is called.  This must
+		 * follow the axienet_setoptions() above, which writes XAE_FCC.
+		 */
+		phylink_mac_change(lp->phylink, false);
 		netif_wake_queue(ndev);
+	}
 }
 
 /**
-- 
2.47.0

