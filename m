Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD023EEAE9
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 20:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788380528; cv=none; b=mkuU8JTVq50LtFsQ2AqxLFvxM9BB07wdK3U0y2FordI6rbAT/vtdG6L3FkgpRD9NkP/6Sp3k+90ijkwGKvMvPsnhPdvy1Zj8iQvyyqHz10tLkZLvI7A8UiOw4tdBA/7gw9PbC5VUZpyRADD9xd8C/KxJNX6hH1vWjoOGoEHtyS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788380528; c=relaxed/simple;
	bh=Ifjj33M8C/GMTqqu+oWRpsGS046QLRzs37W0a4ay888=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ehh3aqZwnBrHYyH1/zFR5ebZFC7oVfaKoRqx+vqetRVGAoWEH/tCqG21Y6VIFmI83hWeJY4upsePI3YBg2DeSeIaJCnL43vh/o4LoxrTT98jyPOgAmRK78fOxORSSTTWmCDUhMdKuWighjYDa0ny6ezrkHE06l9dqV68Ku+rqNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PsRyZbI8; arc=none smtp.client-ip=209.85.214.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PsRyZbI8"
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2d7293f13c6so20666845ad.2
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 13:22:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788380527; x=1788985327; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c/jVGVXgcxhO4Cwr4IvA8VgQeYVxY1W7sZCNw8BHXOY=;
        b=PsRyZbI8J6nveXE7NygS6BTwcMf3o8U2w68AYk1e1s/doLRaH4msm52ZtZToMM07FX
         NnK45WLga+OVm0aE2s39FlcV6pDjeN0HcLTpKcMxCS8R4dFPrgpzng1eIPxx8GS01VGE
         CDcv8rDusj+vvtuqrRhR82BL46q1iGiUGsHQRjbrj5LbHIahTqTgQXk6ue95YJ6gnW9/
         RT3BP7T+Vc/0CrZ8pTQ4Lzoq/XZ3ycfxTtMHmFMVS9D/XRFgyFSiCcFhASFOzUgKKKTN
         QzJ4h2V6tEiG9kIRhvTFB5n6DDVqZpndi330sY8rx9S5UWQ/v99jJrfgvdW7cSZddeND
         kh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788380527; x=1788985327;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=c/jVGVXgcxhO4Cwr4IvA8VgQeYVxY1W7sZCNw8BHXOY=;
        b=BxV7Q0VDuW79qyasZMSBG3oCopW95c//SjqQE7IuiQiF5haXin6hiPZRt0gECCu3fV
         e+oScVtf2OSlF9Jf385QL9AbJ+aFzedyp8j7SnqSupdGorxtFTiEDWM0czXj8DzKYOBs
         EHutCwtEF02SuBQHnOl9oE3+ElB0S/MiowiTOXi8jyHp6reuNtZ1X6U3Eh2xJ300jh1j
         wfDE1mHh04Lj1qsPoJSLDvmilOLPRhRhKZWZhx/BDxGd5wsACRC+ZlbbpS0gioFVA9WF
         /32RpIZSKFU1Oq1OnSq1MfxUH/KFq7rRLSpqnNmH9ojJjP6MK/DaLVqOmaWaeVqjNnYD
         6o1Q==
X-Forwarded-Encrypted: i=1; AKwUvBzgIgHaJbYQlNAsJGs4DGX4IWK3PJ5cP8gu9XkxuIieJntHv7tzwPNU6c6xO83tNJQeqQNeV58=@vger.kernel.org
X-Gm-Message-State: AFuF++lu663rrLTxSrpY/74pxALVPXTLldqwWH+W9h+1/fEDXv+iVsWE
	OhiZMgyBrebkzBaC328cNGMj3qKD+sZn5BbVNNXU4ODNjzmuOQt8raxR8p7ksubJZhH8hIFPP3W
	ydSC22w==
X-Received: from plgl1.prod.google.com ([2002:a17:902:f681:b0:2cc:6206:58ad])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a17:903:2281:b0:2ca:9d5a:8b6c
 with SMTP id d9443c01a7336-2daec5f4f13mr98520475ad.5.1788380526506; Wed, 02
 Sep 2026 13:22:06 -0700 (PDT)
Date: Wed,  2 Sep 2026 20:21:51 +0000
In-Reply-To: <20260902202202.892676-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260902202202.892676-1-kuniyu@google.com>
X-Mailer: git-send-email 2.55.0.970.g62bdec98f9-goog
Message-ID: <20260902202202.892676-3-kuniyu@google.com>
Subject: [PATCH v1 net 2/3] af_unix: Return immediately when manage_oob()
 returns NULL for 0-length buffer.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Fahad Alharbi <fahad@codepure.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Fahad Alharbi reported that recv(0, MSG_PEEK) triggers busy-wait
in unix_stream_read_generic() if recv() is blocking and the last
skb in the queue is MSG_OOB skb.

In such a situation, TCP returns 0 immediately regardless of
blocking or non-blocking.

Let's follow the behaviour.

Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Reported-by: Fahad Alharbi <fahad@codepure.com>
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 6861370062df..2da1017f8873 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2976,7 +2976,7 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 		if (skb) {
 			skb = manage_oob(skb, &last, sk, flags, copied);
-			if (!skb && copied) {
+			if (!skb && (copied || !state->size)) {
 				unix_state_unlock(sk);
 				break;
 			}
-- 
2.55.0.970.g62bdec98f9-goog

