Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBDE39A7F7
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 22:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775775477; cv=none; b=g+Us7YcIa8wD5Ii706iF8peI7ZeB8s5rc820x32wWYIRv9hr4U+a/a0iTryKKEB+vIYdSB8XIs4VkN0HM4tGfqEz4ZU7N5LWUmrP/aClrvesbTXSJVxNc7B5MV5al+JQWMpmkffyx/uT2B/uessQuNLk+Csyzv3o/ZEp3vWTSI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775775477; c=relaxed/simple;
	bh=l0icAC0WKtAyUMeX00DBbJs/U+SMKWBFK94YmvzFQ5I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=psT37QnU+gYsXmBRZ7I/DdbvvYSu9G5iTfUaT8HPN5lW7DARyD1pqSFMhueXunGWg549QLcqqg2pUUbg5DtdC7YXZoJgXb4ZIFy/SX/dMY5z9ZSG4iyIU6wIjcyidSY0y7fBEKVpmGnHG6x68puN5qAv9JzHjdiiXaRjnXl0aoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=eLl27P+s; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="eLl27P+s"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775775463;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jnoS1wNWmHG1AEsmv6+k3eEUs/PIBJLpg73LgwS2ExE=;
	b=eLl27P+sKlG3ISa/9YlBcjcCoxc8R2RZZ+pWD7lkGIOWzjfpEwJV2qpZuAsSmJyVGz40aR
	9NWt3wfGoNuHFWUFjfhqlGqEhLTlst3qDBg1b8JVqdCiPBGa5n3ATmPt75ctR3yg+i4l3T
	ezbjrVWJZSbSp4oGllr+M0MOX0VEz5c=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Tim Bird <tim.bird@sony.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] keys, dns: drop unused upayload->data NUL terminator
Date: Fri, 10 Apr 2026 00:57:02 +0200
Message-ID: <20260409225703.158552-4-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1115; i=thorsten.blum@linux.dev; h=from:subject; bh=l0icAC0WKtAyUMeX00DBbJs/U+SMKWBFK94YmvzFQ5I=; b=owGbwMvMwCUWt7pQ4caZUj3G02pJDJk39PbPflP+9Gxe8CtdoQcpt+uXSaauUqtPcu0Lm8j5+ 0D4hsiOjlIWBjEuBlkxRZYHs37M8C2tqdxkErETZg4rE8gQBi5OAZjIAj2G/3W7f2gc81314iTn rurAGz/DJKINeK0n699J4Planb9Y5h8jwyPWbUosxtw6z0OuRxu97TPqd5Euufn8d+yWBXs+dXx kYgIA
X-Developer-Key: i=thorsten.blum@linux.dev; a=openpgp; fpr=1D60735E8AEF3BE473B69D84733678FD8DFEEAD4
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

In dns_resolver_preparse(), do not NUL-terminate ->data and allocate one
byte less. The NUL terminator is never used and only ->datalen bytes are
accessed.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
No changes in patch 1/2.
---
 net/dns_resolver/dns_key.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
index c3c8c3240ef9..451247864a63 100644
--- a/net/dns_resolver/dns_key.c
+++ b/net/dns_resolver/dns_key.c
@@ -203,7 +203,7 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 	kdebug("store result");
 	prep->quotalen = result_len;
 
-	upayload = kmalloc_flex(*upayload, data, result_len + 1);
+	upayload = kmalloc_flex(*upayload, data, result_len);
 	if (!upayload) {
 		kleave(" = -ENOMEM");
 		return -ENOMEM;
@@ -211,7 +211,6 @@ dns_resolver_preparse(struct key_preparsed_payload *prep)
 
 	upayload->datalen = result_len;
 	memcpy(upayload->data, data, result_len);
-	upayload->data[result_len] = '\0';
 
 	prep->payload.data[dns_key_data] = upayload;
 	kleave(" = 0");
