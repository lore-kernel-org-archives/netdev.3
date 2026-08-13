Received: from mail-pj2-f4.google.com (mail-pj2-f4.google.com [74.125.227.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D95E3321A7
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.132
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786648085; cv=none; b=YrXYEp1ELhb5t6DzU0iQEA9IdYhDNu+ICgAx1V94TQ5nJqNu80YLU5vJeyz/Rg9D+friw9U5deGpvhlqJHYpHP9lkCE/qcUZRI5EEOapPfZmp5nEj8hK1dBWoGttsZoAhNm5VyV6RWxfEVe3hvuuLLhcb5W7y5j4DS//wcpSesE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786648085; c=relaxed/simple;
	bh=kLTVFMDG9ofr+3bjhE0y0sSg0uRIn9xxlak7gnmQOSs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NNrJ3G3R6EEHsJbwRgrisThF0F5OoVKOrk61a6xiSy+vBljdVAEE/pkrruts6LMxUkH1jP4t2KzjvXHotoH6c7Y9laVH3YPWWzYBFU5wUwCZUdlE8JOcoNc8PyXpOpWawRQJV8IrdHlW9tok0Y9P1sndoipylkyb+dwnusoF6YM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iB2YDucC; arc=none smtp.client-ip=74.125.227.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iB2YDucC"
Received: by mail-pj2-f4.google.com with SMTP id d9443c01a7336-2cc80544c74so907015ad.0
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786648082; x=1787252882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VCh4FhUfWPAIY5oCHgOyENQTN+HS1fAJsuh3sXLGPjQ=;
        b=iB2YDucCDHpD0H4rftrkQEpJlstR0r9YmowM1vfX4Fgr4oZSxYbBbcedTznuo8B5YP
         2P3aD3n/qrYlDQfgg6w2SMoeteT827GdPV0jdQMpVM31OoYNA0tvZQUtjlXoLxAPe6Tj
         CG8kqbO8K1IR1hRSDssaOjE53zkNZn0kw+C15YrdL8ZxBG3gkeDIe0ShIJc3e5I9KVPf
         YKqU9sSGSVZFtT5R/6hTAzFeItcRhj+ykyiRD/HtzHW9w7U+0qO8EDXBwZtHAETjgjWn
         Xbl0Lt7QhiJsDZOXgDsVV9io8zh6DjJYrCSRnn7PDlmdCXmi/RqOLV5L92Nv2VcxbnDP
         Ob+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786648082; x=1787252882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VCh4FhUfWPAIY5oCHgOyENQTN+HS1fAJsuh3sXLGPjQ=;
        b=qVGom7UilVEuU0MfUSj2N8qi5o3ELKBznD9E/+1WT2cTY9Aql1IrZm2NPbI0iPv62S
         cD5dTgSOKYJZtVcfn9n/Fz56GwoYG9vYpVkM+BPHqH1mqZUHYW+ONvihuYhpnrzSdIXa
         E1hYzpBlafRVk+i95mGTLiUlJgru6qSF+MxpgU5ysbcVE28qjFUeuxfbhFxe2aLlZhdB
         2aR9GwYPzLAdO/9Dv/8RYwrTMFmmGV3OElszlLDC+MP4/297G9zDLD1nVBi0XSw2U5Sf
         R3jGlzCdWKw9UL3Kh9u0lNeiroS7vHR5LbMFL0gIA8aapq1uEaiX0QdfEMPzW4x1sa4B
         l9Wg==
X-Gm-Message-State: AOJu0YzdM+7kK2K45+HzYqb6+09kSzmM5teshqJkSK+v6/bzacnyRChV
	YOpymUGgozPO8GhxtTDjAAv1ba5nfuBtoYPCHIP9cPPX+jW6wiueZ4MBwRTaIVZV
X-Gm-Gg: AR+sD11LhxAQ6+ooSBSWpRB/2Sy77gtDTx+CYET7z3RFBX+rrHeQANXy3RLXOi6frwp
	oBr19Nv4SOGU6CaziCTwFC1/pnSNO7kHwFucipWs9Gr4JR1CGqRFT/J17KUfnDuDUsCLzKAFXvm
	a6ZTW4XRPr2ZW0kKqsQ4Ezg5WVn/bFO/GC2Q9/uX5CWjZrfLQNe/WLzx9/a+BCSVPoKjT9DCD/+
	CK96cCRpfsiyRuxh4Xtl7k+e6wYfl1SSOgZf6A/Tm6AEzWOLisD+O3aGoMHuoQpG1keQ0D6YJIX
	kk3oe63AmJU26WN2juzYKcj9JczNq1CwkQKMY/nx4uCjsdfRH0lzU4mH545ckBowNQLPXq47Pfx
	zsHm5lP/tmkL3QNcidDaH6NhAWFYGT523udSILAex3N/q4niDLhge9UdYsFfORXhTuf9G13gwdH
	zGab/O6PYObHUAQq15trklrFGW03dlAbwIaN7ntgPZFvVurTLmMQSfGQ==
X-Received: by 2002:a17:903:1b66:b0:2cf:b68a:340 with SMTP id d9443c01a7336-2d3b0c43462mr1698315ad.10.1786648081499;
        Thu, 13 Aug 2026 12:08:01 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:43::])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d3aeb78d20sm1310695ad.57.2026.08.13.12.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 12:08:00 -0700 (PDT)
From: Stanislav Fomichev <sdf.kernel@gmail.com>
X-Google-Original-From: Stanislav Fomichev <sdf@fomichev.me>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	maxime.chevallier@bootlin.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	aleksander.lobakin@intel.com,
	horms@kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	witu@nvidia.com,
	martin.lau@kernel.org,
	yoong.siang.song@intel.com,
	rohan.g.thomas@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net v2 0/3] xsk: pre-existing AF_XDP TX metadata fixes from Sashiko
Date: Thu, 13 Aug 2026 12:07:57 -0700
Message-ID: <20260813190800.222527-1-sdf@fomichev.me>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A few fixes to address pre-existing issues from Sashiko review.

Notes on the feedback from net-next v1 posting [0]:
- It correctly complains about ABI breakage for 32 bit systems, added
  an explanation why I think we unlikely to have any 32 bit users with
  launch time
- mlx5 batching (pre existing) - I think my point in the comment still
  stays (that we do not make it worse)
- stmmac recycled descriptors (pre existing) - seems valid but I don't feel
  confident sending a vibe-coded fix
- stmmac queueMaxSDU vs taprio offload - don't think this is real but
  we can fix separately later if it is (the existing issue with breaking
  xsk seems more real)

v2:
- target net, address clashiko feedback (mostly here and other commit
  descriptions)

0: from https://netdev-ai.bots.linux.dev/sashiko/#/message/20260810184753.135756-1-sdf%40fomichev.me

Stanislav Fomichev (3):
  xsk: align TX metadata layout across ABIs
  xsk: honor XDP_TX_METADATA in zero-copy path
  net: stmmac: skip queueMaxSDU check for AF_XDP

 drivers/net/ethernet/intel/igc/igc_main.c     |  3 ++-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 10 ++-------
 include/net/libeth/xsk.h                      |  2 +-
 include/net/xdp_sock_drv.h                    | 22 +++++++++++--------
 include/net/xsk_buff_pool.h                   |  3 ++-
 include/uapi/linux/if_xdp.h                   |  1 +
 net/xdp/xsk_buff_pool.c                       |  7 ++++--
 tools/include/uapi/linux/if_xdp.h             |  1 +
 9 files changed, 28 insertions(+), 23 deletions(-)

-- 
2.53.0-Meta

