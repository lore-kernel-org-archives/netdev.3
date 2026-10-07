Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B73AB3B5850
	for <netdev@vger.kernel.org>; Wed,  7 Oct 2026 17:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791394581; cv=none; b=PXb9AvndzJZyNNtrv3cpOCVKKSgxC+6DZ4CDYFNFBVqKjVBtvSVl4htGAjUOqDnD2m2QemoPWRSPcTMgsclGZ6sas0DSphQClCJYrYjGH8dnqgtB5fMU37ZURdQFYdI9x62eP7HZYdp5vyf6XOu+b8peiGRIixuApl9fNhuUjtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791394581; c=relaxed/simple;
	bh=j/d4+6UO1zMm/OSkoPxAoOFd0Pid5fsU1BUtdsYxUhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=s1uTjM4ukOnUjeH4NF2dYyWs/XzjRPsjsUHpiTFp+Kip0kWheB8s0/IHmPuZNdBYyyO48yYSa9/D/FS4dC9FeyKYkEq//6/Z3ivc7p1c/+vGFD0IoG0FLTW4Np6v+3lsNzdlYgyvpPGygLdaS/tR/yp+8z5OsBfZDaz1/XQkpy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=iV3HriRt; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="iV3HriRt"
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-533930955a4so19558471cf.3
        for <netdev@vger.kernel.org>; Wed, 07 Oct 2026 10:36:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791394576; x=1791999376; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mjHNn5scKRu7GjAo0oWLpeiDoRV+YLIFjeS0Mb9ZdUA=;
        b=iV3HriRtDNH9EGhJ7J0p+1mmNHuFN5pJ00M+mxmLUVtApKu5GiisvdUWAcsbRXAxn5
         EXfj3YanXLDbSaotyRCq8bfXvjz+bUScPDNcnoxmrIZjxH2sH6d/twDZh7QDYjbScpds
         onZ1B9UUshxH1/qxg8LoUWEa8AAOPbJnxjhifEw34e5J1TJAlPpy2zFN3Jg+t8u1JRil
         k6V0TmOLulQUrVAM0sEcArIXkNBznejFJFj+Gcbwv2ATWrKSQJFgLmkpJENE511vrbka
         KnBuh1oZEHL1XMAe9HGSbhaEtJb1HYuDomjujLs5T1Jt63GV56GARd5bySrEZbieNcxu
         pF/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791394576; x=1791999376;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mjHNn5scKRu7GjAo0oWLpeiDoRV+YLIFjeS0Mb9ZdUA=;
        b=yW/qL4awrXePS9nb2OIB5Za9cwR7W7FLAeu3LMdrFV2cTgKWJJgR/Kq0Nqjjact1ko
         yvSpZ2Wr9zJZf+tSwHuVP3mGPhBJLTiLVmfnSogrHOvaclfx6fKk7z66hoGOo8CLu9sH
         qwpZI/YXb5HpXWynmitTgfpqHDTDZQEvKbYT7P3XcSwMCcULL2MIOmSkpcJiDNWkYeMc
         21JpqOPUminSivS/rK6kA0QagUGq2QZ8zy+3qQkS2uBZs4yaCOmDnh667CwS8XzRKFE+
         qiX4fUm7aLyXJ/N41Jl4YegKo4pD1b4rhIUBkSARiRW2VNFqijOxV/kjSYcy5CqQTxVR
         oHfg==
X-Gm-Message-State: AFuF++mlN2XvxLHAGuQRt3382rZuQmzblWYAYueOFb5/eKo0TCD5cBht
	Z94Cf5Xd4JVxhTrK/itWQuGZXpK322MpDVYN8sUbAO1nefukNCn8SFJBlKUI5FlRPtQvpsBHjkQ
	05bVB1XU=
X-Gm-Gg: AYBFou1uMOvZNjbU0Cbha/6rckhwDQu2/JpmgnCVYsOFJ647krfZ0ubqEjZKJJf2aVH
	sSpzg3yIs30HGTyMSz7rSbRcqRbhkUdlo81uuRbn6mAKkeuw08g3uWE507tg0L/miz+PWwaht+m
	uAWQeIv0EVeT33YAFPiwaj7VgHvHugT9jH4qkQ2Tgvp3U7Py4y0GXEC0cGDnncbmgE7LBXhHA9m
	A0/Fcin0oW/9BFNsE5qe7b7f5R1vnrzhL/r3vHatCnsefdDTtrEI8PADwJDLeeWGS8/lPmfYL+e
	kRnd7Dq8PHMeqtPWzOMa98Cboz4TzWCldA3Ig2xKCXHji6OuzU3+XXSJ5vCAm+2fIo6UFh0Oai6
	6npd6ffFEC89bY9OW3eaqtJD7ZfB8+CC+o5HitaNynuLjbUXWDAAJTbltyZAn4EHolSvatqrdjo
	Wld52bDafmQm51t0SXUdmOqJF5WZGgeGZ532cnGZf7lBf6MwxJy0b2CApYgWwSVgxrEC8F9wbqq
	aKwbY2/XgAY8l4=
X-Received: by 2002:a05:620a:450a:b0:93e:7ec5:1832 with SMTP id af79cd13be357-93e9b70037emr607249785a.23.1791394574606;
        Wed, 07 Oct 2026 10:36:14 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e99157d6asm267866485a.23.2026.10.07.10.36.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 10:36:13 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 07 Oct 2026 17:36:00 +0000
Subject: [PATCH net-next v2 1/8] net: skbuff: don't BUG() on bad arguments
 to pskb_expand_head()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261007-b4-skbuff-bug-on-v2-1-b9a5f732895b@toxicpanda.com>
References: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
In-Reply-To: <20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791394570; l=1395;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=j/d4+6UO1zMm/OSkoPxAoOFd0Pid5fsU1BUtdsYxUhA=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QMuGVBMQK42cE/Snfa08JC0fmwBrbf2GQNY3ya6ddo+CZ+JOvEDsXz/NSgzmaXVXIxa3Y07tuSV
 +hFZ2GlKKiwE=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

pskb_expand_head() BUG()s if it is handed a negative nhead or a shared
skb.  Both are bugs in the caller, and both keep getting hit: commit
2cbb259ec4f8 ("bpf: Reject negative head_room in __bpf_skb_change_head")
and commit 64e6a754d33d ("llc: do not use skb_get() before
dev_queue_xmit()") each fixed a crash here that took down the whole box.

The function already returns an error that every caller has to handle,
and at this point it hasn't touched the skb.  Return -EINVAL instead of
crashing.  The warning is DEBUG_NET_WARN_ON_ONCE(), so debug kernels
still point at the caller, while production kernels, including ones
running with panic_on_warn, just fail the call.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 43ebe61c7fc4..d226fe77d484 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2303,9 +2303,15 @@ int pskb_expand_head(struct sk_buff *skb, int nhead, int ntail,
 	u8 *data;
 	int i;
 
-	BUG_ON(nhead < 0);
+	if (unlikely(nhead < 0)) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
 
-	BUG_ON(skb_shared(skb));
+	if (unlikely(skb_shared(skb))) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		return -EINVAL;
+	}
 
 	skb_zcopy_downgrade_managed(skb);
 

-- 
2.55.0

