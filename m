Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F259340D59A;
	Tue,  7 Jul 2026 12:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783428347; cv=none; b=umgjrL70xv25p1qWAa0nzKUz/Knf9a57GYMR1cvmDo2dEmLyF51dPZ519zrveyKedBJAJdezy5vvlp8olm69cKb4lYxu3KSgw492iDgPxUJELQuIzJrxv5tGScNGnzXCyryWQWwbHqMSMwQ8v4s9peoIf2w1OufDkPlzK6g3Hkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783428347; c=relaxed/simple;
	bh=XFfQmN0CR0B0YbJYL4Ef7WNAtqRwWo3Zzren7nRpPBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QXGhIm/yvzIL9BJ+BHF5SQPwoOScgh0cxILJmbASledTN08EkZ2jqurvg9Cxxj6Ih4Sem0DLCts6F6mNciY+rmGwJmPxy5rGezzcgAOmMxkkR4/+2qUxnmW+3W6lKK1isL3wp+freg6yjwtabXMsjKOhQxLRD7K10qNCbOuHiLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=NtgCOLV2; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="NtgCOLV2"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=MvFK766ptEP7zJlMpnqJQ0glv+bGUWfEWjxmlfWUuP4=; b=NtgCOLV2/9lu413W8fu9vLfwnq
	MJbVyUzeJs+gLBHp/oUvRIcMCYn0awZKiF9Pge2yubK/cevoUqcr6tHGpIP7Fnz3mpW2x2TNNE/gJ
	cCTqnkipNgNthrjGeF32c1SnjVREq+6T9cxCRI6HWF99QkE90ni/s1S9vLCciQEIHhB8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wh5B7-00BA6I-HS; Tue, 07 Jul 2026 14:45:33 +0200
Date: Tue, 7 Jul 2026 14:45:33 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Louis-Alexis Eyraud <louisalexis.eyraud@collabora.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Biao Huang <biao.huang@mediatek.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	maxime.chevallier@bootlin.com, rmk+kernel@armlinux.org.uk,
	kernel@collabora.com, netdev@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com
Subject: Re: [PATCH net-next 2/6] net: stmmac: mediatek: add PERI_ETH_CTRLx
 register offset in platform data
Message-ID: <3e135fe0-4ef9-45be-a962-d131c8a2e9e0@lunn.ch>
References: <20260707-dwmac-mediatek-mt8189-v1-0-17f345eaaca3@collabora.com>
 <20260707-dwmac-mediatek-mt8189-v1-2-17f345eaaca3@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260707-dwmac-mediatek-mt8189-v1-2-17f345eaaca3@collabora.com>

> +	.peri_eth_ctrl_offset = MT8195_PERI_ETH_CTRL_BASE,

nitpick:

Could the naming be more consistent? offset vs base?

	Andrew
