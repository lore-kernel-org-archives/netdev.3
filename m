Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792918865;
	b=WC2ElE2KmV6p8mIXBRZHSYHssL3J9UhzG1+3aoEBdGPIg4x0Nqpx2EUlcJKLZDBUpagI
	 zpK0EB2FFFtHJ4E+RnQWw3JBaJIXb4NX/pjLxuwWXonfKQklHULs+Ojwf8DlBg6s4akJZ
	 ULKy59WHbiL9yh6J1iz44edwMCxWyM/zMxL38yZQpR0wDmTpD2xdX8rHnJSQB1U94vrPQ
	 jzaIdYUH3vlJ75d5iMdYlg1/gdxf6ipYTk5QWCHNQc3gk1QWqpv2phFYg5ZJJit6r8dqN
	 9btlYR+kFaulr4GfAKxuBfenRHdp1+EIQ6cCS9lP/1IzOmO8kT56BYt0ryoa2WMH5ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792918865;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XEX2cwRDGHHD+wX0VxTmiLBnol48kztc/aV72MB1mJ8=;
	b=u8RHLYDWQxMoBabdDZYK+WtwikuJzZSUeJbL/XHIAN7BIw4Ud9aT2U+yeiMVvw9KCO9o
	 lNW5qPyYalriS/hJjukwKiEtf2xEk9TQoqb4RE3Lp3rwj3yM2BsLJQNZHxaeW68Ww5KPc
	 gL1GUGobu+VDsm6ayV0ZZTXIGqgPDF5ZdMD6cnedPhIg716jf81Ux+L9lE8P/9RGuYOcR
	 5BsSs4cw5UgWArRwrG14sm+2PCpn8Zz7BP/557pPXBm9OXWJfuXoOMLrEISoPurbefvqi
	 l9/XlpfpJuewqY3BfJxiIYh2+WrOTOCnbyyAh9jBFduuEF4uI9zuU5taP18Xn+Y80aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wfnng+us;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A598606A31F
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 09:01:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A598606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Wfnng+us
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4956869750eso13656055e9.2
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 02:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792918863; x=1793523663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XEX2cwRDGHHD+wX0VxTmiLBnol48kztc/aV72MB1mJ8=;
        b=Wfnng+usL6f4cmzlGGXopxt7eGzGFSfKTkmHYy9cI4cCr7jvggfphRP1onvz1FXpyj
         AgxCGKw4uf1Mn8zrQUdVX9NhAzWTGLvkiWQrgBO3omI+OZBC/WgBa6CVPxJjflMA12xr
         KKUmc9f9G4chXmJaeN7/gTcMiwbnlht2pwoSfpch80gh/dMTsFYYqd+dGQ+kCAcV+UI5
         nnSuwjfnA1LF6TJ50zJBrQ0uQS88tXHDT4SVrKGY+x+ukecI9H615f6h3Lp9d6IkEElQ
         1GMESJ5pZt5xmyhN8Hvro/ryN3aSQNLGHJD+gbdqoTdEDtCyoogg7n6fVNHnt4nfWV/P
         Ut1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792918863; x=1793523663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=XEX2cwRDGHHD+wX0VxTmiLBnol48kztc/aV72MB1mJ8=;
        b=OaP4mZTidGFNgbPmC/n9pNaKetrhFSX6pLK8AGOJGcdqBzRcSU44s2+NSo253x9Zd4
         peXNaHBOTFvZ5S3Y/xMLOvakH2XQoItALD49ad6hWF25Jes+qkDXYctfJp44ENRpnG3R
         kTnqfihvzoEPZL2sCN6JbuC+dHkEvp1UH1Tgwjhm9PtGfSmtmyYZsl/LYfgy1tcVwfIG
         vbVZw6dq83Am7XlDru5v2fVxl6VBIz/BF501S6Z0weKxqjjBZwLar9FNYl1A47d0htY2
         XPPRj/xfI4blPDRjEo4bBT1Noz7ei8+YSSw2mlHXFpd1ep6YyIWTW+9bQXViHkfsWIEX
         h46A==
X-Gm-Message-State: AFq9FYIRFRSjsG1RjwYKOm47PhnQM1AOgzALXOBOSicv181knLbyxz4M
	k4IpDJwo0QwrE0yXww+ZejJzi4v9pbykxxnQHx934Vm6xGSiNA9rE2NiXY3/tHdQ
X-Gm-Gg: AYBFou3+Q7WaCF19F7zmxFABw4jw9Ga785Itewn83zClAeWK+BJgonz0aqbGdOgmgYl
	w+BcESyyQdbgb3OFSeJhc/hxpQBQ7HU//IYEb1ZTobo7d7tgkoVzsJ0sk4m/q0QZjOCkFcJTQkg
	HH7Xk40qN8V+V7Cs6241LfmA/blg/xKfJFmYEI8KE0wtN6mL912id7B08DsdXP1vqCS+l2y+7tV
	3fs/Kj48hU0ElnopcWInpdwZWH8mB5/3NrhWOBO6OuiDnqhp7ixm/2y60KuEv2wWNfQ9bMu8JOR
	f3wHkPKHa7QtYGUZXM0WX7O3zW01Y9q6jW/8LxT4sJt8JJavKNe/i/bSiI3XV6bXp5VxqQuRq9H
	vjh+bXmgsfsupHvT8lPa0u3P20SWcNc1SNvh76VcHtFcfZTCVLXlgDf7am4X3h4pSZ8UVBkhE8f
	USiEEBNEdVWmj/HxTwgypT7cBtpdpsU7pST/CwqVnOSI2+xZvCvLh7p1rieFQ7OpK/k/eG47UEU
	/Iyis37lwP0ln9HhvmZ7pcrPAUJU9kYYgX+MJSfV6kdM0A2+aDnYJVMDsOCOX1/ijyi3pcqCfE=
X-Received: by 2002:a05:600c:4e87:b0:4a1:e57b:667c with SMTP id 5b1f17b1804b1-4a35acaa62cmr76173405e9.26.1792918862802;
        Sun, 25 Oct 2026 02:01:02 -0700 (PDT)
Received: from zheweiy-mac ([2a01:4b00:b60b:cb00:c67:3956:189c:b7c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a5822a7sm111588615e9.11.2026.10.25.02.01.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 25 Oct 2026 02:01:01 -0700 (PDT)
From: Zhewei Yuan <yzwlhm@gmail.com>
To: netdev@vger.kernel.org
Cc: Zhewei Yuan <yzwlhm@gmail.com>,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	Kuniyuki Iwashima <kuniyu@google.com>
Subject: [PATCH net 1/2] tcp: Fix fastreuse cache initialization on first bind
Date: Sun, 25 Oct 2026 09:00:47 +0000
Message-ID: <20261025090048.27870-2-yzwlhm@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261025090048.27870-1-yzwlhm@gmail.com>
References: <20261025090048.27870-1-yzwlhm@gmail.com>
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

inet_csk_update_fastreuse() initializes the reuse caches only when
tb->bhash2 is empty. Both inet_csk_get_port() and __inet_inherit_port()
link tb2 before calling it, so this condition is never met.

Fresh buckets therefore miss fastreuse=1 for SO_REUSEADDR, forcing
repeated binds to scan existing owners. SO_REUSEPORT starts in STRICT
instead of ANY, causing repeated fast-path misses with alternating
addresses.

Initialize the caches when tb2 is the sole entry in tb->bhash2 and has
no owners. Both checks prevent reinitializing an already-used bucket.

On historical net f4377bf85887, 16000 SO_REUSEADDR binds to one IPv4
address/port take 4256.956 ms before and 20.004 ms after the fix in a
one-vCPU KVM guest (bind-only means of 3 boots x 3 rounds).

Found by manual inspection and GDB tracing. Codex assisted with
analysis, validation and wording; test/benchmark assistance is
described in the cover letter.

Fixes: 8002d44fe84d ("tcp: Check hlist_empty(&tb->bhash2) instead of hlist_empty(&tb->owners).")
Signed-off-by: Zhewei Yuan <yzwlhm@gmail.com>

---
 net/ipv4/inet_connection_sock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 8151c638a24..93b306d91b6 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -446,7 +446,8 @@ void inet_csk_update_fastreuse(const struct sock *sk,
 {
 	bool reuse = sk->sk_reuse && sk->sk_state != TCP_LISTEN;
 
-	if (hlist_empty(&tb->bhash2)) {
+	if (hlist_is_singular_node(&tb2->bhash_node, &tb->bhash2) &&
+	    hlist_empty(&tb2->owners)) {
 		tb->fastreuse = reuse;
 		if (sk->sk_reuseport) {
 			tb->fastreuseport = FASTREUSEPORT_ANY;
-- 
2.52.0

