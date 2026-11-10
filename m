Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794344535;
	b=uOB16NIxcSWnxLupLEaBdMGTpBV/E09oy9RnpdWvQZlpSLCQJmSL4Z5oOlKGzId3LAAp
	 ycfSwYwpV511YbZNpHkDl9lciovJDOH6u1dTmYWaEhR6KondZt3RSyci4Gyzvf8n5EN3r
	 2fFw+EiLTnU/0xBkbPW8aoG6UHpd4pGKBUz49q5nB5PU6tqkYc6Bn/VDLmkBYiD20GhQw
	 dbI3DdX11IPazFabTv0HjBvS1QRn1TNrMOc89rTnbnYYEm/sidOuNLTaki/QuBludb1ER
	 mJbJxpr2Ou1+YC+SEuXA2iZ4kLpl9+AwXTND+tugUWlIBNB4YCDEPl0gulUNQIzdQ8g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794344535;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=LyTvhcJtY/hqbJYI4KH/+07DZKBe5dmpcgqrAQPdyX8=;
	b=GW7U86UpPQ16f8AzTii+XdGSUgoGp44CCDUDfoLkZ39CB2AGWGZsx2/de/ZXv3WagZcX
	 rgxNriGH1lQ4eS/jjJYuvQNz/BHcWOu5FGxf1i4He1m7SMc9PgC0nLTH8RzQwAzjQmECv
	 4Vqcsz8iDcIQU/aB2+c/EhCuyxFwLhmsiXW5JbR/bqLO1zDOVehj+9XMKGz9NEiDuRqxB
	 OFpJvVnDuEZ0LZePlVoLdHNW5u5fb8JEFpd970R7oqszQe5UhMT1WQJOWzeczHNSZ4uK5
	 ImtSpQa3a5R37fQzqcQLcQPVrxSP4kOk/ozMgqcDsF5BwvRy+FdHi9vvCnaevFHz1lw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=blockcast.net;
	spf=pass smtp.mailfrom=blockcast.net;
	dkim=pass header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=onEK5Wp+;
	arc=none smtp.remote-ip=74.125.82.173
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C7B606A333
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 21:02:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7C7B606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.a=rsa-sha256 header.s=google header.b=onEK5Wp+
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-37000e7234bso4723750eec.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 13:02:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1794344534; x=1794949334; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LyTvhcJtY/hqbJYI4KH/+07DZKBe5dmpcgqrAQPdyX8=;
        b=onEK5Wp+5b7JsC6nGEK1Dz3jr7ngICTy3rNhYCUe/zLLW1Jvm0VZ7AwukO7vfo7WvH
         bCyWkTK+JU4z/srxFjttLg48PSpQCDzdmWFv6Y87SCepGLkbu2QJXm7Dzw676wiISiWc
         FojYGowDEYHLVTEupTaUd5xwCOOlBMA3Y26FCyUdgZ+m+UuuCD06hRxr4CmUjkOgaUX9
         +Pxq+8z9Q5ZInwBmaZBw4HwO4FeIrsUqncykloG+7aR1T4pYMzbZ+VY/R7pmWjl1JEwJ
         cXPOV7Qcu2HgdVgntiG+P9GUpZ1OGQ7aknTCtiYR11N4qMSy+J1vVOTFq+R78vqTQWKf
         hVYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794344534; x=1794949334;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=LyTvhcJtY/hqbJYI4KH/+07DZKBe5dmpcgqrAQPdyX8=;
        b=INFHh2IR2jjoAPBruGzchXGPdY6YQAi/CZBywXGM9D2KJECgzionMOA7b89/a++yHV
         XmGSX6Pb1fWxwS5oEFFEfIrIILukEcEyX5p/fZVnthhktCTjBFQzUy/Kb61ivDN4oQ+R
         ZA2tv9b0b0SJ0cwaNW1bDa3sWjJQy5cmS0lWMLEILxFK4sM9th68gVec+f3RhgiBcxjV
         gMrq92VmjX+e1bEtTfN5kCYVYDPtfE3RwExRemSge9cXW/LzmuTfsniswsBl3uIlVI1B
         51WyH1nsWF5tx1f21Hq/uICxWAAKsgFJ327noWNp0Jk10FktP/6fRHdIwdklWkmSwWxW
         /eZA==
X-Gm-Message-State: APuU4Z+G/rPheOSYQVJadBFwUdR84pM1SRyumZEpbuyxOYRPbD2y1pYE
	RYirzY/+XxLF2o1jX2Nx+j/Q6TfCRyrXoMVlzEPakUyMt6w/Je6TqhSwGe1lEXUHJwI=
X-Gm-Gg: AYBFou0smPXRpl1pX5zHeuc5hwmkbuh3sRDs5A9hdCIkuFdxXk4tdc13Ji2sH17R2Gy
	4FUM3z1rYdFeUqtlzXiI5eH+xHC830W6qVX3tH3JQiXsaHU1VSmjY+BuiSFjqBtSUlFiC6rhOgo
	+Em/uL+Zw/lvnXBNaX8odlEtUbu9EPUtuWMitPMe3yeFAl6EAgrop7fLyMoYu0Prlr5xf2+drNx
	iMPkMtLsUwmzFz7wrHL/nc+Wcu03JwXuXYWcShxkzpGbF6bEu/cA9WK9QX3WB4YXo7uj+K6P916
	BXjaaaU/Y8uf+AjbZE5kXUzNZ7owt3oDPzarOFClVDs711Td1SA8s39o5dINp7O+4ZdScubIDXy
	ZvrMyJ6m17JcJByjH0y1xMhMHmRJXQMgFXTt7dkCvcGcWTAMjLAl74m+Fga1fvIoU3QBHSxUwCM
	darn8Qop9qCgGcE/a1rRmFkasV4lHrTkXqsSYy1U7/gSUJMZ+u6scKT5ILdCYuyq800C/xOwKfR
	d+twq8CCpM3/ePxVOU4jaFVAMAWBZitTiPK82DbB4tLyixoDCEwCLxpBdgwjSKkHYjn3uiAaiyd
	O4otjbnSx4v23oFANL5golrSSmVAD6qOB1zNGAcsJTyqMBIiUuNCpo0WJpvpjLWXwxVMwlg=
X-Received: by 2002:a05:7022:b052:20b0:17b:fea8:1425 with SMTP id a92af1059eb24-1b3c032fc24mr87106c88.30.1794344533792;
        Tue, 10 Nov 2026 13:02:13 -0800 (PST)
Received: from devbox.ts.blockcast.net ([2602:f74d:1::32])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b3b5b4ecccsm7919469c88.13.2026.11.10.13.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 13:02:13 -0800 (PST)
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
Subject: Re: [PATCH net v6 0/6] amt: relay tunnel lifetime, validation and request-path hardening
Date: Tue, 10 Nov 2026 21:02:01 +0000
Message-ID: <20261110210211.110139-1-omar@blockcast.net>
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

Please drop v6. Patch 2/6 still lets deleted groups pile up on the GC
list without bound between periodic runs, the parked-group pinning
Sashiko found in v5 1/5 (now v6 2/6). 6/6 also needs its per-source cap
derived from max_tunnels and its changelog to state the MAC expiry,
replay window and key seeding changes, and 1/6-3/6 need corrected or
added Fixes tags. v7 follows.

pw-bot: cr
