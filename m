Received: from mail-ej2-f8.google.com (mail-ej2-f8.google.com [74.125.228.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85F423DDB16
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 09:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789030876; cv=none; b=o9v2l1Fli5Hj6RdvWQ13+Jrfi72XfszXJJQljJGpnBhpKKmY5qXb6Ux8Qxlz7H/ungTIwrIZo+Cnt6JJ0B0UJiky57i1XyQPDW58t++YQ82q5fSbm4486LHKFaK/JQ02OY6sbvIMHwmcrPwhJQKEc5zsU18gxXp1YCYGfp0wNiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789030876; c=relaxed/simple;
	bh=9VC8+RYrNRRiaQZd+CDVz83hUbh0LCzg9iGqE7yiAIE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RpfwNcx1VwCPYcg/1/imHfw+giEqPvjdKeqNmZpi/3jiE/SljNVFQ051qBeqs5uUqMcmraLgiPSx8QFNYzQI1wkRaw+g4i2RFbHdtV76HwQh1g50OCxmXe4xsAkIfOcREn+q5YPCWSCI0WX2KrmZ0r0SQvqKEHWsUmLr3xqSpiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=HOryBTkU; arc=none smtp.client-ip=74.125.228.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="HOryBTkU"
Received: by mail-ej2-f8.google.com with SMTP id a640c23a62f3a-c254403ada6so292102566b.0
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 02:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1789030859; x=1789635659; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VXVlYl1gjLPwgKI1iO6doAk96CF1C9KclFcluRlvCtI=;
        b=HOryBTkU6iRhtlQfgAGF293LSspXeegR8NowYEUiBy0XFVJ+4ATL8BgJvBt3pa2vTM
         rpJrJLG3NBPS+lXcoQPn1SgDDWNcwmLdW8NXnnSk/i+b5/xM+YAzuro7DUlkx9rFsce5
         2xwt2b+U0oiFCBI9ZhJRwnmHUQ8xpqXd+YEnznmNxosGVr7jc78tf70j+zYXUTY6Lnax
         u7DWZWgzmEBFTm0JREYyd1/u88EvnlGkSqT5ELvJEKLeu6C9oT3KopQypWTrsEqulRuD
         0Jk/FoBCA2OyvUdWeZ0VwUMarltVxLfCa5LHoXcevvUkhDnBQxhhUpgIrUxpyQX4LMAu
         dygg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789030859; x=1789635659;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VXVlYl1gjLPwgKI1iO6doAk96CF1C9KclFcluRlvCtI=;
        b=h94vdVjoo/Gk0ufQq2Kk1Ndw8h75BznSxLUq8p43DRnBl7+RDi+rFmFUwhgRH6sbj4
         PqGbIAeznc0OWGFeJe9OqqyU1tQaOUSxn9QDM7qvLBW06iDx65TGysIZcG2GbrhsibFy
         yQ8rAHHSwWMSuMaepoj1ifyQAkDgVFz9bfXNoSaFDCdCccglGXqAuk/XFEozSLR5YnAy
         MMmLs+LWCAxwwgtQ+x64dLsp9WUVs8unugOUtWz9dJRriTtp6IDPGTmkhfIEj0Aejjo6
         BdcKjZHKgYc/7apwk9jNpyV1+XivF2XkCZCIpE5Mo/bT0mczzvOKNRCuSDrrU70TFppN
         PhRQ==
X-Forwarded-Encrypted: i=1; AKwUvBwYvS5FfBku8+aVSmA7MhijA7zgmStpelhh7es2T+j/A9Vzp6KWcpCXoWL1crjNfJ8E1S/FmPs=@vger.kernel.org
X-Gm-Message-State: AFuF++kzF236RuiTmXLKONE7U2b3zZpGDIYHVvMKETguCVIbutDlfKU/
	CxRXAveS8zqCLW7PRLj29JGd1YMXbH3Q6TzI8VgVrni5EJXTstQIUvdTJpSjoFCm7g==
X-Gm-Gg: AYBFou2bGHtp+Xws2pyR7hcjYbwZdF3BCnm+2bxN03cyEvQf+HxqmS8CglH2byCB6re
	RvBAFsE9lZDxTMSPA2V20hu/v0kmiUdWqDmxguEtzc+pp0iU1D4TpT8TG/DAZCbo9CGBiR+wGtK
	C5x2tUpqumnPa4lbGwj7802kgjl3wuLmQDKh1fIM/J6scG82ssi/Qq6RWfxU35GFUFBu+X++5Aj
	7LTpBMSzb7R7Ga/V92EQehr3errR1t88E9tYcZt7ngMmKFdjNhLCAHFHBwTcj5udXYEVLqXkSAE
	U3CUIW2pMwLDpDfQyJMB7Bi/aR3SY0BvZS08znmSjt0welL9g1bypdNolKXJO1pR+mYu10BAKIj
	sIiPjlOYbP/kuDZ4T8tRBRMI4TSjduccdpGt+olmxlEKTh8/Vg8yzneURjJOyLllPqgl2wOEUBT
	jgxaKDVl+C2UINoFtjGE5USa/MJ+wCT1KHBZ6FEAtpPY002tSbswmoojT7v/s86gU0uh9RmPArq
	Cacg8zdB/wbFuADAPE1skAVQ+iTGFu6LtSXPBQcvNpqYflKXWOOaB+DyiCl+GvUaLbbPfkx9fvM
	qIoVqxz87Fj2hlqEORbEq1l2psYga/gfhDAvUXr8tWRtIv13WR8dPi0FzXgU7bbOiPmFRs4vzKu
	zin1ffnv/VUX9CWqSnNFlEepwJQuMqv13DAY93kXnvReZ32QpBaNJOx99ZdGxYJ8J6pkHkUTrWX
	WHuW1Gww==
X-Received: by 2002:a17:907:3eaa:b0:c26:37fb:3461 with SMTP id a640c23a62f3a-c2637fb36b0mr1280186666b.46.1789030857283;
        Thu, 10 Sep 2026 02:00:57 -0700 (PDT)
Received: from Desktop.fritz.box ([217.26.235.87])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c293eaf1ae8sm156106766b.40.2026.09.10.02.00.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 02:00:56 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: pablo@netfilter.org,
	netfilter-devel@vger.kernel.org
Cc: kadlec@netfilter.org,
	fw@strlen.de,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	geldot@protonmail.com
Subject: [PATCH nf-next 4/4] selftests: netfilter: cover a TCP flow whose reply is never seen
Date: Thu, 10 Sep 2026 11:00:52 +0200
Message-ID: <20260910090052.2034970-5-julius@bairaktaris.de>
In-Reply-To: <20260910090052.2034970-1-julius@bairaktaris.de>
References: <20260910090052.2034970-1-julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add an arm to nft_flowtable.sh in which ns2 answers over a direct link,
so that nsr1 sees the original direction only. The forward hook counter
then has to stay far below the size of the transferred file, which only
happens if the flowtable takes the connection over.

Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
Assisted-by: Claude:claude-opus-5
---
 .../selftests/net/netfilter/nft_flowtable.sh  | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)

diff --git a/tools/testing/selftests/net/netfilter/nft_flowtable.sh b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
index 449c518bd947..516a544266f1 100755
--- a/tools/testing/selftests/net/netfilter/nft_flowtable.sh
+++ b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
@@ -516,6 +516,79 @@ else
 	ret=1
 fi
 
+# Asymmetric path test:
+# ns2 answers over a direct link, so nsr1 sees the original direction only.
+# Such a connection never becomes assured, but the flowtable is expected to
+# take over the direction that nsr1 does see.
+check_orig_offloaded()
+{
+	local what=$1
+
+	local orig
+	orig=$(ip netns exec "$nsr1" nft reset counter inet filter routed_orig | grep packets)
+	local orig_cnt=${orig#*bytes}
+
+	local fs
+	fs=$(du -sb "$nsin")
+	local max_orig=$(( ${fs%%/*} / 2 ))
+
+	# the flowtable takes over after the first few packets, so the forward
+	# hook must see a small fraction of the transferred file.
+	if [ "$orig_cnt" -gt "$max_orig" ];then
+		echo "FAIL: $what: original counter $orig_cnt exceeds expected value $max_orig" 1>&2
+		ret=1
+		return 1
+	fi
+
+	echo "PASS: $what"
+}
+
+test_asymmetric_path()
+{
+	ip link add name eth1 netns "$ns1" type veth peer name eth1 netns "$ns2"
+	ip -net "$ns1" addr add 10.0.9.99/24 dev eth1
+	ip -net "$ns2" addr add 10.0.9.98/24 dev eth1
+	ip -net "$ns1" addr add dead:9::99/64 dev eth1 nodad
+	ip -net "$ns2" addr add dead:9::98/64 dev eth1 nodad
+	ip -net "$ns1" link set eth1 up
+	ip -net "$ns2" link set eth1 up
+
+	# ns1 keeps sending through nsr1, ns2 answers on the direct link.
+	ip -net "$ns2" route add 10.0.1.99 via 10.0.9.99 dev eth1
+	ip -6 -net "$ns2" route add dead:1::99 via dead:9::99 dev eth1
+
+	ip netns exec "$ns1" sysctl -q net.ipv4.ip_no_pmtu_disc=0
+	ip netns exec "$ns2" sysctl -q net.ipv4.ip_no_pmtu_disc=0
+
+	ip netns exec "$nsr1" nft reset counters table inet filter >/dev/null
+
+	if test_tcp_forwarding "$ns1" "$ns2" 1 4 10.0.2.99 12345; then
+		check_orig_offloaded "flow offloaded for ns1/ns2 without reply"
+	else
+		echo "FAIL: flow offload for ns1/ns2 without reply" 1>&2
+		ip netns exec "$nsr1" nft list ruleset 1>&2
+		ret=1
+	fi
+
+	ip netns exec "$nsr1" nft reset counters table inet filter >/dev/null
+
+	if test_tcp_forwarding "$ns1" "$ns2" 1 6 "[dead:2::99]" 12345; then
+		check_orig_offloaded "IPv6 flow offloaded for ns1/ns2 without reply"
+	else
+		echo "FAIL: IPv6 flow offload for ns1/ns2 without reply" 1>&2
+		ip netns exec "$nsr1" nft list ruleset 1>&2
+		ret=1
+	fi
+
+	ip netns exec "$ns1" sysctl -q net.ipv4.ip_no_pmtu_disc=1
+	ip netns exec "$ns2" sysctl -q net.ipv4.ip_no_pmtu_disc=1
+
+	ip -net "$ns1" link del eth1
+	ip netns exec "$nsr1" nft reset counters table inet filter >/dev/null
+}
+
+test_asymmetric_path
+
 # delete default route, i.e. ns2 won't be able to reach ns1 and
 # will depend on ns1 being masqueraded in nsr1.
 # expect ns1 has nsr1 address.
-- 
2.53.0

