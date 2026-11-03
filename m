Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.97
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709427;
	b=enqk/BkJom8TWqnhEEZuKMCRy6wk6j0dJbEx8oRbFlB3I3FyTuPB0QB+q24vh9KIxoGG
	 4fiDezp0ilJtcTNM5Pp34jGQciejEFGis8+0tblyf8mm6WwxfB8YuBbpCxo6tn78BSVil
	 aT4vBS2fAIduE8YpQfAaEebmpE9n7cxB092hnOdzL87PyRT+HL7PHKW9+NPLnq3ZgEZZ2
	 1tNfA6ZAMy2dassh177zbgS0h9xwS19o9TAReNgiRklHIKYqPONec1ezLWZfex3gbNvOc
	 c4jc/PipTeVJR2pdzhnsclPyiW3VLO5g0zbzZ5tW+C1jMdtGhJw1C1n/n6cTKRfrtUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709427;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:X-Relaying-Domain:X-CFilter-Loop:Received:
	 DKIM-Signature:X-Received:X-Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-DetectorID-Processed;
	bh=9yi6gOIzZud2vd+UmqWufIHcf5N7plfF2wRET9ypfz4=;
	b=QqduoT4pNNtTtb148r89EAsD3H6yIctaCdhdcXfL37OqVKe+rjVDujo9CbgxmG30wyQJ
	 FzBcuvIvHVj4am1x0LsuuX+BtPAWaVQ0aBPUfVaL4t3tHVQLffq8X5I1dsehxTeA7muZo
	 XUFfh5gHJYf8bvMxA/kdkr543mcYDAvoHV9bXR5smpEIcy+/vdYn7f+YN9mEeaQoyqMcM
	 6HSn+iDf093asCaLVcMZHiON5EnNrOwiujBmQ3n+HJkM9TGe++YL4Fndgk1VkloMsAjgb
	 rMKPMS1e+eL8RgMR49mGnsYMwEg82CCMVHA3lE/f2JVJ8Os/IwedCkkjpjpHKIy3wUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=broadcom.com;
	spf=fail smtp.mailfrom=broadcom.com;
	dkim=pass header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=f0hXN4Rb;
	arc=none smtp.remote-ip=209.85.217.97
Received: from mail-vs1-f97.google.com (mail-vs1-f97.google.com [209.85.217.97])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F0BB606A324
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 12:37:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F0BB606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=broadcom.com header.i=@broadcom.com header.a=rsa-sha256 header.s=google header.b=f0hXN4Rb
Received: by mail-vs1-f97.google.com with SMTP id ada2fe7eead31-78fb1fb9508so446997137.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:37:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793709426; x=1794314226;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=9yi6gOIzZud2vd+UmqWufIHcf5N7plfF2wRET9ypfz4=;
        b=rKFFx/qJkN8noVEE/I2rc/ZWkEAfGL/8QG9dQoRyloSTWu1a2qZyONxEXV5BAI9ukd
         G/auShV2OQldf/rSLPe89GonbSeScNEatc4dEAMWIpwrQ6IDLYUsuZH8ymbWwrDXbrXZ
         6n8CD4irks1+rP9EPlpBf6FSVzuQeiA+Cf/mLJHKXTjk6foUoY0D97scfWqmjaFFlkdL
         nzZoIbotrcnWjrRbkQD7JulLcwzMYFYtDzXqIHfed4+8ZuLwhWJGfMcbzrTCdSPHbX5P
         RqWA4mLxXCWK/8cE4k9nY4c3BtSmEX9fbsL4XMaD5wBcUfnlGW0v5EmAKxTPcmxhZLoJ
         qokw==
X-Gm-Message-State: APuU4Z+Z33nEyHrpiNKgUZzLl2PeE0nT8Jaik8ei+Su7rZe2nRCA/Iul
	u237OdijGmAa5pO74AjSHfltwyWh5nzm6RA/eItBbMJx6crwNnHqoTnjN3tBMZkpY9DAgSG128P
	eUPKxIlHvjAHIP0o8mUu+jLWKYpu4ZtrAYKvbLe/QIspwejXROKM/coDa0eIk4HZm1UM7i9SGfc
	XapeFQ9xGtjAAjLGHZgSF9aPxI1A9SudPNgjGjMko/8Rd+5/2JLpR4f9j18OzzI9K18Z3GEixOs
	NA18uEs0w==
X-Gm-Gg: AYBFou1ZMmOx5kvvSe0dRGavBnuSOhjdNZAbYZnFMicquNPOKy+RreXClk5hS1obrNL
	ELsSe4LmQ9l38j83rLSLvr8/QqmFAKVWWqWfTNF1si3OmnrL9nmm0DeKIDzoIM8j7EU2CmVZV1k
	Ew6SOxbCEtRF+DmmeVrxS9yLlxc2ggaxQN/OUTsVQSbsVVnq8+TuTits8EhmLTtPgEXykCWP8nW
	HPLDh8BaJE09pP76YjiXgsOY6hAmvgnGE02NBzT7+3m2/VJUWk3LY1rypZI8P/EVzWhKS5C26yC
	4EfH1HPifs2kDqL7Do8yCevf9FHPr6yqPRmlHYggEmTj7i+22K4TZS6b5h8nUtngOuhfgBdT/n2
	m7SiYyAPxwacpgVx+FEsO43pjCw54rlCSZf92ZAe4AosmquO1lVuCQ7kh6MsfpN8nR0bn20Sb7H
	LCCiowdRBkTDMBJ7EXxdwhEuZNGUEp18yxYw==
X-Received: by 2002:a05:6102:3ec9:b0:7cb:91a5:7cb1 with SMTP id ada2fe7eead31-7d05439aacamr4628587137.39.1793709426094;
        Tue, 03 Nov 2026 04:37:06 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-13.dlp.protect.broadcom.com. [144.49.247.13])
        by smtp-relay.gmail.com with ESMTPS id a1e0cc1a2514c-992ee3b335bsm329441241.7.2026.11.03.04.37.05
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 03 Nov 2026 04:37:06 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3aed37745bcso440348a91.1
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 04:37:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1793709425; x=1794314225; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9yi6gOIzZud2vd+UmqWufIHcf5N7plfF2wRET9ypfz4=;
        b=f0hXN4RbdL6zPEUC10ej/8zR7cpZbOaUlNQHaaDqFHwO6tcUUFa5s0hKQyz0e0+xaH
         MNTXl8PKqME8UErtvqsYeiRqL1ydAu4c1M8YLUQbl/hTrp86LwTBtjPNEc95ClV0vlUL
         yEbMvS/jbraRPxcdLaMojFEbPqrIzkTWspoqk=
X-Received: by 2002:a17:90b:5687:b0:3ac:9ad9:6afe with SMTP id 98e67ed59e1d1-3ae897c71e8mr6445124a91.39.1793709424708;
        Tue, 03 Nov 2026 04:37:04 -0800 (PST)
X-Received: by 2002:a17:90b:5687:b0:3ac:9ad9:6afe with SMTP id 98e67ed59e1d1-3ae897c71e8mr6445114a91.39.1793709424283;
        Tue, 03 Nov 2026 04:37:04 -0800 (PST)
Received: from H5-S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b08759344dsm2131567a91.13.2026.11.03.04.36.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 04:37:03 -0800 (PST)
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
Subject: [PATCH net-next v5 00/10] add features to bnge
Date: Tue,  3 Nov 2026 18:06:40 +0530
Message-ID: <20261103123651.442893-1-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.52.0
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

This series adds ntuple filter, RSS context, and flow steering
support to bnge driver.
Patch 1 is a pure refactor (no functional change) that relocates the
filter and VNIC related code into the appropriate files. Patch 7 drops
the refcount usage from L2 filters, also with no functional change.
The subsequent patches then add the ethtool commands for configuring 
ntuple flows and RSS contexts.

Thanks,
Vikas

v4->v5:
    - Addressed comments from Sashiko
      https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260928061307.1172344-1-vikas.gupta%40broadcom.com

v3->v4:
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
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   13 +-
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c | 1126 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_filter.c  |  775 ++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_filter.h  |  129 ++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  170 ++-
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |    8 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  513 +++++---
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   94 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    |  128 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |    1 +
 .../net/ethernet/broadcom/bnge/bnge_vnic.c    |  378 ++++++
 .../net/ethernet/broadcom/bnge/bnge_vnic.h    |   96 ++
 13 files changed, 3115 insertions(+), 320 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_filter.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_filter.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_vnic.h

-- 
2.52.0

