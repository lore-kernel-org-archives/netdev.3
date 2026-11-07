Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794053230;
	b=3ZgNfG/TKzviCwNYgsJA6f7kF4NV2518M6KS+Pb8aLDd6vn4y8ZsC072/6b16n3nfKvI
	 HS3X9GME2lWkA+djmcs9KKLvXbAI65cJJflrBSCC1U5EjQT6CSNh/e75jZrzdYPJFR1Rv
	 fkgQo3TwcsOhbl66ewGp8hVDFM6aWqtwPBm11N2e7dzGekmLXqDsfLPx6ryT2/D5xxOKv
	 q8ECOFRrSYtzluag4FpSUpdB1LW6KeuyIZf4pfPwiOvhdGcPf2RczWhlkqSZgSKH1mto+
	 CUYwxLyZQCQARzdGZDzmMQloLRwFlkDaBxOHUvRsqyV8jZA41V8aCKOAHZJ/NnLHWrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794053230;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yLYelWlzZbcAyDESwlZ+3oqhRhUvbgMxRgZ3XTVSRbc=;
	b=maA/NQ4c5Ej92pKYPIw5iIDPC4ehuO3Nx0wvDLZHOklkwkmfmaBd6VsAyVcLGbqTQBRw
	 eBk+L4AsY8Twxzo/mWysxZF/uc9dMKk+QAxWgS9QCutiTAA7dwrLDv4jw5TpiXw2U1vkD
	 NQ9Axdnmo7DKyRsuDRK4EnUiiV37alOFaJt35LmC3L9SY1ASjCPoH1EWhBNgly2fuCMrb
	 ZzYV/nWWn0BIE1qV0wowkb8ltIWMeOnBX5Y/S9wPNc8D7CeeEdEVrNTa4JfMXfmJK+j0/
	 yVc5ax/2Hlz5+XP04NZZGyXCryKN65vrHSJ58axNw1953rYV0KtWRyXmTAUlSyBoljA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="g/idRoYd";
	arc=none smtp.remote-ip=74.125.224.51
Received: from mail-yx1-f51.google.com (mail-yx1-f51.google.com [74.125.224.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81397606A32C
	for <netdev@vger.kernel.org>; Sat,  7 Nov 2026 12:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 81397606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=g/idRoYd
Received: by mail-yx1-f51.google.com with SMTP id 956f58d0204a3-6774639a8a4so1366605d50.0
        for <netdev@vger.kernel.org>; Sat, 07 Nov 2026 04:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794053228; x=1794658028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yLYelWlzZbcAyDESwlZ+3oqhRhUvbgMxRgZ3XTVSRbc=;
        b=g/idRoYdgqmXq/TogYu2NL/u2aF2vjfb7XJgJ46abv4A/ZAVps6IIxZgVQABqEDCRM
         J/oT1/KHAz1htZu3cJBJMpI6qWr1anBwTdN3v1EOKAm4wfcuCK9XTWevaqHxDurHZ3oB
         mQtUJqnay84Ew/KkMaqKsX/ClvMEyxUBXS5SfCZWJbKr+uFLYJo1tGYc+JqJlIa6m7IC
         91IzJsm9vUuu/Deapo6M3FamSkf9BLAqvHUlJcYxSszyLOsFcNyqTSWyafyxNwcfgPkT
         JhvYROoJWR3rIYbaPSJGfFBOZmBZnlfLmtkNDL3wlj4WIt7Az+k3aBka4mIOWUgmbQvI
         7LXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794053228; x=1794658028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=yLYelWlzZbcAyDESwlZ+3oqhRhUvbgMxRgZ3XTVSRbc=;
        b=r7YLqgQejg2R1IwomysymWrJIYE5o7PjLjNRDAP7cbfvWgG4RlhvQTY9SpVQTMOzcy
         rnf5eDWnydYj1cLjV8pl4LYmmhAKnionqZ/TKdvcJA1iYLzcmtTcBCqZ1JQyA7CBfSPM
         gHcrrf18ZHyiFF+nO91nO6/NABSgTPKXLM0JTumcqaeKUqYdOWRmqN2bu6WaV1LCvcbA
         TQiM8l9GJ+KW1/NzK3fTn2bZj5cOAmHxEdy2eaK7NP0SBa0nW4BJdtVyD/QobaNNetu3
         +4ZblzEbn8qzTs9oIiEWEtJ1+SrY4ClJfe0xKVmOz5ZzMAQvokU7khHxU1m7z6YT3nnT
         CS0w==
X-Gm-Message-State: APuU4Z9H3UjQzQJIT8kEYi38HrcSsVtSt/QopxUbjQUXofNi6zY23/Me
	QYHvvK1XvvwExBcpNe68X6UMIPMpZzkYW7MB+qDxb+NzzkfBDW2becq3yGYouJoc
X-Gm-Gg: AYBFou2HqCDF1vIUR6m5yvD3q8riireOKHsQIUrCFMPHR2eTEO/n+GQ6R7Z6iaA3PKy
	IDcHepIl6e3zNjjjf6LDBHa3dy2Rb3iYY+BnTmp+OntqqB4sL4G6ITNy9QTm4+GuD4yrxRtESJT
	nwZPP5dtp1FI/FJIHF50Q1i+a06EmLuOUARdeyoMyclqnmS49DLK4xlq+Co4FQjBv0ETFbHsdZU
	JYegDM0Io6shbyWANvxEuWh5hOLQQDxkLjuTBYpsklKKFLtummqqf3Ikjz/Ro3IsM7HKlPrlMF/
	ZioEa8uQoQK/jqASGtgqHdr0JBAtc8efCc7Xu8+rtau/5W2eiZCI/A2rYRelyWYoJt429Yk2uA9
	ugnKlDJYuAdejsCeSXoSKYoIS2qq0TOkaEbICxS9XqpTzPx5ymR7N1HLC+5D3tIVM/LXH2cRA+w
	T33WyYlfNwqTxcvMw+zcdVXj0n5C3pOfjmA2XHiEH6XNqOmlFy2dudq8rnfsoUFJfpnLib6lQFP
	UrV4KqjYBfWId5ICykVkiuqRx/20RdciFd+TNWo1m+L0iGk7k4TtwETKOPefB1NkuevCryREAAu
	7SOYz84nlHdWiKNIjucx7pcD
X-Received: by 2002:a05:690c:16:b0:8b3:47fd:a035 with SMTP id 00721157ae682-8b347fdb145mr18976467b3.62.1794053228421;
        Sat, 07 Nov 2026 04:07:08 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b33f77055bsm39518927b3.8.2026.11.07.04.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Nov 2026 04:07:08 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	dev@openvswitch.org,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>
Subject: [PATCH net-next v6 1/2] netlink: specs: add ovs_flow del and set operations
Date: Sat,  7 Nov 2026 07:06:46 -0500
Message-ID: <20261107120647.874906-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261107120647.874906-1-houminxi@gmail.com>
References: <20261107120647.874906-1-houminxi@gmail.com>
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
family was added: del flushes the data path when a request carries no key
and no valid ufid, and set looks a flow up by key or by ufid.

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
kernel accepts a ufid with no key, but a get and a set need one of the
two, and a set that replaces the actions needs a key. A new request needs
a key, including one that finds an existing flow and replaces its
actions, and a del that carries no key and no valid ufid flushes the data
path.

The ufid doc promised that the flow is indexed by that value, which does
not hold for a value the kernel rejects. Anything outside 1-16 octets is
read as if the attribute were absent, so a del with such a ufid and no
key flushes the data path, and a new request indexes the flow by its key
instead. Say so, and record the minimum length the policy enforces in the
attribute.

Fix the same sentences in the uapi header. The spec text was copied from
there, and the two descriptions disagreed once this patch changed the
spec.

The ops skip strict and dump validation in the kernel, so the spec says
so for get, new, del and set.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 Documentation/netlink/specs/ovs_flow.yaml | 86 +++++++++++++++++++----
 include/uapi/linux/openvswitch.h          | 23 ++++--
 2 files changed, 88 insertions(+), 21 deletions(-)

diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
index 951837b72e1d..bfdbf55bc219 100644
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
+          del that carries no key and no valid ufid flushes the data path.
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
@@ -438,18 +446,22 @@ attribute-sets:
           are exact match bits.
       -
         name: probe
-        type: binary
+        type: flag
         doc: |
           Flow operation is a feature probe, error logging should be suppressed.
       -
         name: ufid
         type: binary
+        checks:
+          min-len: 1
         doc: |
           A value between 1-16 octets specifying a unique identifier for the
           flow. Causes the flow to be indexed by this value rather than the
-          value of the OVS_FLOW_ATTR_KEY attribute. Optional for all
-          requests. Present in notifications if the flow was created with this
-          attribute.
+          value of the OVS_FLOW_ATTR_KEY attribute. A request that carries a
+          value outside that range is treated as if it carried no ufid, so a
+          new flow is indexed by its key. Optional for all requests. Present
+          in notifications if the flow was created with this attribute.
+          Ignored in a dump.
         display-hint: uuid
       -
         name: ufid-flags
@@ -969,25 +981,33 @@ operations:
       doc: Get / dump OVS flow configuration and state
       value: 3
       attribute-set: flow-attrs
-      do: &flow-get-op
+      dont-validate: [strict, dump]
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
+      dont-validate: [strict, dump]
+      flags: [uns-admin-perm]
       do:
         request:
           attributes:
@@ -995,6 +1015,44 @@ operations:
             - ufid
             - mask
             - actions
+            - ufid-flags
+            - probe
+    -
+      name: del
+      doc: |
+        Delete one flow, or every flow in the data path. A request that
+        carries no key and no valid ufid flushes the data path.
+      value: 2
+      attribute-set: flow-attrs
+      dont-validate: [strict, dump]
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
+      dont-validate: [strict, dump]
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
index 440825e65837..4c5625c8c1cf 100644
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
+ * actions.  A dump reads neither of the two, and a del carrying no key and
+ * no valid ufid flushes the data path.
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
@@ -655,9 +662,11 @@ struct ovs_nsh_key_md1 {
  * should be suppressed.
  * @OVS_FLOW_ATTR_UFID: A value between 1-16 octets specifying a unique
  * identifier for the flow. Causes the flow to be indexed by this value rather
- * than the value of the %OVS_FLOW_ATTR_KEY attribute. Optional for all
- * requests. Present in notifications if the flow was created with this
- * attribute.
+ * than the value of the %OVS_FLOW_ATTR_KEY attribute. A request that carries
+ * a value outside that range is treated as if it carried no ufid, so a new
+ * flow is indexed by its key. Optional for all requests. Present in
+ * notifications if the flow was created with this attribute. Ignored in a
+ * dump.
  * @OVS_FLOW_ATTR_UFID_FLAGS: A 32-bit value of OR'd %OVS_UFID_F_*
  * flags that provide alternative semantics for flow installation and
  * retrieval. Optional for all requests.
-- 
2.56.0

