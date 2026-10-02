Received: from mail-pj2-f39.google.com (mail-pj2-f39.google.com [74.125.227.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01CF3655EA
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 04:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790916681; cv=none; b=m2G+xuT5ZZ407fWGcq+mtwrlV+kyI47jdE+EuY5fUDDt/hUF9n964weJwRA8qyCEhrtT3P2lOJPNrkEBEP/lHQKTHTpWs1hMpcgmZ2pRbQP0jy4x7brKqIXpS2kLWy7DtWQhpUiEjuO8anW+IgHk1DuY5xOah3EgRW3BOXw0/IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790916681; c=relaxed/simple;
	bh=EteBqRwOLnXN3M0J+gAk+oFidGRofjnyUkuhc8Yj/b0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zy10aFlZ23GcD82LhLYgICxO5tUqq6jlzrZlmt1O1oKqzVRqc0+b/bwKvAz0c2sno4JNrDa68EWbJBr0JDUbtIGLQTBRhcxzpmkK4vCynFig67gooHcTW44NnEam6hELuKasD9vM1+5j3v8+oZMhJDVmvaEhNEVNNU4mnr/Jbk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pGnbTb3Z; arc=none smtp.client-ip=74.125.227.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pGnbTb3Z"
Received: by mail-pj2-f39.google.com with SMTP id 98e67ed59e1d1-3a4805e15cfso2773049a91.0
        for <netdev@vger.kernel.org>; Thu, 01 Oct 2026 21:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790916679; x=1791521479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cTsDoHWNhTSL7kUFc6o5v5Gkxn0GUpcR2BsXzWRaXlU=;
        b=pGnbTb3ZDweKliMva6oEL3jqZIp2+UbsL+t6DWW6bNpGIQ5QKYrjpBTxkuGQ9B3nFZ
         yjCbCPRh8k1i84kdgJ3WQ7/IrBXEL5XbcP0odQFJzP9Lkmmhisml/3ydcNnKJEMiNHer
         0pTZwSw/j6aLPM3Dpy/l6YYqjs46DLhD6nx6MqJwRPEbkLQcs3GBVtuRg9/8/KkLW6Qb
         N8gqckLAJa9qknACM5B9HkgT8HqlqeGSpW58L37dNoChSPiOeJDIZfmCQpQpgrnDKryN
         1FK6cVfJd2Ii0GpPkihfYJdm4PKahkaoYhJHcD77ZVuk06wkodmCSAy86zP+4dqDiILJ
         zJ0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790916679; x=1791521479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cTsDoHWNhTSL7kUFc6o5v5Gkxn0GUpcR2BsXzWRaXlU=;
        b=cDXWtSC6xXhPGzngvbFkwN7E5BU/f5PBfL37uaK/y0xKdl3GnVyRBJugvUfsHIujgW
         RMPS5NpiVPn8YqJ/t1SJBx+4eAaBh1pQDqWR9AkTSKq6ValbY13IX3QsT2lQpYTNF2AR
         0fdZdH2caGszC9FKuGTP5vB8n7gTdlxkzXB6kSp+9JJZjpwZykudb1wH6H5S85K6UBDg
         Vo2W3QLUYkC4SWFE++7xvvY0ePk340dD4YEujgPmuaAW83vLCcDzBBmlH0kvI2QW1rVD
         MX1rCWNdKqqlgDrk0qOSAW/sfkgloXNEDO2/xzGGuX9ffXiVppS2uAqd2Vo1ysa02J8z
         kFPQ==
X-Forwarded-Encrypted: i=1; AKwUvBxfezwQzG27kM83dVOIyWryIb6ScEAW4BaClisoYaQY0k9h9ZnTLWiYkGoTN0W5Acm5bfylHIU=@vger.kernel.org
X-Gm-Message-State: AFq9FYLJoVoESAsoI6B90IIE5ZGH8dZUFskfdttF1RZiGkb2LExntyN5
	cTB1ZewgnkKrDXSYe439FwfFHIiQbk3fKQWSc4d8rPWI2TgKzz5CKJ0r
X-Gm-Gg: AYBFou3vGKDOaBpntjdgHDgpk8s51sk147ZCQsNwuBiSRv3Bl5ODQlcMP/XsbIAZNJQ
	TUA+S/gOOJ858O0y2AFRlxLLNwSESatovgRQkwagm4UPrvPvyoqg4qRC0PN1hw5oYKE7YAnnlAx
	eODKisOsARCpNlkp5kRqefKpmAImwyudwvhnou/caT3znKHpUjihScsg6MhXesGLwMSTMD6x0jP
	vScRFsFabcV70ZjMC2hov0DYX6Y1YY2Wk+GcWBoHHWeCyQf40wpWsqBE70C1keq7X3oEno8evPz
	UzYsuur1MpOqg8dIBzO/XR5q6VWn3m/IWtt4wDTlmXAWeqf69GrucPcLYDNTXyMpUP8frZmkS2G
	mIgTr3UPCeePleP65HTC6DbONexc2Q8chL7LC7ajl9rDIFcTK32gyZI7pdWnEUjTqez6ZKP4I83
	b6V4TBIV7SJLgpjgkEPUo7ag94XEWPM4ikg7Cawvz4lf4cptn5ookN+3D0IMfX+rYwaCgof2QcS
	uCRpKKYhb4=
X-Received: by 2002:a17:90b:3e85:b0:3a5:3f7:27f with SMTP id 98e67ed59e1d1-3a6cecaf8c5mr1436229a91.66.1790916678778;
        Thu, 01 Oct 2026 21:51:18 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6dd3962f0sm642682a91.3.2026.10.01.21.51.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Oct 2026 21:51:18 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vladimir Vdovin <deliran@verdict.gg>,
	Donald Hunter <donald.hunter@gmail.com>,
	Amit Cohen <amcohen@nvidia.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daehyeon Ko <4ncienth@gmail.com>
Subject: [PATCH net v2 1/3] ipv4: stop PMTU walk when nexthop group shrinks
Date: Fri,  2 Oct 2026 13:50:58 +0900
Message-ID: <4fb87ed994dfc067178fc845cdd8bc9b5446b039.1790915964.git.4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790915964.git.4ncienth@gmail.com>
References: <cover.1790915964.git.4ncienth@gmail.com>
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
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
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
-- 
2.55.0

