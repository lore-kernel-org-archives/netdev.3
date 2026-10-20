Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.177
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792478629;
	b=aWwbaCWag1UVtD0FNG6l1sW959TXTlHfrvA9DcwvByBen7uJlI82CtYGGXiUc6y1sfWM
	 u+yjuqwX+qNqJfkB1RGZio/867ai/2Cp8tCJk8B6nCb0PHGjxxfPHmDi8NYh7/2sbUZDE
	 OuAjmkQV6OlNpQnxitoBhLRiwPP99ydiuanP7v83KaDWZyRGZEJqbgdg6nVorZLrrgPYl
	 yZTn3/0o8Gz+8kXMxIA3dmrYGkPWK2h8fKQIsUXs87m4SqttUCWEVgpuQ0T6kkrYxO/d6
	 A6aM+4XBavhOu6IqBsQIqK+Esr1ft9XknfYgtLgi0zfVW3Y5BTg8yPR/BptLTFmuPUA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792478629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0xYz+Ag6ETolcHWRJ2JKQnLDMlAkiPQPGE34hRBKeWw=;
	b=g9hSP7zk0XYEpk8bmhFQwMADeH47QIWUKNkrul5SOcBns8vqfGtuIUSWy28yrKzfk648
	 tR6vnogFoQjlo+KkxiddprM7HLooV2UUJU8ggRF4jWoVntyZkZg4hgKDl+aGsONlMGE8g
	 ry2eswhvPJdy5I7seuEEBYX5zozS3phlPcYM01kPpp+x1SEs2hU0UnvulfgyHcL0+YshV
	 xpL61QKyizlw3z5JfDXqJ0iCDjq4upoIyYTMr7oN/Ijw3mnqpu1zIl61U9Wf4wo/HvZyJ
	 IwjRbnb+ss07mc2YoB1qevGKgYydxMTfWrXK9XFI7YBnqqQzqmCT6kRfClUJjBsZRuw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nebusec.ai;
	spf=pass smtp.mailfrom=nebusec.ai;
	dkim=pass header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=n55TSVmJ;
	arc=none smtp.remote-ip=74.125.82.177
Received: from mail-dy1-f177.google.com (mail-dy1-f177.google.com [74.125.82.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16E9E606A327
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 06:43:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 16E9E606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=nebusec.ai header.i=@nebusec.ai header.a=rsa-sha256 header.s=google header.b=n55TSVmJ
Received: by mail-dy1-f177.google.com with SMTP id 5a478bee46e88-354ba08cfd1so5252595eec.1
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 23:43:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1792478628; x=1793083428; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0xYz+Ag6ETolcHWRJ2JKQnLDMlAkiPQPGE34hRBKeWw=;
        b=n55TSVmJwKVVZsGG5q397Aj4pnL0dAT3T156zuvMa/POxNLLXkAOyXXxsDbioENuVm
         JQp40uMqOUM1hEDshSP7y1wpkMrGaG9UzHRgfbNqI1SLSusAvjcCajQJ1RMop2jf04W8
         RMerrbnBwNDGB3FC5h7uMcY9bsFRGcn1uL8pxiqc4BFL8+oFbf2vbPEIPAy/RNCwbbbR
         UAMlutfotwYc31z4ONsreie7sXz1qvAs69C4XjBw3rwnz/0fCZigofliOuPxNOPyV+Y2
         D0xEpL9qaExVbu1FNFT7gBYaFhF8g7vuMD8lODbezbvylc67UgABoPEAjiemIwTlGbne
         7qvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792478628; x=1793083428;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0xYz+Ag6ETolcHWRJ2JKQnLDMlAkiPQPGE34hRBKeWw=;
        b=s3eJo2+Iy0XWpKxw7moDQS50igL+OeOYdq8D6KHxUdvyFjIXQ4KKofi+z/vZ4VM78R
         OlvkZOuOE2JhvyxFwr/uWFpDJRxwQCHO3OgjM/51jHx0RTtdzvH4pt6eHYk3JeToxN+G
         h4VirlnB7TuFVBhdEpIMYClKU4onBEeKfhHU1EEOcp/6FB4S4/fCjriYbEg+k/pn4Cl+
         4gycMgrKjJ/wCbRvz5oGzwSLJjFYSxP8IIkUuqlQ5dgI1q4rH4DfqlP+L1ECk0P0+FSF
         O9dylAdWj6eoPIgcOhhVBDllcSiE0lhOg0PL7tzn0rolscOJIvq5acAcgT7yW5GV8UOW
         DlPg==
X-Forwarded-Encrypted: i=1; AKwUvBwLxVSpJlHvc1j6TuB4Hbk5YETYLwhJpbf1G0hfEONZpIiNDBUL/f4wqwyUQtcX9xIYNqD+LNc=@vger.kernel.org
X-Gm-Message-State: AFq9FYKoX/ji6Mwzz9THxcVFcj/raPc1NGObRLe/L+L67N4Xnb4BlpAT
	mc5ccVsHETcW0NlCpOdPgWbNGtzY51esa40GYb//GCMQA0AsDhK+q4lqj5ZXqeAr2q/b
X-Gm-Gg: AYBFou29P+9qRrG7Vc6s2BVdMQoOus/jnpJ1vj+lZ2HRwaQ+uRCRxYC/UnBACQEPvgE
	vUcFxhWrTl0fDVU6z0AvGbAKzn1NsMPystOpIIPiT/n+EetDs+tmN3JmTJxBirEl5UOiGo2PLbC
	828ZUHOyRs/KA1fngF/ME1LBUXGEDswO5TcfRhYhmPz8HtynxYbbK06SOHr+TiPXoKL8vCaapYL
	GM/rdDoYhz+53g57tuY0eAdmmH2MAeMKb7Pk1SO8/Pn+07nGUPxRdUoAkOmlGIYMf2fMzUcpoys
	2oCDJ/MsuerQGEQhfbry1haQPI4TBdgq1pEO3lO+RVsL7AQCpcbMFs16GlGxokq4lOv0g0UTApK
	LkeYTfi9gInMychT+czFAfsLQhdj+aj6ZcKPy2DmlaubwYZ3mkMxy2N90M6/koNXhrc6zwuP02i
	p1puc0Bq7gSsicE1HOVbs8HMjoQCx9AP0Mr115EG6SDWSbhGRjlq1k0Evg/UumZksNtYMqJNONl
	WebPX89ydyn3w==
X-Received: by 2002:a05:7301:2a95:b0:366:4514:955b with SMTP id 5a478bee46e88-36645149899mr1091439eec.20.1792478628090;
        Mon, 19 Oct 2026 23:43:48 -0700 (PDT)
Received: from Roxy.sysu.edu.cn ([203.175.14.54])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-366639806a5sm1885010eec.6.2026.10.19.23.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 23:43:47 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: idosch@nvidia.com,
	namangulati@google.com,
	netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net v2 1/1] ipmr: validate VIF indexes before offload lookup
Date: Tue, 20 Oct 2026 14:43:34 +0800
Message-ID: <23ce70e99d6c710bdc4cf065d70350b754ed8f66.1792476942.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <cover.1792476942.git.zhilinz@nebusec.ai>
References: <cover.1792476942.git.zhilinz@nebusec.ai>
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

A packet can race with VIF publication and make ipmr_find_vif() return
-1 even though the VIF device pointer is already visible. In the IPv4
path, checking only the MFC parent device then allows forwarding to
continue with an invalid ingress VIF. Besides the offload lookup, this
can let (*,G) forwarding loop the packet back out the ingress VIF.

Reject packets whose ingress VIF cannot be found in both IPv4 and IPv6
forwarding. The IPv4 offload helper also checks for a negative ingress
index before deriving vif_table pointers. The output index comes from
the bounded MFC output-interface iteration, so it does not need a
separate check.

The out-of-bounds read in ipmr_forward_offloaded() requires an skb
marked for L3 forwarding offload, which is currently done by mlxsw.
The race is rare; the supplied PoC triggers a UBSAN report for the
negative array index, but does not demonstrate an actual out-of-bounds
read.

Fixes: 4eadb88244d1 ("ipmr: do not acquire mrt_lock while calling ip_mr_forward()")
Fixes: 9b1c21d898fd ("ip6mr: do not acquire mrt_lock while calling ip6_mr_forward()")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Link: https://lore.kernel.org/netdev/b966eb102e98f299e45be59ada033a8766e4c6df.1791899747.git.zhilinz@nebusec.ai/
Suggested-by: Ido Schimmel <idosch@nvidia.com>
Suggested-by: Naman Gulati <namangulati@google.com>
Assisted-by: LLM
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
changes in v2:
  - Reject packets with an unknown ingress VIF in IPv4 and IPv6 forwarding.
  - Keep only the negative in_vifi check in the offload helper; out_vifi is
    bounded by the MFC output-interface iteration.
  - Add the Fixes tag for the corresponding IPv6 forwarding change.
  - Clarify that an actual OOB read requires the mlxsw offload mark and that
    the PoC reports the UBSAN negative-index diagnostic only.
  - v1 Link: https://lore.kernel.org/netdev/b966eb102e98f299e45be59ada033a8766e4c6df.1791899747.git.zhilinz@nebusec.ai/

 net/ipv4/ipmr.c  | 11 ++++++++---
 net/ipv6/ip6mr.c |  3 ++-
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/ipmr.c b/net/ipv4/ipmr.c
index b9c544d48c452..d10a66534ef9f 100644
--- a/net/ipv4/ipmr.c
+++ b/net/ipv4/ipmr.c
@@ -1879,11 +1879,15 @@ static inline int ipmr_forward_finish(struct net *net, struct sock *sk,
 static bool ipmr_forward_offloaded(struct sk_buff *skb, struct mr_table *mrt,
 				   int in_vifi, int out_vifi)
 {
-	struct vif_device *out_vif = &mrt->vif_table[out_vifi];
-	struct vif_device *in_vif = &mrt->vif_table[in_vifi];
+	struct vif_device *out_vif, *in_vif;
 
 	if (!skb->offload_l3_fwd_mark)
 		return false;
+	if (in_vifi < 0)
+		return false;
+
+	out_vif = &mrt->vif_table[out_vifi];
+	in_vif = &mrt->vif_table[in_vifi];
 	if (!out_vif->dev_parent_id.id_len || !in_vif->dev_parent_id.id_len)
 		return false;
 	return netdev_phys_item_id_same(&out_vif->dev_parent_id,
@@ -2064,7 +2068,8 @@ static void ip_mr_forward(struct net *net, struct mr_table *mrt,
 	}
 
 	/* Wrong interface: drop packet and (maybe) send PIM assert. */
-	if (rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
+	if (true_vifi < 0 ||
+	    rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
 		if (rt_is_output_route(skb_rtable(skb))) {
 			/* It is our own packet, looped back.
 			 * Very complicated situation...
diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index 9d8116b5edb17..faaf04f5c4f33 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -2218,7 +2218,8 @@ static void ip6_mr_forward(struct net *net, struct mr_table *mrt,
 	/*
 	 * Wrong interface: drop packet and (maybe) send PIM assert.
 	 */
-	if (rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
+	if (true_vifi < 0 ||
+	    rcu_access_pointer(mrt->vif_table[vif].dev) != dev) {
 		atomic_long_inc(&c->_c.mfc_un.res.wrong_if);
 
 		if (true_vifi >= 0 && READ_ONCE(mrt->mroute_do_assert) &&
-- 
2.55.0

