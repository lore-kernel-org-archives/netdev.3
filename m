Received: from mail-pl1-f228.google.com (mail-pl1-f228.google.com [209.85.214.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554DD49E13A
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 20:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792095102; cv=none; b=cyH5hlD07tthOwm2gxWTR/5p8U/JGKzTqGgfJ3LCo1h1aJF89YVBui10W0SZ1MEoNWsYWJPNEc/TIee+W2cnygYVSy6Zm930N3ukJJqWEjuyLDmNDNr+qj5s09QnD19XhMvpzxrDaiZnfYmGtH7AGIA62l+nliboJxiQ7OloiNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792095102; c=relaxed/simple;
	bh=oVBdcx7QBzktUk/xQNOK1ZNW1Ht2UmQ4yAgaHTBOSBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=m2tJmLG8Jrt1aXsu8OqvqrPd2El1AB00eIUV9EYhqVq2pVn1Dh9k7Y2Y+AtNNq/pkixwvHHaSUVYk9G8iVBKn/Sf2rpityn2wdzY4JcN3ygOi/vSImN4bCoO4Bmi3D53rO9VX9swcXLgNeT0c6018ASidJflTVDSfvtDGJBO78Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com; spf=pass smtp.mailfrom=purestorage.com; dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b=BvaPbBpK; arc=none smtp.client-ip=209.85.214.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.b="BvaPbBpK"
Received: by mail-pl1-f228.google.com with SMTP id d9443c01a7336-2e5378b281aso32764725ad.2
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 13:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792095100; x=1792699900; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h5GYjkagcJB1Snpe6UHyziVsipjStIncQ15Pby/HbIg=;
        b=BvaPbBpK4l0z5LQi+gDOFFhZ4Dx8IFs2qvkJrtz78pwJ3xq2ZFqXNMvrDKAyh2oHN3
         XgN/rsD0Vcxkacf1YVRNon4rFSIPXFSUuCs+mFZ1OLJSv+8L3QGdwrKh3pgNBM8CWT6B
         b7EiL+RI9rz2zMFzCGarfxf1oJXt/PWGyQLUeoKM7TnnP0azgZRLsQ3IiJi/F0QOqEJ6
         J7z0A90MjKy02NXDH5m1OFwglJuz91Jg2WyGhQoZ+TYu2i5v+eGfvvNVE2PRlLoRf4AY
         xCWpu8fQGHR19lfp1cSa3R0WQ4kZQlp95hfrK+kQgkPkg7ABg4w524mEyUXpoxoZvdJb
         eDgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792095100; x=1792699900;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h5GYjkagcJB1Snpe6UHyziVsipjStIncQ15Pby/HbIg=;
        b=nZnkobH4ZNCneiEYMlpn5tlhZlX48qwiKUOHC9Gk0M7TQ3gwx+knLOlzZ9Tk8Z9ijR
         DAExiqrwpkKv5qzsrBqYouspR5no3Z7qU7UCI2D18rdDVPwK4X9hqyHqhnJacGS5k/BY
         dJgkNAS5vNuWpIjkErrl769oA90xdhGMN2oIN/ui3ipHTAlYDea/WYMkflvu1NhvRvI+
         nBuQBObE8BjQy4M/ZH3INlOqGdHbGqsTBDDSqItdsGuUFnlOUrRf5XZTQE8SlD3ASEU1
         GYlQgpGFgJgNchb0mOCLN4PDgITdiN4nuRUfDyf6uqupNzHmTiLPUQEHStitOWuMEF5X
         oJUg==
X-Gm-Message-State: AFq9FYKC6An8aquEgAvKSOXMDen+mixs6LDuIbTyA5d6FPGWQF0Te5wT
	8ooUFBvzE0actg6JNoe/ZDfhiXVZNb0blGEq6DW/+/jNWxa4K+RGCY6B0UJrALxLYi1nKyYNSi6
	SlkAlZ52XrakOcravywgOXcdXC1A0h808G4tAganyP7SP8XF5euZc
X-Gm-Gg: AYBFou1pMpqZns6UEOpp9H4ZNBxTilRDaGJmhts8Z1U9+gZYWp2G1IQpCavGIqd54+U
	yaFnOzfFt5MwtmoTqIbDSwzzu3MznP9lmpzUIhZvBf6Cx1d1g2eBGai+/iBcOuHlDRoWWtESdZY
	gQgiP6vrW9ev8nz1dtli0Qc+BmS6hSkfsQx6RpIpB6TNZDyt/w7kShxdm7vkIrEDos0qecAAR95
	6YrJiYmhOFMnBRTUla8aKb3tXUEqke43rZe8n2m2TNP0r9r4hukhbVyNtfB/NJEbVRrDkduTgQU
	vG0mdaKy5XmqkbEqU2U79tuGab8E8S4BXY3ikHPGtGGwBkvhDXcsTpXOTKAmgEalu2yLHrC2DlO
	Jv8WOOyC+636t57xIWrIZ
X-Received: by 2002:a17:902:dad2:b0:2e9:64b9:a330 with SMTP id d9443c01a7336-2e964b9a8admr26744875ad.11.1792095099630;
        Thu, 15 Oct 2026 13:11:39 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2e97e7beb66sm70855ad.37.2026.10.15.13.11.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:11:39 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (bond0.slc5-n22m13-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:430])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id E79B240276;
	Thu, 15 Oct 2026 14:11:37 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id E1AC0DCE0FB; Thu, 15 Oct 2026 14:11:37 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH net 0/2] tls: device: fix users of copied_seq after the strparser rework
Date: Thu, 15 Oct 2026 14:11:33 -0600
Message-ID: <20261015201135.2744031-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Since commit 84c61fe1a75b ("tls: rx: do not use the standard
strparser"), the record being processed stays in the TCP receive queue
in the strparser's normal mode, so tcp_sk(sk)->copied_seq points at the
start of the current record rather than past it. In copy mode it is past
the record, plus one if TCP consumed a FIN with it.

Two users in tls_device.c still assume the old meaning:

Patch 1 fixes the record start reported by the tls_device_decrypted
tracepoint. It saves the record start when the strparser enters copy
mode and adds tls_device_rx_rec_start() to return it.

Patch 2 uses that helper to fix the next-record TCP sequence passed to
the device by core-driven RX resync (TLS_OFFLOAD_SYNC_TYPE_CORE_NEXT_HINT,
used only by nfp). In normal mode the device was told that the next
record starts where the current one does.

Patch 1 was tested on mlx5. Patch 2 is untested on hardware; review of
the device-side effect from anyone with nfp kTLS RX would be welcome.

Rishikesh Jethwani (2):
  tls: device: fix record start in the tls_device_decrypted tracepoint
  tls: device: fix next-record sequence in core-driven RX resync

 include/net/tls.h    |  2 ++
 net/tls/tls_device.c | 24 +++++++++++++++++++++---
 net/tls/tls_strp.c   |  2 ++
 3 files changed, 25 insertions(+), 3 deletions(-)

-- 
2.50.1

