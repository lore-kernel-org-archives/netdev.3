Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244F035DA7F
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 08:30:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779525011; cv=none; b=V7uD8da+ZKD6OV+r7iHWTd6JsLGSLdyDZahp5v2GufsyvHXPvUHVwgDY9oLh6byv1VObdMIBmyEdW2ZZFtT2YmS7NYD6RgxJ/jAYkzuoARsos4/JdnJe6ONxXJmTrEzpsODpAM2JfcgTEFAabiuURbhRaNxRiGZ1WyxwhMBBo7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779525011; c=relaxed/simple;
	bh=ZyD9AQscuylwqpRs04xemnKsI72mnSLQlWHwuv5SjUY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YqJZxnd0jw5kbsg3ZYBsFbq/Q2uRw9qXGp6AA3aa2rUJO5hylLrDXZlrgbkyXcJfZw6gEvk3wZiunTI0op0LVjJiWaomoTHHDyE7asXT/YT2oko86FAxAtX4bd3T57soSn647CC9KT/rfV4pHU8fAXMUewgQE89mhhVKB+Am90A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nUntULXN; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nUntULXN"
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-3662e7756f0so6341326a91.1
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 01:30:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779525008; x=1780129808; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=qXW60/1sU7ehwE+s4YZIIMUDlvA6FNdHZ/Kq8opfaUQ=;
        b=nUntULXNcAtCB8YcsNJmZzmHq+wk0ezd1P5wPHs7vw86VVPunUQgPphW0Zv5WHEb+1
         e560CEcxS1tm0h6ksxA/hQ0emCPKAAmW27xnOtzpPClkesWp6QGGINz/reYGWukInfs6
         5j4yHionT6zTdWSNjACSOrCqXBzcFQu6CTrNz9jKjs+mDaO7/mVrmDpLzg7zVjtvjWVM
         /OTa0DReVqlAgyBFss7ewpu4PqoZvIEhzkIY5oLPASjMjgme7jE/UgEd8MQr53IWi0dx
         cgXwdv1jV8Vybu+yKm1mg8/Q0klMgGXA2GhDum3JZqu+zZ2+PlHlHLs3tCxE+Qbg9i7x
         Eutg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779525008; x=1780129808;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qXW60/1sU7ehwE+s4YZIIMUDlvA6FNdHZ/Kq8opfaUQ=;
        b=HYu6b2MZRVywQdm4NRJoIEvJOiMYAB/YFl3AxwmmvHoEovQXEOaaUs0Xpy8zOHBBIy
         XBb+9L+xCqsC/ipCdCfvvPaNujydbLXQbWuzpBnF2cHqywWjxxY3yiQy0jrt9HmhLLUY
         VH0m29+Fuq1zF0yVgbgQf5/mVwDfqexcauSEcn/JaT9QS+tMZs1fTWqydCvYec2CSmm8
         WMXk2jSw4GqyzDb5CysUaQCFgGzXBC6IXDa5mRisE4rx0UljwZNV52e+KLmy2k2+gnCd
         Yik3GWG608gTzTOqgebapFA0ublerLzCT8FTmdFYFfkTIjuScqUmtSU0wVmdFKiEh5hE
         WoKw==
X-Forwarded-Encrypted: i=1; AFNElJ8U+zIblTZHoA5/AWcuQLuL+6pJV/KReIqywoh8cXjlfhcoROgPt+bVGFpzsoGND0XRswUlObY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ6SZBgOm0TH/+XK3lv1okSsRDlc8dRzxGDr42KflpCZb05Yn8
	h3n3nne9LLhRyqo7eFDcOE+cG93bXuw+TMJXySmQkUodYacjiEcqoPuOdi8xhPvOFbuOw5l5R3l
	mYkyYIA==
X-Received: from pgbbw25.prod.google.com ([2002:a05:6a02:499:b0:c79:67fe:6d9e])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:8202:b0:3b3:ce0:9f73
 with SMTP id adf61e73a8af0-3b328cd80a4mr7338851637.19.1779525008223; Sat, 23
 May 2026 01:30:08 -0700 (PDT)
Date: Sat, 23 May 2026 08:29:34 +0000
In-Reply-To: <20260523083001.2911931-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260523083001.2911931-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.746.g67dd491aae-goog
Message-ID: <20260523083001.2911931-6-kuniyu@google.com>
Subject: [PATCH v3 bpf-next 05/11] bpf: tcp: Add kfunc to adjust sk->sk_rcvlowat.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

We will invoke BPF SOCK_OPS prog with BPF_SOCK_OPS_RCVQ_CB
to adjust sk->sk_rcvlowat when

  1. TCP stack enqueues skb to sk->sk_receive_queue
  2. TCP recvmsg() completes

Let's provide a kfunc to set sk->sk_rcvlowat.

Negative values are clamped to INT_MAX, consistent with SO_RCVLOWAT.

The wakeup flag is determined based on bpf_sock_ops_kern.skb:

  * For the enqueue hook, skb is always non-NULL, and wakeup is
    set to false because

    * tcp_data_ready() is always called after the hooks in
       tcp_queue_rcv() and tcp_ofo_queue().

    * when tcp_fastopen_add_skb() is called for TFO SYN,
       the socket is not yet accept()ed, and when called
       for TFO SYN+ACK, the socket is woken up by
       sk->sk_state_change() anyway.

  * For the recvmsg() hook, skb is always NULL, and wakeup is set
    to true because tcp_data_ready() is not called in the path.

An alternative would be to support bpf_setsockopt() by adding
BPF_SOCK_OPS_RCVQ_CB to is_locked_tcp_sock_ops().

However, that approach involves excessive conditionals and an
unnecessary memcpy(), costs we do not want to pay for every skb
in the TCP fast path.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index fa8a7c7d86eb..3608036632a8 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -12388,6 +12388,22 @@ __bpf_kfunc int bpf_sk_assign_tcp_reqsk(struct __sk_buff *s, struct sock *sk,
 #endif
 }
 
+__bpf_kfunc int bpf_sock_ops_tcp_set_rcvlowat(struct bpf_sock_ops_kern *skops,
+					      int rcvlowat)
+{
+#ifdef CONFIG_INET
+	if (skops->op != BPF_SOCK_OPS_RCVQ_CB)
+		return -EOPNOTSUPP;
+
+	if (rcvlowat < 0)
+		rcvlowat = INT_MAX;
+
+	return __tcp_set_rcvlowat(skops->sk, rcvlowat, !skops->skb);
+#else
+	return -EOPNOTSUPP;
+#endif
+}
+
 __bpf_kfunc int bpf_sock_ops_enable_tx_tstamp(struct bpf_sock_ops_kern *skops,
 					      u64 flags)
 {
@@ -12539,6 +12555,7 @@ BTF_KFUNCS_END(bpf_kfunc_check_set_tcp_reqsk)
 
 BTF_KFUNCS_START(bpf_kfunc_check_set_sock_ops)
 BTF_ID_FLAGS(func, bpf_sock_ops_enable_tx_tstamp)
+BTF_ID_FLAGS(func, bpf_sock_ops_tcp_set_rcvlowat)
 BTF_KFUNCS_END(bpf_kfunc_check_set_sock_ops)
 
 static const struct btf_kfunc_id_set bpf_kfunc_set_skb = {
-- 
2.54.0.746.g67dd491aae-goog

