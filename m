Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52E0377A93
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 03:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785294097; cv=none; b=TTBuqI/8koiIUA9k05A3opOGAML28ynid7ImTwAdylwluBWidGX8GKjgXAvT0BdlhvW/6YkO0oOkL9iI9s3tBmxVp28ORrBNKPjQu7Msjlx4AdJqgzSE34z5E10MNjLptXItwW45gwjsXthzzkGHUZ3zR5nv002P5JuRdMxT0e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785294097; c=relaxed/simple;
	bh=QADeywbTPdfKB8Qp6OcHSYccEUAFfm+PWOQ/PnFtrK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gjz/XZXevFcm7LMZw/JFPLqvjyKh0hSXSCuN6m4QfEoSq1fP0wgComOK5zvYE0U02FVRH3rbUwN5qChhuR6CLMWZCEZMjg/KK1cEtLvii8aqa1NQ6GTDSZcfwpiqCB8yR24uzDG9nrgPN1mE1hqKVU3aafhLnsLacXz9RubhmD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gv1NXtlE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gv1NXtlE"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2cf49dc28ccso392505ad.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 20:01:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785294096; x=1785898896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=OG4+KkePz7FqiZVxRiKijjGdnD6TtTFfUDUGu0gsNfA=;
        b=gv1NXtlEpOdhqOZwIRzBYkKg0BX7dK/nJCHZCIgnepxpFi7eDl2YFZ99mLtyGan4AP
         Ly9gMVRhFPMcl33bCrnaGRfcI9VYHvWB1HT/8NoU7phKB4pL0L2z4WfKKDdibg2/0DSo
         x4UnZHdSWhhtAliFEsHQ8vpmHXaly69E6u+lyjW7Z9CPE6yhMXyzJYXmS8VypN4cuMC3
         6Y/g8TWi9izV809sowt0UA+KDM/UoPTJrKgAw7I7/0yZAHRbEgAks2opEoDcttfFwJdi
         rzdX2tv8W3hQ3SRNZ2lNRHhgm07bjy3CTcGC3aRpJu1F5H76VgHu9P4bbV5jFXXtbYPt
         QyZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785294096; x=1785898896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OG4+KkePz7FqiZVxRiKijjGdnD6TtTFfUDUGu0gsNfA=;
        b=l7Dg75bTSBulGgCYWp/qNcF2SgxxpfqQTbFskqBxbUjC7Z4DJOsvPaEu3O+6vKlstq
         j3tbpBPCOFlLNcnI6XBPalJlG7PDcwWUx8gZMafKayXa2FCwf5R2zdNyAaCZD479MQTI
         yNJ0pk+Bb7tN2qMN4RMabUJZO0+xKAQeK3lhHWvb8jM/g6+LgB3Pmwk5SS2Bok462J32
         EWFExugFAIZQsy7jiCehhJqGKzVuXHDU/mI3QTF5URT17qETrmyevqK3gtBBGS/uDsMK
         hAb2qxzcDSDKIfigJEtfZ7M59OmyutHKscW7TV0YIuZWyLE26aliGnaoeABAxDVOX0Dd
         5Ngw==
X-Gm-Message-State: AOJu0YwsrSZ59cxHsk69E8RWyRbs8q53PvF8hLL0UdYBN5G7z5PhzxBX
	rIPhuNcVzhPnvX0XggpV3lysdaaG+pZjdUAV8zqdrNQ74IztSyIu9VdchksHywuD
X-Gm-Gg: AR+sD13eo5zcq+1lrgUWb1xtuJh14usnrzlFWq5DPbVWczXK8vAYBGXsJeVhu37TqTk
	D1b7RuuHOFZy/Hoy1VCqe4iK+wxcLbVLH8D7EFC5GyAdc1lVYjAEtm7QPyv+MtAEjOTzPECLP+5
	R7TTNnAvkkySB8KV5fvVQoicWXPZVYb7FRHeJ3+A53BAqhJR2CR33oQxQJir4KxjalIlCCm+Gem
	cSRiW0y/fJeRXR9CD5gf8aSMrw5g/Q1MS57OrgCnCztlsr04m4nVs0Ff2NTPh3nVhdhDn+RIlkz
	qCtMBoHcLpMf0YeHt/ffZabHy9NIQ2mE5Dw6AQ+xvQ4GWLZ7iHycNwTZzrLunIZ+n2sRTSo+9Du
	akrjLgYQc9aI92ZpHQ+TyJ+Zmhe1cn/PrW8NABZIJ/4yquwYqdXNodK+6Z48wGRD+9Z+4NyKR2j
	PUrNekqg09tiH5KZ+ZeMHCUOL8EzjrqScktb2lbJrFDVfZA6UwaNAXrSi2xEl8LKLwr/tOQwykP
	4EsvwgqL7vY2uMnQPTffF8FYsfonl5aedK6HeHPNDpE8YOsMrjv25N5gX28FZk=
X-Received: by 2002:a17:902:ce10:b0:2c4:397:dd7a with SMTP id d9443c01a7336-2d015c54f1amr44563625ad.4.1785294095995;
        Tue, 28 Jul 2026 20:01:35 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.72])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d022c3721esm4097385ad.77.2026.07.28.20.01.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 28 Jul 2026 20:01:35 -0700 (PDT)
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
Subject: [PATCH net v4 0/2] packet: use consistent hard_header_len in send paths
Date: Wed, 29 Jul 2026 11:01:20 +0800
Message-ID: <20260729030122.21462-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.50.1
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

Changes in v4:
- Use one hard_header_len snapshot throughout tpacket_snd(), including
  reserve and per-frame skb construction.
- Carry Willem's Reviewed-by on patch 1.

Link to v3: https://lore.kernel.org/netdev/20260728031345.49562-1-q.h.hack.winter@gmail.com/

Qihang (2):
  packet: use consistent hard_header_len in non-ring send paths
  packet: use consistent hard_header_len in TX_RING send path

 include/linux/netdevice.h |  6 +++--
 net/packet/af_packet.c    | 46 ++++++++++++++++++++++++---------------
 2 files changed, 32 insertions(+), 20 deletions(-)

-- 
2.50.1 (Apple Git-155)
