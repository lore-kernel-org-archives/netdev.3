Received: from mail-m16.yeah.net (mail-m16.yeah.net [1.95.21.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA8DB25B0AA
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 10:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=1.95.21.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779532501; cv=none; b=HY7m8V7ewTMqHv++0K+lHBtFBUeGl1kp+MhqJXL8ec3vOcBP73790FHQDPZsj57xoHdp4jlpQngM4n64GL/taXaqhcSZ5MXTcSDNFtg0r09IxkEQ1LB1YAYwZ3GDLDqVcsOuiYTaLjPXfzUEw/IAQ7smPErI19uyXyxjpjdeAWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779532501; c=relaxed/simple;
	bh=UhDVeAgs5MM60bf4Z0fUuZTJS8vHpaji8I67tg2mEgM=;
	h=Message-ID:Date:MIME-Version:To:Cc:References:Subject:From:
	 In-Reply-To:Content-Type; b=tABnUryC4zpH9GcJUn9OVNZobIGj8SZs0KVf+TK/62xPCA2yy7/Lr9m6QuSOYqAM1bSNu2Kc9NGvCTonmdoatsVGOv6UM/lK5IzWU0f7RrqkadPa5D2SigE7k78wIDOrM5xrkXAlqeXlAZT1LfWKCO7j0zzKQYWOU+vnUEvxXEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net; spf=pass smtp.mailfrom=yeah.net; dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b=ES/THfEM; arc=none smtp.client-ip=1.95.21.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yeah.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yeah.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yeah.net header.i=@yeah.net header.b="ES/THfEM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yeah.net;
	s=s110527; h=Message-ID:Date:MIME-Version:To:Subject:From:
	Content-Type; bh=oij44dKMQDraqYM66PoX/o84/gh89pogadBAxRYI4WM=;
	b=ES/THfEMSqwLAi2rX7woOhYft2me3Kw16hy91UQXGF1nW2j0HetWlNAJdre4VL
	uweQS0mnPSc3vDTa8XP4Gjr6Dl9JLcQe307uxTV37OGDg1DdGgwlESpDDfQyfOQt
	wa7nkbDnwzy/SVq6/7usC6O8K0axrvrDJZXJ4rHFQIbzY=
Received: from [100.70.220.18] (unknown [])
	by gzsmtp2 (Coremail) with UTF8SMTPA id Ms8vCgD3P_a_fxFqYOLFAA--.3661S2;
	Sat, 23 May 2026 18:21:53 +0800 (CST)
Message-ID: <a3a9146c-1f46-490a-a5cf-aa81988b312a@yeah.net>
Date: Sat, 23 May 2026 18:21:56 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: luizcmpc@gmail.com
Cc: edumazet@google.com, ncardwell@google.com, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <CAHx7jf_HP3HOENCWa-nb3tMa4U_RXgXpYL38CsVmuMFqhyUpDw@mail.gmail.com>
Subject: Re: [PATCH net] tcp: tcp_acceptable_seq select SND.UNA when SND.WND
 is 0
From: xietangxin <xietangxin@yeah.net>
In-Reply-To: <CAHx7jf_HP3HOENCWa-nb3tMa4U_RXgXpYL38CsVmuMFqhyUpDw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Ms8vCgD3P_a_fxFqYOLFAA--.3661S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvj4RJUUUUUUUU
X-CM-SenderInfo: x0lh3tpqj0x0o61htxgoqh3/1tbiIALuI2oRf8LBDQAA3l

Hi Luiz,

I meet a issue that strongly resembles the zero-window stall described in Bug #213827,
and I found your patch thread.

Since it has been a while, I am writing to check if this issue was eventually resolved,
and what the latest or finalized approach looks like.

If you have a patch， could you please share it with us?
We have a reproducer/environment ready and would be more than happy to
backport, test, and help validate your solution.

Thanks again for your time and for investigating this tricky corner case!

-- 
Best regards,
Tangxin Xie

