Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F1C37C110
	for <netdev@vger.kernel.org>; Wed,  4 Feb 2026 09:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770198218; cv=none; b=o9kt2utyF9QftwpZBnGA2VDz5uW9HSbG8dl/nzD7SXR7T0px5lzj7j7s67oGB03/NfdzMHgW7fMAYWSFarifrs/Hbvu4wnGK2L/rqK6lIe6VgCGNtZee5QAf+lOpiE6+cmPLCIGvxVdyEA4UjyWHkNeE3MYsyZ9Iqp2xhL6NwSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770198218; c=relaxed/simple;
	bh=YYHVJzzDuiPYXBrNyub8NoljsJNUn2c+BE+TsXuz0Fo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lEUfV8NRJMADFF/Gj0SIcitTknbHIvADrmoqIOR4uqU6gAzaRWlHR8yYmeEBnaFC8pUoxVpDjAMtJHMjlKtmaX2j5/Btxam3tyelU7oPtwxiNjcYboECr9mGnTLcBzRU4DNXGy/Tf3mD+wRGNfwG2K7U3y4d/OV9FObtxpURO7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Cg6QqlH5; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Cg6QqlH5"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 53C841A2BE7;
	Wed,  4 Feb 2026 09:43:36 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 24DE960745;
	Wed,  4 Feb 2026 09:43:36 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id D1692119A865B;
	Wed,  4 Feb 2026 10:43:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1770198215; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=PWtAsLhTfJ+y5jHsYpWzRsgFbu/hEL4qAn8qo8Aj8hs=;
	b=Cg6QqlH5UgjplYLeJZvheJEIUH49IBNOZnNrsXDS75HuEkWxF+/u5DZjKduBiLw87Iyubm
	PnGEefEDF0WzKfvTR9sEbX1LPxMc/MTt98JHEmYvkZ/IrhNhMN+i1DtyRpS9VIRfpVK0/v
	EM4O+h5Td69BZpCB17TkwIr38kL/7z228stYxvCyrBqmfhqTyIQQHHUYx5Aaedg0hE0ibr
	eXCsYAl1+fK5VrsGUXY+POiVBJGb6HFdpNeRBsF9PJf9xKcI2zG6hTn53/Z8Lp0q7oUMoe
	NgRRYlDP35ZWPlLzcgS+l76RxObvn/sqs5CMdPiWkXqfmEmtlFb0UQCnyB26xA==
Message-ID: <85fe08a2-189f-4740-81e7-81a65e23fab2@bootlin.com>
Date: Wed, 4 Feb 2026 10:43:31 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 3/6] net: stmmac: rk: rk3328: gmac2phy only
 supports RMII
To: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 Andrew Lunn <andrew@lunn.ch>
Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Heiko Stuebner <heiko@sntech.de>, Jakub Kicinski <kuba@kernel.org>,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <aYMN2gZMfLPKuukG@shell.armlinux.org.uk>
 <E1vnYxw-00000007hox-0DqH@rmk-PC.armlinux.org.uk>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <E1vnYxw-00000007hox-0DqH@rmk-PC.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3



On 04/02/2026 10:14, Russell King (Oracle) wrote:
> As detailed in a previous commit ("net: stmmac: rk: convert rk3328 to
> use bsp_priv->id") rk3328 gmac2phy only supports RMII, whereas gmac2io
> supports both RMII and RGMII. Clear supports_rgmii for gmac2phy.
> 
> Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

