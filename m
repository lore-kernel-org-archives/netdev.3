Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD853E3C73
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 22:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788388314; cv=none; b=FT9i++HplbvWMPSnFrOyJ33+b3oBeTrneamYgZ0tZbMnK6/U0rfg5RgJ5ToWG3AJM6HDu9JVrOywLf19rVnmihLMEHsRP8HlHJvaYbXf6ZnA8IiyEHAIYk1CkeuApOHzStI1Ar0kNG6QrJnOxt67aeKXc/0U0QEgmCvhiKtaMnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788388314; c=relaxed/simple;
	bh=EN1X/HQxHeUB2VtEE8JVzNEaKRKcFTQV+skvIoIM0Lo=;
	h=Subject:From:To:Cc:Date:Message-ID:MIME-Version:Content-Type; b=mx3mdK7PxO9UwlgOHzLpydZ/TR0nEZIvycuX5SrWicf4FMJIF+fUPGpF56opVEoHifQUAY3y3Hy/VrDXXyLmNcf+See6bCLOexlipGcajdi8677t3r8lSWxBP1sZbwspIqsofPtx9uKSA0VFoFNk04PCvT62miV5xSvAqg/WLBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+y1xtGh; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+y1xtGh"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2cc891373e0so17277175ad.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 15:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788388306; x=1788993106; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aket0LMCVWjkrlBFOSFWX0qoHybyThTgJgA8OF2qfk8=;
        b=a+y1xtGhngTsAserWOTNhTikgM2xB4z/iK6GRAXaZFbg7bNKJiVNQctHrH9ZHpozRE
         qG+bCYdT5/k4H6nTwAvOgIfgb137CJ37uq6XnIsVkWHD39OIzk/3pq3sY81If8Y3ACCJ
         vWCFVt5gC4i8XP8V/GuTxow0nORfxyvM4orEbAAS4ak6ydSgqxw4CFJUDmiqooZuwKIo
         iqc9argIDpoxdPM9Akpv7BP281GfShYItNhzvmddDh+b37KgqmxP2cY7hS4lI4Fd9HOm
         O8MRK0xaSKBOWAMsnLdrdRflKtG4vnHwnwzeZZ7q/aCjj/Q2Gf7pdi/V2H6qx8lnsEpF
         Rxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788388306; x=1788993106;
        h=content-transfer-encoding:content-type:mime-version:user-agent
         :message-id:date:cc:to:from:subject:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aket0LMCVWjkrlBFOSFWX0qoHybyThTgJgA8OF2qfk8=;
        b=rOv64aEfai8pGilNQd020t4deIiHVDXdB5I8rWxjV1afidTuwefK1JNOOe+QJTP/ei
         IF69Qz3yM+vF3GO3vSuAcsbRQfMLw5iex/ahE6PU563EUn1xsWLHtVoERfTtCcOZSkC0
         1Cq0E5XqYXzWtHrsk9vDw+c+8vKDKWklSi8sgi80hDpOT6qc/ZLcIlBBKl0ijBY4c34F
         tctEUv5/tN5sOHd+GIoahABjlFzCE01ats8/FaLXUbwSuj+CnChG0sOpe8Xg5/dxnk3a
         6nVPucF7hEGZadaskaatZOCCNkbLjmamkSDJ1CTK7bfA/tk9i6VWlZ9MHfsHba9OePhy
         nRSA==
X-Gm-Message-State: AFuF++lVX05YOQ2hLbyObccEwHNoI8BRnn7gBnCYLb+i/c5DhF+wfJQ1
	+MLFY3YFocrDtNhsuTppM9aa4GQ2PkjtngPR/+lEPwZ88Cp2NAPNmAgF94ZirA==
X-Gm-Gg: AYBFou3JPfMAF04knxQx8PxowZPWZQWiQVyTgBMhn1xDI5bI0Bf6r7YATI+M0pfHJfI
	OhdiEoPVNDb9XkcqxaStELCXMkfVQgZwq4hRxmqEGra9Wmql3h0VX8cv1Me5Bzt0aumzQzmP4OF
	QnLMjJlVnbqgaRiv9woL4bcsdMpKJ1An43pq380AVkQjlkAKDQ3FloPbK0szh2G9r1jrQfUwyrZ
	HCC8gDr9bmj62/9U7r7NO3Ph0XHcEZ8aUfmXAqBIuuo6fhQGGBMEEVa0dbjbKEKLXQENFHkstNT
	45qO6mRw4E7zjzPzqtNqsj2DPPuPeeOMKPp1+ZDo7Sy6Qnaqkgyd/4Z2DHSIzXU30dsrE/EsVBv
	NLeLeb71Ao2v32EyHSXs7AB3ei6gv2rfd2qkkxoVVY/Icm5iLQRbLUxNtuUf6jaxOONJ3CwYQDL
	g4drBrcn8J4Vnk74Kwp6R7ZPrOBolmvJb1H6NPK83clSaicwr/xTWhomdVsWt5UvHLCrsyGmLQy
	vH6aVVnXN8PEXCrroikJwdJy8dkbfVVMKVWOO2jMao0gBuozo6uH3a85asXXOGRXD2YfPVp4SCt
	ty542gEX
X-Received: by 2002:a17:90a:dfcd:b0:398:ba0e:96f6 with SMTP id 98e67ed59e1d1-39aee1ad8edmr12800905a91.23.1788388305494;
        Wed, 02 Sep 2026 15:31:45 -0700 (PDT)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:4db7:e37c:a6be:f5bf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08766a2dsm1413091a91.15.2026.09.02.15.31.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 15:31:42 -0700 (PDT)
Subject: [net PATCH 0/4] eth: fbnic: a collection of fixes
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 kernel-team@meta.com, Simon Horman <horms@kernel.org>
Date: Wed, 02 Sep 2026 15:31:41 -0700
Message-ID: 
 <178838795612.11136.15512516427273655916.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

This series collects a handful of independent fbnic fixes for issues on
released kernels, plus one core ethtool fix needed by the fbnic offline
self test.

The first patch fixes a NULL pointer dereference on unbind after a failed
PCIe error recovery: fbnic_pm_suspend() frees the napi vectors via a
direct ndo_stop() while leaving netif_running() true, and when slot_reset
-> resume fails the data path is never re-allocated. To prevent the panic
we reset num_napi to 0 before we free the IRQs which prevents walking the
unallocated napi vectors when we unbind the interface later.

The next two patches address the FW mailbox. One sets AW_FLUSH_MODE
alongside AW_FLUSH when tearing down the Rx ring, so the write pipeline
actually drains the staged requests instead of hanging on the BME halt.
The other handles completions flagged with FW_ERR on both mailboxes,
which the driver previously ignored. This resulted in us parsing a stale Rx
page, and spinning the capabilities poll to a timeout on a healthy ring.

The last patch keeps rtnl_lock held on the ethtool ioctl path for the
self test. Since the ioctl path became rtnl-optional for ops-locked
drivers, fbnic's offline self test (which brings the interface down and
up via netif_close()/netif_open()) runs holding only the instance lock,
tripping a lockdep splat / ASSERT_RTNL and reconfiguring the device
without the lock it requires. An opt-in flag restores rtnl_lock for
drivers that need it.

---

Alexander Duyck (4):
      fbnic: reset num_napi when the IRQ vectors are freed
      fbnic: Set AW_FLUSH_MODE alongside AW_FLUSH when flushing the mailbox
      fbnic: Handle FW mailbox completions flagged with an error
      net: ethtool: keep rtnl_lock for the ioctl self test


 drivers/net/ethernet/meta/fbnic/fbnic_csr.h   |  5 +++
 .../net/ethernet/meta/fbnic/fbnic_debugfs.c   |  4 +--
 .../net/ethernet/meta/fbnic/fbnic_ethtool.c   |  3 +-
 drivers/net/ethernet/meta/fbnic/fbnic_fw.c    | 35 +++++++++++++++++--
 drivers/net/ethernet/meta/fbnic/fbnic_fw.h    |  1 +
 drivers/net/ethernet/meta/fbnic/fbnic_pci.c   | 18 +++++++---
 include/linux/ethtool.h                       |  2 ++
 net/ethtool/common.h                          |  2 ++
 8 files changed, 61 insertions(+), 9 deletions(-)

--

