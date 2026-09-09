Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4956857EDBC
	for <netdev@vger.kernel.org>; Wed,  9 Sep 2026 13:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788960792; cv=none; b=JLgoNXLD8dKNEbHpy0OkaXj4dW68tjNggZCzuG08Nq2QwzgCUYVsZROPXDhVfccCAkTp8exO6zf6wV1U/N2W2lNAElI2Uh1zY5uPMDNy05KpYCq64SAGy74uVGfKhrcoe3EZM0TjoszCcaJqsjEEYwfNhLUNlbnDJI6RFcs93wQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788960792; c=relaxed/simple;
	bh=qsiqMuArg+phRO/CZK4fjvwQbx/TLhJpLu6XR38eEAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPV0kpHrbTGJccVn4H22G7MuBGwvpLM+0N3/gx5nudHnriYOPZCRZPLh20uf88oy1B3mCSuNv6LdlJYIxf6JuQ+sJmXJ9oGYC6LWXVXviekG6n7QrHsfv2wBzuQaoNszAiGnGPbOajIR79KX4Q44xaOanJypXoi41ZmkQbD+axg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PY04WZOG; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PY04WZOG"
Received: by mail-pj2-f12.google.com with SMTP id d9443c01a7336-2d747ed9866so2349885ad.2
        for <netdev@vger.kernel.org>; Wed, 09 Sep 2026 06:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788960790; x=1789565590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t98tjzsG8/T0rL7P+QBPi2WVtiRsIvKfY/FD1komk1Y=;
        b=PY04WZOGxfszPss/uQln5LFYecmkAmAk9RUjQr5IOR5Jnfj/tYlA6y7/DJLNdT34CP
         20GUQgNV/w5+8u1E6hHnLQXfiZiHWrjfjWp5snSW9CbZxsC8Wn5ixHswAf4Mm5iQwN9J
         8nsfHxjALJcno7EnvlfaGaIYKuPP5o1DXhM80SSenA349ejZm+8hwmDXWXp0sOgxi/2k
         T/LIOZc9Pngp0v5aVBQmJJyM/dMG9sGTGrBTTzyvsilbLj5mI3SlROfaxR4VkkaQ49SC
         8j2Qx5V4bsEgtfR+Xy1ma/D4W6aJymcfLiVgIVUzVfk8tOFpdt4u7tlK8VuNN9AfwLf4
         wGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788960790; x=1789565590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t98tjzsG8/T0rL7P+QBPi2WVtiRsIvKfY/FD1komk1Y=;
        b=P8lHV/k7MK39dh0xUrrjoXtqidNdG+ucFi1XKR0w+7zmqBuF5Vio8tckJKNWtdTyzb
         7wxG9oIDDXP9WKE0qLp8pRLsBInvHfJwGNjyrZYdBk2MLlh+iHl3a0hKQiYznqVMi5z7
         xXx7654lMi/XSDg/+1QjdtILkNXfI23Q2bL2iXie5RU78Nztx97ZzPRgx5kN8VzKxlig
         B3+/KPG7zwS/i6Qye3VzcNdxAmc8u3mUUKC4HbZiEwKVRMxFgHBYY3SqugtiLQHCQmlH
         W9ekpiTeQJIJqv7rETvtcn3PhWUTu+2UhlhQ9mWHiHAIayrsKUgKm2Sohq15EZdajh2I
         fHTw==
X-Forwarded-Encrypted: i=1; AKwUvByR+211o5/OenS1KGXwCVYKzHMt5SryV//maaIazBOfkGCp/FlAuEza4DNn0HM+ZkqqYrcKIDk=@vger.kernel.org
X-Gm-Message-State: AFuF++mQo95A3J1vwMYpQW+Kngc87A3+ZUJtt15RjJVTZM8NVQyNjjl0
	ySMqJv6WJtMjvWtg4IyGHykkTDnWTWkvi3Z8BK4MU+MIN2ryrJKRGpiO
X-Gm-Gg: AYBFou2gr7WlsB3iztndIhVNCNxnZ+tLJBt5sgz/j0b4LWL7994103ZcOZq5GKWEd64
	eBTNIU28fj8iVo/+62E0SJurHw8NrUjbOuGKcF2q6LRqvGulzuXL0GBObkeevdB9EL9c1RBK+/H
	XnjQZQnBb/ZU6tuBcybOiQfKyBy/tnVpcFK8ncDZnS+JxoOA8EaV2kGlrb8PkRwcTRrQynOYToa
	kj0HBLwPM5Lwd4FVu1ywEeGL7+rd0mxEcXpU7YLRhIVMVUtfVoyalnXvCnRpyoydkeiuIG/w+Iw
	/kGuNwN02W7UznfS862RIbzlCvhtym/O1dNcFR0axHDnpz6U9UvKDqX2xYi6pwHR2Yi9j/6To/p
	5cIIYbgGRUaBmhgtaxuef8O+efWPrDdMVF89c6tI0lPxaGbkdxs+R8/m6HFCob1Kt+ssaaH37Dn
	UUMcnvQCuQvd17Q5Wthx+dJtng73e1HnV3C3wWr3uEEaHq+enf8IcmJFS5bt0T4ZRN+96Lw+5Gd
	LKGlLSV9CPgUGWxx7Fsgohh1YbFr4ZmE0eWVidIJsvQYuBtS77Od1JUJUNvDQ==
X-Received: by 2002:a17:903:2f91:b0:2da:f1b1:56c4 with SMTP id d9443c01a7336-2dd077e1033mr17795275ad.3.1788960790302;
        Wed, 09 Sep 2026 06:33:10 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:574b:e1a5:307b:15c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2db14ae8af3sm72564185ad.80.2026.09.09.06.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 06:33:09 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	Nicolas Dichtel <nicolas.dichtel@6wind.com>,
	Nikolaos Gkarlis <nickgarlis@gmail.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf.kernel@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 3/4] netlink: specs: rt-addr: document AF_PACKET multicast dumps
Date: Wed,  9 Sep 2026 22:32:46 +0900
Message-ID: <20260909133247.113923-4-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260909133247.113923-1-sigefriedhyy@gmail.com>
References: <20260909133247.113923-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the global flag, list the attributes the AF_PACKET dump uses and
describe how ifa-family selects IPv4, IPv6 or link-layer output for
RTM_GETMULTICAST.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 Documentation/netlink/specs/rt-addr.yaml | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/Documentation/netlink/specs/rt-addr.yaml b/Documentation/netlink/specs/rt-addr.yaml
index 17ead2203451..adf82b69ade7 100644
--- a/Documentation/netlink/specs/rt-addr.yaml
+++ b/Documentation/netlink/specs/rt-addr.yaml
@@ -77,6 +77,8 @@ definitions:
         name: mcautojoin
       -
         name: stable-privacy
+      -
+        name: global
 
 attribute-sets:
   -
@@ -168,7 +170,13 @@ operations:
           attributes: *ifaddr-all
     -
       name: getmulticast
-      doc: Get / dump IPv4/IPv6 multicast addresses.
+      doc: |
+        Get / dump multicast addresses. ifa-family selects the address
+        family: AF_INET or AF_INET6 for the IP multicast groups joined on
+        a device, AF_PACKET for the link-layer multicast addresses in the
+        device filter. Link-layer entries added explicitly, e.g. with
+        SIOCADDMULTI or "bridge fdb add ... self", rather than by a
+        protocol join are reported with the global flag set.
       attribute-set: addr-attrs
       fixed-header: ifaddrmsg
       do:
@@ -181,10 +189,13 @@ operations:
             - multicast
             - mc-users
             - cacheinfo
+            - flags
+            - target-netnsid
       dump:
         request:
           value: 58
-          attributes: []
+          attributes:
+            - target-netnsid
         reply:
           value: 58
           attributes: *mcaddr-attrs
-- 
2.43.0

