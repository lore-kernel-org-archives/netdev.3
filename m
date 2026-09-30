Received: from mail-dy2-f43.google.com (mail-dy2-f43.google.com [74.125.229.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53AAE298CAF
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 05:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790744601; cv=none; b=gtEvqtcqwbPZvZ4qELIpOqLuSfbJXy6G9zqlERwKS6JLizeQJmk4pV+GWkG3sNyvVRKhAO66eK35ftjtO9IjY4Ca6uXaVTTMDn9A+HfKU7KXwJBrMk2WEgS+FseDL8iF3lGevqiNYvn9g/kpCUXM1cUZNihQ+yeFViTVA9uTPag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790744601; c=relaxed/simple;
	bh=OMwLDiOjOB1/H5Qk3yiRuT93np3VlMrQ39SNlvAqQeA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dvlny5+hUgQDBMiCFaPaykO+dYhk6qlDgp7RUp5Y0aj7izxB/qlkRUWB1uTrFFawL+NuTM4eS/WE/DwfJyG+AJQCP6Sqe2eVI6PNJq0nc+WFm3phOsPZPruRyATzpSRiqRlvmQkfI0GiJzFesZrfcFBaVSRnR2jAA2+wzjnwYYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TCpLfXte; arc=none smtp.client-ip=74.125.229.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TCpLfXte"
Received: by mail-dy2-f43.google.com with SMTP id 5a478bee46e88-33e46a15703so4709520eec.0
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 22:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790744599; x=1791349399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XAeiNx8SHTxJ8mZniOpzlgJX9x6mLwpi/G4jTr7vIVg=;
        b=TCpLfXtesUADRzKkuDktG83CaMdD43Ay+f9y15/0MLEONsePcyyUkPyQNeJiLSU8xM
         M83JlBecWgN3tycUrH49vSm6KYdp8Y8UsX+s/VjePapvrj9x5gHjwkZ8CkVQoshk7YAz
         c6VmKJ2OcpNOOIhOnjA4fbhTyNyKKrGizyrqowRJW0GzPHSHn9CvR/zNPvPYu6msFnhz
         VKsYYRcvdGoK1BgYU/VoY4pHE06FY2W3M5gqr4K3aIVkeKryh2XrIKRc8AJuArFhwxAk
         aIEeSfyQWwQ0glVa4wLfrJFK5jxfz2RqhzLEGCFEjrXtDdV/hn8MMBnA1xr+0TluqVne
         1Ixw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790744599; x=1791349399;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XAeiNx8SHTxJ8mZniOpzlgJX9x6mLwpi/G4jTr7vIVg=;
        b=IJxBG0dna0idHjikL+1JrfBoE8uTK0eg3/qX4xr/q1lXWkkgtt7jkf9XPclHXFc4Ac
         QnYeurQrTRFAx3BabxDBY0xL9B3BEsXf2zZI4CqNA0pcHzCItMNSRFDocf2s/5z+/wHa
         wjhOC5uiBwOuA7AOV4XIeuj9tbUD3sGQ0XLF+FJKXkoXckcA/b+IL/Bo46vxZx7wO+sU
         7VX7m+Avb2XA84F0OKYiFTADHXYo6IyFXDzW5EYyuG/jkV7gyCWONqDi8pVqkknoJcgW
         FUTluZmd4wgfvFJFpKlUGgOhRIDw6rYf+2HU/xipnCBB2Jd+7X8Hn3ygupIUoPm2fyN8
         XD5g==
X-Gm-Message-State: AFuF++k5KpMEbfbONT6mMeLxW95Q4bC8/3ql2hhcE896AOvH4Z1mIkBg
	cXMau7gZM+DmVNYn/O9MyLyJCYVvitKaw+EZceKZM6Zz0Crsh1GpQnU5ECRGsTsV
X-Gm-Gg: AYBFou05JEAd8n75fZyYGnI/Borsc60Ry3ICXwgmAMVIQyz2SqW1UPeiqSZejwqVa5/
	31LV/AIgY5AKEV4J7la+iNALDV5BVjRWUTTAbrCP8ydzH3fFrcRjHRHQnds8rbWsYbpkIG/91HR
	AmzkdeY47w/Z1T4WJMOKTxO9F8PrP6niaiITlYj8Pe/QwFzG8Fb5skCJsXGsNuvQZVW9bLj8uhO
	f1VHb93F2X5QLIVRrVCV4wX7I5MA4RYIj/dJBOJ9F5DAoLCworGWu9S6eZAXgrw5RzSYx/1cCK2
	fYpZYT64KSW99DyWVMUoXklwaac/CRSQ0gEwOs8CI7GKi4g/EutQORd6IzLubiu5KbiTq/73o5d
	MR7dGwiTS4OpxdgfpMxjeAs608oJAkuxzvfm9rui4lmPTpnMtbef5UWi/zGjhxJwRJXvoukpo3E
	CPRiAgL78x4gwb7tQDuNuusQacYDDJ9kJabhN3Y1YnnOW5CMZGLXNnuKlHTd00
X-Received: by 2002:a05:7301:540e:b0:34b:34cc:bcf9 with SMTP id 5a478bee46e88-34cd90763ddmr495416eec.3.1790744598988;
        Tue, 29 Sep 2026 22:03:18 -0700 (PDT)
Received: from fox.. ([43.242.224.196])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-34cf4a63ac9sm772160eec.10.2026.09.29.22.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 22:03:18 -0700 (PDT)
From: Roshan Kumar <roshaen09@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	chopps@labn.net,
	linux-kernel@vger.kernel.org,
	lilly@aronleigh.au,
	shubham@octane.security,
	gio@octane.security,
	robert@octane.security,
	paolo@octane.security,
	Roshan Kumar <roshaen09@gmail.com>
Subject: [PATCH net v3 0/2] xfrm: iptfs: fix queued receive state lifetime
Date: Wed, 30 Sep 2026 10:33:05 +0530
Message-ID: <20260930050307.1978654-1-roshaen09@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IP-TFS can retain received skbs in its reorder window and reassembly state.
Two lifetime problems interact in these paths: the shared drop timer
does not track the two states independently, and retained skbs do not
keep their input net_device alive.

Patch 1 gives reassembly and reorder state separate deadlines and
always arms their shared timer for the earliest one. Patch 2 holds a
device reference for every retained skb until ordered processing or
destruction is complete.

The unpatched base reproduces the device use-after-free under KASAN.
The final series passes the reorder, reassembly, SA deletion/expiry,
clean teardown, and unprivileged user-namespace regression cases,
including a timer-overlap test for stale deadlines.

Testing on x86-64 at the base commit plus this series:
- KASAN + NET_DEV_REFCNT_TRACKER: the 10-case lifecycle matrix passed on
  both the regular and lockdep/RCU-debug kernels;
- stale-deadline overlap regression: 5.155 second close delay (minimum 4s);
- runt-created reassembly regression: 5.152 second close delay
  (minimum 4s);
- PREEMPT=full, lockdep, RCU, atomic-sleep, debug-object, and ref-tracker
  scans were clean;
- GCC 13.3 and Clang 18.1 W=1 object builds passed;
- x86-32 and arm64 cross-compiled W=1 object builds passed;
- allnoconfig W=1 full build passed;
- allmodconfig and allyesconfig W=1 xfrm_iptfs.o builds passed. The
  full builds stop on the same unrelated lockdep_proc.c and callthunks.c
  GCC diagnostics reproduced on the unpatched base.

Changes in v3:
- split the shared-timer correction into a prerequisite patch;
- keep the reassembly reference through xfrm_input();
- track reassembly and reorder deadlines independently and arm runt-created
  reassembly;
- cover all reorder, completion, abort, timeout, and destruction paths;
- use netdev_hold()/netdev_put() and document reference ownership;
- remove the incorrect bounded-lifetime claim and self Reported-by trailer;
- add the required AI-assistance disclosure.

Changes in v2:
- add reassembly queue coverage and state-destruction cleanup;
- add the Fixes tag and independent reporting team credit.

Roshan Kumar (2):
  xfrm: iptfs: track independent drop deadlines
  xfrm: iptfs: hold a device reference while packets are queued

 net/xfrm/xfrm_iptfs.c | 151 ++++++++++++++++++++++++++++++------------
 1 file changed, 108 insertions(+), 43 deletions(-)


base-commit: a7bfaba4823e3c165bb2004c74eff7c096672bc7
-- 
2.43.0
