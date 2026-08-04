Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ED9C449EC2
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 14:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785853806; cv=none; b=ezDuZwooWFRz5jA+nyptOluY1pHJ+lkeu4krLiCG+G21lM7DDjRCvYxK9XNddgddz6ZZP8wxPIaUf03DMNJIJ7SqryPPCya0V6y1FPlB4lzcBaRyjgd3n1L5shTC5JlDgTLPxA3SG6h/P9CtHbPX1Zfo0OpG1G1yqYSK8/vVLRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785853806; c=relaxed/simple;
	bh=ruf5sMxreReMwQaIQKSAQblQ/Q/x7RT3lTJ+YvAyFk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nJBGHp+ExgtONmxUJV7POj1zfE0ekHLIszKmm002Fdwv/DQhdU+dUH9GYjlBPMBLwtWUYbv2z9eZB9p6GITCIlmibj93Q8ZNAO8gqYqRF/tlYhNnaQyP7vaLIeYEsqwiPJHUSaYCrZ2qhP8zzpDIrUWBYWtbREjVp82K3g3gBjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QXNNU+Ex; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QXNNU+Ex"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso2334162f8f.0
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 07:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785853776; x=1786458576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jt5TtSlsS1iDkROg1uOIa6AAAcNAVrK5bbtBRy35vPA=;
        b=QXNNU+Ex2BrP1zwaRxLGFIsIonYi9w9e1PD69fRgdPWhZQy8ll8vxirQJx0qwFj3ge
         hVKYgvYQcjZmCcr8P+0AObecbeqnekhR+WziGPh7gR2f7xDblt0qe7wd9yqQmE/+/bLz
         AZBG59x6LrXWmO+MeCse/U0bu9Xe4TASSIcek/49HjJcSN6KtxMggpUFngUMdGn5nCjD
         EKpwX6HEiMmCDrz5WKgBEa0JVuA3MT+ZrpKdRnPUUaB9BUs/KkYFifh1KQEZ1ZUPBJhM
         iR7nvc/Vb6Tto+/8KEZv3jXmqV16Ti9JsBxp1mH6AhfCpQeJM6Ux9EEQQQagUCks/GG4
         dfdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785853776; x=1786458576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jt5TtSlsS1iDkROg1uOIa6AAAcNAVrK5bbtBRy35vPA=;
        b=dUwpiRxrNbxdE5lXWMDJb84yGrwxS/XOdRhgWqyGqbA5hKpSrAemkrJKwrPNeJjeld
         lBa6FJCntvRCW4MDyL7iV7ysDuqrjrO19NCmVMWd0MnEb9LmcSNcAN1UPSofnf45aj/I
         DSUJDUns1c9CegaPNgln6a15hck4GSaoLeUnQtdYAPF/6ZznpaofklMC5r9SbGrI+He5
         s/uQcJGk1d0DoJaDDwOCRzQjZmkHgC1pLU6XQcaftfXfIWJ51SnboL0lCA8iE3fUhtge
         M9CQZKS/7VxnmveLqY5g6xtKEjk118GjscRD373GDqcXvGDSFnaVkYVpzj6mwWgsQGdC
         2lGA==
X-Forwarded-Encrypted: i=1; AHgh+RohgAW6y3DmQT9OXh5kCBXXpoNPOg2yy5SIvb6dYwJZdKYzsZ5b1bGws1f8uhZHfzGwfrhLJeU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfTGKls1CjFZQuY/l5IA9MRWXsYf0IwtMLKBzIjtZvvo+DR8FG
	iOJYCdU5lmHab5ET0Oie+olm63S5EZcEqya1ACoY6gpgtfBCgSxwHdaw
X-Gm-Gg: AR+sD11mPjLQMDtqp4nSngzPfUGvKfe4zTPdqf8i6XzZZKUm7JhQKOaebyi5PEW7+Y/
	TUjx47YnBy+O6D5wK9lVbfAwsf1+ilqPRsEZ5G7NG56WLmC57FttGm6ONLPDpCMvna9uJlsR7i8
	oIyHKqsqcPQatoj0rHFIXTPmeh05/azM3YOwR8Bc82pZvbrOXc6qUolB4kN9Ofy6ULpDbRDSEqj
	trlkOV+7BXjAgnU0TUDTqNclWkUzm9wIr9llA36GXKZg8SqVhsZgWaxYc0wGhrJrDvrRA8F2GOJ
	ws9GIDLScWu69CXkzod1fYOZ+nxJqNntjgbZ39mSrgjjofmFVWDnm/OU0xASwrVDQCuA8J0NsiN
	3F9nT6QC+/NKgnHUSEz4WQK4lsFe027nRVbufI6dmGwYWsz/YTuMuszcN28HOSGGE/QFmjEYASR
	r84Ff1i5rUZXLY/Htx2Js+yOx3qQ7yqKVSI/sEKjasaclo3VWmz9EqvxE7wroV3T1QmIXRYKzmY
	kWLBWAfx4uX3y9lod1OA1LebpsUFAaw
X-Received: by 2002:a05:6000:41ec:b0:474:3b3b:5e5f with SMTP id ffacd0b85a97d-47fd72c4d4dmr35160284f8f.16.1785853775675;
        Tue, 04 Aug 2026 07:29:35 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([194.156.154.185])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fec232d74sm5088f8f.17.2026.08.04.07.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 07:29:35 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: kuniyu@google.com,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	martin.lau@linux.dev,
	ast@kernel.org,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	lmb@cloudflare.com,
	ppenkov@google.com,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	enjou1224z@gmail.com
Subject: [PATCH bpf v2 1/1] bpf: Check sk_state before sk_protocol in bpf_tcp_*_syncookie
Date: Tue,  4 Aug 2026 22:29:01 +0800
Message-ID: <6218aa3534d0d2d3f448fde70a8dc2769d7a8201.1785823138.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1785823138.git.rakukuip@gmail.com>
References: <cover.1785823138.git.rakukuip@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Luxiao Xu <rakukuip@gmail.com>

bpf_tcp_gen_syncookie and bpf_tcp_check_syncookie accept a socket pointer
'sk' with argument type ARG_PTR_TO_BTF_ID_SOCK_COMMON. However, they access
sk->sk_protocol without validating whether 'sk' represents a full socket.

When a BPF program passes a mini-socket (such as struct request_sock or
struct inet_timewait_sock obtained via bpf_skc_lookup_tcp), sk_protocol
is located beyond the memory boundary allocated for mini-sockets.
Directly dereferencing sk->sk_protocol leads to a slab-out-of-bounds
kernel read.

Fix this issue by checking sk->sk_state != TCP_LISTEN before inspecting
sk->sk_protocol in both bpf_tcp_gen_syncookie and bpf_tcp_check_syncookie.
Since mini-sockets are never in the TCP_LISTEN state, the condition
short-circuits and prevents dereferencing fullsock-specific fields.

Fixes: 399040847084 ("bpf: add helper to check for a valid SYN cookie")
Fixes: 70d66244317e ("bpf: add bpf_tcp_gen_syncookie helper")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---

changes in v2:
v1 Link: https://lore.kernel.org/all/ca8d8c570509b02355bb4bd4e56859f3e2564c9c.1785576172.git.rakukuip@gmail.com/
- Check sk_state before sk_protocol instead of adding sk_fullsock() check (Kuniyuki Iwashima)
- Correct Fixes tags to point to 399040847084 and 70d66244317e (CI bot)

 net/core/filter.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index b446aa8be5c3..1a5f1bac0a75 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7679,7 +7679,7 @@ BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, sk, void *, iph, u32, iph_len
 		return -EINVAL;
 
 	/* sk_listener() allows TCP_NEW_SYN_RECV, which makes no sense here. */
-	if (sk->sk_protocol != IPPROTO_TCP || sk->sk_state != TCP_LISTEN)
+	if (sk->sk_state != TCP_LISTEN || sk->sk_protocol != IPPROTO_TCP)
 		return -EINVAL;
 
 	if (!READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_syncookies))
@@ -7752,7 +7752,7 @@ BPF_CALL_5(bpf_tcp_gen_syncookie, struct sock *, sk, void *, iph, u32, iph_len,
 	if (unlikely(!sk || th_len < sizeof(*th) || th_len != th->doff * 4))
 		return -EINVAL;
 
-	if (sk->sk_protocol != IPPROTO_TCP || sk->sk_state != TCP_LISTEN)
+	if (sk->sk_state != TCP_LISTEN || sk->sk_protocol != IPPROTO_TCP)
 		return -EINVAL;
 
 	if (!READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_syncookies))
-- 
2.43.0
