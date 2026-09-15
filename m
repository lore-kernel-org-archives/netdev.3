Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F44742E404
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 05:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789448502; cv=none; b=rS1banHWsW3I2TGaWdxeWW6awmsgFo6D+OdlcKVtYCQMnkfZzVLQMUgpLM6P9hGS10TCKTPVrE5UYCdhIVzb+8JNu1szq7GaS0wdsD5Jb8CYjZ0Qooljgf/WHf40f4sunX2/2SvPyTsy5zZFyaLPRsj0Xi7jH2Ksb9tRpOy//YM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789448502; c=relaxed/simple;
	bh=uCtUnL+DK0+Vcijpb0NbemyGhnyykjJ0ZTtE8mcmaSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bxZyXe+XTFeCAGEdboQC87r1URCI5C51zwdmV6NMNxS4vjP1+NTcSdnxEy7Q+a5lzR594spZL3PqCsLpOpV1asiuoZwnoiEBfpUg56ulyayavqXIfY+ENOQLP1AiFswoaRibGjW7HFXFK4rVRzRO/rGfLD7/YNdMyxEJ/zlRriU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mC0I0wzN; arc=none smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mC0I0wzN"
Received: by mail-oo2-f43.google.com with SMTP id 46e09a7af769-7f4f0c89e33so1930647a34.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 22:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789448499; x=1790053299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e8F3JwitOM+HzKjUaxufpWmqRA5xpMbmjQIDcQNq5os=;
        b=mC0I0wzNejhewKPZ15ldKEsGHp6Rif7O3zEzRelpr+NJoIFF3OqAOw85MMzXtXOKc7
         tivgimdw7rEuVvUSQOduChnJrw4BD/RW+KA+fJ0Nslz5oeBwg/E0jlreE+IGi1Q7JM3l
         /v6GysBSLqGl6GkQU1kbmpVrUFh9otDCy/cDuws+mrA5IghF4/k2M4jFkmGGQ8sFl/9/
         /N3nlwq3NWEBBJOfVIebE/1luBv4f7ElNNTuWxsWg37SGwbpHaY76AEPPZureKjJvuGU
         pWMz7PB8uAOhXEqRHjqtd9m3kdH5QYMLfakY87BF/oHb2oHQNlg80tJpe0QBFfup+a/D
         ngoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789448499; x=1790053299;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=e8F3JwitOM+HzKjUaxufpWmqRA5xpMbmjQIDcQNq5os=;
        b=G+VL0y7ZLg48GxgCWvtzhf4qa8h212x0Z2P+YGMyYiZiP1Ll6DVzcFASzu9dZ2HfSs
         6ZSB9tQhRieKHAr9fs0bWyIfAyhvBU9wrX8y0tYTzLuHlaGoFpwL6fOieyNoO9dH26Ld
         VqRFblsWvFD9dX8py/6UUZtJZoNQ2KXUBeUOwxVyCUdJbZ4twJFGZ+WzJ/bIbC0q7OuJ
         3bVOQfs+t6GeLM9uAix0x59tuzhiWhS5JVH8QmwkYeMt0oyup2xCRnDQlGCpYCX3rXWY
         t5rhR5YKiWRKEiUPMSQfqAK8/eyN3AiYdf79Z1tiG2KNRTGspNlCZJj4AdumfjfHsjs0
         /aUg==
X-Forwarded-Encrypted: i=1; AKwUvBzwou+RLQ/5CMnsS3wkoB1FCnDUH9/Mx30y1LVjgpx+ss7PBsMjt/ziVrgUPIy/ro/jJoDV11E=@vger.kernel.org
X-Gm-Message-State: AFuF++lhrTV/Xp4Z5ISOHmnle/bN/25f5c0xPRc5Yw4g0XYovDMxZ03W
	gc1HrTB7C3ZYj0y76lPXaiiqXyTjQn2UNwixaTo4oJaho6uvUYYXSSST
X-Gm-Gg: AYBFou3Hltlrw/0O/+jR3rCQFVMjaPw4KooL/rcsa61wZXtd//KsG7MmYTbIJZo4oqx
	7l7Y9AsA7Tn2Vi872wrJS/sMIu6MNwhiVGIkbEU8gnOVE1/9ueXRzndJHtM9rVybw6pVDenZQou
	egOKo7LILAFXyVleAgZ/A6fI8WHDNodAOZVHHEyWut1kN3Ch+IGkBhld85TAX0F1gW94OCMtcPP
	TTbetiCmaTy1cTD5LFYeTyZrw+IbBjQqHEsET/7tG8r1D3PeuSvFQ/pP5BIvpW4rYtwCvLtlJon
	e8LYaqTbvOQw1nnhcULgTekqwOemHp0FU7IYV9yXVl13cjFq1lFeGIC/lpejWfems7XmO1r69yf
	Bhfimryh5b6JmuRYu1QaXSwi14GoLPHd8CRv1GbOI5VdAmWDWZ40XNq0Zb+4z/9epy32DdvT5mu
	t+v1/GM3d92SzRe6fffhKo34MV36CfKdZB8JEN2TiccAbUWLZc1mMzYdf5S4/fVQEpPWwB6MPMg
	4moRmw/UtfbPMZKvxyP5j+/0KM8gKoVCpyPeLagZYah9lqvB1P3WIQ6pC61ShF5RCw7Cu2hr1sg
	GZdZQ2Dp28n+bx2nq9kE
X-Received: by 2002:a05:6830:6405:b0:805:5e7e:9bf6 with SMTP id 46e09a7af769-80899f62264mr4009489a34.21.1789448498623;
        Mon, 14 Sep 2026 22:01:38 -0700 (PDT)
Received: from lawlee-vm0.d4y3nv5wwgfelhhopdxv1tqjld.dx.internal.cloudapp.net ([13.93.150.60])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-33ba4e51449sm26872358eec.5.2026.09.14.22.01.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 22:01:38 -0700 (PDT)
From: Lawrence Lee <lfqlee314@gmail.com>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	netdev@vger.kernel.org,
	Arun Ajith S <aajith@arista.com>,
	Roopa Prabhu <roopa@nvidia.com>,
	Jaehee Park <jhpark1013@gmail.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Alexander Aring <alex.aring@gmail.com>,
	linux-wpan@vger.kernel.org,
	linux-bluetooth@vger.kernel.org
Subject: [PATCH net-next v2 2/2] selftests: net: test untracked NA recovery of FAILED neighbors
Date: Tue, 15 Sep 2026 05:01:32 +0000
Message-ID: <3f33052571409614b953a3dc7778114c51c43669.1789448374.git.lfqlee314@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1789448374.git.lfqlee314@gmail.com>
References: <cover.1789448374.git.lfqlee314@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Seed a FAILED neighbor before triggering an unsolicited NA. Verify that
the entry transitions to STALE only when drop_unsolicited_na is disabled,
accept_untracked_na mode 1 or in-prefix mode 2 is enabled, and IPv6
forwarding is enabled. Verify that disabling each gate or using an
out-of-prefix source with mode 2 keeps the entry in FAILED.

Mark the seed externally learned and disable carrier-based eviction so
the entry cannot be garbage-collected before the NA arrives. Require the
marker after processing to prove that a recovered entry was updated in
place instead of deleted and recreated.

Check both the command that seeds the entry and its resulting state.
Capture the verifier status before constructing the test description so
the array assignment cannot mask a failure.

Link: https://lore.kernel.org/r/20260813233344.445265-1-lfqlee314@gmail.com
Assisted-by: LLM Sashiko sparse
Signed-off-by: Lawrence Lee <lfqlee314@gmail.com>
---
 .../net/ndisc_unsolicited_na_test.sh          | 124 +++++++++++++++---
 1 file changed, 105 insertions(+), 19 deletions(-)

diff --git a/tools/testing/selftests/net/ndisc_unsolicited_na_test.sh b/tools/testing/selftests/net/ndisc_unsolicited_na_test.sh
index 5db69dad0cfc..5f4f29f0ac4a 100755
--- a/tools/testing/selftests/net/ndisc_unsolicited_na_test.sh
+++ b/tools/testing/selftests/net/ndisc_unsolicited_na_test.sh
@@ -3,12 +3,18 @@
 
 # This test is for the accept_untracked_na feature to
 # enable RFC9131 behaviour. The following is the test-matrix.
-# drop   accept  fwding                   behaviour
-# ----   ------  ------  ----------------------------------------------
-#    1        X       X  Don't update NC
-#    0        0       X  Don't update NC
-#    0        1       0  Don't update NC
-#    0        1       1  Add a STALE NC entry
+# state   drop   accept  fwding                   behaviour
+# ------  ----   ------  ------  ----------------------------------------------
+# absent     1        X       X  Don't update NC
+# absent     0        0       X  Don't update NC
+# absent     0        1       0  Don't update NC
+# absent     0        1       1  Add a STALE NC entry
+# failed     1        X       X  Keep the NC entry in FAILED state
+# failed     0        0       X  Keep the NC entry in FAILED state
+# failed     0        1       0  Keep the NC entry in FAILED state
+# failed     0        1       1  Update the NC entry to STALE
+# failed     0        2       1  Update the NC entry to STALE if in-network
+# failed     0        2       1  Keep the NC entry FAILED if out-of-network
 
 source lib.sh
 ret=0
@@ -20,7 +26,9 @@ HOST_INTF="veth-host"
 ROUTER_INTF="veth-router"
 
 ROUTER_ADDR="2000:20::1"
-HOST_ADDR="2000:20::2"
+HOST_ADDR_IN_NETWORK="2000:20::2"
+HOST_ADDR_OUT_OF_NETWORK="2000:21::2"
+HOST_ADDR="${HOST_ADDR_IN_NETWORK}"
 SUBNET_WIDTH=64
 ROUTER_ADDR_WITH_MASK="${ROUTER_ADDR}/${SUBNET_WIDTH}"
 HOST_ADDR_WITH_MASK="${HOST_ADDR}/${SUBNET_WIDTH}"
@@ -88,6 +96,8 @@ setup()
                 ${ROUTER_CONF}.drop_unsolicited_na=${drop_unsolicited_na}
 	${IP_ROUTER_EXEC} sysctl -qw \
                 ${ROUTER_CONF}.accept_untracked_na=${accept_untracked_na}
+	${IP_ROUTER_EXEC} sysctl -qw \
+                ${ROUTER_CONF}.ndisc_evict_nocarrier=0
 	${IP_ROUTER_EXEC} sysctl -qw ${ROUTER_CONF}.disable_ipv6=0
 	${IP_ROUTER} addr add ${ROUTER_ADDR_WITH_MASK} dev ${ROUTER_INTF}
 
@@ -140,24 +150,77 @@ verify_ndisc() {
 	local drop_unsolicited_na=$1
 	local accept_untracked_na=$2
 	local forwarding=$3
+	local initial_state=${4:-absent}
+	local same_subnet=${5:-1}
+	local neigh_show_output
+	local expected_state
+
+	if [ "${drop_unsolicited_na}" -eq 0 ] &&
+			[ "${forwarding}" -eq 1 ]; then
+		case "${accept_untracked_na}" in
+		1)
+			expected_state=STALE
+			;;
+		2)
+			[ "${same_subnet}" -eq 1 ] && expected_state=STALE
+			;;
+		esac
+	fi
+	if [ -z "${expected_state}" ] &&
+			[ "${initial_state}" = "failed" ]; then
+		expected_state=FAILED
+	fi
 
-	neigh_show_output=$(${IP_ROUTER} neigh show \
-                to ${HOST_ADDR} dev ${ROUTER_INTF} nud stale)
-	if [ ${drop_unsolicited_na} -eq 0 ] && \
-			[ ${accept_untracked_na} -eq 1 ] && \
-			[ ${forwarding} -eq 1 ]; then
-		# Neighbour entry expected to be present for 011 case
-		[[ ${neigh_show_output} ]]
+	if [ -n "${expected_state}" ]; then
+		neigh_show_output=$(${IP_ROUTER} neigh show \
+			to "${HOST_ADDR}" dev "${ROUTER_INTF}")
+		if [[ " ${neigh_show_output} " != \
+				*" ${expected_state} "* ]]; then
+			return 1
+		fi
+		if [ "${initial_state}" = "failed" ]; then
+			[[ "${neigh_show_output}" == *"extern_learn"* ]]
+		fi
 	else
-		# Neighbour entry expected to be absent for all other cases
+		neigh_show_output=$(${IP_ROUTER} neigh show \
+			to "${HOST_ADDR}" dev "${ROUTER_INTF}")
 		[[ -z ${neigh_show_output} ]]
 	fi
 }
 
 test_unsolicited_na_common()
 {
+	local same_subnet=${5:-1}
+	local neigh_show_output
+
+	if [ "${same_subnet}" -eq 1 ]; then
+		HOST_ADDR="${HOST_ADDR_IN_NETWORK}"
+	else
+		HOST_ADDR="${HOST_ADDR_OUT_OF_NETWORK}"
+	fi
+	HOST_ADDR_WITH_MASK="${HOST_ADDR}/${SUBNET_WIDTH}"
+
 	# Setup the test bed, but keep links down
-	setup $1 $2 $3
+	setup "$1" "$2" "$3"
+
+	if [ "${4:-absent}" = "failed" ]; then
+		if ! ${IP_ROUTER} neigh replace "${HOST_ADDR}" \
+				dev "${ROUTER_INTF}" \
+				nud failed extern_learn; then
+			echo "Unable to create NUD_FAILED neighbor entry"
+			return 1
+		fi
+		neigh_show_output=$(${IP_ROUTER} neigh show \
+			to "${HOST_ADDR}" dev "${ROUTER_INTF}")
+		if [[ " ${neigh_show_output} " != *" FAILED "* ]]; then
+			echo "Unable to verify NUD_FAILED neighbor entry"
+			return 1
+		fi
+		if [[ "${neigh_show_output}" != *"extern_learn"* ]]; then
+			echo "Neighbor entry is not externally learned"
+			return 1
+		fi
+	fi
 
 	# Bring the link up, wait for the NA,
 	# and add a delay to ensure neighbour processing is done.
@@ -165,22 +228,35 @@ test_unsolicited_na_common()
 	start_tcpdump
 
 	# Verify the neighbour table
-	verify_ndisc $1 $2 $3
+	verify_ndisc "$1" "$2" "$3" "$4" "${same_subnet}"
 
 }
 
 test_unsolicited_na_combination() {
-	test_unsolicited_na_common $1 $2 $3
+	local initial_state=${4:-absent}
+	local same_subnet=${5:-1}
+	local rc
+
+	test_unsolicited_na_common "$1" "$2" "$3" "${initial_state}" \
+		"${same_subnet}"
+	rc=$?
 	test_msg=("test_unsolicited_na: "
 		"drop_unsolicited_na=$1 "
 		"accept_untracked_na=$2 "
 		"forwarding=$3")
-	log_test $? 0 "${test_msg[*]}"
+	if [ "${initial_state}" = "failed" ]; then
+		test_msg+=("initial_state=failed")
+	fi
+	if [ "$2" -eq 2 ]; then
+		test_msg+=("same_subnet=${same_subnet}")
+	fi
+	log_test "${rc}" 0 "${test_msg[*]}"
 	cleanup
 }
 
 test_unsolicited_na_combinations() {
 	# Args: drop_unsolicited_na accept_untracked_na forwarding
+	#       [initial_state] [same_subnet]
 
 	# Expect entry
 	test_unsolicited_na_combination 0 1 1
@@ -193,6 +269,16 @@ test_unsolicited_na_combinations() {
 	test_unsolicited_na_combination 1 0 1
 	test_unsolicited_na_combination 1 1 0
 	test_unsolicited_na_combination 1 1 1
+
+	# Expect FAILED entry to become STALE
+	test_unsolicited_na_combination 0 1 1 failed
+	test_unsolicited_na_combination 0 2 1 failed 1
+
+	# Expect FAILED entry to remain FAILED
+	test_unsolicited_na_combination 0 0 1 failed
+	test_unsolicited_na_combination 0 1 0 failed
+	test_unsolicited_na_combination 1 1 1 failed
+	test_unsolicited_na_combination 0 2 1 failed 0
 }
 
 ###############################################################################
-- 
2.43.0
