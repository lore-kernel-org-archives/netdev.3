Received: from mail-oo1-f50.google.com (mail-oo1-f50.google.com [209.85.161.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782AA3E1231
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 23:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792107220; cv=none; b=J78OA6OJzxWlxHj9p/tFd1ucuBChmv+t7hoQYDdXNuOfJS2vW2PvE8Xcjbf0aanqUcqU+NkW1fiyIAQC7+2BhQ/aLNbj7Y6Fg8OfeB5slF1FZUzoEsRLRGMGFGUorL5VEICptO1ZAwTrRolzZGDEsHHULnlu36Q1gPRW7QsCAfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792107220; c=relaxed/simple;
	bh=CNPsR7bzQDLmgfpvT3zgzovzG/cYekzcy5fSLl9hrrg=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=KohxcUETO3yVUllHEpnCu5nWNeQdpqYWSH04so38npYN1SRD7IRo3TYD0Jqfdn+FtehAsZ1scmgSpfCNOEDTW1aZHEsHAIxoSTPkFjEIfYMtHfhIdrTKnicmZ4gvlDWtJE7Wyo1HSysm9skv7fRvWv33/8RbLOZ2l4oexbfMTN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Duz+gkKS; arc=none smtp.client-ip=209.85.161.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Duz+gkKS"
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6df1eeb43feso2538639eaf.1
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 16:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792107218; x=1792712018; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=zdD17TQF6DaYFKwkt5ECBqDYHDfoAehq3WTKwKTpVWA=;
        b=Duz+gkKSP59wp634+7Kd8g2EIWVtABdIwSF9baB06xqJ0P2vG/WEsAujSndwtsMF2s
         kedVs990V+hpFyLk1IUIpof06mUmr2FhqqYzRcmpHeQcs43mJsvDRDUi3hRacMklpAxq
         DKHMhL2DuieoQhg3T//is8T+RF3evY8mEWGwNRC+r8VUkeBRscoaP3R0avFOS9iUpV/v
         OWuLpRlEu3/YJDpUkbMYbwD457Y/DJTof5k+cQfm+eKvceOmYMKKeZHjA0/rMr/PEAgn
         Ew6dXVDdPhNAuZGmJnIkMDSa0RtvhrWzygavPNjzRpOE1AMH61HK7p8eHR2+NRXA+MoM
         i3oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792107218; x=1792712018;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=zdD17TQF6DaYFKwkt5ECBqDYHDfoAehq3WTKwKTpVWA=;
        b=wtDnhtQgtzZtj7RxnFMQ4ewFVfj6mTjK6KdLYs7GbjxcjDobLFLYnfdci1U65L6Nen
         UDsjOncMmNK2j50Qb/lw8RrJywWPucm4iYkW6MyJzyiLD/p/4gs78sgaRyBBejVaW9yh
         90Vq7OglgVknU2Snyvn9l6jZUh8RstjAU710zeEWuZkZcBSHgCmMpw4QZQSYHSoGhwW/
         wINJaTXvEZVJ1Fm0VwHuGCPzsMMJ/GgdfK9urNM0g874yuDdf6tmwArtcgR9BArYEOo8
         RfQ8lpAJ05CsRa3RDQNVHj/shOUZo7n07X+fVKZ/siuy8SOiLTBtsforLwlS+1zmYdPT
         iDPQ==
X-Gm-Message-State: AFq9FYKwsvnjrOfy4k3XE/Ttwjvo6ab0WRF8zJUkbm1PSmrvesG5YR7O
	kl7GGEroDhyHe3WDJsKVP5MNyoyVYzN/jJiIZAsz/MaNnKdGSagRq3n8
X-Gm-Gg: AYBFou2zdzCfHm6AAEAwsyxg5dsXCCYyRTpHLGiNo44KBYJOpifxvC2zWVVEdxOZCib
	Br6qL7vgGKzbddZExRa2AtQpoWRMuBU7xlyoNcCCQK1aSTQIThMGC27myEDQbxxUNygQSmFjyTy
	Bu36sH2LT3q5IlYpPrE7sSKoc8udG3nFvPfqwWsxWE0DB+vy0k3VG7FQ35zLaYewG5colcDjrPK
	1UMx77OTAKNFHsw+NGUSdcFTxsrfu3QuaDq+JirLs+7bah5c2aQeNZamduDsthHIsPZIDQfleNB
	sE58EfxxpvDBVyXCk1VKThIVr0za+gs9KDLkeNyGYgMA10iJVN7P6QLTLDY0+8cKmc0QXDcG6RL
	Z2Fg7gsgi4qCMiBg7UUzkVdQK0FD8Ww6wx6E4pCsLkmYzkrt9ftvkpGaSuLOXeWhiRVo2VjiO+F
	cJKk1DzKrt83esNthpaQ9UprD3NosGFwaKqEq8c8rOOB7NaVEdIUyfYxdsZO+V6s+s7ObTNpJ3g
	0ShaJmEEpBHq5IDoEevIPyXBubD5EdNaweRwwym+7+kZCl7BC2haEubbAjpLL7ho8WZN0JRSydt
	lNmUVCUvfHkXCHKqB1HWD5bsqjJzM8ZPhLh4Y7YPoC+2ESUGqgrZGm2wxxtHVbARmO6ZWYYDXxR
	6GQ6wgRPbxoVyvtrukzitlw==
X-Received: by 2002:a05:6820:1c84:b0:6f8:3d45:b469 with SMTP id 006d021491bc7-6f83d460e66mr9271597eaf.86.1792107218216;
        Thu, 15 Oct 2026 16:33:38 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70188bd9ecdsm525519eaf.2.2026.10.15.16.33.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 16:33:37 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net v4 0/5] ptp: make virtual clock sampling and teardown
 failure-safe
Date: Thu, 15 Oct 2026 17:33:30 -0600
Message-Id: <20261015-ptp-vclock-sampling-v4-0-cba6ffc8ceb6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NTQrCMBAF4KtI1o7MJDU0rryHuIjJtA32j6YER
 Xp3QxciUly+ecz3XiLyFDiK0+4lJk4hhqHPodjvhGtsXzMEn7OQKDUahTDOIyTXDu4O0XZjG/o
 aDMrKlAWWziiRP8eJq/BY1YvoeRbXfGxCnIfpuS4lWqu/aCIgcEQ3R1obsnyuOxvagxu61UvyY
 xDicduQgFCyJ+kLT2irX0N9GaS2DZUNr5gLtlpWTn8by7K8AbaT4nBDAQAA
X-Change-ID: 20260930-ptp-vclock-sampling-902f98408c93
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Yangbo Lu <yangbo.lu@nxp.com>, 
 Miroslav Lichvar <mlichvar@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Fix virtual-clock sampling errors, registration rollback and parent
teardown in separate patches. Keep failed PHC reads out of the timecounter
and serialize extended samples with virtual-clock adjustments. Also
preserve the zero sentinel for packets without hardware timestamps.

Retain the existing cyclecounter mask, scaling and conversion windows.
Retry failed refreshes promptly and queue the first refresh immediately
after registration. This does not guarantee recovery across prolonged
sampling gaps or assume full-width nanosecond samples.

Changes in v4:
- Retry failed refreshes after 10 ms, keeping the normal two-second
  interval after success.
- Queue the first refresh immediately after registration, while keeping
  counter initialization before publication.
- Clarify the half-wrap conversion window and full-wrap sampling limit.
- Document the zero-input return from ptp_convert_timestamp().
- Add Vadim Fedorenko's Reviewed-by tags to patches 1 and 5.
- Rebase onto current net.
- Link to v3: https://patch.msgid.link/20261013-ptp-vclock-sampling-v3-0-d3ee4ea62fc6@gmail.com

Changes in v3:
- Split the independent fixes into separate patches, as requested by Paolo.
- Retain the existing timecounter arithmetic and conversion windows; drop
  the full-width rewrite and extended-read anchor updates from v2.
- Propagate registration errors through sysfs, including a failed initial
  PHC sample, and initialize the counter before publishing the clock.
- Preserve absent hardware timestamps instead of converting zero.
- Correct the sysfs teardown rationale and its Fixes tag.
- Rebase onto current net.
- Link to v2: https://patch.msgid.link/20261005-ptp-vclock-sampling-v2-0-8ed12d4d10af@gmail.com

Changes in v2:
- Drain virtual clock sysfs changes before parent unregister walks children.
- Use full-width samples and overflow-safe scaling across long sampling gaps.
- Update the anchor for extended and cross-timestamp reads under the clock lock.
- Link to v1: https://patch.msgid.link/20260930-ptp-vclock-sampling-v1-1-c11bc16691ae@gmail.com

Assisted-by: Codex:gpt-6-astra
---
James Hilliard (5):
      ptp: drain virtual clock sysfs operations before unregistering children
      ptp: unwind partially completed virtual clock creation
      ptp: vclock: propagate physical clock sampling errors
      ptp: vclock: serialize extended samples with counter updates
      ptp: vclock: preserve missing hardware timestamps

 drivers/ptp/ptp_clock.c          |   5 ++
 drivers/ptp/ptp_private.h        |   4 +-
 drivers/ptp/ptp_sysfs.c          |  18 ++++++-
 drivers/ptp/ptp_vclock.c         | 109 +++++++++++++++++++++++++--------------
 include/linux/ptp_clock_kernel.h |   2 +-
 5 files changed, 95 insertions(+), 43 deletions(-)
---
base-commit: 045958acaa75205b31578cb22c4345e28dd2e4bf
change-id: 20260930-ptp-vclock-sampling-902f98408c93

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

