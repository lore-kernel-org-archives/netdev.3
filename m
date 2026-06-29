Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F1CF3FADE2
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782726039; cv=none; b=fOx3C3etIffkeie2YyXtI5ayVfSmTZROLcQv85ti+uFKADampaGJnjZBO9cAO+h28EUr6x7bdndXf6qx8urGSV6un7RZ4a+RMrg2ZkZaMiLzAdOdEVREdYsPA8aKzmn6qfmigy3HicbXqNt74bIuHyNdOx3Dj62OU+tUbAGyC/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782726039; c=relaxed/simple;
	bh=qbYNsnpGajxUvoWvZ9Gf+3+VhKKvHnOwjSRy9C17bsk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mosLUmA9eFoPZ3VEGCWiTbH/Slac6hDdBoV/LE6GgApBxj/+R8XK6P6XUiov1uxNPFIJ6AlsLvBMIM6jrshp+VD8QBmdTdX8dfarTGhA9xEQu8xESjXOMQN/9UIrVUgJoLVMRyvDRFWBKksC97hUazMAGzI5zw2ha83cQad0yRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=coblmMZ0; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="coblmMZ0"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-474560436c3so359051f8f.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 02:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782726036; x=1783330836; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Y/tlblPullUUOZj5HMHBD9SnBztd9AJIPot7pnx1VqU=;
        b=coblmMZ0RZ4nqrEB1JXLvFRriTFmuTZLuXUwWh5hb+n1HXFD+/j/ZQk0XTzRqy+KUA
         0h9DrIJvzjRmP7I92H2JVUkcWuPBlxIE1XvW4FO5zB2QQN2+lJpwu1EBO93nD0159Nzw
         2Cjlkc993mWbdW4vUp37AAPEnurb2JN3JjTfsOHjtalnA08Su9buX3uK2Lobyy6LBdqF
         Mr5dt5bD1+8ITq5ESOWRLRYdi1AfxrK13dacqZgltz+EAi88kMjaHcp0QQt7m2vQemtD
         CCyrlyhx+M9O430cvyM27az1pke6sG0b7kfaY0NygGkQSsKE6rBEGThI+coSliw0LTuw
         uwQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782726036; x=1783330836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y/tlblPullUUOZj5HMHBD9SnBztd9AJIPot7pnx1VqU=;
        b=Kbdvw86AX1V/xPZqTKIMBA8s7YyZIC9QFCcoNhXSA6K2usoRXYXSvcZbRjnQEcvXjt
         TaAgKfd6NqSSNCzvCV3l1lNTsfdNZBrMQzUWT8LjXbo7R3PSCfDWXSXK8idAv+zeDVbz
         P2La8pDgl4CTgSkYbtCr57rBw+kUBzvxfJADYn2PvepHAlOCD1SjQHQMNVD4U4fSaqUr
         hQ01iVMOWwsbKVgpHnL1sv4i44xVGbrmMFi/52j7SR+im91tf6DtqiemrKKwi9LRc4/6
         5B+zwp8Gq4KAnl5vtKuvSVnpRZwQ6/guptMMn2mffKZ4PmOateu5u2R/h+POQWMDgUss
         +Rcw==
X-Forwarded-Encrypted: i=1; AHgh+RogHlv7O+9Ty7pNtkpqizJhwsJEE/ny31sENCiywC+0Nc4xMCXJsvyx6yCiwBdgCr0NtqE4E3k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5nKdk1DuE3iM2WbiZJEhGvlMjM1vhQqPAXHFJlCTpAGFx4QrP
	YAJ/XAR/ATry008gGJnduN28/Si4KHqPwcMU7+32U1zyQpA+6vk/hL+s
X-Gm-Gg: AfdE7clYlPKHhMdtFGDIbQUXxaJsdnBnHPqKpeyUtiXnGjRwtW3lIfw4utNp54KvcaN
	H3XlbPG4uhC8fyzj7IV/wn+hlk7ZghndreVWorcKnpROKK/gMEmlYOHf7UnTqL1f8YhWZsQ+dVT
	sd1+/WPeednO2OKNieMDGWxrUYHre6wjmuelA92YePURA/cOsWtRIJdpi9e031a/Gaf0/BTg8Ln
	j8FwyAFVlL/Op6AKbrGUDuhVnhLIutDqeu4l9HFnLumx3i8ZQxvtLg/oHihQILExHeiKaKJKqOM
	YJULs3waQBHlZQ5lJRiLMVLjWJcsoZcbTPkqCnUViIO9mzZwl2JB6s/T7Bpgo9VujusEUc3yAth
	OGpR6UJJZHK+/uYL2W2RKK6sGyx/eberzpfuDVwGZRKh7/wxP8xMFpgQ+cs5vtQdIvuQ/8fxXHa
	AHQ3XZkEt1kYArbSB//FkQobaZgPs5JasAaJ6MVagX/7kYNKU1mtifQGAbcF9ToHUiA96FFnVQ
X-Received: by 2002:a05:6000:4816:b0:472:55a:ef9c with SMTP id ffacd0b85a97d-472055af3ebmr10195520f8f.9.1782726036427;
        Mon, 29 Jun 2026 02:40:36 -0700 (PDT)
Received: from localhost.localdomain (94-43-5-44.dsl.utg.ge. [94.43.5.44])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4726b76e6f8sm17704409f8f.13.2026.06.29.02.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 02:40:36 -0700 (PDT)
From: Igor Ushakov <sysroot314@gmail.com>
To: stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	netdev@vger.kernel.org,
	Igor Ushakov <sysroot314@gmail.com>
Subject: [PATCH 6.18.y] af_unix: Set gc_in_progress to true in unix_gc().
Date: Mon, 29 Jun 2026 12:39:52 +0300
Message-ID: <20260629093954.195016-3-sysroot314@gmail.com>
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
index 529b21d043..a3ac2695e5 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -606,6 +606,8 @@ static void __unix_gc(struct work_struct *work)
 	struct sk_buff_head hitlist;
 	struct sk_buff *skb;
 
+	WRITE_ONCE(gc_in_progress, true);
+
 	spin_lock(&unix_gc_lock);
 
 	if (unix_graph_state == UNIX_GRAPH_NOT_CYCLIC) {
@@ -636,7 +638,6 @@ static DECLARE_WORK(unix_gc_work, __unix_gc);
 
 void unix_gc(void)
 {
-	WRITE_ONCE(gc_in_progress, true);
 	queue_work(system_dfl_wq, &unix_gc_work);
 }
 
-- 
2.47.3

