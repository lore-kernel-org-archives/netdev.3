Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F32B3914F0
	for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 20:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789850120; cv=none; b=GLgfjsbXOHCuDUNksm4iniqWUKDV2Rd33U5dOL3LKUjvI20TpCWWwg9XBJR6rB+R/9L8/hy4ipJbRCzB/nOAin1s1GIigxhtW/G2VASbbuOFoP07lx87EYuYiMrLjmBt9s5WTvTqGNE+1H48/NSse71o/elA+/+daSruErZJMXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789850120; c=relaxed/simple;
	bh=OfksTvPub9kNIDxmVS42dElSISmp30hXX4Hjtet0m/E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jSS4y1gKf2b06nFGQfiMXjJP3HPvriSILmH2V1lfULgdcHKhw/INvfsLGjliC83hZkGKNh6nalcKwWjSiOwcrxHi0cOtcYBNxsn8ocR6VWSPR+SniqBOYHLuPmbqWys7rWEtDZiLK+ORXtsaIIB4VIupwcb8Gs9XuVK73cnx1b8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXMmC6MO; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXMmC6MO"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2dd77300825so18684785ad.1
        for <netdev@vger.kernel.org>; Sat, 19 Sep 2026 13:35:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789850119; x=1790454919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/G/e4ACavZZMwX4fe/povvUI6kdfCcPdqxB1SDfaHUI=;
        b=kXMmC6MOyRJtiKT0vyaCkxzHDJ30Vr5OirCzlXLueoC1bsznt+qSCq3RJ4DvN1rftj
         SBoozeiQJaYn2HikXQVTmj5ZwpBWfRBmaW9jNE4V7NOArNwxvtAf7KG9TXOso62FXIZo
         5s89jfoWM72wZI37gVK3sZ7cGuDUmvQGfnC9fZSWFpGUraFTcCiviQcasPZyZFWKuMLf
         it3jM1sdrTp83SG1hw4+IXjZc87QKeyx+jjkgAjMrh7fgYIQ5b/QhheMzogfOUH/rDn8
         F2IowNZ5DeAp1FLnU1WPpu/E70mGSnEUWToMbtBdMR/cXSotsPs4xuTch26o0w6jwBVV
         Kw6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789850119; x=1790454919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/G/e4ACavZZMwX4fe/povvUI6kdfCcPdqxB1SDfaHUI=;
        b=B+C98vxG8BenYHQt5hTmEZU+nDh1tS+yX+73Zp97sryR4pTONbMRuA4WvpPoAPjLaz
         yb9no1BzZe+9HvRJMHtg3EEKAf0Iji/M2fEwnOpZMk5GyJBsREg2gf2C+7ZrvMQ39PUS
         xJhK26Juvj8BSbnQMawI11JMVIJx8pMIkV8f7dlw6UybZq2YUrutln6uEHRIKrKeIqsn
         uXNOmmDi7yPpxg1SnKJS4gjJY1XOYTVo+Ao+dVZLgN85U5FzcH1m/Wh7SxL8ygt2ifoc
         3qulWzALhtmGR94LvXooimN36lrSwLWo/ubiuEFncUsAqZZnu584OHXCSdVv6JERTvXf
         bIIQ==
X-Forwarded-Encrypted: i=1; AKwUvBySN5LtreoKGZXcQ86iW41NOm5Ohx6RQP8d/vmXkuFZDlfh7iGaHxPaLk8zEUzy3fz/KfwkowA=@vger.kernel.org
X-Gm-Message-State: AFuF++kQzIA7SnsBJHmHM+kYe2UzsT3ViN1H+WkcgAOtste6ssml5NbI
	C3BRZzBB94h8C7uzonNjS0NXzlDtLnDgYBd8cHyLpKv4yypkL+zwdnhQ
X-Gm-Gg: AYBFou0K5V8QwqtUSIHKWk0kTTgvS9w2GKkIryozE1CXNhvMy3VtedRm2oWnLL9PUVV
	Fni8fqKOrdm5XJtVYOI/ke6Emuoz78QiB8ey5GJCn4//CtuyyFeujq7sz82OaUCT3m4c2rGeSkS
	9GWT3hCCC164UMdrthx7Y50xJAdolNM14pLRL2y/tBkxcHGPNGIBVf3N54LlnkUAiTmE+41Jfpu
	Jt1D5ICdh1con4vlEmKUrrTCBQSaCXZoYrjQM76A+xsH3tqoV3SEhlKTi5HQLbWp7Clg6u05deL
	jxXVOdF+Do+uTB6ePi8+GC/KDJJatLgvAOdSlTs+EET8mG1lw+GW5S0b2FNuHG8b/JT++WWe7H9
	kMbpnLxeztsGoCr5DUlH1aDONNpwNxp2qQAWj5LOXCh0L+4EF76UeKMN7+xVUMQxskhB9jh7zIo
	6aNpLjOHNIZnRQ+0+zlFlFXnVrIPBVnjma4xeu99EtiIQGjKTwqkiH2cvdCk3dAZI2aNvyq6RyM
	Ol3iNnQkaLTE+3V5hmEzp4FdPwTj2h/TNZYyNnmo63QI7FrxmquHGvZMJBVfqb6vbEjg3L2sfx3
	l0RoGp48qw==
X-Received: by 2002:a17:903:19ed:b0:2db:3d84:effc with SMTP id d9443c01a7336-2ddb1ab3ccamr105266095ad.6.1789850118925;
        Sat, 19 Sep 2026 13:35:18 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (78.123.83.34.bc.googleusercontent.com. [34.83.123.78])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17ba54dsm12550755ad.54.2026.09.19.13.35.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 13:35:18 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Daniel Borkmann <daniel@iogearbox.net>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>
Cc: Willem de Bruijn <willemb@google.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] bpf: reject unset network_header for SKF_NET_OFF in cBPF load helper
Date: Sat, 19 Sep 2026 20:35:17 +0000
Message-ID: <20260919203517.2581484-1-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In bpf_skb_load_helper_convert_offset(), SKF_LL_OFF checks
skb_mac_header_was_set(skb), whereas SKF_NET_OFF unconditionally returns:

        offset - SKF_NET_OFF + skb_network_offset(skb);

Unlike skb->mac_header (which __alloc_skb() initializes to ~0U),
skb->network_header is zero-initialized to 0. On sockets that reserve
headroom via skb_reserve() without setting a network header (such as
AF_UNIX sockets), skb->network_header remains 0, so
skb_network_offset(skb) evaluates to (skb->head - skb->data) = -headroom.

When bpf_skb_load_helper_(8, 16, 32)() then checks:

        if (headlen - offset >= len)
                return *(u8 *)(data + offset);

a negative converted offset (-headroom) satisfies `headlen - offset >= len`
and reads uninitialized skb->head headroom before skb->data (or before
skb_mac_header(skb) if mac_header was set without setting network_header).

Validate that skb->network_header is >= skb->mac_header when the MAC
header is set, or that skb_network_offset(skb) >= 0 and a network
protocol/header is present otherwise, returning INT_MIN (-EFAULT) when
the network header is unset.

Fixes: d4bac0288a2b ("bpf: support SKF_NET_OFF and SKF_LL_OFF on skb frags")
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
diff --git a/net/core/filter.c b/net/core/filter.c
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -231,8 +231,14 @@ static int bpf_skb_load_helper_convert_offset(const struct sk_buff *skb, int off
 	if (likely(offset >= 0))
 		return offset;
 
-	if (offset >= SKF_NET_OFF)
+	if (offset >= SKF_NET_OFF) {
+		if (skb_mac_header_was_set(skb) ?
+		    skb->network_header < skb->mac_header :
+		    (skb_network_offset(skb) < 0 ||
+		     (!skb->protocol && !skb->network_header)))
+			return INT_MIN;
 		return offset - SKF_NET_OFF + skb_network_offset(skb);
+	}
 
 	if (offset >= SKF_LL_OFF && skb_mac_header_was_set(skb))
 		return offset - SKF_LL_OFF + skb_mac_offset(skb);
-- 
2.43.0
