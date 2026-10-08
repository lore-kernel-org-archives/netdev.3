Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91C743E4BE
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 21:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493407; cv=none; b=fWTLwDoyUTiwIdni5QeYkjVx8L+kBM8o+XPt+QjtqOKyxs7d+RuS66+wqUjPMh/i4YZCsSuRHUDY54gD1me5s9ua/K20V7W7+LHL0qQqAoJEMUZ7gQCYbLJuNm3yxafDDzLpHARdbxJm4+uKtCjWvSTOQ08985VRABv3kalaIR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493407; c=relaxed/simple;
	bh=eNF9AfY31ifKJcp/wEnDWb5NxkFPFrVkSamyLYsUttM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KaxJZiEVt+D8Vo2AUMoA/WHtzzrJtTCAcsNlw9E1HRpYzhTNc87tW9uCqWcKOS4eF3nJ3e+96yW2CJ5lRFMqxW/CZrPe3HWk2FhOxZmINsSCJFFyhmw8MKMq5gfmTAyeJv8fFP/a/4f2cPYLL84N7+c+IjvCwcZmzAGH4JLtZtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=JhatXkic; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="JhatXkic"
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-9178510f3bdso42601846d6.2
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 14:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791493400; x=1792098200; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cJq2iGR6XjS9tOGb5y7ebTTlkIKkVZtFa6s12jsD6jo=;
        b=JhatXkic0EDV4M8l7ms0jUt7E9pE5+bxlKrgJP1O9N/ZibUN5IYjOoPzKtrGy67/DK
         Drs286lUUQTClCboZKrcDgbMdVELXgZzhLMPgFqegiaApPpbdTIlriLvA+wBoZqTs6vd
         Y6wPmcIanWZCH73XBLn8DJ7iG1xmRXljYNmE0hFf0Eix33HAYCnnwY/iGvDJTZgYdK4d
         68ug6wpHNND+cLVZDIeisi6bYWWUD0iiszn4ihyNILGowGAVQsg6zrEM1RpeSIjVw0mS
         WqfDE9OGh+4oVsj/hKq8yzM/rjQrjlZ7ZlzQm5xh0OstG0IDdY0byEnWQCmMU6ZB+e+m
         I6GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791493400; x=1792098200;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cJq2iGR6XjS9tOGb5y7ebTTlkIKkVZtFa6s12jsD6jo=;
        b=NUtMoUDu2ohG7UN8GVlTEiaA6ogiHQkPvVLOa2Bf16+TPlifWIQORrQMpVqFH7OvPu
         QxBhTLjp7Tw5/Hh7P+PenWXR3YBgGrHUzF7Vjt0TzNtKulysMYH9XTgoUkDOkfj61bBd
         A6EXYikqpkofKi4YABmQW6Nv874/odR0UL4dEtLomjHLI8LX30zxqpyYVopiRkByzhPf
         LrVkuX1Wj+LeqGl46qg/pRfgrBRbpWxGhmJN4iD4kYNKAJGL4V8r9b9yWYRAkxm5EUOS
         bBpz7AS3jbykJknwcbgoYHlMAj1aITVSY83oMzD0NooxD8FP552QL40/B4uKkSnBuE9H
         1cfg==
X-Forwarded-Encrypted: i=1; AKwUvBzkJ78IT63fldD3D4kXLQp4YFZeDRmeDPA3g86bnvna2PbworduL/zF9/sqKB3ZhQ1HL1/iwUo=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMWYQxYIaJcBsiKu63PX9J0sG10/ecRllKr7wMTDVcCzimTRob
	i1MHuegnBcGfOGCzRIcfPOFiI5HfSgnLhNjytEIlkUPEwrX14im4CR53N9O2DK0yPjI=
X-Gm-Gg: AYBFou2FMCsFq6dc5uVrOFFRDJEnmElkdGeOL2MhKyUi5q9RtL3I/2Rd3ed8cZGQWyg
	juFY4JLY0T4MKIdPlTMpcJXazW5ZwHGx0Bl2t+wy/EmE9bxbPBVgIM/ER5YlKgGr7Lb1bDcz7CM
	bikvm/AiZzUsU7Y63ePprRd/2F+a+qXZWSHmBt3n56HDtvvdisayxuWy+XlP0e6L6/I82t77Fxj
	w/nQ1eb0TADsWn3at8fqtwmX6cw258zeS6VAUjuy97ezzLZ25Ga49RxF9kWnqijEvu9T+4TUE8D
	fLgvguXqt4Rn3RS4q9LlfZYPqc3xAQjb7+fTqd9DjOAJfis6DXE91EL8x4AwG2Ja/VOYqt6hwv/
	FGqtDLGBEck+TfsTfWqC2zL7VQLAANh6PrhOO4th5ljXG216Zlvnz2LY6d5ClF9wysDuKGVRgxB
	K142qnx3YJ2yiEc6uzcDqn2ytX3gDmFQdmxj2XrytymyY/8N9K3SJNRa4ca39LCRNVmuaL1kYfG
	c7IsXATBAY422Q=
X-Received: by 2002:a05:6214:8506:10b0:91b:51ea:8f3e with SMTP id 6a1803df08f44-91b51ea9005mr10470996d6.49.1791493399667;
        Thu, 08 Oct 2026 14:03:19 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b55120027sm41246d6.49.2026.10.08.14.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 14:03:18 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Thu, 08 Oct 2026 21:02:48 +0000
Subject: [PATCH net-next v2 01/10] net: skbuff: add skb_drop_empty_frags()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-b4-pskb-pull-tail-drivers-v2-1-8f2bd9bee138@toxicpanda.com>
References: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
In-Reply-To: <20261008-b4-pskb-pull-tail-drivers-v2-0-8f2bd9bee138@toxicpanda.com>
To: Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Eric Dumazet <edumazet@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, 
 Mark Bloch <mbloch@nvidia.com>, Leon Romanovsky <leon@kernel.org>, 
 Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Manish Chopra <manishc@marvell.com>, Rahul Verma <rahulv@marvell.com>, 
 GR-Linux-NIC-Dev@marvell.com, Shahed Shaikh <shshaikh@marvell.com>, 
 Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org, 
 xen-devel@lists.xenproject.org, intel-wired-lan@lists.osuosl.org, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791493384; l=3047;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=eNF9AfY31ifKJcp/wEnDWb5NxkFPFrVkSamyLYsUttM=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QOI8lG/wdh6wd8yc4i7FHBwvmuyCaLtAuFDjmIGDKRvpDQpmhSkJsjkYyP5E/1+czZMvAKz61ka
 mmydLfI/gLQo=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

__pskb_pull_tail() releases every zero-length page frag as it walks the
frags array, even when it's asked to pull nothing.  Some drivers depend
on that.  xen-netfront calls it with a zero count on purpose to make
room when a backend fills the frags with empty slots, see commit
d81c5054a5d1 ("xen/netfront: tolerate frags with no data").  netxen and
qlcnic get the same effect when the frags they pull to fit a TX
descriptor happen to be empty.

pskb_may_pull() returns before getting there when the head already
holds the requested length, so these drivers can't simply switch to
it.  Add skb_drop_empty_frags() to do just that part, unsharing the skb
first if it's cloned like __pskb_pull_tail() does.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 include/linux/skbuff.h |  1 +
 net/core/skbuff.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 27ec1e38c828..c1295f6baf6d 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -2840,6 +2840,7 @@ static inline void *skb_pull_inline(struct sk_buff *skb, unsigned int len)
 void *skb_pull_data(struct sk_buff *skb, size_t len);
 
 void *__pskb_pull_tail(struct sk_buff *skb, int delta);
+int skb_drop_empty_frags(struct sk_buff *skb, gfp_t gfp);
 
 static __always_inline enum skb_drop_reason
 pskb_may_pull_reason(struct sk_buff *skb, unsigned int len)
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 43ebe61c7fc4..f798118df112 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -3004,6 +3004,46 @@ void *__pskb_pull_tail(struct sk_buff *skb, int delta)
 }
 EXPORT_SYMBOL(__pskb_pull_tail);
 
+/**
+ *	skb_drop_empty_frags - release the zero-length page frags of an skb
+ *	@skb: buffer to clean up
+ *	@gfp: allocation priority, used if @skb has to be unshared
+ *
+ *	Releases every page frag of @skb that holds no data and closes up
+ *	the frags array, so the remaining frags keep their order.  The
+ *	frag_list is left alone.  A cloned @skb is unshared first, since
+ *	the frags array is shared between clones.
+ *
+ *	Returns 0 on success, or -ENOMEM if @skb had to be unshared and
+ *	that failed, in which case @skb is unchanged.
+ */
+int skb_drop_empty_frags(struct sk_buff *skb, gfp_t gfp)
+{
+	struct skb_shared_info *shinfo = skb_shinfo(skb);
+	int i, k;
+
+	for (i = 0; i < shinfo->nr_frags; i++)
+		if (!skb_frag_size(&shinfo->frags[i]))
+			break;
+	if (i == shinfo->nr_frags)
+		return 0;
+
+	if (skb_unclone(skb, gfp))
+		return -ENOMEM;
+
+	shinfo = skb_shinfo(skb);
+	for (i = 0, k = 0; i < shinfo->nr_frags; i++) {
+		if (!skb_frag_size(&shinfo->frags[i])) {
+			skb_frag_unref(skb, i);
+			continue;
+		}
+		shinfo->frags[k++] = shinfo->frags[i];
+	}
+	shinfo->nr_frags = k;
+	return 0;
+}
+EXPORT_SYMBOL(skb_drop_empty_frags);
+
 /**
  *	skb_copy_bits - copy bits from skb to kernel buffer
  *	@skb: source skb

-- 
2.55.0

