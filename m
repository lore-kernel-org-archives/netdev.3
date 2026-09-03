Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2324C77D7
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 15:06:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788447996; cv=none; b=cfztxaPsw0TIxup3EOWIc/FOCA8ouXNiC2PwnJvbrL7FHSnSCUxTFLbSgsIgzR7cJUtkVzciRAVcVS2OhO+ZeLkzj0l7c3Ut4Ev7r0anprUWy3hauIHi2cSOSwgriddVxtO+kCzoYbmAHboZAiZhJK4C8MWho56T+q/IIrJBI2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788447996; c=relaxed/simple;
	bh=WH0QTFAGkBASqEUK10naybiWkASY5mU9qZY1XfCsA78=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ATOCPkAs5ncCi+kciCaBdezX81+hJuXtvRWEvJixzaaEjPz6DDQo/C55HdjMaKG+7//253Fa19TyidrhFU3Z3J+78RPB2kBoM6LgMKq6MQDcg+9ww9NUlQ2OO9yFJvF5fk1NVzQFu6Zm0xaB2MoVHFRDooFUc5wMeL0Rs+fVsk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTINs6bA; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTINs6bA"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49b9320423cso25398545e9.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 08:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788447993; x=1789052793; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=THzjvy5iGboyhx98aFSf1bvAFTvgaD3XGcWeB3Rn6lc=;
        b=NTINs6bA3GqiKjFdJsMJUj4OFjHB2BjLZMANp0fpKNE3ooFguHaq8AEbHwdAK1tl/E
         ziNIuH7atdzqKBvRl8x0rNdbZ0vBTuWl1e7Mxem3MDTqYG+m5O4GrkWZVBHdAl3boJVc
         jNRwt/nNd/LVeXZh8l+eoLnC6NvwGIILMbdTQzT3GnL2Shme0RpDdr73hVOpTKiqRLKo
         UFs5wF8G8bTVvW5vvsxnSUv/0ZAOLVU1hVWV9VN6QFm1M7qUmF/O8NG5k2wfTKJejWsv
         /A1sJMO0X/SL5b/SLS8J3kDCrcsOzhCIyS01KxsiFDozHv9gckBfIg88XirtGTxXTv9R
         yLCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788447993; x=1789052793;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=THzjvy5iGboyhx98aFSf1bvAFTvgaD3XGcWeB3Rn6lc=;
        b=pFVHQ8LZpz4AP/uaZgkBvLVqJ6Lzsiv3uNJ10TEETS+cWDs/KuPih4LqYcMXxZEflc
         F5CdnOVN3ZBdS2QJlfrzKfBhRgjL01fe6OO+U/sVeKziI5KkLdh/vtp4Zbtl6d9zGUq+
         Y4JrKawuewYnkv3hT23CQG0WdCxG4vCw/st48Av72u2zEZf6mG7MDbgWlN2MTQikgk63
         U3xLypPRuwyvFR9zWwpynJcgEpPoFiktCWPFmXJVm5F21FxQmHoMizDVCEP0xOWOPV1E
         xuATxeMJos+3lDDK2c2bP7LEr1RWw49RtAKQvpLg8Sx8A2jVK2WNr7Ud6iunl2O0ALA+
         C8MQ==
X-Forwarded-Encrypted: i=1; AKwUvBxpbW7uknMcwZbP/aHl1bkJlroIxeZ+wsKeGokGbUKtjY9oEx5OjCcwFclYIHpg17G2K2jVZPI=@vger.kernel.org
X-Gm-Message-State: AFuF++m7bQrrBtH23Eqou0G1PXWEBmexSU2xDgS3k56n2rJCSq+9764M
	/nZCvu3TSnN8L2wd1ldCkaYRljWRxNzhaynOHwk0QEet9LgDJLaKL6udSrKCoLZccLQ=
X-Gm-Gg: AYBFou2NHRG9ZnRp6UNyifbWZWkOmn/V9/FKrGExhjMFqwfblV4U/O08jIFtbYsGh3S
	JLDlvCoKtI5l0JtBq1SU9Ln2pF/GmYZAk5DvS4FIL87y0XUK2JqlfvHQfU+2Ufk/KnmTVD/xjdx
	WOjIJRUWxO8ukfk6HhfroC/cy2q0mcOPvD2OJ3yK/aIsg+qAmZ99IZOpgtg2/ofsjfZXE912L2a
	QUTk9mTBTwave3d23SSchAPsQO1ZaDuUwyioY3HtPoKkyeeF52zsMRtLqgXsvKrvClzWItnNl/e
	L+qdBOXeEwZOzWLk1YVR6I+qcDHrdRthjb1nlaWwc8TnKnchASsGXbsY/uwHhJcazvCAIkVUW2Q
	wiL7XmH7Y+lQx+GJV1uEq065DVdWA39knBou/EoKXhOPsMW5q7G3f2jo5jcixooLHzyLbte1dNi
	7kJDILAaqxMRJn5i4z2bwL+/ogMkYieI3X01xeQbrvEMHtKADuvPg4Uh0V2g==
X-Received: by 2002:a05:600c:4712:b0:496:bbce:fc with SMTP id 5b1f17b1804b1-49ce5843aa9mr215052115e9.12.1788447992569;
        Thu, 03 Sep 2026 08:06:32 -0700 (PDT)
Received: from metepc ([46.197.185.71])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5e589bsm71318925e9.13.2026.09.03.08.06.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 08:06:32 -0700 (PDT)
From: =?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net,
	kvalo@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=C3=96mer=20Mete=20Kaya?= <omermetekaya0@gmail.com>,
	syzbot+adeb8550754921fece20@syzkaller.appspotmail.com,
	syzbot+101224300649c3eb8af4@syzkaller.appspotmail.com,
	syzbot+8141dcbd23a8f857798a@syzkaller.appspotmail.com,
	syzbot+b0ae8f1abf7d891e0426@syzkaller.appspotmail.com,
	syzbot+d6bbe0f5705cb8a5aa2b@syzkaller.appspotmail.com
Subject: [PATCH] wifi: cfg80211: avoid holding rtnl_mutex across all cfg80211_leave() calls
Date: Thu,  3 Sep 2026 18:05:53 +0300
Message-ID: <20260903150608.485390-1-omermetekaya0@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

reg_check_chans_work() holds rtnl_mutex for the entire duration of
iterating over all registered devices and calling cfg80211_leave() on
each invalid wdev. cfg80211_leave() can be slow (disconnect, stop AP,
leave mesh), causing rtnl_mutex starvation when many wireless interfaces
are present. This results in tasks waiting for rtnl_mutex for longer
than hung_task_timeout_secs:

  INFO: task hung in inet_rtm_newaddr
  INFO: task hung in inet6_rtm_newaddr
  INFO: task hung in nsim_destroy
  INFO: task hung in tun_chr_close
  INFO: task hung in switchdev_deferred_process_work

Fix by walking cfg80211_rdev_list under RCU and acquiring rtnl per-device,
so other rtnl waiters get a chance to run between devices.

I could not add the Fixes: tag because this patch addresses five separate
hung task reports whose cause bisections all failed, making it impossible
to identify a single introducing commit.

Reported-by: syzbot+adeb8550754921fece20@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=adeb8550754921fece20
Reported-by: syzbot+101224300649c3eb8af4@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=101224300649c3eb8af4
Reported-by: syzbot+8141dcbd23a8f857798a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=8141dcbd23a8f857798a
Reported-by: syzbot+b0ae8f1abf7d891e0426@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b0ae8f1abf7d891e0426
Reported-by: syzbot+d6bbe0f5705cb8a5aa2b@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d6bbe0f5705cb8a5aa2b
Signed-off-by: Ömer Mete Kaya <omermetekaya0@gmail.com>
---
 net/wireless/reg.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/wireless/reg.c b/net/wireless/reg.c
index a8336baf85dc..a2e0d1cf8317 100644
--- a/net/wireless/reg.c
+++ b/net/wireless/reg.c
@@ -2466,12 +2466,21 @@ static void reg_check_chans_work(struct work_struct *work)
 	struct cfg80211_registered_device *rdev;
 
 	pr_debug("Verifying active interfaces after reg change\n");
-	rtnl_lock();
-
-	for_each_rdev(rdev)
+	/*
+	 * Acquire rtnl per-device instead of holding it for the entire loop;
+	 * cfg80211_leave() can be slow and starve other rtnl waiters otherwise.
+	 * wiphy_unregister() holds rtnl across list_del_rcu() + synchronize_rcu(),
+	 * so rdev cannot be freed while we hold rtnl_lock() below.
+	 */
+	rcu_read_lock();
+	list_for_each_entry_rcu(rdev, &cfg80211_rdev_list, list) {
+		rcu_read_unlock();
+		rtnl_lock();
 		reg_leave_invalid_chans(&rdev->wiphy);
-
-	rtnl_unlock();
+		rtnl_unlock();
+		rcu_read_lock();
+	}
+	rcu_read_unlock();
 }
 
 void reg_check_channels(void)
-- 
2.55.0

