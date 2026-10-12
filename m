Received: from mail-pj1-f98.google.com (mail-pj1-f98.google.com [209.85.216.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F7CE33F59C
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 05:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791783820; cv=none; b=Tb9k2mlslBk2/Jymzpfach3EhMro6Lr3OQ5d0AZcXqXJelooCChEzkdhlZ/lkysWpYX7TCW8w4jFvYXUtQSYkcsAmUq1KF0vzAC6a03aga1FTvU45li19nUvouMEEqDUlDZ7gJBk/EOt3RUkcBaA1UMSVLhW6AzVSBjxNe9hYLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791783820; c=relaxed/simple;
	bh=Llr2ksnMb8axoaOAofkdX4V28G8NMHhtNXPZ59eRpIU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=riOV32BMtapMi/79BDq5JDBoP+I1loJhvJVqvJpou3g696t+kLyabh4MmuTujReVscetoM+T86NnHb9TO2WWJkQsbxCHCSm7a2gj0DgnfqUy/6e8GlMrOrEdQCcthe1pWOppB7c8eBftMVpGyVKlJIbbYHE+swdanVLj1bK8dUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QVTWjfbN; arc=none smtp.client-ip=209.85.216.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QVTWjfbN"
Received: by mail-pj1-f98.google.com with SMTP id 98e67ed59e1d1-3ab9268d90eso579646a91.3
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 22:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791783817; x=1792388617;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=DrTHSJoQR86XwCgavEnbXSD7VtbrpPm/c0zcBwcD0a4=;
        b=PBPptBHr9qOwE0zODE8lkbi3UWtyqkuHzJOp3ikTVMRXB93O7/m/OKUZvzOPA+QKiE
         qvblYRHh3u/wy7ZTrN0o0mXldOCvv3Li0jZGW39bUx8RrX/Kf6Rug3xXvmPgNEFyooqw
         SwYKLYV0Z0DVeoYKhjZBhsg2OpVJOt6bIG1oCqhtMYO8nrglflLmWFexpNpbbkkSJlrj
         zADMyGUky4pfTaOq6dvBYpzQX30QfhVqb27+CSK+ptSbjMXD3GxHLxL5/3jsvM2NyMI3
         XPBVlH47zcgCi94hKwraDpkYCQ4zPN0adlIjPSxdRcYKBJFT/7GIq59UaVI3GoEm73o+
         8iqg==
X-Gm-Message-State: AFq9FYIFMJ9AdxQTsyTbbhV4EKgz1WSy6jENWdwi7BCvFrXR2sawYsXy
	pGUuTc036L5uY5AXXs7DVnvda+1xrrgHuUTLXOtTtPUzDgntuEYb1m0w5Ac3cD1t8QT0lEbyOAb
	wdlGNoB4ef2RCKIErTJJxsQbwQTTFmZevRTusCyYe/6VL26IlzIZUkiy25LId+nG4Vr/bNGLYuE
	ZmNlAm/0YBu7iVkAil6/mGS9Xn3bKmPSB+9CrSq/wTWlPoCCS1BNdNcxJAXNo1rwbXj++Jhr90R
	STyv+SfcA==
X-Gm-Gg: AYBFou1tB4YFfV6QPWkBARAywaibyIpygOHKou4oJLsOWg3B0fF0kTqvgKbrynFNLQC
	CW3Yyn9W5WUmEivfOAfK532zRVhZ6f30onb4h6PWiSvS1tt1OykA4YJ9yFH9KI4WnzBGNDn4X5U
	Nwk7hpPfjtDMOvjrPYzO2r5ZBW0yRdqEmCeNU0OHe2hGN4NhcZ1MoO/HLNPB190TBzgoXv14HoK
	LnkinpDsnjMgkrLwqES6VuqoRwxa3JBrRULmaNczv7YMD2i+YngRlYV60zdgQwU4ViulJppINLE
	Qo7SfUu1p4RHkNq6kgvNTy3olYAbB4W/liEnfnJ6DWI3B2H2+q+TeOg09mWTwwlWMSmTWFmF73m
	DTKT5W17UaNduUFJ0xcSLVhIOoc+rjjQb4NGtS63m9bxYkeeCDppV+alfjm1fH814+YjNRZ7qBJ
	jAb7W9GtrOMrbL0UttICMqlE9hL0sFiYMsR/pv
X-Received: by 2002:a17:90a:d2c7:b0:3a8:13d6:f740 with SMTP id 98e67ed59e1d1-3ab3a99aa95mr7082749a91.22.1791783816836;
        Sun, 11 Oct 2026 22:43:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-125.dlp.protect.broadcom.com. [144.49.247.125])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-3ab36def334sm5589149a91.5.2026.10.11.22.43.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 11 Oct 2026 22:43:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-3ac0ae43900so205025a91.0
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 22:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1791783815; x=1792388615; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DrTHSJoQR86XwCgavEnbXSD7VtbrpPm/c0zcBwcD0a4=;
        b=QVTWjfbN8zvnAUjtpIKB3A8lr5xYM0GwyoAIELekK1cRNtRNjCE2kdSY18kmeBmdWE
         b+CqXWZi92JR2TUlVyPBmrLWWILUQ/sPkQqcTP99bXJqLJWBeOpw7Lane96ydh7rjNzo
         eIE8eFr50fZ1PbbuqjBZ3IJ7BbjhockYC1r+o=
X-Received: by 2002:a17:90b:1dc1:b0:3a0:eeda:39f3 with SMTP id 98e67ed59e1d1-3ab3aafac4fmr5914881a91.24.1791783815033;
        Sun, 11 Oct 2026 22:43:35 -0700 (PDT)
X-Received: by 2002:a17:90b:1dc1:b0:3a0:eeda:39f3 with SMTP id 98e67ed59e1d1-3ab3aafac4fmr5914869a91.24.1791783814589;
        Sun, 11 Oct 2026 22:43:34 -0700 (PDT)
Received: from H5S1 ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab36f8277bsm14615587a91.11.2026.10.11.22.43.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 22:43:34 -0700 (PDT)
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
Subject: [PATCH net 0/2] bnge fixes
Date: Mon, 12 Oct 2026 11:13:23 +0530
Message-ID: <20261012054325.1782819-1-vikas.gupta@broadcom.com>
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

This series fixes RSS indirection table and context sizing for large RX
ring counts. Patch 1 caps the hardware RSS context count and RX rings
to the RSS table size, preventing out-of-bounds writes and an oversized
memset(). Patch 2 fixes the indirection table sizing so rings above
the table size still receive default RSS traffic.

Thanks,
Vikas

Dharmender Garg (2):
  bnge: fix RSS table sizing for large RX ring counts
  bnge: cap RSS contexts and RX rings to the RSS table size

 drivers/net/ethernet/broadcom/bnge/bnge_resc.c | 6 ++++--
 drivers/net/ethernet/broadcom/bnge/bnge_resc.h | 9 +++------
 2 files changed, 7 insertions(+), 8 deletions(-)

-- 
2.52.0

