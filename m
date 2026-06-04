Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F914CA269;
	Thu,  4 Jun 2026 17:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780595323; cv=none; b=RiWptPKQ6HYRVD2Gtc98ySCqg7/bOvFHGyFvwFEOQuyuV7QwHbgkRJ2Qc8AByKUG310fWdyvmuHWdziDiH0TQ5zJhpuKFPSoh5FdepbzprvW148UxG0UnQPwsQaBGAA2LOO/6PVOeL+Z4R0wPzWB5Arv7WNWX6v/o0k4R6sU1G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780595323; c=relaxed/simple;
	bh=wXAhdqw/SV8ZZocAdCUroCEpQxQ1uifAl7eehfCqoyY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ALsZxPfPb9pzV+NY+PhrqJnrRLSZAin/T7dbdhyiRA50dFNKmlmLu1pIJV/Y8nsPycYd1AmEbtdkdWT6Vo3Qj9YvADApkr0gkSVENI1wVfOitRf1P5/lECdFM9cCpz8HC7AKWm6XNwsRtRSvsQuPeTo4Bd+Pn+iVYDg3ipfk9/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=esu9AHsN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="esu9AHsN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 080CB1F0089C;
	Thu,  4 Jun 2026 17:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780595322;
	bh=Z4XE+cmE63csSg/8k7URSHVKH79trvvdwh9WCSOPI54=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=esu9AHsN+O1VHaFaEHNXRcrj/lHVY5PCsbS7GK9gy/tzZXSv9mOkI+OETn+wKdqrU
	 kQCdsMYry6cf8SmhWBXRgDFvlZYtTJCxZCnZti6z3korD4LfOs9R1ZnlTSdQ3jLlYT
	 kEyGv6ZJ6ZFad56MHFGi8cfpUStvfx+daW9cypZq2rxg0ZInCv68gZAsuvQYCX7do5
	 q3ZQPxKCU8Cy4Jq9C6w/y0Q9GpY+OQylq3kq1DTRqkgc7EssNEpOi+5+DcA1xGDP3f
	 C6pe+ycqPXFz8Rq+gW0I0+Qi04ZZb9zcaTeb7Ko7vG4VoMQxKy5/TeL1q7sOYlxwAM
	 6rCPcLH+w7dXA==
From: Chuck Lever <cel@kernel.org>
Date: Thu, 04 Jun 2026 13:48:27 -0400
Subject: [PATCH net-next v12 4/6] tls: Factor tls_strp_msg_consume() from
 tls_strp_msg_done()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260604-tls-read-sock-v12-4-b114efa6e3e2@oracle.com>
References: <20260604-tls-read-sock-v12-0-b114efa6e3e2@oracle.com>
In-Reply-To: <20260604-tls-read-sock-v12-0-b114efa6e3e2@oracle.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>, 
 Hannes Reinecke <hare@suse.de>, Alistair Francis <alistair.francis@wdc.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=2134;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=GKsYmrWcX7wrTdNnT9sOWBOGwUEovS6suOvycH27ydU=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqIbp3M8Y9KczpCPP7lCOOPeAiKdZFjRv6j0QXi
 zpIHYla7S+JAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCaiG6dwAKCRAzarMzb2Z/
 l2sMD/9NP4vOM4HL3EMJj1NsmUsrZbbdGxFY8ZAnmPX/LTrOJr23LjlvwQV7kp4V7egabIVmBg7
 +sF3LA4CeQk4xqbwHa4v4AOQJ8SLIdqDj1IyjIUoQKPQRWYSR5eRF5+CHnBNF3+P4YPSyNwzgxB
 tgzNzOKBgqO5XxDrbDwVCHI6RWT0ucuuCSJzhsKh0Exy74/HUqdgx1N5z1Ewe+UfhC1KYWg/PL3
 Dr25JrVjNHmuQUt+wHwHR4MlBoSUJHH9WzKErJcOvGKkcrJwBlblax4aw/jdv5lHppXRKzvHWs7
 4rugZva+RyNqcBjeOyb2hNki4ohO6wynXPL4KLm6ngpBe2IlESK+IzNXEbsjiaHl2yD33DJiN/K
 21oi6txEdyUntBYRHFBY0WR+NZrT7DdKYcRDYX0ca8/+PfkuU1C1/JYi50OoKw9X5zHgWlyxGAB
 RSRO+qzrR4KKdluay2p+vMnjSlnjY3y4IvU2km6NKs/Kbmx7Np8NxZVODxgU2nSyS0d8ofszQZZ
 s0yv0BcQhehhkpQtQSS/w+m4+zeWikbguB5X7mAPVECtXjXM2vsDUhBiS9eLmVW045MA1Avcbg1
 x0+VSinE9EMY20E3weD7fk8U3m7XW9UjQZlVFLLRxjFNc7ysfc4PnkWbYr/Yywp/XIwUXbnUBz6
 CWZynvId/f9VYTQ==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97

From: Chuck Lever <chuck.lever@oracle.com>

tls_strp_msg_done() conflates releasing the current record with
checking for the next one via tls_strp_check_rcv(). A subsequent
patch needs to release a record without immediately triggering
that check, so the release step is separated into
tls_strp_msg_consume(). tls_strp_msg_done() is preserved as a
wrapper for existing callers.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
Reviewed-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/tls/tls.h      |  1 +
 net/tls/tls_strp.c | 11 ++++++++++-
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/tls/tls.h b/net/tls/tls.h
index 12f44cb649c9..cb0091e03f41 100644
--- a/net/tls/tls.h
+++ b/net/tls/tls.h
@@ -194,6 +194,7 @@ int tls_strp_init(struct tls_strparser *strp, struct sock *sk);
 void tls_strp_data_ready(struct tls_strparser *strp);
 
 void tls_strp_check_rcv(struct tls_strparser *strp);
+void tls_strp_msg_consume(struct tls_strparser *strp);
 void tls_strp_msg_done(struct tls_strparser *strp);
 
 int tls_rx_msg_size(struct tls_strparser *strp, struct sk_buff *skb);
diff --git a/net/tls/tls_strp.c b/net/tls/tls_strp.c
index c72e88317627..e7aaee6efe6e 100644
--- a/net/tls/tls_strp.c
+++ b/net/tls/tls_strp.c
@@ -581,7 +581,12 @@ static void tls_strp_work(struct work_struct *w)
 	release_sock(strp->sk);
 }
 
-void tls_strp_msg_done(struct tls_strparser *strp)
+/* Release the current record without triggering a check for the
+ * next record. Callers must invoke tls_strp_check_rcv() before
+ * releasing the socket lock, or queued data will stall until the
+ * next tls_strp_data_ready() event.
+ */
+void tls_strp_msg_consume(struct tls_strparser *strp)
 {
 	WARN_ON(!strp->stm.full_len);
 
@@ -592,7 +597,11 @@ void tls_strp_msg_done(struct tls_strparser *strp)
 
 	WRITE_ONCE(strp->msg_ready, 0);
 	memset(&strp->stm, 0, sizeof(strp->stm));
+}
 
+void tls_strp_msg_done(struct tls_strparser *strp)
+{
+	tls_strp_msg_consume(strp);
 	tls_strp_check_rcv(strp);
 }
 

-- 
2.54.0

