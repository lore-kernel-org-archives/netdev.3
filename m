Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F86C34DCC8
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 05:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790055042; cv=none; b=Ftt5n9NcrLhX+k+SzoW8n27AckegoyPygN/tA8lA5SpFk6fQDwwESDRIf7yCL5BO5b/aLR0JypRu8aL5SdIAXI9yc7u8jOk7u3LDOfvjWTC7yKzZRFQaswd79bRlgvBUPpo9l73mkZdlY+JzJ5vRHWjOaTgT9WsvYMkwbAETy5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790055042; c=relaxed/simple;
	bh=Bbie4m0HNMWMQpApjQgU8Cz6XHFA01t9Ywz48rA3up4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QLQ7Ylr2U3U+VhcJ8tKPGsf8AEUxu2Ny9u5mWKuqb2M9fSbCiosdgmAX2/vetsK3AAPA46gjI1brQqhtp/3maoIjR5oYSucaNza6h1BpzFbwe329iBAvgyWeQ8toneI3XKJEPgdEW8HBw7/3nq/FWDvrAv+9iWxwzI6r/sSXCA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=RY4Ac3PL; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="RY4Ac3PL"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3964dfb5b9aso1593189a91.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 22:30:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790055037; x=1790659837;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=ebnLov+Q2rs5repZqDCuiaG4HicuyOeFYO5yUX8XiEs=;
        b=fKunCgAQM0BGdAaNqCwU0GCw4mQQiKy0IgfvFDamdMOOBzsBmPROXHULA1NEqNbhwY
         lQ/MTXuKYLcI6uZWr33JIHVb78QPRHEfZH65EWmkguyQML6ZUmPCh4ItdRVhFwgPHwAA
         XTYpVYN0W0e75YrF0AMTo/R5FIjqIvY5XfuLoyt4MaF+VnaIIi/7YQ1msgdrvBgbFzt7
         m0U48t0ty/md28ktmQPBocBi/k0TzFSKnsMNRXVkLhsP3teeMBTTPaCVYjHOUsvqrPoT
         ugYF7mcglbVj/r9iVIpZoDDaCqpu8YljNCvudertnKJcLJZVTF4XG9JKFuu9t0VH85wa
         60yg==
X-Gm-Message-State: AFuF++n5n4nD/MEVsH0rww+jFcmhZYLC7R0yEEq8xA70pOJwlKvoLsLf
	SttYaRQYtvobFuEt4g15ZRnSVDCZcdDbT7g+uPI+VUtuyKWzAGKpDvwZe3/ZiIare1/DcuNlzEs
	dgAuqsYRIh5RygwzQo5BZ5WYj7v2uLb3uHk5zBJN49RURIyDYBlzcC9QnJ3lk+sRWzb0Hh+IGBZ
	n5MwoHAxXhyXbc97YdT+PR3StQtTlolL9HGkudgMwvnyfbDQPMsVstbAiD3waI2RddNG/HRWM5y
	qqf47/QUHVd1l83gg==
X-Gm-Gg: AYBFou2xoosL+ad2or6Wk/jZIdto+iZ2+ci9kATuTCPPboUODP813ZeHkfK6L6tFGi1
	S3rEBb4cr+VScyEg4cM53G2ifQFI/tEXrQ+Hsysw62ZHFRZuO6MoW4nE4qdZai6squvuAyC/uRc
	TkUevEU7WL68BckKSQRf5abgPq7Y9zNGxaLbZyL0ulkA7sggIiyqCMxtbC5mlNBV/K6jWDsx1ou
	9PhXIMweB/rjtffrqkv83AnsbQfuc0ldy76bQ4o1HC0UdUe2G1ACETD+nVamXS+wTuCQSbcZ4MH
	J6V69FylKoRCYHa2CaxSdXhIgYGVSYfvcM2nwv9LYj/A569VWWGeCqNYSS5SZMKZMMs45NRRcqb
	r4eOjYKEijVUZKKngFIwWLKUwrkXNzrT88m+Mjal0uwWqqHtAkHdgPCwhptKH5O+nWZlJsk7JMT
	v000SJ6mrnFQlREzlJi296xXcwL7RU0fOYpUFjN2STsQ==
X-Received: by 2002:a17:90b:4a0a:b0:38e:2517:5d1f with SMTP id 98e67ed59e1d1-3a073087ed4mr63671a91.9.1790055037313;
        Mon, 21 Sep 2026 22:30:37 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a06e246bccsm470467a91.2.2026.09.21.22.30.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 21 Sep 2026 22:30:37 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-38ecc48b3c2so8943638a91.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 22:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790055036; x=1790659836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ebnLov+Q2rs5repZqDCuiaG4HicuyOeFYO5yUX8XiEs=;
        b=RY4Ac3PLo5MPXj1i4zbyQ3ZKFOaVEUtiX5R6ixkM9PkiiwBOms6k/FMinlpoaI0wq5
         sKdW5cshRoF4U6sut9jifljVq2u6NE1ahdSBQ3el2kdea8rcVsqV6Ftf5Z6JaW1Ncn58
         BgX6fgUpFmIfvqXLJsxaREHWaa2bOB/Hml9rY=
X-Received: by 2002:a17:90b:1805:b0:39e:6c6a:6570 with SMTP id 98e67ed59e1d1-3a07321be51mr35243a91.51.1790055035647;
        Mon, 21 Sep 2026 22:30:35 -0700 (PDT)
X-Received: by 2002:a17:90b:1805:b0:39e:6c6a:6570 with SMTP id 98e67ed59e1d1-3a07321be51mr35220a91.51.1790055035183;
        Mon, 21 Sep 2026 22:30:35 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f29dc903sm2029025c88.3.2026.09.21.22.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 22:30:34 -0700 (PDT)
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
Subject: [PATCH net-next v2 0/6] bnge: Support async events while down 
Date: Tue, 22 Sep 2026 10:58:58 +0530
Message-ID: <20260922052904.59237-1-bhargava.marreddy@broadcom.com>
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

v2:
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

Bhargava Marreddy (6):
  bnge: Extract bnapi allocation and cleanup into helpers
  bnge: Extract per-NQ ring allocation and init helpers
  bnge: Move bnapi and ring_grp allocation to probe/remove
  bnge: Drop obsolete bn->bnapi NULL checks in open/close paths
  bnge: Quiesce NQ0 around ring teardown in bnge_free_core()
  bnge: Create NQ0 during probe and keep active across open/close

 .../net/ethernet/broadcom/bnge/bnge_ethtool.c |   2 +-
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 514 ++++++++++++++----
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  11 +
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |   2 +-
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |  26 +-
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   4 +-
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    |  15 +
 7 files changed, 470 insertions(+), 104 deletions(-)

-- 
2.47.3

