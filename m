Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EBBD3B95FA
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 05:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791437380; cv=none; b=o4vutLuxLy1i4NVzg6pxkqU2WtPy0IjfZIn8AGOFvy32UCckVZmmYwrwo3b8fdUzyBio0BKIVnbxKntl5icuDnbNP294ESY6zJCLrr7Y/wSODqpIpvhyN+RC6G3CF63BhF+Yf2HhLd6ttpkNDiAB2cK8ZJ4bjXOogf8NxImmi8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791437380; c=relaxed/simple;
	bh=FujY0FuqAuIpkLZ3y+9g/MN53rcCMTlTeQOqOTnanCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wy2rkgTvRedGVbTHjr9ksKAazS+SAKCn223pukhNnGb0m1nXf8rNP1ra/X0oPiPJGdme2Nv6NOHgjA7nGJDDGAA0NVeuPcXsPDA7UQkpQg7BZLx9h1xg+GWBRKKOYeaD6Y0/aVFxSOefNrgatzKBzdmdzMUc7EIHpL2x8K0VYHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n5I+NI90; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5I+NI90"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-398b3c37877so1693956a91.0
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 22:29:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791437378; x=1792042178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=DLvhL5rr6s47bfQUS28f5Gkp9XOkJpXtZ7mZKPR0QEw=;
        b=n5I+NI90Wi+5BHGbjKuqJzjvxnlBhtkl89NGTJK3c5ZNAEuMchJD7X1B+mF2GBf3xp
         VpTnmPv148uVdg4gQOWEMyRylIq0x01pTh8MSNcClZBFXFCm5OMB5l9Un8mRd7K98czm
         FZpA45l4gUvz1rdh6FgFMQDHyGWHlSnPQxDRvYOEpcj/r14jt8ovKQl5qFQU52wrWFi2
         uxxdL13drp1LCD8kxU9K52WzrMP5bu1Eabg1ED1RKECZjgU6sVl/QnzwkZSJAaqVx7Zk
         3kreTT8pHwqq5+NIbeF8X9OJBprYA405VXWULBUOovW5YyNi52XSAZHKQQOf2l4hmdkM
         HVWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791437378; x=1792042178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=DLvhL5rr6s47bfQUS28f5Gkp9XOkJpXtZ7mZKPR0QEw=;
        b=tL2RD7Id7vxdJ5WCG7RItcw/jd4Sd5f43ErpgL5hx/mq6fg/FGB2pODQcOj6TpDCtw
         6ik6cH6y6UqLAOGFiILI2o99U5pO/aMYTMPmeEcp8fzsA4/brDun/ECIvAoJee6/Rbr6
         erAq+2AIdbta4Na27D/yBcsKDfeYa3M5wCX//V9hGYmesrsntQ7CzMeHzp6b9mW8qnJZ
         TaS38uLeOU9uXoUTtFRqto0opwSqZShzxJg9JCKgu1oT2TDs7XP1ONNY2tE8/SYS46GU
         o6cqNTWGQmaUgmypj7vK9kQZRuaIkC6pEaL4IuD36+IEOtQDINAg0IVuohh79tK5BQEX
         f/dA==
X-Forwarded-Encrypted: i=1; AKwUvByiiVIAb1hdX+23qGSI7WIsVO211rzwXLHi/3+qCUYCB1ed//tq1a2+AU03PNAiiUnHo4uvCdY=@vger.kernel.org
X-Gm-Message-State: AFq9FYK99RGYwi5al3r1kAkVmSuphTy6devMRAyWTizJdQqD/K4r7Wco
	hpbCZPHvt6shvBlfDVi/vnqvmjHbtIjSamgAsfWgrYQxqoEsdyaWpjYB
X-Gm-Gg: AYBFou14h9gKrT2S7Hg4iezPZnqUDlzbk4YcTbBiaT+2GA03D0mgNB80BFaeE8Wxmla
	Sqh5QG5t+NnjDTV30xkjKbMxCDertpoeK2AY+eWMLTqW7sPI5HKcEYfcA2ZNz9Tc2AJKKAUJv4R
	mb0n3X4zLlNKPeCfPeuznelE6WWNde6cB+uV140QiOSIlXdOCxjXzuzJQZOG5hxwdA+GDUY7OaG
	ybfAiHjkCk7/8IKON7bVGeJqfYpD4PgbwAG1ipGLtcpD2P2YBPHmZWOHwjCS4ksYx01ePMMXIz2
	Qooq5V9AuXiCxEaPMAmgOb8GLa+04nc08vpVsTLX9UGPmNRcXFWheM6DVUty0qsCXKVk6i5qNGn
	t+xzROYR7YtkeVg+r+6T6FhHw00DeR740BDPB+V9tl8+554F9GcwF1fG/HOrATXquHRxmhU5xCb
	DLeVx0S3yupWRW3nrCm4y0yRe4M0i24a8kLfvvtTnxy0HwixXjMP3+gJZaz6SRBI2VrDUfDg8HU
	IjX9QAxGzg=
X-Received: by 2002:a17:90b:2584:b0:3a7:250:333e with SMTP id 98e67ed59e1d1-3a8a192b889mr3373640a91.11.1791437377539;
        Wed, 07 Oct 2026 22:29:37 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a89dcc4e04sm3758223a91.1.2026.10.07.22.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 22:29:37 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Amit Cohen <amcohen@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net v2 0/2] ipv4/ipv6: do not warn on route notification size races
Date: Thu,  8 Oct 2026 14:29:21 +0900
Message-ID: <cover.1791423190.git.4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A nexthop group can grow between route notification sizing and filling.
Both IPv4 and IPv6 can then legitimately return -EMSGSIZE, so remove the
stale warnings while preserving their existing error paths.

Patch 1 is unchanged from v1.  Patch 2 adds the IPv6 counterpart requested
by Ido.  No new build or runtime test was run; both changes only delete the
stale comment and WARN_ON().

---
v2:
- Add the IPv6 counterpart.

v1: <20261007045410.3806739-1-4ncienth@gmail.com>

Daehyeon Ko (2):
  ipv4: do not warn on route notification size race
  ipv6: do not warn on route notification size race

 net/ipv4/fib_trie.c | 2 --
 net/ipv6/route.c    | 2 --
 2 files changed, 4 deletions(-)


base-commit: 23609bce9e1de525d1d0e73fc68c6e7971d0b49e
-- 
2.55.0
