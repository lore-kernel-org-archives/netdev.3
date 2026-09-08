Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE103CF95A
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 08:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788855435; cv=none; b=ceivaKdgoI8hwCAPGDcew5lEMAWH7/xIf9u8DC7x6RtVkZqMUb9HXf05k3E5jJ68fxYLAgAmWkfZXRaxtQIKsB6qgeHHi1ZZRjNvNiTEpd9DjKLsYWXnoMgjh94T47QrvE+kSCahxHkyeiG88QLZSyGueKCFuvYkMK9t7e1SulE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788855435; c=relaxed/simple;
	bh=X4SCGzR9Z/D6wjU/3yGHHJ8OLesQMj3JDhp/4C8Z1lA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IfdX+JPbmFngAmqqIoDbDsVHVGnavnpDcw578kRM0eV5GVJl8HvEIQz/cdGQsDJEpBlFqw5CarxAmzLDljV96W/rCAepzlDXtlxoQao0KHqdOOSqEvtwkaPAko+Lh12X4WScxMpUKI8eA+s+og7417Ct/GjE+Dik3RU/J9msMIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=EVe5o1lr; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="EVe5o1lr"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 50A1E4E41586;
	Tue,  8 Sep 2026 08:17:10 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 21053603C4;
	Tue,  8 Sep 2026 08:17:10 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 0C6D911C79CA0;
	Tue,  8 Sep 2026 10:17:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1788855428; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=9lLKZepQhjXkaNa0awySroD+8Sxqj/MifOMg6ARzVN0=;
	b=EVe5o1lrk/uElndENaukKIAenamtp9ru0HgtgYqmOfJPIbT6TI1HF+xmeYzSESUVjATgMw
	PXpGl2lYMjNRF8yXA5SsZ9wTmBJGoKrgr3Tfz5v22CG1CNoMOZODko0+Ww5cy27BM+ePtE
	xkTtEW4EAFv5a6Pn0cyVQp/ki5EyFmAVif4UbMZWIkl1dLBKD0WcNo7ZufpNFl+z3gMXBk
	ANhKGcMxbviUMGCI2HoTYm7F4LRUPylkzVKrsPhyhyL/is8uwWZVn1IscGC1dCcehefvPC
	2xzqU155ckmK5W1i/TFVZGHbEPFXC4D5HTSr3a1mIITD4/cG6u347BWm0//Imw==
Message-ID: <09e7cd4b-b79c-47ea-95b6-1c1a96fe7657@bootlin.com>
Date: Tue, 8 Sep 2026 10:16:59 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v2] net: stmmac: restore NET_IP_ALIGN in the RX DMA
 offset
To: Pascal Kneuper <PKneuper@dspace.de>, kuba@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
 rmk+kernel@armlinux.org.uk, 0x1207@gmail.com, si.yanteng@linux.dev,
 larysa.zaremba@intel.com, aleksander.lobakin@intel.com,
 netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 DBaldin@dspace.de
References: <20260813092923.284285-1-PKneuper@dspace.de>
 <20260824125014.47862-1-PKneuper@dspace.de>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260824125014.47862-1-PKneuper@dspace.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

Hi,

On 8/24/26 14:50, Pascal Kneuper wrote:
> Since the RX path was converted to zero-copy, the page pool page is handed
> to the stack directly as the skb head, and the offset the DMA engine writes
> at is what determines the alignment of the packet headers.
> 
> Before the conversion the payload was copied into an skb obtained from
> napi_alloc_skb(), which reserves NET_SKB_PAD + NET_IP_ALIGN. The
> conversion moved the headroom into stmmac_rx_offset() but did not carry
> over NET_IP_ALIGN, so on architectures where NET_IP_ALIGN is 2 the IP
> header now lands misaligned:
> 
>   64 (NET_SKB_PAD) + 14 (ethernet) + 20 (IP) = 98
> 
> Same for the XDP branch:
> 
>   256 (XDP_PACKET_HEADROOM) + 14 (ethernet) + 20 (IP) = 290
> 
> On ARM32 this is fatal, because ldm and ldrd trap on unaligned addresses
> even when CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS is set.
This patch breaks the stmmac selftests for Jumbo Frames on dwmac1000 :(

Try ethtool -t ethX, before :

27. Jumbo Frame               0

after :

27. Jumbo Frame               -110

I _think_ the issue is that we have buffer start that is not 4-bytes aligned,
the controller can handle that no problem but it still performs a 4-byte
aligned transfer and discards the first 2 bytes of the first DMA word xfer,
and last 2 bytes of the last xfer.

The issue is that that last burst may not fit in the buffer size we specify in
the descriptor, so another descriptor is used to store the last 2 bytes of the
frame, and the first one doesn't have the "last" bit set.

We need to account for that when computing the descriptor size field in
stmmac_rx_buf1_len().

I can try to send a followup, if you can give it try that would be appreciated.

(this is the first bug found with my stmmac CI setup, we'rre getting somwhere !)

Maxime
