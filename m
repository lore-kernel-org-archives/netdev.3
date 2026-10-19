Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792442329;
	b=ZXPIrWSRmMDkQarMnBXTErUXnMVzjGg+aZ0Po3WamvPoiD07gqndXZ3rbditorCK3g/7
	 h/tEBLAKQOt2QjPORSYaeDcEalX3fU2yZ1bLHl1pkqMrFqp7cJCMJS0lFrfBEVoxR23rL
	 7iKxX2FffV7q1GS41whjNTVPXBYzRy2NSHvioJPY6vbl6OzFtH9CzvnnbrVzC4K1hqZ1h
	 SYGM+C/ll3CEK/ED+gk5/N7F6oM6PZFuDJQsq6XDqpnXDK91+syya50ZqkI2rwQMZ40Jj
	 GWtnlRsf48BLqZKiCsVOu4OOJjBy3yT1gH+1SM8Uuam638HXyeYmshFoWhuxA+NeQKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792442329;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mykHg7PdEIFWYonj5E895gaE3QCr6/2+cpWdbuosEWo=;
	b=uJU7/IpRxoOvEE2aGU/+CB1CaaDUzsYuvjj4QoTdACf2DGZ0Tmb2WbnZnlp2Ybrco+hl
	 mkdVGyhdN33Rrpx9buGr2PIpglgwa5Q0aszGmb5t5wqKfr/CgkAiHLcdSUuYLKqDGb68u
	 d9Uk/7GRLDc1i1hF+pSMFGP/GBEVSoM4UTsREcu6dFY8OqWU83/MwkZfn/hvLXrCZuFxU
	 OqN3bG++SUstFLSPDYPkxCIqAqHeKJaZ4lfzgr5PyBvA0ix8199GThMEfXcH/85Rz8bng
	 fpEskDcmdqYKLwR/BzCAo85bbjqQvcQAtZcvMD9h+ZqLx7ZvU5AIUtACtwu0BGBQI7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XQPEqwwh;
	arc=none smtp.remote-ip=74.125.82.175
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA13606A32F
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 20:38:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EAA13606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=XQPEqwwh
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-35d0be18c71so68405eec.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 13:38:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792442328; x=1793047128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mykHg7PdEIFWYonj5E895gaE3QCr6/2+cpWdbuosEWo=;
        b=XQPEqwwhxF5aBusPPewAqtjL/4RB7zjmYaFFEHrLsEPs/HqvQBnndctqZHr44dg1NP
         s1QnGvOPSthfVCXoBdrtnX+W4Iiu+SU2R5vVqXhlZb6RW55qesYtINTkXyKa+s0Uk9fM
         M2IBLX7JcrgPpsUGP4i4fgH7me70V6R+N+FMwhtjP+AOrLiKiCYt+ed5BQZj11On9fNO
         uQByD3TCKdKgmV2sUBE/n89HMix7ibezzrrlnU2zKwksuFRnp2X8idvYFzAdQrdGYZ4y
         KzEJi/Is3bS/6RJW/yUg+naKg2tLFDDfySZcwTkG06qzYrLHRIBxdZOZ2AYFCnde4sqc
         7F/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792442328; x=1793047128;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mykHg7PdEIFWYonj5E895gaE3QCr6/2+cpWdbuosEWo=;
        b=efx8IDGZhECw1JgdPkfsomH6IF3PPK45TeQBb8bORizIu/PzQwgKa8tNqIxiaPOCeG
         oi0dLJO3PczhZFPFmaECYN9Z6ORCFXRzeyfHtr3X3QmF9S1MVnC7yI8EDhvzQaCdQO8L
         EkS3ojYqdJEvmRqqJttcP3+pH/G/5aTo9ezjW6sonft8a6jgkznv3t2hLFlKzBfgE793
         4mZ5sB0y2An1rDK/pvs3YdnsPgJLuJf/bkza6ZUTQcH+LM4NVPWIZMcSv8WuwmxBHm5v
         7CoQ2xBc9E7X4QhBZc8oBFb5dKSSxXgSrUipIW77LWCGvRoMPKaEw1MdMdKis0SUAXbv
         70jw==
X-Gm-Message-State: AFq9FYL69M+x5bn6y3HCKrQ8JZY0bJgC0RuByLMCYo+wffH7JhaRWebl
	T+HOVbOojzX1hYsBH+l6OKKCIYsDXrAJHVsEF/9/9q547X3oF1I5aWLCe2bELQ==
X-Gm-Gg: AYBFou2ttt+6n9CCQBoVxDER70Xx9lE+DX20062+QdLITGlFAgfT/ThSexfPa8PQgIT
	Jc13XYwSDBHUXE4yGeZqkki+c3FL42LXeFuRory3TN2i7LJoMEp6mTOnF5+zba6ORQZh39u5XWo
	V9oCLfTv8/SnPOt+mxCyd6J07vK/r2RbQ2aYTnLsvZd/U7NhrmV54HQsfE4jLXJl+EFXhvvH2Ws
	5p0cWHfJkQeJNG7R/p6p0J8XEpsA1lQnB/drPZego0ZJArkZOym8TdqC9QsZ0Y41f04TfoMazIP
	WuP5Fwehn9ljdahM29pSpCTDKYbwoutWqvsKEyvN6WVgMRA7jWNmdrq0ECaA0JSTSHoGl8G3Wp4
	rwvFCnCOtJDpH5l0YI3ZIO44B/arPaxHp+YpSYNeUFRy0nSqRHFPd7CGcqPK63x1DHfOJrGjIYc
	6m9BC/vD+qe8+AJBdJHFNC04JugP/DyiDHV8hVJoMDPD9Pig4LPkbGap/q4qbTRHp5D38MNV5SR
	ej19soGHPaJ4JI75ty3kHRv8EpjegoXwyNQSqtOqI3Yplp+cfp/CFDksZ3+rtN4GbI3EIZTQ7DG
	ZCWX5X7KFbc+kZp4vcYCxxrTBw==
X-Received: by 2002:a05:7022:121:b0:146:84fd:7b58 with SMTP id a92af1059eb24-18dbe2af657mr274276c88.9.1792442327911;
        Mon, 19 Oct 2026 13:38:47 -0700 (PDT)
Received: from l ([2603:8002:ea00:6800:7440:7d9b:b57c:b3ae])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-183190aa411sm35138806c88.4.2026.10.19.13.38.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 13:38:47 -0700 (PDT)
From: Dave Seddon <dave.seddon.ca@gmail.com>
To: netdev@vger.kernel.org
Cc: Dave Seddon <dave.seddon.ca@gmail.com>,
	Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Subject: [PATCH iproute2 v2 2/3] testsuite: fix test_on_not on multi-line output
Date: Mon, 19 Oct 2026 13:38:42 -0700
Message-ID: <20261019203843.3127235-3-dave.seddon.ca@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019203843.3127235-1-dave.seddon.ca@gmail.com>
References: <20261019203843.3127235-1-dave.seddon.ca@gmail.com>
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

test_on_not used grep -vq, which passes if any line does not match,
even when another line does. Pass only when no line matches.

Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Dave Seddon <dave.seddon.ca@gmail.com>
---
 testsuite/lib/generic.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/testsuite/lib/generic.sh b/testsuite/lib/generic.sh
index 8b339ec1..ac48f023 100644
--- a/testsuite/lib/generic.sh
+++ b/testsuite/lib/generic.sh
@@ -113,8 +113,9 @@ test_on()
 
 test_on_not()
 {
-	echo -n "test on: \"$1\""
-	if cat "$STD_OUT" | grep -vqE "$1"
+	echo -n "test on absence: \"$1\""
+	grep -qE -- "$1" "$STD_OUT"
+	if [ "$?" -eq 1 ]
 	then
 		pr_success
 	else
-- 
2.55.0

