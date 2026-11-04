Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793794645;
	b=Sl47GfduBKP+OiNahIPM8DMk9+ejXpiTs2L2c+elWNIjVfJypmb4JGqu2RarwhTvaYaV
	 J07gMRsbmAsOe/nOr8N3GlbD3UvdfimVrIshK4LivzoAxKyi92nIKTzc2Jbzy+lkLb8Zz
	 uCP1MfdIGCuWwAQf5cpM0yKxWrJLC1T72/RUuB/1IHwYGPZZz2qJh4cmCZ8mk6X77Bv60
	 fdwuXcXhT1KlP7sML237PI84zW6g7mZ9aQwLSj1Rkg9+59PefGuUD5ahCUV0AHct0Iok1
	 1HGGGwOKXLzBw9/8NUt3jCkvlzJetMmcjV6pF6Du1+8XzkxSq7N2E4XHccYSZqsRPzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793794645;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=GeF5kqhjYg76FiDQFTLk3CgPjL/qABFp98p09W1WKJA=;
	b=VF0C90lnyw8ZG0aUKCja/oxYsru8vtPa/DmgUPab9a4fWoKO2DYN9CGsSSPqZZm2iplg
	 xlmXdDg0cxU9HQE47TkiGJ2p3K3lM8pvRYPusDhtfLdzUYLLzsMWpk9pwmzRJ8JYg0GHG
	 WaCkaojBc87C4+k5H8VKnS1g3vkCjJjOQY5gUbfS82eLctCRR3aZM+6o4IVqnLyjvxirW
	 ZfsK1iiNhvE5IPcAItxLRCJdyVq4s7oz40rZk2ryweHqhZDz4s6njUgtHhOGz8M2VhHLl
	 bbY+cElTR31/CLf2pj1w2yIRwFP0PUG4Wzy8evftIKpoPj+1XGqcfXmunTkvt3QK7kg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZaoYLiYK;
	arc=none smtp.remote-ip=74.125.82.172
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com [74.125.82.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A187606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 12:17:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A187606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZaoYLiYK
Received: by mail-dy1-f172.google.com with SMTP id 5a478bee46e88-369f33df08eso1041296eec.0
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 04:17:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793794644; x=1794399444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GeF5kqhjYg76FiDQFTLk3CgPjL/qABFp98p09W1WKJA=;
        b=ZaoYLiYK3a3zD75MckhXgtoas0jInCoU58ox9eowCZPdk0R/ZyTQbO+ZJlhyHTrhRJ
         vHYD6pqDp8kj8acZECXfxBnz45Z/+9cI88QzZBgobnkEQEX9iGzPae4kIj/cszkNG/LI
         00qbw3o/tQtonIgDSnlH/ey4mAuckJwUt9Vq6DzUSqjMe5SQE/cPJ6e/JC9VFta36QwH
         F8Q9L/DKXwncU3gtMSSJ+Ny0KUW5+L9Vm2pDIKMiJr/05FUbaAXFGAwm780WCzb0FvSt
         r2Z+8FajrfXTdGtYHkCgE6BPeZLNdFok4FsebzXMpjHMYXz7JlTAKOoAPD56jSswrb7l
         L2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793794644; x=1794399444;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GeF5kqhjYg76FiDQFTLk3CgPjL/qABFp98p09W1WKJA=;
        b=ABjjjTnUBp4Qv0goe1uEKLU5JM+ZM203DeBL2+wkxO0ETyoFWan4AAUI3Pxh61Nqh4
         qZ32Y6yDEd8YMu/eS2R1oBaMrIanUjvcP/ELW55NYKIDpXK4C1Cm7EbKrGryKrC2Db2l
         KJg+zwYElZ4O082MjBoj9v5VvD2ja/Oro+3mDc1UQAWZPGRse+qHo9qjuLwCEVctJpRm
         ilI9nvRIHRSGFMQwxFWLWeRK171PIp9Y58Bp5gzj4E3YKcNLdqtzvMUA3LPvR6onCVOm
         HHOAtbmI7exI/EymPgqV2GVFUtjuus9HnyYzHajADTVK25zkyutuveb2g0dVU0clrbRF
         nI5w==
X-Gm-Message-State: APuU4Z8gh1Ez7YV5m4JmCLsW6I9yHg/C78Qvj46tnb1iIa0+a5rOdK1D
	Zyfu3gDcjicIU2scZTkWbt5jhtxojg1kBwM7t/oUntCob43aef6BgKd6+YHuug==
X-Gm-Gg: AYBFou06GqrSwq4LlhEgEZaB5x5t+tGsDE+QpcX9YqjJvsz0vvyjPB1aWUI4y8WO/fA
	0CxT3t7MvpiGMAycg3TMZuAFSEDPu4v8hOglHCizoYjOtUmuuvpZLDF74Afi2kW/tOykpSOt0AE
	H+G0S+p1hrlxGHfwokVVKtByt/GGNpX14ZMfZJb0RDWs8KlRmk8pDhdaahgISNp1vTNJ8y8t56b
	s1Ap5+Os9aXZuVl+X/gP4Gp5s1OXOFtoo7yyaUQhzBBGD26dbJxsHaigtkvJVKNVmyRZrqFJUM7
	UDw/y+YZjHVZe8/bJSX4YbOtRsJmbww38pISZ4U4u2DLF0RnrdcEkG1FMIlzJbsdjNjo/g4TRJe
	peFC/IiD5fiVKJhNNPNANRtyAQGjtf4Ym5nM4AcfNzF4lxrP/yaQ/b9TG51UmErFdnjBqAg+Gck
	0fT1mEFBW9otGRykYx/vS7u7+otqDv1by1V1GNqdOEr82YHTL7VATxDqg/9yGiAP+QmBEog6QjE
	rTok/a7GII5WCPLwJsB6eweEp79oVw5wsAApRGgkwGmdBk/ghOmZIzh3VcztISO0yrY3p2v9i6H
	qwXVkM4Fk2Jz6xYEga4Ss+PBrAk8HLnwQ8hJ8oAhhjbpd1rOIVOesrtdWgB1npW23D4=
X-Received: by 2002:a05:7301:fc81:b0:36c:d29e:668f with SMTP id 5a478bee46e88-36cd29e694cmr2469548eec.6.1793794643860;
        Wed, 04 Nov 2026 04:17:23 -0800 (PST)
Received: from prpatel-thinkpadp1gen7.rmtin.csb ([103.158.138.158])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca38d46fcsm7438355eec.13.2026.11.04.04.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 04:17:23 -0800 (PST)
From: Prijesh Patel <prijeshpatel.dev@gmail.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	prpatel@redhat.com,
	Prijesh Patel <prijeshpatel.dev@gmail.com>
Subject: [PATCH iproute2-next] man: ip-neighbour.8: document protocol keyword
Date: Wed,  4 Nov 2026 17:47:02 +0530
Message-ID: <20261104121702.56526-1-prijeshpatel.dev@gmail.com>
X-Mailer: git-send-email 2.56.0
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

Document the `protocol PROTO` keyword, which tags a neighbour entry
with its origin (e.g. static, boot, dhcp, or a routing daemon's own
protocol id) on `ip neigh add/change/replace/delete`, and filters
entries by that origin on `ip neigh show/flush`, including the
special `all` value. Supported since 6b83edc0 ("neighbor: Add
support for protocol attribute").

Signed-off-by: Prijesh Patel <prijeshpatel.dev@gmail.com>
Assisted-by: Claude:claude-sonnet-5
---
 man/man8/ip-neighbour.8 | 24 ++++++++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/man/man8/ip-neighbour.8 b/man/man8/ip-neighbour.8
index 1f890c0d..4784faff 100644
--- a/man/man8/ip-neighbour.8
+++ b/man/man8/ip-neighbour.8
@@ -28,7 +28,9 @@ ip-neighbour \- neighbour/arp tables management.
 .BR use " ] [ "
 .BR managed " ] [ "
 .BR extern_learn " ] [ "
-.BR extern_valid " ]"
+.BR extern_valid " ] [ "
+.B  protocol
+.IR PROTO " ]"
 
 .ti -8
 .BR "ip neigh" " { " show " | " flush " } [ " proxy " ] [ " to
@@ -39,7 +41,9 @@ ip-neighbour \- neighbour/arp tables management.
 .IR STATE " ] [ "
 .B  vrf
 .IR NAME " ] ["
-.BR nomaster " ]"
+.BR nomaster " ] [ "
+.B  protocol
+.IR PROTO " ]"
 
 .ti -8
 .B ip neigh get
@@ -123,6 +127,14 @@ will not remove or invalidate the entry, but it can probe the entry and notify
 user space when the entry becomes reachable. The kernel will return the entry
 to stale state if it did not receive a confirmation after probing the entry.
 
+.TP
+.BI protocol " PROTO"
+the origin of this neighbour entry. The value can be a number or a
+string from
+.IR /etc/iproute2/rt_protos ,
+e.g.
+.BR static ", " boot ", or " dhcp.
+
 .TP
 .BI lladdr " LLADDRESS"
 the link layer address of the neighbour.
@@ -229,6 +241,14 @@ list neighbour proxies.
 .B unused
 only list neighbours which are not currently in use.
 
+.TP
+.BI protocol " PROTO"
+only list neighbour entries with the given origin protocol. The special
+value
+.B all
+matches entries with any protocol, including those with no protocol
+attribute set.
+
 .TP
 .BI nud " STATE"
 only list neighbour entries in this state.
-- 
2.56.0

