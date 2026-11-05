Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876668;
	b=u071VdEIFJNf8TBB8OF/Ss7B6Rmbjr/fT9vcPirhZY5vUn3GJRmQCZAoEyIvwBBxdtD8
	 igV3gpn9whpAJriKXyaGozKZbHxiGg3iHUstB+UuRmH1mX6SPrBSExa7FHrnEaG5cTAep
	 QwS1XqIcRZ87/tL1YPCuAGm1SySHPutty87vGcydxtzOxs/LnwfUFFEPtHyFaLOKLCcu1
	 AweJBJy8VqiEX0icjgKvqosUNWRPrRp8XQuem/P8qd5UfCalt3RBZ8pHT8sErk/kmVqEw
	 KJiCaNMwOa+cv5b9l371LDFMCmlUxcqTG0eTgw26NAmhDJKOp7Zc9H+IdLIR199lokA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876668;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 Received:Received:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type;
	bh=ckdVqbZ+XEiDBjZjIcTqcZqx2pMHFmdH+FxX3UjOWxI=;
	b=lEoWeIbLLPYVYLuuUOkREILj3SmYOnyACvg8td+yhZCxIIQs+zVdR9/MBwIT+tacRaDT
	 DlA46ZAFu6YSI0P7WwyIlAdxt4DI0UpezQTpH1mw4s1HEE7EHPpCO1P2Gk8FhqvXJNnKG
	 Bb0MAyhnncgThgoggoKXU9WK1ttWt5bDiNRAXt0HlvzZtiJCYZDUT19/9ZV1JbfV9PoJT
	 5pFhhBtd2398WP350EJ1Iq3+9mfuVigZ4PrWkUZRQgQI3n4nKeuV1+ALDaqdAn0wD0kg5
	 ggwwVyLBqAGU5e23tiH1oAFVJFa7RPGophtpnHSrVCZ5tWRTV9Mbj5WtvR83ecUXCNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kQOnU6vb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.50
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA453606A32D
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 11:04:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA453606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=kQOnU6vb
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6b579003f29so946823a12.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 03:04:27 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793876665; cv=none;
        d=google.com; s=arc-20260327;
        b=Vg3tWTcJ1dMBRzeZAg01WIRwG50ESTSt4A69mUKv7Apg97Nz52Ls4YASdw/Ptp71L+
         aonGoYtBaV+iSO21xq2WsjOa1WSKoRciNprqiRljTZRlT7LkltttVvmSqsS9QDAasvio
         2n/sLiv4uBMQMJGLwCT1+VIYlv8E1T5t8j0pGBRbd+dCRkUwAiBa/ShLV2OVw909xno5
         Ea7qJoh17DoySZGIQh60LvTN/iVqJxv8DY386clXE/XPs0f7HndA3NnLaBaO5IhjPv9n
         TwkB56ahXRgH6+DyqN01cBngovJP7kRYhNjEbuX8RXusDQqM+6aS0KDyMplN39pUntdf
         Clxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=ckdVqbZ+XEiDBjZjIcTqcZqx2pMHFmdH+FxX3UjOWxI=;
        fh=3uxnc4YJKEAqGzVVJx4hfPlDdx+K8Ub/ebS49UFwIe0=;
        b=K/4k8JW7J2sEs2gtUbIus9+du60PEFCKNwNvxR3nwbjeq3UaTymJYtmOsp8ZmsSk95
         +XsOpOujC+NOk5bmOq40i9w0h4us8dcoB3e6Xl+Ynm9jHzgGA0CzAMFZdH6MPBHuh3YD
         a10J4FCCTgm8Bw1ET4weHX3dBTcsCF0xg8O6VqjJDxMxOc2GpsRVkJoKkK5pekJyWC+w
         mR2970VkvJOk+x4Uvya/9Da9JCO/L0VNEz6oeFoXbFxUYU4kJye/RGWvSBKQrwX7Q51R
         iTsdrcqG+SKobaJo8ecsab/4w3JvH8h99s401APj8n3od+0wlI+o5Rr4cH1L1yxS6R4/
         +TMw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793876665; x=1794481465; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ckdVqbZ+XEiDBjZjIcTqcZqx2pMHFmdH+FxX3UjOWxI=;
        b=kQOnU6vbvBlzv2wUJZDtjXRES4K22AB+2nCtRX+9Xrj9zVV7catumRxrq4w97sScb+
         D0b/k0GCpvaD2/yHptMwAWWemtEc2miD9yMmOdPGKZyoXQRWrb7rVbK3AYMZ9Rc3Jash
         KgMuYB3j70JjdeTrhGL/vU25V+8nNDgBITbzwCtnf2tErJXYLI46v62dA1BU+HGThpGN
         1G/kJTSyYfH6nbzUhhKlwieUnsmdxAu/4jcsFZbJljniPT/49bgCMotpjT5vdZc6YsYs
         hv2N69uuAr7wFzNj7MmI7Em1zZl+SqYMwevSeUFgqwJLDwbzaYuVMlfPGPxr94IdTClQ
         pmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793876665; x=1794481465;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ckdVqbZ+XEiDBjZjIcTqcZqx2pMHFmdH+FxX3UjOWxI=;
        b=Xnpjp2pGygA4Hq60Ip7GXPdIOPqaVms5GCQ/aDd/+oQp39Jv7hsZb0j39fP43oMq/f
         UGtLdunSu2VNsTJ+kBMcZKYOIZINQE/Z+20DBBZfYfPyamCfkIHoEaLMbL1/NN9DJlYb
         YHJP+cOMq8Ig4h6FH0Gxys0bmCXSyuoI2t1ty28Qrvd7H9XYT0mLGf03TykqS/n9+ctr
         hX71Mv65B7A/xGi3AX3FH64sAPODavYlOaYwg83AgYSQvTZ19klCHfSj5xAtosPPNFtS
         3N9vVzitGNU7zWgq0Yayg+uKWGnZHNqSvE84zh88MoTn0y6/hDWUanFM/66mnVlrhMGJ
         A63A==
X-Gm-Message-State: APuU4Z9ei/Zn+3uqxCDmZi11xft9ra41cE8Uow+opjRR3pFPTyawrve9
	WyDXvWqUlC723083bm3CogGV591KoWmr6HkhKcA6Mihcu/NYPpmk2TzWKQBcy++UVb33RIoJNZo
	m4rkviqoEpT+cofpQ1tgM7ZbjPVzQYmZ/GQ==
X-Gm-Gg: AYBFou365olfXFLG3Pvx8vcUL9I8gVBOX3dmevtQGzlRzMS4vtpTWILCBD/+FXKTULw
	TYkuNq8N2RDtYcddgGCJP3noFGY6tLRFT3wxcx8eJ2IvGMO6KEll+HwMBnV9Fg0uy5BIxM5y5J/
	GyMUGf4kyPRKoq/5+zAFJkCf88yKfXiaKddDh6OISqeoVtignFWREt+8OHsVwtCfswpWwuY0yh4
	LmPsED1MrTGMZFj4hENKFlRdoRZhnxK7UcSbOp0paon9pxbqiF96y94YjWXjE35RUsagupuFFbT
	sAwwVkUeRBojUsaF0yac3jLLxWRggdLyDAzDeJXD04wd8xtPmN2uzUdl7olxFIXFI4D+NhKgb+o
	22uWYGeBvJ5UGBqUn5LxaruduVq7YbmPaL2sf31J6vinJcTfy8+f0LYxKbH17LcKPFpcF/i4pDs
	9zvhwkrydI3/+wjJV+LDGEAkqWDyQc3ALvk7ZJOg/c3h4gmZEuYIrIQzfCaakC4919/EbFt8xrc
	Y9VVi7yabeTtZyZ8w==
X-Received: by 2002:a05:6402:5007:b0:6b1:da03:d01d with SMTP id
 4fb4d7f45d1cf-6b4d553643amr14135108a12.34.1793876665167; Thu, 05 Nov 2026
 03:04:25 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 5 Nov 2026 03:04:23 -0800
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 5 Nov 2026 03:04:13 -0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Thu, 5 Nov 2026 05:59:25 -0500
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Thu, 5 Nov 2026 19:57:54 +0900
From: Florin Badita-Nistor <baditaflorin@gmail.com>
Date: Thu, 5 Nov 2026 03:04:23 -0800
X-Gm-Features: AclHuK-4Nom9RDl4FW6BHaQMolk43Eurezlxzr6YWIJOrxIPsqAN2ihEbuJFFYo
Message-ID: <CADnh+D0zSzAyYCLo5cXU56o9X-P3RG3N2ix7ARPrP95d8sBXmg@mail.gmail.com>
Subject: [PATCH net 0/2] tcp: fix false exhaustion of odd-sized bind port ranges
To: netdev@vger.kernel.org
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

TCP and MPTCP can reject an automatic bind with EADDRINUSE while an
eligible port is still free in an odd-sized local port range. For a
three-port range with its first two ports occupied, automatic binding
always fails although explicitly binding the final port succeeds.

Patch 1 keeps the complete range length in inet_csk_find_open_port().
Patch 2 adds regression coverage for each free-port position in three-
and five-port ranges, with both lower-bound parities and all existing
protocol/IP fixture variants.

The issue was triggered while extending port-range tests with Codex
assistance, then isolated using userspace reproducers on unmodified
kernels. No kernel instrumentation or fault injection was used.
Codex assisted with analysis, reproducers, patch/test code and commit
messages. The task was to find a small networking contribution relevant
to high-concurrency workloads; the missed-port case emerged during that
investigation. An independent model review found no correctness blocker.

Built and booted the exact net base below and that base with the fix in
separate x86-64 KVM guests using the same configuration and binaries:

  New regression test: 4 failures before, 0 afterwards (8 cases).
  Full port-range suite: 4 failures before, 0 afterwards (80 cases).
  Two existing SCTP late_bind XPASS outcomes are unchanged.
  Go net.Listen with a three-port namespace range and two listeners:
    IPv4: 100/100 failures before, 0/100 afterwards.
    IPv6: 100/100 failures before, 0/100 afterwards.
  Explicitly listening on the free final port succeeds in both kernels.

Even-sized candidate sequences are unchanged. This is a correctness fix
for odd-sized ranges, without a general throughput claim.

The userspace selftests were compiled with -Wall. The boot-tested kernel
builds used W=1. The changed allocator object also compiled with W=1
under allyesconfig and allmodconfig (object builds, not full builds of
those two configurations). The baseline W=1 build emitted an existing
Synaptics input-driver format warning outside these changes; the changed
allocator object compiled without diagnostics. Both emails were sent
through a self-only transport test,
read back as raw messages and applied with git am, reproducing the exact
expected tree with preserved author identity and threading.

Florin Badita-Nistor (2):
  tcp: avoid false bind exhaustion with odd-sized port ranges
  selftests/net: cover odd-sized local port ranges with one free port

 net/ipv4/inet_connection_sock.c               |  2 -
 .../selftests/net/ip_local_port_range.c       | 67 ++++++++++++++++++-
 2 files changed, 64 insertions(+), 5 deletions(-)


base-commit: c6b41de4dd9f2d6856d8d8d292348f7961034152
-- 
2.51.0
