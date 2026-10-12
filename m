Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F26101A8F7B
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 01:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791767839; cv=none; b=gmXGbeltLAZ7MpMt2lEF7vQWde0HLIU/GBAH6kj526QfMbHw0l97UUpZ85ozAvqospNc7efcSrf+QpTYx1mCChHqy0EGLROlvdZydWHvyTiKd1P1d2BTzTZ8rGeQ9LgpqUYaGJuVAOBf3FoLJg5QGnQ29FjUKo9Nfis222TK17Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791767839; c=relaxed/simple;
	bh=f9OqVQRTl+RsOTJdCEieHRhe20rLRHVgPk2WCcq/hCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KZQrWLq9Daqbz6y2esdXkcXazUzkjRZyc6JO206Xt4EE4qmgWl0UC/EiXo1GSB2ATk4C4wJmOQHf/Ac2cWI5EzFRgDt7x3GuSckO9AkKPAc6n3d7bvy3g5P1bUwAnAswjWxZfS6agc1jsy2hWa5KIap3HZdgG4gVVtpPxQ6wVpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D5ntySTK; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D5ntySTK"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso519200a91.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 18:17:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791767836; x=1792372636; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HVAtScMA0Gu/eshIKxcJc5e1pXYr3Zfr1cY3+NzAluM=;
        b=D5ntySTKjsCKR9SWPN5mC0aJGtfG1mongNfzmqMze+dEp4bgg5KGHxyg5MTDnhVQYN
         pgD0rR1wWRshCKSSZvzeRXORLc6AZr0J8Ylil7waBNsgCHoGnLp6cObdtV2/sQTFAB1I
         X0OCwxpgDwDxCWrjWXjnnngyvOfBrAMrUVDMQVM7MUTQfYqQlf0gtl4cKGElHmt2JHtj
         sAm4+QtflqQPfZlJ7+NS3yl+TXA5+Cnqix4/PgS4R2G/cbAHKQIT6LfKvg68QQs1NhDk
         nOFpQ3t6NSYspvRPn0OCt5XBjHiaEchYwgq4TYWdTcA/2OWlugm1J34Nxj9BE0HoT7bj
         KA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791767836; x=1792372636;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HVAtScMA0Gu/eshIKxcJc5e1pXYr3Zfr1cY3+NzAluM=;
        b=LJHxenPNxYX/V2OuIO/55gmLeHUVmxaFAV5vbvRUjn3IdSgSw2wBT0w63kpHHjWXjY
         ur4MYHALTGTsvDjBD79XHdlguXMG0ugBfCuck0dhI79lAbhMY6xFI0r/9GkXNtp8qnyi
         ssyHymO53Wy4p9BJMT+ZZ9hwWqJsdTfi07KX+LVYpWFQyJjmYDwtXZyi+1bLvk3mJDZE
         ll8jujPJZFz7c+l7S8Yzu1oXauzftjbFy7Rf1VDlSdNB7YESp+Iiv0lxU2gApJAHeznF
         kpdQAoz7VP/ATuzlcTK3tsIHA9fonTGShTUU5OEU13OeQ++M/ZnAoM7zLHyZLS5imwp7
         ajuQ==
X-Forwarded-Encrypted: i=1; AKwUvBzcclfUWnfvgA1gHQkPGIUmeJ9wfaSsSbtAPJpzx8o9/UH2PBpD9chEDCBtZWF52eLfGKZmwy4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKtTVWb2pi60ylAt0wOZrpuqm0BifBQnY1I79boFjBONd1n2D89
	y5LiMFVzhymmHuhQxHyClKvngqxWgD06qKwIOE6bRpsg7aAPqDrqxTcF
X-Gm-Gg: AYBFou0uSnzLhEdrXIMRyEUTdVAEHPYlup+V1o2h0x8N2hauEfnuVawhSUbjLEp44LJ
	5Hfn2xfAXU2pT8r5fWTqdK2wjSwFWV5P+f88g/sqUtzDVOZXkLuGtYpD0kwI7FT2vMD8dVt6wY7
	w8lkGm/oBQEcdNzouI2ZFrKr7u49bQLPmupYjWox57Y6xo/hu7hE7wStXm9Ekq2cuBGt77szddz
	onT41425BbIP5nAdfSAcKnTmgiYEv4I+Jg+TCd7g/qXuwalpuTZMcHvDu7Y/stlsuPPrtQkxfK3
	+NSb0QwX7rDuIUx8ypAYgeD/AZOIKSARZsV56LcZMoyZ0FBjuxyF7kePJZVjqmcsnZda565rffM
	3qIaBOZB3apsnkSEJsvGOYklf+mpuZqhZN91I/8EuISgnYHzn5npMM/SsKG6ovlaKGc0TT4d6L0
	VUgLwxOJ/VmvtfekZfPrpuKf/3sPhPYPo3NiACPDXp61IofYbDZnifzUwsxZ4HXp8rvLrFBxVbt
	JUpp192C6NXEegyd1m2Jj9vCSRqIzGUkAyol+XHUOewPJrjOOO20ejHt2T1Uo8G8Ca+GbIl0OLw
	iRY3AyWj8CU=
X-Received: by 2002:a17:90b:3b84:b0:3a9:8482:420 with SMTP id 98e67ed59e1d1-3ab3a8e55aamr6706622a91.40.1791767836191;
        Sun, 11 Oct 2026 18:17:16 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan (oki-109-236-14-10.jptransit.net. [109.236.14.10])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ab38dd5864sm13743307a91.8.2026.10.11.18.17.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 18:17:15 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Kees Cook <kees@kernel.org>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v11 0/6] rtnetlink: dump link-layer multicast addresses
Date: Mon, 12 Oct 2026 10:17:01 +0900
Message-ID: <20261012011707.3378-1-sigefriedhyy@gmail.com>
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
link-layer multicast addresses are reported the same way. Patch 4 dumps
dev->mc in the ifaddrmsg format of the IPv4 and IPv6 dumps: IFA_MULTICAST
carries the address, IFA_MC_USERS the reference count and a new
IFA_F_GLOBAL flag marks entries added explicitly, the "static" column of
/proc/net/dev_mcast. ifa_index limits the dump to one device and
IFA_TARGET_NETNSID selects another netns. Patches 2 and 3 add a
generation counter for dev->mc changes so a multi-part dump reports
NLM_F_DUMP_INTR like the IPv4 and IPv6 ones. Patches 1 and 5 update the
rt-addr spec and patch 6 adds a selftest.

AF_PACKET dumps returned -EOPNOTSUPP before, so iproute2 can keep the
procfs fallback for older kernels. The iproute2 side is ready and will
be posted once this is in.

Changes in v11:
- Sample cb->seq before each round and again after it, and skip the
  check in a round without a message, so a change after the walk or
  before an empty round sets NLM_F_DUMP_INTR

Changes in v10:
- Rename the list owner to mc_dev and set it for dev->mc only
- Sample cb->seq once after the walk and check it once per round,
  like rtnl_dump_ifinfo()
- Read the count through netdev_hw_addr_list_count() in the helpers
  file, note the init exception in the _count comment
- Fix the FDB remark in the dump message, bridge and macvlan use the
  default FDB dump
- Say in the spec doc that AF_INET and AF_INET6 honour target-netnsid
  with NETLINK_GET_STRICT_CHK only
- Drop the Reviewed-by tags of patches 3 and 4 after the rework

Changes in v9:
- Change the count of a netdev_hw_addr_list through helpers only and
  rename it to _count, as its own patch
- Use the count helpers in __hw_addr_splice() too
- Note in the spec doc that the header checks are unconditional for
  AF_PACKET only

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

Yuyang Huang (6):
  netlink: specs: rt-addr: fix the type of target-netnsid
  net: change netdev_hw_addr_list count through helpers
  net: add a generation counter for dev->mc changes
  net: add AF_PACKET multicast dumps
  netlink: specs: rt-addr: document AF_PACKET multicast dumps
  selftests: net: test AF_PACKET multicast dumps

 Documentation/netlink/specs/rt-addr.yaml      |  21 +-
 .../net/ethernet/cavium/octeon/octeon_mgmt.c  |   4 +-
 .../net/wireless/microchip/wilc1000/netdev.c  |   8 +-
 include/linux/netdevice.h                     |  11 +-
 include/net/net_namespace.h                   |   1 +
 include/uapi/linux/if_addr.h                  |   1 +
 net/core/dev_addr_lists.c                     | 251 +++++++++++++++++-
 net/core/dev_addr_lists_test.c                |  18 +-
 net/core/rtnetlink.c                          |   2 +
 net/mac80211/driver-ops.h                     |   2 +-
 tools/testing/selftests/net/rtnetlink.py      |  73 ++++-
 11 files changed, 357 insertions(+), 35 deletions(-)

-- 
2.43.0

