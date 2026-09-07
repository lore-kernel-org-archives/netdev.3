Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C1F3C5DD4
	for <netdev@vger.kernel.org>; Mon,  7 Sep 2026 09:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788774770; cv=none; b=RzKskKPf4THC/opZexUpdfhOJIH+jj244z97NfbMwry5WY+B/XIykHpQB+kpqqh/gFko5HRa8XGO6nleeJQSsk3MZFlGx+Q3g9hzujWwOqYZlbziTZ2q9+yK59rEU3gRlOHNxl9/mD1629dXGMjHZinVHdyKqYUf/1o1LVAkzD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788774770; c=relaxed/simple;
	bh=cqlFSrgeVcyAu1DwjM5N2nW2E2ZNBwopzV3zyer3On4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KpbngPtov79LJwsm9vCn6IPsoWgo7Dnm/ZD3mkI5h5hXfiL1Z8cVD3Kq068VnbUReqqWLx5YxiheKSzJFsg51rGjn47FNYkGKmyQmLEJiby4lb470dRbN9yfxbFlzrb+Z1iiZzMsXvu6NtAmPz0nKqM9OB6uQV46Ul/AnlSCkpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bjLwZjxq; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bjLwZjxq"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c9b373d5af0so2593514a12.2
        for <netdev@vger.kernel.org>; Mon, 07 Sep 2026 02:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788774768; x=1789379568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iLGaza3s6F5rgIQf4Pq3PulD1HjtmOc+h6lAEkmWtfU=;
        b=bjLwZjxqs6MoH7uIcpsGHtDVI9kXVStsDfRBRRognSb1JCxLQh1n+wyNUtlKNwyVSa
         1idNSCcz7PUMJARA9h2KsWv/MBgaEFd/+dysIFEPTwPya9ALc8Gsvd/96xSUyvJ0zhxF
         254x1gKhTc9mLrUsS637Wwwpi5P+ZF9MNZX1nByvRUMX3kzi2nuZABbGGoArtAnZQlTT
         SXwY2sW0z53WVUkgky+Qb2JSLa01zfegGOCo8Zu9x0uKxiZGp2lcwBU5ZNRv8WjgLzX2
         2s3YT4mKFyZq9nPpcGe51v+MJa9x8+EJmpf9Cn8nbMGv82qIXBYOWZxQ89fbHYiBTq5S
         jIKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788774768; x=1789379568;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iLGaza3s6F5rgIQf4Pq3PulD1HjtmOc+h6lAEkmWtfU=;
        b=piF27wKhANuzNiFp1j5Ruv1yTQlxzHcgC8RVb3EDeq4j/ktX6r/kM3YOuVyuW+92WB
         bR5qLSys3NTDkY+TXaabewMPxy89y1zM3mlceWS+5uyOYy1mYWxn/uiJWoacxXaYgFRz
         w8AsJSk5iw+/d5ashqL24v0IJtdVWC/YbFEJKilIP5XmMRaRVec5I/REsbl4BA27Uo1I
         XvVAXuSkHoWQYEh3VJDQ/ESbTil6AI4TuX9p667uqRW4/v3oHT0HqBq00rPaFbPPKBKy
         06/23VjZWdVUEtJVBGR2d4KTgw9LyuxgOXDH14jHGizH9qtqkmEU4270R+X3If2Zzc9j
         SGkA==
X-Forwarded-Encrypted: i=1; AKwUvBwYk14l4j1C6cgT3NcwgIH7Px3CFJbiP0taQeOBlPDz8wn86Rg58zROPcGh34XCnxWOCDrDCm4=@vger.kernel.org
X-Gm-Message-State: AFuF++nFkC85OurZqD4VQxQ41MRNcm0X8LIm8/8+cnbzGedf6XEDiZXR
	MDVg9KhiZGr6a2rhKlQKa0c2oRx3+MAU5svPpn09WbH24jiUj6Ekc49p
X-Gm-Gg: AYBFou1xsEHuEbieaT4+LovnVnfgGikod972D/k2arkC2NNF3RwrFi/T8c55dBkDQGT
	mtyrinegRAtQqf7Caa44Ly1G+51SJk52/wkHdgpzUs4HE3U31437TY0gvfsjaZGGg0btfJmNggX
	Ye+KnVBYfLQd5XaOEbwZKK3B3Fkbkt3VAkLLy7jtITDACKlQhISFqMWWx1v1TgUI+29aX3futUu
	AHZz6pNypDUuEGRtWTqO/+NIViwMa9XHYdZDF5SvRBLscjG4DNJiel+j+ioBdt35FjfWr4QYXYI
	ZRTHoyFPgl/nnENrJZVk5Be1EC/Wk29P7OF4pHMZucHtLdO39q16w/JqQLcoMKzNMYnUH7cJ0AD
	c9c3jp82zfv0JAiIBoRzOK+FA6hGJrygYXcfw/qb5QQtFh5k7YBtj+8ugcXoPqALjCXBRqQaA8C
	EPCIux8cc4wKYJ5BkywMrYM6ZjZmOqJ36ujYZp9e8OUxMYPJb4Hz4xXwvA8a4tta3kfK/nuxCTS
	vFQ9FrrBC3kF7E0sPnR2DQ2
X-Received: by 2002:a17:90b:1d52:b0:398:dcef:c040 with SMTP id 98e67ed59e1d1-39b26242a20mr34261880a91.19.1788774768453;
        Mon, 07 Sep 2026 02:52:48 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14332405e92sm18924258c88.8.2026.09.07.02.52.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 02:52:48 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH nf-next v2 0/3] netfilter: fix typos in comments
Date: Mon,  7 Sep 2026 15:22:38 +0530
Message-ID: <20260907095241.24441-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three comment typos under netfilter, split one per component.  Found with scripts/checkpatch.pl using the
misspelling list in scripts/spelling.txt.  Comments only, no code
changes.

v1 went out with a bare [PATCH] and a "net:" subject prefix.  As
maintainer-netdev.rst asks, v2 designates the patches to a tree, and
each subject now names the component it touches instead of "net:".  The
series is rebased onto that tree; the diff is unchanged.

v1: https://lore.kernel.org/all/20260907064239.39910-1-hemanth.selam@gmail.com/


Hemanth Selam (3):
  netfilter: arp_tables: fix typo "alignement" in comment
  netfilter: ipset: fix typo "artifical" in comment
  selftests: netfilter: fix typo "adress" in comment

 net/ipv4/netfilter/arp_tables.c                                 | 2 +-
 net/netfilter/ipset/ip_set_core.c                               | 2 +-
 tools/testing/selftests/net/netfilter/conntrack_icmp_related.sh | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

