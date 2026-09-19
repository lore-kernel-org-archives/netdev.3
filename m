Received: from mail-pj2-f31.google.com (mail-pj2-f31.google.com [74.125.227.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6316D37E5DB
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853800; cv=none; b=drmMykLs1N7ZjnWWVm2fWjPY09Wfyc4SLWtQ/kz7BAC82W3FBpKsHwzwVgbe352yzNSsx8EQmPC2mBVJOKGNuUJzo0hrW25hgIul6USP1Uz9BBeO6QbZjLGfrOQyO9Jsb4/cHAqR1s0OVVN1SYRTwjNnRmP4lj2G9lKqaRFv6oA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853800; c=relaxed/simple;
	bh=lfoMmck27h8rxcEq//cYQsmDPpfPgRsuhqt5p1flyWY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ixoVzSUEUVV8LJGYuoRKcq5oYf6/G+mb8DISAxomaQqLZRwisOixlhdAiJhx3kV7TfdCAC+BRPHsqJ6qjS4ryxXVdMnbL1Z4I2Ver5ldc6sNj1qph/6FxHH2Oiug0MqYmAinsjr5lrNQx+5vHtJOUojRRxB3nlfftayL0GllyUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j+TcEW8k; arc=none smtp.client-ip=74.125.227.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j+TcEW8k"
Received: by mail-pj2-f31.google.com with SMTP id d9443c01a7336-2dd53691be5so16987535ad.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789853795; x=1790458595; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=lBz1wgM4ChVQkuNTsUB6r2UpX/KNTDzOql2jPvCkbsk=;
        b=j+TcEW8keaWFeHwCCe0d9DnBLIUebs0lT33AnkTz+R1w+nrHjYbfrA4KCgz2lKU26h
         9sGcGgs5iAvKs9q0Mvf1tuvsvPzXzkxP822zBvm55WRX9S5eOBiemUScy/MYLz2PVGnK
         cKSHb4dC7CK1ESKSyRf1jhM86TW6QqGXrtRWWWLMioUFJF8gg2SxuA+DBzN/IRLLE6wV
         hPYf+jj2ZESf8xNFAnxkDn7sBqde0Zd1SLb9OAyNYqd0eI2PVgrPW3vhrA877u44rGJF
         tyL3TjiljBmNTBh61PCSZe6SRqXBiVOdfqsCXckYD1/tTTneKqyNsh0E0ujrF6bMFn4C
         JHcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789853795; x=1790458595;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lBz1wgM4ChVQkuNTsUB6r2UpX/KNTDzOql2jPvCkbsk=;
        b=M4wkIKkwb8KZt3Wqqr/6wSUI9UMwNp7jV7s8E2CNxdyVM6b7J4D+DR3lh7vGlrswxn
         9hB7RxB5KPGZwHQ5E9oaayJN5Bpp7/7zHyoDVSfkMBzZ/OBNYoMnoXeKwU2fJcdG2cRR
         Dr9rzxGxycHmrbzJtt1JnKUxDOLpMUiukQ+VVAIkg2SzpWay+sM+DlTgw/sZxltj8F7b
         vJUqHBnchVzoyeJ9l1SNAiooBmNz8gI3qaI0tLbwUyAzahcdnaHLwnR5P7ilj8faVsLy
         UOaVf/3282hLwo3aR/6DDwyOGVXvQP4+ocqpAz8BM7yVDN3wd7CO8OjwKKTqtlpu2Y9H
         ifmw==
X-Forwarded-Encrypted: i=1; AKwUvBwx0V/kJVrYebtTMXv6ADvyYSncDL7ZW2hfl66Io/dpePFuie+NIISim8AWP6TLwqUH8WXKkHI=@vger.kernel.org
X-Gm-Message-State: AFuF++mmGbD6sEe77JxgTCBJDMUKUY4ihjyhN9ENSl33vOfslf6EmBsL
	rQ6sxfRn9M/LjmQclvyLWktHEHBWXAW5VXZwnFtIckvT825480XhVqvB
X-Gm-Gg: AYBFou1wgalEH/CU3m5l7rzUvH2tgv/J/pur01iPz1ZoPZMzj14bSJKBOad0Z1aRvCT
	HZ9s+EwrWIrjgFQ2VLXP/+kg3Y4etPPgY11UihA4YKe0XBbJQT2lf43lEdykXMJnqXm4sIUIXiZ
	wJSib86g1i31OBgv+4zWBwdw35zgOsOHJgg1M8/1dD3AfZz2AsBeXtJ/Hz0NpdvTFByDK6nnU5p
	l7BW+JhxhzGz+ENDfcqfrPAgGwKLIEjTmaHEXHhUDWkYQOVxJ0+HM+janlwgTTbum4bDd8c2mVw
	8DFq3yiogQrAF0qhVD50jMEVvViKq2bipVdTBdTcbBjdrqn+lW4XNkg895zkk2WGqvd8NCglsCZ
	YelDN9g14Gpfeyk5XaoL4u9Xzt0Swho1LdVG5n0JWpbJVtP6ydWLnP5qNtb3qwgMe2PnuASrpnL
	sl6BivcTYM9QxLqvpYdFFCt2mwY8UDHJOWhh++0wkN3h2vob2l9B8cvXSQXXD5KbHclYHw0ejZ7
	Tlu0Kuy62lCNaaybkMO+NlD7Mz9CruLaf0B93F33700rgFry1UxXL5HF/iCdNoM52xd1v6s2rMI
	zhjU+gV5Ew==
X-Received: by 2002:a17:903:2f0f:b0:2dd:c100:943d with SMTP id d9443c01a7336-2ddc1009bdfmr43991255ad.59.1789853795511;
        Sat, 19 Sep 2026 14:36:35 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc16b4a8dsm12762905ad.12.2026.09.19.14.36.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:36:34 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: marcelo.leitner@gmail.com,
	lucien.xin@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sctp: copy zeroed stats to user in sctp_getsockopt_pr_streamstatus() when !streamoute
Date: Sat, 19 Sep 2026 21:36:34 +0000
Message-ID: <20260919213634.3314055-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In `sctp_getsockopt_pr_streamstatus()`, when the stream output extension
(`streamoute`) has not yet been allocated for `params.sprstat_sid`, the
function zeroes `params.sprstat_abandoned_unsent` and
`params.sprstat_abandoned_sent`, sets `retval = 0`, and jumps directly
to `out:`, skipping both `put_user(len, optlen)` and
`copy_to_user(optval, &params, len)`.

Consequently, `getsockopt(SCTP_PR_STREAM_STATUS)` returns `0` to
userspace without writing the zeroed statistics into the caller's
`optval` buffer.

Remove the premature `goto out` so the zeroed statistics and `optlen`
are copied to userspace.

Fixes: f952be79cebd ("sctp: introduce struct sctp_stream_out_ext")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/sctp/socket.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index c7b9e325ec1c..f3e48861e9e6 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -7569,11 +7569,7 @@ static int sctp_getsockopt_pr_streamstatus(struct sock *sk, int len,
 		/* Not allocated yet, means all stats are 0 */
 		params.sprstat_abandoned_unsent = 0;
 		params.sprstat_abandoned_sent = 0;
-		retval = 0;
-		goto out;
-	}
-
-	if (policy == SCTP_PR_SCTP_ALL) {
+	} else if (policy == SCTP_PR_SCTP_ALL) {
 		params.sprstat_abandoned_unsent = 0;
 		params.sprstat_abandoned_sent = 0;
 		for (policy = 0; policy <= SCTP_PR_INDEX(MAX); policy++) {
@@ -7589,6 +7585,8 @@ static int sctp_getsockopt_pr_streamstatus(struct sock *sk, int len,
 			streamoute->abandoned_sent[__SCTP_PR_INDEX(policy)];
 	}
 
+	retval = 0;
+
 	if (put_user(len, optlen) || copy_to_user(optval, &params, len)) {
 		retval = -EFAULT;
 		goto out;
-- 
2.55.0.1082.g2b9226bbc0-goog

