Received: from mail-dy1-f230.google.com (mail-dy1-f230.google.com [74.125.82.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2AB130AD10
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864649; cv=none; b=hTFtkheso7KF/qzsa5SFdd6Q4xCqtC6AZLa4AM5sCgtKn3Bnid8Iz+k8Y94QEWdDoDUSLw1ruTbjy21m126POy5EA+ngQgIrMSWJeeM8emJSQ/cvaIXwoweyU5KGn13jf5ozeUNxa0hfmuZ9DOPEtBLaGGMQqU+ovMASSx0gZwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864649; c=relaxed/simple;
	bh=dBeKVKrD9lIvkFHCp3EUDxckYKPOMYO4ZfykaxKV3uk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f/Uuf9tL9Mk2OcX7RwsOjkD5y228rpuryT4spvlWv6PcVlsUD35+1OgtE2hXfo6kB0DOFT4tbQebkbjPuJotIR7ltmxctmNqvZdy2AP+HVP+n98srBYGtnj1mI8L5EU0dbLkR02jBvAomwdxKbpMCZQGuXAUNSF86GzLHaqlR5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GwKG8EMH; arc=none smtp.client-ip=74.125.82.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GwKG8EMH"
Received: by mail-dy1-f230.google.com with SMTP id 5a478bee46e88-2b86ce04c5cso401894eec.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 08:37:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771864647; x=1772469447;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5lSIG9ivLoVe+LbmYQIykMvJQqJm2iMQdCQm+yNRIk=;
        b=H+5iqBVMo44ZxP+WJLJ+HjnDd+kAdjFnIbqsM0Euawq5gym3EVKJEKZjqtzaGrjV8r
         vNcObZI6iAJuepNYfEIdevLXFWhQqkZtDY8IKAk66VYL2W+U/KXSun/xJ5oZoC0Q8K9b
         kU3taxmlzWKZbyBmJE5bSDlk+cC5VbpDkWQEQxb/Mk0k9wTBmS9EBgqQ4GYWzL6qRNln
         FHrLL48ayX6yjjDPklRnsV2ANgaHdtl2YA84kvh+EKLDGeWI064C+BbjYw8Ft70ZCKnl
         17gP7knHGTaJu8Wg9uVIssTgIKHTT60wM6PqpTy8ZzpaGLoKdfdoQnb3VfrCcwn3OAN4
         f1pw==
X-Gm-Message-State: AOJu0Yx+euzsxVmyyyeHhAKb6bet4BkYCVDfDkWdF9eVDnQUW9YG+QaC
	Ci4NdEWyPVJ+Z3qjjGm+nSW+zgmDdRhW75lIPoGHM39+PVY5pqP8cu1+IgdKA29zu12lBtcBE/i
	B/rl2Mdhnajf9Jl2CZ7fsehn6jbRQPyI2RBuIM85bKtnvXFi2h9lPyftlV6bXpETWeTUE2wPIhD
	QfFXwnbus4A6LaL9RA50wfc2819l9pulRSGBnIHx+06QlbmxIeYsstfvd4OO8eODTXlSYwetDZj
	oWBryPqtKtzj3TiTmMJ
X-Gm-Gg: ATEYQzzPoWBNR1+cj7p0E5saW0vrFrYnPr3Ox79SeBz7TiafkLVNTCJCAsaCDBdnHvQ
	nfXqdeXsTkP4N78HCLpazj2jzIJ8L4WTsOBZlUXGelauvquYWsDMHRjHCFt3eipLDQskFsG4Wki
	TLPi9Avwy7wXKEtiDEX5FgNuxjHZND7vN4f8uyFgbzoDKCCfvXMkIiHl1CF7NSC2LTxeHxP1wQ3
	v4UhiccUq99jQK5/m+BA47TCfJgmmsbnqM+J3ccQ2QiYc76GAXo4UiHRTB6UQW1D74ZIjEmiwFI
	dHTu5xNcbbF+efcau3+PzFNJtQWklMWNsCZP4vCgRK9pE03wEM9INyi28mVDb9VsIRbT65ILNOp
	BDFTauADsBsDrH7Vuc2sy9SrmDpm1yOWTdFqXlaEjzPKKmUVQtkb4sdJ1J1Tc+beE5uISRpSrlu
	WYDwDbNwqme3o+B1RM91c9neC5ng+K7x5WBuM4g8O6jpvXkKmOaPNwrB0oa5PUmKQ9Lg==
X-Received: by 2002:a05:7300:a497:b0:2ba:6e87:525f with SMTP id 5a478bee46e88-2bd7bd7104bmr4157137eec.34.1771864646707;
        Mon, 23 Feb 2026 08:37:26 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 5a478bee46e88-2bd7da826fbsm817982eec.3.2026.02.23.08.37.26
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2026 08:37:26 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f197.google.com with SMTP id d9443c01a7336-2aaeafeadbcso52753705ad.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 08:37:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771864645; x=1772469445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=a5lSIG9ivLoVe+LbmYQIykMvJQqJm2iMQdCQm+yNRIk=;
        b=GwKG8EMHU3yG4XXoWNk3jmCRuR5pRDEzIA7c+IayfvOCcbDxSEyg78Fw5UfmQTSp7C
         YdCmbKCu5tHLd5Y7mMkA+jr67MfZcdLK2qsCVE/QWDq6ibbaui2Azc5Qmvxt09+9f9Vb
         +upKN9C/izj/wwIvQR70TJhr5A8ltGhnKenW8=
X-Received: by 2002:a17:903:b90:b0:2a9:320b:d7b9 with SMTP id d9443c01a7336-2ad74516027mr95810185ad.29.1771864644839;
        Mon, 23 Feb 2026 08:37:24 -0800 (PST)
X-Received: by 2002:a17:903:b90:b0:2a9:320b:d7b9 with SMTP id d9443c01a7336-2ad74516027mr95809945ad.29.1771864644407;
        Mon, 23 Feb 2026 08:37:24 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e3445fsm96763825ad.13.2026.02.23.08.37.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 08:37:23 -0800 (PST)
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
Subject: [PATCH net-next 0/7] bng_en: add link management and statistics support
Date: Mon, 23 Feb 2026 22:06:34 +0530
Message-ID: <20260223163641.755200-1-bhargava.marreddy@broadcom.com>
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

This series enhances the bng_en driver by adding:
1. Link/PHY support
   a. Link query
   b. Async Link events
   c. Ethtool link set/get functionality
2. Hardware statistics reporting via ethtool -S

This version incorporates feedback received prior to splitting the
original series into two parts. 

 Addressed following comments from Andrew Lunn
   - Apply Rev-xmas fix in several places.
   - Correct ethtool-speed comment to reflect accurate behavior.
   https://lore.kernel.org/netdev/49930724-74b8-41fe-8f5c-482afc976b82@lunn.ch/
   https://lore.kernel.org/netdev/CANXQDtb5XuLKOOorCMYDUpVz6aFuQgvmQZ4pS6RJGkAgeM8n1A@mail.gmail.com/

 Addressed following comments from Jakub Kicinski
   - Took care of missing mutex_init()
   https://lore.kernel.org/netdev/20251127190855.69779791@kernel.org/#t
   https://lore.kernel.org/netdev/CANXQDtYy2JziaaVi=Cqt+gAJNt4NjFFs8NbhrS=RBV61ORwinA@mail.gmail.com/

 Addressed following comments from ALOK TIWARI
   - Add newline for clarity/formatting.
   https://lore.kernel.org/netdev/CANXQDtZbLhdwEtN+kKg1OVLV+uy-gsNfX+rU4MR77QPuO6_y9A@mail.gmail.com/

Bhargava Marreddy (7):
  bng_en: add per-PF workqueue, timer, and slow-path task
  bng_en: query PHY capabilities and report link status
  bng_en: add ethtool link settings, get_link, and nway_reset
  bng_en: add support for link async events
  bng_en: add initial support for ethtool stats display
  bng_en: periodically fetch and accumulate hardware statistics
  bng_en: implement ndo_get_stats64

 drivers/net/ethernet/broadcom/bnge/Makefile   |    3 +-
 drivers/net/ethernet/broadcom/bnge/bnge.h     |   16 +
 .../net/ethernet/broadcom/bnge/bnge_core.c    |    5 +
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c |  630 ++++++++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    |  384 ++++-
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |    8 +
 .../net/ethernet/broadcom/bnge/bnge_link.c    | 1311 +++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_link.h    |  204 +++
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  |  586 +++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  128 +-
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    |   35 +-
 11 files changed, 3291 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_link.h

-- 
2.47.3

