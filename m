Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC533313E21
	for <netdev@vger.kernel.org>; Thu, 24 Sep 2026 14:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790259907; cv=none; b=cyAJAvhFKvxY3Qzu0QdRwDiz5coY0eVGY4ADWuMrILsHm89ur5Hi7KPrjQouibtFWUVyb+7aK1llvFIb4j0HKz2QNWdY6BrEWx+nCkEobXwLOsnnDf5QgaOrN9rN5xkf2ZF8ibCmzizour6AKp1a3wOzBcyncwZ7JPUdwmgIih0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790259907; c=relaxed/simple;
	bh=qsUMrcTbx7AzE7Cx0wiAEtx6nDP6qPcZfvfJgKjkltg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K3RSMhzTnAEpiQ1QVe5+gxL9ObaMdl2d/fVQ+uQ2P4krVDBXhrDF0Jga6OVX3crDfRZS+eLx605mTGyV90TtUqRVbHpLcZinCpJdFIfEM29A0E6/1V7j2EY8XaFzOyG6RyJycQCTGR7tL6WaGqXxlUPnxvPVlTOPUgoEA9yoB8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=qvsfgB6D; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="qvsfgB6D"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=vzxYF72Anq2RNU8Kfq+XdWIj8YQSevVbIiXGNGsPrNw=; b=qv
	sfgB6Dgk9DG7oVa7oM7Q9CZZq7b/9kNFVGPbmrpGu3TVnJw/5mmwpdxIbgz+O0LfWZAfO8MU/uvep
	OgI/e/IIlnC1zxgg4Kyq3724mG1KL2nWQFqGeS7jhB9kaMc2K7ZukSgK3zByfyGcxSao/4Bf2yrXv
	4CVHkOt8VJCyZ9U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9kNh-0070gd-FT; Thu, 24 Sep 2026 16:25:01 +0200
Date: Thu, 24 Sep 2026 16:25:01 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc: netdev@vger.kernel.org, Russell King <rmk+kernel@armlinux.org.uk>,
	Marcin Nita <marcin.nita@leolabs.pl>,
	John Pavlick <jspavlick@posteo.net>
Subject: Re: [PATCH net-next] net: sfp: ignore LOS also on Hisense GPON
 modules
Message-ID: <099ef2ac-a9d0-41db-9356-65205c79c21e@lunn.ch>
References: <20260924115055.196631-1-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260924115055.196631-1-kabel@kernel.org>

On Thu, Sep 24, 2026 at 01:50:55PM +0200, Marek Behún wrote:
> Similar to commit 87d126852158467a ("net: sfp: improve Huawei MA5671a
> fixup"), in order to be able to communicate with the module for
> configuration even if the fiber is not connected, apply also the
> sfp_fixup_ignore_los() fixup to the following SFP modules:
> 
>   Hisense-Leox LXT-010S-H
>   Hisense ZNID-GPON-2311NA
>   HSGQ HSGQ-XPON-Stick
> 
> Note: tested only on the Hisense-Leox LXT-010S-H module, but applying to
> all three modules, since they were all added in the same
> commit 95aca8602ef70ffd ("net: sfp: add quirks for Hisense and HSGQ GPON
> ONT SFP modules"), which says they are all based on the same chipset
> Realtek RTL960x.
> 
> Signed-off-by: Marek Behún <kabel@kernel.org>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
