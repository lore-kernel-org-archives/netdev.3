Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792967321;
	b=Ad2ZG16r945bCcl8Sbjg+IHBNasFWb3SCdk6cG1AjoT8V680h0bLvRSCaNAyWTgP4kkX
	 RJbNdh/KEGuv7MFyXwbY4GbS2TPtpiMvrtJlSrDxmd1G/XOZnGEJtLRDL6g0YsJ/DmJfC
	 Ay17c0+rGSaZQbkqg0xxJk86rzJJAZ1JEq4LFUxojLhn3amyVdmdjZTlo1cDovOFddHuK
	 9TyKQwRD5GGlxdQcze1MJA+BAlmxcN5sShRbCyvs0bcTsnqED8IIsa58y2BqMEEwXa9Qj
	 oISKIYtJHcfx7Lql2jILWCgfnYDcbvuMlTzyK4zBmmgyTJpssKgJVwvouy3TB6S236g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792967321;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8L/Gu1pYNU3sPwhJxM4LxaVvBFBaLA26Mp5J8JHh3DQ=;
	b=fClYJB/6nnZflt0NEs2/GUwqYMYPqfu++Z8tycqgnRBumjRxtUkfEMelzyRzeNW/VsRe
	 WaDH8jR973Tb6ZBAl4GmtIb7/PXu8XvvxUY3uAriir5C80gDDfRKlKtVDM13URYJaHRvx
	 fE+zOPAz0+Xi9PMY00VxuUcU/AJfxF98a/8Nk6HdyW6bE2K/x9nUV2OnR0b6bLAn/EoHJ
	 8StgnOdCREITI0zABxVubkSrE4JCC102OfEcFzArvBMP89uo6ApOV53KP5rmWO+0Lu2mz
	 x74Mx+6gxtU5QoC5MW8kPWVBJH5jswbZyFoGkVHtcVtPuhi/hqHKmbrSP+N/RSMNiJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p2BGQp6s;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BCB606A31A
	for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 22:28:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org F3BCB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=p2BGQp6s
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4956869750eso15458805e9.2
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 15:28:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792967319; x=1793572119; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8L/Gu1pYNU3sPwhJxM4LxaVvBFBaLA26Mp5J8JHh3DQ=;
        b=p2BGQp6sRxjFIlt739uBkYlEfeLM4fL+afRAJwBssN/Zdn1xFqC+02PZ0ltikYuQM8
         wk9BBbPXX4/IZp+60zkCLQek/ez1LVnjayMA0ohiKnPYIZ2e4kGudNuO6diBICKum4kD
         hubsXoJ+iccN7zROVh3nOeFKebEdXp0hWaZ8Y1sJ/ThuPgNdQu6TdOAmkmabfgGb+TQZ
         434/6jSWS0dtTrlb7GdIIQDvqurz5PGVv0P/o9er2H0WWy7QrxXZ/E4FoFodYX768HnA
         zPRHfYUOdgDcCpm1bW+lyRgqrbOmJuwvzfRTf6NT0q1SXwWoxNvCyuhzjd8peBhC0WKN
         RZkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792967319; x=1793572119;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8L/Gu1pYNU3sPwhJxM4LxaVvBFBaLA26Mp5J8JHh3DQ=;
        b=m1EVFhh9CeuADHP35Fz6lM8tr5NmKJr6EM29KLVZe6Tl8U9Go1avB7fGx8WuK+33+g
         BH+c5qlTVJ5yu/9r14pjGXhubFwZ4N0IE3PAiyNBZUXMQWO6tS2zo3KpNAevVdtlMjVl
         IybvX9eqA4gQAB8dIdRPNHhAcULPJ3dqLzApqIs80Vp7sbZ4804EG6/GI0K8EQDksrly
         UJmlmM58TJh5+o+QOhZPDhsjFlCHdJ1OEIn61PsgBZjDjRPH4ueI7sqY5/924lczUZ+U
         dh2tiURoaf69L1dcsllbNUd4LHgb1HehJzfBTgMRK9B/4VkQfEgjJsMFG8ez5VKmycpL
         +brg==
X-Forwarded-Encrypted: i=1; AKwUvBypVYUShEOMpUMw2+YcYuCiJJm2WsoageEd/2E6aTuqwP/qRJmO7fgB/6w43LHP+9R8cJFZzBw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIyB2GtjmQcGnlV60Eas2tybcystoes+GwQMMFzCGDURVrZOLxL
	TAAjU8SQeSvmoCd6FUqWrxLkffl0KXo8xEf/TlkSLSenkJuDZT22rnM=
X-Gm-Gg: AYBFou29IUeOwvBIC+u6WCiUUe/42QVSwqnZex5kuLmaDS8Q43Bv9EW2Nb2kbACcMH0
	LeYYSfz9pyH7xMXf7Opbib8+k77p1/S5/p4UOlAlS7Cb2ueYuM7jnsrs9/DGh3R3EHsSJtS3R2B
	O44nh04sDj9I0NZt1Ri3X4P7cR04aubzQ2TW1OxuIR0fJJQVVjHpD/KTXc8wloo9slQU5hPRd8y
	RatEnfs9z89oLseF6eG/79i0mS54UoBeh6w92cvEByxQKpv5Vr4/yvUdn0lSbiSpymIPUR8g3xv
	m1lz4mbkV7wAUuP5Ch9f3Dixi59I5lVXPDi9p2222NkMc+B0ZDJ1j01yUnHFsM4zpriuYccY9rp
	Y9ulT10i3OY+qsGgZMLuRToA/O4seaR7ZbVN6MpY3iModDne7lvflr/NEXfLiX9RPEIdwuC/zId
	VzHOxJ2lpb53mQFNokMDDksyo8TGEW0+Eeo9DjcoDYm7Txg8AlUDgb6HyQTrHfWSYPNRrcfmZMA
	hY39ExxZLhVk/laL++FVMdWzi676EKDY4ZCcQ==
X-Received: by 2002:a05:600c:1987:b0:4a1:96cd:2f73 with SMTP id 5b1f17b1804b1-4a35ac3a777mr91598165e9.1.1792967319382;
        Sun, 25 Oct 2026 15:28:39 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a59d998sm156357385e9.15.2026.10.25.15.28.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 15:28:38 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
X-Google-Original-From: Tristan Madani <tristan@talencesecurity.com>
To: netdev-bot+sinfo@kernel.org
Cc: david@ixit.cz,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	linville@tuxdriver.com,
	sameo@linux.intel.com,
	oe-linux-nfc@lists.linux.dev,
	netdev@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] nfc: llcp: use timer_shutdown_sync to prevent timer rearm
Date: Sun, 25 Oct 2026 22:28:38 +0000
Message-ID: <20261025222838.1096455-1-tristan@talencesecurity.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <179278531637.3327.11947058101101849130@kernel.org>
References: <179278531637.3327.11947058101101849130@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Found by manual code inspection while auditing timer lifecycle
patterns in the NFC LLCP subsystem.  The issue is theoretical --
found by reading the source, not triggered in production.
