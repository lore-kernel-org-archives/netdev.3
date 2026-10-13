Received: from mail-pg1-f228.google.com (mail-pg1-f228.google.com [209.85.215.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EBF545DBA
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791922084; cv=none; b=Iw323vz4baZwfvPxijqNI0HRDsFsn1OaX2AQNiB99oza8DV2btape0F9GBYDKWwM/nK23JMsf0HvI0PvikQsJ02u9OvqcIKzBRQsMFcqXVfE7xOndmaIJD0p90UzmuKHMm9G0wOdfYBYbqTxQ6m/iLrxXRHy8TkCpAyleGO5VJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791922084; c=relaxed/simple;
	bh=ylNSm5iJQKbAXlJuT8nx+gEikUoDjXRomMlE59BXUcA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dv8ihPpNpUH/+qev3u7bJGEQYu56Rygh+TH/Q9FkD7VWJ1U/5PS7rW9X5Iclp5frqSSMx4qR81fKoMP1r6xr9shliUMuTzmKbl31VKObDSs1eG/ue4fMprcPYDZm9me/kxzldhCQEpDB1ZC66E8R8a/WgoNQaeWixiQSHyu662U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=dILCO1bI; arc=none smtp.client-ip=209.85.215.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="dILCO1bI"
Received: by mail-pg1-f228.google.com with SMTP id 41be03b00d2f7-cc4b1f7e8f4so2015646a12.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:08:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791922082; x=1792526882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=vDQVXA2YtwSF9W6aGBSr5Gd50xsxUDYwXPsk5xejvlQ=;
        b=LXiqp2dbQSy1fRLH2QrU7EzGq5T720cAxjdItIFFIJJnuC8NPd2nUkWcH5lklGtSka
         i2fz0U9fZayJXaxAfbY/VDKIpdgfhcikgPagZiylgEWGVOlemxDaVl1FUE9GkqCRPziI
         FIF64cEsW0ESKQ6SSVRGndmlrW5RM4S6Ydb97PrmFy97d4cmsCaRZcX07UUVKbVY/REc
         MrTcDOwQpm5fEvjLKaAlHjAD4G/bxLz4XlQLe5cnnPmSZr7jkWHKAkGEDcv4FKunBrHg
         4Dc9lBOchZzZXJfi+KOV++uIEB9YBkRpjNURXb9iH1Hge4JdFFpxWrn7ZyoiWeRpNRTc
         Cwuw==
X-Gm-Message-State: AFq9FYLTtLNmev9waRRHnucShYhoNGKFIKnK1N7td1hvQHJilPgfYfqZ
	/cUf/lg/HCgASTVNlxw32FnOwAw12xI9eW6rQgR5vYp7hNVZeK0m8SThqiyytHaMUXeo9u00Qjs
	xzW6hdbhc2yHbtOJlxsXPPTXwwLebxMee+1sfww1BnIepyX5rbTPTh0s169Rj9sGYOROsdGHuwM
	Ke+U2zZOuNFwoOe1rWMrHFJn34INBJSLcGJJkDniibJMEjchoCyz2EPgTd8xdPCnAizADSGuZrY
	Hb5+ayKjbit+GTpcw==
X-Gm-Gg: AYBFou3WcaiZhgqwFuoTkAIDz2ecQAF54vEhCzk1kMSBcIdR9P+XNLIr2NeLAO+lhie
	P+DISu9jBUJ97nk+SxNan0iEaZC5xJjCSjVJC1IbBXZgEyGbQo2lA4h+J/rCkvs7RlAWMXNFEq+
	JvHs40qaTXxelTz+2Tu5dPQnRF5yfSXV91UGb3QsH53U7HV58EDhHf7g1Lq5Yyq7S3PwYf+sQUz
	ObpmWBEyL5g8UNeJqsiwp5FY/mO6hbiFTHgrDlPQIuHQsEDd2kOoN/fb2hsS1W8gnpv+MrYJjt5
	YjKHuk06xRsQlrw+XTY0M7LDvvLdK/vu2Nk1L9dc1l7smEsbGee5nHJ16EZUe2vMcIxkwkQNoRu
	t2N71g+yMaiLf+byoUBQSZAI4qgyaS6UCxv0f18tJUHmO1umj4sgMq/jUFNm8qISLs8o1awOaXs
	BS/H28C0oXDPnH6V3bDKBwBvLfs7juxViKMC78EgGVJHNF
X-Received: by 2002:a17:90b:2644:b0:3ab:d45c:59e2 with SMTP id 98e67ed59e1d1-3abd45c5b56mr5800146a91.55.1791922081899;
        Tue, 13 Oct 2026 13:08:01 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ac60395c4fsm309811a91.6.2026.10.13.13.08.00
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2026 13:08:01 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dl1-f70.google.com with SMTP id a92af1059eb24-143826c4a13so2135533c88.1
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791922080; x=1792526880; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=vDQVXA2YtwSF9W6aGBSr5Gd50xsxUDYwXPsk5xejvlQ=;
        b=dILCO1bIGbmikUJIgUJLG8ZWgIq5hFH0mZTDgJrVPahtUSFQ0Bjt39dNlCQ0F5IcR/
         SP7ASbYD0xHoDLuQYLZ8HCfkjXllRk0WghdcE9xQOyolFTZ6MyQrTb3/rCULPS5ZboHV
         HfJ6VvBe9UqJjiegtUVQdQxRZeBzlRIL9Yx5Q=
X-Received: by 2002:a05:7023:a47:10b0:14c:1f57:3e86 with SMTP id a92af1059eb24-16a5f5ddf6bmr17972983c88.47.1791922079310;
        Tue, 13 Oct 2026 13:07:59 -0700 (PDT)
X-Received: by 2002:a05:7023:a47:10b0:14c:1f57:3e86 with SMTP id a92af1059eb24-16a5f5ddf6bmr17972937c88.47.1791922078349;
        Tue, 13 Oct 2026 13:07:58 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-169a31f6f5csm39526585c88.11.2026.10.13.13.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:07:57 -0700 (PDT)
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
Subject: [PATCH net-next v3 0/5] bnge: Make NQ0 persistent across open/close
Date: Wed, 14 Oct 2026 01:36:40 +0530
Message-ID: <20261013200645.1346299-1-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

This series refactors the bnge driver's Notification Queue 0 (NQ0)
lifecycle so that NQ0 remains persistent across interface close/open
cycles instead of being torn down and rebuilt each time.

This persistent NQ0 setup lays the groundwork for additional async events
in future patches.

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
  bnge: make NQ0 persistent across open/stop cycles

 drivers/net/ethernet/broadcom/bnge/bnge.h     |  47 ++
 .../net/ethernet/broadcom/bnge/bnge_auxr.c    |   4 +-
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |   8 +-
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 489 +++++++++++++-----
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   2 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |  10 -
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    |  46 +-
 .../net/ethernet/broadcom/bnge/bnge_txrx.h    |   1 +
 8 files changed, 448 insertions(+), 159 deletions(-)

-- 
2.47.3

