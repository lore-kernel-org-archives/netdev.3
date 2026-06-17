Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com [209.85.222.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40719451056
	for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781733454; cv=none; b=Qfjd+88+/OVe0tDa44IWFxHFgUEVCPtwCckkqRxeRPTjh5a3DM0L49zkWc1TegaNGj9bFv8j8PqQwRHPknjlj/IbuPRV295A1bJJ78uJ5O2ta/9yBQa2wsN4QrmowQ3nUTWdW7g/lbe9wKdTmi3o6XsJaSu7AWxE/9BLonhEJV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781733454; c=relaxed/simple;
	bh=YFX993hq1Dn+Ak0oODn5emNit7+SDeFwOkckrV1bITo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G0+aaiIuLIo17uNlPok/IVTmgJvKBlkfDofHSXS5Ly3fmyyGHbt61IeGxH+C1s3l9ogt4DiC1idLmcrKhGc5iB3whWCA6xzWfHLFrPY/vhlt4XQt0sDxPMqOpPLM7CG3ydtHfAf1xqeRTVioA3X3iE+h+pIWJ6xUWdmYmh55Y2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G474XMNR; arc=none smtp.client-ip=209.85.222.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G474XMNR"
Received: by mail-qk1-f172.google.com with SMTP id af79cd13be357-91591f19c30so40920785a.1
        for <netdev@vger.kernel.org>; Wed, 17 Jun 2026 14:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781733450; x=1782338250; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OX6t51pm0YrW+eM37YUtdbX6+TWrUjJQf11wIZ0s0II=;
        b=G474XMNRVQGXPLkdOIydKCEwChqbirSQBc9kDGRSfgPSWzype3EzSNajhyWOMdVviX
         KY2SW2dTZsX/AhWbvgzwugj7dWVXUfyyUtCnIt5ShpXQ7NMlacQNZcZiaT3ppzvmFUz+
         EnPQLiCfSLC+M/6hhpeYNou4uoabgR4Q9+uqJvu4gAMOVb3UTVSnZUVfvBXpE2MA2TGJ
         +6OO+eRAT+wlQr354KefJBTEx22neFVxI5WKNe4OyiIEG5wpekV0XKJkcCsUo+rFXqxs
         pM5JLoYg7wcY9Qvu/V5A/SoXEH7aRBe5rovW9Ec483vhxahDPDC/UN3i93beyf0cp+9P
         o+1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781733450; x=1782338250;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OX6t51pm0YrW+eM37YUtdbX6+TWrUjJQf11wIZ0s0II=;
        b=YVcnI/SKwI8cXYnjb6UARpcpnUi5OFKUyGHln8hbx0lX00jckzoMA4jyD/HFoy4xGd
         tmB8+FpOziZg0y/2mLWNETFiVUbxztYKGc43SLtG1CaQyjQTFYGv8X/f/ts79YgsX15L
         lTOCgVGUlY4oHqGqiaiZH7Vac19xZPC6tsxvQyLCpdfcERNtdmH8Ocbxtq3bmtF8OL7a
         dp19wytvXx0L2XPmabCDJj8R5n8THiyetIOtpKAOpKBkX8uu65HdYcePkxPJIT+WoBcM
         wXC0Qz5jDaakfiekEXf8K4vBh6dFn6wGBvtwY1BlhaDB/IG1uy7Z4sK6bL2cAUzqhKbZ
         ry2A==
X-Forwarded-Encrypted: i=1; AFNElJ/k9nv/sq94cFDLQH1xf3bL8dpbZkjGXHHrSa1YW9e4/aQPeG8pfgUrfnHZjUJAen7l7dYVf88=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzglgyl0Oc1teskqSzQ/Dpplna01LLs7G1Fds1vwawCAjqPOzTT
	NT5yks/reOT/OOwSVKuCxqS/uMUYnI/mtR0vziSrquTmzEDfCy4GY9xq
X-Gm-Gg: Acq92OGfSG8nTV6OCJuxyWi0JPE/+hoqB+rS5ZMPXKX5NVgIEqw1ge4nF+QGp4DJlxa
	O74lfDKHUkB/H0fb3vkZMKsWvZgoebNOnhPZU7uQfuJPXiJhspqOu8NvDXWXJYBz/8+rE2WxrHp
	9hLIRKI/E8i+zpQfRiXDOJ33eNbLnYM/LCWMWoHXO4hgGuQoCywTpzO9//jTTwyEY+5VfMQdPk4
	ZtInbMVywSA3UBCIN4ZQoYJX1yeE3CogXIJJ6Ta7cLSnaJ5rq6tIq6EpBpufJyoPJDcKXbQCXKi
	xJje1AkBgpoyh0HgEbp0JPsNoL7GhBYizqXM/O04svhJY+fO7jNTpMkbTxM4zV95/rGzqVFW/D1
	GdQiOziyPbOW3uQASY4qvRKaKUHR33d1ZMENN00m17I7dvdiR5nBf7JlUQ9RNX9K4HBKYECV0ir
	6RDyIiCvPIv22yKtTxUwG+7PcB9JAB6rZYhBKH5L7bk9jHubraLdZAyF3Qg5n1DS1S6i9MgTweN
	e/8HXJbF+gBzbJSA825qWpQ7IV3ktPbsbOz1TRXnVk=
X-Received: by 2002:a05:620a:4625:b0:915:aa7d:42bc with SMTP id af79cd13be357-91f2a9c1356mr146659285a.10.1781733449733;
        Wed, 17 Jun 2026 14:57:29 -0700 (PDT)
Received: from server0.tail6e7dd.ts.net (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-9161a006441sm1974497285a.27.2026.06.17.14.57.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 14:57:29 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: Matthieu Baerts <matttbe@kernel.org>,
	Mat Martineau <martineau@kernel.org>
Cc: Geliang Tang <geliang@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	mptcp@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] mptcp: only honor zero-length DATA_FIN when a mapping is present
Date: Wed, 17 Jun 2026 17:57:25 -0400
Message-ID: <20260617215725.1116295-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

mptcp_get_options() initializes only the status group of struct
mptcp_options_received; data_seq, subflow_seq and data_len are set by
mptcp_parse_option() only inside the DSS mapping block, which runs when
the DSS M (mapping present) bit is set.

A peer can send a DSS option with DATA_FIN set but the mapping bit clear.
The parser then sets mp_opt.data_fin while leaving data_len and data_seq
uninitialized, and for a zero-length segment mptcp_incoming_options()
reads them; KMSAN reports an uninit-value in mptcp_incoming_options().

Impact: a remote peer that has completed the MPTCP handshake makes
mptcp_incoming_options() read uninitialized data_len and data_seq (KMSAN
uninit-value) by sending a DSS option with DATA_FIN set and the mapping
bit clear.

A DATA_FIN is always sent with a mapping (mptcp_write_data_fin()), so
gating this path on the mapping bit drops only the malformed no-map case
and leaves valid DATA_FIN handling unchanged.

Fixes: 43b54c6ee382 ("mptcp: Use full MPTCP-level disconnect state machine")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
The stale data_seq then reaches mptcp_update_rcv_data_fin(); no further
consequence is demonstrated, so this is a robustness fix. The read site
for a zero-length segment is:

	if (mp_opt.data_fin && mp_opt.data_len == 1 &&
	    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq, mp_opt.dsn64))

Reproduced under KMSAN: a no-map DSS DATA_FIN crafted on the wire and
injected over a TUN device into a real MPTCP listener produces twelve
"uninit-value in mptcp_incoming_options" reports on stock and none on the patched build (the unrelated mm-side
KMSAN boot noise present on both trees is not affected); a well-formed mapped DATA_FIN
(control) drives the same branch with no report. Harness on request.

 net/mptcp/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index dff3fd5d3b559..e40efa26a6694 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1227,7 +1227,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 	 * present, needs to be updated here before the skb is freed.
 	 */
 	if (TCP_SKB_CB(skb)->seq == TCP_SKB_CB(skb)->end_seq) {
-		if (mp_opt.data_fin && mp_opt.data_len == 1 &&
+		if (mp_opt.use_map && mp_opt.data_fin && mp_opt.data_len == 1 &&
 		    mptcp_update_rcv_data_fin(msk, mp_opt.data_seq, mp_opt.dsn64))
 			mptcp_schedule_work((struct sock *)msk);
 
-- 
2.53.0

