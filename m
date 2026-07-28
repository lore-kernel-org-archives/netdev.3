Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6275A34041B
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 16:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255709; cv=pass; b=grn841oF+ItgJ+4cYs44558vOLEflPzomwUrQVftg91DUCxclCB7TRfqDADJMq9Wvju3jLF8ip6laO1l242NCPY09e4MyEtK8FtFQEGVkF6XJsd7CjwruwMJao/mXKvXB9tVqGHNqlbwj4j6k82km6HDFPZ9MOZwljO8eL32zY4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255709; c=relaxed/simple;
	bh=Jk+DuIcPI1GcugEemQ5xJBOfl2qmWql3hYohtyA2IEA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=R+c1AgqwYaTIksXqSIPj1RyjGg0vVqmp40BeP7cmE32fV9A6fTQfwO58MIShPFwQgJB80bbMSrsiYIGRay9U3vH0X10w439Zw4Vc+OfKOOZamyB/9VtlhZVz8C3+X8QuQOeNDRZfFup/MfXGTsbM3+rTf3C8sbqXu2DQpx4v2fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XnGBmWJz; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnGBmWJz"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c15ca7a7ca9so2874066b.0
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 09:21:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785255706; cv=none;
        d=google.com; s=arc-20260327;
        b=iF9zpJFJuD6XtSEIfYn3E8Hxec1RCG4sFMddmeU5J4dCXXNrb9GO6O2sSbmpVC9t/8
         iYUogJonK6kxCP8h/XmeTdwnoxYpTow8dajckt3fP7Befz6FxQNIReYamuHheCd54MPP
         M35gaty4wc0Ky8nwGE7s8RNoOQRrLNC/h5lscUNQ/+/kGTRp/amkTvETevBjch6cTR9h
         2Y+m4392jpEQPeTwCJFtCmE6p3NUkWu1ZL9FnSih8gf3whPK5ko3jKb01DNcv5mIB5+W
         l0t7hEm/PM+bhZ5aoD3yQieh2xvNldMgu5HxQecuYsOH891EAAx6aaVmts+zmEUnY9kb
         fNeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=aSACA+rojs2I/ZtJErAjFTUM8LM1UmDZ8O99mcrYQi8=;
        fh=Xe8tMI3VjrhyVGPgSH69FhXgIYgezvIHFtF2DWDiJMk=;
        b=OYFCfpl5yh4w7G8xusUeSJZnfVn4n68IXFHFtwY5cCqMPyWdBkqfYyHXHEbp/TIfs4
         hOrQAKaVGa8Vff8ejFbIMVaHf4pWGTy+QaQqlm+nGYzvYr6D0DrQvNsdCTGW2+exOX9e
         89fYZ9/a+N6++jR/kcU/qW4YPwcTzNq92gFZyj9gGSvreIoxdd5jq1bTehgjxwPkLjrj
         wxoD32qJ8P+zkpEZrY0170WEwxrGV946eeTeA9XG7iC42zJA1ETSonTWVciwj3K871GN
         8Oyda/wrnrAkqPm2XNCZHVtuqq6xtVdRlKq4BSBt7uu1sqOIfiCS1dE8gF74hDeUqZPe
         E3Hg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785255706; x=1785860506; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aSACA+rojs2I/ZtJErAjFTUM8LM1UmDZ8O99mcrYQi8=;
        b=XnGBmWJz/8Aa9KTlEN0HM1jLVTFeHvCxnW635KhZU0X+Raz/OQYqKl+plH0LsboXeB
         cutTNTlWPGNBWNefdLxrrSbc9bhEkLAxsCrRL956IDMY8tgPmglm2weKQNAS91LMmyNW
         uDN7Ia1N/+aW7bTSUwnaPa/hv7Wkz7xYy30EkrPixqTesgKAuvQVerkXbrSd/sKuS6nK
         2AObn9o1qe1365gIXZPOLVWoDgxJUfw2f/vfYmfAvV9ygYLODYPeFk6NoeJQDg70LHw5
         vPEykkWxf+0X0JQ7gcDpCRCowBDq+1Aqo1A+QXgzV1U00rJkpTTbZ3Au5MWQ4ubDr1z7
         0ngA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785255706; x=1785860506;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=aSACA+rojs2I/ZtJErAjFTUM8LM1UmDZ8O99mcrYQi8=;
        b=NbJB9W504zP51xcUxK+S/IWrOpA/6DiKI5Fv3BUy4Kqrse5K7t8SN7rKTTqUMFtikn
         uAUjiqSriSHUxXrNOYLnOKfPZRpVc4gcJHyyYhQie3y5wimGCBeGDe8GzPSOHtwqZGyq
         qRbM7e6ZBsbI/e57UDkuvZYrrKhMuCtV0HD1j/DKrm4oa6eILhK9pT8QypvQ/wYR272V
         CWO/AovMx1todw1U1bM9HBMjwhbXWu9HYcYB8AJZD81L37x1cueB7wWM1CiTaBzrVRZx
         aSeNy+RolK7+H7D7/JEAS2F41uWStiHuhtalXv5pH5ZztPsdxug2gI6YZ1yUomc+Fj+S
         Owug==
X-Gm-Message-State: AOJu0YxKSw+WSQfqFub1dSwFeesXg+456v67DJNMDJygZ42mqXxw/j8r
	gbbG/rabRv3cT27lthfbP6wJMFuSLoOji34vv1HvQtHdRaqQRvyq8D7hMvfrhO7pADoxRm5Ixg7
	LxJhGKPeJ+JfyMZboF4te8BQ69zWwLD49auprTFw=
X-Gm-Gg: AR+sD13Ec4Mvzqo9QWtvvyVmwzsQ38DMveQZJkdrVj6PxO0aTFXXfhYvHGMH3+7WKC5
	xB4mF7wa4Mu/zP38zfFXPL86UPXUgyfVqPC5yjoHLHdMU2H7xiHYma0pXmdDjQlE9nwdV0Le9he
	1juDd2Tq7QpgHRRXG6AY1jeJpgizwycEfq4wcDktl+kdHDYnAdABzbUsalklvePtI5Jw8zVZAdS
	KuPznzrDrkUTpRobqkm54qC8M9Jx3vYZIwv27kSIvgz8DU56MgZ+kqrbvlnRz/4j1ZL0F8eIuzw
	HcqtyeyKTO/lDwwn16ZXdRysFDRDtQvjlddg7IBHpE4RbQ==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:907:6090:b0:c15:b4f3:6d25 with SMTP id
 a640c23a62f3a-c1f721bd9d3mr164216566b.19.1785255706278; Tue, 28 Jul 2026
 09:21:46 -0700 (PDT)
Received: from 1051196574424 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Jul 2026 09:21:45 -0700
Received: from 1051196574424 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Jul 2026 09:21:45 -0700
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Tue, 28 Jul 2026 09:21:45 -0700
X-Gm-Features: AUfX_mx8DJLaXoWOlAavAXFn13zlzy4RvDxvrl6Do2e2q2ZD5lpazoYqqv17suQ
Message-ID: <CADqcGBkVewfYCirbeusDW1xbs+mFs9ditaBX7KzG6NcM=xpm9w@mail.gmail.com>
Subject: [PATCH v1] af_unix: fix use-after-free in unix_stream_recv_urg()
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kuniyu@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"

unix_stream_recv_urg() reads out-of-band (MSG_OOB) data from
unix_sk(sk)->oob_skb.
It saves a pointer to oob_skb under sk_receive_queue.lock and state_lock,
and then drops both locks before invoking state->recv_actor(oob_skb, ...)
and incrementing UNIXCB(oob_skb).consumed.

Prior to commit 8594d9b85c07 ("af_unix: Don't call skb_get() for OOB skb."),
the OOB sk_buff held an additional reference count. When that extra refcount
was removed, oob_skb became a bare pointer into the socket's receive queue
without any lifetime protection once the receive queue lock is released.

Because unix_release_sock() does not acquire u->iolock during socket close,
a concurrent close() on the socket races with unix_stream_recv_urg() as follows:

  Thread A (recvmsg MSG_OOB)            Thread B (close)
  --------------------------            ----------------
  Acquires iolock & queue lock
  Saves oob_skb = u->oob_skb
  Drops queue lock & state lock
                                        Acquires state_lock, sets TCP_CLOSE
                                        Sets u->oob_skb = NULL (locklessly)
                                        skb_dequeue() & kfree_skb()
frees oob_skb
  recv_actor(oob_skb, ...) -> UAF read
  UNIXCB(oob_skb).consumed++ -> UAF write

Additionally, unix_release_sock() cleared u->oob_skb with a lockless plain
assignment. This creates a KCSAN-visible data race against READ_ONCE(u->oob_skb)
in manage_oob() and unix_stream_poll(), both of which rely on all
writers updating
u->oob_skb with WRITE_ONCE() under sk_receive_queue.lock.

Fix the use-after-free by taking an explicit reference via skb_get(oob_skb)
while holding sk_receive_queue.lock in unix_stream_recv_urg(), and releasing it
with consume_skb(oob_skb) after the data copy and consumed counter
update complete.
This guarantees the sk_buff remains valid even if a concurrent close() dequeues
and drops the queue's reference.

Fix the data race in unix_release_sock() by wrapping the u->oob_skb clear in
sk_receive_queue.lock and using WRITE_ONCE(), matching the locking contract used
by all other oob_skb update paths in af_unix.c.

Found by code review of AF_UNIX OOB lifetime management after commit
8594d9b85c07,
and verified with a clean build.

Fixes: 8594d9b85c07 ("af_unix: Don't call skb_get() for OOB skb.")
Cc: stable@vger.kernel.org
Signed-off-by: Muhammad Bilal <meatuni001@gmail.com>
---
 net/unix/af_unix.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index f7a9d55eee8a..011ea88d57c2 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -689,7 +689,9 @@ static void unix_release_sock(struct sock *sk, int embrion)
 	unix_state_unlock(sk);

 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
-	u->oob_skb = NULL;
+	spin_lock(&sk->sk_receive_queue.lock);
+	WRITE_ONCE(u->oob_skb, NULL);
+	spin_unlock(&sk->sk_receive_queue.lock);
 #endif

 	wake_up_interruptible_all(&u->peer_wait);
@@ -2773,6 +2775,7 @@ static int unix_stream_recv_urg(struct
unix_stream_read_state *state)
 	}

 	oob_skb = u->oob_skb;
+	skb_get(oob_skb);

 	if (!(state->flags & MSG_PEEK)) {
 		WRITE_ONCE(u->oob_skb, NULL);
@@ -2793,6 +2796,8 @@ static int unix_stream_recv_urg(struct
unix_stream_read_state *state)
 	if (!(state->flags & MSG_PEEK))
 		UNIXCB(oob_skb).consumed += 1;

+	consume_skb(oob_skb);
+
 	mutex_unlock(&u->iolock);

 	consume_skb(read_skb);
-- 
2.55.0
