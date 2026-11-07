Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794074384;
	b=0PKiwL7cT0SyIJ7Of6jDeB89NnX2dkWOwIwc/huxRjtAk0/MhBkBsp11Rb70s8BNzqx5
	 uwAVI/96Br0nXjxiXKlBtTBDpDAjaH15ddjPDjda5qyV8AzqPiAXMcA3aoW1AaOagIRX6
	 EYxX6ngusQoua+AtLO1Ox6oSOX9cOYdbZRMvcUO3/AW/DHujIubYoQpND7YqRvek31mVa
	 AiAJcxYoFoNJGxr9EDKn8LvRptU5+0giS4SvMIXcjiR++f/B4GShdi2wSC0Lcg20DKmbl
	 adVNTq4FAl1qhlssHJTSrrr97GOPPh6302Q+JVMfE4wqHzjFYuUP/Hmu4LO+pXG81jQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794074384;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=79FysFjd2dyWM4cbOMbQLuIbKRWCojV53uV/DjjCXlA=;
	b=e9CkWqyehB0Dhkx5jz4Qyi8g+kz9u+Y8dXsBEia6S3GPQmYvt6xYK33SXQTXVeHwuYSx
	 c/7dSl5W5jpec0YE4lemtnOwUVr/iCDqxOUyHBbH4e32sx6kpbFf/e8hPryZz+3RzOrXe
	 GmbkyFR7YfLT/L7u3QMgzqC1jPy0u6BGdItbcxnV4XhLigxTnHrdCZs9iSquSmHo0Z6Sk
	 VobXOLFCmCmCfsqP5C4QeChJul0I4wcGt/abitOYefRFno+IscGHOoAtvRKcd9qaoX0EV
	 UR1kY0ucjo3eBTUu7Je2qVIQfFpmSj8GIqH0OeFRXykhGIUB8jFtG79YaFYewAm4DYw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=CfYeAE4O;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF71606D805;
	Sat,  7 Nov 2026 17:59:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AAF71606D805
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=CfYeAE4O
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xPkhM-007j5d-Si; Sat, 07 Nov 2026 18:59:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=79FysFjd2dyWM4cbOMbQLuIbKRWCojV53uV/DjjCXlA=; b=CfYeAE4OX5KfHBKRVmKR+1EMv/
	WCUDdgYn/LemlW0AK5ua22B5SOjTKOsRov3VZsr4+lGiBa8Thc3ub9NXdWukhHzfBv8BL6VlbjdHs
	uz+KNYO9g5wzNwWkURgu5lxSDIsLFOJuiQe6rxqa6s8BUzU1lr/SlWgUSCQILEGDKDl+fYJwPGSB5
	OvJnA/QKJox5KMW2i4qDBqmmX2P7Nf2w79G9cwNkdAWCJ6r8ngDFTaRPJ0PU0iYLpEHZKI6j6Cj4/
	0XREUBGFxyc69nyLyD8U93rxRF346xt+ZKYiCTN//puCA+f6YmExXw3ZprNrvM2j8dym5tvHjyPt+
	7kESatKA==;
Received: from [10.9.9.74] (helo=submission03.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xPkhC-0006I8-Gl; Sat, 07 Nov 2026 18:59:18 +0100
Received: by submission03.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xPkh6-007LnK-Ee;
	Sat, 07 Nov 2026 18:59:12 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Sat, 07 Nov 2026 18:58:27 +0100
Subject: [PATCH bpf-next v3 5/8] bpf: Restrict bpf_sock_destroy() to
 iter/{tcp,udp}
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
Message-Id: <20261107-sockmap-update-limit-iter-v3-5-7c0bad1ad036@rbox.co>
References: <20261107-sockmap-update-limit-iter-v3-0-7c0bad1ad036@rbox.co>
In-Reply-To: <20261107-sockmap-update-limit-iter-v3-0-7c0bad1ad036@rbox.co>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Eric Dumazet <edumazet@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Paolo Abeni <pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
 Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, Stanislav Fomichev <sdf@fomichev.me>
Cc: Michal Luczaj <mhal@rbox.co>, bpf@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org, 
 netdev@vger.kernel.org, linux-doc@vger.kernel.org
X-Mailer: b4 0.15.2

A subsequent patch will mark bpf_iter__sockmap::sk as PTR_TRUSTED, making
bpf_sock_destroy() callable from the iter/sockmap. Unlike iter/{tcp,udp},
the sockmap iterator does not run progs with the socket lock held, so
destroying a socket from that context is unsafe. Restrict the allowed
callers of bpf_sock_destroy() to iter/{tcp,udp}.

Suggested-by: Alexei Starovoitov <ast@kernel.org>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 net/core/filter.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 9245009d9f1e..6a67bc2a0c4b 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -13072,11 +13072,20 @@ BTF_KFUNCS_START(bpf_sk_iter_kfunc_ids)
 BTF_ID_FLAGS(func, bpf_sock_destroy)
 BTF_KFUNCS_END(bpf_sk_iter_kfunc_ids)
 
+BTF_SET_START(bpf_sk_iter_locked_ids)
+#if defined(CONFIG_INET) && defined(CONFIG_PROC_FS)
+BTF_ID(func, bpf_iter_tcp)
+BTF_ID(func, bpf_iter_udp)
+#endif
+BTF_SET_END(bpf_sk_iter_locked_ids)
+
 static int tracing_iter_filter(const struct bpf_prog *prog, u32 kfunc_id)
 {
 	if (btf_id_set8_contains(&bpf_sk_iter_kfunc_ids, kfunc_id) &&
-	    prog->expected_attach_type != BPF_TRACE_ITER)
+	    (prog->expected_attach_type != BPF_TRACE_ITER ||
+	     !btf_id_set_contains(&bpf_sk_iter_locked_ids, prog->aux->attach_btf_id)))
 		return -EACCES;
+
 	return 0;
 }
 

-- 
2.56.0

