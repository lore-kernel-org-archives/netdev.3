Received: from mail-oi2-f12.google.com (mail-oi2-f12.google.com [74.125.231.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71F9B4E324C
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 19:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789673921; cv=none; b=ZGMNortZyoqF1X4tqmlG47FAa4Qxx4c3BBQ+/nwjR6sNW/lYuRtRBNZdeUgRNhO8IFe7eENbxPmRsKDqH3G1Dk1ht1gfRoUw7EAox6b0IaeTxYdTTMpRGRf4oNPZ/NF7dNUMaz1KQcJOiK9StM8IwGKmZSazoUSjFubxHNR5UDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789673921; c=relaxed/simple;
	bh=8WdFP1v7/Oa+dKIJynboqHB29B7wDjj6AhOsc16jvtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YP1yBPXfYaIkVOin7QARjQ++7giNMniA7vm2hDKgThtX6wAni4pP+AVZ20/yJWoDWp7JJM0EN4AybWfPyj9DzyFvBOaF3ZKNSK7lEcVEyVtL6JAB8OCekYT66Gitzskq8x22ulhhcwjo+BA0/PBdYIaHtpVEvX0e7PhU5xtoLLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=Qbvo7E6y; arc=none smtp.client-ip=74.125.231.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="Qbvo7E6y"
Received: by mail-oi2-f12.google.com with SMTP id 5614622812f47-4b37a39a42dso27832b6e.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 12:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789673918; x=1790278718; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=63GI428HLg6svgdiqmZ8ZkijlWs39+VHkT3kxwHKcMM=;
        b=Qbvo7E6yrNTNGp9RMmGVEJ7mvDowF6LmpBLTdg/Af0DUVt0dUM4pB+Zvi7oYIEKkkj
         9ZJRd4hysWWzsHcaa7oGnOqX0li215pPndCf5WSmLvgnCfFrKt2heTnm0Gmt7y4fjJbK
         68cFDBxe/LaRy9L72DNGc24bO5bM+aMsIsYz88BoSDaKk+v53Tsf3GJ8TuJv46W81GVo
         t2ok+lRuAzGILeMeEiN3soOORuA3ahERQ+NMwuaIqffl2EGScwugplwjk2YYWaWom469
         K8rkGSqpNGt0rNwyb3gbTpTpC3WWbSIudCGb3M4WWZPT01hVDRBrSYwmcm09UMmfRTl8
         cQVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789673918; x=1790278718;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=63GI428HLg6svgdiqmZ8ZkijlWs39+VHkT3kxwHKcMM=;
        b=slvQdvEqFY7or5vXBX98l1osiSmt73H2BQPQBBwfLY4q3U3TBPtvL5rxSlEZ1t5oL4
         cLonOll8G8uXKlL2J4TDEYLj7gQEM0cK1tcxntHZV2Nmj8voa/a/Z1MPu+m7aFTKjBpz
         YBAagPJWFLymlU2nndzhz727wkAhuEwTUZjOk7UPJJ1R3KltjWSuhUA9aenXwt9EfOIj
         +8b+3+3tKqp2poc1Zk3084U5HQvRwsG6kafBkW3d1S3n+Zjvqqlqr6KQwlol0hrnXtEH
         24Fj4qjSDYBoct0TKZWe5Dq5rBBIxee2VIR7j6RhkWAP9xAzWwbcJYH8BLAeSQUGlpzW
         R4+w==
X-Gm-Message-State: AFuF++nvQSH8X/X6OVA2dfOphmHUPYmhZiIv3YqfIJeBCEweEBQN3IgT
	qU08LWhMyIMjonDjHFTCzBgz0V+hW8gvovP/USkKdBCfKy9ndqnT0/cU15qOq0Krx76Br0HfRVe
	REUmh3vMBzQ==
X-Gm-Gg: AYBFou3r60+h4/g3SsulG80lSorN98h8TRrM9XcjYHXgLjnHlhWavJT/qx0m0B1nAIV
	d+yR4Y4qwVMW3KZwCYtvjRPu+mpDzbWuXfY6Bs20yw1HIIuVKvVNX42l0s8ZdJpPuc/JM6j42aZ
	0iZ4viVtm4QxB9dLHSflSrlM63GOkVpYCv/ouDMx2if+5xB0eobCnANTZgE9LApBjaOOuwUjewt
	mRfdCYLFD9O2MEKvJlTBqx74za3zvEkOBFSgZHgB44q5/E4LVoDb+zSJwzYPfRe+bFWIyH/UHrv
	gb1Io6YXQYLZC9rVMeP7UQNunU1Veea2uE3UnSklji7xbJ63lddyW0aPpt2KjH/Dp3asPNh7i9m
	7a1H7EoLmYAmnF2CwfFbZXtMJMr5xnpqdt91IMWfyGYXC4uE29DDVHAoXYy5CwayzsHdJks6pkr
	jdZAnLlOa4VXsdwakaEbuQ/4bjmuTAuqr5yHRU9ltVXV/cLb/yHlz40HrNtZ48
X-Received: by 2002:a05:6808:1822:b0:4cb:26a3:a092 with SMTP id 5614622812f47-4cd00f722f7mr143159b6e.18.1789673917758;
        Thu, 17 Sep 2026 12:38:37 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:bf21:2632::3ce:23])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4cb6d267495sm3576435b6e.12.2026.09.17.12.38.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 12:38:36 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
Date: Thu, 17 Sep 2026 14:38:24 -0500
Subject: [PATCH net-next v3 3/3] selftests: net: cover IPv6 uncached route
 device mismatch
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260917-hash-bucket-route-lists-v3-3-30493a37b6eb@cloudflare.com>
References: <20260917-hash-bucket-route-lists-v3-0-30493a37b6eb@cloudflare.com>
In-Reply-To: <20260917-hash-bucket-route-lists-v3-0-30493a37b6eb@cloudflare.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com, 
 Chris J Arges <carges@cloudflare.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1789673908; l=2338;
 i=carges@cloudflare.com; h=from:subject:message-id;
 bh=8WdFP1v7/Oa+dKIJynboqHB29B7wDjj6AhOsc16jvtI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgaxY1IIT5oTohBZJmhnVgJo2HsM7Sv
 9I0LdJCgpeGX6gAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QO1RwsZDwM/ssWO1I1sKt1WfupSScxRHMASpKykF6ut24vhcFE8p3yTn1fxnRNYklXMR/RihLXH
 dvewFKZS+iQc=
X-Developer-Key: i=carges@cloudflare.com; a=openssh;
 fpr=SHA256:Cun99EBiH0EV7wvmfTBF9eDrld2NJx+aD4ScWZ45Q5M

Local IPv6 routes through a VRF can use the VRF as dst.dev while
retaining the VRF member interface in rt6i_idev. Exercise device
teardown while such uncached routes are retained by a delayed qdisc.

Reuse the existing VRF topology and msg_zerocopy raw-header sender, and
verify route creation, qdisc retention, and prompt interface deletion.

Signed-off-by: Chris J Arges <carges@cloudflare.com>
---
 tools/testing/selftests/net/vrf-xfrm-tests.sh | 35 +++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/tools/testing/selftests/net/vrf-xfrm-tests.sh b/tools/testing/selftests/net/vrf-xfrm-tests.sh
index b64dd891699d..4f409d135a99 100755
--- a/tools/testing/selftests/net/vrf-xfrm-tests.sh
+++ b/tools/testing/selftests/net/vrf-xfrm-tests.sh
@@ -385,6 +385,37 @@ run_tests()
 	cleanup_xfrm_dev
 }
 
+test_ipv6_uncached_mismatch()
+{
+	local sender_pid
+	local backlog
+	local rc
+
+	# A local route through a VRF uses the VRF as dst.dev while retaining
+	# the VRF member interface in rt6i_idev. Raw header sends create uncached
+	# routes, and netem keeps them referenced while the interface is deleted.
+	run_cmd_host1 tc qdisc replace dev ${VRF} root netem limit 1 delay 10s
+	ip -6 -netns "$host1" route add local ${HOST1_6}/128 dev eth0
+	ip netns exec "$host1" ./msg_zerocopy -6 \
+		-S ${HOST1_6} -D ${HOST1_6} -s 1200 -t 0 raw_hdrincl \
+		>/dev/null 2>&1 &
+	sender_pid=$!
+	wait "$sender_pid"
+	rc=$?
+	log_test $rc 0 "Create uncached IPv6 routes with mismatched devices"
+	[ $rc -ne 0 ] && return
+
+	backlog=$(ip netns exec "$host1" tc -s qdisc show dev ${VRF})
+	if ! echo "$backlog" | grep -Eq 'backlog .* [1-9][0-9]*p'; then
+		log_test 1 0 "Retain uncached IPv6 routes in VRF qdisc"
+		return
+	fi
+	log_test 0 0 "Retain uncached IPv6 routes in VRF qdisc"
+
+	run_cmd_host1 timeout 2 ip link del eth0
+	log_test $? 0 "Flush uncached IPv6 routes with mismatched devices"
+}
+
 ################################################################################
 # usage
 
@@ -425,6 +456,10 @@ echo
 echo "netem qdisc on VRF device"
 run_tests
 
+echo
+echo "Uncached IPv6 route with mismatched devices"
+test_ipv6_uncached_mismatch
+
 printf "\nTests passed: %3d\n" ${nsuccess}
 printf "Tests failed: %3d\n"   ${nfail}
 

-- 
2.43.0

