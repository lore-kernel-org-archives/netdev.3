Received: from mail-pj2-f37.google.com (mail-pj2-f37.google.com [74.125.227.165])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F9D375AC6
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 01:06:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.165
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790816775; cv=none; b=N7DmGMjkG/dk2t29m6JVV2bolr2Y+FkDPygkoBGZMROUqblBjWL8eOTwWG2UQIUKpjh9Y4LE4JYnFloIkxZI24ohkZwBzLe8xfaWOMHcoBS7UfFrLzW6l6FkIOT//758YeIjcRZIbWB2VtFbREgGT8Q7rPGZAKdslWvXdnoiIIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790816775; c=relaxed/simple;
	bh=BMbtEqLdYWcZjkFJ5a4PL8ZAfkp7UDpEQiVyHNreqzA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gLsfvLbX6j94SCNWE7NLbbyiszZ91uID2ClDLg3D/vzd3LlvAFmSTvCVcJkdCJHNLqWM/GjPW28JNwUp4npwjaJ1korS+TUWfJYptSNcxyrcgpOFWU8l0ZEv67DTecFgh7eqZNH+4B621aUD1B6jF0nIdsUEVA1XSD9KLF+fUj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ADHLSHR1; arc=none smtp.client-ip=74.125.227.165
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ADHLSHR1"
Received: by mail-pj2-f37.google.com with SMTP id d9443c01a7336-2e300fa474aso2126755ad.0
        for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 18:06:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790816771; x=1791421571; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=XpTOif152T6/Gglg3JccrFkcn2lFkVRJZ1UpEwp2lww=;
        b=ADHLSHR17nCSnFlBMm0QpX3Tw1mTUGqeze3h6n7wOzNXuVRUbsjtR9FEWAN6KT0FAP
         AcQQw1JaeRYNRK99cVN2O3uj/TxmJcEjBKOm9n9j1YlAfg2GySMY+ZsLOYCio7MsDDn9
         Seq8Ra1autA/iKijJzDSSsP8P8WQSfs6Am/yrRUldAAQAxhEbOyZDhiqIxB+6tly7KBU
         qVvPNrirlqNya0skotzvD8FChnGWSDAH6vRFPY6vxOA+MVZzx/a6EssLZUvs1OeELLZn
         c/INq3tnqYVXmiz8Mvxs1BKZRGAYgGGSL0zwVyW5MaiLpi/PGsElhzNCNXtw7JVhannv
         YLTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790816771; x=1791421571;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XpTOif152T6/Gglg3JccrFkcn2lFkVRJZ1UpEwp2lww=;
        b=b+Hgdy7O+wg/ODVs2gjo+ocheEEdV5szsGFNk6xrGLCajEBTeRD2vKEmqYOV1s4pjL
         Wg3rk9pbWrXWFHTeT2JJO1Y/eIEbZ6/26Chav9Bepf8zQXHcYyBqmFgzoSvG5rQ2BzUL
         GreJx+68mFgKJ0znk14qzz5aZaBnKuyAUpx4YODPexhIJoUUGW6VmxMgpALNENMmT+ka
         /Jk5x1vgElhn7wa8Bq/WQ7VSv/oxwRs5zR7PeG3ulSadieTDfxJ4LVlLoSkzJ2UqIAi3
         Wr/lurgcjvTJiDb/0ctibOp74AzKYMTRp97f5V5OOueREy5poHMZ4dXzvG3AVO8zg+zE
         T/jQ==
X-Forwarded-Encrypted: i=1; AKwUvByuPOir/bgZdfpI00/JsRo7mEiF1Y6K1i+dHz5YkHtOS4aU07BfksLUnAnb/N0CrLcAcIBvtM4=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBtvOYKBf5b1s7nK061rWzCEvzHu/JukyKvQA+u07IUcMOFeZ4
	n2mulnU5gmaQrpe4DZqcMHzsuE3wrJU+V9Tt4LK52bQ2D2uXbb25pObN
X-Gm-Gg: AYBFou2V8euxoh4+VZ9LE27agrVgvqW9uuxmYxiad4sLtzyP2VNsGqzj8/Kf0X4ZVdW
	SrN99IN/HT1GQGTutmJ2uyaWDEztIGrE1/Ngg0vOapqb1Q5uxrGLMuTYiTK++YnFzyaU8CV9e8K
	vJq68Auo9uNrgW+uOznjtBKH3bFDrWVDeMJu794HFuf1ecShRH++kMqGCfY5zBXDTiw9VTe9Ln2
	IBHAykdXKA5UAQya/cdP+KGT3ZP/WRpDnXAbszNAuGEl3Z3X3//M2JodAu16f+5qkf5PokveQrI
	8cmpsju5r8ahR9rrVQUfjmQoBLvQTNIPiREQSdowcAiXJNfsprfmp1ZL7YcslLSG22ALYNqinIf
	buezzOwhTpK/mOPSIvUOADhkrqMr1rNKf/rZ5a+mzj26dOi3OiXRsdF2KAX93ru2MSuOL1nxv8h
	Twmb5O/UCyxbE4wfMhTKAfHdfCIpTSkQHtTHMTiGp6begFgIEe3vEPIR5mP0igT4Bvup16Caz88
	8+Ja+pz+6osKnLx+7zIsPQ=
X-Received: by 2002:a17:903:90e:b0:2e3:c4c:16e0 with SMTP id d9443c01a7336-2e30c4c1be3mr323735ad.7.1790816770775;
        Wed, 30 Sep 2026 18:06:10 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e300b31e05sm3494955ad.62.2026.09.30.18.06.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Sep 2026 18:06:10 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Vdovin <deliran@verdict.gg>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net] ipv4: stop PMTU walk when nexthop group shrinks
Date: Thu,  1 Oct 2026 10:05:50 +0900
Message-ID: <20261001010550.2742297-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 7d3f3b4367f3 ("net: ipv4: Cache pmtu for all packet paths if
multipath enabled") made __ip_rt_update_pmtu() update every path.

For nexthop objects, fib_info_num_path() and fib_info_nhc()
independently load nh->nh_grp.  RCU protects each group's lifetime but
does not make the loads observe the same group.  If replacement shrinks
the group after the loop accepts an index, fib_info_nhc() returns NULL
and update_or_create_fnhe() dereferences it.

A deterministic probe only widened the existing window between the real
operations.  On v7.2, an RTM_NEWNEXTHOP replacement published a
one-member group after the PMTU reader accepted index 1 from a two-member
group, producing:

  KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
  RIP: update_or_create_fnhe+0x45/0x15b0

Stop when the indexed path is absent.  Groups are dense, so no later
index exists in that snapshot.  The same real-writer window completed
114,423 PMTU iterations without an oops with this check.  A reproducer
is available on request.

Replacement requires CAP_NET_ADMIN in the network namespace.  Where
unprivileged user namespaces are permitted, a local user can obtain it
in a new user and network namespace.

Fixes: 7d3f3b4367f3 ("net: ipv4: Cache pmtu for all packet paths if multipath enabled")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/ipv4/route.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 37674d76f90f0..5f2197874bebc 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1082,6 +1082,8 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 
 			for (nhsel = 0; nhsel < fib_info_num_path(res.fi); nhsel++) {
 				nhc = fib_info_nhc(res.fi, nhsel);
+				if (!nhc)
+					break;
 				update_or_create_fnhe(nhc, fl4->daddr, 0, mtu, lock,
 						      jiffies + net->ipv4.ip_rt_mtu_expires);
 			}

base-commit: 4f1da630d13de0370e2f6361f961f1c8b384af1c
-- 
2.55.0

