Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3154A3866;
	Tue,  8 Sep 2026 08:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788857369; cv=none; b=mYUS3RQDDp428XirPT31uy9dOrhAXKLsT6PYDGdPf7msRpEojxYh9SdFF4i3lYAd5/ANSVqoTG6utyAHwb1BSt5SvfJUuxHdcSkHsYM0wEm9GYKQ1jJiGM17Hxdt3bwC1Bm094SsT5l+lWL39A3lejkhl5JiOVkAYjAS+4BRiVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788857369; c=relaxed/simple;
	bh=PFQeJIbTX8JBAIp6rzNV6zMDoYh0Nr7CbSnGpHlGoSM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dV+g0YcGsDtrcluiV95YZ2CabB7m3OouruLSZrNhcPkq2g0pMW3CNEUh4wlHHWQRU6iaSP9ff3riVN6aWqW6jsvLpbd9p/cGQ35WFsBw7ssNyj/cp55phmvC6TDjVFzxWteP4rmjFGTVakRRMet1eOhPYzo/eMmjdDJ+EsA1cO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Za0qhaVT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Za0qhaVT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70F871F00A3A;
	Tue,  8 Sep 2026 08:49:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788857363;
	bh=dE9rRwZnG7wy+FNbCUDTd+rt4SiIbzZl8SrVSqhT7tg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Za0qhaVToEDzllqVbChCSLXE5WB1iKgz+ynDZftVHGC/BPnKP8euNN8pErhFxlaLu
	 cHEky/zmqJKTEoHFGUbQ6esxUJqHuT0+Qb67FHr+ZAZojYH6qEOd5aKLg2oCTlpOAT
	 qro2T8ioUiSyW4eq3M7P+UDt6yPwgrTPasLZsl4HJkn3kibpWQepVGDtqshknZw64d
	 QyY6QeByxDFVpPJXmAOw6oOijNO9CtPKUnHQkJk+ZVmp6NhI8pVc91xXr6XcWOSgpZ
	 AO+7tS6hP6g8CFhaj/1KcwJs6mKoLXjIlpUTfzRu9cCqxcajolDa2NAicthKxyuwH2
	 hMENyrzZnIz0Q==
Date: Tue, 8 Sep 2026 09:49:19 +0100
From: Simon Horman <horms@kernel.org>
To: Bui Duc Phuc <phucduc.bui@gmail.com>
Cc: netdev-bot+sashiko@kernel.org, radhey.shyam.pandey@amd.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, michal.simek@amd.com,
	andre.przywara@arm.com, hancock@sedsystems.ca,
	netdev@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v5 2/3] net: xilinx: axienet: Handle optional
 IRQ return value correctly
Message-ID: <20260908084919.GM40544@horms.kernel.org>
References: <20260903073252.339250-3-phucduc.bui@gmail.com>
 <178880965410.219967.16945994924537630103@kernel.org>
 <CAABR9nHd-S-3MgTAZk=JMCDEkHjuHqwsE_9h+14tXdhvWdn_SQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAABR9nHd-S-3MgTAZk=JMCDEkHjuHqwsE_9h+14tXdhvWdn_SQ@mail.gmail.com>

On Tue, Sep 08, 2026 at 09:32:32AM +0700, Bui Duc Phuc wrote:
> > Critical: 0 · High: 0 · Medium: 1 (1) · Low: 0
> >
> > - [Medium] net: xilinx: axienet: Handle optional IRQ return value
> >   correctly — the patch carries a `Fixes: 522856cefaf0` tag and a…
> >
> 
> OK, agreed, I'll drop the Fixes tag in this case, since this is a
> no-op cleanup rather than an actual behavior fix.

Thanks, with that addressed this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>

-- 
pw-bot: changes-requested
