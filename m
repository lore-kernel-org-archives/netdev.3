Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FFB39A807;
	Mon, 17 Aug 2026 15:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786981125; cv=none; b=TxkrVfgF8yCOdW0rBhZupIQ0CfI0SP7vaxXOT2QAfg52VKO/CZYZP6OfVKkD9EEHH8Utkk5MSZGnEmUzCx4o1akIY7706GXwnu5t3sg5q3HKWq1jPJuSBDTEmOGPGrHaBcs/165Ds7JNBlr56NEz3IsPPCIPOBAMWxh2jkJCm/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786981125; c=relaxed/simple;
	bh=yBMi91dBD+AvK7Q8kwcMYptVT5sh4MlwOiUU7JIszhA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qZcUA681XW9vrzwtHNXryE8JzZmRHr6lWU9vyakWqK711phkxjIQn/vhGO3+80uH4psB/XV0igh33c4HD32/DaugWhels0DDRGrHBMeqi8/zTVeK4AdfWbRApbBpUpvn9FNshIRc+Q/hP86VlOYlinCt9J+HGVXttFG9+kyi3Bw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cs1GQ4lh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cs1GQ4lh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC3131F000E9;
	Mon, 17 Aug 2026 15:38:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786981124;
	bh=4DmfPql4Th1/vGMYBr32DIZj6vWMe6ET+S2DBK064HU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Cs1GQ4lhenmtLERGetrlLm8k7B7iCtyZCHfMgAdMXMfkB3Os/bImTxpKNa10jBohw
	 s/OTAwSFCcsRi/tha4PZGLrlAkZ3tx3nsAIGFxwZNMdakiXMk/zns7cPsnZOWgjk9R
	 NMflDRPkx6t+B9zz479DHK60b+uA3jknk8Krl/73Cc1DWRqlrr66Ymo0YZ1ljBGDM/
	 pHl/dOsm12cPJH2rqOLYvujCLys0nwVXYnapK6/c7w6BCB16yP+hBm70by4NsDTODU
	 fppVzzPAosh6D/K0dgCQ2Hyk5IeakDk0LqHo6AuZrnO76N6HsKyXGTikvZiEockVuX
	 a5Pi14xUCxUIQ==
Date: Mon, 17 Aug 2026 08:38:43 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, dinguyen@kernel.org,
 maxime.chevallier@bootlin.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 1/2] net: stmmac: dwmac-socfpga: Enable
 multi-IRQ when per-queue IRQs present
Message-ID: <20260817083843.219a0f45@kernel.org>
In-Reply-To: <20260817074221.27459-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260817074221.27459-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
	<20260817074221.27459-2-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 17 Aug 2026 00:42:20 -0700
muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> Subject: [PATCH net-next 1/2] net: stmmac: dwmac-socfpga: Enable multi-IRQ when per-queue IRQs present

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
