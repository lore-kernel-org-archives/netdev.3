Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3896B390CB8
	for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 08:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787387075; cv=none; b=UPjpBmUZ0kp1/i7lge/V6NG6uC7qfqspaasAv0bB6qTV6yM443Wbl2hkECmtDEdBkO1Ro67sSK/8NSospITAfbvxd1ZiO8ct7eyzUhWWkQcvSQ3RsOUOW8egneJ2AFh3EoP/ajZSe496rcLLLySZuYo/vKplUNbBRlYP9x+uGSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787387075; c=relaxed/simple;
	bh=Z0kL/ypFJ2FGHLorOtaZ+IeJE911meCgAVCtAPqReXs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jZv9XxZXgPtx1I/6IvvipdAzuSe4J79iovoQNUAaoIBkBwK1K5df4gOc/aRGs5uCs2suJk/biYHDcnnkjFePRkAxsxV8d/SSYhtt4eoHvDqZn3iBqsEZBviSpa9A9ciJZ3hTCEUenDmCLfhOZ5ZDWgHJLTo++s4DK8reyUTLtdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=kYKuvPpv; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="kYKuvPpv"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c9e7391839cso1751832a12.0
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 01:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1787387069; x=1787991869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7IdaOGAe0h00In+Evgr9XH1YvrseI2U04raVO4/5oDc=;
        b=kYKuvPpvWogCiJnFyiXjwFCI+/5nbBbRl3WS5NbQnilK6FkJ5vEkdjV8NWyQZzkezg
         lhGjTwcnYKEC5JsKxPlej5UWOBDQwAwN+JaSa7i7RDaJcx6HFE7o4zULKuGbceNOceYY
         BUNBRozlmThxVk1AjT+mj7J5adxKcMJF+L2gq2kJQCTFeqYcAFB/sBtthoQ14uq1xvXg
         7OvPI+/GYqY/7yAS52Y+KNzP5ULC7bGQaibt1IX1IBkhTp/alJQ1K16X8WvP5eBOyH2B
         NonD/tbOsiETGf31RVQLmF0qg4g4oxKDRGLQUop9IiR8I7GoqPHwFdtEnG8xGIr1+eSo
         Eq2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787387069; x=1787991869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7IdaOGAe0h00In+Evgr9XH1YvrseI2U04raVO4/5oDc=;
        b=KCyPGlCA9Qk8Z9iyHxz+IsFixnwuPImiHp4XiASXndrZ10RW35MCX1oDLsyb088YvL
         A+nPhutDZtpqVfhWZVHmKGAXTps2VwnyP50kqRXmmFifSLoZUWoukaletzXGhNWGIkwd
         m634oW1+LqCGZamGMoPpRjEI3Q+7HAM1+8KAHOtdstMnYf3j5XvuLe9cmuNPlfePvvsE
         oByYs3Zu0TwfIexFJ2Xwu0W1d+tSxzzkv5y+QGAZ33kkMxvSzeGsgvdAYla5hHw9CtUx
         GHBMAS0Yky4Eu4eQYz7xYO1c8XVx1rbgky83kYW6kTOyKMbFAHGcyQlnB6ZNJvR5GLiT
         EdAg==
X-Gm-Message-State: AFuF++nGpCgbAi16eLAk47o3T0qtRyxtIpsGMGbmjoSh+pr7kEQ9D2Qp
	qPHe4XTlEzgKHZ8cy85ZmDsY5B6DtTT5jqhezZnb9QUTLvoE1F+tOl6+Bigtu6oMMu3+R7+2K37
	j1W/5ZZKIsv8=
X-Gm-Gg: AR+sD13BmWIZqaORRCHeKawqX4a5CdEAP+jX7EduRqn7hZxDSoJN+ZumC2aBZg6uG9W
	RntPwZn22QyjcgzDzGeWGjmTFdXlnFQE0c8WLLazrwpyN3nnYKFySFTRkVTgzsyCFZ+yic1Mwol
	+rGhuDLN3xU8d/b4Qq+efw0q+RcXdp3A9vk4I3WkEMl5RLouOlaZRJIZ8SwgwgyA74EEue6+2N1
	Z0/u+H674insUmux3NQnB/83/ZxGF0cDDEq5ZesY7MV+o/TlT5n8RjOmbEhRbx72xiBcaT/bvmY
	fcF98WO8jWH8TdGFNQY8OgTdeYSSXknGTLNZsfXrw0inESBU4RA4ObeRFIgw8jZwdtEy2laKQp+
	0eJsLtK48bDp+H6sTMglYmA6ysGO7BrjORCtnV5wxhlTb987k21ZGyt/pGYSIzSzlhlZj+ry1qV
	O66tZW7AgPhd6Q1z/0rsxtpeK6SZeWcquxV66x4SKIJIs1BjaopvYF8GVaX3/6qcfFygVP2u4Vv
	Anou0xL9Da3fYo=
X-Received: by 2002:a17:902:e78e:b0:2d3:7887:7e7f with SMTP id d9443c01a7336-2d64b0c6fe8mr243979635ad.11.1787387069109;
        Sat, 22 Aug 2026 01:24:29 -0700 (PDT)
Received: from gmail.com ([115.192.250.163])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d6768f1379sm2647875ad.82.2026.08.22.01.24.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:24:28 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>
Subject: [PATCH net v5 2/2] llc: reject out-of-service state before state lookup
Date: Sat, 22 Aug 2026 08:23:54 +0000
Message-ID: <20260822082354.3109-3-zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260822082354.3109-1-zihanx@nebusec.ai>
References: <20260822082354.3109-1-zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

llc_conn_service() checks only the upper bound of the connection state
before llc_qualify_conn_ev() indexes the state table. A socket in
LLC_CONN_OUT_OF_SVC therefore reaches llc_conn_state_table[state - 1]
with a negative index and can read and call data outside the table.

Reject states below LLC_CONN_STATE_ADM before the state-table lookup.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: Codex:gpt-5.4
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
---

Notes (llc-reroll-v5):
    changes in v5:
      - Make listener child cleanup unconditional so queued children are also
        released if the socket leaves TCP_LISTEN before close.
      - Serialize process-context child cleanup and backlog dispatch with bottom
        halves disabled, avoiding child-lock acquisition races with LLC receive
        and timer paths.
      - Drop packets redirected through a pending child after its listener is no
        longer listening, and release children left out of service instead of
        dispatching them.
      - Split the LLC_CONN_OUT_OF_SVC lower-bound check into a separate patch.
      - v4 Link: https://lore.kernel.org/all/20260814185843.4748-1-zihanx@nebusec.ai/
    changes in v4:
      - Create a passive-open child only for SABME and generate listener-side DM
        replies directly for non-SABME commands.
      - Use an atomic incoming-child lifecycle and serialize pending-child lookup,
        backlog processing, rollback, and listener close with the child lock.
      - Keep immediate SAP publication for passive-open tuple matching, but release
        unaccepted children on direct and backlog failures and on listener close.
      - Defer final incoming-child cleanup to workqueue context so timer
        synchronization does not run in the receive softirq path.
      - Add an LLC state lower-bound check before state-table dispatch.
      - v3 Link: https://lore.kernel.org/all/20260805175945.10698-1-zihanx@nebusec.ai/
    changes in v3:
      - Drop the unused llc_conn_handler() local rc variable reported in review.
      - Rebase the numbered patch and cover onto commit
        ede76849012e45ffb2193ad110b42027eec02c5c.
      - v2 Link: https://lore.kernel.org/all/cover.1785386749.git.zihanx@nebusec.ai/
    changes in v2:
      - Rework the fix to preserve the existing passive-open tuple matching
        semantics instead of deferring child publication until LLC_CONN_PRIM.
      - Track listener-created children pending publication to accept(), and roll
        them back on every earlier failure or drop path.
      - Cover the original non-SABME leak and SABME paths which fail before
        LLC_CONN_PRIM, including backlog enqueue and backlog drop failures.
      - Correct Fixes to 1da177e4c3f4 ("Linux-2.6.12-rc2") based on the earliest
        locally visible root-cause fact.
      - Clarify panic_on_oom crash evidence and packetdrill selection.
      - v1 Link: https://lore.kernel.org/all/cover.1784725007.git.zihanx@nebusec.ai/

 net/llc/llc_conn.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/llc/llc_conn.c b/net/llc/llc_conn.c
index 8120ecd46ace..4272ce4d4a1c 100644
--- a/net/llc/llc_conn.c
+++ b/net/llc/llc_conn.c
@@ -360,7 +360,8 @@ static int llc_conn_service(struct sock *sk, struct sk_buff *skb)
 	struct llc_sock *llc = llc_sk(sk);
 	int rc = 1;
 
-	if (llc->state > NBR_CONN_STATES)
+	if (llc->state < LLC_CONN_STATE_ADM ||
+	    llc->state > NBR_CONN_STATES)
 		goto out;
 	rc = 0;
 	trans = llc_qualify_conn_ev(sk, skb);
-- 
2.43.0

