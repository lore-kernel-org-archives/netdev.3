Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60B539182A
	for <netdev@vger.kernel.org>; Mon,  3 Aug 2026 05:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785735304; cv=none; b=HpnTplsjG/oD2qERctgL/ttRFMjBtX6wal6pELiK0VZ2mVwWNN94QrVmPqI3KuSrULCMngorhVCgCgYiroEzw9Up/+Dtcu+r4GluLqEgr7ECSn10phcwds4y0OE9oz4UjQx1OnjFj1q4jVt5CP9nxlZCsiwTFzRUzodBsbJWHRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785735304; c=relaxed/simple;
	bh=JBlrocB1L0LZXmHhxXK5cCB7MSOqWyW+kXr5VQOVOa4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FAdH3/bbvklK/vtmwAOHZtlpqVektjhu+erOhicbgCZcLUKJdjSV3duHQVbfPq1cZETsI4vG3o7YrIThnODkUOmrgy9AO/ktb81omU99vuzwxTZDuBv/l4cLggQhGoP6M/PkyIgVdyUB3jbVs0T3ZTDXs7WVUwOXU4L7uunBEWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=Wr9tE/D2; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="Wr9tE/D2"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-848479c9bd5so2385581b3a.3
        for <netdev@vger.kernel.org>; Sun, 02 Aug 2026 22:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1785735302; x=1786340102; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TudxJOQLfnxVzJrzoAbpIK8UcBMVw06MbVw4E1g/laQ=;
        b=Wr9tE/D2Q6yd9lb1+qrjnRV+ZJGDi28r1YlBCbyP6+c7IpyidKxuTewdnkOlJQea3T
         k+o2txv1Hzi8F2DfRxPU0i9pkkw6KRqUK1Y6rSZa5y5VDCLcTKsyGY6bOS9hhuT02eXT
         zhp6qEf0qvwzE7Sj4gaOJS8FXJ1UXGit7YsQ4Y2jkOs5xEr2IJbx/YjBM7ylgfL2LPII
         Qd5+oVhwb44tJEn4samJL8fa/AGVHwA0/yrEYNhh7amgrcpKMJ8zZ7iwaXaooBMd/FZF
         ao3hnWFB4hGiycRdzOuH26/MpveMUdOlWpRUtOhEfGQIHZ57zrqLPOrQ5OmIcfVP+PwC
         s86A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785735302; x=1786340102;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=TudxJOQLfnxVzJrzoAbpIK8UcBMVw06MbVw4E1g/laQ=;
        b=Oc7QtZAO/9o7jR6o0IbSVawxGpVYHH+zbpT56WnGvwocaZC/PV9auY4y+muqcSPMM0
         x2/BPjF71DA4FFKu/E3oS38172TNWF3rQL1UwojfQ9tnMFfSB0q4O2LPFQ99hJpdmnSV
         Fow9JaQ9HGOuU6qbowd4yi5TztG0SGFxUbST1Gz8QmsyHSu4pUCFLZHtls8PBUcLyRwg
         ibePMadd4txf+IIZw5bsk9RUUWOSJNuiRuN0FY/kj5ABclZcWfMAg3Gz+LjwORKJJC8e
         6tx3q+m2rinrMAfn9cjgOuvcLkCZfSnTnTkH0SsBIWkQaHt0enp55IXEhVr/Il30R/c7
         MCJw==
X-Gm-Message-State: AOJu0YxIHF9Wtnn4jyeNgrWPpN1giQTNBqdFXidE5a44jgj+tYslqWUs
	IjzgXto5CyVZIz9ae+9GQG7V09dfiLCOAXrdzWdjSWgWg4X55X1AYBJcoC8PxcQuzZTd10VGoLz
	0C7bd1g0w1G2UgQ==
X-Gm-Gg: AR+sD104+KqRkahwCnPbrq2o+NAD3Cu6n+C1wiwFUzfm15RIrTC/5JVTtswHtusL+EN
	MVMvZRPpGBFVZpdg9xyzQLNb6HT1zfshHpEcUuy9tWVzIuA3fMOSxlU20cwrA+FYOTmi0LttIVo
	L370Q7VZetVgl3IA4/fvxymLVTVsjUS8Xfalvbix+9mO7caQ7eRkaJJG1RQkJthc9wWzNWa7ljd
	F5ByS3dC6aCaUbFH4C4I7WMgoe9COHjJNGTjNfFTDdItfLonRNSQYnz4gW5AJKYw9q/BLifV+Xu
	LGM2J0go4Lg2D+T8tOLhb5mLK2b5NdtJCACSvg1weVZ/di6YqBnM4N+pqYADCaRkdRqWf/9dbjS
	gNa96OqupQtBa7idvUWS/QbSFD3rTQxqnsNRRVD40mxq1I04GWxnctby/5cGb4+KEP65lIndYsv
	65/8uionPJD/+58C2IYQtPxkeypYc33Bst7hVrGhz6qHT9RAHP5FbaP6Gj67j834OXfyiAuW1zS
	yns1jlL3fE+rg==
X-Received: by 2002:a05:6a00:4b51:b0:848:438d:3665 with SMTP id d2e1a72fcca58-84ee48bcd15mr7768604b3a.41.1785735302128;
        Sun, 02 Aug 2026 22:35:02 -0700 (PDT)
Received: from Roxy.localdomain ([202.8.9.242])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84edbe57020sm3169178b3a.17.2026.08.02.22.34.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Aug 2026 22:35:01 -0700 (PDT)
From: Zhiling Zou <zhilinz@nebusec.ai>
To: netdev@vger.kernel.org
Cc: dsahern@kernel.org,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	tom@herbertland.com,
	vega@nebusec.ai,
	zhilinz@nebusec.ai
Subject: [PATCH net 1/1] ip6_tunnel: use skb_cow_head() in ip6_tnl_xmit()
Date: Mon,  3 Aug 2026 13:34:46 +0800
Message-ID: <7f099879785257f4d57d6caf9b6308fc76c7aaea.1785734738.git.zhilinz@nebusec.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1785734738.git.zhilinz@nebusec.ai>
References: <cover.1785734738.git.zhilinz@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ip6_tnl_xmit() may need to expand headroom before it can push the
outer IPv6 and optional encap headers. It currently does that with
skb_realloc_headroom(), copies skb->sk ownership, consumes the original
skb, and then continues processing with the replacement skb kept only in
its local variable.

That is safe only if the helper cannot fail afterwards. But this helper
still has post-reallocation error exits. collect_md tunnels reject
non-NONE encap after the replacement, and ip6_tnl_encap() can also fail
later. In those cases the helper returns an error to its callers while
the caller still only has the original skb pointer.

Both ip6_tnl_start_xmit() and the IPv6 GRE paths free the caller skb on
error, so they can end up freeing an skb that ip6_tnl_xmit() already
consumed.

Use skb_cow_head() instead. It provides the required headroom and
writability without privately replacing the caller-owned skb, so later
error returns cannot leave callers with a stale pointer.

Fixes: 058214a4d1df ("ip6_tun: Add infrastructure for doing encapsulation")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Signed-off-by: Zhiling Zou <zhilinz@nebusec.ai>
---
 net/ipv6/ip6_tunnel.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index bf8e40af60b08..fdce16eed0ca3 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1233,19 +1233,8 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	 */
 	max_headroom += LL_RESERVED_SPACE(tdev);
 
-	if (skb_headroom(skb) < max_headroom || skb_shared(skb) ||
-	    (skb_cloned(skb) && !skb_clone_writable(skb, 0))) {
-		struct sk_buff *new_skb;
-
-		new_skb = skb_realloc_headroom(skb, max_headroom);
-		if (!new_skb)
-			goto tx_err_dst_release;
-
-		if (skb->sk)
-			skb_set_owner_w(new_skb, skb->sk);
-		consume_skb(skb);
-		skb = new_skb;
-	}
+	if (skb_cow_head(skb, max_headroom))
+		goto tx_err_dst_release;
 
 	if (t->parms.collect_md) {
 		if (t->encap.type != TUNNEL_ENCAP_NONE)
-- 
2.43.0

