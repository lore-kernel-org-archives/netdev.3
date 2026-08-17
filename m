Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6883F3EC82D
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 14:08:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975708; cv=none; b=Or+CKJETW5RQF89lm1fhdTDRswDXgN2M8l4lNelV+Sui+UDyE2WAg9XE3hpl74S65RnKv4IztT8b2NdRtq8eWGI8JpfyrbNT9soTepct5roHlzXAOPNyKAlat6rfy4aLCillgVpv/9lAaz9tNy8xRGAQOnp36CvjyxEZGubwJdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975708; c=relaxed/simple;
	bh=lO2H7HtOsFo4vWdKsjhuJFaaKGMgGTgL+oMtC31fcIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DbEKA1W9+EGygTYUYtTG3Dyi2u8G/rs3MwzWaDqL1UFd2C0cWMbznpDrXIvyOMlRJ58Trl7lEt+f1wz5nXQzlh1YTRaO1EMVRGG4RTltgBUjsadU17OIbjaRr6XETuIcBpdgMDZ2xP0c2Kqzv8W4ouNNPio8374BHjCW15U0Z5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 67HE8Hg7070169;
	Mon, 17 Aug 2026 23:08:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 67HE8HQD070165
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Mon, 17 Aug 2026 23:08:17 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <64254d80-9248-466c-8108-95f43bd71117@I-love.SAKURA.ne.jp>
Date: Mon, 17 Aug 2026 23:08:15 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net v2] net: add missing ref_tracker_dir_exit() to
 net_passive_dec()
To: Network Development <netdev@vger.kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>, Eric Dumazet <edumazet@google.com>
References: <af7dabf3-d0d7-46dc-a878-e1715b3c9ac6@I-love.SAKURA.ne.jp>
 <CANn89iJbT_e5CxtStQNcsCTt5OqaqsexUPgdDk5MY8R6jn2Tdg@mail.gmail.com>
Content-Language: en-US
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <CANn89iJbT_e5CxtStQNcsCTt5OqaqsexUPgdDk5MY8R6jn2Tdg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav302.rs.sakura.ne.jp

I found that trying to read /sys/kernel/debug/ref_tracker/* causes NULL
pointer dereference crash when alloc_netdev_mqs() via unshare() returned
NULL, for commit 9ba74e6c9e9d ("net: add networking namespace refcount
tracker") added ref_tracker_dir_exit(&net->refcnt_tracker) to only
__put_net() path whereas commit 65b584f53611 ("ref_tracker: automatically
register a file in debugfs for a ref_tracker_dir") added
ref_tracker_dir_debugfs() to ref_tracker_dir_init() path.

Since preinit_net() calls ref_tracker_dir_init(&net->refcnt_tracker) and
ref_tracker_dir_init(&net->notrefcnt_tracker), we need to make sure that
both ref_tracker_dir_exit(&net->refcnt_tracker) and
ref_tracker_dir_exit(&net->notrefcnt_tracker) are called before
net_passive_dec() schedules for kmem_cache_free() via net_complete_free().

ref_tracker_dir_exit(&net->refcnt_tracker) is called via put_net() when
ns_ref_put() returned true. But put_net() is not called when copy_net_ns()
fails. Therefore, call ref_tracker_dir_exit() from net_passive_dec() if
put_net() is not yet called.

Analyzed-by: sashiko.dev (no mail address)
Link: https://sashiko.dev/#/patchset/b06ce35d-e7bc-47a5-8e0a-e82be7e4dd08%40I-love.SAKURA.ne.jp
Fixes: 9ba74e6c9e9d ("net: add networking namespace refcount tracker")
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
Changes in v2:
- Refer to commit 65b584f53611.
- Guard with "#ifdef CONFIG_REF_TRACKER", for sashiko mentioned that
  "struct ref_tracker_dir".dead field depends on CONFIG_REF_TRACKER=y.
- Added Reviewed-by: tag.

Sashiko did a correct review and is reporting a pre-existing issue at
https://sashiko.dev/#/patchset/af7dabf3-d0d7-46dc-a878-e1715b3c9ac6%40I-love.SAKURA.ne.jp .

 net/core/net_namespace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index d9dafe24f57e..21fdda9c20c1 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -532,8 +532,12 @@ void net_passive_dec(struct net *net)
 	if (refcount_dec_and_test(&net->passive)) {
 		kfree(rcu_access_pointer(net->gen));
 
+#ifdef CONFIG_REF_TRACKER
 		/* There should not be any trackers left there. */
 		ref_tracker_dir_exit(&net->notrefcnt_tracker);
+		if (!net->refcnt_tracker.dead)
+			ref_tracker_dir_exit(&net->refcnt_tracker);
+#endif
 
 		/* Wait for an extra rcu_barrier() before final free. */
 		llist_add(&net->defer_free_list, &defer_free_list);
-- 
2.52.0

