Received: from mail-pg1-f226.google.com (mail-pg1-f226.google.com [209.85.215.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0CA65427E8
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 20:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791924330; cv=none; b=X9OHFnT/xbS41Feo9lGriEwoTPtkToQXn6cAmlHhY8OEkxNFr7pZuBpwf+9U8LW1YOHHDw8ebAO9YoKMWPMOR0jCfz5dvL2sehunj7N6qU+7sCbRRMzFiJsAm2EkurH9PE63JV1silvN93LrQAlqg6vYQQOSIWlUmOEcP2ctVtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791924330; c=relaxed/simple;
	bh=zll7pBkaHbkXB7vZcTbnxv4YSU0M8g94JI5PwWIyRHA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Uq38fr93B/GyhQVQx6Z/pXBBcAopm1IIRg41uEWIayfRPviOpCiQhGc0UgaOyZUJnpWY94DCQhAna0Ytnl11de9Mx0rr4TZk6lcF8qQkIrxW8GMix1RGoIBIEf/Oat+pUxdE88z/4ieqYcXBJib1VODjHbrG8SfvU0BQFu9jh28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=gCMFMCGG; arc=none smtp.client-ip=209.85.215.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="gCMFMCGG"
Received: by mail-pg1-f226.google.com with SMTP id 41be03b00d2f7-cc7d154ec4fso1256579a12.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:45:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791924328; x=1792529128;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lHNLMEjBxGv/Csq/Jqd8d5F3GqpidKw5UhBJWGcIr6w=;
        b=B53QDVB4G6GDquWf3FG3bxfK9s4stWQQX5gImvHICXgp+sKTiCTa1EmYpSsMSqRutp
         g/G+bY7iLWJ3ID0WSC2ovo/XqRIrSqxsSQpLZIAWjbiu4yMrmp7iFdqoej8AuPpzwhDD
         Ir9TEV9kMtU7cm7wO+E0l1myLFkWPAXg+63aX8neqAjZ7awC9uc0Y+4xmWvA88xx329/
         /tiYvZRT78T6BBuQHyYMpl4ufZj3Jghec8SK77cs8Jazt3FbN8OB5gP8omAh9zSu1u3Z
         xn9ol/3VO2yRTqbXVGdxJ0MwQXLjLsQitvbz6NKiHqUXpPtd8ATFywNtj66hU4KBsKsJ
         Ap0A==
X-Gm-Message-State: AFq9FYLmQFla6D2u0BguEMS8np8TYCLuzeSAsli3L1BssZAA7RY8AJXH
	H3TkeLWuIa5DeMHfV5VipPUTQqPeKrlYLs5likHlDIuCX2PKyiywhkm44K8LFklmivIPmItDc68
	Xeke8t7JdLQR80r4NZZ/V+fMrn5nE5iUx/i9ROF0fcU7T8DPHwzyX3OxuxRsFm2uIWUUCGVSJCI
	LGCrG7llQNR/9wAFkTuYwI/F/oSpbJ6DUsgi+0Q45hnHZr8dPVdLL4N+gY1t77U47NpM2VTyePD
	MgA2XMLN34q6V4+
X-Gm-Gg: AYBFou3/NYIND8553smCOShPUWazJn8/UfDwYJEuMbyWT21aSR+gqeZu7vn59VwHDtn
	sKsOzFtAdnQFLKubvzMWc1aD3+j/G9+yb7Yr4qbp3ucjtKZRkxfhUwrta1FjmzMxeMfYybOh43S
	FFXzFGN7GV7jq9VK1sfqk7UZDEzPmNnt74ff4/467xMXUEBFw4FVgyCPWERAwtEhEE8xIqloHD7
	mnsu6LbACMuNAAaUn9jmsjs+F7VvSo8UWmEyZKG5BFeX9kbQPlXHZaiHDJtkjFeUewAkRj3WUu2
	qzWwOUZzw39ng5DxcKcdmrxMd5mrHxudze/WIsak5GAf59DbIUG+l9U5Sq3IKuPzW3UyTs0C9xx
	SP2hiUpbMKmXHdcAtmIXiIr2NniEu5slB15spQomdSqmMi1gFQOzxKbKzHlzYWfC9ArotdNHxIa
	Rw2UfAQ82OCZuI32gdrcAta2Cu4GHEk5d/5ye1xb/NkR8=
X-Received: by 2002:a17:90b:3a48:b0:3a0:9640:803a with SMTP id 98e67ed59e1d1-3ab3a33db41mr12288488a91.5.1791924327608;
        Tue, 13 Oct 2026 13:45:27 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-100.dlp.protect.broadcom.com. [144.49.247.100])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ac60081b70sm350217a91.4.2026.10.13.13.45.27
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Oct 2026 13:45:27 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5350ec54bf6so71453891cf.2
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 13:45:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791924326; x=1792529126; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lHNLMEjBxGv/Csq/Jqd8d5F3GqpidKw5UhBJWGcIr6w=;
        b=gCMFMCGGY+hO/QJlkKPDI1lccyf56F4/Y6xl0SU3+ZrTJ2KZfgV9mTm+m3DKlNXTHW
         5ODjLYhMu6tgEXvZFlOx7k7/ZksXKq5yKah7vZgjfTUGVEy+jc7zwHNEkszont1x7gEe
         1w7gRDQ4sgCPFhTj4sS6q6y7xL58uoQfkBi+E=
X-Received: by 2002:a05:622a:488d:b0:533:2139:9757 with SMTP id d75a77b69052e-5359fb8ef45mr224558281cf.58.1791924326271;
        Tue, 13 Oct 2026 13:45:26 -0700 (PDT)
X-Received: by 2002:a05:622a:488d:b0:533:2139:9757 with SMTP id d75a77b69052e-5359fb8ef45mr224557741cf.58.1791924325569;
        Tue, 13 Oct 2026 13:45:25 -0700 (PDT)
Received: from stbirv-lnx-1.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-535f4eee7bcsm15879231cf.30.2026.10.13.13.45.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 13:45:25 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Zak Kemble <zakkemble@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Ryo Takakura <ryotkkr98@gmail.com>,
	linux-kernel@vger.kernel.org (open list),
	Nicolai Buchwitz <nb@tipi-net.de>
Subject: [PATCH net v3 RESEND 0/6] net: bcmasp: Collection of fixes
Date: Tue, 13 Oct 2026 13:44:33 -0700
Message-Id: <20261013204439.3494046-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This patch series is a collection of bug fixes accumulated during a LLM
coding session. Thanks to Justin for the internal review and helping
with the last patch.

Changes in v3:

- add Nicolai's and Justin's R-b tags where collected, except patch 6
  that did not make it to the mailing list somehow
- removed inline keyword from bcmasp_netfilt_is_companion per Nicolai's
  review

Changes in v2:

- address Sashiko's feedback and correct the commit messages and code
  accordingly
- add Nicolai's R-b tag where collected

Florian Fainelli (6):
  net: bcmasp: fix mib counters struct alignment with ethtool stats
  net: bcmasp: unmap previous DMA mappings on TX map failure
  net: bcmasp: validate minimum RX packet size in bcmasp_rx_poll()
  net: bcmasp: fix OF node reference leak for phy_dn
  net: bcmasp: account for offload header in TX short packet padding
  net: bcmasp: fix network filter lookup and wake filter pair allocation

 drivers/net/ethernet/broadcom/asp2/bcmasp.c   | 121 ++++++++++--------
 drivers/net/ethernet/broadcom/asp2/bcmasp.h   |   4 -
 .../net/ethernet/broadcom/asp2/bcmasp_intf.c  |  32 ++++-
 3 files changed, 95 insertions(+), 62 deletions(-)

-- 
2.34.1

