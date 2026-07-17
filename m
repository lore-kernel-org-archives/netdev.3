Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2301390231
	for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 18:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784314646; cv=none; b=M3uY80aHKnGp+BJxNbssxn7KSiw1ot8I/pFRSdZybPtOLRd1ZWq0Sd6FKgh+RxbVVBKLUkabNnrtEiyNRPPRMuHCPA16VWvIIh8vko86dnwWYVpTwxTiaeszvsAjLakK3wfX/cFtiB+CUiTUDc9GeYoFo6ExMxAgmg7iJ2m5Msw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784314646; c=relaxed/simple;
	bh=1F1SE1lLP/oS3nzGeTd/9IBL0aREwzGS+Bo3bJtQMdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AdalgOVaZRGGNEO/Wij1pnRKg3ujFR313TRFZVOvWyCkLvujs5gbrSFHVQ7xrMzzATKZCBknzir6Cf84MTcM9+JqyJNtHDJwuTdCpwoAXo0Ku7/AQmVj5mLP9EfdvGtfqMBxSKXtpaSSrE/3kwCJNtb+DKRRSa1ixxLeyDzfH9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gsFMA99E; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gsFMA99E"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-8484f229529so3532894b3a.2
        for <netdev@vger.kernel.org>; Fri, 17 Jul 2026 11:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784314644; x=1784919444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=joB5XdEMkRYTFOe6oQxV2wUDblqkRFAT1rpZftZWDv8=;
        b=gsFMA99EfPG7VxxbP/T+hdSq0a8HGgOyQHeviAw40zTvPK/cCJG5M+t4OGeUIsDkYG
         fW3nhFMA+Dl+RtjdoMvlA7hxMNbV/woo78qEDtAt6p9QdqSu+CHhVOceCqv7BKPd/ehi
         r2VhvCnLoMgM1Nqr+xciqK+1kbCpHILOMhm8VAPxowY5ACMAADv8MbXjviVBBoDVEZJb
         CrZ1SCG0oHqxxgjXRLn+OPdvvvJcTwmOFEPno5WUSj/lcTdGTbzP5haMMwszYxMkRgtK
         Sv0Ng/ksRTb5sNfiilAAIk5LCTLl+gEdfbVZiCKuESyOvZ3Cf3Y0HJiMBtLmRCVgmD/e
         xYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784314644; x=1784919444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=joB5XdEMkRYTFOe6oQxV2wUDblqkRFAT1rpZftZWDv8=;
        b=AecXx2w+RBNGx9KNl904ftx70fImNl47zHIoIJ9wu0ZmKRAjL8YbPUM21EBTtDk7lk
         6R9pQSRjEhqVQfL7RtehF6n0pjunWSnOkI6mQLDuHeA10I5Eu+0L/3Le86T0i17o861t
         VtjinPli+lMwa58fjIZyh2ZfDDgaNK+OFT5vMlllJD+Dwyb96gpTdAABKbT0ZfCsT/UY
         idVSEmGSdlTNByYcCsrDQIUGIS/MSbhv+pHBj9/SE6MRHsBc9Si15l0oXkJCCup2PAct
         zwBWMJ3u9NDgAcUQb5Z5/5JnjMXurPvHlIY8j2ntHvTVRZo4zFVl1X0ioSTowzeddwzb
         g0dQ==
X-Forwarded-Encrypted: i=1; AHgh+RpboIROAX1uQFznwV9LW7eE1yJgUi0Ah/HwKacjA++My+mkewba8ebo1cSGPjYhXJLBN9JDAjQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxN5fBgj9qDd67IO3a+BZgS4sbhGQ4GSI2Xt6U3nKWagVpeYuh7
	E3zRKtmJUIzIszJJT7ripO0JTHuWUitQdNyFTXhJzIgzS75OX74IsPlG
X-Gm-Gg: AfdE7cnwLtLkNCIHe+CiJlaI44pbDCeGdhpaqgoiZmy6+Q1MVPRNwKXT39VqtiImb8J
	MyoXhgC7H+DqgbOOzWpy1qhg+W1FoYeQUXi8rnFZKb3OJ2wBw/aQ6hGN4hyfx57gnSLmLbETZGI
	HM2/hYh7tAEhpdQSW3lDgvjBWqVKxGu+cI1pE4lk+gTXBUGP6bTdYsYdiaFiehO6upAvvlOJIFL
	bjD3F84m1nrEc95IXUB3VPDBkFaTgKvnUM5Crlh0kriy4GEIApoZ3CznAiNjCQFxXalQXh8qhpB
	n7tsZD2wxhMlUqVcYZnZQCZqIcrnffgMXQ+C3RiFF0sX9vwi+WHkVJ61JQUKpYcE1AvniMfu2/p
	UVW05Lficqueai6ukiwYCE1O3UZMUHZolGAP2fnOimhLxHdt3wE0UDSk9ZThpsnOLbAtVFIpXBy
	WfZz1vRMhL7zo6acH5ptslQqIQ5HgEJNFUyGlrz5o=
X-Received: by 2002:a05:6a20:e292:b0:3c3:6cfb:4ed7 with SMTP id adf61e73a8af0-3c3ad7ec516mr4411442637.30.1784314644148;
        Fri, 17 Jul 2026 11:57:24 -0700 (PDT)
Received: from kimi-bug-hunter.. ([47.236.164.125])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13ce2cbb7c5sm7376688c88.10.2026.07.17.11.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 11:57:23 -0700 (PDT)
From: Weiming Shi <bestswngs@gmail.com>
To: Jon Maloy <jmaloy@redhat.com>,
	Tung Nguyen <tung.quang.nguyen@est.tech>,
	netdev@vger.kernel.org,
	tipc-discussion@lists.sourceforge.net
Cc: Xiang Mei <xmei5@asu.edu>,
	Weiming Shi <bestswngs@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v6 3/3] tipc: fix node reference leak when defer work is already pending
Date: Sat, 18 Jul 2026 02:57:00 +0800
Message-ID: <20260717185701.2828080-4-bestswngs@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717185701.2828080-1-bestswngs@gmail.com>
References: <20260717185701.2828080-1-bestswngs@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In tipc_node_write_unlock(), TIPC_NOTIFY_NODE_UP with an empty
cluster_scope takes a node reference and schedules n->work. If the
link flaps down and up while that work is still pending, the next
NODE_UP takes another reference, but schedule_work() returns false
and the extra reference is never dropped. The tipc_node structure
leaks.

Verified by flapping the bearer while the work is pending: one
reference is leaked per repeated NODE_UP, while the work is put only
once when it finally runs.

Drop the reference when the work was already queued.

Reported-by: Xiang Mei <xmei5@asu.edu>
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Weiming Shi <bestswngs@gmail.com>
---
 net/tipc/node.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/tipc/node.c b/net/tipc/node.c
index b545a47d6ccb..428c4eacd02f 100644
--- a/net/tipc/node.c
+++ b/net/tipc/node.c
@@ -447,7 +447,8 @@ static void tipc_node_write_unlock(struct tipc_node *n)
 		/* Defer bulk distribution to work queue */
 		if (rc > 0) {
 			tipc_node_get(n);
-			schedule_work(&n->work);
+			if (!schedule_work(&n->work))
+				tipc_node_put(n);
 		} else if (rc < 0) {
 			/* Bring the link down to start over bulk distribution
 			 * when the link is up again.
-- 
2.43.0

