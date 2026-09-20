Received: from va-2-35.ptr.blmpb.com (va-2-35.ptr.blmpb.com [209.127.231.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5555B3515D3
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 06:19:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789885176; cv=none; b=K6Fhn4uD5CT+uTihbg64KeEqi8ELsb3lklRy0oTfbmlq1gY6T59ZeMo9t/auDD0U0eaGcNEXFN/oqq6o2FwBdj+Famwz/JF7ptEI52ZtYjjQC+G/OsJRgkiwFShHIaT5Ucy2QUyJJPlWZNlgncRlcp9G88YY8gkazXQqlCjZwks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789885176; c=relaxed/simple;
	bh=rnMQbbdgbu32h+ljMvAI3F6b2WvLzvm7YjN6hioE+Yg=;
	h=To:Cc:Content-Type:Subject:Message-Id:In-Reply-To:Date:
	 Mime-Version:From:References; b=LZ+ErIaRMWLi2e3t994tVmvSb929WBZQUR5pwNtaQHVwKPx84ZV+wp58AEAA7USFE5CsaJnA+bJg+LUzJ6dN4oLlYXbMYqciZgwmstVQq5+A+cum++MtK6bZc0Zsd1/Q/1gzWG3+MhH9AlXEmR/s17Z+3DbXbIdyQPZhH8kXyf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai; spf=pass smtp.mailfrom=moonshot.ai; dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b=BQNGZOt/; arc=none smtp.client-ip=209.127.231.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b="BQNGZOt/"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2510091218; d=moonshot.ai; t=1789885163; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=DtcePfBq/Wgxt45Maj0MMOd4M1kW8iYGmPEyk4W6x5I=;
 b=BQNGZOt/aS3dPRSUoUnSZjuk8DbRbAfR9rQJMuB3h9DzBs11llUzV9a3ndQqXai287mHEv
 b/987BhcJXwgng278PEYWW5gNFJ6csa77tCWUCsjvhYeZT6EZUjbjX++ec/V2HVMEP3Dc0
 UNXgOBpXCaI9ZkxDzweTt03Na955Z4lhJJZdx7553RkILRvGbG8tjhzajL738unDpkRLxa
 YMgEcdX3G8P5xW79vljejgtaC2Q5ywyWinpfmaY56q2X5m3dhyF4M5X1XQiikA1Sqf2etD
 DIMKq20kYegSU+YC3FxPpxXZebba1X+J+VZaTjzK3/JRGp4q14F+HsfHPw0oag==
To: "Mat Martineau" <martineau@kernel.org>, 
	"Matthieu Baerts" <matttbe@kernel.org>, 
	"Jiayuan Chen" <jiayuan.chen@linux.dev>, 
	"Paolo Abeni" <pabeni@redhat.com>
Cc: "Yilin Zhang" <yilinzhang@moonshot.ai>, <netdev@vger.kernel.org>, 
	<mptcp@lists.linux.dev>, "Kimi Security Team" <bug-report@moonshot.ai>
Content-Type: text/plain; charset=UTF-8
Received: from dev.msh-dev.svc.cluster.local ([117.157.206.135]) by smtp.feishu.cn with ESMTPS; Sun, 20 Sep 2026 14:19:20 +0800
Subject: [PATCH v3] mptcp: do not use Fast Open on MP_JOIN subflows
Message-Id: <20260920061755.3575063-1-yilinzhang@moonshot.ai>
In-Reply-To: <20260903094010.4066892-1-yilinzhang@moonshot.ai>
X-Lms-Return-Path: <lba+26aaf7ae9+979157+vger.kernel.org+yilinzhang@moonshot.ai>
Date: Sun, 20 Sep 2026 14:17:55 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Original-From: Yilin Zhang <yilinzhang@moonshot.ai>
From: "Yilin Zhang" <yilinzhang@moonshot.ai>
X-Mailer: git-send-email 2.34.1
References: <20260903094010.4066892-1-yilinzhang@moonshot.ai>

tcp_fastopen_create_child() hands the SYN packet itself to
subflow_syn_recv_sock(). For an MP_JOIN request this takes the
fatal fallback: the cloned child is destroyed and handed back with
drop_req flagged, but tcp_fastopen_create_child() does not check
the flag and queues it, so accept() can expose the freed child.

MP_JOIN cannot use Fast Open: data on a subflow requires the
completed HMAC exchange (RFC 8684, sec. 3.2). Refuse it (only the
TFO path passes a SYN skb here) and let tcp_conn_request() fall
back to the regular MP_JOIN handshake; also strip the Fast Open
cookie from MP_JOIN SYN/ACKs.

Fixes: 90bf45134d55 ("mptcp: add new sock flag to deal with join subflows")
Reported-by: Kimi Security Team <bug-report@moonshot.ai>
Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Suggested-by: Paolo Abeni <pabeni@redhat.com>
Suggested-by: Matthieu Baerts <matttbe@kernel.org>
Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
---
v3:
- refuse TFO for MP_JOIN in subflow_syn_recv_sock() and fall back to
  the regular handshake; the TCP-side hunks from v2 are dropped
- strip the TFO cookie from MP_JOIN SYN/ACKs
v2:
- https://lore.kernel.org/netdev/20260903094010.4066892-1-yilinzhang@moonshot.ai/
v1:
- https://lore.kernel.org/netdev/20260902121247.3248539-1-yilinzhang@moonshot.ai/

 net/mptcp/subflow.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index af81ad5..2b454d4 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -348,6 +348,10 @@ static void subflow_prep_synack(const struct sock *sk, struct request_sock *req,
 	if (foc && foc->len > -1)
 		ireq->tstamp_ok = 0;
 
+	/* MP_JOIN cannot use TFO, do not send a cookie in the SYN/ACK */
+	if (foc && mptcp_subflow_rsk(req)->mp_join)
+		foc->len = -1;
+
 	if (synack_type == TCP_SYNACK_FASTOPEN)
 		mptcp_fastopen_subflow_synack_set_params(subflow, req);
 }
@@ -832,6 +836,12 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 	if (fallback)
 		goto create_child;
 
+	/* a SYN skb here comes from TFO, which MP_JOIN cannot use: just
+	 * fall back to the regular path.
+	 */
+	if (subflow_req->mp_join && (TCP_SKB_CB(skb)->tcp_flags & TCPHDR_SYN))
+		return NULL;
+
 	/* if the sk is MP_CAPABLE, we try to fetch the client key */
 	if (subflow_req->mp_capable) {
 		/* we can receive and accept an in-window, out-of-order pkt,
-- 
2.34.1
