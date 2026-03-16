Received: from mail-lf1-f99.google.com (mail-lf1-f99.google.com [209.85.167.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 432743CE4B5
	for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 16:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.99
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773679778; cv=none; b=npJuaVHG/Ogy/5u59KnM21WoF+Bis+r6rQDWIUtSR67fVAcclVUa7/v5m5afIKJq28/l8TpRRy76xGtOlYN150YlRsjHG3Pzs2oNTrURLDRXjpL7YDgWbp1fDNjUbVaYDyIRb1dbS6l9ovSSI9ugP+/cHDoriuhqcQMHCB+5M54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773679778; c=relaxed/simple;
	bh=dXfsihbB/0u17xAbJe/nwOIJEY3qa5b9DOczSyGYNmA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=E+izt7D4zZ2AGetQCLsXYYwco7SEqX7tDFshUKChbSDYdGchahvcxn+zzf76Uxfqj6Map5XQabVkcrWRmbe5piSlvEbEOCn8S5BWn8pbILqHvYXfQVbX8rUYq599P9fKnhl4pSV/2/ruQFjNUNQ62A1ypHrbTiG3Ab4vhucWz4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com; spf=pass smtp.mailfrom=6wind.com; dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b=Cz4yt6QL; arc=none smtp.client-ip=209.85.167.99
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=6wind.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=6wind.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=6wind.com header.i=@6wind.com header.b="Cz4yt6QL"
Received: by mail-lf1-f99.google.com with SMTP id 2adb3069b0e04-5a12c19affeso6713242e87.1
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 09:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=6wind.com; s=google; t=1773679775; x=1774284575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GebID9Fz+svTro9iiiZ+sDepPKQe8Gm/XzKmqqFUaQw=;
        b=Cz4yt6QLVZOMWRoyO80+gNM1Pwl7F/N+PSmdcPRJhS3R35jEoUOJo/wznZ3wYQ3UEG
         3S1UAVYSL/5lVCvt6T6obrmKdXl8UzC5cDE6pBGhSVvkG1wlxUNij5QSLXAgY2jZ0NUX
         MzAEKvxh5N1i1dCFsrsS8L9nqDM2Z28y81vCBKEGFxTwbuB3gjgYeLrtAJnfAaLAzwxM
         +uf0y5T0kgOn3VjZ6cyVcBvErLGncpsMKDJ4PBg50xIKI2BHD0VSzQn4r/DQ+wJ51TW/
         FEZomS+YD/V+moLO9S5ERTsmHfQSN6xGKRJYbn0v8vQNCz4IxypoaIqyGM1Safy9rr/Z
         K5ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773679775; x=1774284575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GebID9Fz+svTro9iiiZ+sDepPKQe8Gm/XzKmqqFUaQw=;
        b=i0BaPigsOqytwIQAP4Ked9XIn/sqkC36gkAa2VyRAThMFjrXfxxGcQW4CA9HvfkZ3P
         N/+Y9kKb8RQ99r2EUwRALIvS36jGbiIlzKyDJIDnxkZFGSkZ8qDOklWsVYvXLfVodrYt
         psv5sbDxsQIxRGy57XMCl7Xbe6Tp5YxaWDCZUDsmVyB6ZbTgnlIM8sxomj5YzJLNPuGo
         k+RSXdMpgj2vv54or1hjc3VUfD0rO48qv6k1/Vk//X0suvpH7YRT3X7zyATKOdPphZal
         cG71L5CIZUfvC9GUa4kRqHF2IB0QxefovYQ/iFQ7d0uTGyxJlRrdUslWl0uj8OejrgnL
         mZ4g==
X-Gm-Message-State: AOJu0YxfDs7WrbvojPVoM0Or34rdRknsa2Wq/4EvXtHpoZ1Llb8ZKeDV
	hSE7SgAZC/33kLP+k5XD0wQTLtfhnp24hhpRTiq7L+ShDMwujKA9EPyP5GBPFg5uykDJHsGS3vt
	DixmMeF6FMIbiioAxfWuKFYcItGxZEXYNjt0w
X-Gm-Gg: ATEYQzxewSNe18diXs8UTNT7bUIQ+sWz7oSDqgqNBGke9g7jH2cm3aptotlDasfNuQw
	wIbCDbbuEqm5o5fkvdX7VsguT09gD8oZHADu2cLHKIbEXbGhO52G3XrJe1LIThu947nUMDBWnkE
	d2FHlZ3p6L4t9wrvAUGiR9icB3MnzyTF5yIJlHtVR0b4TiepJi8fNPFY5D6b44Bek3MWZHAGi4C
	QXVW+d3c8D3W1Vu449QmuaCcMmTU8YqGXIJKfCvPEko0e3pTgaw4icxZ2nFhANcsz1G7We5RxXu
	nGYt4BTs6Lbs1dERQcQnavnxMHA7jbhzxGjBeiDhlnDZ1pkdbqZoqhe9ZEor9ussIj004doAA0Z
	UJz4USvr7h9soTbJx8XrR9Ta42K4/UVINAYnQnlxaODGK+9oFPX2dHoewhWUh6uzwajG4/nyVUQ
	==
X-Received: by 2002:a05:6512:3091:b0:5a1:2ffd:1504 with SMTP id 2adb3069b0e04-5a173b9a153mr81655e87.3.1773679775309;
        Mon, 16 Mar 2026 09:49:35 -0700 (PDT)
Received: from smtpservice.6wind.com ([185.13.181.2])
        by smtp-relay.gmail.com with ESMTP id 2adb3069b0e04-5a156154789sm1340089e87.41.2026.03.16.09.49.35;
        Mon, 16 Mar 2026 09:49:35 -0700 (PDT)
X-Relaying-Domain: 6wind.com
Received: from localhost (kadavar.dev.6wind.com [10.17.1.232])
	by smtpservice.6wind.com (Postfix) with ESMTP id DA5AC19FB6;
	Mon, 16 Mar 2026 17:49:34 +0100 (CET)
From: Justin Iurman <justin.iurman@6wind.com>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	stephen@networkplumber.org,
	andrea.mayer@uniroma2.it,
	justin.iurman@gmail.com,
	nicolas.dichtel@6wind.com,
	stefano.salsano@uniroma2.it,
	paolo.lungaroni@uniroma2.it,
	ahabdels@cisco.com,
	Justin Iurman <justin.iurman@6wind.com>
Subject: [PATCH iproute2-next 1/2] seg6: add tunsrc support in iproute_lwtunnel
Date: Mon, 16 Mar 2026 17:49:06 +0100
Message-Id: <20260316164907.1255510-2-justin.iurman@6wind.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20260316164907.1255510-1-justin.iurman@6wind.com>
References: <20260316164907.1255510-1-justin.iurman@6wind.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for the new optional "tunsrc" parameter. Now, a tunnel
source address can be configured per route and has priority over the
configured per-netns source address (if any).

Example:
ip -6 r a 2001:db8:1::/64 encap seg6 mode encap tunsrc 2001:db8:ab::
    segs 2001:db8:42::1,2001:db8:ffff::2 dev eth0

Signed-off-by: Justin Iurman <justin.iurman@6wind.com>
---
 ip/iproute_lwtunnel.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/ip/iproute_lwtunnel.c b/ip/iproute_lwtunnel.c
index a7885dba28c1..00b4f7565be6 100644
--- a/ip/iproute_lwtunnel.c
+++ b/ip/iproute_lwtunnel.c
@@ -266,6 +266,13 @@ static void print_encap_seg6(FILE *fp, struct rtattr *encap)
 	print_string(PRINT_ANY, "mode",
 		     "mode %s ", format_seg6mode_type(tuninfo->mode));
 
+	if (tb[SEG6_IPTUNNEL_SRC]) {
+		print_color_string(PRINT_ANY, COLOR_INET6,
+				   "tunsrc", "tunsrc %s ",
+				   rt_addr_n2a_rta(AF_INET6,
+						   tb[SEG6_IPTUNNEL_SRC]));
+	}
+
 	print_srh(fp, tuninfo->srh);
 }
 
@@ -953,6 +960,8 @@ static int parse_encap_seg6(struct rtattr *rta, size_t len, int *argcp,
 	struct ipv6_sr_hdr *srh;
 	char **argv = *argvp;
 	char segbuf[1024] = "";
+	bool tunsrc = false;
+	inet_prefix saddr;
 	int argc = *argcp;
 	int encap = -1;
 	__u32 hmac = 0;
@@ -967,6 +976,22 @@ static int parse_encap_seg6(struct rtattr *rta, size_t len, int *argcp,
 			encap = read_seg6mode_type(*argv);
 			if (encap < 0)
 				invarg("\"mode\" value is invalid\n", *argv);
+		} else if (strcmp(*argv, "tunsrc") == 0) {
+			NEXT_ARG();
+			if (encap == -1)
+				invarg("\"tunsrc\" provided before \"mode\"\n",
+				       *argv);
+			if (encap == SEG6_IPTUN_MODE_INLINE)
+				invarg("\"tunsrc\" invalid with inline mode\n",
+				       *argv);
+			if (tunsrc)
+				duparg2("tunsrc", *argv);
+
+			get_addr(&saddr, *argv, AF_INET6);
+			if (saddr.family != AF_INET6 || saddr.bytelen != 16)
+				invarg("\"tunsrc\" value is invalid\n", *argv);
+
+			tunsrc = true;
 		} else if (strcmp(*argv, "segs") == 0) {
 			NEXT_ARG();
 			if (segs_ok++)
@@ -1005,6 +1030,12 @@ static int parse_encap_seg6(struct rtattr *rta, size_t len, int *argcp,
 			  sizeof(*tuninfo) + srhlen))
 		goto out;
 
+	if (tunsrc) {
+		if (rta_addattr_l(rta, len, SEG6_IPTUNNEL_SRC,
+				  &saddr.data, saddr.bytelen))
+			goto out;
+	}
+
 	*argcp = argc + 1;
 	*argvp = argv - 1;
 	ret = 0;
-- 
2.39.2

