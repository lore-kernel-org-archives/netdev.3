Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D694A45038
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 08:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789807558; cv=none; b=Kx9mtQN8unxmorfPSUOtVES0mW1dJAwVbJaKJUsPwcCctTf7eM639p74HYR0FwaDsK27Jdu+Yum+yjdErupBxxORTfju8+kQ+yfoARNgyqZJGPxwBU2rTqSBI/oEi0kEIzRMBT6SSmqCsgTxbbbkvDCbDr9JV8vQZCghumg2tyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789807558; c=relaxed/simple;
	bh=UEI2LGlCAzpNZZbvRBnIqxjWunRyp9kHL11PSVrSEBg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PaENw0ale+qNMaVan2qZQBnjcZtNYzSFXSrerqHMiahMbJeEhNITqjOGSEhTH+AxjPpeFnbP8O9Z3W3U2SilMwybd+bt8Ay0/sN1aRYwCOKgz8b6OKH64ABF7s8tk0gwrlJjFTw4gWSN0SpdQepH0kPPxTP728uaSR0EkhFeTVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h3U5sA3U; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h3U5sA3U"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-396ccb1a98fso1400986a91.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 01:45:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789807556; x=1790412356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fIT34fzAp20QfA3W3/wrFzqoA5JH29tRSqgsBN01jXI=;
        b=h3U5sA3UEtza8RiEKIOcHOBOXmXD59BXH6octAMNx2UfxiJ1a38OzZ9Ab5ZTAUWPQt
         4M6d/jFgnZUzXdhGfMBfIR1OROWMZ2iPIsL1ejnrLHN+AkDq9T2WVlR58RMtCv8nXJQF
         d9JOQidLpFPkB3dJW3X+FxQSx4GkJD2BUehQmV0MgHczbN0Y+FVr2l+y9yky5TmGT6ex
         IE/hTrKX1regi/83NWvWDnd2PpBsF6zMReJktreo7SE7uVmQF51K7uqR1ZMPl/k9a86G
         fJuEwVKAmnm4H421HgiH/2EeOeepi1Jqq+0S8ZXD4f3EAHjUG6nBhDGTX1qitXdiHGm1
         TGYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789807556; x=1790412356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=fIT34fzAp20QfA3W3/wrFzqoA5JH29tRSqgsBN01jXI=;
        b=lecAaNpgWahWa89nzvLnNZWFjkWMzN1srhvbDn4jrbdMfShFOR8wiyKUiNfVjx7QkR
         o/6FNoXPikLEYY6vCltLiFAHcnZimki2U20LQL3uV44sjEy2lPx4HmexOcUTyHwKnuRw
         tNnbxD24LE9MS44A9BN/XsNpYsRl3GoJ5bgqH/n4hnftg5GL2kur6B/OYUjStK46T6GD
         vomRMD0QeXD9d80aazXIG13k8sqo8A0MXsvwsqAGc1r4IYHGJlDWtlfsv/84c9/Z/GOS
         fNQFlUdc4tj5KQwUFK32ZzFsuzj5azAfMokysvDLxjiikzIIHglkpo4zds6ANl2p/PeF
         22Fg==
X-Gm-Message-State: AFuF++nUeNqtS3PAbxs1FILo/SgC96mE8HhwFgxLyhFaDJwv7U6w9d16
	64u6JFH+UBr7NkmN7MqDHojyJtGHGVo/ZS9jKxm0SgiTE014sT9LLEXHp3Ri4NNFFA8YFi+E
X-Gm-Gg: AYBFou05NT0VnPfYbezzgF6yQ5r7lnnhNwCLqoR7Ri0HSh8YUWdC2HCi/AppU/5clBK
	BU+ajY45lho/mtM0eCSZtcGENosj89m4P4i2rzuyE6rNDGVE+HK7nY8zLXGCC+JhuGTYqJ88/9x
	V3CnygMVtaqh9wMEXTnq++a2wwypk9Xw/zK3HTtHiYRR7JcnjsW8OD77Cg0TuAdWBzfczrovxd3
	ltejnD/D0BrQNA5ZEVa/u+A/YTVbgD9zci3bHGJARZOkppsfJBiDAwWRfZUbHmWOWpIqlOQfJSj
	oEN3MKbWuf9MjPE1/NGBgu4v7twDYNF6bflb2c2sLLi+uYU5wcn9QAUvVvF3i1aJ/H+seWBx17q
	Gm5jpMAXrxOM9mKUDMah39SWvgCXusynATzOz2Yj59loTgFqHJz+VWH3Yv0c5LoWahlHjpbeGJG
	rwGJbY5KNAx/4bouIvyKheHq9S1hoBUcDguR5ly0+ALzb+NpzFGHc0SSNI7Tg1/59lZYxeZaD4K
	YF0F4Wch5ND33A+3zogSlAdlCrVu/K4+Yw56YBFrGqVfxkxOPatyWpv6wV3TMWUzbIF9A==
X-Received: by 2002:a17:90b:4f81:b0:39e:4d1e:d47c with SMTP id 98e67ed59e1d1-39e54d8b8c9mr8697331a91.25.1789807556095;
        Sat, 19 Sep 2026 01:45:56 -0700 (PDT)
Received: from lenovo-thinkbook (42-2-127-248.static.netvigator.com. [42.2.127.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c6dd585sm3346698a91.0.2026.09.19.01.45.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 01:45:54 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: netdev@vger.kernel.org
Cc: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: [PATCH net 1/1] net: ipconfig: bound DHCP option construction
Date: Sat, 19 Sep 2026 16:45:27 +0800
Message-ID: <7808dfbfa2162dfd0b19f59aff5742d6e0db2abb.1789798023.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1789798023.git.xuyuqiabc@gmail.com>
References: <cover.1789798023.git.xuyuqiabc@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ic_dhcp_init_options() appends the hostname (option 12), vendor-class
(option 60) and client-ID (option 61) options into the fixed 312-byte
bootp_pkt.exten[] buffer.  Only the client-ID branch checked the
remaining space; the hostname and vendor-class writes were unbounded.

A 64-byte hostname together with the maximum 252-byte dhcpclass=
identifier needs 18 + (2 + 64) + (2 + 252) = 338 of the 312 available
bytes even before the terminating END marker, so the vendor-class memcpy
runs past the end of exten[].  With CONFIG_FORTIFY_SOURCE this is
reported as a field-spanning write and, when the kernel is booted with
panic_on_warn=1, aborts boot with a panic.

Route the optional options through a common helper that makes sure the
option, its 2-byte header and the END marker all fit and drops an option
that would not.  Configurations with short options keep sending exactly
the same bytes as before.

Fixes: 130c0f47fdf9 ("ipconfig: send host-name in DHCP requests")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Assisted-by: LLM
Signed-off-by: Yuqi Xu <xuyuqiabc@gmail.com>
Reviewed-by: Ren Wei <weir@nebusec.ai>
---
 net/ipv4/ipconfig.c | 45 ++++++++++++++++++++++++++-------------------
 1 file changed, 26 insertions(+), 19 deletions(-)

diff --git a/net/ipv4/ipconfig.c b/net/ipv4/ipconfig.c
index 155db067eaec..1b8585404a41 100644
--- a/net/ipv4/ipconfig.c
+++ b/net/ipv4/ipconfig.c
@@ -676,6 +676,24 @@ static const u8 ic_bootp_cookie[4] = { 99, 130, 83, 99 };
 
 #ifdef IPCONFIG_DHCP
 
+static bool __init
+ic_dhcp_add_option(u8 **options, const u8 *end, u8 type, const void *value,
+		   int len)
+{
+	u8 *e = *options;
+
+	/* leave room for the option header and the END marker */
+	if (len > U8_MAX || end - e < len + 3)
+		return false;
+
+	*e++ = type;
+	*e++ = len;
+	memcpy(e, value, len);
+	*options = e + len;
+
+	return true;
+}
+
 static void __init
 ic_dhcp_init_options(u8 *options, struct ic_device *d)
 {
@@ -691,6 +709,7 @@ ic_dhcp_init_options(u8 *options, struct ic_device *d)
 		42,	/* NTP servers */
 	};
 	u8 mt = (ic_servaddr == NONE) ? DHCPDISCOVER : DHCPREQUEST;
+	u8 *end = options + sizeof(((struct bootp_pkt *)0)->exten);
 	u8 *e = options;
 	int len;
 
@@ -721,31 +740,19 @@ ic_dhcp_init_options(u8 *options, struct ic_device *d)
 	e += sizeof(ic_req_params);
 
 	if (ic_host_name_set) {
-		*e++ = 12;	/* host-name */
 		len = strlen(utsname()->nodename);
-		*e++ = len;
-		memcpy(e, utsname()->nodename, len);
-		e += len;
+		ic_dhcp_add_option(&e, end, 12, utsname()->nodename, len);
 	}
 	if (*vendor_class_identifier) {
-		pr_info("DHCP: sending class identifier \"%s\"\n",
-			vendor_class_identifier);
-		*e++ = 60;	/* Class-identifier */
 		len = strlen(vendor_class_identifier);
-		*e++ = len;
-		memcpy(e, vendor_class_identifier, len);
-		e += len;
+		if (ic_dhcp_add_option(&e, end, 60, vendor_class_identifier, len))
+			pr_info("DHCP: sending class identifier \"%s\"\n",
+				vendor_class_identifier);
 	}
 	len = strlen(dhcp_client_identifier + 1);
-	/* the minimum length of identifier is 2, include 1 byte type,
-	 * and can not be larger than the length of options
-	 */
-	if (len >= 1 && len < 312 - (e - options) - 1) {
-		*e++ = 61;
-		*e++ = len + 1;
-		memcpy(e, dhcp_client_identifier, len + 1);
-		e += len + 1;
-	}
+	/* the minimum length of identifier is 2, include 1 byte type */
+	if (len >= 1)
+		ic_dhcp_add_option(&e, end, 61, dhcp_client_identifier, len + 1);
 
 	*e++ = 255;	/* End of the list */
 }
-- 
2.55.0

