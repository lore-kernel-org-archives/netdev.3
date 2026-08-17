Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB10028BAB9;
	Mon, 17 Aug 2026 15:42:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981351; cv=none; b=Cqu3wa1E++0MtPeTc+5GDJRdkHl/OXtC+gDoqiWvEja11NCHz8jmuD9/Lp/y3x8vwEvvqlWDX5OsF6F4xNj60jCE2VxmSSfPe1UkRhllKITS8ScCF5HNwhxco99tFPBhMppucoCsekc/otM/XTVv09AoYFsXk35wzo/OziGIPfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981351; c=relaxed/simple;
	bh=jDlSk8u2kol9t1hUHH0EVIijN2hs3ZcPPoaDGEvtCRI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XWBDAcU3+lgWeaHQ9cHETIyO9sy/d5ZGln4kcQ5HZXbqYirINzSvdEwjU5NeUrRtlIBnAxUxUog2mT9XC7CPdXMnLGouA+IUp83Ciz9LXLKW0L4eaKH8t03h82tyilYXz74Pd4FSc7ppjHlQRu/aojjS8RvIzDvsnLwdzQSshNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NLOPrDNw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NLOPrDNw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B3801F000E9;
	Mon, 17 Aug 2026 15:42:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786981350;
	bh=g6Ezqa2dO/9Dmog89bWC65voOH1LK7nETEJo4JkXH5I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NLOPrDNwAKy7N7zNCpj6yObRFmmM3rz0rjWFoasL4DTAnV5u3J43xmVBZ3AYoN6Cf
	 IJc8XciHN2zsdxVgaWvWpkNqmKtveIy5I4WbN6pl76un0tl/NanWSta6ofN1yjUJGD
	 iblDnWEdPaXs5dx4nhcFjQCFpGHMXFSZMOW0grxJDlStA8zZosIdqogV3yugPnyRrr
	 2QgYnM+hxWSj9D9Z5fEwjy5Yt4EePlABLothAheGRotdJTchS2wJDMli4Rq/jUHJcF
	 Dl9DFp6N1e26RzfsmCo45pNojSqEz6mt+V7CxKPLzF7yO02m+e1TNWB5Sp+/sIX1c9
	 bp5d56b8s2NDA==
Date: Mon, 17 Aug 2026 08:42:29 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: dinguyen@kernel.org, maxime.chevallier@bootlin.com,
 rmk+kernel@armlinux.org.uk, krzk+dt@kernel.org, conor+dt@kernel.org,
 robh@kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 4/4] net: stmmac: dwmac-socfpga: Add support
 for Agilex5 TSN GMAC with FPGA converter
Message-ID: <20260817084229.56655607@kernel.org>
In-Reply-To: <20260817030213.6769-5-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260817030213.6769-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
	<20260817030213.6769-5-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 16 Aug 2026 20:02:13 -0700
muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> Subject: [PATCH net-next v5 4/4] net: stmmac: dwmac-socfpga: Add support for Agilex5 TSN GMAC with FPGA converter

## Form letter - net-next-closed

The merge window for v7.3 has started, and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We will only consider applying net-next patches which were posted
before the announcement:

https://lore.kernel.org/20260816155953.072d73da@kernel.org

Fixes are obviously welcome at any time. net-next patches may be sent
for review and discussion only with an RFC tag.

Please repost when net-next reopens.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer
pv-bot: closed

