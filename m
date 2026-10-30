Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=202.36.163.20
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793339983;
	b=duzI5SgghZHQYGcUxw9CcKCY7UlS5p1kFol8F75zcJl056LVNnTrOsqItO8duDBpt5zZ
	 yDg+vXxITla1aC5qb/tqqQ6uKc/TkHUFLEwy3guQVQmvppbBTu5nbbXemVLzaoxgVSH3a
	 t/rErvRcxjgJzSyO7Y7ndoPCtxXXbjFvhv0AcbW3874kUy2GIqWWB7mV1luf54logDAPA
	 tKFxBzzXKOwRkesSbt+yX7JZLYhxbhpYYqdemmWAuVQ9deosyXNWvkACqGI455XNuVRBM
	 +5MZmc5xZwQoqFJ4KvCDOgzyDrDWFv3E0mYKic6COZc76ohy+rv5ZOrq0gAm4M/2fKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793339983;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:From:
	 To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:X-SEG-SpamProfiler-Analysis:
	 X-SEG-SpamProfiler-Score:x-atlnz-ls;
	bh=bJPDbwmu2n41I3LqblZ3/zd2gnBPm8CP17I0CfwL6dM=;
	b=PPmkWiKpyrH0l/xqSHxlmeTBm8SabbqZPNvdGlDLN312LYO6PJ5uZNfT3ixOXottLaqe
	 5g66B3GERvX5kn4N09Q5tuYar3gRRzuaPkOjseU4gYlVmOgOkGFt5bjwuznPkKGx5ETdu
	 mtduxt3vNNJoUPBfg03IJ5wy3zMUo4jUTpoxI/vWtfL7Dy/jKcOQHv45EtKyV/ltwjGQn
	 a1YFwXcwrv166Z937WBto42JgIJ6PU+o30JQOvOe5/c2EBQK5H6pYd8Ndja9Zvmg37qAJ
	 vVLyQxNUE79KJCure1WJRmLHuDQEeZEFz4uDyaFJVJ/6KYj9K6MILlJ3QuuDFyZVYIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=alliedtelesis.co.nz;
	spf=pass smtp.mailfrom=alliedtelesis.co.nz;
	dkim=pass header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.a=rsa-sha256 header.s=mail181024 header.b=oxoesOKF;
	arc=none smtp.remote-ip=202.36.163.20
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [202.36.163.20])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B08A606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 05:59:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B08A606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alliedtelesis.co.nz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.a=rsa-sha256 header.s=mail181024 header.b=oxoesOKF
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id E98932C038B;
	Fri, 30 Oct 2026 18:59:32 +1300 (NZDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
	s=mail181024; t=1793339972;
	bh=bJPDbwmu2n41I3LqblZ3/zd2gnBPm8CP17I0CfwL6dM=;
	h=From:To:Cc:Subject:Date:From;
	b=oxoesOKFNpzS71UE0bdkH1ejvxLFX1FOzVA3RwI8VKyShzZwNPP1mLFXq8Sm1GUTT
	 cZsQs0lr7zucwidRKs6NpNxmoyh4eENDogyXTAuQ67P0bvvEBu+HhiXdIF15g3kDiG
	 YJRq3P3ocOjo8vt6447pUDNSJyQ+m37pjt/Z9+1YYLSN8OvpLay+Osidtbh7qO370q
	 V1KoJ6P01qxssnlAexdL7jjLb3D6sreRC/rUdDTakiIKPBj7jgvSdf9xhzJfYHGQbb
	 SGjL0QjLF0D0UkxN/h+xqAhjYa4do8Q5KfFcsj8h+NQaDcGimZJXbnhVFnNzG6eLPm
	 x+GJ+JxwSYyLw==
Received: from pat.atlnz.lc (Not Verified[10.32.16.33]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
	id <B6ae432440000>; Fri, 30 Oct 2026 18:59:32 +1300
Received: from angga-dl.ws.atlnz.lc (angga-dl.ws.atlnz.lc [10.33.22.14])
	by pat.atlnz.lc (Postfix) with ESMTP id D091313EE2B;
	Fri, 30 Oct 2026 18:59:32 +1300 (NZDT)
Received: by angga-dl.ws.atlnz.lc (Postfix, from userid 1025)
	id CBC55564D90; Fri, 30 Oct 2026 18:59:32 +1300 (NZDT)
From: Hermin Anggawijaya <hermin.anggawijaya@alliedtelesis.co.nz>
To: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Hermin Anggawijaya <hermin.anggawijaya@alliedtelesis.co.nz>
Subject: [PATCH net-next 0/2] ipv6: addrconf: keep lifetimes of manual addresses on RA
Date: Fri, 30 Oct 2026 18:57:55 +1300
Message-ID: <20261030055757.2094944-1-hermin.anggawijaya@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-SEG-SpamProfiler-Analysis: v=2.4 cv=FJW4xPos c=1 sm=1 tr=0 ts=6ae43244 a=KLBiSEs5mFS1a/PbTCJxuA==:117 a=660iZSQnnn4A:10 a=d57nF5oMqvLz-22E9Z0A:9 a=3ZKOabzyN94A:10
X-SEG-SpamProfiler-Score: 0
x-atlnz-ls: pat

A PIO with the autonomous flag set refreshes the lifetimes of any
address on the interface that equals the address SLAAC would form from
the prefix, including manually added ones. RFC 4862 Section 5.5.3 e)
only applies this to addresses configured by stateless
autoconfiguration, and the result is that a static, permanent address
silently becomes one that expires.

Patch 1 restricts the lifetime update to addresses carrying
IFA_F_MANAGETEMPADDR, i.e. SLAAC addresses and manual addresses added
with mngtmpaddr. Patch 2 adds a selftest to rtnetlink.py.

Hermin Anggawijaya (2):
  ipv6: addrconf: don't update lifetimes of manual addresses from RA
  selftests: net: test RA PIO handling of manually added addresses

 net/ipv6/addrconf.c                      |  9 +++
 tools/testing/selftests/net/rtnetlink.py | 79 +++++++++++++++++++++++-
 2 files changed, 87 insertions(+), 1 deletion(-)

--=20
2.56.0

