Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D78BD3793A9
	for <netdev@vger.kernel.org>; Fri, 19 Jun 2026 11:37:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781869059; cv=none; b=k6qe/P13jwDZ8ilhjHH1yb5Fn5jw3rX1RdTGmqWvDBGF9oKvQTinjptXMCd5ibsQGC7E5ZPMVbVbyuBGZee+U5mjBTeoAt/bjIJZbkXudNjVSAJwFCTauzSVoudb46REIqRLMzBxhWV/PTzL9oAfDISdBmEwiW4tHm2LciErFME=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781869059; c=relaxed/simple;
	bh=mvonQbQVWa6ZXoLml3aLDQSYxa94cwHBReY5bw7V5Eo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=R5wYbDTED2g9psEhfFp5kY0R6AGxJ9jECe4ett7ov+cxcareDEB1WXtjXBWVfr0JWpNB23B3KJXLxAcktUXKgUTMJy+GJTNCcwRhx/txN8QNLskRnpOUS4SZlOYTpyHlHWCfYQYoOp6TwR2qLBZe9BVgobBoKsNydauB2OXGa/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdF8De6o; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdF8De6o"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412291F000E9;
	Fri, 19 Jun 2026 11:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781869058;
	bh=mG0vyVDluQRxAy4jusCEO+px4MVfNltVsG+sO1nmh/4=;
	h=From:Subject:Date:To:Cc;
	b=XdF8De6o26MHRFAXcvYne+qrgyDnGUcBJN4ThPYhMrGAyZ1gP2Z7LH2yGkDKsl53B
	 oJ5SVC7UToQRWLQ/Gwh6RRRQjnkQFtvFs6RqNtpeQEer89JpzVTU2Xn/r53NIupYB3
	 i/I8RwIO0FQLWHmyGTX/KyU3MZsqcZ+gKSJ2qjujbiEG9r/2AWegY9Cv9qaBQOt8vX
	 SPogv2jkRQsHKzgk74FjuTjHpgjWWBCwhbav1dzFFNjiK/KOOlMPWPshODYIShMarT
	 j21mjgal4TsZruwiEZAJW865vnnGt4Ztg0/exeD3uBm47YtnPzh+bGk8KWU2sAfHa0
	 nCxGDjsEt5maw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [PATCH net v2 0/2] airoha: fixes for sched HTB offload support
Date: Fri, 19 Jun 2026 13:37:12 +0200
Message-Id: <20260619-airoha-qos-fixes-v2-0-5c43485038f9@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3WNwQ7CIBBEf6XZs2sAhVZP/ofpodVt2WhAl4ZoG
 v5d0rvHmZc3s0IiYUpwblYQypw4hhrMroGbH8JMyPeawSjjlNMdDizRD/iOCSf+UMLRHZ0aVWd
 dp6BqL6ENVOsKgRboa+k5LVG+203WG/q/mDUqPLT6ZJw12rbT5UES6LmPMkNfSvkBWx8rMrYAA
 AA=
X-Change-ID: 20260618-airoha-qos-fixes-b6460b085680
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, Wayen Yan <win847@gmail.com>, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, 
 netdev@vger.kernel.org
X-Mailer: b4 0.14.3


---
Changes in v2:
- cosmetics
- Link to v1: https://lore.kernel.org/r/20260618-airoha-qos-fixes-v1-0-37192652157f@kernel.org

---
Lorenzo Bianconi (2):
      net: airoha: Fix off-by-one in airoha_tc_remove_htb_queue()
      net: airoha: fix netif_set_real_num_tx_queues for sparse QoS channels

 drivers/net/ethernet/airoha/airoha_eth.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)
---
base-commit: 96e7f9122aae0ed000ee321f324b812a447906d9
change-id: 20260618-airoha-qos-fixes-b6460b085680

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>

