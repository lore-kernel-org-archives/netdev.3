Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794208270;
	b=bbrmCOA83Vbs6JKivNS5VuO/9XORkk7vuJYYdwi+4yEmaEFb6VYco62q8D3pojOyzCdu
	 X1N3uXVeG+lTRug1+k64hp6WHX8aBu34YEYQADZTGPQcz9lZww2NrKKMhhNUNQ+EyJmJF
	 09w//1QBOQpJ4dXKaP+WWRWpv8MeVqIXlxPNiyFnb7ykgFVozZEiMbuqTvz2/78yVXyLr
	 3PF3DdRfJAsebFhBxk/yGHw7a/SURpEnBQExIt8DfyRH2ROhOIPY1AaAOgtCWZPQho1rQ
	 7RWOOJY8K/8qM49BuFhZiffQJ8e65hMQZGZgSp/ytfCrMetPAh5KhnOt38QBcutl8lA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794208270;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LrXsda7Q/wV7+l2k+sGQxx8wXojvBKGw7M+uJmFtdYU=;
	b=2KMnLFg+T607e6WzCNb5i1X8WJSGgjM0WDuA9mhCNWQc1mj+2gYuQ3iUjosgGVIYB5uX
	 1WHKgn7F0YJAFA2rXkZjSaO9CeErgaMzof2ZzMJ0hR46ui6HYVrezwhncpGAYcugmpV4E
	 oOoHgRKhyBnJq47t5Fp6/ciS285YTRy84SPH+jqQzw1fAn4fUXCqqT2wsPg6Z2W0otbU1
	 x7lEwC6sewnZogD0hnIr9GTVdPLt9z+L3xsJzvBTYR22kX3IM4x/tB7aoNz+f+aIJiFnE
	 /l9CqIMlxvFLKHL+v7D9Eu/56V9H35SZ9kINAOv81tEbB9f8J7m1Lp1dO+5vsbzDe/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a3coknYg;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8CA606A322
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 07:11:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DC8CA606A322
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a3coknYg
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1b244fb7fffso583213c88.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 23:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794208269; x=1794813069; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LrXsda7Q/wV7+l2k+sGQxx8wXojvBKGw7M+uJmFtdYU=;
        b=a3coknYg0/9is928kAfp4u0Vmq7Q+SzLiFXZc9jUQ3rdzRY7S4pdGKN+LcYXzwTLkF
         nqvyRSUa1Z7NyIvwl9Ciu+wpnMeevbcig/AZL8Hez6ihonfDQheXaxWg7qv7P1z0hiAp
         Qia8bMGREQf5y9c0vmBMg6OGIKV4kZClYM0zmzuJok0RceLVJpdlNrR0Nazewt2SdD2j
         FmxpptP/USok37rRTtUZ64FVfZGYgbZtkiPCqpKGjqVS/e/qnSm1WW8A5u3/oO5xkF6u
         +5RzUcQfWG6WH2fx0icLfyYVR3iuKye7XL0lHfjZlJ2Pj4282DaIJv1D99eWm4jP6QJL
         nbpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794208269; x=1794813069;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LrXsda7Q/wV7+l2k+sGQxx8wXojvBKGw7M+uJmFtdYU=;
        b=NBnrvmQbSODIz1YMnFX1P5JxLk3uI/r+F3sISNV6myeIItZ7q6lw6RZABh90nf8ZQb
         SjtYx9jZaADXujDSf0nHlZ5ugM/pvQ7YwekA1lglqWgcs6ZdBulYS4yhT2hkmBueJ9FI
         LuvTdiobis/glKicvoABSVt6YgpEAR77+GPGEeu91AWPN1jco8ZEC9yTonwXulGFtT9k
         vP98iO/PLF0QwygWcF0dlB+1K+OuwXPXsvkzjC6pWnuQq6bbEAYjO6i8D6jrSIHhrC05
         6HiHvNnir0Zf2JnUuP5l3M3rclxdXz9PnWKixpuQQEX2UWi7VPu1NP0VCZ07nnQFYsS2
         4jAg==
X-Gm-Message-State: APuU4Z8UijuVM6qDFSKW96E0Nh0V9BrAy2W+LgIeZ/tKEA+2+3phVhDa
	KOz3DU5X2qS3rpD9GdaltGxV9Qj4KY7h2xh9j3sXWJAp6IRdyESlW7zSfr2nLQ20lfs=
X-Gm-Gg: AYBFou21h51REZimlsvta/Z89VizrIVTlfsA8jyRUSSaqZ6b836HwX5ksecLnJtHOb6
	3Tlmby957uzhblyR2B7j2tIm+kyvTiEWXmMTRTEHYoZlAE0od4gkwoRgKz+s8BO9DsKOVnBHNEb
	LBAhnipbvd3zQI5gmUWtU1bSvPJSRW1eoG1Xpbr9+eiQmRFKC/x2IK7tpyp7aYnF6h8bCltImhM
	FFjc88WEiyVSNWgbQmZWUYSeHKC+5CurYJ9so2qoAey8NkBk7weXSrvABLsT/NnKCJknTQ2kZjY
	BwCG/RVi+vM58/nXVO3eejEAGU5NmYRlAs/tAK8qem0vLVrTkS2ogZi7yBt4KL9kFGEuB4i4Nrq
	C2BlBxf9CKud9Fe6K5aI34Bq6k6ZHqvHyn/lkL7LviShmeRGTJzteBVKPCZWdWbT1hrfPIwYJvi
	4aHDy6JNikA3oQx3qDBJ4JLN5a1Yi9h7vS0GumnJ2mDvf2QP9xmvTbR5olNdrIVB9g0kUd0QO6q
	8hCUZabmD1KOUwEchG4lg/JWunoh0l5mou/Q3cKxNEXwX4KOBauVU7FeKC7ZZShZ+K3FMAilwRP
	AalIulzODBm9fUGEDx+P/hyj6ZCYl9zJaCXgJn7sZt+P9iv3HAatcXWCeCM0wdJqM9zxu0Fr4dE
	2qdAJLCr33ZqXadMr6r5hL0E3Hi9j
X-Received: by 2002:a05:7022:286:10b0:1ae:59d6:91cd with SMTP id a92af1059eb24-1b39fecaa6emr4913256c88.38.1794208268937;
        Sun, 08 Nov 2026 23:11:08 -0800 (PST)
Received: from Inspiron-14-5420.. ([2402:e280:21c6:671:cc96:e14b:76e:f8f1])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3755eb6efsm13443513c88.4.2026.11.08.23.11.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 23:11:08 -0800 (PST)
From: "Hemendra M. Naik" <hemendranaik@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jiri@resnulli.us,
	jhs@mojatatu.com,
	shuah@kernel.org,
	donald.hunter@gmail.com,
	ast@fiberby.net,
	toke@redhat.com,
	liuhangbin@kylinos.cn,
	j.koeppeler@tu-berlin.de,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	vishy0777@gmail.com,
	tahiliani@nitk.edu.in,
	"Hemendra M. Naik" <hemendranaik@gmail.com>
Subject: [PATCH net-next v10 3/4] net/sched: pie: correct tc_pie_xstats field documentation
Date: Mon,  9 Nov 2026 12:40:16 +0530
Message-Id: <20261109071017.438478-4-hemendranaik@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261109071017.438478-1-hemendranaik@gmail.com>
References: <20261109071017.438478-1-hemendranaik@gmail.com>
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

The comments describing struct tc_pie_xstats do not match the values
exported by the kernel.

Update the delay field comment to microseconds (PSCHED_TICKS2NS() /
NSEC_PER_USEC). Update avg_dq_rate to bytes/second (avg_dq_rate *
PSCHED_TICKS_PER_SEC >> PIE_SCALE).

Documentation-only; no UAPI layout or runtime change. Touch
include/uapi/linux/pkt_sched.h only

Signed-off-by: Hemendra M. Naik <hemendranaik@gmail.com>
Signed-off-by: Vishal Kamath <vishy0777@gmail.com>
Signed-off-by: Mohit P. Tahiliani <tahiliani@nitk.edu.in>
---
 include/uapi/linux/pkt_sched.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/pkt_sched.h b/include/uapi/linux/pkt_sched.h
index fef848eaaab2..445a041cd103 100644
--- a/include/uapi/linux/pkt_sched.h
+++ b/include/uapi/linux/pkt_sched.h
@@ -920,9 +920,9 @@ enum {
 
 struct tc_pie_xstats {
 	__u64 prob;			/* current probability */
-	__u32 delay;			/* current delay in ms */
+	__u32 delay;			/* current delay in microseconds */
 	__u32 avg_dq_rate;		/* current average dq_rate in
-					 * bits/pie_time
+					 * bytes/second
 					 */
 	__u32 dq_rate_estimating;	/* is avg_dq_rate being calculated? */
 	__u32 packets_in;		/* total number of packets enqueued */
-- 
2.34.1

