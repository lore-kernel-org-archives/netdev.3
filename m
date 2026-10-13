Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C88A053D9E5
	for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 19:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791919192; cv=none; b=nj+tTvQLxAq/iJ5BMAHb26Pub0N1FBb28S41/+Q4bm+g326GCrK0XEjPjkjB0d4BI389tG4Sc1/0tOzvU09mYbTQlZ38BTff0TpypiyoLOuZIMjTRxG6jxA6Z5BGQrN0qEokHMviXVeiY6dJirWStx17l/ElDT8tnJvvx+2JA7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791919192; c=relaxed/simple;
	bh=YprzRlSBQO097fnNymkwLoOkj/kncmNm/McSsUydoqo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mYKQHXB275y3BllU/0LIlq0Tme0saJ7hN+A3+GSlLlwaGJ5Q/74N7ng1Ht3+nFtNDRpL0MGgadNjAIdN1n+xHIipC8kQZbqaC2LQepGScLpY+xbDSek5zNhq3G/k5gayUI+yGKWYhtdSuUc7MZSOzQuN3SV4c6mr7lU/VIT7ZxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UMLgawHx; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UMLgawHx"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-81ae6aefdceso178961a34.0
        for <netdev@vger.kernel.org>; Tue, 13 Oct 2026 12:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791919188; x=1792523988; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=m/MFCfPNCZQJrpx+S7Eyax5BhDmU/GYfaQ7qYqnUIsk=;
        b=UMLgawHxwYB3IdRJAPm9+eA57B7M1fYCskNO90N2eIUXp6UeFME2Vb1V4pyinyBmza
         6sGRMNybx5ARsPHDr+jgXJ++kwdk9LexqmpB0DIOhSlu2Fha0kZeHF9v+lVRXbto37oz
         UtU86KQuz1Ed4cyNLXBAzB8e+GZyfXQTWjpkmZrscgD5j604bBps0yQVRjJKDerFkDp6
         WtEFi8WB1hNGfU2ET/hPwOug0fqa1nFJdJB7UNR6Nq4FyzHPcqlK/dbavfNHlsV4vwua
         gadAwhF1oSU2bprGqIPu73lIWPClfDwLvz3w79bWJiAPjZDxsHmh4tHoJKuOjkpGKRmh
         IqUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791919188; x=1792523988;
        h=cc:to:content-transfer-encoding:content-type:mime-version
         :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=m/MFCfPNCZQJrpx+S7Eyax5BhDmU/GYfaQ7qYqnUIsk=;
        b=Td33asKB4CnxTl0FzPfAKScgPliFrNUE1W54N/IM2Ad/WYApveVHgxn1vdBGHvE0Dy
         Pa/oDB06SQnPpTeeDJ61Z7bT2ongXIQCskczBJzdm08DYfo5rSt3Ng2CXSIPoBJV6R+N
         LUv44duc+U1hs0PU0kdYIaBc3lMAcG1Gb61YtLLEBoNml578nKxH9oQc64DdN9M9Bmrm
         AK92396ZQKRabVTWXKFv3YX1hri8MR7B8TFGUJYhM6IsiaXJa/A+0cW8biuxn7JDnkYl
         vcYj9YKELFIlXBJ3uDUZ6VwSevYxhhnCLdrrkqH3oS040bl9hp0A/MNgNsBs3eiHIJNm
         814w==
X-Gm-Message-State: AFq9FYJ1QiqB2RsyW4tjFXFy1vw7TzU2IvT+EJdF7RvzYpI8u9WPLZin
	p4vxFclvTRxxT27By5I0S6rgwFuDWj07j37FQ6QbMB/2GU+m9bko2InzXI/JgXdk
X-Gm-Gg: AYBFou2J65jXJRzOfVYVDJUEDP2t6npEImOuOWV5H3dYAMs6as5euKaG4Op9+w4jFUj
	BvvB4aVrf8Nixu9DdpKFiruDpJ1AuLfoJz6aMxS8fXcqTExTop3hVmQZpNpMnrUpE1F2yV1hhyf
	gOvY8cxAjWO9pbStPOIk5j+BSsymorh/+6QefMkEFo9jm1UUaqcaJFr/1vaZCQK5IghmllegwhU
	P6eMWqJFDavSeRHQ9j9VFTrV84XxFypSmRBfq2G3QENcbrZ72kGy1RUUMGo9F+huaYhsg56nKHT
	kqQP5xvu3tiN7hXkz/ehqYyisynTAR7e83/U9/CizP4k88rgO2e/6fRrPnx9YKN21RiIipsZhiS
	Whneq35aReKewl4KFAoCwNa7oqsW27LT/Z3Uc+s5YtGb/aCiIoKWQOOe1hpOjoKhyyWZwjsy/pO
	UAOIOuQJfRLa/e1UKqrbsXNEgPN0BIrh+SpbEp7p9zppq6t09oYENu9qUlfSclsU7VqMeew8VBL
	VEjjrEP6W8fhTjh7QhwepjVCq8DnKUzWoPShdkYBH8fKCVXWZveGMXjtzFAo6+xqkd/mdsVGP+N
	NOMxc4ymCOnUBD2K297lTRIP6zXJkCnjIijPTI//mUNkgiuRIfvKfyQoC1uCFDdjlkqvhw9Lvu4
	h0geGwsnz+VPtxRathMoW
X-Received: by 2002:a05:6830:82e6:b0:811:72c5:bd19 with SMTP id 46e09a7af769-83097c62e15mr13853654a34.25.1791919188430;
        Tue, 13 Oct 2026 12:19:48 -0700 (PDT)
Received: from [127.0.1.1] (174-29-1-49.hlrn.qwest.net. [174.29.1.49])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-83039a3dfa1sm13280507a34.18.2026.10.13.12.19.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 12:19:47 -0700 (PDT)
From: James Hilliard <james.hilliard1@gmail.com>
Subject: [PATCH net v3 0/5] ptp: make virtual clock sampling and teardown
 failure-safe
Date: Tue, 13 Oct 2026 13:19:44 -0600
Message-Id: <20261013-ptp-vclock-sampling-v3-0-d3ee4ea62fc6@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NQQ7CIBAF0Ks0rB0zQ2tTXHkP4wKBtsSWEmiIp
 undJSyMC+Pyz8+8v7FogjWRnauNBZNstIvLoT5UTI3SDQaszplx5C2KGsGvHpKaFvWAKGc/WTe
 AQN6LrsFOiZrlTx9Mb59FvTJnVnbLx9HGdQmvspSoVH/RRECgiO6K2laQNJdhlnY6qmUuXuIfg
 xBPvw0OCJ3RxHWjCWX/bez7/gZeIEVt/wAAAA==
X-Change-ID: 20260930-ptp-vclock-sampling-902f98408c93
To: netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, Yangbo Lu <yangbo.lu@nxp.com>, 
 Miroslav Lichvar <mlichvar@redhat.com>
Cc: Eric Dumazet <edumazet@kernel.org>, 
 "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, 
 James Hilliard <james.hilliard1@gmail.com>
X-Mailer: b4 0.15.2

Fix virtual-clock sampling errors, registration rollback and parent
teardown in separate patches. Keep failed PHC reads out of the timecounter
and serialize extended samples with virtual-clock adjustments. Also
preserve the zero sentinel for packets without hardware timestamps.

Unlike v2, this revision retains the existing cyclecounter mask, scaling
and conversion windows. It does not assume full-width nanosecond samples
or promise recovery of elapsed time after an unobserved counter wrap.

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

 drivers/ptp/ptp_clock.c   |   5 +++
 drivers/ptp/ptp_private.h |   4 +-
 drivers/ptp/ptp_sysfs.c   |  18 ++++++++-
 drivers/ptp/ptp_vclock.c  | 100 +++++++++++++++++++++++++++++-----------------
 4 files changed, 87 insertions(+), 40 deletions(-)
---
base-commit: 513444cc62e231a11c9b15ea88de0890da9b2b4f
change-id: 20260930-ptp-vclock-sampling-902f98408c93

Best regards,
--  
James Hilliard <james.hilliard1@gmail.com>

