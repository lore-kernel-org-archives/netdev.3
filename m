Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794012587;
	b=Y7Zx7TaJ1Ob82ZEXYhKl+by0iJN9jsH6PDN57g3xONrwW2T+fSf842m1QFvsCTrtW+Tq
	 7fvcGogQAaspZfuppb99EXEnY4yUFHh4FzMPrZ9TwK1t6LcI19sHUGPthYOU2QHKRCFK/
	 zqic5vE19vB/O/oCcRQPoi3BuGzR96Mfp74Vt7NvpxlqMbV8FxPyPIu/6pa1Y3ZOLh1jZ
	 +6MOQrlcz2zLDw04Lk1uRcyNg/YCjSTQR/XEqcbe4PQpnfrX4BJ7qg+COzu90Y4lcCuwn
	 QWt77zqNr0ExjS3bykrWWpOX7XRv9ikMFf038XMnS8euZbm/q20UiHtU+YcHwzh+B2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794012587;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7xQshCH8xaN5UPnSW1KLNuEBOnt44t+We6BEBpXAUps=;
	b=0+8dvVIp2f0YG6II0/4pCOHNsLeaa7vAjOIhUW8Tla/fHmC+cq1IseYJDhJlVc/Ajzq5
	 BG4VHRyHdENXSrzuD2WOZ6MZtThoO/NtjvMv0VLhf2G7N4GlPQRHzLZYL7GT46nqxApE5
	 aH0uxMsavqOontYbB4ra8bhT05kwTR0SrBd2FRLPYWHv6As3l4aXfRIqST9J7jX4pihDc
	 tR4HTSx0paXuM4Wref75w6V3KV6dRS5VzfQKRjrgeduXvkAk3NdS4zIxwUSynZDBtpbuy
	 5RBdLNY8xBAFzO6zwqQTRdsKYl+OfC2AatqwJmxd/zI6crYehFiS36rGjVJl/ZT6oPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=byWRxeKJ;
	arc=none smtp.remote-ip=74.125.82.170
Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EB760733C8
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 00:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 66EB760733C8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=byWRxeKJ
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-36e99cf7bb3so1953233eec.0
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 16:49:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794012586; x=1794617386; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7xQshCH8xaN5UPnSW1KLNuEBOnt44t+We6BEBpXAUps=;
        b=byWRxeKJyZpL/96LCkSzvqpdonTp0uKzG89jYCknLPTkytzi9hMuKAqDt0kLeGG0Po
         Q4GGfhFmjmt6CMeUyPJqCA4J86FS/3KFCq6uWA+pFIqeIPlJH8GM57BCDtTJNFKMRpBu
         a93DzahHVPPtWXFoyZT+An3CP33sDiYxyltZ1xyAb1SDKRBDnrHvpwAN7Shr0C01O+cR
         FNIDJbeiAV95gmnoAOwxH59KUrUdnFSOU3Z4q9lSLgjAEsDdt+hAciZrK9NencfOAtvJ
         f/aWVwi7JNyXRuwDoimNC4d/z4IwKH7xNUjymrTX7vuVQSVXlsfAL6mWnn/4ixcTYTxf
         JEfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794012586; x=1794617386;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=7xQshCH8xaN5UPnSW1KLNuEBOnt44t+We6BEBpXAUps=;
        b=V8wp5JogyFONgfak1uCKG3AgTyA8V37zYHWzdclRM6BPn5C7KFcUxbjCLR4AgGPS4z
         WvEVW1z52qtUfsN5W8e8ShOX+yT+9nUeMjPmhDcd2q37EqbW2sV6PIH+oOmcjQ1fSA7o
         ZjKM9KesynrEBESGmYPC3ecLT+Azfaz47EMKeJTp4NYlmzuT8bZf1Z1g8m18NqA/ZTME
         kB+L8zcOvp9E46g/Yf0OTNf/nBRqQX/N2eTzsJeQAK1IicZ30vZqypJ5ZyihxCB0zK63
         xsgCj3I6dRmuYCljNnxQQJtdykqCtJJSM34bdEG2rG7RBsfBqzREzNY2supZ6SRzKgQf
         Z3og==
X-Gm-Message-State: APuU4Z8+6xbzv/SMBFUiydSO87GaZEVgq0AC9AInO7fvJsYIAdo17xv7
	8zMzuLHHRduOUwi2duQ1kjTjLYZSKBMCD2KlzkWHi5abvSFppT6kUuhWKn55TyCMovE=
X-Gm-Gg: AYBFou1wYSqyr213KqWO3X08M+e5QFvqGFiyWcb5QVubkFw9OHT5QCLt+U9Toh16K6g
	iMmGp0b6a2dMdXTtOhci8+q8vSSBm8+oLQPfIo/u/JAhJMfI/KQuGRfHEhFVthqwsHObiRj2DNM
	Oqrr1ZkaJsc9sm9WKlx+oBGFVEi6x7J6bCAREQV8PdfyzQvJdpZDYQgTyRlFtMfvosfZqguiXWn
	2d7nojF5iwb3C7SEEbgio/xhKB23F1Hw3CiTqribOOAmCh00KvxBUL/Lj+0fBkoVgxJ9q1lubaH
	kYgBZuSs7gKkn2JrYsgSmGB6nhDPXeZFoig/bTw6U+Jn/k5pJViluSx/yaeT6VAIQVeJGx/SYRQ
	ye0dfyu7+6w5uQhg/NKcJp7+eVxKEGi9GBkd1ltfVF0dCghCh2WkWPkbL/doJ4TeunB7Tuqk2rJ
	cMn72dRcO/P/O1z1sx032IFzy91/In6Q7mJjZPLIDKJxHaYJYRUFCEMYdXDgfqbRNKdrh39SBev
	7oVwIeDx064Fde54Snpu3yKOVPbvLtsc84CI7cC+HGoy/exCnDq5o4KK7xuPypkWblz7f5FcIIX
	6pFMeusNdV7JhdsMftl8RXwbE/h227XI47JdEVYY9EehibVXFLA6eBByGdLdf6FomtroNg8=
X-Received: by 2002:a05:7301:690e:b0:35e:2c6:d46c with SMTP id 5a478bee46e88-36f76815707mr4993084eec.10.1794012586359;
        Fri, 06 Nov 2026 16:49:46 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36fa8e3a718sm11021294eec.4.2026.11.06.16.49.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 16:49:45 -0800 (PST)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Simon Horman <horms@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Clark Williams <clrkwllms@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-rt-devel@lists.linux.dev
Subject: [PATCH net v6 4/6] amt: require an exact IPv4-sized IFLA_AMT_{LOCAL,DISCOVERY}_IP
Date: Sat,  7 Nov 2026 00:49:33 +0000
Message-ID: <20261107004935.2627329-5-omar@blockcast.net>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261107004935.2627329-1-omar@blockcast.net>
References: <20261107004935.2627329-1-omar@blockcast.net>
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

The netlink policy for IFLA_AMT_LOCAL_IP and IFLA_AMT_DISCOVERY_IP is an
untyped entry with .len set to the size of an IPv4 address, which netlink
validation treats as a minimum length only.  Any longer payload passes,
and nla_get_in_addr() then reads just its first four bytes: an iproute2
that puts a 16-byte IPv6 literal in one of these IPv4 attributes turns
"2001:db8::" into 32.1.13.184, and the device is created with an address
the user never asked for.

Use NLA_POLICY_EXACT_LEN(sizeof(__be32)) for both, so every payload that
is not exactly four bytes long is refused with a standard extack instead
of being truncated.  The range check this expands to fails the attribute
even under the liberal parsing rtnetlink applies to IFLA_INFO_DATA.
amt_get_size() and amt_fill_info() already emit exactly four bytes for
these attributes.  IFLA_AMT_REMOTE_IP is only ever reported, never read
from a request, so it is left unchanged.

Triggered while writing a selftest for the AMT IPv6 outer transport:
an iproute2 without the IPv6 attributes put all 16 bytes of
"discovery 2001:db8:a::2" into IFLA_AMT_DISCOVERY_IP. On a stock
kernel the command exited 0 with no error or warning, and the device
came up as an IPv4 gateway with discovery address 32.1.13.184, the
first four bytes. There is no oops or trace; the symptom is the
silently wrong address, which fooled the selftest's capability probe.

Fixes: b9022b53adad ("amt: add control plane of amt interface")
Assisted-by: LLM
Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 drivers/net/amt.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/amt.c b/drivers/net/amt.c
index c714994ef..6d5d43b48 100644
--- a/drivers/net/amt.c
+++ b/drivers/net/amt.c
@@ -3331,9 +3331,9 @@ static const struct nla_policy amt_policy[IFLA_AMT_MAX + 1] = {
 	[IFLA_AMT_RELAY_PORT]	= { .type = NLA_U16 },
 	[IFLA_AMT_GATEWAY_PORT]	= { .type = NLA_U16 },
 	[IFLA_AMT_LINK]		= { .type = NLA_U32 },
-	[IFLA_AMT_LOCAL_IP]	= { .len = sizeof_field(struct iphdr, daddr) },
+	[IFLA_AMT_LOCAL_IP]	= NLA_POLICY_EXACT_LEN(sizeof(__be32)),
 	[IFLA_AMT_REMOTE_IP]	= { .len = sizeof_field(struct iphdr, daddr) },
-	[IFLA_AMT_DISCOVERY_IP]	= { .len = sizeof_field(struct iphdr, daddr) },
+	[IFLA_AMT_DISCOVERY_IP]	= NLA_POLICY_EXACT_LEN(sizeof(__be32)),
 	[IFLA_AMT_MAX_TUNNELS]	= { .type = NLA_U32 },
 };
 
-- 
2.43.0

