Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED3A23A561
	for <netdev@vger.kernel.org>; Sat, 27 Jun 2026 02:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782528037; cv=none; b=LlgGQA00gmLQadREcNf7x0iNRJITabpmleT3dFRL2F1ICi/6A9DWu3jvH1sIvMTJ/CPJsgaau5wugkT5JeYDcMwLdOL/LpqhkB83O8bU1IXZ26HepUnUAmuxBhLzKvL5nsgdDQaOfT9fywIXSuXwldkKhjDw0cNcf3GTuTqd5pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782528037; c=relaxed/simple;
	bh=ieYswKICtre1rnsgvSMIMGQG5zoVTxccIjlV8Hnu2A8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GKYjP9iokHsv0E6fE5U8KyaWhsR6bXd4MvqZYQrurC/W1BGq8Ive431V6lZYXluMulrYjQeQVUG7xM1qx/yHA8riqGj/77u2GSUaumu3KhSWqP8qp5PqTjKpGiDgL4kLSENsjWSqmOMr8OM0Hzak3O9/8X8+Q29JPMuid2V0M9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu; spf=pass smtp.mailfrom=asu.edu; dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b=cV8wPGHZ; arc=none smtp.client-ip=74.125.82.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asu.edu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asu.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asu.edu header.i=@asu.edu header.b="cV8wPGHZ"
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-304f590dd91so2160943eec.0
        for <netdev@vger.kernel.org>; Fri, 26 Jun 2026 19:40:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=asu.edu; s=google; t=1782528034; x=1783132834; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1wsPAh2y3yfSexXiOM28qxBM4x0Sra68O2XRY3OksBY=;
        b=cV8wPGHZtDxe3vbI2OsLsOizsD4sJFlAMXQoAj9iSFngLs9PmfYOf7h94ui5MRrz37
         hoOwL83lONYVDMzdyU/4kKeOuFNkNc8/JTFAD1fPDLmj+RI31OUIO2Ad0WbZWg1LOvau
         LWkmqmsfDFu975j4k/aIIUEANoGXS2DMoHHzJfufSrKF/zFg3aHxSROT0lNbeg2DmnuA
         UeluJ4n6i8OE5Inojz+wLpztB0sPd4XV7YuUqc+/n/nntiqqAe2UEeUz1Be1cr6qYW8C
         gg7+1367GRHevJN5+oErG0AMA8Kem70cnis0TTVe6mZIIOxkDPytithJylwpA5B1TWil
         0c4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782528034; x=1783132834;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1wsPAh2y3yfSexXiOM28qxBM4x0Sra68O2XRY3OksBY=;
        b=HVXQJ4i3cCstzWGplslLhLtFczO60BT0rp9/MwS1td/qYNgyl3flpVJ5tnDhN4ie/+
         HFvfnYBtclwPeF8meiLa+ebSYGWZq0/WI22HqaPlxYtdNuYjwNFHMH+a3XcN/lcjJhn+
         +nm+EG/vmHbW623bbN0yfKY8Xk47CeWdQtbRfjeMumKkSOfDdJwyNidI7Wxf4WbfIxTH
         TdSDsVsi0S2ny0nwFq35AOhseOAE2ii+G4tHnbWoFt6UWemL95+VJMCOm5miKcfvNBRU
         uh9QNjYGKlxqfYTr5qhtLlxQXpxiORaQj0wnBrLqs323jCf4Ik+/hJKWAm98UNvA7ieW
         nHHg==
X-Forwarded-Encrypted: i=1; AHgh+Rq5v4vdCitsNv7TZphPCYL7DnzN9BzYQ5cMs+7vdFGHyVVsopqHu9cXpIgXWM4SykwvqPgmt8s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2rRzP32XLnitRAlIfLeiD6XlkEoThPmsNWOVINv8ArVUQ6ltO
	lO4wnWjm/M6lDxUFNXKq2C2ml5xN4OKholwvVcPZAeXPWXbaQuNdIbj60eRVmmP/Ng==
X-Gm-Gg: AfdE7cnN0wtcKrdP/GtSZc0ZS1eezPL8drmL7o38phsH5P9UzHDi1Q/M6Kr/WnhPicC
	C9G99CdrxHFjG484HEOsqRUA8lNVrbHXg99ZlhKjWvtOTFz8x4jqeW+Ds059Dn3srjpUv6xCjqF
	TGpNz/sneJbo8nbPw0cFOVqFI2CjBxWKUlNpWC74h48LQtXbI7YU6I7jnRrH7QOQIi3aodE3MPt
	jvQVTyt4KuB4+pL5/T52q+/OcQtbxs+cA/BFNR8zJ8l9NxrhzR33xBpe0VhQwhDSmKs98n3ku8w
	GvDobVOebkfjJRJ85KV7SeemzkhzH12ABaSPNuouNeT1E9uwpNmWC5VhoMzp7qXrvgLLrpVJ2er
	RxAR2VH+7SMyebtPB5EBO11L3WbRkrPQEwO4vIm0dwDyl8flq//HioYZszxx+2CHDOx3U3cSENn
	/QV/ssFgXCkI4Kijtg8A==
X-Received: by 2002:a05:693c:3944:b0:30c:ab4d:3829 with SMTP id 5a478bee46e88-30cab4d3bddmr2004410eec.43.1782528033566;
        Fri, 26 Jun 2026 19:40:33 -0700 (PDT)
Received: from xiang.tailc0aff1.ts.net ([20.171.14.70])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-30ca5f15024sm9530585eec.17.2026.06.26.19.40.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 19:40:33 -0700 (PDT)
From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
X-Google-Original-From: "Xiang Mei (Microsoft)" <xmei5@asu.edi>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	netdev@vger.kernel.org
Cc: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	"Xiang Mei (Microsoft)" <xmei5@asu.edu>
Subject: [PATCH ipsec] xfrm: fix sk_dst_cache double-free in xfrm_user_policy()
Date: Sat, 27 Jun 2026 02:40:23 +0000
Message-ID: <20260627024023.2201160-1-xmei5@asu.edi>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Xiang Mei (Microsoft)" <xmei5@asu.edu>

xfrm_user_policy() clears the socket dst cache with __sk_dst_reset(),
i.e. the non-atomic __sk_dst_set(sk, NULL): it reads sk_dst_cache with
rcu_dereference_protected(), stores NULL and dst_release()s the old dst.
That is only safe if no other thread modifies sk_dst_cache concurrently.

For a connected UDP socket that does not hold: the transmit fast path
(udp_sendmsg -> sk_dst_check -> sk_dst_reset) resets the cache locklessly
with an atomic xchg(). A per-socket policy change racing a send can make
both sides observe the same old dst and each dst_release() it, dropping
the socket's single reference twice and freeing the xfrm_dst bundle while
it is still referenced:

  BUG: KASAN: slab-use-after-free in dst_release
  Write of size 4 at addr ffff88801897b6c0 by task exploit/155
  Call Trace:
   ...
   dst_release (... ./include/linux/rcuref.h:109)
   xfrm_user_policy (./include/net/sock.h:2239 ./include/net/sock.h:2256 net/xfrm/xfrm_state.c:3053)
   do_ip_setsockopt (net/ipv4/ip_sockglue.c:1347)
   ip_setsockopt (net/ipv4/ip_sockglue.c:1417)
   do_sock_setsockopt (net/socket.c:2368)
   __sys_setsockopt (net/socket.c:2393)
   __x64_sys_setsockopt (net/socket.c:2396)
   do_syscall_64 (arch/x86/entry/syscall_64.c:94)
   entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)

Reachable by an unprivileged user via a user+network namespace.

Use the atomic sk_dst_reset() so the cache is cleared and released with a
single xchg(): whichever side wins releases the dst once, the other sees
NULL and does nothing. Behaviour is otherwise unchanged.

Fixes: 2b06cdf3e688 ("xfrm: Clear sk_dst_cache when applying per-socket policy.")
Fixes: be8f8284cd89 ("net: xfrm: allow clearing socket xfrm policies.")
Reported-by: AutonomousCodeSecurity@microsoft.com
Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
---
 net/xfrm/xfrm_state.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/xfrm/xfrm_state.c b/net/xfrm/xfrm_state.c
index c58cd024e3c6..08ba6805ddb3 100644
--- a/net/xfrm/xfrm_state.c
+++ b/net/xfrm/xfrm_state.c
@@ -3010,7 +3010,7 @@ int xfrm_user_policy(struct sock *sk, int optname, sockptr_t optval, int optlen)
 	if (sockptr_is_null(optval) && !optlen) {
 		xfrm_sk_policy_insert(sk, XFRM_POLICY_IN, NULL);
 		xfrm_sk_policy_insert(sk, XFRM_POLICY_OUT, NULL);
-		__sk_dst_reset(sk);
+		sk_dst_reset(sk);
 		return 0;
 	}
 
@@ -3050,7 +3050,7 @@ int xfrm_user_policy(struct sock *sk, int optname, sockptr_t optval, int optlen)
 	if (err >= 0) {
 		xfrm_sk_policy_insert(sk, err, pol);
 		xfrm_pol_put(pol);
-		__sk_dst_reset(sk);
+		sk_dst_reset(sk);
 		err = 0;
 	}
 
-- 
2.43.0

