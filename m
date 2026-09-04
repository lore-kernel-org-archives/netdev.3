Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F4C33EB10;
	Fri,  4 Sep 2026 13:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788527804; cv=none; b=l4Qg4WoYnh2CN4160BjG98fOXzV8L5PK8NLyuVZE99j/L23iK3O9gTxNYLFIo7ELS+ofM46OtR6P7P2yAomInpolFsfi9yIfrX+lRUGsoQq41TTq7b6g4Rc2Ru2s0vjoVZe0SEXoZmdM52G8scVR7fngqhvixf8b07AcYGnlFj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788527804; c=relaxed/simple;
	bh=PXttz18TTOR2r5zGg3fXbPD/kA6aVtR4qOElKaLdAmk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1snxykLOlgMql3/uMLHovwP2kUUot/jl+IWxcT3HHtZULvN6DdBiJx+khuBf9uyA/dJetWAU78CUcG7lvu/zD2MTWBJt98TuDMU7wxPYoTv1dmz69uHX59vEe16bvDVUSfqzAwTkm16O5E1wvLX6F3sliV+Ki1z53BqV3wRSts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=wdZfb1nq; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="wdZfb1nq"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=+6bSSytURb3TWVHcD03JvhMDUkVn+6vRiFmCnnL9S3I=; b=wdZfb1nqKfToVov7Kp1kkDRfoS
	KqAs97VeIF0KgYdDh9LGdzrsBaJi4sRaCAKi7SCW53Fp4XBPUc4Zd9i2TiiDYWrn0JfURLMXlKLaS
	88nLmXGi9PBdnF0SaTEildfRbAJ/CLKL/XOA8HJ7G5lNk8ptneZKSfPS3t/mRTCvb9Yg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x2TmZ-002yv7-O5; Fri, 04 Sep 2026 15:16:39 +0200
Date: Fri, 4 Sep 2026 15:16:39 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Hemanth Selam <hemanth.selam@gmail.com>
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH 1/2] mdio-mux: fix typo "framwork" in comment
Message-ID: <2ed2f84c-a4c1-4856-a2bd-531184d9cc1a@lunn.ch>
References: <20260904104107.12832-1-hemanth.selam@gmail.com>
 <20260904104107.12832-2-hemanth.selam@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904104107.12832-2-hemanth.selam@gmail.com>

On Fri, Sep 04, 2026 at 04:11:04PM +0530, Hemanth Selam wrote:
> Correct "framwork" to "framework", reported by scripts/checkpatch.pl using
> the misspelling list in scripts/spelling.txt.  Only touches comments, no
> code changes.
> 
> Assisted-by: Cursor:claude-opus-5
> Signed-off-by: Hemanth Selam <hemanth.selam@gmail.com>

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

You should set the Subject: line correctly to indicate net-next.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
