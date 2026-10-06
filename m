Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9122E4A2A64
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 17:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791306647; cv=none; b=nBYmwxoDyyuaqhkzvwo918EBzmGxDXJ9MrW+KHd8cGyulpxlRNsuxTTtuHKn6NVTyywF5oPa//BBroJZ+cfa5L8dKafU1ApnYvKMOYwuM/UMxnFW9bwMwhtSyErd7IcRUEE+9x12vHwDmvSECzgAxCshGn0JQ8YNzJfYk2c5kDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791306647; c=relaxed/simple;
	bh=DDflBQe9rOFwdyuerX1yW+/JeWMvXhklLxeTuRBv5Qo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aam7vIOlE7zq8cMN23bcn07xhG75prE4nr6vH/1WuNSZqi3dmGwjylKne0ELo5HnWuUyuFo+t/ZToEta41V6hp4+R1RqUbVw61aZjyXY67+WgzJnkwFWk/e0AEjUG8thRTPuUR2KZjZ9/kLS6uPXLiH143xiu++6FAOnw8e4oGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com; spf=pass smtp.mailfrom=toxicpanda.com; dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b=QXSTiVZX; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toxicpanda.com header.i=@toxicpanda.com header.b="QXSTiVZX"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-93e63522076so49267385a.1
        for <netdev@vger.kernel.org>; Tue, 06 Oct 2026 10:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1791306643; x=1791911443; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KC6Wx175jqCrvXS4LmjAF7lZT+6ZiBebrhytRBII/LM=;
        b=QXSTiVZX2WsM/3eiJeWWGQMOh7IZqJpJqdUs2zIOtJanXNTe/3+Y0sBpBxMX9m5BUe
         WfiWoiShIqjqbxkX2ALLRL+df9TVc2YhjUrHhVNRLtt6A7WvGSd5ZBsQudGttnk7jUij
         AZ2HS9coFrxqn9jKBbaOvUgMf+XtT/exsgxBKHCf7JrXxDGJ3gA+ay9Yau34JQxJ9SFf
         c24U958GlOP8Jq/ZJDCv+Ir0g++jYC3l7PI42+Po0c66OY5uI4/PqoPwIFodjtEcKMQT
         HbR/KZyP6rQqNUH0Sjhlc7lE6r1lPse/wskkOzVO0Pm/P5UFbwFqhkqJdh9UJw+1jmCW
         mr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791306643; x=1791911443;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KC6Wx175jqCrvXS4LmjAF7lZT+6ZiBebrhytRBII/LM=;
        b=pxOplixWrQlMw3SlgPIcVFzaCQfDyscheW9PHiJJqfQ4xj04ggcUB/SG/SmqFVnHLq
         yr+FxDS1dmH/UWVsrExjQ+mEjFWZ+9Q5NTLgEr1Zfe7r3Y0necLAYcP90+q+LFSwYHPV
         f/3Vrv+34czNNmpk634KyrzRdV7453MN+HJnrWTWhctuKm94KQTFmnrxEY9V20g5yhJY
         ve+lruuBMwyyb7DvocSi/S4oOFQqZqB44qhVBXPSE/3IRtSFVsDisdx0DaIe125r8Jeq
         42qjWa4ZojMJKmh+FMrg3t5M9FnF6IUfrpAsrwY2bkfutLOlrCS+CQU1seW7bpaMMzzD
         7Z6g==
X-Gm-Message-State: AFuF++nPZtPFkyxrMsQ8MW5W98ZhLZGsdSQIYzth0z64if/LYoNrwtX2
	kjcNwwpoJ3zvtGaun5/+obk6sbupF6NnzXT+HkhNsMdh9lHh3hH4O7jSlL6t5fW+2u0=
X-Gm-Gg: AYBFou3ZUW15P32GPuxJy/3BIfISJLGQ4e8H3wGsRR4XrgSBOUotoMZ4xlU5riHI9YH
	DxZUgQrAWz4IR2xmcVTSVmCVnJXUW5kUdoJtkjIfc3piDOam55guqtIAPjvxVQB7H1CirUH9qPv
	jM/uwXZLWtBF5nKuJTampL7iyw/nJ/4HI0oQVghSp8IV7EnejE3GdiGC6NE3UsMfhkEvtC55roH
	RV7SpbJt7g3kZHkVwIf+1pbhRWyDcxyCATlvC1dZHSHln1n9wox9PGs+ECOVcRbu8Hpb2QgoAsF
	mJXs831lSnqqC7bV6D1p+mlARBNbF/H6QGv14Crvg42EJZCyqoZvVogAg2KSOBXKOyj96EW1bSU
	PMH46cX92+VsRIfuN99Csn0EK9JJOlvy7s4QUekcfIRBmvNneejtTSTlyfSvLhck9Fc2dVW0Zt7
	6qGrOTrgtmqyVB9BXqFn5G+fUPG2E+m853UsGC5gvrdiSPbX9tLIFEkrFhjYMmzdZmzquRqdPPb
	7oM0nfKFDaOMkU=
X-Received: by 2002:a05:620a:2707:b0:93e:48fc:aa85 with SMTP id af79cd13be357-93e8f4d12ffmr400757785a.43.1791306643375;
        Tue, 06 Oct 2026 10:10:43 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.249])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93e99158463sm5742585a.20.2026.10.06.10.10.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Oct 2026 10:10:42 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Tue, 06 Oct 2026 17:10:18 +0000
Subject: [PATCH net-next 3/9] net: skbuff: don't BUG() on a bad frag_list
 layout in skb_segment()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261006-b4-skbuff-bug-on-v1-3-1b4434c5357c@toxicpanda.com>
References: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
In-Reply-To: <20261006-b4-skbuff-bug-on-v1-0-1b4434c5357c@toxicpanda.com>
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Kaiyuan Zhang <kaiyuanz@google.com>, Mina Almasry <almasrymina@google.com>, 
 Willem de Bruijn <willemb@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 bpf@vger.kernel.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1791306633; l=2534;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=DDflBQe9rOFwdyuerX1yW+/JeWMvXhklLxeTuRBv5Qo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QNE8FgLFm04/MQTMOVst4PWyNQnmk9EEN41GATHccJiCzZ/FVf0X+tKmZ9HEHAWvOay+M3p0Q4f
 dh1IsN6pStQA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

skb_segment()'s frag_list walk assumes the GRO-shaped layout it expects
and BUG()s when the layout doesn't match.  Anybody who can get a
malformed GSO skb to a segmentation point gets to crash the box.  Most
recently commit d5dc1e69fd72 ("inet: frags: strip GSO state from
fragments before reassembly") fixed one that an unprivileged user could
trigger with two writes to a tap device in their own user namespace.
commit 3382a1ed7f77 ("net: fix udp gso skb_segment after pull from
frag_list") fixed another.

skb_segment() already has an error path for a bad layout: the
too-many-frags check sets -EINVAL and frees the partial segment list.
Warn once and take that path for the four layout checks.  The packet
gets dropped, which is what should happen to a packet we can't segment.

The one check that runs after skb_clone() and before the clone is
linked into the segment list frees the clone itself.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 5d856948cef9..405d27e9bc9d 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4916,7 +4916,10 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
 		if (hsize <= 0 && i >= nfrags && skb_headlen(list_skb) &&
 		    (skb_headlen(list_skb) == len || sg)) {
-			BUG_ON(skb_headlen(list_skb) > len);
+			if (WARN_ON_ONCE(skb_headlen(list_skb) > len)) {
+				err = -EINVAL;
+				goto err;
+			}
 
 			nskb = skb_clone(list_skb, GFP_ATOMIC);
 			if (unlikely(!nskb))
@@ -4929,7 +4932,11 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 			pos += skb_headlen(list_skb);
 
 			while (pos < offset + len) {
-				BUG_ON(i >= nfrags);
+				if (WARN_ON_ONCE(i >= nfrags)) {
+					kfree_skb(nskb);
+					err = -EINVAL;
+					goto err;
+				}
 
 				size = skb_frag_size(frag);
 				if (pos + size > offset + len)
@@ -5036,9 +5043,15 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 				skb_shinfo(nskb)->flags |= skb_shinfo(frag_skb)->flags & SKBFL_SHARED_FRAG;
 
 				if (!skb_headlen(list_skb)) {
-					BUG_ON(!nfrags);
+					if (WARN_ON_ONCE(!nfrags)) {
+						err = -EINVAL;
+						goto err;
+					}
 				} else {
-					BUG_ON(!list_skb->head_frag);
+					if (WARN_ON_ONCE(!list_skb->head_frag)) {
+						err = -EINVAL;
+						goto err;
+					}
 
 					/* to make room for head_frag. */
 					i--;

-- 
2.55.0

