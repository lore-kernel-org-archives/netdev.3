Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7BDE388364;
	Thu,  5 Mar 2026 11:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772709416; cv=none; b=bl2TViaOVD8IjIZ2SC2dkU8QuL45N56Lrp3gv2JlI4D80leiqMvMvbJTTKneGXfKybUDtKevG8c/WonGcbGP1DxkGYDPzUt68gQ0cnDeIovb+MFfYgCP76Uy0fb7VKeY3YQkqkFGYxXAPjiMVOe1xrnhpDG2vinxQmsN4l6ftOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772709416; c=relaxed/simple;
	bh=wffDf4FT3dOwIOmwn2q6s5EPtLmLJobTvyH563mzxZo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=idW0N/XWwIb0bKldaBVfnkznGrHzYRfGCo+VyQcmwc6HFXkME4YbDiHCuzpoUfqkwdLhizzV7ijNyCT9Stf8aH1f/UyqKsmBInrgX3lTU9ONQXNPw5u+H/obCpKfAHFsgMBcFK3mie+L1EXWpYYrqxnVP1snOR+eUoPnBup1Co8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KIAwlwOz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KIAwlwOz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB4BAC116C6;
	Thu,  5 Mar 2026 11:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772709416;
	bh=wffDf4FT3dOwIOmwn2q6s5EPtLmLJobTvyH563mzxZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=KIAwlwOzmCYtZ3+VBU8vWrcD8bFqr1zYRlW3e7wDQKt5kmrbtb+hEmj/gWp/05WOj
	 lB0C33AgUEwkDFEjjdbB5ABDKBExpJOJDpv+y2+0oXVUXZom2FnO3zvZLuwy22pZh4
	 Iphcd/jQuBcykpMl/LvLB4jokqPs804F9B1db6xNbo1X+0l4Kdb2R99GclkWejKzot
	 rwAaaHhksYAoHzn/FKgbM0HgRevhqklvCcxevn7bUDNBn7zNAeqAzeCzDDjq9Iqd9x
	 ohaEGzE1LfC427KPqlK3Kvr9ravqbcLuEbXfIwgk3ADbRVjO8Z/Kew4jg6XZpC9Se2
	 13sF3RxHFZtYw==
Date: Thu, 5 Mar 2026 11:16:51 +0000
From: Simon Horman <horms@kernel.org>
To: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Alvin =?utf-8?Q?=C5=A0ipraga?= <alsi@bang-olufsen.dk>,
	Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Michael Rasmussen <mir@bang-olufsen.dk>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Mieczyslaw Nalewaj <namiltd@yahoo.com>
Subject: Re: [PATCH net-next] net: dsa: realtek: rtl8365mb: remove
 ifOutDiscards from rx_packets
Message-ID: <20260305111651.GC90938@kernel.org>
References: <20260303-realtek_namiltd_fix2-v1-1-bfa433d3401e@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260303-realtek_namiltd_fix2-v1-1-bfa433d3401e@gmail.com>

On Tue, Mar 03, 2026 at 05:25:12PM -0300, Luiz Angelo Daros de Luca wrote:
> From: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> 
> rx_packets should report the number of frames successfully received:
> unicast + multicast + broadcast. Subtracting ifOutDiscards (a TX
> counter) is incorrect and can undercount RX packets. RX drops are
> already reported via rx_dropped (e.g. etherStatsDropEvents), so
> there is no need to adjust rx_packets.
> 
> This patch removes the subtraction of ifOutDiscards from rx_packets
> in rtl8365mb_stats_update().
> 
> Link: https://lore.kernel.org/netdev/878777925.105015.1763423928520@mail.yahoo.com/
> Fixes: 4af2950c50c8 ("net: dsa: realtek-smi: add rtl8365mb subdriver for RTL8365MB-VC")
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> Signed-off-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
> ---
> I'm taking over the original patch submitted by Mieczyslaw Nalewaj
> (with his authorization). The original message is referenced in the
> Link tag.

Reviewed-by: Simon Horman <horms@kernel.org>

