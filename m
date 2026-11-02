Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=62.96.220.36
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793606695;
	b=UIRdXgSPvdvFaeAg/TR7djnNfKshResM2P9Z6HRAfnR0P3jji8uzPbI+xQ9SaXZpYdAT
	 3bjtSgbebmetPWzm7y5l4sQCihzp/I/UROfFGuCQyXyKOQ/5Rn/1y9eeClOR1CX3Fmgtv
	 RfAXBLgcT5ouL2921S1wGaeDn7eTaZEGtFovX9VSSNsn0mMdSHJ5+eZRHfxDGDaS9Pb2h
	 0sa2H3Pu5SM/hSHKEse57YceLNajyNc4mwu7D9M0+OXIHZjPsiDtQP87qEZPG/kjLLjWX
	 ++z1pOY3d8gg/KUmZyU6y++L4Rzhy4IwCoPpFGeGpQpEz64SQu9KWpyizuLseqiG9Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793606695;
	h=DMARC-Filter:Received:X-Virus-Scanned:Received:Received:DKIM-Filter:
	 DKIM-Signature:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ClientProxiedBy;
	bh=RN0KtHePRWJJDIJqcoSp9L1s2pTtBDmwuk/8VGE9Y7A=;
	b=gl4qPR0ejsSp+Piois5rHmUgBNSYJPHIoZVpDBgK19wIVgyCainbKptRtZ7Bh/lTpOeb
	 em1e8uz4CBgNjAL0Pf6fEk0aARCyFDuTVKh1UGX0ENf8FpTpXSSHdf+rexRST9pJ5Fr4A
	 SK8wDkC9vkAGAwwPdt9RBJjfygTEaf1/pt5K74Uvcmk7uLCKo1blWRL/aQHCInUWNSBgR
	 XZvMTnktP9fi9ijLlGIHKd9yo/w4u8LJQO62REPLpDF8q5g0UPK1GoWZOhE2WZAEYXsK4
	 oGyA4zAQilBjbgHsMC2TghYNnmQowDd4wPqjkIBkfYFmO7xvPPP0KfWuW4LUQCqUXGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=secunet.com;
	spf=pass smtp.mailfrom=secunet.com;
	dkim=pass header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=PiVMWyyB;
	arc=none smtp.remote-ip=62.96.220.36
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CD1460A380F
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 08:04:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8CD1460A380F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=secunet.com header.i=@secunet.com header.a=rsa-sha256 header.s=202301 header.b=PiVMWyyB
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 266F7207C6;
	Mon,  2 Nov 2026 09:04:53 +0100 (CET)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NFDoqxW9Bk8D; Mon,  2 Nov 2026 09:04:52 +0100 (CET)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 681DC207B0;
	Mon,  2 Nov 2026 09:04:52 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 681DC207B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1793606692;
	bh=RN0KtHePRWJJDIJqcoSp9L1s2pTtBDmwuk/8VGE9Y7A=;
	h=From:To:CC:Subject:Date:In-Reply-To:References:From;
	b=PiVMWyyBzDpsUWjIyzt+yrPldt5Ikp7lLLN9oK64DuQ9Yf4JOF1lna7scFL4avZ9Q
	 6CKk6PiQsb/NXU3F946IdikIuvF9VXITrku/yr8h2bZNmpHQhujsPClT7VTlNgKKJn
	 ls67nmz53TMM5hcY48u9Joaf/mDpLtvyj9EDpiPS0e+tdXVDFnFktwSGSwMmFSMQOB
	 gt9AwBSHv+yRkI6Kwn+WdTXelWOW/NUxPO2VhCKS133On/HIbuAFvKJb3VvoCqlCTF
	 NlebRb0ebL4qex2CBEogTDKvSnUZi36vulxhtupiXr0huOIYXBCA0DqfS37aZhiGrY
	 6xQcU+H64Whuw==
Received: from gauss4 (10.182.7.102) by EXCH-01.secunet.de (10.32.0.171) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 2 Nov
 2026 09:04:52 +0100
Received: (nullmailer pid 2505897 invoked by uid 1000);
	Mon, 02 Nov 2026 10:04:58 -0000
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 03/14] xfrm: zero-initialise km_event in the replay-notify path
Date: Mon, 2 Nov 2026 10:04:01 +0000
Message-ID: <20261102100451.2505200-4-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261102100451.2505200-1-steffen.klassert@secunet.com>
References: <20261102100451.2505200-1-steffen.klassert@secunet.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)

From: Shubham Antil <shubham@octane.security>

xfrm_replay_notify(), xfrm_replay_notify_bmp() and
xfrm_replay_notify_esn() declare a struct km_event on the stack and
initialise only its .event and .data.aevent fields, leaving .seq and
.portid uninitialised. build_aevent() then builds the XFRM_MSG_NEWAE
message with those fields:

  nlmsg_put(skb, c->portid, c->seq, ...)

so the netlink header of a replay event carries uninitialised stack
values rather than defined ones. This was confirmed at runtime rather
than by inspection alone: the .seq and .portid carried in that header
hold values that nothing in the replay path assigns.

The request-driven paths set these header fields from the requester
(xfrm_get_ae() / xfrm_new_ae()); only the kernel-originated replay path
leaves them unset. Zero-initialise the event so the header fields are 0,
the correct value for a kernel-originated notification.

Fixes: f8cd54884e67 ("[IPSEC]: Sync series - core changes")
Reported-by: Giovanni Vignone <gio@octane.security>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Shubham Antil <shubham@octane.security>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 net/xfrm/xfrm_replay.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_replay.c b/net/xfrm/xfrm_replay.c
index dbdf8a39dffe..9394953247ab 100644
--- a/net/xfrm/xfrm_replay.c
+++ b/net/xfrm/xfrm_replay.c
@@ -40,7 +40,7 @@ static void xfrm_replay_notify_esn(struct xfrm_state *x, int event);
 
 void xfrm_replay_notify(struct xfrm_state *x, int event)
 {
-	struct km_event c;
+	struct km_event c = {};
 	/* we send notify messages in case
 	 *  1. we updated on of the sequence numbers, and the seqno difference
 	 *     is at least x->replay_maxdiff, in this case we also update the
@@ -304,7 +304,7 @@ static void xfrm_replay_advance_bmp(struct xfrm_state *x, __be32 net_seq)
 
 static void xfrm_replay_notify_bmp(struct xfrm_state *x, int event)
 {
-	struct km_event c;
+	struct km_event c = {};
 	struct xfrm_replay_state_esn *replay_esn = x->replay_esn;
 	struct xfrm_replay_state_esn *preplay_esn = x->preplay_esn;
 
@@ -356,7 +356,7 @@ static void xfrm_replay_notify_bmp(struct xfrm_state *x, int event)
 static void xfrm_replay_notify_esn(struct xfrm_state *x, int event)
 {
 	u32 seq_diff, oseq_diff;
-	struct km_event c;
+	struct km_event c = {};
 	struct xfrm_replay_state_esn *replay_esn = x->replay_esn;
 	struct xfrm_replay_state_esn *preplay_esn = x->preplay_esn;
 
-- 
2.53.0

