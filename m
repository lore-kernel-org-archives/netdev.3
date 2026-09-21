Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69C88479864
	for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 09:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789984322; cv=none; b=oV5dhNmLsaTFyeVlLtcWLdZZCCkbfZAGU3/Gotd4y0GUjGVq5E0INgZ+1Gx+ysLzrM6q71xFD8dQoSbSfDyULkQ0EoQgX0IZZ/PBhzI61vBX3aiuLejEZGu6/OnHHUfo4gqeVfBlToTg61oLDiodkg8Ty6DJM1r2o87lYG6qwzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789984322; c=relaxed/simple;
	bh=D/JDpfmo4lE6E5DAlMCGk2mWzgwrTrTJ3MZzqIj78Kc=;
	h=From:To:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WnJlOx5fYRQeBUOQaOLbb4BF+LHd4c6UjLvK91t+nth29itIf5TkebIy5g+DaCoJB2674xTuWEdTQSnSCnM/FnC0bYPIWKUvh9o6gh4iEutegbA+ZHo0rwmwzr5/2N8TxEukQRxH6x40T/OwPxWnTpF0qTbxM5OBpeoDDgkWCJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: 137a7e12b5a211f19a56ed5b684f684d-20260921
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:305731f5-ac63-41f0-98b1-804f989162c0,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:ebf5d547a6c93db39afdbd04f33e3cee,BulkI
	D:nil,BulkQuantity:0,SF:81|82|83|102|850|865|898,TC:nil,Content:0|15|50|99
	,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OS
	A:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 137a7e12b5a211f19a56ed5b684f684d-20260921
X-User: zhangyunfei1@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <zhangyunfei1@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 1267927254; Mon, 21 Sep 2026 17:51:54 +0800
From: Zhang Yunfei <zhangyunfei1@kylinos.cn>
To: netdev@vger.kernel.org
Subject: Re: [PATCH net 2/2] net: ngbe: clear DRV_LOAD bit when ngbe_open() fails
Date: Mon, 21 Sep 2026 17:51:51 +0800
Message-Id: <20260921095151.881953-1-zhangyunfei1@kylinos.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <178998233448.2160803.12090332415521537974@kernel.org>
References: <178998233448.2160803.12090332415521537974@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Thanks for the review. Point by point:

[Medium] the unwind frees DMA memory the hardware is still programmed
to use / DRV_LOAD clearing order

The hygiene point is fair: wx_configure() has already enabled the Rx
queues (WX_PX_RR_CFG_RR_EN), programmed the ring base addresses and
the ISB address when these failure paths run, so the current unwind
releases DMA memory the hardware is still programmed to use, and
wx_control_hw(wx, false) hands the port back to the management
firmware with the Rx unit still enabled -- a different ordering from
ngbe_close(), which quiesces first.

On the practical question: in this window nothing writes into the
freed memory. phylink_start() and ngbe_irq_enable() both live in
ngbe_up_complete(), which is never reached on the failure paths, so
the link stays down and the hardware interrupt sources are still
masked; no frames arrive and no descriptor or ISB writeback lands in
the freed coherent memory. Still, the unwind should not rely on that.

I also looked at routing the error paths through ngbe_down(), and it
does not work as-is: ngbe_disable_device() begins with
test_and_set_bit(WX_STATE_DOWN, wx->state), and on an open failure
that bit is already set (the suspend-time ngbe_close() set it, and
only ngbe_up_complete() -- never reached -- clears it), so the whole
register quiesce (wx_disable_rx_queue()/wx_disable_rx()/
wx_irq_disable()/TX SWFLSH) would be skipped; what is left of
ngbe_down() does not stop the Rx unit either (ngbe_reset() is only a
software MAC-table/PTP tidy-up). In addition, phylink_stop()
unconditionally calls phy_stop(), which WARNs on a PHY that is
attached but never started (PHY_READY). So a correct fix needs a
guard-free quiesce or a per-path sequencing; I will follow up with a
separate patch rather than respinning this series.

[High, pre-existing] failed open leaves netif_running() true with
resources freed / WX_STATE_RES_FREED

Acknowledged. As noted in my 1/2 reply, that bit is only set through
wx->down_suspend(), which is only called from the PCI error-recovery
path, so ngbe_close()'s guard does not protect this scenario at all
today. Pre-existing; I plan to address it together with the
failed-open unwind.

[High, pre-existing] ngbe_setup_tc() discards errors

Acknowledged -- both the wx_init_interrupt_scheme() and ngbe_open()
results are dropped and 0 is returned to wx_set_channels(). Agree it
should propagate; separate patch.

[Low] unlocked wr32m() on WX_CFG_PORT_CTL

Agreed with your own conclusion: the same unlocked update already
exists on every ifup, in ngbe_close() and in ngbe_dev_shutdown(), so
this adds no new race class. Serializing that register would be a
separate libwx cleanup.

Thanks,
Zhang Yunfei
