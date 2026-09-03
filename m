Received: from va-2-28.ptr.blmpb.com (va-2-28.ptr.blmpb.com [209.127.231.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE824052DC
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 09:40:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788428440; cv=none; b=uJA8jv1tNx2lkn1biqwMW8dWXE6wbWn23mPqSWZV67wp76eNNvvmEfdPcNUnue7TuwLX+SnrrYSyIZCB7ryaOOpNzTWjH8siSc364GsTETHiub8VJJx7e4706YG0HJQOH15PxjBz6WMq6+MGnWh1FU2DzmWzeLFnTjWp6PsUWCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788428440; c=relaxed/simple;
	bh=GrCDUN0qRdj9HHV6N1Eevl3QYXECGcs4nqA8GSP2BeU=;
	h=Subject:Message-Id:From:Mime-Version:Cc:Date:Content-Type:To; b=Yyr7LZI/ViPc8msWdAQefUsf8gRhw54PjTrFXsYMSoRZMo4SHn2zm1JMKy6iqial6trgtgNeW2GETssEN6Buj6n4I7A3rxP/ej7sDR7nBnhcKx3aKyqH4+3wgG+EvFpiaJe8ATocKIFkaBDsMtMAKoHhsgGmQ6jM6J+bg74wddI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai; spf=pass smtp.mailfrom=moonshot.ai; dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b=iGUlE7vM; arc=none smtp.client-ip=209.127.231.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b="iGUlE7vM"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2510091218; d=moonshot.ai; t=1788428427; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=mIr6xKWADAcPBR6bmqJhJGXvjssZ2Xl3MgIb0zIP3cY=;
 b=iGUlE7vM8qQ/Ik50O/i/K8qC/4zuDB1vIQ5tqg4IhvEFPBbD5OyJHAGukbDZjbC3oX8Pcy
 hA+9PV0ldTeqOqWP51MyyNMFYnDd58WbK6A35RXtBvmkpojpUB0heIk99D2HzR5e4VD4oY
 LVUr52RtszRMRVIoqq5CGf4Lf4NjZW7z8DJqJeM6usrecE9JxoTGSmWnjmQFk5mucjdmQV
 Iv/Ma7W12G7ktg9iv+kiQ1KX+yxRjYyNJUee5yahJaMU5+7goh4LjBAb8bDiradN18GW5e
 Y4eqd4t9Z2HTUmLr+dtrkTo2EiE54g6mlyUkcw9euXxkFDmo6SILRUxSuLG19Q==
Subject: [PATCH v2] tcp: fastopen: check rsk_drop_req() in tcp_fastopen_create_child()
Message-Id: <20260903094010.4066892-1-yilinzhang@moonshot.ai>
X-Lms-Return-Path: <lba+26a99408a+9357c7+vger.kernel.org+yilinzhang@moonshot.ai>
From: "Yilin Zhang" <yilinzhang@moonshot.ai>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Received: from dev.msh-dev.svc.cluster.local ([117.157.206.135]) by smtp.feishu.cn with ESMTPS; Thu, 03 Sep 2026 17:40:25 +0800
X-Original-From: Yilin Zhang <yilinzhang@moonshot.ai>
Cc: "Yilin Zhang" <yilinzhang@moonshot.ai>, <netdev@vger.kernel.org>, 
	<mptcp@lists.linux.dev>, "Kimi Security Team" <bug-report@moonshot.ai>
Date: Thu,  3 Sep 2026 17:40:10 +0800
Content-Type: text/plain; charset=UTF-8
To: "Mat Martineau" <martineau@kernel.org>, 
	"Matthieu Baerts" <matttbe@kernel.org>, 
	"Jiayuan Chen" <jiayuan.chen@linux.dev>
Content-Transfer-Encoding: 7bit

subflow_syn_recv_sock() sets drop_req when an MP_JOIN SYN takes the fatal
fallback and destroys the cloned child. tcp_fastopen_create_child()
ignored the flag and could queue the destroyed child.

With an MPTCP listener using server-side Fast Open, a valid-cookie
MP_JOIN SYN could then expose the freed child through accept().

Release the locked child and drop the request before tcp_conn_request()
sends a SYN-ACK. Initialize drop_req when allocating the request so the
check cannot observe stale state after request-socket reuse.

Changes in v2:
- unlock the child before dropping its reference
- drop the request instead of sending a SYN-ACK after the MPTCP reset,
  as suggested by Jiayuan Chen

Fixes: 90bf45134d55 ("mptcp: add new sock flag to deal with join subflows")
Reported-by: Kimi Security Team <bug-report@moonshot.ai>
Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
---
 net/ipv4/tcp_fastopen.c | 6 ++++++
 net/ipv4/tcp_input.c    | 5 +++++
 2 files changed, 11 insertions(+)

diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 471c78be5513..22494ff746c7 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -337,6 +337,12 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 	if (!child)
 		return NULL;
 
+	if (own_req && rsk_drop_req(req)) {
+		bh_unlock_sock(child);
+		sock_put(child);
+		return NULL;
+	}
+
 	spin_lock(&queue->fastopenq.lock);
 	queue->fastopenq.qlen++;
 	spin_unlock(&queue->fastopenq.lock);
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 0f60a1dbf927..eb0e4259c280 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7669,8 +7669,9 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	tcp_rsk(req)->txhash = net_tx_rndhash();
 #if IS_ENABLED(CONFIG_MPTCP)
 	tcp_rsk(req)->is_mptcp = 0;
+	tcp_rsk(req)->drop_req = false;
 #endif
 
 	tcp_clear_options(&tmp_opt);
 	tmp_opt.mss_clamp = af_ops->mss_clamp;
 	tmp_opt.user_mss  = READ_ONCE(tp->rx_opt.user_mss);
@@ -7775,6 +7776,10 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 		READ_ONCE(sk->sk_data_ready)(sk);
 		bh_unlock_sock(fastopen_sk);
 		sock_put(fastopen_sk);
+	} else if (rsk_drop_req(req)) {
+		reqsk_free(req);
+		dst_release(dst);
+		return 0;
 	} else {
 		tcp_rsk(req)->tfo_listener = false;
 		if (!want_cookie &&
-- 
2.43.0
