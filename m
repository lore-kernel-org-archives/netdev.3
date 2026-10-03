Received: from mail-dy2-f42.google.com (mail-dy2-f42.google.com [74.125.229.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 166EE33AD9C
	for <netdev@vger.kernel.org>; Sat,  3 Oct 2026 01:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790990658; cv=none; b=nduuATAl4mnc4hsHR+aVUJd+qmLNs6Aoa9oEitFy68/Ep1eU+8SxEB1fGkqIo4zIzVoMutr6IHyuXJ9sfogQ6Y08AL8UVX1noQqGLAsrLygSZTSvZ7ZS6B8quOMTvE/3iP0M+Fz3TAeYYrDaq6tVMLYse4PkppXb0BGXEll+rL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790990658; c=relaxed/simple;
	bh=mGfHz8WzMa0nxjyWHH1yaS/WBBINfwLBBS0zG9gaNF0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tc/+wlgasZEzPmE7Cpo6MEOwe9osBYIv0GndBS+huBxoGxk4uCX4tw4VKWBa1n7X5g11o4jKLneQNpvSsStqh2yycxUN9VmOLTznw+UfERnLI0YLOO6bGTGIFZkkDLnTlqml9fZf59/0ZUOvpL5mSaTsZQOflJAH0iEnckOD+x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Iq+d0wiC; arc=none smtp.client-ip=74.125.229.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Iq+d0wiC"
Received: by mail-dy2-f42.google.com with SMTP id 5a478bee46e88-3510b42f4e3so189022eec.2
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 18:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790990650; x=1791595450; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MpQNOUzo0h+6dQ2FvXXFM3ZKgMz7jGcuuS4JPkwmK20=;
        b=Iq+d0wiCfBtv87DXyN0Xfa6s1CFPGpyuvZ9mE8e4ZqyRU7NyWmxSlEUokF0CgohTPf
         mWRGDnnF0FpFEWh97tlb0WoqfMZmjz24z/fdhTZftP0LZKxvwQEajdzlVnVTEiLejBHE
         y8wgwBDz9i+Ob++xFA8cn/tC++Oy/9J1hXrNpIScerpiLVvJ7Fb7apahH45U3Z1gzPXQ
         Ee2m1pG/fpBK/JIBQP3aevdiDvGY7zOJP8Zj5t/ch01hrJ99MJRBo4zy33gwNPHLEitT
         3TolAMk2f7CkIKsUljOu6Dr+S5hb7VQGNmebfARNbm0eZHrP8w5d3yhpIoBSiEX2fzRa
         xlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790990650; x=1791595450;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=MpQNOUzo0h+6dQ2FvXXFM3ZKgMz7jGcuuS4JPkwmK20=;
        b=D24oCCnCmnnvnfe+4enI5uKqA8l6Qoo+u9USg6xfPgboTsVw5vGaRNn1JBG9MgeqLM
         cmoXrHR6lHTv2czcaborz0ZM5QpdHS2Z2iuLTfYVRstchHA/Wo3VFwM9NYS5da0tWsLm
         bxAd220AeY+tx+qG5H7oECJ07E6H7gR+r2A2pMPjNx2hO1C8rX5txEPSrPHfNELVSwlK
         zVlY9yRy4E2xo1jmIQjKcNsOFyV5ONqAZPpEeG9yS8ibRdH5S+B/nmfgfQw2IJevY5Ws
         Jyh3Uuoqa2igiGuu7dW81o/hypOdaE5DH2QV1xi5or60kvixL50qIpy7fCrBIj0Bn4j8
         DqBg==
X-Gm-Message-State: AFuF++n4JPryScyFK/0ozLpd1Ne9cTqnmm41eGWI98wlZ/RpXM1PUaLi
	JI2b2o0HDEzEww7mjQWbzq/6yKk5SX7hcvYhyakiZ43Q6FELFXiizdJ3lWv9uFH1Zvw=
X-Gm-Gg: AYBFou28Nx3jTkR7dMl2zhqI+cWdtX7Sa+vNsWVWnCCeU079dqHt7uIyZqVyITmi1et
	/vqBUkq6ya7DXSuW+HQNEtgnLTs44rXut9VNd0RTze0qIgnTMsqPITlkvDkeOLypgQVxdASlQAz
	xYE0cNn1xGOJ4x3MY/oyuKryiUS9/iekAhEMzz0Hw6pdpYBmj8NH8hx5TiACJz5BDHK3NB5KNWU
	qrAkqBW+dybcjDBP6bRXU028De9RziJBznBQFOgtBV+ThN0iRv1Yx3mS52D/wKVEOwuwLv6PEc4
	MsEW57tokIvXbQxwWBZQL5nIhjoJDAuDzqRjEldEqWi1k3f3XLcOscBgMVZ0HLrC/yIAWtftmb6
	7Xt6PUmlU/huazL5PrVCbg8v2lGfGMJlEluusJyFAnu1u8v7YHyAa8PAQz4qA2V0fpDn4WUtvkm
	502z0+/WbysT1M4gvty0D8v1fXrK26nudwZXdDWp1aHiXzJtXPAzSNv8Nm099ZyJ+2bfoafb+AX
	FJiR1Y2rkXLbTeI4m2U3MADMovr3EvV0hi3+aFQArFt0JkM63SN7yIuHKLlJg==
X-Received: by 2002:a05:701b:4287:20b0:144:eb46:be0 with SMTP id a92af1059eb24-14f5b311259mr4874581c88.13.1790990650180;
        Fri, 02 Oct 2026 18:24:10 -0700 (PDT)
Received: from s1lverbox.orsomething.local (47-144-201-183.lsan.ca.frontiernet.net. [47.144.201.183])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-151fd2b2a95sm1133007c88.17.2026.10.02.18.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 18:24:09 -0700 (PDT)
From: Jean-Paul Sergent <jpsergent@gmail.com>
To: netdev@vger.kernel.org
Cc: i.maximets@ovn.org,
	kuba@kernel.org,
	kees@kernel.org,
	stable@vger.kernel.org,
	Jean-Paul Sergent <jpsergent@gmail.com>
Subject: [PATCH] net: dst_metadata: fix fortify trap + overread in skb_metadata_dst_cmp
Date: Fri,  2 Oct 2026 18:24:08 -0700
Message-ID: <20261003005449.2675.2@jpsergent.gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261003005449.2675.1@jpsergent.gmail.com>
References: <20261003005449.2675.1@jpsergent.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

memcmp: detected buffer overflow: 108 byte read of buffer size 96
 WARNING: CPU: 0 PID: 15 at lib/string_helpers.c:1036 __fortify_report+0x45/0x60
  __fortify_panic+0x9/0x10
  skb_metadata_dst_cmp+0x11b/0x120
  dev_gro_receive+0x303/0x620
  gro_receive_skb+0xc5/0x230
  gro_cell_poll+0x67/0xa0

Same disease as the tun_dst_unclone fix (4c6d43db2a4d), on the RX
sibling: kmalloc_flex() in metadata_dst_alloc() sets __counted_by for
the structure to options_len, which is then initialized to zero, so
the compiler's view of the metadata_dst tail is 96 bytes at the time
of the access. Geneve carries 108 bytes of options, and the combined
struct+options memcmp trips CONFIG_FORTIFY_SOURCE when built with
clang. Observed live on 6.18.54-talos with Cilium geneve, in
gro_cell_poll (gro_cells GRO on the geneve device) under sustained
cross-node RX; the warning is followed by a fatal Oops
(kernel BUG at lib/string_helpers.c:1043).

While here, fix a related overread: the memcmp length uses
a->u.tun_info.options_len for BOTH sides, so when b carries fewer
options than a the comparison reads past b's allocation. Pre-check
that both sides carry the same options_len and compare the options
through ip_tunnel_info_opts() so the counted_by view matches the read
length (the same two-stage shape the unclone fix uses).

Fixes: 69050f8d6d07 ("treewide: Replace kmalloc with kmalloc_obj for non-scalar types")
Cc: stable@vger.kernel.org
Reported-by: Jean-Paul Sergent <jpsergent@gmail.com>
Closes: https://lore.kernel.org/netdev/20261003005449.2675.1@jpsergent.gmail.com/
Assisted-by: LLM
---

Reproduced without the fix: live kernel panic on 6.18.54-talos
(Cilium geneve, gro_cell_poll) under sustained cross-node RX; trace
in the report. The fix itself is NOT build-tested - no kernel build
environment on the reporter's host.
---
 include/net/dst_metadata.h | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/include/net/dst_metadata.h b/include/net/dst_metadata.h
index f45d1e3..60878ea 100644
--- a/include/net/dst_metadata.h
+++ b/include/net/dst_metadata.h
@@ -115,10 +115,30 @@ static inline int skb_metadata_dst_cmp(const struct sk_buff *skb_a,
 	case METADATA_HW_PORT_MUX:
 		return memcmp(&a->u.port_info, &b->u.port_info,
 			      sizeof(a->u.port_info));
-	case METADATA_IP_TUNNEL:
-		return memcmp(&a->u.tun_info, &b->u.tun_info,
-			      sizeof(a->u.tun_info) +
-					 a->u.tun_info.options_len);
+	case METADATA_IP_TUNNEL: {
+		int ret;
+
+		/* Options lengths must match, or the options memcmp below
+		 * would read past b's allocation when b carries fewer
+		 * options than a.
+		 */
+		if (a->u.tun_info.options_len != b->u.tun_info.options_len)
+			return 1;
+		ret = memcmp(&a->u.tun_info, &b->u.tun_info,
+			     sizeof(a->u.tun_info));
+		if (ret)
+			return ret;
+		/* Compare the options through the flex-array member so the
+		 * compiler's __counted_by(options_len) view stays consistent
+		 * with the read length (same shape as the tun_dst_unclone
+		 * fix); a single memcmp of struct+options trips
+		 * CONFIG_FORTIFY_SOURCE when options_len is still 0 from
+		 * allocation time.
+		 */
+		return memcmp(ip_tunnel_info_opts(&a->u.tun_info),
+			      ip_tunnel_info_opts(&b->u.tun_info),
+			      a->u.tun_info.options_len);
+	}
 	case METADATA_MACSEC:
 		return memcmp(&a->u.macsec_info, &b->u.macsec_info,
 			      sizeof(a->u.macsec_info));
-- 
2.55.0

