Received: from mail-pj1-f100.google.com (mail-pj1-f100.google.com [209.85.216.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0803175A8D
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 01:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.100
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786670090; cv=none; b=WiN3ZlKwynJz1jVNWCqKH17lrfEtTKw6zYrEtb3YXC+Y0WTEUdbwqgvqXwLYhXEXGDCtXRovCDqajAKC459SIrzHPk2uJ5BQlHGesFyDDosprethC7UeT+Otl1niPZoYxScFzVcoy6i7Xuv50aBiR2tG0vW+CN6aQrZ69EKYmLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786670090; c=relaxed/simple;
	bh=Igms4MbUq7ZL944sFBYoSBZNEhdbJAjFn+H69ILRavY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jp9tFzWNzeJxe3FpwwfeG+hDFnRQ+x5h4lmXBN/FhLbpGdIWyaWHN5If/hscw+TzK3E96wLxJgQDNthyCH+RRh9xpxU5mEGUz5haYsr1xllo8JfzdjPKs1SJbwIQ80dnafk2GXdJ2swPsVV8/pywK4SqhY6XIZZZ/3zKZ+BfiDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GFVdi6k3; arc=none smtp.client-ip=209.85.216.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GFVdi6k3"
Received: by mail-pj1-f100.google.com with SMTP id 98e67ed59e1d1-383cb94f742so440008a91.3
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 18:14:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786670088; x=1787274888;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zSvtMbz0hkgj9EdEUXeFJSwF50sUCkS5t4HNfXSLM9I=;
        b=tZR2mL2RF0Y0AjsxdMlfyCH7IttS7TU02PEohYKCae8B8aVVp+c0okb7Wy24nKyJqK
         N7pOkQAc8KKI/G0FutgO+FIhl2uu3ROF4GLRSBXGYmz0uQZsZpKf5d0ohEc6lNL2v8Rg
         OX/P23CAf2C9eGql7NcIrQRA2ZxwGT8P+IPtRPPLhrQUIC+QRU0h4+cvaBv/OITSh+ls
         wbMcs81u4xK2xeKfcixNvsN2IlaYDBOGIBCoOBV3qnAoi4gUXam5WDipTwtcalvE4dSM
         yt9UVQM4CeMJz6cTfkEYsGbqC3IC6d1iWOmYXDYsAvWNJdG5/4mygPv/qQvQLXKLWvrn
         jI7Q==
X-Gm-Message-State: AOJu0YzCPBcHGu+WiT8syyhIGlDnQy+xAa2ghhqPQku8x9Ra4Ul4pSuD
	H7nPg2dSZd7kY4wJe9fvA6tvv2tCw+osl7niPu3oMo3qNYpuJM6flFUXkFgCBUjQ40QCWmAiVja
	r6Zhl/hQ5j0eUO2iiz3tFsEjSp0siBhBjqt10D8K1yEjwl4uLp8y96GWoLZACiqL1XdGvO00v7z
	UdSQ4EYy/pFaYr9zHc69QpoL7mnXvjMsL9sSeViCMIkZKoDAOzkJd9EWE8WB5s312HEVHX2WC6d
	MoDCw18Eg==
X-Gm-Gg: AR+sD12FT39n9Sfr8VWLRLYX9MXy1SXhpu0izlpwKjx0//S6XKKtNMRSa8w+8YVoxBJ
	vjmNFflusbfuhrd2+HW6aHJ54AbqLUqeis0xXM3vbvpuf2HqGiXdy4ghvNj/H4V2Qs1bmdRXvOg
	ZkPHlMpMp8oym5hORPryP4VmlkAB6Vu6fVI/toRWA4sDVq9+/uHFesuQbmiUqxjoKDRvQ5L6KQJ
	S944bKEy4735P0pvHXbXuLovAlDb1coehLzHPgwesHJDwRWZ+JzSazTB7S/V1pi9t2w9yh3QhL/
	VGFTiUp5ueIVrSdV99c6n2qngg77YkQYr/hLnUFSoU6yWFsf4yW6G1zc9ndP7kYBoIP/2dHbTza
	j7/DMim23HAs0SDskurGJQD514ZYlTmPT5GeRQVXtVrxIf00PtsI2+4O7WqEveAf2kiLuOikjmy
	ubZzMSNxe62i9Shw734cP91l0Qi195td9/SQ==
X-Received: by 2002:a17:90b:1c87:b0:380:540:d499 with SMTP id 98e67ed59e1d1-3933cae4b3amr1914600a91.6.1786670087812;
        Thu, 13 Aug 2026 18:14:47 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-16.dlp.protect.broadcom.com. [144.49.247.16])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-394ea9817acsm112225a91.5.2026.08.13.18.14.47
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2026 18:14:47 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c9fe4c5eb39so292218a12.1
        for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 18:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1786670086; x=1787274886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zSvtMbz0hkgj9EdEUXeFJSwF50sUCkS5t4HNfXSLM9I=;
        b=GFVdi6k3IZf9zuufBJN/PevaNhXu4RENvRS3VXCRMhm+Q2lXRCulCXs98M0695ALnk
         p4BhTkQjtGLKI+oxWMNNnC2RSEfpxMhwJ8E0pziehp2HuIXwPSR22Q19HwfPonleglqD
         AXoqi2/3AQtGSm8E+kdC1mdIkbq0E8g9b+Lr4=
X-Received: by 2002:a05:6a20:6a0b:b0:3c3:a5e4:912e with SMTP id adf61e73a8af0-3cc71fa8648mr1833035637.17.1786670085884;
        Thu, 13 Aug 2026 18:14:45 -0700 (PDT)
X-Received: by 2002:a05:6a20:6a0b:b0:3c3:a5e4:912e with SMTP id adf61e73a8af0-3cc71fa8648mr1832984637.17.1786670085294;
        Thu, 13 Aug 2026 18:14:45 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31ebcb69fbbsm12174177eec.11.2026.08.13.18.14.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 18:14:44 -0700 (PDT)
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
Subject: [PATCH net-next 00/11] add features to bnge
Date: Fri, 14 Aug 2026 06:44:24 +0530
Message-ID: <20260814011435.194631-1-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
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
Patch 2 is a pure refactor (no functional change) that relocates the
filter and VNIC related code into the appropriate files. Patch 7 drops
the refcount usage from L2 filters, also with no functional change.
The subsequent patches then add the ethtool commands for configuring 
ntuple flows and RSS contexts.

Thanks,
Vikas

Vikas Gupta (11):
  bnge: update HSI
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

 drivers/net/ethernet/broadcom/bnge/Makefile   |   4 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |  15 +-
 .../net/ethernet/broadcom/bnge/bnge_core.c    |   7 +
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c | 999 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_filter.c  | 633 +++++++++++
 .../net/ethernet/broadcom/bnge/bnge_filter.h  | 122 +++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 182 +++-
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |  10 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 361 ++++---
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  91 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    | 106 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |   1 +
 .../net/ethernet/broadcom/bnge/bnge_vnic.c    | 272 +++++
 .../net/ethernet/broadcom/bnge/bnge_vnic.h    |  91 ++
 include/linux/bnge/hsi.h                      | 136 ++-
 15 files changed, 2740 insertions(+), 290 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_filter.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_filter.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_vnic.h

-- 
2.47.1

