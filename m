Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1465D3C5540
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 16:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787155540; cv=none; b=KNW4kOQOcOTbIgRwlgi6GRXUczW6a9JI4Vn2XtjMETol0cL5fPGZ+kHWTUFE0aZMnzkVqlOfUB3LMFzn+yaz4oUQJvlm0YtqmioqY9VtEOHX1/fcyWPievIrazrGUNJj1GlWlaFuebVOc65zvtE53iqtXIa494C2RZcoWfOLIlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787155540; c=relaxed/simple;
	bh=Uq72CL9fZNFRNii8z7yyMBjPeqH7XuAkPWI5AWdn+tQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LQLsQ4BaWmS+t/XcKOyqZ8tTMQ9F99lEHGPgQmKuO/eeV/GQG+7TMqYvUyM5e6qhPTP7cDTE3Z2D6RXd6DcmRI457yktIa30cTF57q8mEgbJFXyJ68gg2h/Pjr8Eis+W8pm0irFIEX+KBPXYlf2X4FyaqTCFhpW1605uvG0aIWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QAG2fIY4; arc=none smtp.client-ip=74.125.227.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QAG2fIY4"
Received: by mail-pj2-f9.google.com with SMTP id 98e67ed59e1d1-38eaa0c5df6so135579a91.0
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 09:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787155537; x=1787760337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8jkkIHI4R35tfZea7PHfGNfeEKUbdMreB+UNwExCspY=;
        b=QAG2fIY4i2E+karPkpbY3q0AiiNQxD5319hqyK44/yYpX0EonINCL5a71rNxpx71Nb
         yLxiVuCPoQ0QA1wGZRV2EzSfyrbjEnCJZJG18wMvP5NHoD9xwELbsO7ppx/2qUUJqHVS
         JiHJv5dHdH8VWYxfhPA8X0RK/4omr+SF9Y2rVMJDbdHe5aV0jnKEO5CBsGQaWXlYfYnc
         r44Bnpsq3lrguu6Xp6k0aKCwHs9ol5Xsn3yVk3yEAHhDkgKjPlkBshnTjOl7o34b/XLV
         JQJkeUAbB4sYpus54//knK/XPPfoAyVv+nOo99nXlr4UL5VgtMpDLuMgTtx0OKJYtfya
         K+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787155537; x=1787760337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8jkkIHI4R35tfZea7PHfGNfeEKUbdMreB+UNwExCspY=;
        b=qxdhoo2marUy97XKvRmZ3Z+bg0XtXZFVjrs1KEH12DUANB0Yw0acWpl9wSnIm/E9bn
         bD2yBMjQfmvCw6LkXPRLVgZf2Wu4ouVNK7p8iRDp2Mbi5r6Qsp9Jb9bsB23JJZR7UuTS
         zj41wnWAMSTlqnXfIkz9vUHggsTw2caas2ai8aAGOIcFFHboDo0JJ+UhI6SaNoN4gAkt
         5dRw1ne7ARn741t0GuxdDkb2rdYS9UiQfikc/wWIJz6pQ+dtMRB17Xa7WukW/JTpz/Lt
         iuZAJlF1DrWsDAcT61nMIkPXUHZEYElOKxI4jqNdsFosGc709+kAUhO8LNZa24+513iG
         jdSw==
X-Gm-Message-State: AFuF++mdbQHdx02pXBzmuhZ5ZHvQL9bkb40+dN9u3ylOZWheOhfIayTZ
	B4Y4h4Wznc5OgfeKd1rBeQ/hsHChj4RKcw1ifkCM6jaN1K7jkZcK89NJDKFNmzhW
X-Gm-Gg: AR+sD127Fx0vHMkd5rQCea7j+HT1QkxpTXGB0mnpkvYqoiG5+mIMvo1KYW9vZskVe8g
	Tnjb5sHZRvjxZeZ/bAFr/XAPe31uzxK3g9hI7Wsuot5ODCdoxBelBc3yajNM+poOU62++k9nuFr
	Pig2UgG4jp2eVZseSfVbok15aYXWEcn0KIVI5lSk+bF/NF4ICFGq9xUaNlbKhIaaTvXPN5FBefI
	HDyYCdpX1DVjAF4nrXI3zNoB+zljyok3xBnjH6ctDd5NHs5xhvLUKcAS0o8NS1hRte6ZpImk+cc
	D/F/41yUmVZa4GyMg7UnlHd/iCfo59091sFjVEAfEaCo5l9FBk7OCARF41eI4b8hupC7x4ULItC
	Hn7jArxpboKvmN0m2Vo94Ltfxfps3BZ4+p3zozHPP5HFPBLr3QKthRV8aRl8AhbyxNtiGlWBSSi
	uXVRMutBOIPDKFRVNheK69+YcYcUekqd99IIguTPGpqLvtlNmn1bs0KQ==
X-Received: by 2002:a17:90b:2584:b0:38f:de94:bf34 with SMTP id 98e67ed59e1d1-395a074aab8mr140125a91.10.1787155537339;
        Wed, 19 Aug 2026 09:05:37 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:4e::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957fbbe817sm1267610a91.2.2026.08.19.09.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 09:05:36 -0700 (PDT)
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
	guoren@kernel.org,
	dtatulea@nvidia.com,
	witu@nvidia.com,
	martin.lau@kernel.org,
	yoong.siang.song@intel.com,
	intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	bpf@vger.kernel.org,
	linux-csky@vger.kernel.org,
	leon@kernel.org
Subject: [PATCH net v3 0/3] xsk: pre-existing AF_XDP TX metadata fixes from Sashiko
Date: Wed, 19 Aug 2026 09:05:32 -0700
Message-ID: <20260819160535.1472459-1-sdf@fomichev.me>
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

v3:
- update first patch commit description (Arnd)
- replace last patch with a comment (Jakub)

v2:
- target net, address clashiko feedback (mostly here and other commit
  descriptions)

0: from https://netdev-ai.bots.linux.dev/sashiko/#/message/20260810184753.135756-1-sdf%40fomichev.me

Stanislav Fomichev (3):
  xsk: align TX metadata layout across ABIs
  xsk: honor XDP_TX_METADATA in zero-copy path
  net: stmmac: document oversized AF_XDP frame handling

 drivers/net/ethernet/intel/igc/igc_main.c     |  3 ++-
 .../ethernet/mellanox/mlx5/core/en/xsk/tx.c   |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  7 +++++-
 include/net/libeth/xsk.h                      |  2 +-
 include/net/xdp_sock_drv.h                    | 22 +++++++++++--------
 include/net/xsk_buff_pool.h                   |  3 ++-
 include/uapi/linux/if_xdp.h                   |  1 +
 net/xdp/xsk_buff_pool.c                       |  7 ++++--
 tools/include/uapi/linux/if_xdp.h             |  1 +
 9 files changed, 32 insertions(+), 16 deletions(-)

-- 
2.53.0-Meta

