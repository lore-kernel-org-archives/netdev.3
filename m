Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825277;
	b=afK6kzgAdhz3xaf6h0zxNfH7atfvh8ZP1EqWRpTFVO96j9A/S/DPlwJ2L/opbkg4WjqP
	 PHYMPUBqbT7h+1q0m1SS4TZoY/dZANaaZdcUFat1O0VYtwyNyi2FegjNgR/njB4scSqba
	 n3HVqgPocn7/Hc6xci1ZJ61kny1G8vHItOd3J7XcKJjdHssUVKW5+12YCZa0nwKvbcNH0
	 fU4MQn8Doa+2Q/yUmjz0KBR9hn/+GokIwJ/SLdezR4jUBHKMm9OTdJ+GWSC0fcy6v16RJ
	 6F/BRZT5TQ8REXBYzPnLybdifkxqfKCRJC6/GrKjp8+ilGnqmo/LhC3nbNLppdJVo4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825277;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=76u0opG5lCQGub1g5v24NFjQ04Vm85vyhWc2VR6fzD8=;
	b=PbWYAktc5D23QM59cLNLi4dM4l6BD2se00qtRDGRaYXeNxFqx9BNHJNRZtIdRInCJQEA
	 qM7NdUoyfDiea9S/PfR2wPrYUg7h/0yYkFDDBBfJ2UbEHii5vWPNUV6Gb6vC07MroAKLV
	 /7EhmS1LLgeG2ZqOsIXLCrgRDzvpHGu7rKr6yHa90mD7b4IQbp0SaHbf2bUajffwI5cFn
	 6XiArCzAf9JJlPMPJJVn+Rqch0J2svcmw79t9exWqEh9i4ZA8l6aMNAseP7NKTIW7mRbR
	 fWX2xSR4SbhlTu4n6OlGdgWIPRAnsrBFEM2alrb4zBw7EI/kiXQpzDHlJoC775CRf4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ToeFJIGf;
	arc=none smtp.remote-ip=209.85.160.171
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F0A6096BFD
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 20:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27F0A6096BFD
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=ToeFJIGf
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-5365f9a04c5so16297091cf.1
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 12:47:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793825276; x=1794430076; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=76u0opG5lCQGub1g5v24NFjQ04Vm85vyhWc2VR6fzD8=;
        b=ToeFJIGfymXDCUENI0uBOYLnw6friJlIjAk/U0EPJrTag8k86tJyUqhkr2taAFvVhx
         Nl1kc3vblU6IjtACiKDrLZR4u3F/dchEIe9o413eWHHDZyubC2n9U6Uew1Sw+DlRQJ4u
         YjWFMvGmXkdbUKAt9VXIY1sEHBkqWu1QarKNulRYnsx+P1S2kF6dHZPpnHNx1CUCmm8y
         RuQL8MadPD8T+DoPsekQRMKz34ETW2uVKSdXGuJFNQivJMIK50d8A+nndT0J2e70B7jc
         vLrNRgaqGfC0nh0tX+KRSPS+nMUt8ar39EFFBOZcUmlIlVPKR0Zq1NmCM5KLnD4A+Y2K
         p/hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825276; x=1794430076;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=76u0opG5lCQGub1g5v24NFjQ04Vm85vyhWc2VR6fzD8=;
        b=u403kv8bTlEP02fbiEAIy2a7+QiIRXINZO/dCGIfBkvRkP0icSteijKxcR5me/iojG
         eRSr23LZXn9SdhjfRqwiV74LvoPv1/Ll/JilTrHLFNYDK/iHy6z682IJh3XFs5gjD4id
         clHN+oXnOUJvWPnnYHhkB3yExe049iLv4ZEtXxHoQarS2YzTJ6/uajXOt43W1o3KXqFO
         klCCG+TFIrxRR5btUvOa7YspcyWxJOG9p1UW0zs4ooe+VaoLhvXk7fuJI5ZGaEj494W3
         LoFjveg32r8ABb6YE++CI3eOIeTN3ehLLtoXbSkl6Az+texOpZduBCc8X3PStf63PMQO
         hiew==
X-Forwarded-Encrypted: i=1; AKwUvBzaFyGsdY10aC8jd6t3lnxyCzfe40DBxvXu4mww/zAL9RNesMU8PKRF5orG1MFKZJ7MvSeBHLo=@vger.kernel.org
X-Gm-Message-State: APuU4Z+4ORd3yvEbgMP9fK8fTaNyTPC+xjAjvQxIGimkz9aMUimMoSAR
	2ym9IQSsoyi8g1V70w0QbMw6+BeAgSoQq4bfL33zRI3GRIpYNcjUApOWCHS9E6Gqkg8=
X-Gm-Gg: AYBFou04edr82kSoQDQzJVbsBOHeqp5Vp5qZ1A7VG6L9GiAnsK5X8hM4fZMD/Y5vSvV
	mfOHrMU2X5I4Mwhg1QtF7Mr4C9lAabc/lwS1ZuY48C7/W+THjPy3C1nRduw8d5QLyz5YLVpqZYK
	hzNVthNsTyTOcF3AyKTcUoEfQKFi8Nhy1zktcxGIOUGTyxWj0veyApDrLHpwaZt+LfmdU26JUvZ
	VHML0iZTcLRGbV4uIMvEH7beweK7o/C5U1EQy1cAqalrBFZShnYst6nhyHhZ4uaNMcdbwDqliz2
	D+uPnGuWpIsYmiRR1eeMPw3LRIvoS/xKuX521lGkEp6seFn+36BTVc0Qz4DH73lp5z5DqSWjBRK
	1Cjmrr0HxymbyOg8/uOA0ewwjigbNEBw6sbWR67jEvidyaepScZM/EpPzuu+EbHThOhGb/MxUMI
	2AQQOk+8LSc7DDeXgzFVLI21qqb8AZujy4aLvWLffbwxZoSB5DUyPiVeeZ833rQr3xj07eBEYrL
	MEI5WS6PUTYzJJsmZgIvj6yOrclaZV6xsFIK4w0M11U2N8VUCLWaQ0p50Ksa6VkKsji0E74dytF
	KCrQxChnm6hVzg22+7OUlm9rqWBqIf/2/HDfaoXMh3F1JQ==
X-Received: by 2002:a05:622a:164a:b0:535:20ea:cefe with SMTP id d75a77b69052e-542b639cb3dmr296202871cf.18.1793825276187;
        Wed, 04 Nov 2026 12:47:56 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.245])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b1086db63sm33603081cf.11.2026.11.04.12.47.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:47:55 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 20:47:17 +0000
Subject: [PATCH net-next v4 05/15] net: skbuff: drop hw csum if trim can't
 checksum tail
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
Message-Id: <20261104-b4-skbuff-bug-on-followups-v4-5-b7ffeb364f5d@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793825268; l=2083;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=VhuNRWOW3RZfgkvn1rBlfP7PvQEEgt9QwL/nWscgVi0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QEREoQ9M5gk5NXv0IYrsYL5d3xD0iqwQBzSWkwyENQ0s2oG9H/Gc4OPqk98ZP46iyupEQkfEnKm
 OaNK0sIyfUgQ=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

For a CHECKSUM_COMPLETE skb, pskb_trim_rcsum() subtracts the checksum of
the trimmed bytes from skb->csum.  It gets that checksum from
skb_checksum(), which returns 0 if the trimmed range runs into an
unreadable frag_list member or past the end of the skb.  skb->csum then
still covers the trimmed bytes.

commit 2e357f002c61 ("net: Avoid checksumming unreadable skb tail on
trim") handles an skb that is itself unreadable, but not a readable head
with an unreadable frag_list member.

Use skb_checksum_full().  When it fails, do what pskb_trim_rcsum()
already does for an unreadable skb.  Set CHECKSUM_NONE if the remaining
packet can be read, so that software checksums it, and fail the trim
with -EFAULT if it can't.

The stale skb->csum was only reproduced with a hand-built skb in a test
module.

Fixes: 65249feb6b3d ("net: add support for skbs with unreadable frags")
Fixes: 20ddd0fd2fcd ("net: skbuff: don't BUG() on leftover length in skb_checksum() and friends")
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 20 +++++++++++++++++---
 1 file changed, 17 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 43bfaa010db7..66ba9bfa8fc7 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2821,9 +2821,23 @@ static int pskb_trim_rcsum_complete(struct sk_buff *skb, unsigned int len)
 	int delta = skb->len - len;
 
 	if (skb_frags_readable(skb)) {
-		skb->csum = csum_block_sub(skb->csum,
-					   skb_checksum(skb, len, delta, 0),
-					   len);
+		__wsum csum = 0;
+		int err;
+
+		if (!skb_checksum_full(skb, len, delta, &csum)) {
+			skb->csum = csum_block_sub(skb->csum, csum, len);
+			return 0;
+		}
+
+		/* The trimmed bytes can't be checksummed, so skb->csum can't
+		 * be adjusted.  Software can checksum the remaining packet
+		 * after trimming, as long as it can read it.
+		 */
+		csum = 0;
+		err = skb_checksum_full(skb, 0, len, &csum);
+		if (err)
+			return err;
+		skb->ip_summed = CHECKSUM_NONE;
 		return 0;
 	}
 

-- 
2.55.0

