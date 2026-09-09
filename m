Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A74945616AE
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 13:32:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960779; cv=none; b=VCrJ4MBePj2qAkb3QbsLZ+hWlDcr9DIeonSK+QPs6PEC/WhTlsQp+ozmrnyKFh4hN4RXNMcFmB1WsWj4HZjSDkABwfOPdaj2JIuaFsy9JKrguR52j8J0BdoSpcR7SWy1H35d0p7jyFSCcm+ehBZS73F27wVODiiVPAa7N7ZDByU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960779; c=relaxed/simple;
	bh=8Cxs1swI4BazcAdCuTGtcvH4qiVFXfzzgesxxRAK/UA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mquS7pa5CndSYveUXmUZ8GGimeZvaaA2POnnVZtTaFAfu61/z28p3B/+dewy6TtfYzhVZixxjMxPcfU7vDUzMqsBY1Xz1PffBL54mYAXAz6YQDn0lcGGarGv3ZX9meoOau2UL6KP6pKlwqpGmbDpb3AYbEfuBhjDAqwSzmYCTwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J4mSDywS; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J4mSDywS"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38ec1402b05so5786465a91.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 06:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788960777; x=1789565577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IYWWqOrH0BFKdSQbag3FfKUxf8azbOar4qW5b2e3MNY=;
        b=J4mSDywSNys5skQHDJWouK+7/9mX2dhD/tWVcspI1faI4n2nnIXQtyiq4OVptMO7SS
         UKa4gQ0tTXCa4gg3+3SS+AhgDC3G3CBIQ67Jb0Be7p//0O7tI9+w98pbWXRNmHEPDuvb
         DyKfV0/wy7OKKx9aR7nb3RDAsXXkyO9ww7y5yQdic645I4LueswTPsNKOzbce3nRjcI5
         lcPGX4r7I2LLMN7kaBoFmJNYB0qgHNOSF4gPw2pzxuuqd3m7mAG4Ula4kk/Q4ToxI1a2
         Yeolio3I3oX4XqJGcw6Zf7qxokAelXjrGSwonUfAsMPm0RVQ0g1vJHqO/sR3UND2t5vP
         6xHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788960777; x=1789565577;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IYWWqOrH0BFKdSQbag3FfKUxf8azbOar4qW5b2e3MNY=;
        b=GFzvLSmDWU/K/5i94WQbKICP60Q6ULF/p9ZQCLOJeGZISb4srBwWojBehm2p+xABXv
         61V9nhY2K2WzpVwsvjvXt2KWf8NjDfs93ji1fE+MQpwsVgCd6nmZ8Y/NDeaNiEbSTlsk
         gaO/y3nolbcQq3K267rScyKZqomwAwqjv1s9MkoBGd3DK0HYYEZMPkrtt2xf2600RptD
         grMWfa+uzrBqKK931ZDGDgYLCqIpWy8LYZEyy0sUlF7b+L/b3QCnFKG84Ab7C46e8lII
         KZ7gdiVFNSycsmdKAN4ng7ww2HWLXe35PANxWnbpyyHUWGP0VNzHfVF9gNEEogbq3ULS
         n5fA==
X-Forwarded-Encrypted: i=1; AKwUvBw158gz5tuNl7vs8V/KideaSELx6opQuLUV0ktCRQDOg7rbxuRZTSFqQ0FbL3zVnbiOA/c4vSE=@vger.kernel.org
X-Gm-Message-State: AFuF++miFzSlQMCysfjMocZbCS5OHGH/+M5VQSmjz7oGOzfc1ixrWvTR
	GaaJ34kxCuWBQ91Qer/vIFa0aM2Fl9pUE0XBqgt+zOrCosTy/EkKZAfXjovpl/CYVnA=
X-Gm-Gg: AYBFou1P+MJyp/keoq9bPw5jCiTouzItirf99PbpWsTbJFlsYlj0NuJqj4LIBgMbVqi
	yOa3X3Vju2ptxI1FAMRzGe9hJN1Y+ddN2GSW6SszbbD6uvHVXuNX3wwgS/DtAFyD1LwjS9L5+at
	gXu5KQ9OfKlrDz0FXwmzTXUKZKMPW/wYH+bL6pjpKZHbWbMkceeVTxR+kdIJb6xQXNShf/XuiY1
	PBgVRVEfOKg0HGY+Jhm3TO5gLSM0MoT8Y4v+7wn7YXHXO6jkYbJD8sHgM2u82i0hQEmyIo07yQJ
	l+n8PEhdbimACvfoAaj7T4XfdcI/92WHJx/Y12ChUyLYS+Va8SzjDRRQtsg26nCOZTv9QFPqLX1
	3gxSKus0GeW9luKJo5HlIYNodyMio7Nly8JLwI4gHQqqp5QI57SDHdpJxPYLPrFpj9Z6+nFVtDt
	fxogqYhgxKI1mCmHMfJikvRwzNLahHEulTr5vRNC9CNXdiAWovxEjMqFLmMDP14ntcGboIH8oLl
	yToD7BLYNeoAHm6ZLppDh4gIx6gGzPcu+kpyC5UZWMfoBQhsoafr2sUod0PeQ==
X-Received: by 2002:a17:90b:5287:b0:38e:6a44:671b with SMTP id 98e67ed59e1d1-39b25eeeef9mr55298249a91.0.1788960776711;
        Wed, 09 Sep 2026 06:32:56 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:574b:e1a5:307b:15c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14ae8af3sm72564185ad.80.2026.09.09.06.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 06:32:56 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
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
Subject: [PATCH net-next v3 0/4] rtnetlink: dump link-layer multicast addresses
Date: Wed,  9 Sep 2026 22:32:43 +0900
Message-ID: <20260909133247.113923-1-sigefriedhyy@gmail.com>
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
 net/core/rtnetlink.c                     | 165 +++++++++++++++++++++++
 tools/testing/selftests/net/rtnetlink.py |  71 +++++++++-
 4 files changed, 248 insertions(+), 6 deletions(-)

-- 
2.43.0

