Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604104;
	b=eaJZ6BzKG+VMZROujTlNgZiQHFph6hmr0VCdrALYA6yW8vccAYPONctTqMEvmTbnfsTG
	 ryoiXyzGekpW0+MQ58fMLwuhx9bT8vxzsDZLPJ6lQvdCeYLeDyT6YqXcN+At14YSljv4g
	 DEDrccWO1joNRT9Uwkm2BeFDUKubo16RkYsLpFHz2TaQptgKUn4NnAulSre5lFDW/hnK8
	 Y+eC5a2+TUCu7gMjXQfnoMUgUJH97gTzyboLUzauHdXgP4fluUZfuOeQJiHrO5mM18BAT
	 pRenYMZ3kF/0bmH6YWm+dvSRJE/bODS/Kv8MqbTBvj02AYPhkkXbYsYnfxiWV5Jg7GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604104;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=Lw6EOCCC6sbUctDXo+tERpXOU4fD8zFY96sMocjjruQ=;
	b=J7M4xDfq2//4EYu2z0FAttQd8e75FEKA+u1rcGUcCthK5yRxhxDOcfarzjEsLnrDPthc
	 fXW40Dvd+GpRuA9sHk4rir+oB+pGu58Ettb7u/eg/vrLAoF/1EKvda1hziot0GTo8MohB
	 Md4LJ65htizHMp82tMx8C6EhFPV4ZQba0FTttZp6EF+xNJGgzNVDP+k4vvcXm2Obm1U3s
	 lTCq07cVr7Y8SPm3W8aS5CQAruUUfw5chH4H+RgJio70BJPdlSRy/wu4v2Gem6h+UvLZ5
	 Xgrjj1GDqdzacBP8HvB6SL4VVb2ipm0+MHdK5fpz3pC3+na7YmSQS+MiiPaDG6Vpj2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="UdU7K/zl";
	arc=none smtp.remote-ip=209.85.216.49
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9E2606A326
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:21:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF9E2606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UdU7K/zl
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-3ae6b4c669fso2198881a91.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 23:21:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604103; x=1794208903; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Lw6EOCCC6sbUctDXo+tERpXOU4fD8zFY96sMocjjruQ=;
        b=UdU7K/zl7+AfYut04J2RYdwN/ElOPqf7v48tRRcqux9UpLJONFqejFO1m+Wr99ltvU
         BHe6ie/S4nOi1B1EbNXX+f3V/4lyKdddQC2Uba8BnuaoGLvZm5PasbW+2YHdUGZfnSEj
         PicmQbC/ROQCoWPof6Nc/fQFxB1fse3XkRwM8lk0h00M6ZJNjGxZEesPi9rzIRH8zq/b
         waJV2CqBsLsZmYFeTzvs83oFrL7RA1YuHFwOiArQA/Duej66C5LmFS9SeD+6Pe0/lhC6
         6W7iKB6N37dLyhdHC/il9yCqk0fZRVmt3A7Wkc2y6XBUbD2IPSkUulrJIhkI03E1CZD9
         4BZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604103; x=1794208903;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Lw6EOCCC6sbUctDXo+tERpXOU4fD8zFY96sMocjjruQ=;
        b=OTvcC/1XN4NtNcwhTCNwiqP+p1aIHEcMb4z864d9UqOdUL8J0tUlMvVT5eYdJWBfcD
         HZuUqOxyImu1apmi5GpqyeL524FQl2/BgRoJe4IMkUNjMAgcmD/G9NzUXgD9sE4mcQ84
         9e4LsBC6BjY38OMPCCptj+1O5rL3w4aVqbjkrU3ZZTllb5KvN8UPHAkXBVbKydEyi3Y5
         ghIxZXETEdmAH8bUJwEfSlj1owo17VPJFCeeOZc6vic1uBHW3fpzZSsn3ojUQQK0CVC6
         vVfDsQLgPg/OrRRKooUFop6dNmcJrG5JzYhxDngSNYu2WbxD/q5WzxG3SScvcDHkC/1+
         etkQ==
X-Forwarded-Encrypted: i=1; AKwUvBx4fcR4FCLf5cbKYbrz/GhX5ECdt19s1NILg+KEWLVFQLSA2FK9w8NQ2xuaCaK7HXfaEahc+xs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+tO7LN05l/4W8eqtjtqxQxVBNvpdcQv71mfVDGl+K58LVuq81H
	3Q5p9+aLQADLxHwfSOzxBeXvFOEGc+H3bZl0Rc7QhQ8In5W1eNKp+7Fp
X-Gm-Gg: AYBFou1z5dFpDj0SlmZBq/AMN81fWt7hYQRQdsKEuoasavimv/Djqs4nhDUm7aDq/nE
	Wm/3OngzUm8VIU2EthYyy0VMXf+nBzFeCFN6MrhDvz5teaV1RgWuP7iN6PFUWTfsHkpyMUW/ArX
	2PDyavipcMtMAQ6HsM7Z9Dwstm6EC1+kmjVe0bLzCLMm6eMJsVLDXu7OQ10TBYbfxOdwGMzkxlv
	8uTE/tT7+5ZlDj4ofQDv3LyJsJMyB2nrD08dgNK61jAAXCbsmDxop0nBzKUXVFxb+1KkL0df9Hg
	ZQRhAYYVpzpkFzUiWswmq+BFCKiUwmS2D0nv+jIR6U162lxgF/ymFZ1PbiZDyR14ixFzVxcuV66
	nySPjGKFppQTgU01hhrs1kyMZR0kEn0FqjYeE164uvqHjVAdpIYWxEFdgQ4UghKqSE2zDjix1+L
	/QXyhLns+MPfgKhDRcScUzyfQzGvtcaFr6cVKXV7NmjDlOlLGJZuXfu7tTSw5RzDIPUrG74NPue
	jYzivLkrtm94EWszn7D0t3zEvwZ+AqsSvWYu/DdItzxcuB8Um0IZTA5rwcDWFPmiT0amjPiF6tr
	4R5T1U9TfN1URRwaW/gTDyeipbZLCgkSjLUk+xZXKn706NT7GYaB5EpSuDhX6ipyqc9fxEKm9gn
	Yqd1shyLU9gNA1bLqOCSN/Gjesy5Ry6Mlh2rqk5IIxJGzOv3dEjzwePKBd//lJAG0xofJ4ZpDag
	s=
X-Received: by 2002:a17:90a:dfc7:b0:3ac:6e91:3f1f with SMTP id 98e67ed59e1d1-3ae6f00cccemr7838997a91.37.1793604103048;
        Sun, 01 Nov 2026 23:21:43 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.246])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cdb09814cb9sm2753697a12.24.2026.11.01.23.21.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:21:42 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf v2 04/15] bpf, sockmap: Subtract all dropped bytes from the return value
Date: Mon,  2 Nov 2026 07:21:01 +0000
Message-ID: <20261102072112.4160195-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

When an sk_msg prog returns SK_DROP, tcp_bpf_send_verdict() frees the full
message. It then subtracts tosend bytes from *copied, the return value of
sendmsg(). But tosend is the number of bytes that the verdict applies to.
After bpf_msg_apply_bytes() tosend can be less than the message size. Then
sendmsg() reports dropped bytes as sent.

Subtract the number of bytes that sk_msg_free() frees. After an error the
SK_PASS branch already does this. The SK_REDIRECT branch does the same if
the message is not the cork. Nothing changes when tosend is equal to the
message size. Otherwise sendmsg() now returns -EACCES if it sends nothing.

Fixes: ca70b8baf2bd ("tcp_bpf: Fix the sk_mem_uncharge logic in tcp_bpf_sendmsg")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/ipv4/tcp_bpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/tcp_bpf.c b/net/ipv4/tcp_bpf.c
index b016aa419fb2..36d1bf46353a 100644
--- a/net/ipv4/tcp_bpf.c
+++ b/net/ipv4/tcp_bpf.c
@@ -521,12 +521,12 @@ static int tcp_bpf_send_verdict(struct sock *sk, struct sk_psock *psock,
 		break;
 	case __SK_DROP:
 	default:
-		sk_msg_free(sk, msg);
+		/* All of it is thrown away, not only tosend bytes */
+		*copied -= sk_msg_free(sk, msg) + delta;
 		sk_msg_apply_bytes(psock, tosend);
 		/* The verdict holds for apply_bytes, not for ever */
 		if (!psock->apply_bytes)
 			psock->eval = __SK_NONE;
-		*copied -= (tosend + delta);
 		return -EACCES;
 	}
 
-- 
2.55.0

