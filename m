Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62EC2392828
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 20:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775852000; cv=none; b=bP3Z0QoJzxou1EMOvmrfGPXYMVgUnZ2ExHaYaLmPvDTTMQQ6BXHUeknSOqEIFGhfI+sabQ+8MS8s5yEwL55YaSG2uYvtVyu6Ac2vSoOOJk4fTbSIHIJ8F4NN5RBp2SWkD7docvT7JbdJ/4k60lBpdK0lPHQiWtbhqBwxBUduntk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775852000; c=relaxed/simple;
	bh=qiRcrLqgsly/sA58JHzcA1Yo5JF3HlyznqHytmQzUDg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B+Pk5r5InnOfOHmWS1nb4GM3/H8VvOMGBR8fdiphlhkXa0YMv3jAGDN3Dn/w7m0oluhCAZFgmmT2r4Bzvtk7BjFKBKSkJPBs9P9tePD6dVuLDimh+F6IWKfeYQfxRf+NwyBDO1w9/w3A4pZJzUhCbZ30hrfs1UDp2j1Rn8uHgrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i4fUbZAM; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i4fUbZAM"
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82c7ec40f92so2408832b3a.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 13:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775851998; x=1776456798; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=UqaTGJhN3710wR5/WAiTwoeY86F0ZEdJtqmdan8PJQE=;
        b=i4fUbZAMBg2oMhovLkuQUnpFBUg9ncYy3OvbraDRvVBSKUPNheT1KRiuwZtEmcrHit
         PvZskVxzLb4sk6FbzQeHDwI39gDp1kGJd//ibEyxRysIXCoL+HMsPLY5ThskxIM4DdpS
         RyxnPYg82SRSzp8JUDH9UabM/RRm5kmFMv55BhFhXXGg7MnlwP6Qoq6ex7o/M9PMej3Q
         q4Nu9Hu1OpPtFbjCF29XGSPoA1NN9dj8fLRty15EBX8/yMulq0jKKHT6SQMfJyBEVNvR
         oozGOdi3NZjEtB8cmbUBY2x0m97w1i+fj4ahbZn3gvKHviNOBLd5zDA1GI54BFWdVALn
         39Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775851998; x=1776456798;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UqaTGJhN3710wR5/WAiTwoeY86F0ZEdJtqmdan8PJQE=;
        b=DIWkWyu4nAb7xThbvgIBvtt0i7AUPVUb0QuK1p5BoXQYAyrw8+DGCcVTP2sNSJWnFH
         GNvQtISPE53d+Mn9T1U+ChEERQBStcHprqn0ce+uIbzyvzs6YrWi+9PgUeIGc/TBdYWC
         m/xhQZBLw6lunzTMh697BqxjqhPQ6Rb9FkGyZ+QDSQ614sQh3NkFy4cI3oWl37FALPn2
         vK1YN3uXI+9KNNuDQYpMDuDzpkMEIH1PKqVERfIxWKTbQAxgK8OwsOr2YZMDAB0Xc/JP
         zP1nOoei/QzFVViR4pt88HuQ89dbUOpYicLLlSgIrk50oneHDX8Sj525FBSvkzcNzmJn
         2H/g==
X-Forwarded-Encrypted: i=1; AJvYcCVqK9+BW0Yfbbw4i7UuTGXkk9RAUbMR2QD4tkcCHqD6aslp4Zi0iAwQqBqmftOAHAiEM9YpMCY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3yLrLDz50l+PzTBCAt9KAP0vzW6Jc2BkgrPi0r1ka7kj7J7PP
	2wKnvlsXvUqh6IYrb2Bss51nX0AUbGVntaM9LrtEWoW4L+FrTfDv7Q/WHRjMqFdj72yzIvGgPh9
	0PC6xnQ==
X-Received: from pfbbj3.prod.google.com ([2002:a05:6a00:3183:b0:82c:e71a:ff8e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:a217:b0:82d:1faf:7748
 with SMTP id d2e1a72fcca58-82f0c2a7399mr5178809b3a.33.1775851997377; Fri, 10
 Apr 2026 13:13:17 -0700 (PDT)
Date: Fri, 10 Apr 2026 20:06:21 +0000
In-Reply-To: <f6cbbc8da90e95584847b5ceb60aae830d1631c2.1775731983.git.wangjiexun2025@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <f6cbbc8da90e95584847b5ceb60aae830d1631c2.1775731983.git.wangjiexun2025@gmail.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410201315.1573403-1-kuniyu@google.com>
Subject: Re: [PATCH net 1/1] af_unix: Hold receive queue lock in ioctl(SIOCATMARK)
From: Kuniyuki Iwashima <kuniyu@google.com>
To: n05ec@lzu.edu.cn
Cc: bird@lzu.edu.cn, davem@davemloft.net, edumazet@google.com, 
	enjou1224z@gmail.com, horms@kernel.org, kuba@kernel.org, kuniyu@google.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, rao.shoaib@oracle.com, 
	tomapufckgml@gmail.com, wangjiexun2025@gmail.com, yifanwucs@gmail.com, 
	yuantan098@gmail.com
Content-Type: text/plain; charset="UTF-8"

From: Ren Wei <n05ec@lzu.edu.cn>
Date: Fri, 10 Apr 2026 14:31:57 +0800
> From: Jiexun Wang <wangjiexun2025@gmail.com>
> 
> unix_ioctl() peeks at the receive queue and may check both the head skb
> and its successor while deciding whether SIOCATMARK should report the
> mark. However, u->iolock does not stabilize receive-queue element
> lifetime. Queue teardown paths can purge or splice the queue under

Please be more specific here.


> sk->sk_receive_queue.lock and free the skb while unix_ioctl() still
> uses it.
> 
> Take sk->sk_receive_queue.lock while inspecting the queue so the skb
> and next_skb stay alive for the whole decision.
> 
> Fixes: 314001f0bf92 ("af_unix: Add OOB support")
> Reported-by: Yifan Wu <yifanwucs@gmail.com>
> Reported-by: Juefei Pu <tomapufckgml@gmail.com>
> Co-developed-by: Yuan Tan <yuantan098@gmail.com>
> Signed-off-by: Yuan Tan <yuantan098@gmail.com>
> Suggested-by: Xin Liu <bird@lzu.edu.cn>
> Tested-by: Ren Wei <enjou1224z@gmail.com>
> Signed-off-by: Jiexun Wang <wangjiexun2025@gmail.com>
> Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
> ---
>  net/unix/af_unix.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
> index b23c33df8b46..54f12d5cda37 100644
> --- a/net/unix/af_unix.c
> +++ b/net/unix/af_unix.c
> @@ -3301,6 +3301,8 @@ static int unix_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
>  			int answ = 0;
>  
>  			mutex_lock(&u->iolock);
> +			/* The receive queue lock keeps skb and next_skb alive. */
> +			spin_lock(&sk->sk_receive_queue.lock);

I think this is not the correct fix.

SIOCATMARK is apparently for MSG_OOB,

  $ man 3 sockatmark

and non SOCK_STREAM sockets do not support MSG_OOB
and should not abuse SIOCATMARK.

---8<---
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index eebabf0bd850..868b26c963ab 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -3299,6 +3299,9 @@ static int unix_ioctl(struct socket *sock, unsigned int cmd, unsigned long arg)
 			struct sk_buff *skb;
 			int answ = 0;
 
+			if (sk->sk_type != SOCK_STREAM)
+				return -EOPNOTSUPP;
+
 			mutex_lock(&u->iolock);
 
 			skb = skb_peek(&sk->sk_receive_queue);
---8<---
