Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792733187;
	b=TaOfo5LjTiqrXsJu2XU5WKWW2LjLV6g9Qkhu2TiK+ca/56U57Jo9Z7uoGaernB6xRIHv
	 2X/soA32AmALxkRdSrhaDTQ+dfgr+TAjM2l0KlgVLFCCftrMD97c8IcXrM60cKCQGSMs4
	 SOYlRrT/KnzHjfes06MKguD6OftYP7h6Vq0U/994t53aKLsZbqzZupcxWLn3Ae7COnbaB
	 89cnym2KBUht8TReHlsfS5rK1Y334FxjfC9TE8Bv0mtDk27VMv72q+4H9L4wOiFFm5go+
	 7GpxFPrFD8I5aRvNNLOGnv2KChBeLkecAWz2dlrJvznDfo0Fkv2DeuUK0oLMnc/QXfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792733187;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qlBNnkEDkPHB8dgWswxWdVSqPFXZ5/t64+eH3GFcJTM=;
	b=O/sRJCR7sojb2EBveHr/E3ykWFvuaVgPdsIKPTeHxBzEpIYVv9gVr0uaDV7q/mDGTfIR
	 H2A5+GlcNrwiQHN13aze86Lfa3Z8SnEGuO3sFjDD+HWfh8iWN9ckIT4hhtLKCShNxbhV3
	 H/ZYKD/ABc75pONYqp8ilPcJ+rlZXUXxcHyqt7wp51aq9wKeADaQkjfONL8LCfSXF4m//
	 I3pbv4aO0mzQ3vNEYFObQI0m2tu5GVThV3EvYWu6StPmekQaTiyPu/bCcYld9a+p8DHc9
	 UbGgo8J0zALczTKgZuwszTiStFpqCHYoUEUsGpREV7Lp7vxwJlB3u+SydI7o4Xs9+Uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l3592cdj;
	arc=none smtp.remote-ip=209.85.216.51
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B91606A31A
	for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 05:26:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 15B91606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l3592cdj
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-3ab2cb8d577so371059a91.1
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 22:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792733186; x=1793337986; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qlBNnkEDkPHB8dgWswxWdVSqPFXZ5/t64+eH3GFcJTM=;
        b=l3592cdjG1936JuIGRQc0PPIVLGtQBCJu7eIiK5WEf5QtJ5IRGI+IfkjRMYfsk6BSJ
         RUkzntpaSplD6lG0jflA4cYJ28u0/GTA91FNV5QldVRQocJ9dqT4tzJvthM+XJAK8QzH
         54KzgDzpdaiX2e+FjmkMOzr+kTIxaO0Nl3lYyidGC4w0qm56KxKT23gokonhjkuo/FA/
         soDE2ZFzJSHmcIQCwsuwNZ7VxWlNj1e6+L0evJN/VdxYk78EcTg9BfP7PSSc+XELPC6b
         zk6L4bVybDsQ2sZDIcfV9cZYY4Svpmr6fLJJiKkytdPto8v70AFbprCyxZLgj/XMLOBK
         HJrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792733186; x=1793337986;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qlBNnkEDkPHB8dgWswxWdVSqPFXZ5/t64+eH3GFcJTM=;
        b=lmFqXW+A3NWlke+pJ3Qs14kgg2CZ4/WG8oJj23CPIs1zCoMOzqFTGWpZz/LGRHPMU4
         67/phZZvAcjNwq2OhbA7m1cucFk6cSku6ABmaaxt8pI/fh4rL07gWtxdg//0ihftVRxp
         gPBepbMunfzGXBsw94EMw9tJ3OoiRx9F4WSbacwvMdoDtDDjv261vt+9pjC4davGp1as
         KBRUyJd/XomtCv0X/aCMU837LsaZUMdDQv+NceiA6WoEwGLbMNFT3GGUeSsqEwyoso3s
         xMZgw0yDIV/GphuUsNuCkot/0l6dMjsHYDyA2hue74xmUPb4Ce+RrGNzpv6UQ928MnrL
         7jxA==
X-Forwarded-Encrypted: i=1; AKwUvBz9bUzV9KjdCPffW3UiEMsXC1u1zYF1NxPSdfeUO/eYAxLYw7Q7NfYaEgoPt04b2XzD1CFyX/o=@vger.kernel.org
X-Gm-Message-State: AFq9FYKZu5TqcIiq1NAZeIBY81G6lokEJwFSafNhVmUigFoet4kh3caG
	BqVO4jhRJ/2Sz5jAssMKdgiEa6zlAvokOyr9rmacVdS+JV8su7qNJNXH
X-Gm-Gg: AYBFou0snCyUY2iADAkMfX3g3UvNxcQmQgaNw8huPgP7nqXpvY9KVLDg9elYcNInFcq
	7zm7dmEeJ31GCEYXgRZE/rEoLsrohQoQnqZrHicAb8xwCAxR/fWdOhLP6NvfFqQG1vOWiEDpXnm
	pZ+jtfPg8BI99Wk8qjM5OopZWJNwqlRK1ZdK3DmcMNEWq7Ev1pgmd7ESroT1RtfC+eVz/t8pq4M
	4KY4Rr1zhrUIA8LtMQM8aPpOYzqIpI4pyyc3Ibju+CotSLin6rsWaKSxfQ//HOHq/qmKD93DfzZ
	jV759iI9RSRXgM0WDxm7m4pF11VHo3pbIrX+v9MsOY54aRDqXdyG9jQpxT7dGrxMu0FesxoEgJT
	FjdMAFvdkmANYvvr+8OaoR4e1AbDqAcMeZWedXcCm5KGLjEE9LcHkHwZBXpSCGdSjdqWef5FKE8
	Xs8a61chAuv30du+y1ZO9Ha0go7n7AUUUhok0F2ebbrX6S6b88nFX70vxBECDHfpzHqXuBXv9+P
	6pFpm9mwR4iys1RP46NjjvDi3Q5JHRD9pQuCK2sz6ty5+C96OzDfGc5sYW4943SFUCZmNIsH/JD
	buKTvZCCzUekIp5yNk0OugM=
X-Received: by 2002:a17:90b:4b84:b0:3ab:884b:65b4 with SMTP id 98e67ed59e1d1-3adce154993mr920199a91.59.1792733186301;
        Thu, 22 Oct 2026 22:26:26 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4890c56sm7379785a91.2.2026.10.22.22.26.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 22:26:25 -0700 (PDT)
From: Hyunwoo Kim <imv4bel@gmail.com>
To: edumazet@kernel.org,
	ncardwell@google.com,
	kuniyu@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: Hyunwoo Kim <imv4bel@gmail.com>,
	martin.lau@linux.dev,
	john.fastabend@gmail.com,
	weiwan@google.com,
	sd@queasysnail.net,
	jiayuan.chen@linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH net v2 0/2] inet: fix established lookup races
Date: Fri, 23 Oct 2026 14:24:34 +0900
Message-ID: <20261023052542.3505250-1-imv4bel@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Fix two issues in lockless established socket lookups. Reject unhashed
sockets after taking a reference, and restore the acquire/release
ordering around refcount publication and acquisition.

Changes in v2:
- 1/2: split the unhashed checks and __reqsk_free() to reqsk_put()
  conversions from the ordering changes, set the Fixes tag to commit
  079096f103fa ("tcp/dccp: install syn_recv requests into ehash table"),
  mention the TIME_WAIT hashdance and request replacement cases, clarify
  request reference ownership, and drop the full socket race discussion
  (Eric)
- 2/2: new, split out the acquire/release changes, set the Fixes tag to
  commit fb041bb7c0a9 ("locking/refcount: Consolidate implementations of
  refcount_t"), cover sk_clone(), and leave the already ordered TIME_WAIT
  path unchanged (Eric)
- v1: https://lore.kernel.org/r/ath58Egc-oI6p3Jl@v4bel

Hyunwoo Kim (2):
  inet: reject unhashed sockets during established lookups
  inet: restore refcount ordering for established lookups

 net/core/sock.c                 |  3 +--
 net/ipv4/inet_connection_sock.c | 16 ++++++++++------
 net/ipv4/inet_hashtables.c      |  7 ++++---
 net/ipv4/syncookies.c           |  4 +++-
 net/ipv4/tcp_fastopen.c         |  3 +--
 net/ipv4/tcp_input.c            |  4 +++-
 net/ipv6/inet6_hashtables.c     |  6 ++++--
 7 files changed, 26 insertions(+), 17 deletions(-)

-- 
2.43.0

