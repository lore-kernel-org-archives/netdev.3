Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793288228;
	b=qsRlVB/MNTClGsfF9+7UmE+9S35HU723DrreUenteH0gdHhBZnsJJv4IOc4SoywI2XRa
	 34KyFO+uFxb337q0rXMjAdvft9xO6X2nzR4bmgYYz7Gnw2E/h+ZIR4aYRj0j4doFLX0/v
	 /td5m0VGYVQ+k13kq26K23+Ts1UoGDhBxvpaOHdeYRoNRfDyXsR8r+mq5vd9uQsEdxv0W
	 o7Le7z52+LecBqI6/4BU/wiQGPf53cmIthich+qRLQgV8oAWby1VwEbZzEqFIFc3vn39o
	 ObyqivY83htomYR/ItZR8touhZnG7SLhpNl521YQbCGSt3PXxCvrvQIlwlK8U5DiJoA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793288228;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ISkMz3ASxfr+lKCh/nGM5qIpjGO+THkfUP4Oe9g4JJg=;
	b=12XqJl1WkBBwrrr9+xmt/0z8ESDqKB+ZmRDD9eLCx8w1Tnt5kTEh5sH1B03rgKctFmzF
	 tZbipPqQiXcYuf9IKHTOi4G35iN48IMXsnEkEzBnlXevytcLLECwZu9AkwnWep8CZWFWJ
	 FZjUJEegdtQXNm9X5PHwnZAcg3kYQvUpqiPpDquN6tpX7NkDh3Xl4Jw/VMh+YKojcmnA0
	 GfYPXAo+xk9YG9XeoHTNRirIdxrtJME401qVK1qh/mW07F2NQbE266JfuvtLmSKOI7IS7
	 3zou4T3mmGFTl+pNcesKUVVJeN+EKTgMcqTUqeabpimKo0Ub6ikX+vhQLCcsxGc3EXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=fail header.from=smartx.com;
	spf=none smtp.mailfrom=smartx.com;
	dkim=pass header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fyX6a1Jm;
	arc=none smtp.remote-ip=74.125.82.50
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97AA6606A31C
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 15:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97AA6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=smartx.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=smartx.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=smartx-com.20260707.gappssmtp.com header.i=@smartx-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=fyX6a1Jm
Received: by mail-dl1-f50.google.com with SMTP id a92af1059eb24-185fd3a4ca3so2146717c88.0
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smartx-com.20260707.gappssmtp.com; s=20260707; t=1793288225; x=1793893025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ISkMz3ASxfr+lKCh/nGM5qIpjGO+THkfUP4Oe9g4JJg=;
        b=fyX6a1JmIX16giFT5SgiksZLB+bGccozjMTwvQ5Hy6Gtb6320r0NfZkSsMUjcW3kHU
         SxyltN/matoVdvpYzfSUf30tVIhsxZuB35PNIOSBP19ZQGeBeEcGT11s1WtlEPmJL8X8
         uEn3l0QtNap2JpfYhO9bSZQMA3TxLRXNHvIslmmdFviP3OyDwsSdeUMgvwrCLYBPgBl8
         AtYw2GnQBisbLMofFI+kl9OTkGnfxkjL5WQ9tx8av5ceUUbrlDR5dfsczLEdR3E0SBfE
         ysMN9kP1Ai2DhAj95oTEw9eSGbDJdldHVLCcaqzxwPpNd3jHyjqy3wcCMELf1Noc1G0l
         vpSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793288225; x=1793893025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ISkMz3ASxfr+lKCh/nGM5qIpjGO+THkfUP4Oe9g4JJg=;
        b=Ovlia2zh2FItySXuyubD3loIHgFEyMhflo51ZAw1MrYA0ShCHtkETPZGlMK6cjdgE1
         LAaUbV/Jg7IcSaAaIXVTv1RaICOz6wRqUacpk0d4U2jMMw+2uxo9KGdIGUA+lBebRd0S
         dzZC4coNxsdk32Eu7kVTn216INhR1iQVerzdsTeOFUpieLmiJcY33qZFO/nIIW9mHkRU
         j84x4iQTGkBr9QDXMK+iaUDjyyyMjXfq81ulUHegHGo1eAFTSNldv/XNEaWOtACojyDc
         +NRLOOp6pqfKPRyfIBvfEd6c8O9gGZEpyM52vOBtQCFQQyTH7/hg/wFixG96yoQzgiTc
         U6uQ==
X-Gm-Message-State: AFq9FYJxmRENvzKvY2O3x2bfmOd29VFTUkcjf5kfWtI760uRg5MgV/3t
	yPPtCzwMnvR6h5r1j9RMz5z5yzY7ko1kTKTXdUn6N7jSfQuJ+y7bkHv4hkv7YZt/DWAWPsradO5
	rJtzFkWbhnnnwoqqtwMxvrCPpOGZXj7QY/zVgelBDnLoXYGoGiOowS+2C+ZCms5ZI+LrgnETc
X-Gm-Gg: AYBFou2u2eOlriJqavSUvdqGWV9wWmbZExf0qcrZvSokCNey/B40uqhLQRLM8Qvahyv
	HfIiR1SKRZJgkLcCWJNJLTv5I9vxIwCXOShpFoVJvhArvLdsNjJOcNxNbMgnNtDR5iIlKM0umfC
	ZQxp7TYV+faBLT3cFIeBrRMlTKRrhz5x6TpST2xN6gLS21W3zfXA4rZIIfNbnUhqZlh92U5Ai4U
	XGiNON/nyU5cyKl+dHWvnua8im92IGgWPzg9WYuo5/0cxzqgE8K1R1YP7/nIYyi9IC528NftsDe
	sn8UUNwl7b8h6srpG8WdUue7Rjo4TrueF+aCVF+P97x5HblXOYZXfO65NR+G4soP4ukrjvF7+80
	dnUrcWvGBFVz/7gwOZN+Cer0K2chiY2td1Xy5L88qdtnvQpQTdCGyPv+nJ96mjkacYhNd1fjDEd
	52IT4EKv1nE0i1Lafp5k3vxp2v6Sp075Q+7oWsKrtSWx0wc0/sp687uy+qqqUcse4jvIm1zRmnd
	9eR6eMApcO4cIH/e/WmHuwYjiRBfKWMMilKknEu7vnaxuLmzShT4tpQi05x3M35Q2Q6ibwu4SC5
	cAKmhcRwJypaR5u0GVsEyItlCMnagVxNS45j6KQICwRlfzWfpxsvqvxFf9849cLm
X-Received: by 2002:a05:701b:4586:20b0:1a1:8bac:c1c1 with SMTP id a92af1059eb24-1a6cc069414mr7188123c88.15.1793288225045;
        Thu, 29 Oct 2026 08:37:05 -0700 (PDT)
Received: from localhost.localdomain ([23.148.204.240])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75e1f2de2sm15338311c88.13.2026.10.29.08.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 08:37:04 -0700 (PDT)
From: Wang Zhan <wang.zhan@smartx.com>
To: netdev@vger.kernel.org,
	Eric Dumazet <edumazet@kernel.org>
Cc: Wang Zhan <wang.zhan@smartx.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	stable@vger.kernel.org,
	Kyle Zeng <kylebot@openai.com>,
	Florian Westphal <fw@strlen.de>
Subject: Re: [PATCH net] inet: frags: limit the truesize of a reassembly queue
Date: Thu, 29 Oct 2026 23:35:39 +0800
Message-ID: <20261029153539.1224463-1-wang.zhan@smartx.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261028182934.2236310-1-edumazet@kernel.org>
References: <20261028182934.2236310-1-edumazet@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On Wed, 28 Oct 2026 19:29:34 +0100 Eric Dumazet wrote:
> @@ -510,6 +513,7 @@ int inet_frag_queue_insert(struct inet_frag_queue *q, struct sk_buff *skb,
>  	if (offset)
>  		nf_reset_ct(skb);
>  
> +	q->truesize += skb->truesize;

I am not sure whether q->truesize should be cleared in
inet_frag_queue_flush(). Was this intentional or an oversight?
Although this does not affect the fix, after reinit q->truesize includes
fragments that have already been freed.

The call path:
  ip_frag_queue()
    if (ip_frag_too_far())
      ip_frag_reinit()
        inet_frag_queue_flush()
    inet_frag_queue_insert()
