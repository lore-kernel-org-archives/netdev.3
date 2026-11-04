Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825276;
	b=kHhyIaNU/pSHkGLl7xeCplXOldrErVFjMB72wwyWqOywp41uEkpyxZ8aIq76s2QnkEQk
	 IuFIFMBSziTCzJ6xvnX5nYxk7nROmf+onVBPADaQbOk3a62a9rA5XRkPh93DG97lzrVyU
	 bSpZrhfd8zaDHLbTcmHpRJd2GluV4DAxCrtS6I5abqFAoTcb6SVle9KcRl6BQh7BbAzDA
	 J+kwtsni30Ai6qsNybXoXpAHCBMKtZnwCkg+IggJaLQz1N09ekwHTkEfjzQfIXHmDJv6G
	 fhChmeLOMucB+jvWPqrFjd4Og1W/Wo0YHZU6xiTSphoVDLWw5r73zJIz8rZZ49imPvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825276;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=Z0ofG8i+5G3+D6Lky4QQ+QewxWtJgEdu+4PNn/sRjok=;
	b=ORREZu9Or/N/EC+9E6ZVmvUbK+Tt0tTWV2pCILlBRd7S+8ghWjmWlg7F6fjK9r6Tfq65
	 0Fi4mCkpOiuCuZsO19Ab/W+JJehjAZ/7P3BpWENf85VjVmsGS8qXqYBZitWfWF7zS9Yn6
	 JyiRg82hQaRGuU3hUtROEr1MZM7noeiEu8lTpH2/aV7PsX/X8pXmDyDBY8jx+uTvpG3o9
	 UQJFxkGyLYzSdMtKCvIjX99quRXUypKYo7nOtT2L+BfY+bfS2/M/5k3iRHaEPueZLx03f
	 wCzp0mo+Ha5spe2TfrRtREGHsXmpifjuzE57b8XckTBUZ1l5fysCCDsmb+vGMDVsA6g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=rB3BLLqm;
	arc=none smtp.remote-ip=209.85.160.172
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6C66096BF1
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 20:47:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C6C66096BF1
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=rB3BLLqm
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-53397554beaso10335531cf.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 12:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793825275; x=1794430075; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Z0ofG8i+5G3+D6Lky4QQ+QewxWtJgEdu+4PNn/sRjok=;
        b=rB3BLLqmstn7/qGr/a49kPDEpNnlBgLutRtjwVcdTTHDhao0autqmwsY26RrIVQTxD
         eyL7ynpGB1utHPizrasTfvU0B1lam1CvbxNBwBNy7pM3G6GgehaN9HbkxT2ELFAtMShz
         0nORgvCNlDU1E+2DJ/Fv5HuGOnwiNq+cjjd5r9Q5NYAjFZGQhDszdvqkQGrshUb0cfGf
         MlaSS+CfuJ5xF8qYNojLWQSh4lk54GGh+NbmWLFCZ2IoLS8YSK76328PEkUejA1spFjr
         r83V1ed96SLKwXumvweJBEZLYBefsruD12roC/18e0ktOt5vnWnW0ecd9XPCfplKlvj+
         gc0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825275; x=1794430075;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z0ofG8i+5G3+D6Lky4QQ+QewxWtJgEdu+4PNn/sRjok=;
        b=nOMz9DkHL2w64DhUDHIcwo7rEGXdCX+1uGMN7uEjW4pTRiuWWOLPpIw1/GFUkW3EOi
         C4MnjWshX5XDUnCIvNr07uaUdaUYsfVowLH/qMPw5w0mGHsP6Y+J4HSqImLP2FnnhE2r
         tvdSZyFFjmGa+VtWpt4wmB5WkNikXM3PNBseVP0Uop4nnEE4kA7w+yYOku+u1vLF1kp/
         s393HiDUqac0JuMZXmaDQRxj9p3P5xnQ/5pYRS5XzGYsKrdRsDlqVSq01sYFGLnnSluw
         bOGKR/6s4sDxgu9Y7PjIXDEUKVqe/U3KUtXJGBo/FQ/vDLmg5ZHnHQCsxdhbODLDG2e3
         Kk8Q==
X-Forwarded-Encrypted: i=1; AKwUvByM3CI9tM59Xx77pzcCtbYlyWduM8/kkFOLo2kGu8tI8e9uJuT0C0Z4HpYdCBma8nMOVwW8Io4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8HQnW0A3aAmy+g6ANAWJcXwM20W7GOAzeBIlZJFJ9Q6r7Llnsp
	ql14yUNMe33W4w5Bd8XLCw6TvPOeoz7W+2r1nn3TOgF4EZ4ObDkw/Hjx9VYlmVJZC7g=
X-Gm-Gg: AYBFou1lAVRYv8OYAlmJnziY94/dwtsb8exIEXtmpY8Php1BibQE/mNZ1GYMZ8xDt5C
	jN38i2LsGFY6A4FBRTfiMZE3dV85MJI8nnOh3+xYZ20G1jZVPICSKoYUDM76gLiROOCVyBWyjk+
	qsI345RWNyD6Pu5vEQsZSVlsa7vZ2i7IwlMRtcjUoynAH0VcTsBf/w3YmlWJeWWg2yBJTJGTC51
	JHcBc/IRHSZF+LnWgnPFZ2BEqLQjBWgWN0ExZDer4ttccRlTQz9L0weNqmPxHfE7uNiXJnekrFD
	ShpjgVD1S1H0aUIchTLRbzAO0+O4mNbZX7bMM7Jy/XqTr7SJrpCWGjl1Y8Lef1/SQSOOwLysCor
	dQvZqrTfkBDQ9rrOFthg7uQC5Ap1mneNSthW4PS9LsU74gnygzUWHHMW2RLxPoaUjToS/WHm4/y
	n+wye7MSriFDPAWran/oJdXMegg0hepLV6eVn6ll/i7m9ucTTdKX4SnOD36o1Ue892kNFgYUpx+
	QffDa3gAm0XbkrZ0csmZrs3CqiwlIgbnn+6CBI2kuXmClE58TNygvMmfY8mGsRYvoNxkpisi1Xm
	MoOQ732Gbcx4DHfa9F39OK8Rmtqy8FPfAFmyxFa3cTSX0v55+1wEfh9w7jACEdJ1dP0=
X-Received: by 2002:a05:622a:5b88:b0:53f:a444:dc7c with SMTP id d75a77b69052e-5489bf4ed8dmr148147081cf.56.1793825275132;
        Wed, 04 Nov 2026 12:47:55 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91e7e728f87sm28503726d6.36.2026.11.04.12.47.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:47:54 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 20:47:16 +0000
Subject: [PATCH net-next v4 04/15] net: skbuff: fail segmentation when a
 segment can't be checksummed
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
Message-Id: <20261104-b4-skbuff-bug-on-followups-v4-4-b7ffeb364f5d@toxicpanda.com>
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
 xen-devel@lists.xenproject.org, Josef Bacik <josef@toxicpanda.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openssh-sha256; t=1793825268; l=1797;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=wq7jmBov95d1ubPFIBwmfjjLdm8phK81PlxkHkS1v7k=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QC+K6YoFA8/X2w62wsZpb6RlJydDVfMR0awgE6H/Srw2FuCPuHi1hJdV2my2TnKDRzcBlXa3JFb
 7M90ontNv/wM=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

When the device can't checksum the protocol, skb_segment() checksums
each segment with skb_checksum().  If the segment has unreadable frags,
or its lengths don't add up, skb_checksum() returns 0 and the segment
goes out with a checksum that doesn't cover its payload.

Devmem TCP doesn't get that far today.  Its skbs take SKBFL_SHARED_FRAG
from the zerocopy uarg, so skb_segment() tries to linearize the segment
first, and that fails with -ENOMEM for unreadable frags.  No other path
is known to bring an unreadable segment here either.

Use skb_checksum_full() and fail the segmentation with -EFAULT, so that
the checksum doesn't depend on that flag.

Found by the Sashiko AI review of an earlier fix for the same path with
SG off.

Link: https://lore.kernel.org/all/20261009-b4-skb-segment-nosg-unreadable-v1-1-7e2334a55fe8@toxicpanda.com/
Reviewed-by: Fernando Fernandez Mancera <fmancera@suse.de>
Acked-by: Mina Almasry <almasrymina@google.com>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 0082b12544cf..43bfaa010db7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -5294,9 +5294,13 @@ struct sk_buff *skb_segment(struct sk_buff *head_skb,
 
 			if (!nskb->remcsum_offload)
 				nskb->ip_summed = CHECKSUM_NONE;
-			SKB_GSO_CB(nskb)->csum =
-				skb_checksum(nskb, doffset,
-					     nskb->len - doffset, 0);
+			SKB_GSO_CB(nskb)->csum = 0;
+			if (skb_checksum_full(nskb, doffset,
+					      nskb->len - doffset,
+					      &SKB_GSO_CB(nskb)->csum)) {
+				err = -EFAULT;
+				goto err;
+			}
 			SKB_GSO_CB(nskb)->csum_start =
 				skb_headroom(nskb) + doffset;
 		}

-- 
2.55.0

