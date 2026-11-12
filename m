Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794478807;
	b=XtlWPBza1eGoZD/K7Szh6Dicl2WKeP7h8Ks1elkJQb2Tad/YgXzExDNtuaZTRNdw9ypB
	 YiIBernN8SWdreGahiVVbfYTa7vtuW8duaCOT3Z7fHVsdUPs6j/DPs4qda/KPco+UEVLZ
	 lS/K6M/+IDPNrJgTBSKBN/xo6QUteLCR2zjG1JV68z8mMjw825Qup5Qi5b7l8raJQJfkA
	 qayNgw8loEvq4vvfhz8o9JkyfhKOfmh1nYbaG3tsylr/hs7v/cTBEF2FSUa6QX2QZkWiB
	 REzA7mo2G8W7AY+Kf2jAKl+j6t1Wz1KsF9ODP0nTSLnnNqQDeiDJeA2mN59kWR5WwcA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794478807;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=sF7y7ODXiFCQ/wwsbAodrtj1P3nmUKeBBn5BI0VTc0E=;
	b=HlNBHeUoF7VRjfTWTfFHMLRB+387ycL/0adI2CcRPTUudN4vMbtkzjZ21UQVbIjk2VY6
	 BRzWOPlWXmZC/sC9YWqZW+geU+ZSKTJ4AucUXsHmq/s3SHfpTBtEuSbWik20yw/qGMLIA
	 UMjecrHJssHMHhhF2V+mNC5WJQQMbMA26MWqgRfwOvdD20YIlsvDISB070xbMsIBkSqZL
	 CWRjITOKnawqorP1GC0/l98r+1uWAKW5pG9/8znacRNuBVshkZlOCcSmb2BG8Mf3zq+6E
	 OoW4IhLEV+2WoRCzhnlaKVQ6YqmsVu0AooqrmNv9NTrLafHYyt8JMhEjSZil/cokWIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U6U2JQgE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3C3606A31C
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 10:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U6U2JQgE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FA9F1F00A08;
	Thu, 12 Nov 2026 10:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794478807;
	bh=sF7y7ODXiFCQ/wwsbAodrtj1P3nmUKeBBn5BI0VTc0E=;
	h=From:To:Cc:Subject:Date;
	b=U6U2JQgErZA2G6OwqLJGOF9Q/A1561fMpL4ZOBI8Lh+R5rSU7U4f2h5NG2YiuWlli
	 RBDL+3sBIZTQYffAoxZLXHIxMcCvU88yBJXGqhDQ469ACO2JJ5vcPTiW+A0BsYBLlp
	 vebM2HkbY4JQYdFA3ipkcT1aCOwGmSuKUGsrc+99mSdpESRH/Wr7SoqCdrQYZQocAn
	 lVFCdddmcuVQT6d+t+HXlxpnu9knuHbj/kG3M5J7zXMKUuRLMeRJQmjB1RymYL3ySf
	 D0TqvC1jsdXHMXM5oyCJxa/C5AFCsUywb4n6qQy8qyXQIeaWwwNvYEbKthq/YkFERp
	 uJW2A5L+ZZZXg==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@kernel.org
Subject: [PATCH net 0/2] nsh: limit recursion in nsh_gso_segment()
Date: Thu, 12 Nov 2026 11:19:59 +0100
Message-ID: <20261112102001.3744643-1-edumazet@kernel.org>
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

Sashiko found that nsh_gso_segment() can call itself, through
skb_mac_gso_segment(), once per stacked NSH header. Nothing limits the
depth, and a 64KB GSO packet made of 8-byte NSH headers overflows the
kernel stack. It was reported while reviewing an unrelated virtio
series [1].

Such a packet can be sent with a packet socket using PACKET_VNET_HDR,
when the nsh module is loaded.

Patch 1 uses the recursion counter added in commit 006c8b834aed ("net:
gso: limit recursive IP-in-IP segmentation"), with the same limit as
IPv4 and IPv6.

Patch 2 adds a selftest: it panics an unfixed kernel, and passes with
patch 1.

[1] https://lore.kernel.org/netdev/179443691180.2199510.148246238688217560@kernel.org/

Eric Dumazet (2):
  nsh: limit recursion in nsh_gso_segment()
  selftests: net: add a test for NSH GSO

 include/net/gso.h                      |   2 +-
 net/nsh/nsh.c                          |   7 ++
 tools/testing/selftests/net/.gitignore |   1 +
 tools/testing/selftests/net/Makefile   |   2 +
 tools/testing/selftests/net/config     |   1 +
 tools/testing/selftests/net/nsh_gso.c  | 126 +++++++++++++++++++++++++
 tools/testing/selftests/net/nsh_gso.sh |  71 ++++++++++++++
 7 files changed, 209 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/net/nsh_gso.c
 create mode 100755 tools/testing/selftests/net/nsh_gso.sh


base-commit: 145480b28ca82e9fae789427cc4569e596515a32
-- 
2.53.0

