Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793358679;
	b=BGM3DfpRZTnpG7YA0yyEhH4sJQkxHFQcNbzYDQkVtOR/6uupXqESJw6DAwp4nWvIeYp6
	 R37TLty18jpwsVc/rNF6hr3C9/rIPpa7dnP14EaP6zclY5B9TA8Km4/RnpZwMvGsgQfTe
	 EKMhayMdqAQ3vTxrsiep4Zvonu8Abv/Aq9bMCd102w4euQIp4nRYwn6hsnL0Icu6y9j7K
	 U22gIquW7I1Bf/DtGLcSS/M42EEqZE7JdCPUgjny9GRcIWC9sBr6a7Era99IizaGwH83W
	 +UptXaLkd36WyHnzaQGt8a2bgQ/Pk4YH4ocG4FCHVkKKN1nM6GEdqsSbv8W7x6zoVUg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793358679;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	bh=KmOrBm1qC65xwrgbyzMtaj27QcC/iPJg0n2kc5knBkY=;
	b=mqzJaeJmqhKAw2PWNtMj9iNVV1N6VNhLi2PyTKTmiL3qHWh8rOGOZky6TNYeNdDDhht0
	 XA0rkN8KrjbVpxMjI1HjoYhOp/JiU19sLrGYt7pxLj7+7PZc8+DViukOT02ewUoO5qsyX
	 8VXTTc3KCArnnjPA972rZd25ItG3svaqZfGkH7adYQwb3YJLwWh8sIoo2UPQA7HhiSG4v
	 2EAbkZH0QxuKBtqiD3lXopUMwfzzVh8pLT3BrXATHs9pdOHP/Q1Lro3Bh3NnLsysQNfK1
	 zRddIRfPLHr+p1Yp5nGCcgSwDLTnKKv/CsbLFo1pyynIX6XaSqSmWe1hCbPPZMo+IZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zWuZnZ9o;
	arc=none smtp.remote-ip=209.85.217.53
Received: from mail-vs1-f53.google.com (mail-vs1-f53.google.com [209.85.217.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127C460A260F
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 11:11:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 127C460A260F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zWuZnZ9o
Received: by mail-vs1-f53.google.com with SMTP id ada2fe7eead31-7a6e560f580so351232137.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 04:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793358673; x=1793963473; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=KmOrBm1qC65xwrgbyzMtaj27QcC/iPJg0n2kc5knBkY=;
        b=zWuZnZ9oXZ5HmCIQULU2ysuHIxEAao+4ssIn5SxifJ4hATR4wMsIroOAme4Ha/exnz
         u88h30A443XorD04h9OibQs3AsxA6ZdamxupOrVxZmd3EGYNVgVGNaxpoWqBmHABT2xI
         WLGkfFKwu8xMSJKQ5KztKDRtkUQp36XNPrft9PZilrNktRx87afAV8xhQ+ZGCGTXO/rd
         V9cqMdNvHJX173W7Ibnw1ymxuMOGbV3fE6maXXbnkKvuHGwIuL2fWCxaIkda43uOG2yM
         nBQcbsHBTUj7XPCLwskOI4Y+i6RuXou02KmEArxLxiz+vwAGjSpiqLrIFGCjnlw7jO/3
         V20Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793358673; x=1793963473;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KmOrBm1qC65xwrgbyzMtaj27QcC/iPJg0n2kc5knBkY=;
        b=N7c9tjXgOY1B1u1l+x/QH4nEuLoXZQFBrLC+1jo9b5mycHA5074zT8SYkF4jQ7Qalg
         j512cW8Eam9b82ljPJz5bkr1zLx2Y1909UMe97l7xOJR/3zx3BiuTxVutFUeHyPv+R28
         9kcuwCyk0sp+5sbVJyqCir7K4jlatylM1BK4625dXqpQ6jjmouciTE/lAtfEFCnB9lYo
         cUt2BofqEMtCmGxlh4CidVdUDAs90YrNbscdR/1T/LpJBtEQvrMmq9QOtf9nCldMDJKw
         FimZ/JU/kg9g/54UyDrFG3RQ5eXWPuDPW15+P6m9lNp51dpYacPhfz8h0yTPj++RRu/B
         NSoA==
X-Forwarded-Encrypted: i=1; AKwUvBxQH744S2V0nar2kHzHl1D7IdQcqDTWaZ3yW6Mauh982fYQ9OamspZWDAEBsgrTMhFlXSZnMQ0=@vger.kernel.org
X-Gm-Message-State: AFq9FYKdZjNvy9FgAbiCdGMqC+ZdFAOcX9t7T1rc0jC8ZZYchvpVN3gH
	eMta5Onz84jWbRtDU18T9D3yXHV9cumi45OSnNegPLWlVDtSXstvxpXr
X-Gm-Gg: AYBFou01Wzu6MxripL5CMZUaYf+b89SXCmHWf6NMLEmPV1Urnk3PaD8FRL5WV3KvkUK
	YLh3QnzAusjLASCDcsCAZNayOTBUJpwHOIO5JYS+dC5n1JGM5P14Dv7dNwcwHIScF+k6pUl2XfO
	Qf3bCS850XixvCamRwyEP1IUfqXgDFXfnAMPrct0C1QWCWI1v/dIp0vn8SH+CK4BFHDpJNrR6SU
	Baxe6IQXV6HRKjkZSv9go9kWdRSH/Wk8aOtucG0xsdDpQJQq1BFn/ZVfhUGx+WS3xvIJjiRcj98
	vw6/MghV01WQPASwJH1owi9wRGVLzF19AeD3Ioo8fTvvo/30JpFEPaWYXuD42Xh3FLu9Mtx1Qgb
	Qd+mck2Xtj/hUf3hbQ3J6L3crxBms3VpciI/30DPefJ/LtJBMyc/CozY4dN+v70H8wr8UIBdtt2
	ACL8ljUHfkF7QCt9xliWHij2phWntfjJyNpx2OKk67QVAd3YMjgTZa7blubbF1rCcyQlDjGfBFm
	M/b2sy7K9qyBfq0yDQRBc0kt60Bc8ilcMCSqWfB1uo8syJ/eQikmjDlkdPSzQ8J3MNIY6wVnEzc
	NnfUBWVCrEUlaIXy1n79rnQgCJ9VskK1BEWwCUYRe0UwKoYtbSgblw2XEv8wHYUV3lGzqsfsGK5
	MrytRoBYxdcjCdmWi9yc=
X-Received: by 2002:a05:6102:3588:b0:7cc:2c52:47aa with SMTP id ada2fe7eead31-7d071f2ec61mr1143935137.0.1793358672919;
        Fri, 30 Oct 2026 04:11:12 -0700 (PDT)
Received: from 1.0.0.127.in-addr.arpa ([191.34.116.20])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d07754c1b4sm1841044137.4.2026.10.30.04.11.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 04:11:12 -0700 (PDT)
From: Joas Antonio dos Santos <joasantonio108@gmail.com>
To: David Heidelberg <david@ixit.cz>
Cc: David S. Miller <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, oe-linux-nfc@lists.linux.dev,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject:
 [PATCH net 3/3] nfc: llcp: free the response skb when the data exchange fails
Date: Fri, 30 Oct 2026 08:10:42 -0300
Message-ID: <179335864272.64596.2156668877648051796@gmail.com>
In-Reply-To: <179335864271.64596.805818095553030218@gmail.com>
References: <179335864271.64596.805818095553030218@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

nfc_llcp_recv() is the data exchange callback for LLCP PDUs sent in
initiator mode, and it returns without freeing the skb when err is set.
Like for raw sockets, the skb can carry the response even when err is
set: the HCI core passes it on with the error derived from the
controller's result code, and NCI does the same for a frame interface
data packet with a non-zero status byte.  So each failed exchange leaks
an skb.

This was found by LLM-assisted code review.

Free the skb on the error path; it is NULL when the error does not come
with a response, and kfree_skb() handles that.

Fixes: d646960f7986 ("NFC: Initial LLCP support")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
Assisted-by: Yaga Agent HackerSec Claude:claude-opus-5-5
---
 net/nfc/llcp_core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index 74bf81700..f0632a0b9 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -1638,6 +1638,8 @@ void nfc_llcp_recv(void *data, struct sk_buff *skb, int err)
 
 	if (err < 0) {
 		pr_err("LLCP PDU receive err %d\n", err);
+		/* skb may carry the response even when the exchange failed */
+		kfree_skb(skb);
 		return;
 	}
 
-- 
2.43.0

