Received: from mail-oi1-f226.google.com (mail-oi1-f226.google.com [209.85.167.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968345013C0
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 09:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788859899; cv=none; b=tr4Raixbv9U7SfhMSKWezSiN+Erb8Hvtih7E1wOgR05gTQY8vg9UTG2WRz840bP3Vs+Nyf5gb/xd9iew6jOWsKWLkzu+nby3iK3vWDdIjNCto+xyDiDxTpopD2T4jpncowyCFOInDfmDF2AnGdzOeaVJAXwrMhlG3pfsDV/9s9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788859899; c=relaxed/simple;
	bh=r6y+2XF3w/Nq3FYeRd1SJJWJu2qSw2QUOoHNeSVwAhA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EwHZPx556ZP3178sI/8X/PUUFO34klm2on352v0t0GjN7alkl8B3X/bicrbT0EEKBH4LwKWE2d0icDezEwpP9ShGeZwFpPzwdxL/jfrsm9Xhzsb2eimZatw+yHm9cgjovu8WRt0tCQTugllrTxJLsJDM5Ylp82lwM252GdlKAao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Pwwcfd8z; arc=none smtp.client-ip=209.85.167.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Pwwcfd8z"
Received: by mail-oi1-f226.google.com with SMTP id 5614622812f47-4a483a552efso1778053b6e.1
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 02:31:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788859896; x=1789464696;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=netHJ9lyAcbXzjolOOikFRYCS8ocsEKzFL/kWM9D9EU=;
        b=Z5uUC7kqY44kCtwbz11ck0F322JroXzpbbOrgcU8QXvpdV0Q+iyCzEKra3r3zoDjfd
         xYj98YtqFZo+lzEqUizkOBO1akNB5KQIP509l+YuKZoCVLJGsD/bxDifmpg+FefQ93k5
         EwWuti0tRgjV/3Jk1ykhgDqTHlBcs9ccXGsMyZOlxf+P0swi0FSmKScGXZJeZtVFWhZh
         Xy0fROt6pfSjlK5yE4JYrlSdJq3XUAfeRmQT88tx0k0ykoF3+IvyY0Zu57lXMGsj4r2P
         DuAzixhLN99TlUODyuNnAqGZ9GHCusJUcEkOsEWSoxvPhO64FWwXKYTXZrBpbeOATRWf
         3XIw==
X-Gm-Message-State: AFuF++n+Azy7J3WIHPSlPxL11KT5wfbeKJPpHJrw8adlq56PlImMySyP
	KJZtMK4sJ1jh4JTH0wwXMfLhPVIC7zmrkzzt2gOcHh3zW6iB88pKMdKpYvujmySDHj91uxGLYmf
	dEJC67BHYXG/5sSiqdAuYp2BTyKYpZsFCsxTUsSGrQuGGc8BodMVqrww6UeQ3ffYl/lpUYc58S3
	EN/lV4E0aC67TNjjuu8evnlI1M2s86VjyR+pwGaDk61BWhCXbMayXYFAijg+7r7jsNV8Msmsi2a
	tCssm27Vg==
X-Gm-Gg: AYBFou2IBl9Ehbu5vhfMqkY3G5OYR1duMRx5/KwAiriRU76SzBqE2rBeg1QH94qoZZH
	QhpwowD4yz4kMKaHrWPKBE6SKl5MnigYg1GR0kkzwzz8kB7eIMWl1CnUqHD6u5ruHNcyJNhPmIP
	zPcRSpFjpp/YQONLUbsijEf9q/L89+2OhP6S/75B0nKdBC3L8nK/s4x4FFNhyQVf0ap3QJRFiDe
	T3EuYu7ttijRZyTx9YeoY0055NxRWRJ6eoQIKYrVaSjgVyuo0lxQ8xN5lX9L1ZzGgws1u5WSYG+
	Qm7v01dm5XMDNiZCaUXJVlG5CKhHj3MQncEmzh5kDpPuAUvjA4ma1GbrY0FOEUtrWHI2CM8BW4g
	oBl6fNxwoDjHx+IA4nRECENhH9cwszSm6TfqhXseNQXWwIDwVSnlyvKNFvmJrieHslfhTGzKHCF
	OrmJkhDTY2WezrMc6W64KwGY9vL+Ye8IP7WA==
X-Received: by 2002:a05:6808:23cf:b0:4bb:e62e:49c9 with SMTP id 5614622812f47-4bbe62e6e3amr7402468b6e.28.1788859896129;
        Tue, 08 Sep 2026 02:31:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 41be03b00d2f7-cc4553f38b0sm2817563a12.5.2026.09.08.02.31.35
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Sep 2026 02:31:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-398e1f7d1a5so1222043a91.0
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 02:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1788859894; x=1789464694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=netHJ9lyAcbXzjolOOikFRYCS8ocsEKzFL/kWM9D9EU=;
        b=Pwwcfd8zHqryyTmO6LqSlrrq9YJ0zzhEvO5TD7jbD9TPb5sbbX40YgkwmTtBZwsnPI
         RH4uIkW4cDp6OcKoO3mmb3qytcgnWTDi1lJwcfdJRcVicJmYU6pB84Id/pbY6l4tOjdH
         h6wnXd4FUVUgCYqJElkNcAn2llp4xYmSZ4Huo=
X-Received: by 2002:a17:90b:3b52:b0:38f:18f9:785 with SMTP id 98e67ed59e1d1-39b26101d25mr42036785a91.8.1788859890979;
        Tue, 08 Sep 2026 02:31:30 -0700 (PDT)
X-Received: by 2002:a17:90b:3b52:b0:38f:18f9:785 with SMTP id 98e67ed59e1d1-39b26101d25mr42036176a91.8.1788859872058;
        Tue, 08 Sep 2026 02:31:12 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08ca63b3sm31493316a91.11.2026.09.08.02.31.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Sep 2026 02:31:11 -0700 (PDT)
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
Subject: [net-next, v2 00/11] add features to bnge
Date: Tue,  8 Sep 2026 15:00:42 +0530
Message-ID: <20260908093053.2596020-1-vikas.gupta@broadcom.com>
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

v1->v2:
   - Build fixes.
   - Addressed comments from Sashiko
   https://sashiko.dev/#/patchset/20260814011435.194631-1-vikas.gupta%40broadcom.com

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
 .../net/ethernet/broadcom/bnge/bnge_ethtool.c | 996 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_filter.c  | 668 ++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_filter.h  | 123 +++
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.c    | 182 +++-
 .../ethernet/broadcom/bnge/bnge_hwrm_lib.h    |  10 +
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 406 +++----
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  91 +-
 .../net/ethernet/broadcom/bnge/bnge_resc.c    | 119 ++-
 .../net/ethernet/broadcom/bnge/bnge_resc.h    |   1 +
 .../net/ethernet/broadcom/bnge/bnge_vnic.c    | 272 +++++
 .../net/ethernet/broadcom/bnge/bnge_vnic.h    |  91 ++
 include/linux/bnge/hsi.h                      | 136 ++-
 15 files changed, 2828 insertions(+), 293 deletions(-)
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_filter.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_filter.h
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_vnic.c
 create mode 100644 drivers/net/ethernet/broadcom/bnge/bnge_vnic.h

-- 
2.47.1

