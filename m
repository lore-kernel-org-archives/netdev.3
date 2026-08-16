Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59073230BDB
	for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 01:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786843282; cv=none; b=Q3N0bc9IR5A1BdqwneOsJHvHvIfayp2p4Jd34qMVnj7kUUe/nrl9glllFudtiQRhK8KLn2aXw7r2r4izkNOpgUisKXx9n8HAoI7ug5ByqIN6jWHRaX+qZlPFIUnGfQqMpB8TpQb9BPKcFmL2BwkJNJjyWU5R+zsPcmh6QhCSS3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786843282; c=relaxed/simple;
	bh=Gen9hwbb5IzqFoip7jeIVRTXtpYL4kYgrsAnLhvo1OA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D3v4qY8bSKyQDTnDQbtj0WonM11ZrpVF74WWSpqVJrT76fGGi0ZkLqwyQFm9Z19RTKFyx3lo8SkHTBg7mk2nUX2DXNdPRbR/PI40Kp9lSevG6iqpP1lNLPZONRCJnkdjS1u3qcLkD2ROqUo+EVc7L+RXlOCgDXAVcGN+C6xfwhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=czBQ/w41; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="czBQ/w41"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-472326ca506so1537626f8f.2
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 18:21:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786843279; x=1787448079; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZxQftwL2PECJ4SpESVyGEcp2FdWssPfyBN4bxwXPtrQ=;
        b=czBQ/w41rPrfdhEgTGwVExUj4ebWs06JJCopyhkGf7UeixJLyFbKxkyHn0UT14HgTY
         RipN5lVnVObDGwOaA9ehgHKEi5/SKd3N66BOmBBoqYvyNJFF4yfuz6XEFiV2Lwww8faZ
         6Ir4ewRoAJCTCwvWt/rQJ3APdUgmUmQMSkSZsfUnIobRnFPnYAZBr44D+mdf4iHt8FZr
         NTssM39Qh5Ist4QyWz1v/MUHYechX9B2N4DZETuZJlm9qblBDxOxzv9WCxCH+KNTlt6n
         dDzacIDqrN4A9VhYhv3S7cAkuqQmxYxWrZfrMfe2dJVOgX4dRWUnmjihupnXPKQVHwhn
         4H7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786843279; x=1787448079;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZxQftwL2PECJ4SpESVyGEcp2FdWssPfyBN4bxwXPtrQ=;
        b=moXq9tgpaa4VYoWULze0AiDDTLrOVF2kt9mq3gZVKNU7gMkbQYsEwJxzW8tnodD8fc
         R+Zu48xLUbGwharTyU3K0LmXUlbDCtc/qrt1brzBgTp+8wJOMOYceui8t2S+Qnrx4mNM
         tLpgDRGMsYUxjPBwHpdenaE++R47XVaDtSFXxsJuOC/6iNmldU9PtnAG9pVHim1ihZRM
         svv7817fngzoyDSFJEbfznbPXnQcXSkZZID5NF1Yk+3aWzTjmpYvvJIRr+Wrmcu7t0BG
         7MwlmIA0Zj3cRP3XgXHkVE4uGCr+FK0XCeO1JZQwnN48G2HXoI/hlXZO4IeYWnOHTFkB
         Fuuw==
X-Forwarded-Encrypted: i=1; AHgh+RpOE7W22LS9yhJ+IX8auZODOoeMClWqXaWXm5zmWJY7jcI+32R8YHsOThcj/fzCOR8ueftcnss=@vger.kernel.org
X-Gm-Message-State: AOJu0YzvD3QHmvkMqvgRxwZUPF4ivXILg8WqeHbIHzpdNHUDAdFWU5Ni
	7HQwNvvUZ5HETxQk3hKR62tsH8mlTfw8YdxwvTRGdBRVAcaQxp2f88b1
X-Gm-Gg: AR+sD10fLEePQUc0C+ohy93prHpD3zm49BuzHPub03mChWJe/ey3ayupbqrvf6QTdhS
	r8ga1N56lRFSRT3pK7tGp0yuEp/gRc9Xn7zAyANm0aCG9w3Ewp9hUITzstbbfXfOUFFDizepcbA
	PLN0cvBgmwfq2BHMXpPlky2qp+LyWFKu9NhfkhqjVFbsGewYZqYExpXWR+fsNd9Aw52izsyk99L
	BsNS4vfSWdDdcSA9cx8TQqTqDGuLmbJIPTpyQl+4IOd2ZN6pMpSqaLmNMlnZNFf4VDjXJGgZpZe
	Cx2CJ5QimoiaFKIdwzWyTSXaD2wJpQWh4A6qH7Unzh0X+0+Ij9eBji9L2xAJKkoQRqHGCggmr6n
	+dKSdYbJU3RR9GkWYXX/+FVzuWdKWHm0wwbklcCsBu4DJd117rMcJ6zNsZ7QbrxYxHfLfr9i37D
	1tlAiCl02d+fwREYGy0o7VgXpH7I4EyV7A6AANs6yU2mEXRyelBpfplsWfMPJ+mDKKSq/tyh3E
X-Received: by 2002:a05:600c:4e14:b0:499:7e2b:8e5 with SMTP id 5b1f17b1804b1-4998793ffe7mr247502565e9.5.1786843279382;
        Sat, 15 Aug 2026 18:21:19 -0700 (PDT)
Received: from unicorn.lan.internal ([2a0d:3341:b894:4600:78e4:e92e:b052:d281])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499961767f5sm923525e9.9.2026.08.15.18.21.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2026 18:21:18 -0700 (PDT)
From: ooonea <ooonea@gmail.com>
To: =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	cake@lists.bufferbloat.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net/sched: sch_cake: fix autorate reconfiguration throttling
Date: Sun, 16 Aug 2026 03:21:09 +0200
Message-ID: <20260816012109.2865223-1-ooonea@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

CAKE's autorate-ingress path intends to limit shaper reconfiguration to
once per 250 ms, but last_reconfig_time is only checked and never updated.
Since the field stays zero, every qualifying capacity-estimate window can
call cake_reconfigure(), causing avoidable rate churn and scheduler work
under bursty traffic.

Store the current timestamp when autorate actually reconfigures the qdisc
so the guard enforces the intended interval.

Fixes: 7298de9cd725 ("sch_cake: Add ingress mode")
Assisted-by: Codex:gpt-5.5
Signed-off-by: ooonea <ooonea@gmail.com>
---
 net/sched/sch_cake.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index f25f60978..dc9326702 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1907,6 +1907,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 					ktime_add_ms(q->last_reconfig_time,
 						     250))) {
 				q->config->rate_bps = (q->avg_peak_bandwidth * 15) >> 4;
+				q->last_reconfig_time = now;
 				cake_reconfigure(sch);
 			}
 		}

base-commit: 24ef02f934eeb48830cff6b739abc3c62b1d107b
-- 
2.54.0

