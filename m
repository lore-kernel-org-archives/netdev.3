Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com [74.125.82.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0672149E5C3
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 19:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790105656; cv=none; b=cqJ7Kzj80JaG30tMULQfACuHSP9tq54+BAyky0n2RbuhkuSCK86SMzGw3J2zej7qKvVEM+HYpLslM6bFDRoF9fKE/wA/HHfrIqBdr8igLmRsld1YYG5bZ4jNM2yFnsacrBFFOpUIkpjyQkdPoF8vKcjiukA58sBAMZDq9CRJXE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790105656; c=relaxed/simple;
	bh=yDBNrwWJwf5FhuRoCHjrQ6GFZcedsDXJbmWOSp8weaQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=E78gEUOXR3P1VcqPDXHLuKswpKAEu5uEit5HgOKtpW7hkkVx7jR45PZIlr1/tD2jSlM9edkAJ+NjgPcyzeeY38JqSYATsquCSy6mABRkvWWqb/sby1DF4nzOyH2j9WjVIbP6rwiSeCHF9QBL8xfssN9ar0OXW9b8VQx4UYI2jTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kaifengw.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k9O79WGC; arc=none smtp.client-ip=74.125.82.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kaifengw.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k9O79WGC"
Received: by mail-dy1-f200.google.com with SMTP id 5a478bee46e88-30bcb065bfdso186238eec.0
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 12:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790105654; x=1790710454; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ymirBoiEOHofxcXtdlpyBstNGlWIgIPDHZMqR8FvNhI=;
        b=k9O79WGCsYjMjCBaq9Lrj2bnUMOT98uiDyrS7Ylf2tgLlYmHhzQF0OGmiinaJ855/5
         2NrorTb5bBNywaER7DDZtTEaN3lqtwvhzW/1BsQBOmq/zxWifnwhx40cktn388lRN3q8
         5ZGlkkLoh/dHo5LHRiLjPk/wnKqcH/SOrCbBpcedcW0fOGYkrv6G1PCIuGkXZ/ilnF6/
         Hd6cDaMzeWtXloAz0dAyKQ8Z2frsYO2VflfaeIGCMZINUgiRynGAIsT0tpY4dcw17DE/
         ihmnurFY1NXONSlt4mI4WZYgFgpWkcnpMW0k68m18z+5JEkNbCdpspdxGd+qYEUoR8uf
         QeyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790105654; x=1790710454;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ymirBoiEOHofxcXtdlpyBstNGlWIgIPDHZMqR8FvNhI=;
        b=NR3VJ5FqPGppu3wJy5nlrZdaZQoh87udbwNi/N11fELhv14Ge//LGgPs7cY5uTcVYj
         ROTG7nRs0ThhvyKWCdZmLSX9lLA/+pUphiX75MJN9NxBFaO+5xCA3zCuFjQVSHv+DZmt
         Pso2wBfOcR77t3zjM46BFiSzFQZ0ISWcNazeYp6dz5ME0pQ0DQ2/wEWSCi+KBQHB4bMQ
         3hUiNPWJqYGBzYfc92C7jdlSUMuxGfOhIpAwvfiBJbcpitN2CgmxjXXKMinihuxMG70Z
         CjLeltYLkXfLzgwQrN8VF15QYuFbdktujUnHyKCHGXC3jZDc0aNpr2HJbkYcbsU/7+3v
         Hl9w==
X-Gm-Message-State: AFuF++lqypxlI8Z7HGI2zoghxaXzKLlck0TRRpxH9X/8f8lRZM0cHdEl
	uZV//vk2i03MfF8YdFrSJBu8pcpef80vIcP4PGsuxbwEMwg+H/hnQmfOuu4aAtQVh3CMzlD+L0u
	SWuxptkmv7+nS9K4Qpti73e7+5Zezq4avODICGG0rqNzqGAMF38cdGoQFYPfOECR2rkE3BXqhPO
	zRyKUs16x++W/KfhrQ4AYkezIy3lUzBCF73KdqhEhvYCjRLss=
X-Received: from dybvk2.prod.google.com ([2002:a05:7301:53c2:b0:339:69b7:3cf7])
 (user=kaifengw job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:7300:c01c:10b0:33b:fa29:4a66 with SMTP id 5a478bee46e88-33e8ddbcfc1mr273275eec.31.1790105653596;
 Tue, 22 Sep 2026 12:34:13 -0700 (PDT)
Date: Tue, 22 Sep 2026 19:33:56 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922193356.542922-1-kaifengw@google.com>
Subject: [PATCH net-next] net: devmem: use page_pool_put_netmem_bulk
From: Kaifeng Wang <kaifengw@google.com>
To: netdev@vger.kernel.org
Cc: almasrymina@google.com, edumazet@google.com, kuniyu@google.com, 
	pabeni@redhat.com, willemb@google.com, davem@davemloft.net, kuba@kernel.org, 
	horms@kernel.org, linux-kernel@vger.kernel.org, 
	Kaifeng Wang <kaifengw@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of looping over napi_pp_put_page() and repeatedly acquiring the
page_pool producer lock in sock_devmem_dontneed(), use
page_pool_put_netmem_bulk() to return the netmem references in batches.

This reduces the number of lock acquisitions on the page pool ring
producer lock when releasing user tokens.

Reviewed-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Kaifeng Wang <kaifengw@google.com>
---
 net/core/sock.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 2948dffcc3e1..a6b6d5b2051d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -129,6 +129,7 @@
 #include <net/request_sock.h>
 #include <net/sock.h>
 #include <net/proto_memory.h>
+#include <net/page_pool/types.h>
 #include <linux/net_tstamp.h>
 #include <net/xfrm.h>
 #include <linux/ipsec.h>
@@ -1086,7 +1087,7 @@ static int sock_reserve_memory(struct sock *sk, int bytes)
 static noinline_for_stack int
 sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
 {
-	unsigned int num_tokens, i, j, k, netmem_num = 0;
+	unsigned int num_tokens, i, j, netmem_num = 0;
 	struct dmabuf_token *tokens;
 	int ret = 0, num_frags = 0;
 	netmem_ref netmems[16];
@@ -1123,8 +1124,7 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
 			netmems[netmem_num++] = netmem;
 			if (netmem_num == ARRAY_SIZE(netmems)) {
 				xa_unlock_bh(&sk->sk_user_frags);
-				for (k = 0; k < netmem_num; k++)
-					WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
+				page_pool_put_netmem_bulk(netmems, ARRAY_SIZE(netmems));
 				netmem_num = 0;
 				xa_lock_bh(&sk->sk_user_frags);
 			}
@@ -1134,8 +1134,7 @@ sock_devmem_dontneed(struct sock *sk, sockptr_t optval, unsigned int optlen)
 
 frag_limit_reached:
 	xa_unlock_bh(&sk->sk_user_frags);
-	for (k = 0; k < netmem_num; k++)
-		WARN_ON_ONCE(!napi_pp_put_page(netmems[k]));
+	page_pool_put_netmem_bulk(netmems, netmem_num);
 
 	kvfree(tokens);
 	return ret;
-- 
2.55.0.1082.g2b9226bbc0-goog

