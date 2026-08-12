Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9F24746A3
	for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 17:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556398; cv=none; b=Tko3cgNb4UHMWqc+zpq7kDO9v3uiugOoWeUMuFOfaY+a8aDEZT1r7F6OsXb/SX+cneQsJEqlxYJB3McLA83k0VeoFnHFvkgxd1+BXOI0y4yKjR4DvPnY0IwDWf/JR3PHZ1uOb91MSTgzzrLps0Mof+1LSiV49Gm1sPFKZXWIzpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556398; c=relaxed/simple;
	bh=/zR14rBLp5RSvnjMYkYYe4XfDEj9OJj5TTqgGwx66vU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NvsBCmKWf5ydHFDFnWqfdSK32Mcmj5xXDhaaYXEmyZHpAMHp6RxDmW2re/Y6jnIeLtVRMnU0cU77hapfeGEsftFPxByiZtoqybGlYu02oEdKwWNnJ4QUZwCJ4rmd6L5O8/RaV3AgR0V1NDmYinxqX2elujDVZ3Knax2X83Zqhk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=HMWEaxgM; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="HMWEaxgM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1786556392;
	bh=/zR14rBLp5RSvnjMYkYYe4XfDEj9OJj5TTqgGwx66vU=;
	h=From:To:Cc:Subject:Date:From;
	b=HMWEaxgMtyfVAG9Pj5JAvjp82nEA8R62CAyqOIY0guFI1NbbJhUqQ+E9O2zBeXPZ4
	 KsgWpfi5QsQa21O6krVszIF6qe7JKOVmDKD0trSyU/h2Rc0f6Zzzgb6Ib3b4UHfD9K
	 D2ivMx8dsLcpAL3tj5JsjQq+jI8mtfwP6jKISHMxNEZM5wGo+I9BKHEF4eW5yOD47V
	 nTNF/dlfSZOYCPgAca67YGo/Hyn2yfF7eVJjyKrwO0KV98uI/zexx7tjotfrdd21Li
	 V/2zqaB9RSxZabZohfY6hV61uuP8+zU0pce46Yu6bTxQsJnFnBw6vX6PZCoSSlLONX
	 tMoVah3jEFpCw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 8A58F600C1;
	Wed, 12 Aug 2026 17:39:49 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id B04AA201569; Wed, 12 Aug 2026 17:38:59 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: David Ahern <dsahern@kernel.org>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	netdev@vger.kernel.org
Subject: [PATCH iproute2-next] man/ip-ntable: fix app_probes typo
Date: Wed, 12 Aug 2026 17:38:55 +0000
Message-ID: <20260812173856.1870300-1-ast@fiberby.net>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

"app_probs" should obviously have been "app_probes".

Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 man/man8/ip-ntable.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/man8/ip-ntable.8 b/man/man8/ip-ntable.8
index 56108afe..661db0c4 100644
--- a/man/man8/ip-ntable.8
+++ b/man/man8/ip-ntable.8
@@ -36,7 +36,7 @@ ip-ntable - neighbour table configuration
 .IR MSEC " ] ["
 .B queue
 .IR LEN " ] ["
-.B app_probs
+.B app_probes
 .IR VAL " ] ["
 .B ucast_probes
 .IR VAL " ] ["
-- 
2.55.0

