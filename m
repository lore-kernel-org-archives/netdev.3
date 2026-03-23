Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA3D2571C7
	for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 23:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774309714; cv=none; b=KXawoyoBLT2OYVQJB1DmDGmurqX3mdyTxLmXLlyddIIL+FQufd+2YGIJfICC7SMGMeqYGV2NqLFzQei2WbIM0GamRbGCQlcoQKP6UAj0NgRCHJ+oRgzTQNIUZsMS7OgoNJzywS4KCiS6Kh2OmS/ArSyPBL9L4gA6W+cBONUvnGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774309714; c=relaxed/simple;
	bh=WYchRTWNriN4A8uw7+J4DWGe/iMkrx09ZRefCEFiaPU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fcaf+fI5ud3bMhUO17jFall2ycxhjMTnIARMLblqx9B9NS2zIuwRxncUzoTzOJYsMsFoe64N83DLDasuKcDF77GhqSJRCH0fnj45CkjBKetipooZcFY22L7tXzZJSrmFGY/LYoWA0KDb17qN0i92QekyzR8rFu1HVtlS934p9Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lrEqfeq0; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--hramamurthy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lrEqfeq0"
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c741c4cebf3so329971a12.2
        for <netdev@vger.kernel.org>; Mon, 23 Mar 2026 16:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1774309713; x=1774914513; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=h65q+VaAvWrjnPJh7+6Dviqd62Poaj7FWOIQSbrAeMc=;
        b=lrEqfeq0aBNdyOLiNf9r7778zYEmbhDrrYOT3dTFzpYU7LYk+xbvergWOznsEHnDgY
         eOk6qU/7CWqqpKqCHDGEp9v62LGjdspte7OQz7859TXdL+ozcLmowbYhay9bSNRBjEup
         IwgXWIhqQG4nOF1NQYFsorxzno0lw7fFByDQItpmak3xbLWnPl3zR+AFjQKbSOceoDna
         Wljfk6mMpR27gwk4AwqvBQiNJPupjTIzWAZMeXltpBL99IMUTZMZvfY/CP+uGp3F227r
         9+ZD54mjWQwvCGzie4xGTQUfd3UfaA3/2TlE6Ql8tUT3zM+++HVLtKq1A9AAHeYotm7P
         JBNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774309713; x=1774914513;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h65q+VaAvWrjnPJh7+6Dviqd62Poaj7FWOIQSbrAeMc=;
        b=UVcCGg0ybZAS39w2ox6R4o46+a1P8wFtWQrCfItV8US9cOe2un+XxmtyN6zw/FJpCL
         2jCIHAyNaZKUvNpFdTcaWjoAJ2ifBhPNyqEBtKJ6E+l8e/IxNYSzQTqzQKthd8uh2bGt
         F6P1t4lRX450PNnrS66IxTkvD7wsNcqBNfGiZVEBiLa3eN6LMvUwYYRtf1Dnlj6NghTJ
         GJClC2bzcGOX0HrbqnxbXzDTOAH3TjBqJ9dgv34gtM4+quTbgHJ2btYizsqegiEcYA1+
         4E6EQubQL/FnvHciQ+o33EO9c7sEhCjTkgt8zAMEWjFlWmWnIaPvrwLbDxHjgdAFzSSb
         ga+Q==
X-Gm-Message-State: AOJu0YwYOtXO5/NqvrNDVYrmo86X9VX8z9mJ+GPTOD0Z1+75F76Na2cT
	X0W9vw7Vga9WM2kxd74rIl3ShJGmFlqUY3WXnKDttkB2bBr0YXtVRp8o4R1WJQAEMrMFr4YaOQk
	0Kqr5Q98W/3yCL3UsjUO+ae5trpZFPrGeTj95ItsepSNsEPW6AlgC/dnVYayDatTR8+ID5KwmWr
	tpjZJM6kxqc6IPpi3qcicAAXln6j1gyUxVa+/cVbAoT7rvHUSNmdhfDX+8BE+IKfA=
X-Received: from pga23.prod.google.com ([2002:a05:6a02:4f97:b0:c73:9ca1:e556])
 (user=hramamurthy job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:1593:b0:398:8870:b531 with SMTP id adf61e73a8af0-39bcea6e897mr12634620637.14.1774309712698;
 Mon, 23 Mar 2026 16:48:32 -0700 (PDT)
Date: Mon, 23 Mar 2026 23:48:26 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.983.g0bb29b3bc5-goog
Message-ID: <20260323234829.3185051-1-hramamurthy@google.com>
Subject: [PATCH net-next 0/3] gve: add support for PTP gettimex64
From: Harshitha Ramamurthy <hramamurthy@google.com>
To: netdev@vger.kernel.org
Cc: joshwash@google.com, hramamurthy@google.com, andrew+netdev@lunn.ch, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	richardcochran@gmail.com, willemb@google.com, nktgrg@google.com, 
	jfraker@google.com, ziweixiao@google.com, maolson@google.com, 
	thostet@google.com, jordanrhee@google.com, jefrogers@google.com, 
	alok.a.tiwari@oracle.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

From: Jordan Rhee <jordanrhee@google.com>

This patch series adds support to obtain near-simultaneous NIC and
system timestamps with gettimex64. This enables daemons like
chrony and phc2sys to synchronize the system clock to the NIC clock.

GVE does not have direct register access to the NIC hardware clock, so
it must issue an AdminQ command to read the NIC clock. Due to relatively
high latency of AQ commands (~100us), it is necessary for the hypervisor
to sample the system time sandwich inside the AQ command.

The first two patches pave the way for the PTP implementation by
quieting excessive logging and refactoring an existing routine for
thread safety.

When tested inside a GCE C3 VM, this enabled chrony to synchronize the
NIC clock and system clock with sub-microsecond precision.

chronyc tracking
Reference ID    : 50484330 (PHC0)
Stratum         : 1
Ref time (UTC)  : Sat Feb 14 01:53:42 2026
System time     : 0.000000001 seconds fast of NTP time
Last offset     : -0.000000000 seconds
RMS offset      : 0.000000001 seconds
Frequency       : 0.686 ppm fast
Residual freq   : -0.000 ppm
Skew            : 0.001 ppm
Root delay      : 0.000000001 seconds
Root dispersion : 0.000000812 seconds
Update interval : 0.5 seconds
Leap status     : Normal

Ankit Garg (1):
  gve: make nic clock reads thread safe

Jordan Rhee (2):
  gve: skip error logging for retryable AdminQ commands
  gve: implement PTP gettimex64

 drivers/net/ethernet/google/gve/gve.h        |   6 +-
 drivers/net/ethernet/google/gve/gve_adminq.c |  26 ++-
 drivers/net/ethernet/google/gve/gve_adminq.h |   4 +-
 drivers/net/ethernet/google/gve/gve_ptp.c    | 209 +++++++++++++++++--
 4 files changed, 220 insertions(+), 25 deletions(-)


base-commit: 5446b8691eb8278f10deca92048fad84ffd1e4d5
-- 
2.53.0.851.ga537e3e6e9-goog

