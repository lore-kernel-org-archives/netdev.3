Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C2F1632E7
	for <netdev@vger.kernel.org>; Sat,  5 Sep 2026 09:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601182; cv=none; b=Tcy5MtfJ3LgsBIBv5xazYV3ZzXBAwzVFe82RfT75GqklhT9Zn1hCYEMeB+84bqO8jmYbNU0Gv4sonxI6Qusbd/IhKhEMKt5pS4PxDcnuunYh1rxRYKIzxc9XkaTP9mwoBIr/LLiOJSgC3LMzIdV4F3IRclzIN2zhYvsmgy68aRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601182; c=relaxed/simple;
	bh=36gROY4qL9gSQnmwWWmssqa2Rc1TUhB5TO6YlZyD02Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qplJ2c/ISztMN/UFls9fMfYNn9//p2vH7s4h97CDDmldaxUEwV+dkM3BHVOtAZdiPhu1xgDynLHY8r4RB0FvuKfl42Pnv4dUIHnnhsl4SphxL2VPj4bMkD0o26YgwIoZ3/n89fDl11zTMPV431L3cwdUYzgUERNhMvMQY+eGO48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PeNXO/QL; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PeNXO/QL"
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2d9004f39d3so22973995ad.2
        for <netdev@vger.kernel.org>; Sat, 05 Sep 2026 02:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601180; x=1789205980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RohfZQzLcCU55CV/vABPS7u+EENiNPdreGoEMSHrxVg=;
        b=PeNXO/QLNfyNaOzNHPIgIGP5PsR5Us8JGog4v6Mhwr5aq+NZbo1CJNf64yuQVYPL8I
         BnueYOYLAFVElk67SCbbfZWLWlcP2Yf6qZca0XTVwARMpESNQUS1+a7v8dI8N4jDpkUf
         qukf4nIQ7Wxj2nZBzzlFLEGQKkj8XaPE8Zv8dQ+NhnAjnHwau0lHF9WNnjmNAaa5soZK
         gaAYd4VNrA2+tmfjfyZWRBzKqS+hPmZ8aEPOea9XWHszWeYhV2W3q04UeE/iK3CV1rHw
         z7NAkESSaSPoBswJXOWUIYrXSC+fh+WOvvUtyBVHHtkV0nut+eIQjJ2M5eYC28QeLPEA
         9bUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601180; x=1789205980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RohfZQzLcCU55CV/vABPS7u+EENiNPdreGoEMSHrxVg=;
        b=WuSAyeQg4FEJrlmcLQQsLXNYiuJMcotaAhPyuKDPQvonz32nUVXQnGwjrlnN9V8Ys9
         1Vuq/vma2E59oBxj8jbZy6Z5YfQjTiyQQpi1uXWKMnya/Z0WZp3vGsv17OTWoxU7eguo
         3YR90xZkKqTOHDi91Q5t+ZaRyeJyQHQWpQFbuFPangKd9szqn38Yq97pFNpizOYSHQ3H
         ewD03kQv5Y6hEM56zbnE1gx+HZ0CVxCHp9J5EMINIPssQQA//0hYB2D4NgbdD4ZectIe
         iON4A+lM5h8eoeeOlR7Vy2OpQrtybt6IDXozEZ5EQzhGGScSHwv3RQqWp0N0OYlKBqpQ
         fbpA==
X-Forwarded-Encrypted: i=1; AKwUvBy4mAAdRhGkzBlA/L0C7+nDi/Wx1ImLxyN071d9xB4KL/wybGOTcWuc+kJz8k2BYUTSyT2g38M=@vger.kernel.org
X-Gm-Message-State: AFuF++m6Yf3JRz1K6HuyeUwOnCQbwxlHbvs4hAHaYIszD4n/lzE6hL78
	iCVlVr4UnNXewXusmklqpKX6nF7KjGCt8dhYUiQHrR4eeIL+VCymS16L
X-Gm-Gg: AYBFou3rQK0S34Iji62mAzBWnjmF5TrlPWtPqy8Cnl2Z9LbBJ6+eo2oVaMNvGbWdbPT
	a0vxU57AVaTcIAOQt2rrK1o/m8RbUXOqChcbG8ItaQ0Y5IrkQ5jWlhdNoSk2ssldPZ4jHcYBdcB
	CvcdMLpJWNicIdR6m+Eu78oeZm06uMJn6RmkjegofRoFZGorj7up+FJkSRRQFrUH0cpl24gMOO9
	i0U+Vy8c1jDRAp0uO1yTbH+cqP/A2WJj4EqiFDjzp2lypM2Z2bjN2sMdl5wUdmiFnjaKO8uJFGX
	AIz4mVeHcC4ROUB3i/xhrY9nVH8qXNfqejY172m3qCBe9BhL/O00vEVgJO5rEZxnm0qznZDV+y1
	gRtPExYB9/rgWJ+hFsn9Ic4AyODRExfe2jOmVb0ecExEC1QztlHtIX6mLXvzKLZw6b6o39Xmpkm
	NFifYJNxY3pe9Nb3MLqYyRBxyEm8peRGkaJWWOuTQLSIEH+9SEimT4pXC0okSxh1WKBTQqs4vGc
	RZnA2vjuEsl9o3ES7RXAvnWORG/KmQddqQpQbtLm9JP9OJp
X-Received: by 2002:a17:903:28c4:b0:2d7:f0:896b with SMTP id d9443c01a7336-2db125a3438mr104278615ad.13.1788601180369;
        Sat, 05 Sep 2026 02:39:40 -0700 (PDT)
Received: from m-upc-A520M-HDV.lan ([2400:2410:3f60:500:dbc1:ef89:4dd5:b812])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db1495a0c0sm20393745ad.17.2026.09.05.02.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 02:39:39 -0700 (PDT)
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
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next 0/3] rtnetlink: dump link-layer multicast addresses
Date: Sat,  5 Sep 2026 18:39:29 +0900
Message-ID: <20260905093932.43726-1-sigefriedhyy@gmail.com>
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

Patch 1 handles RTM_GETMULTICAST dumps with ifa_family set to AF_PACKET
and walks dev->mc under netif_addr_lock_bh(), no RTNL. The reply reuses
the ifaddrmsg format of the IPv4 and IPv6 dumps: IFA_MULTICAST carries
the raw link-layer address, IFA_MC_USERS the reference count, and
IFA_F_PERMANENT is set for entries added with SIOCADDMULTI, which is the
"static" column /proc/net/dev_mcast has and "ip maddr" prints. A
non-zero ifa_index in a strict request limits the dump to one device.

Patch 2 updates the rt-addr spec and patch 3 adds a selftest that
checks the filter, the user count and the permanent flag on a dummy
device.

Nothing changes for other families. AF_PACKET dumps returned
-EOPNOTSUPP before, so iproute2 can keep the procfs fallback for older
kernels. I have the iproute2 side ready and will post it once this is
in; with it, "ip maddr show" does not open /proc/net at all.

Yuyang Huang (3):
  rtnetlink: add AF_PACKET multicast dumps
  netlink: specs: rt-addr: document AF_PACKET multicast dumps
  selftests: net: test AF_PACKET multicast dumps

 Documentation/netlink/specs/rt-addr.yaml |   7 +-
 net/core/rtnetlink.c                     | 132 +++++++++++++++++++++++
 tools/testing/selftests/net/rtnetlink.py |  58 +++++++++-
 3 files changed, 193 insertions(+), 4 deletions(-)

-- 
2.43.0

