Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792820262;
	b=gCtDofo4699jP4XINsSiKmlfXJh2JlOKW31SCBX2CmGhRA0pIKrMbrkoDHPmPzrMQunj
	 c7u9DBZwNCS7zFEVO8XxRWZ0Ifd7kc+PsD7RCVHT93RIOBGEKMMw6ICEXDrV9upRJetBh
	 WvYvSCYp4FP+yUY9KRJ29/+LrSdF5Z4Fo4V+vTW6+kH+h9BqsZqLfEpaj4X91IQzA//DG
	 QIE/t+Y560S2ZgOa5OsVwX1fWH6/Uo8sjE6yIo4X/GppX6Iy1XCEpChl5A2RpSPdsPncx
	 CHnF5VTC1Hx+azFP9GLAHfWnfVngIvN0h3jzeTS5KNU3A7sE5kFEY7uOIstAIBFEU6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792820262;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HnBn1HrjS5M19vA5Os93lKMqJ/zGnYBBbwXvrRrDfcE=;
	b=ZDElDayW4K6Rov7MkVOkuX26O9Vviq7GOG0a2WIsVZsGzqlnsDIO4XF68dW8VV3bv0Dy
	 K2Fp98UlGsIJrvp+XLXnp9yEYOnDMlOkXTGbkaEOyqZsiIDxv55npD0tBKEzTCrh/UR7n
	 2EnBZiV1PpUPx4PutNDneHK6oza7ZpRo6+qC27IC5JWtxA7lgAn19zrcOXqkLqz5CLK0S
	 W4gkJGxNAdy52/1NWzQnQjVMw8pi5s+A8W3i2VT4L4xlrqG8L3QG/hpjBUWX4j8aawwJn
	 m71wD1iyreHvwodkXE/Hlpdz9ltCMY8EPJWRc23tfkKh4bBY9LDAWaI0lFdIFLelIAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LjJmxPru;
	arc=none smtp.remote-ip=209.85.214.171
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4B9606A320
	for <netdev@vger.kernel.org>; Sat, 24 Oct 2026 05:37:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E4B9606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LjJmxPru
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e8246b13cbso12533695ad.2
        for <netdev@vger.kernel.org>; Fri, 23 Oct 2026 22:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792820262; x=1793425062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HnBn1HrjS5M19vA5Os93lKMqJ/zGnYBBbwXvrRrDfcE=;
        b=LjJmxPruup3KuqV2w37Xn/PF/qINvZOHrVGNwYSk3nNHaWNasay+boIbNx9vmEVtCf
         tRF6raHWreKpEBZ4ChO2p00nnnltGYbNuqILsZWqUTKPZD4yV8RU7TR8GgpWmbtX9eAe
         4T+IcfJK2FHT/bXAwM8S52MNCntSpksgHKzY2EkLP2I7nzphXZmADMebayr8dN/hpdEI
         JQxCuOqwvTgheEQWI7+muNIird7sP6iQI6t3c4KILePJ4hBmI4oicrEgMpmffWJozFmt
         KU9cD+qBg3FRcso+rj+yPMb5rkoTUBTcB1k89VqSJcMUu08UMjFg1Jyhd26HGG7jZ83N
         zMwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792820262; x=1793425062;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HnBn1HrjS5M19vA5Os93lKMqJ/zGnYBBbwXvrRrDfcE=;
        b=IbmOrfiepoH2M762xIZi4Nw4aEg0j2GzXYHeH7HXWwp1yk7fEef4/IygvBWmnhp+kt
         aM5s5jYetXxveyWVCFKFJouXRj8eGFu0NycQeqAGSBLPOdGm4ejIvlMotd0QtC59DBt8
         1CowP9sOxeyjHKDpjPHHQAe0Em4WUuyRH7F0E4XtjMGSFmi7le5dUrEH5mYaUDYKhSM8
         Vr+JCTz0/Gq6PRopZJLV8O+6TlMfYF8V6OKlsfIh4YQQTmaQjq6pjCSNNWX6WbId3acG
         mxtg0dj3V/zKQNOlTTesOFcH/w2ceETgD5/66Qa6wY8wUQDfqV4s3kDwlqkaA6uyYiXz
         44yA==
X-Forwarded-Encrypted: i=1; AKwUvBzR5wxyZ5/dfRzNjjYxaRFhUaj2p1OUep+lpIKkqQF8I/3JSxdVKnCrF/dh3RckywMUt1qe1CA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKO/b9J64KPpUZjFjHaxUMM0wD2Le+bavW+r2r67kHf18ATbmjG
	K+qhl1FJadtkv6I8oS+Sr/wH9edApP3nB8RihUiybYGMQXV370+k3fJs
X-Gm-Gg: AYBFou2sHc7WqXkz0qq+9vTRaa7zqlAfYyQILcs4azNa7bSPxiFVlIVUlLwTfX52/OJ
	uJmVqYvBSkgMRAXYH6dNRR2ew+AfbzxUUU34I34EoYnMETz+tLfrZgr4lKSdQmSbWhP4mviS3wj
	pZKb4v1SuMaM/lKvHvhBgZTV46uaPuO367MBRGiLHLVqc5EsBBRCyle1omxAMT/YAajOMhLdkv0
	eJobpxJNyTYBRlYWwunXiA54hgRkkYZEws/w7blgS1D5VGBr9F9N4o2c3psOvDcf7nRbe8MSAj2
	Aa9Kz7VL+Ow1/U9rVazSQf5ptct9iApi5CCQIy80suttEj3DU8VNYuucB0+UisTG3/SOAn9lXju
	QtLCBYLU5B9zyVhOteg09E0yk6adD+S0AY1HiBKAedRX1pv49+HSzx1ZJIY7C3dQydzDDH0l1gr
	W5ErTS/FLlkIysscGJjKHtWOhuM3iaR6uonhah7yVtX/bkmd+Oq8U3QaSBZe4SALxdAVa82EFRI
	BSJgByPi/D9ixfZA5+jQTgIPnQGJjiYiGQosKN/kMzwbI23sEg6WQaDme682MlgzKo3iIk48gXJ
	o1nq55XxoudH09xRHA9Ic2W4PLKFR8/c8oAowjRz48AjiCYihck=
X-Received: by 2002:a17:902:cecb:b0:2e9:8505:5471 with SMTP id d9443c01a7336-2ea9c0f8a47mr9698975ad.7.1792820261796;
        Fri, 23 Oct 2026 22:37:41 -0700 (PDT)
Received: from v4bel.. ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea9b1a2676sm2692485ad.50.2026.10.23.22.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Oct 2026 22:37:39 -0700 (PDT)
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
Subject: [PATCH net v3 0/2] inet: fix established lookup races
Date: Sat, 24 Oct 2026 14:37:11 +0900
Message-ID: <20261024053720.1147022-1-imv4bel@gmail.com>
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
  inet: restore refcount ordering for established lookups

 net/ipv4/inet_connection_sock.c | 16 ++++++++++------
 net/ipv4/inet_hashtables.c      |  7 ++++---
 net/ipv4/inet_timewait_sock.c   |  2 +-
 net/ipv4/syncookies.c           |  4 +++-
 net/ipv4/tcp_fastopen.c         |  2 +-
 net/ipv4/tcp_input.c            |  4 +++-
 net/ipv6/inet6_hashtables.c     |  6 ++++--
 7 files changed, 26 insertions(+), 15 deletions(-)

-- 
2.43.0

