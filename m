Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794135634;
	b=G78ssHcStBqocfrhZAtND/wWKGUZKTaxBQ35w9hd0W7CZ302ZCUbXv/87iciABUTHUna
	 zd5Ezp/7nOjDf66YbVY9e4CDYrivzW7QcO212MlEc+DX6TeDLlV0LjwaRHpKJ3/BQ2ddZ
	 uYV6FjR6NM/lJYbxcM2t4aHv/lHZcnIhe/blyAK0BcxubM3MoACH8uBLmGo20hwJdWuto
	 7cgbn4DSCRVts12U9ueamoGRDDZWXagXNeaOeWVq9i/WMgq/Tw0zfTNANAH/nm+LuMVgf
	 Duo2y6Qldz7wPkcDw67tSVPGgfbGaeUJbxWYehCbrkn+luF9Tl8bGqtSOGY76ra8SCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794135634;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:Content-Type:Content-Transfer-Encoding:MIME-Version:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=/kOHEMt6o3SH+fIujtD4HWZmb2OSZImsZF0uq5e7/vU=;
	b=5KPfO64qNnrA9t4RA6u2Dt4GPwQw7Zf/DN/U1oXro8LlVC34TiOVZUgoZvf9v15w6Dd2
	 5/6K95CNDqZnPE4+95hshYpKeFlU1Qt5HCpqnwRCNusq/C8UqSpWovipa8wvtCKKSbY34
	 Dl7Cw9FE5UO2uxBBDmqciV46lIPYOoriepwSP/yYQldDwRclQ+6fGTQg3MMUllG4u5Lh2
	 Hmo5ysz1CBkP9tJU79NEZTmBcCvI9bmf/0j2Pp4q1P5TXNZ1RaaxqzTRepdeNJSIS3gan
	 nBzxG51rZ2k1LQvPsupFvCXJfNDbEvwLdEgZ4gZ3X34tPEo7l473HLppVcUbIaNxfLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFE6606A31C;
	Sun,  8 Nov 2026 11:00:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2EFE6606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAD3j7VFVvBqX_OZAA--.21534S2;
	Sun, 08 Nov 2026 19:00:22 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Simon Horman <horms@kernel.org>
Cc: UNGLinuxDriver@microchip.com, vladimir.oltean@nxp.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, vulab@iscas.ac.cn
Subject: Re: [PATCH] net: mscc: ocelot: Fix mirror reference leak on VCAP aux
 resource error
Date: Sun, 08 Nov 2026 11:01:12 +0000
Message-ID: <20261108110112.315001-1-vulab@iscas.ac.cn>
In-Reply-To: <20260921104624.GI13925@horms.kernel.org>
References: <20260917113444.2149183-1-vulab@iscas.ac.cn>
 <20260921104624.GI13925@horms.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
X-CM-TRANSID:zQCowAD3j7VFVvBqX_OZAA--.21534S2
X-Coremail-Antispam: 1UD129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UjIYCTnIWjp_UUUYX7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_JFI_Gr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1l84ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s
	0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xII
	jxv20xvE14v26r1q6rW5McIj6I8E87Iv67AKxVWxJr0_GcWlOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwACI402YVCY1x02628vn2kI
	c2xKxwCF04k20xvY0x0EwIxGrwCF04k20xvE74AGY7Cv6cx26r48ZrWUJr1UMxAqzxv26x
	kF7I0En4kS14v26r1q6r43MxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_
	Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x
	0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8
	JVWxJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIx
	AIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU0xZFpf9x0JjUgAwUUUUU
	=
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiCRIFA2rv4kizowAAsi

Hi Simon,

Sorry for the very late reply.

You are right that a goto-driven unwind ladder is more robust here: it
keeps the release of resources taken earlier in the function next to
the failure paths, so that a failure added later cannot silently skip
it. I have reworked the patch along those lines, and a v2 follows in a
separate mail. The v2 also records how the issue was found and how it
was tested.

I am going through all the remaining review comments one by one now,
and I will not send patches in bulk again, so that I do not get ahead
of my ability to follow up.

Thanks,
Wentao

