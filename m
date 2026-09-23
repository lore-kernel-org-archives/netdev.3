Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E511415B88
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 21:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790199449; cv=none; b=BgDEfZ6wUDcaGqwgD6OOj0RKsQtzNzk8DOoSciNfKjXDq6J8agYnrO6uXJMhJR2JbVLgcWHi19NErsw1UUjKBreNebipoZI3HI6n6EsyOT+Dw2GEswdI/p5OinOIkvkgJP7eFLvZyxZS5KfMbk8VAYRooma5xAsiPEMaUIniqTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790199449; c=relaxed/simple;
	bh=UbHmErwKa1LNMZL8wSqNobROJxCTMjZwZ9+wubqZks8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=W2eqzwg6sZKRphaDwlPjtUqUK0wHZS4/Fe6EuN88WvfkP9UAv6mZAaOeHbSe5HYGrwUaDoB/uZUXXKgqK69ZOPHclu6DLOO554Za1vXn9jFFsNa7z8FtOFXqLvIv4cJ/yaQhkr86IOBT0DhTRHWX2x6h1dRYCMhGBbyEj9Dyv1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZmLtP5Ml; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZmLtP5Ml"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-86a2639398cso2028696b3a.3
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 14:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790199446; x=1790804246; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nXjxlANPMrBNjgEiyPC2Hx/uW+CVjrY7H4f/iI7RVRk=;
        b=ZmLtP5Ml/iMhZ1rELNJEy+hkM3ckb8/ITzet+4HJoFZFzBd/622xSPRrG1kdenc8WV
         GeKwOIqSoLrHSZRDkqvknyGJUitYirV3rQADznKsogVs78Xxx0tLFWqWVAS8C66fRXIp
         D4gBHb8d4JhA/DhRwwxr/wl3yk3yWmcDmCHxFP48IRnva5zvaHNeZG5E40R7GA6itxZ3
         crCXKu6VjVrPdnyfR0XWrGAMR62FTbLFBWVS1nQGojdXtIDitjb7rfkOWPAlfnxlFAZu
         cuOeZhxc+A+lB9sV97+tpZty5BaiMkHMk21BUTQMt4AQgtkye3tjBX3YwHtvTiW11Odv
         Ca5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790199446; x=1790804246;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nXjxlANPMrBNjgEiyPC2Hx/uW+CVjrY7H4f/iI7RVRk=;
        b=w6TTt2SRvDCznz0FunYT4o8EgP74u8uu5+/bR8656KliNQaual1DlA1OxeURtmGJt6
         CKpdPmWy7gcdcOG9CeRXiGxgiFp1ClrNXm53vbib61qNSxftoVf9BF5xoGQV6GcEJygG
         /IYi3n5Gv6fJ1IhX0GQNIP1a8ooHFoGbesTmzMkYCSbHJb0HYi4pjhLXs39v0JhH7jj+
         xYDypde5i5Y1feFak5jDzinHJQGbhx9gHmw6pAISdjaPqI2orqi2K635kZFJQqOmSDnB
         ewLH9JnAcdB+9Bb8J79uMtbwiHo+MjwDzr9Y9t8Tpe/2v0o9mrcCsvkhRJ9Y1jJLVClX
         xA8Q==
X-Forwarded-Encrypted: i=1; AKwUvBzscY/19jKFF18bwijz0A3Kr7Wst+kRFxgj2jPM7F8mmJx+M3/D+oMqQljLp2sZoN6lQGWls40=@vger.kernel.org
X-Gm-Message-State: AFuF++ljiVTZalGuXW8rgSsm4YX+c84bovOeOaWSbroyUrnh3gxZMCMx
	mOzGU2BGeJQimUXWSqyDXCzDp2qYFXyXji5feAOOdnqC3O2dYsmFUu5p7xIOS0oK93sQzjrGhZk
	qPngv6g==
X-Received: from pfbdn16.prod.google.com ([2002:a05:6a00:4990:b0:874:919e:d6e2])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:4615:b0:874:708d:b62e
 with SMTP id d2e1a72fcca58-87ea06d48fdmr325653b3a.35.1790199445482; Wed, 23
 Sep 2026 14:37:25 -0700 (PDT)
Date: Wed, 23 Sep 2026 21:35:34 +0000
In-Reply-To: <20260923213719.224838-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260923213719.224838-1-kuniyu@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260923213719.224838-5-kuniyu@google.com>
Subject: [PATCH v2 bpf-next 4/8] bpf: tcp: Support bpf_sock_ops_cb_flags_set()
 for bpf_tcp_ops.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau <martin.lau@linux.dev>, 
	Eduard Zingerman <eddyz87@gmail.com>, Kumar Kartikeya Dwivedi <memxor@gmail.com>
Cc: Yonghong Song <yonghong.song@linux.dev>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Eric Dumazet <edumazet@google.com>, 
	Neal Cardwell <ncardwell@google.com>, Willem de Bruijn <willemb@google.com>, 
	Tenzin Ukyab <ukyab@berkeley.edu>, 
	"=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?=" <cleger@meta.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, bpf@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When an error occurs in bpf_tcp_ops.{enqueue,dequeue}_rcvq(),
we want to clear BPF_SOCK_OPS_RCVQ_CB_FLAG to stop invoking
the callbacks.

In addition, bpf_sock_ops_cb_flags_set() is often used during
setup or just after 3WHS completes to enable opt-in hooks.

Let's support bpf_sock_ops_cb_flags_set() in the following
callbacks: connect, listen, {active,passive}_established,
{enqueue,dequeue}_rcvq.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
Acked-by: Stanislav Fomichev <sdf@fomichev.me>
---
 include/uapi/linux/bpf.h       |  2 +-
 net/ipv4/bpf_tcp_ops.c         | 27 +++++++++++++++++++++++++++
 tools/include/uapi/linux/bpf.h |  2 +-
 3 files changed, 29 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index fe122242b096..8cdf22667775 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -3264,7 +3264,7 @@ union bpf_attr {
  * 	Return
  * 		0
  *
- * long bpf_sock_ops_cb_flags_set(struct bpf_sock_ops *bpf_sock, int argval)
+ * long bpf_sock_ops_cb_flags_set(void *bpf_sock, int argval)
  * 	Description
  * 		Attempt to set the value of the **bpf_sock_ops_cb_flags** field
  * 		for the full TCP socket associated to *bpf_sock_ops* to
diff --git a/net/ipv4/bpf_tcp_ops.c b/net/ipv4/bpf_tcp_ops.c
index c963e2cc21b5..4b48711d92a2 100644
--- a/net/ipv4/bpf_tcp_ops.c
+++ b/net/ipv4/bpf_tcp_ops.c
@@ -220,6 +220,24 @@ const struct bpf_func_proto bpf_tcp_ops_get_retval_proto = {
 	.ret_type	= RET_INTEGER,
 };
 
+BPF_CALL_2(bpf_tcp_ops_cb_flags_set, struct sock *, sk, int, argval)
+{
+	int val = argval & BPF_SOCK_OPS_ALL_CB_FLAGS;
+
+	tcp_sk(sk)->bpf_sock_ops_cb_flags = val;
+
+	return argval & ~BPF_SOCK_OPS_ALL_CB_FLAGS;
+}
+
+static const struct bpf_func_proto bpf_tcp_ops_cb_flags_set_proto = {
+	.func		= bpf_tcp_ops_cb_flags_set,
+	.gpl_only	= false,
+	.ret_type	= RET_INTEGER,
+	.arg1_type	= ARG_PTR_TO_BTF_ID,
+	.arg1_btf_id	= &btf_sock_ids[BTF_SOCK_TYPE_TCP],
+	.arg2_type	= ARG_ANYTHING,
+};
+
 static bool is_sockopt_supported(u32 moff)
 {
 	switch (moff) {
@@ -274,6 +292,15 @@ get_func_proto(enum bpf_func_id func_id, const struct bpf_prog *prog)
 		if (moff == offsetof(struct bpf_tcp_ops, write_hdr_opt))
 			return &bpf_tcp_ops_store_hdr_opt_proto;
 		return NULL;
+	case BPF_FUNC_sock_ops_cb_flags_set:
+		if (moff == offsetof(struct bpf_tcp_ops, connect) ||
+		    moff == offsetof(struct bpf_tcp_ops, listen) ||
+		    moff == offsetof(struct bpf_tcp_ops, active_established) ||
+		    moff == offsetof(struct bpf_tcp_ops, passive_established) ||
+		    moff == offsetof(struct bpf_tcp_ops, enqueue_rcvq) ||
+		    moff == offsetof(struct bpf_tcp_ops, dequeue_rcvq))
+			return &bpf_tcp_ops_cb_flags_set_proto;
+		return NULL;
 	default:
 		return bpf_base_func_proto(func_id, prog);
 	}
diff --git a/tools/include/uapi/linux/bpf.h b/tools/include/uapi/linux/bpf.h
index fe122242b096..8cdf22667775 100644
--- a/tools/include/uapi/linux/bpf.h
+++ b/tools/include/uapi/linux/bpf.h
@@ -3264,7 +3264,7 @@ union bpf_attr {
  * 	Return
  * 		0
  *
- * long bpf_sock_ops_cb_flags_set(struct bpf_sock_ops *bpf_sock, int argval)
+ * long bpf_sock_ops_cb_flags_set(void *bpf_sock, int argval)
  * 	Description
  * 		Attempt to set the value of the **bpf_sock_ops_cb_flags** field
  * 		for the full TCP socket associated to *bpf_sock_ops* to
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

