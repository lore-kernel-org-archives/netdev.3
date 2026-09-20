Received: from va-2-30.ptr.blmpb.com (va-2-30.ptr.blmpb.com [209.127.231.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC84C3D45C3
	for <netdev@vger.kernel.org>; Sun, 20 Sep 2026 06:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789885169; cv=none; b=pkbbCetMebq97KGBgQHdEdJNHX1uxAatOPykFw13/mp9WKS+fC6WdzCeuh6tYkNi2yxTmjRkbyrhdgz8KoNuc12wICmHJxlARinltkSR6935RiVwMQeKZDV/PsrOOKUEu9brx9FAO30f/mbOS0fa0ktVvEtQam7oS/Cox3Kq41I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789885169; c=relaxed/simple;
	bh=rnMQbbdgbu32h+ljMvAI3F6b2WvLzvm7YjN6hioE+Yg=;
	h=To:Date:References:From:Subject:Message-Id:Mime-Version:
	 In-Reply-To:Cc:Content-Type; b=pbigACzb3bvlbQ1KGZvLQUJPE8M+Uw2PP4xn9lxLXGqoD/aHDqd9m2kG71YXwMufAwJbI2d7cg1zgN0D5cko6bRGITDpQS2GZ75sdN5WgpMXXcBYw/LCAsJw4wbWisqzuaFpX7FOVQRhpXyodx+sAMKkL1GmaDlejDMF1F3jt7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai; spf=pass smtp.mailfrom=moonshot.ai; dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b=XS1u3Rkl; arc=none smtp.client-ip=209.127.231.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b="XS1u3Rkl"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2510091218; d=moonshot.ai; t=1789885154; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=DtcePfBq/Wgxt45Maj0MMOd4M1kW8iYGmPEyk4W6x5I=;
 b=XS1u3Rkl8A4j0FM3usAKrEN+IkCt10hTy1to+wqPIU4oWiV9pTD8T07jKcaH44RrqnVapT
 IZAdHj2eAYAHXU0jCIbllec7c2Mru9uMVFJHHfBIN1Z6Q410nl+54laygY3FvVoHUb5tSs
 1j4GCHeqRs40LBXxonyuCPONa/ckZhErTTzTP41FyGLfXxjSmWtluZS+hw9GFz6qnWtk3W
 3H9An4R4uA0ZO7Gai4PbaBJxokYjbWnzWV7iNWwZPpw1TNqVmDmq8M8XTp4YC/fiOdFZbE
 H/oWTy+lX+t0bkOzXyh9MtbbIJ6WTnzFaWoW08kdCi262m3/8z84VJs8Ict2ow==
To: "Mat Martineau" <martineau@kernel.org>, 
	"Matthieu Baerts" <matttbe@kernel.org>, 
	"Jiayuan Chen" <jiayuan.chen@linux.dev>, 
	"Paolo Abeni" <pabeni@redhat.com>
Date: Sun, 20 Sep 2026 14:19:04 +0800
X-Lms-Return-Path: <lba+26aaf7ae1+259431+vger.kernel.org+yilinzhang@moonshot.ai>
References: <20260903094010.4066892-1-yilinzhang@moonshot.ai>
From: "Yilin Zhang" <yilinzhang@moonshot.ai>
Subject: [PATCH v3] mptcp: do not use Fast Open on MP_JOIN subflows
Content-Transfer-Encoding: 7bit
X-Mailer: git-send-email 2.34.1
Message-Id: <20260920061904.3575780-1-yilinzhang@moonshot.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
In-Reply-To: <20260903094010.4066892-1-yilinzhang@moonshot.ai>
X-Original-From: Yilin Zhang <yilinzhang@moonshot.ai>
Cc: "Yilin Zhang" <yilinzhang@moonshot.ai>, <netdev@vger.kernel.org>, 
	<mptcp@lists.linux.dev>, "Kimi Security Team" <bug-report@moonshot.ai>
Received: from dev.msh-dev.svc.cluster.local ([117.157.206.135]) by smtp.feishu.cn with ESMTPS; Sun, 20 Sep 2026 14:19:11 +0800
Content-Type: text/plain; charset=UTF-8

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
