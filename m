Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC378480DE0
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788280410; cv=none; b=IxKyIIJDLRDh4QiiZD4rcr7Vk+TsRDLOFF9MXu1rzNbM63mWh8hGNWvYFm6dlWe9/QIRev6OS46jhgPVM1GPwuaR4bxB00FugVLFnB8rpq3tqza1hrxMCr2iAa8ZYNwkT2+/9Kdj3wkc0QqCaACD80CqiyFhT6J45xqUnVA/C30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788280410; c=relaxed/simple;
	bh=/NtC7onuMLJTqq24KflS9c9O/xJJwH3ox2ObOEN2/lM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gYWtC0/wqwMfa7xD94N3gQPtP90bMJ56M1eqIf8Oqsa3spD0YxITxc3eix6r/BZktFzFJ59JcHQGESYZ0yNZp+wlk/aBsxaNvfB8Z4aTe/9HH9p4gpAcGekyIbAEPrLWImUm2EnVZVVzc/6EHi1juma+AK5fb9dUoA2iVMTx20c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I0C+Bk4K; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I0C+Bk4K"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-3a2e9851ed7so206011fa.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 09:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788280406; x=1788885206; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ama4vcz/XSYo4+pHJyqT2hFXL9IvS3KsjPeWoufTaYE=;
        b=I0C+Bk4Ky63fOsKBnIBTPKArrA7tMJJ+UJ4rgUGF6Hik5RK0qJ5J51o8R7f6QMHZs9
         By5CnEQDI43mkclFWkC0HNK/ixtJQ2SDojtrDcgAJCKUMAg8nKcTThGsgXRQ4U0RHa6G
         BG6TR4oUwO7/LXJ9K0cKt/zfxh/swiIxiIjy8uv/KgiZJTZhszqhfZcR6W4H22FffGt2
         LvxsHBtIbC7i3+30TSA71UW6W4j+v7W7Usy8SHbBDfPr+ZJYGrNADQy2Kq3SRAx65KZF
         8opCwaX0tAfAXNLoltS1zACS3CnBd3CnVbqxJgEETmDcouCX6rzoYSFsjnG3/r3bRoxW
         66aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788280406; x=1788885206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ama4vcz/XSYo4+pHJyqT2hFXL9IvS3KsjPeWoufTaYE=;
        b=mfdwwqijcyIUfSPnJX0cXk43B192/buClqwy42bjJonP0GLETsx2F3ZvvOLLRww0kl
         UQ4Cfft40iasSKhOXROog1aDTboGSGCcxfrYtF+rJJ5Wttvq4xcmZ1nzhlQ4xQjZArXo
         F8gSlPWSSAeawMfmrjC4jVxni00KnEbseKwa5hgYrNVIt429aotMo5pQ/iq3QRE+fpOq
         kzHgtp/BN79U2Y5td20iVyedzkqCNvh/abN7bKVYAT9iZsK0mu2a0KXwplPwUTS0CZWH
         4LtbNfTSanpDW2kIAphcrQWUA4hqt/vZk2GfICnoEqrbxyScxnqCgy2kdbRtAeB7mRpU
         IPZg==
X-Forwarded-Encrypted: i=1; AKwUvByuJYW32ruDEd/95d4IVGDRlGnf42UOLzFiLzOQExI9HHLgHx3mjR+CyeNxaSvt601Ez15EEBg=@vger.kernel.org
X-Gm-Message-State: AFuF++mknQ7ltqL0rTJ4FFyCUYpJYBWatssjiA77OKhuuXv1Gn1dtOxK
	aBIKqzOLLc5rO14S3bIEUTw1hZQ2KATL3oKIkGuPXXwIfWfoI6Aphqc=
X-Gm-Gg: AYBFou3+HqHQQxXcxHKcwPnr0gEiJxvQgjDejs9qw1ti3z3m+6qrOMwogPS2gET8C1y
	GiYgIeG0LAexwG1dqMeSkbuNFHdqMZq+E9apEbV1vAu+txClAANwS2g98rkHdtzr9a9CQR8cyJt
	8t0OJ5I+C5lNtwBaxzRsTcJ3gQBYo2dmPU/BOz9QsWy0Tg4EhRbVEjhpTRgkFDpr3yFSMpXDKdd
	iW52U/nU0taLcfAtdyMFIb1l30in665ZiYCFfSvT5mKGP7V9fzmABj9toLUJzfo5ppwD8A/C/T0
	fEWAYaQZcAUe9RXu3cq3oj4FRa/3vR4ab0oSYqqR5iBD92CbDjhHjnl1Q8KatA5mvXyilvHOw5D
	0WUAOf1NjIa8vIFJUnpqiz/1vkkFVwDhBYBjO/XqgUWe8M0pQ6ubvK10wQWn0CHQsDYFmpw6Sab
	omb6DM4A7ojQEmROE2VsImKlOxaz8Na/zZOPa48VqVuCtQxp5DA9+gty2ijSQoPXc=
X-Received: by 2002:a05:651c:31d7:b0:39b:128e:ae68 with SMTP id 38308e7fff4ca-3a30175c52amr67573001fa.0.1788280405342;
        Tue, 01 Sep 2026 09:33:25 -0700 (PDT)
Received: from fedora ([92.36.3.203])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a34a8ed967sm678251fa.7.2026.09.01.09.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 09:33:24 -0700 (PDT)
From: Vitaliy Sochnev <sochnev.v.74@gmail.com>
To: Lorenzo Bianconi <lorenzo@kernel.org>,
	netdev@vger.kernel.org
Cc: upstream@airoha.com,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Vitaliy Sochnev <sochnev.v.74@gmail.com>
Subject: [PATCH net v3 0/2] net: airoha: fix silent RX loss on the shared CPU ring
Date: Tue,  1 Sep 2026 19:32:52 +0100
Message-ID: <cover.1788286284.git.sochnev.v.74@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260831234701.206021-1-sochnev.v.74@gmail.com>
References: <20260831234701.206021-1-sochnev.v.74@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

v3: dropped the RX ring stall recovery (v2 2/3) as asked [1]. At 128 the
stall does not occur - 500 forced PPPoE reconnects over 20 h with the
detector compiled in and armed, zero triggers - and it did not fix the
bug on its own anyway. I will resend it if the stall turns up at the
larger ring.

2/2 keeps its code and its Acked-by; the commit message changed. It now
cites the register capture taken with no recovery in the tree instead of
numbers from builds carrying it, states that 1/2 does not cover this
failure, and quantifies what the bigger rings cost in memory.

v2 [2] answered the v1 review: DONE-bit overwrite hypothesis disproven,
QDMA_DESC_DROP_MASK never set, RX_DSCP_NUM default raised to the vendor
SDK's 32.

Still open for the airoha folks: in 2/2 hw set DONE on descriptor 15
while 0-14 were untouched and the driver's consumer sat at 0. Is
out-of-order completion within an RX ring expected, or is the driver
violating a constraint on RX_CPU_IDX by leaving one descriptor unposted?
Growing the ring avoids the symptom; the rule behind it is still unknown.

Tested on Nokia XG-040G-MF (AN7583) on a live PPPoE line. These two
patches without the recovery are what ran longest here: 508 forced
reconnects over 20 h 32 min, zero rx_dropped/rx_errors across 39158
samples.

[1] https://lore.kernel.org/netdev/apaA5jDYH71F0JaS@lore-desk/
[2] https://lore.kernel.org/netdev/20260831234701.206021-1-sochnev.v.74@gmail.com/

Vitaliy Sochnev (2):
  net: airoha: handle RX_NO_CPU_DSCP interrupt, not just RX_DONE
  net: airoha: grow the small RX rings

 drivers/net/ethernet/airoha/airoha_eth.c  | 16 +++++++++++-----
 drivers/net/ethernet/airoha/airoha_eth.h  |  3 ++-
 drivers/net/ethernet/airoha/airoha_regs.h |  2 ++
 3 files changed, 15 insertions(+), 6 deletions(-)

-- 
2.55.0

