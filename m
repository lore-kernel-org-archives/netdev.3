Received: from mail-ej2-f43.google.com (mail-ej2-f43.google.com [74.125.228.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8632B3D954E
	for <netdev@vger.kernel.org>; Sun,  4 Oct 2026 17:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791134190; cv=none; b=iAinRLIJYf5DvxzwZ5MkhUgtVHRdHZdK1PezCM5iFB05bjFVZeWU3QeMsMpOJtnakGWUdLJu8uHIh/g+TUOc/tH8omHdMMWig/PbWa4Ul30IOkBJKaCktliRcYTJM81qA/p2K74z/FEefeCtD9cTVlnYttAQ1OxFtObd+fLRS5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791134190; c=relaxed/simple;
	bh=S806Z0hpfXTXnNB+NFCPkJEG1mGTEr4a/1c81/36Cfc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOqEbwTdRcQmN4TUSUIiSdRr4gwFaendWEPDqnUikIppVLIi4RB7wMWUEndSN5nMdGr2R6D1tYGgiN8kkJ8WVv5scYiuAtkVNac3GvMjiebHr9jf1gf91QTZTguUrhLGPurOu3udMKhXrotkJUqZ26PTnCnN1OdaoJw8uCtgmYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de; spf=pass smtp.mailfrom=bairaktaris.de; dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b=aK/CG+Mh; arc=none smtp.client-ip=74.125.228.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bairaktaris.de header.i=@bairaktaris.de header.b="aK/CG+Mh"
Received: by mail-ej2-f43.google.com with SMTP id a640c23a62f3a-c2a1f611461so77679866b.1
        for <netdev@vger.kernel.org>; Sun, 04 Oct 2026 10:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1791134183; x=1791738983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z21Sm0vXyjYwz54boCuRf17DcAnvOs66BHPm2naaN0E=;
        b=aK/CG+MhHaFWHYi85wq2FUZpBY9c0iUdWZO9qj7XymE5yug2YSsjRm8A5r0sLNHE+A
         KMdg9vlM4qJoOW44GPdwBEXaB7qn4rBQtMqQbvgBTUucs/iI2ochx6YjqZ3S0fK35E+X
         /hpuE3UoBR9SdX7np1soJzgunHug4Hxskyql3yPvttx2L1veHeAfBf0FrWBl2SCwQjkE
         dq/gTzamV3GYH4Amv1diO2bqrWtY9uJp8RL8+IKXgjfVgejcYH6IGIxhuLCP3UI8DyJE
         4vMN4EggZBRsy+C3p4hWcFdvJiuWSA4W9v7ukNRVl0THHRBIhpOpXoL+z9tUDBDMgXBE
         YsQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791134183; x=1791738983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z21Sm0vXyjYwz54boCuRf17DcAnvOs66BHPm2naaN0E=;
        b=l+T0Nbh9pO1EAwt7ms7JvrPaLbMszLLybKWmB4gZJVCPn2lgHd3wETraCoVTYdxPUM
         egolaCShC7kurXBtO9CH/SIJ9r0QF+4cn0ODgTQ0rUjfJNf5DAFSj1e346ZF848SwHcx
         vP4qihUQFkncmIqbv7xeIU9LcvCxzb6zS7HZxm9OWL9kXCuNGBFb8/gvdx5lLD9TiDpM
         dSMfpjPAQFmzRjmOnjn9HNB/sVYlKq8z6Twx6ebjexluyWFqBqoE8F13tq4EJtEc20PV
         Co3/heZMx4BjsvNsbDby8Lm/aXpmsggtLyVViFvPU1kvYRFRkOyZwCuVdLeZ0Bp1i3PY
         5MGQ==
X-Forwarded-Encrypted: i=1; AKwUvBzbhA62jmNHqnDPiZPe6MmH4N1mHL1JIABtT+UweyKN6aww66kUE3pYKjFsaEePfhd/rg4KAo0=@vger.kernel.org
X-Gm-Message-State: AFuF++kDcHX7AOr4T3+I75HnLcajXAUzmlz5pWm46Ic+FucHcbJjmRlx
	o4nsMw6xsfDu43EZADEwoiHxZJrQBSHcpwHYjQydyZVZGGG9zsin6/GFeO4kunxEDg==
X-Gm-Gg: AYBFou0hEkVgz2tJNLXxp3t8Ifh2LFAJFsg7TWnTtR95rYpvWjfZ1fBD03gITzrpoks
	6jErSIelK/CrT8EobftvdoZzEQvtozJmh+JwGnXbjjNG3rZT+p9LkVlsPnsCfh9pWB0LpIq7/xh
	XszxB1KSldXRJmmiozvwH0uD5VOxd78xzxJNI2s6nH0pUcsJ0CRSeS2MTIYjVDsg6ykS+K+qT4v
	JfYy6pUykiQweJTGd9deeARRzxHKvC5zWGhVR8NKyLA2p/AQ61Vp4GTki99NaJgvk2hDl9bphMF
	ezAT/JUBfgykgRb+czPyi5oGaqTAtkyOFkQlTYr2QF/d3BKvc0C97Ye7U30YuCgR0XO+zhZ45Yx
	2domJTsKQV9PjfENvboEzX5mFuSIPx6zfnqUm6s6sOZ8tyz0iRYshptS1Z21wSEjxIIBE73c2kS
	zQi3OLX92JB8ZXwkXYClEXA4+ZfC19DkAP6ifp16Doc0HdoZlrZd/hgbuNu6PRRbbOykC+5+kh+
	+42omiLEGq5TKvnJVeFsx85ltwoXB4b1t6KLFKiKoNhLjjMm/yXOWSgH2grN+/CN9t+kASI7Yx/
	3ZQ8Vvj6IFxDQlVsewz1CHVy2qgJhdwv63ACg2+GOxi3Z/d437TbccPgB1eyYLkORcpmM1UuTpU
	HDftp3239ByjZVHj48ngU0ndkDUmd55fFPHDronmIJLYcZwafWmfDKmJqg5WD/pBe+OpZOk9Q7j
	5hw4bgclg0DufdyAo1IEEEoiWYMf7HnlG/gw==
X-Received: by 2002:a17:906:dc90:b0:c2d:d4dd:8b5 with SMTP id a640c23a62f3a-c2e4ad60fdamr781095366b.19.1791134183248;
        Sun, 04 Oct 2026 10:16:23 -0700 (PDT)
Received: from Desktop (pd9513667.dip0.t-ipconnect.de. [217.81.54.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2e4cd278cesm314885266b.37.2026.10.04.10.16.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Oct 2026 10:16:22 -0700 (PDT)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: netfilter-devel@vger.kernel.org
Cc: pablo@netfilter.org,
	fw@strlen.de,
	phil@nwl.cc,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew+netdev@lunn.ch,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	nbd@nbd.name
Subject: [PATCH nf-next 3/3] selftests: netfilter: nft_flowtable.sh: check upper device counters
Date: Sun,  4 Oct 2026 19:16:16 +0200
Message-ID: <20261004171616.3544880-4-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261004171616.3544880-1-julius@bairaktaris.de>
References: <20261004171616.3544880-1-julius@bairaktaris.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The bridge and tunnel tests forward through devices above the flowtable
device: br0, the tunnels, and the VLAN devices under them. Each test
sends the file in both directions, twice for IPv4 (masquerade and dnat)
and once for IPv6, so check that these devices count between n and n + 1
times the file size on rx and on tx.

Assisted-by: Claude:claude-fable-5-1
Signed-off-by: Julius Bairaktaris <julius@bairaktaris.de>
---
 .../selftests/net/netfilter/nft_flowtable.sh  | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)

diff --git a/tools/testing/selftests/net/netfilter/nft_flowtable.sh b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
index 449c518bd947..e89f86916f4e 100755
--- a/tools/testing/selftests/net/netfilter/nft_flowtable.sh
+++ b/tools/testing/selftests/net/netfilter/nft_flowtable.sh
@@ -272,6 +272,43 @@ check_counters()
 	fi
 }
 
+dev_bytes()
+{
+	local ns=$1
+	local dev=$2
+
+	ip -net "$ns" -s link show dev "$dev" | \
+		awk '/RX:/ { getline; rx = $1 } /TX:/ { getline; tx = $1 } END { print rx, tx }'
+}
+
+# Fails if the fast path does not update the device counters.
+check_dev_bytes()
+{
+	local what=$1
+	local ns=$2
+	local dev=$3
+	local rx0=$4
+	local tx0=$5
+	local n=${6:-2}
+	local min=$((filesize * n))
+	local max=$((filesize * (n + 1)))
+	local rx tx
+
+	read -r rx tx < <(dev_bytes "$ns" "$dev")
+	rx=$((rx - rx0))
+	tx=$((tx - tx0))
+
+	if [ "$rx" -lt "$min" ] || [ "$tx" -lt "$min" ] ||
+	   [ "$rx" -gt "$max" ] || [ "$tx" -gt "$max" ]; then
+		echo "FAIL: $what: $dev counted rx $rx tx $tx bytes," \
+		     "expected $min to $max" 1>&2
+		ret=1
+		return
+	fi
+
+	echo "PASS: $what"
+}
+
 check_dscp()
 {
 	local what=$1
@@ -626,12 +663,18 @@ ip netns exec "$nsr1" nft -a insert rule inet filter forward 'meta oif tun6 acce
 ip netns exec "$nsr1" nft -a insert rule inet filter forward \
 	'meta oif "veth0" tcp sport 12345 ct mark set 1 flow add @f1 counter name routed_repl accept'
 
+read -r tun_rx tun_tx < <(dev_bytes "$nsr1" tun0)
+
 if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 "IPIP tunnel"; then
 	echo "FAIL: flow offload for ns1/ns2 with IPIP tunnel" 1>&2
 	ip netns exec "$nsr1" nft list ruleset
 	ret=1
 fi
 
+check_dev_bytes "IPIP tunnel counters" "$nsr1" tun0 "$tun_rx" "$tun_tx"
+
+read -r tun_rx tun_tx < <(dev_bytes "$nsr1" tun6)
+
 if test_tcp_forwarding "$ns1" "$ns2" 1 6 "[dead:2::99]" 12345; then
 	check_counters "flow offload for ns1/ns2 IP6IP6 tunnel"
 else
@@ -640,6 +683,8 @@ else
 	ret=1
 fi
 
+check_dev_bytes "IP6IP6 tunnel counters" "$nsr1" tun6 "$tun_rx" "$tun_tx" 1
+
 # Create vlan tagged devices for IPIP traffic.
 ip -net "$nsr1" link add link veth1 name veth1.10 type vlan id 10
 ip -net "$nsr1" link set veth1.10 up
@@ -686,12 +731,21 @@ ip -net "$nsr2" addr add fee1:5::2/64 dev tun6.10 nodad
 ip -6 -net "$nsr2" route delete default
 ip -6 -net "$nsr2" route add default via fee1:5::1
 
+read -r tun_rx tun_tx < <(dev_bytes "$nsr1" tun0.10)
+read -r vlan_rx vlan_tx < <(dev_bytes "$nsr1" veth1.10)
+
 if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 "IPIP tunnel over vlan"; then
 	echo "FAIL: flow offload for ns1/ns2 with IPIP tunnel over vlan" 1>&2
 	ip netns exec "$nsr1" nft list ruleset
 	ret=1
 fi
 
+check_dev_bytes "IPIP tunnel counters over VLAN" "$nsr1" tun0.10 "$tun_rx" "$tun_tx"
+check_dev_bytes "VLAN counters under IPIP tunnel" "$nsr1" veth1.10 "$vlan_rx" "$vlan_tx"
+
+read -r tun_rx tun_tx < <(dev_bytes "$nsr1" tun6.10)
+read -r vlan_rx vlan_tx < <(dev_bytes "$nsr1" veth1.10)
+
 if test_tcp_forwarding "$ns1" "$ns2" 1 6 "[dead:2::99]" 12345; then
 	check_counters "flow offload for ns1/ns2 IP6IP6 tunnel over vlan"
 else
@@ -700,6 +754,9 @@ else
 	ret=1
 fi
 
+check_dev_bytes "IP6IP6 tunnel counters over VLAN" "$nsr1" tun6.10 "$tun_rx" "$tun_tx" 1
+check_dev_bytes "VLAN counters under IP6IP6 tunnel" "$nsr1" veth1.10 "$vlan_rx" "$vlan_tx" 1
+
 # Restore the previous configuration
 ip -net "$nsr1" route change default via 192.168.10.2
 ip -net "$nsr2" route change default via 192.168.10.1
@@ -740,12 +797,16 @@ table ip nat {
 }
 EOF
 
+read -r br_rx br_tx < <(dev_bytes "$nsr1" br0)
+
 if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 "on bridge"; then
 	echo "FAIL: flow offload for ns1/ns2 with bridge NAT" 1>&2
 	ip netns exec "$nsr1" nft list ruleset
 	ret=1
 fi
 
+check_dev_bytes "bridge counters" "$nsr1" br0 "$br_rx" "$br_tx"
+
 if ip -net "$nsr1" link show tun0 > /dev/null 2>&1 &&
    ip -net "$nsr2" link show tun0 > /dev/null 2>&1; then
 	ip -net "$nsr1" route change default via 192.168.100.2
@@ -819,12 +880,18 @@ ip -net "$ns1" addr add 10.0.1.99/24 dev eth0.10
 ip -net "$ns1" route add default via 10.0.1.1
 ip -net "$ns1" addr add dead:1::99/64 dev eth0.10 nodad
 
+read -r br_rx br_tx < <(dev_bytes "$nsr1" br0)
+read -r vlan_rx vlan_tx < <(dev_bytes "$nsr1" veth0.10)
+
 if ! test_tcp_forwarding_nat "$ns1" "$ns2" 1 "bridge and VLAN"; then
 	echo "FAIL: flow offload for ns1/ns2 with bridge NAT and VLAN" 1>&2
 	ip netns exec "$nsr1" nft list ruleset
 	ret=1
 fi
 
+check_dev_bytes "bridge counters with VLAN" "$nsr1" br0 "$br_rx" "$br_tx"
+check_dev_bytes "VLAN counters under bridge" "$nsr1" veth0.10 "$vlan_rx" "$vlan_tx"
+
 # restore test topology (remove bridge and VLAN)
 ip -net "$nsr1" link set veth0 nomaster
 ip -net "$nsr1" link set veth0 down
-- 
2.53.0

