Received: from mail-pf1-f228.google.com (mail-pf1-f228.google.com [209.85.210.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 775C049483A
	for <netdev@vger.kernel.org>; Tue,  1 Sep 2026 19:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788290289; cv=none; b=iFS9i0o74s7PKoRbcMgb0ltE5bSrpANB+l38OidmP6JqTszUnyM4R8B0RYCcuIuzoSF29jS/YPDTP389K5mcudNuTKl05RBHEVuCL8/naYtDD13H1YWIl/SxWbiXqiKlIdtPnEumoyYnYEwyG3SST7XvYyNr4pDp4JE/rSKNTTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788290289; c=relaxed/simple;
	bh=+UFpASiuqIKcMdnDWDzTtA4Cae69jKZXqzdxrdR7kpg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iEOd9ZdyeFqJcJ9bvYoo8taKULHQiBpkUvHTeb1n3cxIXbw/0IZ4GeYV6SVdBn1xP15bKn39ZC3h4V3RcGPc2OF1MJYsm/n+2vfYR1vfI1p89CmBWqmiMKHBz9HgWEMXvih3PVSPneG6w/lRmWCzcVGE2WSv9d+KZwCW89osy58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=HNrdFwvV; arc=none smtp.client-ip=209.85.210.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="HNrdFwvV"
Received: by mail-pf1-f228.google.com with SMTP id d2e1a72fcca58-853c401326eso128060b3a.2
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 12:18:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788290288; x=1788895088;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=h1fswLlcr3+9E5T/YNE7zD1XKjJ+1SuKp8Rk5qajcJg=;
        b=pWz8vgBnOfXNM4oksSRqfGNxvwX1QYNGHaprVvGdjvF5nZegpvwdIH1aR8L+Ffik0M
         YGu/5iSN/BveZr+CcZ3YWBNxSTyqB26B6X75qtMwtSevAmPo2NO9WVgUBJyMbAWdvi5s
         puFtoufWAl3S+EPWm17LFj1Y6gyL917aSvl9c02LNScpiZocpl/APdt1YAQ54LM637nt
         AkTSOkI4m+SHJA0HWSv5MqJxFAI412J1iReCG0499/FE1KAxLFtodzrCPL8efbiKDOBf
         p0QfJUFkqSXBNreDl5emo48KcKxGAXGZuRtOdgeNN71oalFnabD6sBrluawiw5BHGHp9
         s3Dg==
X-Gm-Message-State: AFuF++lESc969N26O80se+Wgesg8eo+jRMR+QmXsxj3nOCkypyzsI5bz
	CovyMd/lqNb56WXGAEupMd4W7ahWSqNLejyLDmi7CaG5+uVc/HQ6B36egqqJfP937nSueM+KB8Y
	6NpccIpslIxboAX4M2ZALpbKnK7vsxy0HC0yJgMRWxVkuJIhBGPheWRw58k3UrtySDUDoGxGMUL
	kCjNoQg9mkJkBImw6WtnZXWg0W3mIgBHTRICImULt4j+udVZ53oCo+aRXP+uYAMFvf8CS7j8s1h
	lIgez61GB8VgoE60A==
X-Gm-Gg: AR+sD11IuFPIfQxWtOakU+26wjdbXVWY4uLcfoMp5Ktq5kGsS84p4W3K1u/sJIO3gGB
	pmmM+5lR6jPJLBmEN/Yc/OK1w25tWgEf21CgXyHHUsrF7nqo0Vxq2twMl2GG0rDIzpQGdWY9S6O
	btoTXOJ5p0i2KIm1pa+LyVBVhrubwquka/GGjZstnbhyLLCkO477R+Z/FwiTl/+XQli5DRo5X0p
	RVqn/stQiXVv1t5KTdj8qeAggXg1kO7c39oljtPvbk9DMMm+9+mY0c9emDmggOCa0G+GO73VX7L
	tqUWPzPt5fc5+TH1z1cp7sFMH9WqO/AkbmYM5KSp5T6ajb7HsOfcOg1CCZp6lf5yj63ebQk4/Ne
	sNsUm2EkjFvopzMm4REZgmPsJBO24CTU0tC4lpwFZHB7ocUl9upQ2u0x030eHYVODZL+p8sF/6O
	faxgvNDjMWWrg3fLTmZJ27AjjOlQIymerI6wFYW7YAJw==
X-Received: by 2002:a05:6a00:288a:b0:845:e440:d0ca with SMTP id d2e1a72fcca58-85ed26e524amr71161b3a.8.1788290287654;
        Tue, 01 Sep 2026 12:18:07 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-20.dlp.protect.broadcom.com. [144.49.247.20])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-85dbfc50ea0sm176996b3a.7.2026.09.01.12.18.07
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 01 Sep 2026 12:18:07 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d02df2bf09so1478555ad.0
        for <netdev@vger.kernel.org>; Tue, 01 Sep 2026 12:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788290286; x=1788895086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=h1fswLlcr3+9E5T/YNE7zD1XKjJ+1SuKp8Rk5qajcJg=;
        b=HNrdFwvVfOIVWfRepMIYF4wSBz+sg70WCDdyfLvn5AIuvCQQVghTC5G1arA3h04ehH
         N7bvmP/j/SUA2j2ONEdiTQnKjrQLB3Zj7XXwVcNSqay1OcPaiLlYU6QJbDFOP38PZRgp
         7gEeuesNJmpsVnjKO0ziUNOT1hK4NezaL26Ng=
X-Received: by 2002:a17:902:fc84:b0:2d8:d4d3:da4c with SMTP id d9443c01a7336-2d94a90e1d2mr152890285ad.16.1788290285784;
        Tue, 01 Sep 2026 12:18:05 -0700 (PDT)
X-Received: by 2002:a17:902:fc84:b0:2d8:d4d3:da4c with SMTP id d9443c01a7336-2d94a90e1d2mr152889605ad.16.1788290285320;
        Tue, 01 Sep 2026 12:18:05 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-32f07b79cf9sm186440eec.18.2026.09.01.12.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 12:18:04 -0700 (PDT)
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
Subject: [PATCH net-next 0/7] bnge: Support async events while down 
Date: Wed,  2 Sep 2026 00:47:21 +0530
Message-ID: <20260901191728.643212-1-bhargava.marreddy@broadcom.com>
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

This series lets the bnge driver keep processing firmware async events
while the interface is administratively down, by keeping one notification
queue (NQ0) active across close/open instead of tearing it down and
rebuilding it every time the interface is brought down and up.

This persistent NQ0 setup lays the groundwork for additional async events
in future patches.

Bhargava Marreddy (7):
  bnge: Extract bnapi allocation and cleanup into helpers
  bnge: Extract per-NQ ring allocation and init helpers
  bnge: Move bnapi and ring_grp allocation to probe/remove
  bnge: Drop obsolete bn->bnapi NULL checks in open/close paths
  bnge: Quiesce NQ0 around ring teardown in bnge_free_core()
  bnge: Create NQ0 during probe and keep active across open/close
  bnge: Process async events while administratively down

 .../net/ethernet/broadcom/bnge/bnge_ethtool.c |   2 +-
 .../net/ethernet/broadcom/bnge/bnge_link.c    |   3 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 483 ++++++++++++++----
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  11 +
 .../net/ethernet/broadcom/bnge/bnge_rmem.c    |  26 +-
 .../net/ethernet/broadcom/bnge/bnge_rmem.h    |   4 +-
 .../net/ethernet/broadcom/bnge/bnge_txrx.c    |  15 +
 7 files changed, 440 insertions(+), 104 deletions(-)

-- 
2.47.3

