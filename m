Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A34E30BF5C;
	Fri, 10 Apr 2026 05:50:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775800216; cv=none; b=FU16IV+47rdXmcROT0lWWAi77U0+sNZLm52osX5E1KS2xwKa2AOMUvwZYdPthoOl4rdt59RWeMhKgQKCbiZDtGFTybmlUmE3X3zRphlRu4pemuVyRdM1SUOY7pknUKp2Mk7t86VwH3yy7wZQo5RYPOVBc7PSDlXUhKnN9MReb98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775800216; c=relaxed/simple;
	bh=zPqjh1z6xmTB9lPHSqZ2VvUqMptfElhRPcqqbSlPndQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaAlLMjnew56bnKnAZnGtVzkOnaRMXIF9Q+nuGF3Y1EkNPiXzG+tMvTJS4NBlJPSMbjpuZmYoa0YGuXJhYfFOcTOeY/jpU6JTS5NKS1lcL7lva67ERZdkj8TdKIifqqbPyKECjRVVOB/5JqqJp6EgxZGi3epuwHsIfYLAWbTen4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=X0V4Gu/z; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="X0V4Gu/z"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775800213;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sY29MFK4dUmAkfKCpdegdk2ruSANehnlXZ1ZNUYSz+o=;
	b=X0V4Gu/zGLKPs5pkelr9HzGpJ3vdwcz042miYoIDaT/CvPRZPseWrJ/tXAstif7IdSsqWH
	eWi56Pw+f+6Z+kEcIh+91TktD6U+krgqLmMZCUIK+i/Gr2vKgeZnXo1yhv4AhkpuPtu55O
	9C01GO2fY9U4/LFJoKlSLz408dMM30E=
From: Qingfang Deng <qingfang.deng@linux.dev>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linux-ppp@vger.kernel.org,
	Qingfang Deng <qingfang.deng@linux.dev>
Subject: [PATCH net-next v2 2/2] pppox: convert pppox_sk() to use container_of()
Date: Fri, 10 Apr 2026 13:49:50 +0800
Message-ID: <20260410054954.114031-2-qingfang.deng@linux.dev>
In-Reply-To: <20260410054954.114031-1-qingfang.deng@linux.dev>
References: <20260410054954.114031-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use container_of() macro instead of direct pointer casting to get the
pppox_sock from a sock pointer.

Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
Changes in v2:
 Do not remove the comment, as the struct is allocated from sk_alloc and
 still require sock to be the first member.

 Link to v1: https://lore.kernel.org/r/20260408015138.280687-2-qingfang.deng@linux.dev

 include/linux/if_pppox.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/if_pppox.h b/include/linux/if_pppox.h
index 636772693f9a..594d6dc3f4c9 100644
--- a/include/linux/if_pppox.h
+++ b/include/linux/if_pppox.h
@@ -54,7 +54,7 @@ struct pppox_sock {
 
 static inline struct pppox_sock *pppox_sk(struct sock *sk)
 {
-	return (struct pppox_sock *)sk;
+	return container_of(sk, struct pppox_sock, sk);
 }
 
 struct module;
-- 
2.43.0

