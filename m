Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CD0936165E;
	Mon, 11 May 2026 23:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778541973; cv=none; b=Mv9DT3LbtGEQNXzPb7++n2ExoBcKHltm2nEj73JQCUXYg9v4ip/yO1Jv42QrFk22eX8fsWfsTda5c+HQW/xblYR0+ZdB6q7rPCr1SWuYYOMr9sndWBgPpatoCtqmMSjpX6PmI7WYdsrPNQ1dXrNuNFfl0GTukRaw+lxqNCYFTlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778541973; c=relaxed/simple;
	bh=DqL6uPofn9idmowsKVrzUK3GE62KZpqxNGZKlu19M5Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WrydGg5qMLd0/JUkVcnt9vGUSjp6GLFaywHiNRV5V4nJeYYyi78i555Jbrr256vCm8HaipdIWacJJeXIZS+QLomfPhtS1oOiRgv1RgAG4BjJzyV8gL63Jfla1C0TiyAWgsTXXwpbn2WOfNMyqVSbL0KB1sUzpRIr/omsZimijqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rLBsF5+f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rLBsF5+f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86FCFC2BCFA;
	Mon, 11 May 2026 23:26:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778541973;
	bh=DqL6uPofn9idmowsKVrzUK3GE62KZpqxNGZKlu19M5Y=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=rLBsF5+ffyDD8OpeKgGOBmKGRKZq7VYBvDnBBujyZUqssvcGrU6a/aMnF6hvQyxOn
	 UhRA9FlkZR7nt/CddyhkvuJGN4ivPd/+Dv1IoYE8wasbc79sffhEZhOi/e7Hpb4wVA
	 vqJSv6fK00xwbbSbSotaNLXshykY4AXBCCnmYHGUKpP9YUGwZfGE5kz/KPuCBc3YRP
	 Z03iysJ6WjiQb8JRNsr1+ZNJsQCNd7PyOw4+KdCaVqNLM/0vyVQVIGxQrH/UpBeYQ/
	 GXgComenI1GJw1GdeTCj/o64NkF50ZvaQpL+y2lAQhbI0n3wDCpFlv5RZ82n0pVmug
	 Wxu496r0ruRSQ==
From: Chuck Lever <cel@kernel.org>
Date: Mon, 11 May 2026 19:25:53 -0400
Subject: [PATCH net-next v10 2/7] tls: Avoid evaluating freed skb in
 tls_sw_read_sock() loop
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260511-tls-read-sock-v10-2-279fc5015f0e@oracle.com>
References: <20260511-tls-read-sock-v10-0-279fc5015f0e@oracle.com>
In-Reply-To: <20260511-tls-read-sock-v10-0-279fc5015f0e@oracle.com>
To: John Fastabend <john.fastabend@gmail.com>, 
 Jakub Kicinski <kuba@kernel.org>, Sabrina Dubroca <sd@queasysnail.net>
Cc: Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>
X-Mailer: b4 0.16-dev-da966
X-Developer-Signature: v=1; a=openpgp-sha256; l=1578;
 i=chuck.lever@oracle.com; h=from:subject:message-id;
 bh=V+A07f3eUxHsiMHyt2z7EJUqubrbEIFHJzrrbNgnfbg=;
 b=owEBbQKS/ZANAwAKATNqszNvZn+XAcsmYgBqAmWRR1vUEWoye7cSB4MschKKBm3z/X3u0IRF/
 QOCRZJeKMSJAjMEAAEKAB0WIQQosuWwEobfJDzyPv4zarMzb2Z/lwUCagJlkQAKCRAzarMzb2Z/
 lxbsD/wPuzYVczfNhHre8YszpInywhpBAXL/7ZeaY4Yc0bG0Dy4uBc7x9GIp+PLuukbI4j9ifVv
 OHTiPVofBAFyhTqOAt9FxttzEPjk6tY4xbJ43C0o171Mcj3T6MTcXJ5rH4VwjB20xDSTabPmb5p
 ede3t1OuSgn2dVici9bKujr3NiZ6+j8gnfqXqUUTcjOjEvEfIS2IYDp1/AVnXiXT6HJkjLeITSa
 MV5iDA5hvs71dN2WMJdKF36Zd4kRjbc9QMBR3C8Rm7Ip3WPEneGjLnv8HvsdJg5mWrWG8qZXh1v
 ahLLLIJgJ7WK1CnHEoPEtCirVpDtSrmtLpj5KwOTD7vbT1t3AOqoUfE4nE8y2Q88jZdVG3+9On8
 pq/b/yhv0CeZNjQbwXMWwFxch5I9ONUkz3OhlfvE+YdnLP1sWV95Pwm0P0yWCHA6OecveSQSD//
 FxNRMg5hGRHajJFg4vx/CPUvz3Toh2Rb3cySxqNpL3CssLwMTY3c/n05XWhNaitXOqwudPOw0/F
 Sb6NwkzEO6C/kvsMsEscasbBeQHUA7GVdIv11SgA1Fh0WYPIakWkxOHE0EqDD1xrAZrxHmWVGzo
 1GZmFAuGuynz/JkwObh9whLSxIXzTPo/fJIblLgg+6CBrLA313pJ6d+DW6n2mo0qK1GaQARCCU1
 BdPDZSQK9A6BYTw==
X-Developer-Key: i=chuck.lever@oracle.com; a=openpgp;
 fpr=28B2E5B01286DF243CF23EFE336AB3336F667F97

From: Chuck Lever <chuck.lever@oracle.com>

tls_sw_read_sock() ends its receive loop with while (skb), but
the else branch in the body calls consume_skb(skb) before the
predicate is re-evaluated. A pointer becomes indeterminate when
the object it points to reaches end-of-lifetime (C2011 6.2.4p2),
and using an indeterminate value is undefined behavior (Annex
J.2). The pointer is not dereferenced today -- the predicate
either exits the loop or skb is overwritten at the top of the
next iteration -- but any future change that adds a dereference
between consume_skb() and the predicate would silently introduce
a use-after-free.

Replace the do/while form with an explicit for(;;) loop so
termination happens through a break statement rather than
predicate evaluation of a freed pointer.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 net/tls/tls_sw.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/tls/tls_sw.c b/net/tls/tls_sw.c
index f607ccccb232..559bef05fee4 100644
--- a/net/tls/tls_sw.c
+++ b/net/tls/tls_sw.c
@@ -2366,7 +2366,7 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		goto read_sock_end;
 
 	decrypted = 0;
-	do {
+	for (;;) {
 		if (!skb_queue_empty(&ctx->rx_list)) {
 			skb = __skb_dequeue(&ctx->rx_list);
 			rxm = strp_msg(skb);
@@ -2416,9 +2416,9 @@ int tls_sw_read_sock(struct sock *sk, read_descriptor_t *desc,
 		} else {
 			consume_skb(skb);
 			if (!desc->count)
-				skb = NULL;
+				break;
 		}
-	} while (skb);
+	}
 
 read_sock_end:
 	tls_rx_reader_release(sk, ctx);

-- 
2.54.0

