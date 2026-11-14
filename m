Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.72
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794628865;
	b=lEhjT1EaiqXlkhXKcXWAUcOPS7C3HwIz8uI2mAyWGw3mWRT514DDxyUDE0wNaYgJTaUj
	 pWq6yhAv0Sgq54ZHPJmTm6V+/CeSlakhWEpcm8LozrhLE2kEn66qCLq8JhJ8q6tebuj5e
	 9NddyAhXWw59DpyiDdUWZWTRCLXtvR+RPqT4IAAz8+UIc33Hd8itMi9vLgOx4d+tDl/Sg
	 sJYaGkQpMW9ZTGsTr64HMtNIude9jGWeJp7XVr938EBFaAJxYqKrlsp/Xmpopcm5Op7Ec
	 iMFiBGC+O62fFAxk99An6VgKH/hSDZYncDh7XDSWMmNZnKbc+G+oRqivE47GQsw1P0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794628865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=heVunFDKAxYJLB+e3zcEMTIy4Nh9I6pBuVgw9NvE3ME=;
	b=cixuJPdcTCbXcXAZiybWexXNuclM1qi6rxoVX8Dlj07f+VnwQGDsAkC7PTdFX/uXhv+y
	 bQuiHlbRySa+aC3abfnJIOlab2IGjqj1xYf+MTHZ/5rEgdlZ1HrNXtMDN8vYM7Z0TiaeZ
	 aWar4ncevPaFqpcrRHUEspyQx1rTEUYG74d2K2RtA1MRy0bAc7jlT1MbevmTsvLLMYRNj
	 WztGdrhPuW4yoLM/YYVJ6EhoMo2+pF4IPeRBss9fiw7YQhe1tV+v2yO31G4a4c9RbcuSv
	 AuD0/I9o+AU2kcD2EFibnvR+9Bg7lEhEmFKOdKVFHCfa467pNEbDkqCi2FZZPKdlQRQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pTYhDJpN;
	arc=none smtp.remote-ip=209.85.216.72
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com [209.85.216.72])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97E81606A331
	for <netdev@vger.kernel.org>; Sat, 14 Nov 2026 04:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97E81606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=pTYhDJpN
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-3ad30487d55so2919979a91.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 20:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794628863; x=1795233663; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=heVunFDKAxYJLB+e3zcEMTIy4Nh9I6pBuVgw9NvE3ME=;
        b=pTYhDJpNDCHBg135Q59baHcVI/ysblyBDRGLbx6tT+hRvJjqaa00wKrwY/rVU0TNMy
         K/T2TrWIDLfr4C8ITv6F8CYI5Xo5cQn5qauzVDfTvn3i8jVMl78ET28F5+2gq3bVCd4W
         CNZkJgCGLeXuThDwPV7bHnNDiMRpjQhxZzOtNpKYvff/OpMUoi5PReQXPfTiVy9bPGWO
         i8eg6TgSNxmdEW4bTo9H6n/rahYhyYYjS6+ASrSW6Etx5Fuwq0DySOZSWQgI4VFP24/j
         EhSjHFZUNUxMyYkuNSTKQ1W5a4WMBhQ8idEz8yHdKrFzII/DLff3PFA0Gk2GbkDWd+dQ
         5PtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794628863; x=1795233663;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=heVunFDKAxYJLB+e3zcEMTIy4Nh9I6pBuVgw9NvE3ME=;
        b=FZfD4XmeaS6GzFlL1okFrBmdPC5eaF9Z+3WyjBtrSjfhqlnTeoWkRLOiziHSKbM+qs
         WbDfq40MPD3WZI5FzRAaebSPxjSMRDXZpe/OKvznDtVuVdjhwP3g20JxjXpdEThBk5zE
         W3RhQW5lDicuO6l/Cbw6hzs830nbOLQ7O9O5EtuMXLyLmvKNF11Y5HmCqxTUlOOBi9CN
         0j+tF8emGlrkMrSxr24mvPL/4Bq1n8h3ilV3itVgoiob4Ld3plLd7Q8Dri6yV5guEkcV
         xDCZtlvc1zBlOUIIVnIwXVtvZbvUgqBAz+wUtL+fI8Un1bjeKbVF1jMf1owN5U0gwGM9
         18IA==
X-Forwarded-Encrypted: i=1; AL+hErFT8vQ1+U2vVAL5nx1Ey28HpIav/7uSkzBWM+DEX6BbfuQjAZTaUkHV7JH5R0ELMhB4poIrKng=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kvx4TlAMpCbAjCf3NQoK8ggUxpINqX77GnTx+m0cdMdfEdpns
	eJg5XXL/jc3k9VDEXapm2HT/1Py9Y4nbcgoftvmz55Uue74UohqR0Znny3pxYkrCKh1PS0HBKQ1
	f/bUz2w==
X-Received: from plblc12.prod.google.com ([2002:a17:902:fa8c:b0:2ec:f981:3ba8])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:17ca:b0:39e:6c68:c77a
 with SMTP id 98e67ed59e1d1-3b1b0cda0cemr4582286a91.48.1794628863232; Fri, 13
 Nov 2026 20:01:03 -0800 (PST)
Date: Sat, 14 Nov 2026 04:00:43 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
Message-ID: <20261114040101.1043546-1-kuniyu@google.com>
Subject: [PATCH v1 net-next 0/8] tcp: Prevent tcp_collapse() from bloating queue.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

This is a follow-up for commit 031c403d13e5 ("tcp: do not let
tcp_collapse() drive sk_forward_alloc negative").

The core algorithm in tcp_collapse() is so simple and has not
been changed since commit 1da177e4c3f4 ("Linux-2.6.12-rc2");
finding a collapsible skb and repacking it into up-to-SKB_MAX_ORDER()
skb.

Now that we use 4K MSS and tp->scaling_ratio, the simple algorithm
does not work well, and it could even end up consuming more memory
contrary to the intention.

For example, the scaling ratio of SKB_MAX_ORDER() is 222, but
typically tp->scaling_ratio for 4K MSS flow is 252, and repacking
data rather bloats high-density skb.

Also, once a low-density skb starts collapsing, it drags all the
following skbs into collapsing regardless of the density.

This series changes the algorithm so that it skips high-density
skb and a single low-density skb between high-density skbs, batches
memory accounting at the end, and removes sk_forced_mem_schedule().


Kuniyuki Iwashima (8):
  tcp: Clean up the first loop in tcp_collapse().
  tcp: Don't collapse high density skb.
  tcp: Stop collapsing if not bloated.
  net: Move SKB_SMALL_HEAD_CACHE_SIZE to skbuff.h.
  tcp: Skip collapsing if collapsed skb is less-dense.
  tcp: Allocate all new skb before collapsing.
  tcp: Batch memory accounting in tcp_collapse().
  selftest: packetdrill: Add test for tcp_collapse().

 include/linux/skbuff.h                        |  25 +++
 include/net/gro.h                             |   3 -
 include/net/tcp.h                             |   1 -
 net/core/skbuff.c                             |  13 --
 net/ipv4/tcp_input.c                          | 171 +++++++++++++-----
 .../selftests/net/packetdrill/ksft_runner.sh  |   9 +
 .../net/packetdrill/tcp_collapse.pkt          | 135 ++++++++++++++
 7 files changed, 292 insertions(+), 65 deletions(-)
 create mode 100644 tools/testing/selftests/net/packetdrill/tcp_collapse.pkt

-- 
2.56.0.611.g1030f0b940-goog

