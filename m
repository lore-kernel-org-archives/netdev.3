Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8374B380FE0
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 09:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785577350; cv=none; b=UVW7rcMOz9P+roAjmb+tksTa0esHdQcYtZx/MM/qZV2X0bWP2Oh0BfrA/RLRGJRCVTv/s4MeyoYdMeBDYx+dbyb7OuACf3pv0iKviWHz5HKLfd0asrK3C1DYO/YQMARTVbrC0MNWcAQ51FxVK8S3XqDSCSbFHRqGJNUoF3wVgj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785577350; c=relaxed/simple;
	bh=SAw0Kb+9oqAN1gzi6bUEMvt+RoU0VdIvRLyfU7ZQZas=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bonxJ2l50COofRI79ldlzfiRpfw9Nv+9oYaHtMTIh0VPRW0tSkqkUr984bDI3F/iEeL8S+BGdlWVA3rLV9Bv5Wx7YoxcGSEIe6zS6v3C8FNcoXRNSM6hBSXqot7yw/bxE0Bto9nG/0NmAV51Anrakk9d0YSVhtKqkw77PjTIAqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr; spf=none smtp.mailfrom=isslab.korea.ac.kr; dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b=rYutlYtC; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=isslab.korea.ac.kr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=isslab-korea-ac-kr.20251104.gappssmtp.com header.i=@isslab-korea-ac-kr.20251104.gappssmtp.com header.b="rYutlYtC"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cf6d65d8a7so24521365ad.0
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 02:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isslab-korea-ac-kr.20251104.gappssmtp.com; s=20251104; t=1785577348; x=1786182148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nYPNkkV+81Yt6KAtVQL4iqIfkVKBR+qmznODVw2SiBE=;
        b=rYutlYtC2ruhHNV6BQVR1DUVQQHLgoAa5v2wgWDvQKMG4J2LfLBL9kFgS5IVvoonru
         8k+iJ3RZ/ccNJQiiMphwJPdMnjfupQp3PnpAui9EmID3La7xcMe0kCYqd0v20Tlwxey4
         0KUNxKLptWABR93v1XJomADTi7jO/HAAh0Qgwu8V+6jTnUanKeYr+xiutO6ORW9rx4wO
         lq4TPzPB2l6xjF5eh8cV/e5BMH47uTU8tFp/BhqvvWZQ8SrMvDA3aiiZAt+Mh5Whh0Vr
         uzkOW01nXfCRvQa+fP0oFkXwIAdDZ6fAXVkiC8n8JYbX/luVqFtagI4/s8D/SAf7cbSV
         r+Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785577348; x=1786182148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nYPNkkV+81Yt6KAtVQL4iqIfkVKBR+qmznODVw2SiBE=;
        b=LgsuiPpiADAbdXRv3kPpyHahlzE9Ryv1LeGmVzCAa20UPnx+PvdotVU7MlTTXyuJE/
         S5i8QJDLU+vPqtPBmI480qpzH5mbALZoTxuMIWGXSBlUeaZjzK55ydef/U0Y6f33SKBg
         vZfxz69I7F5I7v46ndX+esaJZoNOw8o5yISUA2PBGPnfmKNWvXDpHQcd9LrONubQSe0g
         RhA44M3d4Yp7rkLxuAD06cuOWcvNCHa4XqV+XXoJQR3Ok87TzOL0SNA+i78i8WetLq1X
         fu9W11z+2ueWYDz2kqi9+95FaDexoGBYRVmPi2gziUxPci4oSuN4fXp16diNRozTFHrO
         RRbw==
X-Forwarded-Encrypted: i=1; AHgh+RpX+gxQoQwRgrQ8Wq8Kt52qknfeobkCOvKi9L8Ge7KSXJUF+4cFKqlHFL5f9LrcutFLMtTJAnU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXon6h8FYOrOR+RvtQOi36KWeTkywm7FddF/Vx2YlLPCPr+vwv
	McTg+Ym86hZAQhIftn6SeQe0dWOLmRqqeZ4I4/lSPRBWaxnuZu5KgH5XnGYDIc8altI=
X-Gm-Gg: AR+sD138E70fDasaYv6HMZBKLdIsc9KqXH6z8OAREUL/ovmj8txcf8WVeu1oYKt1VmP
	vKDA1vpBgpqMn3AoQnALADVsFwXHjxCoRN49pbwCOp8SBlTYCim+heWM9WncTW6rVl1JKWaru3D
	BUylyT6J1l3qcwxrrujqkqSk8Exx0gjjQES8LrTWmbFn8x4crx6nP7aBk1eEzk5XpnbqUUDpn6Q
	5G7VENKW0d/ztsVtS4ywNN59HciFYrlk415OXzz2B+oOJlpKXgxHn540V+jZdNtBuOP0IbJGUrB
	IX4dd2gG7DCB/KtdebFBvxuAtNqVqymsqhJH0yf9FfqsYZtiIFj7i2e3f3XqLaxfVr2BvFKo87C
	8CqLO54EDuqrXYYkjB1Od69czaMVeQAHG/mga6+e2acbOdCpGOX7LtdMa/EmIoGLPkyrAi5cWFK
	uVRErEjRFoJh+Kv3cyWdeN7MGOKbTzOJeHCBBcIegoWmgTi4tmTi3AqOZj+mRUzLDvMoQTRhwFx
	mL68uqgdGs=
X-Received: by 2002:a17:902:d2cf:b0:2ca:a03a:29b2 with SMTP id d9443c01a7336-2d0521a5657mr32621275ad.8.1785577347676;
        Sat, 01 Aug 2026 02:42:27 -0700 (PDT)
Received: from localhost.localdomain ([2406:5900:1044:110c:c329:7b28:fe02:5dc8])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d04b0eb486sm16006465ad.53.2026.08.01.02.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 02:42:27 -0700 (PDT)
From: Yehyeong Lee <yhlee@isslab.korea.ac.kr>
To: alibuda@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	sidraya@linux.ibm.com,
	wenjia@linux.ibm.com,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com
Cc: horms@kernel.org,
	mjambigi@linux.ibm.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	guangguan.wang@linux.alibaba.com,
	kees@kernel.org,
	gustavoars@kernel.org,
	netdev@vger.kernel.org,
	linux-rdma@vger.kernel.org,
	linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yehyeong Lee <yhlee@isslab.korea.ac.kr>
Subject: [PATCH net v5 0/3] net/smc: fix out-of-bounds and use-after-free in SMC-Rv2 LLC processing
Date: Sat,  1 Aug 2026 18:42:05 +0900
Message-ID: <20260801094208.1937951-1-yhlee@isslab.korea.ac.kr>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Split of the single v3 patch, in the order Jakub asked for:

  1/3 frees the LLC queue entry in smc_llc_srv_add_link() only after the
      last use of the pointer into it.
  2/3 bounds the peer-declared rkey counts in smc_llc_save_add_link_rkeys()
      and smc_llc_rmt_delete_rkey() by the buffer they read from.
  3/3 copies an oversized SMC-Rv2 LLC message into the queue entry and
      declares the rkeys that fit inline, so both consumers stop
      reconstructing the layout themselves.

1/3 and 2/3 are tagged for stable.  3/3 is not: it does not fix a crash on
its own, and it changes a structure layout and a static function signature.

v5 touches 2/3 only, and only its comment and changelog: they gave
the wrong reason for skipping the extension.  No functional change.


---
v4: https://lore.kernel.org/all/20260731070509.1818665-1-yhlee@isslab.korea.ac.kr/
v3: https://lore.kernel.org/all/20260727095833.1079618-1-yhlee@isslab.korea.ac.kr/

Yehyeong Lee (3):
  net/smc: fix use-after-free of the LLC qentry in
    smc_llc_srv_add_link()
  net/smc: bound the peer rkey counts in SMC-Rv2 LLC messages
  net/smc: carry oversized SMC-Rv2 LLC messages in the queue entry

 net/smc/smc_llc.c | 101 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 76 insertions(+), 25 deletions(-)

-- 
2.43.0

