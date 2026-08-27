Received: from mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B83837CD53
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 05:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787808161; cv=none; b=BaEuhP58kk6puege0NucnWOW42InrM+bNiBeT+R+0npO6mCDc77689hbP+D2P0+TxFzGphIqwVEMsUvP8/GgFaxTaJDZu+7Xx4R+YvkyWKKW+nwq9MbsksHn6BVus4/oT9rD6wVhWop4AlzWsBXjZuhD9jDuyoYTa4Y3WMVGfIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787808161; c=relaxed/simple;
	bh=QPFq0K3e0JE1XpOgIXInYbgpNOWqOrjgfVwnWSoJhZE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GjhmZvPfy2n6s0w2Jw+b6MqMu736AZG5VQqm4f3LZPA5uDuX/6hnMvfif/jKcXka9pPy+CGHQd8zNCtDcWN1UfL+VhDQwN9KCesJKUqzgGBsX1F8jYJsP3nCOQn10tplWfvj3vOYucVVaKRB1pFSSuciusbhMo/3cRfXicf1A0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=rPlq+ReR; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="rPlq+ReR"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=QPFq0K3e0JE1XpOgIXInYbgpNOWqOrjgfVwnWSoJhZE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1787808155; v=1; x=1788412955;
 b=rPlq+ReR83PR4miupiBqcaP+g9BQfSTzfVXz/DR0MyWLi5zkZLcbLV4tFFPEJoCQmVidZXIF
 Zzlbr8QS831fPivl1tjinkz5zPaMjWlM5q2ByjKaFPNWW2wTY3QI45Ofz2nFfG8/QOQ3tShVnSR
 tfxeF2Jhr1H9kU90ojR0ofrM=
X-Envelope-To: netdev@vger.kernel.org
Received: from localhost.localdomain (147.136.157.1)
	by smtp.migadu.com with ESMTPS id ba4751ca56adbb6f;
	Thu, 27 Aug 2026 05:22:35 +0000
X-Mizu-Trace-ID: ba4751ca56adbb6f
X-Migadu-Flow: FLOW_OUT
From: Jiayuan Chen <jiayuan.chen@linux.dev>
To: netdev@vger.kernel.org
Cc: Jiayuan Chen <jiayuan.chen@linux.dev>,
	syzbot+d3f912a2e30e2079a512@syzkaller.appspotmail.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Jan Kara <jack@suse.cz>,
	Qiliang Yuan <realwujing@gmail.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: fix refcnt_tracker use-after-free on netns creation failure
Date: Thu, 27 Aug 2026 13:22:16 +0800
Message-ID: <20260827052219.290380-1-jiayuan.chen@linux.dev>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The copy_net_ns() error path tears the net down via net_passive_dec(),
which only exits notrefcnt_tracker. refcnt_tracker is exited in
__put_net(), which this path never reaches, so it is left alive.

Since ref_tracker_dir_init() started registering a debugfs file per
dir, that file must be dropped by ref_tracker_dir_exit(). The missing
exit leaves the file pointing at the freed net, so reading it walks
net->refcnt_tracker.lock and hits a use-after-free.

The missing exit has been there all along, but before the debugfs file
refcnt_tracker was just an in-memory ledger and empty on this path, so
skipping it leaked nothing and did no harm. Only the commit below, which
gives every dir a debugfs file, turned it into a use-after-free, so
Fixes points there.

Exit refcnt_tracker on the failure path.

Fixes: 65b584f53611 ("ref_tracker: automatically register a file in debugfs for a ref_tracker_dir")
Reported-by: syzbot+d3f912a2e30e2079a512@syzkaller.appspotmail.com
Signed-off-by: Jiayuan Chen <jiayuan.chen@linux.dev>
---
 net/core/net_namespace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/core/net_namespace.c b/net/core/net_namespace.c
index a91d2b58aadd..0c3f169d9afb 100644
--- a/net/core/net_namespace.c
+++ b/net/core/net_namespace.c
@@ -591,6 +591,10 @@ struct net *copy_net_ns(u64 flags,
 		key_remove_domain(net->key_domain);
 #endif
 		put_user_ns(user_ns);
+		/* setup_net() failure is not routed through __put_net(), so the
+		 * refcnt_tracker (and its debugfs file) has to be released here.
+		 */
+		ref_tracker_dir_exit(&net->refcnt_tracker);
 		net_passive_dec(net);
 dec_ucounts:
 		dec_net_namespaces(ucounts);
-- 
2.43.0

