Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A05F143B3D5
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784815548; cv=none; b=t4wfmHdo7sB34WDGNa/ypNMX3azrerETjSh3jwWzZHphDo7N3IvdHZBI3NuVNiSmTmH1ak86mHs6D7HAncaeUGJjLEvXoerkIfL1WsXCidUysinWmH5YoxBCeR41kSjWOuFfNFQXiAnwRt2BmdkEjdAkieHpUCGEtaZqTdHFU7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784815548; c=relaxed/simple;
	bh=g3YvFr3mQWK4r7QKZwSPcqGz3pifvHUPud8UaiVO7Vg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=S4cgFUUe6Hl1LTX0XMzBckBpLyZSMvZlmPyEFDuKaT/eXixySQYNmBrckzPbUCvwqkyD7XzisSKwbbFZKIJmUHdAwOXpcn9lQT1st7wBMzt0k1FKF95Yew4jnaVJ7mmRaMSMNXcGYQy70tGtlx4rkv+qkTx/VMj8K+Q4SXyFLOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aX/SNI+D; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=ovqPc0l1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aX/SNI+D";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="ovqPc0l1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1784815545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bnNSPSqjSTGJPtdLgfXOXWJwWqSENrN9xp6WtLBFRR8=;
	b=aX/SNI+DULP5SHCXBQfKmEJjDI+qTBvTPTdOozAr/HjCiu3UP35gxML1ijvI8VXXw6/wWZ
	er/LEv0B5v22pAR5n44MF9dNRVYjggPAYbC+WPZiGc+3i28+CAGDb40IqrBAVznEohvud0
	KxxKq45pDiIb/PDZjK945xLUDMTMKsM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-fIdQXlNvPyKkG05xIDK9_Q-1; Thu, 23 Jul 2026 10:05:40 -0400
X-MC-Unique: fIdQXlNvPyKkG05xIDK9_Q-1
X-Mimecast-MFC-AGG-ID: fIdQXlNvPyKkG05xIDK9_Q_1784815540
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4955edc851aso4528245e9.2
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 07:05:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1784815539; x=1785420339; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bnNSPSqjSTGJPtdLgfXOXWJwWqSENrN9xp6WtLBFRR8=;
        b=ovqPc0l1NCqABAi/278vPGCSo23KHjcg494hQ8CwvzPtFL0CgWQx5rYSNvU13b7Cc3
         7aybTHjbLKKAdUHKR5J8DGHZgn+UkSb/iFqgnJ9mVxuRPJZ9y66AsVNIHiNzHWTAwDDG
         4xIZUbTkj5XMCKdJR30FIQSyj9pFGokmzwb+avZ2qylAT/7RVPtBOFO4p3tdYCKraJL5
         s8eGjM+YjTo79Ca1lWrBQqKhi7NcXZwesCZfp4doJKwOa3XxiW8Po4JREBPj4ZTszZdr
         UHWWgttaBfRtruLL+UesF+DpJrPfDYSzKNzUZADyvmvd4kLJwZmIczA9L3jHIbrTd4mr
         tfWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784815539; x=1785420339;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bnNSPSqjSTGJPtdLgfXOXWJwWqSENrN9xp6WtLBFRR8=;
        b=ibIp6s5LDXKmg8EOHeafWH/ZzD5Xkb7EMB5f3wI00vAQnJ4pPAuDgK7Ll9eL+AnPDz
         Fg1ZfYSPuXM9IPRtAzs/+iqm086mZIXj3GKdhqX6CgTdihM8otp473n8Ja8Bd4pC7avP
         FPmv0tkREqqPZ2d5DLHG7GPhB/nHqbMXxtqyURZg+HQYX2V/FoQAHtmohybpzCj3PgHe
         Akc3kPJCm2d/ZsYS3HndX4t6vS0ghLJPMW8lfW5seFMIBOiLQ8PnqL1d47R2SDj3BYMr
         U+ff+Lr2BPMiXfTddxSXae3v67hb0WSh0eOzaXILvXKcyicm/ufmQ4Iv2pdYIBzhFqDM
         d0Aw==
X-Gm-Message-State: AOJu0YwCrHqXRFfA7S5Mrg2ilZThdIMvfa8COlGmFmkVF+aMQy62J+tk
	aoE4V/Oiw0htZiq2OIb0cMlttlY+HIHtW+W721PLKwE8XWhc8Wv8ZgXFpn0zsp/S+i1+9Wovpi4
	MuoHzYtEskRYVUAndI5bQcSimbN6m60sM01cF1zrRsyHweRQ0Qu3V4Ut9yw==
X-Gm-Gg: AR+sD11Tqx4of2ua8eE4UBxSaSrwkIqVkaEwUaeTn205T0/ruPNPkzo2ULBYBshFGbW
	sG7s6c1A7J3HcdM1Njy2cKS1iREtOYNGLNj3LL8E1wnK3cIAx8PzpY5WRhNo5gqaQM0U/zUXNtN
	L/sNcQ+/0WGmUIck2GAjjwJ2mEKrQD2TQpGB3szaDneIlCo6dMnfPWIe2mIbqruOpwTlbAqwzyM
	OfoJJRlYh3VLqfx3a4sFSazrjVxoLh+7V0hkd6T7CZfQ35oR6MPf5TgnVeYw/91AcS31fxrEnLv
	mjX8HW29whbAp2ZyW9vt9OT0q7BBdr2BCeAs15gnJ8/ceeJV/r4gjajZSsLYN0ggiDVxPG/REYC
	6ktSF/XpsLVwbHw==
X-Received: by 2002:a7b:c302:0:b0:495:5943:b76c with SMTP id 5b1f17b1804b1-49573cf2a0fmr25628395e9.34.1784815539455;
        Thu, 23 Jul 2026 07:05:39 -0700 (PDT)
X-Received: by 2002:a7b:c302:0:b0:495:5943:b76c with SMTP id 5b1f17b1804b1-49573cf2a0fmr25628065e9.34.1784815539011;
        Thu, 23 Jul 2026 07:05:39 -0700 (PDT)
Received: from fedora.redhat.com ([216.128.14.205])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4956a4aae16sm154261685e9.0.2026.07.23.07.05.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 07:05:38 -0700 (PDT)
From: mheib@redhat.com
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	corbet@lwn.net,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Mohammad Heib <mheib@redhat.com>
Subject: [PATCH iwl-next v4 0/3] i40e: add runtime-tunable ATR sample rate 
Date: Thu, 23 Jul 2026 17:04:14 +0300
Message-ID: <20260723140510.184819-1-mheib@redhat.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Mohammad Heib <mheib@redhat.com>

This series makes the Flow Director ATR sample rate configurable at
runtime through a devlink parameter.

On systems with many queues and high-rate TCP workloads, the fixed
default sampling interval can cause frequent Flow Director
reprogramming and TCP packet reordering. The optimal interval depends
on the workload and system configuration.

Patch 1 moves atr_sample_rate from per-ring to PF level, since it is
a global policy.

Patch 2 exposes it as a devlink runtime parameter so administrators
can tune it without rebuilding the driver.

Patch 3 fixes a pre-existing issue where re-enabling ATR via ethtool
private flags did not trigger a ring reset, leaving fd_ena stale in
the TX queue HW context.

Changes since v3:
 - Added READ_ONCE() in i40e_atr() for lockless access to
   pf->atr_sample_rate (patch 1).
 - Added WRITE_ONCE()/READ_ONCE() in devlink setter/getter (patch 2)
 - New patch: trigger PF reset when re-enabling ATR (patch 3)

---
Mohammad Heib (3):
  i40e: move ATR sample rate from ring to PF level
  i40e: add devlink parameter for Flow Director ATR sample rate
  i40e: trigger PF reset when re-enabling ATR via ethtool

 Documentation/networking/devlink/i40e.rst     | 20 +++++++++++
 drivers/net/ethernet/intel/i40e/i40e.h        |  1 +
 .../net/ethernet/intel/i40e/i40e_devlink.c    | 36 +++++++++++++++++++
 .../net/ethernet/intel/i40e/i40e_ethtool.c    |  7 ++++
 drivers/net/ethernet/intel/i40e/i40e_main.c   |  9 ++---
 drivers/net/ethernet/intel/i40e/i40e_txrx.c   |  6 ++--
 drivers/net/ethernet/intel/i40e/i40e_txrx.h   |  3 +-
 7 files changed, 72 insertions(+), 10 deletions(-)

-- 
2.53.0

