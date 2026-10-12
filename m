Received: from mail-pj1-f99.google.com (mail-pj1-f99.google.com [209.85.216.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF807389DF0
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 22:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791842949; cv=none; b=CEo2uDMZ5yvowMOlj95XfHNacETzkd1ANSy296HEhx8e1VPkZlc7wAcrYjtLKdycalyMtKiTLkZo0Crg0shhFwN2FB3TbEjv1HcV4mNqSLLAh3+LOY3zB52ZVnZ/VPt2dDe3aGOC4LY4JXNSvBnCPRDogM9rwFDEdxEUqvH1poo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791842949; c=relaxed/simple;
	bh=PpygydwRrL4vnusldI09wTyer9R6Lecq22TSqpR5fcY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jjv+smtRf1cJX23viq1nA+9yA7E41nbK7Za+trOeCny8yJQH0vdSUrh0ajv2x7XQ6GgrAZz5mDStkMwBU1z3LcFKUKmKTWPFuSaqofb0ZfL/xy8TdmfAraSxFN04LMkkhyZWiOQA9PGuI2fANlaCfHh3HEUnnsQQ5URUqkb4cPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Zk4inVj3; arc=none smtp.client-ip=209.85.216.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Zk4inVj3"
Received: by mail-pj1-f99.google.com with SMTP id 98e67ed59e1d1-3ab2bf5e75bso1161919a91.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:09:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791842947; x=1792447747;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=tJJ7ewYXsWBtmg69ttLKKwXZgStX2WDfRLXk7asg2jQ=;
        b=TckGu37pKXX+EbrMt6kOYijvlftFeiff9CoqvwGKypVEPQwmDwifHSIDko0Ha7QCUy
         LYAERFyaHrxJf7apv/sTSxlwXB9hy1u3Pt1c4agLXGQdWaje87ert7xZ3Tw4j9LtUn2D
         DkY9COquqNnFO906Eos0a8K+BoC05nrEDAaUV9ALbxs4QGD0kn4X/jO5OKzwItVEZBSi
         Xrh6w5Zu9ap995RwawcbcJ2tKPImW6UcO1kYS3ZUig1C5YGvQvcO5G4rMahDC+siKqWR
         Q4X08rxvLSoAePNIHiUxdspy4HpAOrt+OP7kYrfDZ19aGVNrqsa4Qlh4eY1r3sljjUn6
         7+4A==
X-Gm-Message-State: AFq9FYKpQ6fFbYnk5ivqe+gjsjSkhQ91OBN8ZK8fL8vwF5AHofQktj9M
	flvdj50SWK4NBBjkGNyJQ0YYHMb1NS8gUkH9zps2n78xJli7MnTwo29VyG/fvqVWNDVEqnV71Bc
	DkzYZ3HgCO+TEAN8vcFIaOU6B+Cqi3kE/ilebPQI7dq/C10D0oekZmBcvzbqBOTNBN4K1/lawTh
	2n+2cnL6QkpvrUbKg1cuw0Q/jIwQSsnAUfgODEm7piRX/qVyaAooZtHFvrVsb6cCmdxnpshEFEx
	PJbM6nKtsg=
X-Gm-Gg: AYBFou1X1yJZ/xok3s1qBFr5wJ4DFjJcbF0HI5DH68L4lcPIAR3RCsr+x6BPjNY1Ojr
	+mtfZw2cfNgu/EfiRAvo4F+foJeoDXJMZO+7S5YLb/MscZSxj9/E88WFncWCzj5eX1g8TjwVPUn
	S72W2T1vx7i5iEV+ZxRVf3UDkTLF4nBtWxw97rrFAUJBimPERm0o875w2pPpuK1D3jTr2n3mYQR
	KFZh588iOUqAE6hGp/Dmu0ph1XEOVuz5UJjUvqeJYePFnS55x74emzHvU0Fz/yGeYeXYMd4Gjvd
	6qiKYh/26mfesQuYb9x68XXoKAzJUA9Dal6djWeyJcabUNiRB0jlmQoliWUR2XojlB3wVg8CuSW
	mXUNTW9EVcdtJMmvtyJ4CXpVGtmsG6aD4vNE6JZbqNnCVznHVSaCmrww2rqIafDJENs3lHmxVDj
	ahzF3sUZgMVix8JeB2WmyJndUKtWGfhzwwNkUZwA==
X-Received: by 2002:a17:90b:2681:b0:3aa:ff61:9504 with SMTP id 98e67ed59e1d1-3ab3a9127f1mr8080838a91.20.1791842947204;
        Mon, 12 Oct 2026 15:09:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-120.dlp.protect.broadcom.com. [144.49.247.120])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ab32d54b27sm2073812a91.0.2026.10.12.15.09.05
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 12 Oct 2026 15:09:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-3510d0baf63so6615627eec.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 15:09:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791842944; x=1792447744; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=tJJ7ewYXsWBtmg69ttLKKwXZgStX2WDfRLXk7asg2jQ=;
        b=Zk4inVj3PLvsc7x4bl3kqYTxnhW/0rLdOq9Yefgry3VdWzt3HDzG8qvHvCdGx+EfZg
         vKBgsyDvy2FPj4hB/C6+geB5v+OSMyoRemgYX+RVT/yU+sFnlheOGoEPt6yWgLtdFLmz
         7bGVp9XOCIDTMEFG5mrsD/xHTpe5iIUty3gbQ=
X-Received: by 2002:a05:7022:1584:b0:14a:725b:7b40 with SMTP id a92af1059eb24-16a6203a4b8mr21864066c88.44.1791842943998;
        Mon, 12 Oct 2026 15:09:03 -0700 (PDT)
X-Received: by 2002:a05:7022:1584:b0:14a:725b:7b40 with SMTP id a92af1059eb24-16a6203a4b8mr21864025c88.44.1791842943348;
        Mon, 12 Oct 2026 15:09:03 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1746482c978sm12483206c88.13.2026.10.12.15.09.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 15:09:02 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com
Subject: [PATCH net-next v3 0/7] bnxt_en: Ring accounting fixes
Date: Mon, 12 Oct 2026 15:08:20 -0700
Message-ID: <20261012220827.340998-1-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

The main purpose of this patchset is to fix ring accounting bugs
specifically when FW is unable to reserve all the rings requested
by the driver.  This issue was first reported by Sashiko when
reviewing the driver patches to support kTLS (patch #3 of 15):

https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260810051358.1244418-7-michael.chan@broadcom.com

kTLS support requires the new MPC rings, so the patches touch
the existing ring reservstion logic and exposed the issues to
Sashiko.  The issues are real but only likely to be hit with a
large number of VFs, stressing the ring resources to the limit.
These issues were not found in the lab or by users, so Jakub
suggested splitting these out and posting them to net-next.

The patchset includes some refactoring and some related fixes
in this code path.  The driver will now scale down the rings
properly when FW is unable reserve all the rings requested by
the driver.  The default RSS context is also reset if the RX
rings have been reduced if needed.   Note that additional RSS
contexts and n-tuple filters have similar problems if the RX
rings are reduced and the fixes are deferred to a future
patchset.

Patch #6 is new and removes support for the obsolete NITRO A0,
to make the fixes in patch #7 simpler.

v3:
Split from the original -net patchset (patchs 1 to 6)
Updated to address some more Sashiko comments.
Added the new patch #6 to remove NITRO A0.

v2:
Updated to address some Sashiko comments.

https://lore.kernel.org/netdev/20260928041712.3467803-1-michael.chan@broadcom.com/

v1:
https://lore.kernel.org/netdev/20260831024342.2161156-1-michael.chan@broadcom.com/

Michael Chan (7):
  bnxt_en: Clear bp->total_irqs in bnxt_init_int_mode() during error
  bnxt_en: Fix bnxt_reinit_features() when irq_re_init is true
  bnxt_en: Refactor RSS table check logic
  bnxt_en: Refactor IRQs required logic
  bnxt_en: Reinit IRQ when configuring LRO/GRO/HDS
  bnxt_en: Remove support for the old NITRO A0 chip
  bnxt_en: Fix ring accounting and validation when rings are constrained

 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 446 ++++++++----------
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  12 +-
 .../net/ethernet/broadcom/bnxt/bnxt_ethtool.c |  22 +-
 3 files changed, 211 insertions(+), 269 deletions(-)

-- 
2.51.0

