Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E15835E927
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 01:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775613115; cv=none; b=kfDavnfoaD+USuWDKp8Wd6ENmHtz9Y8QoNT/tSYxGrsddvZchzQO40GmHXe1aynCBqXHUYfJXyQO6VUCRqw9Qb5PBItzn3zZoNX7uARJF/dmuUWQB77NaJkF3RAxP9AiKw8Jk+N3kbeFRawsLUjQhieKK7oWVgcTQAC0g28CnJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775613115; c=relaxed/simple;
	bh=y/3DO+ORwS5VbmuGQpenBxZoTjBDdKCHAGR259B6XoI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aYUPAG77NKa01XD+iaDm13Z0vWeFr4a4itZWaK+1K4lh3eFN8WCCLlXQqDhGncVcTPjMxmW65eq+mPBbTSJt6bHS1B7mx78hUh804mQZHxl1LVs+5zVjZWg4x6E1aw7w8zyzlUtoDS6TE3/mS+BSurRlXMuAUxjMT1xsSsPupgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pmYOaKOu; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pmYOaKOu"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775613111;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aIh3ARqFq/vGHnNpbOy4uDjZQT9ulz9JUvqqrKVvG9g=;
	b=pmYOaKOuWVio+2g5SXSZBwPgoo2UpZiZ+T/LYffORRFfwfoeckC7Vvfsi6bgTWUR0Lg/wt
	5liZKQ/2rJhtcl2hFnV4QqAr0PdTinNI84ZQydUyLDHYrldrUBFRvybZ2yFubYD4AzvTa7
	TKWqqNMT330BH5wLj5dQsw8gDwQv7hg=
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
Subject: [PATCH net-next 2/2] pppox: convert pppox_sk() to use container_of()
Date: Wed,  8 Apr 2026 09:51:34 +0800
Message-ID: <20260408015138.280687-2-qingfang.deng@linux.dev>
In-Reply-To: <20260408015138.280687-1-qingfang.deng@linux.dev>
References: <20260408015138.280687-1-qingfang.deng@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use container_of() macro instead of direct pointer casting to get the
pppox_sock from a sock pointer. This improves type safety and removes
the requirement that sk must be the first struct member.

Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>
---
 include/linux/if_pppox.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/linux/if_pppox.h b/include/linux/if_pppox.h
index 636772693f9a..4f8d9e02cd7f 100644
--- a/include/linux/if_pppox.h
+++ b/include/linux/if_pppox.h
@@ -38,7 +38,6 @@ struct pptp_opt {
 #include <net/sock.h>
 
 struct pppox_sock {
-	/* struct sock must be the first member of pppox_sock */
 	struct sock sk;
 	struct ppp_channel chan;
 	struct pppox_sock __rcu	*next;	  /* for hash table */
@@ -54,7 +53,7 @@ struct pppox_sock {
 
 static inline struct pppox_sock *pppox_sk(struct sock *sk)
 {
-	return (struct pppox_sock *)sk;
+	return container_of(sk, struct pppox_sock, sk);
 }
 
 struct module;
-- 
2.43.0

