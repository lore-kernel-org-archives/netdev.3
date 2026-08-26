Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49EC3B42F6
	for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 19:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787773758; cv=none; b=EjWNTXK3+RIRXtCC12pbWWkqy8fGLAUYSka4XT0pFoITUt3WGhO0PgNC0Ct8M687HX2xEwqABYumBmF9RKyEgJOPbYKIfNJspOQKu7ZMw7zRYi4vZdU+hg7WFA9QVKQ3ZaNTLK+kBP/ViQzHeS8f3vNpGsmq45Xb7kIBL/cxH/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787773758; c=relaxed/simple;
	bh=AW4WKEuCghMNgHjYQbHVrEDlGbpcj0lCwJwe/wJ++ak=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cp++67Ikfq0OV9s7uWGkfZN9Gd2DqxO+nLCJJNT+yNYEv4xmv+Uji8SCqmDFTNQBDIcq6Tjmv56uirKOWLetJe3r1bFvqiFb7lvVSnJfX5OFL/ywW+J6qb6lnc0yNUPEHle51ibfsb6vyMbofEcDl2Bj/+1C9Qc3Sj9VVAEbtWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKVwepYY; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKVwepYY"
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-8efbafa1bacso8785626d6.1
        for <netdev@vger.kernel.org>; Wed, 26 Aug 2026 12:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787773747; x=1788378547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=byFpZLeLTlYJCoNU6m6amCAw3MQ4r4mZE5VxqlYI1wI=;
        b=gKVwepYY0KKdbFTp0604jq0kHjPNtNNpRfsqprCSWBxedff8o1efKnta/bbiFv7w3l
         9GMbpERuq1x8QDuyU6fHwWJOCmjyLun3V0/W8tVGOStLKWw/YelJnHgvH0/JhiK5IIp3
         tkj823NsIr2BMqBFep1cRfm0IvLplY7caoLadutFtCIqH/eTAnsC/0vnMHyGNqD2Br6i
         8S3Euk45X4tcmlsHpc3i2n4jcYU+ojBtQBEHU5reefgtxrggk9VnLj4gZcwehz/me8Sb
         zuTALpEn3L3iuuTFEQDb1Qcoqc1kahz26dkywuGy9jl3RLYzfx3q8q0JBxGCVoD94lG9
         d4ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787773747; x=1788378547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=byFpZLeLTlYJCoNU6m6amCAw3MQ4r4mZE5VxqlYI1wI=;
        b=YDznhRdWkt2B4Bgm+fl55KhcvaMf9d9Mrbf+mUo4iFQtoRXzEuuII0+u9i7+XzpLH3
         8cXhWLlQqt4xSMGnrPglqJPNR6QrEESKh5BUWQ4YMMwhG0lmHop9wVrdSgCqkF2As/0a
         5qDWftZvuFZFjB2jkk0HbI4xx4It0K/w8FnsE1nTWNfNmPK2C9bPZt8W9/S3Qi1cPr73
         tWtOcooDAFH1YyX8rAYVK+0BNgw3wNHaowcdWQRA+imf1RzSq43eCevrWlCYhIfa7WMe
         DsfEB6HOWSOIyvRDUF2vJg5SgTzm6tjiXXpunhnaRRNwArjNOtX+03ebdAs1cv6ltogv
         Qgfg==
X-Gm-Message-State: AFuF++n6AndEDgykVT52t2QIQPU0yrA83NVDWghGiQ6PI0DR1ivRl6z0
	jX9ZZY/R2c1XcOM1nMVB/6g0B06bNGUGKKgYG2ZUJuFUq/mBxFH+yZMcoYvpEQ==
X-Gm-Gg: AR+sD11U44iJSx79NkKzNvhHGlR4o4Yh6NZLpIhUg/PXrksgBaLyF8I4YZeMxB+aweQ
	onegrwXh301smd/XTb5FBnESU38TJ6a6+GDrywMsCuq1fsvK6aX4d1nLXC/e4giTvsVNuWMPXSW
	y7g+WHTC4n+RjKLA658VD8yjRmnsmkaJwfN94IM+WQ+3EohV1hYRvV4xDbiXmVXbvC5ZCiq5e2v
	7TPd8w15RZGW9dyOhgUjUUj/emmcYssLNU0rZfEIl/p3oCPz5Z5qOSY+8ByGWcSbcxcx+y42UTl
	RHUB4w/SyLVJePuNSklLiKWg4Eq6L4hhXW0Y2lgFPuVDRzMDG7QSk4+g4XeE/nGvMP/KeuzeKpT
	kNixzP+1dfP57hJEcHH7j8Pu1XYpV4rPxUpXWFDNQvfo2Vt9cLQL2uxjIgVZICRxub1UGmXjV93
	dVxoVNrjkgrT6r1jx1Tck72XpK00Os7hP59geOarqbeSKg0ndUQOQNGJf+Sw+zuuZMl5Kah0I8W
	d1MHRN+W98CpsiFZMiRw6vBbjCyBm79mp9WUlH+jmplU4+nQS7FHemoP1l82BcqoixE6WJWjZQI
	NetrlIKWy9cxlnh21rDYBHpdGbmkF1mgAsMHeg==
X-Received: by 2002:ad4:5ec5:0:b0:90c:576a:db55 with SMTP id 6a1803df08f44-90cc79ba9e8mr99466226d6.21.1787773746653;
        Wed, 26 Aug 2026 12:49:06 -0700 (PDT)
Received: from wsfd-netdev58.anl.eng.rdu2.dc.redhat.com ([66.187.232.140])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-90cc64216c6sm34448386d6.22.2026.08.26.12.49.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 12:49:06 -0700 (PDT)
From: Xin Long <lucien.xin@gmail.com>
To: network dev <netdev@vger.kernel.org>,
	linux-sctp@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	zdi-disclosures@trendmicro.com
Subject: [PATCH net] sctp: fix a TOCTOU race in SCTP_CMD_TIMER_START
Date: Wed, 26 Aug 2026 15:49:04 -0400
Message-ID: <9d8f1b5c50329d5ea7c642128d35681abaa9ed20.1787773744.git.lucien.xin@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The SCTP_CMD_TIMER_START handler checks timer_pending() before calling
timer_reduce(). The timer can expire and detach between these operations,
causing timer_reduce() to rearm the timer without taking the association
reference required for the newly armed timer.

The timer callback later unconditionally drops its association reference,
which can leave the association reference count unbalanced and result in
use-after-free during association teardown.

Use the return value of timer_reduce() to determine whether the timer was
actually armed. Take the association reference only when timer_reduce()
successfully starts a new timer, closing the race between checking the
timer state and rearming it.

This issue was reported by Nico Yip (@_cyeaa_) working with TrendAI Zero
Day Initiative.

Fixes: 20a785aa52c8 ("sctp: Don't add the shutdown timer if its already been added")
Reported-by: Zero Day Initiative <zdi-disclosures@trendmicro.com>
Signed-off-by: Xin Long <lucien.xin@gmail.com>
---
 net/sctp/sm_sideeffect.c | 11 +----------
 1 file changed, 1 insertion(+), 10 deletions(-)

diff --git a/net/sctp/sm_sideeffect.c b/net/sctp/sm_sideeffect.c
index 94716406d602..0d99b7e8c082 100644
--- a/net/sctp/sm_sideeffect.c
+++ b/net/sctp/sm_sideeffect.c
@@ -1545,17 +1545,8 @@ static int sctp_cmd_interpreter(enum sctp_event_type event_type,
 			timeout = asoc->timeouts[cmd->obj.to];
 			BUG_ON(!timeout);
 
-			/*
-			 * SCTP has a hard time with timer starts.  Because we process
-			 * timer starts as side effects, it can be hard to tell if we
-			 * have already started a timer or not, which leads to BUG
-			 * halts when we call add_timer. So here, instead of just starting
-			 * a timer, if the timer is already started, and just mod
-			 * the timer with the shorter of the two expiration times
-			 */
-			if (!timer_pending(timer))
+			if (!timer_reduce(timer, jiffies + timeout))
 				sctp_association_hold(asoc);
-			timer_reduce(timer, jiffies + timeout);
 			break;
 
 		case SCTP_CMD_TIMER_RESTART:
-- 
2.47.1

