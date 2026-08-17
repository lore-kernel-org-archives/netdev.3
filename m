Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15EA03F928B
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 13:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786973884; cv=none; b=mX7TDA1tn38lvy3ah3Hh3K4A0ee4UySayvCFsEXbyLGUD/KjQtG0vjr/0AQIEoWWLO0nVOVc1NcMwHa7e6dC9fAGnyP8G5e+m6dRQl90QA5jbMSTQ6J0c1IEGg7PUp5rKexfFKjSx6FL9Szl8/0D4rVRr+eR8FpDGvJUO5s5nYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786973884; c=relaxed/simple;
	bh=CC3JC1giahHEy9sjcaKvgoScSXSfuw8gg/e6vEdqmPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Dts3+x1S6Fy9maXfgIVXBr8afm5tauXEz/5z+oRAgUyHaKkqTszS+pUbCsoDX5dcM+5NTGco/PQa5hEmMIcM5gM93muBKYwPiSILYMAJPBvC9EIXmcmKJ6evkd7q4NE445WQwAob3TGMJIHaRoaavERvvmfMh6w2FzQJvwBylnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jeGhDhTq; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jeGhDhTq"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-47f703a9e5dso1562588f8f.0
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 06:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786973878; x=1787578678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=zkp4KPcClMvoNogOQGnOerubTOxqG8PDXc/dySr0Dq4=;
        b=jeGhDhTqfvnk214WxoFyBMeeAjQQ0rbtnLUvA/VkTvw+sRnX1d8IfItV83IzxzdJXS
         EGP6O+O2ckNQFagqlDfr0uqumIHAblBmGtJ5Pyl/xdBopTEJg/ju/rzqZn3yfbQpNDAs
         5f73QGykKjlNQMKEdkIOned/LvwoxpXuI2biZwgto/ehu1gOK8JD6VGZU2jO7XqwPLXU
         CwTGMbWEpuGTdK6pb1aw4Vn69T4tcuky7jnKIPxqgZrDtD291NFwfO9k1xQaE1rs2kkQ
         bRY3pEfHgHH+YfjFGO/zYQQSsHiRsjKVP80rc67NmKmRVt6L3RXqY2sR20pzRgaOuBb6
         asMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786973878; x=1787578678;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zkp4KPcClMvoNogOQGnOerubTOxqG8PDXc/dySr0Dq4=;
        b=jVFl31PIJf612u7N5CGT1dFC01HF7QclTiDtm2LkLFR/+AGvO4QNyoGC4+vdQUGY0P
         n0eKLw+fCrDwSzipcD6wsOjnnMfb9GQuy8QJa0bFuuaaqOK/TUnshuIqJ5GqD4MCeCcC
         c/+BW2KEXUgbf1YsgWSz5jr3VG6PGXxmhI2+soOEfJMW/PsTqzT0IB2+j7+hDcGu6YTW
         uF3zxpCJPiWxJp/NQXRx332aA6voXkDO1pvO85t0nWiTWYEHeBG29yQFE80/FYJqTvKV
         LIirN341vsCTrg7rgVWZECjsDyS3wWV7jByzS8Z6SWum0D021Q00wCtwnHX8460S6AqL
         A3kg==
X-Forwarded-Encrypted: i=1; AHgh+RqQ+XAgVCeA22dyE9+SYSzPhS7Q+Fixsefzg6+RqSef91aSvwi3bbtTs0mpBTAobdBYwViTrQQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBcfT51i8DiIsX6hzKXGTwsPomzCLRGYBTVRh36ktLssTtvnqV
	YFGEqGR6X/m/d8M6FetGCDnGHf3vP/+M/pPD8HBcH0d+WAEC+L1YA1sb
X-Gm-Gg: AR+sD11I0ldBdsoK8bcdl4v4Zh97Zfk0BOY82WQ+GSQgeW+N2BXId/CAazZ8UzaDmm2
	anzCUfBKc7ij0qU8uMi/WBGDNJziIgJjenc08dqA315aZGB7b3Nj4RWEnNeY+0taOOclEoZBjNJ
	kzZN3mCVSCML7NshDZiLCqOhydaAlStNMWnH1Ypb5UhxNmCdHjmWHADf+vCtkbUFF++kDeH0OUo
	TbtzPge+Bg+SkAvtHXYe3YrpxHPoNXJGExo3thE6FKZCmnmoxH+Q+jHQ+Flx06BWTK/oGeMR6AP
	sjUsiUaD7DSjVBF7ak65Apc+r/f+A20lRS/+A565w1UqX9it8jqhm/n+0+ptxiz3EaPkV1I7edM
	Erfh+vL++zxp391kCoRp4vgdV521fzUfAkYzJFqcjUg6snh0KpPwu4TjBOHo47GG3Mzza8tcKe7
	aTli1C3vv8x2BAwtnK/QPW69W/6FKrefD0QZY4if3YS9y5G5TKbTmvLgsXBIdYlfDV0bgrx+o/
X-Received: by 2002:a05:6000:46d7:b0:47f:9447:62bf with SMTP id ffacd0b85a97d-482a8fea9e4mr389507f8f.2.1786973878093;
        Mon, 17 Aug 2026 06:37:58 -0700 (PDT)
Received: from localhost.localdomain ([41.251.64.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-482a5b81715sm4141667f8f.35.2026.08.17.06.37.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 06:37:57 -0700 (PDT)
From: Maher Azzouzi <maherazz04@gmail.com>
To: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Maher Azzouzi <maherazz04@gmail.com>
Subject: [PATCH net v2] esp: downgrade zerocopy managed frags before mutating skb frags
Date: Mon, 17 Aug 2026 14:37:52 +0100
Message-Id: <20260817133752.30033-1-maherazz04@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On the out-of-place output path (esp->inplace == false) ESP rewrites the
skb frag array: esp_output_head() appends a trailer frag and
esp_output_tail() replaces the frags with a destination page, both
referenced with get_page().

When the skb carries zerocopy managed frags (SKBFL_MANAGED_FRAG_REFS) the
payload frags are owned by the ubuf and must not be referenced or
unreferenced individually, but ESP mutates the frag array without ever
downgrading the skb.  This breaks the managed-frag invariant two ways:

  - esp_ssg_unref() walks the source scatterlist and drops a page
    reference for every frag, including the ubuf-owned payload frags,
    pushing their refcount below the GUP pin bias while the pages are
    still pinned, i.e. a use-after-free of the zerocopy pages;

  - esp_output_tail() installs its destination page as frag 0 with
    get_page() but leaves SKBFL_MANAGED_FRAG_REFS set, so
    skb_release_data() takes the skip_unref branch and never drops that
    reference, leaking the x->xfrag page at packet rate.

Fix this the way every other frag-mutating site does (__ip_append_data(),
__ip6_append_data(), tcp_sendmsg_locked()) and call
skb_zcopy_downgrade_managed() before ESP touches the frag array: it takes
a real reference on each existing frag and clears SKBFL_MANAGED_FRAG_REFS,
so the per-frag unref in esp_ssg_unref() and the frag release in
skb_release_data() are both balanced and no mixed-ownership frag array is
left behind.

Fixes: 753f1ca4e1e5 ("net: introduce managed frags infrastructure")
Signed-off-by: Maher Azzouzi <maherazz04@gmail.com>
---
Changes in v2:
 - Use skb_zcopy_downgrade_managed() before ESP mutates the frag array,
   instead of the early return in esp_ssg_unref().  As pointed out in
   review, that early return also suppressed release of the ESP-owned
   trailer and destination page references (a leak); downgrading the skb
   the way __ip_append_data() does fixes both the underflow and the leak.
 - Fix the Fixes: tag - the bug needs managed frags (753f1ca4e1e5), not
   the 2017 skb_cow_data avoidance commits.

v1: https://lore.kernel.org/netdev/20260712170530.9807-1-maherazz04@gmail.com/

 net/ipv4/esp4.c | 6 ++++++
 net/ipv6/esp6.c | 6 ++++++
 2 files changed, 12 insertions(+)

diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
index dfc81ee..faa48f5 100644
--- a/net/ipv4/esp4.c
+++ b/net/ipv4/esp4.c
@@ -441,6 +441,12 @@ int esp_output_head(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
 
 			esp->inplace = false;
 
+			/* Take real page refs and clear SKBFL_MANAGED_FRAG_REFS before
+			 * we mutate the frag array, so the per-frag unref stays balanced
+			 * for zerocopy managed frags (see __ip_append_data()).
+			 */
+			skb_zcopy_downgrade_managed(skb);
+
 			allocsize = ALIGN(tailen, L1_CACHE_BYTES);
 
 			spin_lock_bh(&x->lock);
diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
index 296b579..a3a3857 100644
--- a/net/ipv6/esp6.c
+++ b/net/ipv6/esp6.c
@@ -470,6 +470,12 @@ int esp6_output_head(struct xfrm_state *x, struct sk_buff *skb, struct esp_info
 
 			esp->inplace = false;
 
+			/* Take real page refs and clear SKBFL_MANAGED_FRAG_REFS before
+			 * we mutate the frag array, so the per-frag unref stays balanced
+			 * for zerocopy managed frags (see __ip_append_data()).
+			 */
+			skb_zcopy_downgrade_managed(skb);
+
 			allocsize = ALIGN(tailen, L1_CACHE_BYTES);
 
 			spin_lock_bh(&x->lock);
-- 
2.34.1

