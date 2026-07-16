Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03EC230C35C
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 00:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784162652; cv=none; b=KKhfOmMEYsoT+VA8M7fmO/bGDGmSj2ZdBVarsEalzuBwZ9/E/ffVBIE1tMYqJDv8aun1N7Jl75HoNntssSnVkbLyyoOnIaPvuliea2AwA6XJkJatBekf04Fr64bbb8vZmvKv18pzc3JkaWyvdHQzahDbMdzqBLiBLJDDO/NW9gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784162652; c=relaxed/simple;
	bh=/mWKmgPPP3TeTo5213fkgzBCXwFcfeZrukW48TpwrP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ciign0dwROn9EZxXH2y+KcEt/7qBWp1JcLK7LH0qaevA6h0XF3lPUtXOemcJabHEH1Sb6YNfVWLnFLJ2aP8jdVit1iDi/kpHz/fvUfT8gVtBlZ93A8IgdKoCYANMSlAFGsizsS8J5SRJt1vHQejbEEJy2mRRtfLGNPL/z1DcJSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmQ7wj3N; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmQ7wj3N"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-8486ac3f347so51362b3a.1
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 17:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784162645; x=1784767445; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4KYs6bF4G5Lma9vSvx/+axD0veNKsucRJ9eKrQH9KOc=;
        b=hmQ7wj3NWek2tmasKCWePocY+59m7HFcM0+AEmb3tY9H5yahHIR85V6GVN8PMeDXFE
         vdm4e/sdZLHdoKV5folV8HpLUsLe/5NEAPoVpA4BamyVXDoZ8B99DZxv/fxrmo9U8b5y
         26B5x5NjO5IP3RuMeYqdZ9lB987tnlncxsVv+7btJlrOwtH1h7JGfbXqIGsXRKnccZDg
         RjISeEo2rEDCNlqwA0wttmPNTWtXMMydUnl1I1usYEFHCmrbpWs6DG+T/Ai2UbyPUQuu
         UEDIkhV4lZNZ0ExAm6CmR5zShKWUvfaA53Gio1KAL5Ynk9COZGkJzr4hX4QCqpOmMb4B
         8NSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784162645; x=1784767445;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4KYs6bF4G5Lma9vSvx/+axD0veNKsucRJ9eKrQH9KOc=;
        b=Q5U8hJ0KT/AravIrGRhftttKGxnXr3HZUwbpLwydhiOXG27S+We3w218Yagh+zOruB
         jZdbddD/W+adVoohuli5VaZ7euupLpjvvLIMaGzsrZ3QavmgdIzVZyAaDVYQqfnl8F5r
         UBhG34bsSBfNUe/1CTpjWM5rE821VNFR9EzEOIBwJyA5R3lrbi+eBRUwy0N/RStVlTEp
         NEzcbEoMV85f1MxqXWAzs1iOxqN2Jqi/J4q+QjV/duGJhdh+TW6OOk019pjaSEc4aZL+
         mux6VnBkSjBPjVIN0Ke4uUfHvVw4SCTGDc+2Gd5nTO+9SYn/qw+KhIkKTaNQmvT8+IV1
         C9yA==
X-Gm-Message-State: AOJu0Yybxf0X6nwUT2K2wRGbiPkwRumTI3D2lJNtk+by3aUPJ4WHnP/Z
	2XKu3SXv+eq/3xpiWFbdu9dK4fnA6eJMf2q6rm8UaQNQn1gToFJ662tPS4PbQA==
X-Gm-Gg: AfdE7cme9VEmrBhDn9X0M49W5WSrqY4LUJORjYzdLI2E5Mhu0Og8pGpXXhB/zaAXGOj
	x5bNL3499/GmEVDXliRsKp364LHohuqwzWL4DtBk6aKiLxr9FB7RznaRe2NypRFpfe6WFtFYsyO
	MtNiGqv3x/XXdSKtypqdkOEUr0jQvCkY0ar9mhYVnVT1pI+NbT8beBdmUgJLTYfa5pt7Ms9u09X
	VxAVm01m3iY/1ZKVI/1E67zW5D7euFKJ9SxcKVmqQpGcojxDca7cJ729g7hz9y9H5UECFdUz8+3
	vfKpbwVl7T2ir79sylu7qzzvx8DIPzpFAaRPvTg+vod1b2BrEyPruJ1xBL08XYXlP+1Mvonhvah
	YKCs//I1vAWJ9IIEqfD9YxkGtp3HJWGX7Yvuyqb19osvEnET5soPOcNVXk6VG67VCPm0gxtpDC4
	aLFzmQ5EgnAxkzWMXcN+vigrIQ7GbNAg+QI+t3C41zTiNW2hsm5O74QmTeXt4RPOVTbBkd4OqnL
	NJ0phgygA==
X-Received: by 2002:a05:6a20:244c:b0:3bf:a8fa:a7b1 with SMTP id adf61e73a8af0-3c38dc1bbd0mr378449637.37.1784162645332;
        Wed, 15 Jul 2026 17:44:05 -0700 (PDT)
Received: from l.localdomain ([76.166.220.66])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13cd4284a92sm4107620c88.4.2026.07.15.17.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 17:44:04 -0700 (PDT)
From: Dave Seddon <dave.seddon.ca@gmail.com>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Tom Herbert <tom@herbertland.com>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	linux-kernel@vger.kernel.org,
	Dave Seddon <dave.seddon.ca@gmail.com>
Subject: [PATCH net-next v1 04/11] net: flow_dissector: add fast-path for PPPoE session + IPv{4,6} + TCP/UDP
Date: Wed, 15 Jul 2026 17:43:50 -0700
Message-ID: <20260716004357.3652679-5-dave.seddon.ca@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260716004357.3652679-1-dave.seddon.ca@gmail.com>
References: <20260716004357.3652679-1-dave.seddon.ca@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Adds flow_dissect_fast_pppoe() — a straight-line extractor for PPPoE
session frames (ETH_P_PPP_SES, EtherType 0x8864 per RFC 2516) carrying
IPv4 or IPv6 inside PPP. Strips the 6-byte pppoe_hdr + 2-byte PPP
protocol field, writes FLOW_DISSECTOR_KEY_PPPOE (session_id, ppp_proto,
type) when requested, and tail-calls into the eth_ip fast-path for
the inner IPv4 or IPv6 + TCP/UDP.

Byte-identical with the slow path's `case htons(ETH_P_PPP_SES)` block
for the eligible shape (RFC-2516-valid header + PPP_IP / PPP_IPV6 +
straight-line IP). On any miss — invalid header, PFC-compressed PPP
proto, PPP_MPLS_UC / PPP_MPLS_MC (defer until MPLS fast-path lands),
LCP / IPCP / other control frames — returns false so the dispatcher
falls through to the slow path. Output is exactly what the slow path
would produce.

Why this matters: PPPoE is the dominant L2 over millions of ISP last-
mile DSL/FTTH links, and the existing slow-path PPPoE block does a
__skb_header_pointer + per-field switch on every packet at the
graph-walk entry. The fast-path saves the walk overhead for the
common IPv4 / IPv6 inner case while keeping the slow path as the
escape valve for control / less-common inner protos.

Gated by:
  - new DEFINE_STATIC_KEY_FALSE(flow_dissector_pppoe_key)
  - new sysctl /proc/sys/net/flow_dissector/pppoe (default 0)
  - dispatcher case `htons(ETH_P_PPP_SES)` with
    `static_branch_unlikely(&flow_dissector_pppoe_key)` guard

When the sysctl is 0, the dispatcher hits a forward not-taken JMP —
same per-call cost as the vlan / qinq cases. The new dispatcher
case also doesn't widen the switch table (it adds one case to a
switch the compiler can already lower to a jump table on the
ETH_P_* constants).

Documentation/admin-guide/sysctl/net.rst grows a `pppoe` subsection
under the existing `/proc/sys/net/flow_dissector/` chapter, between
qinq and the next chapter, matching the existing per-shape layout.

Assisted-by: Claude:claude-fable-5 sparse smatch
Signed-off-by: Dave Seddon <dave.seddon.ca@gmail.com>
---
 Documentation/admin-guide/sysctl/net.rst | 18 ++++++
 include/net/flow_dissector.h             |  1 +
 net/core/flow_dissector.c                | 76 ++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/Documentation/admin-guide/sysctl/net.rst b/Documentation/admin-guide/sysctl/net.rst
index 824f4b735caa..1096e6ddca39 100644
--- a/Documentation/admin-guide/sysctl/net.rst
+++ b/Documentation/admin-guide/sysctl/net.rst
@@ -516,6 +516,24 @@ the outer entry is off).
 
 Default: 0
 
+pppoe
+~~~~~
+
+PPPoE session frames (RFC 2516, EtherType ``ETH_P_PPP_SES`` 0x8864)
+carrying IPv4 or IPv6 inside PPP. The fast-path strips the 6-byte
+PPPoE session header + 2-byte PPP protocol field, writes
+FLOW_DISSECTOR_KEY_PPPOE (session_id, ppp_proto, type) when the
+dissector requests it, and tail-calls into the eth_ip fast-path for
+the inner IPv4 / IPv6 + TCP/UDP. Byte-identical with the slow path
+for the eligible shape.
+
+Defers to slow path for: PPP_MPLS_UC / PPP_MPLS_MC (until an MPLS
+fast-path lands), PFC-compressed PPP protocol fields, LCP/IPCP/etc.
+control frames, and any malformed PPPoE header (ver != 1, type != 1,
+code != 0).
+
+Default: 0
+
 3. /proc/sys/net/unix - Parameters for Unix domain sockets
 ----------------------------------------------------------
 
diff --git a/include/net/flow_dissector.h b/include/net/flow_dissector.h
index 4f36f3889a28..df85162959cc 100644
--- a/include/net/flow_dissector.h
+++ b/include/net/flow_dissector.h
@@ -431,6 +431,7 @@ extern struct flow_dissector flow_keys_basic_dissector;
 extern struct static_key_false flow_dissector_eth_ip_key;
 extern struct static_key_false flow_dissector_vlan_key;
 extern struct static_key_false flow_dissector_qinq_key;
+extern struct static_key_false flow_dissector_pppoe_key;
 
 /* struct flow_keys_digest:
  *
diff --git a/net/core/flow_dissector.c b/net/core/flow_dissector.c
index 826314e28db0..21a3f5e0ea05 100644
--- a/net/core/flow_dissector.c
+++ b/net/core/flow_dissector.c
@@ -46,6 +46,8 @@ DEFINE_STATIC_KEY_FALSE(flow_dissector_vlan_key);
 EXPORT_SYMBOL(flow_dissector_vlan_key);
 DEFINE_STATIC_KEY_FALSE(flow_dissector_qinq_key);
 EXPORT_SYMBOL(flow_dissector_qinq_key);
+DEFINE_STATIC_KEY_FALSE(flow_dissector_pppoe_key);
+EXPORT_SYMBOL(flow_dissector_pppoe_key);
 
 /* IPv4 version/IHL byte of an option-less header: version 4, IHL 5. */
 #define FLOW_DIS_IPV4_VIHL_NOOPT	0x45
@@ -1333,6 +1335,67 @@ static bool flow_dissect_fast_vlan(const struct sk_buff *skb,
 	}
 }
 
+/* PPPoE session (RFC 2516) + 2-byte PPP protocol: write
+ * FLOW_DISSECTOR_KEY_PPPOE if requested, then tail-call the eth_ip
+ * fast-path for PPP_IP / PPP_IPV6. Anything else (PFC-compressed
+ * protocol, LCP, MPLS) defers.
+ */
+static bool flow_dissect_fast_pppoe(const struct sk_buff *skb,
+				    struct flow_dissector *flow_dissector,
+				    void *target_container,
+				    const void *data,
+				    int nhoff, int hlen)
+{
+	struct flow_dissector_key_pppoe *key_pppoe;
+	const struct {
+		struct pppoe_hdr hdr;
+		__be16 proto;
+	} *hdr;
+	__be16 inner_eth_proto;
+	u16 ppp_proto;
+
+	if (unlikely(hlen - nhoff < (int)sizeof(*hdr)))
+		return false;
+	hdr = (const void *)((const u8 *)data + nhoff);
+	if (!is_pppoe_ses_hdr_valid(&hdr->hdr))
+		return false;
+
+	ppp_proto = ntohs(hdr->proto);
+	switch (ppp_proto) {
+	case PPP_IP:
+		inner_eth_proto = htons(ETH_P_IP);
+		break;
+	case PPP_IPV6:
+		inner_eth_proto = htons(ETH_P_IPV6);
+		break;
+	default:
+		/* MPLS unicast/multicast + everything else (LCP, IPCP,
+		 * compressed PFC, ...) defers to the slow path.
+		 */
+		return false;
+	}
+
+	if (dissector_uses_key(flow_dissector,
+			       FLOW_DISSECTOR_KEY_PPPOE)) {
+		key_pppoe = skb_flow_dissector_target(flow_dissector,
+						      FLOW_DISSECTOR_KEY_PPPOE,
+						      target_container);
+		key_pppoe->session_id = hdr->hdr.sid;
+		key_pppoe->ppp_proto = htons(ppp_proto);
+		key_pppoe->type = htons(ETH_P_PPP_SES);
+	}
+
+	nhoff += PPPOE_SES_HLEN;
+
+	if (inner_eth_proto == htons(ETH_P_IP))
+		return flow_dissect_fast_ipv4(skb, flow_dissector,
+					      target_container, data,
+					      nhoff, hlen);
+	return flow_dissect_fast_ipv6(skb, flow_dissector,
+				      target_container, data,
+				      nhoff, hlen);
+}
+
 /* Top-level dispatcher: eligibility check (only the two standard
  * dissectors and flag subset) + per-proto switch with per-shape
  * static_branch gating. Each case's branch is a forward not-taken JMP
@@ -1380,6 +1443,12 @@ static bool flow_dissect_fast(const struct sk_buff *skb,
 		return flow_dissect_fast_ipv6(skb, flow_dissector,
 					      target_container, data,
 					      nhoff, hlen);
+	case htons(ETH_P_PPP_SES):
+		if (!static_branch_unlikely(&flow_dissector_pppoe_key))
+			return false;
+		return flow_dissect_fast_pppoe(skb, flow_dissector,
+					       target_container, data,
+					       nhoff, hlen);
 	default:
 		return false;
 	}
@@ -2522,6 +2591,13 @@ static struct ctl_table flow_dissector_sysctl_table[] = {
 		.mode		= 0644,
 		.proc_handler	= proc_set_qinq_key,
 	},
+	{
+		.procname	= "pppoe",
+		.data		= &flow_dissector_pppoe_key.key,
+		.maxlen		= sizeof(flow_dissector_pppoe_key),
+		.mode		= 0644,
+		.proc_handler	= proc_do_static_key,
+	},
 };
 
 static int __init flow_dissector_sysctl_init(void)
-- 
2.54.0

