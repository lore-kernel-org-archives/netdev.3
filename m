Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E05320C029
	for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 19:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773256485; cv=none; b=NvMQU9+6NG6qHiVg8Wr5Z4mHqVbArSfVwaBoRMJij54dUGagTvQ18mETEnDy3t+1zihASyP5UOpIk3YQsF/otoOZg6DrEKJY5RnclOXId0Q7J/YMns+ZfBoja14p8g/NfD502bUYlAxVAb5A8hwJ2PDgc+hcFIB3UcwYgydd7eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773256485; c=relaxed/simple;
	bh=Pq7WKcXzSeR7KVK6f6E09WyZ843apjaQcmdYAuPWLlM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MhQKqtRutrm+NHoQUn5Ye/PNR9gXc+AAIIOKQgE/M1WIy74M9fB+gJtz9qZfI73L73TU4659xpDxnWXc2e2Mo9gsledSepavG8tS8CxBHm2/LIeWTbyURe6ZQlnPL1mCB/6j/szTkscIwY0OpzuwltvPY4S5Ta7xTaCASYXSEd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1uD9uvs; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1uD9uvs"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852fdb36a8so1976255e9.2
        for <netdev@vger.kernel.org>; Wed, 11 Mar 2026 12:14:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773256482; x=1773861282; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rkT5h1c9h1wMjZ35T4RgGzgmp+0K5CAbj2aPzzC5vSs=;
        b=U1uD9uvsGFOXPNydxgv9RLEDUHGgYCFkXYkPB6D+YBsC7Xv8Q3ZsLQ1USFdmawiFjk
         wK/85NwfoEShE5+ozaO/JPgWy9QOfHINdmv7xKtHHyOjvltRNIfNvTDRgAzqBBDcpUVb
         niGlsLPkyW7FJUkjm9gMdJQ4+ZyTWNIZzcR8kG11+TPj9OIWcG7DDS2FzzSupq/mx6an
         hvbMHPPb2PRW99dgbJWTO7Mp2grf+w/Nb6TOlzgfzI2h+1jf3isM5HkHHslEAVc08ouo
         f0uOX+ri4+kVWjn9a+En9790e10O9qK6Ic+VEVjC2BuJBnrAzq4hLXH3+6ZQPkRDAvuK
         ke1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773256482; x=1773861282;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkT5h1c9h1wMjZ35T4RgGzgmp+0K5CAbj2aPzzC5vSs=;
        b=bOdzQ3SlFrg0X8g3Dr7PSIvStJP+5cStyIzE6ODKmRedaTe3Psg6FUMez2ikwlxbvM
         MBq0Igi3C7QyPxmVfNnwqRB3gKaS0DbDGk1aLa/W46qwhpFepcKZ/RDi6Yk5PQPXAaX8
         +kUFvYHKQA07tTJV/QtY2+YF3/LoDTc8lhyxKOmaSwA1+v4kflqDxDx/dRrecBI4JI+3
         SsXBBlSLci84iT3GHPDY/h05OZ7GH8sDsHCxRQJO4F1XoJT4IAmTCSBUR9o32dmJS18B
         3UJj+GGO7GnOVcq/Qts2UY3zxg//NOgnhO2F4bH+QQm8vVzz39U8C7RYCuardAD9nd0y
         sVPg==
X-Gm-Message-State: AOJu0YzIVYe8/bm3gSS1J/PXTjJ35KfCaPpWy67vL9jEoE/OR5/MDNOO
	bbXk3aoDsnGNsftfwV4lroELr/DZvt6V+sUEJ7VnGxQ8TPEzJiJnz31E
X-Gm-Gg: ATEYQzydZSgE1CXEgvrLerotk1Ad7zrZ7dTweHoU1gy1uFFK9a9QKoDO05EhRnckQ6V
	BNX/pASzvLoqGM94aUKsZydHw/w4HhzYL1HHi9lwDPkOBmJ+YxtrD3XB41n/r7UUk7vaXlilLRM
	zlY+e5EIIWrOusdyvUau2PR9HYeJHW6Xc5oFbx61ffGL1JK6yLui+XrsxAIJyjvKAb7AWx324Bk
	be3r3NWFCsSJgIavnQ7d1NklXHRVDd69w+YHpHoMmygEIJd/f0cAWXCzJVFzKeKMM3bQdzIoV6B
	fvuASPpaPkHAZkd7CRifuqUnQvLbauEiQXu/z4zZJ/Fz5KkPgnEZ3+MCs+7HbeWpeP0mk9sqI5L
	dIANSNPgp6SLr1y8LzSWAhcBhLJARIJndSEC0BRlFwXHbpfY8bJ8Qz6dPsdPgz7o1PzC9PjJZoT
	32Z30RJSNz2Ee5jPfJQh9iCXfts077cGrLbsfdZKdoIeRt7CwJt9rbOS+M36uN2ZAFbqbTiolJ
X-Received: by 2002:a05:600c:3b1a:b0:485:34b3:8585 with SMTP id 5b1f17b1804b1-4854b0d6ca4mr71576735e9.8.1773256482205;
        Wed, 11 Mar 2026 12:14:42 -0700 (PDT)
Received: from turbo.teknoraver.net (net-5-95-156-124.cust.vodafonedsl.it. [5.95.156.124])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a2eeae0sm28084075e9.4.2026.03.11.12.14.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 12:14:41 -0700 (PDT)
From: Matteo Croce <technoboy85@gmail.com>
X-Google-Original-From: Matteo Croce <teknoraver@meta.com>
To: Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	John Fastabend <john.fastabend@gmail.com>
Cc: netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 0/2] e1000e: add XDP support
Date: Wed, 11 Mar 2026 20:14:35 +0100
Message-ID: <20260311191437.3581-1-teknoraver@meta.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add XDP support to e1000e driver. First patch adds basic XDP support,
while the second one adds support for AF_XDP.
Tested on an Intel 82574L Gigabit card.

Matteo Croce (2):
  e1000e: add basic XDP support
  e1000e: add XDP_REDIRECT support

 drivers/net/ethernet/intel/e1000e/e1000.h  |  18 +-
 drivers/net/ethernet/intel/e1000e/netdev.c | 600 ++++++++++++++++++++-
 2 files changed, 606 insertions(+), 12 deletions(-)

-- 
2.53.0

