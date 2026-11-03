Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672948;
	b=YoXwVW8x7rbcuIWMxYrJh2p6U3mH82sJdaqNuyJueQPG9qysQOxQpRpaUEVbde0XMSuP
	 DmYGnWpkF5M1c3I5cAJdK35278QfESs2VozTMPQ75Q5p24Mca5A2XOYbSXcMcq1KU1UHD
	 j/wBBVDEkfwvgklH54hB1IZgOhfNUXyMhMma9Ely6oxGik7VtA3sRuNxjZ5i1m4c1anI3
	 0nbB9r/3HKrz/vbRoPxsG6UI8c3Mr3fHqy7NYkIaSCCloYSjg8pbpJFfYqN94jwIkumua
	 w13A2OXcaQCo+H8kykBhqEhI5Zm3AgiAj24TbloBTCA9eT4FPOKuLuy2fTIg6XhW2lw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672948;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=beA32Wl5uGeVdDRquUg9onzNEjLmSlivsd983Tz/Vmc=;
	b=1Xd6BdyIrDRIBLS79IkjCulR7OjWzk7/sDCL0oxUP0gR/4aDMG67aKWmAX4CuOe6qel+
	 G5TU0rwFfZ3QNx/ED7fefl9zbHkzYVaAfrg5hRhjcrqbrWWqU2NSvG+ujn54FCi5YE+bY
	 7dx4Hx2inpdBuBPDreUFokM5heg+M1z9Pec67zLlIasoL2TadAZwluFbqz73Pbe70JcnS
	 tTO6f2s/2ZBuNSJokWcuncgidKxSXsxNONMcH+u58/rrs0T3lSCnjtEeRNuhNfRJNRSZX
	 vrXwMK7ufK58Sp5S3pT34/xN2BCUNGTjDh8Etd8pqyhIMp+aDngAgbn0zmbok6w0ZMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=nfLF84dm;
	arc=none smtp.remote-ip=209.85.219.48
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD282606A33F
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 02:29:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AD282606A33F
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=nfLF84dm
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-91c7b00a75fso44351586d6.2
        for <netdev@vger.kernel.org>; Mon, 02 Nov 2026 18:29:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793672947; x=1794277747; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=beA32Wl5uGeVdDRquUg9onzNEjLmSlivsd983Tz/Vmc=;
        b=nfLF84dmVP4u+olz1NjT0FKbKKgPiOp3BAGJgTHqs4nnzZc8h+Y3Y9T0pwP4XhKKL7
         EbCb7hP4mL0BeMEs3cKt6O7J6ERVuSTEOkas+1YIBdHIdgVeAC5cnKqlfFk9W/gtt/C7
         ibddEb69N5Fjrvehy4GZaTnwy6I9oo7QQzjF0y2jJPyGnGYNTgkpfa8MxLI5YycfLHfa
         o/IXRFOG1rg2cUSU/Ml5n0hlsU6zrsYwj5B+e1+OiW089YteqJbJkPSY29E7J+vxDwaV
         6cIqfSNpLvIjJu2GcukyAMqWhV4UNoucJaiYkorGKWf5Sv++Xn3CF4KPh/wasX1jyGrh
         Yllw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793672947; x=1794277747;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=beA32Wl5uGeVdDRquUg9onzNEjLmSlivsd983Tz/Vmc=;
        b=mSDHX2AI7KzwRAUgBSaH2AKK9CANcGgJDUX905tDpeKBQzBLFiOMaMxlT9knlQHXKz
         x1naJuIHCKbfWNZ+vp18Hh0Sqb4RpUW8EtoNJJ+wmsTCrh6zE+ial6ZOB1dXty2tULYi
         HBqK+dHqocQAyFfP6UpWeedymLvr+eZoHYPVxVnw4S/Z0JKJKgu1sVO+zgCvHliKBjAk
         LBGLSHhwvXmhn/KlRrvKA2qQR95qGVXnHaQYfID8UxT85TrHZmNNWUFNxHThr8BC5p/0
         iJClVyY28aynKrLgqF9QMQHtJS8qtkG1HcFbHJF9cGcD8DbBIG4vDEo9fnr69Cu4KqNx
         HxUA==
X-Forwarded-Encrypted: i=1; AKwUvBytTfHlyOaVOGbb3I6BF7BHQ8dbO0ksHGXzX1wOi4URBIGkGVl2Q7Jst+77k/ByzdjpfTsM6Q8=@vger.kernel.org
X-Gm-Message-State: AFq9FYIBIORiCKPO1kkPEIhkX+5Ust5xxDPGg2kkSu51TgElzI4djor4
	qPmESQ2ImKJNSfSKh+rvkCVX2212PHQTFpk1oVaAWD5R5Zrdmt4ek/Ik4ULBdsXh1ow=
X-Gm-Gg: AYBFou2nGyuZK0g4o7MohdP5MchdYdPI1F/njimYIh2qlm4GbE2CVvzQLbuw1Bsc8D5
	l7xeZ2JkLqzzmlCjSdWOfsZNLnpbSFcZ5ORlLIMalj/4/n0uIM/b6y5QLhAZwtUNE1UEJ/f8x9M
	UbkmZdQCIWqu6eMMAYmyhNWJ7agV0YSkyUDPDFN+Ea06L7UOK4+EV28JD8eEo+L6lVYrQ2/9uXj
	pVznuiyqwo8NRB47TIXBAoxVxIsJ+cQ+sSCb61cAA8e/NWKkrNt5vV2KQnwSzPLxNoneiEHNYIC
	Cnj52lby9WRKmrr8ICnD99O9PAA9Fr5FPEP5+lfrovSCk0KBxIqGqZCoIMPkaywsmmGG7qlukLV
	r2qDoDaJ2OJiKHPlhK1wWsu680LjOrPIcpRRNy6nw/xuKu1TMpcI2Z/WZoa36LRhpQsT00F+JrO
	vBLNqNMw9K9/tg053fLiO060G/qETJLXaKogTxyy/qn+M0nszTM1sZ6HPWha5Db3mnnv03NbnN0
	6eao6sHMdfNXnXoRU3UQWqz8w4f2SIPmoZ3VHHPxC9a4zgQ/ADF8oGOPwL65n8b2HrGLETMZLoV
	x4RNs67LsFHZ1FZmWOhPxI36iM6NRM6Vpmuwfg4inhPo4A==
X-Received: by 2002:a05:620a:2b43:b0:93d:92a9:1a5e with SMTP id af79cd13be357-94421799683mr2059957985a.37.1793672946476;
        Mon, 02 Nov 2026 18:29:06 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.254])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-94425ac5322sm974378785a.39.2026.11.02.18.29.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 18:29:05 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 03 Nov 2026 02:28:37 +0000
Subject: [PATCH net-next v3 11/15] net: skbuff: don't run off frag_list in
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
Message-Id: <20261103-b4-skbuff-bug-on-followups-v3-11-54ad0ab57614@toxicpanda.com>
References: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
In-Reply-To: <20261103-b4-skbuff-bug-on-followups-v3-0-54ad0ab57614@toxicpanda.com>
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
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793672923; l=3043;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=ZFtZ+wZ1/BRwvrFDewd6GJQ8sWu7jAVgTMehQH1Him4=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QF1JASk2FaQ2hzp9j2Mg5ifJ5XQ/M7YFkqH/XBR1KN5aCYeKq0yVaHYAgZGVZBKc6lSw+ESgzWk
 7uQyVrofUxQU=
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

Without SG the payload is copied by helpers that check the length
themselves and recurse into a nested frag_list.  That path still fails
for a len that is too big, and still segments a nested frag_list.

Found by the Sashiko AI review of the BUG_ON() series.

Link: https://lore.kernel.org/all/20261007-b4-skbuff-bug-on-v2-0-b9a5f732895b@toxicpanda.com/
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index e3fc6291d223..b2c44a58db23 100644
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
@@ -5294,6 +5304,12 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
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

