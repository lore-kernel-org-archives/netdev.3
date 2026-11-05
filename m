Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876712;
	b=opiDP62CaOBOJZE5cUs6maOqFc2Vul7TZk6yPIgqWHjde669msK+M6Uuwr0hAQLZ1/2d
	 4qOF72rTOLRB+yN0pi72mvublMYQAVOVlvy3i+wNe7aIT0wj77KyAQ+59XIJWF3EYC5uS
	 Eo1VkA+4eR/yK881UdiTjllRgqghgGLiect2CIXDl4ONRxcxzIlcCkkzYYzcBKn0VYSvn
	 VHJUk/YJq/OR7G0YFq8Kb+mfp0Lk8vc62oWH8VAnPi6NYsoECB1yyAt5j3hRLsPSU/Gnx
	 okLNNhEeLBvIVSu+DQ1jswjfYZ7/IuQEVUDMd3w/Kvi1d93JelJdfGnsD9sIstX0IXQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876712;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:Received:
	 MIME-Version:Received:From:In-Reply-To:References:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=EACSeKrdz4bGKRBeWmqR524LYko7JkqQI6iv01qT4ws=;
	b=z9V/u6jRcc8zOOHUPSEFWiTv6Vfsn0IOhfq8mYECYWT7pRRLPXOwPHrOP8k3ZbUJb1KE
	 s8GWaxQ99Y3Xsa4pBw70WPy0Z9w65k/57RfUBF86dQv0DfL71NplUbgjLauaDWpVlXLZL
	 ClcL8ImVOb3uBUPndJgH9GuzdNvYKnhwP0bRfdWER/y+qOm3nFSUZHHT4UthAptgJtu7/
	 GCbW8aaJRRD6QWnDN5Mpgm6TUObfzJ25ZXJELFMKBSmpx+fgsaazlxPH/funC98/kaZEb
	 ji54xrAo/Wm2sPVJhLtvPAlUD8mrfJSJlgJ4rwKyy71SWng0fdM7JGtveOgyyXtvlag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UwQBFCRf;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E26F6606A328
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 11:05:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E26F6606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=UwQBFCRf
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6b429f71dbeso1725249a12.1
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 03:05:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793876710; cv=none;
        d=google.com; s=arc-20260327;
        b=sKMJ7KDd78p3DR9sjyGg/lufiFJCMHibDiEHbpZ43O5I+U2tp6EDYB+qrETGIwMJsr
         Qow1tNp5iAIGdJngZYDr9wqn287x160dxyNHAID5xZiapUUXnLPcyykMRJ6O5UBt6BmL
         IqUy9WzuS3+Fhg0GO3xRsepwVvR0+JU/nFGIfclBcFq6Dr480jMOIEUOzB32bzcBgkKf
         RYlW90l3BkjQbRlcnX2LYxVgqqwdv0JOjFY71XVMZQlypPkpCBV46uJpISQkaEjoxU9P
         uI6vZ4rMi0D+amXuhRVjOu9sfQWTayh20775I8uFfuT3/Aqf1bt/llssuV/CCMoQ9mWW
         FFSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=EACSeKrdz4bGKRBeWmqR524LYko7JkqQI6iv01qT4ws=;
        fh=3uxnc4YJKEAqGzVVJx4hfPlDdx+K8Ub/ebS49UFwIe0=;
        b=g2gg0enj2EKoi4bjzzLxnhJT4atO1bZXHHT3liuml25qvnYZKBgL+fMhFVfWPNwzzM
         MtSs9lRPXQb465U6I50ZqEtlKkjpTMDc6aVqTq0VtEOo6NTgVgs4tjKhNC1j1TsOFB3E
         lheQd69VQvjiY0GlGjunBc59i7mGzQ5n7hmx5fulJ+DDxuULF2lqrRuWG0jU/UNwkqat
         0TgmiBhtaHUW/1oMTZwC7p23brb11O5WL/eb8EjaNjflo9oHkg1GGeQfNqvCNmixDHPB
         5SZjzLcQ1FaVPJu5v+wmX8dCFOXFStyhljd0Dpsnfw6zoN74huBgzmA3BQNJzu2m7kzr
         7c0g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793876710; x=1794481510; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EACSeKrdz4bGKRBeWmqR524LYko7JkqQI6iv01qT4ws=;
        b=UwQBFCRfxFQORo86l7fky65QmFyk5pZq5nf5Gb1HJMrfA1MqU9tR+cmYRR0Z38XIi3
         eeU8i43UkNv0A+eQu1Mrsa934JL5FU7W2ePK8v3eUsDKU/DM/Bvix9pxLBoN3IJuDIcN
         JlQ3r4aWf+s3JdEAsPAdeje+JAttZ+8Pfz/TMNFuK+lUHEBYk3x3DPMMWzq38dXE/CRb
         jQ0NOwlS9JTD/YM+dBUagabK/67ZjyFU9LyabVfN9WqKeUfTAYOhHTncNSIx8oYO7Nl1
         0Gw2EisIskxJCULQNQrkdUGtV75wFy0dD8b686SCbNPhqCAwuIJqeGnvbYefGUVGO3nz
         og5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793876710; x=1794481510;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EACSeKrdz4bGKRBeWmqR524LYko7JkqQI6iv01qT4ws=;
        b=idnpLTPTC6gi8+8uNSwcEHjGDRpe7jChFGNpxDvPn6Kv6Rf3pgKBKcqO0DeB0RzA8e
         MBP0XGCcVuzCGmNMCPRBqJsQ1KtX88gHLYeXNGBgxv8zf+U6xD9NHgcRt0tbtvQPlVNl
         K3xIsWcQusbYnzqVkTrwsxFbEWNcmvfwnbGTLsKc1djVnOYBY1chAaHDTRjx6ZGjfVoC
         e14Qr+SWPXwCv2oe1hQWRNFYctH4Z2r6ZqeIkBuaPY3sXrOvbF3nFAYB53fzUh3JUy/c
         E6hPMDSOczC2nsRWYeMO15aQ/Qq+CuH+lh+8xU11Q60IKJGGjRYA3A28nbOQRXhrqUfV
         T8tA==
X-Gm-Message-State: APuU4Z8VAQCwD5AvLqXijNJevb5zubaTtRRYy0C02Q55AGuaizqRBfuC
	XdpzpiFyZhbHtxpMi9fVSfdqVTC5tFTzEHvFJWDsstIm4vbzb3uD1Cs45KXIC4XTDDvJ/fh5HDU
	hv+KLB7VqUG+kxCxeb9xW/1xjjcguHrXcL+7M
X-Gm-Gg: AYBFou2NV6acSo2SP7519rZ/iEqX/Pw8wMeoefi2cmTmolUGd09R5dsE7R5MV+vj31F
	AuBu0L3IRpOwTl09GseHHg9MuBu4faPV6w/h7iKWkJb/YV3LUs9McqYFR59b4RDFk8r+7QQ6xva
	pLlRQYQ29ySCTkP6eq/FHhZqnstqJtJE4ewGL3cKfENL+U+G+TN44oJTlMH5SFbmBQXraEeISjd
	SNvJUrR+KwZJiHPvi+Ikoypf+iDVoJknF+4sa9sbKIMuaretGtlkQ+oFHfT2K3v+EZ4OBlOxY8Y
	xn0DrrAGJIfNjpUZ0iACuxzlfc1OXKA1HcAVeosZFI9q0Chma7g92QhEo5z85wZfOKWcRkMfMeW
	rUnLX4peBxUvWlN/U+SQcMBH60xE0zo7hx0e9mjh3ffVaOSY7k/RIvXjNfC/atFkeTSkFFDSw1K
	9wrSoiBkDXd6TSlO8Y2LSq2dgEv4lkW9jqAVmQYyxKQSHmahla2lUegKc2OEzwAhHkP3Rytouv/
	I6lfPGr+8mduuRjWA==
X-Received: by 2002:aa7:ca5a:0:b0:6b1:d2ee:392f with SMTP id
 4fb4d7f45d1cf-6b4d4d7456fmr10223394a12.25.1793876710202; Thu, 05 Nov 2026
 03:05:10 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 5 Nov 2026 03:05:09 -0800
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 5 Nov 2026 03:04:57 -0800
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 5 Nov 2026 03:04:14 -0800
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Received: from 77377267392	named unknown	by gmailapi.google.com	with HTTPREST;
 Thu, 5 Nov 2026 02:57:56 -0800
From: Florin Badita-Nistor <baditaflorin@gmail.com>
In-Reply-To: <CADnh+D0zSzAyYCLo5cXU56o9X-P3RG3N2ix7ARPrP95d8sBXmg@mail.gmail.com>
References: <CADnh+D0zSzAyYCLo5cXU56o9X-P3RG3N2ix7ARPrP95d8sBXmg@mail.gmail.com>
Date: Thu, 5 Nov 2026 03:05:09 -0800
X-Gm-Features: AclHuK9ci3ISHKdlFTJfWL5UQTii2K6y9JcFzosGDRAOWFRE1BZCZMqATJw5ROk
Message-ID: <CADnh+D1CH7yU2fsnoKBnLUSgDdFmWCivS31PQHfDqxUptp9aiQ@mail.gmail.com>
Subject: [PATCH net 2/2] selftests/net: cover odd-sized local port ranges with
 one free port
To: netdev@vger.kernel.org
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Leave each port in three- and five-port socket-local ranges as the only
available candidate and verify that bind(..., 0) can allocate it. Cover
both lower-bound parities and repeat allocation to vary the random
starting offset. Use the existing IPv4/IPv6 TCP, UDP, SCTP and MPTCP
fixture variants.

This catches the false EADDRINUSE caused by rounding an odd-sized range
down during TCP port allocation. Without the preceding fix, the TCP
and MPTCP variants fail on both IP versions when the last port in a
three-port range is the only free one. With the fix, all eight variants
pass.

Allow the loopback bind helper to take a port so the test can hold
explicit binds on every other candidate. Retain the existing helper for
automatic binding and run under the existing isolated-network-namespace
wrapper.

The regression test was developed with Codex assistance and exercised
on booted x86-64 KVM kernels before and after the fix.

Signed-off-by: Florin Badita-Nistor <baditaflorin@gmail.com>
---
 .../selftests/net/ip_local_port_range.c       | 67 ++++++++++++++++++-
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/ip_local_port_range.c
b/tools/testing/selftests/net/ip_local_port_range.c
index 3d32b33cb..c17d95045 100644
--- a/tools/testing/selftests/net/ip_local_port_range.c
+++ b/tools/testing/selftests/net/ip_local_port_range.c
@@ -44,7 +44,7 @@ static int get_so_domain(int fd)
 	return domain;
 }

-static int bind_to_loopback_any_port(int fd)
+static int bind_to_loopback_port(int fd, __u16 port)
 {
 	union {
 		struct sockaddr sa;
@@ -57,13 +57,13 @@ static int bind_to_loopback_any_port(int fd)
 	switch (get_so_domain(fd)) {
 	case AF_INET:
 		addr.v4.sin_family = AF_INET;
-		addr.v4.sin_port = htons(0);
+		addr.v4.sin_port = htons(port);
 		addr.v4.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
 		addr_len = sizeof(addr.v4);
 		break;
 	case AF_INET6:
 		addr.v6.sin6_family = AF_INET6;
-		addr.v6.sin6_port = htons(0);
+		addr.v6.sin6_port = htons(port);
 		addr.v6.sin6_addr = in6addr_loopback;
 		addr_len = sizeof(addr.v6);
 		break;
@@ -74,6 +74,11 @@ static int bind_to_loopback_any_port(int fd)
 	return bind(fd, &addr.sa, addr_len);
 }

+static int bind_to_loopback_any_port(int fd)
+{
+	return bind_to_loopback_port(fd, 0);
+}
+
 static int get_sock_port(int fd)
 {
 	union {
@@ -301,6 +306,62 @@ TEST_F(ip_local_port_range, single_port_range)
 	}
 }

+/* Leave each port in turn as the only available one. An odd-sized range
+ * must not report exhaustion while a port at either end is still free.
+ */
+TEST_F(ip_local_port_range, odd_port_range)
+{
+	const struct {
+		__u16 low;
+		__u16 high;
+	} ranges[] = {
+		{ 40000, 40002 },
+		{ 40001, 40003 },
+		{ 40000, 40004 },
+		{ 40001, 40005 },
+	};
+	int i, j, port, free_port, fd, err;
+	__u32 range;
+	int fds[5];
+
+	for (i = 0; i < ARRAY_SIZE(ranges); i++) {
+		range = pack_port_range(ranges[i].low, ranges[i].high);
+		for (free_port = ranges[i].low; free_port <= ranges[i].high; free_port++) {
+			for (port = ranges[i].low; port <= ranges[i].high; port++) {
+				j = port - ranges[i].low;
+				fds[j] = -1;
+				if (port == free_port)
+					continue;
+				fd = socket(variant->so_domain, variant->so_type,
+					    variant->so_protocol);
+				ASSERT_GE(fd, 0) TH_LOG("socket failed");
+				fds[j] = fd;
+				err = bind_to_loopback_port(fd, port);
+				ASSERT_EQ(err, 0) TH_LOG("bind(%d) failed", port);
+			}
+
+			/* Exercise different random starting offsets. */
+			for (j = 0; j < 16; j++) {
+				fd = socket(variant->so_domain, variant->so_type,
+					    variant->so_protocol);
+				ASSERT_GE(fd, 0) TH_LOG("socket failed");
+				err = setsockopt(fd, SOL_IP, IP_LOCAL_PORT_RANGE,
+						 &range, sizeof(range));
+				ASSERT_EQ(err, 0) TH_LOG("setsockopt(IP_LOCAL_PORT_RANGE) failed");
+				err = bind_to_loopback_any_port(fd);
+				ASSERT_EQ(err, 0) TH_LOG("range %d-%d, free port %d",
+						       ranges[i].low, ranges[i].high, free_port);
+				ASSERT_EQ(get_sock_port(fd), free_port);
+				ASSERT_EQ(close(fd), 0);
+			}
+
+			for (j = 0; j <= ranges[i].high - ranges[i].low; j++)
+				if (fds[j] >= 0)
+					ASSERT_EQ(close(fds[j]), 0);
+		}
+	}
+}
+
 #define REUSEADDR	0x1
 #define REUSEPORT	0x2

-- 
2.51.0
