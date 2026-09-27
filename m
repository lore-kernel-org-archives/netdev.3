Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDEE21CC71
	for <netdev@vger.kernel.org>; Sun, 27 Sep 2026 00:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790468685; cv=none; b=nIi6xaVNg0+raomUyT8K1Za7gOTVPa34iRlnrhuFm3WvLBstWgXsxRgzaaXg5FR9vNml7IcxkdcvNESgz07iwybwzS/mj1vRPf6JAr5OxhLLVH2ADkcqyBV4XU3bZ8K825TG7X8ejHj9I0eSjav5Y+lj8EMJfXmVWez/YpN+xvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790468685; c=relaxed/simple;
	bh=8Fw2qNNSLeDry4szk2gig5m6yGuj0wWmeEbSqaBSsi8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Gl/d6z2gBJzgUNt3svVej8bLTsVb/2CeY2SSFN9XR7CWzmYKwscC4UXDwSeLwXcgonClhw2jzPulPGmYKF6hMMnwoj19zz4ypRuY1M7Uhxg8OWri8oUaHZgKnv9X9FpdBmub5Av7kRVPvLg5iGJplWHkTr4+2opG/+51x0jI7Uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rLINiVuB; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rLINiVuB"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-85469f204f6so939190b3a.2
        for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 17:24:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790468682; x=1791073482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1PK0e4PtkqQ5G4jrPyQfHAmFBUAvufJtROUufsHoDiw=;
        b=rLINiVuBzVPrFieOmINzJr8lqxZmroCDK5Ae9xVPl1RgFQ4FBPzSs5dfhaiZ12+BiR
         2pKB8yjA/NBYtEUp9Y3m41YC6qUHtZtXm6Fx/aP+2Wn1i8C5A2fXIdbpF9QZN1g1vaY3
         NDr3cmzcHtc1IMQAnJFarDVnlo0hC9Nao0wXKxaGBY/8RWDGtG424/tImwMxKb9dZnC7
         MEc9rcVbGClllD03SxHM7VOK18yxOP7m+5Q3JZ3SNV83Swnhd4a8aD2nmQgz8qqUdHO/
         jJRwlMm79YDCvJzgM1wSmSLeQBrhTlz1vRfGjcaeJjvEsj0dpvsdvOIdw4nwz3Zz/U+V
         E2pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790468682; x=1791073482;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1PK0e4PtkqQ5G4jrPyQfHAmFBUAvufJtROUufsHoDiw=;
        b=GChEByGsFwqYl7nsVV3rrvPRBliWI4DP2iKDzF+EIUIu0IjUzh8huDx5VDgef7cH+C
         0XXXpShMNSYLZ60nma+jRISj255VjYeZAUdzB49SHSkmrrdzkE5I3e7RPL0/75h75++C
         uzD4QJtYMBsruJWhK0L9vLvDMxBA97bX5LNJBN//8Ck+4vBqO+yKO3/q0Kw1QrSCthK2
         NMP3OsrS+tpbOsXag+5ZTU3m3AR74gE8RjnkEbV79yzZVYwQfEJQ4w/fBB3/lXbizmVK
         bcvR7m1oufliqBQPrkJcSu4sJrHBxsTdFlWYNU2qt62K7E3nomTEiwd1Eh3J8mSmWQvV
         Puug==
X-Forwarded-Encrypted: i=1; AKwUvBzp5GTwqKPTgBpmvvG08929CzsxAYU7Q96fVYNOan9tfpuf5f4ZypciEROgng1XqNzNWkuxc8w=@vger.kernel.org
X-Gm-Message-State: AFuF++n6wTKeKXOB72QPz9mu5qrlR4dvOSwNAECVnmxldgb1iPej1Zs+
	dGAJwrWyB+g9xe/CfT/X453jbU4WH1Hdyrbl+6B4J7hftleDSt90i1Xe
X-Gm-Gg: AYBFou1cvFLYgV8Z9IWVhxyED7jXOWIDcRBgd7acK4bHx3iiYmRkfHAjyFtccsnuqd9
	4uYemMElSklAovSSjz/Us1xAgdtQLE6JwTkvd9e4hdkAjK2Bw3XNHSCtaGTgR8+6GXiv+THk8ZG
	JDtBhyuyaP/C78uRSSKLeDbLFSBaSQ3ell6XRMQfsTUsIRbC8gNYIZOhRLt2vGZCZI0F3emi4F2
	uS14kC0+HvYREKut7az8Zi1BtQHHvSsG4LpY5AgwzsFLYV0U0CpOkU8k5eV7z7PKw4eHaLyjGgG
	7vo0KxseAi7VBAz6Zh0A8Gy1/7Fboy+zLAcJ+cYIQaLQ7A80glSIb571m6itMIoxqi2Yp1SZCMv
	ZY6iAI6ucMeP66eTq/jMSXU3WqrAVCB8x55cLNUE7r7TU1rSZKCv8NSE7IJco7t7ipda/Q1Jliu
	Axh326cA8F3SVk1J5GXkmSH9hTTebkH29M5962GyEoiDtL3BieKgSnX3qh0RBk2BDPg6OT5gN3R
	OPu2GRGSePqExl3zp1NGqTpWaLAqyUN7pkQg595c3jWb7pXWH9DRucfxe4X6Q==
X-Received: by 2002:a05:6300:8053:b0:3de:1b92:a4dd with SMTP id adf61e73a8af0-3de1b92c673mr6070280637.18.1790468682175;
        Sat, 26 Sep 2026 17:24:42 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:78b6:7bf6:b1de:12ef])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc78791c680sm2698224a12.16.2026.09.26.17.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 26 Sep 2026 17:24:39 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
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
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v8 0/5] rtnetlink: dump link-layer multicast addresses
Date: Sun, 27 Sep 2026 09:24:22 +0900
Message-ID: <20260927002427.4519-1-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

"ip maddr show" prints link-layer, IPv4 and IPv6 entries. The IPv4 and
IPv6 ones come over netlink today, with IFA_MC_USERS for the user count.
The link-layer list, dev->mc, is only exported via /proc/net/dev_mcast,
so iproute2 and other users still parse procfs for it.

This series adds the AF_PACKET family to RTM_GETMULTICAST so that the
link-layer multicast addresses are reported the same way. Patch 3 dumps
dev->mc in the ifaddrmsg format of the IPv4 and IPv6 dumps: IFA_MULTICAST
carries the address, IFA_MC_USERS the reference count and a new
IFA_F_GLOBAL flag marks entries added explicitly, the "static" column of
/proc/net/dev_mcast. ifa_index limits the dump to one device and
IFA_TARGET_NETNSID selects another netns. Patch 2 adds a generation
counter for dev->mc changes so a multi-part dump reports
NLM_F_DUMP_INTR like the IPv4 and IPv6 ones. Patches 1 and 4 update the
rt-addr spec and patch 5 adds a selftest.

AF_PACKET dumps returned -EOPNOTSUPP before, so iproute2 can keep the
procfs fallback for older kernels. The iproute2 side is ready and will
be posted once this is in.

Changes in v8:
- Set the owner of every list a device has, not only dev->mc, and
  check for dev->mc in one place when bumping the counter
- Add __hw_addr_count_inc/dec/reset() so a change of list->count and
  the counter bump stay together

Changes in v7:
- Add a per netns generation counter bumped on dev->mc changes and fold
  it into cb->seq, dev_base_seq alone did not cover the dumped entries
- Sample cb->seq under the address lock of each device and again when a
  dump round ends, so the NLMSG_DONE check sees a change too

Changes in v6:
- Move the dump to net/core/dev_addr_lists.c next to the dev->mc
  helpers
- Stamp cb->seq from dev_base_seq and check dump consistency
- Let an unexpected dump error propagate instead of skipping
- Check for an address only present in the peer netns in the
  target-netnsid selftest, the peer and local ifindex can be equal
- Document the ifa-index filter and the zero header fields in the spec

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

Yuyang Huang (5):
  netlink: specs: rt-addr: fix the type of target-netnsid
  net: add a generation counter for dev->mc changes
  net: add AF_PACKET multicast dumps
  netlink: specs: rt-addr: document AF_PACKET multicast dumps
  selftests: net: test AF_PACKET multicast dumps

 Documentation/netlink/specs/rt-addr.yaml |  19 +-
 include/linux/netdevice.h                |   6 +
 include/net/net_namespace.h              |   1 +
 include/uapi/linux/if_addr.h             |   1 +
 net/core/dev_addr_lists.c                | 247 ++++++++++++++++++++++-
 net/core/rtnetlink.c                     |   2 +
 tools/testing/selftests/net/rtnetlink.py |  73 ++++++-
 7 files changed, 336 insertions(+), 13 deletions(-)

-- 
2.43.0

