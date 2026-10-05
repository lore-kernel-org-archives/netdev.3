Received: from mail-pz2-f43.google.com (mail-pz2-f43.google.com [74.125.228.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D4D04503B
	for <netdev@vger.kernel.org>; Mon,  5 Oct 2026 05:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791177783; cv=none; b=eat+Gc8R6RaftfDKey+bOvES6gaiOwzkITiOhD9JPNky7Xt6deNh8sH/Qk5MBMIcKYu678CFMDZoyjunYbbnn1/pKrZumTVyTSU2iTRZuv7C50QZj84BpUfTIkZxm/sPt0ai3nVR/6eIBiLRPaOsb9tkjmTcNnyg448+E8XzuT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791177783; c=relaxed/simple;
	bh=cnq8VRGE9n5XuwukW5hh1k7uNWq/pATR2EzIARvwes0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mBhboNSaY26GhnehANxi+mtnJb3Z2LNEEbl874HohrR5VNH6A4sdchlGlM0V0qJEjlCjy86ra+WSZxqp2tT/nXsGj9S4XhKU7gg2g3odeyVfZdn41PSf/b874Mo8Se+5YqP3ze9Aj8UXvojP+EExzVnZdJTDakZVr2X+fGN/F+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=cxCDGj8T; arc=none smtp.client-ip=74.125.228.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="cxCDGj8T"
Received: by mail-pz2-f43.google.com with SMTP id 41be03b00d2f7-cc4aa0f1a94so363280a12.2
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 22:23:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1791177782; x=1791782582; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RXR2cjF2SX9+psFRCZLkP9QNDvuenu9EP2yM4v1zRNA=;
        b=cxCDGj8TR5+Em8IpK2AsZeSbadun1KRGjibOwzv/q+guPf7/oihGwAHBsLA/dhG8DL
         ddQ02GKdq1jfntw+dZsYiqzA3vSNYNapD/dmDGaeimrBJK6qoaALDvPlz0PIctouhKZ8
         OHcWGm/ygwadDbBtJIyuwAGDwEfbz4r1T59miKUSoMCUUdiLorUzAkiNkcmAkOhucY+5
         JeT2GAueIA6Kh9YFpsRu1Ivb9CLc4ehEj2xpAFDJZgBjb5X2ShwLWiJFDMhf/YpwDYrd
         EX6XFlvsKrCAfeW5A3SFFYXkwTX0JY0tVOgG68mbPySfOwmhn/D8KWG+a+0wKjs7M9bR
         iMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791177782; x=1791782582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RXR2cjF2SX9+psFRCZLkP9QNDvuenu9EP2yM4v1zRNA=;
        b=o8H7m/jMcftrgbq8AJ/yB7uL3HPjQU9RWpRKtpowKobCP0d5UiYrWyzJrj4kzk917Z
         znlRj2AIZDr/A4EB5kCpP/oNCiudsiYfQ6fcK7Er3+8CtbLh7Uy8/yoSswwQBxyHuGIR
         yg50ZjPZ8Zvv6YHeeqpSodBPUy6uiUZyyuO8rf+vLNBDu1AsXWg1iqH3Q5ePozcV3YMh
         I+OpNuOrTI95zrBSPMhLC2Kwh/IVCG2R3qpKrwdV+vdOvQ4e4XpjUcUnv7cxSKFiLp8+
         GUDM5zNXaayCTBSK30bR5hc4L5bgQ+5X7iXIHUOUwzAQivPqtXJTIrjr5Aer1TUW5KlZ
         vPjQ==
X-Gm-Message-State: AFuF++mliJVpZOADSKKbJb048x2vDRWtZZ623G7Oo1Qz9wCVOjjJ3eFl
	rGq8SL0QNFWHst61rRYBTunCBPpjohxaXX3QIUfz/WozUMK09cgma2pK8nCol8NctbwLF+lC/jm
	1be3r7A==
X-Gm-Gg: AYBFou3v/Jn4kk3HnuKszW2RWjR6aOIPnMn8CDONjTsQ8cbszY+mPwy5oRfyVmH1v1R
	Csko75SFLjv2WzxyldcTT+SlzKdomSzFgihjmJutnxM9d0/dhOibjE4jqeMqkGgdv4Qvupa52S2
	fE+FRqRoMVt6qiMf8pcmymFyQhfTMu1wd7wT3al7cbo2sveC3xShQvxZQd4zVWoW6pCiSIsP+0a
	RUygaAQ4wBUGa+xE9tDhi2XE78w+dIGFbwxdgIrWWFaj1Mg9vdBZLYHskFsVQsV5HVqqCeJAe7i
	G2bUJXfeq2S/EFzeqwRtu3Ehf67cl8MKBse1TxfAfhvtuDwdUmu/090rte+rrphCIsP33/0GRgS
	IgfHn6sgNqaC3Y/smnH+RzWedSlx23rNyFpYetu+y7Tgimav5UupO+5L4pC3l5hNqPG++7I1PRR
	nDnBJxvfub0GqcGco7UfpaPQnUSiSrFYtTyoUnmGeffDSaX03vHVxiY1HRyBr5MStY2tA4F34/3
	u0VQvnJ
X-Received: by 2002:a05:6a20:748c:b0:3dd:9483:48cf with SMTP id adf61e73a8af0-3e0bc9f0b29mr9957566637.6.1791177781833;
        Sun, 04 Oct 2026 22:23:01 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([191.222.220.30])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cce6d2406b1sm209442a12.8.2026.10.04.22.22.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 22:23:01 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org,
	kuba@kernel.org,
	jhs@mojatatu.com
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	vega@nebusec.ai,
	bronzed_45_vested@icloud.com,
	enjou1224z@gmail.com,
	weir@nebusec.ai
Subject: [PATCH net v4 1/1] net: loopback: reject skbs with a short linear Ethernet header
Date: Mon,  5 Oct 2026 13:22:49 +0800
Message-ID: <20261005052249.1914367-2-weir@nebusec.ai>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261005052249.1914367-1-weir@nebusec.ai>
References: <20261005052249.1914367-1-weir@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wyatt Feng <bronzed_45_vested@icloud.com>

loopback_xmit() calls eth_type_trans(), which reads the Ethernet header
from skb->data and consumes ETH_HLEN bytes. This requires at least
ETH_HLEN bytes in the skb's linear area.

An earlier transformation can leave a non-linear skb with fewer than
ETH_HLEN bytes in the linear area, even when skb->len is at least
ETH_HLEN. Pulling the header then makes skb->len smaller than
skb->data_len and triggers the BUG in __skb_pull().

Check skb_headlen(skb) before calling eth_type_trans(). Reject skbs
whose linear area is too short, including those whose total length is
less than ETH_HLEN, without attempting to pull bytes from fragments.
Free rejected skbs, account them as TX drops and return NETDEV_TX_OK.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/all/2d4e79d252a57bdad83435999dddf2c4b708dcfa.1785049236.git.bronzed_45_vested@icloud.com/
Suggested-by: Jamal Hadi Salim <jhs@mojatatu.com>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Wyatt Feng <bronzed_45_vested@icloud.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
Changes in v4:
- Replace pskb_may_pull() with a direct skb_headlen() check, as
  requested by Jamal after considering the Sashiko feedback.
- Update the commit message to match the linear-length check.
- Correct the Fixes tag to the earliest tracked occurrence of the
  unchecked eth_type_trans() call and the skb pull invariant.

 drivers/net/loopback.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/loopback.c b/drivers/net/loopback.c
index 1fb6ce6843ad..eaa9a5a8542a 100644
--- a/drivers/net/loopback.c
+++ b/drivers/net/loopback.c
@@ -72,6 +72,12 @@ static netdev_tx_t loopback_xmit(struct sk_buff *skb,
 {
 	int len;
 
+	if (unlikely(skb_headlen(skb) < ETH_HLEN)) {
+		kfree_skb(skb);
+		dev_core_stats_tx_dropped_inc(dev);
+		return NETDEV_TX_OK;
+	}
+
 	skb_tx_timestamp(skb);
 
 	/* do not fool net_timestamp_check() with various clock bases */
