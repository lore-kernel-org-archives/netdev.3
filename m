Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793973554;
	b=xLKrMdUz0pgO2eqs5C/oj9USi0fwjRr4xrM0wfF6bKhlAPh8J/f10bPTYnUmxzxyTXcy
	 20U9/p5ur/6eEonea620n5o4RMIw6anrZ3IeXy6AuIJytE18xW6L98L7EgNSoBGbJhtBx
	 XowKqLlcvqgPro1gwv+n+M9w3nIZJQWq1QfNY4LCe/3HlO33sTZhRTrzNuiEtFXoKjvQp
	 iLP+WZ1rl4Lw0xYkwjKan877vsjr///+ObiC/fthi0/y0iz0GJI5gZeDB6Da5EW110LY/
	 o0Xk/5uHNKDmtXTHptiEpzCDk/m9rjXVz6rVmlAnntneZV1/og+P1jVwK2ZTi1B0GOA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793973554;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=fdyWAktPoh7yf4BNuSuBcGMtWgBKcjHGM1gjgcFt1EY=;
	b=KA3oRjhB1n69QX6t/tTvu/41uAUf0T09H4UpVNgTgMnm3n68rSGWfyPntNNsqqa+UJ3l
	 aH2q+JgJ1e4CxOy9t+lBE+UUZBHLqB94+h5rwBHLmexIGqQiaYaDIXiS4jbkMUR176WXM
	 PrChB6nrMvilKLIp2KjwgdP78XYre5wmsBnpKV9ONNyHcHt6flEHuuCdHKxHS/06Mens9
	 Sm5/K97asc6ORX6cOVeDfP5zdzFYmBQ1colPLDwyiQ8YVE004hk4MUn/OWNlynJ+av2zL
	 xPRJOLmPTPmx9dIYfqC3mxIP3DHthsigvMp6x2WNUxy1rkhXATNoq1rkimWgckxgjFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P72btyHj;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9455606EEAA
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 13:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9455606EEAA
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=P72btyHj
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e8f2c3ad6bso3583495ad.1
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 05:59:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793973553; x=1794578353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fdyWAktPoh7yf4BNuSuBcGMtWgBKcjHGM1gjgcFt1EY=;
        b=P72btyHjY0jWhATyUuntFPnCjQYvQyZl6CAC83+e1eJuLGmmk7Srn9vgLectTb7NwS
         SkjrxMTYbyIkZH1OX9DoDc0jA57Mir0CQ7WrD90TidWTpgD6p/gwTrVFFlxtC0+6PYkF
         swJ3gb2skQPh3jakrbqwFmrYeNOQ08vL2/HS9ib3W2KuLGakO5w5iDpt7u9ISs34WWC1
         4sutvtlrtkR7hlYys/VMaFkUgpIikUYS3oLKM1fSOY2OCUp9MqYI3m/Fhtff1hXOSO/d
         tIr+Bda7xassy/dF+LT7We+g6DFiq0/g/6MV4zsyEQAF1jpiEPZsIiku+lL8KaDmdFOS
         OWSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793973553; x=1794578353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fdyWAktPoh7yf4BNuSuBcGMtWgBKcjHGM1gjgcFt1EY=;
        b=HRjGltZkK8JWwFw1E3kMPbJkOpnZs1WrTWcEV4KxZ57Dew1SsMj6kk0a5pB3JDNNCT
         SVSI1pHIogarjCBp6PFAYxF3c0XIbCKsHuyxgsa1TBV+8UrYMoq0mUvE9WtqPnB3/Sce
         aMY35HBr5PQIO2kxqn/dEYFWjoRljFWfaaxqjawb9jqbE+5TP6LgE8SRgRFp5ZmpaYAm
         tIWgLzB5LMrDu41SQCMOEFd0rwrrxpEcvmp4HhHteR34araBRlofUWVFQprFtjq3qjce
         JBDeN8XKvjj4q5rFvFL9JyBH0VQyJFG2erlJFPc7VE25880uF2O68rlqNyWKfA1huAHu
         Abew==
X-Forwarded-Encrypted: i=1; AL+hErE+YK5AlHwvpQjTklglsEaz/f2ro3Zw8aUDh4tSaTu7+KlzcoMlXKFBPo5ypmDZURAAUP1cXDQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z/HVJpNTuBTKvX8/aSeDjX4Wfz9gyYkuj51tlwCtXxxTXPtN7ZO
	sfZsBuPsCVpLhISCOJ32uG51NDeOdwHUFkKpQQRNTBPrIw7vtqjsTy3/
X-Gm-Gg: AYBFou05KA8h/0FvveL0TmAb5u9Mj9LJxF+9aslIVPCrK4R+kypbbcNtOvy1cEEq9Kz
	7DjfclDCLhX0+cBpyI+Hs6zYr/+5vmqhcRl694On/uSWazA1DpRH8LjhEQxcAYC7kTztBU/zGKq
	helCdpi9l9skdETACaZabuBjy4Lu8DVj4hbqnmUtr4Hz/FDjtDDUypsfYMkE65nHAzDWPaEMiwJ
	9wP2daHqJnWUFIPnB0A/SKXSkrCKT32S3lUbBHL8tXtbr+osETwVRNBedo/YjYz4CCs/EV2/U62
	ODtzmOKCIPH19OXTG6+1WuuJDZCkfwRoVH9fBY7P17hoHYJFNYWqZRiw24mnWaHcjTXwmgM8jwU
	yerPNwZmqVfVY7fClDSzgdx91hDH5JMAE2m+6pc1ChY/Yg8rSuTzKy8LvsHlgv7141Hyu2gyTzi
	S1yM6UshxarQf16+vtQ6hVoL1r+i72isqOCfD+E+a3tNs7xXvA7yoVFW2ctutIATTfg7HJPuBGP
	kSHBpZ/JiVA0T2n3S6+xuM/K+TlWisyw8TUPn3U1H4ArcITQ8yRo2Yycat+YqzGeK5nq65zEmfF
	rB4vE4qAlu8mg5G4gGT5zZLNNCrL+lbf1xyL4OieiryKaEPEk4NhqGRF+4qGuXhaKzC8dJWpQ2A
	xRiJsLcx0Od7Nxw==
X-Received: by 2002:a17:903:2ecd:b0:2e9:7e90:8a3 with SMTP id d9443c01a7336-2ed41bfc38fmr34706695ad.39.1793973552850;
        Fri, 06 Nov 2026 05:59:12 -0800 (PST)
Received: from JIAPENGLIN-MC0.tencent.com ([112.97.59.166])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47d40998sm5634145ad.34.2026.11.06.05.59.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 05:59:12 -0800 (PST)
From: Lin Jiapeng <ljp1205831794@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Martin KaFai Lau <kafai@fb.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Lin Jiapeng <ljp1205831794@gmail.com>,
	TencentOS Corvus AI <corvus@tencent.com>,
	stable@vger.kernel.org,
	Lin Jiapeng <jiapenglin@tencent.com>
Subject: [PATCH net] net: reuseport: avoid duplicate closed socket insertion
Date: Fri,  6 Nov 2026 21:58:38 +0800
Message-ID: <20261106135841.418-1-ljp1205831794@gmail.com>
X-Mailer: git-send-email 2.55.0
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

Clearing SO_REUSEPORT on a TCP listener clears sk_reuseport but leaves
sk_reuseport_cb attached to its reuseport group. A subsequent listen()
does not put the socket back into the listening section because
inet_hash() checks sk_reuseport. However, inet_unhash() checks
sk_reuseport_cb and calls reuseport_stop_listen_sock().

With request migration enabled, reuseport_stop_listen_sock() ignores
whether __reuseport_detach_sock() actually removed the socket from the
listening section and unconditionally appends it to the closed section.
Repeated connect(AF_UNSPEC)/listen() cycles therefore insert the same
socket until num_closed_socks exceeds max_socks. The next insertion
writes before socks[], overlapping prog on x86-64 and leading to type
confusion when a reuseport program is attached or detached.

Only insert the socket into the closed section when it was actually
removed from the listening section. A socket that was not rehashed as a
listener is already represented in the closed section, so leaving it
there preserves request migration semantics and prevents duplicate
entries and the resulting negative array indices.

Fixes: 333bb73f620e1 ("tcp: Keep TCP_CLOSE sockets in the reuseport group.")
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Cc: stable@vger.kernel.org
Signed-off-by: Lin Jiapeng <jiapenglin@tencent.com>
---
 net/core/sock_reuseport.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sock_reuseport.c b/net/core/sock_reuseport.c
index fccbdd0430b0..775f446516c3 100644
--- a/net/core/sock_reuseport.c
+++ b/net/core/sock_reuseport.c
@@ -480,8 +480,8 @@ void reuseport_stop_listen_sock(struct sock *sk)
 			 */
 			bpf_sk_reuseport_detach(sk);
 
-			__reuseport_detach_sock(sk, reuse);
-			__reuseport_add_closed_sock(sk, reuse);
+			if (__reuseport_detach_sock(sk, reuse))
+				__reuseport_add_closed_sock(sk, reuse);
 
 			spin_unlock_bh(&reuseport_lock);
 			return;
-- 
2.55.0

