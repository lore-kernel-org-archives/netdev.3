Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=159.226.251.25
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794134422;
	b=r0c0n/Wrbczzdb9bkkR0NR6tEgwHxZYXJX2/n+TxfXMVd/ATUndiQNbtc038vtRgBAAQ
	 mwWd99w3GJ48dFXSzC+TPI0tvISImIej/KD3uyUBoTGOwUfuynIBufo0KBshvglOYfr1r
	 yvZSxkHg3VaLlZFbYtEVdCwrDWYLBWgyeqOr29faS6veJXcb5K/ANfEi3wz/6zVYgndG5
	 J2bQiUNdWjxjZNW+Up0Jylkopj/YgOnnjsggfCfqab8bgsH4s1SmsOm81MwKEsQIl+0Cl
	 dOkwnL3+4eATY5rJ5jV331kyqgDTZ/qFox+wFLB50dxvYBjiR8SQEtbc+8R8NlIid7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794134422;
	h=DMARC-Filter:Received:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=PdqtEo9xLDdWwT3xdR1bxDI+v+RI6HU8eGmnhPdgZKo=;
	b=U1OyRy4mzEHksgN+bXFmONC/+g9FEc98RPotBoI0zPCGTxeUsRz+UkcmTdscBhJnaC3H
	 l7nwT0sIIssqOhTF6I/7yEr/3/GO+DMGA0H9EWRslansd3z18/4osBgHf7FfhY1yhRW2z
	 sDsyifRZLdwmH3UnjEjvTPVozf4YJ+mYUDafcQrHxiOeiSYuK+5pyjrpIiHs6JYyrtZ0u
	 LJN7IdLyA6nMDYOaBpE+6nrN+a9rLkSZ+IdT+y/M8monGK0tf7RLy2BUVeH1IPLvUSw1k
	 aBdv07C+nMRqx3+AphuFJ34IVdqmEWR+srcZ41b6ySvAHJ3wj6vOAPXEtjt2IPUbaPw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=iscas.ac.cn;
	spf=pass smtp.mailfrom=iscas.ac.cn;
	arc=none smtp.remote-ip=159.226.251.25
Received: from cstnet.cn (smtp25.cstnet.cn [159.226.251.25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4E6606A326;
	Sun,  8 Nov 2026 10:40:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A4E6606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from [172.100.0.8] (unknown [36.110.52.2])
	by APP-05 (Coremail) with SMTP id zQCowAC3TbOMUfBqS6eZAA--.21264S2;
	Sun, 08 Nov 2026 18:40:12 +0800 (CST)
From: Wentao Liang <vulab@iscas.ac.cn>
To: Alex Elder <elder@ieee.org>
Cc: andrew+netdev@lunn.ch,
 davem@davemloft.net,
 edumazet@google.com,
 elder@kernel.org,
 kuba@kernel.org,
 linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org,
 pabeni@redhat.com,
 vulab@iscas.ac.cn
Subject: Re: [PATCH] net: ipa: Fix enabled_state leak in ipa_smp2p_init()
Date: Sun, 08 Nov 2026 10:27:00 +0000
Message-ID: <20261108102700.3182122-1-vulab@iscas.ac.cn>
In-Reply-To: <692ed9ca-fac1-42cd-a514-517f6903f8d8@ieee.org>
References: <20260917115216.2149867-1-vulab@iscas.ac.cn>
 <692ed9ca-fac1-42cd-a514-517f6903f8d8@ieee.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:zQCowAC3TbOMUfBqS6eZAA--.21264S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKw45KFWxtw4UGrykCF13XFb_yoWkXwb_uF
	yjk340qa109rsrtF4Ikr4Yvr4fWayxXry7u3sa9r4Yy34rWFyDGr929rnakF1fCrW5ZF1D
	CFZ09ay29w1qgjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbT8Fc2x0x2IEx4CE42xK8VAvwI8IcIk0rVWrJVCq3wAFIxvE14AK
	wVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20x
	vE14v26r1I6r4UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280
	aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52
	x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUtVWr
	XwAv7VC2z280aVAFwI0_Cr1j6rxdMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrw
	ACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2AF
	wI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY6x8ErcxFaVAv8VW8GFyrJr1UJwCFx2
	IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v2
	6r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67
	AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IY
	s7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr
	1j6F4UJbIYCTnIWIevJa73UjIFyTuYvjfU7nmRUUUUU
X-CM-SenderInfo: pyxotu46lvutnvoduhdfq/1tbiBwQFA2rv42CrNQAAsd

Hi Alex,

Sorry for the very late reply, and for the noise.

You are right on both points.  This is already fixed by 96ca1e658ae45
("net: ipa: fix SMEM state handle leaks in SMP2P init"), which has been
in mainline since v7.2-rc2 and releases both SMEM state handles on the
init error paths and in ipa_smp2p_exit().  My patch is a duplicate, and
on its own it would also have been incomplete: it only handles
enabled_state and leaves ipa_smp2p_exit() untouched.  No v2 is needed;
please disregard it.

On where the code came from: the diff was generated from an old snapshot
of the tree (v7.1-rc4 based), not from v7.2, and I did not rebase or
recheck it against the current tree before sending.  That is why the
context does not match what v7.2 has now.  The candidate itself came from
our static analysis tooling; DeepSeek and GPT-6.1 Sol were used to audit
the finding and to help write the change, and I reviewed the result
myself before sending it.  Checking it against the tree of the day was my
job and I skipped it, so I am sorry you spent review time on this.

I am working through the rest of the feedback by hand now.

Thanks,
Wentao

