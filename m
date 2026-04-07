Received: from mout-y-111.mailbox.org (mout-y-111.mailbox.org [91.198.250.236])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A432342CB4;
	Tue,  7 Apr 2026 17:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.198.250.236
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583079; cv=none; b=MpG46yYAip11Gx9WlZufF4SmPNOKFcABYp9lkdYMyQFx3dQUIB4qDaRcOdByeh/4Lo/+nAiGN7lK5nReLXy72yFk1z37YRSyE4wjB69Oj/AIztCPwNp4bAIpwBzRLmlTZGOSDtHeNefCnhZFF38rzOMNBDxFke98kUcqVOnpyP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583079; c=relaxed/simple;
	bh=tlECP4uTLaQqF5M9Il3Phq0WryFOhdvy7fqtkbVffuI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFif9iFd3dvYUFbGqcLZvCf5H6w4ffQLowI0iWlhHVZDz+H06ovTlx34jpHVmsfmavkLtuNNuJnFENXY1Rd/tXAHMk0hIhClw1cBUVAYWuWXzrnuQGpeOQBaDIspz7mzXtfB083agSQyVxQXXC35foiJd8ZBfsfTHM8BJwN3Qng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Qt5VoshN; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=pg/wNs+C; arc=none smtp.client-ip=91.198.250.236
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Qt5VoshN";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pg/wNs+C"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-y-111.mailbox.org (Postfix) with ESMTPS id 4fqtXM3bP8z9ySW;
	Tue,  7 Apr 2026 19:31:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775583075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIg2qhrKVQQuHdMcVdIxvMpdtcCA2y5ngwd5rH7xFHE=;
	b=Qt5VoshNB9EznJ7DNd9isUBAQR+2o9cswtWIELjvRqwyuUTULsxsoBv1AF4MT/EgC1APuB
	Um0NsaZyjLthSVGnHPs0a9nE2Ke4n53eWuwJk0MQ+/nHP7XDQJNzcSdfnm7rOJB0n3WTnb
	W/SJSzwtLvgW4C73L8PlzQVSs3iTkpEngCaPPZ763YPICm/4XhRWaNHl9biB/AtEbGovJf
	bcXq7jfSCAxe1xTKM1UYXvdVo7CEa3TdcgBjDfspoYeo6wz1vbd6EQhXHc24ghZLl967Y2
	uedXzOhml7EWHd64fVuC4CNKLONbUjZwO75Qb1bBdRAGvlIAhc9C8DcXHdTaxg==
From: Mashiro Chen <mashiro.chen@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1775583073;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iIg2qhrKVQQuHdMcVdIxvMpdtcCA2y5ngwd5rH7xFHE=;
	b=pg/wNs+CAjbAtJTlPpFP258sYpX5AosAsh38/Hy7+YvcDXQS2vOs1HQMipmBFBDPjCnJEJ
	ofjg2j7JOFVZMGsWidBUnwcMxmVRWiGubEGUpCQbLxFcuBEEN6Zdbb7C8M/+VioizVHSIE
	OS2EupEx8W0x4hhsPAAbq4JGf5CkyyTTdndBb+Pu6g12zA99fmu/Mybfern+NSR6XCqrx4
	fDAdAk8mfrvuB83agH+0pes4vWXCEHIyDu2PInCmT04XvekSxZBWuB0IaK38mJLtQLA/8K
	lv1ciRgXMldgt2nZ8UMlItvwxGl+rdsBs4DozdurSBD7BcuNG3LdDMCXdWh51w==
To: netdev@vger.kernel.org
Cc: horms@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-hams@vger.kernel.org,
	stable@vger.kernel.org,
	Mashiro Chen <mashiro.chen@mailbox.org>,
	syzbot+ecdb8c9878a81eb21e54@syzkaller.appspotmail.com
Subject: [PATCH v2] net: hamradio: 6pack: fix uninit-value in sixpack_receive_buf
Date: Wed,  8 Apr 2026 01:31:01 +0800
Message-ID: <20260407173101.107352-1-mashiro.chen@mailbox.org>
In-Reply-To: <20260407165007.GB469338@kernel.org>
References: <20260407165007.GB469338@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-META: rmpiu6ikw5xibeb9ef3raowfg7e9ej14
X-MBO-RS-ID: 803d5a9751816110560

sixpack_receive_buf() does not properly skip bytes with TTY error flags.
The while loop iterates through the flags buffer but never advances the
data pointer (cp), and passes the original count (including error bytes)
to sixpack_decode(). This causes sixpack_decode() to process bytes that
should have been skipped due to TTY errors.  The TTY layer does not
guarantee that cp[i] holds a meaningful value when fp[i] is set, so
passing those positions to sixpack_decode() results in KMSAN reporting
an uninit-value read.

Fix this by processing bytes one at a time, advancing cp on each
iteration, and only passing valid (non-error) bytes to sixpack_decode().
This matches the pattern used by slip_receive_buf() and
mkiss_receive_buf() for the same purpose.

Reported-by: syzbot+ecdb8c9878a81eb21e54@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=ecdb8c9878a81eb21e54
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Mashiro Chen <mashiro.chen@mailbox.org>
---
 drivers/net/hamradio/6pack.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
index 885992951e8a6..c8b2dc5c1becc 100644
--- a/drivers/net/hamradio/6pack.c
+++ b/drivers/net/hamradio/6pack.c
@@ -391,7 +391,6 @@ static void sixpack_receive_buf(struct tty_struct *tty, const u8 *cp,
 				const u8 *fp, size_t count)
 {
 	struct sixpack *sp;
-	size_t count1;
 
 	if (!count)
 		return;
@@ -401,16 +400,16 @@ static void sixpack_receive_buf(struct tty_struct *tty, const u8 *cp,
 		return;
 
 	/* Read the characters out of the buffer */
-	count1 = count;
-	while (count) {
-		count--;
+	while (count--) {
 		if (fp && *fp++) {
 			if (!test_and_set_bit(SIXPF_ERROR, &sp->flags))
 				sp->dev->stats.rx_errors++;
+			cp++;
 			continue;
 		}
+		sixpack_decode(sp, cp, 1);
+		cp++;
 	}
-	sixpack_decode(sp, cp, count1);
 
 	tty_unthrottle(tty);
 }
-- 
2.53.0

