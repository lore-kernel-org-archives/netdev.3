Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF2247D920
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 13:53:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788789205; cv=none; b=hCB31LJYPiAgc3ZmuDpuc1wpnnqPe+XfSivnYczw2DmxMwEsynqWFl5syz3I76YUBbpVcgFL9TRjZ01tuuhx41JqLJKvJEAkyXxj5YmuLR4tB61ta6aGdtaglnMMpj0lqwYfmcbw6Os7W4Is2FeKfkLMR9QbBL/hV4yqNkEUG7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788789205; c=relaxed/simple;
	bh=47x1gmYS5KETxsK67acl3LI1NZv3B3g0kC0P4y8LNE0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUAHcTB6HaW4jqAP4DyTOh+yLjyjRUGiI2uJEGFF3s7ltYjOnf1YBkP9UP1JBtAjY1AIYySzxlbpCEpfBugJM+Xzak36qFsTDeebyX7EYZv7KlYE8iu83qhT2u4e+3IFzkbe3eim97ZrrKAxHrfw5iUR2I+HLNcT03idkJYOnL0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=G6yCMOC4; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="G6yCMOC4"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-398a5aad413so2627577a91.3
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 06:53:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788789203; x=1789394003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rUAd5a57Ijw8GSMVGKJOoAag1P4lVOLvfbZKkau5P4c=;
        b=G6yCMOC4CRLUF+Cs0M1DpLpqDCCjOCxOtiXgpEcE+SYc7fxBVMz2h42/Pxt/s27e5T
         lABeyK2pz5IatqxNvN85OHodpEcKpHK04pZnwte/WJN0fAWqO0JT88A160xcSaTUSop7
         RxT2eC3CVjwzTEP24K6c0AwYDer9VnCKOcRHyDfsx5RfU4N7LjNdhHTwIvqoHkTeXHE9
         RF8UhvplPSJNKUkQ4a/WkOupOl1XOtRmxJqpW3YpZDzxov5nlq7wI8b3OzBBFHiNrPse
         bA10OBtLWqLuIGhAWG5B4DWXsdgyuo+IHd3SUiZzWjpAnzAfYMvKHEh/c+8CUkqoU2LU
         tu3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788789203; x=1789394003;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rUAd5a57Ijw8GSMVGKJOoAag1P4lVOLvfbZKkau5P4c=;
        b=cUWrGN/7q1xGPk0/O4G89Ytp/o+Mhjpr1c6jsb5SzNPZGTdpOAxcFD37RuR4qowUwf
         ocpzfoGU+txHgF3W4A3HVdEeA/lZtHForUXFgDl+OQwPD1fiopufSuZmeB7JDcIIlkQK
         U0Jo0rNTFR/nyD7JsiNGamRniYPtZF0PYPScxGWCfpK0g/ceuuEmjOusCSBaWVuHBl2M
         4s3Y2MbNi6dt6U/V4kKrnsUspLun9SSzHR2OTRNvkU+u6dZP6jmgqb51kV9+tMHJorec
         vhGON097sWtaFOPQhfVyBrWE6JV0rFg/QIcfBbWsko6rIyR8W54esEROQdIJuzODHIuj
         7dFQ==
X-Gm-Message-State: AFuF++mrP2gJ69eLfxnsiuzasH3DFGUeb/0IxUXb6vMMdQnN4zDV0XEb
	SzXz5oRZEW9KyIppgKAhZSUAoewcYW3x8oremdZbcxSrwnsUu/ohMIESOeK2ptXS81UfOjVyHaS
	Gxlb4bA==
X-Gm-Gg: AYBFou0xbXgQfhaiGyGGwlA/BYKpclXn7/GTbvOdqPs5EX/9POi9cDsJpf2xVrSO7Zh
	LddmRN5ZVmCdT/oL8baoMNaFMtCSiXbbb08L0hNa5/1609kJImvmydMGf1PCM5i9BX7bjC3pQih
	j+OzZ8vy0b2QBtXd+2ysyFGAnPNKSlvYLu+dmqLGWngWIJz0Vh7QjLZTQDpqXXaNo7G4SQBtfqg
	6yGH5XzMOdJVx+kT8gQr4vQCcf7TOFmzGwlXoRSNodh/H+KOxYXk+J2T9G3XNoIuHxFE78OXuB+
	bcQ5kq/awPnUOrViUyrZBc+hA/ihmUgXp+lL3oVtt9OVmlAoS1YdRBXwOJC14UdeIEki6NJJaPN
	oagUHHBdSAQ5VX3CRzw7ojoyvDcF8IG4eIFZ54HjcmClMYwZDTiC3ir33OyIFOG0nMPWNJN2qXh
	sa3TCyQ4wz4P2jwb8sbsID4XkEGGzAiXEntQ+uUDtVbzWYuTZ3+4iDhoSGoBK4E6c1jyuc9PGdn
	q/FlpKoIWdEgZ1Vvner
X-Received: by 2002:a17:90a:d004:b0:392:6638:2e6a with SMTP id 98e67ed59e1d1-39b26273267mr35785346a91.13.1788789202756;
        Mon, 07 Sep 2026 06:53:22 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b260fdc1dsm21282204a91.7.2026.09.07.06.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 06:53:22 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	David Ahern <dsahern@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>
Subject: [PATCH net 1/1] inet_diag: cap bytecode filter complexity
Date: Mon,  7 Sep 2026 13:53:11 +0000
Message-ID: <d1b0d3a224167afa0ee61db0c9f778a2d12ff9b6.1788775605.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1788775605.git.zihanx@nebusec.ai>
References: <cover.1788775605.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inet_diag dumps run request-supplied bytecode through inet_diag_bc_sk()
while walking TCP, UDP and MPTCP hash buckets under their bucket locks.
The auditor currently accepts an arbitrarily long program, so a dump
can spend unbounded time in that locked section.

That fact is already present at the git epoch: tcpdiag_bc_audit() had
no op cap, and tcpdiag_dump() ran the bytecode under the listener and
ehash locks. Later inet_diag extraction only moved the same code.

ss(8) filters only need a handful of compare/host/mark operations.
Reject programs with more than 64 ops in inet_diag_bc_audit() so TCP,
UDP and MPTCP dumps share the same limit. 64 is a policy cap above a
normal ss(8) filter, not a lock-hold budget.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---
 net/ipv4/inet_diag.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 34b77aa87d0a4..1ca528cd3e72b 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -725,6 +725,12 @@ static bool valid_cgroupcond(const struct inet_diag_bc_op *op, int len,
 }
 #endif
 
+/* ss(8) filters only need a handful of compare/host/mark ops.
+ * Bound the program so dump walks cannot run an arbitrarily long
+ * bytecode sequence under the socket hash bucket locks.
+ */
+#define INET_DIAG_BC_MAX_OPS 64
+
 static int inet_diag_bc_audit(struct inet_diag_dump_data *cb_data,
 			      const struct sk_buff *skb)
 {
@@ -732,6 +738,7 @@ static int inet_diag_bc_audit(struct inet_diag_dump_data *cb_data,
 	const void *bytecode, *bc;
 	int bytecode_len, len;
 	bool net_admin;
+	int ops = 0;
 
 	if (!attr)
 		return 0;
@@ -747,6 +754,9 @@ static int inet_diag_bc_audit(struct inet_diag_dump_data *cb_data,
 		int min_len = sizeof(struct inet_diag_bc_op);
 		const struct inet_diag_bc_op *op = bc;
 
+		if (++ops > INET_DIAG_BC_MAX_OPS)
+			return -EINVAL;
+
 		switch (op->code) {
 		case INET_DIAG_BC_S_COND:
 		case INET_DIAG_BC_D_COND:
-- 
2.43.0

