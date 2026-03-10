Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 258893C344C;
	Tue, 10 Mar 2026 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773166100; cv=none; b=CfEMwz82JXOb5N92copDtHwAkVvSfsd1FTkEp3lL0DuJWCGgvZJINUyogyat6mzFiaf0Kiwgv27jrmxMx1wEu3oIOUc4fwpAwAci0LNAYeYCLlENuHK1QSTama9FItP1ZWBjo90YNJ9TrFgKFJPkX/Ffk5ik73UX5fHJhwQSXdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773166100; c=relaxed/simple;
	bh=9TEA36UZnGZhsqp6aaqGfEB0TcVYWyEKHcKIM8n7B6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mVCZvxr0fLzLJAmWlZNeHiRBidH4qURFIUq2nH1NJbmsbR3pGXyR3W/VJHoi0BNTyxXbzffaEzlXFe2mTgQ6ygz1QG+LPOdB0kGi+WsvYiuTKhca9cdIb2wYgdvlUzd11FUFa3EjdHtTV+oNf60HVtQ5gGo1w51aL7kGo2Tc9OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g2vEA06Z; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g2vEA06Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AEBC19423;
	Tue, 10 Mar 2026 18:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773166099;
	bh=9TEA36UZnGZhsqp6aaqGfEB0TcVYWyEKHcKIM8n7B6A=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=g2vEA06ZGMjQRvmNK2JBW2pmACYF5k3xRMJVuUgTPwedDVc23aWTSmikWBBhsaLex
	 eh4PnDfX76O4GlohlRPt0XuAxwfz3SN1MkyCYjqeB6L+tSPKWxRTZyyjG2NRWet/9p
	 GmdG1/UXaKEZMEaC3ITn6WJMoEtAfjpBrAi8LHe8r/4dl30i0JwyysHOZrI5iRwHoQ
	 IA0MqnpQ1ufPPOjqWO1QjgZTdj5QePA6+Im5aH4hG+NKDtkk2NjJxZNHA8BLm1YLRM
	 LBC76CvdAbB6XjiuI7TrUQDtSlaP+9C06PQhMVqAKVXqYMPhYai8+8hkqtcSh9JgcW
	 2gl5hMwN07fbw==
Date: Tue, 10 Mar 2026 18:08:14 +0000
From: Simon Horman <horms@kernel.org>
To: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Pascal Eberhard <pascal.eberhard@se.com>,
	=?utf-8?Q?Miqu=C3=A8l?= Raynal <miquel.raynal@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: Fix error path in PTP IRQ setup
Message-ID: <20260310180814.GA899930@kernel.org>
References: <20260309-ksz-ptp-irq-fix-v1-1-757b3b985955@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260309-ksz-ptp-irq-fix-v1-1-757b3b985955@bootlin.com>

On Mon, Mar 09, 2026 at 02:15:43PM +0100, Bastien Curutchet (Schneider Electric) wrote:
> If request_threaded_irq() fails during the PTP message IRQ setup, the
> newly created IRQ mapping is never disposed. Indeed, the
> ksz_ptp_irq_setup()'s error path only frees the mappings that were
> successfully set up.
> 
> Dispose the newly created mapping if the associated
> request_threaded_irq() fails at setup.
> 
> Cc: stable@vger.kernel.org
> Fixes: d0b8fec8ae505 ("net: dsa: microchip: Fix symetry in ksz_ptp_msg_irq_{setup/free}()")
> Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>

Reviewed-by: Simon Horman <horms@kernel.org>

