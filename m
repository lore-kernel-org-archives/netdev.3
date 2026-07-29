Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113D432F75B
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 03:41:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785296515; cv=none; b=HsKSw/rSleK2Ht9TucjgVEVoG2u28pCEnzWiIf1PEEDKZCQuxFZJfPqF2sz1OqzW9GBZDTIvRiyWsDfdslcvSimTdOiMHxUwuBuvO+UiCiS6YU3J0jphg1UytBgy2IO+fa31LkR6XZsj/Qdlnj+1MUdSRuXlFQ358XHHarbNGsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785296515; c=relaxed/simple;
	bh=UFgwWFaUDHNfS7pe9YQMo1osWM7ZIU7JHCt0yYbjg5s=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Xo4SLUf3WVX1fS0VbuchCLykfGxOJG1Z2wDqRC0bHI8iI9Q0d57YfW6rCF7fNjRkL8isKQZ1vbMcRzKxMO9a7EMHjgUj83r2AtJf4p1Y+05n08yVxfOBovP+oUJ8QKneASGJokQ3NECwt1G74L3TqokhrpSbUjIWY1z4/R1yThw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sOB6dlpY; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOB6dlpY"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-c9fe3c9bd5fso1111678a12.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 20:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785296513; x=1785901313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3ystWRSu0XGzWLVNCp/qZNWLqhKRo+gG6ngoi7HTHAw=;
        b=sOB6dlpYxepWznoCYsY0Fw5FVENKSKH06NfBwvPC2TSZ70IVVk4t3v2seG4eMfIsoa
         G0jkOyLe0fpMxnVOOuQOzEIIS39nvfUDJC3pYx/JlZIM5HKslKkOe3iuyoq8WW5tyWaw
         vio0ItD/BPXFJ8tLmFUcJ8BXVYDxJrPmBqXgpqOnPRwiH/GDFHmdK8WpXueKXahXCHxX
         byXovm6jyarcGaU/ELs3r0hHZEskjGMWMozmnkKOHyduoT8z5NZZns1rk+BvO2cvIvNH
         WbA5eTo4UQCX6J2mJeJSvpUN+VxoKSFOqp3WyPKXFCrV5ge/9Szgy/vbbYYVLyPbqXpl
         IrYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785296513; x=1785901313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=3ystWRSu0XGzWLVNCp/qZNWLqhKRo+gG6ngoi7HTHAw=;
        b=GHCTPn8ySCIjLBjjAqF6OMtA7tBBSosIGTu+FJIlPrPyaQNctsmEL8FBhRlzug6Zib
         9W0CgD1A+hG1yYEXnphqepGWPzOKmyQSMdMwjQFp9f71O253gyOjvGAQ9rMmMJox09OY
         wsUOo5V/D+1fgX+EbaHmm0DMgfS5AFC0t7d+MuJy3NZxzxbaniwUQqVCUGRhH2kaq42o
         2pU9ejZNGP4NHt5Q6RqOL/TPOCrOvkvN3nzB9UKGATN9YsFcQphDi0K8kA2JgkiOoeS2
         nYvEuHZVuOy30CBH7u8ikNyMdIeW6ryzJjVK3wZLHzt4gdqSBIip2GSRAICob80jdn1I
         AGtA==
X-Forwarded-Encrypted: i=1; AHgh+Rr5lqlZaGXzPuKg43oltrFENPF/h79j+8GkZhWp+cQYN/fTpQ7hmf+XwUqP/C+nsP3psHf+Pec=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6BTfklkXEPS07A9PCRR358ktagcJjvNs9X8vt35FdhpN5asrE
	kAwAL159Cx1XnUhnf3TjzmFQfNaACgpP0yYcbV8GOL+EbJYUsUM6EmQ=
X-Gm-Gg: AR+sD12r6W+g7iT1V4lEX3oPCGnxBsD3t+h9sGdf3YE7APQmKBxRNAjHoT7+fyJ3eGG
	6aqhuLJKDn18r4RZ+vmcCBvsozFPUefHXxIcgR4Jx3xGEAeIhSrDu7ibNlGCRwYYGOYiZrdZKv8
	Km2iwc5BveTIIxE7HpG0CgPDURahkEySVeV7ic258xffAUDyIrrIPQAp69i82n7teFdJTwLfKfA
	hSIquNMj1U4MsIL/N1TKr2TAvtRuUTlf1mlnfwbvL+qqSKxV7Uj399eSYX+UEjzeT+bTEyoT6N5
	pHT3eKdCUte1bJG8EC6n7y6Mn9v4G7HSMecOCBD2NEYaJ2+k53wdVIOx+hp+TxUDqP64PSXt/XM
	V/Jgb5plKd/WjBQLtQCxPQ1Ul8hv5JQQg8V0Ysmv8xP9JcVu2xAKcJMU/JJkmdhP2vpnUvhumuZ
	gU2zznECIn7XgCmV9imlHcoCu8Q3nJCOWh4pKUKy5+P+O0Est9e95qe6vI3GrN5FA=
X-Received: by 2002:a05:6a20:6a2a:b0:3b3:ccd0:cf62 with SMTP id adf61e73a8af0-3c8e492ab44mr714378637.36.1785296513350;
        Tue, 28 Jul 2026 20:41:53 -0700 (PDT)
Received: from localhost ([2405:201:8018:1843:35b9:9f48:c0dc:e32b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-31504cc9dffsm4502149eec.14.2026.07.28.20.41.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 20:41:52 -0700 (PDT)
From: Ayananta Paul <ayanantapaul@gmail.com>
To: kuba@kernel.org,
	donald.hunter@gmail.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Ayananta Paul <ayanantapaul@gmail.com>
Subject: [PATCH] Documentation: netlink: fix spelling in tcp_metrics.yaml
Date: Wed, 29 Jul 2026 09:11:47 +0530
Message-ID: <20260729034147.6970-1-ayanantapaul@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Correct the spelling of "reordering" which was incorrectly
written as "reodering" on lines 113 and 115.

Issues identified using `codespell -D - -S "*.bin,*.o,*.a,*.so,*.ko,*.gz,*.png,*.jpg" Documentation/`

Signed-off-by: Ayananta Paul <ayanantapaul@gmail.com>
---
 Documentation/netlink/specs/tcp_metrics.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/tcp_metrics.yaml b/Documentation/netlink/specs/tcp_metrics.yaml
index 13144aeed31a..dddf92bedc4d 100644
--- a/Documentation/netlink/specs/tcp_metrics.yaml
+++ b/Documentation/netlink/specs/tcp_metrics.yaml
@@ -110,9 +110,9 @@ attribute-sets:
         type: u32
         doc: Congestion Window.
       -
-        name: reodering
+        name: reordering
         type: u32
-        doc: Reodering metric.
+        doc: Reordering metric.
       -
         name: rtt-us
         type: u32
-- 
2.53.0

