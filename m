Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E664339866
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 05:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776490461; cv=none; b=Ygp0MKZojAEM2ocg4SN3u7XSI6v5fR/2r7LFlray0Lz/w4kW6iDRt1UgBxOobUckbWrrW/jpn0a2PpoBOyl2wRDpE7wyC9d/njfJPo47fftYklnStxicxBD+RU6vSEiOrUbCouvUw7JfxLo/tGbMYPAEtpdJPZj8SdkIvIRts1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776490461; c=relaxed/simple;
	bh=dxbxBb6TnRkHxYFAqTGmkEtNLztSZkN8uclWlfV6SBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lZoqPvgt0pwsncnTNLQoNCl0ExNyIYltSLDKJgK965QxyqeETTqgYNAitMFHTrqI1PPTTbzaYQ/kGE0AaDi9LUCD5g2jHX8RdctuKMw5+tr3fvA1A/EQSsSIerCIEMEGXnbyhhkaBntxBnhU9aIZKMp4GP7T1K6YGNYm/FLSp8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bYpyJiNb; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bYpyJiNb"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2b24fcc2b5dso9168275ad.1
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 22:34:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776490460; x=1777095260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/XN2z1dmL8Rxs7mT+ZQ0R3Y5Jc0sLY9a/dtkkBH9kE=;
        b=bYpyJiNbi5UsSERB67S4XXMcr500Aufzt0WkmxDZGXunSvK4Z3bSQmT8FONsDDNxEX
         Ug+74ZRKJqOPRAlqlRa5UmgTbt99oAv01g6xivrOB1kKVO0xA9GRo71+s9Na35C1+S6p
         R4ZNh+YOoNEES8E2bp/AbEMT0jnuwcpHyD2nDKAt6FJNtzdAr6YliPzIjCzl36jgl/5d
         7kwbZMUjX+pfo7Ry6ZBIt6HcS6TaZnKK4NOXnvSdY2xsrKk0vlYO2+LpLYjdbDoVWhBv
         LB2TP1D8IsXol16VyhaEulbAdjnVbxfXHtOn3W9cXRVjdVOkNFoZ4BA/GKb4ejuE/lAv
         rBzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776490460; x=1777095260;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/XN2z1dmL8Rxs7mT+ZQ0R3Y5Jc0sLY9a/dtkkBH9kE=;
        b=MgM3CoJXdtaHuq6s8oPny5+F9dXgTkVTRbfZXnrUQsCodBRrgaXqRfVg3VsLS3qOI9
         OEgGPM7fsx1Ji+OOSi0JxTaZEbSD6w0+/z6VV8IwoTvv1aJSt84k9ezmEvUQDnap6oU+
         eujXcgpd1WTzy2npbIamdkMegbhtsdBUqoWRV3GqJoTUgoFCfl5gs6btOHONHVhn+s7K
         lSwUWJcbyQQx8/1qMlNUW0CnJ5FMtdUv30PPioK/yJqtHC1PK1b4N++4i21QT4b+lo4b
         vnGaVBcQA7diCrAx/ey3RV17qez6E9kup+cDKDcft5TODRwqhawFGcxdtWvOhTGqxbsS
         zWkw==
X-Forwarded-Encrypted: i=1; AFNElJ8nug4UM0idsuSONJq6QcM2Mr5/DLYjioFtjuhQs7NBk9KnrNZ3IMbzoDikvSaowncm/mPLBy0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzlnG1CZL8QJhSFLL+UWRMk3Doko+0GOxVoBWxaG1iL++SMtlq4
	HiXAwmbi0ndGa0HwilijAuHQL5a7DQ5uHShU8IhpkfV2JtGtigaXG20oTCstaQ==
X-Gm-Gg: AeBDietShJgd7/6Y6Ds4i7ST9S4HQomisjHZpoxLizNqHYOLHjSHy8GoaTBmj2Dku+V
	WT4NsVFx9ruyh86cUNlTbwcBOSMfXu/N8iQni41wV6hr4cKxlk0kIUcyOTQrGqt8GZdtRGawWW9
	l0lUHrdez6toWTDPiUtvCUxDLnQSaROFBwZtv8A5nGhgOROvWSHmyTddT9OjTWrZ+XR9icSKvA/
	7SpQuEJLEHcfTaN6eI6OiTGpOIJnZ34FubNsFrptxMuQA2irKi/GjOJbD9QmsQYC3Cj0j7JYTVf
	HW2BCu6UiJGjDGKF/ZBiZzEUXD6QvGcJTzBLFfZycp17M0KIVZHB+TsCGHEpnakMyzNooz0nKLl
	nrqfJaQgUAYywxGfA95C0KxmkQtsIMRatrKSj7i6bgWayKxZTPw13fzOE/rdC3lFqLgbcR1mDPs
	Lv+SaAphHm5bUoaWQjRHoHdsDiyDymFHKaDzxw8dylfBaZk094ANJCjCVIPg==
X-Received: by 2002:a17:903:1b03:b0:2ae:ac0c:5a2a with SMTP id d9443c01a7336-2b5f9e7a9a0mr59106245ad.6.1776490459624;
        Fri, 17 Apr 2026 22:34:19 -0700 (PDT)
Received: from fedora ([61.74.238.173])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5fa9ff3bfsm46251885ad.7.2026.04.17.22.34.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 22:34:19 -0700 (PDT)
From: SeungJu Cheon <suunj1331@gmail.com>
To: luiz.dentz@gmail.com,
	marcel@holtmann.org
Cc: linux-bluetooth@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	linux-kernel-mentees@lists.linux.dev,
	SeungJu Cheon <suunj1331@gmail.com>
Subject: [PATCH 0/2] Bluetooth: ISO: Fix KCSAN data-races on iso_pi(sk)
Date: Sat, 18 Apr 2026 14:33:59 +0900
Message-ID: <20260418053401.128483-1-suunj1331@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Found while auditing iso_pi(sk) field accesses after a KCSAN report.
Patch 1/2 is the reported race on iso_pi(sk)->dst in iso_sock_connect();
patch 2/2 covers related races on other iso_pi(sk) fields accessed in
iso_connect_{bis,cis}() and iso_connect_ind() that were found by
inspection during the same audit.

SeungJu Cheon (2):
  Bluetooth: ISO: Fix data-race on dst in iso_sock_connect()
  Bluetooth: ISO: Fix data-race on iso_pi(sk) in socket and HCI event
    paths

 net/bluetooth/iso.c | 59 ++++++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 25 deletions(-)

-- 
2.52.0

