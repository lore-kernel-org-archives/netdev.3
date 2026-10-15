Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2633F0773
	for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 20:01:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792094491; cv=none; b=mGw3j7Mrk08QQ5A3ZO26J3+yuJVvjG+9LS/dIdhTt+Q+VN8galX9nHpTHvA8tX+VdV8/0YHOpJwi3Z4kPLyowBpdx9d4WK00xARNqNG95UUfrTAJAP/Tnq+e3QBS9GfdTmhsElXXxOACETVrH24gxDz4FWJtYMOJHWmPtO41v1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792094491; c=relaxed/simple;
	bh=QL9G/ZdfxHTjVTXMQirkaxiH1Rb6WFT9TmpnX/tQqdU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mf44xoyXKjp8uyHYYO1BY7DjECKufQWN0HfIL3JMNppjeZQYagw295XXpCmWshkXomgbWrO47BOecnzLBs+ey78sXqSRUo6TmLLGGcTb8J9MuD+6C0ij3IQCclBhlzG5QD/+IWUxQZiEIwGiL7QSwlznje6rFoTPiT/sAkfTriI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a601hR5r; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a601hR5r"
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-48e2d5a69c4so1056748fac.3
        for <netdev@vger.kernel.org>; Thu, 15 Oct 2026 13:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792094489; x=1792699289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rt719Y4sNnt0qnmrZXsL4TYbTguenBlckVdl7ZRbCnc=;
        b=a601hR5rYr8KSRmch8t+lHxpjcl6hE2e0cIl7T6j9pjPHk/HRS492+vNQdYrxVA2mP
         oBTsL0cbr2QsBpGrQwQPxrJWvuPmuGbJacJNDqPAI+8raB8P2Mb/0LoztA9TCgmoou4C
         v562DEzjUga/26Mz//uNRJVciKtrTSA0oX8QlgkREP0zGkrFjBRxDOKHFOJmzi717sbj
         Qxcxseoxm6ZqMlg4yWaKZc34gs3kp5JWlhi/pxNgHxraawF4TuNY2OWGF8sbCqJsiMx8
         walK0AobHV6aauEudYVhKykKNocBqI+PtYg4ZYXwdMieqNKVosJpODlgeL7FAu+WFSMY
         42ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792094489; x=1792699289;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rt719Y4sNnt0qnmrZXsL4TYbTguenBlckVdl7ZRbCnc=;
        b=hhQFrM/f3oGnY8PUejsljXDw1pGuSJ86KPFzH4ayv6p4SjnSDMLMy8gTPLP5KWQMrY
         Xxv0LWd4BDzBeVlb3hg3muZq+z5jsD3K27uSghDRBCF5rN//jkG4F3auCU9P6BQFR9Xc
         iFYmUIG6PDOWAdvEVk0dZn0HzPhmbCBS8kzIzQVDUV7/MKuj/HbAa0nvwnsxwKFl05gG
         +tK6v7UxqS1DkIO+CTp9Cq+GoO6aG0tavhVPZJlUpgI82Epf1bvQjx5oQ22JSP1ENh6A
         7sAbrQ75mA3I+KHKfM5EypQmuFI0CukpcjhEM+1dsaDg/vRcicJqv+13XShpcl6eBxTO
         g3qQ==
X-Gm-Message-State: AFq9FYLkkL20fXJJy2G1DLxIj9vu25Z+c6I6CkvgwToOPifO4MlAUeq1
	3fPayBdSuvnwUaGLFnxTt9kEIPOWb18ZJ+bHB3CbhZz05N89gu2K0Dfh
X-Gm-Gg: AYBFou1w4b4xeXAzKfaEbnaGhQGDwvUI/Qbd8Ndddnlnn2f5FLfO98+Nuoi9p4RqTyq
	1TawKCcRTtVpXB6Sp6eYfwIeQ3+H6MroN9VndepSroECmlTerlmPpH4kQj1PEyCf7zuEI+0TgbF
	uyK4Bymwu4EdD+EaASUyr4GtnTF3xZRttBoMqugvq3y14IIlKGhLWSMDR/AtJXX19zBm3kwEFBM
	cTCHpNFKgw2/d6gLszG7aQpXR4eFAQbHARh3uY/41xUJ5f1S3v85W73RlosBkUQeehU2OXeBwoE
	3GbH7GKLHzuL4892t0AHl1YkVx8TNbRV9c6cthJp8D0fKwf/ijD/jm/RV1qIeygVxwAjevsTdBX
	MSV3Zotmq6L326dU5P6zIUY1zCNYkuT/f8OS7V+kOJ03R5rPGY5+t1Gut2XyrFMZcAdTs328AKa
	2Xqeh31xvTdtvFKmoPSZdfKIUHTgqqK7Gd8z/TKAthhOrF/eNBOa3WgRJN55DXJtfUG2F/Fx5yR
	pMFzBv1u1LSBYI9OOCuj69ff0sfqYOFGewyxiptIZGmOyC/kRw=
X-Received: by 2002:a05:6870:5064:b0:491:2ed8:33e6 with SMTP id 586e51a60fabf-4a2a8b4290cmr16609778fac.59.1792094489083;
        Thu, 15 Oct 2026 13:01:29 -0700 (PDT)
Received: from cr-x-ubuntu2604-client-2.dev.fyre.ibm.com ([170.225.223.17])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4a73adff016sm12208fac.0.2026.10.15.13.01.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 13:01:27 -0700 (PDT)
From: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
To: dhowells@redhat.com,
	davem@davemloft.net,
	marc.dionne@auristor.com
Cc: netdev@vger.kernel.org,
	Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
Subject: [PATCH] net/rxrpc: Simplify rxrpcpeerseq_next()
Date: Thu, 15 Oct 2026 13:01:15 -0700
Message-ID: <20261015200115.59571-1-chelsyratnawat2001@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the redundant initialization and conditional handling of n,
as it is always set to 1. Use the constant directly when updating
*_pos and starting the hlist iteration.

Signed-off-by: Chelsy Ratnawat <chelsyratnawat2001@gmail.com>
---
 net/rxrpc/proc.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/net/rxrpc/proc.c b/net/rxrpc/proc.c
index e9a27fa7b25d..608670dc97d9 100644
--- a/net/rxrpc/proc.c
+++ b/net/rxrpc/proc.c
@@ -367,19 +367,14 @@ static void *rxrpc_peer_seq_next(struct seq_file *seq, void *v, loff_t *_pos)
 
 	for (;;) {
 		bucket++;
-		n = 1;
-		*_pos = (bucket << shift) | n;
+		*_pos = (bucket << shift) | 1;
 
 		if (bucket >= HASH_SIZE(rxnet->peer_hash)) {
 			*_pos = UINT_MAX;
 			return NULL;
 		}
-		if (n == 0) {
-			*_pos += 1;
-			n++;
-		}
 
-		p = seq_hlist_start_rcu(&rxnet->peer_hash[bucket], n - 1);
+		p = seq_hlist_start_rcu(&rxnet->peer_hash[bucket], 0);
 		if (p)
 			return p;
 	}
-- 
2.53.0

