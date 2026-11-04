Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.175
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793825286;
	b=H/I1T+5aLy/d+ZWadnlZfcOriPnkcvvvFKuKbI1lchwpNIfciOsVBcU8cSPArcXguzDZ
	 CiJt+yAY0XjxTPmXX++fvoO3Ywpk758hfR4g+wp+Go7Mi2gqvUjEsek26OTQx60Nd0mxs
	 6Dk6aj0f3C83kQ4P0F7fP+t7Sgcn+HHiSDAb1HcwmWDnJuYFRv2AXr1eW985H3v2TJC2W
	 m/bvEhtw6UxGMNG/WQiqjNLNwi2VJzbZIv5ElQfnAMh8lb05QQpBWSs7dgh/EkLNLtRCj
	 M+XTPU93ftH2E4u0LeOthlcMLwRAG8q8rCzowt4xs5jhSYguIxbK1nvy3Qe9ZbNa+rA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793825286;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=NVn21fMcy6xP3x95gJReWbvgO5dQmcWPIIyj1sSFlXQ=;
	b=cRMTSl7L6PQr+m41xSMrpJGcE+hg2tR4uZ1A0Z+xZ98vP55vMdqZQLUEEL6sFkqDe/zD
	 ckb41FVNfb4u6wFkfFJ2WG86KHmGsv8BqbEAlh5W/V2BUXHT+Sqh8mh1H17e7S1TqP7dq
	 efwrZgiHTPUB3RIjKwdPW6/eMbpW1801dRCbsbNOEmRwcBxULc/xEX+Hawa4Ujj4eX/Rf
	 rCNhe6dSMZOeY2ccXLilp92pOHh/ldRlpZfbSBGk7P3MBExBmIKcPi/63IdOvLHxnJc9S
	 +mzSwS5IDyi61HSsM8V2mv4RgJMkHFPxriYZERN4vVqNgZsai+HRRCB+ZVAtgMgaZ8A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=toxicpanda.com;
	spf=pass smtp.mailfrom=toxicpanda.com;
	dkim=pass header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=hxzLEvpR;
	arc=none smtp.remote-ip=209.85.160.175
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D47860A6F78
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 20:48:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5D47860A6F78
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toxicpanda.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=toxicpanda.com header.i=@toxicpanda.com header.a=rsa-sha256 header.s=google header.b=hxzLEvpR
Received: by mail-qt1-f175.google.com with SMTP id d75a77b69052e-5430f70c827so11885111cf.2
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 12:48:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toxicpanda.com; s=google; t=1793825285; x=1794430085; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NVn21fMcy6xP3x95gJReWbvgO5dQmcWPIIyj1sSFlXQ=;
        b=hxzLEvpRM1R7tYMOAwXlR7+/Msy75CyDVIIJO4iL1isDNWcseW7gIqVo6yDiaO48Y7
         Izbq/q7xfCh2+AOG8gvBH1Qed7Jt1SoyX9taXMqjAnGlNtZ+hFG9drRYVRHFha1Ds+5W
         GzKDoFl4yh3BlYNmzMrvaBJsbLPSDg7MK2ooeYQwofh6G4a8Up9hKRQSRXRiCHK23d50
         aJJgUgb9vivGq6sN+OREch5i9joGfArwOL0mAtWaQXdmpsHN1ZWegdLTzLJEi91pdpgA
         OpNiDWSm/P6akD3LR1paPEbeKqGje6KUOYsip4YYFAlCHpjiT+sEzCxjjjx9U2Bf+vgF
         Xrzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793825285; x=1794430085;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NVn21fMcy6xP3x95gJReWbvgO5dQmcWPIIyj1sSFlXQ=;
        b=xv/HEQzNJLrcwek2NXJhPvtX9fphS0IJmtJpKNYT1pnR+F0v3LruvAcCONiwIPfjHa
         PynUhdfuEoASg2yqdOh3P/37eQ8FcB4FZGsHUut3N8XK934oht5qf6pouhWIkdC2uGqe
         fqY0e5R3EwF4xGmEWdyiB/17cli6fFw1ch7BnsLMW3crsLgp//MYFkhc0VdfKEGEBwwr
         yPq4ilxZtAwduW3+3BRFOZTYBycFxlQPlHMK1KxxRujcVD4K3cJ/WtHQwAHS/4pfQQzm
         SH4RLKckAKAtjAw1lyR4bY3puSPABUVtZwKH2GGv/NaRWm9ypNat+CL8+gaqvlxzjHoJ
         Z6RQ==
X-Forwarded-Encrypted: i=1; AKwUvBx+gTDH+kwLYdiX9Jz49t8MPEjD/cb1a+UOv5BSDRXrPS51R2nqK3MZGyrFDpJl+vJOCn748N0=@vger.kernel.org
X-Gm-Message-State: APuU4Z8b1Lop2XxQeUIiLm0gSmqaKKrnYguCZBsda0m2uw6oToVUuVha
	33/KwapwxiPALJXTvq/7LjVd00fxejXfMjuDehcjuokabavb1cgyFmdjsBOiyijt0BQ=
X-Gm-Gg: AYBFou3Szkddu/KgN8lE5YHorzhkV/V4+OHpQNrFI26CBlXvVdanSgQq8ZuOMRPC3JS
	tM5lexXMLka2BCYGDChYnAVDtduDOSVEDyPfbz2alun6QStcK1IT8c5pg6w8aDm/87ImCm7apfy
	K2c/3u1hz5C9Oo4d7A798wE/BjXvVCcl9dh9fB0p078cILbQLHSmVwIakPTAHwlVLX0P5GNpNCu
	HSlVSVycmkLjzvS545y4CWCKvVWHr0sGIHPf6dNR5hOzmqGzDAuVrvhOBbVFGJaO8PAXnv4cBTw
	Shg9j6MVKAGQFxj7QERpMHI3rhWJtX3QQirmOer5cRbXO/4dnX+RINlxfuh7qoY1U7QrmzB8rSf
	7kBy2mo95Kmzbkf4c4/tT17uGclugzktsggWY0VgUoEvONEveXJksepjSIPj5boQ6hE3MlrWUS6
	EeYvGxxi7qL66VBbGQRvlvjMoojsbFJ4hupgMCoecFRhMbOT73R4ZV1Pnl+Wm0OXKPlkOA5RQcV
	3dV7frg+sohepmy3bNY+Z3DU0yukN2sHDgjjnO9gkEIigJ9qGwAGhMXxEPUL8lSXhyJ5nG8T/Vd
	Nn3zv6nt1lOcB0ZcFHGZvyYtLuE558wYF9g6xw2EEwWNCA==
X-Received: by 2002:a05:622a:5919:b0:536:5ee8:cca9 with SMTP id d75a77b69052e-542b6780e91mr301127981cf.12.1793825285045;
        Wed, 04 Nov 2026 12:48:05 -0800 (PST)
Received: from toxicpanda.com ([153.61.196.253])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-54b10c4dcddsm33675341cf.20.2026.11.04.12.48.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 12:48:04 -0800 (PST)
From: Josef Bacik <josef@toxicpanda.com>
Date: Wed, 04 Nov 2026 20:47:25 +0000
Subject: [PATCH net-next v4 13/15] xen-netfront: don't BUG() when
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
Message-Id: <20261104-b4-skbuff-bug-on-followups-v4-13-b7ffeb364f5d@toxicpanda.com>
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
X-Developer-Signature: v=1; a=openssh-sha256; t=1793825269; l=1259;
 i=josef@toxicpanda.com; h=from:subject:message-id;
 bh=zzsYthMv8IPVXjBtHviI0y09ueLAi8MeGKpMdcW0nP0=;
 b=U1NIU0lHAAAAAQAAADMAAAALc3NoLWVkMjU1MTkAAAAgUBr36M/n0nWN0DNbnxwzIiCZez6MG
 JiruuNaSCI/zXsAAAAGcGF0YXR0AAAAAAAAAAZzaGE1MTIAAABTAAAAC3NzaC1lZDI1NTE5AAAA
 QPdw7QRLxn5IZHZCHDO5ZCwaqrEZRXxs42UXzWDr7r7WRHwPZva73HxZD3G3reol2INnyXLXU4W
 ViF0TlWuOfAA=
X-Developer-Key: i=josef@toxicpanda.com; a=openssh;
 fpr=SHA256:C8kOX2QUJCMqnCX+KEeoqRAjLo9L+ELOSH2NSAJHqGA

bounce_skb() is an open-coded skb_copy() into a page-aligned buffer, and
it has the same BUG_ON(skb_copy_bits()).  skb_copy_bits() fails when the
skb's lengths don't add up or its frags are unreadable.

bounce_skb() already frees the new skb and returns NULL when the
allocation comes back misaligned, and xennet_start_xmit() drops the
packet in that case.  Take the same path, with a
DEBUG_NET_WARN_ON_ONCE() for debug kernels.

Reviewed-by: Juergen Gross <jgross@suse.com>
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

