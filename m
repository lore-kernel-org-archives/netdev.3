Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793310169;
	b=eYs1XpPTmgvRBnZzppnh01ix3L+F5DXWEp0CvEqSB/ClJ7bqCj6g5DwvXa78cPVE8az0
	 TXAPB3D4sxvoWx7Bpxvc8BQXgm7oTnXfE8P0EROmg9dHMDVYT5oKfhG6id/FRNuXjlN+0
	 VUNw3x/Oaze9jVRz+Qe40njkw+766rrl14cZ/YfItl9og50zfnzwU6HUJcIbeKX1AAbPN
	 szDCmPmls2QZH1xo38MQKMuVlafh1wwGdpipU3VdBhtIeez9hC2hgaUU4cOcaZWQzxlzT
	 6crcWBUJcna45R8+AXkzO/0XWk02Q1JDPdPyzxJsjvMMZsiIBIfgwebBnKN8XVX0vIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793310169;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wRJ7rSES1Q+dBHDyjANmzY6ddFxkYCyiQ+eYFUYeOnM=;
	b=qDweGCTS72efM2/Fu+ICNmDGHkpsS84MvqjgaZcPyfaXUz01ve029kRqbAW6rnm1L5bU
	 e01FYI+aoxtjc5S+XZr5evFgn2AZG6l1UCAlB4yZQ2gJOv3Y5dAw3iZBNmfupanx0G6ZZ
	 llZB5cwr+QCWOeRNcArFQfXOuiKhoxw3fSMrXhqiQ/C2b4OGcyA/VIjKPs3wY68RVF/TV
	 I2nEFs4M4cdMn1Jm+dKtTaUq052K58oxjz89BjUVoiCoCHdHTrHdkR/CNfpoWykxyhRON
	 m1IZbz3LUvyM1Qksxb+39kmwvRltOmpr8gs7M3SglqmUlbkbZl+KvxbQMbtW04ZXd8g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YbSdMr+N;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7CB3606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 21:42:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D7CB3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YbSdMr+N
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3aded3c6103so28132a91.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793310168; x=1793914968; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wRJ7rSES1Q+dBHDyjANmzY6ddFxkYCyiQ+eYFUYeOnM=;
        b=YbSdMr+NYKjh4A1ybgtEtwwJepIemdmWBf0aaFXLdkjVOYy6NuqfVKmDtlVOK4f2sw
         vS8pVU/ZTXQTVjrufHQcd6fW51stPbT2P0UjCU28SpzG9LRCeEavnmlifl8Rb4tGn1pR
         39qDehfB5afXnK8DhSOj1AbdZLAgsi83faJcYkx1a7qNKfkrWWyNjC19oDVrYecPcHkd
         JmdAgoR//jcKr37B6oeBGQmgn/XYnwiR/E5ea+Ome0EsLmyl0mKsgfboVeByJaI3Gmfb
         psaa4QCYJvEUJ1VFBNlHdhUahWYxCeIO/i6zVUBJRzaEYX+8FggO8IQySmOo02Q2cLqv
         onIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793310168; x=1793914968;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wRJ7rSES1Q+dBHDyjANmzY6ddFxkYCyiQ+eYFUYeOnM=;
        b=ZkNAAxc2MQ1sWSUZRj2rmJdj2S+cF8bNnMHHcI3CBmNtrT98S0gZonRWKXKO3SvH1R
         opaU+7TI8OlfI2XQ3nkGuMFk8KDSsh60423xIx9ndTbV317MufJaHaHj6jKbPnP2BLHk
         eNzSNsw1h3pzBWrRju3lKgIvCJjG4ChMz3ZfvR+Yoik1T5CKkucDkfuj6Iptvzuz/klv
         IB4YvD1V58oYKae1YkUv0hNYuVHOU3xVBmVrJ3msRG99EamuoeTFQ5BinbJKyKKE6FFf
         1LgVtYI1yrcZxoukhKWWfeIMnTDwbWGjGvtFBiUgQZ33mO1iWtpgk43ZrKlCqfEVXAfz
         G03Q==
X-Forwarded-Encrypted: i=1; AKwUvBy6FpkSRVBu6695h6DYm94q8+WxwtNuqW0zQ9lDNktBW210ey0oj/HVIcZ5tuTEENE7GZLrD7U=@vger.kernel.org
X-Gm-Message-State: AFq9FYJHBov+M9LogrE5UKx2yBuD6Mv4vXsiYN7Lj4PbOHeRqdopQWrI
	84KX/cJkfVpQ/SecoDUd36tRDy9SRk3jUa1SFBel7bhj07sP7AiRXc5J
X-Gm-Gg: AYBFou0FIHAj9okbYE0npwc4ZyozAj+2xuRHLkhBS65fc1zEhfF1gIk8ShsP6xH+TQ0
	EqncyA2JzgEeoOdqLnYDOKYPxAm+xU53kZPGmCEoiyP370AGWscrvLPOhyaUK7ko9E7huj/x8NA
	kQKJE3+tslq05HaTJ+CloexFE0MrrWMOQ8f36l7CKHpRhJqKr7YO0Eh6sVPwgiPHt8fQ5R7tyHT
	LAWyJNgkZ1KXsfFsqE9N0q6K1bmGeYw65nTgy6ZWYZ4rCXReNNcRkz1Dn8NYICnaRRIiX6zfiUP
	QaMxrUEDV0njKVvIdZtmKsuXCYD6LHQHv4GGc1Dh8nt3WAtCcTkz6dIZW7qgC+vxZ3lk63ASpSZ
	vklvuXJDAISMUw8S2HHa5vn5kDUnnrfaiFhvJ+KUr/nvP9YRaQX7B9IWgthiBzWwdXK/tvOtynR
	eMMk0qZKKLBOWYkWO34IXecBxpKgtBeYWj7jTJ3y3U+yJP0eVAjGNBL6YcukyPY4kZY6IBEpwpA
	5CE8M7Shug0fi6cYYVexnV/0qqTvXPIu53Z7tXK863ZA1ToT+YA3stJ79ITXa3XL4M+0rfN3833
	1lvlHzlp5qMNstq8B5dF2GOiUelVhvSVLL7p0nfqqD6NU/jIAV9O
X-Received: by 2002:a17:90b:17ca:b0:3ac:adce:60b5 with SMTP id 98e67ed59e1d1-3ae8977688bmr228774a91.14.1793310168178;
        Thu, 29 Oct 2026 14:42:48 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ae845ecaf5sm1122486a91.16.2026.10.29.14.42.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:42:47 -0700 (PDT)
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
Subject: [PATCH net v5 0/2] inet: fix lockless ehash walk races
Date: Fri, 30 Oct 2026 06:42:15 +0900
Message-ID: <20261029214219.1035176-1-imv4bel@gmail.com>
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

Changes in v5:
- 2/2: add acquire ordering to bpf_sk_assign() for BTF socket pointers
  (Kuniyuki)
- v4: https://lore.kernel.org/r/20261026003804.61923-1-imv4bel@gmail.com

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
  net: restore refcount ordering for lockless socket access

 net/core/filter.c               |  2 +-
 net/ipv4/inet_connection_sock.c | 16 ++++++++++------
 net/ipv4/inet_hashtables.c      |  7 ++++---
 net/ipv4/inet_timewait_sock.c   |  4 ++--
 net/ipv4/syncookies.c           |  4 +++-
 net/ipv4/tcp_fastopen.c         |  2 +-
 net/ipv4/tcp_input.c            |  4 +++-
 net/ipv6/inet6_hashtables.c     |  6 ++++--
 8 files changed, 28 insertions(+), 17 deletions(-)

-- 
2.43.0

