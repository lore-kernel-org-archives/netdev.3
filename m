Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=82.195.75.108
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232534;
	b=seecbpj82ZCztDoBxGKRvYKMCiiAVlvqqag2mPdvGVEZ1DYkmOiUlmbA379CM6wVj8RU
	 e0JhhT49PAjMmXtCYwxGdG0la1zyOpVK7nwcifJ+PsD1ue/MRr2rGSH5YzKT3nr7/ei0P
	 B1rWtNJjpXTA595i3Z6V7eTLGUS15FV4GM5Q8W0jL9gVRBj6gkslRvMHoK3aZUzADfgGs
	 NzWMry0S/itYvADY1cYd1exEzwD84PS+b7C/R4VLOXteYmCX612uVG/SZlkaPKSKAGLmn
	 FgWm0H3jNEZdrx8TaEJqGrTgEBZRwVFuXDE+pgDA0x0t0H2it1X0s1lWywMuff11l0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232534;
	h=DMARC-Filter:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-Debian-User;
	bh=ieh4iGWZ+vr9hr8kiPlV7U48pBCHgYhYSusZXJeufN0=;
	b=q5v6K0Mf/uZZJg56Rs3/7hinRSn7rlkW2RyfF10xUR64uz3cNhCzGe1dJ3hzLzRf0qB/
	 5Yg1myT7GEAd4E1m9m//1CmNRNfkN90jyI7JNZAxSW4s7HiwiuEtVqwcw+P5JLMrOqODr
	 vAPW8tLMdI+9xUAEV8usixhmori/LGoMTS6aKaOWX5y6kRhIh+f4vzs7ccPy5dLgY80hl
	 Xo7AtDSgukDVfleKrt8obhbQh8dKsFgpQgNqhYeC6zbmnofVgeQ6dubWZg4qFBjqZtEci
	 UvEaaF6cGQ3l1E0Ft6BalTycID+Qxw06OYVqFBcXjuP5fcYbDUDRgHEQK2vhqgm0OiA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=debian.org;
	spf=pass smtp.mailfrom=debian.org;
	dkim=pass header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=QpRuQKrp;
	arc=none smtp.remote-ip=82.195.75.108
Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3F6606A333;
	Mon,  9 Nov 2026 13:55:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2E3F6606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.a=rsa-sha256 header.s=smtpauto.stravinsky header.b=QpRuQKrp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:Cc:To:In-Reply-To:References:
	Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description;
	bh=ieh4iGWZ+vr9hr8kiPlV7U48pBCHgYhYSusZXJeufN0=; b=QpRuQKrpHZ8FP9PnS6e6rhEdOF
	YGMggZND8Zl1F+r40UuWNWGOMdMCxvo5AfbS0OPrubqS412pjTI+eInIUox2nkoxLuFWGG76cxC9A
	wuBNjgxfr6vhH4GE/ptxN44G0eLry+H9OF64ZHIJQf2yps/KCy2RemQllMhGyWKaDAoDK49JddDCg
	6NOH00AXzNOwBkQ+zZnymzbFiYBUjpNbi1eTGWvH8NWBdRGbKOQXTZzlqjtP6FQWKc3IrYJH9g5Ti
	jg1NTpi/FxUqLjiF/IkTNDGGTSM7M91GYSxkNZm29s4wPaKFzBDgR/DsgmJujdKZWN8vcOqFNI5g9
	PJ/L1hpA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1xQPqO-00BfYy-0o;
	Mon, 09 Nov 2026 13:55:32 +0000
From: Breno Leitao <leitao@debian.org>
Date: Mon, 09 Nov 2026 05:50:38 -0800
Subject: [PATCH RESEND v2 2/2] nfc: llcp: convert to getsockopt_iter
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
Message-Id: <20261109-getsockopt_phase3-v2-2-d0f74c6e0f37@debian.org>
References: <20261109-getsockopt_phase3-v2-0-d0f74c6e0f37@debian.org>
In-Reply-To: <20261109-getsockopt_phase3-v2-0-d0f74c6e0f37@debian.org>
To: David Heidelberg <david@ixit.cz>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Eric Dumazet <edumazet@kernel.org>, Eric Dumazet <edumazet@kernel.org>
Cc: oe-linux-nfc@lists.linux.dev, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, sdf.kernel@gmail.com, 
 Breno Leitao <leitao@debian.org>, kernel-team@meta.com
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3489; i=leitao@debian.org;
 h=from:subject:message-id; bh=fGoMic1ySEx1yYGeWCFsHPVeAgro3j+eSMDyCmYAY+4=;
 b=owEBbQKS/ZANAwAIATWjk5/8eHdtAcsmYgBq8dDHri2mVQunLNX5zzIa1aL2l9vldPQ/C1tWx
 PKIqGOxl4iJAjMEAAEIAB0WIQSshTmm6PRnAspKQ5s1o5Of/Hh3bQUCavHQxwAKCRA1o5Of/Hh3
 bamTD/0cjIjkhwOjnw1D92pwMeDkbAwmRX/ehmyYas3bKYVHucCbPEBjq3izrzx4MY8j8FQ91ck
 oE1Q2TqsggsjHAZ3V65pCJ9Xz1Jk6opeRbFAkOesj5Htbakfl+Zm2v2t2ju9VF5tpMGbXrE3/yc
 EzF2Kn2LLAv1VUAA3s0+++1Vk8rtDL2+YSMp5DCL1c1BkWi8u0bzQo7ZPzrp3IzojwW19uYqiFT
 dqm9CyV7+egbBe9UusfsbCwGDrI5Qb6FoNZA2rOEnDZBp9QDBoGXAW14hlWMPlCukWwOFY3igU/
 bgj+ylotEB9VBEqMNqM+F5LDp8e1gDqzD1qvef705f1frP5hcuqjcTlaZmgyBq+1PuwmqAX1NAm
 FNlvg+BHP2VhzfPAzUWjYzwhT8UDOMlwu99IYQBVLHoeTnII5WQ6Ov6DW2/uhmDcvQ3PoMZgWcZ
 uG/orIyYdlcpoIZ0hLokrxZgD/xvzpcxFw002kuttK8/zg/bYSyE82DIO4bfzRGZxvAiiEGofi1
 aigeJlvlOkDG1giXRJK0eVsNrhPc56c+xfqll3JoOebbb+7KJDVpWEpekUWoaEelx5vT9uuOeKo
 OiWdFSxahqI4OCiCxa/3SomqxBbukBV7Qc8biVnP0xcitKS+XnJ5f6flA0n796fjKo6VfAmgCVo
 x4p68FwhX5FdsKg==
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
index adb6e06229b4af..8323a0e6a02ea3 100644
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
@@ -966,7 +966,7 @@ static const struct proto_ops llcp_sock_ops = {
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

