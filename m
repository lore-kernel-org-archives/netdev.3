Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793604111;
	b=NnxdWWU0rK08cJbEm4RmjV0ShRq18XuF8va0j0h1UlUXmrHwMAxRdFkpVAda+YryJBmx
	 Ug9PV8ZrWEdU1D0jRBT6cCIr/tBo4o/DrZ7X7mZvObtTCVTtfwjCU1WdcdIGUAtZmPUlK
	 whDV0QTREuAwHerH6Sg9oiQIW0p9H5pQjvpEPRFcIKwPY8m4+bv44MRmRYjQ+xu+qPqSs
	 wW/dj5bWz7sE55xcSUXiqe/A/fIDaXNdkqVnDeJrM5/KPpEwy3mqR7iBMjJ5e7IJfT7+y
	 zii2MaX2uUnHWihUc3bf0uUo1E3Qiycw0q1dg8m2MCp5Wn46oXFVl77RhO5iQz7Zy0g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793604111;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0ivwDO8RmSZboOluSZSZngxFUW4tZlFEXHx0gIyw2xc=;
	b=pNrZPL06rY01CVz2hWExAIj1ApOEmzLx0S4mrV3cYDhbkNB+nPyDlueSh2uV8P51WJu1
	 ccGMWAJqyrZy4OmMsOq6WE0YpATICjGotFCFXR1Nbj1s3imnqWdpRUV7R03rDOOph2lJl
	 sKZdA+idI5iwkPnENX9vs3Yva8W8/wHhEIfdHwXYZM5zz2tvpt4aCSdBqPbiBEoPP/gKY
	 2N07gIA1Ds4vR0m0gzEodyKzO/8v+cBAeNsjeGnyHLYPVbjpG4dpFsG4hOhjPwYda5mZY
	 zztm4HtRexoqPxCXXY0um44aE7cLfQrftOb84nJZI5O2WhVtVsbJJm+IdqO7tiiHfAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GFg87Apd;
	arc=none smtp.remote-ip=209.85.214.177
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF21A606A32C
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 07:21:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CF21A606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GFg87Apd
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2e985106c0cso25217795ad.2
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 23:21:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793604110; x=1794208910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0ivwDO8RmSZboOluSZSZngxFUW4tZlFEXHx0gIyw2xc=;
        b=GFg87ApdBn73TJ86NfBoPT9YgutNodcefQFgQRBOIe3MMSo/u+i6WYibbpy+LyKgI3
         Jl6Vd8cphaUlw22wVDB8SC3RyFT07Xoaz2rb0/9R6BcnfWQERLIV6pWSOjdpwj4/B9mc
         UA+2iAUXxx0nF5RaI2Op/ijrGF6E9qgHYCa9Fn8wgWhC6ZBa0vfhfMcKCVrAuX4ba/Wl
         ehrOpfAjgpkO7frM4hKubRuSDKJ4kLPQDfyECUleSoGzZhLiHKBBldXPtAthe2hKblbJ
         b6LsjopF98PuJBaof0/BDf3WuuWRUXBmJhEQEuvyjyGd+gYp3joD3f28IY4PgUS76/VV
         I82A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793604110; x=1794208910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0ivwDO8RmSZboOluSZSZngxFUW4tZlFEXHx0gIyw2xc=;
        b=NgzpLgGuLLUcp9GQvmyTkOxtdJXlm3wODYtZ8j3q9ZRMesaR54KFQITfOPyMMcp4VR
         tamWe9U+4beBcT3N49U/jVDcWUM47CWA4c4Ml3e48rUR2Tg+CB1HKfloEvFbYC2HCiiB
         s3+ZWvN/E75JRaS1D7Ja3X5gRKQveRlPNG66mOIRtCpK/iKwaxKOtzGKJQnJ7w0x844m
         l0E1hiecB+x8/j7zadVEtk9oFNh5xnPGBn9GwHMI0xb8Sbokoy5IUS+wLc8KAj8BSyUM
         wTC5OkVvYC3fpFG5AF+CKB6T9w0fE8biJ+yaATmW2gxW/DVvtA1uS8Gln4MRy5d2WJpR
         GBKA==
X-Forwarded-Encrypted: i=1; AKwUvBzKSZZCeZZ1bPgad2MI86HWgJLRR+ti1SB27kGbEAiBVgec+fZ9NdHNFLSYU4dWCsMSp9NxCkE=@vger.kernel.org
X-Gm-Message-State: APuU4Z9HjWIv56Qv1/RXpb81bs5U5WV+1V9jpeVG/pQGywLrZuwR7k61
	WsHVUjFvWFKeNlef19GT1iLHKppFE/qIbRHKgeVwsljyeG9VRV/xt0Bu
X-Gm-Gg: AYBFou217PMdPMohtKSwL/uVIdfT/exqPZ0NiXfSHtH5/w+VAcSheF/ArxKVVPc/1k/
	bjlnFRGy6lRxAvyiXAEBPOlCdwLvYoAU9SYczA1WG4laTceQuJCFLzkROgyXvb+bbAhBrgyrN6f
	GqNPN+ZqzGjZGzFUXaivM1nDNwwmH8uZQRLzhqb+Lrl+XUcwRMWZx/ndDv5ZeK+U0HeLUfsqkuy
	YPw6/b5p8/knK7n1irVXUw3kIHIWWg7JS23GpGFanG1lHpWY0yXnyIMVT3x77aWbHTHDt0mo8n7
	yQ4WUfXgRJAxn+EvZJD64mg3/c8IAS790bXq9rOub1kmKNuE26scTRl05Oa1bs4wC+ECdT8dlhn
	MJEZ2WWrP2Qu848t7OR5QgXrmWGtjtb72p6CxF3+mI34iv2zaMWBzhiH9Y8x0IfwFU7+gCY7GNT
	P2pG5+qsmUiaPJz89g/mgL7a6Tz6fnWHKXosttPyFk72+meOQpO49smfhVWpXh4645qnNXcw5l3
	y0ALSh5UE2fZx384uUDB3ucGHNlTfm6BillmdK9QoAtAFNr27VBlXZ3vndFR8m6M8CXcxYH+xF0
	waAENiaZ1yk/gJ/dVmBLFX302MydVSDpqvlW/hjsNOrLtxqzRlayA7qA8WQl0oGeBK/zMPFPOWf
	eTl1+/YlOL2BS/AP1+AbSmp95JWa3+lbknq+oXFTL4Qbj3VbQbEp/J8+kF3JRxwC8L47qSA1mHw
	==
X-Received: by 2002:a17:902:fda7:b0:2e9:c569:7050 with SMTP id d9443c01a7336-2eb365116demr91088175ad.47.1793604109917;
        Sun, 01 Nov 2026 23:21:49 -0800 (PST)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.248])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2eb392ae546sm23619805ad.70.2026.11.01.23.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Nov 2026 23:21:48 -0800 (PST)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	john.fastabend@gmail.com,
	jakub@cloudflare.com,
	jiayuan.chen@linux.dev,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	kuniyu@google.com,
	willemb@google.com,
	matttbe@kernel.org,
	mptcp@lists.linux.dev,
	mason@kernel.org,
	josef@toxicpanda.com
Subject: [PATCH bpf v2 05/15] bpf, sockmap: Clear the resume state of a stopped psock
Date: Mon,  2 Nov 2026 07:21:02 +0000
Message-ID: <20261102072112.4160195-6-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
References: <20261102072112.4160195-1-alexei.starovoitov@gmail.com>
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

From: Josef Bacik <josef@toxicpanda.com>

sk_psock_backlog() passes the skbs of psock->ingress_skb to the socket of
the psock. When the socket has no room, the function saves the length and
offset of the remaining data in psock->work_state. A later run continues at
this offset and clears the state when the skb is complete.

sk_psock_skb_state() saves and clears the state, but only while
SK_PSOCK_TX_ENABLED is set. sk_psock_backlog() does not test this flag for
each skb. If the socket closes during the loop, sk_psock_stop() clears the
flag. The loop continues, but the state of the completed skb stays. The
loop uses this state for all subsequent skbs and sends only part of their
data. A closing socket may lose the end of a stream, but not the middle.

The state belongs to the skb at the head of ingress_skb. Always clear the
state when this skb is complete. A stopped psock still saves no new state.

Fixes: 3b4f14b79428 ("bpf, sockmap: fix duplicated data transmission")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/skmsg.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index f03519468ad1..a5d498982848 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -664,7 +664,8 @@ static void sk_psock_skb_state(struct sk_psock *psock,
 			       int len, int off)
 {
 	spin_lock_bh(&psock->ingress_lock);
-	if (sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
+	/* No new state once the psock is stopped, but never keep an old one */
+	if (!len || sk_psock_test_state(psock, SK_PSOCK_TX_ENABLED)) {
 		state->len = len;
 		state->off = off;
 	}
-- 
2.55.0

