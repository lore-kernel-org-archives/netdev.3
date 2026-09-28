Received: from mail-wm1-f66.google.com (mail-wm1-f66.google.com [209.85.128.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 833884F96C3
	for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 20:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790627004; cv=none; b=ZwOOsFm8hiECdq2EzbrPKvY2RAmsy6mnf4Qk32QN61zQ0nkwKnt1sLfm9WlriJ+m9L/FeVnR0mRLnG0BTIjv0ySkc7XKuWEF26ZlBGSLdMCWgW2rOEZQAF02vgobMrbQ8Ulhg2VvWel3grZee2szPa1Pef8TDjXY7i0xF9cTuFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790627004; c=relaxed/simple;
	bh=3qVnGX5rRaJCRwlcgQzeEp0Kkeac6bWfTm59GQvGhnk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ByaPoQjQOM5q0MzPFkblkhGT5g2qOFZq4zQ/sdKDIeIFtRTvXOL9G/1PPsx3VtuDVqCMx8UNbfAmzP4uocXX12qcMqa9HPDomb7TDw1qERq+VsRmZrgDsufgfTXuZnXuxvDPHXHwpqrkq9lNB2UtTZ7Bp1ajADfugtoQx2AXpfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net; spf=pass smtp.mailfrom=blockcast.net; dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b=PhIE8MLr; arc=none smtp.client-ip=209.85.128.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=blockcast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=blockcast.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blockcast.net header.i=@blockcast.net header.b="PhIE8MLr"
Received: by mail-wm1-f66.google.com with SMTP id 5b1f17b1804b1-49e73611928so2707775e9.1
        for <netdev@vger.kernel.org>; Mon, 28 Sep 2026 13:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blockcast.net; s=google; t=1790627001; x=1791231801; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z1fkwGoumcXsELwjWXc8Y0RIsf/dT14wb+aaMLvRjLc=;
        b=PhIE8MLrmekDU/QOE4bV2Q8L0OykDqthq2V4TYqajzgS+tG8DAcptQogKDQNqzTmwu
         ksW+GYFNw8/npEtnDVZ8JK0DLjAPhhNftzhdhO/SR1xD8sa3oJpcV4RuDi2bS/ugDSvi
         VvrljkM0bxCmK0UD5CjKGLgWO8avZCTBTXGERvhUkic82Mf0e4cqU8nM1jjPCw4FdVc0
         BLOX6Ifb3FFhYQztC7Y+aKd3qEzldayrdhbF4BRv0jKOo0gBmBfSsZmado+R/Kqk41Bj
         5DEekzDXEFhTVo9QyzR9AAU92SE1+DeNaC5knHLbwMocaw5SXKtXrVs0+a3KXT6IIGHb
         h8Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790627001; x=1791231801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Z1fkwGoumcXsELwjWXc8Y0RIsf/dT14wb+aaMLvRjLc=;
        b=uWKuAUnlC1YL9d6QuP0BxSn6gKEG43qPzAWUYjTJfV/oNkeu0gGtmQ2hR2skHN/ggD
         2NYkG7WjUEdSkbHgaB37NstALFjuup+r0Tc9YecOFw8NtK7GkKFdQa0DY+YqGMgvXs94
         S1vfXRev7pG7bhbnmx3zrFB1Rhu61+LmSPFDCjn/3fikI3Zmch7vQq8op+lwjDU3YWSR
         6IoK06hIjIk1WLW+WeFGMRol2SwTDx4NC2fjwRMZ+GY4Aepe0WSIFFN1PApvrBGF6mHn
         hV478Dt/XN5CFeJyaqT6bDs5HWj9cdbxhRtz+xHsyU3q6+Y8yiyyG/5XzqTl3nrk6i6s
         4MIQ==
X-Forwarded-Encrypted: i=1; AKwUvBxi/k1OSiCN+2Tvbw+Igh1E4bIHXS152OTRBl27Sshz3nc76vMKnDJ/l7HYhGxgRiLQPW2yYBw=@vger.kernel.org
X-Gm-Message-State: AFuF++n8tibMABKXvK4fmzDyBW0diU0VqBS35Ct8EPK12oh6pM2v7I+1
	OPbnyxhG29NmpEtageyBTft6bg94HheCwo1ulirUB/qqui3ezT1xdowcsKTaCZYJnFA=
X-Gm-Gg: AYBFou1jHTr64gjiWN/D5GCARx/+C3knCwYiGDhZ22B4dvbhqWFeeaX6tZIFUHLDmox
	b3rMOP6agdfYWZDY2OYXO/iEYlLlScybN1dFO6GyqOSgDgFHUb136+bID7gVsB+igHVvFwVcO4v
	9KlMxYqQzxl/T72fUsFo70ubzHYX8WMygjet8wYqDDH5oPTdudCiSM/LI9mV2kuTqdPB9kVm6Ws
	xe24hWQCmVhHUEGP8/+jvE32OfRLnwEluvvgXqb6OpOk0mYCFCUEvV/hIoEJgei5/IhzL+RAb0/
	7+qC/mLA6nUxzGaHVTq8kYg2+E7rDBVLdH/gVpEuQT2Kk7uQa7lvNwGpOheyBmGUxDbFOIqeKqQ
	qvOXdSl2Wwt3HWX7suxa7dS//yR2D0fLsM3bIy20PNxna42fmFeH3H6A0rz/1/SX5xDLwaUO+HG
	5igfo2YG3JhhNFgsfycJ7UJuT6AvsyxCXthoScazPvgGCWubkWuaaii38ZHb2UsW5gcRLbgmO36
	/Ax4bFoXo7yXpUUofrbW4zDpH12tIATx/DQICIOzoU87seZ9Qfa42H5vzxcQx6pizYAL77hPHW6
	UmQ8TfbMRswb
X-Received: by 2002:a05:600c:6c41:b0:49d:28fc:d6a0 with SMTP id 5b1f17b1804b1-4a00d7b2adbmr4612875e9.18.1790627000712;
        Mon, 28 Sep 2026 13:23:20 -0700 (PDT)
Received: from localhost.localdomain ([197.51.38.79])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4887a30bcdbsm29620500f8f.2.2026.09.28.13.23.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 28 Sep 2026 13:23:19 -0700 (PDT)
From: Omar Ramadan <omar@blockcast.net>
To: Taehee Yoo <ap420073@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	netdev@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	Xiang Mei <xmei5@asu.edu>,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	Cen Zhang <cenzhang@linux.microsoft.com>
Subject: [PATCH net v4 2/2] selftests: net: amt: check that the relay's queries bypass the amt device
Date: Mon, 28 Sep 2026 23:23:12 +0300
Message-ID: <20260928202312.74574-3-omar@blockcast.net>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260928202312.74574-1-omar@blockcast.net>
References: <20260928202312.74574-1-omar@blockcast.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The relay used to hand its General Queries to dev_queue_xmit() on the
amt device, where a query could wait in a qdisc and outlive the tunnel
it pointed to. The previous patch sends them directly from the receive
path instead.

Count the IGMP and MLD queries that leave the relay through amtr with
tc flower filters on its egress, installed before the gateway comes
up, and check that there are none. The forwarding tests before it
already show that the gateway received its queries, since it cannot
join without one.

Without the previous patch the new test fails (one run counted 7 IGMP
and 6 MLD queries); with it, all of amt.sh passes.

Signed-off-by: Omar Ramadan <omar@blockcast.net>
---
 tools/testing/selftests/net/amt.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/tools/testing/selftests/net/amt.sh b/tools/testing/selftests/net/amt.sh
index 663744305..d13b20ccc 100755
--- a/tools/testing/selftests/net/amt.sh
+++ b/tools/testing/selftests/net/amt.sh
@@ -150,6 +150,13 @@ setup_interface()
 	ip netns exec "${RELAY}" ip a a 10.0.0.2/24 dev relay_gw
 	ip netns exec "${RELAY}" ip link add amtr type amt mode relay \
 		local 10.0.0.2 dev relay_gw relay_port 2268 max_tunnels 4
+	# Count the IGMP and MLD queries that leave the relay through its own
+	# amt device; test_query_egress expects none.
+	ip netns exec "${RELAY}" tc qdisc add dev amtr clsact
+	ip netns exec "${RELAY}" tc filter add dev amtr egress pref 1 \
+		protocol ip flower ip_proto 0x2 action pass
+	ip netns exec "${RELAY}" tc filter add dev amtr egress pref 2 \
+		protocol ipv6 flower ip_proto icmpv6 type 130 action pass
 	ip netns exec "${RELAY}" ip a a 172.17.0.1/24 dev relay_src
 	ip netns exec "${RELAY}" ip a a 2001:db8:3::1/64 dev relay_src
 	ip netns exec "${SOURCE}" ip a a 172.17.0.2/24 dev src_relay
@@ -246,6 +253,27 @@ test_ipv6_forward()
 	fi
 }
 
+# The relay sends its General Queries straight from the receive path, in
+# the same context that found the tunnel. A query queued on the amt device
+# instead could outlive the tunnel it was built for. The forwarding tests
+# above show that the gateway got its queries.
+test_query_egress()
+{
+	local n4 n6
+
+	n4=$(ip netns exec "${RELAY}" tc -s -j filter show dev amtr egress \
+		pref 1 | jq '[.[].options.actions[0].stats.packets // empty] | add // 0')
+	n6=$(ip netns exec "${RELAY}" tc -s -j filter show dev amtr egress \
+		pref 2 | jq '[.[].options.actions[0].stats.packets // empty] | add // 0')
+	if [ "$n4" -eq 0 ] && [ "$n6" -eq 0 ]; then
+		printf "TEST: %-60s  [ OK ]\n" "amt relay queries bypass the amt device"
+	else
+		printf "TEST: %-60s  [FAIL]\n" "amt relay queries bypass the amt device"
+		echo "IGMP queries on amtr egress: $n4, MLD queries: $n6" >&2
+		ERR=1
+	fi
+}
+
 send_mcast4()
 {
 	sleep 5
@@ -287,6 +315,7 @@ wait $pid || err=$?
 if [ $err -eq 1 ]; then
 	ERR=1
 fi
+test_query_egress
 printf "TEST: %-50s" "IPv4 amt traffic forwarding torture"
 send_mcast_torture4
 printf "  [ OK ]\n"
-- 
2.47.3

