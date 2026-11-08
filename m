Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794162725;
	b=r0M39hjuWDFo/HZPBfFnjQCrIAsj10HNteEokUGeXvP0zibMyLdIMZQfIMlw/myuGAlf
	 mfLa3X1kVmaz1gvkMsemmuNIHDNsD+ziUjBSwp27PVHrFLTt5qPWE68pvuTzjK/ohkKXA
	 aDYhEn7bCcM8UkmgXcq4ebhWB2gy+Zi5khH/Gw1g6e7X08CW0MQ+PB4VWNy5cmqr2FDJc
	 OIkucq2/FL/booLQrDFBNBfpaRq72KIAtz3ngCXyCqh+DFTzFIbXvd2rIYEh8/V8rEtGP
	 KW/SoGGYLtKoTXYR43xNwEUTqR4Uk6M8v7cn9i/UnT7wqZsXGXWExxrCLQF3DLd01sw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794162725;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=dFkadmcoyh6vL70GL1A4zEl8wwQu3kHxlpOJ4h+0Quw=;
	b=O0kS71Gd7ClklOBigBP+C/cu+QttJDD05aYuzP3ZNO6EbaQIp5Khhzgzbm7zTL1+fJ0x
	 wP2crvSMD5NderitnkyrWC657786pJvD11dp1UcUkc2GM/vKgCLJstN7oEgUI1tADKH6k
	 RIcj0cs3E4g/MiHTUok5+4LC8pnZlBbTyVftUg+hZlHx4cb/f4fkZl4cT+cYhuLqX2vMH
	 OJwd90brmsbrgsT9MtoecrniFrAfe7ny0cndd3wHuLtSUXqHp3A6xEYt0zKuPUUZ/StuR
	 7Lt8iOW/fMLg85cr9n41Ubv5UMme8fBZMHiJq3NFKbEqW5mImIh6f9/in28wSoimM8Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="IJ80/boD";
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE71606A31C
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 18:32:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6EE71606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IJ80/boD
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3b09a83d12aso135518a91.2
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 10:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794162725; x=1794767525; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dFkadmcoyh6vL70GL1A4zEl8wwQu3kHxlpOJ4h+0Quw=;
        b=IJ80/boDQtMRoIwjrZsUSJQgl+ycHU6Grft8+P2IPGh/JQ3W+dE4vtcvHfk/sSqh98
         F0WVJbH70SFLKNeBMNnyTNLf9MSEw23N4XCtkCGWhf3y/GDYlFDYxHGsFwqJH/SS+tNo
         CYgtiqfa/cE19pJQlOI8YX6F+Rm7JEM/Dn1V2Z33eWdAPKWNpBCceOSi80fDBVYxAcyy
         DhfbqGkrNzThf+U/pW9nSm/S7LVNCVZSFnUzb2EzAPfNQ9eUrBD9FeaSZSkwv6SbkJhD
         bGcRH9s20alGfUvsrx299D129jLpAZS9t+iuvxNH4Jxudb/bfK0k+0B8ck+alwYGDjCj
         7fZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794162725; x=1794767525;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dFkadmcoyh6vL70GL1A4zEl8wwQu3kHxlpOJ4h+0Quw=;
        b=d3fOJBI6u1MR6iGEVBKoDS3gdDQE3qPi6fJLKTVObCFOEHIw9TMxcekkeLdTlmZKJ2
         uqV9VhWpYPnmdsizZSsYuD6k1KhUgjUbBhuzbvvLMl10QAGCDAUPfjlhbovdk/TLASKD
         QTRFiUe+Nts/4BtIZHErpX9rzz1RKNtkMn+PMgHlm8P9JcwWGffj4ejwI3Ue+pbuFGnu
         YAgNx33JURkQKX2b19IO18Okn8oHJzEQZCAm30HZCjubEXLIbsKHBIBk3lDkDqDg6jvm
         r9GC1+8hRDkomR/PnQF301VKq/MFUsv0Vr9HUnKuTTn+udsmd4vz4kYlFl9wLyvjyP05
         bhlg==
X-Gm-Message-State: APuU4Z97KoYfOhp/ubBkKTeS83AuOqzBdihtFwvbrAE94a/pB6w6uLPD
	A3zydRatHt7RFdi4PmDKNpO4IVkDgEBJ+oB8BfrTyb35RIrEEts1boz5yZmRtg==
X-Gm-Gg: AYBFou0kXJ18gDxkBbJK8iy4rsWx60/Jal3Ee67sjYtc9ivMGBWmR6LFILiKnrkBPep
	2C/9PwKMLBSTJz/7b/Axx1GIsquO/3zvOT2FtlF7DTF0RQ38jlZ+bnS1toq4TVoOBXeQDaS6ZAd
	yk/fOM5N6l3sikXRirPVfFNrgvjO2NHNMqOikzTSff3tN++mCtMpHd2KIAWCzp4TEwnwfuLjP8w
	HLexOE9IG7mAj6SkOlyAIvV+m2mF4A/qMtpQQKSyo2UlNJoCaE8+bzMb+BV/3TO7HghKJdbqUkp
	GbZUsVYmOFLXn9Kn69cadKxh6jOdm+rZk9Mg9Nl3RklQhAGKm/Eb+GJUuEsfZv8s1K/dmXf8jOT
	j6sfmbQjm1NgM75t7B2TmcsE3+F3tiEi70Z6TffbqSp6hWIZgu4dyxHrwY+CIMNv9HaDV/6U2Hd
	OpSo+EcCj8pqE24l9jlmGZgHQ/j2I0cTwXo7ZfGLBwu7Siy2Y334Mev4QTRRZvQCWTFC+AyZF9s
	nTLM7ci8f7fA7pji4p06dRKZ7FJs4s6tkfnUeZeII0ZjqHPdOu6T1LqYFbexXcNiXe69V9hL6SJ
	YWxQTJFBUo+P3HFrjU6BMgaVREaZ+bkDLJej784uwTcKtM7u5KJVhw==
X-Received: by 2002:a17:90b:52c5:b0:3b0:9e2c:9b57 with SMTP id 98e67ed59e1d1-3b12d1087efmr2244213a91.4.1794162724579;
        Sun, 08 Nov 2026 10:32:04 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:76a0:28::1d2:30])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1054a53e4sm7600534a91.0.2026.11.08.10.31.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 10:32:01 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 0/3] net: dsa: motorcomm: MIB fixup
Date: Mon,  9 Nov 2026 02:29:25 +0800
Message-ID: <20261108182931.1542638-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Various MIB defects, reported and verified against vendor doc by LLM.
Very low severity, target them to net-next.

v2:
 - fix issues reported by sashiko
 - drop patch 4
v1: https://lore.kernel.org/r/20261107132040.1066996-1-mmyangfl@gmail.com

David Yang (3):
  net: dsa: motorcomm: Fix stats64 error counter mapping
  net: dsa: motorcomm: Fix RMON fragments stat
  net: dsa: motorcomm: Use safe 64-bit counter reader

 drivers/net/dsa/motorcomm/mib.c | 43 +++++++++++++++++----------------
 drivers/net/dsa/motorcomm/smi.c | 35 +++++++++++++++++++++++++++
 drivers/net/dsa/motorcomm/smi.h |  2 ++
 3 files changed, 59 insertions(+), 21 deletions(-)

-- 
2.53.0

