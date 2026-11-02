Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=103.168.172.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793661313;
	b=j8DBK9HVGQgOVWzYLU9DvPIVvTnjcnddA/wmKCfMyT/HsASGJ2lMw2HNMaJ3a2TMAH/g
	 dacWl6xvmH7wHWGMPvlhoS3A3qSHId61AlCEunq0sKK2whwlao1Xy8YwerBNuB34K+Ojk
	 AMLjJQ9wsb0K+ROfctk4XTXJV/EMKjRdRVAL/gpVMmNZF/EqLnqjS2LemgZ7RiV0/cGFs
	 i0PWufOwuFy0ytLfNt5+2aXa7Of88Qi6oPsqkfmHjD7rACVpmjHbE6PGj/R8P+948fJBo
	 FxxcIj+n7GLbXcq28b55ALlOUv8lLpbWdzoHak8fMRwztJ5aeDCrvVO33dVBQLBIyKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793661313;
	h=DMARC-Filter:Received:Received:DKIM-Signature:DKIM-Signature:
	 X-ME-Sender:X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:
	 Received:Received:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=7bd5Xv5qWbRwmBYlvVKZEYk+hw7JII6BrgO0bDV3OGw=;
	b=EHAzP1RemEJyvqdyrZ5Yx5OrAOler3DL0ekENXKnG0/XxOPH/ccwiEyp6nxwr1lM7Lkl
	 N0KF06gzEAt2ZBnTVP1pUWIjUhxDJKjcaURYRiLqhSfI7GtRiJt+qd6WFIc2pr2Oklltg
	 ZWVvKxk5DHxR1fC8JiGbEGbE1xsvtfTDh923auzSIbYiI6w+/0btrRL99TvOfwi12V/LG
	 2D1/At3B76fa92+lrQBnRCKAYe2AnkRexu13Jttb8ojUzk/Nx7mN+kGqdu1r/kTCevKyE
	 WEhw11q0se7kO211gf+/DXnvv223o1pG2HtZEHfErfQ5MmrGWlDqWV6GqFeuSoTWyBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bernat.ch;
	spf=pass smtp.mailfrom=luffy.cx;
	dkim=pass header.d=bernat.ch header.i=@bernat.ch header.a=rsa-sha256 header.s=fm1 header.b=L2ppz6OQ;
	dkim=pass header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=eef5Q6ef;
	arc=none smtp.remote-ip=103.168.172.157
Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DA5606A339
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 23:15:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D0DA5606A339
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bernat.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luffy.cx
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bernat.ch header.i=@bernat.ch header.a=rsa-sha256 header.s=fm1 header.b=L2ppz6OQ;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm2 header.b=eef5Q6ef
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C9658140024B
	for <netdev@vger.kernel.org>; Mon,  2 Nov 2026 18:15:11 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 02 Nov 2026 18:15:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bernat.ch; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:message-id:mime-version:reply-to
	:subject:subject:to:to; s=fm1; t=1793661311; x=1793747711; bh=7b
	d5Xv5qWbRwmBYlvVKZEYk+hw7JII6BrgO0bDV3OGw=; b=L2ppz6OQA8spwcEnlX
	O7CcUTViD6WdJIoMeooGdplP3OmW+YjFq5pU+P2VYIf8ZwljKyI4p+loZrxpG5+h
	XnXsCyj7N3G2B4JpuMCX3JV3Ki6O7mew81BDzT/11nZZuTn/LK+GrxHPlVjIrMn9
	PNfCkuU9DbPczEU/dNQQfhsrHljlUDYwvnJX+ddFxXqOf4E+9Jh6gRA872j/qXQA
	pVcAU+kGE7gy7QSh+j9IeCLOOBI6YeWS452o4Ppmro5S/ikubqWsNW/868nHl+Ga
	q6pc3je0isZBn7J6J+P0oL5AG2zeS3Jgs6C8N73v/K7PyIEoeDwG0GfONxvHDjLK
	sNLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:message-id:mime-version:reply-to:subject
	:subject:to:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1793661311; x=1793747711; bh=7bd5Xv5qWbRwmBYlvVKZEYk+hw7J
	II6BrgO0bDV3OGw=; b=eef5Q6efiIh7YIRjz5jR2aB44ZvJF0CrO6WoEjigCHiJ
	scLPkX/trP8yLalSHLAjYUaDQ5YU2Qp6exg44KpdDwpBLIrkguIO5xevotMhpcOw
	MEsWrL87Tx08sjQo+BMusw3Jo8YKNPpqON51FnuG01Lu9KrjDijCsv6QxWvgqQX4
	T1mUQByqRqYYFqGc7TIzxmG0WibtiIhAmcEL5ko9hD5N9ctLMSbjvNks+cmq7unY
	545C17gLnQKpFCgOV7/kVqUAEHIx85IxAie79fujCgICdNdo/QPFcz3Vxg6NQ2Mc
	hqTvqGtfPCnwt/uGcc9vs+F5ChglKAY9yIdA+AFcoA==
X-ME-Sender: <xms:fxnpahsk_3gpbbDKRvqeeyaQkBlAlaACR0xKMr9atxfv0YqbhAbK-A>
    <xme:fxnpatCBqqRC_yNzoRsaZ8GBvAbj3DYbpOmdLGUaCLh21xRdE9zPjdTHNdDX5VlQX
    lqD0IbiQM-sbpcAB0jFvLxQ4dMoAnCqf5S-aPS58UWYSzzvNaBScGma6g>
X-ME-Received: <xmr:fxnpaob6F-BrcnMUFcDwM4PfT7d3_YIIyy0R8XCRPgXkAnJgsMttxluY-A_HJgeIfbcAkuD1PRrEDJJ6i7s5WQNWEVr3>
X-ME-Proxy-Cause: dmFkZTGJRNdhgeTdp2RwStXiI1WQ7P0xiROqMWkOA341+SzhrKQphlBLrP0ew8ZLD7dWmY
    eDAaBDudjd0vjkC7xCiWG19ETHSZ4UzzSSbVdHh79a/LPi5eqhuxfsGyri9zp7JDnSbkjy
    suW906LUh4a6JCj9e80OMcfmNmyjd+6zNt4egGrHlRDOOzP6ipheGzMfhsrJ1DrMtJnLug
    4FCP8383nj809qyj+PGpI58qiYZjH6JEV1dTKksfPdkd9hPoSlfGLskKOU1Z8Y+quJhNat
    neqZjC1Y/wyh1RpZei2M3olseYJGNJR5eHqCwbojk2RrtNMK814bZ10LtP4fXEUC+cTjQu
    TLbnlX4bb1vmLDeRl8qzTG+o2tgZrgRsuPVF/rdL0nxSkKnKX0np11pcoyxX/ranlwZucS
    vk1E66XBXTfamtZy5HveVs5eqfc0kgVPfyY7l0Wtts6CcImzQvr5osPtulX1NvNI/MWuVy
    mphQ0edUC3K5mNWzk48lJXB1CD3T2AbQdm4zlthfnVs83DxLlzm4sa1FiGylf6YW91S6T+
    E1TnJSnW7MyD0wFG/1ha97VJKMvTH4mP4gWWmRK94qtq6xITRMpcHkQghFa3RJITMfclPa
    YaYI+Cybit9dhhjZtGBgZlH1uBT/XreWXHBzcnmegJ6Q2WJLoapBWzigPJ1Q
X-ME-Proxy: <xmx:fxnpaoXEXir097-ogSdYcWZXJ8u3AlykvGEwZYCrIMjSWI5GqGXxUQ>
    <xmx:fxnpanNaBTE_ebgCXt6VWD_ajrHMiTKsIqcDmQBcZPbWFl4YGB_Tcw>
    <xmx:fxnpaiaLMNwUsuB-LY1FTkaPtkJ9KB6ojVkeFJ26cMw05DhsC8-zFA>
    <xmx:fxnpam9fvmHEwXujhcODJ1HkoVaT6sM1Ktg6QO3DEx7d8Bo0wE-BGg>
    <xmx:fxnpal9oTWyJKyENfnin7rlh_X9c1M90e1r9X-KpZrrV1_35CjIRzNmh>
Feedback-ID: id69944f0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Nov 2026 18:15:11 -0500 (EST)
Received: by neo.luffy.cx (Postfix, from userid 500)
	id 6334CFF; Tue, 03 Nov 2026 00:15:09 +0100 (CET)
From: Vincent Bernat <vincent@bernat.ch>
To: David Ahern <dsahern@kernel.org>,
	Ido Schimmel <idosch@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Cc: Vincent Bernat <vincent@bernat.ch>
Subject: [PATCH] net/ipv4: check RTNH_F_LINKDOWN before ip_ignore_linkdown()
Date: Tue,  3 Nov 2026 00:13:30 +0100
Message-ID: <20261102231456.965943-1-vincent@bernat.ch>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In commit c0c5a60f0f13 ("net: evaluate
net.ipvX.conf.all.ignore_routes_with_linkdown"), I introduced a small
performance regression of about 5 cycles per lookup by adding several
dependent memory loads through `IN_DEV_ORCONF`.

This patch cancels this regression in the most common case where an
interface is not down.

Here is the distribution before this fix for lookups in a table with
500k /32 routes:

    min=128 max=4657 count=994104 batch=24 average=134 95th=134 90th=133 50th=132 mad=0
        value │                         ┊                            count
          128 │                                                        120
          129 │                                                       2232
          130 │▒                                                     25224
          131 │▒▒▒▒▒▒▒▒▒▒▒▒▒░                                       264264
          132 │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░             516480
          133 │▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░      126864
          134 │▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░      21624

The lighter shade of gray is the CDF. Here is the distribution after the
fix:

    min=124 max=208839 count=994104 batch=24 average=133 95th=128 90th=127 50th=126 mad=0
        value │                         ┊                            count
          124 │                                                        576
          125 │▒▒                                                    49440
          126 │▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░                      584904
          127 │▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░       284592
          128 │▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░      45288

The median lookup time goes from 132 to 126 cycls. Benchmark were run in
a VM pinned to an isolated CPU and running on an AMD EPYC 8024P (Zen
4c).

Signed-off-by: Vincent Bernat <vincent@bernat.ch>
---
 net/ipv4/fib_trie.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/fib_trie.c b/net/ipv4/fib_trie.c
index be1e40780ad7..39c8f441601c 100644
--- a/net/ipv4/fib_trie.c
+++ b/net/ipv4/fib_trie.c
@@ -1403,9 +1403,9 @@ bool fib_lookup_good_nhc(const struct fib_nh_common *nhc, int fib_flags,
 	if (nhc->nhc_flags & RTNH_F_DEAD)
 		return false;
 
-	if (ip_ignore_linkdown(nhc->nhc_dev) &&
-	    nhc->nhc_flags & RTNH_F_LINKDOWN &&
-	    !(fib_flags & FIB_LOOKUP_IGNORE_LINKSTATE))
+	if (nhc->nhc_flags & RTNH_F_LINKDOWN &&
+	    !(fib_flags & FIB_LOOKUP_IGNORE_LINKSTATE) &&
+	    ip_ignore_linkdown(nhc->nhc_dev))
 		return false;
 
 	if (flp->flowi4_oif && flp->flowi4_oif != nhc->nhc_oif)
-- 
2.55.0

