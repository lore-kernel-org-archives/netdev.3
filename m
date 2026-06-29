Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB993EC2F7
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 09:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726025; cv=none; b=ex2piAunKQqA51ZvlnJ3ef3GylOeZPzpgGfZNdlwIKLYLYEbx7Ro4DI55Q9m+O8D4lDtw83pZ5lyVMti7meNp4uMda+rXOZvzxpFzrceDTY8i0KFwS+2XJpajy99luLFTk174l6BSBhSTVRMqp3Ny1lvDlX5tU86U2BpW/Vf/5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726025; c=relaxed/simple;
	bh=0NRnwOTkYqoD8DBF+bYtIQoBIoqPd4HJRoOYSMROJzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gxyKOoUl/N9vhNVXU9sGF2jyvo4jm4cxs9HFekJFT2g0bM/dVSI082968E99Gsv7LHxzkKUxNzYfJ4iC9B7WlhmLO7PKfPwhwTRiVLlAo1a8AodWUj7grMQEcraTX9ZC6b8n79vK0Ao3mtMq4XrzskLQU+M4z373G4JENAwTIFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/R7v/Ib; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/R7v/Ib"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-4629051c946so1659720f8f.1
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 02:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782726023; x=1783330823; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=buX7wAG0nhZSHN5FfnjkD/cPhw+ScyqwYDleMV3fgho=;
        b=Q/R7v/IbW/MXL9vYsMmuXIdmmf4kmy4eLhHST0v/lqLqqeDzxfLzOSXM/PYWjC92ZD
         hPK4i0YCrcd164/Lp3bQalGKGiviGwXW/QGTiLDynuuSGTyw7c4AIukOOA9l3ytZYwCX
         Jpj0w5rFayKJzK0w64+9H32DR6/BQa4FZG+3mgeptocGzHVOKx/fYlGxwdaObfvI4xtt
         sWRY9jaXk94hTVp2kevnCqeWrFgNMyYgAgcR1lRCpyo/EWct5RspFKzbPUiA354THwqS
         eF1NikejQ8Nqk0Gu99K8zadvttX/tmV80lS6ks3Uv1xil9QLovl30+rQ1AzUaNyq/0Vn
         dw0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782726023; x=1783330823;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=buX7wAG0nhZSHN5FfnjkD/cPhw+ScyqwYDleMV3fgho=;
        b=pBmUMPR9oq+0sqA8Na7p3x9FIqRnAg2vUB1jU01KojgsmegD8szlD/2XVctm7bdQ5G
         jF0X7gIV+C1rM/hwAy/5V0KRARUlZpC/suK/wVVIFFTQkAUwfw7AWMPm6ZWX3A9MUVbB
         jXYByXTUN5/2dRZbX6nH1BzU5kzjxltKS/8zadpgnoNvBZ7pbG8mfabo9CrQeOk7z+mG
         APAiPqx9+rPIDpxopdix0t1MWLi4oMRq/BcB8ofzA6c5ciGzMnddBsxap45Vbm/8JMXM
         2cVymMUf91gOC0fWf6hkh79LwoBV/EqdfSAVbeaHP4ZwBmfKXqkAGtgnbhixzZvJ2eWK
         BCJg==
X-Forwarded-Encrypted: i=1; AHgh+RpDMeRK3TxXyJR1o6AuEm9LdQS929meVjl3F3qqJL8VtW1+3WdBuz2f61jGAuOnbGtmNTLXyEg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEAGVXBxs7Syf4naSlc8rLcs6/X1QxvvDZ6NEtHB0jFcorZXGS
	whh+7dKmE0ZOe4Hqf8ybjK3aHWuImlvpT5jM0sulXp+LkyX7ZeagSxTp
X-Gm-Gg: AfdE7clY8xauNK8ibhaR2rAQC5Zg7XIL/hXLk2z+XJW7sOeHdVS/+9Cx1cnyyhWhaeb
	LmaZd9YO2n6UMOpfhlPiTwlYo5+uzePjgiXStcdLWkPS8X+ehIfWqr5e5vqu7AkWW44TraMYPU5
	IrxCEYyMnxpOWInks0GRTVIQYrctAmaaXbOvEj7steEfNWS5cy/6it3AoA9DTX/dZnma/olgOZD
	MraKNUApZGqHr3PTROqBZuH4Tp+HggFtcsqCPF6WGfvz2lewEUD1ABJOsXmYPKZa7qsNw5fDUSN
	XHjt4znb8GRswpqk0r7uMXM1edGmE3HltGSwaGVNJUmuBsVRrIo8fzqYgfD8++9BNPPUVAqB4fO
	7UcLZPbDDzQdDvw1ZujDL7vmzMr8JAK/PSmT51uZvEkpXrNQXbCEhVVrb/95+RADrKskIaJm4Sf
	vxyzJzfIz+gqTiSNCXdEwq1nP1wNyscALR2aMJsk8j+mC4Efp3TDvt4Cwz6EUvoYXeT3nHdntj
X-Received: by 2002:a5d:5f90:0:b0:474:c3a5:4132 with SMTP id ffacd0b85a97d-474c3a541a4mr732878f8f.9.1782726022624;
        Mon, 29 Jun 2026 02:40:22 -0700 (PDT)
Received: from localhost.localdomain (94-43-5-44.dsl.utg.ge. [94.43.5.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4726b76e6f8sm17704409f8f.13.2026.06.29.02.40.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:40:22 -0700 (PDT)
From: Igor Ushakov <sysroot314@gmail.com>
To: stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Igor Ushakov <sysroot314@gmail.com>
Subject: [PATCH 6.6.y] af_unix: Set gc_in_progress to true in unix_gc().
Date: Mon, 29 Jun 2026 12:39:50 +0300
Message-ID: <20260629093954.195016-1-sysroot314@gmail.com>
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
[ move WRITE_ONCE(gc_in_progress, true) into the __unix_gc() work function and drop it from unix_gc(). ]
Signed-off-by: Igor Ushakov <sysroot314@gmail.com>
---
 net/unix/garbage.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 1cdb54c616..82dfb1ad34 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -583,6 +583,8 @@ static void __unix_gc(struct work_struct *work)
 	struct sk_buff_head hitlist;
 	struct sk_buff *skb;
 
+	WRITE_ONCE(gc_in_progress, true);
+
 	spin_lock(&unix_gc_lock);
 
 	if (!unix_graph_maybe_cyclic) {
@@ -613,7 +615,6 @@ static DECLARE_WORK(unix_gc_work, __unix_gc);
 
 void unix_gc(void)
 {
-	WRITE_ONCE(gc_in_progress, true);
 	queue_work(system_unbound_wq, &unix_gc_work);
 }
 
-- 
2.47.3

