Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76297285CAE;
	Fri,  8 May 2026 22:37:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778279824; cv=none; b=KAp/Nfxc4gf3tZt7YbclsVdlbk4lkqdq4N1lSt2YuBvSeVbOMxHgehtvM+S10JOX7TdC/1aIwSbe0fl65YMVpX+Pv5TZRSDOA5w/96Cwih3EuGuei233jN8LDnp2ft8Hoy/21P1B+3ZnApt/tsBqBBIRLdtzLM6vhfUu/qMJQGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778279824; c=relaxed/simple;
	bh=doWXpAV8i1KIsPVSpwySS7aiXUQtAtR9+ap1JLqiNmY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSCv8sd6VdhPtPlbsc/xVEWDBrQP9d7yzqAQ4vmtQXT8pbhKahLGYghRy7lzfoko/gtMzb646wVxmILdBYmmRZhcCdfEV2wdoy63E1h/6Gp+6XG9E38R9m8GycmHfk62mghxTwXwXD/n9BxkUb+B/JVQPH1pdDHumnPjj+RJdzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXG85BpP; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXG85BpP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58AB5C2BCB0;
	Fri,  8 May 2026 22:37:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778279824;
	bh=doWXpAV8i1KIsPVSpwySS7aiXUQtAtR9+ap1JLqiNmY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nXG85BpPsxRXtTy9vRquN4aUado99x7u/EAuFTgMICFe+wwITf2rfcVrYZgAwlYya
	 Mxy4a2RZCeIctfJAwSRe8W2bhDgn79oPsVSdbGG+Pygl/yXbYVRJ8gHhO6TaHl/4no
	 B9PgioG6LhM1bT4qyMVEUCU8FkaCHv9N959BnZLI903mRcw/uhTnM2YoGPrP7XYK4l
	 5dLH4A9DVNHAze0vKfR6FttTjSVFm/cfddtjE9p85vol/yodgVTNfqw2p6xNHX0btk
	 APfG6Y8z/NZzpVCZ5S1qtUXva0YGZUcXb1gix9GmLarkB/L6SFNKFx5+vFD1rCDKIl
	 fI643HKC3DtaQ==
Date: Fri, 8 May 2026 15:37:02 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Frank Wunderlich <linux@fw-web.de>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Russell King <linux@armlinux.org.uk>, Frank Wunderlich
 <frank-w@public-files.de>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mediatek@lists.infradead.org, Mason Chang
 <mason-cw.chang@mediatek.com>, Daniel Golle <daniel@makrotopia.org>
Subject: Re: [net-next v7 3/3] net: ethernet: mtk_eth_soc: Add LRO support
Message-ID: <20260508153702.69b89021@kernel.org>
In-Reply-To: <20260506192806.143725-4-linux@fw-web.de>
References: <20260506192806.143725-1-linux@fw-web.de>
	<20260506192806.143725-4-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  6 May 2026 21:28:03 +0200 Frank Wunderlich wrote:
> - fix u32 vs. be32 reported by patchwork check

Have you tested this? I still see an extra sparse warning
(install sparse and build with make C=1)

It'd probably be good to fix the pre-exisiting warnings as the first
patch in the series while at it.
-- 
pw-bot: cr
