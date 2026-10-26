Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792975118;
	b=xFck4tPTt2zEVXqHF0YhWTYmj4+vbfV4nzEhC/pjV3T+4j/vZKH4bxR8Pkq7xOQsJ/wr
	 QM31ME0YrlkiHcs23dmNuxCx1GEwc41fxV+imEOF4d6+OKAP4sUFk1WNhtcDlR/NRjLYr
	 HEPNPwQWDNitLV42dmZjjLw0/V98vXCNnrsfdUGm+CEc/EDjKABfG7NUGLjakmIi48mek
	 RypkGdsH1nQqllPWPGzgEJizqzaWbGS/5XGLv2x0ctBzVQeqihKUd26SbIEf+bhUpPIEp
	 UrZEWbQwvozcQKu98igC9dHdJCVnvkdf4oDI8neG85gM+Pga9dZ7mfteK2VOOsLzUDQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792975118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=V8AhUCDcFgJA8JYRnqCY+rHjKoVSWLP96qgzkdaHUTg=;
	b=W9qZT8cytbFbBCzaO39FCR4FZCjNBJ0utDp5DQ2hATHrOD/m0guYKTikyWTSaqg80RJa
	 fSpWwsoRDqly0eXj6zfRB8vdODVmv1MfXCzzabaJ4eiWea4kmpPdHEUFwB5kLD2NfzFbo
	 2UVUYI3C7LtMwy0Y+/e6Ny3oUi3oc1xIc8Dz0YnRmqz0w1DamdZYQShkSqC0fJtZ5wvq5
	 k2P5a4rbD57gyzOHR5inC7CiZYiwKA2av+HU3OHtorUJ17DOxB/X7rV/iK9GQU2JbaQM1
	 CJ2oukIeHkHyGUvmqvwVadxBpDHliv5KmznWhuyw+TmN0tjnqKE0dcbpXXpG79Dy3PA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V1WhKAbf;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C328606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 00:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C328606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=V1WhKAbf
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-33bf40b0c8bso7303028eec.0
        for <netdev@vger.kernel.org>; Sun, 25 Oct 2026 17:38:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792975117; x=1793579917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V8AhUCDcFgJA8JYRnqCY+rHjKoVSWLP96qgzkdaHUTg=;
        b=V1WhKAbfIU93jpuND4nkzBZKwtyq4z7dbVS6FHvB7uR0snxpA1CIj9XrTPsH6CPC1g
         KMcHEpegLpiFm5O233+7T3sUptjTgc2ZGzadJVmEpVtpODtYqQb7A0DEwslRDwqv7iR6
         HepREpLq39Mms2BIb/7vkeTwVGa19QdMvtbsTw8jiaSvEkqEH5NYd8unOMT10lutKg2W
         yyrwTb1fQS0mtVXQBIYu6OsIPZQX2zARar3IKzIhBYyRiDixeocdyRZMWKKDiVjP/diy
         jObYMruEMxscPRG19dh6fLsnyhnDUOZlYg+ihUCSmnuTqyjxaR6rjaPw5yw37K2QXgQ2
         IIfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792975117; x=1793579917;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V8AhUCDcFgJA8JYRnqCY+rHjKoVSWLP96qgzkdaHUTg=;
        b=RYhwO6EdN5YAW5neuqAbAqPobhnzFxwfX35idnHUNSRsEiAXbEwtGq1/S8sXWIzet/
         8lT0Akt2vk2uWguSi/08oCM1MBzUmLBEzjum4ky9aPF0wuHKO4iuFH31QYk3ZPF/K13t
         PnhKcZK8EPZE6ymw5orIlo7hENtM37hIe+qX+it6RhcE1XNWoBR5o9KuI4CFMQxNV3de
         ctsFRHgpu+tsLLmrBLrinwf3YOVeg3DKyHqtjn0XzIHDUGWK8D3ooc+ox2Mk+YfrgDt8
         lJ0dCVH7i0HuJOOxCSp72y1HQzu+hySog0PpbP4A0+qf8WtsleF9i9bpvNNhq1+X+llo
         /UcA==
X-Forwarded-Encrypted: i=1; AKwUvBw7wXo36LA9+ZSbHD4NbzhgNa/WfA5KxzOifTq5O5YZ9ls3y3VMI5Jwv8CTXhMm6v9uZcrDIno=@vger.kernel.org
X-Gm-Message-State: AFq9FYJda6uJWa7xogCc2gBPUYyhBh1Y93l7j+a1j49Fx5PD8SRk1Lrp
	27wJnLTjFALlTt9JpoCUYM/ibmxNNHkAFMpMUCdR05PHwssdKW7awPVb
X-Gm-Gg: AYBFou1uddzmrhQo9oYN3LcY81TwsbUojjv6tr82fPxy4r4JVMv7n2OnPm+64CC0X99
	L96HECcPFD20x59yffPVQKbM+RVz8e2btD2qgYpOkat1ZKgu7tAug9r8Pa3gosY6rgeH3lpJYds
	Rm2JfIV/bC5bIIf8Ctycvk1uefP1Z887bGwsyfaDJYTH1HtlNJHqqP0ESn4Qe8HvyZOsKTyvu7A
	c8PJdAh8zHYXoHrQ/1NfzX6hCuetntAOLuZs7NzG3buRMdAkHrqeknmYNVsb6Ok0sqo0qmcxEUb
	HdJFrQXHSukGjurl6QuywBvAOWZqbNHTl6jWMgg4XzmFRy44d+wBlvhp8yRHlv9F/YLE/ER68W0
	UWT3XicPXwe4fxhIa0cdiVlWaBnZU5rL3iUhqK24LZ2UUaKtTJn8v/+WUcnN8334p0kmcBlDKIC
	GSUvKcZTAVl9PtgelEt5kJDT+48bH79YpL/sVDwBqaQLHdsOnqf1NUjY3brctZVX21SXNIF/C8Q
	6OSzx414BWU05AfYd6EDuUAc1ofRgzrkgbvodaQpcny+zEn0Sotk3UA26glA1zCNmcfKWN7sHsX
	Fw==
X-Received: by 2002:a05:7300:7fa7:b0:351:52ec:60ee with SMTP id 5a478bee46e88-369e84fcea7mr13199208eec.28.1792975117087;
        Sun, 25 Oct 2026 17:38:37 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-369e8ec50bcsm37925013eec.23.2026.10.25.17.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 17:38:36 -0700 (PDT)
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
Subject: [PATCH net v4 0/2] inet: fix lockless ehash walk races
Date: Mon, 26 Oct 2026 09:37:43 +0900
Message-ID: <20261026003804.61923-1-imv4bel@gmail.com>
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

Fix two issues in lockless ehash walks. Reject unhashed sockets after
taking a reference in established lookups, and restore the acquire/release
ordering around refcount publication and acquisition.

Changes in v4:
- 2/2: add acquire ordering to inet_twsk_purge() and update the changelog
  (Sashiko)
- v3: https://lore.kernel.org/r/20261024053720.1147022-1-imv4bel@gmail.com

Changes in v3:
- 1/2: clarify the request reference comment (Eric)
- 2/2: drop the sk_clone() change, keep the TCP Fast Open update in
  place, add release ordering to TIME_WAIT, and rework the changelog
  (Eric)
- 2/2: note that backports to trees without the refcount helpers need
  adjustment (Eric)
- v2: https://lore.kernel.org/r/20261023052542.3505250-1-imv4bel@gmail.com

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
  inet: restore refcount ordering for lockless ehash walks

 net/ipv4/inet_connection_sock.c | 16 ++++++++++------
 net/ipv4/inet_hashtables.c      |  7 ++++---
 net/ipv4/inet_timewait_sock.c   |  4 ++--
 net/ipv4/syncookies.c           |  4 +++-
 net/ipv4/tcp_fastopen.c         |  2 +-
 net/ipv4/tcp_input.c            |  4 +++-
 net/ipv6/inet6_hashtables.c     |  6 ++++--
 7 files changed, 27 insertions(+), 16 deletions(-)

-- 
2.43.0

