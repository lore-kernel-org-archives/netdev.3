Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793144990;
	b=U/aigL75L7KSWi9svQPS8AsMyMBFdrZzW91n8IrvkfsKfhREF0MM6sxAXeRdi/LWwCFT
	 JEth1KzsvkkaGCeujC/Q1I3/EDKuIRPx7A/PVAa2l/tFCDgKI1TV+lcqQ3G/a9gtQa59v
	 nWjz1ZEgFw9EXKBSED8rFe9tJ3So3aEtgbHLS/uu4RtOp9r4+ZHOy4DjNUUZodN6GB+hs
	 209/s5eGkPSCUgvFvR90hdO0pd/50udzZVBS7odtU8L6/tGocW8U9E1XDg+HUR1UZoWIP
	 DW7pvEzYu6x50wDEj0vBmBrixTTkR1LrAEt5snpgfTZKXQ8OKsyf+FBRbWynKcgWThQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793144990;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=ZiN1Jcj+ktTvoPoRBYi951JEE+IUEKCrPjtVRKMqDd0=;
	b=TFd0bRBw/DcKRvFm0nqCBevZtlrgusyonZ+U9nhpGBMxPKEcaK/nBpfzQ6f1fxjXDCML
	 ZrDR2nevupv5y1B2teUJ0nzQhTM6pZWdJuDsL2VqdnxaBuU3SPT4TQBwvp0of4JME5B3r
	 7dH7ZWqkCsun/kmXyirZWK01OPcCCfoIZNCyS+5YYYN+lwxa8xrz+F1kZ02WEoGwGRluS
	 vF28+ijuG9bBPH+hJJ9KwIMcTpTHgYtd7H6KSNqnKfyPVxg1ROcU1g5cLYYWzauP0UItD
	 5ah6xQGwoh6ViUfThLsnC0evsE7gFTFHt7BEe6/lH5KSlWNLRi/0HPM8L2ZRDog/gAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k3W5GY0v;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC2E0606A325
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 23:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k3W5GY0v
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A021F01829;
	Tue, 27 Oct 2026 23:49:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793144989;
	bh=ZiN1Jcj+ktTvoPoRBYi951JEE+IUEKCrPjtVRKMqDd0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k3W5GY0voABaKWsMr6B/0d6LGM2c5IKPrFGR1vSQVK2Tjwa8YoeE2UKj2aUDYVcRS
	 3d6cKt2bbO4DKF/s9jbrFKig2dtR/LuvF5y31/ssN632C5VXCcmAedim21oNlg+BdJ
	 q+BD+gb3SbARNUYWjKBCrUTRcRNs/fp3OOzMCgbeZik0xRCot2IsFVeA1AuMfPqJW8
	 eG3gfslG0yTelATgiNPT3p19bXBfX9zrokmuqFDJBkXQG2+o5dIALe7as+6SZ90hKJ
	 FjPlv15XfVunWHvMvwWeN8uLNp7gef8L7bETDoVWzp526kBxaBLemb+g4qiHnbzYtD
	 EDp8JGT2di1OQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	eddie.wai@broadcom.com,
	prashant@broadcom.com,
	huangjw@broadcom.com,
	gospo@broadcom.com,
	brett.creeley@amd.com,
	ap420073@gmail.com,
	joe@dama.to,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net 4/5] eth: bnxt: free XDP frags when xdp_do_redirect() fails
Date: Tue, 27 Oct 2026 16:49:39 -0700
Message-ID: <20261027234940.1267225-5-kuba@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261027234940.1267225-1-kuba@kernel.org>
References: <20261027234940.1267225-1-kuba@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When xdp_do_redirect() fails bnxt_rx_xdp() recycles the head page but
not the frags of a multi-buffer frame. Their agg ring slots have
already been refilled, so the pages leak, and the page pool can't be
destroyed until they are returned, which will never happen. Redirect
to an AF_XDP socket in copy mode fails this way with -ENOMEM whenever
the socket's fill ring runs out of buffers.
A socket bound without XDP_USE_SG also fails with -ENOSPC for every
frame that doesn't fit in a single chunk.

All the other drop paths in this function free the frags.

Pointed out in LLM review of the first patch of the series.
Tested on a BCM57504 at MTU 9000 by redirecting 60k 8000B ICMPv6
echo requests (a head and two agg buffers each) to lo, which can't
transmit XDP frames. The page pools' inflight count stayed flat
rather than growing by two pages per frame.

Fixes: a7559bc8c17c ("bnxt: support transmit and free of aggregation buffers")
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
index 96845c8646e0..161e0dd62be6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_xdp.c
@@ -307,6 +307,7 @@ bool bnxt_rx_xdp(struct bnxt *bp, struct bnxt_rx_ring_info *rxr, u16 cons,
 
 		if (xdp_do_redirect(bp->dev, xdp, xdp_prog)) {
 			trace_xdp_exception(bp->dev, xdp_prog, act);
+			bnxt_xdp_buff_frags_free(rxr, xdp);
 			page_pool_recycle_direct(rxr->page_pool, page);
 			return true;
 		}
-- 
2.56.0

