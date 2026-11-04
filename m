Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822672;
	b=hOM192gir7vbwqydfuyIhDOILFjQn0BEsX+TDrmXAL5h3fhTIH0bctxil8dC9CR357Sp
	 x8gbjR1STMxiHe48L6yzZZ+z2Xv7eXzWsjWqZhXQvscLLF9RwK0gwCfdupVFxB9eRGGX3
	 70Y/A8JwAEwpsv+CzpEByj3FTP5/YChbVPj8RS3T2RUUxWn8vTVgXSrcPuBM9itlVjRqg
	 8lE1S4r7CbFuuU8D8QOiL9ml9iW4h+6DLsv/02iXRNCDEjFE9Tg+RDQ586mW4K5lWJHmA
	 MKuJaPlMHDwlAvDcJXU0/8P8fYVWpQrqpcLjhyhVxjxg/PFff+EvUKU7048kHyofPiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822672;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=mAUYa7DsnYJVWK5uXvFQ0zTldnyeSGGQ67HR5sn+wb4=;
	b=x9XdsNDDXayq+BW80bCbZHJZVQYH3ZL8dEcyCqAIao7ceUP9oRzn0fQWAO+ChqNRNX2Y
	 SYyeD9gl+8Ih4s7CBmSoRsNSp3goFsEdvUJdTJmuJqsY5u8MEZ6AkY1dp7TvyQoCFvmMj
	 pXKJ+qQ9avDrIjaShV4A3kIoLCzfdjqKUzBxmFCydu0RBcKO5WKCC7w1W7AftrGPVRth3
	 wGnHdAPqkstzIvp8G84//pa0DkKPf++sVPm0SJ+JIAvpRslAoof7tc7xW7NrruNm90TYr
	 lemBot0LlgDcBURv0zLhKqiHzxswi6eciRS0r/ZtRuvwKrSAy4ju/EsraIxpXvguD5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iIGQtM82;
	arc=none smtp.remote-ip=209.85.208.178
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97B51606FACE
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 20:04:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97B51606FACE
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=iIGQtM82
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3ab39af88aeso14371191fa.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 12:04:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793822670; x=1794427470; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mAUYa7DsnYJVWK5uXvFQ0zTldnyeSGGQ67HR5sn+wb4=;
        b=iIGQtM82BiNLyonv+Vl1VspuOaMrUC9/Ps8jkarVh6KbuKTW0cgRyFG3800Y8PBh94
         0O1TWzSF/QTQci3Jk8AyntkfwTrPK+ONyfVuEcW5cRCww6IwspuYxE6yDuZO/To2EWNB
         SExxL0YrZIYwTAFcBxjHG/uRDjSNW/mA7AME+Q3Z7c7217QIh1j0Ie9cf+jgYRxX6wn3
         0CP8WkGxtJawP+paRtQYxDz+iqhcbKsDOFdDCIiSrryfAUVwYa7zt0xC2AbpU3KnJCHW
         P9MGnd0HI+2n2KJKUS6Mvd95vktqGYhifeMI/55MUHToq+3/nMCk15kwgFdTtDAF0d0k
         l3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822670; x=1794427470;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mAUYa7DsnYJVWK5uXvFQ0zTldnyeSGGQ67HR5sn+wb4=;
        b=Gs056xUdHVrBD0CuxxFORkIoQA0V4GN2Wh8qaWsejFe1Nza6+EgkJB1FAaHYZId9tc
         D/NE+a4739ddIuVeDJbX7cDK1Jz/wufx1zdpzebYY8WAM40UrqnTkZsEbwW7m02bWotq
         1H9PhaoGXRjMGqx0PCdb+MGlgPO1FWCOiNb+v0MGAHS+qZG7Rg2GZaATRxQ/u8ZbSeHY
         TkSU8n4748lSeKMZdZTL+oNx1Jc3LoBwbBWewjMkEdtwbTA4/qTYSVZrDH1UsHYeVatW
         18BFmtN3lYZPJCJlKhGDb9Nkiv6WPwdPwd0iNT8g9vFf6gd6R3hKxC9urRY1pJrG2sZk
         dslQ==
X-Gm-Message-State: APuU4Z8pbBUus5/mSAr8d5aYIaJKTN1FxKt7DXR4Q03NIUyyC40NED9E
	rnrJ3+m9LayuTlp5RxItCEA+RJXMnkqKmyRSuUPaM+IuNHqKlD/bK16YeIVyikNxFw0+XQ==
X-Gm-Gg: AYBFou2HCgEwCFhWj/0rOdPFhoYIWixKk3iwWlWM0CCI2H36sw38XkidvfR/2hXmmXa
	MJfQcjGcyMBPEeg1gU3tISyE5ND0kvyCnJbkZ407FW2tyY8sGfhm01Oq4IDF0tlYwetaTbEpSCM
	94QUIRfrrwREERs2FfOP8egwbq6ezodf9ARKCQF43ws+/0nRh9HKKuDuV52j4lIlcsoF9FSiWb3
	5vmwWnZdgSUzHogm0SRInHxodse64Pnd+2n91sZF6wRgtlJVCWSHuz7Y5skSLKdh570LjX4SzGZ
	N3uB9LqaJh+Bb2yJ8GxplkBrsPyVisx/tFJNG0nidpYjzM06TLLomv2TfVV3N6eztj3vzUOYcg5
	NvEaPHSdPIMncl6eAqyoABd+sa/3bPqAhbcDxFtRMLTesRgsU+1O1G1liWllSMDU+xB5tGrMz5X
	HDutUguac3NicSHl2ppxVURqn6izgxkcrw/pk8A0W0On1l+TyNxPsNhmlfR641qnewfblYnNsCM
	3IpdLj2GL4tiJpygP1B6DcXLgbXPeEiw9ZhiYcUrNKYrpBOjhG3DToelWI/qnXz39UCddJKVlFy
	8tr13bnC/vEA81IzDoSXUSgvJQU847rm165qxCBOyCahlelGOfA=
X-Received: by 2002:a05:651c:43d1:10b0:3ac:cf09:d6ff with SMTP id 38308e7fff4ca-3accf09d9c0mr17250161fa.24.1793822669498;
        Wed, 04 Nov 2026 12:04:29 -0800 (PST)
Received: from gentoo ([95.55.209.127])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3acdc6e9b60sm5848021fa.35.2026.11.04.12.04.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:04:28 -0800 (PST)
From: Yaroslav Dudkov <aroslavdudkov622@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	weiwan@google.com,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	Yaroslav Dudkov <aroslavdudkov622@gmail.com>
Subject: [PATCH net v2 1/2] ipv6: ignore link state in gateway check
Date: Wed,  4 Nov 2026 19:56:54 +0000
Message-ID: <20261104195655.1406837-2-aroslavdudkov622@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261104195655.1406837-1-aroslavdudkov622@gmail.com>
References: <20261104195655.1406837-1-aroslavdudkov622@gmail.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

IPv6 route cannot be added in table when all
following conditions are true:
- gateway is not link-local address
- ignore_routes_with_linkdown=1 on device
- nexthop has no carrier
- gateway is not present or covered by any route in table already
Also multipath routes addition is invalidated by kernel even
if only one of added nexthops satisfies all above conditions.

Reproducer:

  ip netns add t
  ip -n t link add va type veth peer name vb
  ip -n t link set va up
  ip -n t addr add fd00::1/64 dev va nodad
  ip netns exec t sysctl -w \
    net.ipv6.conf.va.ignore_routes_with_linkdown=1
  ip -n t -6 route add 2001:db8::/64 via fd00::2 dev va
  # added
  ip -n t -6 route add 2001:db8::/64 table 100 via fd00::2 dev va
  # RTNETLINK answers: No route to host
  ip -n t -6 route show table all
  ip netns del t

Route should be added because:
- RT6_LOOKUP_F_IGNORE_LINKSTATE in commit d5d32e4b7668
("net: ipv6: Do not consider link state for nexthop validation")
was added for this
- the same route is valid in main table (when no specifying table id
while adding route)
- fib6_nh_init() initializes nexthops with no carrier
- IPv4 already does this (fib_check_nh_v4_gw() ignores link state
using the FIB_LOOKUP_IGNORE_LINKSTATE flag)

Before commit b2c709cce682 ("ipv6: Convert gateway validation to
use fib6_info") rt6_lookup() was used for checking if nexthop is
valid, rt6_lookup called rt6_device_match() which does not check the
link state. After change rt6_lookup() to fib6_lookup()
find_match() under fib6_lookup() started to invalidate linkdown
devices, because RT6_LOOKUP_F_IGNORE_LINKSTATE is not passed to it.

Adding RT6_LOOKUP_F_IGNORE_LINKSTATE to flags for ip6_route_check_nh()
solves the problem. RT6_LOOKUP_F_IGNORE_LINKSTATE is already used
inside the first search ip6_nh_lookup_table() and fixes the
bug in second search fib6_lookup(). Also RT6_LOOKUP_F_IGNORE_LINKSTATE
isn't read inside fib6_select_path().

Fixes: b2c709cce682 ("ipv6: Convert gateway validation to use fib6_info")
Signed-off-by: Yaroslav Dudkov <aroslavdudkov622@gmail.com>
---
IPv4 example of this situation:
  ip netns add t
  ip -n t link add va type veth peer name vb
  ip -n t link set va up
  ip -n t addr add 192.168.0.1/24 dev va
  ip netns exec t sysctl -w \
    net.ipv4.conf.va.ignore_routes_with_linkdown=1
  ip -n t route add 192.0.2.0/24 table 100 via 192.168.0.2 dev va
  # added
  ip -n t route show table all
  ip netns del t

Also when adding RT6_LOOKUP_F_IGNORE_LINKSTATE to flags of
ip6_route_check_nh() makes adding this flag inside of
ip6_nh_lookup_table() unnecessary for this call, making another call in
ip6_route_check_nh_onlink() with flags=0 the only place where it is
needed.
---
 net/ipv6/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 94e5ef1c4f83..73d8a2c95602 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3424,9 +3424,9 @@ static int ip6_route_check_nh(struct net *net,
 			      netdevice_tracker *dev_tracker,
 			      struct inet6_dev **idev)
 {
+	int flags = RT6_LOOKUP_F_IFACE | RT6_LOOKUP_F_IGNORE_LINKSTATE;
 	const struct in6_addr *gw_addr = &cfg->fc_gateway;
 	struct net_device *dev = _dev ? *_dev : NULL;
-	int flags = RT6_LOOKUP_F_IFACE;
 	struct fib6_result res = {};
 	int err = -EHOSTUNREACH;
 
-- 
2.54.0

