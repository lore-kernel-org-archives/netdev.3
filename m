Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB5546983C
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 16:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787761285; cv=none; b=iZczBgZm7WZTTtpEKg9284VT4xw+sCRBPO8XeUXK6bQOiOLDX/uwPQG3l4uAeZ9XUBLjM0cXhPSzsURPc0v53dEURwL+nThF6msPY3XcEd1zgNbr6xMMbv1xO8n4i7IqMVXQa0cFNvop6nuvan+ovUISsweFoqw6nvakvKw/cMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787761285; c=relaxed/simple;
	bh=pvjWpnlTdBZKx5UqOCq9/dEYrGv5OCu+9mtstfD1pFA=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=thCn6/BcIsO+VMVQFFxGQJOG5bS4sE1wCIy+tja1zS6KAMyrs+RZVdekWrchkIUQLa7Zh9VNBQlq+EzJ1tKyv7eiqWlyquMj2LqyNMEk41tvvrtmkZIfLhcOfMFmXuTVsGwpT4hIWRlqBVA2VajoFPsLzOuach198Xo75EfUO84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NVQ7iyD2; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NVQ7iyD2"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so1947600a91.0
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 09:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787761280; x=1788366080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9/VxaBSyrAp2V1JuGfOC1NLa01pzB3ApfCB2gfxG+kg=;
        b=NVQ7iyD2jeGIpRsm1FJtEPzmfezADQch930PPya/IK6VEsIO2zl4I82W6ul6Xb6nXo
         EtFF4tTiyIi/jNTZdVYCE+uh0SxdBxJY2Zb8z4mWzZAzGXxGzr1qHOwNDDJ8Ctx9rwWj
         K3eXFRM7tjiTS6yliz0EwwOcuvmhaKdepaUx6m99H36KUqNQdlRMuXImCRZNvp8S6VZC
         zQMUbWBvP6f/JfUCdAWcHkr21bM9doH+rFqrV6mMUfav4/kbT8BizPdQWotpd+9TZnCr
         C2BqPgT5rf9wNyOyuDHH0u0YbWd944ZD+O83dnRqgOVxDyOHi9svquv+JxIzYEbbD6vX
         SC2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787761280; x=1788366080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=9/VxaBSyrAp2V1JuGfOC1NLa01pzB3ApfCB2gfxG+kg=;
        b=iOq34Oldi/c0q76rWg1UFJBCXiFfDXkR6yBfe5wOshw25SWtZizJ1Md4K07D29BJDU
         PaA3y6cSY89zx0kNvXdJtigKBuAkeIy0SLEgID2YRM0yGAJR2ZxGsTt0Vmfzhw5VzK6V
         h725kSlMCvzMtdFd6Dyyk4aOraO93ittGyWFzWskTUHqN2G8yWfBZHxRysvCCzJ5t8ZE
         UrhR+BE8HdVcAHEslFjYjJHri4O7fugoK3u4W0AsTKmk5hu46pRgNp+3cOT5ZFCEf001
         vL1Yjbn+VSyIW4QmhXzviky+8Tc5JiriP+dg6KSx+mFpCFipf9NzzuWnYOJb3zGX44jG
         gMRw==
X-Forwarded-Encrypted: i=1; AHgh+RopFWmpOkGyZTwQZnWaLjRP5Km7bZ8ZE5V+XIU0sBi5nru4rKxihh8OgxeWgcaa0CMzEmIKovA=@vger.kernel.org
X-Gm-Message-State: AFuF++nuW355mnCcXrB58P24L9tAj/TqS8xsHK1ixK/OSM1x4HIl/5Fr
	r8gX21vV/FsJpd47qRmD2HlQKh3tuNi1FSnStbe4rWpaa2VDmfV8esAdmYs+k+R1KKI=
X-Gm-Gg: AR+sD11ROFWlndhqEoPZNHmlzD5w1d4FrWepovNmFlDe6kjO/EW432OGznYnt332nza
	tBMQJiFlQrvUBeb0GioTk4TDvt+PtyfTw+nN9FJPRtiUDwj9TfUXwjUsheFbpz/CMmhPdSm6/Aj
	9MlfIFYhv1J8tT3i5fLcKuDF0dgWHD787xVEaR5N+icmYy6UNbS0eimrSgEpbrgyzlCoy6c0f6A
	xf1vWq+JFNYWp0EDGBwLpJZa11CMB3IO4Tnk6mb7qF7wL3hiqniqrYrndGiRbP6kfAVLzL8s9HT
	ReczS6PykSavgSb9r+Hgr8n1Ko3O5JoDFR0w0CCwiQeXVuvT/Iq4nhci6GJ0ugB2QToyS7oCnEQ
	iajzDYaPO1QzeDzXi7nuR7rjW9juI/PjLJU4fviulD18/mURoP3tB7yLcLNIduVPErUMYxV/cmx
	DUkpPgUHZcjmvHlGCldgmCojrJ0V2Dfa4YBu3Xr3DmxhkvdJc9tlyFKZqF7z9Q7NMDB5oGXMwgf
	7DdY1gQN5QMjnozLHlJOEQ=
X-Received: by 2002:a17:90b:554c:b0:38e:1497:af5b with SMTP id 98e67ed59e1d1-3966d1396famr18305322a91.1.1787761279828;
        Wed, 26 Aug 2026 09:21:19 -0700 (PDT)
Received: from localhost.localdomain ([103.210.91.42])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396689f1419sm4660649a91.9.2026.08.26.09.21.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Aug 2026 09:21:18 -0700 (PDT)
From: Khawar Ahemad <ahemadkhawar123@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	magnus.karlsson@intel.com,
	maciej.fijalkowski@intel.com,
	sdf@fomichev.me,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Subject: [PATCH bpf-next v2] xsk: Fix circular locking dependency in xsk_notifier
Date: Wed, 26 Aug 2026 21:51:10 +0530
Message-ID: <20260826162110.99879-1-ahemadkhawar123@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

syzbot reported a circular locking dependency involving &net->xdp.lock,
&xs->mutex, and netdev_lock_ops():

-> #2 (&net->xdp.lock):
       xsk_notifier
       unregister_netdevice_many_notify

-> #1 (&xs->mutex):
       xsk_diag_dump

-> #0 (netdev_lock_ops):
       xsk_bind

In xsk_notifier(), xp_clear_dev() was called while holding &xs->mutex.
Because xp_clear_dev() acquires netdev_lock_ops(netdev), this created a
nested dependency of &xs->mutex -> netdev_lock_ops. Combined with
xsk_diag_dump() (&net->xdp.lock -> &xs->mutex) and device unregistration
(netdev_lock_ops -> &net->xdp.lock), this formed a circular locking cycle.

xp_clear_dev() operates strictly on the buffer pool and net_device, and
does not require &xs->mutex once the socket is unbound by xsk_unbind_dev().
Both xsk_notifier() and deferred pool release are serialized by rtnl_lock.

Fix this by capturing the pool pointer under &xs->mutex and calling
xp_clear_dev(pool) after releasing &xs->mutex in xsk_notifier().

Fixes: 975b11ae9077 ("xsk: add socket allocate, create and bind")
Reported-by: syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=aa48b5fe7bfda62d1682
Signed-off-by: Khawar Ahemad <ahemadkhawar123@gmail.com>
---
v1 -> v2:
- Resolve the circular locking dependency in xsk_notifier() instead of
  reordering locks in xsk_bind(), avoiding ABBA lock inversion with
  xp_clear_dev().
- Preserve user-space errno precedence in xsk_bind().
- Reference the correct Fixes commit 2495b430e382.
- Link to v1: https://lore.kernel.org/bpf/20260825152152.86092-1-ahemadkhawar123@gmail.com/

 net/xdp/xsk.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/net/xdp/xsk.c b/net/xdp/xsk.c
index 7855ee09c4..c2f47182dc 100644
--- a/net/xdp/xsk.c
+++ b/net/xdp/xsk.c
@@ -2106,6 +2106,7 @@ static int xsk_notifier(struct notifier_block *this,
 		mutex_lock(&net->xdp.lock);
 		sk_for_each(sk, &net->xdp.list) {
 			struct xdp_sock *xs = xdp_sk(sk);
+			struct xsk_buff_pool *pool = NULL;
 
 			mutex_lock(&xs->mutex);
 			if (xs->dev == dev) {
@@ -2113,12 +2114,16 @@ static int xsk_notifier(struct notifier_block *this,
 				if (!sock_flag(sk, SOCK_DEAD))
 					sk_error_report(sk);
 
+				pool = xs->pool;
 				xsk_unbind_dev(xs);
-
-				/* Clear device references. */
-				xp_clear_dev(xs->pool);
 			}
 			mutex_unlock(&xs->mutex);
+
+			/* Clear device references outside xs->mutex to avoid
+			 * lock inversion with netdev_lock_ops().
+			 */
+			if (pool)
+				xp_clear_dev(pool);
 		}
 		mutex_unlock(&net->xdp.lock);
 		break;
-- 
2.54.0 (Apple Git-157)

