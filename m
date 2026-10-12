Received: from mail.tipi-net.de (mail.tipi-net.de [194.13.80.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0426846D2DA;
	Mon, 12 Oct 2026 13:18:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.13.80.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791811113; cv=none; b=CeCwTagLhJFSZi1P1S66Ss/B2YgYoW4+PeG8mGuNJo7wnMXXjICra8vfoJ8qwIGK9erYHS8EupBsFlfQ4eKVtcJrNT2/mzZQt978VHVphLtDrYYB+CUHjpcnYLaWrDQl3bopI3gnI6k+z1a3aSIMFf0rcSaswV989KbXDYKMEE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791811113; c=relaxed/simple;
	bh=Bq/Kjg6CoCViVVMbPOG+5JtQptYfGBlE43kVe6rqTgU=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=AC4Vw06o79pbPlhWWDwJSTwvvQ+4E7MUIjjPLIdBRqfoElIRq2sIOAqCXpaNKRh0m88jd+T97eJ9ytZp7yuDWhy5ML3AqnP1MPt7o6G1Z+Ky7xiUncxyuROtxae2H9afbXQNeGsgvrhnNWVXz/0jxv1ohgN28Ezkd9tezaC6IAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de; spf=pass smtp.mailfrom=tipi-net.de; dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b=HwqI2EOv; arc=none smtp.client-ip=194.13.80.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tipi-net.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tipi-net.de header.i=@tipi-net.de header.b="HwqI2EOv"
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 07A3EA012B;
	Mon, 12 Oct 2026 15:18:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tipi-net.de; s=dkim;
	t=1791811104; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Bq/Kjg6CoCViVVMbPOG+5JtQptYfGBlE43kVe6rqTgU=;
	b=HwqI2EOvmzNJQCcgUVfX+jdD29+XEkBwuw99rgT21hWqWS8SfMH04iWELdUW7sU87gWxDx
	SXwFVowM1FdnPmuT6J88AXonOFyMv1efY8AfB5J8lvL7TG+JcwZkUaY13W09zUJwZpZ6Ob
	152r3huJ8Ehi5OJNjMAf0Jbj01i9rwzCYyBNYbs1wOZbXVDOUfnf9ApwefUaVVGDJsr2IL
	7jEIDbVjh6b+YQvMDWyg4tYSuUJf34OCoa0PLdMgdmpDB+pvfbXVmT9mPhMFZtsGU+0GBX
	CXiclk4ppm4HitJwogpbAZqy03Tzh6hJa0KBwoau5lUABrwlLP5JM2fS113vmg==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Oct 2026 15:18:21 +0200
From: Nicolai Buchwitz <nb@tipi-net.de>
To: James Clark <jjc@jclark.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
 <andrew+netdev@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Richard
 Cochran <richardcochran@gmail.com>, Doug Berger <opendmb@gmail.com>,
 =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, Russell King
 <linux@armlinux.org.uk>, Conor Dooley <conor.dooley@microchip.com>, Broadcom
 internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Thomas
 Gleixner <tglx@kernel.org>, Miroslav Lichvar <mlichvar@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 5/5] net: mdio: bcm-unimac: implement timestamped
 MDIO writes
In-Reply-To: <CANz3_Eae-M6V9XROx4GqPB+BVjVWWuO5JqGoBOybh0-D7DNZVw@mail.gmail.com>
References: <20261009143506.2507607-1-jjc@jclark.com>
 <20261009143506.2507607-6-jjc@jclark.com>
 <3b1a2994-5251-4800-8c61-b63d7a435b21@broadcom.com>
 <60accbd89cfaf0d4be1da5ec2fafd975@tipi-net.de>
 <CANz3_EYfcBopo=HgRioXkhoT6P+4WWpfFT7UeWkXd5eM_RNpSA@mail.gmail.com>
 <41c32f5a6f38ec9df8a79ce896912fb9@tipi-net.de>
 <CANz3_Eae-M6V9XROx4GqPB+BVjVWWuO5JqGoBOybh0-D7DNZVw@mail.gmail.com>
Message-ID: <365bd3473c9375d467663738f217ac51@tipi-net.de>
X-Sender: nb@tipi-net.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

Hi James

On 12.10.2026 02:54, James Clark wrote:

> [...]

> Sashiko wanted write_sts limited to BCM2711 because the 63.5 to 64.5
> window has only been measured on BCM2711 and we don't have evidence
> that it applies elsewhere. If it doesn't, then we could potentially
> violate what PTP_SYS_OFFSET_EXTENDED promises. I think one could argue
> that this is too conservative: clause 22 specifies 64 bits and the
> 63.5 to 64.5 range falls out of that given a free-running MDC and some
> other reasonable assumptions. Andrew made a similar point on 4/5
> (https://lore.kernel.org/netdev/c136b0ad-6d7e-4695-b988-55eb37550d01@lunn.ch/).
> Florian said he wanted a compatible string but I am not sure whether
> because of this or because of the clock. In any case, I am happy to do
> it whichever way you and Florian decide.

I'd drop the compatible. Gating on a clock on the mdio node is BCM2711
only in-tree anyway, and as Andrew said on 4/5, 64 bits is clause 22.
Florian can still shout when he confirms the clock name :)

> In the probe, I believe I still need to add a call to
> devm_clk_get_optional() in the pdata branch, which is used when GENET
> creates the UniMAC device. At the moment this branch does priv->clk =
> pdata->clk, so it would not pick up the new GISB clock from the mdio
> node. I think this new clock would live alongside the existing
> pdata->clk: the write_sts rate would come from the mdio node clock,
> but pdata->clk would be used for gating. I was not planning for this
> series to make clk_set use the new GISB clock.

Fine, I can do that as a follow-up together with Andrew's 2.5 MHz
default once the clock is in.

> [...]

Thanks,
Nicolai
