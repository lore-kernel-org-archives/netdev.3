Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BBF3C3C1C
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 05:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787896136; cv=pass; b=hXQev6Gg4ZkNc80tp+hTUfOb1KjN8dsCgQF9hVGlxVVtq6+6fFlg3pQ5bTK6FEJAs2iTJHG9AacPqzmKHr08pWrP7gufB9/aPK6o13Ct/mPPZIBrsNe6eczHLh+Pyy/GzcYPToD1HUIcVRaNCxzjHinm61aRk9zqn6ajTaFsjgY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787896136; c=relaxed/simple;
	bh=QZcZIYCT+Re7sKM4Gb3CgS7BkE6WBbGG4LvAQn5P0Gc=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=YDuzo7FKOK4g+m57YdzOv59QYlF3iujZVj1z1oaF5eJIxBV75f51WadFFdTSc61ZLztF96gtoBfGZwF7NVn48t8/1+Z11Nu6sXCxUME4pNkaBMCgwlt7Kt5JUkD1V6HrXBYD22VsjTDdDcUdgC28pJX2URf2f4EExc9KSf6Ay8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu; spf=pass smtp.mailfrom=berkeley.edu; dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b=B5GAk/Ag; arc=pass smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=berkeley.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=berkeley.edu header.i=@berkeley.edu header.b="B5GAk/Ag"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38f620399a0so741768a91.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 22:48:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787896134; cv=none;
        d=google.com; s=arc-20260327;
        b=PjOY8+bj1wcEURh7TIJ/VanZuEc/le3g5C/DHWWMdTNbtSfXGtej05kKESsoJTeQAt
         dV1mtCEEaNfnq6981UZ0lRtm8hSzxe4OfVIv1QUd1FFJX2aLSa2ltsWsUqeDL3DZ1lwL
         7H7fwEHB0QSdpxugUbJXGGTn28WeFWdCbNoKXMfWMli0S3cKp5U6dj6X5jGfF2HInTf9
         sAKY1DQPMj7Z1RMFPo1PRsai4EKvrcBjm0HG/PHiynbVZ9Ggp0DMsgTQGPCyQZdnmpc8
         AqTgyEiiD875tGp9fOybMj2b/g5a8fnhsAbnhv6UALpD86MeSRdIfGcPWqwEiffDYB+1
         N1Qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=XGiqvAKih07txWqwNMygIXFEXpvBV7V29xEbvP7fW4M=;
        fh=6o/5VGFqUEKwQf6ynT7oujp4XbihyEDAs/7qoglZFKs=;
        b=NVTGIP4GNEj0GXU83O0w+BEl4SkURR/OxL9OBzq9e2tSOI+DXeVA6mdWjNQJKdyppQ
         uZdeGZQuk0BhvQfnB+Qnr+6BCC2HCUcDmvUEsUvezENMqWH4/Bn2FK2pzy8eycHe+Ldc
         zef3WA9exaoF3bXbo6qvR5yJ2+0UgKGE/ICs3xdhT3+kjQww5auVJO00Zjiaptt86hYn
         znMyS5uXWKpaYHrFXdjHmnlHO0SvjiBHSt+JQtfiA4mKlTO+24r5/t5STbEPDnO8r1Gx
         4GYSpV9KI/O2kt5S/C5ziXjtyTkf6v2u1aW2DtxFGeQ++Px8le7BswR0JGmSV6QyM+Nb
         lnTA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=berkeley.edu; s=google; t=1787896134; x=1788500934; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XGiqvAKih07txWqwNMygIXFEXpvBV7V29xEbvP7fW4M=;
        b=B5GAk/AgOD0afKqNPo5cOtmJZV9fnElf2Xj1vYu/c5YYjmE8QqyKDd3j1mRJSHFcYA
         tncqfyrzy9NElyTwYzQUMk6BGccXT4jHtAUUtnL63GKAsDdLDuPvfSJtzPXcvREWEYIr
         uFa8BHTA2rvuk1A/nZ16uf76bOAQ3Up33eeZg53INi4ibcxK8oCGNZYa5/EkN9Z4uHZO
         zdWpF7S7v4NZSirTWtRfMdUU6hQCGN7YHZV1G9kJoN7JCW82NkdzLMgxHWVRtihe02Po
         gJSh/ey6ocZIxcdN/oE3x2zOA3ABb5FF/o0Y3Zr+9tOY/7FjDqP9bwVNNXRvd6xP3pXB
         x3dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787896134; x=1788500934;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=XGiqvAKih07txWqwNMygIXFEXpvBV7V29xEbvP7fW4M=;
        b=PrTVzro/Q2zoZI6EKgO1ESGNIics2hDEuHkngKDRs7Iu+zCL+RiidALnA6+NBvnss7
         Byob2EnBmRdsxpy/25lOP7lS87dVFSAQEL2XObHh3XYDD1WAFAQiHPnhvByX9KtwPICV
         DM2q+Cb/SbOh9rbFnlFMFjC3kOU3iWck92Z0uMyMUvwxcVdETQF0C2FdD63KoVIW0545
         vcnZGIIy+4lNgs1HHv1LzWl/IMCcjOfVtiI1iRlDElf56ZZvfOphF69PUFqhCFD5+JZZ
         XErG0pCcHf8hOCLtPsg/qtjuwR4IuCVmSM+bXVLfEpdFufHPojYOE09PJ/tBjofYVnSg
         CUaQ==
X-Forwarded-Encrypted: i=1; AHgh+Rpol9ErDsn86nQ36ISaxF2qQo3WxQqFXF6xqHKlNbLHfQ7MOaX2QWncanQCs8ofWlE19HZwUv8=@vger.kernel.org
X-Gm-Message-State: AFuF++mDbuDsdnpSGJgWdXlMTKnmeXepbTCfcxnbzqlO1yqlYetkDL75
	qUcuSvxeYboRXFohefh7tzgP/pab2AXuj1GQghbDQYnSlXk9sSX1LRET5VyM7MFTQl6kKsUcN2D
	iG4ESrt8QT5ZB87N2DiY4gGobGzzExmGUsDAig1hwWL/C9pFe3snf5Q==
X-Gm-Gg: AR+sD132I4OVtECnuE//0YJLv8IwmJP/lsOhmgGYLbLrkeMMpb8qlg6Mi9XsDc7fqF1
	oBoDuq4zzApgzMvPucV732zdt04qPWCAHFoClIUCvCLLCTRCphKHHFNhJtmsm0W0rdA5NXhoMeT
	vxKCdt59n0QbzSDoDJE62CXcB38t97F8JFpOS5CqNLg1Dzdhgtgj702LobLX7LRHw00qrKsjoGs
	sFud16ftGSoN/d5FWEQqd/pc3GIi00CHnLG3d11X3Q/XSEB7qo9c2ncbwrOaDlSZ27TySycG10k
	dwmaLZA7tuNtHhplRC6M6u0MmdSU7p0PVhK60HFu4bqiXcR1XP9zYzHRF8efS6SdfmvdlU7SEri
	3dmk4GRfh09mVkYcdKTIf9XEPGI3s/OBjfA==
X-Received: by 2002:a17:90b:1d04:b0:38e:4cb:51f with SMTP id
 98e67ed59e1d1-396d0f75f2fmr9434380a91.11.1787896132569; Thu, 27 Aug 2026
 22:48:52 -0700 (PDT)
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 05:48:52 +0000
Received: from 474444807712 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 28 Aug 2026 05:48:52 +0000
From: Farhad Alemi <farhad.alemi@berkeley.edu>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 28 Aug 2026 05:48:52 +0000
X-Gm-Features: AcwNN1VegKfxy6tXl_M334rwOdANRXO1AtXiatObd5RyLQjD6NlT09EXgv8WeTo
Message-ID: <CA+0ovChS18paCd=ZE-7j_M-JtFF-N6+A75deKUqJ0Yy7ux=h2Q@mail.gmail.com>
Subject: [BUG] WARNING in lowpan_compress_addr_64
To: Alexander Aring <alex.aring@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: falemi@asu.edu, linux-bluetooth@vger.kernel.org, 
	linux-wpan@vger.kernel.org, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

As part of the kernel research at ASU's SEFCOM
lab, we hit the crash below. Crash reports can be found here:

  https://github.com/farhad-alemi/public_bug_reports/tree/main/182-warning-in-lowpan-compress-addr-64/

  WARNING: net/6lowpan/iphc.c:937 at
lowpan_iphc_compress_802154_lladdr net/6lowpan/iphc.c:937 [inline],
CPU#0: syz.9.76/13660
  WARNING: net/6lowpan/iphc.c:937 at
lowpan_compress_addr_64+0x4be/0x9c0 net/6lowpan/iphc.c:952, CPU#0:
syz.9.76/13660
  RIP: 0010:lowpan_compress_addr_64+0x4be/0x9c0 net/6lowpan/iphc.c:952
  Call Trace:
   lowpan_compress_addr_64+0x4be/0x9c0 net/6lowpan/iphc.c:952
   lowpan_header_compress+0xeef/0x1ef0 net/6lowpan/iphc.c:1242
   lowpan_header net/ieee802154/6lowpan/tx.c:234 [inline]
   lowpan_xmit+0x4c6/0x1420 net/ieee802154/6lowpan/tx.c:282
   dev_hard_start_xmit+0x23b/0x620 net/core/dev.c:3904
   __dev_queue_xmit+0x11e7/0x3250 net/core/dev.c:4870
   packet_snd net/packet/af_packet.c:3082 [inline]
   packet_sendmsg+0x3d9b/0x5150 net/packet/af_packet.c:3114
  Kernel panic - not syncing: kernel: panic_on_warn set ...

Our reproducer.c is available upon request.

Happy to test a patch if that would help.

Regards,
