Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09E1746F481
	for <netdev@vger.kernel.org>; Fri,  4 Sep 2026 10:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788519119; cv=none; b=RPf/tp5ooBCSO9rIi4c1GU6VIH/po6Qj/dioaQMNllCKKPl+bh2s3hbWi3IOPNm/fHNZopa6wC/yrMDTttth8+8JChnKI4FooniCLr1/OoCBWfmdyHkrdm93vBR0rEpuzmEoevi8bu41OdbdK3Ea+n3CeTRahzvrCQZBOpruyP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788519119; c=relaxed/simple;
	bh=CRZ5621kJBUf0kFBzIs/p6RrIVmIC+L8HojR3yFkYa4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J227zPQuP+uFeH4NlDpgCtie9GomRfcT2NSp5aaUaCAHtQsyyFr9GbRHINl9o4svcg+GhgXBMaTjo+0XtAKuJzywIDREtKxr55OQSi0+749y2D5zVxnEqJQNPYWvLUicoEMJ9LW4nq/sK13Uowbh3uiw81QvJhQKXpmnvapbyas=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T3E1j5o/; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T3E1j5o/"
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-8568e3ed034so612315b3a.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 03:51:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788519117; x=1789123917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EeZIpn+895MAZ1fW9hfBwDfRAEOEt4BIsCHza52OGII=;
        b=fv8kjiD98kyV2yFCjqvoaqNunqP/4vsgJ6fi2CQ5wahnbeQqjgG1DZvwEpuQPF676y
         mC8KtpRwwwl9yzDGOjS68e52gTjt0ZLbBc5dOebEh1/UrS+GvnQtGLKMhs5QvKLTGffS
         3obKUY7gHEur9DXbbpLnD1h5tYDvUrImSORmlzBDLrH5KMqHR0Btjg0DTmTMA7yFCiPo
         hAt6NdzlzthWUwWTyoadyzL0vkjrdvK2E24Cx6Vm0zdaFxzfql2xbku0EfZ558aPwSbs
         0mw+GggvjntCAvuteOyXyFeUQ+5PX+CTHUuQTCCwy540mAQ20hn3FM7fkuVbH1NRTbRH
         Weug==
X-Gm-Message-State: AFuF++mICWCLLAIwPy4UjjgQMNHQNrPiEg9oUWKPUqPHxUsfnCZg8dNy
	rK9ZsZkfnaHF/7DJ3w5JRiLOTR0Bv7hhFqjLFE179Ss9w63FHCNOEKTZki4wRvkJxPZJQIqNpld
	V8ZzeKzylcGTWV5zN7lvlkRLV0syKMX7AnKy+b3AdFxnmDroPUO6Et+50rGqXwIa8vZRS0cgMfm
	ftKSM8fp5BVpkDgUrLivZEpTjudPEc/2IegN9KYgTwRAYqq6/GsWL1uEecsOIBn2pflh9e8abKo
	Q9jGzXt8MoZ
X-Gm-Gg: AYBFou1Fl/R490Zwtg71RrF1sPsWJ7R8ABSrQWEpdcc5Hw/BGFGLDTf5OGIHJMpbo3x
	rXaI6G5AHnIzxctA9Pz2SFYn5GxyexpWOqevruf1FJLdz4N/3XTKPfF99b5q0M508LoJ4fp6uqG
	AaASyGMqDIIjK/SZ2xkF6dpnl0zyZK+eCECzbjNITSUn/wZrbp4CCuq4mKfKM1XBoM78BS++KDi
	qF0zZ57FHHrjz4HED7eV/sd43sfqP1EEafypmyD85qHX/ZseKmQ74V/fk6EpGIqEXFfegEFN2CO
	4b/2P2o71wZr97ELxUhqIb3UqVxJb4gYKcXq98kPxOSXULZ8DvbKIijD1j8JQg/5U937VxEvjxQ
	P2Dzy2xaD4xxjHBHkcFRVqdamUL7idCcYjvO5eXtmMECdRLEYPSGLdjWLNg3ppIgzOy31lsXc9L
	ez0l7+Q3/cNyNSNUFlhZR6G6q0cFZWy8l5WA==
X-Received: by 2002:a05:6a00:1d26:b0:853:2ca8:c42d with SMTP id d2e1a72fcca58-861678a9d49mr6502798b3a.2.1788519116906;
        Fri, 04 Sep 2026 03:51:56 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8614e59f912sm745784b3a.2.2026.09.04.03.51.56
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 04 Sep 2026 03:51:56 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398e1fafe17so1311780a91.0
        for <netdev@vger.kernel.org>; Fri, 04 Sep 2026 03:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788519115; x=1789123915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=EeZIpn+895MAZ1fW9hfBwDfRAEOEt4BIsCHza52OGII=;
        b=T3E1j5o/D3XZILv1ITS/3xwiAvhtY0AjR34wo/uHW5V07eV97wq6535rbs2OjKMcXb
         f4n+HaR9SxYb/hZDsDat+23kBY8XnJec8a8FB1z9wo4PiHvTOKB7AUgO3S2cyAUtjQux
         cvSYkXyZaWHc/IovhaDc2jP0WW4bqEwHjDo0A=
X-Received: by 2002:a17:90b:2d07:b0:398:ceed:6d44 with SMTP id 98e67ed59e1d1-39b262abd26mr7938662a91.25.1788519114884;
        Fri, 04 Sep 2026 03:51:54 -0700 (PDT)
X-Received: by 2002:a17:90b:2d07:b0:398:ceed:6d44 with SMTP id 98e67ed59e1d1-39b262abd26mr7938612a91.25.1788519114416;
        Fri, 04 Sep 2026 03:51:54 -0700 (PDT)
Received: from mgmt5.dhcp.broadcom.net ([192.19.222.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339a534d0asm6171170eec.8.2026.09.04.03.51.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 03:51:53 -0700 (PDT)
From: Siva Reddy Kallam <siva.kallam@broadcom.com>
To: leonro@nvidia.com,
	jgg@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	Siva Reddy Kallam <siva.kallam@broadcom.com>
Subject: [PATCH 00/15] Add BNG_RE control path verbs
Date: Fri,  4 Sep 2026 03:43:08 -0700
Message-ID: <20260904104328.763768-1-siva.kallam@broadcom.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

This patch series adds control path verbs support for the bng_re
driver, along with the corresponding bnge driver changes it depends
on.

Fast path verbs depend on a specific HW resource configuration in the
bnge driver, and work on that is in progress. We plan to submit fast path
verbs support in a follow-up series once the dependent changes in bnge
are pushed and available in the rdma repo.

The corresponding rdma-core user space library patches will also be
published shortly.

1) bnge: MPC infrastructure change
2) bnge: Update New HSI
3) bnge: MPC ring reservation change
4) bng_re: Add RoCE MPC infrastructure and xid manager 
5) bng_re: Add support verbs
6) bng_re: Add ucontext/mmap verbs
7) bng_re: Add GID verbs
8) bng_re: Add PD verbs
9) bng_re: Add MR verbs
10) bng_re: Add CQ control path verbs
11) bng_re: Add SRQ control path verbs
12) bng_re: Add statistics verbs
13) bng_re: Add AH verbs
14) bng_re: Add QP control path verbs
15) bng_re: Register device operations with ib-core

Thanks,
Siva

Mohammed Faraaz (1):
  RDMA/bng_re: Add AH verbs

Raqib Jones (1):
  RDMA/bng_re: Add MPC, XID management, doorbell infrastructure

Sachin Holla (2):
  bnge: reserve TX/completion rings for the RoCE MPC channel
  RDMA/bng_re: Add GID verbs

Saswati Das (2):
  bnge: Add infrastructure support for RoCE MPC channels
  bnge: Add HSI definitions for 64-bit doorbell and MPC channels

Siva Reddy Kallam (3):
  RDMA/bng_re: Add ucontext/mmap verbs
  RDMA/bng_re: Add CQ verbs
  RDMA/bng_re: Register with ib-core

Suresh Rupanagudi (3):
  RDMA/bng_re: Add PD verbs
  RDMA/bng_re: Add MR verbs
  RDMA/bng_re: Add SRQ verbs

Usman Ansari (2):
  RDMA/bng_re: Add support verbs
  RDMA/bng_re: Add Stats verbs

Usman S. Ansari (1):
  RDMA/bng_re: Add QP verbs

 drivers/infiniband/hw/bng_re/Makefile         |   16 +-
 drivers/infiniband/hw/bng_re/bng_debugfs.c    |  308 ++
 drivers/infiniband/hw/bng_re/bng_dev.c        |  269 +-
 drivers/infiniband/hw/bng_re/bng_fp.c         |   38 +
 drivers/infiniband/hw/bng_re/bng_fp.h         |    8 +
 drivers/infiniband/hw/bng_re/bng_fw.c         |    6 +-
 drivers/infiniband/hw/bng_re/bng_fw.h         |   27 +-
 .../infiniband/hw/bng_re/bng_hw_counters.c    |  304 ++
 .../infiniband/hw/bng_re/bng_hw_counters.h    |  118 +
 drivers/infiniband/hw/bng_re/bng_mpc.c        |  574 +++
 drivers/infiniband/hw/bng_re/bng_re.h         |  275 ++
 .../infiniband/hw/bng_re/bng_re_mpc_roce.c    | 1861 ++++++++++
 .../infiniband/hw/bng_re/bng_re_mpc_roce.h    |  218 ++
 drivers/infiniband/hw/bng_re/bng_res.c        |  299 +-
 drivers/infiniband/hw/bng_re/bng_res.h        |  321 +-
 drivers/infiniband/hw/bng_re/bng_roce_hsi.h   |  317 ++
 drivers/infiniband/hw/bng_re/bng_sp.c         | 1965 ++++++++++
 drivers/infiniband/hw/bng_re/bng_sp.h         |  458 +++
 drivers/infiniband/hw/bng_re/bng_verbs.c      | 3211 +++++++++++++++++
 drivers/infiniband/hw/bng_re/bng_verbs.h      |  379 ++
 drivers/infiniband/hw/bng_re/bng_xid.c        |  110 +
 drivers/infiniband/hw/bng_re/bng_xid.h        |   26 +
 .../infiniband/hw/bng_re/bng_xid_allocator.c  |  870 +++++
 drivers/infiniband/hw/bng_re/xid_allocator.h  |  114 +
 .../net/ethernet/broadcom/bnge/bnge_auxr.c    |    1 +
 .../net/ethernet/broadcom/bnge/bnge_auxr.h    |    1 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |   32 +-
 include/linux/bnge/hsi.h                      |  161 +
 include/uapi/rdma/bng_re-abi.h                |  118 +
 include/uapi/rdma/ib_user_ioctl_verbs.h       |    1 +
 30 files changed, 12356 insertions(+), 50 deletions(-)
 create mode 100644 drivers/infiniband/hw/bng_re/bng_fp.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_fp.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_hw_counters.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_hw_counters.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_mpc.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_re_mpc_roce.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_re_mpc_roce.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_verbs.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_verbs.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_xid.c
 create mode 100644 drivers/infiniband/hw/bng_re/bng_xid.h
 create mode 100644 drivers/infiniband/hw/bng_re/bng_xid_allocator.c
 create mode 100644 drivers/infiniband/hw/bng_re/xid_allocator.h
 create mode 100644 include/uapi/rdma/bng_re-abi.h

-- 
2.43.5

