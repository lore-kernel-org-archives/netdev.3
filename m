Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF3825785D
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 00:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791419780; cv=none; b=B4J6+IbqfKnQqxEYVQobdXEd31GaoTMWHHsluVGD3SXd8Ea2xjz4Fgulpk39PaByz9YFC/J8+TwC3NkEeRoPhUoiSxPN5JjxcytyhtVhDoaOu1gAz/kkie11CvPHzWinE3gax5IYvpyvY7PDrqdUVg9piCb98OIBQmdePxRjs5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791419780; c=relaxed/simple;
	bh=wzs1F01/ow7OULZpLgFM/8mSLAaxGtAlahSetko60uE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sXMl9bXY7ASLa3Zj4Tqir2ZIBei5ocWHHXbU5n6b+FwA4KPGO3ntqoNTjFjaUNoNWXMNiEj/DwSCmmCAdy1oh5h/VJsACtw8JtjvVe6FFGdrK70hEIlSmk6Grid4HqyC2C7LG4Yl4aMzVIq5txy1hpWlIzxSUnbgdhxeHW6ztJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=onJUJpbG; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="onJUJpbG"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-3517d4e49ceso47711eec.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 17:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1791419774; x=1792024574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cUlJazWzaxUjjRKpYw+lQ6eU3z1EAi0CxgyA80J73rM=;
        b=onJUJpbG3veUk/8p0+9q0NHp2qPFBjXZQiu1L8Utf4YcVevcrgd1Hq0EmiQtjKbrpS
         2vc75hQxouOOKNZSGUIM9p1MnWsurjNQ7Cdx+5O3toEHS18GMRze4wkkqcawHbmxTokN
         CGqxyezLhU5nJMMflivSsToDhS1dpkaT4SDo3apTTMr7OGgWVAAmKDeR0GpAtswLRXYe
         NSt8KlJVDUHBMJrec2y8xWRc1zvu6F25YVnnGuzZT8LiBmyF//R3UBEJKDt/tqQZi9g9
         pZ9BmCW8YsDn0wWx1I5+AxibjX54hgy0LpIMqNvRnFzVcS/GmFLTzU69R7E7ZgFN+tDT
         5HNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791419774; x=1792024574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cUlJazWzaxUjjRKpYw+lQ6eU3z1EAi0CxgyA80J73rM=;
        b=oDMMR/pUftZkfQuEUgI0VmZYy8stBFg+BR1FGZBrYYBaPUHg+axTUWq+v4N+o+tGmj
         7k66a63JSjs1pUbqyZgZfKNlEWupVAhTL8hGJ0ZIksBciXTcdiRbf41XOm17u7rL7aeD
         mGtTlGnL7J9i53nT31TZBEskkjI5DRj5hqonsMNlsU6EyMNcB0FW+cLVbY7D/Dy2fmba
         IypCzuvFLfkXluZRf+45Dn2rD+VGDsRCmhzYVTah8WivTu/NVMgOS5+98oDQaXkcbAgw
         TGzj/81cAIysmhG2iLk6JGb/0lszR6yMY6ySiCc2JLikOeic3EHTdPh7MPexsL8+T5vP
         7EAQ==
X-Gm-Message-State: AFuF++kPBZw4KiVTBNC9UIdvEVPOKYPkznh/zydO2Jb7WX/2YS4V7l02
	B6sSeR9wMnbW2rvju3IrjYQix4su3a2taAnB9fdu68DkRM47Tfe7Ke1aBJrAIGMnO4k=
X-Gm-Gg: AYBFou3/qa99t9iaQ8+6xBlucQ44h4EZH87m2kpVx6e3k3SeG2IrOvjDKPBu9Lge1D/
	9OQbqOXAGlBztTu7LBVoP3yjEIY5g/pKlQnZaSLxI/AtEJWqfGFMOwmqB+OCkDhuLZBnH1QGC7N
	rZKvuzs7fTjSW8paWnMNNKZJN28p4MB2DTtNMAKa86nXX3lIGLqAMwllHeqGzloZ0Ue8rPPazRg
	br+XvR5lSpZy/Vi65kwzo5brQalaR+bmDSr63+/Cqwc5g185BjT1I0azYivU50r9X9scx5X4JfQ
	4CVtJv2vlKBihIJRMqPYbLgTjQAJfTFvahicKnEK8foF+sshefQyrVSO7nL3Iog8bJGaI7VuHwK
	FlsavXIF00gzO3WmAk6M2d1SjlNF225iJKpzAljx1+q98oR2WonvSN3CtcVo0WcgJr5oAHJJHw2
	oIjyNXO0M/CNkJ/PgEJk/lFuFlRKsusNimKc9XpyAx2E1NNS5bsZCp4T9bRmMHdIBrpYVN4YcF6
	D03SbVkOgkjM8W9BFh5Sf+BmeS5a3DQBJqNITHM
X-Received: by 2002:a05:7300:601e:b0:351:2200:1cde with SMTP id 5a478bee46e88-35177712b66mr954708eec.8.1791419773980;
        Wed, 07 Oct 2026 17:36:13 -0700 (PDT)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-351735e316fsm3496694eec.11.2026.10.07.17.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 17:36:13 -0700 (PDT)
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
Subject: [PATCH net 3/4] amt: make pre-query report drops visible
Date: Thu,  8 Oct 2026 00:36:04 +0000
Message-ID: <20261008003606.3666617-4-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261008003606.3666617-1-omar@blockcast.net>
References: <20261008003606.3666617-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A gateway cannot forward an IGMP or MLD report until it has received the
relay's Membership Query for that family. The query supplies the nonce and
interval echoed by the Membership Update, so dropping an early report is
required, but doing so silently leaves operators with a dark multicast path
and no indication why the join never happened.

Emit a family-specific debug message before taking the existing drop path.
That path already increments tx_dropped, so each discarded report is
accounted exactly once.

Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index 17dceeaa1..79f2f59bf 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -1251,9 +1251,17 @@ static netdev_tx_t amt_dev_xmit(struct sk_buff *skb, struct net_device *dev)
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

