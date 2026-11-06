Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.225
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793993540;
	b=zvsggzHsHoNKbLaxp0twfmM7a1+U331UIz4VYp/L1yeZ71IselsrXUaI5okCAY3vavpN
	 BQQvh/YEVmXsm1czv1eV27u11W2xnJoXWCdNp5k6bB5VntoASaTh+tPGUu+NfkFSaf7HK
	 B9bnAqWKX6kWOpw9QE/VqbQ09y429aRDHO8IoY2WPtYasem/g9n7JSiXzLy+PXpI5+HLt
	 dPYQ3QIOnFWWJi+yfSLtxEiw74hiNk98RbNc5bR5cWW1vY9IYTACn43wkHz0jBHpVAW5T
	 m1y0qKqOCLz72BraFmCXKS3KaTQ8CoTcozKHL+oXgcrJ3Du1vTwl0nhmXgIIXzunwYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793993540;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:X-Relaying-Domain:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=a0RDp/rl6Vk8Phw3anBonrB3Rzcis4iuB7hT2hI6hOI=;
	b=hKlfipy7tY5fk2VLQTTRoC18VIehtBPBQmpUUfDo4kvczOsIHYlhiZUw9yeJt/IQuerM
	 peDg6ifOBxo4vsbfrOPA25hjld7XlYHzD3cG/qfttOuOSQeV4Hk8Bk7NzHDmb1cr/jq30
	 +sJU5zI22Nm/Yk23gyyoujAENlH6Z6G3w6CtYAwyIvWpqLKv/3jAMtoUQYfBTASNs/UyC
	 oTRkLfn1k55EttimSlG4tsiswEIj10mM0FaFAHk4Q/ysD+hpYieQVpB4PSIwfAkbh2r49
	 ze6n53O7XlKtSKwC7iiqhAjFmaEhuL+h2TdJ9WOI8SqmCJxFjQjzZI/Qab6rJGeoi5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=purestorage.com;
	spf=pass smtp.mailfrom=purestorage.com;
	dkim=pass header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b="cyyCMpl/";
	arc=none smtp.remote-ip=209.85.210.225
Received: from mail-pf1-f225.google.com (mail-pf1-f225.google.com [209.85.210.225])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD750606A32F
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 19:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DD750606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=purestorage.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=purestorage.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=cyyCMpl/
Received: by mail-pf1-f225.google.com with SMTP id d2e1a72fcca58-89f85edd210so393397b3a.2
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 11:32:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1793993538; x=1794598338; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=a0RDp/rl6Vk8Phw3anBonrB3Rzcis4iuB7hT2hI6hOI=;
        b=cyyCMpl/K9YhiSpcklec+E4m9mCwAI22y4dX48lD15x7/Kc1vND/f/x9+hse5q45Iy
         TkcUyPL7i0VGtAh6GKeB077uQOeFu6DbNqt5mwCgJQyBMtIf0dTFE2GAQU6XUl/3aWB3
         cOslvwCLBHEBhRcNM1wVW6hKsBGp0vJZdJ1Kjjm4KF+EJdg1CQTO7jm7bkjsEftfMmuF
         8iymrMYxA8qS8W83hH5SZz1IFHvBskDGMg0SygnpAWa753RcFK++LaKUhhkweZgekpgN
         cLUaoxICxWhoe+krQIn8A8VDTepnm9iLgMSATnwTL0b+3VB1TtyFzSXRvUZ1kEC/AmyS
         G58A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793993538; x=1794598338;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=a0RDp/rl6Vk8Phw3anBonrB3Rzcis4iuB7hT2hI6hOI=;
        b=yg2UXaY4o1XDzvNDn7ugFkA1S2caUb0Dbh3mo7jvXeX6CCEEY/VGKPRWBZiSkntEnL
         qAfXJVhUV2n/J8XVrGrFBmbi7ZfITRVkenMbjWnKj7YNNNfZ9NP0UUcWU/7E8m0/sxhj
         3J9S1O/T+eeUlyaPCa3fAAtBcOdD3Xqb9EK2NHcX/1lCQEor9MDMkzya8X3bsiS1GSaE
         KY2dqeYNC4g9PuUlFwsLkWPMOAev284x5d/rHfRm1rb0dOPKoBVCzzhI7S8YFETsR2GN
         I8GPTjCKS7GW43FMZVgr2ZvLHt1u2S7v/WuZ49n0551oXHPJ+TGmQApoE/xTVF0x+fo3
         Ektw==
X-Gm-Message-State: APuU4Z9g2d3Yo51P0chdPLOCor9vX3GAkxYfGN/TP2W1l41Vmg3jdKqK
	ACYlrAQE22qO3fEhz44jKaHYpEBkVyWEYeyzPfcwwHRTyM+y7cFgWSL1IG8jfOzv7/f0iG91a36
	flE5wGWIs3uxBItvl60vJrVemaPieTlCTmmkv
X-Gm-Gg: AYBFou1E8E3T5YQCyHA9BWG3gB2HKI5ORYHED2oD3ql0ERvsP1Q9rARehoOQsaK5E4t
	SOlQTasxOIUmjj/wou5CiIs5PhObz5xjNPqtIGpTygf+h4+Cuy8OCNslzVCGD8elMPl2Axuivrv
	Tn78tqEvFoWj7wEFSa5D9OLOgeaV+Fdildj7XZ1uBikryAWDDR7J7vKUOQVpo0SFbpeGJKitSsp
	qzh73oF4dO8zvqLj92C+a9vIBZu0vqXSSCCmAlZ79gxUL6auWn5sj3TKN9QIalRNR1sThE04quw
	qYfUKOB+fHjo/2Vm6RkU8WVgVVj39/4BKHt2aP67P/SFVFoqrM3mDGQULSaSk6RrJP2ukDoUyw0
	JsFEwtcrKMENdezKllzPn3Xx34CClwvoR65Y=
X-Received: by 2002:a05:6a00:ac3:b0:874:705d:f659 with SMTP id d2e1a72fcca58-8b37bc5f406mr3255945b3a.39.1793993538079;
        Fri, 06 Nov 2026 11:32:18 -0800 (PST)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.129])
        by smtp-relay.gmail.com with ESMTPS id d2e1a72fcca58-8b357bc29c4sm36071b3a.12.2026.11.06.11.32.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 11:32:18 -0800 (PST)
X-Relaying-Domain: purestorage.com
Received: from dev-rjethwani.dev.purestorage.com (dev-rjethwani.dev.purestorage.com [10.17.2.234])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 6171E40152;
	Fri,  6 Nov 2026 12:32:17 -0700 (MST)
Received: by dev-rjethwani.dev.purestorage.com (Postfix, from userid 1557719937)
	id 5CB4CDCE11C; Fri,  6 Nov 2026 12:32:17 -0700 (MST)
From: Rishikesh Jethwani <rjethwani@purestorage.com>
To: netdev@vger.kernel.org
Cc: Rishikesh Jethwani <rjethwani@purestorage.com>,
	syzbot+cca46a9d1276f38af2ae@syzkaller.appspotmail.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vakul Garg <vakul.garg@nxp.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] tls: read sk_err once in tls_encrypt_done()
Date: Fri,  6 Nov 2026 12:32:08 -0700
Message-ID: <20261106193210.1152577-1-rjethwani@purestorage.com>
X-Mailer: git-send-email 2.50.1
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

tls_encrypt_done() runs from the crypto completion, without the socket
lock, and reads sk->sk_err twice. getsockopt(SO_ERROR) and sock_error()
clear sk_err locklessly, so it can go from non-zero to zero between the
two reads. A successful completion (err == 0) then takes the "no error
set on the socket" branch and calls tls_err_abort(sk, 0), which hits
WARN_ON_ONCE(err >= 0) and clears sk_err.

Read sk_err once and use that value for both checks.

Fixes: a42055e8d2c3 ("net/tls: Add support for async encryption of records for performance")
Reported-by: syzbot+cca46a9d1276f38af2ae@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=cca46a9d1276f38af2ae
Suggested-by: Sabrina Dubroca <sd@queasysnail.net>
Signed-off-by: Rishikesh Jethwani <rjethwani@purestorage.com>
---
 net/tls/tls_sw.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index 771e02bff519..b4535139438a 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -473,6 +473,7 @@ static void tls_encrypt_done(void *data, int err)
 	struct scatterlist *sge;
 	struct sk_msg *msg_en;
 	struct sock *sk;
+	int sk_err;
 
 	if (err == -EINPROGRESS) /* see the comment in tls_decrypt_done() */
 		return;
@@ -489,12 +490,13 @@ static void tls_encrypt_done(void *data, int err)
 	sge->length += prot->prepend_size;
 
 	/* Check if error is previously set on socket */
-	if (err || sk->sk_err) {
+	sk_err = READ_ONCE(sk->sk_err);
+	if (err || sk_err) {
 		rec = NULL;
 
 		/* If err is already set on socket, return the same code */
-		if (sk->sk_err) {
-			ctx->async_wait.err = -sk->sk_err;
+		if (sk_err) {
+			ctx->async_wait.err = -sk_err;
 		} else {
 			ctx->async_wait.err = err;
 			tls_err_abort(sk, err);
-- 
2.50.1

