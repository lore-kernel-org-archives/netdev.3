Received: from va-2-41.ptr.blmpb.com (va-2-41.ptr.blmpb.com [209.127.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF99472556
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 12:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788351197; cv=none; b=ghOV/QnfXkjde97rvbPzef15h5veB8FxmuzaEJ6ci2oYjp+wNQ4w4qMpl35EqsFfuwonde0GYnJCTQuY4H+xtO+2Le73rqbo/okdQNtZpFQPCC+lj7S8R/R/aDIkbM1/n5RV7xLDaZYyxJaHZyNOt7SRcWJTBZGYvFN0YpIcBqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788351197; c=relaxed/simple;
	bh=8yKUv3hhur45T4gGYj+9dz7Dm39B6FzLNZm7RIKRb94=;
	h=Cc:Subject:Message-Id:Content-Type:Mime-Version:To:From:Date; b=qhHxUfApzN3Ts7Kp+eXKGIRS0k8XmzBAyI+zxyoexWSnu9tPmSY+FSiGf/ERcBqv8qtu9av8DH+HclHxZmPcsh8N/M6R4b5UxXPl5fAifsxf4Xru5y8NKNioryLOwam00zzfeGs450ApdV2tn/t/n+bsiT/w3yGSpp5v9OdKb7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai; spf=pass smtp.mailfrom=moonshot.ai; dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b=eWTvAwnK; arc=none smtp.client-ip=209.127.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=moonshot.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=moonshot.ai header.i=@moonshot.ai header.b="eWTvAwnK"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2510091218; d=moonshot.ai; t=1788351182; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=aGUX08HyL9LrDEc8iXEXywO/u6MBE8iqaiS6DjYw1tU=;
 b=eWTvAwnKjep11+AZNN9FrYHowHC61ZNUFmQ06Qyy0RQjSVsS1sPe8VIqSBXBH5T6HReBN1
 dxwd+d/IbEp1IBwHlBtgms++CRPFvvQ0TjT0Er30reNvwYvyQ/OfngazFdZkTXyaUmy9bn
 IJnU6MNgtRPaibO/IvoTMcGcVmF+N+xaE5qxKgb2erVGk8hJRFREkDzodMWOUcNLuV6PDU
 WnRkfUMoJK2TRxIOi0nXAeHt0c7pOY3HcAY7OxWk62bElKHoGvgbmtej8o9TkAL84Hgwg9
 CKjmZK46ZH60s877SyGu31axIstSBYIdNh0vdIwhNjOTkaOYrz6I9m57S0Kl5g==
Cc: "Yilin Zhang" <yilinzhang@moonshot.ai>, <netdev@vger.kernel.org>, 
	<mptcp@lists.linux.dev>, "Kimi Security Team" <bug-report@moonshot.ai>
X-Mailer: git-send-email 2.34.1
Subject: [PATCH] tcp: fastopen: check rsk_drop_req() in tcp_fastopen_create_child()
Message-Id: <20260902121247.3248539-1-yilinzhang@moonshot.ai>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=UTF-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Lms-Return-Path: <lba+26a9812cc+7da524+vger.kernel.org+yilinzhang@moonshot.ai>
Received: from dev.msh-dev.svc.cluster.local ([117.157.206.135]) by smtp.feishu.cn with ESMTPS; Wed, 02 Sep 2026 20:12:59 +0800
To: "Mat Martineau" <martineau@kernel.org>, 
	"Matthieu Baerts" <matttbe@kernel.org>
From: "Yilin Zhang" <yilinzhang@moonshot.ai>
Date: Wed,  2 Sep 2026 20:12:47 +0800
X-Original-From: Yilin Zhang <yilinzhang@moonshot.ai>

subflow_syn_recv_sock() destroys the freshly cloned child for an MP_JOIN
SYN under the fatal fallback and hands it back with drop_req=true to
tell the caller to drop both the request and the child. Of the three
syn_recv_sock() callers, tcp_check_req() and the cookie path honor that
contract; tcp_fastopen_create_child() only checks child != NULL.

With an MPTCP listener and server-side Fast Open enabled, this can
become a use-after-free:

  1. fetch a TFO cookie,
  2. complete a normal MP_CAPABLE handshake to learn the server's key
     and compute the token offline,
  3. send an MP_JOIN SYN carrying that token and the valid TFO cookie,
  4. a subsequent accept() hands the freed socket to userspace, and
     any fd operation triggers slab-use-after-free, leading to a
     denial of service.

Fixes: 90bf45134d55 ("mptcp: add new sock flag to deal with join subflows")
Reported-by: Kimi Security Team <bug-report@moonshot.ai>
Signed-off-by: Yilin Zhang <yilinzhang@moonshot.ai>
---
 net/ipv4/tcp_fastopen.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 6a031a1a6c9f..7a0b58b39a2c 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -337,6 +337,11 @@ static struct sock *tcp_fastopen_create_child(struct sock *sk,
 	if (!child)
 		return NULL;
 
+	if (own_req && rsk_drop_req(req)) {
+		sock_put(child);
+		return NULL;
+	}
+
 	spin_lock(&queue->fastopenq.lock);
 	queue->fastopenq.qlen++;
 	spin_unlock(&queue->fastopenq.lock);
-- 
2.43.0
