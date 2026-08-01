Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B168630C37C
	for <netdev@vger.kernel.org>; Sat,  1 Aug 2026 14:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785592814; cv=none; b=uuO4qfo21z2wERG5I5vdic6wAyHWbKiCn14dsQW97L9LNWAGjsmjBr+rClY072boPqb55Ym2dQsL+/HG18w2F3G+vgPS4nTR4ZUBrfgqfy6wn53v5xzfuEoZHRqAnUptKw+1uX5yxNe1XtuH1/l3r3/RmVDE9epOQ+xqJ9ICoac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785592814; c=relaxed/simple;
	bh=TLKVpsxTAiz0l4w695xmNw52fMhFEdpB6KuSW5hRE8Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M9iOq93yWt6WvuX2eYZtA/6GD3ZxjjRFym4Obqx3By/eQTi9pEhFzfD3+F+EP9BTbFqyB5hgm0UhXbFE0714wCGbWFUxzfsKxsTYMKQcadDxsOJeJIYCDePuCKehKomT4vkSvpov9r7sIWiHFJFNRrBCSZmi/vEA9+5N2oAPrjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R9P+sPYY; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R9P+sPYY"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c9ef3e1337fso1401583a12.2
        for <netdev@vger.kernel.org>; Sat, 01 Aug 2026 07:00:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785592812; x=1786197612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ij3qVcBl3D2Fgt+3IhYwcypP53Zfir6uLkrmNSB7KuM=;
        b=R9P+sPYY0ZGYyQBqz1couX2RV2P4D+HbaOpyH7TyGedE1IQfxeP+Waai7OEFu6dKKV
         0fNFN9w40hQyEd+q5chP3+8COCJXKCJ05rycBkjpGRFPVLUO3Vs/kvhAVvzKqchkBKAM
         G/P03mQvyY7UfARqTaFmEqWX2oJNnFqbnXH0zfy6iwjfI0OJwafaGxSBQjc3VMltdznh
         1FEJP1nBZm2cY23IrEtNtQj7st0wNMqOXEd5stDR5xa/OeB67Z9ZsxxPucS9960ed6IK
         226Kc+MO5YDbmWdq/gIGx5PmQB0AvWpNGs4sZw2pLtGKhhncF9Z6mjw47MErKA22pbES
         dJdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785592812; x=1786197612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ij3qVcBl3D2Fgt+3IhYwcypP53Zfir6uLkrmNSB7KuM=;
        b=JmlfFcANasafYB27eRT0xi6uQkVakZNO59ysDB6xi6Ecxh5r/2/y7flG+iPDp4X6lw
         o8uTLw8NFVIuGLsRnRd8xPN/RV2TkXxjNb3XYFPp8Y0vRHIgXAu3GUXQ2FRFMGgAJn9n
         wAXG9Cdu0mvmyySUwHqaGWM9G6b4Lxrtfv6rdCnDGG4H5VvYWIqd1rnEtmwh6Q/NgOMV
         mo0mJ7mOQZBwx9oncpKvj5UnNyHUDZ0LTqlAU0b1JQqbTVi/DdTBmwmkTjz3wBmELws4
         qb71+qM8DUti5YbP7uDlyYJnl4FteVQfeZomeHe894qzeE1Dv7dzAopg66l+aXQUGKKa
         bQ7A==
X-Forwarded-Encrypted: i=1; AHgh+Rov6rsskunU2g2BXir/Z+ydfEHhuYxFI8lnLQ4IqsSPFmiz0c5VfuHefzqnB15KVunU4C6LdgM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8gbfmH9qIiRGo3TIID10rJRp2RfECz0xzKycYVuNH9P9TFNY8
	5XSCn0EsFo0SOnklyJC6sPkZAXS29dtM8U1bcUh5wHBZcX6bmNgorJKP
X-Gm-Gg: AR+sD11nHFUcn+ds4KLP8JQF5SJnRpJ++pLvJJnInkRo1hAmuNTcDdbG1v7rmjxphY9
	rElIMAznU2YBiicFpqh4wYlzBgTjIRTUHAJrpXLVjn8DBJxkC/p+SNH7seqrm0mnK0uKD2opJBj
	dCSBQbRNlCHldaiuO4LPu1iZ5kbXeHACgJ9UYfOaTIPxFjYf5SNFRCGGCHVYk5FVG0zqAQZpKEK
	FtYy72wN6cgCSmmkwoe49DQylmfTTulH9vTIyKpqInrK/AzSxDV1rDhXUXn6FfrKRN4gJzD2puG
	ZZ35Z6cwYyiWi5L8vy9n94lSocZNx+TZFGmoHKubfbyzRhmq/Gn5/uokHNTfO0xT6dkl+ZrouWX
	gwbsHzTK9C3+CudyXeqbBaehJbc3DxTB1NlsX2rPPfRPjiamuTyg6ljy7ah6edMAtVBpDouTM5i
	dAXs8LwjCETg9jRjOWbHRnIMlbZN0YGtvg0BwC2W5QaxHkqZVtgNFPqnUg08wtVzdoz3WnOv0j2
	khJ
X-Received: by 2002:a05:6a21:6112:b0:3c3:a3fd:db0a with SMTP id adf61e73a8af0-3c92a62d724mr3112934637.16.1785592811080;
        Sat, 01 Aug 2026 07:00:11 -0700 (PDT)
Received: from enjou-Legion-Y7000P-2019 ([165.232.167.5])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e18d9c6sm18493764eec.30.2026.08.01.07.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 07:00:10 -0700 (PDT)
From: Ren Wei <enjou1224z@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	jolsa@kernel.org,
	emil@etsalapatis.com,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	lmb@cloudflare.com,
	vega@nebusec.ai,
	rakukuip@gmail.com,
	enjou1224z@gmail.com
Subject: [PATCH 1/1] bpf: Check sk_fullsock() in bpf_tcp_*_syncookie
Date: Sat,  1 Aug 2026 21:59:39 +0800
Message-ID: <ca8d8c570509b02355bb4bd4e56859f3e2564c9c.1785576172.git.rakukuip@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <cover.1785576172.git.rakukuip@gmail.com>
References: <cover.1785576172.git.rakukuip@gmail.com>
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

Fix this issue by adding a sk_fullsock(sk) check at the start of both
bpf_tcp_gen_syncookie and bpf_tcp_check_syncookie before inspecting
fullsock-specific fields.

Fixes: c0df236e1394 ("bpf: Change bpf_tcp_*_syncookie to accept ARG_PTR_TO_BTF_ID_SOCK_COMMON")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Luxiao Xu <rakukuip@gmail.com>
Signed-off-by: Ren Wei <enjou1224z@gmail.com>
---
 net/core/filter.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/core/filter.c b/net/core/filter.c
index b446aa8be5c3..afdcfdf41489 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7678,6 +7678,9 @@ BPF_CALL_5(bpf_tcp_check_syncookie, struct sock *, sk, void *, iph, u32, iph_len
 	if (unlikely(!sk || th_len < sizeof(*th)))
 		return -EINVAL;
 
+	if (!sk_fullsock(sk))
+		return -EINVAL;
+
 	/* sk_listener() allows TCP_NEW_SYN_RECV, which makes no sense here. */
 	if (sk->sk_protocol != IPPROTO_TCP || sk->sk_state != TCP_LISTEN)
 		return -EINVAL;
@@ -7752,6 +7755,9 @@ BPF_CALL_5(bpf_tcp_gen_syncookie, struct sock *, sk, void *, iph, u32, iph_len,
 	if (unlikely(!sk || th_len < sizeof(*th) || th_len != th->doff * 4))
 		return -EINVAL;
 
+	if (!sk_fullsock(sk))
+		return -EINVAL;
+
 	if (sk->sk_protocol != IPPROTO_TCP || sk->sk_state != TCP_LISTEN)
 		return -EINVAL;
 
-- 
2.43.0
