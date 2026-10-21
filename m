Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.219.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590437;
	b=zWx9ZB+T6IEN/frwZp2nLFIOEOmtq78gd9QyfV6hba0aKiwFCq5LV/9qLwNmMCDYODPK
	 08dqyFkekwosWnwuhs/h+MOMd99s5izT3B8TZQzSCss+VsHYBMAwU+lGdnZPGGrnkDMvF
	 0xs8YucGAPqib/ECim0z68nfRi6tKYH6ChDfSrtbL7qPVMVe8UiO/+hD/GA0Qetj57HNs
	 z+TTl3u9QkNYIV5+VjTXN9eWfUueZQQan6fc9pbqxu7VXzkH4LlN1cFJWUC0XzyHRYpof
	 CHmZvB8RZo661OY442RW31PLzFR3RlTjBvS8JUOlopfwhUmgMtmk6CH4e6uVNF69e9g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590437;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=t5hhezvrkrPsILbBbBLRGuH3wT+463IdJ8u+tbtUXF4=;
	b=nE0qqZHW11PREtohAQDV/jKIYa1KKvP4tNb1bgt2PVLTobg3PqFn13E+2PEbQrpax65N
	 AnnKUPV7oMrjZSlCq+VQ7rzu6Y4h0aKHqgcFN5eU5vIOnlNPUK7Nsh4ScLNW+wGL9FhI7
	 Sc5fyr/ZJYgpBqyIuWcey8B++Z7k0oAPVmxCJ1pyom2PBibKlVYv1eJsRX72IUaCKs/9a
	 ZtCg7qif7jDz1wa396dWYPTQwQkK7VUFb6wq9/rrOLaI+qwt6/bgqT3HAsS2I5vI4lwDv
	 g2gFbemRVE7YAUEk51662BTpyD96jTpiU1gRn+2ydP5ruDR2tQK0ZwVUmCW2ne4rTgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=mj4hwt6C;
	arc=none smtp.remote-ip=209.85.219.49
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76248606A337
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:47:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 76248606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=mj4hwt6C
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-91c162febb9so5203326d6.3
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:47:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792590436; x=1793195236; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t5hhezvrkrPsILbBbBLRGuH3wT+463IdJ8u+tbtUXF4=;
        b=mj4hwt6C2RmhDFDWcD+zlE/t9lP6W8MjrMHNDX4hMrVubb7ceFq0PkJDlzGVjX+KgQ
         hwWWdjfCBrZDV8YpSbodfVwuJMP263FZvzzXYm7QCrz+VUm50L2jto1wvbaTkKKO9ILD
         xUEXXMggwQzD7XBbTKE81umHCjFP0TYuuf2kA1yaIJJr3pQWjgg2U6T6W9uqrYwRiH0d
         3kMF2xnp1mCWu/+YTfwS4qb4/pamtbM4/AmVyKaHY90CFbDUgjMBq3lHUr52YLBVZueb
         PD6mg89f4GEyZ72Q/CYzU10r/ziD2DtkyIy9ovFIjYiXEFo0eRGeyCErIioQh+CWEz1H
         o/gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590436; x=1793195236;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t5hhezvrkrPsILbBbBLRGuH3wT+463IdJ8u+tbtUXF4=;
        b=f/QoGHSIWu6UqYgEL1nhq4uvjoNXIM2cYsCkl41c+1EI0hCUJH8W4fVmnIFxB6SGwi
         SPUWYTf15wrPd5bZZJnjZzujFVjVR+gs5RlXTjmxPWeI9X4Uo9fyG52MxSZ4ljJcdwiW
         6I+gAAYZZZM3/b68c0KOHoOiK8nSVtF7xNP1yPassBgVK1HwG61e4nXYPdO35cw83dhi
         vJmYP2NCwHDQy+2Od7bl+LX2xVUiUw9pft1ImBF5k5uyOP8S31LFobN0Y5Uf5i7j7Zrj
         toEmMZJ5DV015rLH54amQnjG9xnQpcy8SVSrzFvG4mceAPlYSMDE0Pgd7Dzm1rdiFDY7
         1d/A==
X-Forwarded-Encrypted: i=1; AKwUvBxacoEPrEr4HmPdYtztnbWtj2zIcGYyQpQ41qG01x91gjyHcCrijWt7ZrJ0BbZ8PU87ABuN8rE=@vger.kernel.org
X-Gm-Message-State: AFq9FYKlfhRnp7HY9xu2213zkG1e2yltnuBX+yrqZN10CzoblGSzwwVj
	+hOjdvILKGI/Q16t7CUOPrEXmbYMPVqQ7ez8Eud0jiVRT6ma0SrChu7bdVBkSmYuRUo=
X-Gm-Gg: AYBFou3FS6WnxWBjv4axeEITe709qEmXXD/G76ugc24ibsDVWtzyYXhd5DuLT4re1iF
	v1gSSz7fRf+v1ccUJEUOAoFGPCKEEFDTuMZlZUiWraQWr/EPOJqG41acuAFdDu8mB9kzKuibtxW
	vJzgsxeUfg2Ujkx5dmwd8+rdAxybQpXzqyBC4HfcD61WqYXyIgN6M/czjT6BfidfkUONVZBPn53
	4KFAJCCEBTGYe0rbqMM86Br2988eW85UhJ4C5kYd5BeRu84Zrm76/uT2qa6kUsG5SlUiO+qJRH+
	GlaV5QU0oJQpbKcZww1KckXQeeeMoLvSHwRsLSSQ74y8Il7MKCijNWLogDKv2kvg5ZAqMED+nK2
	7Mf8wD4ZZVmqBnUL+JC65y9uO/1cq0fm1eKlAuiUvkNaNF+4+yfPT1o/EfsFcLlVz6P/Q7conJi
	Rt5DmrZfeg6S7ZjK8pGPL0GksJcetHFsw99fYYtY2XioqXeWOIRq1ZHfa6N87Yquu+FSQFdA7sY
	gPXG7gvh/DhDompnQi37ujGfEpbjM2O1Uj+DwBJhi/5Pt6VGAeNdWEy334mdyM+IsW1z88v
X-Received: by 2002:a05:6214:5910:b0:917:bebe:9be5 with SMTP id 6a1803df08f44-91c12eec79emr37007046d6.37.1792590436396;
        Wed, 21 Oct 2026 06:47:16 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.247])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91c10b736adsm24541336d6.7.2026.10.21.06.47.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:47:15 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 13:46:49 +0000
Subject: [PATCH net-next v2 05/15] net: skbuff: fail pskb_trim_rcsum() when
 it can't checksum the tail
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
Message-Id: <20261021-b4-skbuff-bug-on-followups-v2-5-2aa780a03524@toxicpanda.com>
References: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
In-Reply-To: <20261021-b4-skbuff-bug-on-followups-v2-0-2aa780a03524@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792590423; l=1264;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=+TWKmcN/9YISrCDdUhnWQSTAcvPk81OG628CQR0a1S8=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QFTlNfGUcXXV3pjdWKViUvre5XIQ/uvNasCkIWODiOg4AiKOk9pUX7ncc6s9bQlJoyAZkqeFxAv
 XxSpKAAtILwU=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

For a CHECKSUM_COMPLETE skb, pskb_trim_rcsum() subtracts the checksum
of the bytes it trims from skb->csum.  It gets that checksum from
skb_checksum(), so if the trimmed range runs into unreadable frags in a
frag_list member, or past the end of the skb, it subtracts 0 and
leaves skb->csum covering bytes that are no longer in the packet.

pskb_trim_rcsum() can already fail, and its callers drop the packet
when it does.  Use skb_checksum_full() and return its error.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 net/core/skbuff.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 88ed2dd99dc0..de433d452939 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -2829,9 +2829,13 @@ static int pskb_trim_rcsum_complete(struct sk_buff *skb, unsigned int len)
 	int delta = skb->len - len;
 
 	if (skb_frags_readable(skb)) {
-		skb->csum = csum_block_sub(skb->csum,
-					   skb_checksum(skb, len, delta, 0),
-					   len);
+		__wsum csum = 0;
+		int err;
+
+		err = skb_checksum_full(skb, len, delta, &csum);
+		if (err)
+			return err;
+		skb->csum = csum_block_sub(skb->csum, csum, len);
 		return 0;
 	}
 

-- 
2.55.0

