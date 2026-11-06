Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793985288;
	b=p8ybR7tG1pUgJJ7eg2I9HhDg0yl8wTAGADTUL63Qbc4SBJ5etBplNQfqdepwowXHZFUw
	 y4VQMSBkUShbD9CudzzTo/QIbzJOflvknA95lnBGQ+zZnp99Uvm5i1bEVXo7SJon7T8TT
	 DJQsIO6ODBGWbPU+4L4Hrq77RzxTedUB74e6744gMTShQu5MGx4LYpVgW32eu5v8BWv9l
	 +3TJNBFJRkpg1GJDDQK3EcpF5uvOi5mMv0AcrWL9pwFXFW3O4o8hu6wUDHOCUFViahoIr
	 jiPIlX5qrRrlIb3g96xKWqFHQb6GagA5KiqbdEqRBDf7K9aiQT0CO6t0DU8TwQpDTAw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793985288;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=npSSNgqjeDjy8yeV7j2uv0PIl6Tg9TTaL41tLSP/LLk=;
	b=F3pHRzTWn9t0dLRStgOqZGX3OnuFRzvRw7b/cJwHpB7IKwlDLCsMAnyHobMRFFO4owhm
	 Kx45mQr7LkX8N6qNQbFLHfoO46dBU5dWuqSiYzAdiq1wAot6hjWwi9aIUwksw0TUCI/7h
	 INbtZr5DJ1JVnpzb66aZWodZHDs4lVynEHWA/sc79F9cwPoAYVdWoKjymHJEnL9fYi7BO
	 HXHFTq/P4YFo1aRifacYvIAGcDf9505085NVakXCQIvz9jha/v9NfCNde4woKYuOwIAsb
	 68MZrXwzvgpju2AlmQdHqnStPIX6cKNfF9XshbeltBzDyZUSXO9Nw0V9GIKly9RU6Bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fzybGRN7;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0A8606A337
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 17:14:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B0A8606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fzybGRN7
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso5733385e9.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 09:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793985286; x=1794590086; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=npSSNgqjeDjy8yeV7j2uv0PIl6Tg9TTaL41tLSP/LLk=;
        b=fzybGRN7Vrij7P5ZSgvy+kjz2qjkPQLHTUD+avlpUTUi+3GXQwFtpab7vPsfLxMvY/
         7G/t5jTCVR6KSoLIERkw6KsBaX5X1B017xkHIFQBVTi9QwVMS6d4O/GJE8WjL0w8fQyN
         F6lpO994JG1Saksrnbk0vIO01qesDJ1IK2z4astuNkvPORb7ElXGnXztH0yt9DiD7DNL
         HajcbBhwT53x0XMnEfNWA0uzRagFhJR+bXvl3QUoUD7RpAPMrRyHGLF4fesvG3AaHIAw
         IJHdHsAWxj80QNhhZ5VxyoqSS+LrZBMsjhhc0SQ/Y8bYjyxAi31m9TsdllbkzSolTel0
         YSvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793985286; x=1794590086;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=npSSNgqjeDjy8yeV7j2uv0PIl6Tg9TTaL41tLSP/LLk=;
        b=B03ofQAtttkipYhbgMoafeVXcJdRt0XBL1eavm7WPPUoUuXQdY+nL7N/N5pS190UTe
         2LjVbCxAK5s6UHUOUbsPltDbsWNamGnoTPYAjZxLo4hLIxwhkNzP//QWUyMCfz5aG+m/
         PEEy/DmqKE9gzgjGhHmx1fmSWI9qMvOCr+h/9n/MHd4jOaDbhvPqKj1CczqgIIjc7ffm
         ROPeucuGPQISX2sUPC7zptCJy12Z0ByyLDl5cak0QJmX82gDrPjYAYBj8hfMHht/ZCTH
         hi4z3orZWMnKLqliOS9J1E8Kvg5nmo7fSXdAcdlPfj4vdu2Dg47CXsWl6w70wvqMAqtb
         9OXw==
X-Gm-Message-State: APuU4Z/R479uumD1GAdmWLNPQJ3DiTp7fBJCbfZfXErtZizLA9F1G0SA
	Q1zi2KBOOcl4y68ZMEZ7IZ14h7QxLHYND8ZOgTAORvxm7ZuUmkDrXDgf4Bpy6FJz
X-Gm-Gg: AYBFou3JJNgw2JizgTiyE7zBVvltrDdPPB81JSbyzLHBTBiGs/9gjidKSD9ms6nYsnJ
	JH2tqGKmDcMNMoCprUqfnq7bTc+wnRdFkNEuyJ8KNf+jGDm4nprrUzgTFjFQVIT86gsrxHIeIFq
	Z+2+z3uLLQSfu0YJXi50OLJpYRxHn7JSbyG0KrSOPo8EohHhNVvlDQ9bM1KxInzJHpklV3ru0AV
	NoZKuik9PkZB6yBxf31wlp0UDysIB1+0z1g9ZZB2QO6aMpypYEau5l9YTkLfDQ/9KQkJiWsYeOO
	MtkAw7QSQX0ezcQSVFCLsU6eD+6jg5KSJtTwFdbcs5++FQ0dYaYzE8kSZpAjbcL9q51GPOt8yxF
	jt1ihA6yfl0wEGhf9ONolBEM5NGq2K4KgRj2ErVcS8/FltNFsjtTLIqXj8+jqCIGRPjLjCkEsLM
	4YJvsI2F8BKZt4daBpfFCw63ymSchtm/5sBNa9vFfo8FuQ/64AEk9pB5Fw8UjTvUtjBDxS/bgkV
	xdyc+ebbbz/2AGX0T+2h8g1ugwEjQMut5QxXFcHGhSBvaGCr50A3KI2cEPg1C90ZxkY+NHsW3i4
	QEV2PubWK/igPwhgvYWBJVBeRfA7Hd/FouDTH5SrbEe8cxFOX+kudt9M4UD5Yh9zE0AvJx4+7zI
	TFGMTNTU4szFYa9P74WHd0Y+6UicjB+AvayNFQQmw5hMQWhbdJV0AobMoE3ZMfQO9HWDsQZF1P3
	NR4gflks7kf7eBjV5m4G4+pZdOdpfbxeRItx3NeeFeVxGbquJCzSHlsm/zlEktSA==
X-Received: by 2002:a05:600c:c172:b0:4a3:59c9:a747 with SMTP id 5b1f17b1804b1-4b6df5e88admr49637345e9.17.1793985285709;
        Fri, 06 Nov 2026 09:14:45 -0800 (PST)
Received: from localhost.localdomain ([90.95.39.175])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b571f46489sm148071985e9.3.2026.11.06.09.14.44
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 06 Nov 2026 09:14:45 -0800 (PST)
From: Florin Badita-Nistor <baditaflorin@gmail.com>
To: netdev@vger.kernel.org
Cc: edumazet@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v2 1/2] tcp: avoid false bind exhaustion with odd-sized port ranges
Date: Fri,  6 Nov 2026 19:14:41 +0200
Message-ID: <20261106171442.31811-2-baditaflorin@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20261106171442.31811-1-baditaflorin@gmail.com>
References: <20261106171442.31811-1-baditaflorin@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

inet_csk_find_open_port() rounds the range length down to an even
number but keeps the original exclusive upper bound for wrapping.
For an odd-sized range, the two scans can therefore miss a valid port
and return EADDRINUSE while an eligible port remains free.

For example, restrict a TCP socket to IP_LOCAL_PORT_RANGE [40000, 40002]
and hold explicit binds on 40000 and 40001. bind(..., 0) always fails,
although an explicit bind to 40002 succeeds. Both IPv4 and IPv6 TCP and
MPTCP are affected. A namespace-wide odd-sized ip_local_port_range can
also trigger the failure without a per-socket range setting.

Keep the full length for the scan bound and wrapping. The two scans
then cover every candidate in an odd-sized range, with at most one
repeated candidate when exhausted. Even-sized candidate sequences
remain unchanged.

For odd-sized ranges, subtracting an odd remaining value when wrapping
flips parity. The first scan can therefore also select offsets of the
parity preferred by __inet_hash_connect(). Namespace-wide ranges with
same-parity endpoints already trigger a sysctl warning, while connect()
uses step 1 for a per-socket IP_LOCAL_PORT_RANGE.

This only fixes bind() allocation. The rounding in __inet_hash_connect()
for namespace-wide ranges is unchanged, so connect() can still miss a
port in an odd-sized namespace range.

The issue was triggered while developing port-range selftests with
Codex assistance, then confirmed using userspace reproducers on
unmodified kernels. No kernel instrumentation or fault injection was
needed. Booted x86-64 KVM kernels were tested against the regression
selftest, the full ip_local_port_range suite, and a Go net.Listen
reproducer. The Go reproducer fails 100/100 times per IP version before
the fix and 0/100 afterwards with a three-port namespace range and two
listeners occupying its first two ports.

Fixes: ea8add2b1903 ("tcp/dccp: better use of ephemeral ports in bind()")
Signed-off-by: Florin Badita-Nistor <baditaflorin@gmail.com>
---
 net/ipv4/inet_connection_sock.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index e56beec43..755fcea35 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -343,8 +343,6 @@ inet_csk_find_open_port(const struct sock *sk, struct inet_bind_bucket **tb_ret,
 			low = half;
 	}
 	remaining = high - low;
-	if (likely(remaining > 1))
-		remaining &= ~1U;
 
 	offset = get_random_u32_below(remaining);
 	/* __inet_hash_connect() favors ports having @low parity
-- 
2.51.0

