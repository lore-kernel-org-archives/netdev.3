Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977AE364E89
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 21:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789853330; cv=none; b=oHECOsmtoW0tkGr13+f4CfNXkpHZyXEgTPwqmzeRdgzKFTxfTza7MvvjEuodRJiYvL7Zaxif2bj4zBX8CJ179P/LpAqMpnSgcjnXGnJuEkBfbThZu/hpIgwQl8s9t0S7Q5N07GF/ho61Oa9qw3e3jFKtTN4AMet6qnzFYmFRP3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789853330; c=relaxed/simple;
	bh=txBOqJNUqUZdel+9yUNyCOiCDqWDPLD8LNB84oXPLPY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Lj2PV3D9pop5Ngwxp69yrY1XrFCoPsFV0t4TtsrZNH0azBWCS9oAaMwJbMredZTqmWQVgqIlbnfe4arbc7v8Fl2xBJTRr1eSDM8AA5G/7gRPSOx+4cU/YSkaitkF61KkbkVlSZV+Fc9/0IGmhP8ffjn0gmsRZF0njH6wKjzjz/E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rIXvWwE9; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rIXvWwE9"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39b31b4281eso1882820a91.2
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 14:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789853329; x=1790458129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=eGfBY0P65oH7gmD1rjRA1pJgtFrGgNFWTZNcEsIhx08=;
        b=rIXvWwE9MJ8ClY7NHE0LoGMHaCwYyQFBbP62Yi5a/dygd/DbiGFoaUyl6mw4CT0uhi
         3kXKgsBo6swtb6ZYlXENiGdHzyv2WvR9xVFBdzfPgdGi+6rnDopzzwqHNOAc0jyQpEtv
         qHhFccSeqP3LXA1sPZ+y0gtapUbgn/nT8YvxKMparIc+f3JNjBbw5yxM2i0qJYdqgHu1
         IXh1Hf6hsZZgMweFq5RwjpFHdMdHWi19JpRFpFfJmCLReUoI4ou0JYXktu9zzmUUQH8K
         qm/PqFYC90UUw5a9OVm0rU3+Axe/XGytal6l7wFnZPQp9Yw+YfGuyJ+c7HmXlWCa9Klu
         4Kqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789853329; x=1790458129;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eGfBY0P65oH7gmD1rjRA1pJgtFrGgNFWTZNcEsIhx08=;
        b=cwJmsHclao27IPFLmoVqOaK2sBWvkRluuHnxlJ/765Pk2UVIuinwRb3/0q23Nu/vCI
         u9zW1sVJYBunZsUjhMYOlBP42zMSDDfkuJpJDTC2WXk3nkLXhGIdebidT5G5kBCtRAtL
         E/Lo/1NJNdSp7sLBYxc8pC/N5Aq8sa39reF5Lfxgo5BbMVmhrBpFMGdMP0/b3iKMSMmg
         pzTG46rovTMC57pGeOPM7TmYiiJdsFJRVNq7EbhGsgTfoRjQtu/qyhyayrMDH9Myt8cD
         Mlt8tjmwcQut0H4MbTDVKHrUpz3FiwWp6paWgHdqfahCUy78XkPNXYN6EX9plvyOmJi9
         bLqA==
X-Forwarded-Encrypted: i=1; AKwUvByx0OybGPgmrkwHrazFi3Z/2DwpdutYJMCUiQyfbJ+U0EG/AzuKcc8aMLKTxkO1+mnVzqBrj1w=@vger.kernel.org
X-Gm-Message-State: AFuF++lClL23Tmx7lF/orfjuYxuGG0gDyUBnOIHfXqJmXfGjK/EKLAe1
	xPNcbXdyUAndwLi/SoRTtInUTkE011rgWacPwpKFq1R3K1pDIfld7Yr+
X-Gm-Gg: AYBFou0G3wGJbqQM1TiKD/N7RWTlMDr7M1NDn3rT9ISvl5tq7NSkPgLLq/0S0i+fEUm
	BTJPU8aYl0dxlTlKrnKm2S69YAbK9Q5VPrHkQQ0NHToQVmG+pIVIv4Dap1zMPLFS9G5QIdBsWVs
	DmPzRGBdzns8/anAL9wUm6YDNZGTO8K7sXHjAS/wi7rsN9zSZ+v7Fu0yYdeMNNZKptN09+Qns0/
	1KEtaTNPgG/QB9r92zfgQKSW8zatndfqOBFwpm4bNixWrz8ANoRG1my+a+9YynzfZ8tsS1o9Vcj
	kdfydt4mTSVNsSSF62ijnpOqX0I+o2QG1oA8so0ijzrQ/8KkSt5DJrxTN24l6k9X7bfUsqbjpTB
	PANC5rZgUTwimJdSJZUQMyWrvSkKUKF79If7w3kZDwjERVv/9sbRU9jo8jfW1j370xiplr0Ai2W
	8EfWzWkeobUlpTxq+aJ8xJTzpQny3a2XP5aLDzHNedszQX00d7xxzQQBeLJp6Ok4LSDZiN3Sfb3
	t1/mckURAwkIYRw7YIvEzNe3e9AFpvunZ6hoSzQT4tWQhBVY2dtSqbJNgciEyqBl+gXYMLsk0W5
	olsJPuV8gQ==
X-Received: by 2002:a17:90b:2e0b:b0:39e:6c68:c78a with SMTP id 98e67ed59e1d1-39e6c68ca60mr4787983a91.64.1789853328817;
        Sat, 19 Sep 2026 14:28:48 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a026898b76sm3869604a91.16.2026.09.19.14.28.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 14:28:48 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: mani@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: horms@kernel.org,
	linux-arm-msm@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: qrtr: use u32 for port in qrtr_port_assign() and __qrtr_bind()
Date: Sat, 19 Sep 2026 21:28:47 +0000
Message-ID: <20260919212847.3239934-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __qrtr_bind() and qrtr_port_assign(), the port number copied from the
unsigned `u32 addr->sq_port` field is stored in a signed `int port`
variable.

When a user supplies a port number with bit 31 set (`addr->sq_port >=
0x80000000`), `*port` becomes negative:

1. The privileged port check `*port < QRTR_MIN_EPH_SOCKET` (`0x4000`)
   evaluates to true for any negative `int`, requiring `CAP_NET_ADMIN`,
   or conversely in `idr_alloc_u32(&qrtr_ports, ipc, port, *port,
   GFP_ATOMIC)`, passing a `int *` cast to `u32 *` risks signed/unsigned
   mismatch.
2. Changing `port` in `__qrtr_bind()` and `qrtr_port_assign()` from
   `int` to `u32` matches `struct sockaddr_qrtr`'s `u32 sq_port` and
   `idr_alloc_u32()`'s `u32 *` parameter.

Fixes: bdabad3e363d ("net: Add Qualcomm IPC router")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>

---
 net/qrtr/af_qrtr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/qrtr/af_qrtr.c b/net/qrtr/af_qrtr.c
index 78347c937af7..cae7af5b9229 100644
--- a/net/qrtr/af_qrtr.c
+++ b/net/qrtr/af_qrtr.c
@@ -785,7 +785,7 @@ static void qrtr_port_remove(struct qrtr_sock *ipc)
  *   <QRTR_MIN_EPH_SOCKET: Specified; requires CAP_NET_ADMIN
  *   >QRTR_MIN_EPH_SOCKET: Specified; available to all
  */
-static int qrtr_port_assign(struct qrtr_sock *ipc, int *port)
+static int qrtr_port_assign(struct qrtr_sock *ipc, u32 *port)
 {
 	int rc;
 
@@ -835,7 +835,7 @@ static int __qrtr_bind(struct socket *sock,
 {
 	struct qrtr_sock *ipc = qrtr_sk(sock->sk);
 	struct sock *sk = sock->sk;
-	int port;
+	u32 port;
 	int rc;
 
 	/* rebinding ok */
-- 
2.55.0.1082.g2b9226bbc0-goog

