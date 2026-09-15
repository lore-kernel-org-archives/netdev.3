Received: from mail-oo2-f42.google.com (mail-oo2-f42.google.com [74.125.231.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EAA3D0929
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 02:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789437842; cv=none; b=eVnVtkKY6qNyvWRvSi46qaU3zPij6Y5z0hdBmaNZ/A0kWSm+YU26dOS8+PxsbOlNo+K6v+5Ej4Pm706JkCLSTVnSKySV26+zlt3DpNsjbFxq1hnS3p9jWCQTkCDAqNIbIxpsf7FM9eDkvf9LnqkslP3oNXp9IFzEvyIalWsEdMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789437842; c=relaxed/simple;
	bh=8WdFP1v7/Oa+dKIJynboqHB29B7wDjj6AhOsc16jvtI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Vd1u+9QXIJXUCewJZqaf4O3IKDtffnJNp9AnNHM9LwTpcV6otHZGcbQijVLZqwugJwHs8dHEiz2PSz49k2WuMzjM31VGPyG3RkMpPS4o4Hop52u8aF7INw3EmUJqNCXjROyj9t+EpwHSKqqe1Y7HtoKjE8caq6y9KlR+aB702IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=J5+fb0gC; arc=none smtp.client-ip=74.125.231.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="J5+fb0gC"
Received: by mail-oo2-f42.google.com with SMTP id 46e09a7af769-7f4f0d37f9dso1262669a34.1
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 19:04:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1789437840; x=1790042640; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=63GI428HLg6svgdiqmZ8ZkijlWs39+VHkT3kxwHKcMM=;
        b=J5+fb0gCkZb0yw0F/HqBYlxu/KDjBUXSTJOlo5Q7DqTcEfIsffH98AKU+KJJNBkcb2
         xrDlOqZL1htnWA9dMZj+AGA9e/judpS9fXb5XCzs2NwADdDKuPhM1fv6w4mJGbwIYCmP
         Ue8jurfIsxXTRccbe8oG8ByQggVY2m6NdBlrgZhcVEDu3/mhpbVOS/yws7PGBUK6IhNJ
         FnqXfLrWBwvgeFIIRStjL0aAWSTZSMeuJKJzFiuz8plnrhqyyQWjkboj190yLoXREzDw
         qQO7pY5V1KOddeEbPTPeHhu0FnrdibWz/54CLCp/G06LgmY2cUDoFWOm4K+wHGndFiI7
         Pxhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789437840; x=1790042640;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=63GI428HLg6svgdiqmZ8ZkijlWs39+VHkT3kxwHKcMM=;
        b=BVRGhAOznXimmkv/unThJ3ErMfv9H2xinwBNSASUS8ECgYshOGPa7hXiwqRSUrn4/W
         vPhUC0JA3ii8S2ohY2FsP+VDTdf+CfXl5a7CijuPJ2Ak93dr6yL/XlLuG1t2JxqTnJG4
         /B8JE59j4NwxHQt4CH5YLYji63WHNeyIvqPfE2K7CGWEi725VMhBWz/tao5ZRZCLvVKw
         4gvLXqGatQQGh8b4x8Zn0BVOe7hAQhRXqcqCJMV4o6Fd2+LczbpRN1fI/nCjSLRgbXOO
         WBk59nKvx5ZA7QTTHK7rIiLx77KsO93Kv3ziXGxi6Gn0nxyV52+xpKrXFK8vced4p9K0
         L6gA==
X-Gm-Message-State: AFuF++kdWl2d65VwXVl0itvrTYONocNO725T68k8TaeytXikl3RcATF4
	E+vjO9blyZV5jX8cVAyi0cy5yrqut4SvuOICJVGO2o8q7wlSc7aZ9IlJnf/44SWvfOY=
X-Gm-Gg: AYBFou0Apvm3MKVsp8FGopJNwND+27xzNjatD2I79o/iwyCZlrcqxc/+SGp13PD2H76
	6v46etu96q5t7DMaToiD32DeDRpdRUrtWupFYqZVI5gprXmjbrSgFg43z7zUZQBIGmpiE+/7uJo
	gjulgZOaPkUlqLxKqqmOZfV4NFg/CnmFZsZB/+C58mT0wpV5frfz1AhJhjFvIFo+FgZJPrbYBLb
	S3WDCjXHOY80mKTGgjGkuLuBeHJnG3eyhLs0JAeCGUgqsvvpUeLWRYA0lDGnROhra4giKrNjnHU
	AOgkLoA+D8mA+6Hkgz8gINB5E11thT5NfIekVHiXPd16RgF4dCWTx8PATQd76pIXx0w8TRwHbx/
	0uc70kCi+zAgGE2+1A046QsTWrcTDRm6yA7X743XvbnzfvEhhwHM2N9W9rOmEeINnhOG9Pg9I5R
	2C15znrgg7LBqF6Wlog3pLvMu4scHsjbMvCwOZRYEWqeSw08GdUrxcVydBNUnA
X-Received: by 2002:a05:6830:2b25:b0:7f4:bd7e:1394 with SMTP id 46e09a7af769-8089709640emr3666718a34.1.1789437839686;
        Mon, 14 Sep 2026 19:03:59 -0700 (PDT)
Received: from [127.0.1.1] ([2a09:bac6:bf21:2e46::49c:4c])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-804de582afcsm10795696a34.16.2026.09.14.19.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 19:03:58 -0700 (PDT)
From: Chris J Arges <carges@cloudflare.com>
Date: Mon, 14 Sep 2026 21:03:37 -0500
Subject: [PATCH net-next v2 3/3] selftests: net: cover IPv6 uncached route
 device mismatch
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-hash-bucket-route-lists-v2-3-29f6297d8a5a@cloudflare.com>
References: <20260914-hash-bucket-route-lists-v2-0-29f6297d8a5a@cloudflare.com>
In-Reply-To: <20260914-hash-bucket-route-lists-v2-0-29f6297d8a5a@cloudflare.com>
To: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Shuah Khan <shuah@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-kselftest@vger.kernel.org, kernel-team@cloudflare.com, 
 Chris J Arges <carges@cloudflare.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1789437828; l=2338;
 i=carges@cloudflare.com; h=from:subject:message-id;
 bh=8WdFP1v7/Oa+dKIJynboqHB29B7wDjj6AhOsc16jvtI=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgaxY1IIT5oTohBZJmhnVgJo2HsM7Sv
 9I0LdJCgpeGX6gAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QB1uSHqNTuHSEUu0oOnVIk7OUTk3RZzaswZwmFCmorRKp9gGkFSsUhv6PRzmEUm+JAD+57TJR82
 YoQmqb3O9bwE=
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

