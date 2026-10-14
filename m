Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50FDE1BC2A
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 00:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791937162; cv=none; b=Z8iigFoTCSUuTq3tjerGZglkwr0zV0v8Y/2EFUpeQFvA6UIlRdabKp1iTzttLvrZqW/mLRSJ43sSj5ECzfPfXNF3xIC2pO1EltkMoqJiAZvr4b3bco6fvsAJ0DTOdvtmHOBspV+iHve3P09Nhb88PDZnzdDoy+5oWN2bP/y5pNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791937162; c=relaxed/simple;
	bh=+CjQJw4TmLJjx0ap5zKMR4YlXTxBErMluxLinens74g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mp446vgDlPReG3U/Epq8+7iKQLRsGMdCRJmiZwRXvhzXObXMaFFbSMH2WtV9I6yDuT5zVJpDhCeo/rtzPS2mWMo1LvuIU+uBKGiCZ/0Eio0xOMVWhk9zN7GEGBzuWzf/sdjWFF6el5ycxISrw3R0Uol0W7VPSS6dv5u4+toT58A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lXtCuddq; arc=none smtp.client-ip=74.125.82.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lXtCuddq"
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-30b6dad2382so8222621eec.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 17:19:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791937159; x=1792541959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=w9IwgLzkDZ0iRcnUoTHhJ3o94HSpCzvoAYWamlL8/eQ=;
        b=lXtCuddqztDsRF+WE6xyLzgUG/4njusTKaga7Rg7Ed/WPIdVb264OfPlsiDiLrBtHx
         KSQkeZl81qtUB13EHi1Reu50/Vt9ohDJlt/n+bowbcVv7MRHjDftnu7OIdS6DPPxmjBT
         ULQsKBc5bmAUocK9lKrlOQs9QAjFgKysefFpzTAAma12qmEWN3xzImJI7rvawH19eJ5r
         RgCnq4yjJyLLq8D3Wxp2UTMBvAJ/zWG4qssnBd6ORMuLyXZDfz+AKWeQ+QxKYNET3tGN
         l0rAXdFChPnW6sfp5OyiYG4lJ6DYAk42nWojpKZiyKqR+O6uh+baRwjFtArH0O1lpbXM
         1hCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791937159; x=1792541959;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w9IwgLzkDZ0iRcnUoTHhJ3o94HSpCzvoAYWamlL8/eQ=;
        b=Mf4X490GL5HyIuPB35JblB8mo0Av8LNZ8Kb0q3r6mmZlxjTm4+rzLX7WZ/hp+zC+0t
         VK31fWPW5khU55oj2c7rdyfbO9yWPGUYnXQ78/9OZkdSF6n50SWsEO3Y2iRR59tmPghW
         qO35boaTFHh+xvfj7SZ+MDpoIyrwdX6xELTf4+SP5h0lW7+6L0By4d0219nU2zr926lu
         DwTT+dk0unV1How1txBpSxIhTJFetnJyGlxgBCtykezq6x9RQR1NjlXQhomPmot3zHhd
         r4ZyzVzTeEI5ilqpFA53qBNAOPeD3PRTqsIkV76jFT2Rhm/XDBZfTXiY6aWXttlTQ2eS
         r+0w==
X-Gm-Message-State: AFq9FYIEbSbkadeZXXW/VW5pX77NUXyq01Z8xEVAJVYH5BvACffL2V+w
	c3iNudbWZSpzP30NWLBdziBLurzGfCNK0kLJF0wDlHu2zCoMKFGDJnP10Z/DvPIx
X-Gm-Gg: AYBFou1r0XlHyOBPGcCyF+g9xhQnX27EycYfr7rlIGLcqPyWvIrfyflWP1AHrpmY8y1
	AUEqmw8ZlDhDjNa8KZxb83GppfUKf4EQinrZwXwgU97ZCwck/Uhdxoz815DyRC5f7M8Y98DlGVc
	iqpgr5cCkwwSDXuaa1vU3tJUDB1MySCPEFs1dNY0lCuoWKxLsm5eHWhBoskGkinyII70EIm4v1A
	JepAw4TLeP1PLZy62g6fgKriN9TOgJmTMMBA2jBQN8fxVqt5SqFNH3S4YVvHZ8d7gR1R3ceSbcz
	ngXIHCYbOnFKILqZM27ZvCmZzbd4aP4Rvm6m7KIB2BxxbxdPmQyyXzx/e16QEWjzNVA8LMQrQGx
	hGneqRNPHJ/zILG+XglpMwpvwKWOcC3KvwTerjsOfIsdJ0WRKxE+LjpQMYhfe2pVmFjzAs+bhdM
	2VnM1SFcsfHLQ0ewv2/+4v4Jl8gb5o0uQOsmYqj4TcHl422AeJpCwHRkVuzpBu2CTAfl2SB/Sp3
	U8dx9I+9VJNG8HMmCA4Z4ETkA01JJQJceIsYGNsXs3nfwv5LgaiGhcXbX4RiYxdpM0adbzdhEN7
	osUPh+FieX9KisYjf7rSFiJyOAoK/mkEtUsTLLrqrrfTRRwkt7hGr+eZjUI=
X-Received: by 2002:a05:7300:e5c4:b0:353:5d9a:9971 with SMTP id 5a478bee46e88-3537e088be4mr19654921eec.18.1791937158928;
        Tue, 13 Oct 2026 17:19:18 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cab27d5sm52213504eec.17.2026.10.13.17.19.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 17:19:18 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: bgmac: don't process RX with a zero NAPI budget
Date: Tue, 13 Oct 2026 17:19:12 -0700
Message-ID: <20261014001912.141532-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netpoll calls the NAPI poll with a budget of 0 and expects only TX
completions to be handled. bgmac_poll() passes the budget straight to
bgmac_dma_rx_read(), which checks it only after handling a descriptor,
so one received frame is always processed and bgmac_poll() returns 1.
That trips the "exceeded budget in poll" WARN_ONCE() in poll_one_napi()
when netconsole is used, and passes a frame up the stack from netpoll
context.

Return right after cleaning TX when the budget is 0. NAPI stays
scheduled, so the pending RX frames are picked up by the next regular
poll.

Fixes: dd4544f05469 ("bgmac: driver for GBit MAC core on BCMA bus")
Assisted-by: LLM
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/broadcom/bgmac.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bgmac.c b/drivers/net/ethernet/broadcom/bgmac.c
index 427a096e5ad4..b1cb973caee5 100644
--- a/drivers/net/ethernet/broadcom/bgmac.c
+++ b/drivers/net/ethernet/broadcom/bgmac.c
@@ -1154,6 +1154,11 @@ static int bgmac_poll(struct napi_struct *napi, int weight)
 	bgmac_write(bgmac, BGMAC_INT_STATUS, ~0);
 
 	bgmac_dma_tx_free(bgmac, &bgmac->tx_ring[0]);
+
+	/* A zero budget (netpoll) means only TX may be cleaned */
+	if (unlikely(!weight))
+		return 0;
+
 	handled += bgmac_dma_rx_read(bgmac, &bgmac->rx_ring[0], weight);
 
 	/* Poll again if more events arrived in the meantime */
-- 
2.56.0

