Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794423718;
	b=vn+0qnxbL9J5k/AmZ6fl8RKiSq6aOTtoTnTRwy1qoIeRAU3+f79wlrlpuHiUJjDDf76i
	 zWSrbpZtZUfREyHEXJXhBv83eF0Cq3mcgm/cmp7V925lS8rbw1RfzB6uLQF9VY8IMJ/EW
	 kbLYoPwTUPqpot4t/YHXMfOteSwbq3wSGkxtv6uelClk7Bew9doq0HGQ/SjHGBoDE73Yb
	 3YZAnR2tLSIu1LbUAaPYSbQzZ6D8z/FtND8kOmBL/vOpldW31y3i0xwPs92ARMC7dqnfP
	 AHvGD+4FuIcj/soSebrnEmhM0k7m+FipG9fQXJ0ybjSBISb/d9Ff9SupHLM/Dr0QMog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794423718;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=WGmBVBqTPzE6wBBa29Lpbl1ycjxY4huditJNqegwALo=;
	b=R/+hxfd6WH5SxoobODpWKZ4f7eUGchc/5zEgMia+Fsi4W4TKbNw2bF3jiGoUFHjy6m0S
	 jEp8hsgfPslToBHLwkZ1lVp2kFhxNWxR/foSBYQ2ixn/p38KIbatLP86OPtzyOfzbhoYV
	 b0uSNIRrDo1jsfA//pAy2NAetCZHi0gtl9wOtFVuL5Q/JII6fExUpIjJKXEHh58vAf9lg
	 h1C0Lzt/0iGtfaKEJuJhhikfKm/PFb3WTZImsSoau6FGpb4kDfzUl+zbRruzdutl4EnM9
	 zD7bCuXCBI4Jv5LRpoTy4kAqv1jI5zaGTbAYUKcGGAVJqCVSWhcDmiEblQ+xjiIwP1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b="GXjtCnX/";
	arc=none smtp.remote-ip=209.85.214.227
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08DA606A321
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 19:01:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B08DA606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=GXjtCnX/
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2ede35b0cf2so3628915ad.2
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 11:01:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794423717; x=1795028517;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=WGmBVBqTPzE6wBBa29Lpbl1ycjxY4huditJNqegwALo=;
        b=bvrVY93YSRD6JnJ8j5lXodcheVInMfIZ+phbSv2D+4eugWJ76SsqsEbtbx/ZLZR7ol
         9zgmHJXjDyDwvxIvHT7mjO5U5Q4u7JN25f/vBU7IxlvvCEtN2PHKRiO41gj1/J0asIMS
         SZHeGFgGkyB3SE40oFCri7KUCGfXQzXROvoNyOToTvLyCIBVeVHOhObEhursTd63NTUH
         zPZ9q+T/2/QtM5b3mkASUylyVA/gcDwG0NCwrHzgVBERp/Sw79zWGSmXKXsWVTD5e+Rs
         5cz3QBD3EBxBUr4j5jUoqBs/PL/iWQT6nTiQ5oWmqe9qJJ7ao9NHMVHTZOYSR5OVXMge
         u+UQ==
X-Gm-Message-State: APuU4Z9g+FR+LEwIvBzvJg4Xr8ZcWk1Dwbc5neV5Gfny8f9r1tXgoJrW
	exHO2qFJqY0yO4L8Bx5Ms11fWDg+JmS265zUzFlqK2iPQTyocyjzzpbtRFQV1IRoQ5DfTYyV0bL
	h5SaCa0ydpxcRWhD56JhLvXVS0ahc780r2AqicLhabVCzXiWWXtaBLbVMunhGvaDTb0OCNk7/gz
	OV6PdPwR1Y0bvKhYQuZVMJ0Ic5vU6rBthxypp23q64DJdwbbpfEByDV5DUwxq0rElBuMmlxtdax
	e2hGqnI5RTAKuCmeg==
X-Gm-Gg: AYBFou3MBghMXa5OxFTOxKJRt/xfXtqSPtTSO6Kd03KA1q1udmbbgHftXSHzA+ZbhlX
	991TKiYizD59jDLoLLx7kMeFZT5vfOLJHB23Z4xN1PXPfYpf3QK4fxSsIbKOpO/gEDIZsFQwpzd
	PnaMDsXs2tp9V5C/zf1oWTI9J3FXUYudldHlaVJuGgBBkGf5uTpJaty7V/Eud0A/lJSwhavbc6J
	6xixKikLcXuoBuB6uL1ishqvBaSLcSsUykw1OF7Au+iNsv1J8fDeJ6Je2+4Mnny5tFoMxrVak1A
	Q+kLvXqmNLff/kShusVpBIg5GQNLBKw2VEmY40gmPt5x7g5xzqjztaVjE/OZup3naF3MI6tMBdN
	Dz06Zn2c/7a3Pb0BoChDlzNgnMK8/ReOM7oSGo//Ygv5vEMkbMbHLhFs2LE3IgrId1235dKrunH
	+bfXL9MBL1rsEWKNhiFPFUTodvoeIMjslq7yQHh9y9og==
X-Received: by 2002:a17:903:4588:b0:2e2:c995:b00a with SMTP id d9443c01a7336-2edd7a67c4emr37457225ad.48.1794423716964;
        Wed, 11 Nov 2026 11:01:56 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-22.dlp.protect.broadcom.com. [144.49.247.22])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2edb64dd308sm1262075ad.26.2026.11.11.11.01.56
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 11 Nov 2026 11:01:56 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-30bcb065bfdso5690098eec.0
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 11:01:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1794423715; x=1795028515; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WGmBVBqTPzE6wBBa29Lpbl1ycjxY4huditJNqegwALo=;
        b=GXjtCnX/JlcdnBl8m58qpkEwqCeVbTt6BGj9vkP7o+5++a6Pe9HfY4VCmoYSjATwaB
         hstyPOS/xpYFRTSCPMceqHZSXVJn/LkW4r18xbRtLmv14zzhDxUUxkI401BeUFgRMWhF
         mHqyc9z/zbUOIXlxWge9sGvpAqKAiI3Ii2FYk=
X-Received: by 2002:a05:7301:77c6:b0:36f:d53:cf2f with SMTP id 5a478bee46e88-37682f94242mr3747139eec.1.1794423714650;
        Wed, 11 Nov 2026 11:01:54 -0800 (PST)
X-Received: by 2002:a05:7301:77c6:b0:36f:d53:cf2f with SMTP id 5a478bee46e88-37682f94242mr3747097eec.1.1794423713587;
        Wed, 11 Nov 2026 11:01:53 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-375212ec002sm20860468eec.26.2026.11.11.11.01.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 11:01:52 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [PATCH net-next v4 0/5] bnge: Make NQ0 persistent across open/close
Date: Wed, 11 Nov 2026 19:00:06 +0000
Message-ID: <20261111190011.53437-1-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
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
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

This series ensures the bnge driver's Notification Queue 0 (NQ0) remains
persistent across interface close/open cycles rather than being destroyed
and recreated on each cycle.

Currently, NQ0 exists only between ndo_open() and ndo_stop(), so firmware
async events (e.g., link changes) and HWRM completions are not received
while the interface is down.

NQ0 and its MSI-X vector are now allocated at probe and retained until
remove. To conserve MSI-X vectors for Rx/Tx queues, vector 0 is shared.
NQ0's NAPI exists only between ndo_open() and ndo_stop(), like every other
NQ. While the interface is up, NQ0 runs via NAPI; while down, an
IRQ-triggered work item processes non-datapath events.

Patches 1-4: Preparatory refactoring (alloc/free helpers, logging
             fallbacks, NQ iterator, irq_tbl layout). No functional
             change apart from the items noted in their commit messages.
Patch 5    : Create NQ0 at probe, free it at remove, and add the worker
             fallback.

irq_tbl layout after this series:
  Vector 0       : NQ0 (probe to remove)
  Vectors 1..A   : RoCE (auxiliary driver)
  Vectors A+1..N : Main L2 NQs (open/close only)

v4:
   Addressed feedback from Jakub Kicinski on v3:
   - NQ0's NAPI no longer outlives the open state: it is added in
     ndo_open() and deleted in ndo_stop(), like every other NQ.
   - While down, the NQ0 IRQ handler queues a work item for async and
     HWRM events instead. The mode switches only in open/stop, so one
     context consumes NQ0 at a time.
   https://lore.kernel.org/all/20261022181639.1815c338@kernel.org/

v3:
  Addressed feedback from Simon Horman:
  - Extracted the failure-path NULL dereference fix in bnge_alloc_core() and 
    submitted it as a standalone patch to 'net'.
  - Dropped unnecessary defensive NULL checks (!bn->rx_ring and !bn->tx_ring) 
    from bnge_free_tpa_info(), bnge_free_rx_rings(), and bnge_free_tx_rings().
 
  Addressed comments from Sashiko:
   https://sashiko.dev/#/patchset/20260922052904.59237-1-bhargava.marreddy%40broadcom.com
   https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260922052904.59237-1-bhargava.marreddy%40broadcom.com

  Other changes:
  - Renamed series from "bnge: Support async events while down" to "bnge:
    Make NQ0 persistent across open/close" to accurately reflect the
    streamlined focus on NQ0 persistence.
  - Completely reorganized and streamlined the series from 6 patches down to 5.
  - Redesigned and shifted the MSI-X vector/offset mapping layout:
      Vector 0 (IRQ0) : Permanently dedicated to NQ0 at probe
                        (no longer recreated on RoCE load/unload or open/close)
      Vectors 1..A    : RoCE (aux) queues
      Vectors A..N    : Main L2 queues
  - Added a new patch introducing bnge_err()/bnge_warn()/bnge_dbg() logging
    helper macros to fall back to PCI dev-level logging before netdev
    registration during probe (Patch 2).
  - Switched to the bnge_for_each_open_nq() loop iterator to clarify which
    loops are open-only versus those that cover all NQs (Patch 3).
  - Enhanced safety in bnge_napi_poll() to skip CQ notification processing
    on NQ0 when completion rings are unallocated while the interface is down,
    preventing invalid dereferences of cp_ring_arr (Patch 5).

v2:
  https://lore.kernel.org/all/20260922052904.59237-1-bhargava.marreddy@broadcom.com/

  Addressed comments from Sashiko
   https://sashiko.dev/#/patchset/20260901191728.643212-1-bhargava.marreddy%40broadcom.com
   https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260901191728.643212-1-bhargava.marreddy%40broadcom.com
  - Dropped patch 7/7 ("bnge: Process async events while administratively down"):
    - Link events while down are unnecessary to process since bnge_open() already 
     queries and updates PHY settings via bnge_update_phy_setting().
    - Keeps the series focused strictly on the NQ0/NAPI lifecycle refactoring.
  - Corrected the order of operations in bnge_quiesce_nq0() to disable NAPI
    first, synchronize IRQ, and then ring the doorbell to prevent NAPI
    rescheduling race conditions.
  - Added support for dynamic MSI-X vector reallocation by introducing
    bnge_reinit_nq0() during interface open.
  - Fixed potential NULL pointer dereferences in core ring cleanups (e.g. bn->rx_ring,
    bn->tx_ring, and bn->grp_info) on allocation failure paths and failed opens.
  - Fixed a resource leak in bnge_init_nic() where RX ring pair buffers
    were leaked if chip initialization failed.
  - Corrected the MSI-X vector demand check in bnge_resc.c to ensure
    sufficient vectors are allocated for both NQ0/aux and main rings.
  - Changed CPU affinity hint failure from a fatal error to a warning.
  - Added robust NULL pointer and safety checks in ring allocation and
    cleanup paths to prevent potential kernel crashes on allocation failures.

v1: https://lore.kernel.org/all/20260901191728.643212-1-bhargava.marreddy@broadcom.com/

Bhargava Marreddy (5):
  bnge: factor out per-NQ alloc/free helpers
  bnge: add bnge_err()/bnge_warn()/bnge_dbg() logging helpers
  bnge: add bnge_for_each_open_nq() iterator
  bnge: make irq_tbl layout depend on BNGE_FIRST_OPEN_NQ
  bnge: create NQ0 during probe and keep it active across open/close

 drivers/net/ethernet/broadcom/bnge/bnge.h     |  47 ++
 .../net/ethernet/broadcom/bnge/bnge_auxr.c    |   4 +-
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |   8 +-
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 518 +++++++++++++-----
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   5 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |  10 -
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    |  57 +-
 .../net/ethernet/broadcom/bnge/bnge_txrx.h    |   3 +
 8 files changed, 493 insertions(+), 159 deletions(-)

-- 
2.47.3

