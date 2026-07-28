Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 148E236C9C2
	for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 16:15:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785255336; cv=pass; b=Y3l2FgmWgw/amhj9+b7DgghasX0zpwO4S/OC6drWNYo3SLiJz2Gn7SJqUTTg8DByZmYjgIQh94JZmOK/lgC1kkplxLiVbqsINn8moPkdBB/8t66EZFYJA2bv9AIE/9DbQVIX2HIUJsLXO0YQ9I6chYl16j6XWSbjyLHzj46ruCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785255336; c=relaxed/simple;
	bh=KL8JYzXFUfnOn1522aC8QaerT3EkTgrcZ23WbEjsBuY=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=aFyFTpOg/XRKESkhVihgS3C4pgdlXwLgR6eLeagg9PhPjFl2WJmZFyDDejW40BcLlPutowHOn/9j78ZGl6NPL8h0FOcvnHKJUcOfj0vr72Xc6LhRcqp4fZh2dm4xEMzuu00M9X93EMayK/H58fUh0FCU/92GWl9B6TdgGE0Afis=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=tG2hKCkC; arc=pass smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tG2hKCkC"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c1f7666a90bso237566b.3
        for <netdev@vger.kernel.org>; Tue, 28 Jul 2026 09:15:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785255331; cv=none;
        d=google.com; s=arc-20260327;
        b=Lqmff3Oaqcsf1htQMGQ/U2R6GH76lshR2fxmSdJ+N6ETzx8r5foEuJa0n6jXOooM3m
         UuythbahyNnV4KWgP4J6YGU8u14KTSatnCia2xJ78mAC8rIIB0Dx7kICoy18OzmNUwJo
         +g01nNMQ8i7Lv5p5Jr8KRVR60+X/KtkHYWTK54moAHZL2GVrxbeEKn7c/yINa5NKWci4
         9qMRBku5YrkwjlHqFf4rrtV1IAOucsjHqAUxSzONeU/KhWd+5c3JT1OhR2FL8LffwbTs
         M82M1hI/V/fLq9snk/Q4Yuau933Zg0y8gKq2dXmO5XwaqeQ+J27FYECFIoZ130DuyrFX
         zNog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=NwG2qX3S802a/UrNfFrfBBHuEoTh6esKMzTZ9OPaRtA=;
        fh=Xe8tMI3VjrhyVGPgSH69FhXgIYgezvIHFtF2DWDiJMk=;
        b=cCdcwP0p+ygl/lE0CM/0xJXEyAdAxoI/sjVaUeuJuSuPLtk/60VT/ZDspJysdqo9Ui
         suHOnXuWZx7URtVSYfBDUM2YBfjSemcCZaSsGOfuZEesBtYSY8GoCJdOd73PV6A76P3R
         FFSaOYnKAKuDyesAZCI66Z6KfiWwB9TuYTrHG0/UtTGCeyBnxhogigte08y4r0FE/SVi
         tTvNvx78c2BqZmcDrwQslkpX5U3Ym2+k3fOvsLvQPTRhBpYUnSLoNYpCyt+AP9CZU+Ll
         n2eZPaJ3q657zCYCvbYmPPFq5C8yfrHPxZaejk9cYD8ADDwTpGZLjY8sYeH/ddWCAnYP
         5+Mw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785255331; x=1785860131; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NwG2qX3S802a/UrNfFrfBBHuEoTh6esKMzTZ9OPaRtA=;
        b=tG2hKCkChFWnbSY9R5mb518ccMneJlYRHu/H7FXJPeNgDVOUomyjLmpW+6fQjMv13p
         0pidA1D+eI3/SZdLfiSndla6N621oAkAwR7r61Z4tdI/Dx8zHsAvyRVstMPT5I1+Ll6c
         VHF1kFQBaudYnkg4uaqQi101fDVgYybqwowYw90E9EF9P7L4tApQWRu631KbsA6pGco3
         CAmzveChNlvLploCymbPDuKyi4iv3HfSLqoMUvdkGlANVhEwMOkaKV2PNBvhzsVUXHAp
         xpIVLwZkNOhs5T5CE68DEOH/Wi+bZIshJ4KWkWU6OWEvpueFemP8c/s2zGAPVUwHT2yu
         7Lxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785255331; x=1785860131;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=NwG2qX3S802a/UrNfFrfBBHuEoTh6esKMzTZ9OPaRtA=;
        b=hHHhBWj38uQUNNPIrybTVMlCBvSvBdzEFeQZ9MtfcdrhP2BBY5WcDsxMPgNZlT9WBH
         ChNMvfJHUUfSVxs0IZcFZfK0HRzeKjbsm0sBYyUe3pYpJm5A5ArWQCJZdXY083d1DYca
         TlC5XcH0mL96hQTH39+Ju/RBsB2I9HR94VLHQR/uRJQdl4b8vfAgyK9Qo9TDmXhYVRPL
         tM5tjA7hm0b1sN0UIGeIsVE3EbHIt2RQ8xW7S/mPcBQaaskUN0k8VtC1YpO2JkLFNpTG
         +vwlOfeCQL3QyIgiQ2feqmxfLrlcd2RElk6fPU0/3Cy3TMkm9pquljluNbdIJZI7qJRM
         RLFw==
X-Gm-Message-State: AOJu0Yx3+oR6BJziE+lB+fgRAHU2BwX0PrjPUvfKLs0ThQ15p3QpUWua
	xuiMQex3xQhY1iu6rXYckvvYgPIynczLMNfSCWhLkGXdTf3BYYPuPMhVWYuWWXB6+sU/513hgsn
	6ETpINH5lI5KQK93cwlmAhx42tk0N4/LpwYvN+H0=
X-Gm-Gg: AR+sD12X7Do4OcU1fWw4AGcY/mbh9p1Qipj0NtXE2+YER4znE+2ETGdiMaw649lBt31
	wCAAhbfbQv3wTEryghX+ZM9mR96UTlCrAzZaiZaxiC4238m3OeyAkpoWlybVPZ9uSr5xu+OQhOb
	Z83bma2MuUK5XgmbvoM/KwdDASejX6I86MsT0FBmG2xSfXacu/pFmiaqip1qOD1b5uU0YDhn/3G
	8e7qQl/FhI9+Ds1WNqWeUP8p5SNslElSWStPmCaY4BQn6L2ajIzNPlpKPkT8iVUIpxW82Ygga03
	NcsyxnD2QaPyoGNrNlgVFRmk0apqdhjrBnVjNdJ85mtFQA==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:907:e00c:10b0:c1f:83a2:ffca with SMTP id
 a640c23a62f3a-c1f83a342f7mr10564366b.40.1785255331297; Tue, 28 Jul 2026
 09:15:31 -0700 (PDT)
Received: from 1051196574424 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Jul 2026 09:15:29 -0700
Received: from 1051196574424 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 28 Jul 2026 09:15:29 -0700
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Tue, 28 Jul 2026 09:15:29 -0700
X-Gm-Features: AUfX_mwVDCsiQodQ_vysqlyLF8YOibZ8YWZaF0Uc7AsXlBDK6CWDPinFdX4Hb70
Message-ID: <CADqcGBmFyNEhE74Y=jn9cuT17nFw4wprEia7pVqoVkV2eQcgJw@mail.gmail.com>
Subject: [PATCH v1] af_unix: fix use-after-free in unix_stream_recv_urg()
To: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: kuniyu@google.com, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, horms@kernel.org
Content-Type: text/plain; charset="UTF-8"

unix_stream_recv_urg() saves a bare pointer to the OOB skb and then
drops sk_receive_queue.lock and unix_state_lock before accessing it
at lines that call recv_actor() and update UNIXCB().consumed.

After commit 8594d9b85c07 ("af_unix: Don't call skb_get() for OOB
skb.") removed the extra reference count, oob_skb is just a pointer
into the receive queue with no additional refcount protection.

A concurrent close() via unix_release_sock() does not acquire u->iolock
and can race as follows:

  1. recv_urg() saves oob_skb pointer under queue lock
  2. recv_urg() drops queue lock and state lock
  3. unix_release_sock() sets u->oob_skb = NULL (locklessly)
  4. unix_release_sock() drains receive queue, kfree_skb() frees oob_skb
  5. recv_urg() accesses freed oob_skb via recv_actor() -> UAF

Additionally, unix_release_sock() cleared u->oob_skb with a plain store
outside any lock, which is a data race against READ_ONCE(u->oob_skb) in
manage_oob() and unix_stream_poll() which expect all writers to use
WRITE_ONCE() under sk_receive_queue.lock.

Fix the UAF by taking skb_get() on oob_skb while holding the queue lock
in unix_stream_recv_urg(), ensuring the skb survives until consume_skb()
drops the extra reference after use.

Fix the data race by clearing u->oob_skb in unix_release_sock() under
sk_receive_queue.lock using WRITE_ONCE(), consistent with all other
writers.

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
