Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792548212;
	b=voKhEQrPb5vi4vPcbZHRWaO60jfu10wZMLCUYMsL6gf79R8lPUfsnnbFNIJEZ2wILX63
	 eaqOBiCLqIoqbe4VOmfYWfuD6D/7nS0hFd4X6rDoHheFhWv+VohcbHA3KmCJzz/o2ORtN
	 eaXJedU7+50Nol5cGK7kSBVRl6g1iYbkEGBXcstwRZqhWj54S55B8tvOIbscf8kpOSMWI
	 tU2RC/YlcXMrSIdBXGVkP3KKFnc7QEaJLDG81EIuYjZ1KdChrbMRxSiKuACY2ItBanyc8
	 vgEZp+0rhDa8ErNw6181xAnuFsP9ascRdOCE0UVJ5H3YznTGPt/u4fsYwPjIt36jQVQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792548212;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=BlvUMX8Lu0GoGP4/a2/X6c3y355TJFwaE46ARxjS7zQ=;
	b=GAxAjweaPwuQF3Yihc9f1ZBmxiccIavB7dN3Aj2hVsNv389IlKEjfKFpGUxDTTDUPs1O
	 faeTRsld6AqBkQ5G62qUl5/kfED+aQIi4mSaDahmejjNs/PfmjM9I6u8AdEsYzUtT6712
	 geN9QqCAGhyRHxoer3X+7GjNlyyOneYGRTDXLV3zp/VejHHknEaQJ6c1oxWL27WyyCBVJ
	 NwiTZnSmXiNfShNQ+hX3GB/T6CQ0IylWeDhbkYo0p1lcK3JAPgpO+ylIaaMVUoBh5EFiw
	 6t47MhbpbgghiPX5nmpbUVoXmdiNJyk333z8XJI53GkKs0Lz6zmnZR9ANWScxHnvonA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gt.tech.gov.sg;
	spf=pass smtp.mailfrom=gt.tech.gov.sg;
	dkim=pass header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.a=rsa-sha256 header.s=google header.b=CifFtXAT;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D32606A31D
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 02:03:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8D32606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gt.tech.gov.sg
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=gt.tech.gov.sg header.i=@gt.tech.gov.sg header.a=rsa-sha256 header.s=google header.b=CifFtXAT
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cd5e6f0a22bso36864a12.1
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 19:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gt.tech.gov.sg; s=google; t=1792548211; x=1793153011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BlvUMX8Lu0GoGP4/a2/X6c3y355TJFwaE46ARxjS7zQ=;
        b=CifFtXATkbaGlUsTaBdoFlT+mxYjc+kFA264t+FxPrPhmj7Bsnk92kj5LGKdG3gXbF
         NEaI+UPYZXsFx6VBd9CSHcq32NVUKOQjKTc0D+Ep2EhxZzJ40GuR97ZT34oJ680QY3GO
         yAYK2mZBW14HZ0n6VGzAmq/FFAqVw7nAOo98A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792548211; x=1793153011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BlvUMX8Lu0GoGP4/a2/X6c3y355TJFwaE46ARxjS7zQ=;
        b=foVNJW9/NTcVYpx/4RZTLqEnYeDTuTWHOWSWdknVqx//H8qpbKThxkNCAcNSSwLSHx
         jijHoLh2LVOfEyDQL2gV1K35bYcwa+J7E3Y7qLaV0QKCvD8mTIBgvgNOQqN9GVScuxzd
         IgBf+kp8uPeB5I+4oY/nkyx4OiKMXJ5wf360uKkjhwtSR2tmMzw9lTI3hBODLB/lSKyB
         NEkGqKXUAUIdni+5D9ObnA1litrPCp1ts+U9AmzuPiGfWED2Uk+ZY8GILbVRKrZh3wOY
         tT0B73bVEYFRgFby63LGG/Y3b4m7hJE7+58nk+Ongh/stF0MfmPz/yNCsRAlXLe51ZSr
         LSBw==
X-Gm-Message-State: AFq9FYJ+QBE8Jbyxz8iQE8EjSnWuUmtL0RK/NQ73Nj8QxiPfAXhUuzQl
	MngCYNalsMtIY+vTG9fjyi/6dyoSIBANkK2/gz7g4493Lr55R3YL0HZFsCRbkXiCKQY=
X-Gm-Gg: AYBFou1TI0SkGVHwsA/Teaj7WdEN10O/k+OsGdnKOFm+rTkfWF2qXUFJrz2OO9J7aMH
	pOELVZSFADY2+phD5293I1SKMJs4Xd0455AHm1FS4uJf4fmtYwTTJhLqDvLqwcGICAbBn58eZuN
	UpA+ZL5SVkM8IRdbk66eJqY3Mso2qEh2UOULeUPdX1gcmk323NUC9qz2IXtNnOqHqvq/nHP1v5Z
	of+Q7Db6DlWawi3B77a3aWI1NU5UFb5xAnXLUPSwZf00pvI8FKx+kdr89JpEqDx1GgL1mXXn3nM
	p6wnAwCDclcv2BHMZ2HhSPZ4U3SHQa8wfmCc0chux2m8qEkiw2usw4OrkPyGn99towLtQ/feTHD
	DDXBVPuHGrAO/WQeZM4iVWJP6CF4arcVXZpIloQySnnyAnbVOwwJ4da2ticn7rc+MxsJFA1XNgg
	7mARlCDEqSEF6AN84RF2w+XkYdFF+mVrDK+yW4/KV393yVl7O3pa8HWZgeYN6J9zn0nN4j+nj8M
	K3+pgNRMjINetlRpDwT7eV4b1Jmfm5wQBcRXD24Hoahq18GzDEmMWTxMMDjztEb7G+8qboeZWYN
	52AvsmebQQ==
X-Received: by 2002:a17:90b:548e:b0:3a8:59d3:530f with SMTP id 98e67ed59e1d1-3ad86f23619mr533892a91.57.1792548211109;
        Tue, 20 Oct 2026 19:03:31 -0700 (PDT)
Received: from LAPTOP-UUUVNN1I.localdomain ([203.125.131.137])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8035a117sm1934124a91.16.2026.10.20.19.03.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 19:03:30 -0700 (PDT)
From: Wei Jie Law <law.wei.jie@gt.tech.gov.sg>
To: Petko Manolov <petkan@nucleusys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Jie Law <98lawweijie@gmail.com>
Subject: [PATCH net v2 0/2] net: usb: pegasus: fix receive length handling
Date: Wed, 21 Oct 2026 10:03:08 +0800
Message-ID: <20261021020310.34045-1-law.wei.jie@gt.tech.gov.sg>
X-Mailer: git-send-email 2.43.0
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

Two fixes for read_bulk_callback(), both reachable by a USB device that
identifies itself as a Pegasus II adapter.

Patch 1 fixes an out-of-bounds write: on the 0x8513, every frame that
is dropped because of an oversized length field advances the receive
buffer by two bytes, until the host controller writes past the end of
the skb data area.

Patch 2 drops frames whose claimed length exceeds the data actually
received, or is shorter than an Ethernet header, instead of passing
stale or uninitialized buffer contents up the stack.

Both bugs need a malicious or emulated USB device, which
Documentation/process/threat-model.rst treats as a regular bug rather
than a vulnerability, so they are posted publicly.

Testing: the series builds without warnings (W=1) on net and passes
checkpatch --strict. It applies unchanged to v6.12.105, where it was
tested on a KASAN kernel with a device emulated by raw-gadget +
dummy_hcd:

The first two tests ran against v1; v2 only adds the lower bound in
patch 2, which does not affect those frames. The third ran against v2.

- 3000 frames with pkt_len 0xfff, then 20 valid frames. Before: KASAN
  slab-out-of-bounds writes and a general protection fault in
  skb_release_data(). After: no KASAN reports, and all 20 valid frames
  are received.

- Five each of: 1536-byte transfers with pkt_len 1534, 1535 and 1536;
  101-byte transfers claiming 1500 and 97 bytes; normal frames.
  Before: all 30 received. After: the 15 that fit are received, and
  rx_bytes matches; the rest are dropped.

- Frames claiming 0, 4 and 13 bytes (three each) with five normal frames.
  Before: all 14 are received, including the runts. After: five are
  received and nine are counted in rx_length_errors.

Both bugs were found, and the patches written, with LLM assistance,
hence the Assisted-by tags.

Changes in v2 (review by Sashiko):
- 2/2: also drop frames shorter than ETH_HLEN and count them as length
  errors, because eth_type_trans() reads h_dest and h_proto without
  checking skb->len.
v1: https://lore.kernel.org/all/20261014025307.25233-1-law.wei.jie@gt.tech.gov.sg/



Wei Jie Law (2):
  net: usb: pegasus: do not advance rx_skb->data on dropped frames
  net: usb: pegasus: check rx pkt_len against the received length

 drivers/net/usb/pegasus.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)


base-commit: 746d0e7e851edefce9656ce744d4ec5e94de6b5f
-- 
2.43.0

