Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.198
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793924752;
	b=Sakac09AL/Z5CAshu5irqlNSmoIptWUGiJrYj7Fyu1Zrqd2z6FQw8akG2CqsiRJsb1vR
	 EfvPytJHx/mWHjDdDbLkZyoOo2s//t0y5ArL8I8y2L59ZeBeKri4XINr+atY4B6gDUG5C
	 fuELtcGC9SWGLUIhHVV9kEP9vGFUoCOabQwh7/N1wWiu0rKOvXSQ5pT779Kp6m7JIAOep
	 I9k3L/JcJDrQv28qLcliQojCWQctk4A84RySO0oIs/sgL6d7CKLhdC1NbkdwKTtt3sPzT
	 ELjpaTs1/S7VKSzSW/Ygkm5lmpDkYUO0klR29P2VnPAiIIdAhRcCvHOmJ80uMiRJyJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793924752;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=JvqI6TBiIZCiWZcWVkF7wmK1Vhkf37zW3gHeE3OoHp8=;
	b=tSgOtU4grwzSDLLZiYzNLPsDgF4GkKhC9fWuZ0jEX2Li0sWcwHrO4E+yznzrb1fw9dGr
	 qB6VQB7T8b254EvpSEqKFDB6dn3I8YxsEezJ6/+EwQEhyrjSgolddb7DP9B36H2V9U/hs
	 LA0lVMCQf2Q+D6pFcqMoj5Spm4TZpcBW+RTRc/RK3VowOcpk69aexPkqmlN9GRuXN82AS
	 R3mgyAyDlgBs0xL6EOH9UTD0tjoBogglQxF7PKSmrgZkjXP7N7ncTzEp+bIHxnvjeI8Zz
	 FrRg9Uc2nUw1uPv2I3wcSlE0VwaRUley+h9Rt9UeGCBRcwsMCGgbk8Iu+Ro6TLEE16Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--namangulati.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dPxQOlzm;
	arc=none smtp.remote-ip=209.85.160.198
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00FC606A31B
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 00:25:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B00FC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--namangulati.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=dPxQOlzm
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-5337ed1ba44so1136411cf.3
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 16:25:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793924750; x=1794529550; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JvqI6TBiIZCiWZcWVkF7wmK1Vhkf37zW3gHeE3OoHp8=;
        b=dPxQOlzm/EecsuI7ecJmtBSeZKddd15hJzcNWEHbZOfkGkRrFLra1+pRgFfixRPIr2
         Vw6iYxZL9gg7ntrQWkdN0vZmtClduoY/dygZdYHSAXjN/ald1qENYJ72z4BzNJwp1p7j
         iAKy85t5ioYPYuJD68ghEy7SsARQQjKZGHKRP44Bbh1ooytror1Ys8Tn27rn3222DidO
         iAPz5IR58gBoD2DNR0J/YkAogCoPXnYROVrvkKmsn4emf4c9nbnhRSfQX426QYFiQiCY
         h52lkHE3bp57tJ1FK40ndSoF133yuKUthYlrRyllnDqvEA1ckg4QZqtSBBY0qnnFhrOi
         4j4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793924750; x=1794529550;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JvqI6TBiIZCiWZcWVkF7wmK1Vhkf37zW3gHeE3OoHp8=;
        b=19akCkryGLkeckXAocLd5BcuWe41ONdlRsPGqcLrZJ8k8K2LF5SLoMQQf1DH8xmOPM
         dzbtFf6TCocym2nQpuiLr6sv0py1p5gBUqY8b+KF6o0ZRPbAfckNB0rg7i84gbyEQL0y
         lbsG6I5leq7mCIlppXVMxqdiQriUqnzbkux9yA6Q+zydzSPFkLmARuf+OxVEdwi0x9Yl
         DUIEEi1QLVZXpwqt0/WOW+bysdehVsQc4tWFDhS2HfV7dLs3iG12HZWZJT658oGxvLA/
         MhURuonvRBGRll6LJ81zW2F4ubjkXWQ8+q7MUf+rmA2BW2Ncl8tLwF3gPsqukS5UtkLX
         Fuow==
X-Gm-Message-State: APuU4Z/LuBMCmzTv3f/NyE8K0Qd8lcotJ3gZR6M26Nc41HAkmK8tNjwL
	dVRx3hbpNoy/inDxo9fUm1kY02DSQEqaU2URH4mg+blPdsy9ZhkOM/wJOg2pyU3Vuw+mr0NkZK8
	3Yv59s7gLGz333GphtCBnLZri/A==
X-Received: from qtvx8.prod.google.com ([2002:ac8:4d48:0:b0:542:fcb0:6027])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:3c8:b0:535:14f9:3f02 with SMTP id d75a77b69052e-54e1566b67cmr16452671cf.58.1793924750173;
 Thu, 05 Nov 2026 16:25:50 -0800 (PST)
Date: Fri,  6 Nov 2026 00:25:46 +0000
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106002546.2100412-1-namangulati@google.com>
Subject: [PATCH iwl-net v2] idpf: fix Rx payload buffer leak when header
 buffer allocation fails
From: Naman Gulati <namangulati@google.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Brian Vazquez <brianvv@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Naman Gulati <namangulati@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

With header split, idpf_rx_update_bufq_desc() allocates the payload
buffer for a buffer ID first and its header buffer second. If the header
buffer allocation fails, it returns -ENOMEM and leaves the new payload
buffer in bufq->buf[buf_id]. idpf_rx_clean_refillq() then stops without
consuming the refill queue entry, and the next NAPI poll retries the
same buffer ID, again starting with the payload buffer.
libeth_rx_alloc() overwrites bufq->buf[buf_id], and the earlier payload
buffer is never returned to its page_pool.

Each such failure leaks one payload buffer. The pool's inflight count
never drops to zero, so when the queues are re-created or the device
goes away, the pool never finishes shutting down and
page_pool_release_retry() keeps warning about a stalled pool shutdown.

This happens when the header buffer pool runs dry while the payload pool
still has pages, for example under memory pressure: a header page holds
several header buffers and only goes back to its pool once the skbs
using all of them have been freed. This was hit under high flow count
TCP stream tests with memory pressure causing RX header buffer
allocations to fail, and validated on idpf.

Release the payload buffer when the header buffer cannot be allocated,
as ice_alloc_rx_bufs() already does, so that the retry starts from an
empty slot. idpf_rx_page_rel() also clears the slot, so the buffer queue
teardown cannot release the buffer a second time.

Fixes: 90912f9f4f2d ("idpf: convert header split mode to libeth + napi_build_skb()")
Cc: stable@vger.kernel.org # 6.11+
Signed-off-by: Naman Gulati <namangulati@google.com>
Tested-by: Brian Vazquez <brianvv@google.com>
Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
v2:
  - Add Cc: stable@vger.kernel.org # 6.11+ (Alexander)
  - Add Reviewed-by (Alexander) and Tested-by (Brian) tags
  - Note how the issue was triggered and validated on idpf in the commit message
  - v1: https://lore.kernel.org/intel-wired-lan/20261104013606.1527767-1-namangulati@google.com/
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 885df6294ad94..7383d8241ead5 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3745,8 +3745,10 @@ static int idpf_rx_update_bufq_desc(struct idpf_buf_queue *bufq, u32 buf_id,
 	fq.truesize = bufq->hdr_truesize;
 
 	addr = libeth_rx_alloc(&fq, buf_id);
-	if (addr == DMA_MAPPING_ERROR)
+	if (addr == DMA_MAPPING_ERROR) {
+		idpf_rx_page_rel(&bufq->buf[buf_id]);
 		return -ENOMEM;
+	}
 
 	buf_desc->hdr_addr = cpu_to_le64(addr);
 
-- 
2.56.0.455.g6c5a503b38-goog

