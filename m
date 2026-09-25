Received: from mail-yx2-f41.google.com (mail-yx2-f41.google.com [74.125.224.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5A9E4A33F2
	for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790345522; cv=none; b=OvlyrkLp7+oGpfR+vEeV6IlgAjxugEZoBcfOXO3K5Iq0Uv17izTBLuXyWu8XFyLEwD54knYT1A3AmAIAxkAuok9RwCU3hB4h0rxMiW59/9SJaRxVie0bnuLbvJRjeVNbUU7/M/lwHWL0pkUQ1ieBK2XbYwTw0OixMfxdAsCX1Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790345522; c=relaxed/simple;
	bh=kKl5iNOzsdbjr/Dvasqz/qsqldtPZgltzii4Vm4aYBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxexlWEiK/e1Vv0dx6C+B/cJbNSnRgWqBBv2XdryXcmrMP4dwoGeoJ3yHAjorcdvl5jle/ha/07iMB55xwoNYYFWANyQxq32ysRxZo8bMMF0B+gZt/Zq+KJM+P1I+TIDimFdrdj3kSv077R/CaXxmeyTknimg9UUCzg5C/O0zRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1password.com; spf=pass smtp.mailfrom=agilebits.com; dkim=pass (1024-bit key) header.d=1password.com header.i=@1password.com header.b=wvD2JHTX; arc=none smtp.client-ip=74.125.224.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=1password.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=agilebits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=1password.com header.i=@1password.com header.b="wvD2JHTX"
Received: by mail-yx2-f41.google.com with SMTP id 956f58d0204a3-6740dd8b4b0so754617d50.2
        for <netdev@vger.kernel.org>; Fri, 25 Sep 2026 07:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1password.com; s=google; t=1790345520; x=1790950320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cxXLBzacgfxUv6Sv0XbK1ALWzQLvq6MJyLP+zQbXIKo=;
        b=wvD2JHTX0d3PDCtBse075GDwkM5WvSsAhieQlTENFpe0Ov4v9BeH99Ze0cmQq/FLxI
         BIATLR3wIFRXtChY/DxgmsiT0gMh2ffP7D3l9egHqh7j0EWpuj1qrj20fYaLBzNaWdMt
         D3lFSJJtHt9zUt39Ld52mg/soBK8ziL0rzC4k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790345520; x=1790950320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cxXLBzacgfxUv6Sv0XbK1ALWzQLvq6MJyLP+zQbXIKo=;
        b=wZDznBCcd7YRTPuCl/bdG6HdgYozgp+T0Y9Ocqm4EA43aVbB62qco+dVTH9qRsf3Y/
         5R5NAiDANbM/zHRZwXRNA3M4KaNpdbZmkRy5bKqDNxpu3PNmHuspQVMI9iTqSSH60y0l
         /Hir3SUgpbwjGU+W50VuNg+WTE8BCylw8isATbSivCtyuQD/zu2Z1eOMDcNkl5PW7tHY
         X4wo28oNow1iaRkPw4HTOzll+LI5ZxVX+CtVks3uUtnmiIloEU3cjjz2n1Sr4kMzE2Nc
         T8IVdBrLYdsPk/zXQN9AECoP/oKoo1I1Zt7ZIexXXTpvLZDNbBBBNYAj1rBWhXK3bCfJ
         MNXg==
X-Forwarded-Encrypted: i=1; AKwUvByFXVGSK1RRCa2h/i4+5sqA1Gfkz+JEmKxqcbDl4z6725Mj8wOUBnNL/iDD4znvdHQN6B2KD/g=@vger.kernel.org
X-Gm-Message-State: AFuF++nGvKzVyNd++p+xJT/EhvL/X4ACGU/Qa3idlqFXWcrPjinjywHd
	Xty44SDzIJEg4RXT7rV2zzwqQ6V/X9TzTPKZpF2l+hTZ7x4VifAyztvNaThBh5BzCew=
X-Gm-Gg: AYBFou0EAJvGleXREHRm4vmjXhDJehXsJaaRDVHtVYpg7ot0k3cZ7gKI4YIV2gZh/iq
	HWyGS5IiIonUYCaKhFE9PyyxtI3/cgGuFsi4qe44LfDYChv88Pe6LrO1+ggeQkYygbmE6+KLMWW
	rXTJdDkAiJgFXMUVWolYX2EL22YfLDTpdoTm9BwEwzb7JnRkLSj8EgYZjNVyffpBMbCRPTS4z97
	AlK8fICXS37MiPG/PbtA/RjIWQuHa0tv+s/7MTXJiB29K8J2rwh4sSZM4WVumnVI7pYkQHxb7O9
	CVBvlOIu6DmPYmLEQdSohkBE0cvp6seajht25Q6bzI638zHB7o/Zz3/TpV5amQl70p4GvoeF9vV
	12RdCFozkSOnGNn5bq/EgP7nbdw+FZUxRMhac0X/GXjxcRvGq7yowpgWTlXtH9hFCCT09T2ItWT
	NhVTWL4ohe3m8+8/7zPfhftappx3zg/UUyXSmWsH4Xl6Bpx4DyaSZM+pucNSxkmjhtOm8IgApXA
	3Ef2xfrc24I1YbiYBaU6v6vjasVkRQ=
X-Received: by 2002:a05:690e:120e:b0:671:4c1d:fa3e with SMTP id 956f58d0204a3-672ecd6592emr2967192d50.0.1790345519528;
        Fri, 25 Sep 2026 07:11:59 -0700 (PDT)
Received: from localhost ([2600:4041:59c3:300:7917:c7f6:28c6:182b])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430db38d0sm17919246d6.17.2026.09.25.07.11.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 07:11:58 -0700 (PDT)
From: Axel Mierczuk <axel.mierczuk@1password.com>
To: Julian Anastasov <ja@ssi.bg>,
	Simon Horman <horms@verge.net.au>
Cc: Pablo Neira Ayuso <pablo@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	Phil Sutter <phil@nwl.cc>,
	David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	netfilter-devel@vger.kernel.org,
	lvs-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	Willy Tarreau <w@1wt.eu>,
	Keith Hoodlet <keith.hoodlet@1password.com>,
	Axel Mierczuk <axel.mierczuk@1password.com>,
	stable@vger.kernel.org
Subject: [PATCH nf 1/2] ipvs: avoid out-of-bounds write in ip_vs_nat_icmp_v6
Date: Fri, 25 Sep 2026 10:11:54 -0400
Message-ID: <20260925141155.17603-2-axel.mierczuk@1password.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260925141155.17603-1-axel.mierczuk@1password.com>
References: <20260925141155.17603-1-axel.mierczuk@1password.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ipv6_find_hdr() does not set the header offset for non-first
fragments, so an ICMPv6 error embedding such an ESP fragment leaves
ip_vs_fill_iph_skb_icmp() with len == off. The NAT paths size
skb_ensure_writable() from len, and ip_vs_nat_icmp_v6() then writes
the embedded addresses after the validated area.

Include the embedded IP header in ciph.len at both ICMPv6 call
sites when parsing stops at a non-first fragment. ESP lookup does
not require a transport header. Non-first TCP, UDP and SCTP fragments
bypass IPVS ICMP handling before connection lookup.

This fix does not depend on patch 2. Stable kernels without commit
342e24a339b9 ("ipvs: do not mangle ICMP replies for non-first fragments")
also need that commit to handle incoming ICMPv6 errors quoting
non-first ESP fragments.

Fixes: 63dca2c0b0e7 ("ipvs: Fix faulty IPv6 extension header handling in IPVS")
Cc: stable@vger.kernel.org
Suggested-by: Julian Anastasov <ja@ssi.bg>
Signed-off-by: Axel Mierczuk <axel.mierczuk@1password.com>
---
 net/netfilter/ipvs/ip_vs_core.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/net/netfilter/ipvs/ip_vs_core.c b/net/netfilter/ipvs/ip_vs_core.c
index fd503f0efb57..cfd193196a5b 100644
--- a/net/netfilter/ipvs/ip_vs_core.c
+++ b/net/netfilter/ipvs/ip_vs_core.c
@@ -1206,6 +1206,13 @@ static int ip_vs_out_icmp_v6(struct netns_ipvs *ipvs, struct sk_buff *skb,
 				     true, &ciph))
 		return NF_ACCEPT; /* The packet looks wrong, ignore */
 
+	/* ipv6_find_hdr() does not include the embedded header for
+	 * non-first fragments, add it so that ESP can pass and the
+	 * NAT writable checks cover the rewritten addresses
+	 */
+	if (ciph.len == ciph.off)
+		ciph.len += sizeof(struct ipv6hdr);
+
 	pp = ip_vs_proto_get(ciph.protocol);
 	if (!pp)
 		return NF_ACCEPT;
@@ -2036,6 +2043,13 @@ static int ip_vs_in_icmp_v6(struct netns_ipvs *ipvs, struct sk_buff *skb,
 	if (!ip_vs_fill_iph_skb_icmp(AF_INET6, skb, offset, true, &ciph))
 		return NF_ACCEPT;
 
+	/* ipv6_find_hdr() does not include the embedded header for
+	 * non-first fragments, add it so that ESP can pass and the
+	 * NAT writable checks cover the rewritten addresses
+	 */
+	if (ciph.len == ciph.off)
+		ciph.len += sizeof(struct ipv6hdr);
+
 	pd = ip_vs_proto_data_get(ipvs, ciph.protocol);
 	if (!pd)
 		return NF_ACCEPT;
-- 
2.43.0

