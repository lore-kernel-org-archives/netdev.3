Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.167.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332841;
	b=AfcK46OIHvRba3iRdVnwW1SqMUZd2lAGi8VmPHGIVbmJHJ5qnwVomGeDaMcrMDnRn+uU
	 pdOhxdypHIBAp/EH4V3VUbfWInb2TDez9+ox5wgEndqYh6xJXQhUHFyCpQA4IY5ljvWmk
	 lD5//7ayTFdycSUcmKHmFQIw1fJDXgq3hDxJNO1zoN5la3HSjrLaarVFCCxCss29LGRtY
	 XbEi/YKQ4O96UeGqBLJYkgnkzDCKBpJRaQYOdZVVGHrY9l5ctzuoz5GaICwK+1iQwriZJ
	 CY5l3J1oF4wLguKzrTnFRY2H/I3ExOCnxm9L3h+gPdpu1PDYxeE+O4eHGjPe8Qj80yA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332841;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=R/VVIrZF33zZNNLK4F0UO/Zo9290InoyHrFWxhianmE=;
	b=1uj9/LCdpe/Fu6ZNhcVjj3Gn/sGQR9CCIMViUi4d8rJKVJxjiW0fz1qQVnDD7Afs3qGY
	 2xUxqRSU6s54hzh6qgNZAoUll+ovmn0oZNOsVcrEVC+qxmygQ+pz7REqnc2ogGwyVYVV6
	 M+vwUNSmjrGz50k7ge9T7fQ3LZKepA8knnN7CX+OYyiEnDbxYE1fcW0TEPrw8GgTgQi55
	 R3iPr+VHpuZJ9hD/BghipOKJ4gffNQaUu06pM1l0Xs6bCLf/rQZSaWytNCutxLbgO6Zt+
	 S9OYwpnThqqDRhx7on11NJplqj9GCBnK5t0g7m9A45fPkkGOHE1KGbzfGAVd3SmSW1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gaE73fgn;
	arc=none smtp.remote-ip=209.85.167.171
Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE6D606A325
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:47:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3CE6D606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gaE73fgn
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-4f48d91ba7dso1245250b6e.2
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794332839; x=1794937639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=R/VVIrZF33zZNNLK4F0UO/Zo9290InoyHrFWxhianmE=;
        b=gaE73fgnAlZD9KkO9sZ6NryD0ZsN4hskEm5BizeCw1X6QVgp+0/i6xHIKvGwV9ecY0
         O5uCACHUxgqVitQNb4EAtVmkcsnvqKRA4o2rbJg6GCfcMdRtvO0V54NkdpmKezs5I5yU
         W7bAIUqtX/PNjKdVPPlYGoUdnj5j0CHDY/a4DnS84wkouXyZhjifZz2WtZricIQqDNY/
         FoqtQ9wli+eDjqOyMJpMjBqRfSSSNHYOuOGIoDvwMP+qhNL4fSQB/sieq5endjugEjRo
         FwRDzryX9YEQLIuzR6Ox5UUNMxj2UYZhlfBc0LTDJVQHQ17FwtxF64q1/6M9QuHaStED
         ThTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794332839; x=1794937639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R/VVIrZF33zZNNLK4F0UO/Zo9290InoyHrFWxhianmE=;
        b=PE87+klZR5nznWQKYvwKGla/+Dttx8YA9RLQ9fvmnN6ZkmmBf3s0eO9J3RYdBdd2H1
         H8tmQnVUXmsUwGjxquuO8JMsZMMSZzU7DMm1tnSyTXcwaDzmlQSIEYrn5+JZBlKyP0Pz
         q/YC2Wl7E0/+jhYgwPXhiXy8r0c+AYP4O0KqZXYJTRgY+SorwuSXVWRD4smRAKwF+CPV
         lvWWe8jVLmURodnGsqs+Ii0VXQ6QU2V0yrZQoPKIL2/ybZQydWlLYO4UdK7VEwslo4iA
         /TIZinonRKFzBCHRz0vNzJsvKL80Nttl6BkKO7M2T4m7fVMRBHaTd3Ocu3rwykLKp6ud
         MvIw==
X-Gm-Message-State: APuU4Z+FcZ/ldqoGdlW6C9NdwEhL/Ka0OAeIam6Dx3n1Sc99SQj0a0k2
	Telm8JziXoUjNCR2PIQVv+xGjRSkQt4sEQrdY2GgmXoIoGzqIe6ZIa/zucaZ+dMH
X-Gm-Gg: AYBFou3/3/WYbXO37KGA6hxHhU6hmtZeKiwRHZSltYVVt6ZZBDvQOvnTfqyq/yB3E3H
	bgrNy38vxpY657Kd00Q8ltYmQWXI3aupGPzzcyDlouU54t0Qg7cMp6rX79+mCAny+pd1vAeVtfR
	fdTzQaPR3WbBsPC8lj63c4JH9lWEa1HH+A5AYzv0hWIjF62rtFElHVkBcA7/U+hvuSBR3Cyj7Qg
	eN3h9cC8zVZBm5l2plFXfrY0h9BpORCZYL48fgDun542Bn54RaTeJmqaeNm7EanrsCPh3SfgTKD
	gDUsU+tf6BxpnWnIP7kIppWX7DijqcpkcEJANr1p8uzrkl19Twf1haMVVCdjUudX/XpvzD9oOR2
	aBSQe+cAcRh3ca7/kwPiBh8p8QPBs1dW+8BGTHLoRJf04+nS3O8cpDTbgzdRvnMpst1xRuXDFII
	NObuOdWuKFYWAvQ9oVJf6tRrIsw43oNqGhBA4nUHNrgRzR44r0RK2Yg42F2dj9XtXminb5u5/SD
	LO6vtrszvN8fDArru9itHB3s2dubmLzzihLg8mu99SU4yzOG9M5mryWxjkusBhLQhWEQnsNECV6
	GCQeoteYe7DwAo+9s+cxSRFG2WINrhcwAPdEKEftm++Rmg==
X-Received: by 2002:a05:6808:159f:b0:4d6:90f3:74a1 with SMTP id 5614622812f47-5683ccd209amr2548440b6e.44.1794332839046;
        Tue, 10 Nov 2026 09:47:19 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-56905f2faf5sm2667315b6e.13.2026.11.10.09.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:47:18 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Paul Blakey <paulb@nvidia.com>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Shuah Khan <shuah@kernel.org>,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net v3 2/2] selftests/net/openvswitch: check that a failed set keeps the features
Date: Tue, 10 Nov 2026 12:46:51 -0500
Message-ID: <20261110174651.972936-3-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110174651.972936-1-houminxi@gmail.com>
References: <20261110174651.972936-1-houminxi@gmail.com>
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

Add a set-dp command to ovs-dpctl for the kernel's datapath SET command,
and two tests that use it.

The first test clears the features of a fresh datapath, sets the dispatch
bit with a valid pid list, and then sends a set that would set the same
bit with an empty per-cpu-pids. The request has to fail with EINVAL and
the datapath has to keep reporting the features it had. It then sends
OVS_DP_CMD_NEW for that name from an outdated client, which makes the
kernel drop the features, and checks that a further set still works.

The second test does the same for the recirc bit. A datapath can only
hold that bit when the tc skb extension is compiled in, so the test
prints the reason and skips when the kernel answers EOPNOTSUPP, and any
other failure of that request fails the test. CONFIG_NET_TC_SKB_EXT
depends on CONFIG_NET_CLS_ACT and both sit under CONFIG_NET_SCHED, so the
selftest config fragment selects all three.

The two set rounds fail without the fix in the previous patch. The
rejected set then leaves the datapath reporting 0x8 where it reported
0x0, and 0x8 where it reported 0x4 in the recirc test. The reference
count itself is not visible from user space, so the outdated client
rounds only show that those paths run and that a datapath keeps working
across them.

set-dp sends the features it is given. When --features is left out it
sends the features the datapath reports, and it refuses to send the
request when the datapath reports none. A pid list that is not a list of
numbers is reported as such, and empty entries are dropped.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 .../testing/selftests/net/openvswitch/config  |   3 +
 .../selftests/net/openvswitch/openvswitch.sh  | 126 ++++++++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    |  60 +++++++++
 3 files changed, 189 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/config b/tools/testing/selftests/net/openvswitch/config
index 15685d242813..38fa1477b7cd 100644
--- a/tools/testing/selftests/net/openvswitch/config
+++ b/tools/testing/selftests/net/openvswitch/config
@@ -2,10 +2,13 @@ CONFIG_GENEVE=m
 CONFIG_INET_DIAG=y
 CONFIG_IP_SCTP=y
 CONFIG_IPV6=y
+CONFIG_NET_CLS_ACT=y
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NET_IPGRE=m
 CONFIG_NET_IPGRE_DEMUX=m
+CONFIG_NET_SCHED=y
+CONFIG_NET_TC_SKB_EXT=y
 CONFIG_NF_CONNTRACK=m
 CONFIG_NF_CONNTRACK_OVS=y
 CONFIG_NF_CT_PROTO_SCTP=y
diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 21444657a040..d22f4f535beb 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -24,6 +24,8 @@ tests="
 	nat_connect_v4				ip4-nat-xon: Basic ipv4 tcp connection via NAT
 	nat_related_v4				ip4-nat-related: ICMP related matches work with SNAT
 	netlink_checks				ovsnl: validate netlink attrs and settings
+	dp_features				ovsdp: rejected set keeps bits
+	dp_features_recirc			ovsdp: recirc survives rejection
 	upcall_interfaces			ovs: test the upcall interfaces
 	tunnel_metadata				ovs: test extraction of tunnel metadata
 	drop_reason				drop: test drop reasons are emitted
@@ -1409,6 +1411,130 @@ test_netlink_checks () {
 	return 0
 }
 
+ovs_dp_features_set() {
+	python3 $ovs_base/ovs-dpctl.py set-dp "$@"
+}
+
+ovs_dp_features_check() {
+	python3 $ovs_base/ovs-dpctl.py show "$1" |
+		grep -q "features: 0x$2\$"
+}
+
+# The number of an errno outside the base list differs by architecture.
+# EINVAL is in the base list and is 22 everywhere.
+ovs_errno() {
+	python3 -c "import errno; print(errno.$1)"
+}
+
+# dp_features test
+# - a set with the dispatch bit and pids is accepted and reported back
+# - a set with an empty per-cpu-pids is rejected with EINVAL and leaves
+#   the features as they were
+# - an outdated new request drops the features, and sets work afterwards
+test_dp_features() {
+	local t="test_dp_features"
+	local dp="dpfeat0"
+
+	sbx_add "$t" || return $?
+	ovs_add_dp "$t" "$dp" || return 1
+
+	info "clear the datapath features"
+	ovs_sbx "$t" ovs_dp_features_set "$dp" --features 0 || return 1
+	ovs_sbx "$t" ovs_dp_features_check "$dp" 0 \
+	    || { info "features were not cleared"; return 1; }
+
+	# 8 is OVS_DP_F_DISPATCH_UPCALL_PER_CPU, the bit that makes the
+	# kernel read per-cpu-pids.
+	info "a set with the dispatch bit and pids is accepted"
+	ovs_sbx "$t" ovs_dp_features_set "$dp" --features 8 \
+	    --per-cpu-pids 1,2 || return 1
+	ovs_sbx "$t" ovs_dp_features_check "$dp" 8 \
+	    || { info "the accepted set was not applied"; return 1; }
+
+	ovs_sbx "$t" ovs_dp_features_set "$dp" --features 0 || return 1
+
+	# ovs-dpctl sends the empty list as an attribute with no payload,
+	# which is what the kernel rejects.
+	info "a set with an empty per-cpu-pids is rejected"
+	ovs_sbx "$t" ovs_dp_features_set "$dp" --features 8 \
+	    --per-cpu-pids "" &> /dev/null
+	[ $? -eq 22 ] \
+	    || { info "the empty per-cpu-pids set did not fail with EINVAL"; \
+		 return 1; }
+
+	info "the rejected set keeps the features it had"
+	ovs_sbx "$t" ovs_dp_features_check "$dp" 0 \
+	    || { info "the rejected set was recorded"; return 1; }
+
+	# An outdated client that asks for an existing datapath again makes
+	# the kernel drop its features. The datapath keeps working.
+	info "an outdated new request drops the features"
+	ovs_sbx "$t" ovs_dp_features_set "$dp" --features 8 || return 1
+	ovs_sbx "$t" python3 $ovs_base/ovs-dpctl.py add-dp "$dp" -V 1:0 \
+	    &> /dev/null
+	ovs_sbx "$t" ovs_dp_features_check "$dp" 0 \
+	    || { info "the outdated new request did not drop the features"; \
+		 return 1; }
+	ovs_sbx "$t" ovs_dp_features_set "$dp" --features 8 \
+	    || { info "the datapath stopped accepting sets"; return 1; }
+	ovs_sbx "$t" ovs_dp_features_check "$dp" 8 \
+	    || { info "the reset datapath took no features"; return 1; }
+
+	return 0
+}
+
+# dp_features_recirc test
+# - a datapath that holds the recirc bit keeps it across a rejected set
+# - an outdated new request drops the features
+# - the bit needs CONFIG_NET_TC_SKB_EXT, so the test skips without it
+test_dp_features_recirc() {
+	local t="test_dp_features_recirc"
+	local dp="dpfeat1"
+
+	sbx_add "$t" || return $?
+	ovs_add_dp "$t" "$dp" || return 1
+
+	ovs_sbx "$t" ovs_dp_features_set "$dp" --features 0 || return 1
+
+	# 4 is OVS_DP_F_TC_RECIRC_SHARING. The kernel takes the bit only when
+	# the tc skb extension is compiled in.
+	ovs_sbx "$t" ovs_dp_features_set "$dp" --features 4 &> /dev/null
+	rc=$?
+	if [ $rc -ne 0 ]; then
+		eopnotsupp=$(ovs_errno EOPNOTSUPP)
+		if [ -n "$eopnotsupp" ] && [ $rc -eq "$eopnotsupp" ]; then
+			# Say it on stdout: a skip that only reaches debug.log
+			# leaves CI with a pass and no sign of the missing
+			# coverage.
+			printf "# tc skb extension is not compiled in," \
+			       "skipping recirc\n"
+			ovs_exit_sig
+			return $ksft_skip
+		fi
+		info "the recirc set failed with $rc"
+		return 1
+	fi
+	ovs_sbx "$t" ovs_dp_features_check "$dp" 4 \
+	    || { info "the accepted recirc set was not applied"; return 1; }
+
+	info "the rejected set keeps the recirc bit"
+	ovs_sbx "$t" ovs_dp_features_set "$dp" --features 8 \
+	    --per-cpu-pids "" &> /dev/null
+	[ $? -eq 22 ] \
+	    || { info "the rejected set did not fail with EINVAL"; return 1; }
+	ovs_sbx "$t" ovs_dp_features_check "$dp" 4 \
+	    || { info "the rejected set dropped the recirc bit"; return 1; }
+
+	info "an outdated new request drops the features"
+	ovs_sbx "$t" python3 $ovs_base/ovs-dpctl.py add-dp "$dp" -V 1:4 \
+	    &> /dev/null
+	ovs_sbx "$t" ovs_dp_features_check "$dp" 0 \
+	    || { info "the outdated new request did not drop the features"; \
+		 return 1; }
+
+	return 0
+}
+
 test_upcall_interfaces() {
 	sbx_add "test_upcall_interfaces" || return 1
 
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 1615843c225e..e7e9d8bedf97 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -2301,6 +2301,24 @@ class OvsDatapath(GenericNetlinkSocket):
 
         return reply
 
+    def set(self, dpname, ifindex=0, features=None, per_cpu_pids=None):
+        msg = OvsDatapath.dp_cmd_msg()
+        msg["cmd"] = OVS_DP_CMD_SET
+        msg["version"] = OVS_DATAPATH_VERSION
+        msg["reserved"] = 0
+        msg["dpifindex"] = ifindex
+        msg["attrs"].append(["OVS_DP_ATTR_NAME", dpname])
+        if features is not None:
+            msg["attrs"].append(["OVS_DP_ATTR_USER_FEATURES", features])
+        if per_cpu_pids is not None:
+            msg["attrs"].append(["OVS_DP_ATTR_PER_CPU_PIDS", per_cpu_pids])
+
+        reply = self.nlm_request(
+            msg, msg_type=self.prid, msg_flags=NLM_F_REQUEST | NLM_F_ACK
+        )
+
+        return reply[0]
+
     def create(
         self, dpname, shouldUpcall=False, versionStr=None, p=OvsPacket()
     ):
@@ -2961,6 +2979,23 @@ def main(argv):
     deldpcmd = subparsers.add_parser("del-dp")
     deldpcmd.add_argument("deldp", help="Datapath Name")
 
+    setdpcmd = subparsers.add_parser("set-dp")
+    setdpcmd.add_argument("setdp", help="Datapath Name")
+    setdpcmd.add_argument(
+        "-f",
+        "--features",
+        type=lambda x: int(x, 0),
+        default=None,
+        help="Datapath user features, defaults to the current value",
+    )
+    setdpcmd.add_argument(
+        "-p",
+        "--per-cpu-pids",
+        type=str,
+        default=None,
+        help="Comma separated upcall pids, an empty string sends none",
+    )
+
     addifcmd = subparsers.add_parser("add-if")
     addifcmd.add_argument("dpname", help="Datapath Name")
     addifcmd.add_argument("addif", help="Interface name for adding")
@@ -3057,6 +3092,31 @@ def main(argv):
             ovspk.upcall_handler(ovsflow)
     elif hasattr(args, "deldp"):
         ovsdp.destroy(args.deldp)
+    elif hasattr(args, "setdp"):
+        rep = ovsdp.info(args.setdp, 0)
+        if rep is None:
+            print(f"DP '{args.setdp}' not found.")
+            return 1
+        pids = None
+        if args.per_cpu_pids is not None:
+            try:
+                pids = [int(x) for x in args.per_cpu_pids.split(",")
+                        if x != ""]
+            except ValueError:
+                print(f"invalid per-cpu-pids: {args.per_cpu_pids}")
+                return 1
+        features = args.features
+        if features is None:
+            features = rep.get_attr("OVS_DP_ATTR_USER_FEATURES")
+            if features is None:
+                print(f"DP '{args.setdp}' does not report its features")
+                return 1
+        try:
+            ovsdp.set(args.setdp, rep["dpifindex"], features, pids)
+        except NetlinkError as ne:
+            print(f"set failed: {ne.args[1]}")
+            return ne.code
+        print(f"DP '{args.setdp}' updated")
     elif hasattr(args, "addif"):
         rep = ovsdp.info(args.dpname, 0)
         if rep is None:
-- 
2.56.0

