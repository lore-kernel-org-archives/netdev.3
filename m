Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573A72C0303;
	Wed, 30 Sep 2026 20:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790798763; cv=none; b=q9bcXSn88sOfSMIqEwzop0k5xu7NYyy7/WmJrzHi7iWinEquV1MtMaOp/AkYoZEPSlnDYaGk06JqXVq+LqESRf0K8vY038724Q1fxUswHzGk4X4TwsDd05AKVkVJMUyAlODsNXT8/eAQKTkoDmSScu5C63fd5eCWIwf+MI4VvFo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790798763; c=relaxed/simple;
	bh=Hw+TZ5jKsW0oWyrNgiA3s8w+iHdTPag1uRGzaEnTf4c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbHD0HyyM+K+JK1cxsK/baMqXmX20YjtEpEmlwF/QXNnk8NVA1k59idt7uGnZwhIeHiQZX7K/YOYuA1KH2PO0QrjGjKAi76WvPL+PgVIAHJp9Pi+ZKue9HPHecVtt6OUrR2JKu1gmRcUJmaUxZCVV3KcSXZdqmg4C+Gq6y2f0Ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i68c/lqL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i68c/lqL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51E71F000FF;
	Wed, 30 Sep 2026 20:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790798762;
	bh=zpJEc90Wl5bVnYdB/HuZUcLE7YTrN2y5wMacSDj6/dY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=i68c/lqLbl5+TfRQmP3iQfb4FShI/UMviQEPkCvW7Z67mCl2Y/eu8N9Q/bUQEvt4p
	 BxGG8/pceVjvz93NUgbdtmUuC2novpo94SdovAgs3A6nCW0DxA2NHPrZtKR/IciB+2
	 YlyjspH6SWnLgZ/aKef2B9lMNMyKGduvlTxA2uTNPdsf5KmqirXWg0JnkjgXUaQEc6
	 5UD6nSNocGVzog8zUXt7X4Zi/mWV9HdsVzP1MYDIvMuYnhnaBG5PJc6YeQ40+V4CH7
	 MfgQBijmwip6bovBTteFaKIIFtWs3JGd1h/AUKn2Mv18BcnyrKWem1330cnuddQSzj
	 HglDESN7JrUUA==
Date: Wed, 30 Sep 2026 15:06:00 -0500
From: Rob Herring <robh@kernel.org>
To: netdev-bot+sashiko@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, krzk+dt@kernel.org,
	conor+dt@kernel.org, shenjian15@huawei.com, shaojijie@huawei.com,
	netdev@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] dt-bindings: net: Convert HiSilicon hns-dsaf to
 DT schema
Message-ID: <20260930200600.GC3971425-robh@kernel.org>
References: <20260925215848.2949157-2-robh@kernel.org>
 <179072083746.434549.9632212557416686292@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179072083746.434549.9632212557416686292@kernel.org>

On Tue, Sep 29, 2026 at 10:27:17PM +0000, netdev-bot+sashiko@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 5 potential
> issue(s) to consider.
> 
> Critical: 0 · High: 0 · Medium: 2 · Low: 3
> 
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwork
> know by including "pw-bot: cr" as a separate line at the end of your reply
> (one such reply per series is enough).
> 
> - [Medium] The schema leaves out properties the driver needs and drops
>   value constraints the hardware relies on: (1) 'buf-size' and 'desc-…
> - [Medium] The 'reg' description in the new schema (lines 21-33) gives a
>   fixed four-entry positional layout: [0] external interface control…
> - [Low] The patch deletes
>   Documentation/devicetree/bindings/net/hisilicon-hns-dsaf.txt without…

Fixed in another patch.

> - [Low] In the new binding, the port 'media-type' enum (lines 115-119)
>   allows only 'copper' and 'fiber'.
> - [Low] The schema example (lines 135-142) sits at the top level with no
>   parent bus node that sets '#address-cells = <2>; #size-cells = <2>;'.

Fixing the rest of these.

pw-bot: cr
