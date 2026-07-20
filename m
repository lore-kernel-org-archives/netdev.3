Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17E7439006
	for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 17:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784567746; cv=none; b=FHLwsYpGg8cMzOoaJIvvS2hhyGoVcEAhaFqdcOeU9F8rHi80qpLcoyYtyCm/DLN+Rtvs7Oa2SX9tTodQ1nE5BMZMchdD7y0DXEAD5MN8DCzuSy2enOCzyQANTBuGgeRdLr+fDBXPWiey+2eDGT8EH+MOepH/gFgyPehck37Ze+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784567746; c=relaxed/simple;
	bh=aotS4eEfRpVStcxAhOhiA18MzhLy96mjpdyq44LYXME=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XfkEDEFnJAxb+jmc19A2FkhstV7xItwA9SCNYx+Jj6E0XowErYsdHAcVuBrMl46HHdQZG+h9uUkNxoBMY6vGQ3Q3N3jA9Hn6ocBI6jAgn8ua3JTAM4gmvwn7U6DC5tRT++Agm8qzs0hx9utWFa9a8oSmxwggQ0VUQ9tTGhHXlKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RZrtMeU1; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RZrtMeU1"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4954afac04bso28497725e9.0
        for <netdev@vger.kernel.org>; Mon, 20 Jul 2026 10:15:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784567740; x=1785172540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PMzyY0w2hvyVLQCy4KUYX/zX5WWoesLqRMdPQHdI44g=;
        b=RZrtMeU1tdM/U7oFsgmsO+PsqJucRmiGpz2Fon6khrS+969ciIezNGVpsHbRQA3NBm
         OPlhlxDoTSQkl157N4Tmprn1xJGA3sBEnk6LUAU8zUxgMSZjGlDAVEU2MYUA6TyelEQ0
         EYJCfk/7lfmktevT9GpDXzbnokJpGZgsylnyNJuieF/DXBlWKo2ZVkoTV+k/Sjk1o5Md
         z6zb/Fgqv9W1AUfWA6veeLg4tF3GVqaHMP0d2bqz7bb+Vr/0jrw6ULBgZjdqTHEPK5oi
         0tEtcQOze0p9+k0pRyYqhWT9gOkgNKrBsVTrwD/HRWPs6Whw7rReGQeNXsfy4M2uDiPY
         J0sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784567740; x=1785172540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PMzyY0w2hvyVLQCy4KUYX/zX5WWoesLqRMdPQHdI44g=;
        b=JIrimnl7HRuy1NU5/3GngtCGuojVotPST09y+lRByLnwGSHFdFUzOtc7erN3/mEDJw
         vSBdYziOrBS32PpiJz6vjqeAXZmPQA+1pH8T2X62zizg9rbP9iwgI6a9A5b5mVY+0LZJ
         LzEZ58f3LAn9ReeUZCnw1XaWxIedSmg8Fi1M3YzLmMGBW10IOWi4TGkODLjrePrG8jgM
         i6VKosJ0dUfjwP6R9Ftx/xdHyV1Y0xpMu8ry7fvHzUt71UNbKTl0KH7/aAqGW5jP0EMV
         7yD6xaqYmOa5OkrZzqcTYFt8EYK6x8B+Dpl0SOVjlSODqsUfVPvtXgUEyvB1Ut/hrLRr
         p7dg==
X-Forwarded-Encrypted: i=1; AHgh+RpljoT+ZdRk5DtyugaWMy0lIqVcNiG5GUE8/l5OQKcNKgdpnu1XtUSnOdQtTPtNx7A7II3jbuI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMFwLtYgjNdU5psB0tQHuwH9flDTqcSP/vFQ75Vtg7eCpsp74H
	8tao5aGe3JPRaAhrby/l7Xuyg18QA/cG+gWwW4Ty9InIBvHSN4PRpI1z
X-Gm-Gg: AfdE7cmz/UpMPt9Tq80qQXLWsp2dtfgltIRnKwSlFSl3XPZfcHGVTqbaoplaOs1nUfo
	tlEhRLyC1DZb1B90my0CVcE42u2uSc1g2zIkDbZiyzCq/dfTG0ivSyiBcoXoTbJ7hXETR/We+nr
	N0vaXCKxdywVfHMP8pp7PNW2B4BVUQf5tcYTxX+6PFLcdbDby3jUEZwwlYuOBaZKWeFScquvDEt
	txKg26TKSTY2V5UBJpz/1jsLF2y3HBV8VSs+cSnvVRIe3mK0uhPZow4MvHdecyhc1rQ2MVzsjV4
	h4EQXpIJ4DNKCadlb5Um3M/sB/FNxlcf69rRq14f6EwtnXuYcmPniTTULYJefXMGS7dSXF7TeEq
	O4D9IdnXWQVnPxwYA5d9BvMK0bWBeP2XzK/SAGXPPE+XVd5v2HpMRG/I9knBI/CGEpNBsrQgNFv
	HZV9iyYx3QcKLx5WteIIUsgoN5u+42S62qx3PZ8Hsd1vJpIZEv5Cf3f3yr3t5bcGZL6Q==
X-Received: by 2002:a05:600c:4f13:b0:495:4fd5:570 with SMTP id 5b1f17b1804b1-4954fd506eemr130115115e9.4.1784567739453;
        Mon, 20 Jul 2026 10:15:39 -0700 (PDT)
Received: from localhost.localdomain (host86-153-201-25.range86-153.btcentralplus.com. [86.153.201.25])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956547af7esm2304865e9.8.2026.07.20.10.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 10:15:38 -0700 (PDT)
From: Nnamdi Onyeyiri <nnamdio@gmail.com>
To: nnamdio@gmail.com
Cc: bpf@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	horms@kernel.org,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	kuniyu@google.com,
	ncardwell@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	sashiko-reviews@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/2] bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
Date: Mon, 20 Jul 2026 18:15:33 +0100
Message-ID: <20260720171535.67867-1-nnamdio@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Spurious wakeups in tcp_msg_wait_data() aren't being handled by
tcp_bpf_recvmsg() and tcp_bpf_recvmsg_parser(), leading to unexpected
EAGAIN errors returned by recvfrom()/recv().  Adding handling for the
wakeup and a selftest.

This issue was first discovered in an application that adds sockets to
a sockmap as a way to view the received data.  No redirects or any
other operations are performed.

Sashiko has noted a few other pre-existing issues in the same area
(https://patch.msgid.link/20260714205118.17DB11F000E9@smtp.kernel.org)
that can lead to EAGAIN in tcp_bpf_recvmsg() and
tcp_bpf_recvmsg_parser().  A local run of Sashiko also identified a
potential issue in tcp_bpf_recvmsg() handling zero-data FIN packets when
the MSG_PEEK flag is set.  To prevent this patchset from growing too
large, I intend to submit follow up patches to address these once this
one has been accepted.

Changes in v6:
- Closing the file descriptor in the selftest worker thread.
- Ensuring the selftest loop breaks early for an error in the worker
  thread.
- Added comments to selftest regarding focus on EAGAIN error.
- Updated selftest commit message to imperative mood.
- Link to v5: https://patch.msgid.link/20260717155348.54975-1-nnamdio@gmail.com

Changes in v5:
- Move selftest from net into bpf/prog_tests/sockmap_basic.c
- Link to v4: https://patch.msgid.link/20260715213538.37229-1-nnamdio@gmail.com

Changes in v4:
- Fix potential data loss in tcp_bpf_recvmsg() when a FIN or RST has
  been received.
- Check the return code of pthread_create() in the selftest.
- Fix race caused by using EXPECT macros in a thread in selftest.
- Link to v3: https://patch.msgid.link/20260714203927.32289-1-nnamdio@gmail.com

Changes in v3:
- Added the sockmap_recvfrom selftest.
- Link to v2: https://patch.msgid.link/alFRK66z45eDNZA7@localhost.localdomain

Changes in v2:
- In tcp_bpf_recvmsg, handle signals and the socket closing in the loop.
- Fix spurious wakeups when SO_RCVTIMEO has been set on the socket.
- Link to v1: https://patch.msgid.link/ak_rR-Skd8Mvn4mH@localhost.localdomain

Signed-off-by: Nnamdi Onyeyiri <nnamdio@gmail.com>
---
Nnamdi Onyeyiri (2):
  bpf, sockmap: handle spurious tcp_msg_wait_data() wakeup
  selftests/bpf: add sockmap recvfrom EAGAIN selftest

 net/ipv4/tcp_bpf.c                            |  69 ++++++++--
 .../selftests/bpf/prog_tests/sockmap_basic.c  | 124 ++++++++++++++++++
 2 files changed, 184 insertions(+), 9 deletions(-)

-- 
2.52.0

