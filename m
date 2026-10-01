Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ECD945D93F
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 07:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841476; cv=none; b=iBkxJTwGN7Gx2UnsCmsyujQ67z/z8Jleyi2mi6R8sEXmxbKoEXCMNuPUtttp7p0QsDIK8BkNzv7Eyx0mY5a9sHpbv8gHLyTYp1PZfbe+rMTXWMcosxBpbKY9htN5TRVl28OZ7TZDNqrtPIc8bYA+/20lbcgSnRijjoRwySB/qDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841476; c=relaxed/simple;
	bh=YqDRQ5W5rsAkOJ774wYqgQ2gbuHwMHmfMksSt7FNIGg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YmFjaHOgs2YEThEFmW42AtQ4yQw2WjXwunFpkGxuzsVHofGXbvAvepIp8Lwe6GLNmutVTvnr010rK5g2U57ircdTKH4l+/RcBkAWNJ82++288vKC9B7ZtCMKtso83MIn+Fyoem/9K59p2RdqBp188Ov3tD3XICRKXz47uTKHWho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=Fzi6XwnE; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k9Sm/WXU; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="Fzi6XwnE";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k9Sm/WXU"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 417C07A00BD;
	Thu,  1 Oct 2026 03:57:52 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-07.internal (MEProxy); Thu, 01 Oct 2026 03:57:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1790841472; x=
	1790927872; bh=jbsUQ4GPFwaWqu71DtOJVHflPrFccJb9tsUynoAzNb4=; b=F
	zi6XwnEgZXmVwR40O+PDQpduAu7PNZn2AA0WdWYk1D/33BTD5gE68F5gQ8uRTaoj
	zpQtk4rp81uyS1xgLx4fZkeLtoCpg/fvm15FkXm5EmGUmDyAr987blHEOOc52R64
	ObqUrMlSVPtfwy/TI5aPFl2golEbFjYfk3vhvI1/OGvW7MfoM2ZNHx/NjVtv9kWu
	yWZhd6MI17L6UadBagL6MpiBt6TxXF+uWIo4xQcO2/HFDhgMO61prfsjlYCoC8/E
	EfYmdUV0nHtxTvBGs08D2ArFNGQ4On3lU+Gx2sku5YKrUI4cyVKjQQI0hsU3HLkB
	medShuqEOemJ2LHINKivg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790841472; x=1790927872; bh=j
	bsUQ4GPFwaWqu71DtOJVHflPrFccJb9tsUynoAzNb4=; b=k9Sm/WXUwEtyxktDJ
	asNs7QazsopDqbzbFuczPlXKjssCQBAFxcCBYupjBG2iKWO/98ovI0drfKnUCIXo
	Q5lM+uxIr8rwB45MRhBaGLMEWxj/j2Wc4EtXLzb/FQXLzeChpHC4rSTFvQzHn6Yu
	CbuSJafuoRu8HeiephrYIb3Nb2z/rS+JUSU+N7HklIajvV8dZJwPhDO4FnhqN61n
	kzQ+maROHTBUf4Y6ZCvei+AumCpG8uUNI6ktBG4zDvb4+By00HPtSrEMsi4mR/MC
	6jXQdLoEElcWrda1wBHu2oS3RN85Z2F8QLIblHDnhHH9DsXGJl5f3yh/Fi5OfZgv
	6NIwg==
X-ME-Sender: <xms:fxK-atlF3yddMtHkNfyolb2ogoU7I4j1K7ZjDcdSoWMGbGm1r62KcQ>
    <xme:fxK-au1Scf1HaA49zly5WOcddYAoUDAg4qIQTQZCowe67ikVW0Fs2jY68KNWVNmBd
    SvMrZLACVKfWR8XdVJ2cWi-XJshxnJWZGQkJvoEnq-WWqO6ARfnUjCo>
X-ME-Received: <xmr:fxK-ahQzhuY-U0fr-uspLsBoObxIOio_yv_t4VIb4DaluePVedgJIJbyNY_c>
X-ME-Proxy-Cause: dmFkZTGrlCWeHT+g+Zlf20e7uU3eZJyAipOOtczwBxzD7N3VyNOdxX/HBzbROOe5wu2/jR
    Vw8dtcU/d3uOEsrzk+lFNWUrPvjFDLSiNivpRofFj2lF/LCgnEyhBSAP8cmPmNhT7V9t/q
    uW/FhjwihsfkbcruXtDMaTObPhDJ49E9a187VcUVbXYYUyXOTpdxWKJr2aUcUIJ0JWsezP
    y8EyxskdQyV2BcdK/O3U/kT2U7IItGK22qtPNXdsi9NIK0Cw+Z4I6Pd50W9VRJSgiB0mmZ
    pnaL9JDhMXJ8gB8BhAaKhbV6vHiB2rGYhxSHLtOQw0X/dtY/TfpDYSqEUWJGc3FPV19zDj
    1gR6+Blt0KypIHqwhcBZ7n0aan8iE0HX1AHBVGFbmYwNzUT8q7QSUkdLErZdh7+JqBDG7/
    bwNK+OuBGPgBjXm5Ylm/sEQlK/bIkT+Vj8pU3cwnl9ey9cr+q6c6mEC8phOrqbgCl09Gmz
    4ywY6Klkv/ZiASs4siZB3JOhsWpKXQqRc6C28UUw3zkogop7+lXfm2+uM/e8laa8o7fipe
    9QGUlISkMuznjSGOAd9qTLetvLaOU1yTLr4qpkth+mo1h4iqGuWiSI+NIZK+UThfHvitrN
    dX9+nb75Ym+EK165fYQMNBWVgQFf/FT6HDJMHK7Uu3khxDZV4rFJGmgnqIhw
X-ME-Proxy: <xmx:fxK-aosAUk-HLfT_7yv0XaCIz2BoNMG8mHHvOxxrPqt7rcmmZMmX6g>
    <xmx:fxK-auaaUWZwSt6lPEup5OG4z6Qsw7lbnSOqxT5Gg-Fjm5qFZKsC5A>
    <xmx:fxK-aluDib-bfu-PBIETWi7h-owdn92P_lfmAG5nZ--UjcJYn3rwAw>
    <xmx:fxK-aoFiCfcUyUH0B8PJPCAG_ATFqNjR-Sbjo8BLY9le7NzHwjTX9w>
    <xmx:gBK-ao80MROEmk0dp6Fjbi1x_l_IUk1uWHs4IgTwj4GLJnVlHN4b4Ww_>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 03:57:51 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 1/5] net: strparser: remove unused abort_parser/lock/unlock callbacks
Date: Thu,  1 Oct 2026 09:57:25 +0200
Message-ID: <e55bcc033317dddd47a6dfda6575c755ae7175f7.1790702233.git.sd@queasysnail.net>
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

The lock/unlock callbacks were introduced in
2017 (bbb03029a899 ("strparser: Generalize strparser")) and haven't
been used. The abort_parser callback has existed since strp was
committed (2016) and has also never been used.

This patch replaces those indirections with the only possible direct
call.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 include/net/strparser.h   |  3 ---
 net/strparser/strparser.c | 39 +++++----------------------------------
 2 files changed, 5 insertions(+), 37 deletions(-)

diff --git a/include/net/strparser.h b/include/net/strparser.h
index 0ed73e364faa..78e8e3e12ed3 100644
--- a/include/net/strparser.h
+++ b/include/net/strparser.h
@@ -46,9 +46,6 @@ struct strp_callbacks {
 	int (*read_sock)(struct strparser *strp, read_descriptor_t *desc,
 			 sk_read_actor_t recv_actor);
 	int (*read_sock_done)(struct strparser *strp, int err);
-	void (*abort_parser)(struct strparser *strp, int err);
-	void (*lock)(struct strparser *strp);
-	void (*unlock)(struct strparser *strp);
 };
 
 struct strp_msg {
diff --git a/net/strparser/strparser.c b/net/strparser/strparser.c
index a23f4b4dfc67..b5319ed56857 100644
--- a/net/strparser/strparser.c
+++ b/net/strparser/strparser.c
@@ -75,7 +75,7 @@ static void strp_parser_err(struct strparser *strp, int err,
 	desc->error = err;
 	kfree_skb(strp->skb_head);
 	strp->skb_head = NULL;
-	strp->cb.abort_parser(strp, err);
+	strp_abort_strp(strp, err);
 }
 
 static inline int strp_peek_len(struct strparser *strp)
@@ -409,7 +409,7 @@ static void do_strp_work(struct strparser *strp)
 	/* We need the read lock to synchronize with strp_data_ready. We
 	 * need the socket lock for calling strp_read_sock.
 	 */
-	strp->cb.lock(strp);
+	lock_sock(strp->sk);
 
 	if (unlikely(strp->stopped))
 		goto out;
@@ -421,7 +421,7 @@ static void do_strp_work(struct strparser *strp)
 		queue_work(strp_wq, &strp->work);
 
 out:
-	strp->cb.unlock(strp);
+	release_sock(strp->sk);
 }
 
 static void strp_work(struct work_struct *w)
@@ -436,18 +436,8 @@ static void strp_msg_timeout(struct work_struct *w)
 
 	/* Message assembly timed out */
 	STRP_STATS_INCR(strp->stats.msg_timeouts);
-	strp->cb.lock(strp);
-	strp->cb.abort_parser(strp, -ETIMEDOUT);
-	strp->cb.unlock(strp);
-}
-
-static void strp_sock_lock(struct strparser *strp)
-{
 	lock_sock(strp->sk);
-}
-
-static void strp_sock_unlock(struct strparser *strp)
-{
+	strp_abort_strp(strp, -ETIMEDOUT);
 	release_sock(strp->sk);
 }
 
@@ -455,36 +445,17 @@ int strp_init(struct strparser *strp, struct sock *sk,
 	      const struct strp_callbacks *cb)
 {
 
-	if (!cb || !cb->rcv_msg || !cb->parse_msg)
+	if (!cb || !cb->rcv_msg || !cb->parse_msg || !sk)
 		return -EINVAL;
 
-	/* The sk (sock) arg determines the mode of the stream parser.
-	 *
-	 * If the sock is set then the strparser is in receive callback mode.
-	 * The upper layer calls strp_data_ready to kick receive processing
-	 * and strparser calls the read_sock function on the socket to
-	 * get packets.
-	 *
-	 * If the sock is not set then the strparser is in general mode.
-	 * The upper layer calls strp_process for each skb to be parsed.
-	 */
-
-	if (!sk) {
-		if (!cb->lock || !cb->unlock)
-			return -EINVAL;
-	}
-
 	memset(strp, 0, sizeof(*strp));
 
 	strp->sk = sk;
 
-	strp->cb.lock = cb->lock ? : strp_sock_lock;
-	strp->cb.unlock = cb->unlock ? : strp_sock_unlock;
 	strp->cb.rcv_msg = cb->rcv_msg;
 	strp->cb.parse_msg = cb->parse_msg;
 	strp->cb.read_sock = cb->read_sock;
 	strp->cb.read_sock_done = cb->read_sock_done ? : default_read_sock_done;
-	strp->cb.abort_parser = cb->abort_parser ? : strp_abort_strp;
 
 	INIT_DELAYED_WORK(&strp->msg_timer_work, strp_msg_timeout);
 	INIT_WORK(&strp->work, strp_work);
-- 
2.55.0

