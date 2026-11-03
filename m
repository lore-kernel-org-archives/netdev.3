Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793730818;
	b=pCLIwagf/VG2QK4wdf9JAWCHPtB3PtGcppMwzRS792l4yiBycnzWpc3EWchPbbuPZvW4
	 4TBYOrLQ1oFkFWZyAi4aJvzHci8cqwP+i61YI1bof1aKr5QktM/74vkLAcpfHero8Piwy
	 KL8Nc1byXZR2nEu+KZkTPkWpOR0WQUSXNbMnXih6tiZ4S1Ain2S1G9jpt5NY0QGfs0H/3
	 ZxHSNaJE3++QqDly395zCVol3ZeynTwpNrZ3TlLwbJkJ3r7ss2OnWhXELhtKzmHzOauej
	 v34lWxDMvMvxQqhrlGo/0Q5pxJaALGDTxB+j0bMCuedkpvPLsPX+WObtOtL8Smqvy9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793730818;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=z4A50IYJlUSL3ecbFXam+OCYwWYNMkNL30RovVUG41E=;
	b=Ev35E6Z3CF+rqa4XHfF+Xa2KcQTa9ds/jZbuqpLgeHwG82YkEArSOdR4bYSvvY7nC90V
	 xKVA/L/3XdAHrk/J6CLBEphTJWqUQSfJWo4PXSf4kLiA0zxMcgEff93wy1VddCz5uDvKr
	 VSZD1fVfJ0Hq0AYxuRxlaKm+lDmIK0IQqdWmGjsKhlntt5D4Jty1oS8ZGpURQgWdB8rt9
	 sTqP4GcCbYxqpymWxsRKpfewSPQKvUncOr9BSFJLkZe0q/74v1Incz1DOHcq8SreImJa6
	 vReGYWiVQUYkvz3wENqSjoC8OyWdg19g2KQDfqDK6E2kHwPDaufTtsDbqniGerbohyw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b5Fpf784;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68A9606A329
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 18:33:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C68A9606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b5Fpf784
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93f3c895a0eso410163285a.2
        for <netdev@vger.kernel.org>; Tue, 03 Nov 2026 10:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793730817; x=1794335617; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=z4A50IYJlUSL3ecbFXam+OCYwWYNMkNL30RovVUG41E=;
        b=b5Fpf784TQETNXJ4Y4g9Y2KTuvc+lXpyqZCgOvOfmPUElj158tbBT19p45AkHdna54
         HJiolSJtsa4N1vWO2ZRKYYxAAZk5ssx/jkgH17Q+q61GEmErpJHUmMpe4ymYaXeW6lwG
         CPKwFaUMB9IvvLPxYZo9dG+bWjuYuUnS52nBcHTwOhDmnlUTlxSTu2YQK1h7xxqe/Tvk
         QG0cwhD3+gcY+CqIItlE1U/KPA64oUkX8qky104cWjxGV3VxGg1hLrmdYTlNS5RE97R9
         b79XJLq4x0WuCRBOw6nx0eZBTaKdF9iKqQUAembduVFkIRAFBgy/4H7tOemRuG1X0GAm
         Oa5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793730817; x=1794335617;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=z4A50IYJlUSL3ecbFXam+OCYwWYNMkNL30RovVUG41E=;
        b=OTSKrhHqQgn9NkQafWDNljXzQfpctILZspr8+SIBxn+bY+T9n84GS7GGWfrIO45fs2
         E6QD3CCwhfyOzqx9T3DCiTVGpHo1x5rl70gwV2iaNDMuI2w8ZMJiKJGT8qdqt16vwOym
         BcycuTkokMU94iIkZ0vSorWprNWQxo+k9mkRPiCj8KlmArRwDjH0Z5twhxixCMzTyDAL
         VAo/A7tmuCUD1szdeI/Wz+ofsqWh0DPNOZn8tSznQOklmd1uK/PSZnEzl+NMGd4XB+aN
         8xp32o4T5nhvYHLkjnstnaj2zl7P6mQ5zrhsQPnN929Ci7hVfRnC/GqgfiUtBiadldS4
         I8pQ==
X-Gm-Message-State: APuU4Z/Zy5AXjCxLBvfuEgsJDW0n9kJDCoM9G2Abqns9tllMyYZ58iEm
	M7mwnV/zZvJCiRsuxf11TtdFebaNzkGKV3YEdpHHggDPby75ezCcqwgo967a2FY8
X-Gm-Gg: AYBFou1zg1V6GQUHErBGPYe+o5xIp8ZYxapHJiiyHzDcoOz+Sc2yXqcsTUjcOzkyRws
	MJjyxRoUzxQj+zWtalIsvfKXf7Vs6KdXUlN6GFk74uvCPDIwSQMpD2HI0YrdJQiSf5vzIDm4Az1
	q4tiMPNwuUOzXDRb9sfbk6F9cDrol00rDCLMkA9eH6nmGxJm14NBIt+FNol61nlykD3ayjY5hYN
	df0enE2A7Jn2MowPOJyn4FIAseh6IKNbK5LXm58zwtxY3Dc6TopTyQnNloXx4/pyGggsxJnAL2Q
	FZY/xtYPJ+cMA3+3p2p6P7OYxaQyfh8fhfwUxJsCNPSFHsqlhZ996mAjx5cch3UE3k6izAchUsu
	cYCSBwSe6YONCrB69dRSyiHVBSqhCkvR6v8cxUp3b1HCam8uYkEk4G4kbpE96X6pNVyfmqBsGYC
	kIpU6TKYi5b68Vjbfy9gZhENW3gE3wjDGX15Nhr7tNDnwS8+xJl0W2+0Ryc5wtZl1c1TsOv/Ure
	YIT9wO60X6yzauv5h3P/x1NM0o9PEmXGCWruho5wTu78SjBzkgnxKE7YWVuSH6XYrG+BRh23dP9
	wIx/CM3hj0EEffTsRXPmndBw
X-Received: by 2002:a05:620a:2603:b0:93e:c12c:43ff with SMTP id af79cd13be357-9442172a752mr2298884285a.76.1793730816559;
        Tue, 03 Nov 2026 10:33:36 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d468fbe9sm1912585a.3.2026.11.03.10.33.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 10:33:36 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next v5 1/2] netlink: specs: add ovs_flow del and set operations
Date: Tue,  3 Nov 2026 13:33:18 -0500
Message-ID: <20261103183319.2730567-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261103183319.2730567-1-houminxi@gmail.com>
References: <20261103183319.2730567-1-houminxi@gmail.com>
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

The ovs_flow spec described get and new only, so a YNL client could not
delete or modify a flow. Both commands have been in the kernel since the
family was added: del flushes the data path when a request carries
neither a key nor a ufid, and set looks a flow up by key or by ufid.

List the attributes each command reads. new reads ufid-flags and probe as
well as the key, so those go in its request list. new, del and set need
CAP_NET_ADMIN.

A dump reads ufid-flags and nothing else. It shared the get request list,
which let a client send a key and a ufid the kernel ignores, so give it a
request list of its own. The reply stays the same as for get.

probe was binary while the kernel policy is NLA_FLAG. A YNL client leaves
out a false flag, where it sent an empty binary attribute before.

The key and the actions docs called those attributes always present in
notifications. A flow identified by a ufid sends neither when the request
asked for it to be left out, and a get reply follows the same rule. A
dump also leaves the actions out when they do not fit in the message.

The key doc said a key is required for every request except a dump. The
kernel accepts a ufid with no key, but a get and a set need one of the two,
and a set that replaces the actions needs a key. A new request needs a key,
including one that finds an existing flow and replaces its actions, and a
del that carries neither flushes the data path. The ufid doc says a dump
ignores that attribute.

Fix the same sentences in the uapi header. The spec text was copied from
there, and the two descriptions disagreed once this patch changed the
spec.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 Documentation/netlink/specs/ovs_flow.yaml | 76 +++++++++++++++++++----
 include/uapi/linux/openvswitch.h          | 17 +++--
 2 files changed, 75 insertions(+), 18 deletions(-)

diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
index 951837b72e1d..bbfa2c1b7466 100644
--- a/Documentation/netlink/specs/ovs_flow.yaml
+++ b/Documentation/netlink/specs/ovs_flow.yaml
@@ -383,19 +383,27 @@ attribute-sets:
         type: nest
         nested-attributes: key-attrs
         doc: |
-          Nested attributes specifying the flow key. Always present in
-          notifications. Required for all requests (except dumps).
+          Nested attributes specifying the flow key. Present in replies and
+          notifications, except for a flow identified by a ufid when the
+          request asked for the key to be left out. A get, set or del may
+          carry a ufid instead of a key; a get and a set need one of the
+          two, and a set that replaces the actions needs a key. A new
+          request needs a key, including one that finds an existing flow and
+          replaces its actions. A dump reads neither the key nor the ufid. A
+          del that carries neither flushes the data path.
       -
         name: actions
         type: nest
         nested-attributes: action-attrs
         doc: |
           Nested attributes specifying the actions to take for packets that
-          match the key. Always present in notifications. Required for
-          OVS_FLOW_CMD_NEW requests, optional for OVS_FLOW_CMD_SET requests.  An
-          OVS_FLOW_CMD_SET without OVS_FLOW_ATTR_ACTIONS will not modify the
-          actions.  To clear the actions, an OVS_FLOW_ATTR_ACTIONS without any
-          nested attributes must be given.
+          match the key. Present in replies and notifications, except when
+          the request asked for the actions to be left out, and in a dump
+          when they do not fit in the message. Required for
+          OVS_FLOW_CMD_NEW requests, optional for OVS_FLOW_CMD_SET requests.
+          An OVS_FLOW_CMD_SET without OVS_FLOW_ATTR_ACTIONS will not modify
+          the actions. To clear the actions, an OVS_FLOW_ATTR_ACTIONS
+          without any nested attributes must be given.
       -
         name: stats
         type: binary
@@ -438,7 +446,7 @@ attribute-sets:
           are exact match bits.
       -
         name: probe
-        type: binary
+        type: flag
         doc: |
           Flow operation is a feature probe, error logging should be suppressed.
       -
@@ -448,8 +456,8 @@ attribute-sets:
           A value between 1-16 octets specifying a unique identifier for the
           flow. Causes the flow to be indexed by this value rather than the
           value of the OVS_FLOW_ATTR_KEY attribute. Optional for all
-          requests. Present in notifications if the flow was created with this
-          attribute.
+          requests. Present in notifications if the flow was created with
+          this attribute. Ignored in a dump.
         display-hint: uuid
       -
         name: ufid-flags
@@ -969,25 +977,31 @@ operations:
       doc: Get / dump OVS flow configuration and state
       value: 3
       attribute-set: flow-attrs
-      do: &flow-get-op
+      do:
         request:
           attributes:
             - key
             - ufid
             - ufid-flags
-        reply:
+            - probe
+        reply: &flow-get-reply
           attributes:
             - key
             - ufid
             - mask
             - stats
             - actions
-      dump: *flow-get-op
+      dump:
+        request:
+          attributes:
+            - ufid-flags
+        reply: *flow-get-reply
     -
       name: new
       doc: Create OVS flow configuration in a data path
       value: 1
       attribute-set: flow-attrs
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
@@ -995,6 +1009,42 @@ operations:
             - ufid
             - mask
             - actions
+            - ufid-flags
+            - probe
+    -
+      name: del
+      doc: |
+        Delete one flow, or every flow in the data path. A request with
+        neither a key nor a ufid flushes the data path.
+      value: 2
+      attribute-set: flow-attrs
+      flags: [uns-admin-perm]
+      do:
+        request:
+          attributes:
+            - key
+            - ufid
+            - ufid-flags
+            - probe
+    -
+      name: set
+      doc: |
+        Modify an existing flow. The kernel rejects the request with
+        -EINVAL when it carries neither a key nor a ufid. Replacing the
+        actions also needs a key: a ufid on its own is not enough.
+      value: 4
+      attribute-set: flow-attrs
+      flags: [uns-admin-perm]
+      do:
+        request:
+          attributes:
+            - key
+            - ufid
+            - mask
+            - actions
+            - ufid-flags
+            - clear
+            - probe
 
 mcast-groups:
   list:
diff --git a/include/uapi/linux/openvswitch.h b/include/uapi/linux/openvswitch.h
index 440825e65837..318209873e26 100644
--- a/include/uapi/linux/openvswitch.h
+++ b/include/uapi/linux/openvswitch.h
@@ -624,11 +624,18 @@ struct ovs_nsh_key_md1 {
 /**
  * enum ovs_flow_attr - attributes for %OVS_FLOW_* commands.
  * @OVS_FLOW_ATTR_KEY: Nested %OVS_KEY_ATTR_* attributes specifying the flow
- * key.  Always present in notifications.  Required for all requests (except
- * dumps).
+ * key.  Present in replies and notifications, except for a flow identified
+ * by a ufid when the request asked for the key to be left out.  A get, set
+ * or del may carry a ufid instead of a key; a get and a set need one of the
+ * two, and a set that replaces the actions needs a key.  A new request needs
+ * a key, including one that finds an existing flow and replaces its
+ * actions.  A dump reads neither of the two, and a del carrying neither
+ * flushes the data path.
  * @OVS_FLOW_ATTR_ACTIONS: Nested %OVS_ACTION_ATTR_* attributes specifying
- * the actions to take for packets that match the key.  Always present in
- * notifications.  Required for %OVS_FLOW_CMD_NEW requests, optional for
+ * the actions to take for packets that match the key.  Present in replies
+ * and notifications, except when the request asked for the actions to be
+ * left out, and in a dump when they do not fit in the message.  Required
+ * for %OVS_FLOW_CMD_NEW requests, optional for
  * %OVS_FLOW_CMD_SET requests.  An %OVS_FLOW_CMD_SET without
  * %OVS_FLOW_ATTR_ACTIONS will not modify the actions.  To clear the actions,
  * an %OVS_FLOW_ATTR_ACTIONS without any nested attributes must be given.
@@ -657,7 +664,7 @@ struct ovs_nsh_key_md1 {
  * identifier for the flow. Causes the flow to be indexed by this value rather
  * than the value of the %OVS_FLOW_ATTR_KEY attribute. Optional for all
  * requests. Present in notifications if the flow was created with this
- * attribute.
+ * attribute. Ignored in a dump.
  * @OVS_FLOW_ATTR_UFID_FLAGS: A 32-bit value of OR'd %OVS_UFID_F_*
  * flags that provide alternative semantics for flow installation and
  * retrieval. Optional for all requests.
-- 
2.56.0

