Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C84B32AADE
	for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 14:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777388272; cv=none; b=Zb4NvkcF8zO7m164MK6XjNOxO4FNDfGGs/k9u4ApSynO0qjFbvDwKBrOOyWkximBO/fyI/7zvP9iIbf4SKI5LsTCIx6lY3Ef7EVOiw4O0O/Xze3gYoOdMm8CF1SzKznZWrhS5BYWZX61hMFdNUS9Tz5pgqYbNP1RfZgnRIIQ0Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777388272; c=relaxed/simple;
	bh=vUmBN7ysT7cMsEZ/akVA56U/xX3hVHiiL7r5zeDPk2s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aa7IsnDVy7jRJGzWFJsbApjFT17fpZ5I3i7Dus9RpD2PJVKOT7xXFN3yTabmpWwemdA3cXVgNycT3ZuqflSQ9GH/8n2/1/kOYyXUEphcZ6ux0ze4tZop0UrqObIMouKhQscLt3FqsDl6nuIHbc7/lEJmVFOv/1S05w5TP89kRWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LxHi9u/j; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LxHi9u/j"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2b2503753efso118731085ad.0
        for <netdev@vger.kernel.org>; Tue, 28 Apr 2026 07:57:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777388270; x=1777993070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bFUk8datTypjawkPIlOc1SYezMUIN63Uxev+tDnIiuU=;
        b=LxHi9u/jjQybejxpq3qK09pvcP4BNVP6Yw05dcVN7u/a6nPnmfrGLZaHXOkWSLnkc7
         2MXZACX+1edZcrMTdNSxQhwpe0I2GJ4WFvvy60bOZ3y6V2tmXVcs1z+rSJr8DGnYa7ao
         e4jA5jsCOBZ9ZzAMFrTxn0OekyjaEwwVDmIAj5yTkpApwItYwMEn3LqWwtNggBZ9O5+G
         Bb7uxrRdAp2UHC0/MYuTVtn9GxvI+NGKwTedhTmo2qqxmrNlonRAoaVlXioDzwfEZH3o
         h7+FUfKFnH3Y6eReBXlf6IMia0QH23zDhFMxu/dRNOe0e8hbL2vsLLBVO2x4FfGtUISx
         L2FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777388270; x=1777993070;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFUk8datTypjawkPIlOc1SYezMUIN63Uxev+tDnIiuU=;
        b=L3lgjbBbalUxxTVcGXTStXWOzPKWQOVPME10/Yezm8rJjLMH3PZN22+y84HFkOf3gG
         TrqJvu5ZjXRvI5hzv6SOWTH2JnNLCs1/tH33BhAEEmmuX8/Qx7CTk8tTYoz0f1rqqkq7
         ZUvNbTm5SNfJnDExcw0IgJzsvM52GFUTDyNanvksvkaHojtdrjLQHDbFHmBCp9Yz8pWB
         q9jYDSAErltA3mbVlJDvps/7gr7js3eHwtCQz2C8VYiuE0ZhKd9TiA/lJM/1MwehecjN
         EPHFOoJp/l623VCRmiRwXQS2KoXbf4klybUJrMw0wqAwJJ3USdYC/X141HexO2kZdeBc
         E/IQ==
X-Gm-Message-State: AOJu0Yy2ODoFZAiNSvCaxI0hNwb/ZENfOS6plbZ/5SaqgCIgT88ItoFj
	u6hQ6tLus71mQNVonpYOzz4lp+8KSS0FIVxrgyi+bvcBeGiiIpB3lHlE
X-Gm-Gg: AeBDieuoA4w7V3nGU7AHR/adEnXxz6e+3Ugt9VysfoMnX487pV1kVs9PAq1jcY92o50
	agvekaNqUKFSuNQYT+GBpv1QeNEPW9MulypUrEL7PptLXJxJu49erajH1iPwbmz6pz3YbBo571p
	tHIupzTPM8r2xDARFBWYnRSdCVHfr1WDR781t/3ILJJqeUmI/paYAiIJr2OCJ5J2IcnndCK7CYP
	vieOPA3A3UVxa4SuQzbA1K45bU2DvMhG/iSAC9z4FvH+o4j4J4afMyZASOYRQNZtw3KxUrmJCkK
	vymbj8lzeMAMxgbxYb97ugb972+igXairLBbSfhnswB6AhLr+MSMCHOfV5ujOqTAIMRYnmklFiG
	YBbUX8BDFau4jr1n65TFHSiq0HuqRVSy8FkVS6KZgBnNxT64FJXVMpftfxt//yPp4NUwCJ8xG/t
	6GfDpxMQsJfffD4TRadGUTLmKaVv5DMkOv2jRhnM+C
X-Received: by 2002:a17:902:da81:b0:2b0:62dd:3a80 with SMTP id d9443c01a7336-2b97c4396e6mr39454135ad.17.1777388270383;
        Tue, 28 Apr 2026 07:57:50 -0700 (PDT)
Received: from lmao.. ([2405:201:2c:5868:93f1:2c21:e056:f551])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b97aa7b858sm28796665ad.8.2026.04.28.07.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 07:57:50 -0700 (PDT)
From: Manas <ghandatmanas@gmail.com>
To: jhs@mojatatu.com,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	rakshitawasthi17@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manas <ghandatmanas@gmail.com>
Subject: [PATCH] net/sched: sch_dualpi2: Add missing skb check
Date: Tue, 28 Apr 2026 20:27:30 +0530
Message-ID: <20260428145730.26375-1-ghandatmanas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A packed is dequeued using the function `dequeue_packet()` but there is
no check to see if a packet is dequeued. The assignment is always
considered as true resulting in null-ptr-deref

Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
Reported-by: Manas <ghandatmanas@gmail.com>
Reported-by: Rakshit Awasthi <rakshitawasthi17@gmail.com>
Signed-off-by: Manas <ghandatmanas@gmail.com>
---
 net/sched/sch_dualpi2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 241e6a46bd00..e360bf16d617 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -588,7 +588,7 @@ static struct sk_buff *dualpi2_qdisc_dequeue(struct Qdisc *sch)
 
 	now = ktime_get_ns();
 
-	while ((skb = dequeue_packet(sch, q, &credit_change, now))) {
+	while ((skb = dequeue_packet(sch, q, &credit_change, now)) && skb) {
 		if (!q->drop_early && must_drop(sch, q, skb)) {
 			drop_and_retry(q, skb, sch, QDISC_DROP_CONGESTED);
 			continue;
-- 
2.43.0

