Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D99FE3DBD53
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 12:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786883224; cv=none; b=QIIiWoh/Ink4t2AUhl+G/rbTjUe59TvU9Rl+tNA8FmNZuZ54NL5U/nx4ZCWY2pXdjnHMDIEP/os8YS8woqi2lMFfnkgZ4m3WKcE3ibAPzD3iZMVZz7myI8P5lvCmAlPpvEyoi5RYmObpEgzrKoHk/fMV6/Bz4rirmByM/zQzk5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786883224; c=relaxed/simple;
	bh=mfBhlwUocbG6p3DpnjjumZOmhGJCAmXFqBVPuW9dGc4=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=fnTZep8TSOKY7oHHn3GTVD/fa8Vs2MsLhb7FaCqtcY6+ZBC49eKEGgrwhPcQI41N/t5bP5+q1BJSXkEGciblRgeS5DGAfgf64eWtb1SwYzhQ7Fx7Ede5VbHo41y5d/Ic/R1jN76QRZ3jU/kAmRLZCpgaLW0pPaeOlT+rGcbqSW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from www262.sakura.ne.jp (localhost [127.0.0.1])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 67GCQsSG093524;
	Sun, 16 Aug 2026 21:26:54 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from [192.168.1.6] (M106072072000.v4.enabler.ne.jp [106.72.72.0])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 67GCQrBV093521
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 16 Aug 2026 21:26:53 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <af7dabf3-d0d7-46dc-a878-e1715b3c9ac6@I-love.SAKURA.ne.jp>
Date: Sun, 16 Aug 2026 21:26:49 +0900
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Network Development <netdev@vger.kernel.org>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] net: add missing ref_tracker_dir_exit() to net_passive_dec()
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Virus-Status: clean
X-Anti-Virus-Server: fsav105.rs.sakura.ne.jp

I found that trying to read /sys/kernel/debug/ref_tracker/* causes NULL
pointer dereference crash when alloc_netdev_mqs() via unshare() returned
NULL, for commit 9ba74e6c9e9d ("net: add networking namespace refcount
tracker") added ref_tracker_dir_exit(&net->refcnt_tracker) to only
__put_net() path.

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
Signed-off-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
---
 net/core/net_namespace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index 6e9a0c29a9a0..4915ea7b2374 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -530,6 +530,8 @@ void net_passive_dec(struct net *net)
 
 		/* There should not be any trackers left there. */
 		ref_tracker_dir_exit(&net->notrefcnt_tracker);
+		if (!net->refcnt_tracker.dead)
+			ref_tracker_dir_exit(&net->refcnt_tracker);
 
 		/* Wait for an extra rcu_barrier() before final free. */
 		llist_add(&net->defer_free_list, &defer_free_list);
-- 
2.55.0

