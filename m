Received: from mail-oo2-f7.google.com (mail-oo2-f7.google.com [74.125.231.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374C130F92E
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 07:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785742475; cv=none; b=jKTnCf5gNYw/iXdIcZHZG4HGSVdsVGYorYLArLUn942B/JZyvRN0kBgKK+xlSpwhovYJR8ZmXqGlQfzJxg6TH990Bkyw/+0TB4G3TmGpG8bqV2qnDwjK19jtJ38Q/YUGv5NQtIMJfAhYIJmeQHVB7pGKLW1BIrJiOX6soySkya4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785742475; c=relaxed/simple;
	bh=tpjh1uatBlhYLlD5vAk+xB/DquSmvzWDtmA63zML9yw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g3KQfp+Bi1T3QrYaHAQP5wcx50vbW3dBUbYVLTTJtR263IPgwEdZHZcG4JIEiSZ8ibH5BVxSilZdMhLemoNOOEhHX3ZmbMlhhUmomPDWUE2rUpURNyPZqepjGY/Kocw+GV8N3bnZqoo+uz0nUOBk0QppSB6ap9Vl9z6txWoBNKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VVFnpiwE; arc=none smtp.client-ip=74.125.231.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VVFnpiwE"
Received: by mail-oo2-f7.google.com with SMTP id 006d021491bc7-6ae3b48a69fso829278eaf.1
        for <netdev@vger.kernel.org>; Mon, 03 Aug 2026 00:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785742473; x=1786347273; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rsONA6Rm8WFDnPmCZS0NGqffUBQ3s2z+UFLSP3FHVZc=;
        b=VVFnpiwEtpdiltKA2m5q2KESOAO5J3lGmSpvJN7pD4APjt+JujwwGMQxTBHUX79iL/
         Os2fXNq6ZM3ZUvw2Sw0LMEOHaTWxnJ7pYdC3j4tGIOpkrI+Oi1hgJHj21zEUnJsTRphh
         5nzX0ys7RdDMp9XbtlN4Jf27gRI8Xev6Hy5Quzj5qTthfrhq8aBZDpsMwuFji6ELhbGa
         /zgGJVx6XuipwAJzsQjkJKVQQusKmAIXHWrfebQ89Tml47B2njxt9jC0sKql7Zhf4y9e
         1Uke5gr17NMOqbHs8leY0L+X2c1RSSAC474icihIdFR1ljIfgIq1OgwL+i692icYJOrr
         XT5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785742473; x=1786347273;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rsONA6Rm8WFDnPmCZS0NGqffUBQ3s2z+UFLSP3FHVZc=;
        b=SW8bZHcQ9KGf105RE24wlglt29CxDt7HypEM5N3MOmqKOSxQKgygb26aUJgILfk3Bi
         69K7LQVEWK0rzvMZhfPnm2LJGel5DO+Xu+sCGXrZY3SVCqWoyB7p7G6ZLfxWulTUhAVk
         RkAWBJ4q7fUbWZ9KZ08kRULFesZHm0vdDStOhIIBocZU9J8B4aum65vvUqOg2dkrcQTJ
         ufMSM7nS2dJ09lcfUk/wYJ2qSDH4OrbcwDMXr71ruVbmqOkunA/zMVLvkMQRs9Sw/vWk
         F6fIrHo3LSwxq4/hJPak2cYaU96wunzMgCud4hmm94n6WzW2GfqVFCa/CcH3J6UJQK0T
         VRHw==
X-Gm-Message-State: AOJu0YybthPsAQGL6XaaFnUzLdIrXsn9usYqo5oEo0ueA2ixsVuYMm8N
	IFzMqS3QibOC31U3RwRTp7N1dxyoEf8yq+nnkV4FNFAWyk+Y6jI3gZjXQsxcokYNageohQ==
X-Gm-Gg: AR+sD10JztzG6L0fmFjGtbUVMQawUmSYPHFjBA5FlQ8ALJ0x2iKIxx0ZPWGkR3U6xD5
	/J+Jh0nWwLwUR7tlSeLNYCS3QOzzg6ITFTeZb8LYaPVauCBaadpoU2n4b59JcPMc0ZeaZ3l5J6H
	I5v5/wuYzo/evhD+RwA/V4WhwwVmg2VTFHsLaHRsuVjDuaDgXKNXN7Ny5VP9+SbzryXTUVI5V2X
	qFIpTvD+O3Gsr/QAIM854H/9u3DF8YGWs3WPUrHx38R2U2IXSn5BfQG7ebuLH4nAqYZfJw/+EPC
	zTwVH4C2AcRHjcT+ENnUsLUfm5iPDE51w54H6SFhM6+oaw4+XlLIEQJipcxdBurOIbLc7R52fT/
	AVs4YfUhhWjA6Zw2U87+H4MxCR9G+7+ipoHkBYt3YdKfWd8VB82nqdUcyzHE0UIC/Dx6xr4tvJ6
	3W7GtfQwv5WhJ6St3Y89SRnWYgXC9V8u7kz1zibwcTiMU4+BOsfM42VU6cfk/7wdWBPypCv23uJ
	yB0PpY2jbn9pFppKIyjQczrog==
X-Received: by 2002:a05:6820:4b02:b0:6ac:c531:2ef4 with SMTP id 006d021491bc7-6ae43336570mr14325667eaf.26.1785742473037;
        Mon, 03 Aug 2026 00:34:33 -0700 (PDT)
Received: from localhost.localdomain ([14.22.11.162])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6ae39e2f5c2sm6173749eaf.8.2026.08.03.00.34.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 00:34:31 -0700 (PDT)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: netdev@vger.kernel.org
Cc: dhowells@redhat.com,
	marc.dionne@auristor.com,
	linux-afs@lists.infradead.org,
	Henry Martin <bsdhenrymartin@gmail.com>
Subject: [PATCH 3/3] rxrpc: recheck RXRPC_CALL_TX_NO_MORE after sleeping in rxrpc_send_data()
Date: Mon,  3 Aug 2026 15:33:55 +0800
Message-ID: <20260803073355.3895949-4-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260803073355.3895949-1-bsdhenrymartin@gmail.com>
References: <20260803073355.3895949-1-bsdhenrymartin@gmail.com>
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
