Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4724A260F
	for <netdev@vger.kernel.org>; Thu,  1 Oct 2026 07:57:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790841481; cv=none; b=oOO5VmkVEHpDoKU7v+8msWXaRCTTUeAIv8Y7i9rphz9kdtCMFNxqt2CTuud5M6oQkFJpK4bh7/ndDeFsdVhbOeAjUzAhzbjG1wbYwEBjKxkone7vz6mqrV9Y+qST/0HAzLpcAGHrU/yAP8hnomGfT7cfQEqTIcNI3wT21ktNsVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790841481; c=relaxed/simple;
	bh=sTtKUgpMkuhMNyNO5mmsvvRIISMyXvHDTqf5CEHFjz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y77WoBr67+ggopqE6UMTe3pzk/OoLvWHUIsiHeuvMt07bLY7L9IJJjyAC4txd7XFRffDFyGP7hDNFL4qhqYL2u0dNURhZct83oY2LAJX8w76fnsE1jXq6l417z2auNI6lkFtrR5dF9GsT1AHPXGymdqU19KSiBFzkIF6yjb0K7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net; spf=pass smtp.mailfrom=queasysnail.net; dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b=J68j0YLX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hKOidCyG; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=queasysnail.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=queasysnail.net header.i=@queasysnail.net header.b="J68j0YLX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hKOidCyG"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E12B27A0010;
	Thu,  1 Oct 2026 03:57:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Thu, 01 Oct 2026 03:57:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=queasysnail.net;
	 h=cc:cc:content-transfer-encoding:content-type:date:date:from
	:from:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm2; t=1790841478; x=
	1790927878; bh=7aGxtmKNVgr89VcKPPbpCAxJ4edUrPMBHjDhQNuzwCg=; b=J
	68j0YLXUvd6zo25kyrZbu6Yi+dk3okRRgbS+8QGZNGjLnbmCjOA8GoSlTwux9X7f
	VN4AZ6EnHaHXyMcUMnSiYFWV9/szmU3KwYnonDQpw3CxN9N3nJJ8U8a48Z19F+JR
	FGFcmYKUQzGNuxxKZS8jhO+5sAeaBW3f7qPsmfdOxxzb6tdysKCbUzXYC3R1/JrR
	K4GiBkIuetA5oTXvOOgwfophegMtLTc3rGCJyEIn8FMpwPxE82jtzge9Kg0ZS2PZ
	7mZvD5a+hmCieIYaC4tU2e2WrG7krZpZrBUwpcJjstXzwMaUAomjADBTsPrwXpBs
	zN32KcZ6Tu3AMD8SMK6Tg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:date:date:feedback-id:feedback-id:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
	:x-me-sender:x-sasl-enc; s=fm1; t=1790841478; x=1790927878; bh=7
	aGxtmKNVgr89VcKPPbpCAxJ4edUrPMBHjDhQNuzwCg=; b=hKOidCyGp3/t9L5XP
	Md8Tb1rORat7/I6F4pYR5x1YIahfXjBgfQ4W0D3UZ4FeSt8ABCVndsJWBL14gTic
	rs7nI7cxlm57IiaCHH6JfzrUaP1TTip8fGfKwpzEr+Ucdw8v4NTqLM01sLbSfeov
	y4cbE6zsHsr6j2LvCChWaXh8mdyd/Cayo3WUn86kQUpM+FJ2tKY68IK8gdv7pppR
	ynx53pskS6tASbrJqXQR1k577/cv1eecd/QEfexoN9fLFzW9ZI9aAIyiPPj2ZbY7
	iZyEgyuuDtaGYKKHSI0PCqz6dPTOKuChXpXx4aI3ks0pa+i0n9WNRNmHAJvYqNQ/
	5YV+A==
X-ME-Sender: <xms:hhK-asUFawaaGyu67mVLvRhnU-VUZPCO-lKknOvlC_zSVvDXTuV6ng>
    <xme:hhK-amkS8OJhij4dVpXrkZMWwW2MEsgLfLkm3lhFEq4ixqY5yYeszzs8L-lfBo-mh
    1lZ9KFsGdT4RzCKS6r1uY-H-WajDxsYkkrRXJ92E00zgRlESx-DmmzP>
X-ME-Received: <xmr:hhK-auAi14s9v79Mg1D6-9-uyAvqNqg8Bsgw5In0vu70kpCpUHo3vt1bhvye>
X-ME-Proxy-Cause: dmFkZTGrlCWeHT+g+Zlf20e7uU3eZJyAipOOtczwBxzD7N3VyNOdxX/HBzbROOe5wu2/jR
    Vw8dtcU/d3uOEsrzk+lFNWUrPvjFDLSiNivpRofFj2lF/LCgnEyhBSAP8cmPmNhT7V9t/q
    uW/FhjwihsfkbcruXtDMaTObPhDJ49E9a187VcUVbXYYUyXOTpdxWKJr2aUcUIJ0JWsezP
    y8EyxskdQyV2BcdK/O3U/kT2U7IItGK22qtPNXdsi9NIK0Cw+Z4I6Pd50W9VRJSgiB0mmZ
    pnaL9JDhMXJ8gB8BhAaKhbV6vHiB2rGYhxSHLtOQw0X/dtY/TfpDYSqEUWJGc3FPV19zRU
    j624IRyk5vFJBND/XPrM9TRph4BUCAY0MawS0DtBW5Wk2Z7UrzQwN/FDn5XFyfDmjpaXok
    Q0+ckzVvhcjVwjOhwvZBsjZaZIAFlFJUIr0ixr9D7Nzglwi57WyByOxt5+iJoi3pDXuEsZ
    YoQNXf+TYBJRYI6J7ZgjNrc3pIbjyA5bbab3aBKVY5/3KQiDo6EMOkuNYZ4BymokQ4IyzG
    XXPEWrC4wD3SGXkOYnPtpcpiuhZJd9vcgImcB6HalAhRuHBJ8+1rs1/f4ab8CJc/0xQF5k
    fUrqTVdoU5bMVYNaL5dNVLHxcSQ+ZK5Z7A7qIvlThR4pa8kdp4Ks04JLMJMg
X-ME-Proxy: <xmx:hhK-amdiSWJGTh45rrO6p4VW4R8GsCSNFdsuWvOjKOOgYvqIKOWdcg>
    <xmx:hhK-apLtYbroCbUjsbX-gXxmiug_lcGEp0Su4nP7zTgi0PINIznMVA>
    <xmx:hhK-apc-U5OLxx6d1Umz8jCpi5_wLYUex2gbnZ0d_zf2c5Ufbpmdaw>
    <xmx:hhK-ag0DdgWbhz2mikEp2Pfzt8wZwEtdLRQRx9T7S2YrXWU9RNvZZQ>
    <xmx:hhK-antaFwgL0-pj9X6LQC6sRcief-Q4HPvMrZEA0BdlWiVUCIrIF-dz>
Feedback-ID: i934648bf:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 03:57:58 -0400 (EDT)
From: Sabrina Dubroca <sd@queasysnail.net>
To: netdev@vger.kernel.org
Cc: Sabrina Dubroca <sd@queasysnail.net>
Subject: [PATCH net-next 4/5] net: strparser: removed the aborted bit and aborts counter
Date: Thu,  1 Oct 2026 09:57:28 +0200
Message-ID: <53d83ac52f192a7cf2a8decaf72d454cbb86211a.1790702233.git.sd@queasysnail.net>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1790702233.git.sd@queasysnail.net>
References: <cover.1790702233.git.sd@queasysnail.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

strp->aborted is never set, so the aborts counter is also never
updated. Remove them, and hard-code a 0 in kcm_stats_seq_show() to
preserve the user-visible format.

Signed-off-by: Sabrina Dubroca <sd@queasysnail.net>
---
 include/net/strparser.h | 5 -----
 net/kcm/kcmproc.c       | 2 +-
 2 files changed, 1 insertion(+), 6 deletions(-)

diff --git a/include/net/strparser.h b/include/net/strparser.h
index a72dff8e6a3f..3c9c8ca08828 100644
--- a/include/net/strparser.h
+++ b/include/net/strparser.h
@@ -32,7 +32,6 @@ struct strp_aggr_stats {
 	unsigned int msg_too_big;
 	unsigned int msg_timeouts;
 	unsigned int bad_hdr_len;
-	unsigned int aborts;
 	unsigned int interrupted;
 	unsigned int unrecov_intr;
 };
@@ -90,7 +89,6 @@ struct strparser {
 
 	u32 stopped : 1;
 	u32 paused : 1;
-	u32 aborted : 1;
 	u32 interrupted : 1;
 	u32 unrecov_intr : 1;
 
@@ -128,8 +126,6 @@ static inline void save_strp_stats(struct strparser *strp,
 	SAVE_PSOCK_STATS(bad_hdr_len);
 #undef SAVE_PSOCK_STATS
 
-	if (strp->aborted)
-		agg_stats->aborts++;
 	if (strp->interrupted)
 		agg_stats->interrupted++;
 	if (strp->unrecov_intr)
@@ -147,7 +143,6 @@ static inline void aggregate_strp_stats(struct strp_aggr_stats *stats,
 	SAVE_PSOCK_STATS(msg_too_big);
 	SAVE_PSOCK_STATS(msg_timeouts);
 	SAVE_PSOCK_STATS(bad_hdr_len);
-	SAVE_PSOCK_STATS(aborts);
 	SAVE_PSOCK_STATS(interrupted);
 	SAVE_PSOCK_STATS(unrecov_intr);
 #undef SAVE_PSOCK_STATS
diff --git a/net/kcm/kcmproc.c b/net/kcm/kcmproc.c
index 25c1007f1098..f065406f57a8 100644
--- a/net/kcm/kcmproc.c
+++ b/net/kcm/kcmproc.c
@@ -332,7 +332,7 @@ static int kcm_stats_seq_show(struct seq_file *seq, void *v)
 		   psock_stats.tx_bytes,
 		   psock_stats.reserved,
 		   psock_stats.unreserved,
-		   strp_stats.aborts,
+		   0,
 		   strp_stats.interrupted,
 		   strp_stats.unrecov_intr,
 		   strp_stats.mem_fail,
-- 
2.55.0

