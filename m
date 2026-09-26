Received: from mail-ua2-f42.google.com (mail-ua2-f42.google.com [74.125.226.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA77377ABF
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 21:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.226.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790457660; cv=none; b=c2UPAxHG7ixa1by+W7oF8KBKwtj1Iws4bHqKzauOC2H39j/xckREb4evR3G0tt2voqjSUEuXf7uMsPz2WDZ8rUYxpuCmGsgYMnSEkAwT+DpAkP231D2vwj4C6u2MTqV83OcdjP6JtgbdzzdvG4VU51/oxSWbkZ4d1nn+ygtiXvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790457660; c=relaxed/simple;
	bh=ehymt4lLAFUs4DIWG3dhPtmab2vi6Zhi6J9yEIZNRNQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Qw8z9NZa8NYFDVIezFBeN60ETY3FysC+eILI2hwlZ3LQjAsmrN9oh6eQfKfScE6jDqvOj0Y3GrNp+sCCXURHXf7Eojo2B+JW4K4Nx96UFYq10rnk8AAOLabZB2jaC6bOUE7CfUbZ0yJBZHSc/+zmWQpN5aiEB1mjzqEpoN0PyDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+MRx51u; arc=none smtp.client-ip=74.125.226.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+MRx51u"
Received: by mail-ua2-f42.google.com with SMTP id a1e0cc1a2514c-986e0b83340so1139715241.2
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 14:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790457658; x=1791062458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=D3SALmSygZKgLrynJMWzH3B1y0jcmXpTFsBEcTzacV4=;
        b=Z+MRx51uyUvTVii6pR341bKrYPsPvdfuI26qyCofZjsMWh05nFEETTLOp+rrCNTIK3
         VpPCjW2Xhlyyc7Nx4Y1Vtzzy4utwz5/g0cpQws+vKF9rgl2R8ZwyijzZyToOgwWI2HCk
         OLaD8coRLdV1/7xEMQONnGVmyLG4JkpChfAuZRhWybZqS6DTQzgayjlfPQP8SKc+7Yl8
         bt7vQlQis88z1ThENRlsobeiylSp3MJWjumHqn4M3mrspLjUjgyJ65u7v8J9LOnLjD+s
         fWYZW9cotNZpIX9asE9aKf5fU74LJ2QgrAr3hRxpKomhvs01QKarbeCnmflKiSPe5+7T
         vMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790457658; x=1791062458;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=D3SALmSygZKgLrynJMWzH3B1y0jcmXpTFsBEcTzacV4=;
        b=et+CwQFMKbdhwuk3lpmlI/2NzOCnLI/1XLOepVJeHLyWeWZ1RoBhKkCrUlPGJhF1Su
         bq5pEv7kyh5+1vS7aFN6WvvxYfTMtPhSnMhYySkWpQkagwVD26xmYsRxH6/MbBdgD76J
         AY16iP5QOsR/OHKFAV0pTBGgKYJS8AB26Z7qHK5RSys9pgFcov8u0Ojhc0eY12WygA8c
         Dhc2kRvfQSx9SyjfmFcxbS7bakRfY7MJSqZ1t2qIC7Ev2KM3aj8TOK2+JKpmoh2UWamN
         3fNqqjpmbY932/fJvz9tKqGQ6iZuXUWPuGMavPUoYy1p/DtCeIEsqiKSs7YjcwKpRPgs
         6IJw==
X-Forwarded-Encrypted: i=1; AKwUvBwH3Xx1k3j5QiomcrwAEr9xkGdZpKH2x33xBljD1/ILX3pAMIsY1BpFj8Lmqjcmk0KAUfjWZBc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJTzgsWaeN0ZjFQnOilY9M7B+dT/vmsIv5hkBdf3sbhTwrCc5Yk
	nQg3772N4t7cAQ/C9lUc8mNTjwxHHza6UF2fcRoOJLGTMyPtvmLYM8c9
X-Gm-Gg: AYBFou3kQumPtiqCO70J23zhxXDaddkKsjnMxlvL4iiY3LXFG/H/9WGSt4c4UNE0kdl
	wlKgG+W3JN2cValYgwV8iRWmDbzy2P8PaOrNb3jm7VlXy8VoQ8ttApqcD9pqwG6kPLAvjDwmxbN
	lxbLxWYiTroC8SjCNaQcz/LysZMOxk/mNswaGLu57y0/kqLtQmSW1Qz20kzT+2BeA1WVPx2DSA/
	38/NITG56mv+/PDZ4HyibrmO3XzSJxzq9+U4zaf21j77s7+5Cti5yzX0w/YcUfk4bnCYjvhrf9q
	jmU4UwMz051M2pZ6dKNRbcLc/gkSD3QblkFU0x5LQdlmztwOrDzHlyRAuqNXaLIYAoYMHzVngpc
	awGxp8jokjZfuBSwEx1Jl8IMFlmACoX5ccGwTxPEPlYorjny5KGXZPK3Y48ZLQgSlvd2szCIgh6
	nh+x65Jaf2/tswtgsC34Xh64amlCALqRsNsV/WCqwFItilTI2Gv8WPNsTO7n5ZHzocsiexNVo7I
	w==
X-Received: by 2002:a05:6102:4b11:b0:7a7:198b:674c with SMTP id ada2fe7eead31-7af1f3f3a90mr3668073137.33.1790457657120;
        Sat, 26 Sep 2026 14:20:57 -0700 (PDT)
Received: from beelink.. ([187.13.30.172])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7b39b9ae253sm3267723137.8.2026.09.26.14.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 14:20:56 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: david@ixit.cz,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>
Subject: [PATCH] nfc: llcp: clear device pointer on disconnect
Date: Sat, 26 Sep 2026 18:20:41 -0300
Message-ID: <20260926212041.1342558-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nfc_llcp_recv_disc() drops the device reference via nfc_put_device()
when a connected socket receives a DISC PDU, but does not clear
llcp_sock->dev.  If the socket is later reconnected, any cleanup code
that checks llcp_sock->dev will find a non-NULL pointer and attempt a
second nfc_put_device(), underflowing the device refcount.

Clear the pointer immediately after the put so that a subsequent
reconnect does not double-release the device.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
 net/nfc/llcp_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 74bf81700..199543c47 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1220,6 +1220,7 @@ static void nfc_llcp_recv_disc(struct nfc_llcp_local *local,
 
 	if (sk->sk_state == LLCP_CONNECTED) {
 		nfc_put_device(local->dev);
+		llcp_sock->dev = NULL;
 		sk->sk_state = LLCP_CLOSED;
 		sk->sk_state_change(sk);
 	}
-- 
2.43.0

