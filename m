Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD2D6339714;
	Tue, 18 Aug 2026 17:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787072779; cv=none; b=pdT+zvgb4TXIri/INymvvuv06VQhtAVtOPH5A+xlXpl65lxHgZwHjgQNKit0jg0d1G3GDNHXFOqR45e+4ooZ1zd2E53fvPKRqHqTBAZDSR47AEiCyhygnTQ4nli8k79Gm3fZP5mI4JWQZNVmid2YmyznSHSeJsMcAP6J2JR5Gms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787072779; c=relaxed/simple;
	bh=geO/1Yr88H/8xAIjkENqofNR/CYfMF82HkeF7HDvE2g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qu/OKDcKULryWgl5GusDISbu8v6QJnRv0DazyKBhiZT/Zv1wbrpL/k3i/cfXAQ0EpOdmb8ReuLIJHQm0tVoonmgMntjT1HPA3pA0wk8a2MS1wtgoeVzLpk1rBfTYoUzbTGbVrKj8jwSy1G4TDZO44Dg/DKI+2iSlSvULQpDl5BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C06FEfbw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C06FEfbw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFE9A1F000E9;
	Tue, 18 Aug 2026 17:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787072778;
	bh=PXlDYXG7iD2b/Vwo/HqOinSmHl4qk+QkDazEVxGzqR0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C06FEfbw+fxJwPHQRNqX3mtE3VeGL3DmjmQg5xXxipXlJep0jIWOmnAqJ8m80evxz
	 Ny9yxG4yXTR1OAxfH84xqperjRUawN345ylxAm2fp0JA2b7/Yf2f0caK0ULhp7cQ0a
	 yhLxleYwvpFj3mgYFLNRjcEXzuguyDjdRd2oLIgSLMVoONJjn9/BLfcYxae9NsAPHQ
	 KX4VBDk/cAoakb+wqQoxMJ4sDva+a4TvR0KNGmlDKITcE6Nyep2GH05QJJgJBAHntE
	 jBpc9sRHiO/yG1PJjQ/IZZma69ggamXCMaFBPSUKuh8z2i63oscZ1DAJn3BbrXnGwg
	 F3bfkRRr+zLdg==
Date: Tue, 18 Aug 2026 10:06:16 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ali Rouhi <arouhi@sitime.com>
Cc: "jiri@resnulli.us" <jiri@resnulli.us>, "vadim.fedorenko@linux.dev"
 <vadim.fedorenko@linux.dev>, "arkadiusz.kubalewski@intel.com"
 <arkadiusz.kubalewski@intel.com>, "robh@kernel.org" <robh@kernel.org>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>, "cjubran@nvidia.com" <cjubran@nvidia.com>,
 "Oleg.Zadorozhnyi@devoxsoftware.com" <Oleg.Zadorozhnyi@devoxsoftware.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v7 3/3] dpll: add SiTime SiT9531x DPLL clock
 driver
Message-ID: <20260818100616.41461605@kernel.org>
In-Reply-To: <20260815221919.64226-4-arouhi@sitime.com>
References: <20260815221919.64226-1-arouhi@sitime.com>
	<20260815221919.64226-4-arouhi@sitime.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 15 Aug 2026 22:19:23 +0000 Ali Rouhi wrote:
> Add a DPLL subsystem driver for the SiTime SiT95316 and SiT95317
> clock generators. These devices provide low-jitter clock outputs
> commonly used in telecom, networking, and data center timing
> applications.
> 
> The driver exposes all inputs and outputs through the Linux DPLL
> subsystem, supporting:
>  - Lock status monitoring via register polling or optional INTRB IRQ
>  - Input priority management for automatic reference switchover
>  - Per-output frequency readback from hardware state
>  - Phase offset measurement via TDC (time-to-digital converter)
>  - Phase adjustment for fine output alignment
>  - Embedded sync (esync) pulse control on outputs
>  - Fractional frequency offset of the selected reference
>  - Optional reset-gpios for hardware reset
> 
> The driver reads all configuration from the device's on-chip NVM
> at probe time -- no firmware loading is required.
> 
> Co-developed-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> Signed-off-by: Oleg Zadorozhnyi <Oleg.Zadorozhnyi@devoxsoftware.com>
> Assisted-by: Claude:claude-4-opus [chat]
> Signed-off-by: Ali Rouhi <arouhi@sitime.com>

Does not build on 32b x86:

ERROR: modpost: "__umoddi3" [drivers/dpll/sit9531x/sit9531x.ko] undefined!

please note that net-next is closed for the duration of the merge
window. v8 needs to wait until September.
-- 
pw-bot: cr
