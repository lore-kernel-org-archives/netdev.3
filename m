Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5593DCD95
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 10:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790417050; cv=none; b=uIqvOuHZChdMOSdtL82UqD7mJLamrjIFDZTiyzKzeuagJiixBJcOdlRKgmiwTdVULelaZ12vmb0uv2KVCGSBec4MdNiPtg9Hk1lzl5yEBP9OIWht0ZKqn9WF7RKZyjAJ0bgE4eb0/fsNvJmw7PFoFhFSmevNhzHZlqVqRAzSns0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790417050; c=relaxed/simple;
	bh=NOFvYIzMe59oRg00wo/vPLaX5v5lix8k0vP6rv1OWrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tkHHPD8VCOc4w4a0kbIg+ZGCwb47OMTkWJHn8b1MXXL3LEDRIpAodCDXI3w2OpPimw+IZCQANgkuVNvrXSa4XoArA4b8zlbKxS+PTKcuXof1qvKsMVzfepNtQKrhxyi5PBWRJ/vlo7aFsLPKOe5JmJHNZzULOBrNWtkN5E8E2hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iV4U93lB; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iV4U93lB"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso857482a91.2
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 03:04:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790417048; x=1791021848; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AJU1rtsDPsuoX/UjSP5YhpwRW3gJBK/2ZRn5HWHEarw=;
        b=iV4U93lBCT/jdrUDAGQAmalaFCeHlfUb8gBCUwyZuQwD5AA9Mp/1rK3Eo4LXj2Rftl
         b5fdO4HGFOI102rGLsRzXVwuarb4Y1D29hiKtkBHGCZrFt7lMrk9S5ATMJXmSjf4og84
         8qF5/psBtR9dBR38EuTG4cL7QL3v0LbH4n0zw3ZOts1aJYHx2k9hunB62dW2fdToIh3o
         W5GI0Mv6uH2Lp0RnLGJp3LLxSkcvIkT/pLk+zJ735z2XOUvoVxNMdJC1toaQD8J7K6Tm
         UMJXlycSNzjohzIRxdBVYVTHx4lP2+G9igoN6W1+k9GSyYzH6cAnL8QL8saIeF/twYnu
         9rPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790417048; x=1791021848;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AJU1rtsDPsuoX/UjSP5YhpwRW3gJBK/2ZRn5HWHEarw=;
        b=Ixriz6J+IwS1T5Zzke0AQA1trsZPysnyRugaPNhEz4RwfmKbu/Rr6sBa3gvVb5/3yV
         2fcMJCMMRlVEQhyGSSBniI+ZV+6fbnrjSMuvqQ0x1b7ywsTgNPVhXowQ3Py4OEi3K72O
         xcuhNrCzI1oT9BRkKi++LJKTwVWHyFzo+2QQxdfyl+jwlAVVoUUGUCFspm5OLofAmAL1
         hsoOqBVxxsXBXrL1PeN5hgo5xI1R4SJlZhsuKtub6RyoZiG9jII+LKRwuhG1dshD7Ocl
         8zu56UYAFr0KW8jORPFEoSl9K3U1yPP+u+Zp18HzLnv6UAtA0G4Axj0uKLnfSfc0KM7R
         XXnQ==
X-Forwarded-Encrypted: i=1; AKwUvByRqQrnOi/tSUG20vE7ifHKz7NpEM053O6Qg6YtcIXMRm6ZbTZEi16WPbhFIXIvsBnpEjTJoi8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLrYfRPL9rom4aJ9b9i4uqAAVAc1+JP5WJ09S1goszYCzyQD8dN
	CWD0q3Vyptd2QByb/otskx8VW7lVmQbZvZ3e0Sj3celDuNC8nRpHGUJm
X-Gm-Gg: AYBFou0RgpKGQ4UObqq9twGPZy6KQ4TXpCULXDfRCTFARw4RcIEjA3BawfA2CqxFtYK
	8d+QtTsDlh4dMRZqxVf/Wn69X00ToZo3bzbeeZ6SsABqDpLkcYRbbXCeD00hkAK8ubilSVM9pBt
	S0zBBv0dq6IWmdArOa/AYcScWR9F+PdEssopE5hTAurDdmue3nDNb4aTyJYY2A7dwHry6I91t/4
	iU1z5Nj9SQnejuietXG5URyMwSWUM/r3gGVGOyuao+IbGcx+Oa+IBKDycSUbDoYarpG+S7GjzBD
	lrnDn2XUSntMiUkzzXO0DFy1bO3423ijHkW4EdHWtp+NjyZaVQl/8y/vrwBEued8NanKih6BFHO
	1F1DI7QiQucFSUgFVoUtHQztJfLISWnWXHhUNa6zs2SbeW8KHthQcKCSsL2IOffUpX62/wpqSIZ
	lbM9NmKoLu70Ye9UVWO3yh8Ukclk+XgaFG8X/ovhzNBhfjoBrWIjzyHd48N9rmW457b1c6/MVsh
	xk86pvAZdsVJeb6ABAjDVHcXss2HG8ZA7c1mySQHXuthxF+6FJVAvR3Xw==
X-Received: by 2002:a17:90b:48d0:b0:3a0:e22b:1b16 with SMTP id 98e67ed59e1d1-3a0e22b1df8mr1010759a91.25.1790417048136;
        Sat, 26 Sep 2026 03:04:08 -0700 (PDT)
Received: from JUNVYYANG-MC1.tencent.com ([43.132.141.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0c719f86fsm6730826a91.7.2026.09.26.03.04.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 26 Sep 2026 03:04:07 -0700 (PDT)
From: Jun Yang <juny24602@gmail.com>
To: Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-sctp@vger.kernel.org,
	netdev@vger.kernel.org,
	David Lee <david.lee@trailofbits.com>,
	Kyle Zeng <kylebot@openai.com>
Subject: [PATCH net v3 1/2] sctp: hold shkey across socket migration
Date: Sat, 26 Sep 2026 18:03:57 +0800
Message-ID: <20260926100359.78731-2-juny24602@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260926100359.78731-1-juny24602@gmail.com>
References: <20260926100359.78731-1-juny24602@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: David Lee <david.lee@trailofbits.com>

sctp_sock_migrate() transfers queued DATA skbs from the old socket to the
new one. skb_orphan() invokes sctp_wfree() during that transfer and drops
the skb-owned shared-key reference.

If userspace has removed that key from the association, this can be the
final reference. The following sctp_set_owner_w() then dereferences the
freed chunk->shkey while trying to take the new owner reference.

Take a temporary shared-key reference before orphaning the skb and release
it after the new owner has taken its reference. This preserves the selected
authentication key throughout the ownership transfer.

Bug found and triaged by OpenAI Security Research and
validated by Trail of Bits.

Fixes: 1b1e0bc99474 ("sctp: add refcnt support for sh_key")
Assisted-by: Codex:gpt-5.6-sol gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Acked-by: Xin Long <lucien.xin@gmail.com>
---
Original submission:
https://lore.kernel.org/netdev/20260731120558.558957-1-david.lee@trailofbits.com/

 net/sctp/socket.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/net/sctp/socket.c b/net/sctp/socket.c
index c7b9e325ec1c..4a08023d52aa 100644
--- a/net/sctp/socket.c
+++ b/net/sctp/socket.c
@@ -147,9 +147,19 @@ static inline void sctp_set_owner_w(struct sctp_chunk *chunk)
 
 static void sctp_clear_owner_w(struct sctp_chunk *chunk)
 {
+	/* Keep the shkey alive until the new owner takes its reference. */
+	if (chunk->shkey)
+		sctp_auth_shkey_hold(chunk->shkey);
 	skb_orphan(chunk->skb);
 }
 
+static void sctp_set_owner_w_migrate(struct sctp_chunk *chunk)
+{
+	sctp_set_owner_w(chunk);
+	if (chunk->shkey)
+		sctp_auth_shkey_release(chunk->shkey);
+}
+
 #define traverse_and_process()	\
 do {				\
 	msg = chunk->msg;	\
@@ -9632,7 +9642,7 @@ static int sctp_sock_migrate(struct sock *oldsk, struct sock *newsk,
 	lock_sock_nested(newsk, SINGLE_DEPTH_NESTING);
 	sctp_for_each_tx_datachunk(assoc, true, sctp_clear_owner_w);
 	sctp_assoc_migrate(assoc, newsk);
-	sctp_for_each_tx_datachunk(assoc, false, sctp_set_owner_w);
+	sctp_for_each_tx_datachunk(assoc, false, sctp_set_owner_w_migrate);
 
 	/* If the association on the newsk is already closed before accept()
 	 * is called, set RCV_SHUTDOWN flag.
