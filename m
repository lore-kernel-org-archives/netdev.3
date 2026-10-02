Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02F8D2BEFF5;
	Fri,  2 Oct 2026 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790953262; cv=none; b=po+8+w8mUTh1IuFTo8wwp2qJeBhKE6op/C/iFolBOwG166sxsI9bxw1Zzadwu9/7EkRGV62/WhSFnnegwidfnO7URUMwL8dIv5Yol9WR6Wl+2KO8/Bnmw6WrO3vEOhtQE3z5hrXIlvTr3BpL/M1c8U0UYOe7TKeZKj6SdweiFnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790953262; c=relaxed/simple;
	bh=+siaZXvk6hAkD+vDKPAv0Oqo4gbWvnGDIAOfoi+byvw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=aRYq5EjvIoSjp087N9ChFwpqUjg6Fzz/ZZ6icuZ2IMTLflXvSbGURwdUVj1PjTObpS/rTnKHJByoIw7omg8yzFiq/55sksjdPDQKQnnf6y9E+svVf6BX74jBNck1cX3I/VPUJiIKt5MXioGwi53sY1o30ijhM8Kjj/0SiDwlme8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=EI6gatAe; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="EI6gatAe"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9A79EA0579;
	Fri,  2 Oct 2026 17:00:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1790953257; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=2pe520I3fJpcCDB2BSMD7MFtkbrDxlO8z2NM7U0NQgc=;
	b=EI6gatAeiC9jn8YoczEoSUdTmne50bONHSexQ7wuVczWqOMVwJ3zkYVcMWIyXh+vhpE0Yf
	/6bPSvkH8/9z/IgJj1+PUrP+Rp4u+a4log6u+VcS1UrGnwr2MbsSNdcArGJyvmnZBIAwaQ
	87cVEXqZ3kdwVaTSJ3Y7/4Ak2U0o7aeJR1jDERPLbJZBuqpEwe3HIN7caprsNZijPN4GVa
	Fg9g/W7akfgz0okS42rxdqWQcbcloT9gxP6wSFdP6bouyVHhZBGJHMJZsx26qljkE4i0zF
	YWxIsXSyyx9b39oEkH9CPAmmQfN1zuh4JT4Jk7b8hZlZIN0EhbOL34iI9R4+lg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 02 Oct 2026 17:00:56 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, Jakub Kicinski <kuba@kernel.org>,
 davem@davemloft.net, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Maxime Coquelin
 <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Russell King <linux@armlinux.org.uk>,
 Lorenzo Bianconi <lorenzo.bianconi@oss.qualcomm.com>, Jitendra Vegiraju
 <jitendra.vegiraju@broadcom.com>, thomas.petazzoni@bootlin.com,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, Peter Robinson
 <pbrobinson@gmail.com>, Joe Damato <joe@dama.to>
Subject: Re: [PATCH net-next v3 3/3] net: stmmac: Don't set or get RSS
 parameters when not supported
In-Reply-To: <20261002142806.1299041-4-maxime.chevallier@bootlin.com>
References: <20261002142806.1299041-1-maxime.chevallier@bootlin.com>
 <20261002142806.1299041-4-maxime.chevallier@bootlin.com>
Message-ID: <f009c8c1e2d095bbdce139d5877d300f@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 2.10.2026 16:28, Maxime Chevallier wrote:
> The RSS kselftests fail on stmmac, and this is partly due to the driver
> reporting bogus data for the RSS ops :
> 
>  - ethtool -x reports an indirection table and a key while the hardware
>    doesn't have any of that
>  - ethtool -X fails with -EINVAL.
> 
> Return a 0 indir size and key size when rss isn't supported, 
> effectively
> meaning we don't support RSS here.
> 
> Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
> ---

> [...]

Reviewed-by: Nicolai Buchwitz <nb@tipi-net.de>

Thanks,
Nicolai
