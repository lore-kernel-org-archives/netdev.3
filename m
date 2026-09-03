Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EE241D11E
	for <netdev@vger.kernel.org>; Thu,  3 Sep 2026 08:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788423788; cv=none; b=LtyLGXHwOrqdJAh6GwVCdsxFIOGwqA79iZlwOwAah1wyKo9Jde8dZqWputfEJu97k1OA11i5Hsa6WyIb2yD+HVwvpAxd/kbqJcNz+U/Lte7aA/j431B1FoY7mBrxX3ET2fFR4OdRHtiTP6EjBNjTwEr8bBQ33LBen3kLNCFDCds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788423788; c=relaxed/simple;
	bh=CoPjRai4bpFjpoO1hLKHz2e2vlHftvEQRd7hfXf92Ag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pcCfuRuA350lvXisglh+YyL/z80CDy7M018kUmVi1zRr0F7po7QR8GbqP7S2aF8g4d6Wv6CsDeklRJDKwfx2NfcMkew8xeCBmDafh42r+MAVlv2EGeENvGdKZhtLouoVjlil+x6lTkwB7lOk1FTdcXyL2OxyeAtV01KqbyLo9KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S3ZocCh5; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S3ZocCh5"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-398b1e63c49so711418a91.0
        for <netdev@vger.kernel.org>; Thu, 03 Sep 2026 01:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788423787; x=1789028587; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=xhPbHg14H3tGTjrunsG8Oim1GGIOwgeAe8+HMzV8sU8=;
        b=S3ZocCh5rBnlA4UjvTcXJd4h2VyexIKbjqBTMJ7xem2CX94uA4E8LwVAbNDu8kpAhE
         /HXBZx08LN/Dj9aKXqhasYvan3xZZuvdFfFs3hH3qVBzRJ3Tj/mj1V29JHGU8AzjfHx5
         3v4AsGH5f89EKtmZnzbwMfXtytMpIJCSrvf0JMU+cCz4EIOvTQUMgfg6thwPlkrFPSfi
         KYL9X/ScPc3IzUwbFeaFNCU3Pbc7GZCsvfAHirIGNoMBnFRmbvGK/8jXuUkOPdquG/tw
         VA0L0oG4rfujJuILFjyuSCxKFrgD58rfUa+ZHk+rU9/qgMEstGmagyJVJzqgjdXfDqaH
         limA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788423787; x=1789028587;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=xhPbHg14H3tGTjrunsG8Oim1GGIOwgeAe8+HMzV8sU8=;
        b=VZ8P3EK7lOxpWBeFgfNblm+nQUyM7gi0boxtUDVEMFQtLZhbrrUxPaBJA5z0ve/Okg
         dC4XODfP2isrDa6FrCXjTQk/wcYem5jxwIV4PVx3IjrbI6PDsttLUa849S7nqrA5fi7L
         2lyzrdZDdsWxLHAGjzLY0S57M/5DqXmKLsMXI0F/iVLGo5sEU25zkswYA56HfHcZ9puI
         nJTM/SklEVjVNSlDKK5TpVP36vdSFJVHDzFoxn5+1NuMBzVjmQ65CZvHMVvXaf2Hik1Q
         1rjekgSekQp6ihSB3qpdvAQFohLN/mq/7tf2uaddvn3vG0V4QOA8Z6hHPeQYN3OAWd2b
         0o+Q==
X-Gm-Message-State: AFuF++mIZ/ukglxd1dQ+1U7Ci8hFWhtnkbKV4HYYZAA8EOqvf7012pDT
	wDAdo3j3rF9qEups8UgSHMGKKRFturwLiXTaz8go9AHXyWArqIhTiMk6
X-Gm-Gg: AYBFou2F4qyD2Qhyi+AJayv/8TIzPsK5FO7HiL25/Q1LjSdwDQ2bFPDIbodrnQmlOVg
	80bzheIQOdTetbJ+Gr0PqM1NwVWJg/L2HDz9Q6WSSVF+gv6n0ddXXEpg8JrXZtPh7gC7TC8PHhA
	Vuyw/cijp30VaY3Sm/zhsSkh1n8f3zN3LvNvizFjpNbTanE1mT6p1f5ZEEIU8OACU1wsxfsQvyi
	C2Pxy1lNky60nMb9thXUt8sQaAmNQ8hIpRXnbfub+wSwBHGDluesdTMM2WZhGV2ZFrFZEJt83lg
	KGY2FCD61PWr7v1e8mGcEaBQBfNAcuZWcesKIIhbQRGcipGSxzSgb0TvIdJ1g9dpF45rHahiu/1
	MYdi6aG54YCRkplY0agt9IjYFbxYhhAuZNM/A5UKhoiVCchhipwTtTzA3QTDZg93as0iDUHRbbc
	OUjS/nMGJElcUGRVIXxkJuGqDt82nNMMNpdf69IoK9mMos6SEkNSBV5VTkVOEJESB33oR6BmLaa
	tOT7rLn4EjHRFYLwaqWuBQ=
X-Received: by 2002:a17:90b:3a43:b0:398:9bd3:d6d2 with SMTP id 98e67ed59e1d1-39b132c749amr1858214a91.12.1788423786715;
        Thu, 03 Sep 2026 01:23:06 -0700 (PDT)
Received: from [163.43.103.131] ([163.43.103.131])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b083e7167sm3935106a91.5.2026.09.03.01.23.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 01:23:05 -0700 (PDT)
From: Yuya Kusakabe <yuya.kusakabe@gmail.com>
Date: Thu, 03 Sep 2026 17:23:03 +0900
Subject: [PATCH net-next v2] seg6: reallocate the skb head on L2
 encapsulation only when needed
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260903-seg6-l2cow-v2-1-f37b3b35416f@gmail.com>
X-B4-Tracking: v=1; b=H4sIAGYumWoC/22NwQ6CMBBEf4Xs2TV0QVBO/ofhAGWFNdCatiKG8
 O8CXj2+zMybGTw7YQ9FNIPjUbxYswIdItBdZVpGaVYGiimLLzGh5zbDnrR9Y543OqmrVFFCsA6
 eju8y7bIbGA5oeApQ/hL/qh+sw+baup34YN1n/x3Vvvh3MSpUyGdKNJPK0lN6bYdK+qO2A5TLs
 nwBVxxA1sAAAAA=
X-Change-ID: 20260902-seg6-l2cow-77dc3ba41232
To: Andrea Mayer <andrea.mayer@uniroma2.it>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Yuya Kusakabe <yuya.kusakabe@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=3182;
 i=yuya.kusakabe@gmail.com; h=from:subject:message-id;
 bh=CoPjRai4bpFjpoO1hLKHz2e2vlHftvEQRd7hfXf92Ag=;
 b=owEBbQKS/ZANAwAIASrX0XUqXRtNAcsmYgBqmS5nq5bTFbnbILmPv6FT2+yXLmmrErSttIPg5
 FtGyPvpU06JAjMEAAEIAB0WIQTaB7usAfxNKMeqa6Yq19F1Kl0bTQUCapkuZwAKCRAq19F1Kl0b
 TVAiEADWnPbScQ4WTCY18T9nAQTjMDNhqU7GEV160rNxffYKl0pYpvrGRD9bqH81nOngIbnVBQr
 rMVGu6g9BqmFFwTRrVK9dmqKUUtD5ZHsUdJgQz503kTgsVHhga9VBGhxiEHDT4/bTmdnEz/D7PR
 3WUZpMqdcxyaizjDNyx/K4k/rVGl9AdpeM+Ju+0SUQQgEbvbhkzK1HxK6dT5APSGgP+J0SBlC2m
 PBCkDQyXBBfzxypYQYuf4QqUcDuaALga7n8u8zB0MWYSUe+PswGsuYjTXeYkv6nKUAqLi9pq4gd
 Dc0vsANWPECbgICxZY49nFZT/FgJntXpjw8Yf/XothBhx9X/DpZMh8er50kPeO7BIti09oLWat+
 SnDVp53uBnp0lChMQJG/Tq87+ZsK+dDqJL8N+h49XtZo/FbDwQXnHxe5Ec5cTf1C0RvTzVEDUTt
 GpQU18nSjy91kt84X9XymIbMFgbAraHJhz6R79z/bpzu5+zuJc9DEnZ/bmqqdrOaDpwIPERAFBU
 XBx82cmo2y8ETkjsSf2SKwmHX/0iKgMjJdT0C8l6dd7uF1VgthSkXdpXvahsBpsDlAceKSttePC
 UBcgitID3KuH5OJCgaEueRwGeKcnAiHeJ+VGlROHdGI1b7ujzxfEtwNDiXvQhYxmGFeeGQjkMLt
 /OZTc96ZResZULw==
X-Developer-Key: i=yuya.kusakabe@gmail.com; a=openpgp;
 fpr=DA07BBAC01FC4D28C7AA6BA62AD7D1752A5D1B4D

The L2 encapsulation modes of the seg6 lwtunnel reallocate the skb head
on every packet, where the IPv6 encapsulation modes reallocate only when
they have to.  Ask for the whole encapsulation up front instead, so that
the reallocation happens at most once and only when the headroom really
is too small:

  skb->mac_len + sizeof(struct ipv6hdr) + ipv6_optlen(tinfo->srh)
  + dst_dev_overhead(cache_dst, skb)

__seg6_do_srh_encap() then finds the room it needs and its own
skb_cow_head() becomes a no-op.

Drivers reserve more than that on the forwarding path, so the
reallocation usually disappears altogether.  A single-segment policy
on ixgbe needs

  14 (mac_len) + 40 (ipv6hdr) + 24 (SRH) + 16 (LL_RESERVED_SPACE) = 94

against the 206 bytes the driver leaves.  Where the headroom is
smaller, as on a veth pair, pskb_expand_head() is called once per
forwarded packet instead of twice.  Asking only for skb->mac_len would
still take two whenever the skb is header-cloned, because the cow that
unclones it does not also make room for the outer header.

The cost is amplified by CONFIG_INIT_ON_ALLOC_DEFAULT_ON, which many
distributions enable: every new head is zeroed in full, and that memset
alone accounts for 16% of the datapath profile.

Throughput at 0.5% packet loss, 64-byte frames forwarded through one
2.30 GHz core (Xeon E5-2650 v3, ixgbe 82599ES), offered by TRex and
binary-searched over 10 runs of 10 s:

  Before: 654.6 kpps
  After:  965.7 kpps

Assisted-by: Claude:claude-opus-5
Signed-off-by: Yuya Kusakabe <yuya.kusakabe@gmail.com>
---
Changes in v2:
- Ask for the whole encapsulation headroom at once, so that a cloned
  skb no longer takes a second reallocation inside
  __seg6_do_srh_encap() [Eric]
- Re-measure against unpatched net-next rather than an older base
- Link to v1: https://lore.kernel.org/r/20260902-seg6-l2cow-v1-1-e823ce216454@gmail.com
---
 net/ipv6/seg6_iptunnel.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 61c6a27bf202..ecd8146089ee 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -400,6 +400,7 @@ static int seg6_do_srh(struct sk_buff *skb, struct dst_entry *cache_dst)
 	struct dst_entry *dst = skb_dst(skb);
 	struct seg6_iptunnel_encap *tinfo;
 	struct seg6_lwt *slwt;
+	unsigned int headroom;
 	int proto, err = 0;
 
 	slwt = seg6_lwt_lwtunnel(dst->lwtstate);
@@ -446,8 +447,13 @@ static int seg6_do_srh(struct sk_buff *skb, struct dst_entry *cache_dst)
 		if (!skb_mac_header_was_set(skb))
 			return -EINVAL;
 
-		if (pskb_expand_head(skb, skb->mac_len, 0, GFP_ATOMIC) < 0)
-			return -ENOMEM;
+		headroom = skb->mac_len + sizeof(struct ipv6hdr) +
+			   ipv6_optlen(tinfo->srh) +
+			   dst_dev_overhead(cache_dst, skb);
+
+		err = skb_cow_head(skb, headroom);
+		if (unlikely(err))
+			return err;
 
 		skb_mac_header_rebuild(skb);
 		skb_push(skb, skb->mac_len);

---
base-commit: c8ea08ba34f2a2e9bfb18ff3d69eb2d69b324f49
change-id: 20260902-seg6-l2cow-77dc3ba41232

Best regards,
--  
Yuya Kusakabe <yuya.kusakabe@gmail.com>

