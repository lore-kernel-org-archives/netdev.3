Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B36843CEF5
	for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789123873; cv=none; b=NVbeLUtbVCsBkm3nVMPUsi7fAciXDUeZESrLYeXNQgsDO3BXX1O0Ud6OZFBlOYi3xkplPyH2273AgaEmZ5A9tVdQU9QlGo676IsDl1uN9LyEvo5fzfQgjVsJjFvZH2sYBVc3dIViJMNnY+3ZLgTjAHtmhWWz6tLLP0wOhIsGKBk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789123873; c=relaxed/simple;
	bh=rJpzhKBNri9c5UULZ56nVQy/rVD79h7nHatgwn0HBTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PvGm9/A+ZE1MkSzPNoYvS9dg6xwqiRjlJvd4lJMBzwhCVv9M1W0clZkC7zeAy1TVjnna04e2GNvqQm09LIiNkqm9m8e6Elgl3z9VJTlEeOtsjgGSxT+xaJ+PzqvVF47inNzCbHjmJWUYPadUmsHzmNW+dvB7EChGzgDYZ+FgRb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVelHYmS; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVelHYmS"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4ae61629fso585480a12.2
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 03:51:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789123871; x=1789728671; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=h3ODOEOt2OmT3owcwJIlSNokTBKqpEmCWa3Dh35Mcpk=;
        b=bVelHYmSaet8xa+VhqcxACQ+7wEqnbsQ5q8UVZy83A24fbt4TRYnFT1KUvl3/Hqd1/
         75329ZZSVLaI2P6TFJJrQPkfudaD+YxwRWc2nPRftwhDCjARZqtE5vMWWrfXfLc/OhBG
         VeCdPUDu5/MRyy6W5h2yDORj81bs/dw4ZwKeYIJNk3B0zT3WwF7Ldb6m7iul3E/JuHW1
         9oknnM80LuUEAQZPlBB4s5gE+JlurkxK3S4n9MBIOr0ygzm8e+Udzy4PJBWAx4R2IB/y
         H/txExw4qLYFgz2oCCnzuL/Ip1Iss6L9faiqF6fS5tVyvSr3boF1jTB2UKL3rWTiKFMh
         s50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789123871; x=1789728671;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=h3ODOEOt2OmT3owcwJIlSNokTBKqpEmCWa3Dh35Mcpk=;
        b=L+8H2gdtVc9ngBuJrB/0jpPIFtZKMoJknPL37OPN2twm5L9w9GXP1+ZDYaiKRgp02D
         1S7VfUPiP54mZzA/8Vt++7IucqUidCRKhQQCoeLJsxsazZdXyalMq40icGZ0Z++kiTor
         7qw+1DY8jDC/wrvtqI0dW+09j0A/2VYGqZoqD5ieA0U0W6Vn5SGqpJn26Qd+veWlovRL
         7iJJG63OBvli4xQjRfcopXMf+9JX6abusGf2lnsB6G523RgCBorRNFJCbaqvGgYfKDUs
         hHmg0/jO95H3LMO2Kre1AQcAGJtFN10DOoqXAlq6+hkfl9s2dd3Iem7k84/RjTL1daBH
         zSsw==
X-Forwarded-Encrypted: i=1; AKwUvBztXhC5tp2BzgqVtX+Fb6T+CP0/kkTlJCYRnk2DhzuwSgxwv0aspcVlgYP7uaGi8kHMoKBPEIU=@vger.kernel.org
X-Gm-Message-State: AFuF++lEbhJRNbrsv7/zY75WUrWSVnUcOD9+sz1k82OouesrdzbxbbVK
	LUzWcI1OnlJxrwhAxOEEYHX0qhAXd+7iV6VrKMy1uulQr4U7A+o46jpY
X-Gm-Gg: AYBFou0JQq7IwQ9v04Q2iQsMufYgo73rNnyt2c/0WEHsqAKc8wZjJfH3d++wGYE/fbd
	TmQyKTT69uFDW4/1SFfuYTn8qBZ+a8tWr3XAmydpW0CkcQLWixLXjuF9kxwy7qjc5ojlrpsJrY/
	LzXHGKMiNFiVBGC4he4xP564u9z4rehm4rvJ3FI6CpjqdIV4yZhK3z8lxnbd5tzT9kK89Qc9oxq
	GNGWRtQ+odtwkK3YA9Haj8cJ4b5iPZ4frKsX16cjuXj+BN6QGWnZ+AWBQIElDu39QIcazTMS8Tb
	EswoSZXPcJrdjt0BFmAgtYj0uJBum9cHsDCb6/zqltx+d6pJcbCTcgppU5LD+b9BXq0ao6lUWA9
	pGMp3q/ad4Xkm9Xq4tU677SwbwnhlX6dwSwAnkrz9Flehso3YNnxdrcv/jzNujihJSIfksM4x1M
	/sQW7YheDuxTDI+loafZhNITci0xk9cE61lNBP82Nbmwie2LqWpzHysefoNE4dbzkBmideI0jPQ
	IkE8DfTR0x1A82qF3i0xDiwZqL70FqSoZTxyhNqOvu+AgKKuw7yc6TNSp/suw==
X-Received: by 2002:a17:90b:1dc9:b0:38f:aab1:5148 with SMTP id 98e67ed59e1d1-39d9c0b79efmr6645363a91.13.1789123871146;
        Fri, 11 Sep 2026 03:51:11 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:f7e5:8b43:47c8:5245])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d94bafb3bsm4876004a91.1.2026.09.11.03.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 03:51:10 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v4 0/4] rtnetlink: dump link-layer multicast addresses
Date: Fri, 11 Sep 2026 19:50:59 +0900
Message-ID: <20260911105103.7771-1-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"ip maddr show" prints three kinds of entries: link-layer, IPv4 and
IPv6. The IPv4 and IPv6 ones can be read over netlink today: IPv6 has
had RTM_GETMULTICAST for a long time and IPv4 got it in eb4e17a1d915
("netlink: support dumping IPv4 multicast addresses"), with IFA_MC_USERS
added later so the user count no longer has to come from procfs.

The link-layer list is the missing piece. dev->mc, the addresses
programmed into the device filter, is only exported via
/proc/net/dev_mcast, so iproute2 still carries a procfs parser just for
that. This series closes the gap so that "ip maddr show" can be served
from rtnetlink alone.

Patch 1 fixes the type of target-netnsid in the rt-addr spec. Patch 2
handles RTM_GETMULTICAST dumps with ifa_family set to AF_PACKET and
walks dev->mc under netif_addr_lock_bh(), no RTNL. The reply reuses
the ifaddrmsg format of the IPv4 and IPv6 dumps: IFA_MULTICAST carries
the raw link-layer address, IFA_MC_USERS the reference count, and a new
IFA_F_GLOBAL flag in IFA_FLAGS marks entries added explicitly, which is
the "static" column /proc/net/dev_mcast has and "ip maddr" prints. A
non-zero ifa_index limits the dump to one device and IFA_TARGET_NETNSID
selects another netns, like the IPv4 and IPv6 dumps.

Patch 3 updates the rt-addr spec and patch 4 adds a selftest that
checks the filter, the user count, the global flag and target-netnsid.

Nothing changes for other families. AF_PACKET dumps returned
-EOPNOTSUPP before, so iproute2 can keep the procfs fallback for older
kernels. I have the iproute2 side ready and will post it once this is
in; with it, "ip maddr show" does not open /proc/net at all.

Changes in v4:
- Reset the resume offset when the device the dump stopped at is gone
- Use a tracked netns reference (put_net_track)
- Say ifa-family must be set in the spec doc, drop the AF_UNSPEC remark
- Close the netlink socket and guard the checks in the selftest
- Drop the Fixes tag

Changes in v3:
- Report the static bit as a new IFA_F_GLOBAL flag in IFA_FLAGS
  instead of IFA_F_PERMANENT
- Support IFA_TARGET_NETNSID and test it
- Describe global_use accurately, it is also set by dev_mc_add_excl()
- Fix the target-netnsid type in the rt-addr spec, as its own patch

Changes in v2:
- Always validate the request header, not only with strict checking
- Use a single "with" statement in the selftest (ruff)

Yuyang Huang (4):
  netlink: specs: rt-addr: fix the type of target-netnsid
  rtnetlink: add AF_PACKET multicast dumps
  netlink: specs: rt-addr: document AF_PACKET multicast dumps
  selftests: net: test AF_PACKET multicast dumps

 Documentation/netlink/specs/rt-addr.yaml |  17 ++-
 include/uapi/linux/if_addr.h             |   1 +
 net/core/rtnetlink.c                     | 174 +++++++++++++++++++++++
 tools/testing/selftests/net/rtnetlink.py |  75 +++++++++-
 4 files changed, 261 insertions(+), 6 deletions(-)

-- 
2.43.0

