Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0A342FE042
	for <netdev@vger.kernel.org>; Sat,  8 Aug 2026 00:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786150653; cv=none; b=ZtHo3K/WfSxec+X9jlurf/030Xwqsdieg5UFshJiuHBM4hdJfxaitLAflGYjPCTSjS/iLaQMGIOAeTVGgCj3ZlsNQ3ty/12NmEoP2CZXft9kASfUvzN+yIHSR35XustJcDJ+YQemm1pjsurqbcPr1Q5vUQwWy5BZS2hVt3/nEyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786150653; c=relaxed/simple;
	bh=RXRTAXtIAvF5W4zhV9XvNk6Eqr4bA6CJDR4OTuU8uKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xkib00COcu1Kbt/1qtLRDkS/dQtVohkskAv3qCRE26CrIwTen0POGfn6zji4WeqHnsdfDcrzgub1RKprnHeTcjmWT2zzXJwlMlMSkJKrBCFx82Nn/XPxSwA2szADWZhcYeQUr4I5ew5D5jIpg9lNcLMKUkI1z512qUVneO15Cl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pvUFkvks; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pvUFkvks"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-382ef647e20so124463a91.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 17:57:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786150651; x=1786755451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=diMA3NQ10gzHFnNLk3VwTDac6B6hmowUzo1h66c0BkU=;
        b=pvUFkvksPeHuKWj+IZsJ7F5QsUK+omc8El8hI3uoMdXoUrbzGN666TcVLgyvIy1d+J
         JPib1bvOnnwLMazUztHEOBfk40VRUt6WHaAoKzpiWumEE9MGHMX6eNBYqK/VPU+AlmBv
         6Jag3WolleR5Agxewig03Ko8eazJHaLmRzSe/T4kgEld1LRmTQwiWSJsG7nxfe4Ar/1c
         w3xswLFdgX9novDK4vBG6tHEM614p6KC5YByy9xK32oawgaxMvD9c5fpiyXmS8xVzXHb
         k2nQrEKb7H1kEXkJpOZBqAgj2NaLnGh75eh5JW46fxrJ+7+6ZoC+D0U2+y1j5dUPHrBu
         3dww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786150651; x=1786755451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=diMA3NQ10gzHFnNLk3VwTDac6B6hmowUzo1h66c0BkU=;
        b=Kl/CyFsnaaSptq16U6nmKRfp517fFSZ2UGFJ0iXi29LPmKYlZwfbxfsztup2a20qq9
         7WmOWTaKrEswaE7ID9pMbnFr5CoXUUwyZd94L828dvIWTGGKIyfrLgQiqfDXXqiWpfCW
         rN/1Z5YPBhCVMJsJI2UnWNAPwcMd9TvEv2GEI9SDEx7kH25Q0JmPt2sov9qXm5dkrnAY
         vWEAwBY9eInLg2l3B8MPlWao3esB2QDURBODXDo0dPlmrIr3euPNI8Kr3fH0VctRb1I4
         xuDh10mt71xuRAs7PB+TpFiwbYF+RHly0e2HiVBOlsa8o2ZQ9cu5SJFVMB7B/D4bA0mT
         ds8Q==
X-Forwarded-Encrypted: i=1; AHgh+RrLZeqJBv4gmr7F0np4FSTJxgeSnK+d2ETl9yI6ybrfp66iZ7WHShWtF+PrgWdK70GiT1wHqK4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9YeujosIcyeuCaizdgKzTtX2uEDqhTd5HeZ24XMh1/oZn5Nkx
	4n2MF91Lbz6UiY6/ujB/a4/YKGek+ybsSSzWSNN/8Zoxn1i6l1pX6ezI
X-Gm-Gg: AR+sD13PMVvG5ghpvH6hih7nkw3LyeTJcQ/TaXmLNnRXu+YnRV9TbScv3xAmouQ8dRI
	HRqhrGNFvHbbbjyERxdSCLutUSHkuN9zmTR6CDcaRwum/OsnMoIhmBxHdz55n4hyZInRNGbwpG1
	kSEdwfKOKhSKxy9zwRBNF6g1elGD1B1ZqQdDjM9V6PlRsOWQj0JxB5jyRhhblc7nZ/Vs6S+QLAS
	FCYkAF+1a6wA2OcbWcEOWyn03rfmmpjuCi3e3ds0W1pUshM2DIIHCnL0vDOmNZp2qRZpsbxLKow
	jjzTPk9EDAEkVk8k7pq/B5i8ab3/RR/Kk8MV3JitNCWhH71YpULIuAqRlGCsNAj+v4MdyVpDhbN
	Lu5vXABYi3I1r+XfsXwt/SeDMJSMZLG6Cpdf+fesy4nsPf3s7avLRBhWi7rE3d2G+BtW7UyQBsv
	AUxqea1zEd3OgYYkp7V+etbxpwtPZamfxnb62zAfYG579CEUFV/dpBUNQYwhqONJ3g7pRN5GfSM
	j126iUz1DYYiAOm4/n0n4cOTvnoqU4FYQKpktP/2JVanKX4jS+zXii/xjU/RZo=
X-Received: by 2002:a17:90b:3985:b0:381:9028:5945 with SMTP id 98e67ed59e1d1-3903c58ee8emr25039098a91.14.1786150651049;
        Fri, 07 Aug 2026 17:57:31 -0700 (PDT)
Received: from m-upc-A520M-HDV.flets-east.jp ([2400:2410:3f60:500:d7e9:6449:7464:1dfa])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fc6c13asm4205182a91.2.2026.08.07.17.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 17:57:30 -0700 (PDT)
Sender: Yuyang Huang <uyoko90@gmail.com>
From: Yuyang Huang <sigefriedhyy@gmail.com>
To: Yuyang Huang <sigefriedhyy@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Chris J Arges <carges@cloudflare.com>,
	Daniel Zahka <daniel.zahka@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	David Wei <dw@davidwei.uk>,
	Dimitri Daskalakis <dimitri.daskalakis1@gmail.com>,
	Donald Hunter <donald.hunter@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shuah Khan <shuah@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Willem de Bruijn <willemb@google.com>,
	linux-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v6 09/10] netlink: specs: rt-route: add the route deletion reason
Date: Sat,  8 Aug 2026 09:56:41 +0900
Message-ID: <20260808005642.26901-10-sigefriedhyy@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260808005642.26901-1-sigefriedhyy@gmail.com>
References: <20260808005642.26901-1-sigefriedhyy@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the del-reason attribute and its enum to the route attribute set,
and to the getroute reply, which the route notifications reuse.

The attribute is absent from the newroute and delroute request lists.
RTA_DEL_REASON is above strict_start_type in rtm_ipv6_policy, so
encoding it in a request is rejected with -EINVAL.

Signed-off-by: Yuyang Huang <sigefriedhyy@gmail.com>
---
 Documentation/netlink/specs/rt-route.yaml | 34 +++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/Documentation/netlink/specs/rt-route.yaml b/Documentation/netlink/specs/rt-route.yaml
index 9f4a1a253676..253037ea5176 100644
--- a/Documentation/netlink/specs/rt-route.yaml
+++ b/Documentation/netlink/specs/rt-route.yaml
@@ -78,6 +78,27 @@ definitions:
       -
         name: rta-used
         type: u32
+  -
+    name: del-reason
+    type: enum
+    name-prefix: rt-del-reason-
+    enum-name: rt-del-reason
+    doc: |
+      Why the kernel deleted a route. New causes may be appended. The
+      value space is family-agnostic, a value is never reinterpreted
+      per address family.
+    entries:
+      -
+        name: unspec
+        doc: The deletion path does not record a cause.
+      -
+        name: expired
+        doc: The RTF_EXPIRES lifetime ran out and the route was garbage
+          collected.
+      -
+        name: ra-withdrawn
+        doc: A Router Advertisement withdrew the route with a zero
+          lifetime.
 
 attribute-sets:
   -
@@ -185,6 +206,18 @@ attribute-sets:
         type: u32
         byte-order: big-endian
         display-hint: hex
+      -
+        name: del-reason
+        type: u32
+        enum: del-reason
+        doc: |
+          Emitted only on RTM_DELROUTE notifications, and only when the
+          deletion path records a cause. An absent attribute means
+          either an older kernel or a deletion path that does not
+          record its cause, consumers must treat absent and unspec
+          identically. Currently only IPv6 deletion paths record a
+          cause. The attribute is notification-only, the kernel rejects
+          it in requests.
   -
     name: metrics
     name-prefix: rtax-
@@ -299,6 +332,7 @@ operations:
             - dport
             - nh-id
             - flowlabel
+            - del-reason
       dump:
         request:
           value: 26
-- 
2.43.0

