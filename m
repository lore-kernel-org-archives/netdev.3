Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.231
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792707458;
	b=2ZdOxQBTwY/pTiK6/tkM8NBnaTCO/luZkd1GopRBw+ke0wVTGKZ1GVbq04nWCFpD/2FH
	 ny8R4J0LPneAHuKdakPk06ihjncz9epkGvomr1V1mXix7vN7+NhmzOxKkhupKEt8rSnNm
	 C8M3uRip4P5+8ORkkWS3C8vprTe6T8q1Ie7M7CuerchuM6q7YLfkypot0CK0CdeuMw3KQ
	 0p2ytcyR2Br8+FwoJEtkT4Kjr5o4HyY2xeG6ynBjCw/77bZpNj2kFum+VVY8vFxewB1Fo
	 bar0YttTzvrd0VA8BMdWmjsTkAq7tESBbnEENoKdFk56LQ0yD3vV97iuaV9wtcgAyVw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792707458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VHaeZGgjerZ5PlElz/VM+qJtbp4LLZwii715TTrJtLE=;
	b=HmgY1sW9GRKfuTmSGsScxfNIL5QaAMjwOKhQnR/SATcVaQrZX57Y8jb9BYYb474Mephs
	 VE0omm2SEnNk0xY6gVxXE0yFvAXRmPbfCW1Ln5YyryIK+buV2aqVXquBTOzLmaq//sPQK
	 hDi3hLXpk9NNP57yLa5Y2n27PF/1FXwJyzCvw6ANJnZjc+ePmdXZxP6qsunys2G613AR2
	 9wB3ECcRpSxttY/zyyM1bR86HJKJiXboUxiR0aJgIgVV7TKoRskgfFhmGw5xiq0BAcxfo
	 HVGrGdMbma8DYfP+3OaLzu7EjhlOKfECtSN6/BQowwKqSC2KcOOcYQ6tChyJ4FLaJjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=LQZJyh59;
	arc=none smtp.remote-ip=209.85.215.231
Received: from mail-pg1-f231.google.com (mail-pg1-f231.google.com [209.85.215.231])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180DF606A31E
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 22:17:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 180DF606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=LQZJyh59
Received: by mail-pg1-f231.google.com with SMTP id 41be03b00d2f7-cd6a7e1f4e4so131705a12.2
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 15:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1792707456; x=1793312256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VHaeZGgjerZ5PlElz/VM+qJtbp4LLZwii715TTrJtLE=;
        b=LQZJyh591EaLfct1rUy67PvZZjeQLBLlyfgKYDmVehyElSbn9xeHi+iKYzIB5FfBgG
         Yf3yneVygpN2dFSHaaCD21+Xdx/7zXDzblZN0nDOF503xQiqspxxWQ8lR+mbDxzij2wb
         Tm1zYL10qsR6KUyklRrxjh/5ZnibGhE3HYtA1kqJ8WMSD9pv84gr6sHAGWQ93OMH5XBM
         +aVH6myzHsqPOrc1izZfSQ2iHc3CbYphp7kRewDjhYz3rCfNKB1LF82XYZgPXjdFf9mr
         K0AcitJApwAc7f79x8nLuHvXEu2JDOFSKD1A79AGgd/E575MRk6emqt/P5hqNDmNxyhb
         /UFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792707456; x=1793312256;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VHaeZGgjerZ5PlElz/VM+qJtbp4LLZwii715TTrJtLE=;
        b=VCGD+KrU8CvMFE6XkOysOSD4DsXIFSjGvKuGZYfOyvtnOiLC1V4G7SCnb1Mt4q8HGY
         LZi0cSyR4FuAqwF18L0K/NwQ6kpC+Jsc4Fa8Dn2zjF7Z1Vr6V54Askj/Bj5Fmzsduen0
         P2UxvtX9g7PDe+zHBaqVUhTYncyDxgkNshctDAr1stqu+bWbiCjjFO1R2AWU3NbG4iy6
         cwfFIK6URSnFySRQbqCqare+VH00yurFA0etEJVQ/94IhiCfQt4hYycxYXJr8/qYA/BG
         l9aHOtt4ETj5DRcZ/Lh7y2v9nwj1VVIDvaFQXHYjfRLHzqnv7ZaO57Da/QaT2Mk2qb/T
         XUNQ==
X-Gm-Message-State: AFq9FYLHJQFfMbTc77poNdt/rIyNfq/42M9sQE09uao6PkTMiGIfsglf
	eqsMPY2EswADK29hw+UGfcb62tWDE90g4xG+iFr3V8taqhuY1XIoAMNw34XvmT04RU8pDeR0QMs
	AX4YUOEKJYasXZJhV7y/qVOuyYWVIL0xZqjRwPyTjQPeJ9/b/636cPcb6i+lQRKLKkz6cOhttvw
	9HHlfo0aI514eoDAvpNo1PMf0/Jh3CRzAUv628qKa1C1lBpXnZkt2iKNTHmJUjVajywOz4ma1/d
	nbpz9iY3Gw6paGJI2IbXrKWtUdXh7vDHw==
X-Gm-Gg: AYBFou38Pf1N9e+V1ATuklG+4/PKFsLdiqWSVzJTDt0mqz+FkxY77tt4m1et2n1fh42
	QNSp6XF0Yn96QnZjo40F5zJj/NHZG/48SNzaXKJ0tLPN5CXN3oV72Q0znB4rkaSXEnvxp9Lup+j
	js0+G+SZJ0pS2TC2nk91v87WdiQQ+8gkh1vwU1LYvNn87Fk/fCozgjRM6nVCN8PTWmhPctwbcL8
	9idNjny+FhGH2SYgURaudgin+0ba3QOROTtvjwHX9N6VhaTzTgEV5sfhr//sJTqpAhJCKYSvvba
	dcEJ7qul/+oQ3rICPyPbKMZFy6WRiilDBB9ZsjFYjXpCKSNq6PBwb8Da4JE4hLnEdIBpm1FOO0T
	LgQcTSDgDouH5D0NeUzk=
X-Received: by 2002:a05:6a21:3d85:b0:3e1:fcec:c724 with SMTP id adf61e73a8af0-3e369354483mr186171637.31.1792707456192;
        Thu, 22 Oct 2026 15:17:36 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([2620:125:9017:12:36:3:6:0])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cd8ba7f4e4esm11560a12.12.2026.10.22.15.17.35
        for <netdev@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 15:17:36 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [10.17.2.234])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id E43954029F;
	Thu, 22 Oct 2026 16:17:34 -0600 (MDT)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id DF1CFDC48A1; Thu, 22 Oct 2026 16:17:34 -0600 (MDT)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: Rishikesh Jethwani <rjethwani@purestorage.com>
Subject: [PATCH net v2 0/4] tls: device: fix RX record start tracking after strparser rework
Date: Thu, 22 Oct 2026 16:14:56 -0600
Message-ID: <20261022221732.1397620-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
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

Since commit 84c61fe1a75b ("tls: rx: do not use the standard
strparser"), the record being processed stays in the TCP receive queue
in the strparser's normal mode, so tcp_sk(sk)->copied_seq points at the
start of the current record rather than past it. In copy mode it is past
the record, plus one if TCP consumed a FIN with it. Several places in
tls_device.c still derive record positions from copied_seq, and the
copy-mode header parse reports a record start that ignores where the
record begins within the first skb.

Patch 1 makes the strparser save each record's TCP sequence when it
starts parsing the record, before anything can switch it to copy mode,
and adds tls_strp_msg_seq() to return it. It uses that to fix the record
start reported by the tls_device_decrypted tracepoint.

Patch 2 uses the helper to fix the next-record TCP sequence passed to
the device by core-driven RX resync (TLS_OFFLOAD_SYNC_TYPE_CORE_NEXT_HINT,
used only by nfp). In normal mode the device was told that the next
record starts where the current one does.

Patch 3 fixes the record start passed to tls_device_rx_resync_new_rec()
when the header is parsed in copy mode. It was the start of the first
queued skb rather than of the record, so DRIVER_REQ and
DRIVER_REQ_ASYNC resyncs could be missed and CORE_NEXT_HINT given a
wrong boundary. Commit 9466ef3ec972 ("tls: fix RX desync on overlapping
skbs") made this path more likely right around a loss of device sync.

Patch 4 fixes the checks that decide whether the next record is already
queued before a CORE_NEXT_HINT hint is sent. They used tcp_inq(), which
counts from copied_seq, and now count from the record start, so the
result no longer depends on how much of the record has been consumed.
These checks were already wrong with the original strparser, so this
patch fixes the commit that added them rather than the rework. It
depends on patches 1-3.

Testing:

tools/testing/selftests/net/tls passed 655/655 on each host over
loopback, covering TLS 1.2 and 1.3 with AES-GCM-128/256, AES-CCM
and ChaCha20-Poly1305. SM4 and ARIA variants were excluded as those
algorithms are not enabled in the test kernel configuration.

On two mlx5 hosts with TLS 1.2 AES-GCM RX offload, all 28 cases
(1,344 records) passed plaintext and sequence checks. 26 cases reached
hardware decryption, four of them after a DRIVER_REQ_ASYNC resync. In
the other two, offload was installed mid-record and later headers were
split after two bytes; the NIC never issued a resync request, so these
cases cover only the sequence argument, not recovery.

Patch 1: all 1,344 tracepoint record starts matched the TCP captures,
covering normal parsing, copy mode, and three records where the copy
also consumed a FIN.

Patch 3: in 192 copied-header calls the old expression would have
reported a wrong record start; the fixed argument matched the wire
sequence in each. Hardware recovery through one of these repaired
calls was not observed.

Patches 2 and 4: these affect only TLS_OFFLOAD_SYNC_TYPE_CORE_NEXT_HINT,
which mlx5 does not use, so they are verified by analysis only.
Review of the device-side effect from anyone with nfp kTLS RX would be
welcome.

Changes in v2:
- Save the record start whenever the strparser starts a new record
  instead of on entry to copy mode, and keep the tracking in the
  strparser; rename tls_device_rx_rec_start() to tls_strp_msg_seq()
  (Sabrina).
- Say in each commit message how the issue was found.
- Add patch 3 (record start reported to RX resync in copy mode) and
  patch 4 (next-record queued checks for CORE_NEXT_HINT).
- Expand hardware testing on mlx5 (28 cases, tracepoint and
  resync-argument checks) and add software selftest results.

v1: https://lore.kernel.org/netdev/20261015201135.2744031-1-rjethwani@purestorage.com/

Rishikesh Jethwani (4):
  tls: device: fix record start in the tls_device_decrypted tracepoint
  tls: device: fix next-record sequence in core-driven RX resync
  tls: device: fix record start reported to RX resync in copy mode
  tls: device: fix next-record queued checks in core-driven RX resync

 include/net/tls.h    |  2 ++
 net/tls/tls.h        |  6 ++++++
 net/tls/tls_device.c | 16 +++++++++-------
 net/tls/tls_strp.c   |  3 +++
 net/tls/tls_sw.c     |  2 +-
 5 files changed, 21 insertions(+), 8 deletions(-)

-- 
2.50.1

