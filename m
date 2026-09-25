Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A93F94A3F27
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 13:52:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790344335; cv=none; b=Lzwjw1daWcFYsr9/vAzlsL29zu+n2J3Xa5KOiu9vAqDbROzNiQslRDlRa6WfW/lSBZId3KZdq7pVob1fpZRzpkKIJe+8pJEeJF6YvizqeguoEfkS5mQ4NZiuzM1cXA62kRIi6UaJijBZb1/d1USWmfISuDbXlCuqIelGQ6wGWgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790344335; c=relaxed/simple;
	bh=2shXhNJTm6G99RgzbnDIjGhBVdl6DIGZvgsBJL0OyUM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ToXKhhOQ28gm7AGJpGT8CzutyXSOXGPXHKMcYIMz7TclkGBl+fOuslEK4MbR+QPj4JnN/HLimJ/tDMNZac4g1oBDlmYw3nm2X5HQ3XEmb01EOHJNtDgwjcn8JJNGnyBvGSg6e7cCQp5QxYriTtRsMlMRDcqFHoWd9T8oO/vpEUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=BlSslCkO; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=etYD36Rx; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="BlSslCkO";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="etYD36Rx"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 31A4B140005A;
	Fri, 25 Sep 2026 09:52:10 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-07.internal (MEProxy); Fri, 25 Sep 2026 09:52:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to; s=fm2; t=1790344330; x=1790430730; bh=Oy6hPZKCCO
	6LYV2dt0HvarzsxLAD2KHXzFX/gPQHN04=; b=BlSslCkODPuj3PrYbleEg4jUEQ
	VCblBK2/MGsK03XxZ48M1lUQ+Spi8i82QELQHJ5SnzMICUN535hsRiuTPcObWPds
	V0a5GIG5tABybvQAUxHZi7a9ABAyxVYRlIkzXAp1/12Yao5/TlPN/mpqAdPyZC0/
	9OyeI7ASc8TWS2tPD5KmjLez5mgYmdEm3Av6yozYshbU85GTP4S7aAdulqFtDgcB
	OvBXKtCiz3Bth5OTeGjfSEcKpUVVZRGwotJkbrvizrHnoRjf89CCb4epgbM157A5
	MG5xkpwXPxVrCsaMRdhy7JW7RN1uZcG982Epxa/Kk4lpY8v1w2XEzMlH5IQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:message-id:mime-version:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790344330; x=1790430730; bh=Oy6hPZKCCO6LYV2dt0HvarzsxLAD2KHXzFX
	/gPQHN04=; b=etYD36RxQ1e8nVWR2awGAnUtFkLnALsfTK/Sze0UdW27a6rE2Mz
	mldS1Uf6LHbFL98lpN8ZLbF+CClFi8w9fam85qrc7OwuytW63uyFfUCsZamaRoti
	j8NJ/CF8ud6yg5UEY5oymiEx45kTkqnuGx4xueF0EeFV6w+cOkA954WozCC+QI7e
	mZcP6yBhPidWpLzUwiGPDVDNmbYNGw54Zh0K088FYgt+Y5y3boUrboh+iNR0trbb
	SL7hwLLGor82uw0PRSeuezauEIjcMWWLBH5YN2HPPj1GJnTzBUAucnVOIyvf/8je
	zyIBHJOhtEHZekoyrm83evJltOWEgb5KCeg==
X-ME-Sender: <xms:iXy2ajfBlwlGwzKQPlV9inJ21n1PjkMLEPw4d61Owehb0GP-jDSCFQ>
    <xme:iXy2agqmuu9yLbdY1PWH68ZP806etrjtebB9R7NAX-n62XtWTCjuJibgJ7Tg1sSqL
    DJ719iw-Ffo6IoRHJWr1CgsL3ZKPHH8uW4hER3l09nAIDNWAHzf6w>
X-ME-Received: <xmr:iXy2ap62W7X3qwWY2EmdGO0Dm6MRpzCgVmcyMry5NngJiT7I1DT6gGQvmRpC>
X-ME-Proxy-Cause: dmFkZTEitUvAlZU1Z/VeRX0hCgV6ygmi0nCxCoXIrp64j+FBh4ILYRCro5W3Sb4hbPQ/DM
    yyxhCushpJ9dJkvSN/aG69GFSJvXF4LO3c4Lt84g8nS/y2Qi9wlQrznDN9VJx+mcaQLPEr
    zWxNMq2nivvI+pWeFNKT9WsNXmbSofloRPJCs4zvOp7PkKqFqbvnT5viSgOHHVK3jyRxK1
    b8uWa9vijJ7NBF5R6D0eLRvBFgPjs7cX0zBuUJSvdYWXfyVuE6E4ZACsFXH4cT5hdTRG9I
    CYVS4l+ZIavK176wccDX1NFqcHKZc4IaJBEfaSStaF9JzwUb1n0mm+ptGxtgc5pCNtpVs9
    C6el+LJVTCVKMEhPlJbR26kKFAxpJ4NDhcW90//Ud19sgyCWLhMzQn5kcGry9aYIDiWRws
    obTlJfhHz4VrKssngc3IDulsh6mt3rywJLCUGaVqHkGAlTdGZZFwcfaprW5ba7J4Py4jsB
    wamICkq19HzEDoZbVvg3BI0I/Q8M9As5B9unthBRsigIx6tGXt+20V35RiP3ek2YHPgV05
    ndOxIcCKyF5tnL4FlC0YVDAS10bGscVPmdVRe6Ew7SCf9wdIkHDG2cAyGfTNe29B/2Ow26
    V9D/eBTlrKCQWIJPCLWP3bc3hJS6G65AIYLhJCO861TQjnLJgrAEIYwK4jBA
X-ME-Proxy: <xmx:iXy2auo4keQS4pRZeug8JDllcVAMEFb_rXXdHmqUwyrjz-anYYjZ7Q>
    <xmx:iXy2ajjzEJmJBH6MVz7UBEuwBpHN526MRJJmcI1PDB_YvFbHpPE_3g>
    <xmx:iXy2agJg7TihplcRVvnwOTGMaiwxhnBDsDt4XBQZfZRRkI8sBPLC0g>
    <xmx:iXy2arC2_ixYM_ZF69V8OYncQagwTjmXoUHba1Udt3XJqYupzZKpKw>
    <xmx:iny2asqAJnc9TqAl0ahd1Hb21EUHUWL3UVsVeK82eLu6ONw1rQyuuBpW>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 25 Sep 2026 09:52:09 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>,
	Hyunwoo Kim <imv4bel@gmail.com>
Subject: [PATCH net] strparser: make sure __strp_recv isn't running before tearing down the parser
Date: Fri, 25 Sep 2026 15:51:58 +0200
Message-ID: <4c80ea646f95abbd5beca2c081d129fe7d61a0aa.1790344112.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comment above strp_done() claims that if strp is stopped,
strp_recv will no longer be called. That's only true if the caller has
a mechanism (eg locking) to guarantee that strp_recv() calls that
started before strp_stop() have completed by the time we call
strp_done().

This adds a lock_sock/release_sock pair to guarantee that any
in-flight strp_recv() (which runs under either bh_lock_sock or
lock_sock, depending if it's called from ->sk_data_ready or strp_work)
has completed.

Only espintcp can be affected by this race condition, but this patch
makes sure no future user of strp can have the bug.

Reported-by: Hyunwoo Kim <imv4bel@gmail.com>
Link: https://lore.kernel.org/all/aZgpkyTDU3aXe_V0@v4bel/
Fixes: e27cca96cd68 ("xfrm: add espintcp (RFC 8229)")
Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
This could crash on strp->sk ("general mode" of strp), but this mode
has been here for 9 years and has never been used. I'll send a
net-next patch to get rid of it.

 net/strparser/strparser.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index a23f4b4dfc67..401e67533005 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -511,6 +511,10 @@ void strp_done(struct strparser *strp)
 {
 	WARN_ON(!strp->stopped);
 
+	lock_sock(strp->sk);
+	/* sync with pending strp_recv */
+	release_sock(strp->sk);
+
 	cancel_delayed_work_sync(&strp->msg_timer_work);
 	cancel_work_sync(&strp->work);
 
-- 
2.55.0

