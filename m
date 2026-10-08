Received: from bkemail.birger-koblitz.de (bkemail.birger-koblitz.de [23.88.97.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9265A29B766;
	Thu,  8 Oct 2026 12:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.97.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791461867; cv=none; b=HZ/WUhYol0SXMHN+Q0hrykteYZqmvrxBn8ptwZwub2IkzqJ8DjnKcKpXX93x9j5gOshp/qcXGu/Wx44S7mL0V1+/9t2HYnbFjq6cG4DhK5YLOGzwOuK7HDLZmS4swZcUZaxbtJDtp0i+jMrkDMhYW3UWThgvEIwXduCKtnfpaYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791461867; c=relaxed/simple;
	bh=79n3TeG5j1UaX+/AdwzOmfmxhX0AYmK8L5GixoO3mkk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GQ32NvBrPHfmMPCvcyel+akCX1W/5Tf3K2/w2PfSJ/Dk7T2FPPWd9PwtkBEQiJwcYpue+X+5XiTO9ZTgjZOKhlNhBF1V/EHs1gDO4R1lwrWgQaG4pHQQTsDyfiVQiaFflmGeP0zuaDpYuFlQPViheOIvTHFqzHZx1aOFXQP2iGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de; spf=pass smtp.mailfrom=birger-koblitz.de; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=w22IQ2ls; dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b=Dypgcyqi; arc=none smtp.client-ip=23.88.97.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=birger-koblitz.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="w22IQ2ls";
	dkim=pass (2048-bit key) header.d=birger-koblitz.de header.i=@birger-koblitz.de header.b="Dypgcyqi"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791461857;
	bh=79n3TeG5j1UaX+/AdwzOmfmxhX0AYmK8L5GixoO3mkk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=w22IQ2lsmqV/biPF4yc+R7xauEioyxmGtjNVsrepEhDwX0zTjq5hNUefPlJBf49cw
	 SrCFs9wsfRpsZ6naQbkSJwMleJjIcKoP9plQ+9S+lz8Hz0ktqIfrQA2P4v3At8t+Xk
	 XoVeUw0TEpk/RIA/3776ov7rQBVbVpmI/VWqTt9ZmFAT/7xIoeYZgi5MSlYekGcuTR
	 dWilCaM9fC0djqApSWuM7SoauR5Nzpzzt+tJ2k1lZdmsedz2dggrpHl1Vx/I213SOd
	 +TXFjkGWlF4GUrIJiReYUzYtjCTkxs/o1iPLgHXDf9aVgA/9ZbjypLyEcmt0NSD1S6
	 vxxmxBU62DnDg==
Received: by bkemail.birger-koblitz.de (Postfix, from userid 109)
	id C83374728A; Thu,  8 Oct 2026 12:17:37 +0000 (UTC)
X-Spam-Level: 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=birger-koblitz.de;
	s=default; t=1791461856;
	bh=79n3TeG5j1UaX+/AdwzOmfmxhX0AYmK8L5GixoO3mkk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=Dypgcyqi6UHesM2Of79Iw7jHOhsEwqO+kqOapKJd0X5PI99KUlF5bsmUX1Gu3QRJs
	 pfId/gnLu8eoPwHwgr7wAk2oXCmN49qFrghEpsPTECpeqMHgvAF/3FELfzw76vL0qE
	 Jakn+3aPQlxnXLeUd/n0yCpmcZcKl3jxoq3ti395nNCHPsNG5Bo19VcbrkYNBlXCOY
	 wmUhoLVs2bDK969WGd4RIVj6QGMqYnHyAc+dDsQ0efWD/ksIP9l9YQBY2XsMUDXxMl
	 ClwicoSb1xrkv/SOehlkKrRXzkjHoO174/3IAuSrTtMrbEen2X76O+fwJvJoFSG7C+
	 OdDfT3JNHmD9Q==
Received: from [IPV6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb] (unknown [IPv6:2a00:6020:47a3:e800:271c:c6c5:9fde:77cb])
	by bkemail.birger-koblitz.de (Postfix) with ESMTPSA id 87E1E47182;
	Thu,  8 Oct 2026 12:17:36 +0000 (UTC)
Message-ID: <633a0f2b-67b3-4896-8464-6a4d0c05498f@birger-koblitz.de>
Date: Thu, 8 Oct 2026 14:17:35 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 01/10] r8152: split r8156_init per chip and
 factor out wait_autoload_done
To: Chih Kai Hsu <hsu.chih.kai@realtek.com>, davem@davemloft.net,
 kuba@kernel.org
Cc: netdev@vger.kernel.org, nic_swsd@realtek.com,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 edumazet@google.com, bjorn@mork.no, pabeni@redhat.com, andrew+netdev@lunn.ch
References: <20261008081556.47901-1-nic_swsd@realtek.com>
 <20261008081556.47901-2-nic_swsd@realtek.com>
From: Birger Koblitz <mail@birger-koblitz.de>
Content-Language: en-US
In-Reply-To: <20261008081556.47901-2-nic_swsd@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Chih Kai,

On 08/10/2026 10:15 am, Chih Kai Hsu wrote:
> RTL8156, RTL8156B, RTL8157 and RTL8159 shared a single r8156_init(),
> gated by a dense set of tp->version range checks. That made the init
> sequence hard to follow.
> 
> Split r8156_init() into one function per chip family:
> - r8156_init  (VER_10/11)
> - r8156b_init (VER_12/13/15)
> - r8157_init  (VER_16)
> - r8159_init  (VER_17)
I have a hard time to understand why you want to separate out one init 
function into 4 different ones, for each chip one. Especially, if, as 
you say no functional changes are intended, which might justify the 
re-factoring in this manner. By multiplying the functions, it will 
become more difficult to maintain the code: if an issue is found in the 
init-sequence, it may now be necessary to fix it 4-times and future 
developments touching the init-sequence will also need to be replicated 
multiple times. In total, there would afterwards be 8(!) different init
sequences including the other ones for the RTL8152 and different 
versions of the RTL8153. The same pattern repeats with _up(), _down() 
and other configuration functions.

Would it not make more sense to try to further combine the init 
sequences or try to disentangle the code by establishing common library 
routines put into a _lib.c file and possibly different .c files for the 
different generations of the chips? For example, it appears that the 
rtl8157/9 belong to one generation of chips, based on the rtl8156 
design. On the other hand, rtl8152/3 appear to be a different generation 
with various family members. That would allow to build a basis for 
future development like to rely on using phylink to handle the PHYs 
integrated in the chips, which all appear to be already supported by the 
Realtek-PHY driver.

[...]
> 
> No functional change intended.
> 
> Signed-off-by: Chih Kai Hsu <hsu.chih.kai@realtek.com>
Best,
   Birger
