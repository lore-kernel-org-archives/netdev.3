Received: from mail-qk2-f12.google.com (mail-qk2-f12.google.com [74.125.230.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F8F33A9F8
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 14:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789742821; cv=none; b=mqzANIHnkKuFJp7wRa1+Z/sPWi3BPhToyrTUCUgslnBHN0il1c/rQjQ2PQ5ZTte6OYJM/atykQQ+n6i0Aven7bFwFBV91iRE4HwWUNZPJ9Uy2UmD1dKbn6K0fo/UqMPyUS3xRyFHYGUbXubCDCbDPEzAj6ePmkZlbWY9iO1cHMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789742821; c=relaxed/simple;
	bh=jViD/rOj158IIVRyenKEzNXvlTOBl+PLeh6KrO3NBhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Vt+0hsd+dOdQstQ+rgTgYj+MK6vtotEU6Jnmbpx57QbWf2VoKgNutUu6ah0b+6NoW2DdA0GeuQwSQRJtv2btkWju7eVqSoVB3HnhWYCHYOHnwDEIF7UsT96CFcI9nhQCORYlSNXFwk6WrRWkLxNGok5G5uHk6IE94hiJLSLd/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1/SQG+3; arc=none smtp.client-ip=74.125.230.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1/SQG+3"
Received: by mail-qk2-f12.google.com with SMTP id af79cd13be357-939109fafd6so71560985a.3
        for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 07:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789742818; x=1790347618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RoRhENqwgBZMFIya0BCuX69IQkNFf1AmBE46Ti9pPss=;
        b=g1/SQG+3UwbCkccq748a/9012V1piM4hOiCcqrrGU5F+BJJzNm44wAbzVzpNZArecD
         G6RslO9pef4STQz8BHx/nMycrC3262evCwvrh/vMZe6y4DZx+K6I8GHn+8qgurogVW91
         ni0TwbuDwY1Yyr2TLShjAOnEER3+OojEF618x9lv2kkii8e1s2pemxOQLMZIuB57x+9H
         m69G9KIWZKJjkWzURxhOfGjJ0vT/s/AdNg7fNcSI45l0+SljYgaqSeueTJyGX6uSquCM
         mliRcM0HwIh6p7eeaonnGrCNlkK0ux5WlLHMsH/9mHuaFhTUdzdzL8AqYr4Fw+zFwWKT
         uQiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789742818; x=1790347618;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RoRhENqwgBZMFIya0BCuX69IQkNFf1AmBE46Ti9pPss=;
        b=FmDrbwOE1yybCc5gKGY/IeAZHadgTyJP005JRyh9tONj7PAqfttJm41d8VyOTd0xYU
         GPllwk3RiLrnvcLYbL1WvS4NEQHxpPcg4SygogU/eCz8YT15IR68IVOG1bNazsxojmiD
         Q3yfKNjM7iD5mO9fAv941YjyGlC5yfwARJAb4U8/EE7PGrwf31zHYYLIUEIzM7vpMvRX
         LxB3mhckN2qwtIrbAqwsccPGCeSk1oc7gtUx29ozLN5Y5b7Y3I+tL1kOV+AangAx4U9x
         iKuY/HMhKJGZnYMjy3ieL0JwZD+Vx1HkxXGY5GyGp15rLmrkLpZZbVoBq4I3cCxEKjMv
         hfIA==
X-Gm-Message-State: AFuF++mPqk5QBGyqpgYg+2JIjkh0KCia4Ka7h1sXol5IgD3bF/sd0sJo
	ZBbDvBai+PMatJKF0G/8ktKH7ifc7DbCeY9aAORB/TJiRou1pLwntXxxSQ6+JtUw
X-Gm-Gg: AYBFou05hI//tzveBP2tB8dg6JEWMjsrQeMK2ZsJNTJzLbgYo1TrskyJWKIORZAAMaQ
	L0LPqXIaA/7SeCvkwXNmUkAfl6tSjMfPy/BLtfmDeRVboO4E/YlxXRj1Mv0Kpw7cN8bR3JzO6kF
	y+9Cf6jUdRWtPto9ZcbWwMihpa+tLOqUITREM14xTowQi8ejJcJTkQiy0WlRlNbXmf/AEEOII4t
	m9L5mR1V/ujrCOXJkBUYLB1UpQjd7fsLOtNnugNoY3flShWe9SDyvE2zzHsIXjXo6218aF5WVYy
	TfF+Y+yF28YJJW1JB7Rg6F7rciLqQmTiQ8sMWHi3pdoydun4eB04ozRMbuVQaU1CgZQtos020dw
	AR+1FlK+Q4181Di6+RZckfV1GmLckdHCQ2WDfw3RXRLz87xIt4wcweQSJ7QGJqqjPug/iY/ALPq
	F2Y2jfbkao6GJzEqsMk/pGlPlq+TJFKtjN5G7SAsnf2mdOiR9DFhlWRPAIJLsk45WuaQ==
X-Received: by 2002:a05:620a:4009:b0:939:a9d4:50b7 with SMTP id af79cd13be357-93bdc6a958dmr403161985a.26.1789742818019;
        Fri, 18 Sep 2026 07:46:58 -0700 (PDT)
Received: from houminxi ([61.170.217.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93be0ed50b2sm160197485a.32.2026.09.18.07.46.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 07:46:56 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v5 0/2] selftests: openvswitch: SCTP flow key coverage (IPv6 + NAT)
Date: Fri, 18 Sep 2026 10:46:45 -0400
Message-ID: <20260918144647.2024095-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The merged IPv4 SCTP flow-key test covers only IPv4 and only the
plain forwarding path. This series adds SCTP over IPv6, and SCTP
across conntrack NAT (ovs_nat_update_key() rewrites L4 ports on the
recirculated skb). Patch 2 translates the destination port so that
SCTP branch is load-bearing; address-only NAT cannot tell a working
branch from a missing one.

Full OVS selftest suite is 19/19 OK on a freshly built kernel
(sctp_connect_v4, sctp_connect_v6, sctp_nat_connect_v4 included).

v5 restores the series title and patch 2 subject to the v1/v2 names.
I renamed them in v3 and v4; that was a mistake.

v1: https://lore.kernel.org/netdev/20260823020942.3101898-1-houminxi@gmail.com/
v2: https://lore.kernel.org/netdev/20260902125133.1828572-1-houminxi@gmail.com/
v3: https://lore.kernel.org/netdev/20260906165251.1176875-1-houminxi@gmail.com/
v4: https://lore.kernel.org/netdev/20260909122521.2687193-1-houminxi@gmail.com/

v2:
- rebase after net-next reopened (v1 was deferred while the tree was
  closed). no code change.

v3:
- usage() tab alignment
- wait for the payload with ovs_wait instead of a bare grep
- CONFIG_NF_CT_PROTO_SCTP in the config fragment
- probe with ct(commit,nat) so kernels without NAT skip
- NAT translates the destination port (4443 -> 5555)
- commit messages: drop the INIT/DATA claim; point patch 2 at
  ovs_nat_update_key()

v4:
- keyless ipv6(proto=132) install must be EINVAL 22
- wrap a few over-80 lines; checkpatch --strict clean
- rebase onto 548b86839f7f

v5:
- TEST_LIST descriptions sit at column 48 with the rest of the file;
  shortened so expand -t 8 stays under 80
- skip the v6 test when socat has no WITH_IP6
- CONFIG_NF_NAT=m in the ovs fragment so the NAT test is not skipped
  on the reference config
- CONFIG_NETFILTER_ADVANCED=y so CONFIG_NF_CT_PROTO_SCTP is visible
  (it depends on ADVANCED; without it the symbol is dropped and the
  NAT test skips)

Signed-off-by: Minxi Hou <houminxi@gmail.com>

Minxi Hou (2):
  selftests/net/openvswitch: add SCTP flow key test over IPv6
  selftests/net/openvswitch: add SCTP flow key test across conntrack NAT

 .../testing/selftests/net/openvswitch/config  |   3 +
 .../selftests/net/openvswitch/openvswitch.sh  | 202 ++++++++++++++++++
 2 files changed, 205 insertions(+)


base-commit: 548b86839f7fb819a4d6c83b71c73ec378d24275
-- 
2.55.0

