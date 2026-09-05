Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1354545FFA6
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 10:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788605198; cv=none; b=oinGipRGSpIzw+jCLLsm8TGJHBwQUajk4OqVLxm+IjX0H6I0wl/by/G3zUclz/EtFWyEJJwfR4U5DEH6pvKAmvyGSEXbwcJIk7PS1fQDB3NWDs73qmhzNDDVDfGxql6GoWpCWeVY2gI1ypIim85v62TQmnB/fkKJvG1CxrX2qZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788605198; c=relaxed/simple;
	bh=FgEGMIHyi34p6yz3OD6tTYDCoTrdvOj/pRpra1LVBOU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bmxC1t2FM8mrXg2FlMizpt0mg0gDeOD9/rjlqjywu01a/6Ekz20qukvpVoZ64RC4MXVOwUtoZa+mXi9DVei9NEet1cfqsqbNs13ffajBVnYkyhCVNYQqj/OI/xTOJruZoworXfTxj7jhIbZHq3THSDYNLcK13u6w6L3e63Yc1tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qGgIhS8j; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qGgIhS8j"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-49d036e0e99so2385875e9.1
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 03:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788605190; x=1789209990; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=uEpc1uNoyEmkilcb6oip3iNpVvRjfV4LqWJo0sBYBR0=;
        b=qGgIhS8jLIkJ9yTY/1nVap7GRgb1j4yVxSFOkVpTOobK9vByQXaiYcNNk2z+i8dCIb
         BwFxznCqr0+JznKYPnalper+d6hp4Syhj0e8qiOKkSp9iN18epnAlaG5ogtU5gqxXIIi
         PEHCZB5djIh2WhrivCuwaMb9v6j/5Cup7bM5XmEdgp6xAsAtfORAvVVcxtEEtqjxbqSJ
         60uJQlKZ8TsKnWN+K+yDJrbT+jNKRKsQc57DZpLa3WQm8lPXvc1UWArLvMgPWjZDnVYo
         VbeQUQYHIOQNeQsqX1EOWMfSFYs41ozpyXAaxftd1WmlmjJFpYQCmM+2q03nQJfuM52v
         3Jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788605190; x=1789209990;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uEpc1uNoyEmkilcb6oip3iNpVvRjfV4LqWJo0sBYBR0=;
        b=KnANjxcTTEPPk/1m2/afFCHpq7UYgVzjdEV0R3bPLXCOk4NI6CZmbWL6tUux2Losr3
         o7TeTXbEFiyBdvEPz/bMDfSzGGCeEJtjLcDfweKhN/sumw7WjVm2vXEVBAa+YPR9f8Pr
         Fczqt1lLy6dlR2fqiFwkqEKM/22NxgMwBqHOtL53YJl9Lq3dMzF23Q9v3JIakBumWQWf
         6zYs9OEZOv1EDGwNzDvgIqUy5hqmNIEowcUFWSoq5ymuL5XAv3HSolOTjfMWuNgWG9Np
         3A4vNIHoEWjKSW+oTU2FPbt+rcO0/4+LkpPTUcANorQBZCmCX1GAtt4TSR7s4P77XYJI
         FwTQ==
X-Forwarded-Encrypted: i=1; AKwUvBxLNdnW7A6waa/p/eDJraN7hhK7mgMno0DdqPKAmlDQv6QXXMfCF2lCM9ICVVAyfzY0kaGb/A4=@vger.kernel.org
X-Gm-Message-State: AFuF++lyPtPKsdQgEDoOc2Q8x2C0yJU9tsdJSSOuhdlRLj3FyBSAZ1Mu
	jsP+snmdDs8/hurV+fO3sKezzuYJSxXTF3x0osnKVCU6Xrw9Azv6pnuH
X-Gm-Gg: AYBFou17ys4SzEqFl2r250IakokivV4MTrrEch5317bGHSmpGsFulXAQXl1V54QGrMh
	xlM/8VVkmyg1OsN8bgMC5XwcgaokSCD235XBgYPQ69lnpK318WTpwu51lDUQPLdarhWtnCIyrw0
	TwexPk1eFMUtOD1b6PX1fQcHS4MI8cRzOJrxHLzF0hQRb/OO1x9yvT3iqcYDgc9g7LJl15JyrWz
	RoPtWx7ddhgrxR1stz2Lvi/oUW1yUF/w6GEbZymkSI8QIfPx+TAHtj0S3sEPYEXLGV2SPKlwErf
	ghWFyhRIIvcvZeJ8sMsUgC69DZe3Kby2xnHPgBT8xv5EdkOHv1/SmsYeJ3S+fW5PGKVx4R2Mo9s
	17WgCk2AUEt/p05D6ozkC715mTebczd0qJG0XMu2+eJlH15axZhMxGafPGoq/yzWgl1dCUTrfuj
	hwRiiRu5Mpbo0aFBZFaVSlmciag1uFwf6aj9pC1SPv6da7HdHoml7U5rJOohAErnYAbyZbRUpVS
	iKGNUaV5SF+LXFZkmo1EcQEa9koDAihRqa4n1CE3bB3rbfG3c/OzwJHjEzcH/FEZdhNJn5k6Jd2
	7caBI+Pr9E08H4LG2csB/yC1797NRToV1IixZUJZQ8egOGXgjfEhyrMxU8NMpAIurG4=
X-Received: by 2002:a05:600c:a0b:b0:49c:cee2:1697 with SMTP id 5b1f17b1804b1-49cf8262133mr122050915e9.16.1788605189720;
        Sat, 05 Sep 2026 03:46:29 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a4eb-3001-c06d-af27-9fa2-ea53.310.pool.telefonica.de. [2a02:3100:a4eb:3001:c06d:af27:9fa2:ea53])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee80eda4sm219626695e9.15.2026.09.05.03.46.28
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 05 Sep 2026 03:46:29 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	netdev@vger.kernel.org,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH ipsec-next] docs: xfrm: Fix the two aevent sysctl paths
Date: Sat,  5 Sep 2026 12:46:25 +0200
Message-Id: <20260905104625.43722-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The sysctls are registered as xfrm_aevent_etime and xfrm_aevent_rseqth
under net.core (net/xfrm/xfrm_sysctl.c). The document calls them
sysctl_xfrm_aevent_etime and sysctl_xfrm_aevent_rseqth; those names
appear nowhere in the code but in a comment in net/xfrm/xfrm_user.c and
were never the proc file names.

Use the proc file names.

Fixes: b8a99520f78e ("[XFRM]: Add documentation for async events.")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 Documentation/networking/xfrm/xfrm_sync.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/networking/xfrm/xfrm_sync.rst b/Documentation/networking/xfrm/xfrm_sync.rst
index dfc2ec0df380..27e3d151b11e 100644
--- a/Documentation/networking/xfrm/xfrm_sync.rst
+++ b/Documentation/networking/xfrm/xfrm_sync.rst
@@ -120,12 +120,12 @@ in case they are not specified.
 
 the two sysctls/proc entries are:
 
-a) /proc/sys/net/core/sysctl_xfrm_aevent_etime
+a) /proc/sys/net/core/xfrm_aevent_etime
 
    Used to provide default values for the XFRMA_ETIMER_THRESH in incremental
    units of time of 100ms. The default is 10 (1 second)
 
-b) /proc/sys/net/core/sysctl_xfrm_aevent_rseqth
+b) /proc/sys/net/core/xfrm_aevent_rseqth
 
    Used to provide default values for XFRMA_REPLAY_THRESH parameter
    in incremental packet count. The default is two packets.
-- 
2.53.0

