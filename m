Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DE813F0AB3
	for <netdev@vger.kernel.org>; Mon,  6 Jul 2026 07:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783322987; cv=none; b=J7st8P4zDb9DAeoGvETq5P99HtfAxxgpdnYE85D3Kr0Bm+78yovbXBV5B5TJuoFEnWrTxZF9gREUZi23TxHhrTNlHFM0EdBifqv/wNDMSLSZniT2+qL4fzeMXONuNJPPLxxBXOhxvEfFKL2LovI4wvUTSd3DA8nWbjGF3ES+SRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783322987; c=relaxed/simple;
	bh=BJdzyAdPzA9PfeUybiJaZ9NvFJM2wfG8nwzgx+vwc+M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cLfse8XQV3gYTzLOeGT7fL+RKkB6YXXorjtjFWyZy8DO/J7j82A1b0CVc+fvINGwkdfiocpG4AQCYUjfbOexSUsWOt5+j43T7A+vHeYrMpD37itC1xzb89lSlHyJeyOy7EjnCycw22Yv3Ed29eEKP6fNYFbJhrBjmttX5j8mcAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Zbh7if0t; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Zbh7if0t"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 9A6EF4E40CA6;
	Mon,  6 Jul 2026 07:29:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6F904601A2;
	Mon,  6 Jul 2026 07:29:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 7C01511BB9B7F;
	Mon,  6 Jul 2026 09:29:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1783322978; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=Aj9lqzpiwEKBkvZLZq7eSUG0H/5wh4xQkq/3Fm/wPyo=;
	b=Zbh7if0tzX7dtkKyhz9JHOMndwD9zF1EW2OiiO/MxNC8XkBayZZxLAoe+v2vgU2hkuAZh5
	Vu1l/wT8pYWAp0pv/DnohOEc4reLdKPdxxtyLmSv7kcQyc18MS9sctljA1sxw8fDsfEmZh
	AA+09obNfiFq0/xUZ09R/CG+VG0qdY0qeo2PnGf8Z1yzi+Va858VQReEX/u1XKcx5iAEkf
	hxzuU76QizTKlClSC6REuR84AgLkbivcjQxALuKB55dbUErNguPCaf4QNa0s6/NY8MlBLe
	qTxBMFzebCLnBIWroSznsueKrjlZFrwOM+kmeXtM4tcFcqN1Kbk1s3Jz7LOEzQ==
Message-ID: <21f1bc5e-72ff-494f-bff3-5c0e4275cdad@bootlin.com>
Date: Mon, 6 Jul 2026 09:29:36 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/2] net: sfp: add quirks for OEM XGSPONST2001
 and FS XGS-SFP-ONT-MACI
To: Martino Dell'Ambrogio <tillo@tillo.ch>, netdev@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
References: <20260705185440.136496-1-tillo@tillo.ch>
 <20260705185440.136496-3-tillo@tillo.ch>
Content-Language: en-US
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
In-Reply-To: <20260705185440.136496-3-tillo@tillo.ch>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi

On 7/5/26 20:54, Martino Dell'Ambrogio wrote:
> Cheap XGS-PON ONT sticks identifying as vendor "OEM", PN "XGSPONST2001"
> have broken TX_FAULT and LOS indicators (driven by the ONU serial
> passthrough wires) and need a longer T_START_UP than the SFF-8472
> default. The Fiberstore XGS-SFP-ONT-MACI MAC-mode ONT stick has the
> same ONT-class TX_FAULT/LOS wiring and startup behaviour. Apply the
> existing sfp_fixup_potron handler to both, which masks both signals
> and bumps T_START_UP to T_START_UP_BAD_GPON.
> 
> Both modules fail to space-pad the EEPROM vendor PN field past the
> legitimate string as SFF-8472 mandates (the XGSPONST2001 fills it with
> non-printable garbage), which defeats exact-length matching:
> sfp_strlen() cannot trim the field, so a plain SFP_QUIRK_F entry would
> silently never apply and the kernel would honor the spurious TX_FAULT
> and eventually disable the module. Match both entries as prefixes
> using SFP_QUIRK_F_PREFIX.
> 
> Signed-off-by: Martino Dell'Ambrogio <tillo@tillo.ch>

Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>

Maxime

