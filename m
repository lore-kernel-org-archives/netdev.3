Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CA2437477
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 15:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562737; cv=none; b=gUHTKYVR4Fp6t5XXhkn8/AybESc9fkL0TO6eK14wIAbCJY5117VZiFYsu9SOkXee7H2onxn5Oz0lwVU+O5qdsFS7T4e/xDAtjqjo9pcpw2ydwFcY8d3p7Eyx0oU1Bzta1snl6PmKXrfmeq1VVRE2mw1OcTpuvMTEIfQs85YEYEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562737; c=relaxed/simple;
	bh=awiAFydxdIelEQ4wg8/iHoVK1CLVZXMRpWwfx96zJZc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EpTkjCH21f6+bk2itshQZlxtlnEfG5zsg8jUvlx/7OEMd05gJa+66gMqdpZ63+8VJ5HEuVhWexmpaUuu5sH/VWjiPvgnP943tOqrJy+asOlIEb4RnudJKlSSFKuCG+PXaTKaaZ96sRnKmwQZVeCFfazbUk5gu1hTqJKF5YQTJCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D0BvIK/f; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D0BvIK/f"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e347638adso5402474a91.0
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 08:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784562735; x=1785167535; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pe0BelC1xYhkiVWFcp8S5qlznLCha6GNRa/amzyqD5o=;
        b=D0BvIK/fOTuyvxtdJw63BoeoH4t0UF6wKKRpa+rjIXJL/xdfMUw1ijnZJzLbHdJpiP
         SyRlTpeKLrtAyzBnaWh4StnOa3oqZVtNeeY0msSAES5bUqmpWRBGE4ymCa4GOYcISrz9
         k436nBwc6IDB0pjwKmtJVCjxPKpMyDBgtJa6tbTYW6MMl0fMlszeEtt19anAX6eaPUlc
         NzjzVd2BeSDcA+517Np3RV5fJxe9H9UZeIbaoeLuKnqW9IVPkvaL3hrrKDCtPT04VJOi
         K19YEsEoskR6lqW6LXv3tZ4cVSAMi2f3/gMGLLU9s5im5P1QeHso8fN7PJafqnxzKhWI
         tRmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784562735; x=1785167535;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pe0BelC1xYhkiVWFcp8S5qlznLCha6GNRa/amzyqD5o=;
        b=sMZcvNqmc/7+IZtcFrL54Y3VPdnNM0XSjhjfAxu2E7g/MukwTIEuSOdIJ69rt3TN41
         N9KABsuAjt/63cydeWTXnHrBBUji1r7Fxj8hWoDNNBpc2Gw0ej5Ds6b49xy364I4Pwuq
         O0xqeeX8PuIbcQNwGAEPgsuA0hmytGp3Pv1vaF6792ozS1vu5YHz30Xyl9/4yFX5SfMZ
         Z+8S9fL4DNu+uwBAWZbW9RIJ2QhjohBSS0JgRlzXAN1hwTMVsJSGpAu9ci4423KYAjPM
         P/oEbq7bVcsKp4c7X/pfUKoNi8WaUCkdFiPJ2Dk5o1r83DRzyykwfIroIY8fCrUk/YuV
         gcWg==
X-Forwarded-Encrypted: i=1; AHgh+Rr557lK2zX6vol1VKnW/kdx5WBvgwfQmcNCl5byA+rdEFL8ky/n3JRnwltnIXU+I/rpU7so78I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmMUfK1vZFfGTXvBw3Z+UhonkfabdZGP+N9N+whHPjelNIhAna
	x/DaEDcpga8dGKGOTQvMWpNWrdvxrU29Gn7q5fqK5Bym82Dia/2f9kJI
X-Gm-Gg: AR+sD13QESYwwgrzFeZa1zqRLGtihzlgrKDPF6nPiqvwNrYacGdR4VPOwO7uiQOE0gL
	MQS0qMxgiKqbQUgFjBjCby+MQEwqH0s8uBFWw9MIXPdbZ/31geC1wx8YieWkj0bohD8xobVWQ53
	9q5PpTdsRbQRzhIX54STFVgcrsbOfKIbPFFbiK8XrqlV2s/gO5YP5F8KQ35916uGrzopRKhKbKK
	mO33d/+Cq7ZJRR/P92W2Xysr/whhtlhGT5eBcM46e+YB/5R5Ojg4oaVd+4QJgJW7w+IpFeyPNGc
	Wf6H5mIitB9IE83ot1VThjsO5PUmodz3xdyeJEd7NvTsrJUGCFDvnUz71GS6cSOpGZJ6+soPmB+
	s88Th6CCMlVtZ/EE+o35WV5zKJ6p9ntQIW5mDTbbpA1jCHy2emFXxa0W9NdGbwU+rWTRObmN0g9
	b15CgkGJ5woYEtW3j6K8uKamCyJ384xkS4kF3aiookIjNxleil/w0q4wBAozvIeHQil6QbZhgIg
	jNQsNsdK1Zuze6Snw==
X-Received: by 2002:a17:90b:3887:b0:387:df8f:1406 with SMTP id 98e67ed59e1d1-38e4b59b8fdmr14439187a91.39.1784562734431;
        Mon, 20 Jul 2026 08:52:14 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.f7a5e5c3-cab1-4810-bdbb-207cdd06de9e.globalsecureaccess.local ([2001:4898:a800:1012:e4ac:299c:3d12:cc91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4aff1cd3sm6113063a91.6.2026.07.20.08.52.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 08:52:13 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: sdf@fomichev.me,
	horms@kernel.org,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com
Subject: [PATCH net] xsk: reject tx_metadata_len smaller than struct xsk_tx_metadata
Date: Mon, 20 Jul 2026 11:52:10 -0400
Message-ID: <20260720155210.34229-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

xdp_umem_reg() validates tx_metadata_len for upper bound (<256) and
alignment (%8) but not a lower bound.  xsk_skb_metadata() computes
meta = buffer - pool->tx_metadata_len then unconditionally accesses
the full 24-byte struct xsk_tx_metadata, so any value less than
sizeof(struct xsk_tx_metadata) allows an out-of-bounds read.

KASAN reports this as:

  BUG: KASAN: vmalloc-out-of-bounds in xsk_skb_metadata+0x4b2/0x500
  Read of size 8 at addr ffffc90000f11000 by task exploit/148

  xsk_skb_metadata (net/xdp/xsk.c:837)
  xsk_build_skb (net/xdp/xsk.c)
  __xsk_generic_xmit (net/xdp/xsk.c)
  xsk_sendmsg (net/xdp/xsk.c)

Add a lower-bound check in xdp_umem_reg() to reject tx_metadata_len
values that cannot cover the full metadata struct.

Fixes: 341ac980eab9 ("xsk: Support tx_metadata_len")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
 net/xdp/xdp_umem.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/xdp/xdp_umem.c b/net/xdp/xdp_umem.c
index 58da2f4f4397..d16ad9d8f919 100644
--- a/net/xdp/xdp_umem.c
+++ b/net/xdp/xdp_umem.c
@@ -208,7 +208,8 @@ static int xdp_umem_reg(struct xdp_umem *umem, struct xdp_umem_reg *mr)
 		return -EINVAL;
 
 	if (mr->flags & XDP_UMEM_TX_METADATA_LEN) {
-		if (mr->tx_metadata_len >= 256 || mr->tx_metadata_len % 8)
+		if (mr->tx_metadata_len < sizeof(struct xsk_tx_metadata) ||
+		    mr->tx_metadata_len >= 256 || mr->tx_metadata_len % 8)
 			return -EINVAL;
 		umem->tx_metadata_len = mr->tx_metadata_len;
 	}
-- 
2.53.0

