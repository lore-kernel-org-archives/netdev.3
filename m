Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639D23B8BDA
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 10:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787741575; cv=none; b=QWNItqjlLSe8K4QPc9YKe5TUUd/T1ODJoIDVLukNOnaFiUVlfc6O0yNHlgaHD8WvHxm9mAkNv9RXMEyy7k8QGG6PAVJ/wwvpBAWD7N06fTwDU9zYTJIx5ftOqUbvhJ3P59DIjNmye+qeeYWKUe+pFGkNBKrD+KcwO10qHdNyKy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787741575; c=relaxed/simple;
	bh=/ls5BeKpLATZSEMrx/GBfxNGWerB1035CuzGl0Rdg+s=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=K/5Xle3HVyNt9Ydqh1YXXb4V7NBmk4I05E/iVdtWIh8LIDfS4LGafWRU/lno7FTb65pMHY+7p/dz/XraWUIyE+TINISj/UC5sUZZp8WV+2NflKDioLu5RTTVwG3HBwbS5eF85JMNu/oRbJSZdiVRTzzxH/ivY/cuq6bQRQDb5XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YiVgAFIk; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YiVgAFIk"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93771aa0379so94923785a.1
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 03:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787741559; x=1788346359; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lr1+9ZYzYrBn8/7Vq1xvFhGGkMuHVqAfPU69pyc2DgU=;
        b=YiVgAFIkVz3XiIoEZYNsi/oNXrdhzFSzf6b6ymOCFt9/PuSvuNMow8oSdEAkDUYUsQ
         RHQRFl52OE/b4jWdgsq04OtV5vHEjJyOx8lGAUF5gmBn9x/mhtyFosUyuCSrv7FPsEPW
         vwqDNiTjchDDOfzQOP5NcKHWGjgrCyHiwP2g2kFMfP8zFeNmjKUSBrvuKYGUlErXt6G/
         3AVDOZn8q0XZAMcgYxmuFSUzGsIg9Kl82/0BfnB1PdCxGtKiH7205M49pJbO7SG4rRkh
         ZhaBSVzGhPIJVPqQli7OlJgYiTPBBupgpBH/SK8NshdIGe8Itr9BtcbIpSayVq1wAoxR
         5Rpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787741559; x=1788346359;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lr1+9ZYzYrBn8/7Vq1xvFhGGkMuHVqAfPU69pyc2DgU=;
        b=nF4JjNYM/iifGejGEo7juCGYOdJzptXzQT959fduUO6vM+zmZ+er4dVbKm6+kkGyZw
         5ZnuUUcS7M1Qku8IEmAwK75BWXNS0mbI7SXJkCtOIWx+tJw7E2hhvyt9AZHW2l0QPSwC
         Fp1SZfmRFseNtWsP/HLgJS4TURS3ejoIJhv17wEnscf6zfdMGi6k/0rRdccPGvah2K3z
         6bMKxwSN1tyfbvvfigqvVOjHVyYWSrxH/ZpdEGRs2bVOGgEYIXVUas+AnGopW8VV5nwJ
         uPF6vnCJXySqiOD32znw7rC6O0fFzT8gqjf0X1nlg6FE8pEi3ofqoynbGDJFvws+4Vy6
         +K0g==
X-Forwarded-Encrypted: i=1; AHgh+Rqbai3JO28Ub1sh29N3WKFDb08FgiY1kHPQBWwZbDIHKClUil022P6Ywi4eddeloiSLMq5B6WQ=@vger.kernel.org
X-Gm-Message-State: AFuF++k4HLIEbD9Oax+cQdC8QNCAzTuJ+D+BQaz7GsBBUM/rkm23pdwc
	b75izOrjaOJ230+K3gKte/7IpE6MTChDXOMQvy2pEB+vs7tNHg2YdsWB/jUU2IZeH476OfYxARU
	r3ySoIPOHNlAwlQ==
X-Received: from qknpy6.prod.google.com ([2002:a05:620a:8786:b0:915:80bb:1689])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1265:b0:938:8ddb:5e9b with SMTP id af79cd13be357-9388ddb60famr35322785a.8.1787741559119;
 Wed, 26 Aug 2026 03:52:39 -0700 (PDT)
Date: Wed, 26 Aug 2026 10:52:38 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.860.g4b6b3295ed-goog
Message-ID: <20260826105238.3323436-1-edumazet@google.com>
Subject: [PATCH net] slip: remove slip_hangup() to fix use-after-free in slip_receive_buf()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Jaeyoung Chung <jjy600901@snu.ac.kr>, 
	Eulgyu Kim <eulgyukim@snu.ac.kr>, Qingfang Deng <qingfang.deng@linux.dev>
Content-Type: text/plain; charset="UTF-8"

Jaeyoung Chung and Eulgyu Kim reported a slab-use-after-free read
in slip_receive_buf() when racing against tty hangup.

tty_ldisc_hangup() calls ld->ops->hangup() while holding only
a read lock on tty->ldisc_sem (via tty_ldisc_ref()).
Because slip_hangup() simply called slip_close(), it ran concurrently
with reader functions such as slip_receive_buf().

slip_close() unregisters and frees the net device and its private
struct slip, causing concurrent reader threads in slip_receive_buf()
to dereference freed memory.

Line discipline close() is already guaranteed to be called under
the write lock of tty->ldisc_sem during hangup processing
(in tty_ldisc_reinit() or tty_ldisc_kill()).

Remove slip_hangup() so teardown is serialized cleanly by slip_close().

Fixes: 5342b77c4123 ("slip: Clean up create and destroy")
Reported-by: Jaeyoung Chung <jjy600901@snu.ac.kr>
Reported-by: Eulgyu Kim <eulgyukim@snu.ac.kr>
Closes: https://lore.kernel.org/netdev/20260825150655.1450271-1-jjy600901@snu.ac.kr/
Cc: Qingfang Deng <qingfang.deng@linux.dev>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/slip/slip.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
index faae711cf793d3f2351f67dfaab6abb2d2b72b19..ac0fc59c8c2593f3d9d501d7bdfcade7bf0de47d 100644
--- a/drivers/net/slip/slip.c
+++ b/drivers/net/slip/slip.c
@@ -881,8 +881,6 @@ static int slip_open(struct tty_struct *tty)
  * Close down a SLIP channel.
  * This means flushing out any pending queues, and then returning. This
  * call is serialized against other ldisc functions.
- *
- * We also use this method fo a hangup event
  */
 
 static void slip_close(struct tty_struct *tty)
@@ -910,11 +908,6 @@ static void slip_close(struct tty_struct *tty)
 	unregister_netdev(sl->dev);
 	/* This will complete via sl_free_netdev */
 }
-
-static void slip_hangup(struct tty_struct *tty)
-{
-	slip_close(tty);
-}
  /************************************************************************
   *			STANDARD SLIP ENCAPSULATION		  	 *
   ************************************************************************/
@@ -1275,7 +1268,6 @@ static struct tty_ldisc_ops sl_ldisc = {
 	.name 		= "slip",
 	.open 		= slip_open,
 	.close	 	= slip_close,
-	.hangup	 	= slip_hangup,
 	.ioctl		= slip_ioctl,
 	.receive_buf	= slip_receive_buf,
 	.write_wakeup	= slip_write_wakeup,
-- 
2.55.0.860.g4b6b3295ed-goog

