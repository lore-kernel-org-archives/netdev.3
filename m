Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793876689;
	b=t4yHchNu/JCWgFEd20yk0tGXbMOHw+JO5UtNi+XJKUcfmdv2eewy3btgzOhxrCEiAbwU
	 qlEJeGsEfkEdp6Dr1DM2ZmGEvBnTyt9+zekvKLufZXWt5HSV4rqoimm/mR1s74MOrswU4
	 +KQEvD+a6Zb/OeFc4ySc/nyOuEkTK9A8jdqD7eWVxa2ImddKxN51hhR70EA6TWuMXTAiG
	 Dv8akO9Lfwn87dpVRp263jFiPf0Urud02PH+nCPT7F8RwmjsYJRQ1TtctiAVfhfjz8qT8
	 uifdPq+lUYpulItNuJq+rhBDUl1p3kOpvzGi9F/IkUJqq4sIdKYupbmNz6bm4eXVqBQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793876689;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:Received:
	 MIME-Version:Received:From:In-Reply-To:References:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=0am8CfLTgv92qkgop5G7IfmmvPUqaNxO/vuHRyrSZqw=;
	b=O9j2wDweTPGj+pLYxlye6uxQwvgHYrqcOtHdgGIu/OJG7qjjxABqWUUOdSN9CsJJ7jKz
	 5RKnAyTNcz1v3ovljQCmWiNkpm1KKRRqro2HfhuBP6bsoHSR687/vTLXsdJYljXzZtDNt
	 zY8fKmsh3Yez9+xTE42pnDZnIT+SlcOpGpMf4yePABc3Y+S/P6yVXDjfULym1sMHBGsyF
	 bK5dQ7zCut0GmbG4SnscT1w5H3O2MUM33QzZeJC1GeCnOv2QB3yTygffbOuZQkROejtzr
	 CCo7JWGhmk/K0xqzzrgAe+lBZyv4nNrJVUeMVx9Dmhk9t1sYM3w3o84fRybV5EkauMg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b1PlvSnv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.47
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F5E0606A31B
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 11:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F5E0606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b1PlvSnv
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6b58cb69927so113936a12.0
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 03:04:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793876688; cv=none;
        d=google.com; s=arc-20260327;
        b=QlSHpC93B5hIyOLLaK8DLdeJj8yuUgASyY3kwo5uzhqXOTaY0xkUzdCm2VEDrqX250
         BX4efVrQ+8WnfdinxvuKkoMEeCUjMvS62rct71Viukqr52leZKCv+29LWRY0B9daXfKf
         zWsAAzsFzKCgU9gk1cr+iiSSEzKnXseqC0YGAHBlROFwLpK8J3Uj3+iGoYY+YfqMuHT+
         0ZAr2ABdIcPW//7KOtQiIZwCgJNu8EOve2krRL+Kq3I5WlcC3psr9j+apPGUZpgTQN1+
         YVVJc8+WRd2eQnEWsIDrPnuEkLC8toV2wV0D4Y4CrbYjGVkdHtCGH80u+2qGlzdJ/kZK
         2Y9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=0am8CfLTgv92qkgop5G7IfmmvPUqaNxO/vuHRyrSZqw=;
        fh=3uxnc4YJKEAqGzVVJx4hfPlDdx+K8Ub/ebS49UFwIe0=;
        b=R0K6o1uAF3oe2WjhobBuIQbzKCrw8hAjeGdjAFYLHD5xg4Foy5dTHeuBn1V/dlwGxD
         bl4BzqOwDCovCzseaSITfyDNpvSJqP9tme/Nr3aiBVwO3rzKLRsxnm8K1SnHg7pOHUGB
         T5T5oA1pP6wREPn4d7tVt6KlqBjlfhaz9vKKMoaMfDQ/uko3wYu124mjnnfIsLxvwvAa
         WXowG/39XRTxg/4ypSr/UoNoUs0oR5GPVq1o7dWfUqtCmfCPMPNOejZ+HKPVseNjFeSF
         LqKBCwS/qSANR7OBkNL3s0rLjBbLTG42Lt8TpVwV4CljWpFv8G7iCflQqPCBrGgR1CAd
         dY/g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793876688; x=1794481488; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0am8CfLTgv92qkgop5G7IfmmvPUqaNxO/vuHRyrSZqw=;
        b=b1PlvSnvndvaZQXsu8PAy4yevw7hV0/nJeaKI7uWTPJjANe+cSJUoyFhDheZjkMPON
         Gpq2TLF5sZHYJC6MeRwCp33wmE5/YK8jm7Kozc4HAKBY8aLyk6TmEdoClGIVNzCJEXy6
         LO7JUMRpgYoSqfA6c/eGRgTL/ZZjeVhp3y3mPBOI8Bh+sMXeLUV8MbvfprFiwHdRqRE+
         3u2znYOuR2n2iOUSLYFPhA5OVfrZMR9KY5sokvZI4/z0THslW+CDXmfnH6WXYOtHqBgK
         F6dgEbmqptVpUrrkes75CgdmCu7vmoYE4i7E6AV1H/B2HDVS8sTrJgwQllSEgZUB+t3P
         EO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793876688; x=1794481488;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0am8CfLTgv92qkgop5G7IfmmvPUqaNxO/vuHRyrSZqw=;
        b=GQmZNmwnvjZ8ms/RAVwTsxkES9EH5iL/nwmItoDvKEgk6YJEguaIPEsok5pVG/+EpQ
         hgqYvjkOftBzM9DqB2DO4y65rNKZ3A4n825IW1Ko27CX7lZkhiSAbQDkEy9Q2DjmDFFf
         xSrLtoQF7WKJfSGtlmShsLzERJzo/Wo1xD4JuAYgIfYawjs1QCRbcDS5/gEt61RGhlSd
         MTncqkBLfOPl/jTAWprw5F8NZB/bswIXPHvh/3y+7QMkXsZdl9GP5HNM2eGKXbtoYu1T
         q+5zF/b49iOipYi2QNffgNmp8vHTd1QTW3BVz2CRuto85m/biWBb5zX2XWfs9/XbPRYK
         5a9Q==
X-Gm-Message-State: APuU4Z8xU1TBn94yqIjQADFArUzNMxQNBy+2Bd7Uao+2wFP+BOgXf1av
	x09RJDNEsiwBMrK5OBqO8113Bg5NGJ0IqC2z2BPuoyAcIqaMH/MyORder22iNZw5nc4hI73hxha
	0gO0KA5p7QXumKkvFHwJLj7RH7QFfFnfHFVnC
X-Gm-Gg: AYBFou2czEGk5mXW74rcy9uDg6zizqXPTBhtapxzYJZlGtXOj/n0U85A5gMz17DcTlJ
	NPMCFNy8QcZgrdyUW0HBrSjcJhifLaJGjUslvDdlsJgtTA3IeuXT0Lrjl/tg+FHU/1hbnYV+uVF
	yBg4//dfA8VVwPOr1DQWoYFpgkPuxFqvBLTJc15oOtrrGIvdjaE334U+d3XQSOj4B4JUeM5X3au
	HpJvjFUa0zbXDp2k+TWjN2psmRNnMsWNmpUZN+F0hIRUznOeFkiIYa6c99Co1/CCKUHZVyt/hby
	3jQtNsxPOdoXMxi9EdczroPwQqoDuROGRQfZXpsgMxkjggaOrS3kVr89kfi5xU695mQVvkjCACZ
	sdITn8gAS0jxrNZWNEZWbzPc8Ong4XCztN9VAbMe+xHcoYdbR+2KZOFg1eoRKGBa1yiauQsIRxV
	ziuMK5qvGAB+gAQUwBT0Gitzx+qPRe9n1SYLM5ZBPRnoHux+6+pOqr2EyZELYnCbHJEH+EYpwtQ
	AbDdGy6jQgZQrMGdg==
X-Received: by 2002:aa7:cfcd:0:b0:6b3:cfa0:77cb with SMTP id
 4fb4d7f45d1cf-6b5777268f1mr1117005a12.10.1793876687591; Thu, 05 Nov 2026
 03:04:47 -0800 (PST)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 5 Nov 2026 03:04:46 -0800
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 5 Nov 2026 03:04:40 -0800
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 5 Nov 2026 03:04:13 -0800
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
 Thu, 5 Nov 2026 02:57:55 -0800
From: Florin Badita-Nistor <baditaflorin@gmail.com>
In-Reply-To: <CADnh+D0zSzAyYCLo5cXU56o9X-P3RG3N2ix7ARPrP95d8sBXmg@mail.gmail.com>
References: <CADnh+D0zSzAyYCLo5cXU56o9X-P3RG3N2ix7ARPrP95d8sBXmg@mail.gmail.com>
Date: Thu, 5 Nov 2026 03:04:46 -0800
X-Gm-Features: AclHuK8JAKDvSsOv_WcYjMNCz8gzZNtzoHji_gLTKVDuZBc4kV7FsgmeUAtGpZU
Message-ID: <CADnh+D3nz5aehxjvurK+Fv7gF6n4csMm-dFatvdMmg1fWdGSQg@mail.gmail.com>
Subject: [PATCH net 1/2] tcp: avoid false bind exhaustion with odd-sized port ranges
To: netdev@vger.kernel.org
Cc: edumazet@kernel.org, ncardwell@google.com, kuniyu@google.com, 
	davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	shuah@kernel.org, linux-kernel@vger.kernel.org, 
	linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

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

The issue was triggered while developing port-range selftests with
Codex assistance, then confirmed using userspace reproducers on
unmodified kernels. No kernel instrumentation or fault injection was
needed. Booted x86-64 KVM kernels were tested against the regression
selftest, the full ip_local_port_range suite, and a Go net.Listen
reproducer. The Go reproducer fails 100/100 times per IP version before
the fix and 0/100 afterwards with a three-port namespace range and two
listeners occupying its first two ports.

Fixes: ea8add2b1903 ("tcp/dccp: better use of ephemeral ports in bind()")
Cc: stable@vger.kernel.org
Signed-off-by: Florin Badita-Nistor <baditaflorin@gmail.com>
---
 net/ipv4/inet_connection_sock.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index e56beec43..755fcea35 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -343,8 +343,6 @@ inet_csk_find_open_port(const struct sock *sk,
struct inet_bind_bucket **tb_ret,
 			low = half;
 	}
 	remaining = high - low;
-	if (likely(remaining > 1))
-		remaining &= ~1U;

 	offset = get_random_u32_below(remaining);
 	/* __inet_hash_connect() favors ports having @low parity

base-commit: c6b41de4dd9f2d6856d8d8d292348f7961034152
-- 
2.51.0
