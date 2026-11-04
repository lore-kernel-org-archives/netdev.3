Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793773233;
	b=GPPDBcvjWq9N04HpDRaA8k8qSxEkGxSBRxCMwXhUn3SRx9UcvK9egVGdRpGpGoNDZM80
	 L4q0twMw3Q5XjPqkDYxRb/9R7HAGzvBZM+lzxRHAsSw+ua7Ml40Ekeef0jOwGfNcI3DUS
	 cmlrgyQmRKVpdNaqYYNSpr58Z9W2VJ65vXDlIloIAVBQdaU1N/hfiFT0bYWYFVvJ4x7qa
	 /rlnaLl507m3leH42nMkGUlAlheYfm4jWPgQFlIWLgnWtl3Wuc0efScQwGceg5VLRfRLt
	 F1NC5aQ+bhVQCI56QwBYhc2HMFjbReN0CUnhOiDt449pDZKP7J2KrV7F1fgXlRaKrIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793773233;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=j/G9eZEhmGI9eqew3mTdn9uzfzxC/cn4soLSuXEetZU=;
	b=fMhSSrU6RGM5wnRsiSzERlhEsxuXYDndLBzYYVw4EhUXl0VmxxN0PDil+mKhHkgcp+Wl
	 gRtfKKvVvaogqlCmfm6S56lyyjke0WHwUfqGhOwoD/Zt3fKmbeqmjHIipRpBzgSq3+NyW
	 kB2s8G+O4J3STEFSU/vCxiGRvctWPZTuvjJjklsR/AHt19OS0FeMmfmbxVByNBnOdO22W
	 qYubo2BblzZF5hD0mSLN2mGii0ja84S1/kO6keXN7rPTuGNOROLwCYMNC5wIfhczACmjk
	 gmjlcniTXi8P1sEbycVT1mWHv+bzr3W7IbPQlcP9ZpWxoF1YaOgztHO92CifJpRNDmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=octane.security;
	spf=pass smtp.mailfrom=octane.security;
	dkim=pass header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=QswTzzZ+;
	arc=none smtp.remote-ip=74.125.82.52
Received: from mail-dl1-f52.google.com (mail-dl1-f52.google.com [74.125.82.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB22A606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 06:20:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB22A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=octane.security
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=octane.security
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=octane.security header.i=@octane.security header.a=rsa-sha256 header.s=google header.b=QswTzzZ+
Received: by mail-dl1-f52.google.com with SMTP id a92af1059eb24-15dd124bbe7so791891c88.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 22:20:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=octane.security; s=google; t=1793773232; x=1794378032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=j/G9eZEhmGI9eqew3mTdn9uzfzxC/cn4soLSuXEetZU=;
        b=QswTzzZ+fVXFIcSekN/kaZQrtHzfWqwO6BQEEio0UDlc6NGx5x+hi842b/FkKHAax4
         5MULu+2iSJec6rQ6V2Bx2+4b9U6wdzfS4IdELB/9LDhwrLA+EyE/Lr0PgSlKRAg7ED+U
         IMIztlJMKUPl0uVpsSl78F+98AI1lyJurNNVBD+6tzJtwl5QfgknnH5KpnF6JyJo92KT
         IS/4cQSMxJHPqmPfKOqnlEtvRYYIc0lNHFAswQ21yBuEEcYMJuJag3zGFwccMkz8d/gk
         q4aLjZjIdOlwG5zjA/QJ+9/LIWtFdDlO9WV6WQWnEMFCw6btIscCC7Donpc+jPFmgzpt
         Yrrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793773232; x=1794378032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j/G9eZEhmGI9eqew3mTdn9uzfzxC/cn4soLSuXEetZU=;
        b=hvZta0kmOgcTvlot0NIROx6YTres2BRyX9rz0z2J8eUtQdy/iBRwWDYMdjRh8bvA9U
         xFG4Bg8HN1seAhLTIYfM0eLKtrG7k4CKpKY9ZcxReSl4IG67VhwPHYTlqkf7wFUeL/UB
         oO+q84XV2r/tp90kxxzK3hn10QvHe1Vp8y04SHbtccPiyV2et13t/Ali9y/te2uTsgEA
         h34jB/253lOlBVHVjklyp6DruD2U/c/6kZBPf8GtsQn+FtdFb4pTvND9tscr9j8446+1
         TP3p8Ju3BoO2k7NpbuXBLTm9tmaOuehUqWNTvTdkNZx98h2qnR6b3fCIPZ9m6UPZ61GD
         1xEw==
X-Gm-Message-State: APuU4Z9UhGghKINhiaSxrpTWPOonr10MxXStDO3ZMCvWq/cB85COQI2a
	WmK8PdDzZ69dIgSfg0UeOpm+jIV2umR2y1iNvDp3lWIcUcMw5c7G+mMWTN7/eSjTsj2a2rNC+sj
	k2iyo
X-Gm-Gg: AYBFou3uOxJBr1O8YxRCMYIfB+AghWi6rDtlfrbFKZb7pAltvLbS6UrXfPeuhjf4KrV
	6wfB+C3vj97Og7kk5li1dMYKOt3BMBPDmihwfB3qvFwgbo29QszyDMVo5HOsikoPl0Pz1JbkVrg
	fAZFlRxhi6hmXXwyw3y9XCDcpcaicKzziBHZIx2Kha5RHcX3GrIpqQf2TyBeb7Il9BR8Wf0hqsa
	esxRu/PJfq37wZ86D9BumSEZygyQX6WUcfRCMq90PmPkxw4dpet0IydvhFm4hDIVJkLjUWCDGOV
	lonpRaqKI/WZconvNofSF0zD7n0GEF7RwRvejch9lbORPq0fphMLmS88Pt6jcexJp71xxhGZQ/u
	P56mPTs15LEJevndAiBT6+2/Nlc3fj5mbvEk9FCt5zJGZGWM7KIszI/QAGSfGlGP2zBhJmcJQui
	Qvu+WcVbrYaI7drl0r7sE35sFpK1y7VaPWPdyy50PhP2J5Ofd70dXOF2we5jfai+VpHfOTTDnm2
	nOvRWmZHl2Djw9FrOFn58nOmSjXesQD4L3sFeIP8LwaHlGT3FK111gob5wl4daNohWr+/8colux
	2IR2LdvQAiunzHWgUbkOGRjKGWWcuhCIH6m0seOy3WqlS6fiq4BhwoCPNmiR5zX1lzHnqIonEhA
	7qjxs69tna5bA+utDkL3p1jxS/dmCjGiqwRtJR3cdq/VyLBd6uQ==
X-Received: by 2002:a05:7022:281:20b0:1ac:91b6:8dfd with SMTP id a92af1059eb24-1ade9e3e335mr21918851c88.31.1793773231590;
        Tue, 03 Nov 2026 22:20:31 -0800 (PST)
Received: from localhost.localdomain ([103.196.55.178])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c69c3fsm4486279c88.20.2026.11.03.22.20.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 03 Nov 2026 22:20:31 -0800 (PST)
From: Shubham Antil <shubham@octane.security>
To: netdev@vger.kernel.org
Cc: oe-linux-nfc@lists.linux.dev,
	david@ixit.cz,
	horms@kernel.org,
	gio@octane.security
Subject: [PATCH net v7 0/3] nfc: order NCI UART and firmware teardown
Date: Wed,  4 Nov 2026 11:50:23 +0530
Message-ID: <20261104062026.80599-1-shubham@octane.security>
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

Make NCI UART driver selection, callback shutdown, and Marvell firmware
download completion explicit and ordered.

Patch 1 serializes NCIUARTSETDRIVER and protects the driver registry while
a transport takes its module reference.  Patch 2 closes UART callback
admission before private state is released, publishes the Marvell transport
state before registration, and preserves the unregister-time CORE_RESET
before quiescing and halting the controller.  Patch 3 drains the Marvell
firmware timer/work/command dependencies before NCI workqueues are
destroyed and prevents a new download from replacing state which is still
active or completing.

The firmware overlap guard is local to nfcmrvl.  It does not change the
completion rules of other NFC drivers.

Source auditing, patch development, review triage, and test planning were
assisted by OpenAI Codex, gpt-5.6-sol.  I reviewed and tested the resulting
changes and take responsibility for them under my Signed-off-by.

The series was tested from the stated net tree base with:

  - strict checkpatch and git diff checks for every patch;
  - targeted W=1 builds and sparse checks;
  - a W=1 allmodconfig build;
  - an allyesconfig W=1 compile through vmlinux.o; the final global
    objtool pass could not be completed on the 8 GiB test host because its
    working set required heavy disk-backed paging, while the affected NFC
    objects compiled without warnings;
  - a full x86_64 bzImage and module build;
  - KASAN, UBSAN, lockdep, and DEBUG_LIST enabled while exercising a
    pty-backed user-space controller through reset-preserving lifecycle,
    concurrent driver selection, registration/publication, overlapping
    firmware requests, and firmware teardown cycles;
  - a separate strict-mode KCSAN run over the same lifecycle and race
    surfaces.

No in-tree selftest covers these NCI UART and nfcmrvl firmware paths.  No
physical Marvell controller was available for testing.

---
Changes in v7:

  - drop the generic NCI unregister/reset and firmware-serialization changes
    and keep both fixes local to the affected transport;
  - retain the close-time CORE_RESET and halt the controller only after
    unregistering;
  - fold Marvell state publication into the UART teardown change so each
    patch remains usable on its own;
  - restart a queued frame when the transport publishes READY and balance
    tx_start() with tx_done() when teardown catches an active burst;
  - replace generic firmware serialization with an nfcmrvl-local
    active/completing gate;
  - drain both directions of the NCI command timer/work dependency and purge
    commands which can no longer run;
  - hold firmware frames until the reset pulse finishes, queue timeout
    completion on the firmware workqueue, and preserve positive errno
    reporting;
  - drop the stable Cc because each patch exceeds the current stable-tree
    size limit and would require separate stable handling after review;
  - document the discovery, validation, test environment, tool assistance,
    and selftest and hardware coverage required by current netdev rules.

v6: https://lore.kernel.org/netdev/20261021032443.44412-1-shubham@octane.security/

Shubham Antil (3):
  nfc: nci: uart: serialize driver selection
  nfc: nci: uart: quiesce callbacks during teardown
  nfc: nfcmrvl: stop firmware work before unregistering

 drivers/nfc/nfcmrvl/fw_dnld.c | 243 +++++++++++++++++++++++++---------
 drivers/nfc/nfcmrvl/fw_dnld.h |  11 ++
 drivers/nfc/nfcmrvl/main.c    |  18 ++-
 drivers/nfc/nfcmrvl/nfcmrvl.h |   2 +
 drivers/nfc/nfcmrvl/uart.c    |  28 +++-
 include/net/nfc/nci_core.h    |   6 +
 net/nfc/nci/uart.c            | 235 +++++++++++++++++++++++++-------
 7 files changed, 419 insertions(+), 124 deletions(-)


base-commit: 21f57ec673a1917547c808cfa81890485fffa03b
-- 
2.54.0

