Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C47B3B6BF2;
	Mon, 11 May 2026 08:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778487427; cv=none; b=a6g+AFuslXcCEORr5nwmz0AiODbS6szg1xr7QggdM0zwsOlLJPpdYg2334b/t6uDzhpDAe6AG3C0vW4EpW7hGstwqhw3u49DtPi3Q9vZkX84EQcYwuN7ftEGQUdOPOAUBtAnegQEL6Sil1gICT1/4TDmwrAR15PHyJzXq5jIMks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778487427; c=relaxed/simple;
	bh=KPcJ5hXTrwKnBFSf+/D3W3X1RxZdjdwGOBGpUyeY9+E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q+KlNaa3kI5MVloT/4bPQQ9oW6Iz1SNGenItwuIx6uz7CbRMecbqqMdUJHzy2du8zh2lpVZv/1gm07VIcJ8cVQ/r/WlEOBeHzNW4BdImMYwudn5SLfPoEbt/+oUnPXwa/vWn3b15BYftQJ3WAzCbRh9lFramwpWIiuuYfjl3jhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rVobUHTG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rVobUHTG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AB9EC2BCB0;
	Mon, 11 May 2026 08:17:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778487424;
	bh=KPcJ5hXTrwKnBFSf+/D3W3X1RxZdjdwGOBGpUyeY9+E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rVobUHTGza6GZfg8w0UTZAMczYbMPQch/G+cyMGhEw7IXFraKAnGZANTLqWXuL0Zf
	 2FyPwogC9dBiIJlQRlKNcE9Oipc2KvfuFWb8IXDATI2CV4gpSkdeH/xhtVFLIkOVL2
	 NSgPzgiQZ90w1neSUehMWCn+yjRK5T4sZXygWOlo=
Date: Mon, 11 May 2026 10:17:02 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>, regressions@lists.linux.dev,
	netdev@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
	Jensen Huang <jensenhuang@friendlyarm.com>,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: Re: [REGRESSION] stmmac: Random DMA reset failure on RK3399 since
 v6.18
Message-ID: <2026051154-region-handcart-09b6@gregkh>
References: <CAMpZ1qEwNOqR-KQD4kEqd93aB-TpHnG6WdQc2tXUF0aXMmw_SA@mail.gmail.com>
 <198e2ce4-07e1-46c0-818d-1eb18645aca0@leemhuis.info>
 <CAMpZ1qGEOiPj7cApnWJnojSyEpDmXfco=No5n1VfyTCoNyCyFQ@mail.gmail.com>
 <5308c658-7d4c-4292-b091-a51546ea4d23@leemhuis.info>
 <f07da4c5-cdb9-42c8-b4e7-f5122254ed8a@leemhuis.info>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f07da4c5-cdb9-42c8-b4e7-f5122254ed8a@leemhuis.info>

On Mon, May 11, 2026 at 09:35:37AM +0200, Thorsten Leemhuis wrote:
> Greg, Sasha, could you please cherry-pick c171e679ee66d7 ("net: stmmac:
> Disable EEE RX clock stop when VLAN is enabled") [v6.19-rc1] to 6.18.y?
> It fixes a regression for Jensen Huang (for details see below; it was
> later confirmed that c171e679ee66d7 really fixes this) caused by
> dd557266cf5fb0 ("net: stmmac: block PHY RXC clock-stop") [v6.15-rc1]. tia!

Now queued up, thanks.

greg k-h
