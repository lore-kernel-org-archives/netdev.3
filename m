Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD38B2AD37;
	Sun,  2 Aug 2026 07:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785655051; cv=none; b=cMRWWOEYz4fLGtaykNB/1cbtSa2MgYnnmDtUBJE8+MP/4wvJSIS1HtSr5muLA0cQGzaBvSdKtbHOuSq/glwJvhVrNgxQNPtxYUC1VM5cn740GfSZw5RY4EY/LMY0lumliVkhyfdOISbC2BOObUcHKtS3jgeUqA09/N5DbsfpjBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785655051; c=relaxed/simple;
	bh=1jlknHe4iV4oZoXc6mCfJiIKHeJdJfLrJ8iOS5mdCa4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Huh/UztJaYyRQeIXX4CcglzDSUdy18OQeAnme9RDn1GjeTl8gJK77Zs5sbJ3+k4PNQh+ljHmddRDiWkGxziBTJu7vEmhm7hoZll/uG7Nfka7ZbEPiSwzdM5xHJZNDMoGEtV7DTfqHFz45aykFVWf7rJzRbk/VruqA/lIOcVZsmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=emM1GUDS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="emM1GUDS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA31F1F00AC4;
	Sun,  2 Aug 2026 07:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1785655050;
	bh=VWcS08wYbUKTgtgDwKAVkzVdcWJ6o8TT8Tvh1zpGqQ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=emM1GUDS9vAsyRfHz/xavNPUVMKnxoptCON0BOYvmnCdxQgrLgE5sVPPlp81wz5aM
	 GDABB/zq4IhFPb1YXZ9dxbycLU+ZlJY5oRVHKuRgefCIvTIxr0WiT25GWPMD8tLMMz
	 rUVZmlFR0GdZB5n0rOOEAKFRVmlLhQYSPzopr7Mg=
Date: Sun, 2 Aug 2026 09:16:01 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Pablo =?iso-8859-1?Q?Vallesp=EDn?= Aranguren <pablopva014@gmail.com>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	open list <linux-kernel@vger.kernel.org>,
	"open list:TULIP NETWORK DRIVERS" <netdev@vger.kernel.org>,
	"open list:TULIP NETWORK DRIVERS" <linux-parisc@vger.kernel.org>
Subject: Re: [PATCH] net: tulip: remove xircom_cb driver
Message-ID: <2026080252-conducive-opulently-3bc1@gregkh>
References: <am48DR5FC-xTY3-D@ThinkPad-P15>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <am48DR5FC-xTY3-D@ThinkPad-P15>

On Sat, Aug 01, 2026 at 08:33:49PM +0200, Pablo Vallespín Aranguren wrote:
> A possible bug was found in investigate_read_descriptor() and a fix was
> proposed. Since this is an orphan driver for hardware that is old,
> removing the driver was suggested instead. This patch removes the driver.
> 
> Link: https://lore.kernel.org/netdev/2026080158-next-diligent-b4ce@gregkh
> Signed-off-by: Pablo Vallespín Aranguren <pablopva014@gmail.com>
> ---
>  drivers/net/ethernet/dec/tulip/Kconfig     |   12 -
>  drivers/net/ethernet/dec/tulip/Makefile    |    1 -
>  drivers/net/ethernet/dec/tulip/xircom_cb.c | 1172 --------------------
>  3 files changed, 1185 deletions(-)
>  delete mode 100644 drivers/net/ethernet/dec/tulip/xircom_cb.c

Acked-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
