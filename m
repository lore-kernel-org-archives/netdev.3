Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F2A38BF9C
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 06:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763092; cv=none; b=I73knor85hsENmY4cIECfiJpUA26YrLEKZEyhWHcpFv178JG5ZNxWDdFAw/y6y478ETmVxw3EnRS8N3s4X1HaiVmmTiYL7fb21vlvsaiLYJwEKgVeVy+QunBKcG1Gz5i7UhXNECM+LyUXeDlZow28NhIM2XV5kxcRvZI8pno4b4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763092; c=relaxed/simple;
	bh=axaYHO8Bx7A6SwagGOHhoHo/gv6UY0jGnfB+8icSGAE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V8MnlJKjVlczDqs6xSwsOL49gLEFLyzqHqPoeDdX07Xo7vJRdJ2aKVOUhHokBHva6OLio4zZEf8XaiXu1qQObXCdUr+uX1VVY4BAVcZxq5kSdV76SHN9T7RkPVv2Spn817ys/Dev92HrhcZiGZMPLolUOqkZMvJXhlF/00apwQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ri3ZLXhN; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ri3ZLXhN"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-38759bcd877so3184291a91.2
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 23:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763091; x=1789367891; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xbM2ytUwgMYDUMgw3izsEczlFofBu8pewRebFwxAFDA=;
        b=ri3ZLXhNmZd0A2YeWGYQGWTORjlUANwWbFIHX02T9dvNXzMxrBhrwrAi+ismrpXbGK
         i1G+Z7bgm1dwCZ3DLGr/3bS6HrSjZzuB6bzz9lsRs9tXDOwayOb5u4xe+lVgrBTAp05R
         +by3US2NdI0hboBuABCNf6EERmRjKGMuB/5Qsj4U/syh2MWMDnWN0JwEIsqTzkloxeZE
         e7kdfsnsVplHxd9F9bZIxCTnPDGJV6myRTjf2W+31YBimuF8eBBRsY/06wAFGVd2Iiu2
         TKYpSiFISULq84hocTwQvHVYGCGbXK0zRIue7WcvqoKUMAk20fT4piTS6ffkUReC5CXT
         CemQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763091; x=1789367891;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xbM2ytUwgMYDUMgw3izsEczlFofBu8pewRebFwxAFDA=;
        b=kwSkithnVWt9v5Sw2QnZ3uAHfGnZp4u1gn358AUtyWA5KoDgSx/4HBV+e98dn+LtkE
         S6RlsqlcCgehUvvex8syfBB9qS1mtjficVPV8U9cZXnSJ5gixAIs4QVOMBVo11RBbyAZ
         XBX1IAAgiGu4Dlo8PHwxQdeRdBUAGR2g7MDzSgP19i7a3ixpky8X4x75BLAcH7Oil7r4
         QYOSsdNQAmatY3RL1sKLeFjWsJfVwczS2Wy3gsIasLzYrgpBNbn0vS/SBy6DhJkF1fSc
         RvPPPN7wy4vshfr1pEYBC9AdY4oyX+70Kke8NbzMtBTRuynofIgdk9IEJsTVl2yDyHxZ
         larg==
X-Forwarded-Encrypted: i=1; AKwUvBydG6ndUr8rwXGgmdB8pMtXttNTcGLJaysRpdz3VSAvPG4VS5jQqVOx2hZtpZGiag0gvEkQtDg=@vger.kernel.org
X-Gm-Message-State: AFuF++lx4YkfdsfBGuY1xinVTDu4cTfMF89hmqotqOy2gWm3EOvzpm9C
	64SUtL1pVrDGPvpik3O/xY5CUWMMAkuJtMfeGbi8j/7JWfP8lNOuN+Y6
X-Gm-Gg: AYBFou1j51zTFqpy8fCrzIxbcq9k1MMmzc+IOwlxLNhx3I3Il1wPFgHc2J19cOEG9Jk
	UsnOoKMmb8YsaUI4tr+VDsHaPoTtmPab8dLAca4ReJus/TjFAWonvGQreah+POamSvkcz8Uxpwf
	ioYV20VUUMokxOQd1oFsUVSjhi46F18xJ3h7/uFmEwWD4gTISDSEFZiNffMGcz2kI84vhkGg9gK
	ZzBFA2Pi2IQxVbGT2dSOzAm7o1n2aNJwnlnCG9qzP/SuGzGZW66rnkf/yjRsnSWgxN2Vg3SHEb9
	RqDRJug9B5qTBR0S5kTzt0ZnSAxrDHigjMTbdZOOjDibPKPnNrb/5AiwduL45s7xnm5aL2OZH/F
	Vi+34QXgJE7CdqQXuxl71m34jyP2oAYG2CKeS3jS0C37M8CKpu3v5VdgJZTjswYIfyHBH4i4VdP
	RiXMPXXn2fWbnobfoYL2VC4dKMXTKJ8dMb1twQBQjtfgDA1hhmb7DnZ+7YbC4/+QCNqZfMnXFVS
	hgCJMpMii94pQ==
X-Received: by 2002:a17:90b:3c45:b0:398:9beb:5c19 with SMTP id 98e67ed59e1d1-39b26232bb1mr33016891a91.20.1788763090750;
        Sun, 06 Sep 2026 23:38:10 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1432437d0f4sm22103963c88.7.2026.09.06.23.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:38:10 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Harald Welte <laforge@gnumonks.org>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: osmocom-net-gprs@lists.osmocom.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: fix repeated word 'to' in comment
Date: Mon,  7 Sep 2026 12:08:04 +0530
Message-ID: <20260907063804.26581-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Drop the second 'to', reported by checkpatch.pl as a possible repeated
word.  Only touches a comment, no code changes.

Assisted-by: Cursor:claude-opus-5
Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>
---
 drivers/net/gtp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/gtp.c b/drivers/net/gtp.c
index 69fe5717846b..4aff23bcfdd1 100644
--- a/drivers/net/gtp.c
+++ b/drivers/net/gtp.c
@@ -770,7 +770,7 @@ static int gtp_parse_exthdrs(struct sk_buff *skb, unsigned int *hdrlen)
 	 *
 	 * This length field includes length field size itself (1 byte),
 	 * payload (variable length) and next type (1 byte). The extension
-	 * header is aligned to to 4 bytes.
+	 * header is aligned to 4 bytes.
 	 */
 
 	do {
-- 
2.48.1

