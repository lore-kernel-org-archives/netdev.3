Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A26725A354;
	Thu, 14 May 2026 01:53:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778723637; cv=none; b=q2N8dwiLWZYSjyT1SEFYQ7LeoOHDzS5puxjXXXyf46OX2rMPHViFQwsUsk5/n9ygJzsh2FkzzLkEpBFe430goDFEQWk2OrH3KbYTIX0kJePi7dkXZQiYxZQL86E9ihNDO010+RCRldEKP3Zy2O/nus2PN98pf4Wo52LZ2u9fWbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778723637; c=relaxed/simple;
	bh=Q1VpBQM50Yn3gZ371kogckumiz1tEUSOReWT97QXvUE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kfHh08V1P5Yc1u4yUQ3iORAkEwTQ7BAJA9Tl5qyznxfU2oaJNXyxIq2k38aMIOowqUMiuorsFHLF3MD00un1VOULds3qe77ANe/DfFPNRwEUyBSK0axjBRvFZNft1S8JgZUbOgoQ7MY/gcafANpA3+UKnloyAgkBd6QqHj+F/Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q3Ata02/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q3Ata02/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D38D0C19425;
	Thu, 14 May 2026 01:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778723636;
	bh=Q1VpBQM50Yn3gZ371kogckumiz1tEUSOReWT97QXvUE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q3Ata02/VEERalLaUvFCj6TCjwaPOownTlkECTxQWB3C4NtbHWKTMnQ3gABen+7kA
	 yTprbbdgliGsfqb5MFiQpJ1umq9JhN0LxVTdse2WJxd+3hrOUDinrG1xl6t5s0boZS
	 ipI9/RadHXALChuJOgvmux9PfHu+ZAAvXgBLbsy/mpyk+sIuH8C0+fFjkEba1EJu9u
	 OMsy3pfJEPCbgD4iNEBaCxfYZ/wbYlpHPWEAFfYc3SQJQRa9fYUJ8hrIffizOiU2cn
	 0PWxTbPC0AScp7am/KaPy5dmWT5x1+R40eia7lE8FN8TZAm+KEyl89NF+GffJABT0K
	 l0t8sqHXT46TA==
Date: Wed, 13 May 2026 18:53:54 -0700
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
Subject: Re: [net-next v8 3/3] net: ethernet: mtk_eth_soc: Add LRO support
Message-ID: <20260513185354.31e97941@kernel.org>
In-Reply-To: <20260509190938.169290-4-linux@fw-web.de>
References: <20260509190938.169290-1-linux@fw-web.de>
	<20260509190938.169290-4-linux@fw-web.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat,  9 May 2026 21:09:32 +0200 Frank Wunderlich wrote:
> +			mtk_rx_irq_disable(eth, MTK_RX_DONE_INT(eth, MTK_HW_LRO_RING(eth, i)));
> +			napi_synchronize(&eth->rx_napi[MTK_HW_LRO_RING(eth, i)].napi);
> +			napi_disable(&eth->rx_napi[MTK_HW_LRO_RING(eth, i)].napi);

What purpose that napi_synchronize() serve?
Also we don't charge for temporary variables, maybe save that
MTK_HW_LRO_RING(eth, i) to make this slightly more readable.
