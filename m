Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C7223546FE;
	Wed, 10 Jun 2026 20:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781123291; cv=none; b=agwSP9XAV/2A2IU/ZuEunCDFPQigYdW2KzIlbIaBqIFhzzkdtFgrikaZKnnTRvbudlAIK7IxKCwfldiL/16PqGVT7CWuEN96KejJXDSqrK0FhYT0Q/wxi9eE4mkcs8YTcw50oub8Uwb3NLtk5FbISgtf1+JRNrGJ6jUOzXXwBLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781123291; c=relaxed/simple;
	bh=s8PLSTWqayI2a24VIoGdE8eYoVMdHPP9Vz7IaoHuIHU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rw4xRi1hGFFf8dbD5Y8oSsEGWTcJQoa2pdELZQVu18bpiFazcFEK2KX/15ZcvE4Nkjk21Z2yik2cAh/jNENkNszupw8n4VC8EKAq5fC0XD4/MLZVpSSf21qP/fiYmHgueA4HYKGILwzrgL5nfzkF5FIyq144v8tSob7F801zBlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gJ66Zm61; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gJ66Zm61"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=gTZRVG2MQu2TxnmalgtedlBp1TY5xnipy0GHzJFdNAw=; b=gJ
	66Zm61a4TvqRNNULPTFxRoOwyYXIOrEqG8p1QSE4W93w9zHnn1q3Y0Ra1oh4olazY/ULYbh3x46na
	Lk+5NXlR3PsBSKbPG7JqwNkjtNzxRvcenqL5f0hbdO3OYtEDdBCfpVXNAqBghopqdnYtdRNGSd5iL
	6rqV8HmlKJAo6Gs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wXPWt-00733h-14; Wed, 10 Jun 2026 22:28:03 +0200
Date: Wed, 10 Jun 2026 22:28:03 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: loop: Fix devlink resource ID
Message-ID: <2c8baa5d-32c2-44fc-9075-27da9d6b4c7a@lunn.ch>
References: <20260610062554.769892-1-mmyangfl@gmail.com>
 <53211107-5f22-4ea6-8374-b70317b9b2cb@lunn.ch>
 <CAAXyoMNjX5rMpcj2N-WTkUD871tp0-2ceaOzMmUdwWSSGG6J4g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAXyoMNjX5rMpcj2N-WTkUD871tp0-2ceaOzMmUdwWSSGG6J4g@mail.gmail.com>

On Wed, Jun 10, 2026 at 09:36:59PM +0800, David Yang wrote:
> On Wed, Jun 10, 2026 at 3:23 PM Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > On Wed, Jun 10, 2026 at 02:25:45PM +0800, David Yang wrote:
> > > Fix collision with DEVLINK_RESOURCE_ID_PARENT_TOP (0) by keeping the
> > > real resource IDs in enum dsa_loop_devlink_resource_id starting at 1.
> >
> > Please could you expand on this. What is actually wrong here?
> >
> > When i look at mv88e6xxx, hellcreak and b53 it does the same.
> >
> >      Andrew
> 
> dsa_devlink_resource_register() is, but other users of
> devl_resource_register() (mlxsw and netdevsim) avoid 0 explicitly.
> 
> In this case for dsa_loop, the usage is semantically questionable (0
> being its own parent) but might just work as well. But it is a real
> problem on mv88e6xxx, where ATU_bin_* are in fact registered as
> top-level siblings, not as children of ATU, due to ATU ID colliding
> with PARENT_TOP.

So please produce a patchset fixing all users of
devl_resource_register() which pass 0. And then maybe add WARN_ON()?

    Andrew

---
pw-bot: cr
