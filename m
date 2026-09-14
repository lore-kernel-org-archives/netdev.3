Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCDF33515ED;
	Mon, 14 Sep 2026 12:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789388424; cv=none; b=AUGahyK1Yd+Iq9GieIMUHZyrhYIvcKBotM7QkhEQm4Ji8jxEC8MWk79+uVDXkx2/6IXbnyAkKxStJu9Dw893aj7a0SAXRTag27MAON5LtcQsaUVW2DToltFd+wkZJ0n7svFCdAzLZvfwWggv2JwlHKG8DhkZ9FutOPqN9unHSOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789388424; c=relaxed/simple;
	bh=rdl+BcaghWHtfV7+1VqfVd7sJRug6nmHf+pErejLkqQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U8oTuOHiAIMwA27OWmbkyL8+eum6bx460DTKY+l0MxL73jMWX3YJL5N1K2pfVhDOhTFkrXiSSscTii6657+WR9DH2X8QfkTj8DjqJpYcDVq0erBtbyKvsNtDkNM1mbYBOtyHIJqwZy0Kul3qi6Jnupi8/GYPanTH8WJt5fNKO2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=Kv1UOyPP; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="Kv1UOyPP"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=36vjxovsp5VC9PYmAmRvtGCqLI9aZONSq/ohKmKaSzw=; b=Kv1UOyPPkyMnmqzOApH9BAm5Vh
	56NalrNu0EnGNaVG5ymeqgqxomEe/1/hqN6qbMDJ6TKe73imwKKOEY281NUMm5zUGCknFDtnZzQlf
	Wf1unuXffFC451u0fEFEia5BraruT1F7gBhQ5yOz/bORK6XG3y00pc3NZoIrA91wRht4brSdimuxP
	KlWgyzOQNBroBEtmC7hbHNG3+VBfvEj7QCxgGb1lNNhK/iR8p4HSU00maAYtSczA297k5xSIfv5hc
	30BJYXzR4FhlyxkjAXTDqKzKVaeW5fX0VtahJPTQjUbru9xVXpoKMtImcKS0tA49j7XW5JpkpwGQ5
	Y17unS1g==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1x65fW-003btm-1s;
	Mon, 14 Sep 2026 12:20:18 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 14 Sep 2026 05:20:07 -0700
Subject: [PATCH net-next v2 1/2] net: add sockopt_expand_out()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-getsockopt_phase6-v2-1-e48befc9602e@debian.org>
References: <20260914-getsockopt_phase6-v2-0-e48befc9602e@debian.org>
In-Reply-To: <20260914-getsockopt_phase6-v2-0-e48befc9602e@debian.org>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kuniyuki Iwashima <kuniyu@google.com>, 
 Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, 
 Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 david.laight.linux@gmail.com, Breno Leitao <leitao@debian.org>, 
 kernel-team@meta.com
X-Mailer: b4 0.16-dev-f8e9d
X-Developer-Signature: v=1; a=openpgp-sha256; l=3629; i=leitao@debian.org;
 h=from:subject:message-id; bh=rdl+BcaghWHtfV7+1VqfVd7sJRug6nmHf+pErejLkqQ=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqp+Z4MymIGXJEddyX3QBwOi6IBtF6ldg+YZjK9
 4hbYQm5Yr+JAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCaqfmeAAKCRA1o5Of/Hh3
 bc/uEACRLzTwuKw6bEUxy++GsHNq0amWJJ6Ez3ajbNj4x/haRBarVNhy1Cf5Zd1kHm7oD89Rh94
 oUQJ1ZEXv4DcVp9EkSHveXwHnh6FKhU0th1MuQqkZM8lvaFipFQKSPWjdZcwGkk+/TqTyocxK1E
 95KnRBjdwG1UqyjXEh0Q1s0bUFolgDdpXu+5WhOlMPGSsRADRGChosTqlAEai1dDJTE7iH08HPZ
 rI0xPrig74iZhH1P7jLcCS3zubkBSItVA8+AGOT7fpG03vU+v9rcdL+9FpjxFpg2qK4MCwdy/TT
 zF8UhqBtz2g56GunNaxd6aqPkAGxSvA0HvidvtTOeksdqWL2fbugmnl/vDjIIgoH/8fUyduuz6Q
 MogOyUuCSd5ICOr3TCC99TufUiuelfpvEi4Dn8aWakzlVs3EXAxfN1Zo4FojIlQlGxSfa399kww
 PzNQ6Nony9mHuYYYwkyedLE7u7ja77zac6Zp3yUEUUh/1E2IC3NZjnZ9nJjeBtdjz+iegOAOxZW
 CgDCnoljRwyj//JcfZCHKp87OQre0WU5p2RdrksNoCNr2aD71bw17Vw+0g4FLb3/zDagQfu5pNO
 q7GOUHy0LTHeA7wNd1Zhu3xvDLK2MbLj+4T/SXttwk0Qah6d2JpC4Ofb9DI+t8OK2OYIXtEWpWz
 /sdEsTaAzrup6eg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Some getsockopt options size their reply from a count the caller left in
optval rather than from optlen, and so write past the optlen the caller
declared. Userspace relies on that, so the sockopt_t conversion has to
keep doing it.

IP_MSFILTER is the first one to convert: its reply covers the
imsf_numsrc sources the caller asked for, while optlen only has to cover
the fixed header.

Add sockopt_expand_out() to grow opt->iter_out mid-air, so the quirk
sits in one place instead of each protocol assuming it implicitly. It is
a no-op unless the reply outruns optlen. Growing re-anchors the iterator
at the head of optval, so it has to be called before anything is written
through iter_out.

Only a user buffer can be longer than optlen says. A kernel-backed
optval keeps the bounded iterator, and a callback that asks to grow one
gets a WARN_ON_ONCE() and -EINVAL.

Nothing in tree can trip that WARN: the only kernel-backed path into
do_ip_getsockopt() is sol_ip_sockopt(), which takes IP_TOS and
IP_TRANSPARENT only. It is an assert for the in-kernel callers BPF and
io_uring gain once the conversion is done, so they declare an optlen
covering the whole buffer instead of repeating the userspace mistake.

The conversion in the next patch calls sockptr_to_sockopt() from
net/ipv4/, so drop its static and declare it in net.h.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 include/linux/net.h | 32 ++++++++++++++++++++++++++++++++
 net/socket.c        |  4 ++--
 2 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/include/linux/net.h b/include/linux/net.h
index 470100ae710773..7db3aff33f2ba5 100644
--- a/include/linux/net.h
+++ b/include/linux/net.h
@@ -70,6 +70,38 @@ static inline int sockopt_init_user(sockopt_t *opt, char __user *optval,
 	return 0;
 }
 
+/*
+ * Grow optval to @size, for the options whose reply is sized by a count the
+ * caller left in optval rather than by optlen. Those write past optlen today
+ * and userspace relies on it.
+ *
+ * Call it before writing through opt->iter_out: it re-anchors the iterator at
+ * the head of optval. Only a user buffer can be longer than the optlen the
+ * caller declared, so a kernel-backed optval is refused with -EINVAL.
+ */
+static inline int sockopt_expand_out(sockopt_t *opt, size_t size)
+{
+	if (size <= (size_t)opt->optlen)
+		return 0;
+
+	if (size > INT_MAX)
+		return -EINVAL;
+
+	/* Re-anchoring reads iter_out.ubuf, so the iterator has to be a user
+	 * buffer that nothing has written through yet.
+	 */
+	if (WARN_ON_ONCE(!iter_is_ubuf(&opt->iter_out) ||
+			 iov_iter_count(&opt->iter_out) != (size_t)opt->optlen))
+		return -EINVAL;
+
+	iov_iter_ubuf(&opt->iter_out, ITER_DEST, opt->iter_out.ubuf, size);
+
+	return 0;
+}
+
+int sockptr_to_sockopt(sockopt_t *opt, sockptr_t optval, sockptr_t optlen,
+		       struct kvec *kvec);
+
 struct poll_table_struct;
 struct pipe_inode_info;
 struct inode;
diff --git a/net/socket.c b/net/socket.c
index c05d86e63abf7d..29a0f7f8e2cabe 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -2437,8 +2437,8 @@ INDIRECT_CALLABLE_DECLARE(bool tcp_bpf_bypass_getsockopt(int level,
  * It is important to remember that both iov points to the same data, but,
  * .iter_in is read-only and .iter_out is write-only by the protocol callbacks
  */
-static int sockptr_to_sockopt(sockopt_t *opt, sockptr_t optval,
-			      sockptr_t optlen, struct kvec *kvec)
+int sockptr_to_sockopt(sockopt_t *opt, sockptr_t optval,
+		       sockptr_t optlen, struct kvec *kvec)
 {
 	int koptlen;
 

-- 
2.53.0-Meta

