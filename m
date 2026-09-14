Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C2312AD2E
	for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 01:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789350349; cv=none; b=uGrGUiprRpNS69kcGeSC0soXO0IPVPtMC6TJXWqWqHYOh1Yo4CvqaJyg38pQPI/akDTn0PoKhUnkNmLm24wJ4lgP/+5SZCxT4Th0ew31ZtabkrACDzDu57x0SGjDx5Sq+PTesdRohpDrIcQLOOIegEp9L3uyJvVcvcYkzG+R0+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789350349; c=relaxed/simple;
	bh=7AN+51LlF3bcXtQGVd7Fj0d4POHYx2tj53sbahfN5Zg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=n5wz4CXKKnhepge4dcMl6XBmOQb+3gSPwiK3zevPI+FyQHdPBpVHkC5Ji88mk1tnblkkD3Q1s/2Ikk546TMu0QYXQBxg7ZM4ZZVsEnLl2dhdWIpDbbvWAQbsLkVaJJ95+37JLwtYWRJOamXTnx1aG/a80+OJsRcWb6f0TLNUJac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9Sb4On8; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9Sb4On8"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc1cebcb8d7so276816a12.0
        for <netdev@vger.kernel.org>; Sun, 13 Sep 2026 18:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789350348; x=1789955148; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CXkr0qtNX1TIaAFXwEelUT+kftOPKorlmCKYL/cX3dg=;
        b=h9Sb4On8kImIecdYDc6kS/ZuIHFoK0/WDMyZxQ7hpg8xNdx9IJRpXBe3WizYM84Adp
         xayfftTzOIfq4mjB2G8H39zocGiAF/4XmTQ6mTdXz1S3ukpJtPJErbt86xX8kxGnXwSE
         HduGuHNZ1mHTmdxy0nAYEfMWmOF/s5ofW51hPLWQd44ZkXQqbRIz1ls29mSMv9HXz7kJ
         Amh8Hf7eA3Xg7CvBqDivLkxH7jA3G1qev2dRKpf6Ck2Qt84KxE6VZerse7TSWsaT1Rxm
         azE6aCPDMbHB52YNDcjliNr/sKVUXUhtLDYt9Ph3ffKpKVQ2BJ+Ujw09h6zdWEUKZqza
         lTkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789350348; x=1789955148;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CXkr0qtNX1TIaAFXwEelUT+kftOPKorlmCKYL/cX3dg=;
        b=GrqDPulBvacIrNiI8NiPNvp8SnDDmM1VoMgkzg3bnrZ6b/CFjeoNb8ZykmPV4ccBIz
         GeR11IBLiVd8wUap+LwgITVDXqO9/hvBQyjGwxLUpeawZrX5iMBzE7rixiH6R4lwmFHZ
         RLGpc3FlBXNeJRxy75d4YquL86iuAgyPOk5FCsnU5pKE+VMiLfJjkHJxh9OqcvVWYQRt
         Tuqz02mb4tr5OhycNhXem/0JKnI604StsxcL+jjamtddz9sxqD5mUIyutOdpEbK/yeGX
         UyKjH/uf7V+1agNrrWnq1BBUT7+iQ5PfBIXSKHnzZ+TxZfQe+kVphPVWlg98aeTMtjP+
         HOrA==
X-Forwarded-Encrypted: i=1; AKwUvByTpakB7tQoc8qKtOAWq6ZLwft5joITU73xCtZzectZmzsTy/bj3giITKhgU1lTJQQoZBdktMo=@vger.kernel.org
X-Gm-Message-State: AFuF++lFbdG2OnNT9F0qhirfvMqr96O+hcoPQe+uh6ar9cyY/U7MCtNh
	rFfMT0AQ7RFdkzEpa3TPbzo5HG7MtK2VNzrZdyiAW6GPMZTZVnrzYAnZ
X-Gm-Gg: AYBFou30FpTQRSnvib1HV2NIJZQPxWUCnItwEai2fhTokSJDrBdwuaqw5h7sSpBhlTa
	O+KbGBHBmjqB9EMWUMLV6znk0dK8QpBup37jhPMDNhkzsNIs/EYdQnrfg1CgwGtx7p8CXCPmxj8
	4NzTdHl0qae3+t3K1i/u4V38Hpy2KTBWryqORU8btRHp8TjovrQWCoDCGk4vh+eP1WxCJay6+HV
	AQztDBLkMVCUHkbQhLP8SK1zt7yR54LDVj3gonVMZmHFcAucT02Bx1u9fYY2PFe+Qma15eT8sqg
	nZUSKoT/sIHaDgT6rOqvSETECy9dtUj7zaXL9zVjc6118B/RHxZjis8my7J6XFEXreYRdFHEYdz
	wW0sTY107ucmOqtEQcrJ7FObfA9ULLOfExHNpOrenuLqeLOTeMIwOPrHKwFUo2iShYy2ZxqLwuk
	j71Nb2WlrAHQB2H3Rpq1Ql4psgjyNN41OkLCbnUXQyRmEyfDLNi1OAVBKIN7GiVi0BJDQ5RzUfb
	s1zOTT68nR+pnhaqJTjDVBE6SfsapQyZHHflpZiBbbS5RY=
X-Received: by 2002:a17:90b:4c0a:b0:398:ba46:1d9f with SMTP id 98e67ed59e1d1-39dec4e1a4emr501507a91.13.1789350347843;
        Sun, 13 Sep 2026 18:45:47 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:fd07:4a24:951e:c85])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d951d1056sm17513403a91.7.2026.09.13.18.45.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 18:45:47 -0700 (PDT)
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
Subject: [PATCH net-next v5 0/4] rtnetlink: dump link-layer multicast addresses
Date: Mon, 14 Sep 2026 10:45:35 +0900
Message-ID: <20260914014539.5015-1-sigefriedhyy@gmail.com>
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

Changes in v5:
- Filter the target-netnsid selftest dump by ifa-index, a new netns
  also contains the fallback tunnel devices

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

