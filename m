Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793699762;
	b=Ws8QXZxTrR5DlQKZEgZEKqKsgsOcpxLqz7CJtxW+QHVY4W0viqvruoMwLM1sYDFQzq46
	 bMk6V3gm/As2B6h/BnJ/UnFBIc6S8si2lX5yew3+IrRdHLvPb1yi12Px7K/tJ0siz1AG8
	 p/hzVBKELni2B4O+6x7iRdQTBtuYaH7rPFOEaw9qG17/yVusUJV0o/6W/L9lj1tsZzAX9
	 D+Opc7e+egHQ7o0DiQrMkEdCKDz8TFVEVGbB7UhNuFK5CrVwupEPG19ekxoqtbFeUo4QW
	 mVmV7mVKZdAkvJhHz9OfCfqqYKmAvW/wj1Dwd4NROfYnYgpGRWbu46QvB1zTC6AP9BA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793699762;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=ZhlFvLGCrbcs8sxORBaYOZNo8wD7mjZ19zKxzr41P9w=;
	b=Bk07pLoZ7fPlF+SOP2hOBt6aC5qLMpjh3k3rUf5pNKHSLluSqV+Q7+xgiYRC916JxmFI
	 VfPHHhPf2omlnXvI/7x2tQzW+ue/3qzFCmcmsGazgLbVdp2QjwcRsalTRTFpq0IP5mm6T
	 Az4p1ZRu78Yhyw3BDPZbv7wGdN2g+tumsI1yNHWog2+OfXFCPRKC2fzZ7GUYJin8PE6D9
	 Tq5YMdvwU5wJAdKp9V42cKMLX4rfEyRwiJinEUVXMiGyHoUxbuMGvhJ7MsdTTwEvXHlzk
	 9VXIGesgeDvWopkyx7NpC6wqOXbreM7iPgThtWmktQHo/dEWQfiO+QRARzVU5qvTk0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tw4mSAaT;
	arc=none smtp.remote-ip=209.85.215.169
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA716083631
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 09:56:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8DA716083631
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Tw4mSAaT
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc4dbda1e5dso1350804a12.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 01:56:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793699762; x=1794304562; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZhlFvLGCrbcs8sxORBaYOZNo8wD7mjZ19zKxzr41P9w=;
        b=Tw4mSAaTJL/2ywfIbTue4iPx4IgxQ435oPnXw7BCDXHJ2QE/HojChsK7gaHZ7ufDI2
         fNdvTKtrK4uqhVXpwVphJKASz5sc2PXTWtyASAx/olcqX5hlCTgp/kSDSxSLAJ7x9y0f
         UX2zgC4l7W7M2PGP+guSo95w8HVq+FU+NqJvk29/8t/1K2p/Ne/KmqBVuvPowZknqixJ
         aH/UQLkAaJezo7x7zJYucsMt00w00mjSjNrjLKqYlhtwsegCfFnEHmIGdDrLdKRfrO3K
         kjn7pBdFhlJLXSxr7Hyi+gD0uUmCs1JaWLIqWlwMHiY41Qqqfe9KwfsfE7lxZrus4H2x
         RBKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793699762; x=1794304562;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZhlFvLGCrbcs8sxORBaYOZNo8wD7mjZ19zKxzr41P9w=;
        b=0Kxzj3lOkZyBcuK6HLoavu315pb9IFAHf9KkrZqA70J78wdYlEhP7HuBqC2cFCp2GU
         TRuHbrooX8OCfv4Wae0ycOuKcArptED8oEqiF8Z5uNdlLw/rw2yrCshsfEYWJ+I9/1sW
         mm63vRVpAUsqKdOQg06FFML+39pMc8rsi5xi9ZbWZ3tWyiF2OT3Xl089Q4MYcK7PT2w/
         xmY3rySPA8/qJYnXdwYqPvwtJp5lTOLNe+EXMfPGOEZY1z+n0+HM/N1/afTu1vcU8dCr
         5PAuxB6ZiB52I9C0Htk908pPYshF/Z52xHElhL3b6j5QtQmfJ1xKJ2vwyVI5w18zaphS
         uN1w==
X-Gm-Message-State: APuU4Z8DwhiDYbaEy6DamN1685CPoW+58YoidYZzk8JinzHpeb46cixi
	2AyV/h3Kp1K64AuAPv2O/lLBKn9W5U2UZhI5l4bH6abADrC3IlLSa3dFpNtkIQ==
X-Gm-Gg: AYBFou2TxLLNj/TmflwMbDBjwCmED87Vje4e/k+iWO6paGNMQDZSsdfccPYzu30ctAZ
	RZLhuPTL7gtc1D+8+U+AXFDGSQc0q3XsKmzgdNnXq3NGNnyjNKhsCiHtcboUAkhpPe1yz4jZ+eV
	Z3cH6FLLCxHkUv1IfQm0PiAh8nQKgM1Q5BhnscOFfh3GOzf1X7ljlSeTf2MTKZeXHzaciE7Q7d1
	MG0fFx/TcCrcdONEeBS339qL2svL/vTwu2xXGf4IUMFUuIx2vBbPVpQRmtN56EGxAHA40fTKFsl
	eJzbelA1pCkh05s34yVZDtbEmdCAtau1P9j/w0bdif0FzKEFWJ2UdiHevsgPzgngAnbOyIkHAHn
	U07hz3uxNcabpyQDm3mlLsHOpe2LvEO2CD+n7qEfHox8ZfisjfJ4NIvPxOvaIdZBzhZL7donFm8
	EDbG9r1l5kZebtKDZXMCQrgyd/J+gIJhuStm8aXFr2zOSYa+JAa2gmfu0rgo9Dvvw3UFVLj4FrH
	8HcciXZTG84+rQjOYJu1EHZJA5h6NoXvf2Kr0+NxLbBtv5KxST3oq924o/5pVqF2T8LIpbyAX69
	6FWg/v4HwBQDiLYtynJkhCwdcBxsdMmK4TLoxM3zzcnzfAgUBH/q
X-Received: by 2002:a17:90b:2741:b0:3a0:e4ce:31fd with SMTP id 98e67ed59e1d1-3ae896f8304mr10589297a91.10.1793699761834;
        Tue, 03 Nov 2026 01:56:01 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2a09:bac1:7680:28::4:396])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b07c666cdcsm3488954a91.11.2026.11.03.01.55.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 01:56:01 -0800 (PST)
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
Subject: [PATCH net v2 0/3] net: dsa: motorcomm: ACL fixup
Date: Tue,  3 Nov 2026 17:55:07 +0800
Message-ID: <20261103095514.338700-1-mmyangfl@gmail.com>
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

Various ACL defects. Found by LLM and manually verified (on YT9215).

v2:
 - withdraw patch 2 as it needs another test run on the device
 - fix patch 3 to align with software behavior
v1: https://lore.kernel.org/r/20261102071119.3435180-1-mmyangfl@gmail.com

David Yang (3):
  net: dsa: motorcomm: Fix extack message on unsupported TC actions
  net: dsa: motorcomm: Resolve the flower action list to one ACL verdict
  net: dsa: motorcomm: Delete the ACL rule of the port being unbound

 drivers/net/dsa/motorcomm/tc.c | 86 ++++++++++++++++++----------------
 1 file changed, 46 insertions(+), 40 deletions(-)

-- 
2.53.0

