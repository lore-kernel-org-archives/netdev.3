Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2FCF33DEFE
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 21:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777928784; cv=none; b=V+CU6XP2KyVFPIWtCWeLRUd0bCprYWcQusrnjf3lowYfw+H+EFndaNIs/33wbrApokYJ4EbSPbBD7oetjLEQU4zjf3YPBnXQ6AGZ6kxh/vXTLskL3ntapqQ+6iLVCyX9OaaacfLyEq8vOD4Tb4t0Osmz2OG4lFaWmVcgWF3pX0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777928784; c=relaxed/simple;
	bh=bzB+fl9VtvLM5Uyg9T51LJiJi48HHHF0xxoKeg03HoA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ToEHxiQ3ZkoV8Snq+I5OfSYCt5kEo3s32QexISer2O/rlglBj/6nInvwJbkGOO3ExTndYRdKY5DZNZgDKympyJ8wUl8OL4WaZesnnI1dTCBHcBvwI1R5RXxmw4HlGTiP+Ca3g7ffJEHH+SSuPVFrc5pZy6yGtVDMs/f0pi3SRww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hlZr+WMc; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hlZr+WMc"
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-8353b042152so2080482b3a.3
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 14:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777928782; x=1778533582; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=oMVtTJExhZiVc3HBoDF7EBw2DGe7oG5ooUfjkrrLuzY=;
        b=hlZr+WMcgwF01DoazkyQbjthLr2ALlFs+eTHlwC1EZkkeJwXseT541JpEqkJ/bU3ZK
         MBZ0uHQtgK41YFxFNy28+O2IxuJtESm3vJ2tpjK8JYPtn0JPB/HWW4pnnEU/xUem56UO
         fjGp6gD4k7R2vhnauPlVAMs+wg4Afw8sRDBhH79D4PHNGDRWF0Xi57IQf0DTgXwvxWqp
         k7AenbkQGLfWZDTDa4E+VGmuLES2obUlmVlRNvZFlCzrCQiJDhx9bBX05rawVt1skoFR
         pebeZzsyMEKUWvUBj3Vx8mDNRfOHiqAzIF6tEM9xG/839IyMS8KfmDFCHsNkfoZU3ZB2
         TMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777928782; x=1778533582;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMVtTJExhZiVc3HBoDF7EBw2DGe7oG5ooUfjkrrLuzY=;
        b=VHiT8jIMyAaFpxwwt+y16sR+fOMUvm6Zhgu0xP7TyNiL7X4oy4Rtlf3Fle6iQxHxp3
         W0nn6RFn1AuufOClABmnwxb8FK+PylPFqWwlcIqUZXQX3DoDHUN3ZfGlea9IweC64frm
         yQXFd3BsFDRu2sxXsptqu8CGMv9RNdgBiqQIH782sltD3D5/hUEYrmeq31eX+UDeeBJ8
         KNofo8uhbqHIhE3qWgojIM1ADRxK3s/eUW9Kcj3SzWpCHhgoBgUnhzXuyelLTQx3a5q4
         oPrL8uTlRAhxrM9ediJFvZr8rHDfyqty7LeDgTTd9N/RAoN/IBdjUeDYy4+CK950oknb
         N3xw==
X-Forwarded-Encrypted: i=1; AFNElJ/L1Oq3GXaLUnwlnckFX+ZsqBpcpIseVFlHC4IMQKYey2q9S1xe5Uk56lD1nyD7MW8lHM6Ujic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz81kfy+AB7B+Tv/WoSGOijIhFhUxev9v4EuQahoV9bzgOfXyF7
	kkGMNgDx+IW0SaMHjFSOm2PIckRZRh9PpW9WqiYvZ8/Poqz7Y/b6o57v/DTLcJ8fxCtc14ow/yH
	ccIFVgg==
X-Received: from pfbig18.prod.google.com ([2002:a05:6a00:8b92:b0:839:35e5:3d67])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:448b:b0:82c:7383:3745
 with SMTP id d2e1a72fcca58-8352d1766b9mr11524504b3a.19.1777928782246; Mon, 04
 May 2026 14:06:22 -0700 (PDT)
Date: Mon,  4 May 2026 21:04:53 +0000
In-Reply-To: <20260504210610.180150-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260504210610.180150-1-kuniyu@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504210610.180150-7-kuniyu@google.com>
Subject: [PATCH v2 bpf 6/6] bpf: tcp: Fix type confusion in sol_tcp_sockopt().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Martin KaFai Lau <martin.lau@linux.dev>, Daniel Borkmann <daniel@iogearbox.net>, 
	Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>, Eduard Zingerman <eddyz87@gmail.com>, 
	Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: John Fastabend <john.fastabend@gmail.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Song Liu <song@kernel.org>, Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

sol_tcp_sockopt() only checks if sk->sk_protocol is IPPROTO_TCP,
but RAW socket can bypass it:

  socket(AF_INET, SOCK_RAW, IPPROTO_TCP)

Let's use sk_is_tcp().

Note that initially sol_tcp_sockopt() checked sk->sk_prot->setsockopt.

Fixes: 2ab42c7b871f ("bpf: Check the protocol of a sock to agree the calls to bpf_setsockopt().")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/core/filter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 684922efd481..ef0877eefaa7 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5481,7 +5481,7 @@ static int sol_tcp_sockopt(struct sock *sk, int optname,
 			   char *optval, int *optlen,
 			   bool getopt)
 {
-	if (sk->sk_protocol != IPPROTO_TCP)
+	if (!sk_is_tcp(sk))
 		return -EINVAL;
 
 	switch (optname) {
-- 
2.54.0.545.g6539524ca2-goog

