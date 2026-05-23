Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8632F851;
	Sat, 23 May 2026 00:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779495276; cv=none; b=pD6XziQV26Y5NTahF/NkWdWKLi6c4HyClfoAnWer1S+gbK4WiWoMIxAhOAGGD1USnVkctSzzG4F3jcFReulN9hHKetlINcSJR+kvflykIWulcc1C7qbkm96p8BKzrebis/4ZWGgAVsirHlmb1R85RwuszMM8U/yJF9YLqkN8Grk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779495276; c=relaxed/simple;
	bh=XFnXSis1ga5gm9dioRrZCR2pty3RsSUFz3ZWeD/6G8k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t3daOx/1nf9h1WrxLFbdUbRJOinelcqE5CFjo693X097uoeMf7FWS9OU5OOqIGCt1HLHSTdpOX8FRFsyahah49HEtiPaGrDGMUl8RS6bAU5XwgTrbmk0F92YsD6UJeFH5E9Fjv1uL8oyP+F/204SC/6MKaCW8SXMjA1QKoLHUbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1AKYGRr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1AKYGRr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5543C1F000E9;
	Sat, 23 May 2026 00:14:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779495274;
	bh=j0t69r3bMCjdLkucDoEyqqnJ5p3iq1dWdpipyJtqdY0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=J1AKYGRrK7rSIpUTPdIi/XjmWL+uKkin+k/hblmq76sokDnQ+O1TTq5JlWxafLvgw
	 Jta7bMi4ZJsX6HZxzXP0uoTHDDEdzWmgR6W6yk2CSgYitGIrNKY7nZBA0RfCzNOvRi
	 ja1XoN/IPCwVz5fYtwFe1kg+H95Mg/r7Ob4ib/4BafFmM5hesg/ziuWUYetItwWUaF
	 bl2gx3OxaL/lSbXKAitPIEQXfgduF6lYr/hNdyo86oOmLrI6BlR8p50HWvjDeYuQa4
	 mwpLWqrZ/DtpgK65fldrxxn6oQvsDP6Jb5ceU1hr8Od4s8DwPDSuSssgyRdm6Kk5hu
	 erjhEoNG2dlTQ==
Date: Fri, 22 May 2026 17:14:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: weixiansen574 <weixiansen574@163.com>
Cc: netdev@vger.kernel.org, avinash.duduskar@gmail.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: sfp: add quirk for OEM 2.5G optical modules
Message-ID: <20260522171433.66a9c38d@kernel.org>
In-Reply-To: <20260520151629.905-1-weixiansen574@163.com>
References: <20260520151629.905-1-weixiansen574@163.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 May 2026 23:16:29 +0800 weixiansen574 wrote:
> Signed-off-by: weixiansen574 <weixiansen574@163.com>

A more official looking name is required.
Unicode characters are accepted FWIW, doesn't have to be westernized.

> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index bd970f753..6f3213793 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -583,6 +583,8 @@ static const struct sfp_quirk sfp_quirks[] = {
>  	SFP_QUIRK_S("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
>  	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-D", sfp_quirk_2500basex),
>  	SFP_QUIRK_S("OEM", "SFP-2.5G-BX10-U", sfp_quirk_2500basex),
> +	SFP_QUIRK_S("OEM", "SFP-2.5G-LH20-A", sfp_quirk_2500basex),
> +	SFP_QUIRK_S("OEM", "SFP-2.5G-LH03-B", sfp_quirk_2500basex),

This list looks sorted, and I'd think LH03-B is before LH20-A 
because of the number?
-- 
pw-bot: cr
