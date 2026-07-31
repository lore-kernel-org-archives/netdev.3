Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EE83F1AC4
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 12:25:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785500717; cv=none; b=sluDbkv9tfjJucX7ejz4H/R24pP+Ie4MjGLcNgy35iCgamrONkiXfT++kIaV5P+34Jfq+iTRW+V4zrsX19QSaB/uh6LJfgg344KmiyKUk6fvoufM8tquS01/MExTZLv2bxr8sV+t2QLWBnAFCa1SEqU+j9L3CkrZ1pYg2qBd6fc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785500717; c=relaxed/simple;
	bh=ArEtNCtRbbY4wjd3Veh0wlNsWZvV0k/OkdYuQXF9h4E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ce6/UdnXLzOgVKE+MFoqRPAnLn6FLgKYRQT1XbXLInbORRPJL38A8FgOiOjn89qO3R9VKKr0PPq6QeE2EY3sIBvITH+0wcTisJwcC72vJLOLnbp0lpYgbKy7paCvHnmaSmzbG4yZAaBRgGykSib/fIJtRYb4P9J1g0pumfVmoPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T4KMdbu3; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T4KMdbu3"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc97653887so9146735ad.1
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 05:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785500716; x=1786105516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PdTo+/TQyeNm3heeXf+U2n0OPP+o+fgY9AO2g2zYeiY=;
        b=T4KMdbu3SwlTwZcJwolpvfovMjhrte/zhpXDZBpt5aEAd9beYiZz3FJ2kFioTPOCMf
         Y3VqgceneVb1a2Cb92FlT+42wrpqGtUoJBLweOkciXdiozs1u+G+h1f/pQr1GPAqFnm7
         zhbvtofBGxdexaQVXF5chsn08c5qEdoCwFpt3Q3sZyZgHI4thELRZA5dzCPf9L9hiCnl
         eYl5UYuULos+0Mqss5MLMgubVJQODcdTvAv3U1FWcuaPQXZlmuo/yQCtmlpvVw9zAzpW
         OG9OIbv0ZtEhPoiJyba8zylER+N8vppg/5IzJfub7OejyRZBOV/PD/FbxXPQ50b7pVbH
         WdnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785500716; x=1786105516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PdTo+/TQyeNm3heeXf+U2n0OPP+o+fgY9AO2g2zYeiY=;
        b=FT+LmnAD/yZZu4HC9ZE81yVoZECV+ondfWmgf0mqOfeQlQB4A9T3QvsbfPnzyqqOtC
         GBOPAOKq6xJyQnmfQBYY7JTUh4Nl8f86mJZkqHR/RYhv0Bl8Qn6Vs/Y2hr2qa3yfYIUn
         OWzy3mcywmBi77nuy7c+O8EQ6kNJ3Vi+u9604diWbN0K2L3GJ7SE4qccctl71XNc50Yy
         Ug+SEnyJjbDfkg3xtWmVAv4lNytduCtIH+JUWwVFwQL6oOw/T4GjT4V4C5BMnFggJtx1
         RN2gahXaztl8BbmkcU5l7RZ+SAq0mroX41Wlmku/dcmWPf5RR/JSytxuSWLkRKWOjQEa
         qmDw==
X-Gm-Message-State: AOJu0Yxb/DVbpjsLMQG4I7zbo5t9T/wQ8jY8oCRd1FHswrE67v0rLf19
	rqJbEoh82+cSlytl2sqA/2RFboNaT+D3t+v7LWK2EvCXdoi2csVHHH3x
X-Gm-Gg: AR+sD136yjkkLaKJJDivP6gxeJmofYhpOeyK2f9rWcKZpxJpF4ru5ieX6ZnGLkFm3kL
	NmsY9NtedRu2aSvOirCM4RpOZ98wXbpI5xT3MWOOaAi/HLuCOdB8rh3w+Ok/kDbhmoaW/O7B13w
	Wnsi3dpaVEUhGzDTtKsz7djGXFj5h6yUycCJws6bamh6Nv2SmsSTg5pYI8Q8he7YeRrbFzRxk41
	gk6emLU0NKmeBU1qGSRWakR+I6hwNfYmRrWsgkaESfn3i1h5QHh/UEUgmRv/Xhk6s7L82lEeyZP
	BHJIujQ4v1ssGmERzntq1+82ueeQD5F/PgfdJjL9EM+o3AerWikuvUsONqI14Z9iL7KZKSsuHUa
	GbBXljBKowyLfmSsWEFk7qmSehcx34ENpEZrmmEupoelEm27Xx+2DBIapSTpE8n9uBHJJakgRiR
	2IjNN+/NXOfdohVlo1gW9IuSOQLAnj/m4UQtfCvPqdWlQkorWsmcjGrf7spab7ZQxgsxGsSs0OR
	2avjuZmcZWC/gswS+JXLZr9PWQVCEgl
X-Received: by 2002:a17:902:ce8e:b0:2c9:e69f:edce with SMTP id d9443c01a7336-2d046eef1d9mr17743515ad.44.1785500715580;
        Fri, 31 Jul 2026 05:25:15 -0700 (PDT)
Received: from oshada-HP-250-15-6-inch-G10-Notebook-PC ([124.43.23.194])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e0700e8sm5573050eec.24.2026.07.31.05.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2026 05:25:14 -0700 (PDT)
From: oshada imalka <developerimalka@gmail.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	oshada imalka <developerimalka@gmail.com>
Subject: [PATCH] net: eql.c: fix switch case indent
Date: Fri, 31 Jul 2026 17:55:01 +0530
Message-ID: <20260731122501.10591-1-developerimalka@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix ERROR: switch and case should be at the same indent

Signed-off-by: oshada imalka <developerimalka@gmail.com>
---
 drivers/net/eql.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/drivers/net/eql.c b/drivers/net/eql.c
index 06083b9841ba..5fbcb9a4a31b 100644
--- a/drivers/net/eql.c
+++ b/drivers/net/eql.c
@@ -281,20 +281,20 @@ static int eql_siocdevprivate(struct net_device *dev, struct ifreq *ifr,
 		return -EOPNOTSUPP;
 
 	switch (cmd) {
-		case EQL_ENSLAVE:
-			return eql_enslave(dev, data);
-		case EQL_EMANCIPATE:
-			return eql_emancipate(dev, data);
-		case EQL_GETSLAVECFG:
-			return eql_g_slave_cfg(dev, data);
-		case EQL_SETSLAVECFG:
-			return eql_s_slave_cfg(dev, data);
-		case EQL_GETMASTRCFG:
-			return eql_g_master_cfg(dev, data);
-		case EQL_SETMASTRCFG:
-			return eql_s_master_cfg(dev, data);
-		default:
-			return -EOPNOTSUPP;
+	case EQL_ENSLAVE:
+		return eql_enslave(dev, data);
+	case EQL_EMANCIPATE:
+		return eql_emancipate(dev, data);
+	case EQL_GETSLAVECFG:
+		return eql_g_slave_cfg(dev, data);
+	case EQL_SETSLAVECFG:
+		return eql_s_slave_cfg(dev, data);
+	case EQL_GETMASTRCFG:
+		return eql_g_master_cfg(dev, data);
+	case EQL_SETMASTRCFG:
+		return eql_s_master_cfg(dev, data);
+	default:
+		return -EOPNOTSUPP;
 	}
 }
 
-- 
2.53.0

