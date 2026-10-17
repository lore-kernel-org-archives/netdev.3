Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB28D3939A2
	for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 16:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792255138; cv=none; b=bQt1zm/4eF1l3bOIr1pjsxRKABcInEqBlQ0i7+cHgSC974RJcDILtYkhMy0/ToWrF75xcSJyxEPMJTNBvi+tMYS/Kbq0X2FYHGhw2/tl/VCt6BTLmE4GulKK7SXy+l0ytg/FTDD9IvBO0DiCJ9Hn56oYfYrP5eApqZ6o4HGMR6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792255138; c=relaxed/simple;
	bh=jmaWeyIveisSzZ7aCwrfiBdfaBQ6cxntCG0EieSF8SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=t8Za5K+GA7QQc/QAEAtOKg/pWmk1CsUCIGFtXEXrH3CxwglfSjQ4VPwtqqJhZlmlSuOSbs26ZFyCmMwW8+EbriTTT+iwPRgcBUM5WOIqXWOZuc5JlWKP+E/CJJu/6iBr0qpuJ7g++/WqEgsDG4Tmmyel+FkWTQ6pCUyW6s5mqs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DBbgidyO; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DBbgidyO"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2e831e86ebfso3574845ad.1
        for <netdev@vger.kernel.org>; Sat, 17 Oct 2026 09:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792255136; x=1792859936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NoQnwU23qouoapgLxBv+Bhz2dTNvqCRZampt5Twechk=;
        b=DBbgidyOSk2d9WrV+Z5GiFPvHDuBAaTfQqWyRcRdpl21/AUjRsIWPHy6YsQE8VN+JR
         c4a7PQhBiIAhhoE9G7My6yDb+K/juQVg50WBMZvRp7GTLHHyAJuaM06swrA+vPQ/mhTN
         7mhIUqEnN9cTDzMg6WQaiyMPlOZgKqT0uYBU82BSCsQnOttIaWtZZA9jQjdDgTsAcTwG
         Q4mwUwo48qqxd1zudq6h3ZgWV3ydpAwfeILiNedBUs9Ey0M6Qk8BAQVzNgGTCtvrbjF5
         xYjwvEjZkNBr20j6ZYlY8/7OF9I/eEjbsY3Nv6TVwRinmaTEglhuXq0pE545ZHV9/VK0
         y9cQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792255136; x=1792859936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NoQnwU23qouoapgLxBv+Bhz2dTNvqCRZampt5Twechk=;
        b=bTAmeBDi4+/FF24DkyvtBGEhvGTvuK0+a0H+7AGl3Zkp8kD8FnYBPRD+l6OE+fIb4u
         nKsuF9ybWZddHH7RYMNwJwwvYsaVF1X8CPTexWW8aplv//y4SQIaSMrPNoEG9zy0B3vm
         DwiHkHE6i1JiMNImlB+g4pvyPEW5xxdeXSiRp1zVvoonKP/WA4L2FW0Vysl9tFWN6Yxq
         /iBYF5lNwHGg66PY5hjmyVE+jUtj8qyOrSC+bcp/opRH5Q49ffMAI/2rgl35TMhJdjOK
         gayZgIS+BWfuL+PB+0drFRvD2F4qdxNhUx3o278L2D6+vK10cs3K7Uwri5RcTH7uuGeF
         16IA==
X-Forwarded-Encrypted: i=1; AKwUvBzeiVmeF+EeK2mwyg17AhLEAZy3BTP6md41h1fBA6IDYt2sQt1AkqnrP767VuEshzbRu7oHWvQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYJSd4qsg1oOjZ0s2I5RS0tSkBwEnWfi/H/T8tEtI0opO5Va9g4w
	NQrqDXZCoJ8q0L/AhAlRu92j3haxYfpBu+oLy4F2cJ++K6CPTxMPJZ3u
X-Gm-Gg: AYBFou1lAN/pSZ2qmM7wuzs0xbahmBqQ6HhrxhYd4jiKz6WvRxhrpgBkc8krybbztwo
	CRgCClrLW/BMyA/j4kXS+StPyTDY87yS5YZR5/XeWoCZ8rMI5joJFPLd7chaHT5ezXHx7w65x8H
	3dY/ZCfQ1vVUHCaj7574uJzSRA9WXthCTr/J2nVfTYu6B0eJgR0rFrb8gR4c+1AuVWJ2b3w24Qe
	a9cuW6sD0lgZ1PuSsC1dn+BVfmmkXaKHyKxyRj5Rrd4fzyrMGR4Hv+zzRxV++dSBZBMQjgrWveA
	p7nr0TDH3/JP/GojEy2Nq82TIvxCtM06Z15ip8RQyzN1MZ80lHgGDO57u2zDrdJCjBqAt/JJ9QV
	DHTmdnysfhuqiYZqPluARW4eJ8ATcyuUALgvZJV8dCOx+4ChMB3MU+Y4yFMYTtnd3YKZgyXOCm0
	bX2talEtK/4LcSCg7YV5opXT7/hJbtL05XYVUnyxCEITEi0Q96eZtGrMnIPWWd26c7Qk7qvZICX
	FKtBptzEV/urETManT1LxU+MjskN03P5eMskPfSdzCFq59Cg8iCtoSpNL9abbqNO3D3G/yz0Y7c
	74aPdoWTv9g+bC45WWTmCu4HGDwTCi3KWWBZ7s4OXCU=
X-Received: by 2002:a17:902:e547:b0:2e8:93b5:c555 with SMTP id d9443c01a7336-2e9a6e5296emr27675065ad.61.1792255136209;
        Sat, 17 Oct 2026 09:38:56 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.252])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2e97e8997edsm22735055ad.63.2026.10.17.09.38.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 09:38:55 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	netdev@vger.kernel.org,
	josef@toxicpanda.com,
	mason@kernel.org
Subject: [PATCH bpf-next v2 11/43] bpf: Validate the SRH which End.DT6 uncovers in End.BPF
Date: Sat, 17 Oct 2026 16:37:13 +0000
Message-ID: <20261017163745.3341787-12-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
References: <20261017163745.3341787-1-alexei.starovoitov@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

input_action_end_bpf() validates the SRH of a packet and pulls it into the
head before the program runs. If the program decapsulates the packet with
bpf_lwt_seg6_action(SEG6_LOCAL_ACTION_END_DT6), bpf_update_srh_state()
looks for a routing header in the inner packet and takes it for the new
SRH as it is.

Nobody has looked at that header, and whoever has sent the packet has
written it. ipv6_find_hdr() finds it in a fragment of the skb as well, but
hdrlen is then read at that offset from skb->data, past the end of the
head. The header need not be an SRH, and its hdrlen need not fit into the
packet, but it is marked as valid, and bpf_lwt_seg6_adjust_srh() and
bpf_lwt_seg6_store_bytes() check their offsets against it.

A program which then adds a TLV at the end of the SRH, where hdrlen has it,
makes bpf_lwt_seg6_adjust_srh() move and write memory behind the head of
the skb, as far as the sender likes within the 2 KB that hdrlen can say:

  BUG: KASAN: slab-out-of-bounds in bpf_skb_net_hdr_push+0x185/0x240
  Read of size 2088 at addr ffff888107d6f09e by task srh/102
  BUG: KASAN: slab-out-of-bounds in bpf_skb_net_hdr_push+0x1b5/0x240
  Write of size 8 at addr ffff888107d6f8be by task srh/102

Use seg6_get_srh(), which pulls and validates the header. Without a valid
SRH the state says that there is none, and the packet goes its way as
before. The pull can move the head, so compute the data pointers behind
it.

Fixes: 486cdf21583e ("bpf: add End.DT6 action to bpf_lwt_seg6_action helper")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 net/core/filter.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index dc630fc9f3eb..a62f3decf1e2 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -7025,15 +7025,15 @@ static void bpf_update_srh_state(struct sk_buff *skb)
 {
 	struct seg6_bpf_srh_state *srh_state =
 		this_cpu_ptr(&seg6_bpf_srh_states);
-	int srhoff = 0;
 
-	if (ipv6_find_hdr(skb, &srhoff, IPPROTO_ROUTING, NULL, NULL) < 0) {
-		srh_state->srh = NULL;
-	} else {
-		srh_state->srh = (struct ipv6_sr_hdr *)(skb->data + srhoff);
+	/* Behind a decapsulation this is a header that nobody has looked at */
+	srh_state->srh = seg6_get_srh(skb, 0);
+	if (srh_state->srh) {
 		srh_state->hdrlen = srh_state->srh->hdrlen << 3;
 		srh_state->valid = true;
 	}
+	/* it may have been pulled into the head */
+	bpf_compute_data_pointers(skb);
 }
 
 BPF_CALL_4(bpf_lwt_seg6_action, struct sk_buff *, skb,
-- 
2.55.0

