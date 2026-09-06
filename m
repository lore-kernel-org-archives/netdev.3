Received: from oss.cyber.gouv.fr (oss.cyber.gouv.fr [51.159.188.251])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7163C062A;
	Sun,  6 Sep 2026 21:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=51.159.188.251
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788729280; cv=none; b=o5SKtvz811w2L1oEX/0PQWrXQyaEiFEq8EFAhzaHs9fP6wL7mMfRhxPpYoYt7kXr2A6Usrnw03D2OxWzjG3ujjZNNdzc2/LrVLV2urQb6k7McJRJGwRMVvCYBuziMTcujzuu1cA9I/UfccHStmJFh/gzBEFUgwBgmdFdg/61T64=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788729280; c=relaxed/simple;
	bh=8tNgnoL4lXTELZ64pjtu+GZn0RIvP8Nw9XXfkkL2ZS4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HRkASIklYp53IukvXMTw2pO7CRx7idGAEpTJHpq0vwUk/JdhEIVCxejMiM14QnNz0WHm55t1GfQZ7EezBQtToHi60yqAFpi0y6nouUvxjxcW+XAods064P5i98WJEL66S0KcaUmX+2e4RgE+/qemwiz+HXclXMrj2Mla69UmjS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr; spf=pass smtp.mailfrom=oss.cyber.gouv.fr; dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b=EyPIRlDv; arc=none smtp.client-ip=51.159.188.251
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.cyber.gouv.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oss.cyber.gouv.fr header.i=@oss.cyber.gouv.fr header.b="EyPIRlDv"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=oss.cyber.gouv.fr; s=default; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=bT9WYmX9w/E30G1jqrOA0X1Y7ZYi1YOE/L9fRG4SJAg=; b=EyPIRlDvEsqQA1V6P16Akqqibm
	sQBkP3I2zdSJFZmIYN2+LUlO8cxU1kHvr2O2zy5BzfqR0kOrlwQVIfvTvLdc0oMuwbNMS/nhhLENb
	34m+xRVjnHI1Ud3ZoElmNAN0eDhi33jgp3N7LG1Jnw1n+YAMRJ8BMsiNnrWueK5Pj8jySfa25eY6s
	F+wRvJGJ2WrkrMe1SvhRF3RgfZFTTl/Z4Zpj19uDOFguethGNf1IGZZmzarePnHTLid70xUl9h7Lo
	/CXLTANAT0kqVGjVERNtEs/PHzTeAbywL/dWNigE8oGv1+G3xXfuZOCpP0c7aiX7eV8y1/2SS4WxK
	wnTWTsZg==;
Received: from [151.115.150.205] (port=53132 helo=gepetto..)
	by pf-012.whm.fr-par.scw.cloud with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.99.5)
	(envelope-from <Jeremy.Jean@oss.cyber.gouv.fr>)
	id 1x3KC6-00000008LBi-1vbA;
	Sun, 06 Sep 2026 23:14:30 +0200
From: =?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?J=C3=A9r=C3=A9my=20Jean?= <Jeremy.Jean@oss.cyber.gouv.fr>
Subject: [PATCH] udp_tunnel: avoid calling the wrong GRO handler
Date: Sun,  6 Sep 2026 21:13:52 +0000
Message-ID: <20260906211351.1272699-2-Jeremy.Jean@oss.cyber.gouv.fr>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - pf-012.whm.fr-par.scw.cloud
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - oss.cyber.gouv.fr
X-Get-Message-Sender-Via: pf-012.whm.fr-par.scw.cloud: authenticated_id: jeremy.jean@oss.cyber.gouv.fr
X-Authenticated-Sender: pf-012.whm.fr-par.scw.cloud: jeremy.jean@oss.cyber.gouv.fr
X-Source: 
X-Source-Args: 
X-Source-Dir: 

setup_udp_tunnel_sock() installs the GRO handlers before updating the
global static call. The socket is already bound, so packets can arrive
while the static call still points to the handler for another tunnel
type. Receive and completion can then parse the packet differently,
leading to OOB write.

Removing the static call is enough since the existing fallback already
calls the handler selected during setup through call_gro_receive_sk().
The helper also performs the same recursion check and sets the flush
flag when the limit is reached.

Fixes: 5d7f5b2f6b93 ("udp_tunnel: use static call for GRO hooks when possible")
Assisted-by: Codex:gpt-6
Signed-off-by: Jérémy Jean <Jeremy.Jean@oss.cyber.gouv.fr>
---
 net/ipv4/udp_offload.c | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index cf07c3c..30649f4 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -148,13 +148,6 @@ static struct sk_buff *udp_tunnel_gro_rcv(struct sock *sk,
 					  struct list_head *head,
 					  struct sk_buff *skb)
 {
-	if (static_branch_likely(&udp_tunnel_static_call)) {
-		if (unlikely(gro_recursion_inc_test(skb))) {
-			NAPI_GRO_CB(skb)->flush |= 1;
-			return NULL;
-		}
-		return static_call(udp_tunnel_gro_rcv)(sk, head, skb);
-	}
 	return call_gro_receive_sk(udp_sk(sk)->gro_receive, sk, head, skb);
 }
 
-- 
2.47.3

