Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794134092;
	b=kEgrPafLzMLCaxzBjpT7bySXZDhG3eoMRmXJCMb5smY68nXq64QshI9pBLPygvYm/H2N
	 7LoHg23VwvAVFdaVHpF2KyXmkGkXphKbM3xfues8WvYH7V5GpwVGbEutksIId8I1UaRZG
	 q6iu7xMN09u87OzB+A4erhh2HxvfjcRceZVv67mI+5EUVGgOjCpJ3OTFfGM6lFAiulvqL
	 6j1lyj2DSq7vQSWDpXPzj9775/whCROUs1/OT91SDAQ3yu8fFi26yxuh/f+trdwzbU1/j
	 UUvjYCCePAsYzdWG9a/6Iu/jW2iT8U+fwK0mA6J1/3mgJsSt03Ys9U83pfgztDSwOMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794134092;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=W4I31YjleFdCNATg6q0vEOTi0QRZ/2qKymckCRQzCsQ=;
	b=ccNf6fuv8oMQWU21xPOEZEWC9lap5mQom2aYjtlkfl2yoaZDImdSekC7OrZ25w3DUnKg
	 JsEZmRgSCXyLrR3PGTLWLkOxB7gsQHbh3REhSAU58oDgzJGuIRrIa81wj6gVDh06NLlk3
	 f6VOoXDOR5mUqlUgpf+wESoTjfb7PL45/MbQN+aVPiJjNz8kzqZqZLATGaiiI5VVrfw8Q
	 oGnSvRGzVIBv5laYA0vxroS8bbzSYBAEhTm9qJyFlG6djxI852Wchusnd8m+Mt3Bz9fH1
	 fShXIvd36xVCnv3Pt9AMtNBwvVPb+6TVQcSgaHrlS4UvcE9YbE+k5HydKYPcT0gAgcA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424A3606A320;
	Sun,  8 Nov 2026 10:34:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 424A3606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowADnfrQ8UPBqZJKZAA--.18219S2;
	Sun, 08 Nov 2026 18:34:36 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Jeff Garzik <jeff@garzik.org>,
 Stephen Hemminger <stephen@networkplumber.org>,
 netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: cxgb: Fix skb reference leak in espibug_workaround_t204()
Date: Sun, 08 Nov 2026 10:34:46 -0000
Message-ID: <20261108101000.2147805-1-vulab@iscas.ac.cn>
In-Reply-To: <20260917073655.5d7c9ecb@kernel.org>
References: <20260917105425.2147804-1-vulab@iscas.ac.cn>
 <20260917073655.5d7c9ecb@kernel.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowADnfrQ8UPBqZJKZAA--.18219S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ur4UAFy7AFyDZry5tryfCrg_yoW8ArW8pa
	9xt3W3ursrJrWSk3Z7Zw17Ja40y393Xa98GFn8GryIywn8Xa42kryrKws8Za4xuw4fWr47
	tr4jqFn3G3WUZa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvYb7Iv0xC_Kw4lb4IE77IF4wAFc2x0x2IEx4CE42xK8VAvwI8I
	cIk0rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2
	AK021l84ACjcxK6xIIjxv20xvE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v2
	6r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxV
	W0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv
	7VC0I7IYx2IY67AKxVWUAVWUtwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbV
	WUJVW8JwACjcxG0xvEwIxGrwCY1x0262kKe7AKxVWUtVW8ZwCF04k20xvY0x0EwIxGrwCF
	04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I
	8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8
	ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x
	0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_
	Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x07
	bb5rxUUUUU=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBggFA2rv4zKpNAAAsB

Hi Jakub,

I am very sorry for the late reply, and for the flood of patches that
made it necessary. You are right on both points, and I apologize for the
extra work and confusion this caused.

You are right that I sent far more patches at once than anyone could
review, and more than I could follow up on. The hard limit of 15 patches
per person, and the guidance to stay at 8 or fewer when the changes are
of low value, exist so that the feedback on one posting can be applied to
the next. I did not respect that, and that is on me.

I understand why you asked for a one-month pause on new patches from
@iscas.ac.cn for drivers/net and net/. I have also gone back to the
kernel documentation on subsystem identification, patch set organization
and testing, and on how this kind of work should be submitted, and I will
follow it.

To be clear about how these patches are produced: we use static analysis
tools to find candidate issues, and then DeepSeek and GPT-6.1 Sol to
audit the candidates and help prepare the fixes. I review every change
and sign it off myself, and I take responsibility for anything I send.

This has been an important lesson. I am going through the remaining
feedback one item at a time by hand, and replying to each one promptly.
Going forward I will not send patches in bulk, and I will keep every
posting well within what I can review and answer. I have also shared
your message with my colleagues, as you asked.

The cxgb patch is a small reference leak fix in an old T2 driver. A v2
that also covers the single-port timer callback with the same pattern is
ready; I will send it separately as one patch rather than in this reply.
If you would rather I drop it, please tell me and I will.

Sorry again, and thank you for your patience.

Wentao

