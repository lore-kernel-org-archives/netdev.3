Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793446902;
	b=UDSh+AUWkTYvzXE1N30Txs8QepiTbUELFc0ouTh6npMiOjaoZjY3iMO6pfYhDweqQSSq
	 ku5K5W+mtpzShw2ztrEKdZDVDplvazXRPAmdUrDk4VkwiRP1sAIKrvTpzv4yHnJ5z34TA
	 7tqrDfe+orDi130DcwFjY+RxWd42J/ZEWXjGlstBNbL62l1VZvXIsV6nMxNBn39wbjmKu
	 pDYtHPXcx9KTjXOfvHNcz3lDXczest4/0LnEn+XLnayCpT5AwZ/BYyTYWTDfHGPmwldFP
	 Z2aiGYiqmqQJb2hEiE13vRtUfmoWZPwO4wsSp5xdh5yyUSEEa1OvWsaAXF/uJHusLTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793446902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=0HkCg/YnWhbYWbYZDdGBQDEn6UPPXchTb+/3lfwZnMw=;
	b=pQU+LEoViID2F6lCFX4HmmPIdegqrTsfvOdIsSNi6dXp7K1q516xOr1QZFLCVoG8Fbpv
	 nfDmGGTSLSJom+EFwflhfNAzkikLms4kGvCLslwx8+Au1QtzblWyq1B7gBzs/l96X6fRf
	 iRfjn7bvi7As/Qf4qpf01GTLsNm9gio/b34B5O5M9LDFMCLoWnSOWOQq+mPgOLo69Xj5u
	 /wi71GHLX7yrqD4VLxwSk5Y8XBrQju3IQjiVLmZEatoAkwZvx9AP6IX6qjkOM/txsfAHJ
	 FPZldkBGXCHVs034npOXPC9aPM6CD8PoFr2G1lQjzkO5jDA3vJ/OJIKpq85q+ro6r/A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bc7cToZg;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF498606A31C
	for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 11:41:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AF498606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bc7cToZg
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-48e10a70540so934206f8f.1
        for <netdev@vger.kernel.org>; Sat, 31 Oct 2026 04:41:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793446900; x=1794051700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=0HkCg/YnWhbYWbYZDdGBQDEn6UPPXchTb+/3lfwZnMw=;
        b=bc7cToZgfB/Q8+JCX7UfRYI01UsXNH6dckTKhXALoMqVL0aew2sCiwm3Pf8SGpFjU6
         nlfpsGUd/22Jy7FWHT6+N1uMEdziUhvZaA7kymyGcQuA10kBUKqiVNeQRi9WonYjy3WK
         ZOmkBXd3Cadq1eY0qMWgo/SvHSmhjEHgjqzYpo1fWl5apOYSZAWExbIgkh0OvObebeVE
         V8OFSsFZY7AnHQmxxCqQqh3frj+D8sNj6uoXea27l0cKmB9pjh5+9RwyJRVTPUQXcNG7
         gY4a06HXUITjRq3bYw+vcg6biXxvDbgrHM0y31ATwuQ9cUkl9/+zaDAZI0X+ykG9x8vD
         /axw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793446900; x=1794051700;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0HkCg/YnWhbYWbYZDdGBQDEn6UPPXchTb+/3lfwZnMw=;
        b=lyVoCKffEDReZYWCF2MXYEjm8TMasbAJQ3wA0gXujATfiPMhWvuL4ai1T6swDIxrqL
         Kla6f5h6is7R4mY0vcWRxY0v8nQ3bWFxqdy5K/S1HpccHj7mGMDZrvHOF/eeEYRx8qN9
         26DvHLWG78hpKRLsw5RdZViOFyV+Gt714fvuCtJYcyaDJlbK7voyGNsZBD22GXa2RNcF
         li17W3+/Q51+/XmFo237veGAnniPe34n1lSe/5E/HXusxjM43XCw+gcZ17f021EdzbGW
         8QYnPGoT5nrz+G3ODXb31dAaCbuPC2QCsvFxxmXKUC1cB1UHcCWpe+XmvMqxR7zC/3oc
         yckw==
X-Gm-Message-State: AFq9FYJPWsJU8H3L1aKJvy1riCpyZlJBgvYW4vmEGNTeI63Q67XYMxq4
	WvccIFQs8Kh9uEt85SLpQLyezuBHGRuv/bsnbHcDT5/CavxIKRtJHqq1fIqfupa1lpIYRg==
X-Gm-Gg: AYBFou0TQJvNZfCxdMJH4zHK+Lg1tHavmUVPL2VpIHzytI7BSWJKdSNsJvqvSl4AGH7
	kx3CO2aN3qVrEaBfu6vgSPJcC66t50ZLqsFK9EYmIeOPsAOJsP1xVprmYSTiiXzSoDTAON3zAE2
	Fn7cGITs0XtFuo3kSDMMe4LHp9A5+mdx6y4l1YCS1K0h1LQkhtbNmrR/SY/D3GNvQHbPqWaFbsO
	pX4+t9wIb3QZPB2ZC3pCBihLKj+FialxnhKxxdxSZ0LddxTnGVDxjt8yFlI753gC3hCEgyCu6yb
	Skw8Yp6GEugDwy5wjcFCBlepGf+Nyzod0E3zGAyWuhf8Ju2wORaZU0cYH8PLJe9XJkg97LfhCfS
	gEu5H/Ad1WzO2+0nDgLFJhQIslVpo3mv433qplQGP/ZT7V3bT6zp2eDIGdFx/eQky5kIyJeXvQN
	nlXgGn5N2QG8uM+v60bhbtj7iPY7r2q3v1Z6fn18FdMuHCY9CbpCHAj0EYsoC81pksJ6Mc2Cfw2
	XbdmwHkm2tB6OsroT3MLNB3Y6WQnfRtQWLB0U2ijve3Be42HLTQ1vaUqcBUzra+5LtNX6y0iJX0
	uSMMgkA9n59xD/aA6kbM8gNb4FVz12Lb/FI7zit5wVoS
X-Received: by 2002:a05:6000:40cc:b0:48e:5ea7:b1b9 with SMTP id ffacd0b85a97d-48e6e30543fmr12313595f8f.31.1793446900015;
        Sat, 31 Oct 2026 04:41:40 -0700 (PDT)
Received: from localhost.localdomain ([2a06:c701:4773:6f00:c8d4:ec29:293e:f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71b78a4csm8353081f8f.23.2026.10.31.04.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 04:41:39 -0700 (PDT)
From: Avi Weiss <thnkslprpt@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jason Xing <kerneljasonxing@gmail.com>,
	Willem de Bruijn <willemb@google.com>,
	Mina Almasry <almasrymina@google.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	John Hurley <john.hurley@netronome.com>,
	Cong Wang <xiyou.wangcong@gmail.com>,
	linux-kernel@vger.kernel.org,
	Avi Weiss <thnkslprpt@gmail.com>
Subject: [PATCH net] net: skbuff: reject zero MPLS TTL before decrementing
Date: Sat, 31 Oct 2026 13:41:35 +0200
Message-ID: <20261031114135.3784868-2-thnkslprpt@gmail.com>
X-Mailer: git-send-email 2.43.0
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

skb_mpls_dec_ttl() decrements the u8 TTL before checking whether it
expired. An incoming TTL of zero wraps to 255, causing the TC MPLS
dec_ttl action to pass an expired packet instead of dropping it.

Reject a zero TTL before the decrement while preserving the existing
behavior for TTL one and valid TTL values.

Fixes: 2a2ea50870ba ("net: sched: add mpls manipulation actions to TC")
Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 48f676411724..9b057cc9cbd3 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6858,7 +6858,7 @@ int skb_mpls_dec_ttl(struct sk_buff *skb)
 
 	lse = be32_to_cpu(mpls_hdr(skb)->label_stack_entry);
 	ttl = (lse & MPLS_LS_TTL_MASK) >> MPLS_LS_TTL_SHIFT;
-	if (!--ttl)
+	if (!ttl || !--ttl)
 		return -EINVAL;
 
 	lse &= ~MPLS_LS_TTL_MASK;
-- 
2.43.0

