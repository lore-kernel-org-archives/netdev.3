Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.226.149.37
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793582302;
	b=VlVcwvVAhcgtxnayvxnvdPYyuO58u+w349GoYSjvx4EYCUAbBHRTs5MtQcu6xAvjR0wP
	 1gJx8oH8oKfh+h2OzZJhlFCv4YQ3pTpLPFApWsY8ZJJ6/ed9XkItgy71X5JlTupzM4clb
	 wiZpUFtv6DgNviV3kCGRsrAGvOe/xrDLdgv4DkbXW7J5WoqGVN9l/EG6loFJVnYLmj6EA
	 0yZNv3bXS9i2Di+tR3rO+ybMJeTldD9hm2BTzE0mFFgbxaB8fMqBcX+SmSG3CPvpgM4pK
	 LarEkwar13xQG7V20abhJz7oTa4BZ/SIgyApLM/u58dOiM7yQUbUShN3W3PITdieo7Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793582302;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer;
	bh=8tIm04Oja/SW4T8u6sczsnBdJ7I+/QcEMyTu0oj4EaQ=;
	b=mhOVSjJTBLAxOb3oVB90hbZ9DTFuGOgJSuxYIG6T3O/XjVaUSS7+Q59dL5+AfpmH6osi
	 9wSZm6NSgpfo0WVaPfK6hYMsVVkQ1B1RqcIRr1sXdF4llSViNw494exMZ6xgEVIJOPsOM
	 GPouLuXa4yGNHFNH7pqBo2iUw+QGhiXOyBkjTlnvqGjkk6qLp5VKS0Gx0+en70Ms+IW95
	 65tAo6RnhwCgB5JZnT9rS0lODOLNAS0b2DGM1rwXk9AI2F18oOIYFEzX/hM6SuO3jzEGj
	 HOeZDH+Q+YBARa0frG89h8QwpEBvsQ4tP2E2Xn/k1fwvNF/m0OASlcnd2SAIHrQ4P4A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rbox.co;
	spf=pass smtp.mailfrom=rbox.co;
	dkim=pass header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=SMdZ9D9x;
	arc=none smtp.remote-ip=185.226.149.37
Received: from mailtransmit04.runbox.com (mailtransmit04.runbox.com [185.226.149.37])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581A460A260B
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 01:18:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 581A460A260B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rbox.co
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rbox.co
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rbox.co header.i=@rbox.co header.a=rsa-sha256 header.s=selector1 header.b=SMdZ9D9x
Received: from mailtransmit02.runbox ([10.9.9.162] helo=aibo.runbox.com)
	by mailtransmit04.runbox.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.93)
	(envelope-from <mhal@rbox.co>)
	id 1xNggX-008AQp-C0; Mon, 02 Nov 2026 02:18:05 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=rbox.co;
	s=selector1; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From;
	bh=8tIm04Oja/SW4T8u6sczsnBdJ7I+/QcEMyTu0oj4EaQ=; b=SMdZ9D9xVKQXZPhSoZ6UThEiwR
	FJY2FadAoyT3s3OfVkbW1bRfZw7FQnWVRs8muTJkeMl1iy8AyCJvCTQSrCaW6mKHwNa2TjaSuaRIn
	y6kifW7E+iweoHXJsMBPFS0nRp+xESj7P9OjvszqltwpmchHOuAdSybYDO8P06H/zPgy3lRWWrVgr
	Ufh0mAXQR+e9tLHP31SkLRZhLLApNSQFFHX7wkSG72TThhL452dNHnQCT3qfG+U5CEI2prKyC0HKB
	Zre7fSOF9GDf04NozlwgR0JiBIvV2LyiC6IP6LFmczy8Si+ae3FZaVpiX+q7sNoPfyBOim4jK9T10
	IbpqsDqA==;
Received: from [10.9.9.72] (helo=submission01.runbox)
	by mailtransmit02.runbox with esmtp (Exim 4.86_2)
	(envelope-from <mhal@rbox.co>)
	id 1xNggR-0005sB-H8; Mon, 02 Nov 2026 02:17:59 +0100
Received: by submission01.runbox with esmtpsa  [Authenticated ID (604044)]  (TLS1.2:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.95)
	id 1xNggK-008JiF-9p;
	Mon, 02 Nov 2026 02:17:52 +0100
From: Michal Luczaj <mhal@rbox.co>
Date: Mon, 02 Nov 2026 02:15:59 +0100
Subject: [PATCH RFC v2 2/4] bpf, sockmap: Restrict iter-context sockmap
 updates to iter/sockmap
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
Message-Id: <20261102-sockmap-update-limit-iter-v2-2-e96a63c43b39@rbox.co>
References: <20261102-sockmap-update-limit-iter-v2-0-e96a63c43b39@rbox.co>
In-Reply-To: <20261102-sockmap-update-limit-iter-v2-0-e96a63c43b39@rbox.co>
To: Alexei Starovoitov <ast@kernel.org>, 
 Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
 Eduard Zingerman <eddyz87@gmail.com>, 
 Kumar Kartikeya Dwivedi <memxor@gmail.com>, 
 Martin KaFai Lau <martin.lau@linux.dev>, Song Liu <song@kernel.org>, 
 Yonghong Song <yonghong.song@linux.dev>, Jiri Olsa <jolsa@kernel.org>, 
 Emil Tsalapatis <emil@etsalapatis.com>, 
 Ihor Solodrai <ihor.solodrai@linux.dev>, Shuah Khan <shuah@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Lorenz Bauer <lmb@cloudflare.com>, Eric Dumazet <edumazet@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, Paolo Abeni <pabeni@redhat.com>, 
 Willem de Bruijn <willemb@google.com>, 
 Jakub Sitnicki <jakub@cloudflare.com>, 
 Jiayuan Chen <jiayuan.chen@linux.dev>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Michal Luczaj <mhal@rbox.co>, 
 netdev@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2

Among tracing progs, allow only iter/sockmap to update sockmaps and
sockhashes. Previously, any BPF_TRACE_ITER program could perform these
updates, which caused locking issues in specific scenarios [1][2][3]. This
tightening is part of the broader effort to lock down the BPF API [4].

[1]: commit 4d328dd69538 ("bpf, sockmap: Fix af_unix iter deadlock")
[2]: commit 64c2f93fc325 ("bpf, sockmap: Take state lock for af_unix iter")
[3]: https://msgid.link/87echn2fhd.fsf@cloudflare.com
[4]: https://msgid.link/akRZ_e7DJh2aP-2i@john-p8

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://msgid.link/20260626205814.BAC3C1F000E9@smtp.kernel.org
Suggested-by: Jakub Sitnicki <jakub@cloudflare.com>
Signed-off-by: Michal Luczaj <mhal@rbox.co>
---
 kernel/bpf/verifier.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/bpf/verifier.c b/kernel/bpf/verifier.c
index 1b6c0674ff6a..4dadfe9505a2 100644
--- a/kernel/bpf/verifier.c
+++ b/kernel/bpf/verifier.c
@@ -10487,6 +10487,7 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 {
 	enum bpf_attach_type eatype = env->prog->expected_attach_type;
 	enum bpf_prog_type type = resolve_prog_type(env->prog);
+	const char *afname = env->prog->aux->attach_func_name;
 
 	if (func_id != BPF_FUNC_map_update_elem &&
 	    func_id != BPF_FUNC_map_delete_elem)
@@ -10497,7 +10498,8 @@ static bool may_update_sockmap(struct bpf_verifier_env *env, int func_id)
 	 */
 	switch (type) {
 	case BPF_PROG_TYPE_TRACING:
-		if (eatype == BPF_TRACE_ITER)
+		if (eatype == BPF_TRACE_ITER &&
+		    !strcmp(afname + strlen(BPF_ITER_FUNC_PREFIX), "sockmap"))
 			return true;
 		break;
 	case BPF_PROG_TYPE_SOCK_OPS:

-- 
2.56.0

