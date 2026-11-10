Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794332892;
	b=3h1/dZTqgekQI2CT0hDgYC7nSRNCYCjMtz5OgpZ0GkJwuMwYDjkhJE/gMNhXv4WbryoB
	 FUeOGyijuQqXsZEjiIXN2oMb9cwrv87zlAfvu605mOgSDkyjSMidGMimd5jIigq9Pui68
	 iXAlWzfXSDRrNuWjsF4rvgU6Yt5X1GaHT2YGqPITMDbFm8lWQiuO8ft2yz+j7Zy9V40sS
	 btQdsiG6iWWkBuebZqT2wjNCW20CEI35UQznhsAxhZ7gOE/MF5FmaQexdhhfd2jpTMSKJ
	 9lO2XCSyso5bZPAK+z4QEMenDygtTBY5mQrSEOQ+X9rUZygKEHmk6WMLJrHkO/CUAYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794332892;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=2BNJp0XaEeEgA/wSoQsOlakc4WKHeFEPgbgErfDCVmc=;
	b=E5yz55hDF/WCo7U3xVJh0HzSxzRll0yQmWGyJxEC/+is/+m6HnEvmuQmUiVwgwvU0k/d
	 E3p5FrdDrAZ3KF9Zne3y9XYON9ExO5UD6aHcH3k4GitvwIHenhDBiXwaPcTFtRsli7k/s
	 W6yakMkE8U9OdwH0tnVts3Lbkt05EibQNb3+1bnB0ZnOMLIJPo/M81RSpo/OYmFI2Qahz
	 Z/853NMa0IyGwYR6C0Tb+yWMt9WVn3QZ3Drjo7QXWxaWIgFmEIasg7HFJwERBwFdO9mPe
	 1/WNlepBWRey2fMrLRS7XNZ/hwurak7jkblAPNntAFQMyd5+pk+SJeZC+U/0+E9Ys0Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B6LFUkag;
	arc=none smtp.remote-ip=209.85.210.53
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41DE7606A31C
	for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 17:48:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 41DE7606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=B6LFUkag
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-846566246e8so2087890a34.1
        for <netdev@vger.kernel.org>; Tue, 10 Nov 2026 09:48:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794332891; x=1794937691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2BNJp0XaEeEgA/wSoQsOlakc4WKHeFEPgbgErfDCVmc=;
        b=B6LFUkagIVAIeplmBpD3YlE0rKu10cgbYC9mFPBREX1MUZG7uTe3cfm4mkd4LtbNYG
         X6de6oS6f++I3QcOv/+dHMAcGTKXgQxwA7WbjtmkGnpl+0OToiXGz7TU/kYp4B40X2wW
         J0ZzIn2NQnxY/jBAiQK5vJcVuAnBJS1TYblLKdzoqJxEGjnH9fxd8bdLR+7fknOwwfXi
         wpofQna4V4mlzDYejAmbMYIhE1OujT3EQRsmBrPB1tpZqr0s9XrpSHsYHnWfXMwDOr4O
         U8qC0CPG49GjNyO9OaGg7Twl+1IhbCegrNYZ3tyKzkSxompDS9LUulr/tKX2VjBGzTvS
         l+Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794332891; x=1794937691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2BNJp0XaEeEgA/wSoQsOlakc4WKHeFEPgbgErfDCVmc=;
        b=x6GQOJiMtJOUa4ib79MDM8BaFLoe5hnxG3tdxB7T6OL9ESvMkHbDonZQxCK8rKpHux
         jjk2hs/Ngxn76UU4lCctMEDUMVeepNQr9qW5V1eb7Aba7H8fPqmJoDDoZUupAAxGqekb
         MM3uiagj6v5H6Km5P4f42qCYAShuxZEFyYjRnTSZ1Sg17lHLWz8PUwgTz1JTG86jOP35
         8ZTQ/Drga81hNi2mLUq9rCsxtQxAxVdphCw3ZD4eqPvNWPtl3vb5mczlac8NIJtIoXTy
         vc43rTvTdbHgFPt8AUSKs1IDwkc7dZanEv9JzVQTi1EcJvxoQOUwTa7Wq7n6pUIU1B+C
         N9Mw==
X-Gm-Message-State: APuU4Z+xxiyjgnWzvBA/eotKRI/YSiFT8TA5FlTDb+wczpuHpz+5ol9I
	OMFOXAt3goR03bCTP7e9blcwmff98qOSHcdJJWDlfx65ty4PUyBAwr3CDDg0BIKo
X-Gm-Gg: AYBFou0TPw7KNGc0kygJopeqizNrRW2dbKaNs3lnJKzEt9K/DVfY/jlBSRLxuBADapZ
	AtSdAzF52MQG9751xPG2IjoILCAp1G9FSDhnVf/hewPfUsToY366y4hcqaKp3JR60A23thACvYS
	zvYleDG/Tij22PyZ1qmKRB41/beOrkJgLAPPwBl0nUPFgxCnXHF2qzfY0358TzOd8h5DpcncbmY
	icYYTOTWsBGVU7mJYWXMQVHntJimPry7pE1QrcbsXY6tFtiksuYVbnrXw1ZeiwWRhhz9sDemOwR
	bWUx70OKvERsGMphr7Hsbu+VXqvDxbmF2StiwqbB0Jqwg7gB+3Qod57xwzNt1O9FAKffFkKQfwL
	4Vd8YSAXyirfpPslEQ9bSAJCV7d+0zwMYWqZXvsNB44wwpgYtB1jCYuuXCZU9oe2PgZwEHcjfxy
	4Fkk5AXwNVg8PkiCbLJedfHVev0P9tyvszUpqXpZ9tGjonfSgkO37OD2y2IIoaY5gXiWf0KNOzs
	QJUG/sf+39hNRTn2Ujo1om1L7HhqFidSJzaeC3GBRA2+pq9Q9w87S79IooJ1Z8317MTwu7ePEKp
	gLTclgVGHcFwA9ue/Eo/jlq1
X-Received: by 2002:a05:6830:2e12:b0:846:6f06:33d9 with SMTP id 46e09a7af769-860f03a92e4mr124893a34.31.1794332890959;
        Tue, 10 Nov 2026 09:48:10 -0800 (PST)
Received: from houminxi ([61.170.225.237])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-860dca42411sm2389254a34.1.2026.11.10.09.48.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 09:48:10 -0800 (PST)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	dev@openvswitch.org
Subject: [PATCH net-next v7 1/2] netlink: specs: add ovs_flow del and set operations
Date: Tue, 10 Nov 2026 12:47:50 -0500
Message-ID: <20261110174751.973464-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261110174751.973464-1-houminxi@gmail.com>
References: <20261110174751.973464-1-houminxi@gmail.com>
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
neither a key nor a ufid, or no key and a ufid longer than 16 octets, and
set looks a flow up by key or by ufid.

List the attributes each command reads. new reads ufid-flags and probe as
well as the key, so those go in its request list. new, del and set need
CAP_NET_ADMIN.

A dump reads ufid-flags and nothing else. It shared the get request list,
which let a client send a key and a ufid the kernel ignores, so give it a
request list of its own. The reply stays the same as for get.

probe was binary while the kernel policy is NLA_FLAG, so a client that
wanted to raise it had to send an attribute with no body. As a flag the
generated setter takes no value.

The key and the actions docs called those attributes always present in
notifications. A flow identified by a ufid sends neither when the request
asked for it to be left out, and a get reply follows the same rule. A
dump also leaves the actions out when they do not fit in the message.

The key doc said a key is required for every request except a dump. The
kernel accepts a ufid with no key, but a get and a set need one of the
two, and a set that replaces the actions needs a key. A new request needs
a key, including one that finds an existing flow and replaces its
actions.

The ufid doc promised that the flow is indexed by that value, which does
not hold for a value the kernel rejects. A value longer than 16 octets is
read as if the attribute were absent, so a new request indexes the flow
by its key instead, and a del that carries no key flushes the data path.
A zero length value fails the policy check before the command runs and
the request fails with -ERANGE. A dump does not read the attribute at
all.

The get reply carries the last-used time, the stats and the TCP flags,
which ovs_flow_cmd_fill_stats() fills for get and for dump. The reply
list named only the stats, so a generated client parsed neither of the
other two, and their own docs called them notification-only. List them
and say where they appear.

Fix the same sentences in the uapi header: the spec text was copied from
there, and the two descriptions disagreed once this patch changed the
spec.

The ops skip strict and dump validation in the kernel, so the spec says
so for get, new, del and set.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 Documentation/netlink/specs/ovs_flow.yaml | 102 +++++++++++++++++-----
 include/uapi/linux/openvswitch.h          |  35 +++++---
 2 files changed, 105 insertions(+), 32 deletions(-)

diff --git a/Documentation/netlink/specs/ovs_flow.yaml b/Documentation/netlink/specs/ovs_flow.yaml
index 951837b72e1d..d7aeeeb5a3cc 100644
--- a/Documentation/netlink/specs/ovs_flow.yaml
+++ b/Documentation/netlink/specs/ovs_flow.yaml
@@ -383,41 +383,50 @@ attribute-sets:
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
+          del that carries neither a key nor a ufid flushes the data path, and
+          so does one that carries no key and a ufid longer than 16 octets.
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
         struct: ovs-flow-stats
         doc: |
-          Statistics for this flow. Present in notifications if the stats would
-          be nonzero. Ignored in requests.
+          Statistics for this flow. Present in replies and notifications if
+          the stats would be nonzero. Ignored in requests.
       -
         name: tcp-flags
         type: u8
         doc: |
           An 8-bit value giving the ORed value of all of the TCP flags seen on
-          packets in this flow. Only present in notifications for TCP flows, and
-          only if it would be nonzero. Ignored in requests.
+          packets in this flow. Only present in replies and notifications for
+          TCP flows, and only if it would be nonzero. Ignored in requests.
       -
         name: used
         type: u64
         doc: |
           A 64-bit integer giving the time, in milliseconds on the system
           monotonic clock, at which a packet was last processed for this
-          flow. Only present in notifications if a packet has been processed for
-          this flow. Ignored in requests.
+          flow. Only present in replies and notifications if a packet has been
+          processed for this flow. Ignored in requests.
       -
         name: clear
         type: flag
@@ -438,18 +447,22 @@ attribute-sets:
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
+          value of the OVS_FLOW_ATTR_KEY attribute. A value longer than 16
+          octets is treated as if the attribute were absent, so a new flow is
+          indexed by its key. A zero-length value is rejected with -ERANGE.
+          Optional for all requests. Present in notifications if the flow was
+          created with this attribute. A dump does not read it.
         display-hint: uuid
       -
         name: ufid-flags
@@ -969,25 +982,35 @@ operations:
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
+            - used
             - stats
+            - tcp-flags
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
@@ -995,6 +1018,45 @@ operations:
             - ufid
             - mask
             - actions
+            - ufid-flags
+            - probe
+    -
+      name: del
+      doc: |
+        Delete one flow, or every flow in the data path. A request that
+        carries neither a key nor a ufid flushes the data path, and so does
+        one that carries no key and a ufid longer than 16 octets.
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
index 440825e65837..3f18f59e91dc 100644
--- a/include/uapi/linux/openvswitch.h
+++ b/include/uapi/linux/openvswitch.h
@@ -624,24 +624,33 @@ struct ovs_nsh_key_md1 {
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
+ * actions.  A dump reads neither of the two, and a del carrying neither a
+ * key nor a ufid flushes the data path, as does one carrying no key and a
+ * ufid longer than 16 octets.
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
  * @OVS_FLOW_ATTR_STATS: &struct ovs_flow_stats giving statistics for this
- * flow.  Present in notifications if the stats would be nonzero.  Ignored in
- * requests.
+ * flow.  Present in replies and notifications if the stats would be nonzero.
+ * Ignored in requests.
  * @OVS_FLOW_ATTR_TCP_FLAGS: An 8-bit value giving the OR'd value of all of the
- * TCP flags seen on packets in this flow.  Only present in notifications for
- * TCP flows, and only if it would be nonzero.  Ignored in requests.
+ * TCP flags seen on packets in this flow.  Only present in replies and
+ * notifications for TCP flows, and only if it would be nonzero.  Ignored in
+ * requests.
  * @OVS_FLOW_ATTR_USED: A 64-bit integer giving the time, in milliseconds on
  * the system monotonic clock, at which a packet was last processed for this
- * flow.  Only present in notifications if a packet has been processed for this
- * flow.  Ignored in requests.
+ * flow.  Only present in replies and notifications if a packet has been
+ * processed for this flow.  Ignored in requests.
  * @OVS_FLOW_ATTR_CLEAR: If present in a %OVS_FLOW_CMD_SET request, clears the
  * last-used time, accumulated TCP flags, and statistics for this flow.
  * Otherwise ignored in requests.  Never present in notifications.
@@ -655,9 +664,11 @@ struct ovs_nsh_key_md1 {
  * should be suppressed.
  * @OVS_FLOW_ATTR_UFID: A value between 1-16 octets specifying a unique
  * identifier for the flow. Causes the flow to be indexed by this value rather
- * than the value of the %OVS_FLOW_ATTR_KEY attribute. Optional for all
+ * than the value of the %OVS_FLOW_ATTR_KEY attribute. A value longer than 16
+ * octets is treated as if the attribute were absent, so a new flow is indexed
+ * by its key. A zero-length value is rejected with -ERANGE. Optional for all
  * requests. Present in notifications if the flow was created with this
- * attribute.
+ * attribute. A dump does not read it.
  * @OVS_FLOW_ATTR_UFID_FLAGS: A 32-bit value of OR'd %OVS_UFID_F_*
  * flags that provide alternative semantics for flow installation and
  * retrieval. Optional for all requests.
-- 
2.56.0

