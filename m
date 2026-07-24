Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D80481FCE;
	Fri, 24 Jul 2026 23:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784936943; cv=none; b=UsIwSbcqwbQvgeUd+YL04f9t+ZcGcfsIR2cKDk/DgLbdygl/Hl39su0o87R0kb0UjGlm1V+Caa4Bg/Jh5PyTKuA3vogBTns7OQZf6idkTEdtBPLFnwrd0GJYXuTcD+X8dUcE6CV0O74HS9yFwDYlrzW62fr0vSC7lkuLbPG2Dnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784936943; c=relaxed/simple;
	bh=f36OJJDT1hLLfotiFBLNqP+ObqaF2oHvDBLUGAsLRh0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RqVbVaeZhq1AwIXBUD75oA9yIVgPRT8kMBYf/D2AnopFeophjJyQnooh6owvxM8fYKqZgSUflj+xEhIQjM87VxR9193gLoJDIwqP0+IRFZtie8tYYWYa+LnIT3hmEMywhRwlvly5XW+jfHiK+kmcrWC1Ox1JlJGUMZz8YU9UTeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O0ZjnZkU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O0ZjnZkU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3CA751F00A3A;
	Fri, 24 Jul 2026 23:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784936939;
	bh=AqKuj0HwlEdDwSOzn2VjliWKxWpCEy+aNo9N9G5cUUU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=O0ZjnZkULRdiZso1sXw9HC9P90fSaJ+Kvkr3yPHqGbYptrMpdm+QqeItiZz8yAvAr
	 SAtsX/Lt0e9dOXFzoZ0BBxfeF4GDjT3/DocW7yXc/mGYtltfYfdsOFLfl1YReTWC7f
	 /7tW7CTGXi5pu6OahXKuMRRgajxsZ69pdmV12vkpdhRmbHRlZ+OXnNQXle8L5mmoqS
	 qk3qqlTjThULSNzrLqb2L+rDgNC9JVUpPa78jh6wpHJzf8lt6j5Qvp1w314SzPiO3I
	 FcIUtcd3w5EtkmLe39xjy55LLcVFz6DteuuD58AdfmcjLI0g09lql3bgRCwucC0df1
	 impOOnRCbx+eg==
Date: Fri, 24 Jul 2026 16:48:58 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luke Howard <lukeh@padl.com>
Cc: Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Vivien Didelot <vivien.didelot@gmail.com>, Gregory
 CLEMENT <gregory.clement@bootlin.com>, Andrew Lunn <andrew@lunn.ch>,
 Richard Cochran <richardcochran@gmail.com>, Cedric Jehasse
 <cedric.jehasse@gmail.com>, Kieran Tyrrell <kieran@sienda.com>, Max
 Holtmann <mh@rme-audio.de>, Max Hunter <max@huntershome.org>, Christoph
 Mellauner <christoph.mellauner@joyned.at>, Simon Gapp
 <simon.gapp@gapp-audio.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v3 2/3] net: dsa: mv88e6xxx: embedded PTP
 timestamp support
Message-ID: <20260724164858.4581408e@kernel.org>
In-Reply-To: <20260719-mv88e6xxx-ptp-fixes-v3-2-161386ac8a62@padl.com>
References: <20260719-mv88e6xxx-ptp-fixes-v3-0-161386ac8a62@padl.com>
	<20260719-mv88e6xxx-ptp-fixes-v3-2-161386ac8a62@padl.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 19 Jul 2026 15:30:54 +1000 Luke Howard wrote:
> +	/* APPEND means the switch appended the time stamp as a 4-byte trailer
> +	 * (not all switches support this). Any other non-zero value is the byte
> +	 * offset past the start of the PTP common header at which the switch
> +	 * overwrote the time stamp in place (e.g. the reserved header bytes).
> +	 */
> +	if (arr_ts_mode == MV88E6XXX_PTP_ARR_TS_MODE_APPEND && skb->len >= 4) {
> +		if (skb_linearize(skb))
> +			return false;
> +
> +		*ns = (u64)get_unaligned_be32(skb_tail_pointer(skb) - 4);
> +		if (pskb_trim_rcsum(skb, skb->len - 4))
> +			return false;

The append mode would extend the frame, and possibly run afoul the MTU
on the conduit AFAIU? Since neither implemented chip uses this it's
both dead code and questionable. Let's remove it.
