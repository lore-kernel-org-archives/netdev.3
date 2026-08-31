Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5F03B3C1D
	for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 21:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788213128; cv=none; b=c+nt4CGknnmlRGLA8SnoEndKg/RmOS4NkAaKc2zwaNVxy8/ZIF4lPruyr5YYqDM/Dn22u5/8E267kHOYGdjSdshf0cgTl8qinVpYiIAwI+qJ+8KeAyXYP1cFRPRGqxcKkgdblqGUlzu+8S2SjiySALB+mGE+3DxmFWyHqSI57s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788213128; c=relaxed/simple;
	bh=YuTeDlB5rSGQjCGg0nhug/A5mS/4NUh11W33+NvMTeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P4uABlrYZi6jVQI6Qn/BIMEAjmYgWfiQ8OcQA+yxdOFxFGUiZUUl7eNaG8vDjeIe4L0aYm7brCimh577GAIr9oKQKVlT4XgfcJujyDgY1w9FR4wwRpf5mLGUABORdOyHE6VH243DTLqgQLbvChd/EHTOy3V+CBl68rZm09oBoFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MjhmwFaR; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MjhmwFaR"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aec201b582so5032002e87.1
        for <netdev@vger.kernel.org>; Mon, 31 Aug 2026 14:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788213121; x=1788817921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=N3b1QazDuG4xzv4W7Y1bzZmafsmvUHp3dVsi9T+Ml1A=;
        b=MjhmwFaRxYAvYIWJsf6j0XmbfbkCHQnWXCzAfNge6i+m/SXHRtjmGuJfEzGNQ0Rgnm
         PxA1cCeDJloqh5W1EQSu7zGkgBQGy3O6aPofbHGAsTCHkD40UDsnKm/GAWVpNGg8Igz/
         iauwHokC1pdmvpfxkhC58kjprU9nhJopkAHCQhNqHOZKz/i5LJXseytLmE4HBeW974JI
         UAK7MLFfivGFfzZCWbBWF3TofzEhFvl75hak4tGGEcgaEuH2SDCFilJ8gBxoEl1XWWpt
         KHUrQ+vgHITNuaI37YbBlBcXWNX2ntzpkAOf9RH0TeGEWZxCNxnEOuhDrSdUGUdvzl0J
         yYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788213121; x=1788817921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=N3b1QazDuG4xzv4W7Y1bzZmafsmvUHp3dVsi9T+Ml1A=;
        b=VmkjwAXj5VvQKAXcTrleOmdXSF9fU9pwpfGvRLpUs+NlwHaeoRGIAb7lO9pffvVEHQ
         s060k8Jiv18nBsizQNyrScwvqvSRiDj3hom6tROkzQaZtqLvTkwXDFCS7imH4Ff5HS93
         yIooMKD6cUcZqt5b68BzSGGhswPXPtAMDjx0W8gz4UWcUjHdcarDplIm6sQ+vzTH2tt7
         DMKQbqUXc35KoDaM3LCnVHBbcBYXDeCMgF7SWmHVqUNz52nOqrLW5QSO0f75YKgFP89U
         B7plWfwajzO1WuSQ1Vqz99bo1p05wdkiN1ngr9HLe2eyIV/I3l9suGhL7FIaHNwkvkes
         VfTg==
X-Gm-Message-State: AFuF++lACmjADHVuWBvBww35HhmRZfhvkYcsl+/eWgXSLGGwkYcDF95S
	uhfKjciP5WDfG151xPSH2qlfswaw9a6jiVXNX+O9f75cvpzqTgcnfEjufCsYsgY7dt8=
X-Gm-Gg: AYBFou1OzfWiaWaYLPc7QjYpRKMuvfSVMhxEZQ5Cs2zL1yu63vuRgdWjaumNK1tfuXT
	XLk5gI3j9b6YFJGkSkUy6o0KDKPrtZr/U8/JThCLq1Bww8yZmDmPdhyWAdy1LvSRGzV43ueMrwj
	EG48IRSOmoiaAsuIJ3KtHJ/wNrzITo+0RuLnvNLpnaZithgMLo53zzXOXeVS3Ga+oaPcctA2tQI
	wudlCSiddxfsMFZWlZ1Xy770jWUwBQVnHoDVXstoxfsvBBg4uHvZIMZh5xLAKVFpxyvA2vUnEo+
	L0q6lpAdmtHsw3a51uRidmnzD/Io7ac31bGDLn1kKewN5eOBqEqozUTetpFAKxBzQ9SP2P9JZB6
	aJST5mrmKS5KsC5vepS8bi3yTlAToOnQWGq7JdWRQm7J4iAERALWH6YyDyl+uEi86/dMAeLYdJa
	jt6t/VE3gwzodWO3r4LiAObBnYT/bXs8BBPvvbaQrc1bNxW7rYEQ3oPe+GICaijg/li/js8utrN
	39oUXJZEckely2baQzto12oFVYhzQjN/9UOHlTo5cqZ
X-Received: by 2002:a05:6512:3c8a:b0:5b0:22a6:6b13 with SMTP id 2adb3069b0e04-5b5e684ae6bmr9361502e87.0.1788213121068;
        Mon, 31 Aug 2026 14:52:01 -0700 (PDT)
Received: from dau-home-pc.. ([212.35.184.237])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b5e8a06a77sm2388782e87.48.2026.08.31.14.51.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:52:00 -0700 (PDT)
From: Anton Danilov <littlesmilingcloud@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 07/11] selftests: net: cover the GRE specific drop reasons
Date: Tue,  1 Sep 2026 00:51:33 +0300
Message-ID: <20260831215137.549324-8-littlesmilingcloud@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260831215137.549324-1-littlesmilingcloud@gmail.com>
References: <20260831215137.549324-1-littlesmilingcloud@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend the tunnel drop reason test with the reasons added to the GRE
receive path:

 - two endpoints configured with different keys make the tunnel lookup
   on the receiver fail, which is reported as GRE_TUNNEL_NOT_FOUND,

 - setting the routing bit of the GRE header is reported as
   GRE_INVALID_HDR, and announcing GRE version 1, which has no handler
   unless PPTP is built in, is reported as UNHANDLED_PROTO.

The last two corrupt the header of the received packets with tc pedit
and are skipped when the ingress qdisc or the pedit action are not
available.

SKB_DROP_REASON_GRE_CSUM is not covered: veth hands the packets over
with CHECKSUM_UNNECESSARY, so the GRE checksum is never validated and
the reason cannot be reached without crafting the packets.

Assisted-by: Claude-Code:claude-opus-5
Signed-off-by: Anton Danilov <littlesmilingcloud@gmail.com>
---
 .../selftests/net/tunnel_drop_reasons.sh      | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/tools/testing/selftests/net/tunnel_drop_reasons.sh b/tools/testing/selftests/net/tunnel_drop_reasons.sh
index eb19967ae7dd..aad003f0efe5 100755
--- a/tools/testing/selftests/net/tunnel_drop_reasons.sh
+++ b/tools/testing/selftests/net/tunnel_drop_reasons.sh
@@ -20,6 +20,17 @@
 # A control case, where both endpoints agree on the options, makes sure
 # that no tunnel drop reason is reported when packets are accepted.
 #
+# The GRE specific reasons are checked as well:
+#
+#  - a packet that matches no tunnel is reported as
+#    GRE_TUNNEL_NOT_FOUND.  It is triggered here by giving the two
+#    endpoints different keys.
+#
+#  - a header with the routing bit set is reported as GRE_INVALID_HDR,
+#    and a header announcing a GRE version nobody handles is reported as
+#    UNHANDLED_PROTO.  Both are triggered by corrupting the GRE header
+#    on ingress with tc pedit, and are skipped if that is not available.
+#
 # Drop reasons are read from the skb:kfree_skb tracepoint.  A dedicated
 # trace instance is used so that the test does not disturb, and is not
 # disturbed by, anything else using the tracing facility.
@@ -202,6 +213,47 @@ test_control()
 	check_reason "gre: matching configuration (control)" ""
 }
 
+# Corrupt one field of the GRE header of every IPv4 packet received by
+# the receiver.  $1 is a tc pedit munge expression, with offsets counted
+# from the start of the IPv4 header.
+corrupt_gre_header()
+{
+	ip netns exec "$NS_RCV" tc qdisc add dev veth_r ingress || return 1
+	ip netns exec "$NS_RCV" tc filter add dev veth_r ingress \
+		protocol ip matchall action pedit ex munge "$@" || return 1
+}
+
+test_tunnel_not_found()
+{
+	setup_ns_pair
+	# The two endpoints use different keys, so the lookup on the
+	# receiver finds no tunnel for the incoming packets.
+	add_gre "$NS_SND" "$SND_V4" "$RCV_V4" okey 1 ikey 1
+	add_gre "$NS_RCV" "$RCV_V4" "$SND_V4" okey 2 ikey 2
+	addr_tunnels
+
+	check_reason "gre: tunnel not found" GRE_TUNNEL_NOT_FOUND
+}
+
+# $1: test name, $2: expected reason, $3...: tc pedit munge expression
+test_corrupted_header()
+{
+	local name=$1 want=$2
+
+	shift 2
+	setup_ns_pair
+	add_gre "$NS_SND" "$SND_V4" "$RCV_V4"
+	add_gre "$NS_RCV" "$RCV_V4" "$SND_V4"
+	addr_tunnels
+
+	if ! corrupt_gre_header "$@" 2>/dev/null; then
+		log_test_skip "$name"
+		return
+	fi
+
+	check_reason "$name" "$want"
+}
+
 if [ "$(id -u)" -ne 0 ]; then
 	echo "SKIP: need root"
 	exit "$ksft_skip"
@@ -217,6 +269,16 @@ test_opts_mismatch gre icsum
 test_control
 test_old_seq gre
 
+test_tunnel_not_found
+# The routing bit is the second most significant bit of the first byte
+# of the GRE header, which follows the 20 byte IPv4 header.
+test_corrupted_header "gre: routing bit set" GRE_INVALID_HDR \
+	offset 20 u8 set 0x40
+# The GRE version sits in the low bits of the next byte.  Version 1 is
+# PPTP, which has no handler here.
+test_corrupted_header "gre: unhandled GRE version" UNHANDLED_PROTO \
+	offset 21 u8 set 0x01
+
 if [ -e /proc/sys/net/ipv6 ]; then
 	test_opts_mismatch ip6gre iseq
 	test_old_seq ip6gre
-- 
2.47.3

