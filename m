Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7521425CCB;
	Wed,  8 Jul 2026 11:52:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783511550; cv=none; b=jv9t84SUM5Kko9OZ7pazWCqYmdtTEzSNKXDzxqs9SeNstk22MQmMHdwhp5gEG9+D0LjvUI8MET5aZtWIhLT+5K8MuAfSVft0KW/PRl/mVtu9ZRPj0EbxovmtRuKwRM43xJUr4GSnSG66zRByDx2fC9Fp6SUveGWrKRwHFOmPjoU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783511550; c=relaxed/simple;
	bh=kJ+Kh3oaC1Ua5xY6TwLFvAdMgWjJTsHzrAQ6sjb1nSo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Jkh6omlLYmPYwYCBYR87pXHlyVR39tVdSaZlIPBgSSuBOoZUe07iqNpj7IELuaKusnZotbejzI0k6WyMo+a3GR3gcL9zloeW2mMkx2zW2ZsJ8kQiHaDuIShLvamMpDgDcy+iDtR0Hw4gexn0xKcgqpWJ0+tn7+YxX+26efd9uBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=lVglUYCY; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="lVglUYCY"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=i75F3RttXhulJNWIw2ZX+9qrsSgvWqNEAljgohIXHqo=; b=lVglUYCYMQJITRssT8MSLzeG8l
	zAOPREnVlAgeRaLbYcQiEeoT5FxxROdOewF77AU9enatoHYCss2lQY7IYF511WVmsf3VJs6VBdb+1
	4raK2h1si/v6AJeraq2zT593SIKpa3ZRDrEOJpW/3SwKEqjxhMlNUA3oedncbxoEzhXxqLgKVbT1P
	t0/VHbpN7WjDNzq9ujzVvEBk4FMn3QaDz2p+6SYU0j6twldEtsc2jESgmqRMSHq9znD+HlHrIYkeq
	YJrYR3d5qDuAIofUyS9R4cw40zQ9Pm34BoHotyummN6P/bsvGO/zNBxL6D0jH5UUPSlRk4fQCZsUV
	YXwxUZaw==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1whQpF-002veG-22;
	Wed, 08 Jul 2026 11:52:25 +0000
From: Breno Leitao <leitao@debian.org>
Date: Wed, 08 Jul 2026 04:51:59 -0700
Subject: [PATCH net-next 2/2] nfc: llcp: convert to getsockopt_iter
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260708-getsockopt_phase3-v1-2-d8394f2fc554@debian.org>
References: <20260708-getsockopt_phase3-v1-0-d8394f2fc554@debian.org>
In-Reply-To: <20260708-getsockopt_phase3-v1-0-d8394f2fc554@debian.org>
To: David Heidelberg <david@ixit.cz>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, sdf.kernel@gmail.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.16-dev-d5d98
X-Developer-Signature: v=1; a=openpgp-sha256; l=3487; i=leitao@debian.org;
 h=from:subject:message-id; bh=kJ+Kh3oaC1Ua5xY6TwLFvAdMgWjJTsHzrAQ6sjb1nSo=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBqTjnt8a/t0gbzvG9IACJApyw75iyKrVVohGGta
 HnOIUb8cVmJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCak457QAKCRA1o5Of/Hh3
 bfmyEACtoUebDNDwdaYYXV8ChpKTNxvPDiz43uWn2kW3qfM7z3V/fBvt4jJ71h83RURQJf8NUzH
 uvmzsJ72rw4dzTzl+pq6qUz1n+MMFgosWQVrU9v49JtUlErn35H9rRLDt8K8mU5lIssB5ONBNJ8
 0koPrq9x2ccf7iUlj5qwyCQ0ye4EkIwa77xuTu7liTIxpb7bgSZjzXXJ/X/FTirSqIufRNhvASN
 Zqtap5YvUmkVOFvkhbx4ocd0YiiXxsX4GVGB/x4ddtQjQmEwnLq+OIOkAtwthtEF4gsUQA1naJo
 OBAN8EudBrdrbjCeRan4O9597j4mvwIaJijACAcVXUnYIKtF8s2BNAz67WhGdjbxF6PI2sgRqsO
 Jyq/Wr7iYsqhvX4AC6qDBfULJj38Nqhjjy+iNqNczVkhVBkm9FZtaUriFz1FR/15zbgdy8VdbVC
 Vghvu6RiXUeJn4NzZEyz5so9VwBoy+5vilV7d8d2cqEhrZuQ9ecu+ywHlejL14Gn139KK1lbnpw
 8YHnfsvP8m6f4qtm9eJcwdWR+XFbYh6prAfbreQ1SmFpYwgrudGWYQHJtQIuDkfe/yI/xVJ7/xm
 hcZtXwv4Jb7Dm9/u+6dTAilSlfDR+HF/ivqyCK+m8Kai2NdXVFEkxiE5nh+zDXu0l/4Phra+GUx
 07ij+1DoXM5arxg==
X-Developer-Key: i=leitao@debian.org; a=openpgp;
 fpr=AC8539A6E8F46702CA4A439B35A3939FFC78776D
X-Debian-User: leitao

Convert nfc_llcp_getsockopt() to the getsockopt_iter proto_ops callback.
It takes a sockopt_t and writes each value with copy_to_iter() instead of
a put_user() into optval; the socket layer builds the sockopt_t and copies
the length back. The socket lock and optlen validation are unchanged.

No functional change.

Signed-off-by: Breno Leitao <leitao@debian.org>
---
 net/nfc/llcp_sock.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/net/nfc/llcp_sock.c b/net/nfc/llcp_sock.c
index 94850fbe3620d..0f9cd03294074 100644
--- a/net/nfc/llcp_sock.c
+++ b/net/nfc/llcp_sock.c
@@ -302,21 +302,20 @@ static int nfc_llcp_setsockopt(struct socket *sock, int level, int optname,
 }
 
 static int nfc_llcp_getsockopt(struct socket *sock, int level, int optname,
-			       char __user *optval, int __user *optlen)
+			       sockopt_t *opt)
 {
 	struct nfc_llcp_local *local;
 	struct sock *sk = sock->sk;
 	struct nfc_llcp_sock *llcp_sock = nfc_llcp_sock(sk);
+	u32 miux, remote_miu, remote_lto, remote_rw, rw;
 	int len, err = 0;
-	u32 miux, remote_miu, rw;
 
 	pr_debug("%p optname %d\n", sk, optname);
 
 	if (level != SOL_NFC)
 		return -ENOPROTOOPT;
 
-	if (get_user(len, optlen))
-		return -EFAULT;
+	len = opt->optlen;
 
 	if (len < 0)
 		return -EINVAL;
@@ -337,7 +336,7 @@ static int nfc_llcp_getsockopt(struct socket *sock, int level, int optname,
 	switch (optname) {
 	case NFC_LLCP_RW:
 		rw = llcp_sock->rw > LLCP_MAX_RW ? local->rw : llcp_sock->rw;
-		if (put_user(rw, (u32 __user *) optval))
+		if (copy_to_iter(&rw, len, &opt->iter_out) != len)
 			err = -EFAULT;
 
 		break;
@@ -346,7 +345,7 @@ static int nfc_llcp_getsockopt(struct socket *sock, int level, int optname,
 		miux = be16_to_cpu(llcp_sock->miux) > LLCP_MAX_MIUX ?
 			be16_to_cpu(local->miux) : be16_to_cpu(llcp_sock->miux);
 
-		if (put_user(miux, (u32 __user *) optval))
+		if (copy_to_iter(&miux, len, &opt->iter_out) != len)
 			err = -EFAULT;
 
 		break;
@@ -355,19 +354,21 @@ static int nfc_llcp_getsockopt(struct socket *sock, int level, int optname,
 		remote_miu = llcp_sock->remote_miu > LLCP_MAX_MIU ?
 				local->remote_miu : llcp_sock->remote_miu;
 
-		if (put_user(remote_miu, (u32 __user *) optval))
+		if (copy_to_iter(&remote_miu, len, &opt->iter_out) != len)
 			err = -EFAULT;
 
 		break;
 
 	case NFC_LLCP_REMOTE_LTO:
-		if (put_user(local->remote_lto / 10, (u32 __user *) optval))
+		remote_lto = local->remote_lto / 10;
+		if (copy_to_iter(&remote_lto, len, &opt->iter_out) != len)
 			err = -EFAULT;
 
 		break;
 
 	case NFC_LLCP_REMOTE_RW:
-		if (put_user(llcp_sock->remote_rw, (u32 __user *) optval))
+		remote_rw = llcp_sock->remote_rw;
+		if (copy_to_iter(&remote_rw, len, &opt->iter_out) != len)
 			err = -EFAULT;
 
 		break;
@@ -379,8 +380,7 @@ static int nfc_llcp_getsockopt(struct socket *sock, int level, int optname,
 
 	release_sock(sk);
 
-	if (put_user(len, optlen))
-		return -EFAULT;
+	opt->optlen = len;
 
 	return err;
 }
@@ -937,7 +937,7 @@ static const struct proto_ops llcp_sock_ops = {
 	.listen         = llcp_sock_listen,
 	.shutdown       = sock_no_shutdown,
 	.setsockopt     = nfc_llcp_setsockopt,
-	.getsockopt     = nfc_llcp_getsockopt,
+	.getsockopt_iter = nfc_llcp_getsockopt,
 	.sendmsg        = llcp_sock_sendmsg,
 	.recvmsg        = llcp_sock_recvmsg,
 	.mmap           = sock_no_mmap,

-- 
2.53.0-Meta

