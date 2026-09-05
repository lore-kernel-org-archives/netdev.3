Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812513DD85C
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 10:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788602778; cv=none; b=QHr2Sbf7Xkozen83yqsZCHcHoMxzKrHJUsH2iEiMr9mapZBTntOogpcB0RpeMkziWrCtQ2d31bLhbmby2yUan5eVzIeYLe67ColqHAfCm2pyCe2p1u9E/zhxhS3gG7GnnFJ0Csa0wTJhKQTeab7A2CXCa1hjNxOd7cJqEjHAsW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788602778; c=relaxed/simple;
	bh=5H7SqX417qL+0SX5OskiLaFk2kFVaplSTtxV3hhdclg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kL/Zs9TJkn312iUu1WM4DkqHmZiLkM9Kgp6r+wsc7CT3fM8RDY6N7JTxXs6hRqZe0/LKGER/uVpfAD8DHXGKOEbXfFtTffMLiiDx1+Ee+I8OMvBw1WFNwrNsziCfDyy7NIqfu6R5QfGq4kYtIjCl94dw5hHuP9dIGJwDZUN4C48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E2bEQnvy; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E2bEQnvy"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48441a2ba14so1630241f8f.1
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 03:06:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788602775; x=1789207575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9hbxRI2kqgXW8szRb8+pxHMF73xMKN7kRApAerLpQSI=;
        b=E2bEQnvy2Bdf8cG+F0wAdSCSFD2vVJqTGNz7b1CFVHmyjOUh8ozKqZyd/++tltwfVd
         SmgC5Tx8OWKiYgqHcDabh57DUgdsdH3BNixXUjqsIu4Xqupe6IfkhadCksQbn8LIL+6k
         zYTgJCuETA8FEMW7X5Agn0YYNjolivv+gG7ktKa5NfAUGnXu8oJQ9f4NnvgNC6qqa2Bc
         742B4AeS3Vpp7L74agW464/Blol59afNuz0RAG9iBUCo63+L5iahlKaiulZnbCQdzXjy
         /s7uveomXDh/K3KDspFK9s09TNXdNt/idOM6tdTI3cu7YWzJty2/GS/Z8K55S1UDGFrC
         2n3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788602775; x=1789207575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9hbxRI2kqgXW8szRb8+pxHMF73xMKN7kRApAerLpQSI=;
        b=d1z5ewDm2GGF312oAg+88ITPFwi0qtcCUaxGlb49gJUccwa8rNBTxhDrMgZ3CdtSPi
         iVWLB5XALgjBC2NaR7Mv93e2vNbMqUqTGGk80iNp1Le4G6P74OVbPoZecpFKK4/kg3vI
         gmhS1Cvm7ObBMpodIpImNUX/ZyRyxUKVwq7Lmzp9dC0coK3DGTVpEGcFDDtlBJoDZekj
         Iy0hiw427Qdrsyv76/PL5eNxsJ13mrUbbUBCPUWcs5cdekYhUnPj75q09Al2OPX37r5g
         hMZj2+mwxcycfl9izu/z6aQKYxohq7/n2W8udP/wkYQLxEpXtekMF5izceMZV6ud3/nb
         pt6g==
X-Forwarded-Encrypted: i=1; AKwUvBwbEgB71u0mMmZ36eTXgAEL26WDbq6a1zX4nfGGYmAZ8fIprt3lCpgGA19PUOimyem83WPr+tU=@vger.kernel.org
X-Gm-Message-State: AFuF++nnn4GQOb3OMKEqZ8xuBNdv3vPJItOl7LDhPO4e5exzWrVMj/Ln
	6lUkVydKhfWu+qOtR/Qn/rO063ekWmwEPJoapO/hVIDPoyt8V7+5V9Q0ZGYBbCkt
X-Gm-Gg: AYBFou0M+7+7p/PKUqCsdYyYBaShB+F8rqNjSz0OsFcG6zoWdaKLoXWjNNGLGe+AC8S
	O+wNBMmLvYmFLlsWCZ1CXliSFzh6+PKs/Gt8iif6HfiIyvGAoervN86M+E0celjH6dUeHlyArZ2
	OdvR7AhEaKBV8p6CFway8NWicwegw5R4OKQi+ujP+BkgbNnIhUGAe9/2g0Fs4ESUsjSXZ/OgPh2
	82WreWSFUvzImosYZd5CVpbFzhTm+md1AbUq20rYlDLUNHKtTQzi0Uw7C/O/8OibmwpqlmkI6gN
	kGJ4LmbMaKcEAE7oRRaV6JNxx2Gi393tVfbsoWDCjZQMDTVm4yvWFraJBweXcvoaKMOie4JUQSn
	vDLSGZNgev+H2el2w7jka3C5OcG/DN48gSQTgH7Zs1bMHkAVxw9656H+8poIH4aU9sienkvq87R
	2f36oKJO1VO28euJ5hOAHOdJHmBMpK+1gH/Znwoqu1ATJ8qBES2hsXyklqyFsayGA3UwE/fcJ0J
	yGzYl35IcqG6e2XRfGnjzFhdymkcsCNl32b2fKwhQHzrUjn16H6NiQgGPjU8b7QwCMVIKu/AgDQ
	2jLmTo1zBH6WowM/a2H96jsyChVpDUBztlT4a2JdQUNjrN1dIzlAc+iVVWTcthuGN+X7
X-Received: by 2002:a05:6000:420f:b0:484:f26c:b9f3 with SMTP id ffacd0b85a97d-485872ebd4emr13211105f8f.28.1788602774606;
        Sat, 05 Sep 2026 03:06:14 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858dd90e1fsm9411657f8f.28.2026.09.05.03.06.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 03:06:14 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Jason Xing <kernelxing@tencent.com>,
	netdev@vger.kernel.org,
	Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH] MAINTAINERS: Update the so_txtime selftest path in SOCKET TIMESTAMPING
Date: Sat,  5 Sep 2026 12:06:08 +0200
Message-Id: <20260905100608.42539-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5c6baef3885c ("selftests: drv-net: convert so_txtime to
drv-net") moved the test to tools/testing/selftests/drivers/net/, but
the SOCKET TIMESTAMPING entry still lists the old path and
scripts/get_maintainer.pl --self-test=patterns reports it as matching
nothing.

Point the pattern at the new location.

Fixes: 5c6baef3885c ("selftests: drv-net: convert so_txtime to drv-net")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 903e73ec4611..2ba35f12c46e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -25332,8 +25332,8 @@ F:	Documentation/networking/timestamping.rst
 F:	include/linux/net_tstamp.h
 F:	include/uapi/linux/net_tstamp.h
 F:	tools/testing/selftests/bpf/*/net_timestamping*
+F:	tools/testing/selftests/drivers/net/so_txtime.*
 F:	tools/testing/selftests/net/*timestamp*
-F:	tools/testing/selftests/net/so_txtime.c
 
 SOEKRIS NET48XX LED SUPPORT
 M:	Chris Boot <bootc@bootc.net>
-- 
2.53.0

