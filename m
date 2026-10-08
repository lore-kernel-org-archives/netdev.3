Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F0A04A5EA6;
	Thu,  8 Oct 2026 15:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474243; cv=none; b=cmnk7txzEtC2A7jQyhQRVfWKZw1DIknAi4F/QZd/l5TpbHojYRymjbQLhV6uDJ0Q586QW3MCUhkl63WiIgM0gLPR0XRh1YSed7TaqtqELxmNK+8hwIQMUzchp0UiQd/N4a6AeEGWWWIIJmI8pJx2MuleQEAEfPTuL8LMiD1McfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474243; c=relaxed/simple;
	bh=CocebfZlUvE2GLSSH1TzDkAlegLZA0uA6aFI2SwhH7Y=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSnVaCeFTduYImm6nhUVj1vI8buEuLcd9/etC9CmfNroPzcMvTYsLKw7Pm2pLqxpGaSDjEmG/OynNzapN2cIITGGxmHBSnCto1v+aK22cAsqbmtYHELmn/ekWzTP4HnwFeuAeG3KwpS0pgURKeYkXApp0XsZNXJ60BwSwLPm87k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VYKdvTAg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VYKdvTAg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567641F000FF;
	Thu,  8 Oct 2026 15:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791474241;
	bh=EAoEcgecpDgDmA8sdZYJnKiAg6jAe7b6z86kSORiHeM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=VYKdvTAg1ztQTuADalDMD0sLB04kX2Ly9lmCC86pXXHGs5oxva09Kso1HYCsaRdhT
	 lmS4kIiHJuK7H2345t75h+Zlv/zh8BHk3oir86k2/wfZNP4zfSUCO+riQbxSBfyaAO
	 8QvRqWNzTtyktUTstu9JvKUgonPdlc1Cj1hctpsMh72nZnf9rYCebMt8sHr1fswj1C
	 PUnvdUTew/4fWFtpLFln20WxxqctTYn2h05WMi7HrggroatQxed3Ret80V3PwitM+i
	 EbhgXKGSA9foh014w2bLUavHphiQhyrnYSXhr0EIj6yXe8JoM0QpSBdcLztEzSRLRE
	 29/rX41BqafTA==
Date: Thu, 8 Oct 2026 08:44:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Rosen Penev <rosenp@gmail.com>
Cc: netdev-bot+sinfo@kernel.org, netdev@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Michael
 Stapelberg <michael@stapelberg.de>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v4] net: phy: marvell: keep WOL_EIE across interrupt
 reconfiguration
Message-ID: <20261008084400.6decd936@kernel.org>
In-Reply-To: <CAKxU2N_k7YL+JmdgoQP_9hRne+Eg8udFyEjLOeiKUFuus0sfcw@mail.gmail.com>
References: <20261007182112.821061-1-rosenp@gmail.com>
	<179139748566.2527009.10663595607133766847@kernel.org>
	<CAKxU2N_k7YL+JmdgoQP_9hRne+Eg8udFyEjLOeiKUFuus0sfcw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Oct 2026 12:20:37 -0700 Rosen Penev wrote:
> >  - How the issue was discovered, e.g. hit in production, hit during
> >    development, syzbot report, manual code inspection, LLM or static
> >    analysis tool scan.  
> Tested on Helios 4.

The question is how you run into this, now what platform you tested 
it on.
