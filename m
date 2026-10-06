Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 864C34A1E0B
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 17:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791308003; cv=none; b=aUy6YpRhcyim1dlurOrY3LapCtlqXpA9xZyNakunnHWlywTurCugEFRHfLMe/J+JfqAReV3GGF8ImfNkSvd4/7pdFShUYaVUEEYNMcMDlIGDhBNT5ggjAiC2GbSKHyye7ZnmzQRoO6fZmr0u1Xa21aQemRgS/CLDy8h3hPUkzXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791308003; c=relaxed/simple;
	bh=kTgr8P/nHMLEmyjBo2BvdohBA5jClZbefuaaY9uAsrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FBhVHfruyFdlkh/an5t9U2bKJbcM1pMkDziW9WSE3+tVoqE04AxnWDOeqPF+V7M8rZejZA+msbqwUFKJPlFGDcd9r/mGRITCHw4c9VG44+aTvUWp2nLaf65v9gRnwVPEyE+vYnFoqjfHCMb+Q/m2uXb4guQNemX7PIMXbpXn8XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=AEjHVivS; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="AEjHVivS"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a0e1b0681bso7467805e9.3
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 10:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1791308000; x=1791912800; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cydJHqNsAliFhPASrleIpr3STINpYAHg93P+bPMs80o=;
        b=AEjHVivSJ+YedYBovT6GmaA8mndUir6AhdtlTYoCt3O7LESb5VAvg/Bo1gQmy+VYF+
         rwWALCSIJMH87foXZf7ynZziiTiMmzAdBjEopfwSJ9uMNbd/T7musXjQDcAzzKOwNFvr
         xT5VKQ8cslpJr3eurM24mDiSdB4KJ3xjWry6WaTPxEEk2ePQaq6sAOVO8hg8jLDq/8Ud
         LfKztFsfpPZpN01Rac+Ornu0f0lbGCkZ/jTZTFVEap7XgYzv5Awmq5YVhjMOEGsNmJ56
         Bazn5JyvMMG6siQ7CVT35FnEm0jLTqIix2Fxgv5ttzL8ppVwlFOrA8KvFpcYXRpW4HiZ
         f9yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791308000; x=1791912800;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cydJHqNsAliFhPASrleIpr3STINpYAHg93P+bPMs80o=;
        b=SORHLkbLC5DFLuiKkvissoug3+ewjGaze2ANzygoZcL5X4yjDyFLB6Lip4PHfiZpp1
         N9hLvCMcuh7BCz47sHw/zHVE2a6LeERf4zSLHaU1XdceUb9NKVqoeBVxj7qx3gCf9qMN
         bbB0CRxmO5eclQD5mgkPTqabpo8Hp2LCBtRebLptPandGymk1YL8BKUMxm+qXBAH4HD6
         VrAPHkOR1yFbxGqkhSsE3tzwkDA8RrelI3bAhRCcuZtGxHQN7HIKabpe4L68AHsxXWWq
         Aur5MKfdA/yVJkpXxbykN2NewQ5zsAuMkEpKac1HfDUqWOdSO4yC27aHkFPoVnGfoZo/
         5fDQ==
X-Gm-Message-State: AFuF++mpXqvHW2ZrdTHV2AxSuDmFaKffmKUfYkkr00Cp9vOQhN3NO+mW
	QPwUdOEcTfgpQhQTK9OfAJa6JmNDGhaHqUE+sNxP1jjCQiJVvEJ10fhUOqP7VTv4M81omkfFigv
	eYqYQpbnDEw==
X-Gm-Gg: AYBFou2XvET+pt8AsxFu8S6SFrSF28T545JwD6gxxTERiknnEf/iAKBbaxQZWUxDEQd
	wlIHRKjHJzmTwZAe28rbA1pBI3AYGEYPKXlJf05H5MQizxpWeM2aAmor7xc3x3tMCL4ZhXuVrzR
	F4ZnaWhQ58O0bWyruTDCMAdjI0+UO01/B0z/83xorJnRAGPD85PAa05qsCQ7FunLMqH7Ru5Hz5X
	AMHh1DjTovHhq89Zni7gseMqOgHfxU3dGwKUUjFp3V5wMb8dUVGf93A0SGkVpi+FYBOkG6WrcNf
	h64oXuuBKeQnMpgtA9pd59tBQMk7L1839PPcOhAYnA+EVUpiGcHrjK1/hL817VCjPmcMI75Htxh
	Oiekc1xe0Xa8RUi6T+3wOROiE5EVZkTgzt/2zfvCvzQK+daSqPtQ9Y7XVHFYQqPrs5uprBsP8VO
	s6vQyGI4b+HwONOCVn+t4QHZNCg4lbW7f+YGLj+TYJZxiggOc7F5/arkkYLUxYI6wJGE2Q0DhRx
	uh8Hc8MUapi9m8=
X-Received: by 2002:a05:600c:1394:b0:49f:bd3c:bc1b with SMTP id 5b1f17b1804b1-4a17b53fc1fmr31811145e9.22.1791307999766;
        Tue, 06 Oct 2026 10:33:19 -0700 (PDT)
Received: from D90XRJJJNQ ([2a09:bac6:37af:d2::15:413])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71d1272esm714121f8f.27.2026.10.06.10.33.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 06 Oct 2026 10:33:19 -0700 (PDT)
From: Tianyi Gao <tianyi@cloudflare.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	toke@redhat.com,
	lorenzo@kernel.org,
	horms@kernel.org,
	bpf@vger.kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	kernel-team@cloudflare.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	linux-kselftest@vger.kernel.org,
	Tianyi Gao <tianyi@cloudflare.com>
Subject: [PATCH net 2/2] selftests: net: veth: test peer ndo-xmit after GRO toggle while down
Date: Tue,  6 Oct 2026 18:32:37 +0100
Message-ID: <20261006173241.65945-3-tianyi@cloudflare.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261006173241.65945-1-tianyi@cloudflare.com>
References: <20261006173241.65945-1-tianyi@cloudflare.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test that toggling GRO on a veth device while it is down updates the
peer's ndo-xmit XDP feature once the device comes up, for both GRO on
and GRO off.

xdp-features is only visible through netlink, so read it with the ynl
CLI, as double_udp_encap.sh does. Skip the checks if the CLI is not
found, as in an installed kselftest tree.

Signed-off-by: Tianyi Gao <tianyi@cloudflare.com>
---
This commit only covers the peer's ndo-xmit flag. Paolo asked for
selftests on the device's own XDP features when commit 7a6102aa6df0
("veth: Update XDP feature set when bringing up device") was applied
[1], which refreshes them in veth_open(); those are out of scope here.

[1] https://lore.kernel.org/all/155aabf8b873bb8cdcafbd6139c42b08513e5fe6.camel@redhat.com/
---
 tools/testing/selftests/net/veth.sh | 46 +++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/tools/testing/selftests/net/veth.sh b/tools/testing/selftests/net/veth.sh
index 9709dd067c72..8b867e0675a7 100755
--- a/tools/testing/selftests/net/veth.sh
+++ b/tools/testing/selftests/net/veth.sh
@@ -9,6 +9,8 @@ readonly DST=1
 readonly DST_NAT=100
 readonly NS_SRC=$BASE$SRC
 readonly NS_DST=$BASE$DST
+# shellcheck disable=SC2155 # prefer RO variable over return value from cmd
+readonly YNL="$(dirname "$(readlink -f "$0")")/../../../net/ynl/pyynl/cli.py"
 
 # "baremetal" network used for raw UDP traffic
 readonly BM_NET_V4=192.168.1.
@@ -74,6 +76,37 @@ chk_tso_flag() {
 	__chk_flag "$1" $2 $3 tcp-segmentation-offload
 }
 
+chk_xdp_feature() {
+	local msg="$1"
+	local target=$2
+	local expected=$3
+	local feature=$4
+	local ifindex
+	local out
+	local st
+	local flag
+
+	ifindex=`ip netns exec $BASE$target cat /sys/class/net/veth$target/ifindex`
+	out=`ip netns exec $BASE$target "$YNL" --family netdev --do dev-get \
+		--output-json --json "{\"ifindex\": $ifindex}" 2>&1`
+	st=$?
+
+	printf "%-60s" "$msg"
+	if [ $st -ne 0 ]; then
+		echo " fail - ynl cli error: $out"
+		ret=1
+		return
+	fi
+
+	flag=`echo "$out" | grep -c "\"$feature\""`
+	if [ "$flag" = "$expected" ]; then
+		echo " ok "
+	else
+		echo " fail - expected $expected found $flag"
+		ret=1
+	fi
+}
+
 chk_channels() {
 	local msg="$1"
 	local target=$2
@@ -222,6 +255,7 @@ fi
 
 [ $CPUS -lt 2 ] && echo "Only one CPU available, some tests will be skipped"
 [ $STRESS -gt 0 -a $CPUS -lt 3 ] && echo " stress test will be skipped, too"
+[ ! -f "$YNL" ] && echo "ynl cli not found, ndo-xmit tests will be skipped"
 
 create_ns
 chk_gro_flag "default - gro flag" $SRC off
@@ -283,6 +317,18 @@ chk_gro_flag "        - peer gro flag" $SRC off
 chk_tso_flag "        - tso flag" $SRC on
 chk_tso_flag "        - peer tso flag" $DST on
 ip -n $NS_DST link set dev veth$DST up
+if [ -f "$YNL" ]; then
+	chk_xdp_feature "        - peer ndo-xmit" $SRC 1 ndo-xmit
+	# make sure the peer flag is set before disabling gro while down
+	ip netns exec $NS_DST ethtool -K veth$DST gro off
+	ip netns exec $NS_DST ethtool -K veth$DST gro on
+	chk_xdp_feature "        - peer ndo-xmit re-armed" $SRC 1 ndo-xmit
+	ip -n $NS_DST link set dev veth$DST down
+	ip netns exec $NS_DST ethtool -K veth$DST gro off
+	ip -n $NS_DST link set dev veth$DST up
+	chk_xdp_feature "        - peer ndo-xmit cleared" $SRC 0 ndo-xmit
+	ip netns exec $NS_DST ethtool -K veth$DST gro on
+fi
 ip netns exec $NS_SRC ethtool -K veth$SRC tx-udp-segmentation off
 ip netns exec $NS_DST ethtool -K veth$DST rx-udp-gro-forwarding on
 chk_gro "        - aggregation with TSO off" 1
-- 
2.55.0

