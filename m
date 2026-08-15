Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DC0331E848
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 01:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786756113; cv=none; b=u7A+av4iE7Kzf1d6GIT9bOdjqinvJXGoRuGWwptfH1Fv+TkDuh9h2x1pyy0yvQSpkbrfzi7Dim+ogdl2ZjApXGjmkYiXYjAlXTbggyZk0qk+CnKAq7R+2sLfuB1K6+tAQriBeUv7mt3LjCtoXZuqAgdhNADwdkvueaFtjbTCyNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786756113; c=relaxed/simple;
	bh=2kTLjAyAaBeF3tIJ3J75poWZGpgQ8cUkBPsm7La4pXI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KFgiatXOKxfr76Yo8nSFff6oZFTpZemXUyC0En4eku3Qp2FwLbVyZ8k+fIoi06Wn4gl8nNRSZYlcd4I3avGUXblTaJxVvrv+cCRmw3YiQf3WSz0kMNLLH1/qpgxQBy1sWkXyn2r7pSzICKbMNr9RjE+mJb8XDJV1Dlv9Z1CsFA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UYmPfMck; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UYmPfMck"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7e9ecb1e13cso1640835a34.3
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 18:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786756111; x=1787360911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BUYEVZhB6IjzU8iIkm7Fy+3Re1KgS2KX1bdxTPKKy6E=;
        b=UYmPfMcksN4rTEyb8RHp5zp3Aa7PoL6VKbQv8RLSG4i2Ij/lM5JcJ7hed4Ldgq6yEN
         dgw4swbtimYe3BXTb7z50bSrIy1HytyR8SsDPUuuIMDeS+gjixQlXyt1RYphotNYghen
         ZesOtHMIJnhmdROHsWQPjkTgxappc52goVB08p83P7cskzQ7BvwjhLaiCWEUX0pQp3ah
         d1lINL4PUhJAle2driELYKmLJflhAQQmPn0SQrb2EpOLqM0vNcS5x801uXq1yht+Wn9a
         njAH8Ua+msDIxfW9LJ5x91W6Nxx2POca1LgHQXVEysqN5fMppL7G4oqpK1pd1UCMCqTx
         mlpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786756111; x=1787360911;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BUYEVZhB6IjzU8iIkm7Fy+3Re1KgS2KX1bdxTPKKy6E=;
        b=HWIBZfea8PWAhoq3ZG9BfWMSzCDZsl78x0NIxRqv1ic2UPi9x2X/0z41/Cjva0s3Io
         t5o94aHhLMWHcynKH7If9vHjmAkknCx7UbEiKG0i8joNgUmZc2f8vwbgN8XPtVguB38X
         SKPfYGjuoaANkDTCGF3u0yoMsIhWB1NKoxeq2ZK1lDX2YpCX5v0jUqaUOV21AiPWYQBs
         p82bB0H+Fg1n+lIAMWpZeAT+y8DUC95ymEqrZjsgeBUtj/0pNjTRe6Iabe5//kYDcQwC
         7AfIkluu0NDbLQHCYhY5BMJVLCEfx3EXL+3gRfwaG8LWVZ6y51tD0EPNstoilMG4DaT+
         nLCQ==
X-Gm-Message-State: AOJu0Yz9U1KjnGw9yT44rvU2PqTeFlbreJywxiIjA7y0UYWDS8G+OmZH
	Kr4+tIB7t5WB3bEf588CgFZYH2ZiPJNcy611Vbm0Gdv6KCLQCDmLpGoP
X-Gm-Gg: AR+sD117p1KvsnlBO7HJHlsfX6Fhvvwacx5R73EghNshlAAdns6PEVwdi7Fe81Y7kwv
	KDzlAsB3I7i0kLMZNz8xfnnm46SCF3sRFLNfv+UiJn3ThuYhn0r1MC1kkKFLVAQcQafsObmdB8t
	OxkoE4mlqK6WvFlmeYf77ZLZV+4nyuI8ifE8Cr02H160tq+/TiZF8dTzqtD07vXYeI8I+0H8Fb9
	XD2HqTIf2MwZXT0IchhnSTE3/L0AfoReg1ymL/ApbdSV2wJklnjcrC2g9FO36nfU77EGg/1KEDb
	K4cBkpMoapB8RRyRIfpeZRJiYdgz5jbz0NeIixbiKhTySaeoySWKChkZjdZuqlEBM/5LyCJUO1L
	8GpQpt2idbPS8Wuh+VTu6lKNwiyGc31S13S7HWd1hatJ21uzNdJuVQMeM9mzDYsODrR2xt/9JA8
	6gnx/lNa88Vb9yOpARBbDsJwZYykJ8FQ93vXB1vdmRm7V71A1ynQlWg63VWj9K8HjCsWQPEDc8a
	P/MZrFwSeZVHfErN0carcn1C+JBvMY=
X-Received: by 2002:a05:6830:441e:b0:7e9:dd7f:7a83 with SMTP id 46e09a7af769-7f3de1e5583mr8902353a34.0.1786756111121;
        Fri, 14 Aug 2026 18:08:31 -0700 (PDT)
Received: from shiv-machina.. (174-16-201-18.hlrn.qwest.net. [174.16.201.18])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f3e86282fesm2232153a34.14.2026.08.14.18.08.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 18:08:30 -0700 (PDT)
From: Shivani Gupta <shivani07g@gmail.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Matthew Vick <matthew.vick@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Kurt Kanzenbach <kurt@linutronix.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net 0/2] igb: PTP Tx timestamp state fixes
Date: Sat, 15 Aug 2026 01:08:25 +0000
Message-Id: <20260815010827.91912-1-shivani07g@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The igb driver keeps a single outstanding Tx hardware timestamp
request in adapter->ptp_tx_skb, guarded only by the atomic
__IGB_PTP_TX_IN_PROGRESS bit. The fields around it (ptp_tx_skb,
ptp_tx_start) are accessed from the transmit path, the retrieval
worker, the watchdog and the teardown paths without any common
synchronization.

Patch 1 ports the fix igc received in commit 9c50e2b150c8 ("igc: Fix
race condition in PTP tx code") - which the igc series cover letter
already announced as intended for igb - to igb's single-timestamp
model: a new ptp_tx_lock protects the timestamp request state and is
initialized during software setup, before register_netdev() exposes any
consumer. The state bit is removed, and the unsafe cancel_work_sync()
calls in the watchdog path (deadlock with the new lock) and the
atomic-context transmit error path (sleeping while atomic) are dropped
in favor of the worker checking the request state under the lock.
igb-specific paths that do not exist in igc (the 82576 polling worker
with its timeout branch, and transmit error cleanup that verifies slot
ownership) are covered as well.

Patch 2 fixes a related lifecycle bug: disabling Tx timestamping with
a request outstanding strands the request. On re-enable, all new
requests are dropped until the stale one is flagged as a bogus
"Tx timestamp hang" by the watchdog up to 15 seconds later. Pending
requests are now dropped at disable time. The disabled mode and empty
slot are published atomically under the lock introduced by patch 1, so
the transmit path cannot admit a replacement request during cleanup
(which is why the two patches form one series).

Both issues were validated on QEMU's igb (82576) model. The unpatched
disable/re-enable blackout reproduces deterministically (recovery only
via the 15 s watchdog timeout); the final patches complete 100 cycles
without a blackout. A 60-second timestamp stress test with link flaps
delivered 6445 of 6469 requests and completed without a KASAN, lockdep,
DEBUG_ATOMIC_SLEEP, warning, or panic report. The race window itself is
nanoseconds wide and was not directly reproduced; it is identical in
structure to the igc bug fixed by 9c50e2b150c8.

Note: this series touches the same schedule_work() call sites as Kurt
Kanzenbach's pending "[PATCH iwl-next v5] igb: Retrieve Tx timestamp
from BH workqueue" (20260305-igb_irq_ts-v5-1-d3b96828ab5b@linutronix.de).
The overlap is textual only - that patch changes which workqueue runs
ptp_tx_work, this series changes the locking around the request state -
and either rebases trivially on the other.

Shivani Gupta (2):
  igb: Fix race condition in PTP tx code
  igb: Clear pending Tx timestamp requests when disabling Tx
    timestamping

 drivers/net/ethernet/intel/igb/igb.h      |   3 +-
 drivers/net/ethernet/intel/igb/igb_main.c |  49 +++++++-----
 drivers/net/ethernet/intel/igb/igb_ptp.c  | 120 ++++++++++++++++++++----------
 3 files changed, 113 insertions(+), 59 deletions(-)


base-commit: 24ef02f934eeb48830cff6b739abc3c62b1d107b
