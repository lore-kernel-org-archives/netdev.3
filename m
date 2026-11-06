Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793934730;
	b=ObhyG9U2Z9blwxUi9IMr0Q98JepDyNdIwDL4wEtOJ7hCd6Bmlfs/hqsvJ6/HeRbHfUcl
	 pFX1nwVWKA4pTzoD1vXpapN3+16S12iPwcS4KEs74qD3mIqW84amqe+yuKOTmZMB30KyC
	 vsgxDnHxpmFIj3e5TdnsHSMFyVpYNcrSBiNt7WvSSUQ5qNBzmffUIAUf28q4PFO1mMXmQ
	 oBS8cF2FswODxiTzuCR5qxalsv4yXStcvmHzVFF4lq0j3KV521j5ZJdPnOk6KiMDuqZQx
	 596Pzovx26Jt/io5M98+be0OneodgSkWWcmpuExbyFFvAdedm4Dn4HKFv7IsSi2NbKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793934730;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=IRcXjez6Wcmci2QU6oft8mh4ZWWaV+Xd9hzzpugK6UY=;
	b=UqF5XSTFwtxTLQP4ow3PEgbwztPVWQZNaMi9Bc4yXC1QIvCQ2nmraoRbMH0lMlQeCEWC
	 9SJGlidpD0AcGMgfTJrpKkv9xrqI97kC3HghmkvSxlGKCJzHgJJQJAh3df7RpbfW94BgX
	 xMh/mqkiwLanYDJbPhw8wuK9iVr0wLXbG/NiRztiqY1dAerRLo0N6kFdQmj5j/D43uyJ+
	 SgOZAyTLaIDYgIM9c5c+B0MsfH0ao/tvNVVX0PPb+/L5zGpJ4oxn2zc17zkdGfxlELs4H
	 C7Jaw9i0ICgYrWiqC9c87DfdtdsVAcnstCVSbCwUtta45b557XI3sv5HGy/fjkZcWCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w5p8VSaO;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E778A606A31B
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 03:12:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E778A606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w5p8VSaO
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ada4c06b7bso93705a91.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 19:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793934729; x=1794539529; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=IRcXjez6Wcmci2QU6oft8mh4ZWWaV+Xd9hzzpugK6UY=;
        b=w5p8VSaO5NEXEHlMuy5YV0Adw7eaOIfNMTTD5WPQbBt0Jpl97k/9RuWnVZzgWFb3u3
         tytDIAj3BVHIjFNgLASr9EUORh7VRMgihNGPWYH2eR3GlsF9gJGir9e63nUNhVbEIDvz
         UaSQLNSGN+GXWnTiV/WAlKHGm73PqvMyP/LzEk8x0ABDTa1jspgAeuNVWvc6vY+wuttV
         Py7iqhQbZERiqhOkq8Pe3YZxSk6WsPChIc3gpnLgUvjARq79RCTFbkmQhGgHGWbWG5q7
         aG62HiiOq/MKGAoPbfdCXtkpbYZNVZinZHVXCzcTZNppJ5FxZE5mmPjPKZ7sQRSF6iXi
         Jxpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793934729; x=1794539529;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IRcXjez6Wcmci2QU6oft8mh4ZWWaV+Xd9hzzpugK6UY=;
        b=c2SqtQqm85LQI/raW9euk9qnFb8eCoVMQhEUBTwXqlQiaxyjf/edXXKAnZJUUpm7ZM
         2E5dIKxUSeHXQRJ1FqKvGKndhllSQDW/iEE/AXfqsbNi5FTDEpgx/VOe3Jy9JSBogLTZ
         3bIcTCxJ748s9pLSUAVMDUP2opltLlrQBwNDAC9sE+5gg5nNxiJwP8AgAYP9pZi4OvPJ
         mDW4Cndwf/OwPc1a83dk/HM3Rt93NW88ZaPoTDY+PI6SvWV5pLeOS2kQLvTPeSLqy0mk
         sVq8UTkbgjXJ8e64eWGABIypXRwrRSlcH0HM0hU+RinyRPbEhinuxlPNF3QfuZllmYgX
         OtFg==
X-Forwarded-Encrypted: i=1; AL+hErH4oJB4Qu7+45KORBOcuDCovcZiU51+1xKSxe4Phl4cHSzXeP/+d9X6WbL988EYSaSX3MoqAWk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/U/+FoawYSmxEF30L2eO3zhEOlVxzsFi/8Y32LJHEo/RbhcdFJ
	NdD3+QnXj9PSbtUefME/KqyVXevf8M/+Dte4gE9lkdj3bxPgCGFSXjTD
X-Gm-Gg: AYBFou1/3yfW+fw5RElUUebhchxvdV/eYzKnsyP7CCIrwwjn3T4c6pw5NhKmzzY4OBo
	a3p5Nv/koWhXnFjbxxUTXJZyxkdoiCqoGx3xpfWtwIv3y4G7ugnZg9nlNtLydDkTzS42wLdw27U
	P6+EkQEu7YHGU2m0NZXh8RFVXR4oxYSXk6dMGR6jsKKWe+hOwdo80Bh2qpv9HTXy+8EdfRfaxTg
	Hr7q35MIj1tYrmjZv4+WX/LFDcDTJ/EKMQSsSoRt3PX/grI2TSsqPv0aR7Xwq9ctw2JBM70C+mh
	BT2zIgBOHaVYMGqahJQBNmkDj8L21eZSjGjPdLtaXxPHt/Zn3XjWQdRKR0YcJIQfC7nKS+p6tKv
	AT6AgVD6/ZHb+guF8xdU+4JOsieUQrbYLMMlpurU0tDjl4ylXqk+04TlWUN8BjeEn8rzi+bG2gg
	xWqB1Iv3CAIsdEz5uXtE9ICSyX0/BpW1ND6efZob6upEoV8lOemI5VCv4tMVUp4+Thl1Xp9NDMU
	TtHpoO3P8YJVHgFX7wLALBhqB6crTfYpACP/jUG16GJLWrwW73/NLy5a269lZBLedTZnm1NuSDR
	l9uQ49Y1WkOEdYi7mvQ+AOGMv9LvwvjpMg==
X-Received: by 2002:a17:90b:554d:b0:3ac:aa8d:19e0 with SMTP id 98e67ed59e1d1-3b0db5efbcbmr1246139a91.9.1793934729247;
        Thu, 05 Nov 2026 19:12:09 -0800 (PST)
Received: from localhost ([2a03:2880:7ff:8::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b0d7c66fe1sm1386784a91.7.2026.11.05.19.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 19:12:08 -0800 (PST)
From: Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
To: "David S. Miller" <davem@davemloft.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>
Subject: [PATCH net-next 0/3] selftests: drv-net: hds: fix state leaks and ioctl tests
Date: Thu,  5 Nov 2026 19:12:05 -0800
Message-ID: <20261106031208.465456-1-dimitri.daskalakis1@gmail.com>
X-Mailer: git-send-email 2.52.0
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

From: Dimitri Daskalakis <daskald@meta.com>

Fix hds.py leaving tcp-data-split in a non-default state on drivers
that report HDS state rather than config, and fix the ioctl XDP tests.

Dimitri Daskalakis (3):
  selftests: drv-net: hds: always restore tcp-data-split to auto
  selftests: drv-net: hds: perturb settings via ioctl in
    ioctl_enabled_set_xdp
  selftests: drv-net: hds: restore HDS settings in ioctl_set_xdp

 tools/testing/selftests/drivers/net/hds.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

-- 
2.52.0

