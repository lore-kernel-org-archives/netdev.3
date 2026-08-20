Received: from mail-wm1-f98.google.com (mail-wm1-f98.google.com [209.85.128.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAF9847D948
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 16:43:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244240; cv=none; b=J+lqyULXBDsBNXhStAYEHNWPRaEQoDiTE/DPnswUpWfPetXFIngTKHcU10pTkaI8N/n7OL/fJ2Kdk/3oCKjozwUhIkAIxSvd0FQkax2pOPyhUx24gHwouIr6ELzCDh+qww+D4bJYA6KUt54EV5o/0uzetJOILlRw/P9aDi56W9M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244240; c=relaxed/simple;
	bh=m7upjCV3lgDStGrwKswC8ci7UMVgnmM1DCtNUaCZuAU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g3BkMdjD9D+id4bB1+E8gSOi04bBesI2dCrSkpN1Fxx2geouIY22N9jAm2Y6ds9z9TvbM2WnQLyWTz/fmaRtE/+tXleYwQAl565AIYCU1wHTGArYKWPegJXfq7hsAj8deY9hEjnxuQDz3rPA/V7fGWzfxxVIpvCJ5kfm/WlzMlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=fI6NHJD1; arc=none smtp.client-ip=209.85.128.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="fI6NHJD1"
Received: by mail-wm1-f98.google.com with SMTP id 5b1f17b1804b1-4998e0916faso133885e9.2
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1787244237; x=1787849037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TzNA1W640bRMxMbtSEq0q3i2nn9xvjC7AZ90LyFQylQ=;
        b=fI6NHJD1kipRNzBRKNXN+uBSEq2W1sZ3clfCRHn9/2zuchGkvY5Bsd0YB5gjZEODkl
         ClvJCeB7QTxB7FEC90lSU+V5iX8GSumm0udcu0mr8RfXIKqMpsGhj1NK53i3QTUfXmH8
         kCPkJaAo9o1//hXEAXF9Rm4iEYcrWG70eJcB3Jn2rMTYmWBQo6qAXyhdMnhjTV4NsdHG
         uLWe012g56BBW7dz9AsAU5rb5qxaveeSb7drguiVBuCVMlFmwcwrUGljSKQPInrssRok
         932dNCdONySl9qbTHDTZNbE/tb2hiKYGHIZsGyCPhMopI4pk+BoUIO2RZoFMKUk++yOX
         +R8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787244237; x=1787849037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TzNA1W640bRMxMbtSEq0q3i2nn9xvjC7AZ90LyFQylQ=;
        b=Ac79fzzT5M6mVEv6aMAlSjZhZvV3TUjkFxf6RYjrq85SvSYSjW0+0BI7tTGG4Y7sHc
         mWFJ71MME44rrp1WeTP/2d7n7oVW3+UMTBPc0B6H5F2SOUwehiIW2HLAMNdNaqh7Fjbk
         dGisEaQkwPnN0MPewjvSWEZEYlGCQVhuoGp4pKTG5XtM+zGvRTC1LTAz1AHQtmS/k1aW
         mFRLZsX4u6kZ6Rr3omXMlpqXsAPSKTAQKW+NLvPtvYE3yFVxmjC2t2XZSS91MTZ/G+Nn
         jDJzKXMo/1uOT8U1r+HbpYe2ppW8CVTMna1wa5cap16phxa1Gg9/X9xY4FkFlKR6wLvp
         IqgQ==
X-Gm-Message-State: AOJu0YyH4Y62urJ+f9eg6Mrk194+eI2VXt24rUacmANPA4lB/Zsi4jPP
	vHIRnDqSxoBSU3w8WolCfTBE/fxySideXwJJMJbdczdacU9i1WZyNyK+nZ1YDXldWszIVkXueNG
	k9nrXOs5qF7h8IXQQVBEKeBseQTeGR6gWRMTQ
X-Gm-Gg: AR+sD13HWZMkqT6jJO/pv2aaT2AMy2KnxoAcMA8SKbfbWoc2wxKTPIy0jLaYHMzseQu
	UGQm8MGEq2m7LNce20xVzUO9YKUpYAXSli+F83p1RAAZ6z5dHw8YSTeuvXnWYVJLoE4TUO08Ap+
	TCf/uegdi2uSqGQgz3rPEvo9zxnUEUoXBkwXCdeQuKJhZlrGq4mLL/3/I2tlSqEVUF6wtmc4az6
	gwVZhV21LkGEjgQfbVvM+P9P0Jx068PoVjgxkpAoe0BKUcaphquagagn+kpq4AjG0SpEwqMlSxF
	IIYPf7UTKivbsfyzr65M37MQmzSJR9BkBcCWSWZw72PHQ9YMGuhc8lRpjqAdhtsUhPzXhmR17oj
	DePIgUXvsRgCFsrV9iTKpZGkRYqmveL3nMfrScpPAYif4MbmR6qQTWg==
X-Received: by 2002:a05:600c:4e56:b0:499:728c:4704 with SMTP id 5b1f17b1804b1-499b8461b32mr2266635e9.12.1787244236680;
        Thu, 20 Aug 2026 09:43:56 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 5b1f17b1804b1-499b1bdf708sm11106635e9.12.2026.08.20.09.43.56;
        Thu, 20 Aug 2026 09:43:56 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from stryper.dev.6wind.com (stryper.dev.6wind.com [10.17.2.5])
	by smtpservice.6wind.com (Postfix) with ESMTP id 703EC11D1C;
	Thu, 20 Aug 2026 18:43:56 +0200 (CEST)
From: Louis Scalbert <louis.scalbert@6wind.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	jv@jvosburgh.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	fbl@redhat.com,
	andy@greyhouse.net,
	shemminger@vyatta.com,
	maheshb@google.com,
	jonas.gorski@gmail.com,
	horms@kernel.org,
	stephen@networkplumber.org,
	matttbe@kernel.org,
	dsahern@kernel.org,
	Louis Scalbert <louis.scalbert@6wind.com>
Subject: [PATCH iproute2-next v6] ip/bond: add lacp_strict support
Date: Thu, 20 Aug 2026 18:43:52 +0200
Message-Id: <20260820164352.1933916-1-louis.scalbert@6wind.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lacp_strict defines the behavior of a LACP bonding interface
when no slaves are in Collecting_Distributing state while at least
'min_links' slaves have carrier.

In the default (off) mode, the bonding master remains up and a
single slave is selected for TX/RX, while traffic received on other
slaves is dropped. This preserves the existing behavior.

In lacp_strict mode, the bonding master reports carrier down in this
situation.

Link: https://lore.kernel.org/netdev/20260603150331.1919611-1-louis.scalbert@6wind.com/
Signed-off-by: Louis Scalbert <louis.scalbert@6wind.com>
---
 ip/iplink_bond.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index 714fe7bd..3e8a964e 100644
--- a/ip/iplink_bond.c
+++ b/ip/iplink_bond.c
@@ -155,6 +155,7 @@ static void print_explain(FILE *f)
 		"                [ ad_user_port_key PORTKEY ]\n"
 		"                [ ad_actor_sys_prio SYSPRIO ]\n"
 		"                [ ad_actor_system LLADDR ]\n"
+		"                [ lacp_strict LACP_STRICT ]\n"
 		"                [ arp_missed_max MISSED_MAX ]\n"
 		"\n"
 		"BONDMODE := balance-rr|active-backup|balance-xor|broadcast|802.3ad|balance-tlb|balance-alb\n"
@@ -168,6 +169,7 @@ static void print_explain(FILE *f)
 		"AD_SELECT := stable|bandwidth|count\n"
 		"COUPLED_CONTROL := off|on\n"
 		"BROADCAST_NEIGHBOR := off|on\n"
+		"LACP_STRICT := off|on\n"
 	);
 }
 
@@ -188,6 +190,7 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
 	__u32 packets_per_slave;
 	__u8 missed_max;
 	__u8 broadcast_neighbor;
+	__u8 lacp_strict;
 	unsigned int ifindex;
 	int ret;
 
@@ -417,6 +420,12 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
 				return -1;
 			addattr_l(n, 1024, IFLA_BOND_AD_ACTOR_SYSTEM,
 				  abuf, len);
+		} else if (matches(*argv, "lacp_strict") == 0) {
+			NEXT_ARG();
+			lacp_strict = parse_on_off("lacp_strict", *argv, &ret);
+			if (ret)
+				return ret;
+			addattr8(n, 1024, IFLA_BOND_LACP_STRICT, lacp_strict);
 		} else if (matches(*argv, "tlb_dynamic_lb") == 0) {
 			NEXT_ARG();
 			if (get_u8(&tlb_dynamic_lb, *argv, 0)) {
@@ -642,6 +651,10 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 			   "all_slaves_active %u ",
 			   rta_getattr_u8(tb[IFLA_BOND_ALL_SLAVES_ACTIVE]));
 
+	if (tb[IFLA_BOND_LACP_STRICT])
+		print_on_off(PRINT_ANY, "lacp_strict", "lacp_strict %s ",
+			     rta_getattr_u8(tb[IFLA_BOND_LACP_STRICT]));
+
 	if (tb[IFLA_BOND_MIN_LINKS])
 		print_uint(PRINT_ANY,
 			   "min_links",
-- 
2.39.2

