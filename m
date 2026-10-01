Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EA94848AE
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 07:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841476; cv=none; b=EHZO1eOQOwYLzka1sbN+bb1s/MPzscERfeEPE+8h4TVhh+Pg+8sJ4Xa6fyUrLgb95Qv/+R+k1s8XkalXdDa4tVtMGZfuNJ61x3pM64eL0DwbEYQ4R5IrcnEQPnWKZmjwtlG6IExUt/nuFmv6ZRE0byO2ZH1iedUuZj58e9s8oU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841476; c=relaxed/simple;
	bh=AidR3vbbltUZ3DJc9GSWhF/azxg+J9fGK6Nhgxww9Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NJ+fsr8ZoKcrVbVO/dJYzSp6yvy6nWq9UDb9kQQL60fZzXV9d+N2DQzi7gtnbC33CAzSw+z6g5VRe5GLUfUx++KLp772XbdVwW4Jb/gUa0tcQNofPuTjYoEINMgtCTsayD3UEgxPARx/FO1Sfy2tYQCfuHv2ZbuOQP0MQe/O6Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=STS3eZPu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CvUPhgw5; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="STS3eZPu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CvUPhgw5"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 8BBD47A0010;
	Thu,  1 Oct 2026 03:57:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Thu, 01 Oct 2026 03:57:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1790841474; x=
	1790927874; bh=FnJRS+v3s6eAoJRK/LASHiIgUP+rBsrquVk8ULucyBk=; b=S
	TS3eZPueeFk99d9NDmO8SshBI6/b915h965SRiH+ypYk+THiifa9zGVAmHUhKAS1
	8GZRi1dHgpEuVn5EjjD3nB3hhjD9stKbEU6goY8b5zfxVtnVzAzFAJIyx+8iTGNw
	2HSSSlVMUc4RUywMMpNlayJbypG5LjkdWtbRjN7s4mceQnkamnSrAM1wRtgRHwZn
	NPsJiMRQ3FGl2BSBRcU7mw9E6Nspw6ZwDLwRfXiKdVQ5uK56Ow3qArsdKDHdVWk1
	IZDEi0HH4KsFUizyoQZCTRin9dCGbVhhy56uaMBaiwUThgpINiIzboCgwRrb5xPd
	MLG0FcqpTU/M00GCJ0c/A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790841474; x=1790927874; bh=F
	nJRS+v3s6eAoJRK/LASHiIgUP+rBsrquVk8ULucyBk=; b=CvUPhgw5XhtqhUIJl
	VpDjBCWa52o8Jp0FaoAZolWmPmO2ijcUwbD+BRlKk7Ag1lP7lF9w2vLDy7J6QnKk
	Qbv+SEim2GId2S1WklTl3cEmvNCXgDwljCAM3ZsrVAoUK4oEHBrd2MFFjh+woaMX
	tOfleUHqYxH+iqY02QcTfCxwkNfF1RL9J2ne0Q/MpXk58qVDVaRfPbRChVNfZgBW
	H3K6hlGby/KyB3gwc+hpb1aHXV9rWfrNTOpSBtnbmL4P7sBi06bFqRNJ3/WoDeI9
	dFh4o3/8zREoNLjc8ZWW4LOvANUTlOKN8sqCVJKCe42xOmb57uPT6DyHwdFxoh7V
	R6Tdg==
X-ME-Sender: <xms:ghK-akvxXubNKaeuqsn9ZVbof16dsxSAlip3wRlE3jlhU61G25YGvw>
    <xme:ghK-ane-7bZMEb2sxkxhPWvDUbzeh91nSKKE2ra4bmgG1pV-HQEa9eik2x4d0yNt9
    BWNcfg7RB39RwXwrKhso_jov22TToDg1FflVfocunox0cKeVL9U3oU>
X-ME-Received: <xmr:ghK-atb4VXglvnOJEZqGFoU96la0HN4bBS1wwtbg2xWgMH_9UtpR6gxUh2ZR>
X-ME-Proxy-Cause: dmFkZTGrlCWeHT+g+Zlf20e7uU3eZJyAipOOtczwBxzD7N3VyNOdxX/HBzbROOe5wu2/jR
    Vw8dtcU/d3uOEsrzk+lFNWUrPvjFDLSiNivpRofFj2lF/LCgnEyhBSAP8cmPmNhT7V9t/q
    uW/FhjwihsfkbcruXtDMaTObPhDJ49E9a187VcUVbXYYUyXOTpdxWKJr2aUcUIJ0JWsezP
    y8EyxskdQyV2BcdK/O3U/kT2U7IItGK22qtPNXdsi9NIK0Cw+Z4I6Pd50W9VRJSgiB0mmZ
    pnaL9JDhMXJ8gB8BhAaKhbV6vHiB2rGYhxSHLtOQw0X/dtY/TfpDYSqEUWJGc3FPV19zQP
    JEbmKXWLNstKDsoVEsxk7Dat7owsfKuNoNfPfJLhPtP1m/pxMbWltnXDuPPeoPEbGwjM98
    htp9t4yTX7L+9GKR0GABe4qAj56mO37mAPufh3Bq6YIe8YVi+2evSSQ0OjZZoGOYHKwsro
    Z5aiHSg1XvtCbf3G1e6KUZome5fLTM7eGLG9z/UOgRVWAIuWEF4bb2ySmKE0iaAhjGDIbB
    yCj8LOvs/flcZjmZQUwrzeBTMvkgiWZG5Q2yvqqG7DwTuFYouV3nu/keUDOtlHPUzmXV+T
    DFWbNC7J0G7n6kka7O95VNw4qeBYoq3RY9/zGJAcjLd0ZbvXLhMWFAw1RQ0A
X-ME-Proxy: <xmx:ghK-aiWATZvMAoBddbkVwN-6aPDeVqBuwIJ_s2JUX5Vyzc--U8Jd0A>
    <xmx:ghK-anhLA-OlcR3TDk0KFdbm1vPrK21sAognYNgj0PgibgfXn_CywQ>
    <xmx:ghK-aoXdbN50GQy4CFEtmsnERQqosRHmvWNTEQD9YBpE63AXz4EDQw>
    <xmx:ghK-amOCkOvT66e5pDTjl5uFS7XlXxO9zg1Kz2FniRGfk748yUiarA>
    <xmx:ghK-agGBdbf3KGkive1_XjffIbZ2-u-wTcxhpdwAI7m0R0gQ9IKHkgvk>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 03:57:53 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 2/5] net: strparser: remove strp->sk NULL checks
Date: Thu,  1 Oct 2026 09:57:26 +0200
Message-ID: <a823a8decf85b3586e50adf8c6d768f59538140a.1790702233.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790702233.git.sd@queasysnail.net>
References: <cover.1790702233.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strp_init makes sure strp->sk != NULL.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 net/strparser/strparser.c | 24 +++++++-----------------
 1 file changed, 7 insertions(+), 17 deletions(-)

diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index b5319ed56857..6cdbd12f41e0 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -36,6 +36,8 @@ static inline struct _strp_msg *_strp_msg(struct sk_buff *skb)
 /* Lower lock held */
 static void strp_abort_strp(struct strparser *strp, int err)
 {
+	struct sock *sk = strp->sk;
+
 	/* Unrecoverable error in receive */
 
 	cancel_delayed_work(&strp->msg_timer_work);
@@ -53,13 +55,9 @@ static void strp_abort_strp(struct strparser *strp, int err)
 	strp->skb_nextp = NULL;
 	strp->need_bytes = 0;
 
-	if (strp->sk) {
-		struct sock *sk = strp->sk;
-
-		/* Report an error on the lower socket */
-		sk->sk_err = -err;
-		sk_error_report(sk);
-	}
+	/* Report an error on the lower socket */
+	sk->sk_err = -err;
+	sk_error_report(sk);
 }
 
 static void strp_start_timer(struct strparser *strp, long timeo)
@@ -80,17 +78,9 @@ static void strp_parser_err(struct strparser *strp, int err,
 
 static inline int strp_peek_len(struct strparser *strp)
 {
-	if (strp->sk) {
-		struct socket *sock = strp->sk->sk_socket;
-
-		return sock->ops->peek_len(sock);
-	}
-
-	/* If we don't have an associated socket there's nothing to peek.
-	 * Return int max to avoid stopping the strparser.
-	 */
+	struct socket *sock = strp->sk->sk_socket;
 
-	return INT_MAX;
+	return sock->ops->peek_len(sock);
 }
 
 /* Lower socket lock held */
-- 
2.55.0

