Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B775635A393;
	Thu, 30 Jul 2026 01:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785375883; cv=none; b=XvrW9Wzl9/OCvUb2mkzlGICn/vv71ovXPW3YNCzltmVvBGTLgc9acSejXtzFao/7nPlGxWE/FcFQfVYMNRSS/FjYcPxy2YytgfW8tWm38FPQF5ouqtdJrz+SuBd8R7+GjUzU0iSDclfXxyrs1uPwjG+prMDiiWzq18DfFfBIFwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785375883; c=relaxed/simple;
	bh=Q/BylPwIh5qX6/OuCPiuft/CFLN0lzsNTz3li3F/psg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NhS4hm1AGpTNwMMVsHPljKxW1yH7cdUohvxSxGPCBRTKevhHJZelMaXPBFrXfFEheJfs5IC/F1roOrlZiJpepYbIKxQgrvpBWMDG0AOE5ILTVE9+PaDD1ICKLzhgInA2MRigqBZLVEBsZOzQxVkEhR9pxKgm+MZBDfV7rGlA6Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFcyLcQT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFcyLcQT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE7A1F000E9;
	Thu, 30 Jul 2026 01:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785375882;
	bh=hLDg/lOQfnHHDcmf98A5srZhKLIOaOoJ/RLfiAyjiFo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hFcyLcQTUVNOHTXuVoab1LHOar6vUpahKFtRrwXtVzGu+HqLHeGMMVnlO0MywAxM0
	 q2hqrpRhp3GOQbpkQgZaaE1NAj//OQnc35haTpfSI0teK/Wl2oNqw/XlDx2GA/8muP
	 Ko4T4247XaxIzUTiIN6rQXvVByziF47eDmVqjPfBLgCUUxyG46KUCM9S9KtcWKLAQ3
	 PbAEtj6vgjXuz7ZUmQeWSCL48J2zfU1S7A2ncZcMvtuoxFS2T7hZJngB0Gf4qsxWQb
	 Sn/q6ZODlSBtxcRoBsnRib+LCLErtZ7Qwek5Rkx3sxvhSzj0X6nentwzHeVk2vPY5m
	 /67psCDxD/mfA==
Date: Wed, 29 Jul 2026 18:44:40 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Daniel Golle <daniel@makrotopia.org>
Cc: "Chester A. Unal" <chester.a.unal@arinc9.com>, Andrew Lunn
 <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Alexander Couzens <lynxis@fe80.eu>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, Russell King
 <rmk+kernel@armlinux.org.uk>, Sean Wang <sean.wang@mediatek.com>, Florian
 Fainelli <f.fainelli@gmail.com>, Landen Chao <Landen.Chao@mediatek.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH net v2 0/5] net: dsa: mt7530: fix swallowed MDIO read
 errors
Message-ID: <20260729184440.0d67ce5b@kernel.org>
In-Reply-To: <cover.1785368701.git.daniel@makrotopia.org>
References: <cover.1785368701.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 30 Jul 2026 01:14:30 +0100 Daniel Golle wrote:
> While working on a register access cleanup for the mt7530 driver, the
> Sashiko AI reviewers flagged long-standing error handling gaps in the
> driver's read paths [1].

I just applied v1, please send a rebased / incremental series.
-- 
pw-bot: cr
