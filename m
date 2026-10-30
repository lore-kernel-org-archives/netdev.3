Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793327581;
	b=TKJrcqWMPgZRzv40/qUjppL5usz2mQ8ZNaI5ourn96go8WHqzGSJ4Dga/k6wCXiumajM
	 YvbjYzL0KPX98bHsM1YLY7KKXRBV4Xcf+zah8ofB5tzM3JUjHOGowpcWZtbqhFOJu69GM
	 zl/+jYjwmo5KqGDXR4toWAiPoUGf9GhgS99yHoMVHGykHRgwDc3RCgbOajtlFAbMtRLXd
	 Gt1FtBvbmqbqw5TFjrvrl4Vus6T6uTbuLZo0v6930GHwb3++638SHdJ4qcvCw1ICZadCx
	 ehAAyRqzBrkD4qsM5/auo+AGW5nzh4QNvjDuKNeLJ0lnC+STJJVlURDdf7fdTmoZjdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793327581;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=pcgb/vipsFKI93zItJdvIwVM2kRByvoCBd5I2lEqCew=;
	b=hhbezvgXSHwBGv+tRhZvGnM4sloSO8833BWrzkiEFM75A9ZGKWPCQfuq6f22gJU8hU7n
	 yfBClZB0K2hzLZRXZ3O9gC2yzbBx0oimxoct7IKwjqavwRf30S4QRy+50AH2/dk+GlSNw
	 05lpO73RIBScEG2g3zZmvImb41OiFw9U+AHUuz53Ycwi6Ig0R12q8a+s/MZN4XThKO+Yi
	 f5sKZJ7WLaIyL3rcLhmMdLOzXGp8azK8KbEUpU4UwHMldBLiOVWoIObvF1jOM4wPOk9nf
	 /zuOnrFx5Xrgk9Eda6kaC/per8ZLwJXd4x14++o4Tvv4SVtD72BTy+SDRYSw2xKwkKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I4cVE3zN;
	arc=none smtp.remote-ip=74.125.228.5
Received: from mail-pz2-f5.google.com (mail-pz2-f5.google.com [74.125.228.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF87B606A31E
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 02:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF87B606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=I4cVE3zN
Received: by mail-pz2-f5.google.com with SMTP id 41be03b00d2f7-cdac0ac5f19so101739a12.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 19:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793327580; x=1793932380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pcgb/vipsFKI93zItJdvIwVM2kRByvoCBd5I2lEqCew=;
        b=I4cVE3zNaa166lxyWLucLPwYv+KKUvcJb2782h1+tYmj2lVTSPBnTdH7SA9m7E9MjF
         0opo8avjoUPnItlZu0TYg2a1aVmH7OVIHTMN9HDYSVB6OTsM+uzbXx5oJMSmRtRxDgQF
         Psf7xF69LvGaOsj8RTjjMLfwRyOAE17xVsMKWn67GPX6PGAQQADemFAaNfTmHs3G/uga
         24/DqDEdEZbMqcql04HYUY8Mabl+kRXlUmp3Aq4hzHPqCDpfDigrJEXAjWyr7+pwGU4Q
         9gJSjAfD5AGxdLhscnnIyTuY7pH3wocg5//cRWle78FoXGuQ4ZLJP094+OwKCV6FPTWi
         i28g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793327580; x=1793932380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pcgb/vipsFKI93zItJdvIwVM2kRByvoCBd5I2lEqCew=;
        b=d0A5X85f9wUMYm3wEiUmqBMl3EofoMr6rvkRyYOqTSNgqVoFAmEVUTdj5Y5L8M+5zn
         IQXxnItjYRK19D1fAJ9F6EaxrbmHvEXpVmexdCbkON1tS8dtQqzijyzjIx8Tpot1yZy5
         Rs3mYFrc16tBTcKMJ3QBGZ6lphg1bdsjcGl88UXInAB3jjQEMIint4UkPORxAAPBP5+v
         /7yH3LYlJy+eAkABNwLLOPx80yKWOYeALrZl2Vdt0/8zeogP2aHOCcbFr2fg2KhtmOLg
         nKNteQ/mQj90g6hxgmLH35ySc4roXjdR5yzASp3var2NsfowJLBO8kWwba9qZa4rdGbL
         CYeQ==
X-Gm-Message-State: AFq9FYIFg7FkSP0ZWJT+Ys6mx3dGzGSnWezTcO5O5nQBzYpnErbF6uKA
	3Zqmyk0eFTS1+8KQl1Vw9AaPEVPpBYb+V94QtCYIN26SSdi1Tf0PyGiMi9CqPBH637z3LzJa
X-Gm-Gg: AYBFou168bWUqFzbhrsIysZ9nxlm0PQ5HNSSPM5/tI7VjCza3EFqVHIT5NelavDBPo+
	UHdXuXBKTJNxLaRaCfv2j1vslBdWshbB4cJk9+TdqcJpxDLBkVAKDYbGozzb32EAzeLWDgmV0zl
	3S0hAOs+TKh7qrHqraIOrt7caUWxdxFvpfL1WbwoRDAQL6zsNNhrPIOAPSPJgetDe9rlvzdaoWI
	f2i4hQhMYy5xH/bL0VPjUX+EFRPpErOsRMHy7pBq+VzDHQ3U9BXaDAqhtzhnTE60Z6R6zXKxHlc
	PH3Se5VvXy6MUk1al5prYnbtlbzGXiB+OxYfUyhc9LjmTFNiJVgZJPwk4iI/5vgy/eTdvZkzDOt
	vGoMIQjqK68SaLUHlrGOw9VwY45BElcg9xDCaoBB9Jr7fkz+y0KH3Y1HxY535PhAVriJVTMjOnp
	/FKvGXdPUBbN7Lm5eUa8dO47eB6gXzZA1tPv8TXzyokherQgLyviWlktBMGmqRwHF4G+p/ZtVqU
	9NfbI0OiUD3b7161c5g29yPME4Fo5hvaYbKf/BoP40Ip8GcWTiMJATxu+atqYbITIyboIMnvfkG
	NJfhVct3tAEjwlL23Hz45LtFa4CfByaMbmdr/hKOqrWUEgbQIbNtcA==
X-Received: by 2002:a05:6a00:140f:b0:89e:f8e9:205e with SMTP id d2e1a72fcca58-8a9bf71c0f3mr783776b3a.40.1793327580059;
        Thu, 29 Oct 2026 19:33:00 -0700 (PDT)
Received: from localhost.localdomain ([58.247.233.220])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a9eef95f2dsm152216b3a.10.2026.10.29.19.32.54
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 29 Oct 2026 19:32:59 -0700 (PDT)
From: Rongzheng Wang <testwrzwrz@gmail.com>
To: netdev@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	stable@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rongzheng Wang <testwrzwrz@gmail.com>
Subject: [PATCH net v4 0/2] xsk: fix multi-buffer TX software checksum
Date: Fri, 30 Oct 2026 10:32:46 +0800
Message-Id: <20261030023248.78802-1-testwrzwrz@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is v4 of the AF_XDP multi-buffer TX software checksum fix.

I found this while testing multi-buffer TX with XDP_UMEM_TX_SW_CSUM: a
two-descriptor packet had a bad wire checksum, while a single descriptor was
correct. There was no production or syzbot report.

Patch 1 moves the software checksum calculation from xsk_skb_metadata() to
the point where the last descriptor has been added to the skb.  The old
code calculated the checksum after the first descriptor, so multi-buffer
packets only included the first fragment in the checksum.

Patch 2 sends the packet using every descriptor count from 1 through
MAX_SKB_FRAGS + 1, and runs the existing metadata and checksum verification
for each case.  The last case is the copy-mode frame limit documented in
af_xdp.rst.

Patch 1 is unchanged since v3.  The updated selftest passes in a local QEMU
run.

v4:
- exercise every descriptor count up to MAX_SKB_FRAGS + 1 (Maciej)
- keep the last descriptor within the packet length (Maciej)
- fix the local variable declaration order (Maciej)

v3: https://lore.kernel.org/all/20261028025026.11401-1-testwrzwrz@gmail.com/
v2: https://lore.kernel.org/all/20261024141157.59301-1-testwrzwrz@gmail.com/
v1: https://lore.kernel.org/all/20261024091256.17918-1-testwrzwrz@gmail.com/

Rongzheng Wang (2):
  xsk: defer software checksum until the skb is complete
  selftests/bpf: cover AF_XDP multi-buffer TX software checksum

 net/xdp/xsk.c                                 |  23 ++-
 .../selftests/bpf/prog_tests/xdp_metadata.c   | 147 +++++++++++-------
 2 files changed, 107 insertions(+), 63 deletions(-)

-- 
2.39.5 (Apple Git-154)

