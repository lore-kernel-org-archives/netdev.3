Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C182D73AE
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 17:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771264218; cv=none; b=IPQLqlJSAWfrB2Ljs2Ib45Xne1cPthLJXTGr0cKo/+0lSevM/Wfv6VZa49ifT2butNc2BRj7skhC+nj7+Qvcma+ONEazJWXPKlMrrYXJhhoxinCh5DrHVscf/jcQFmmg1XbZYeGRXPlTx6UlUzlujusqcwbRnHu1c/VyDU1nLRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771264218; c=relaxed/simple;
	bh=rG/47OfKUebe4WZWFUbfl2bEO8x/XP6C0M6dGxqt6jU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gIBmIxFVpo1dcPY4QIYq1PsEG+UYKqlKGRapJfZiddFN6Yed41qEcZ7hS8S4T81/g6s8wncTzzAX6Ak0dqGb0caoESwb3tn6pPFA9qAfaDIsPIB2xzQ3x6UgUf8ctusf45bR48bCM3vYnaS/SS523yfmBaeNQpml6qMQ/15xFEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aHIM+zS5; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aHIM+zS5"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2a963f49234so12998165ad.1
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 09:50:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771264217; x=1771869017; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4v1fAIra7fT95ebg+6JoHH+N4Or/PJb9vOIc+JmSiXE=;
        b=aHIM+zS5vkzL+OPP+msc43lFmD+dALVOk6Zvg6FgnMwc5CffAa2rbzOMIDtrmAVTxj
         vdAHZsSOHXqlWxVkTcLRsD48tO147fmmmldv4erK7sQvCH/obDg0EJP/yTHYcL+2O9Nq
         nul8tnI8FTqiV7TJil1Ji7YhTF/RejzyG28S6cFr/uFiOQK3YeoIwPpj0CFf2wEj4btF
         ZKiO2/8uiZpzdtFlBoHn/vuaN3/wT1vJbkAHpXUdFajFEk38jDvOqvP1UqCNtvM68Tw3
         KRAONHCVtZNoKWJ6nKDEVw3YzJo6DMobUxwVfCfd6CrD8vhXi4RAHBjvucVJGdJj/ld/
         vhbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771264217; x=1771869017;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4v1fAIra7fT95ebg+6JoHH+N4Or/PJb9vOIc+JmSiXE=;
        b=GGznkbkEQTrrOwpZRDYaSFc52LYgPK9t9jqS5F9SORsytd+T0xviLx/7C016NYSE/Q
         CsQ77+pLEQtg1GwH9v8YnmoHUzkYfUGAPRrx7V+7qEanKc22JJ9exoZZBiNpm+IFrdjq
         8IQLk5Mt0y76uYj9fWIoZG5S0vfa+1mHC5A9GTGONpHIfi+EDgBMYk7q0GJZN2gneFTq
         DbkZB9bpGnZZ1+ycMNnvmCtAS95Ppe/xwgUdVZ/RN84wm9viM8278cZef+7YtUNMG80W
         g2RtDj8VGnZDPSti4c/X2bccEvvoJer0xL/N37OEVNpEhblSrp+NT73de+lsMweqqvr3
         HVjQ==
X-Gm-Message-State: AOJu0YwzauaG/FJfKIsTy5qpUoDXb4fRpZkgsU7B+icldraH28i1vrfp
	K5wjQtIbcplVwy2DTJKWoI2dRiA7qo4KUZkZ/1aE4zQXV89HqckmBE7R
X-Gm-Gg: AZuq6aJNh5byja6AeatTtMqggRX23S1Y5IHo0mKA2O9R7S1YuUQcxi9iPuVhtDnSkJf
	KRTurG20UKoGyFC7T+FO8liwVQ9PT1yGZCEPqv/yJANvFvUMVpEgd+L/ma9K2pl8lHlWRhEPU7C
	1+Un2M3Ag86QafsXKiM/KptVkBNQQRWhKHUzXexQgYtCi2RA9WYDOHLTBMhlpMOsHuTnJ3DFA/g
	spIpXOoda8zlTiPAoLJVqmCMvDIvMcIbq82vY7xTEzIbqIQxybOsmMUR3YgnQui4wtkWXE0Awmd
	+oOtyUhkL9tyaBC/9FpsOFH8X2qXtCX3Ll4cnQfDvErugkXqny+Z0H4ohJSC+qo6MmC7EfE6xor
	0rbQNeTYZnFHvF8cSHvZlB7lEqL7AxsABZRQpKoXrSdxWh63C54NkydyMKkH5NSSCmhJsQuSs67
	FGQHyokwnboHKSHusQHYQelX6PCplVPGnrIudpI6CqhxrQpv4TUnQDoo1EyjXaDUoIPBwZ
X-Received: by 2002:a17:902:cccd:b0:2a7:80bf:3131 with SMTP id d9443c01a7336-2ab5062d628mr94522245ad.58.1771264216721;
        Mon, 16 Feb 2026 09:50:16 -0800 (PST)
Received: from sean-All-Series.. (1-160-221-65.dynamic-ip.hinet.net. [1.160.221.65])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad1a9d5c58sm80759155ad.59.2026.02.16.09.50.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Feb 2026 09:50:16 -0800 (PST)
From: Sean Chang <seanwascoding@gmail.com>
To: nicolas.ferre@microchip.com,
	claudiu.beznea@tuxon.dev,
	trond.myklebust@hammerspace.com,
	anna@kernel.org
Cc: netdev@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sean Chang <seanwascoding@gmail.com>
Subject: [PATCH v2 0/2] Fix warnings for RISC-V builds
Date: Tue, 17 Feb 2026 01:49:48 +0800
Message-Id: <20260216174950.455244-1-seanwascoding@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series addresses several compiler warnings found when building the
kernel for RISC-V.

The first patch fixes unused variable warnings in the NFS client (including
nfs4proc and flexfilelayout) that occur in certain build configurations.

The second patch fixes a format-truncation warning in the MACB ethernet
driver by ensuring the snprintf output fits within the destination buffer.

v2:
- Split the original treewide patch into subsystem-specific commits.
- Added more detailed commit descriptions to satisfy checkpatch.

Sean Chang (2):
  nfs: fix unused variable warnings
  net: macb: fix format-truncation warning

 drivers/net/ethernet/cadence/macb_main.c  | 4 ++--
 fs/nfs/flexfilelayout/flexfilelayout.c    | 2 +-
 fs/nfs/flexfilelayout/flexfilelayoutdev.c | 3 ++-
 fs/nfs/nfs4proc.c                         | 2 +-
 4 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.34.1

