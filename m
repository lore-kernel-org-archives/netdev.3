Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9764D3C9EE4;
	Fri,  9 Oct 2026 10:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542187; cv=none; b=Ct/hHEdp98fUC8tnUIVhx/XwddZAeImRgngPmUpNvW0fIybFtFb4avb3X7b4csIcvDfCz9ll/XJPDHvL+qlR+PATY/cYbBiR48/HpbEQHCD8f9BVK4Fv/s1mCoRhF5rZ1F74RKR6fwx0mL86jLq9+kqlSwaLt6IUHMt1xX6V9MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542187; c=relaxed/simple;
	bh=1RN/EsYxex/ghP4ZDZXyxYt0QsAUcFF6WUJ8Shxv248=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t1Gx+qruIIB39kbGy/Y8QE7xIJW+FLpcQAarN4IVzkfhHIj47u8rwvPwKoqpna8+TQvqp2dbVN3EWyfzhAjFJcnIIW8Pv93evNJsV0feD9wZU6AV08qM8U9wUjw4fePyHR0wHg70jsPIrNOpjPOAGZ8GsZ7RLEiwA4BS/DoX/uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kmiJWVSq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kmiJWVSq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233051F000FF;
	Fri,  9 Oct 2026 10:36:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791542186;
	bh=ynxo/0gvOeqQKfEE3XBlWSt5mCkBPjwXEsdxR42jXko=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kmiJWVSqeo7ISWCaqD2mb+bNrWb4QSniIZrpYPC00A+TSoPkAo7bhgfD28rugcFid
	 +QTTIx7JJsyFEHXf2COoyENEPaq3FT7QbdvVjoR3O01U/qeMqijlGdaIja0fDkvyDj
	 wsip9cZbfN9NEZPeSbIhmElKm7tfCIcvqqt1nJpa91/Jyk3IY7gLb/SDSR7ktwMs3X
	 vvUCaEL7l9jeKQ4RXtS93Odq4TEmBD0dZsqjXzfQzwRe5Whle0QRQPgALsjJcubUjJ
	 ttwoVJlaiWYfObG+/BDGZ0jT2cjqoWQId0JRAQElFPqHFhYSd+G/JBAZ+bRLWrT3pt
	 QW3ivHBdk7eZA==
Date: Fri, 9 Oct 2026 11:36:22 +0100
From: Simon Horman <horms@kernel.org>
To: Vinod Koul <vkoul@kernel.org>
Cc: Frank.Li@oss.nxp.com, Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Frank Li <Frank.Li@nxp.com>, Yicong Hui <yiconghui@gmail.com>,
	"open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
	open list <linux-kernel@vger.kernel.org>, imx@lists.linux.dev
Subject: Re: [PATCH 1/1] net: ethernet: micrel: ks8842: use
 dmaengine_submit() instead of ->tx_submit()
Message-ID: <20261009103622.GY83879@horms.kernel.org>
References: <20261002193022.168248-1-Frank.Li@oss.nxp.com>
 <20261007144334.GR83879@horms.kernel.org>
 <asZhHwzXU1sdk3TH@parshuram>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <asZhHwzXU1sdk3TH@parshuram>

On Wed, Oct 07, 2026 at 05:11:27PM +0200, Vinod Koul wrote:
> On 07-10-26, 15:43, Simon Horman wrote:
> > On Fri, Oct 02, 2026 at 03:30:19PM -0400, Frank.Li@oss.nxp.com wrote:
> > > From: Frank Li <Frank.Li@nxp.com>
> > > 
> > > Replace direct dma_async_tx_descriptor->tx_submit() calls with the
> > > proper dmaengine_submit() API wrapper.
> > > 
> > > Assisted-by: LLM
> > > Signed-off-by: Frank Li <Frank.Li@nxp.com>
> > 
> > Hi Frank,
> > 
> > Is there a back-story to this change?
> > Is it part of something larger?
> 
> Yep, Frank has been fixing direct calls with wrappers with aim to
> eventually start moving dmaengine guts internal and have a good
> consumer/provider split of the engine and objects

Thanks,

In that case all looks good to me.

> 
> > In face value it looks like a cleanup to an unmaintained driver.
> > And if so, I'm not sure it's worth the churn.

Reviewed-by: Simon Horman <horms@kernel.org>

