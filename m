Received: from mail-oa2-f0.google.com (mail-oa2-f0.google.com [74.125.231.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5368D3C109F
	for <netdev@vger.kernel.org>; Sun, 23 Aug 2026 05:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787464443; cv=none; b=hs+5bJZIXZSInMuGVTTTT+90onFp6Atnlu2i2TMPWQPR8r2olkkgpPXUNRGipza9G5EPZbg0OT2Ftl7WlZfg8avz+weroNLOWC38jZ2K9Gaido3aYcsyTqc2YJUAn938UpaxdOfTqHDuh1/P84piI4XNtelTCDV9IRFyjLHDmvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787464443; c=relaxed/simple;
	bh=tpjh1uatBlhYLlD5vAk+xB/DquSmvzWDtmA63zML9yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c1+K6NGqrrpPhf2D16ONrsA2Dxu4IYUz/mI0MOVvD5g9KAs7+Jc6BoS748TUG1CwE/gRMHfP76wMAwCWzD+4gVbQkHYMd0pzgqcqt3kVdEXYDmMyaZJ2n8zfoITlGthbY/lydTjMyYMMrNI410o7qxaQQnBZ5U6Sf79z0SYuFNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FGHx/5EM; arc=none smtp.client-ip=74.125.231.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FGHx/5EM"
Received: by mail-oa2-f0.google.com with SMTP id 586e51a60fabf-455efbd6e96so939580fac.1
        for <netdev@vger.kernel.org>; Sat, 22 Aug 2026 22:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787464440; x=1788069240; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rsONA6Rm8WFDnPmCZS0NGqffUBQ3s2z+UFLSP3FHVZc=;
        b=FGHx/5EMVRqr4KbrmtOJn9a3Tax/TJWfkhT9KSdpP59KuAmZ1rcloM6h5q1PU/cdam
         hfX2MBNPyKwRN0DRIfaL0RA5QhQk3twceha+bZgYrFWE+a+FqMMQpVfokmjmRPhAbUf8
         Bxh8YsRC5MWPbLDHbpFAxB+1sKbVy9v0cYOs5D7VZn03/TPQ6l27lc7Nn/8qUkVHxTR0
         ClQ869WwWzTfo6Cs4mEjsb4XDxg56CwHgfRP/5Wy8gPC+adOaaYWqpLuC+hIq22ZB7Jf
         bM+EOM2LUgkscKTl/QwGqh3dy//+O2oEL8h4WoD2ShPbEGI9WXxJdW3q3WNtjrBihorj
         +Srg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787464440; x=1788069240;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rsONA6Rm8WFDnPmCZS0NGqffUBQ3s2z+UFLSP3FHVZc=;
        b=B3QhbXnYDBscwMbrzZPlPWeNGlMjZKbsQXIdyRCdBNxWj4fhv+r9iskhCEyHCvOY9F
         DrgotJNgyp9aw657AiCBFh400sf0EJx9KmmW8LubSlOV++vZ3YLihqBI68GSrLy5xngx
         bkMpVWh6t0ceI6SfRKa8H7Y8tly+kLK2as8MYPWNorneh2qD+q59aA3i/Dij+66GoDP9
         GTGYw4VuwgpxWh91qbUS0STqN/jwDP0MrazEYS0WzLia6/cDfIQUCWyNpMx+3bQFqWZw
         eF0U8VBQY49mUG3UhF9Hh9Rfr3j68X1cMseMtFutU555oupHWLdcfsSYkRkAlAKYNUp3
         Z8KA==
X-Gm-Message-State: AFuF++keRA4/sur7yW0xwVcsBHJ3Kfk/DcRV1OzQ+DtjSoFHobhHB1ZN
	aCZ2uc8/N3F5cJ4zCUG12iKv71gOCtAICfBA0KEf8hdKnbBvKV/ifOyyOz7F4Bo7BGk=
X-Gm-Gg: AR+sD12g1dJVM0uRKRKaQ0XueJy4CQPO6Drk+knJrcMN1wpxrr92wMLVkU3Jh8lwz8u
	2g34wXgyrQIHWPqK3g5qlZlUd8udL62x1DanDAJ2UcXhghNEEu3LIhsWMlELVjd9cN/FRX8M5LZ
	xD/cbsX5740IlX/2nDUyOpnad3ISU8lLRHMzoYCOfRSKaVydZ3zvYe8A37HTcORVQa9W9d0L5Nf
	i68/1FIJIqO6mageZaCFdgObKp/zAD4uPOIGNToF1qqU3gaINubSP8M/f6UkUXCLtjp0EMf1qb0
	NqLPU3oZz6mEIIRXqiI7Qb4i1InufZLvLBfdBoCAn2lUppWErIl9VVxY/JwoPZxZr47ucyTsb0Z
	IyTlyvzqDf9pceQe010WGfcuiKhu9I4tzOg+igpmoHnS50AFnkZFsnTC4+LKfcBY3cE+sPzAfsr
	esGczi0bQpf13cGcgfZW4D5Acd25qUC/FBMYxxLiqbOpvwBpH8UJBqYamtx5lFmNhnwV3BBudxJ
	kAqM8XNnkP1DqGBZCMFMCJOD+heFxmKuJp7
X-Received: by 2002:a05:6870:80d3:b0:44c:5514:4e7b with SMTP id 586e51a60fabf-46350f9e304mr18570451fac.2.1787464440308;
        Sat, 22 Aug 2026 22:54:00 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.161])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4638313340dsm2791832fac.2.2026.08.22.22.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 22:53:58 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH 3/3] rxrpc: recheck RXRPC_CALL_TX_NO_MORE after sleeping in rxrpc_send_data()
Date: Sun, 23 Aug 2026 13:53:18 +0800
Message-ID: <20260823055318.371374-4-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260823055318.371374-1-bsdhenrymartin@gmail.com>
References: <20260823055318.371374-1-bsdhenrymartin@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit ae4f89989479 ("rxrpc: Fix ability to add more data to a call
once MSG_MORE deasserted") added the RXRPC_CALL_TX_NO_MORE flag and an
entry check in rxrpc_send_data() to stop late sends on a finalized
call. However, the check runs only once at function entry: when the
transmit window is full, wait_for_space drops call->user_mutex and
sleeps, during which another thread sharing the same user_call_ID can
finalize the call (queue the LAST packet, setting TX_NO_MORE and
clearing send_queue). Upon waking, the reload path only re-verifies
the shutdown flag and call state - and a just-finalized call is still
in RXRPC_CALL_CLIENT_SEND_REQUEST until its data is hard-acked - so
the thread proceeds to rxrpc_alloc_txqueue() with send_queue == NULL
but tx_queue != NULL, triggering:

	WARNING: net/rxrpc/sendmsg.c:297 at rxrpc_alloc_txqueue

and returning a spurious -ENOMEM. The call state itself is entirely
legal at that point; the WARN_ON's implied assumption that
send_queue == NULL implies tx_queue == NULL simply does not hold after
finalization.

Re-check RXRPC_CALL_TX_NO_MORE in the reload path after reacquiring
user_mutex, mirroring the entry check, and bail out with -EPROTO.

Found by the autokbug dynamic kernel fuzzer at Tencent Yunding Lab.

Fixes: ae4f89989479 ("rxrpc: Fix ability to add more data to a call once MSG_MORE deasserted")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 net/rxrpc/sendmsg.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/net/rxrpc/sendmsg.c b/net/rxrpc/sendmsg.c
index ed2c9a51005ad..b39af552c6b46 100644
--- a/net/rxrpc/sendmsg.c
+++ b/net/rxrpc/sendmsg.c
@@ -358,6 +358,14 @@ static int rxrpc_send_data(struct rxrpc_sock *rx,
 	if (txb)
 		rxrpc_see_txbuf(txb, rxrpc_txbuf_see_send_more);
 
+	ret = -EPROTO;
+	if (test_bit(RXRPC_CALL_TX_NO_MORE, &call->flags)) {
+		trace_rxrpc_abort(call->debug_id, rxrpc_sendmsg_late_send,
+				  call->cid, call->call_id, call->rx_consumed,
+				  0, -EPROTO);
+		goto maybe_error;
+	}
+
 	ret = -EPIPE;
 	if (sk->sk_shutdown & SEND_SHUTDOWN)
 		goto maybe_error;
-- 
2.43.0
