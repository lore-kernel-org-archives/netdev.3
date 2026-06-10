Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD04226ACC;
	Wed, 10 Jun 2026 00:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781050672; cv=none; b=k9evkQa/2VCuu7kK6dMZkpFM/90Pm+l+XE3B3OGusai8sb+EJw+3pLJoE+0ST9WtVNi/NdTk7XVlLsebuopUNZK2fTYVwnaqTvdg/AdnYbdCL9n6irY5zveXk3BGncDSrk1RP6gQZhYZAfEqDrWEl3MMWGkhJgb6Xo0kgp1+jyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781050672; c=relaxed/simple;
	bh=2X3adUZBt/OsiwFj67H2fjX+z3gaGYoliU4kJoBwcMY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7+OJMK0ozv/jQuAdvGM1vSxoFOQx1mePi7hCaTAeO2Vgf3Rl/Oo9Y90JiMVCqK8PTlCvir9s2J42N0/gFDfCdXPTfEeZZ8ci7OqrcInUvmpdFfV7asSlSkzZxul5PDn2r8NojfowZX0daYsx2yztNgNjGxVlz/4njyf2Qb+stE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFtZ89aW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFtZ89aW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D3991F00893;
	Wed, 10 Jun 2026 00:17:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781050671;
	bh=kpEtiFrBEIM+OcxmfyVtuRseNKwhQK6Li7jNDIkmsk4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=mFtZ89aWwYePdEMSZCIYhqOArs44ygPvWB3tdzkh33PvIxn5Aam8KArGCmpQYJplW
	 HK3TYSwyj6Nqzpz/JWe2UWE4n65n/MThJmxsCGFn4Yz8au7hPcaTj5q/6TXHd4101o
	 xtp2nGMRpzqEkkB6785g2Knv4wZz4PI7L0g88up0xmcdA3tyuf6b8Z2OdmlDBftHej
	 U3vxKyg1ajRId2ejVTWRY1/M5g8qcFPR+VjCrSmvBzcLDnh7IrGg/qE9DVqo9XzqHo
	 oRcFiGsy7O/BUyLdAvV6rl8HGAJq6LNbG6QisoQu4CsYbBc8blhbCBtlkPtHxkrNrR
	 wY3sVt13NilkA==
Date: Tue, 9 Jun 2026 17:17:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: muhammad.nazim.amirul.nazle.asmade@altera.com
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, mcoquelin.stm32@gmail.com,
 alexandre.torgue@foss.st.com, rmk+kernel@armlinux.org.uk,
 maxime.chevallier@bootlin.com, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: ethtool: mm: Increase FPE verification retry count
Message-ID: <20260609171750.7c5709ac@kernel.org>
In-Reply-To: <20260605025631.2872-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
References: <20260605025631.2872-1-muhammad.nazim.amirul.nazle.asmade@altera.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Jun 2026 19:56:31 -0700
muhammad.nazim.amirul.nazle.asmade@altera.com wrote:
> The current FPE verification retry count is set to 3. However,
> the IEEE 802.3br standard does not specify a fixed value for this.
> A retry count of 3 may be insufficient when the remote device is
> slow to respond during link-up. Increase the retry count to 20 to
> improve robustness.

You need to CC the author / expert on this code, please repost
with the CC fixed.
-- 
pw-bot: cr
