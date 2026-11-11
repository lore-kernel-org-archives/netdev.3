Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.174
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794421037;
	b=KMAe3SQ+6ocJ103evCKUXJXIERJltaD+3dzSFVdjLwRU/mDHGtVKfJoDVqXggMtj2CJG
	 Uz4KNsNhEDg89NCP0QLzimAjBKZSZAbe3MMA5n1LoPIpENg95tXZbaZxayAm90SuRDihd
	 D6vPfrSQ5cGLKOPGZ0JFvrpJuQKzofH0fM9VOa8yKH70C4DFXXz5N6wBuUUcJJCETPqcd
	 uB1f6SuPP7x/93LuUbnUf3yNbUA4DCVvtbSfCx5orQtblwukIwrO9nLmPghdJe1RtIUzA
	 sx7t03svx7cB+HOycXufAvBhur0I/9XTga2kiAeXsH3Zc72BN8olN+fAOq57iApw5fw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794421037;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=618pqcGBrZrV91HK6JBp0UjXa1+rzP/KMK4sW2rhxZU=;
	b=E7qyGaID1W/9sox/Ortbn47nKKeNzqq1bJCUUlKA8aCUTkieQYs+PVQ12sq2l3YAeBht
	 U2hOBBwxeYBBq0QIBHH/wFypC8VVUCQKqRKAmJ5feM8g1q6FIdAYJ+C00pytdVAu62YJD
	 XAuElJ9HnfU4uh0uqRl2bPoyUL8WNJiPronRMoQ5dx2X8tmHiNBx3c7NouARj1VL4iQfV
	 iXuQdtrzoX+6k26X4DRWh36iY7y6ChEBGUTUwbhAt58WfQ+XB5nZqzN1JMpBg+7mUhXL3
	 H/HgS0TRgLnDG1uBWc5mQmkjiEWMIBxXnp5sZsG1rbQxXLZXY++xdJB4rr7zAZtndvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="TPvZUxh/";
	arc=none smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FF35606B789
	for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 18:17:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9FF35606B789
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TPvZUxh/
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b31448caccso28401377b3.1
        for <netdev@vger.kernel.org>; Wed, 11 Nov 2026 10:17:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794421035; x=1795025835; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=618pqcGBrZrV91HK6JBp0UjXa1+rzP/KMK4sW2rhxZU=;
        b=TPvZUxh/IlSKDp6xSNqVKM98lnxZPjxyxn7ZQ+jh5xWX1IAn3pRRthM7bvPZWwKexb
         NXdDLrHKajeJ2JE9f0ig+JE2mvow9I5l/BAJkLM0wwTnUMMdASWgjwVQkIG3YqeZZTu2
         1fXBZ5o0m6i9fx8Ea8gAdaWgVNbCdoIbPHl9umJLEcCoY5HHxXhDQOpADHW/EfQvMOHG
         3Cb3vCSHedHO4gxEwp9CG8XvgK1NBfd+on7YGYx8lY55nnAsmfem4gFUrpzRRnxoKXk6
         apq4il2G9Qoau+GdBJKwH7pb55YcAgyLKJqVOPwwCu7ViOXnnW8mg/KWeAA2NAo10LU0
         E4nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794421035; x=1795025835;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=618pqcGBrZrV91HK6JBp0UjXa1+rzP/KMK4sW2rhxZU=;
        b=f3otcCMaOfsr1Kkr/x8GZEPY46ZO3tw/Qw9lH5Hd46SJXhuP/KJ2mMwy6VGGtxECEJ
         ogxh6amquyGT+MdPesUtkE2EeuB0186v1leUzMKJp/YCKVbzODmKMrTt5ry5WmxQAVoP
         JHbB/jvfIxOV2clyKHhldP1OgrC/s5340GAlznK+UzLZfvCyYAdAkEyMQKy58MDqJXBH
         mhEwRIVjW1pwtQsJ/rq5fhKgySDPV4n5KheF5X/u4BHbjFRB2wJlidF6xqECnxTPO0NW
         Z4v7sCzHY7eUTvoaxVjpzxRSPLOC+X++lZUm4nqLUxMeCTXjiFRNPsuj1q3GpJQfx/hJ
         DjYw==
X-Forwarded-Encrypted: i=1; AL+hErHopSZ7B9N4WPaaISL/7APEOJmnW6w8/s8ra/t+T1AxcwBUPVS78W1HXbJebcE7bJ7X1CGE1sA=@vger.kernel.org
X-Gm-Message-State: APuU4Z8LhrzLj7ImAL9fcTzOvBJW2H71GM6H04lpMgiyIzf9kGQ2n3Pz
	NUDgI4dqgsQatreJ8SzUqVMgaeknc+kqbyrAqAffykKZk6HOwOZOt7JG
X-Gm-Gg: AYBFou3Bykw8etTYwAx6v6qMcyH0u1aXgNRq15C8G98n6+3ap8OUdKIC1T3NZfKD8xi
	BKJXJcTDD7G8uiWpHQyyAC9RKBz0UANm+RhK6QUHA7bf7+FuJkwIY8ZeoFpoSIE/z9MTbGeF+Hd
	TDMgyRsxNEhSUgZYvBCRemjuO4yXCG7PwXULeLf4lE+VRZzDsbZBEPsblcGbRR8e2OCW1D2Q9oh
	7KMibQxQhbEvMjf1dJI9T6L47KpjqbURbjhg1cF6LMZMeHPUZmdZ0PPxr5gye0MlKlRLAVAK5pk
	CRJSGxS2RihRhIAHbtt8HUXNgGRRA+upn/FOsYlDho/PU98JS/UeEhnAmlYgcmZnrT74atd7G6Q
	4AfQLK2URYmRQgUj9XOUDYxjR/qUfR6o/E0T+xp8hD9lh0olKzj1WZb+e7Z/o05xuf67FIvqaKn
	/kB6OU+2OiWnZAUQ78o/yrSfl8lGzJpxGscVdMjA/Bo9/BfxlFaDXAOhABkf7KB67BtWk1kgtCu
	AkgjPBIdBjKEXp/mol6r+jzIL2pesfr369QeoLy+kUDkQAQNsw9iZWTumWJju/OF+TZD5qN5mUB
	LR2ABmuxE+LXYnsB8CVE0RIeFx0mYXiyyE3Ws55hhA/cS1bxX3XVaSv/uTAZEcfAZ6Pwz9n76Yk
	=
X-Received: by 2002:a05:690c:288:b0:8b2:bb94:8cb2 with SMTP id 00721157ae682-8b3a8071a47mr23369857b3.35.1794421035512;
        Wed, 11 Nov 2026 10:17:15 -0800 (PST)
Received: from VPN-156-197.vpn.usf.edu ([2607:fe50:0:f802::4046])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b39343d4a6sm50363577b3.37.2026.11.11.10.17.12
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 11 Nov 2026 10:17:14 -0800 (PST)
From: Juan Agustin Niccolini <juanagusnicco@gmail.com>
To: netdev-bot+sinfo@kernel.org
Cc: davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	josef@toxicpanda.com,
	jbacik@fb.com,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Juan Agustin Niccolini <juanagusnicco@gmail.com>
Subject: Re: [PATCH net v2 0/2] tcp: Fix the SO_REUSEPORT bind cache admitting a conflicting socket
Date: Wed, 11 Nov 2026 13:16:48 -0500
Message-ID: <20261111181648.34819-1-juanagusnicco@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <179441946966.2168702.5078417118584073258@kernel.org>
References: <179441946966.2168702.5078417118584073258@kernel.org>
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

> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.

The bug was found by my LLM-based bug discovery pipeline.

Best,
Agustin
