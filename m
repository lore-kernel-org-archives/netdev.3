Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66BF5412BFB
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 06:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790576005; cv=none; b=Cv3KQvMPuY7oKiWQOXSL3YABl2I4NZKVwZmfym0xs8OP0MYQ3sQoe/WBbwoTNgjCybrVj2FAy7GbmAdSDNUnW6/8rck5Covb0EHv+91vnytpBdmdt7jdUzAOKUCzS6ZrDjX5II1jtcY4Hjmzt3DhH52fm/Xl7PetlzV5yv2q8tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790576005; c=relaxed/simple;
	bh=6tD42cqvdIX5kuE3J6jtYXGA/Dn7Do6Ay0I8SZ+eFkg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DSR8OxjoGVV3jKtW1DawZlYUnSbtY0/7tMu2guaTAZZseae5VSI/QGzMBYuIYaLpjQtYoPnGB/BhxEgdEnbnmyrpGRv5J5h0r4J4UwwQfdel0oAc9ui43+f/X1LIZ8p7rkjmhhmTBYkQRLaI931OGlZOy3MAvZPlr8sKpG3Dobs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=C8SSlWi4; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="C8SSlWi4"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-3a0ad669450so1426436a91.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 23:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790576000; x=1791180800;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=XJqX9wReYd0vAQ7JMnmN23yR6lPs88wXppo9VAOKHJo=;
        b=SDmtVBTUDBWyO+9HF3z0PVW4D/PliX8//ja05ziElOzHpMcG2HB3JHVZkkzSTE4I9p
         oNhBEPYp0+VcjhvmvuYqv+SQtmUTXo6HfRocaNn8gpl3qgc/+OMhuDgRSz5kjttPxlHJ
         ZWbLwNTqR++BuiIdEVcdCM3MhfBDxx0yT8VK0DPTrCfECzlNcve+tnRnb7VFuNolt87D
         Ak1o+LoXQkCYycaLL+Nng0u9ZR+GN8rZg1FH71lsxY1fZslE53Rsyzm9eE/fsKiCZow7
         ODV5OWHigSJ1K0jjbJ4ViAD3zHjNnyihcTukQqb/LnKuqTtslBXY8sGOOjG9hwM2mZrL
         9/eA==
X-Gm-Message-State: AFq9FYKAL85wU5bQscZ9c8f2saseUameF6dxolDaS8AWL2FACFWLoDYp
	siO292Ow9Cg+HnPAU11jQqsDKCn575NWs8B/VsK6/Dasf/VXUimSg02FaFMjKvv1RSs/jum3FEZ
	rvEwgItYPf0QPwOsAwRjhxbdIE1digTG2JCG7mHNRjCk0gvYaKxBNtietlcuVkfDF2Ot9Jd7gsJ
	+K3BtQVqeXgM2MOyp9FCBtJ7nQ9KrZtp8tFUCupYBgpBEtIFUaL+fXgKb9d5tNuiblwbSJXOLxp
	fgYt8z+wg==
X-Gm-Gg: AYBFou2zFfWVMtQwhYo39so0oEhXbgNDzWJvAyRvvlrMhvLqc7z5J7dUVLVPElp41FK
	aoikQC/RWVyBLz70tyJNhPtEnriVVpmerV7hP3s8TFzRpSkd+asqPKLxKkpa78EZSOUyAchpq+d
	lzfwOPcE9Eq/GA0vp2RxtH/ZNizEwG/YQvrp2TnRC4mZjtGIT11Crc/qotgMlJLlUAw+bqjWkbN
	XenaG4YE5EVk/mPVKS2Xkt28TtdBKc0rfa04sA99fzxpS/rer1JSepLUQfOJAvTzFGXIeALu6op
	XrQV+DdrBXmOWDs+pDOA0UhNGy0UAxm+0wDLclKCTPVuEt2I7lgJdpAOHHHZZmwbzwXheATbwi9
	nXl0eNnGQy3sGLzvltBk7/hNG4dtVZ2E0UoG60xXEzctqe57bIbX4/Zd/NIeLO0wa6u4EoNAm0B
	RtwPseGZdgRxd+nNTezQvqvZyT6EI6kkr8xQ==
X-Received: by 2002:a17:90a:e7c6:b0:39e:2f57:67c7 with SMTP id 98e67ed59e1d1-3a098d45c0dmr11128829a91.3.1790575999713;
        Sun, 27 Sep 2026 23:13:19 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3a0c1399bdfsm6069300a91.7.2026.09.27.23.13.19
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 27 Sep 2026 23:13:19 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-dy1-f198.google.com with SMTP id 5a478bee46e88-342a0e1d8c4so4003279eec.1
        for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 23:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1790575998; x=1791180798; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XJqX9wReYd0vAQ7JMnmN23yR6lPs88wXppo9VAOKHJo=;
        b=C8SSlWi408iq4gU3c4exk8c3GPMI0VLjIO2H6i6FX4VbWCJTFFvKA7Cxslrp2dGuvp
         TKHxRqs19Vcx2w5Uep8MEKEggCbAa4hP8tLxsfoxasiYbqxa4OyoC6Nn4VMy6uAoywAb
         wz69CUsRDFXmmrWr2uKv0kFXFoup/PKCsGEHE=
X-Received: by 2002:a05:701b:4558:20b0:148:4522:560c with SMTP id a92af1059eb24-148452256a6mr5733440c88.11.1790575997767;
        Sun, 27 Sep 2026 23:13:17 -0700 (PDT)
X-Received: by 2002:a05:701b:4558:20b0:148:4522:560c with SMTP id a92af1059eb24-148452256a6mr5733398c88.11.1790575997013;
        Sun, 27 Sep 2026 23:13:17 -0700 (PDT)
Received: from H5S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-147913a776fsm17355561c88.17.2026.09.27.23.13.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:13:16 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bhargava.marreddy@broadcom.com,
	rahul-rg.gupta@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	rajashekar.hudumula@broadcom.com,
	dharmender.garg@broadcom.com,
	ajit.khaparde@broadcom.com,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [net-next, v4 00/10] add features to bnge
Date: Mon, 28 Sep 2026 11:42:57 +0530
Message-ID: <20260928061307.1172344-1-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

Hi,

This series adds ntuple filter, RSS context, and flow steering
support to bnge driver.
Patch 1 is a pure refactor (no functional change) that relocates the
filter and VNIC related code into the appropriate files. Patch 7 drops
the refcount usage from L2 filters, also with no functional change.
The subsequent patches then add the ethtool commands for configuring 
ntuple flows and RSS contexts.

Thanks,
Vikas

v3-v4:
    - Addressed comments from Sashiko
      https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260917064548.773334-1-vikas.gupta%40broadcom.com
      https://sashiko.dev/#/patchset/20260917064548.773334-1-vikas.gupta%40broadcom.com
    - The patch count drops to 10 now that the HSI patches have been merged.

v2->v3:
   - Build fix.
   - Addressed comments from Sashiko
    https://sashiko.dev/#/patchset/20260908093053.2596020-1-vikas.gupta%40broadcom.com
    Below Sashiko comments are not valid:
     Patch-8: 
                Comment under bnge_toeplitz().
                 Explanation: bnge_toeplitz() is not used for aRFS.
     Patch-9:
                Comment regarding bnge_clear_usr_fltrs().
                 Explanation:
                  Both bnge_clear_usr_fltrs() (only invoked while the
                  interface is down) and bnge_grxclsrule() execute
                  under the netdev instance lock, so they are
                  serialized and never touch the filter list at the 
                  same time.
      Patch-10: 
                Comment "Does this direct dereference of the MAC
                header need a linearization ...".
                 Explanation: ndo_rx_flow_steer runs on the RX path
                after eth_type_trans(), which already accesses and
                pulls the Ethernet header.

                Comment Related to bnge_cfg_ntp_filters().
                 Explanation:
                   bnge_cfg_ntp_filters() runs from bnge_sp_task(),
                   which holds the netdev instance lock while executing.
v1->v2:
   - Build fixes.
   - Addressed comments from Sashiko
   https://sashiko.dev/#/patchset/20260814011435.194631-1-vikas.gupta%40broadcom.com


Vikas Gupta (10):
  bnge: restructure VNIC and filter code
  bnge: add NTUPLE/ARFS VNIC
  bnge: add helper functions for multi RSS contexts
  bnge: add RXFH ethtool support
  bnge: add ethtool support to manage RSS contexts
  bnge: remove refcount from L2 filter
  bnge: add NTUPLE filter infrastructure
  bnge: add NTUPLE filter support in ethtool
  bnge: add aRFS flow steering ndo support
  bnge: add cpu_rmap support for IRQ affinity

 drivers/net/ethernet/broadcom/bnge/Makefile   |    4 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   19 +-
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c | 1035 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_filter.c  |  684 +++++++++++
 .../net/ethernet/broadcom/bnge/bnge_filter.h  |  126 ++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  156 ++-
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |    8 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  479 +++++---
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   89 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |  121 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |    1 +
 .../net/ethernet/broadcom/bnge/bnge_vnic.c    |  291 +++++
 .../net/ethernet/broadcom/bnge/bnge_vnic.h    |   92 ++
 13 files changed, 2801 insertions(+), 304 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_filter.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_filter.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_vnic.h

-- 
2.52.0

