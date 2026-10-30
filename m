Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793361724;
	b=2DjI78tq5cGFMtfq4xKuMab79VoJxHIcPG/dlco6AnLt5b0TaPuoiPu+CZvCFF2xr/Ue
	 RGsUA5mEA1dWCCou+64R2iNbfGdtg0f1Bj/V/e7wVVMW/oYfYH3Xirp/iZrineufAX58b
	 Q6NtRgPCdz/V9SB0Q0HtcPyEneQ1NFj/QqEOHlTisau3fqDkFWOlG3uIzUR0BLe1ziMJs
	 ngbdHaHGVp9odqXJ0YkXg0b97Trtu2raN4lDBJTqqZdw7y0ics2s9Kx3zS63u3PvoMY8T
	 1gl/doBpMqtbahdXAb/5vxZBzH5iif6W/SD0BQLxvAndzIFuwPXN6GLryKz/sU6LoJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793361724;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=0ZHLqr1JXzWBKlZZ1WTQDfeaoTxgloLN7VDsS0hfUyQ=;
	b=kZyOojRM1lrTqvrQFuICpYBOItL8cEAElK6M0bu1jPuRYODlT8X+HIiNwpzN3yYpJWL2
	 d6Bl0jEl2kSzoIyb+KBg13Y9N1AaGRgRqCMPgzodalqpKVpDgQOHBiTiukDS1LijIsQKI
	 km02j8FDthxtTfjLJNVBJtiuzF68gE8s4sPlY4qUueZ/3Vdr8ve/ETxeDAE3dkVSQ4Gc3
	 jh1tRaWVWYjxQNxPPUlMJXSMqkbT0nTJvTFsAUml0TlWUqSy8qOBjUwR6O7AMUZK7Ao3L
	 GuYf33cEkd+G5ysl6Gqy3SIggQI/ZZbdAifQ01mLPa1BlH/yZ2qZvpbrC1YVym50sjQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudflare.com;
	spf=pass smtp.mailfrom=cloudflare.com;
	dkim=pass header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=SoATSqHh;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F552606A338
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 12:02:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6F552606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudflare.com header.i=@cloudflare.com header.a=rsa-sha256 header.s=google09082023 header.b=SoATSqHh
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c40e30c26a4so359722066b.0
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 05:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1793361723; x=1793966523; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ZHLqr1JXzWBKlZZ1WTQDfeaoTxgloLN7VDsS0hfUyQ=;
        b=SoATSqHhNdt8D1MGQLHZVmM4HEw2QSRyz0+xv2QOvOIvvsrp61UemHu4d4HzeWJlmK
         gyQjAWsXG9o9fwhfY4sDB3nOhlW3WbdOk1t+EJpaySIpUpy9kwgHLe8H14lN4LpixI/z
         3BllxnxMspkwrl96oek3fSjfktCgSS24flB5i6n2vsFWZyFVuDTIgfavGE1A0UqMXrHD
         3mPFypXoFwUh+QDchVDdajrUpv/UXA2kDF3LzvCS2crZc7biw41ATJD3rFrh7adfnRKt
         sUax+NJC+M9nNIoSRl7970O9BDXdkSpgLitCa4lSSFBoDwSNtyP5mWy5mVZlPdrmNH4B
         diyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793361723; x=1793966523;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0ZHLqr1JXzWBKlZZ1WTQDfeaoTxgloLN7VDsS0hfUyQ=;
        b=GorFlLotCx+W43CFCazJdEV+Qn5Vqq4mDdo4N7Nc5No4tSlnjID8ipfSn4o700YFff
         LuPiVNaKz9IjaTuviEcjPxnOS/KpgBW9ajpCh1bbStuqOKt6XFIgran6jntXz549UCiU
         SMu4EuMPjEBrVg3wUmDWW+Sm8wbEEPGbEw3qcxDYnOqIGyg1cEEg/2XsDj+b6Aj6X7YN
         jXYy1mlnxfeMOj/9TG6+mrN+Vxv1rM/uSJ/k9gMJk5yn84Mitx86znKryq0eOL9jrUQe
         YqbU6nGcb9iUHr5G+AIBX6pgFp/dLgtp4HCe0rGqWoUxuWReOvBKQtIIOKkJA6sZg+L1
         4zbw==
X-Forwarded-Encrypted: i=1; AKwUvByBFHodKrTCe3B3OHYBvCWxcpBpmmskCJX4uZ/vcn7cZmeU0cx4VJ+UNttegdZGdJ9f0JKVy6I=@vger.kernel.org
X-Gm-Message-State: AFq9FYJjW9QB9RwOe0syqGqx1jDRveeDGzhNTs9KZLwPzo9iX5xZ+zZQ
	GcKJZQKAplx/tu1XoGo0xS+4aAvb44kGVSNuChdyAF8ZUd+iIbkg4GtOdvmu00+AnSQ=
X-Gm-Gg: AYBFou2U2U/rFHMcXpvoM4myFO4L+b1MPPAaTvJtvfjjl6PmNi5jcSHSuY9HrFT8JSa
	/QrQnIl+TfYquYhLdoLbcAkgH8yNNHHvrEkl+qy4egMvHqe48v2uUjQPTwCCadFUsURwJy15k3+
	abOiwwW+DZU19lebuK9XtO5sQ43kYIM6F0khXN3szTXahOsePE4BmLzF2pV0qhGjW2GM2Nb0E+g
	yJ7zFg5GI8dIvKcM9W/KU6wEt+ayECIygTBulNfS9x21cbIyI7FxUs3y4N5kPKE3+c9h0PSMfG9
	UnXviRlYiujg6Kf5Jfr8iXzfh7BPsWBJkdKy7vTYa3xSMgPJz6n0b8LL2NXaN5yUBLkNBp7LCYB
	tmKj+EwmXe8GdpKP4q+S3geU8GrLm5kdbpyPExqQSNnD5Jg7LFrJFEam1hQN1X5q3wXflC1hW8T
	lZ/82BYV8TUn5L7QQCnl32N50QmHJ/uVetitUob/qsZPL0kLzI6EsvD7gw09S69OTfz66ZpPFA6
	1fQaSC8DTTrIxJaj4QnsCXRas4UtGX495CEtxOq+MEv4ZyayGCaV+dykJApMTZPpiisk1v+MOpI
	6SpUjWRE9YGRPfcTxeAyOVYDC+gVf6+woCKwUg==
X-Received: by 2002:a17:907:9615:b0:c21:5cd6:3e49 with SMTP id a640c23a62f3a-c4ca7a697a3mr192464266b.9.1793361722443;
        Fri, 30 Oct 2026 05:02:02 -0700 (PDT)
Received: from cloudflare.com ([2a01:110f:491b:1300:7cff:6795:2d76:e9de])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4cabe1003fsm59104966b.44.2026.10.30.05.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 05:02:02 -0700 (PDT)
From: Jakub Sitnicki <jakub@cloudflare.com>
Date: Fri, 30 Oct 2026 13:01:54 +0100
Subject: [PATCH bpf-next 2/2] bpf, sockmap: Fix psock update-side data
 races on sk->sk_prot and progs
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-bpf-next-v1-2-035eabf8eae7@cloudflare.com>
References: <20261030-bpf-next-v1-0-035eabf8eae7@cloudflare.com>
In-Reply-To: <20261030-bpf-next-v1-0-035eabf8eae7@cloudflare.com>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, netdev@vger.kernel.org, kernel-team@cloudflare.com
X-Mailer: b4 0.16.0

The update side of the sockmap psock lifecycle has several unsynchronized
accesses to sk->sk_prot and psock prog state that KCSAN flags when the
new update-vs-delete race selftest runs. The fix comes from Alexei [1]:

* sock_map_link() installed psock programs and called sock_map_init_proto()
  before taking sk->sk_callback_lock, racing a concurrent teardown's
  tcp_bpf_update_proto() write of sk->sk_prot. Take the write_lock early,
  before psock_set_prog() and sock_map_init_proto(), and drop the
  psock->saved_data_ready gating from prog detection (it is re-checked
  under the lock before stopping progs).

* sock_map_del_link() read psock->saved_data_ready outside the lock. Move
  the saved_data_ready check under write_lock_bh(&sk->sk_callback_lock)
  so prog teardown is serialized against the proto restore.

* sock_map_psock_get_checked() and sock_map_sk_is_suitable() did plain
  sk->sk_prot reads. Convert to READ_ONCE() to mark the intentional racy
  read against the WRITE_ONCE() swap in sock_replace_proto().

With these changes the sock_map_link/psock_set_prog side of the reported
KCSAN splats is silenced; the remaining teardown-vs-core-TCP pairings
are the separate read-side annotation problem.

[1] https://lore.kernel.org/bpf/DMBHB0TQOV1L.38MECMYFGUS5B@gmail.com

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Jakub Sitnicki <jakub@cloudflare.com>
---
 net/core/sock_map.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 057e2f3c0265..efe49551caba 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -152,11 +152,11 @@ static void sock_map_del_link(struct sock *sk,
 			struct bpf_map *map = link->map;
 			struct sk_psock_progs *progs = sock_map_progs(map);
 
-			if (psock->saved_data_ready && progs->stream_parser)
+			if (progs->stream_parser)
 				strp_stop = true;
-			if (psock->saved_data_ready && progs->stream_verdict)
+			if (progs->stream_verdict)
 				verdict_stop = true;
-			if (psock->saved_data_ready && progs->skb_verdict)
+			if (progs->skb_verdict)
 				verdict_stop = true;
 			list_del(&link->list);
 			sk_psock_free_link(link);
@@ -164,8 +164,11 @@ static void sock_map_del_link(struct sock *sk,
 		}
 	}
 	spin_unlock_bh(&psock->link_lock);
-	if (strp_stop || verdict_stop) {
-		write_lock_bh(&sk->sk_callback_lock);
+	if (!strp_stop && !verdict_stop)
+		return;
+
+	write_lock_bh(&sk->sk_callback_lock);
+	if (psock->saved_data_ready) {
 		if (strp_stop)
 			sk_psock_stop_strp(sk, psock);
 		if (verdict_stop)
@@ -173,8 +176,8 @@ static void sock_map_del_link(struct sock *sk,
 
 		if (psock->psock_update_sk_prot)
 			psock->psock_update_sk_prot(sk, psock, false);
-		write_unlock_bh(&sk->sk_callback_lock);
 	}
+	write_unlock_bh(&sk->sk_callback_lock);
 }
 
 static void sock_map_unref(struct sock *sk, void *link_raw)
@@ -202,7 +205,7 @@ static struct sk_psock *sock_map_psock_get_checked(struct sock *sk)
 	rcu_read_lock();
 	psock = sk_psock(sk);
 	if (psock) {
-		if (sk->sk_prot->close != sock_map_close) {
+		if (READ_ONCE(sk->sk_prot)->close != sock_map_close) {
 			psock = ERR_PTR(-EBUSY);
 			goto out;
 		}
@@ -284,6 +287,7 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
 		}
 	}
 
+	write_lock_bh(&sk->sk_callback_lock);
 	if (msg_parser)
 		psock_set_prog(&psock->progs.msg_parser, msg_parser);
 	if (stream_parser)
@@ -298,11 +302,11 @@ static int sock_map_link(struct bpf_map *map, struct sock *sk)
 	 */
 	ret = sock_map_init_proto(sk, psock);
 	if (ret < 0) {
+		write_unlock_bh(&sk->sk_callback_lock);
 		sk_psock_put(sk, psock);
 		goto out;
 	}
 
-	write_lock_bh(&sk->sk_callback_lock);
 	if (stream_parser && stream_verdict && !psock->saved_data_ready) {
 		if (sk_is_tcp(sk))
 			ret = sk_psock_init_strp(sk, psock);
@@ -536,7 +540,7 @@ static bool sock_map_redirect_allowed(const struct sock *sk)
 
 static bool sock_map_sk_is_suitable(const struct sock *sk)
 {
-	return !!sk->sk_prot->psock_update_sk_prot;
+	return !!READ_ONCE(sk->sk_prot)->psock_update_sk_prot;
 }
 
 static bool sock_map_sk_state_allowed(const struct sock *sk)

-- 
2.43.0

