Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792553090;
	b=sT38gb1t7Xp/rYkb1c0HI+wV82xv47e+0Bmn9MJeXqzhng18DMMRRpqSfW+V9yzg0R9t
	 olH2fZA41glh4djl/l5aK4GDk8af4aHChbez8rSObhX/ZFRjobkSp5E/6gp18NCdrHBKb
	 X8zvqNHXXQaTVO/8mxO2RC2Z/vneR8YZHdaNlPE2nmCW/x5kqu7mbT6j1+YmoOjtlPESr
	 BDzvxGdX9rw6fZqSVx20cZq0/kK3Tot9dkfzTIb3mEOYf3jDKFCY4dzsE2O+ldeOVjVr3
	 55oXy2IWY7EbeW4/4S13LhG/vovneCQIfnTCV7iSQILHpZFfWO+np2Igjdfz4yWqWHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792553090;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=Y8qAdHKhHoP8DpQW3B1dUXlYVRW6lqzxu3F7cl++c/0=;
	b=qY+wjZF1ALlK5Q86y4iO6vAbzaqSgOCP0Hio5N1SZxdETTjatbJEGcH1dlfT7YaaHNpz
	 hLVFt7uBKQSueTADthMyN8YNHnWPCLI07Iwy5526xoYCBoIugPJqG+wKhqIYor4ABrHov
	 OuWUvAKE++RhAKDNdG/7Mccw9xJRBHJSJWdM9DDSVxETWp4hI84MEnlvXtgDRN9LgJJAc
	 t4D2e9pR6YW9SuOamZw/LNzLRivYmMB7AHHtkvxSXbqVY1704VUcUAUNZ9X/KKpGM7jYG
	 N10JJhQ1cUHwJwwW74caAB2k4ebvFsTmS43T/TLt7kO/Fpv1q5XfCzwGUuKPYoAo9KA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=octane.security;
	spf=pass smtp.mailfrom=octane.security;
	dkim=pass header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=leOHtMeO;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D093A606A31A
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 03:24:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D093A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=leOHtMeO
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cd6a7e1f4e4so49862a12.2
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 20:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1792553089; x=1793157889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Y8qAdHKhHoP8DpQW3B1dUXlYVRW6lqzxu3F7cl++c/0=;
        b=leOHtMeOwhzxSgsxomewIt1duzeWAEIpCpdNTaBqelAgj0uslrUJPiMloNlCjUA9VS
         YxSvo/Z3Ivwxrcym2sN0WF1NyctTGUwjfjF3zCG0r++yx6SC4nXYUF6a+dCy2Lk9jKod
         KyMgmZxqTEX1ps1x0i5DCoUcchptSrRvrmd9LKkZ2tXZUWkAGg8JabicIikHr1z+RiJq
         Dy5x/qlX+isJzXwSpz6TOaQoWC48Hg1U3GNtZx3sf6zzfGgj9yoxzMC/OJYWRHa2uXen
         2FYz1kmZNT7U+jxd2KpUyNV2ZdAAQ4/c5m3v+e5jq4RjunYWSvBD5cdEjVDgyR8eUGNK
         c8/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792553089; x=1793157889;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Y8qAdHKhHoP8DpQW3B1dUXlYVRW6lqzxu3F7cl++c/0=;
        b=d9kuEmgi4coDJs6KVxBkMea/8NJE7mIow3RYnzBKEqyF2rIjXU7WWLZ6nENYbkmd2z
         jTEeQpNfAdrcSqUz/WfcvjYpIrYZMrSlzraW+BXIb5tTH4y5z9IATqqyEvpkLzLeqgRQ
         ZxUp8OB6XdQ0ohOQYP+k2C5UJ2DASIYhVJcVDEdgyShSEo7eA1TP7vejUMf6RYKyigH7
         6UxTiBSPf++tRi8edKosqVkxgpsKeeQa1Phhv3tNG0eD2quhsqWmrVd2LmqAIBzJiBeV
         A//E6sFq78ziTNT/0e0/l9Y3UGCF3w53Lg1VripWkOLvPI9VfkotrLGUc/iWIQUStf6S
         jgVw==
X-Gm-Message-State: AFq9FYLgDBJt+lSd7DEfIOgIagLi0p8YQJ+iWjWqiiA+tFdJYV9Uij4+
	oo8A2aZTJzouyilI35yNoqv/N32xBK/P0JPtkY3rqMr/gvqbU5y3LUsygJ5SDk3n9RrrWsf8AyR
	BgAdV
X-Gm-Gg: AYBFou00E635aND1eIkUbUrSPQhdqWLSGjmD4G1RdwXNQS9oVZ5aifNP5seHBUwdJra
	8BIIaFh5WLzWVVRZWeYQ+Q5V+o++CrzKywS3z6ULccEqsWIMWGhjgeU5V1T8GGkoNrlFaV9+jQI
	izirsii0COvohRFYj2vf7gbPtLOFmHM6S4+4z6olKVcS95aK1rjiDJhLcryfMQNuDetXaK1Jrg/
	YA5ch45Ecd64WcFEHTyMrcYbA/TC5lrDppcQA9SCBrnxXSPhO+/Te6NWW+VVpCwPQBLf/Uajmjn
	0oNlJPU/6NinoWnRxDWdyjObcobkIWoRhlOvIdswx7ApBtkk5CG7GWGRGeGbUccbLvr8Z5ar78P
	asGoFLxjsq370p9ai9D5Gr6PE7QTQoFvVBg6NSZ07/El1CS0l6OCStNbd93CG46ebKyZOsY3RuH
	oHGnFhSN9EElw8T14/ZlkV4KkRws74o3p7ijD2GVd7fj55rFwjbZHOP9loQ3S5qai2WKnf6YZJR
	jCrEuRPa+kArElQLKmTvG4Y8AheEutllCy5F/Sw7Vmdan6biQmQFAW2p4H2VyeUwjzJ4YAYaDDo
	xR1+qtRQ2OR1ivKHL21QHkS8GzcS2/YjgGUYabGVQApMIToCR91egkI8Rqy4r/F0c7MiCNh+9zz
	N
X-Received: by 2002:a17:90b:4c04:b0:3ac:a491:3cf8 with SMTP id 98e67ed59e1d1-3ad86da24e4mr747324a91.43.1792553089020;
        Tue, 20 Oct 2026 20:24:49 -0700 (PDT)
Received: from localhost.localdomain ([103.207.175.177])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad8030226csm2155285a91.12.2026.10.20.20.24.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 20 Oct 2026 20:24:48 -0700 (PDT)
From: Shubham Antil <shubham@octane.security>
To: netdev@vger.kernel.org
Cc: David Heidelberg <david@ixit.cz>,
	oe-linux-nfc@lists.linux.dev,
	gio@octane.security
Subject: [PATCH net v6 0/6] nfc: fix NCI UART and firmware teardown races
Date: Wed, 21 Oct 2026 08:54:37 +0530
Message-ID: <20261021032443.44412-1-shubham@octane.security>
X-Mailer: git-send-email 2.54.0
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

This series fixes ordering and lifetime problems in NCI UART registration,
teardown, and nfcmrvl firmware download.

Patch 1 avoids issuing CORE_RESET after unregister has closed admission to
the NCI device.  A normal device-down still performs the reset.

Patches 2 and 3 serialize UART driver selection, protect the transport
registry, detach TTY callbacks first, and drain receive and transmit work
before the transport releases its private state.

Patch 4 publishes the Marvell UART state before NCI registration can expose
the device and rolls that publication back if registration fails.

Patches 5 and 6 serialize firmware-download ownership, copy completion
metadata before releasing it, and drain the Marvell receive and timeout
paths before unregistering the NCI device.

OpenAI Codex, gpt-5.6-sol assisted the source audit that found these
issues.  The UART paths were reproduced with a pty-backed NCI controller
under KASAN.  The firmware paths were exercised with overlapping download
requests and repeated download/teardown cycles.

---

Changes in v6:
- Skip CORE_RESET only while unregistering; retain it for normal
  device-down.
- Detach the line discipline before quiescing generic UART callbacks.
- Serialize concurrent NCIUARTSETDRIVER operations and the driver registry.
- Publish and withdraw Marvell UART state around NCI registration.
- Serialize generic firmware-download ownership and completion state.
- Drain Marvell firmware receive, timeout, and queue state before
  unregister.
- Add the requested discovery details, Fixes tags, and stable Cc tags.

v5: https://lore.kernel.org/netdev/20261013025746.41292-1-shubham@octane.security/
v4: https://lore.kernel.org/netdev/20261006115532.72100-1-shubham@octane.security/

Shubham Antil (6):
  nfc: nci: skip controller reset while unregistering
  nfc: nci: uart: serialize driver selection
  nfc: nci: uart: quiesce callbacks during teardown
  nfc: nfcmrvl: publish UART state before registration
  nfc: serialize firmware download state
  nfc: nfcmrvl: stop firmware work before unregistering

 drivers/nfc/nfcmrvl/fw_dnld.c    | 199 +++++++++++++++++++++++++----------
 drivers/nfc/nfcmrvl/fw_dnld.h    |   8 ++
 drivers/nfc/nfcmrvl/main.c       |  19 ++--
 drivers/nfc/nfcmrvl/nfcmrvl.h    |   2 +
 drivers/nfc/nfcmrvl/uart.c       |  31 ++++--
 drivers/nfc/st-nci/vendor_cmds.c |   8 +-
 include/net/nfc/nci_core.h       |   6 ++
 include/net/nfc/nfc.h            |   3 +-
 net/nfc/core.c                   |  19 +++-
 net/nfc/nci/core.c               |  12 ++-
 net/nfc/nci/uart.c               | 220 ++++++++++++++++++++++++++++++---------
 11 files changed, 398 insertions(+), 129 deletions(-)


base-commit: 1c1e8c24d537ba6133f08f523a2b8c626da4e966
-- 
2.43.0

