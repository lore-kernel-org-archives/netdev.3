Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793698809;
	b=sAwIXBG0Gf/G2GHjonwyUXFJGHObZ3PsnsoysIgXQy0O2UzLzuyjCg4YfLkIepYxmIFX
	 goTcP76Qjtj4SOix43ySvgvVFiw2isbhtsW3MYvNQu/IjqkIxq0k4zKyxHR+CjYNx3rch
	 qxhRQfuQ0d+wNwV0CRcZTeNnpgGssfpqPNX7bU59y/+3vLki22sEtZxt3KTwJX9YjKnqq
	 x+guc6F6g7d4gap85rHIWYfJUrvyde6fRMaZ0WJt7t9f8OxXfLNOog/7V1CNNps/YwPnT
	 JDhIYp0yCFKaOJLc6pY1YCcse8nAp4N+fxdI5YninA5Ox01tWb8MaVGYFHdGHmgFaXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793698809;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-Scanned-By;
	bh=qTvUYfsxMUV304+qNt6kKUlLBw0/qh7C+R01DBDtD9Y=;
	b=HrnoznHqUWMSbqvfFpKDtS/o94sHaoS/4HUH+WQEtCoW6KGx8yMQ2tc3fJ7SYV02ltvw
	 DpMKlxcjqVhRyxbkNq4uWiOfXojUv4T7FMmWZPsjPtXiCUGHH6Ds9AAVBe5ZhPnurFjAm
	 7XCjlPxjZ1JPRfa0SKJv6aw3tlHClAUiIvrHl8IoCObZVKgzet2I9ZrkP56itiNs728nA
	 +BEGNsKyoU4ffsrsTA7pod+0PDCc5+k/E5aKCNs7v2kXc/I4pxvgaeotDfNkRSselJYj0
	 2DdmlJnE9MWbjp+fMz/0INDmsUxgBM8Vm5zgFHimzExJKdYSpKD6mR0PDceQU5HhLbg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D3I4jCME;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A1E0606A32F
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 09:40:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8A1E0606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D3I4jCME
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793698807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qTvUYfsxMUV304+qNt6kKUlLBw0/qh7C+R01DBDtD9Y=;
	b=D3I4jCME5khuWLzMSNdEeMi7fm+pMlMFZ7/U3cKuNNSNG1fsK/gc+6Rxyd/QFEHMC4krxu
	stUi0a+iUSIYCT/xmFZjA1lIriLIJ9TlGmxyKRWXcPZI+/wV1YV0nmCK0JMEREONoDVJVk
	TGMXDEChzNhn93fWD/0yRRiOk4soBy8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-625-E_yCWrAcOcO0g3vobffUVA-1; Tue,
 03 Nov 2026 04:40:03 -0500
X-MC-Unique: E_yCWrAcOcO0g3vobffUVA-1
X-Mimecast-MFC-AGG-ID: E_yCWrAcOcO0g3vobffUVA_1793698801
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8A6571955BD7;
	Tue,  3 Nov 2026 09:40:01 +0000 (UTC)
Received: from poros-thinkpadp16vgen1.tpbc.com (unknown [10.44.32.42])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id F16087E2;
	Tue,  3 Nov 2026 09:39:56 +0000 (UTC)
From: Petr Oros <poros@redhat.com>
To: netdev@vger.kernel.org
Cc: Petr Oros <poros@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Ivan Vecera <ivecera@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 06/14] selftests: dpll: add pin state tests
Date: Tue,  3 Nov 2026 10:39:02 +0100
Message-ID: <20261103093910.596225-7-poros@redhat.com>
In-Reply-To: <20261103093910.596225-1-poros@redhat.com>
References: <20261103093910.596225-1-poros@redhat.com>
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
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95

Add dpll_features.sh, a script that exercises individual device and pin
callbacks with get/set roundtrips over netlink. It creates a dpllsim
device with the standard pin layout by default or runs against the
device named by DPLL_DEV_ID, and picks the pin to reconfigure up front,
the first input pin that is not connected on the device, so that no
test touches the reference the device is locked to. The first test
moves that pin between the disconnected and selectable states, reads
the state back after each step and restores the original state at the
end. It never connects the pin, which could make it the reference.

A driver may refuse a state the capability promises, for a constraint
the interface does not tell. That is a skip on a device provided by
the user, with the reason the tool reported, and a failure on the
device the script created, whose simulator accepts both states. The
restore is deferred right after the original state is read, and the
cleanup handler of every script that defers runs the pending restores
before it removes the devices the script created, so that an
interrupted run puts the device back as well.

The stress script gains a test that floods one input pin of a fresh
device with state changes. The library gains the state setter both
use, which keeps the extack line of the tool in DPLL_LAST_ERR so that
a test can tell a refusal from a failure, and a check whether the pin
set usage of the tool knows a keyword, so that a test skips on a tool
too old for it rather than every script requiring a newer tool.

Signed-off-by: Petr Oros <poros@redhat.com>
---
 .../selftests/drivers/net/dpll/Makefile       |   1 +
 .../drivers/net/dpll/dpll_features.sh         | 183 ++++++++++++++++++
 .../selftests/drivers/net/dpll/dpll_stress.sh |  57 ++++++
 .../selftests/drivers/net/lib/sh/dpll_lib.sh  |  76 +++++++-
 4 files changed, 316 insertions(+), 1 deletion(-)
 create mode 100755 tools/testing/selftests/drivers/net/dpll/dpll_features.sh

diff --git a/tools/testing/selftests/drivers/net/dpll/Makefile b/tools/testing/selftests/drivers/net/dpll/Makefile
index 7752fb518b6e9b..7cb42c93b0c9a1 100644
--- a/tools/testing/selftests/drivers/net/dpll/Makefile
+++ b/tools/testing/selftests/drivers/net/dpll/Makefile
@@ -8,6 +8,7 @@ TEST_INCLUDES := \
 
 TEST_PROGS := \
 	dpll_basic.sh \
+	dpll_features.sh \
 	dpll_stress.sh \
 # end of TEST_PROGS
 
diff --git a/tools/testing/selftests/drivers/net/dpll/dpll_features.sh b/tools/testing/selftests/drivers/net/dpll/dpll_features.sh
new file mode 100755
index 00000000000000..42271769b2e706
--- /dev/null
+++ b/tools/testing/selftests/drivers/net/dpll/dpll_features.sh
@@ -0,0 +1,183 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# DPLL device and pin feature tests. Exercises individual dpll_device_ops
+# and dpll_pin_ops callbacks, verifying get/set roundtrips through the
+# netlink interface. By default a dpllsim device with a known pin layout
+# is created; set DPLL_DEV_ID to run against an existing device instead,
+# the simulator-only tests then skip unless that device is a dpllsim one.
+#
+# Copyright (c) 2026 Red Hat, Inc.
+
+SCRIPTDIR=$(dirname "$(readlink -e "${BASH_SOURCE[0]}")")
+
+source "$SCRIPTDIR/../../../net/lib.sh"
+source "$SCRIPTDIR/../lib/sh/dpll_lib.sh"
+
+ALL_TESTS="
+	test_pin_state_transitions
+"
+
+##############################################################################
+# Pin-level feature tests
+
+test_pin_state_transitions()
+{
+	local before state after reason
+
+	RET=0
+
+	if [ -z "$PIN_TUNE_ID" ]; then
+		dpll_log_test_skip_or_fail "DPLL pin state transitions" \
+		    "no spare input pin"
+		return
+	fi
+	if ! dpll_pin_set_supports state; then
+		log_test_skip "DPLL pin state transitions" \
+		    "dpll tool lacks pin set state"
+		return
+	fi
+	if ! dpll_pin_has_capability "$PIN_TUNE_ID" state-can-change; then
+		dpll_log_test_skip_or_fail "DPLL pin state transitions" \
+		    "state cannot change"
+		return
+	fi
+
+	before=$(dpll_pin_get_state "$DPLL_DEV_ID" "$PIN_TUNE_ID")
+	if [ -z "$before" ]; then
+		dpll_log_test_skip_or_fail "DPLL pin state transitions" \
+		    "state not reported"
+		return
+	fi
+	# Restore the original state even when the test aborts half way.
+	defer dpll_pin_set_state "$DPLL_DEV_ID" "$PIN_TUNE_ID" "$before"
+
+	# The pin is not connected, see how PIN_TUNE_ID is picked, and the
+	# test never connects it, it moves the pin between the disconnected
+	# and selectable states only and ends at the original one. A pin
+	# that is connected may become the reference the device locks to.
+	#
+	# A driver may refuse a state the capability promises, for a
+	# constraint the interface does not tell. On a device provided by
+	# the user that is a skip with the reason the tool reported, on
+	# the created device a failure, the simulator accepts both states.
+	# The test ends there, whichever set was refused, a state that was
+	# not set has nothing to read back and the deferred restore puts
+	# the pin back. A refused restore is treated the same way when
+	# nothing failed before it, afterwards it is one more failure, a
+	# skip would hide the earlier one.
+	for state in disconnected selectable; do
+		if ! dpll_pin_set_state "$DPLL_DEV_ID" "$PIN_TUNE_ID" \
+					"$state"; then
+			reason=${DPLL_LAST_ERR%%$'\n'*}
+			dpll_log_test_skip_or_fail \
+			    "DPLL pin state transitions" \
+			    "cannot set pin state to $state${reason:+, $reason}"
+			return
+		fi
+		after=$(dpll_pin_get_state "$DPLL_DEV_ID" "$PIN_TUNE_ID")
+		if [ "$after" != "$state" ]; then
+			check_err 1 "pin not $state, state '$after'"
+		fi
+	done
+
+	if ! dpll_pin_set_state "$DPLL_DEV_ID" "$PIN_TUNE_ID" "$before"; then
+		reason=${DPLL_LAST_ERR%%$'\n'*}
+		reason=${reason:+, $reason}
+		if [ "$RET" -eq 0 ]; then
+			dpll_log_test_skip_or_fail \
+			    "DPLL pin state transitions" \
+			    "cannot set pin state to $before$reason"
+			return
+		fi
+		check_err 1 "cannot restore pin state$reason"
+	fi
+	after=$(dpll_pin_get_state "$DPLL_DEV_ID" "$PIN_TUNE_ID")
+	if [ "$after" != "$before" ]; then
+		check_err 1 "pin state not restored, got '$after'"
+	fi
+
+	log_test "DPLL pin state transitions"
+}
+
+##############################################################################
+
+cleanup()
+{
+	# A second signal must not abort the teardown half way.
+	trap '' INT TERM
+
+	# Run the pending restores of an interrupted test first, the device
+	# they apply to may be one the user provided.
+	defer_scopes_cleanup
+	if [ -n "$DPLL_CREATED_DEVICE" ]; then
+		dpllsim_delete_device "$DPLL_CREATED_DEVICE" ||
+			log_info "cannot delete device $DPLL_CREATED_DEVICE"
+	fi
+	# The device whose creation a signal interrupted is recorded by the
+	# library alone, a double delete of a tracked one is harmless.
+	if [ -n "$DPLLSIM_CREATED_NAME" ]; then
+		dpllsim_delete_device "$DPLLSIM_CREATED_NAME" ||
+			log_info "cannot delete device $DPLLSIM_CREATED_NAME"
+	fi
+	dpll_lib_cleanup
+}
+
+dpll_lib_check_prereqs
+# Another run would find the devices of this one left behind, see the
+# lock in the library.
+dpll_lib_lock
+
+# The module check may mount configfs, so the exit trap that unmounts it
+# again has to be in place before. INT and TERM exit through it as well,
+# so that a timeout imposed by the harness still restores the device.
+trap cleanup EXIT
+trap 'exit 1' INT TERM
+
+if [ -n "${DPLL_DEV_ID:-}" ]; then
+	dpll_lib_init
+else
+	dpllsim_check_module
+	if ! dpllsim_setup_standard_device; then
+		echo "SKIP: cannot create dpllsim device"
+		exit $ksft_skip
+	fi
+	DPLL_DEV_ID=$DPLLSIM_DEV_ID
+	DPLL_CREATED_DEVICE=$DPLLSIM_CREATED_NAME
+	DPLL_MODULE_NAME="dpllsim"
+fi
+
+log_info "testing DPLL device $DPLL_DEV_ID (module $DPLL_MODULE_NAME)"
+
+# PIN_TUNE_ID is the input pin the tests reconfigure. It must not be the
+# reference the device is locked to, so it is the first input pin that
+# is not connected on the device. When the first dumped input pin and
+# another one both qualify the other one is taken, so that the first
+# pin, the one a simulated device locks to once it is connected, is left
+# alone. Tests that need the pin skip when there is none rather than
+# reconfiguring the reference.
+pick_tune_pin()
+{
+	local pin_id state
+
+	PIN_TUNE_ID=""
+	for pin_id in "${input_pins[@]}"; do
+		state=$(dpll_pin_get_state "$DPLL_DEV_ID" "$pin_id")
+		case "$state" in
+		disconnected|selectable)
+			;;
+		*)
+			continue
+			;;
+		esac
+		PIN_TUNE_ID=$pin_id
+		[ "$pin_id" != "${input_pins[0]}" ] && return
+	done
+}
+
+mapfile -t input_pins < <(dpll_pin_find_by_direction "$DPLL_DEV_ID" input)
+pick_tune_pin
+
+tests_run
+
+exit $EXIT_STATUS
diff --git a/tools/testing/selftests/drivers/net/dpll/dpll_stress.sh b/tools/testing/selftests/drivers/net/dpll/dpll_stress.sh
index e5a1c4d88da580..ee543e2cd8703c 100755
--- a/tools/testing/selftests/drivers/net/dpll/dpll_stress.sh
+++ b/tools/testing/selftests/drivers/net/dpll/dpll_stress.sh
@@ -15,6 +15,7 @@ source "$SCRIPTDIR/../lib/sh/dpll_lib.sh"
 
 ALL_TESTS="
 	test_rapid_create_delete
+	test_pin_state_flooding
 	test_deploy_cycle
 "
 
@@ -45,6 +46,7 @@ cleanup()
 	# A second signal must not abort the teardown half way.
 	trap '' INT TERM
 
+	defer_scopes_cleanup
 	for dev in "${CREATED_DEVICES[@]}"; do
 		dpllsim_delete_device "$dev" ||
 			log_info "cannot delete device $dev"
@@ -133,6 +135,61 @@ test_rapid_create_delete()
 	log_test "DPLL rapid create/delete ($STRESS_ITERATIONS iterations)"
 }
 
+test_pin_state_flooding()
+{
+	local clock_id name dev_id pin_id i last state fails=0
+	local states=(connected disconnected selectable)
+
+	RET=0
+
+	if ! dpll_pin_set_supports state; then
+		log_test_skip "DPLL pin state flooding" \
+			      "dpll tool lacks pin set state"
+		return
+	fi
+
+	dpllsim_alloc_clock_id; clock_id=$DPLLSIM_CLOCK_ID
+	if ! create_stress_device "$clock_id" 10; then
+		check_err 1 "cannot create device"
+		log_test "DPLL pin state flooding"
+		return
+	fi
+	name=$DPLLSIM_CREATED_NAME
+	track_device "$name"
+
+	if ! dev_id=$(dpll_device_wait_by_clock_id "$clock_id" dpllsim); then
+		check_err 1 "device not visible on netlink"
+	else
+		pin_id=$(dpll_pin_find_by_direction "$dev_id" input | head -1)
+		if [ -z "$pin_id" ]; then
+			check_err 1 "no input pin on stress device"
+		else
+			for i in $(seq 1 50); do
+				last=${states[i % 3]}
+				dpll_pin_set_state "$dev_id" "$pin_id" \
+						   "$last" ||
+					fails=$((fails + 1))
+			done
+			if [ "$fails" -gt 0 ]; then
+				check_err 1 "$fails of 50 state changes failed"
+			fi
+			state=$(dpll_pin_get_state "$dev_id" "$pin_id")
+			if [ "$state" != "$last" ]; then
+				check_err 1 \
+				    "state expected '$last', got '$state'"
+			fi
+		fi
+	fi
+
+	if dpllsim_delete_device "$name"; then
+		untrack_device "$name"
+	else
+		check_err 1 "cannot delete device $name"
+	fi
+
+	log_test "DPLL pin state flooding"
+}
+
 test_deploy_cycle()
 {
 	local clock_id name i
diff --git a/tools/testing/selftests/drivers/net/lib/sh/dpll_lib.sh b/tools/testing/selftests/drivers/net/lib/sh/dpll_lib.sh
index ab1c0796f599f1..badb787815d42f 100644
--- a/tools/testing/selftests/drivers/net/lib/sh/dpll_lib.sh
+++ b/tools/testing/selftests/drivers/net/lib/sh/dpll_lib.sh
@@ -5,7 +5,8 @@
 # tool and around the dpllsim configfs interface for creating virtual DPLL
 # devices. Sourcing this file has no side effects; call
 # dpll_lib_check_prereqs and dpll_lib_init explicitly. net/lib.sh must be
-# sourced first, it provides ksft_skip, busywait and log_info.
+# sourced first, it provides ksft_skip, busywait and log_info to the
+# library and defer to the scripts.
 #
 # Copyright (c) 2026 Red Hat, Inc.
 
@@ -83,6 +84,44 @@ dpll_lib_lock()
 	fi
 }
 
+# Print the usage block of the given command of the given object from
+# the help of the dpll tool, "dpll pin set" for instance. The help lists
+# one usage per command, each starting with "Usage: dpll <obj> <cmd>" or
+# with "dpll <obj> <cmd>" indented under the first, possibly wrapped
+# over further lines. The block starts at the line that names the
+# command, with a space after the name so that a command whose name
+# merely begins the same way does not match, and ends before the next
+# line that names another command of the object, or at the end of the
+# help when none follows. Return 1 when the help has no usage for the
+# command, in which case nothing is printed.
+__dpll_usage_block()
+{
+	local obj=$1
+	local cmd=$2
+
+	dpll "$obj" help 2>&1 | \
+		awk -v start="[[:space:]]dpll $obj $cmd([[:space:]]|$)" \
+		    -v other="[[:space:]]dpll $obj [a-z-]+([[:space:]]|$)" \
+		    '$0 ~ start { s = 1; print; next }
+		     s && $0 ~ other { exit }
+		     s { print }
+		     END { exit !s }'
+}
+
+# Return 0 when the dpll tool knows the given "pin set" keyword, such as
+# state or frequency. A test that sets something checks its keyword
+# first and skips on a tool that is too old for it. Only the "pin set"
+# usage is searched, a keyword that only "pin show" knows must not
+# count, and the keyword must stand on its own between blanks or
+# brackets, a hyphenated compound that contains it does not count.
+dpll_pin_set_supports()
+{
+	local usage
+
+	usage=$(__dpll_usage_block pin set) || return 1
+	grep -qE "(^|[[:space:][])$1([[:space:]]|$)" <<< "$usage"
+}
+
 # Detect the DPLL device to test. DPLL_DEV_ID may be set by the user to
 # force a specific device; an empty value means auto-detect, which takes
 # the first device that is not a dpllsim one, so that an instance of the
@@ -320,6 +359,41 @@ dpll_pin_get_state()
 	__dpll_pin_dev_field "$1" "$2" '.state'
 }
 
+# Return 0 when the pin advertises the given capability, named as
+# iproute2 prints it (state-can-change, priority-can-change, ...).
+dpll_pin_has_capability()
+{
+	local pin_id=$1
+	local name=$2
+	local out
+
+	out=$(dpll pin show id "$pin_id" -j 2>/dev/null) || return 1
+	jq -e --arg name "$name" \
+	   '(.pin[0]? // .) | .capabilities | index($name) != null' \
+	   <<< "$out" &> /dev/null
+}
+
+##############################################################################
+# Pin setters
+#
+# Every setter returns the status of the tool and keeps what the tool
+# printed on stderr in DPLL_LAST_ERR, the "Error: ..." line that carries
+# the extack message of the kernel, so that a caller can tell a refusal
+# it may skip on from a failure.
+
+DPLL_LAST_ERR=""
+
+# $3: connected / disconnected / selectable
+dpll_pin_set_state()
+{
+	local dev_id=$1
+	local pin_id=$2
+	local state=$3
+
+	DPLL_LAST_ERR=$(dpll pin set id "$pin_id" parent-device "$dev_id" \
+			     state "$state" 2>&1 >/dev/null)
+}
+
 ##############################################################################
 # dpllsim configfs interface
 #
-- 
2.56.0

