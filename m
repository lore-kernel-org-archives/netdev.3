Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793008673;
	b=RAIduBxcZHTXqHhLuGmB4ZshEoKKvpy9r9GB/flVFmA2BPFfwLj/wrCFxjrsF9DXxKEs
	 AnitOMKX2TY4imD1DScvG+DtBfDmXIiTQgBlatMGtWZa0eEBSrt+TEEaS6CQNZN4I1ZsF
	 bbWNgxqkN39Z2ziPX4y8VqEE0Yh0sx7MKP4K4XOyroMslsldDOYZmxVY3dkMPs553RhHE
	 nq/D192IYlRpMatXHFArfZqlRpl57r108fiVPUWcYSQwTT4CPhSrINozCY5k7kkeU6PCW
	 f9kZ5uSuOcKSwCthzLkNyB2Vcf78SAUVRlEBAUSMmGCtoCAmEy7ZKL1XhrJlP2HwQGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793008673;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:Subject:Date:
	 Message-Id:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key;
	bh=TRb4tYcOuZPVhYjPWbt4D3gJvCANnKN9gzX1O8Pld2Y=;
	b=Thoi/P7NFTm5LagZpo7DTI8qe0vb0IAIAmnQ7r9Vy/uzDDDsWPLz51XggZET7RrBxMJB
	 54hq/E1XXpTE5rpj9xoRVm/RuoIQbsQt6NDM0KX4Sw7U/fJNdDKyPG2FiT3RNUb111mFG
	 nyWK2r4oQcgEMTNCmZANlcXLMeJNN5IE2+g0QidP3OZ50ckCMnwwhSuNra0x5MPc5z7SS
	 kZnNDVe6QYkiz1bVMJCWKuzaku+T8uwjiY/ZcfKl2hZROAy5cuE20n/UYRswdgsRLcgUK
	 VOpccb7DUPY3vZYHYhIdC8kYTShaUjMzAzheg+Ogm+hxXO/AXxuCk+NVG/lsJAHFP3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f4t4I0Dw;
	arc=none smtp.remote-ip=209.85.210.182
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4995D606B469
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 09:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4995D606B469
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=f4t4I0Dw
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-8a058315c79so988780b3a.3
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 02:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793008673; x=1793613473; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TRb4tYcOuZPVhYjPWbt4D3gJvCANnKN9gzX1O8Pld2Y=;
        b=f4t4I0DwTnQhTb8wMngRE7s1DR8eNQfR5qcKuOPB7B6AYY4M+/5iOkNp0xudpDx9u0
         tbMowONYmevEJXoRerwi+6pQniiLt/UdOG0SwoiUd6mos1bham8RseN8oMdb6vbQMHET
         9yWPu0LK5BaXjkOWV//rWhwRX1ukcdzL50CCMy3Rw/QTOk9xNAWDofvAaEbETxmC2c+V
         Sn2jT5U71rWFcvf4SOEU7y87wyrEk4ZZmxHpADd38ITmcWF6TC5gyOQ4Onl+8nsP3gDK
         LzL08BK3+OBdVksWlDyTnJwjE6C2QIL4DX+gtOqMNKP6m4xvhNtwdK97W5/ywYyZA2RD
         AEuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793008673; x=1793613473;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TRb4tYcOuZPVhYjPWbt4D3gJvCANnKN9gzX1O8Pld2Y=;
        b=f4+PDGPqQGT+ZE/BBXBA5j7LY4YYv647E51xfksG/ZjxCKGKTmSwK0HamScQqAWZPL
         bLfVY4DjO/jRceWFDtPwL7CaEwORxwonByF9Dr+mVs0QJb8bIx2KcdevuQn9ExHGl1ch
         /8VLA4egiUXlq4Do/3L5/F4iV9jfKwbt3KwECN6JUtcKV5vU0xvD8Z4osn0xYtm8kJeB
         v/jqUXKXrQgK2i20uUNDx3ueCaTMTZWoNFlwLPmYPEEvQx7sYSHNTWe4cXYrOIeQfMLT
         g6z5xoilf4qhFLMTpYreXp3A2go7HZ30UvLwAXMSGlqlDd9nvB4bXk6xTg1Lif4Mp21Y
         8b6g==
X-Gm-Message-State: AFq9FYLV65kzvRIpQecVLzh4zKbLVgF8B181XWLJiv1rzx7s/DUbW5Po
	/drKlumsK56VIy06G66UrGlbr2qoIo0q3Ana9HXaH2t8QwNnuEBwbg0D
X-Gm-Gg: AYBFou1/zOHtPTtGSm7rajhFUzioe9Vu9aBIcRHUNN2lnoGHUn7tDc1VrSPOxJg5KVj
	ZOA81Xq9ezdmNNZ9Eg1lsCGVUpQTl2J2JdMTF2xLhz1993rVIsaZZQo9REymKtkvT4z56MMekJK
	/Ac63pRhnDcb3MxRwK41OP0PPGXtS1tzE0XEJcoPHH+lXHbCpaGBtWz2A5P7AyVguWm3gkVZqce
	VigFfMTBuVxagZi4B1dYT2ugJfv+YbbP2NBYJANBlEmzw5Aor1d6I9WRVYTxFNqlGx2xyEvLG9E
	yldx8KZEFgSWRtCjkWQwnFtdBOKDYxiaPfZLouG4lg6FHH3mPE1HjkV4Kkkc7XUO9KZBGzqE2Gu
	rJdHCopUVxF8As3vE7ICtsp7T/G2/TnYPuwCCwOToFaxySk/PruZDfq9iC7g3jz3LMDG//womyH
	dCd67LWr+936xr61PD7aUPQxgFrFkm2tG5Wag1ZBOyEMGOEAqQc2wfUtV7yZ3Cwdm/jabaPB/Nr
	EOAvuWc7TdUKabx8M0PhqcKkqFH529TG1qti5QcrqihWEwjjdN6HrcyNcJ3Q1A4JyAHBcFFNRMP
	FxjzT49ExVJCUkIHMcqL36uD8mOIaPU=
X-Received: by 2002:a05:6300:6bc9:b0:3e2:59b5:a6a3 with SMTP id adf61e73a8af0-3e7a1b97c06mr4376109637.0.1793008672624;
        Mon, 26 Oct 2026 02:57:52 -0700 (PDT)
Received: from [127.0.1.1] (59-127-145-64.hinet-ip.hinet.net. [59.127.145.64])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36bf0f4dcsm1095577b3a.44.2026.10.26.02.57.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 02:57:52 -0700 (PDT)
From: Zhi-Jun You <hujy652@gmail.com>
Subject: [PATCH net v6 0/4] net: ethernet: mtk_wed: misc fixes
Date: Mon, 26 Oct 2026 17:57:27 +0800
Message-Id: <20261026-wedfix-v6-0-a52f6b15d2fc@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHQUlJIzE
 vPSU3UzU4B8JSMDIzNDA0ML3fLUlLTMCt1EMwNLA1NDUwMTcyMloOKColSgMNigaKW81BKlWIh
 gcWlSVmpyCcgIpdpaAELEUQZvAAAA
X-Change-ID: 20261018-wedfix-a60905150472
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Sujuan Chen <sujuan.chen@mediatek.com>, Rex Lu <rex.lu@mediatek.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 Sashiko <sashiko-bot@kernel.org>, Zhi-Jun You <hujy652@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793008668; l=2955;
 i=hujy652@gmail.com; s=20261026; h=from:subject:message-id;
 bh=549qJPyhyqlBNx06uotz1gnmv+Qgyf4W7lO1nGNCwHk=;
 b=s6R3dKe4amKcP5NVpaUVkILmnGN7AjJuw87IEHxjMsgOZ4RpuDVhDNjo6RwpCw1Nd9be1Olqg
 dFeUk96NAcuCyw/2hqTkfxI7BpUwpPLsEq0U1p4SG/c/MXdoXkslwoX
X-Developer-Key: i=hujy652@gmail.com; a=ed25519;
 pk=uXjqvnRsKEfHEyUr63sOg4fEJIDs4AmiW/rB1cWarXg=

Ths patch series includes some fixes for issues that were discovered
by Sashiko and one original patch fixing issue I encountered.

Patch 1,2,3 fix issues that were found by Sashiko.
Patch 1 was compiled test only.
Patch 2,3,4 were tested on a mt7986.

Patch 1 fixes tx wdma ring reset for WED v3.
Patch 2 fixes the reset condition for rx wdma.
Patch 3 fixes rx ring and tx wdma ring not being freed up
Patch 4 fixes WED on non-DBDC mt7986.

---
Changes in v6:
- Update cover letter to address the platform that the patches were
  tested on.
- Update message of patch 2 to clarify what's the issue.
- Update patch 3 to rely on ring descriptor instead of an extra flag.
- Squashed patch 5 into patch 4.
- Lin to v5: https://lore.kernel.org/all/20261016-wedfix-v5-0-8b02e78fd34f@gmail.com/

Changes in v5:
- Add cover letter.
- Add patch 3 to address Sashiko review on rx ring and tx wdma ring not
  being freed up.
- Add patch 5 to address Sashiko review on error handling.
- Link to review: https://lore.kernel.org/all/179000700034.2160803.10594281691384015089@kernel.org/

Changes in v4:
- Add patch 2 to address Sashiko review on rx wdma reset condition.
- Link to review: https://lore.kernel.org/all/20260730090030.201100-1-pabeni@redhat.com/

Changes in v3:
- Add patch 1 to address Sashiko review on WED v3 tx wdma ring reset.
- Link to review: https://lore.kernel.org/netdev/20260706101044.161059-1-pabeni@redhat.com/

Changes in v2:
- Address issues raisied by Sashiko in patch 4
- Link to review: https://lore.kernel.org/all/20260706101044.161059-1-pabeni@redhat.com/
- Add comment to explain the special case
- Link to v1: https://lore.kernel.org/all/20260630144831.1109-1-hujy652@gmail.com/
---

To: Felix Fietkau <nbd@nbd.name>
To: Lorenzo Bianconi <lorenzo@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>
To: "David S. Miller" <davem@davemloft.net>
To: Eric Dumazet <edumazet@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
To: Paolo Abeni <pabeni@redhat.com>
To: Matthias Brugger <matthias.bgg@gmail.com>
To: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
To: Sujuan Chen <sujuan.chen@mediatek.com>
To: Rex Lu <rex.lu@mediatek.com>
Cc: netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-mediatek@lists.infradead.org

---
Zhi-Jun You (4):
      net: ethernet: mtk_wed: skip ring reset in wdma_tx_ring_setup for WED v3
      net: ethernet: mtk_wed: fix reset condition for rx wdma
      net: ethernet: mtk_wed: free up rings during detach
      net: ethernet: mtk_wed: setup WDMA_RING_TX(0) for non-DBDC MT7986

 drivers/net/ethernet/mediatek/mtk_wed.c | 27 ++++++++++++++++++++++++---
 1 file changed, 24 insertions(+), 3 deletions(-)
---
base-commit: 7076f684d5132e6a6145e1da2fa74771ecd052e5
change-id: 20261018-wedfix-a60905150472

Best regards,
--  
Zhi-Jun You <hujy652@gmail.com>

