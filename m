Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793822679;
	b=Z2mOZ7G5o0a2R429dZ1dZQ8Jd9BkAwpKnIcbNkVIKquW13Y8Kz6lo94RdGXjmn0UXRFb
	 Fvo0QJlyRln8RxRBw6xEZ1ZHtPeLngyv/yCl0dUcmlik18xGD6gg76Y6HmY/ZARCqvi4B
	 pF625BGi8NCVcn2XLuOcXmi57xEFC1GiM7tee7+zC9nF15QBzfXuz2ui+ZpxBzYdArAOw
	 OYDYZj2X01XfygrO+mp1LSMQlhDsbZK9E4vawpegZ/0uh4ODlGop1q3SGDJteMj5bVN3+
	 mey/I/zRM0Aa5qs1bBaEs8En0L07vAbzb92KaufKEKiWhTXHj1E0EgfpiSISoSK0NFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793822679;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pYSTU5X3UuzczYg/8E5OrEwi5CakiKvwqjCVOhWzWq4=;
	b=Q8O95d8J+Sk2cTUB7U72WYDVSaBm5NKZw+G0t9sHeAFk/iEI3BtcOemYlSiQzu6oySvr
	 cK2fTBte6QYs9wqRSC5+kRQcaD0dtB+Llu09gLseU9iwGrzSfGsxNDixkMGJZHtgY4Nh0
	 kafKQmuC2ITFPhsjs+v43ys4h/x9Dq+JNne9nHW3z6Fm+CT5BjF6RUmf9VJLGKTIpCZD3
	 j3OVqbvkp6kR0e7joE9x46xoTEwER+aqHbATlhHj1aBEDo04HqiKcaqiSFOhZ/jgyLs7C
	 NPp7ljtbyhUJADK2x12OYoOhmDoTYVSUuunZ4+Eiv/+O3vwJ0L3HPHiYLjbhnqLCtDg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0DCecO28;
	arc=none smtp.remote-ip=209.85.208.171
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CB04607A96C
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 20:04:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CB04607A96C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0DCecO28
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3ab28f3e4dcso18675771fa.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 12:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793822677; x=1794427477; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pYSTU5X3UuzczYg/8E5OrEwi5CakiKvwqjCVOhWzWq4=;
        b=0DCecO28ue16+Xp/dZw6oCOTeArtgudPtEJi038NWajCPUMgU+Ncyxu1f3gg+8QXA7
         C1Spupb+fbH0LTCgmxLcbp8gu+6eZ5jgq+lUt01LuoXFHduSdD3G5dot5vAFB6bEoGX0
         dzuPJ6EW1pJtHs2dz74RHB0/n9EPaWFkAg87oeS34ikgMMxqR3aXriVN9S0fIcvRo1uC
         aJ9MebCz9V4uzJP6kXoEhg5koqBie0S39kGxx3jwWFgHPIg8YRQNjrk/ML1V66p+F4Gp
         YtdaARu0mRcX1qdSMX9JahtX7Y94FMcRv9IWCTS+DPucCSLYFjOJmra10kzvl/eXE62/
         YnbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793822677; x=1794427477;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pYSTU5X3UuzczYg/8E5OrEwi5CakiKvwqjCVOhWzWq4=;
        b=iVd6s8MV9jI477aCr4wjPfDx/B6c+/ICAGpdaNgMhzEDiOzsQiVUXMczPaoPePOMmy
         vWTb5KItnFcMCY/R8TJlI2L6PyQ5GTiBaPOG/sTr1pb4mZaFgKM504AEoLIAn8NVifO0
         s8pPeOiPgfiR3Ok3OxMVShCEJ7KYx5VptaJ4EALjIunVRN7PSmQ4th/JBIQZZTYcHvmT
         nVA9e0ubPC6vtudG2+x1nuhaigxlFJM4UtS87pA6940jVU8+iFMK2eihWVIhJikYndE1
         LmNHWdW52lwanVp1cDZmMQa9xVIG0X01Ve/Lzsqr9UZBNgZ3XBMEr6qOSl2mUMnbvLEm
         LWYw==
X-Gm-Message-State: APuU4Z/dIikELh1lZDz3l0WdP+emKGZLv8zjRz0z+E0grmCKJAESXYoc
	B1lP8TuyvkWXrdJdYCRgZQqr5zIpx1jtYplUNHYNRMI2utk14LAhF+a+qOkkjV3kg5E=
X-Gm-Gg: AYBFou2K8RZuwZ6Zsy0vub3hsNV1tE0DGAx41s3dWxB+BTkkIHddviEnTHGKOTP46XO
	nBajmuwRNOhvTMatpoIsk7Oiok2laee/GtxKcDVgjean7DfTSp2AH/l/FVl7iU5qnqwx0xIriNk
	r/woDyxX8Grqh3/h32wSzo+5b3ep2X6qKSgKiLtd0QKvO7BFNgBvkgi/q0CYMFwOSl1vNQeIIjH
	Wpe84PeRx65jra9FfaG8Hwal69m0DeePrRR9i58G4cGBVOBwMCUclcEsXlmiYLe5dxAyc2lwmWS
	VvOYfSDumAO0VPuG4+5pYUcgJCSD7wAwCUZW37aJ5PYeDJXf1y/7fTV1FOJPZ9PB3/UfVkFOof0
	vc3OPsupVt/Gi6xIJqLxfd2fmYzMIN3BT81aZxB7c5Bqsss/Fz5qwXEPxCDpoiGvLd3GOS2RWq2
	xHDvb9eguJLLi9/hF3U5xkwPxGhAEkVdz31uC30nCgZbvlsozLjIn3Z+zZ8c/N+/R13Melf24NU
	5ByU48hk5vKQBRNIeXV0QqM4PY0MpYki6ZIl/VvOIu7eal078UHHezSDfY0j+6RkuUzqoRjPBnf
	k2uQnjFZUfsK8nkvNxqlVUmLbyCnRg==
X-Received: by 2002:a05:651c:b07:b0:3ab:4b4b:fab with SMTP id 38308e7fff4ca-3ace2f7fca9mr994011fa.2.1793822677045;
        Wed, 04 Nov 2026 12:04:37 -0800 (PST)
Received: from gentoo ([95.55.209.127])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3acdc6e9b60sm5848021fa.35.2026.11.04.12.04.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:04:36 -0800 (PST)
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
Subject: [PATCH net v2 2/2] selftests: fib_tests: Add carrier gateway test
Date: Wed,  4 Nov 2026 19:56:55 +0000
Message-ID: <20261104195655.1406837-3-aroslavdudkov622@gmail.com>
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

Test adds routes with a gateway while the nexthop device
has no carrier and ignore_routes_with_linkdown is enabled on it. The
routes are added to the main table and to a non-main table, with and
without a device, for both IPv4 and IPv6. Routes are expected to be
accepted disregarding the link state.

Without the previous patch, the IPv6 non-main table cases fail:

Without fix:
Gateway validation with carrier down
    TEST: IPv4 route in main table                                [ OK ]
    TEST: IPv6 route in main table                                [ OK ]
    TEST: IPv4 route in non-main table                            [ OK ]
    TEST: IPv6 route in non-main table                            [FAIL]
    TEST: IPv4 route in non-main table without device             [ OK ]
    TEST: IPv6 route in non-main table without device             [FAIL]
    TEST: IPv4 linkdown flag set                                  [ OK ]
    TEST: IPv6 linkdown flag set                                  [FAIL]

With fix:
Gateway validation with carrier down
    TEST: IPv4 route in main table                                [ OK ]
    TEST: IPv6 route in main table                                [ OK ]
    TEST: IPv4 route in non-main table                            [ OK ]
    TEST: IPv6 route in non-main table                            [ OK ]
    TEST: IPv4 route in non-main table without device             [ OK ]
    TEST: IPv6 route in non-main table without device             [ OK ]
    TEST: IPv4 linkdown flag set                                  [ OK ]
    TEST: IPv6 linkdown flag set                                  [ OK ]

Suggested-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Yaroslav Dudkov <aroslavdudkov622@gmail.com>
---
 tools/testing/selftests/net/fib_tests.sh | 40 ++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/tools/testing/selftests/net/fib_tests.sh b/tools/testing/selftests/net/fib_tests.sh
index 7c47d7fe250d..d7ac3c727f70 100755
--- a/tools/testing/selftests/net/fib_tests.sh
+++ b/tools/testing/selftests/net/fib_tests.sh
@@ -406,10 +406,50 @@ fib_carrier_unicast_test()
 	cleanup
 }
 
+fib_carrier_gw_test()
+{
+	echo
+	echo "Gateway validation with carrier down"
+
+	setup
+
+	set -e
+	$NS_EXEC sysctl -qw net.ipv4.conf.dummy0.ignore_routes_with_linkdown=1
+	$NS_EXEC sysctl -qw net.ipv6.conf.dummy0.ignore_routes_with_linkdown=1
+	$IP link set dev dummy0 carrier off
+	sleep 1
+	set +e
+
+	$IP route add 203.0.113.0/25 via 198.51.100.2 dev dummy0 &> /dev/null
+	log_test $? 0 "IPv4 route in main table"
+	$IP -6 route add 2001:db8:10::/64 via 2001:db8:1::2 dev dummy0 &> /dev/null
+	log_test $? 0 "IPv6 route in main table"
+
+	$IP route add 203.0.113.0/25 table 100 via 198.51.100.2 dev dummy0 &> /dev/null
+	log_test $? 0 "IPv4 route in non-main table"
+	$IP -6 route add 2001:db8:10::/64 table 100 via 2001:db8:1::2 dev dummy0 &> /dev/null
+	log_test $? 0 "IPv6 route in non-main table"
+
+	$IP route add 203.0.113.128/25 table 100 via 198.51.100.2 &> /dev/null
+	log_test $? 0 "IPv4 route in non-main table without device"
+	$IP -6 route add 2001:db8:11::/64 table 100 via 2001:db8:1::2 &> /dev/null
+	log_test $? 0 "IPv6 route in non-main table without device"
+
+	$IP route show table 100 203.0.113.0/25 | \
+		grep -q "linkdown"
+	log_test $? 0 "IPv4 linkdown flag set"
+	$IP -6 route show table 100 2001:db8:10::/64 | \
+		grep -q "linkdown"
+	log_test $? 0 "IPv6 linkdown flag set"
+
+	cleanup
+}
+
 fib_carrier_test()
 {
 	fib_carrier_local_test
 	fib_carrier_unicast_test
+	fib_carrier_gw_test
 }
 
 fib_rp_filter_test()
-- 
2.54.0

