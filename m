Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ECB9443C27
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 10:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454195; cv=none; b=kt2RZy2bxYX7Rot7wVcw/oIhsCD36tkULDYFAAAt5+vHLC7wX1DXWoITMqRFSP6NlA7ZXSiK5R7RUExuocx5ncPMRPGGRGz1kE1IAEB/a6tCgJoLyWCg79Ww05kZbnCLfo5Kv4tfJZahg8dPeNqGk2Uc+Cz4EEQqclLZr8Y8vNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454195; c=relaxed/simple;
	bh=UGd+kjwZ7wLqKrdkmrx/xsOpXTlQdSYek/Xxji0Jj+g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rYlXOqwrN2fpD4e/MFA2B/wgLRhYuIgcuA8vQAPzZcqqv9PjqKQ7SI31C8UBQ9KNf3YFcJuWjgI2GVkiVyiGMlIomhgHt5Uyadmb6rWBw9IhUAF20HxVrzAv2uX71LL5jfChpcMOeLar4oUaY6VtKJO8b6hSp6DCucemAuWleew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W4wvkifw; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W4wvkifw"
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-157fe9d771bso1291968c88.0
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 03:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791454194; x=1792058994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wXNayWQZtrxImfBFLGBlgxTe4JKCGS+pfnkyA+c+fwU=;
        b=W4wvkifwHJqFfVu6Nxl7vmafRGI0SCSCFW5wJHHbnQFfaST1z+Bg8DO6gFw3PuFLft
         oQWZH+nHD6V+VmucYPbDVZ/8HcrBsFhZYJul+VrWRPr7zt7xv6RtbJMOaz0nOArUhnK9
         nA+rrUufCkgbkt62JsNmSlUdbHdU5/Hu23CqVU3dclG3qpLsOGPhItIJgJsbvS1abDuW
         lWPbFLzTRnlS6fPbt0qSwagS7WKV4x21uvraDqwZmT2zTPhbDw1vaj+wDJAYwmhQ3QmA
         Apflxs1q/Wo0VA0RxjXLrfKVhRpsqW0MpDY05lCMqC0VoILmTbjUtWFQSQ5CIfR/rWhk
         J3Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791454194; x=1792058994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wXNayWQZtrxImfBFLGBlgxTe4JKCGS+pfnkyA+c+fwU=;
        b=oRUpy18YdnVgqPJCU4xMQXN2xOeIHbYfzPRkfv8utVk//g6MV8dp4gsTWDxpg6V0Kb
         7yYouJKecEYMVsJRPuqoDMl+wOwnWihrmhWJzE1Zwt8zUVbpnuHdUOvZIiyKXXO1B0au
         YQcDQJGsNZSGQ/BG11qcpGFV9ltPSBWpDDVx/9z3dT/URVJkM0wNzqhB58F3TqhxY0gp
         Bq29tUjffQQseZJwT2tJhgWqAHmwl5FyeNwjdmFe1SC33DuRrHcdKnUr9KSAPbaQqglm
         oInPZmSMp1ngpTspOOWaUq1KvjLBYQgLh/DLjE6u/0TnAUf3OVAv2b63+U1eMcN92RY5
         JGcw==
X-Gm-Message-State: AFuF++nl28qC5Me33QBHxUcN/p3UBaztpUBVCF0ATAkDOjA8vm/iuUE8
	eSA6wGH1/RlzEMcn04b3IpG+MYBQ5X8dIodWvpvUoxVwhCWvKfU/Rj4e
X-Gm-Gg: AYBFou2t+o403k/XVFMwLT0aVV9gLeG0kLP13MGFrMLmy2zTnwMmODuQcEN3k8GbfbM
	cz4FCHv6rLBLDH22q+W9BjeQKr68sLKxnpUBDOkOmakxBPKexzKPK8/Pvf3KseEW8R85jHMaO6X
	WEaKhZ1yExHRo/4NX42yvmWkKUWiiBAD8pZzsOoHH26731XBmqI0Vd0zYEW3Z1ZMldakDOcrAnB
	GVWUjWhR0o3aLA1hnMt+668++HFYUq/T0WxYtC2z2zEwBbm4j29rBn52B/8mlB+qM6sDkzyeR1w
	bqjR3yrsT/WoYBf3MATpuYTAPWbjSWCpJO41aJE/+AX03qJfjxwc6RF/6kWVWKxVGDFMb/t/SdY
	bzt67WC1ilJpwMAakm/fFTYbhEy/3Xp/p/XI8Ov4Cj8fZZTlfN80p09iBKU6oosZSGI2XQdCba+
	TWoqkKWYJmTsC+HaqH3H6tohknV+Urtt5h5k5z37iX+JTOQBaciIVmD+KunQtlPaDQJjhDOPBlf
	j+RgUuP3vsNep6HzdA=
X-Received: by 2002:a05:701b:451a:10b0:158:7ea9:4a5c with SMTP id a92af1059eb24-1620637efafmr5613674c88.27.1791454193686;
        Thu, 08 Oct 2026 03:09:53 -0700 (PDT)
Received: from ramesh.. ([124.123.89.203])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3515abb5389sm16487581eec.2.2026.10.08.03.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 03:09:52 -0700 (PDT)
From: T S Rameshkumar <rameshsv06@gmail.com>
X-Google-Original-From: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>,
	Geliang Tang <geliang@kernel.org>
Cc: netdev@vger.kernel.org,
	mptcp@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Petar Sakic <petar.sakic@ink.fish>,
	T S Rameshkumar <rameshkumar.t@phytecembedded.in>
Subject: [PATCH v2] mptcp: push queued data on passive TFO subflows becoming established
Date: Thu,  8 Oct 2026 15:39:41 +0530
Message-Id: <20261008100941.104715-1-rameshkumar.t@phytecembedded.in>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With TCP Fast Open on an MPTCP listener, if the server application
writes data while the passive subflow is still in SYN_RECV (after
consuming the client's SYN data but before the MP_CAPABLE third ACK
arrives), __mptcp_subflow_active() refuses transmission and the data
is queued into the msk write queue.

When the MPC third ACK arrives, the subflow transitions to
TCP_ESTABLISHED, but because the third ACK carries no DSS data,
the queued bytes remain stranded until the peer sends more data.

Fix this in subflow_state_change() by checking if the subflow was doing
passive TFO (subflow->is_mptfo) and has reached TCP_ESTABLISHED. Acquire
mptcp_data_lock() and call __mptcp_check_push() to flush queued bytes,
clearing is_mptfo so subsequent state transitions are ignored.

Reported-by: Petar Sakic <petar.sakic@ink.fish>
Closes: https://lore.kernel.org/netdev/CAFPPu1gU2Y-D+d4i3F0MoNkYK+e1U+=X3qf6QycjfKBw+8snPg@mail.gmail.com/
Fixes: fb7084501a61 ("mptcp: add support for TCP_FASTOPEN sockopt")
Signed-off-by: T S Rameshkumar <rameshkumar.t@phytecembedded.in>
---
 net/mptcp/options.c | 7 +++++++
 net/mptcp/subflow.c | 7 +++++++
 2 files changed, 14 insertions(+)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index ce0de02f5..d5238fa11 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1042,6 +1042,13 @@ static bool check_fully_established(struct mptcp_sock *msk, struct sock *ssk,
 
 	mptcp_data_lock((struct sock *)msk);
 	__mptcp_subflow_fully_established(msk, subflow, mp_opt);
+	/* Passive TFO: the application may have written data while the
+	 * subflow was still in SYN_RECV; __mptcp_subflow_active() refused
+	 * it then and nothing else spools the msk write queue when the
+	 * MPC third ack (no DSS) arrives. Push it now.
+	 */
+	if (subflow->is_mptfo)
+		__mptcp_check_push((struct sock *)msk, ssk);
 	mptcp_data_unlock((struct sock *)msk);
 
 check_notify:
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index f0a6725d2..c71122842 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1894,6 +1894,13 @@ static void subflow_state_change(struct sock *sk)
 	if (subflow->resetting)
 		return;
 
+	if (subflow->is_mptfo && sk->sk_state == TCP_ESTABLISHED) {
+		subflow->is_mptfo = 0;
+		mptcp_data_lock(parent);
+		__mptcp_check_push(parent, sk);
+		mptcp_data_unlock(parent);
+	}
+
 	/* as recvmsg() does not acquire the subflow socket for ssk selection
 	 * a fin packet carrying a DSS can be unnoticed if we don't trigger
 	 * the data available machinery here.
-- 
2.34.1

