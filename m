Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2AA3B2FDD
	for <netdev@vger.kernel.org>; Wed,  1 Jul 2026 06:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782888808; cv=none; b=JQYpyNBcxSuFGU95zFkOOYBE1KSU+36y3C0pPG/RN/1F2xiU+tn0/LmXSqnlXEyVJmjfheM0j75SijaY43lZnpYqoxTEV9l2BoqRYB8GEFwPUj4BvuZkBYBJC85VWn7kWX3lwkkm+LhS0KqpFYGXl9BABhWCKuowhR5w8Fuoa9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782888808; c=relaxed/simple;
	bh=c3UXkmSf/U+KQu2LbfQINtMaYbmZc76jB9bbaDgnsC0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FBAXLsS2EM0cAIY75/o2AKfCKs2DOWSrkJHAd6mtAfawmzhdMjT8jSvKWWQS3EaypRJkr2/776r72uwuCyGqxO8aOwvkvQyuO62fs3xdDCcWPKg03tgBTXcQPZy6+17eWZhcjjd1PzLFS5+SU/Jpm3XbU1jiBWjCKnee7kbNi2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b3ZEc1+e; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b3ZEc1+e"
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-47231f1f8f3so319500f8f.1
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 23:53:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782888806; x=1783493606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L9lS47Kg6rDUlabcBxfm0AD8NjNyWC3LZqIIiOY+ZJo=;
        b=b3ZEc1+evCK5sOUeERnJZ08unoNTXe2IMNFiBCAcYmYci/z9/aYXmr9+/1n3HTxmmT
         If1loggdJOeJPST1QQYqDOkdPAVj4fC/OkIlQ7dU9X82bD57esw2RjNp/5wb3kFK1KO9
         C/VkrV+Ojyj2czG4VDPG0OI3XMhT6e587alHhk5ce5z4HnU8eQk2HkFx4+DGeSjuITzB
         gGbs1/uIBTlQDJ0PX3bUtd/URqTfPf5BUbJCp4Dwg76VeD1PIpXHrrKsfC0rJKlKDjPZ
         j0gqi8pciBrsc3YUd8pgNk0yQPX4ur98LZ9UDTNqcIsIJdZBS7fihLD3W+c8uv5D3cI2
         DSrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782888806; x=1783493606;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L9lS47Kg6rDUlabcBxfm0AD8NjNyWC3LZqIIiOY+ZJo=;
        b=aY9OfkRupnberYbCO+LapAFj35+9qMi2WG0tqxG/osDW1TfM3tUDo/jTjXorFM3GJM
         mYGRMzfVjV0rvRTd2nx4FmuQeqtPIP7Sqz0TRGS1+mlYqTxCv9XEN35Eh7NqHKfmWu/5
         6Q9U9vbSY7qcP0SWLUrdErLRUkJLjmoTHUd7fCi6xrNURC9kZ4JM6mtEK+wJiM1bNGB8
         KUfRDxtAyTbGDg2o3ZBdjJT/WRMuBm8M4T7IykKSrXoJ4dMqQqq/+Hp71Zq2z4+A1+WA
         onr37+2UH4M5KnZkOp4Gl6QqN/jE82q3uXUnREB8YjD75KgHaMsBjSbALcGrr+pa/joN
         TTAA==
X-Forwarded-Encrypted: i=1; AHgh+RoFGjlMHEvov5XlEvr0Mx/LY8og0UuAmRZ3BuVpR1bEwXFmdLq1Dc9wV/Y8vp0Msho3E8eecfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwVM1qg3rPW8Dpo4EfX7YFqy7VrbKkALn2XzUF8KM3Wf/PpPBH3
	P9xPNB8hoiUMF62U2nt/Vl4S4X3a0nGl+7/PwG+5ZhLVC1I9TN25y+7q
X-Gm-Gg: AfdE7clm4y/aEj+Ngx0q7IydZOpqGm4OiVedLrQys0qdmgxWIn5VQm8nn+C/80xRieK
	k3vYwM2tFR/zZjoWEVuc5kK0aaSDwRFReNYMLrRUx3IXiPdIdlsvZSYAxuHEpLO6FlTCfR+D+ty
	ron93LO4GJtlRgwwjsT4cGUfSB+74aBaScOvqyDlymf7C4OmlN9kmMzSJ5bB831BoxK8CBgnyKQ
	mg15nNkkj3ksuxWkjWvDCH9n923D3/1CxRGhrk5IgqoyRv7OEsJF5HyFtKf3JJylEA0FjrQ/BVF
	1B1O7OHNZ8hHSEjrPAUGmietRrvXn18l1tz+edob+ZghTVNHOWHhEiZzPKf1YJ+6WlOoceHrSZP
	Zu1CpM9r/l74eUnszHkoxrhGWzHBlwOnBQwrjSoLjO7B5XAmA07bXByBuorsVo37bpLivF28llc
	2Mu1WgqYJtmMtDeP8If06oNUPaYbwSmT/pFbXXgK8M1gCdW9D13LhFxXFp0noYkZTfWP3NeKnh
X-Received: by 2002:a05:6000:1acd:b0:475:2171:ac1 with SMTP id ffacd0b85a97d-47759c24ffdmr532138f8f.32.1782888805717;
        Tue, 30 Jun 2026 23:53:25 -0700 (PDT)
Received: from localhost.localdomain (94-43-5-44.dsl.utg.ge. [94.43.5.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4756636d2cfsm16079572f8f.17.2026.06.30.23.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 23:53:25 -0700 (PDT)
From: Igor Ushakov <sysroot314@gmail.com>
To: stable@vger.kernel.org
Cc: sashal@kernel.org,
	kuniyu@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org,
	sysroot314@gmail.com
Subject: [PATCH v2 6.6.y/6.12.y/6.18.y] af_unix: Set gc_in_progress to true in unix_gc().
Date: Wed,  1 Jul 2026 09:53:06 +0300
Message-ID: <20260701065306.281809-1-sysroot314@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Kuniyuki Iwashima <kuniyu@google.com>

[ Upstream commit d82ba05263c69fa2437fe93e4e561cc40f4c03af ]

Igor Ushakov reported that unix_gc() could run with gc_in_progress
being false if the work is scheduled while running:

  Thread 1         Thread 2                     Thread 3
  --------         --------                     --------
                   unix_schedule_gc()           unix_schedule_gc()
                   `- if (!gc_in_progress)      `- if (!gc_in_progress)
                      |- gc_in_progress = true     |
                      `- queue_work()              |
  unix_gc() <----------------/                     |
  |                                                |- gc_in_progress = true
  ...                                              `- queue_work()
  |                                                       |
  `- gc_in_progress = false                               |
                                                          |
  unix_gc() <---------------------------------------------'
  |
  ... /* gc_in_progress == false */
  |
  `- gc_in_progress = false

unix_peek_fpl() relies on gc_in_progress not to confuse GC
by MSG_PEEK.

Let's set gc_in_progress to true in unix_gc().

Fixes: 8b90a9f819dc ("af_unix: Run GC on only one CPU.")
Reported-by: Igor Ushakov <sysroot314@gmail.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Link: https://patch.msgid.link/20260501073945.1884564-1-kuniyu@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Add setting gc_in_progress in __unix_gc(). Keep the existing
  set in unix_gc() for wait_for_unix_gc() over-limit throttling. ]
Signed-off-by: Igor Ushakov <sysroot314@gmail.com>
---
 net/unix/garbage.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 1cdb54c616..fa6983dc31 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -583,6 +583,8 @@ static void __unix_gc(struct work_struct *work)
 	struct sk_buff_head hitlist;
 	struct sk_buff *skb;
 
+	WRITE_ONCE(gc_in_progress, true);
+
 	spin_lock(&unix_gc_lock);
 
 	if (!unix_graph_maybe_cyclic) {
-- 
2.47.3

