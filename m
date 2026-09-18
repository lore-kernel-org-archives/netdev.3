Received: from mail-pj2-f43.google.com (mail-pj2-f43.google.com [74.125.227.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38260396D0D
	for <netdev@vger.kernel.org>; Fri, 18 Sep 2026 01:28:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789694918; cv=none; b=XSqRAymIZ5zaI5DY4pzshiI65JEq4kkFaAB/HnBM1qn+mmMeMvlIYNUs130tz+3j0YnOUUCR9I9Ki863iUhBSFi2rfjsAtBGOuNaYfwX48yhVUSLt1zBF3K4KLKiq6muY+5aaV9JVKbJbosn4UsdeWWWtPPaS4i9d0LiAPxRoEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789694918; c=relaxed/simple;
	bh=Ea1aNPnDh7eYv/LKozZEW8Ct+6DzW2Xa4aTSnQ4yj/c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cUTo0C7ATtdFC5o/iPA+HQRuaNEHi0XEX++sY5TeGBg5/vJ3ckRX4NueB5WyPkqjVlRdvdAcrMUsFd9kaNl5znrlPct+hSseBDHcHqZaL9rL5DghizpDjUhwtxYf2wLNnXsxts7Xa1Rfa76D2Cu8iU/Q+dAX2bkvjv5n88vi+qM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RGgjdS2R; arc=none smtp.client-ip=74.125.227.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RGgjdS2R"
Received: by mail-pj2-f43.google.com with SMTP id 98e67ed59e1d1-39e03468a5fso237428a91.0
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 18:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789694911; x=1790299711; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=6FWo0FHn7Bo/KTGHYNGQsEOiCj/c++P+vjdoJVT5D3s=;
        b=RGgjdS2RT0uawIZa7CdVJjhBn0IipBMEcTBW+3uV0MSeO8i/L44D+vIycTiZpzttnb
         R29xg2fBuo2HuNiMeqeeu4gq2AcdBIFY7zu82C5nd/3Bxrg1HNEXVKaVcVHJVWrbQHVC
         WzbNAklOowf1DkwKVMbmuaKAEsX0TcFSuBHskH1L5cTD2J32RqlZ4Z6XxYI3pWvWS8n8
         xJvrI1jUisHTHRI1eTH3Bg408ThnvHI41xpkWPnh6cNKgPlG1w5lieuIsJv70c5ubnMY
         rzRIwtGxIB8PvoDl85Ry9+IMYsLanUJpSNfUBgIVaDG/Wkno51PuHggMDVPPdc6kyY1R
         IMwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789694911; x=1790299711;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=6FWo0FHn7Bo/KTGHYNGQsEOiCj/c++P+vjdoJVT5D3s=;
        b=p9sq+M/VJ7zPBmtU4im294jr3fDnvQFKn8y8ZvtUvE+rNxN+9j3npgTzWn/KB/F7dY
         U9gF6QowdJI9SHWMrEeWkvlW4J34oWNfgB19O+o9QUr3x7CGckF+tThb5Xd9hWHDB4td
         4/3Acxd/H4z/o8i/tf4kF7B2ne6ku3G8k+RkiNmvktZjKRuonN1YWPAKhk8igU2MdvUt
         GArukp/81IjdPq1EwlnFVctV5qvfw2mrGbdlSx4/NsvvB4uQCd89JQqJAsnaoCosJuDF
         VxmuZdPZPootuEqm/Uw7veCFhKYyi93LJFFGHvxeg65UMZbX+LZlXCYdKvKRlrhvjNr/
         1aWQ==
X-Gm-Message-State: AFuF++nxWJampomaEliii7TIn+UkuhSi1G1WPr18TWmNe78+/gls8qFv
	ndaDbHRYJEAWwcM4wVL4kyCfrI0Ks3xdi94SU9jWBdX72fAS/9gjMeDc
X-Gm-Gg: AYBFou3XOH1nxU2cG2oo7dZH9OSiWOjbxsmMj2JyeVWts39/RZQeitZbfX8U202k9J5
	0rvZwvhiRNM6sMGqMh+LbnO2dlJK36rMsqEMcYWYKdXPp1D4i51U+iIzqA9DbVMtXETLjQr5D3L
	q62RkokRlOjlqeMBIueQPYeGzxvuT9lsRdoYNK28xB7ioFADa3Zxpcil9lWyrW6l9Vg7NllzyIM
	RYjTvcTXTBE/wkO9TvJi+CimEqYzNk1hJXaQNUaQ7ZrMmXIhj3eUmukXVsSwd8Z4QZ4mx6L1TuL
	Fbv4wiVlzBVKDxzuMbqLmeXit+X3RGJwsAL0y5xcpwYuTAlIzmqHmrC7af0MUlnDEPcRT2MDpde
	CnhFRJgqSU8Ux/csmisC/VPGRPMEMEATAySDLwO+h6skWoaAvq0G7pCa7ESuWuwAbekslwKcupa
	aT2FiQ55oxg4YQFVoor7Pm8u9kVCVDgDjvrUNjAldM5E2Py0kZKDh83c3wfxKl9wdL69v+UKbq5
	wZ0oMoHlw==
X-Received: by 2002:a17:90b:2f04:b0:39b:3109:10ce with SMTP id 98e67ed59e1d1-39e54c9c1admr2049084a91.16.1789694910798;
        Thu, 17 Sep 2026 18:28:30 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e50a4bc22sm2108427a91.17.2026.09.17.18.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 18:28:30 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Fri, 18 Sep 2026 10:28:27 +0900
Subject: [PATCH net v2] net: ipv6: keep room for the mac header when
 growing the headroom
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260918-seg6-maclen-headroom-v2-1-4d370af55b2e@gmail.com>
X-B4-Tracking: v=1; b=H4sIALuTrGoC/32NwQ6CMBBEf4Xs2TVtCRA8+R+GQ10WWENb0yLRE
 P5dwLvHmbx5s0DiKJzgki0QeZYkwW/BnDKgwfqeUdotg1GmVLWuMHFforM0sseBbRtDcFjkNs9
 r0lVrCbbpM3In70N7A88TNL8yve4PpmkX7tggaQrxc5zP+oD//8waNSpDxFSoTtXltXdWxjMFB
 826rl+re/aQzwAAAA==
X-Change-ID: 20260917-seg6-maclen-headroom-53a339c17dac
To: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, Justin Iurman <justin.iurman@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5251;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=Ea1aNPnDh7eYv/LKozZEW8Ct+6DzW2Xa4aTSnQ4yj/c=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqrJO8ZQxhYSaMZG1i8Ws6R5JnPZDXSx+z93Pap
 hEa36QBNf6JAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCaqyTvAAKCRAq19F1Kl0b
 TR6yD/98e8z6+ZdgeHCI/5Lj5d2SkUB3nivYNcmkdfYCxf5jrtUXNO/StDnF6GC4IrmWRIFy9Wr
 qZD1ks9v0P7W3yeDjMD028xGi+2s7iGC30TDHoKPbHFkSEFBYPhtw5dKItkhJ5OMgtsrCPSUdOB
 8YsSmPoFPMy0nVFPggxQ+gWGT9y5oKTkHqXGXgyMK61OM2w5ZGml9Hb3Qq7fcob8LV67b1zHQaX
 4QzDESwcfLY/HpPIT9ERbMCOlJAowhxyOjA0RQpOEgifx1rfYsbSqdYsp/6evFILDiYxxuNhV8L
 LCKGyIhpZ29gLfq6R5x/1Lxay6o9RuWPlacsV/IFzMAXpYpo18vJ9V51SvIrJPnyhdGNcQ6hZ4/
 K0IfQgvlcYwbLc46k+w5/HdN3KD0jzdgp9Szxilrj+ZrxoMRIEueTd/9/7vs9zurr1mzxetVIve
 W6ep7cIlyWX4RpMrHun4fvNR7CEj0cpMUZOLg5uXpGdyG085EPKGXmLnQMa5U0hvMJHVCgzClPq
 Wgt4BAj+Yepluaa+pg7WBTT0sOhnGKmW1LjzgNtsZUwqg2ruFCBw1ijjAZcsQXezUKideTUi9xh
 5fmAp0bT1KjnpM3eWjgu37AweoGaJyepGwRhy0L3nuxovWoSlcBFv2DBxHjoSDTLEmUYy1g/EVK
 3/qvhPpGJY7wPLA==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

The seg6, ioam6 and rpl lwtunnels all grow the headroom with
skb_cow_head(), push their new headers into it, and then rebuild the mac
header below them with skb_mac_header_rebuild().  The headroom left
after the push has to be at least skb->mac_len for that rebuild, but the
requests ask for the pushed length plus dst_dev_overhead(), which leaves
LL_RESERVED_SPACE() of the egress device, 16 bytes for plain Ethernet.

Where the mac header is longer than that, as it is on ingress through a
VLAN device with reorder_hdr off, the rebuild runs out of room:
skb_set_mac_header(skb, -skb->mac_len) computes a negative offset,
stores it unchecked in the u16 skb->mac_header, and the memmove that
follows writes skb->mac_len bytes about 64 KB past skb->head.
Forwarding plain ping6 traffic through such a device reproduces it on
all five seg6 encapsulation modes and on the rpl and ioam6 inline paths;
skb->mac_header comes back as 65534 on a 704-byte head.

Ask for whichever of the two is larger.  These requests carried
skb->mac_len until the egress overhead took its place rather than
joining it.

Fixes: 40475b63761a ("net: ipv6: seg6_iptunnel: mitigate 2-realloc issue")
Fixes: dce525185bc9 ("net: ipv6: ioam6_iptunnel: mitigate 2-realloc issue")
Fixes: 985ec6f5e623 ("net: ipv6: rpl_iptunnel: mitigate 2-realloc issue")
Assisted-by: LLM
Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Reviewed-by: Justin Iurman <justin.iurman@gmail.com>
---
Changes in v2:
- Use max_t(unsigned int, ...) rather than max() [Justin]
- Make the same change in ioam6_iptunnel and rpl_iptunnel [Justin]
- Reproduce and verify the fix on those two as well: unpatched, rpl
  underflows in 12 of 16 probed configurations and ioam6 in 3 of 13,
  both reaching about 64 KB past a 320-byte head; patched, neither
  underflows in 18
- Rewrap the requests so they no longer exceed 80 columns
- Retitle for net: ipv6, now that the change spans three files
- Link to v1: https://lore.kernel.org/r/20260917-seg6-maclen-headroom-v1-1-02ccec50f096@gmail.com
---
 net/ipv6/ioam6_iptunnel.c |  8 ++++++--
 net/ipv6/rpl_iptunnel.c   |  4 +++-
 net/ipv6/seg6_iptunnel.c  | 12 +++++++++---
 3 files changed, 18 insertions(+), 6 deletions(-)

diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index cfb2c41634a0..4fc745f78eaf 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -262,7 +262,9 @@ static int ioam6_do_inline(struct net *net, struct sk_buff *skb,
 
 	hdrlen = (tuninfo->eh.hdrlen + 1) << 3;
 
-	err = skb_cow_head(skb, hdrlen + dst_dev_overhead(cache_dst, skb));
+	err = skb_cow_head(skb, hdrlen +
+			   max_t(unsigned int, skb->mac_len,
+				 dst_dev_overhead(cache_dst, skb)));
 	if (unlikely(err))
 		return err;
 
@@ -303,7 +305,9 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 	hdrlen = (tuninfo->eh.hdrlen + 1) << 3;
 	len = sizeof(*hdr) + hdrlen;
 
-	err = skb_cow_head(skb, len + dst_dev_overhead(cache_dst, skb));
+	err = skb_cow_head(skb, len +
+			   max_t(unsigned int, skb->mac_len,
+				 dst_dev_overhead(cache_dst, skb)));
 	if (unlikely(err))
 		return err;
 
diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index 4e10adcd70e8..69d5c7b61e36 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -154,7 +154,9 @@ static int rpl_do_srh_inline(struct sk_buff *skb, const struct rpl_lwt *rlwt,
 
 	hdrlen = ((csrh->hdrlen + 1) << 3);
 
-	err = skb_cow_head(skb, hdrlen + dst_dev_overhead(cache_dst, skb));
+	err = skb_cow_head(skb, hdrlen +
+			   max_t(unsigned int, skb->mac_len,
+				 dst_dev_overhead(cache_dst, skb)));
 	if (unlikely(err)) {
 		kfree(buf);
 		return err;
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 61c6a27bf202..ed0e8f3ef1f1 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -153,7 +153,9 @@ static int __seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
 	hdrlen = (osrh->hdrlen + 1) << 3;
 	tot_len = hdrlen + sizeof(*hdr);
 
-	err = skb_cow_head(skb, tot_len + dst_dev_overhead(cache_dst, skb));
+	err = skb_cow_head(skb, tot_len +
+			   max_t(unsigned int, skb->mac_len,
+				 dst_dev_overhead(cache_dst, skb)));
 	if (unlikely(err))
 		return err;
 
@@ -255,7 +257,9 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
 
 	tot_len = red_hdrlen + sizeof(struct ipv6hdr);
 
-	err = skb_cow_head(skb, tot_len + dst_dev_overhead(cache_dst, skb));
+	err = skb_cow_head(skb, tot_len +
+			   max_t(unsigned int, skb->mac_len,
+				 dst_dev_overhead(cache_dst, skb)));
 	if (unlikely(err))
 		return err;
 
@@ -351,7 +355,9 @@ static int __seg6_do_srh_inline(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
 
 	hdrlen = (osrh->hdrlen + 1) << 3;
 
-	err = skb_cow_head(skb, hdrlen + dst_dev_overhead(cache_dst, skb));
+	err = skb_cow_head(skb, hdrlen +
+			   max_t(unsigned int, skb->mac_len,
+				 dst_dev_overhead(cache_dst, skb)));
 	if (unlikely(err))
 		return err;
 

---
base-commit: 9a1599eeb8d18a2113e4cabcbd3bec5a8377dbed
change-id: 20260917-seg6-maclen-headroom-53a339c17dac

Best regards,
--  
Yuya Kusakabe <yuya.kusakabe@gmail.com>

