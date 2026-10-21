Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792590453;
	b=ZviOwZT91Kj98WSLp0tbBftPUyzA+a8xDtgxSkj8Mdlv18SPvNGRWWt3BJLGYKiEI59A
	 0lSQUfB2E0ae0CKnHSrsgagxOwMs6nOC0jzSE4IVi7LYtII4o+yGDqTO7yeKxS6uE25m0
	 p2nJln341tmMdVo2Bbld9PBj+mXVWRTGoSANcQV9emw26Xv3pyRVxINm9ijdB5zCcsrGT
	 mwvqTmAs9fY6iBfFISER4Fuj0KobR8wwNTAR37mJsRo6Q8lu/d0kFSxTOSJm8/DlmIknG
	 X/sLGuREplZjr01XRwfPYgIbzlgeOLoHJSB2QiR0AHF0mgk8J5PwYTYgJ9KVpahgosg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792590453;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=l2su03NSLDI+QURR7+Op6WIlpfTiC3EObk5mJFR1rWs=;
	b=N6FuQzpnBHUkNrdWDHsLT5GzqObHm6zt3lgpL258cHsSgezcDCS9LQMIbsS698c5dPkz
	 zP3fIZ3DRAH7v1KD+4CbtIIunTPbM991+wkKKJNVNsXzG+YXwAZ2uzOW3g2UzsKoUXXtC
	 km9YNHmnaoU7DfKl0wSO6yBklIkIfl4ZZD5wRV33XfmCcrxsxbfXyLekk3rRi/chG0Lvy
	 seAF3gGzWW/Af737YTs9d0F/M8Up3oeQAMKWChUaGXc5fMRq0rcn5RcV8eeVKfy+wRvNE
	 IDOQv13b7C67m/zPU+3ioJEiIqwyejQexd7f4T2NRYYuT+EMWhyMtpPV95+zRPRAcWA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b="Tfn7C/de";
	arc=none smtp.remote-ip=74.125.224.50
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7615F60A2633
	for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 13:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7615F60A2633
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=Tfn7C/de
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-6798af41644so454989d50.2
        for <netdev@vger.kernel.org>; Wed, 21 Oct 2026 06:47:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1792590452; x=1793195252; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l2su03NSLDI+QURR7+Op6WIlpfTiC3EObk5mJFR1rWs=;
        b=Tfn7C/de+Lrn35C8VrJTEWBisMVVUnY83a30ge2qDQaPsbY3IuoeuFjRKO3WOBQ5+o
         0CJcMOf8RfiPstxkqTdPCeFSRpu0X4/jUteNxMqKbV3isIbtHLUmrN2Bb8pAVUoedeBv
         S31TLszuV4obpF/YhA81ezW4jW2iW3SALEJiFV+MID6PpkLHJtQJHlwFlYrKKtp6JvXL
         JMdtb545LQ8ki5miFct1TVcw8atsyKYedwpjoVzL4qSIcN0owEsWwB7hRoQqj+Z8tlc4
         p/gkSP8AL6T7W/LtuXsyZaZluDJdVzacK7T38oUbS1ea9vhkAs5U46jWX+ckIW0FRG+q
         iSQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792590452; x=1793195252;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l2su03NSLDI+QURR7+Op6WIlpfTiC3EObk5mJFR1rWs=;
        b=XkuXMd+jUtsXWmRddkcI9Y5eVZB0+du/pohJyQriV0Z5bpAOOkxUdE57l+6su0yJH7
         5Atjixwl6D3Q6SaIPKLtvKNNVkOYrCDV302i2Vk5/Y/Rb4B+iLx7IaQvRXRaV2pjRwmZ
         oR9iA92QHjkXX6VQgcnds9AS2AJL747jl2Y08GNClztM6Kr0dzkIq2LaerPpRIRbj+KF
         NGF9nHKRuw13BoRQ4gP8V3UG4EVepQrW8MEJEpv6gDqIZOQPTaiMbmNzuU26HRbus134
         csvoQOo/+RRR0EmfGgAEkzWyC79G3CpKaSi+O0HlgDMiVkrPSK8Jv/V5+1GSvFgtVpLV
         PX+Q==
X-Forwarded-Encrypted: i=1; AKwUvByeXrtOi+Uc8fx2sLg2J4nbuMEhwZdhY6rH7jYMn80R2hHIr4r/KkNiY0QeyPFQZUV7CylttWw=@vger.kernel.org
X-Gm-Message-State: AFq9FYIy12qeG5RURzk+K9YCxyZmF58hQM23KK1nGMW2e4AHbKX6hBMA
	W4DkEWUzpe86qJto4pCC7ecCWuVEDVZfEgCR+y13Gaj0zil0KWbH5PMHXF3/iHdREM0=
X-Gm-Gg: AYBFou2UYI9EL3I5De24ZJeoHix4NfAJcLdVNoYhTFCxVrgQAfZllV3AzNQtV9ZY7XO
	ezyVNWNQ4HX9J8Z0hJ+AtiRn0nBG4WEbIPa2kUKp/A1bMuuEIHugqnq/ckLvNiGMqenMscK22w2
	1G0j2RsfoxBlH2dyBp830IALyu7KnEWj0pB/glEiPqH9p2gdITmS+xJR5V2Z9N156OG0y4Uhy4V
	zy81EYF3D4UNWUNC6njiNAIGSL0VHQqh9ftRUAFU+oUfBS6ETvhNmFX9sI63/wHO4vry9LdsbEO
	9l4JMy90ZbcYz8Wrv4o+BWsEfwUacpfJuzsu4Cx/RpxWefKXMef4jzdxzP/EFQbr3neZhx+AG/3
	+kZz05q82i3BN9MsVf2GKLxDFIk35NwQHB0FkoSINKSyXbmxenRPNhqu3XRpXTQIUAJFknMPs59
	PHtDvbwd/PTk3RDrB1zcEEwIwA/scB8YfKKNmzauXHwIP2HjasaHSsrx2A3T4I1oQ1v+XqtSaJe
	L4vdUXA4adpf9qwhVOe2X9NOpiI7BIAP59EqSVqlqUUJQ7aOvZ+qZkB0a5P7SwpR/DhBApT
X-Received: by 2002:a05:690e:1406:b0:679:b98d:9b88 with SMTP id 956f58d0204a3-67a0e0331e3mr1078570d50.3.1792590452506;
        Wed, 21 Oct 2026 06:47:32 -0700 (PDT)
Received: from toxicpanda.com ([153.61.196.246])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67a0e5779ddsm1061588d50.20.2026.10.21.06.47.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 06:47:31 -0700 (PDT)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 21 Oct 2026 13:46:57 +0000
Subject: [PATCH net-next v2 13/15] xen-netfront: don't BUG() when
 skb_copy_bits() fails in bounce_skb()
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
Message-Id: <20261021-b4-skbuff-bug-on-followups-v2-13-2aa780a03524@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1792590423; l=1219;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=9EvzAU9EO5dyvCGQMaA1nd2saqGuALWIDCXk9Xn6dMo=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QAQjp9kFMKs5+2pU2zx7IwIuaWfR/3YW8oytDjzI4+zZ1wUKMLjTsMaA+PjAnDttJOXuOtpmibb
 u+dc+qRy2bgg=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

bounce_skb() is an open-coded skb_copy() for skbs whose data isn't
page-aligned, and it has the same BUG_ON(skb_copy_bits()).
skb_copy_bits() only fails when the skb's lengths don't add up.

bounce_skb() already frees the new skb and returns NULL when the
allocation comes back misaligned, and xennet_start_xmit() drops the
packet in that case.  Take the same path, with a
DEBUG_NET_WARN_ON_ONCE() for debug kernels.

Assisted-by: LLM
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
---
 drivers/net/xen-netfront.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/xen-netfront.c b/drivers/net/xen-netfront.c
index fdcb91042f29..17811d81937c 100644
--- a/drivers/net/xen-netfront.c
+++ b/drivers/net/xen-netfront.c
@@ -695,7 +695,12 @@ static struct sk_buff *bounce_skb(const struct sk_buff *skb)
 	/* Set the tail pointer and length */
 	skb_put(n, skb->len);
 
-	BUG_ON(skb_copy_bits(skb, -headerlen, n->head, headerlen + skb->len));
+	if (unlikely(skb_copy_bits(skb, -headerlen, n->head,
+				   headerlen + skb->len))) {
+		DEBUG_NET_WARN_ON_ONCE(1);
+		kfree_skb(n);
+		return NULL;
+	}
 
 	skb_copy_header(n, skb);
 	return n;

-- 
2.55.0

