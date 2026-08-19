Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6934D3385B6
	for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 15:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787152933; cv=none; b=qLnE/kROQWDn31zdwcqhM8X6YLtTs+BHTnuVpiAPeZRidz1N6Jv6A9vtAYDw5H3aG+dNaUFAod+E74azD6G26tvQaYj10eosIX/KpxBtnCeksOVWfBBzhln7hJiC9kECLL5r3zYpSDbMT19DHTx0ruKYYM1o9zO/+2lArzEl4Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787152933; c=relaxed/simple;
	bh=giCOjiC1HUAD7goPgDb8+JCWawU0xHq/k5Q8cfRYfgA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I4rvosHcEUwhC4b/XrVnnMluwUzvIYl+BlblmSkAbhkdUWmsw97FFkyMlJ0qU4xTfS5BQ0gTzJ0R7haJsY4hBPWAllEMoG8qTF+cn3FVcTjEF2DExFxTGXBvfaThnz4Gr/tVlxZ49PDfCpLgXwQqQLRgyMaxt2dg9yfyb4Ptimw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=ZlwIPneq; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="ZlwIPneq"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84a4d8fd6ecso1212001b3a.1
        for <netdev@vger.kernel.org>; Wed, 19 Aug 2026 08:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787152932; x=1787757732; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IYOGnu5ncDmPv5zUInDoWOSgxzeaaQ79O7bKMkbkZcc=;
        b=ZlwIPneqb4mm5SWv9rsMkFAbpIFJ+CKgAJQ6S1war3daZquzdeyYsjRn7oZ4wsxsjL
         qnroUZZNGQ39hOGAD3NID4cEbHt3WDCSUa0d3V/9T4PxpjwbE/E3EKN7DYE+Xwm8o//a
         oU4lAw8tORpTBxLKkztKOxlrKSmuNLh69YDdgZp5oHdSIoPwI/0Swi6r2kRUuqs5B50X
         mWvR9LdskIWmrYcHHyIBYZpmsOD6oIlPKy69R/tiQ/wmvvwbon6P6enj7SK52TFJp/Gu
         x9lV7v9RR0Mx5Hc1SyeBEIBLE3uGbJle6uNTkOGgvu9u5dfUH9dQ6lfx/azzEzK3c7aI
         FdXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787152932; x=1787757732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IYOGnu5ncDmPv5zUInDoWOSgxzeaaQ79O7bKMkbkZcc=;
        b=FsFh1YZOqUrXsH3EraCKp5LFJaRx8uXF+ziUgdVFkGPKxCPwdR25HPyOLUM4DGps2i
         dEUU7ZkX+4JsxsvMTgXZatjm62sHzH6u53OZgU4hmcTEo49i3J2+9FsfnyhvJI59d1Yx
         pXQfbMghDLMkHtZUB+ND0ur3ok3t1bEREjMkIDNsn86ElLKZ80xvuTR5MqmIJe5olIMX
         lbQFlk6BSf/bW0632lacslDatu1+SsrXaDYeo2NoEbwXRw3a4h6cTK3JRPl5XXZv0k0J
         mjKZ4n0mZPb6HWgxXAjQUQmszTSI8FMrFevxbbIEfgWIdR1maqr6CJZ4lAg8Ty3tWNKK
         p5xw==
X-Gm-Message-State: AOJu0YzNwfFOoPCyve7D8EjmiwEsK4MqX2GR0AXyUMnEKPYeR3NPiGsi
	wLbhLJLXC8uqj6OOxK9jOPZqQ9PHNZUYXRTYRnf1aiWRH00OVmQ9DzryFOCA3500/YIxg3dnN5Y
	mRnaALg==
X-Gm-Gg: AR+sD11RItwCyK70QftQr5SOUZva3PFu9ROjZp0eYcRkFUksxV54I2ckGDVCe4Mc52C
	0/G6nJQO0kj5lyVYHce7L0lVutZIV/i6tYfGcJxCmEsP0wZXjXskf0jzFhAtALi4+C6AzXYmjUN
	XEZUqjIG5ivscAhOPhTfX17KZeCiGox/eKtv2im+yGqMZHPhOH5aGee4N4VPad8xCXdyyQVVwVC
	3TrDVpDnnA9dcE2R4QmuE/PiV83Bmjpe4yc5r4uvmdAtOgeEKS4CYlPs0fufNiM5rODrtv6RvzJ
	UMqI/rYEs7rFYrEnD6fcd2vUT5jw6jzoVsfdh1fgHpOl7X/WFmlR2r+7mcEZY4BICyDiQLlXWwY
	16p/pEvhC5qm1zsqHspPrkvOSbwpAOsVIJf0CXkkN3OjrEC2LFdGlCP0NmYWa1Cy7M1qJqZ6QAO
	+EtfO8b7kb4OHAGqT49L/gTMPz72CGqSkOjYVatutyEd0nLKr2FBVfcu9G/hjwSzNqOEHRfVc=
X-Received: by 2002:a05:6a00:3d4a:b0:851:92fe:504b with SMTP id d2e1a72fcca58-851d3847989mr9306507b3a.7.1787152931406;
        Wed, 19 Aug 2026 08:22:11 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([167.71.204.91])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-851d3668afasm780519b3a.48.2026.08.19.08.22.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 08:22:10 -0700 (PDT)
From: Ren Wei <weir@nebusec.ai>
To: netdev@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	edragain@163.com,
	weir@nebusec.ai
Subject: [PATCH net v2 1/1] tcp: clamp route advmss to TCP_MIN_MSS
Date: Wed, 19 Aug 2026 23:22:04 +0800
Message-ID: <251eaf8277fa7c66364c9815c5da01662d269181.1787074852.git.edragain@163.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1787074852.git.edragain@163.com>
References: <cover.1787074852.git.edragain@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yong Wang <edragain@163.com>

tcp_select_initial_window() assumes that callers never pass an MSS
smaller than 1, but route-derived advmss values can violate that
assumption.

A too-small explicit RTAX_ADVMSS is one way to get there, but it is not
the only one. The same divide-by-zero can also be reached through the
"default advmss" path when RTAX_ADVMSS is left at 0 and the effective
advmss is later driven down by route MTU and min_adv_mss.

Introduce a tcp_dst_advmss() helper that clamps route advmss to
TCP_MIN_MSS before TCP consumes it, and use it in the TCP paths that
derive advmss from dst metrics. This keeps the effective MSS from
dropping to zero before tcp_select_initial_window() rounds the receive
window.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:GPT-5.4
Signed-off-by: Yong Wang <edragain@163.com>
Signed-off-by: Ren Wei <weir@nebusec.ai>
---
 include/net/tcp.h        | 5 +++++
 net/ipv4/tcp_ipv4.c      | 2 +-
 net/ipv4/tcp_minisocks.c | 2 +-
 net/ipv4/tcp_output.c    | 6 +++---
 net/ipv6/tcp_ipv6.c      | 2 +-
 5 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2c5b889530b5..670c20876f26 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1782,6 +1782,11 @@ static inline int tcp_full_space(const struct sock *sk)
 	return tcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf));
 }
 
+static inline u32 tcp_dst_advmss(const struct dst_entry *dst)
+{
+	return max_t(u32, dst_metric_advmss(dst), TCP_MIN_MSS);
+}
+
 static inline void __tcp_adjust_rcv_ssthresh(struct sock *sk, u32 new_ssthresh)
 {
 	int unused_mem = sk_unused_reserved_mem(sk);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 7f413f509d7d..497b1a0370cd 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -1736,7 +1736,7 @@ struct sock *tcp_v4_syn_recv_sock(const struct sock *sk, struct sk_buff *skb,
 	tcp_ca_openreq_child(newsk, dst);
 
 	tcp_sync_mss(newsk, dst4_mtu(dst));
-	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
+	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), tcp_dst_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
 
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index 6ab3e3a0b431..fb901b368ecc 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -440,7 +440,7 @@ void tcp_openreq_init_rwin(struct request_sock *req,
 	u32 rcv_wnd;
 	int mss;
 
-	mss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
+	mss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 	window_clamp = READ_ONCE(tp->window_clamp);
 	/* Set this up on the first call only */
 	req->rsk_window_clamp = window_clamp ? : dst_metric(dst, RTAX_WINDOW);
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index d7c1444b5e30..7b761edf86ee 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -143,7 +143,7 @@ static __u16 tcp_advertise_mss(struct sock *sk)
 	int mss = tp->advmss;
 
 	if (dst) {
-		unsigned int metric = dst_metric_advmss(dst);
+		unsigned int metric = tcp_dst_advmss(dst);
 
 		if (metric < mss) {
 			mss = metric;
@@ -3972,7 +3972,7 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	}
 	skb_dst_set(skb, dst);
 
-	mss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
+	mss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 
 	memset(&opts, 0, sizeof(opts));
 	now = tcp_clock_ns();
@@ -4127,7 +4127,7 @@ static void tcp_connect_init(struct sock *sk)
 
 	if (!tp->window_clamp)
 		WRITE_ONCE(tp->window_clamp, dst_metric(dst, RTAX_WINDOW));
-	tp->advmss = tcp_mss_clamp(tp, dst_metric_advmss(dst));
+	tp->advmss = tcp_mss_clamp(tp, tcp_dst_advmss(dst));
 
 	tcp_initialize_rcv_mss(sk);
 
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 9e9155b1b3aa..df9c29eb5c1f 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1487,7 +1487,7 @@ static struct sock *tcp_v6_syn_recv_sock(const struct sock *sk, struct sk_buff *
 	tcp_ca_openreq_child(newsk, dst);
 
 	tcp_sync_mss(newsk, dst6_mtu(dst));
-	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), dst_metric_advmss(dst));
+	newtp->advmss = tcp_mss_clamp(tcp_sk(sk), tcp_dst_advmss(dst));
 
 	tcp_initialize_rcv_mss(newsk);
 
-- 
2.53.0
