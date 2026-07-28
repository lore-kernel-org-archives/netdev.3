Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 918D630EF68
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 03:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785208434; cv=none; b=pKxR70lKUrEottL7NovGnx4uKsDPh3UCKGZ+WiwGjbwT2e74Xi4rGX4zgz8x+LjDOFX2Bn3x1MTM0YQHgx19ff/rFZlXYZN/28J0hLf1OZkhNYSLDCx9kfparWBb8bFOF+2BN97QcgCP0ZwY9go0umEjVouDQpiEhJbvPZHduq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785208434; c=relaxed/simple;
	bh=v7oBAjJMIhVfdijcfMPA9HrTDSWEC2QWu+BjAmEIkd4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A85d7WNp4zwHwhgyHxrPjnEMl3ZIS7Kf5ck2McXUDYxKSzqpOa5NmpGQF3STom9JKlGxnVzztjGmYh66SnEBTMElM3byLgUBGDY2C7XGl8xVIZmUxKVJdhluIjGNbpenH7urhynlSU7/m9nGKN9aHveBP+tpdlr20eRQ3LxpeWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jRpnxh2B; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jRpnxh2B"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cad85b7b5aso469155ad.1
        for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 20:13:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785208433; x=1785813233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ts5/Y1TVWAmyd7a1WEfthTQKByaZz802Qr0m4Iw99Us=;
        b=jRpnxh2BjD4Irvz/8bwy6eobCX7e0L+jRCNGDNr5xNpjIFNLj1gAtYzmLfEnHOD3JD
         IkHW5oViIYENmXp5R2Mffiinkz8HsFJbv/RCVEZxAWawGmTJn/70Q3jMRNoKLrItmbsR
         TJTlfF3q/yNXHbSD/efHInii8SYtK1zFy4VlLsFSawOPBgvEoYKrd8MQIW/8HzGoipaO
         yl1iE1nhUpsglenSVhM0vBvCuhKlf/evN9fHc2MO4TlqqgfhtmpQTQcRPczMdgo2aslE
         hgVxyq8Zl7oFVdlTJdOxYz/M6hTvzlh/4du4s44fb0hHvUrLPSKaVHX/vTapQS0Y/aOV
         U98A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785208433; x=1785813233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ts5/Y1TVWAmyd7a1WEfthTQKByaZz802Qr0m4Iw99Us=;
        b=Q5HfRQ4PDM1CtR6mYj2jdoWeazqasiACVG3/1OJv2u576WUI1cUH5PYHU6DSWJVzwP
         NUUEeTGONdIilKXvFVvrsHdqK+FhNT9IO4PeOPOvSQFYYh71DKDSJXa5k66ObkgA5U9r
         hpQKeFU/un7vpuTbr7hzZrHpkyoSzzKAjuHnRhtKsYVsG8Y89xLTL4mOUeTnQxPfU33j
         DLPvPt1+ayguiSgtTGWvQvua7MP+XTy3LLnkPTFUm+IGRsHT5H26DvlyhypX0aOUk6I9
         KVXsiJnAHBaI1ISva0B6Ydi9nYkJ8bR26II15cVIg7xM3P48fwq2TWh31FZCessddqK/
         hEgw==
X-Gm-Message-State: AOJu0Yym+OUBDuJB9rbvrOz9VnV+tJrBpObsvxQ3n6hcpigGkLL0fYwR
	iDVb2qyRsPPxCWXwL+M9D+PuIVbs5i6LzhbSUolwpRZwMpMl9TQxEgNT22LWeG9j
X-Gm-Gg: AR+sD10fQ//jiWL8FWNR6xoOSqLO1O1sKyFXvD0Xl7RH0TU95w8XwvbmUqSE1GuGG6/
	B3mebopsOSUsytTEPhAdnDlgYBK+HWt+jQL9m0r/WPFXiIbhRGsRUeceY2A8qLO5DaJsxp+SciP
	bNHiUJPLXHJ63UAGqbQrLLn0GJEbW15O/DmSrk+19mo7+6KNaHycVv9eHtwb1hurhfsXYXWozwA
	JfyjA0e9OAFM46SBM5kZ/fG98cXbUzJ9Wbai8CxRpDPvQrTb4zoNh9hCNXbvC5m9h0zsNZ/6DxM
	L9Vi7Xb122WV8fX4+jR/u2lLlBHwmucJgV4bwTJFOdsB5wLd1DIfCwtCd9K0fI7zhVlImjHVfIl
	FYiWoJF7vqacwCoiROayWQQ2rQQ7uSIPtXvpvlw/+4q+70YSYfLakB8VaTC/Uj/rtmppY/GFLNm
	xag/JptnppGxmJpHJI03tZMpl+H7WneEcL6Yjaad1S9EkwgqOnVGDgTJ107BUlLYhc
X-Received: by 2002:a17:903:9cf:b0:2c9:b96a:2855 with SMTP id d9443c01a7336-2d0157926c3mr9244445ad.0.1785208432832;
        Mon, 27 Jul 2026 20:13:52 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde59bb13sm44311065ad.1.2026.07.27.20.13.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 20:13:52 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: willemdebruijn.kernel@gmail.com,
	daniel.zahka@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org,
	Qihang <q.h.hack.winter@gmail.com>
Subject: [PATCH net v3 0/2] packet: use consistent hard_header_len in send paths
Date: Tue, 28 Jul 2026 11:13:43 +0800
Message-ID: <20260728031345.49562-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260726092110.80185-1-q.h.hack.winter@gmail.com>
References: <20260726092110.80185-1-q.h.hack.winter@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AF_PACKET send paths read dev->hard_header_len at several stages of skb
allocation and construction. Concurrent netdevice reconfiguration can
make those reads inconsistent and cause skb headroom underflow.

Split the regular and TX_RING paths so each patch has one Fixes tag.
The separate SOCK_DGRAM consistency issue between hard_header_len and
header_ops->create remains outside this series.

Changes in v3:
- Split into two patches, one Fixes tag each.
- Add LL_RESERVED_SPACE_EX() for calculations using a saved length.
- Use int consistently for saved header lengths.
- Drop unnecessary READ_ONCE(header_ops).
- Snapshot hard_header_len per-frame in the TX_RING path.
- Reset copylen for each frame.

Link to v2: https://lore.kernel.org/netdev/20260726092110.80185-1-q.h.hack.winter@gmail.com/

Qihang (2):
  packet: use consistent hard_header_len in non-ring send paths
  packet: use consistent hard_header_len in TX_RING send path

 include/linux/netdevice.h |  6 +++--
 net/packet/af_packet.c    | 47 ++++++++++++++++++++++++---------------
 2 files changed, 33 insertions(+), 20 deletions(-)

-- 
2.50.1 (Apple Git-155)

