Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794490254;
	b=VLa2uUwm6U6y5ojKu5iXyRQ5qlQ3bzSREg4YWMFxWtw7weQePgLhhUlfZ3ZRsC6iwDaN
	 O2YaVPqvHeqUUVaDaU/jV+c1HbvLFjQsG6e+XULMoFC9KV5oBEDHtnG7fKlWDciV0VnF7
	 XL5wY39xiqbJ5yDr3uqeA7uM0ob5VfP7hTAFbVk3Zy7KWNDd7lqQgEDWV6daEtqiMsI20
	 vbR3rig/ILdcmaTZtFCoIuKaRsA8GlXssP7AbeusEi63yMRkX4d3rWd8rK0yzAf0lchgd
	 HfBw/9SF3vj1USZa0alpRiF5/bKFmbyxTnxR0RqCN82wbnFZ2a5hJ6CaJ8Kh9Pvyi6A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794490254;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer;
	bh=bQmKrWpVoZ9SaI+qEplFddxtx0KLqYF6wLCqi2/SLYE=;
	b=ZkyXw0YkI2ChzyQRaW3tbvWzIfLSaDYLWi9CvKZ91DL1xF80Axwh8N5m2LI2+uOf+Yqp
	 afsnVFVE/D1tI4vuUxcKveLde/QO/q2v48PubnRx3Ynvmq/R7Y+PKMglVQPxTXAMIw/8h
	 JtzcnNR1r5ue624U1tB5hMrLG475HtkjNmCfwjxOgEZ6CGHQpShExzZ/s7zokQgQp3E6m
	 +YQX1zAjvRR8xnc9zqZHRXhK839QpwpxzS7eqpPfFcSPNJT+NPo/xfXiAs5p/g7cjnFNX
	 Bmc18Bt0NauQCuZUZaIlMjGdfwAcnPJw+8miQdrMPbobYE72Ts7HjsK4217iiJnE0Rg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIzVteX0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6E0606A32D
	for <netdev@vger.kernel.org>; Thu, 12 Nov 2026 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aIzVteX0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D1D1F00A06;
	Thu, 12 Nov 2026 13:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794490253;
	bh=bQmKrWpVoZ9SaI+qEplFddxtx0KLqYF6wLCqi2/SLYE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=aIzVteX0oUv6GHfSGLvsWtm+ShgTjdDlwVn9l+n1gzQ6URyJraWzaYT88X21Ivb/6
	 Tev+/HP6xx4Z1dHdxXDCdiw3aG1nnUGv15LZueB86yYVHnUFUO6kCnfBvzMenUe9/v
	 O7m4xTiNgDH5yk5mvAbqtTpAdhVaalVU6JC6HFv+L8sF8xp6pgVlnib/sqyIUsJMlS
	 UTErThbCww3UeBaf4Tdl88cL1cEtovJAV+RLwPjvL6kDEn4qbxX8wz3YTojc1bcAoA
	 Ip0JDPFh80gcO6AYWO3CkQA6pUfCMUiD+qPgJBSrioSutBQLH+fmMh5uqg9ROgpBRb
	 RgDK/PWIDgggQ==
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 12 Nov 2026 14:30:27 +0100
Subject: [PATCH net-next v8 12/19] net: ethernet: cortina: Account RX
 buffer size in truesize
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
Message-Id: <20261112-gemini-ethernet-fixes-3-v8-12-f55bd43e02d3@kernel.org>
References: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
In-Reply-To: <20261112-gemini-ethernet-fixes-3-v8-0-f55bd43e02d3@kernel.org>
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Myeonghun Pak <mhun512@gmail.com>, Eric Dumazet <edumazet@kernel.org>
Cc: netdev@vger.kernel.org, Linus Walleij <linusw@kernel.org>
X-Mailer: b4 0.16.0

gmac_rx() charges only the received payload length for each page fragment
attached to an skb. Each fragment pins a complete free queue DMA buffer, so
short packets understate their memory use to GRO and socket accounting.

Charge the full posted fragment size for every attached fragment. The skb
already accounts for its own head separately.

The issue was found by reviewing the RX fragment accounting. The series was
tested on a D-Link DIR-685 with media playback and ksmbd transfers under
ping load.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linusw@kernel.org>
---
 drivers/net/ethernet/cortina/gemini.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 364504c9d441..f31fd0de0059 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1907,7 +1907,7 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget,
 		skb_fill_page_desc(skb, frag_nr, page, page_offs, frag_len);
 		skb->len += frag_len;
 		skb->data_len += frag_len;
-		skb->truesize += frag_len;
+		skb->truesize += freeq_frag_len;
 		frag_nr++;
 
 		if (!(word3.bits32 & EOF_BIT))

-- 
2.56.0

