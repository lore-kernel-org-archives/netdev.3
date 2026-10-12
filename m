Received: from mail-dy1-f180.google.com (mail-dy1-f180.google.com [74.125.82.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF95548F83C
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 12:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791809999; cv=none; b=FiMW3mt/k4fVaffeL3D47aORViLpGWgrbpHVLoL9nl3Eov3hXW64OH/bZaiadYj20LiWb1wSmUHrH3/Srifhtyhm0guPhvCTzfP4o5WCbT2HGl88tHK+hn0GZ6QYaddZx4r8AKvL5ykF6j3jjcVyaBQp/7sm8hCL1uN4MKBxHzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791809999; c=relaxed/simple;
	bh=vbVRB+XAfZvGBptDaxyFBy0L6X6qfAhFcflwuzt2ToE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o/Ciz2qpzwecQcCImt9OGQQ4UYAESTWWdGTNM4pnDmh/XXHpmatXkxOIACzioioy+VVmmz3oMG8d1z8lQPhojxoVomg2o4Nly8alqRtWl1Wo0kCvQEOSGHnTn6bHBSN8g7arggIuANSWhEKT0jLArBXi8mB7SfNZMiN00q5H+xM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=m9Fw9/Jd; arc=none smtp.client-ip=74.125.82.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="m9Fw9/Jd"
Received: by mail-dy1-f180.google.com with SMTP id 5a478bee46e88-3514e7cbbbaso4758631eec.1
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 05:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791809997; x=1792414797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NfErURfU2L/OAAJKu6lDn6CF9WwV6WN3auE0sc7fkD4=;
        b=m9Fw9/JdT7zVBMhw0E3rlXzFTYRFAi1+7rVI/COJIXrHow+sAIwXCl9g3P/CnRzzFn
         DOULJy92j2ozVGbsPxG5G70EyGKDXAYjeQcZWudb/Ecss+KZiX0P+CIHTWhWRY/+f4Pf
         J2WGyNQbplTBE6apklFFfuOYxeDSCtGjaC/+VrdZGUNzJfsxQAUD4AdJwJmv95O46fP+
         hCwK5C1zZe97BOnfdiGTC9X7XvxSnin43uostm4WOAdZPrxzjxMqBvIaEa/IBzUTK20N
         /DI9UfPACtAMRwGKdgvA2Rsgtqhz2P3XWe5ufX7lnkxGCLpdNXAXFMjkXRfsNTvfwAyB
         D57w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791809997; x=1792414797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NfErURfU2L/OAAJKu6lDn6CF9WwV6WN3auE0sc7fkD4=;
        b=A7c5DJyLOHcGhOm89/r0fw/6mwMrDLhq+2a/rpGPHB6JFNC32KKhc/choNVtm/6XZW
         dDbRXWoYjmAQRqxSYm1715oDgL3LrK8s3Ld3itZzZArSe5XBsoX6/ejnkh/Gb+cbA0Qa
         mNnSeFUdyN6n9qg0ZgEqb1yL1YpMK75vBI2fSQf3aleZQH2hNeLFLuZKY4F7TgKdLKQ4
         jtDrmDvGSHKI7zXUL/Ezjb+HiUU05CylyNhDcKXIlwVWXdKdnsX55qY7Ew68mPIqwImU
         CcMJ7I1I4s0EROo+FPHsyu6bVHNC+LK5lgsgJ9MvQg/N7ObAngiFj3p4YQ7Jgrivbcdi
         UPxA==
X-Gm-Message-State: AFq9FYKX4Mvy+zwiqCpk7V1lL6klencW1BT/MlNW4FltsMto27sOMOe7
	ZoYAO4Uxl23ZG5aHMwdZIESxp3841gF0ZCp1CGAwjO8TDwnYGRKBsAoEFQRVv7P/+qU=
X-Gm-Gg: AYBFou1z2QsgYblvF+BMK9UEHM4/SwXpQ9dMhM3lhvKPzR7kYlsH5o3rP6Dw6NJJp6s
	PLnUqO8rMS2GcoLpP/EEq171amKXQnWxAT6AuCFvKmGQS44PBRVvBzcuPm5qpzd3Et7gEh3G+T3
	0VwULURZmWJUMJuBWnDNVhbocdNj1RF8mYLXMAhWq3OGNIYQEJxNRTh+QQ4pS/n+GhdNYgVZqVl
	0Jml0pBi2XGY5O/6UsFNOqTnOAJjMt075whhWrv5Og+G95EScrvrb02V60hrGXCkGg2fYYkGtHM
	6QA8c1mdpzvKQGeQ98j3V3z9G0iyVRCiotMdkwrmpIwGTfICI+bXT6DezUm5aYgFp6s2+Ul4v9M
	3zoD66gkqaZP5mm82gdeNIu2hb+LFJ4cBJzQiGFK45Dpw9Vzlj8DXt6ixf7Vr3zIzBCynl8Ldmi
	md0vuVwW34Rgo5fLitezkxyaTXTuSQR5drYwfvox97lVbKf2aRdh3vR3cU121ElU+skYr5vOxEs
	6cBqeQEU70XConrpaaLsmo014rQ3bjzkpQHp6KjrTxMHgCux9xbeYGuTbgS4Jk=
X-Received: by 2002:a05:693c:409a:b0:33e:a173:4aab with SMTP id 5a478bee46e88-3537df8cd39mr13479385eec.14.1791809996829;
        Mon, 12 Oct 2026 05:59:56 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([69.25.95.32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3537cacb61asm35348067eec.21.2026.10.12.05.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Oct 2026 05:59:56 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net v3 5/6] amt: make pre-query report drops visible
Date: Mon, 12 Oct 2026 12:59:42 +0000
Message-ID: <20261012125943.558629-6-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261012125943.558629-1-omar@blockcast.net>
References: <20261012125943.558629-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A gateway cannot forward an IGMP or MLD report until it has received the
relay's Membership Query for that family.  The Query supplies the
response MAC the Update echoes, so dropping an early report is required,
but doing so silently leaves operators with a dark multicast path and no
indication why the join never happened.

Emit a family-specific debug message before taking the existing drop
path.  That path already increments tx_dropped, so each discarded report
is accounted exactly once.

Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 2feb418..fec3265 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -1249,9 +1249,17 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
 		/* Gateway only passes IGMP/MLD packets */
 		if (!report)
 			goto free;
+		/* A validated report can only be forwarded after the relay's
+		 * family-specific Membership Query supplies the state echoed
+		 * by the Membership Update. Log this readiness failure before
+		 * the shared drop path accounts it.
+		 */
 		if ((!v6 && !READ_ONCE(amt->ready4)) ||
-		    (v6 && !READ_ONCE(amt->ready6)))
+		    (v6 && !READ_ONCE(amt->ready6))) {
+			netdev_dbg(dev, "drop %s report: no Membership Query for this family yet\n",
+				   v6 ? "MLD" : "IGMP");
 			goto free;
+		}
 		if (amt_send_membership_update(amt, skb,  v6))
 			goto free;
 		goto unlock;
-- 
2.43.0

