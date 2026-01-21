Received: from mail-dy1-f196.google.com (mail-dy1-f196.google.com [74.125.82.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E857E42B72F
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 21:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769032208; cv=none; b=Ii4jPy34XYzidrMzp/vxqN2UVdiKnzAne/WS2RRScyJi7sAdA1Y3OJr46aiEsQgxOY5Y03I//ET/zhEr78Bv8ehXJ6Cx426TAdXijN7NkyGU52GSrcyF4KTo1/b4exOqsTTo7JLEzF0lfGgjpGNy8geaXBjyQeYFvHVqa1z9Tpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769032208; c=relaxed/simple;
	bh=f0XtGBQbCFOrd3Lq8WEDogq8qdP2aAPuJxjV8kZYyxU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=swzzDsV97fxra7mo9X1rHJB6/L7LaaFsP1EJrsJtbjmiSEcyHLwQMQlpr/CfPWeGlycyvWdyOVGSEHVbFcxILWlZt1tYeZ6yTduYM+/tfSeyBXkFhFVavQIJAvURgrxIjVHuIhE4B2oZVkcj9bpJNPNV1ffm4m6SDP0s9sfSbPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=TuyS/Se0; arc=none smtp.client-ip=74.125.82.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="TuyS/Se0"
Received: by mail-dy1-f196.google.com with SMTP id 5a478bee46e88-2b71347ac0aso466141eec.0
        for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 13:50:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1769032205; x=1769637005; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LBJ+f7+TYiG375b9KrrBw24eToFYbOENYmfabxxmOsA=;
        b=TuyS/Se0nQlTzVnNpgsllCbW2OZajoiZn5pnxR84JGe1i94rAXwlbMaH6l1E/dIXE8
         MPqh/i6REEw+t/KWO0R9hP97iLZzkEphDqQh6P4m/abV9gPp2JtsMeQBdcQVJLZf7ZeU
         gsogDZeTQ8du4N8Sy0VsbOTV7FNnO1MQGSSX+28pevka/nGer+gBLZDsieJXBPaxL4OY
         I4+PV4lTI8lg8e19D0DRLIeufRXO7txfLPdZfTbhse0mk8hkVpNQ30F1eNwPqpZqc8v3
         Ucvbt73jksPUBll6g/u8EuXTUtfqXhD0hTLxn0PPRsLfqySGJw6Q/9bE1D/cKqniRua7
         QPVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769032205; x=1769637005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LBJ+f7+TYiG375b9KrrBw24eToFYbOENYmfabxxmOsA=;
        b=P1Pu8LJMpmeCodO/YxTRrLmUmBQSdo5ZDJdqYgdx3XHeOtbJP8TezjKViPcl6ppAY6
         jAzZYUXNc9IxNZeOodVhNW4B5y/7ShDRPBescrLGZ1OtphSlzHNTVqEn+tpUgkK+fm5M
         ZkP6l7M7I931x44NlmWnYipsFcyRKkRYnyBdksUHxnfHGzu3v9YjUz1IwzSMMeFadUEJ
         z2nj5HHCS5QkduJOOzN5Q/WU/7tP5htTlhtxBAVMJl0iSVQXOzinLcddLKaHO65WcBoJ
         ChlrAGiuSFlAG5KB2DTgQT5rE0KN70Yxvg6GnaNEpokY3M0hqOU/NMY1orzQNQlo5XsI
         /DNw==
X-Forwarded-Encrypted: i=1; AJvYcCU/7ywYWmYzYBIm9jB1OTDMUSFE6XyTqd1tOpHm1AdLR8kulcCyGPSJYG0cctTWW46E0wF6OjY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxOb727qGoQXjFqD9O8F3aSNIX16Z+avpKRARlrFAwUovXa5ITT
	9gZdJ8ErS42PN0+SioTOm6fVaO9SxT/XEbUdp9fMaSDqlqb9cIILxr576aNIcZf8TLAQibOHh6z
	PxKKxsw==
X-Gm-Gg: AZuq6aL0Pik5gEkjuZM0GxxOu+8r8aB/x3X1sHfneHx2/pOLPUCBYeZSWinDKuKgw1Z
	FaXJEhLSGfcQlMKRlZENzr8oID/eLHOvu7u3HUEEFfMo14qAKllicNIaQbQgXNS9SpTvafIgzrn
	Wg/I8FyUezz+v/VsAFsIzGyJzUHoICQ6RO7gbzE44e3JsVTyOevFmTlZ5WPVs/uBtsVOAgROfU7
	Jdsu7yofiI0UM5oJvgatwYLmtNhZbDVfZumVLkLiIl5GNtH6RzxJGa7FF7rsX1PvIVThN88vqfY
	hY7LMbrLU+yorQS6xV8EOs3HWIlbA3UFk5l8R1gBYLPydfotcQ7Va0AxrA6kwyZ11XC5ycLmezd
	/YgynpwaSRnfex+XCAWPqr3OkMi0uEKIXYCbTWzywE7JwkPXQUBF98j467JEDPbwiKrCN6oapEC
	72SoVgkRFH4KjWhKSJbVD8r4t9YmcQb0hHIDs8d1EChXQ+dH1UfAUALM86
X-Received: by 2002:a05:7301:1e92:b0:2ae:5915:47b8 with SMTP id 5a478bee46e88-2b7247c4221mr541913eec.13.1769032203489;
        Wed, 21 Jan 2026 13:50:03 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:30c4:fd82:1cb1:ed85])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b364579csm22774482eec.23.2026.01.21.13.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jan 2026 13:50:03 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v4 7/7] ipv6: Document enforce_ext_hdr_order sysctl
Date: Wed, 21 Jan 2026 13:49:25 -0800
Message-ID: <20260121214925.112604-8-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260121214925.112604-1-tom@herbertland.com>
References: <20260121214925.112604-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the enforce_ext_hdr_order sysctl that controls whether
Extension Header order is enforced on receive.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 Documentation/networking/ip-sysctl.rst | 29 ++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 5051fe653c96..f8fa9f67b2ed 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -2581,6 +2581,35 @@ ioam6_id_wide - LONG INTEGER
 
         Default: 0xFFFFFFFFFFFFFF
 
+enforce_ext_hdr_order - BOOLEAN
+	Enforce recommended Extension Header ordering in RFC8200.
+	If the sysctl is set to 1 then the ordering the ordering is
+	enforced in received packets and each Extension Header
+	may be present at most once per packet. If the sysctl is
+	set to 0 then ordering is not enforced and Extension Headers
+	may be present in any order and have any number of
+	occurences per packet (except for Hop-by-Hop Options). Also,
+	if the sysctl is set then Destination Options before the
+	Routing header are disllowed.
+
+	The Extension Header order is:
+
+	    IPv6 header
+	    Hop-by-Hop Options header
+	    Routing header
+	    Fragment header
+	    Authentication header
+	    Encapsulating Security Payload header
+	    Destination Options header
+	    Upper-Layer header
+
+	Possible values:
+
+	- 0 (disabled)
+	- 1 (enabled)
+
+	Default: 1 (enabled)
+
 IPv6 Fragmentation:
 
 ip6frag_high_thresh - INTEGER
-- 
2.43.0

