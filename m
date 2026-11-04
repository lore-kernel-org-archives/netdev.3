Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825284;
	b=BsisKdR8aVNdiLgggIrxjXa5l8atTUl+CgvXG1fWrKFjcp/Yh2x86iNA5iNWAmtyFeE6
	 RHoYayWFf61sgMvnpXSwdO5tQpLwy8HEZcG0QzStJMJ1EsdRXu/BIMO44IoJnx1KFDIQ/
	 g+IR+wcGKnUTKb1HPvX3aQqorEi1ZceR1FlJoEA9Cl81b/stGpYSIN3zEiUn/73dSsNs9
	 h7z6FlwOAEnJXH5XpTsT5Rhzug9LxZjz268HBu48XC2XNFgbMv0M4LlbdVhEwZiVC5t7H
	 XYEL4L7t3yOI/tg2JZ7hWcd6AwH+H5Tk2yX4G6J0LtLqJDz/V1CA2x0TaOYVSwlAvtQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825284;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=21AXhK/7pbqORDSG4HxUO46u8d65H6wDFEiP5u1gVuA=;
	b=rtySxmDUWVEZ3eOiBBOrOUGvLhep8FoVLABb+EUCDk8d9fPdPbZsdqgy+R3Tpgkj45Cq
	 FmVqlrmjPF5j8HJ2gG5gY43wgoJbRDFNJ7etwCRKlPMYcJKych6siZi9xBiFP5DckSK6d
	 f2iWU4a0Edtc6kX5rg7YM7nmfnWrfe+3soSQPSHyIs8a2b4AGyNfm7do6d+vONhejWWOI
	 W0gwPnBBWHM+k9z0/sa1IXT1BjHjxIVNeqhyCgWl4B0gHlt4xY5oOYjy/X+ILfy3z6Nh7
	 CYCJXa+1c9OrED4d99HjK/9zLTfL9D/DdCke6ht6QJDpg4s3SM9Gt6HMxGdwwZxHEQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=PMXJI05h;
	arc=none smtp.remote-ip=209.85.222.171
Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DB1606D829
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 20:48:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7DB1606D829
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=PMXJI05h
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-93f2b8cf037so95120485a.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 12:48:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793825282; x=1794430082; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=21AXhK/7pbqORDSG4HxUO46u8d65H6wDFEiP5u1gVuA=;
        b=PMXJI05hZEvrgvCeo8a/xPJQsDRMZPlMqX8YkXwavYNj2ccHs36fVpf95OuqWuEcsy
         CMu6b+7DUhTqFh7WM4QjKVrISNn4mgFgOiz6t5I4A36cdbgb5AtVAXup4e/FJqHC+QFy
         Z7yHkLRsR7JN0jZysX90ZlDzIitlsMl4mea7/zFWE/zNBzSMfl41rM/HdpYx6T59YtqX
         k3RT46Bsm2YFTFUW7iEjvUWV45QCqjx4ANC+mtRRtlJwMWTZuVPehfUa/sW8CBYxyJhz
         PqrklQVgjH17wBdHzPTPl2ltz98ZwKfzEqHwhsje5mpO/dD4/4gD2aAvASMK15wxPk6p
         TSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825282; x=1794430082;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=21AXhK/7pbqORDSG4HxUO46u8d65H6wDFEiP5u1gVuA=;
        b=Ah53Zvjg6FqjsP/sH2TT/heV4YV+5G1H8fAAwkGgpQgku/aMtviRlsGzlDLumAKfz/
         ztxPixXFQXMKbhfvWp/D6YTWjnNAMOYzlGWGo8pdygdlRef7XSPPj60uMKCESeaaXqXu
         OVR0XuaUxBSOspSPqOuc21Kwe7b08Zkv0RariUm88K9J/2mCAtWFwU4urG5ybGr1eeJz
         iswI2bSjUmIcQdGw3+wbOrfa5s8Jpp7w0qSWp+rYTsWVGMp6opJPBziporEIjKkkC0ZR
         alVMsjJ2qGdMenJXfladVw8d/MLK91AZvh0QOfxy4yziefJ/Lsh+lt70s8lyg4M4tj5x
         JQmA==
X-Forwarded-Encrypted: i=1; AKwUvBzvdUii9StHxmuyCk4YAkh0FT4ZpgsoWDU5/z6tZNdVZIxJharUW56YxxkpJUh2+jlkac8ocbw=@vger.kernel.org
X-Gm-Message-State: APuU4Z94+dayEUzpbhIog2S8VvSX2WF/HoNNKLlAJIt7S1zxjoApIb6f
	hoIXVX3V4BqVLBHLY7idvCQMN2JSPMhgfEiQZYlD8YeeRpjfx4hV0fa2U4EZ1UvBwew=
X-Gm-Gg: AYBFou3aLJvhcdgCPGDkyATENnvTweY/C+pc7cOfopW/IILkFbmuZ7a851NL8+YLgmf
	ArKm1Qv3EjNX8uTMWyG36w06Wtja5gv11TFor0TqN+Q3fzeMNwvCWJI0Wdinv9NWAli1Zm1FK8/
	eP9WRio+32ywHYkri7nPM4CA0oj+Pzu+8zm3EQh/eR/D8iLx7QTYUa359kKKXh8/L3JHp80wHv+
	zNnUPlCao79iTp4IkH2yMVa4cN3Zke6D7DA1HT2exHckK42Nd4sRBieGvwdczjob0JJLfnTRtdC
	opT5tfJPiMdEDZSNkLyHzjYgCOj8lAKt3PD7kmX5A9gBJxB5HnoG3xWmKB1CFsjNRZXoeG/YKvP
	ZCCZLpB7fOyjOYBEv16c0ZlwSEwwaJ/iDVoOCU64lXdsgkbNiK2iXx9n2yYDetgLtD8JgDph7bR
	BgPzAFH0xyu5wN8wpUyMraGicd8ZJw+N/sGwKzSdDHrG6+9fwQkmxXCLG4g8H/OdNhLJ+iT02Xt
	D6YN4Z7HrTxq0692x40hBzDyY0CDBxBaGfJdBoeFY6lr+xUY748mBVOUvemX26dUHaMhbesxDrI
	rbWeAF+EbqMJ4jnUyE4q2IsPxyn1lv1b17ErWZ5YIG65QA==
X-Received: by 2002:a05:620a:2984:b0:93f:2e7e:c818 with SMTP id af79cd13be357-94421799c57mr3047302585a.59.1793825282649;
        Wed, 04 Nov 2026 12:48:02 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.255])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-945d4813a6fsm293565585a.21.2026.11.04.12.48.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:48:02 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 20:47:23 +0000
Subject: [PATCH net-next v4 11/15] net: skbuff: don't run off frag_list in
 skb_segment()
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261104-b4-skbuff-bug-on-followups-v4-11-b7ffeb364f5d@toxicpanda.com>
References: <20261104-b4-skbuff-bug-on-followups-v4-0-b7ffeb364f5d@toxicpanda.com>
In-Reply-To: <20261104-b4-skbuff-bug-on-followups-v4-0-b7ffeb364f5d@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Juergen Gross <jgross@suse.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 Fernando Fernandez Mancera <fmancera@suse.de>, 
 Mina Almasry <almasrymina@google.com>, 
 David Laight <david.laight.linux@gmail.com>, netdev@vger.kernel.org, 
 xen-devel@lists.xenproject.org, Willem de Bruijn <willemb@google.com>, 
 Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793825269; l=3248;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=6s0PzVt82/I3gWDSKQnU5ZDEZJBYWsfTYigRyKi8yTo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QBVz2JFcgnUXu6h2/lcBh0xilKeArmwQIEfFWo4537wo7SLcPc1F7X+FqiGAn38PBEs5QZhYRtT
 GHOVrXmke0Qc=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_segment() keeps going until it has segmented head_skb->len bytes.
It takes the data from head_skb and then from each member of the
frag_list.  If head_skb->len counts data that this walk can't find, the
walk runs out of members while it still owes data and dereferences a
NULL list_skb.  There are two ways to get there:

 - head_skb->len is bigger than what head_skb and its frag_list hold.
 - A member has a frag_list of its own.  head_skb->len counts those
   bytes, but for each member the walk only looks at the linear part and
   frags[].

No path in the tree is known to build a GSO skb like either.  GRO
flushes instead of chaining an skb that already has a frag_list.  IP
reassembly does nest frag_lists, but a reassembled skb isn't GSO.

Check list_skb in the three places where the walk moves on to it, and
fail the segmentation with -EINVAL.  The KUnit cases in the next patch
hit the NULL pointer dereference without this patch, and at least one of
them hits it again with any one of the three checks taken out.

Turning SG off doesn't avoid it.  The walk reads list_skb to decide
whether to clone the next member before it looks at SG.  With the checks
in place the payload is copied by skb_copy_bits(), which checks the
length itself and recurses into a nested frag_list.  So without SG a len
that is too big fails in the copy, and a nested frag_list is segmented.

Found by the Sashiko AI review of the BUG_ON() series.

Link: https://lore.kernel.org/all/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com/
Reviewed-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 7ecf6701f68c..45cd77e153f1 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5164,7 +5164,16 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 		int hsize;
 		int size;
 
+		/* list_skb runs out early if head_skb->len counts data that
+		 * this walk can't find: bytes that aren't there, or a member's
+		 * own frag_list, which the walk never looks inside.
+		 */
 		if (unlikely(gso_by_frags)) {
+			if (unlikely(!list_skb)) {
+				DEBUG_NET_WARN_ON_ONCE(1);
+				err = -EINVAL;
+				goto err;
+			}
 			len = list_skb->len;
 		} else {
 			len = head_skb->len - offset;
@@ -5174,7 +5183,8 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
 		hsize = skb_headlen(head_skb) - offset;
 
-		if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
+		if (hsize <= 0 && i >= nfrags && list_skb &&
+		    skb_headlen(list_skb) &&
 		    (skb_headlen(list_skb) == len || sg)) {
 			if (unlikely(skb_headlen(list_skb) > len)) {
 				DEBUG_NET_WARN_ON_ONCE(1);
@@ -5296,6 +5306,12 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
 		while (pos < offset + len) {
 			if (i >= nfrags) {
+				if (unlikely(!list_skb)) {
+					DEBUG_NET_WARN_ON_ONCE(1);
+					err = -EINVAL;
+					goto err;
+				}
+
 				if (skb_shinfo(nskb)->nr_frags &&
 				    nskb->pp_recycle != list_skb->pp_recycle) {
 					nskb->data_len = pos - offset - hsize;

-- 
2.55.0

