Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108F714F70;
	Wed, 19 Aug 2026 20:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787171847; cv=none; b=CjKNgVfzLheWV3yDDTHbURxjFl3EnNDK2Hwv00qVyL+Mb9LI9sKLA5MIelhhEO6xtlucgh+VKE+KW8aN+COOeRqBBWMxiox7dAbz42DPF84H769qxKvxontc96lgJ1uCocY0T1NRauTN7HoX6IF1jqqxquh7fdPFhPHIIyjvZDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787171847; c=relaxed/simple;
	bh=wZAlDo6u+Rqszs1NHxc252zKIZ2SXm70uNZcJc9kP84=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oAGztsHVfrqmdJfV4jZ3P9DK3ER7OBYvZD5jBPQYgY1dTtMF8RcQ5xQPrsE3cLoTolFiDsVfr/JHsXvEX24tBGVKhx8sn2N58d3ZLj+0Ds8EB+Lle942vzs6B2bHLz9gXZRqsEG7U8oxbSntuyMWqKkT9sQ540XtYbecl3XR7zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=oEoHHl2W; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="oEoHHl2W"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=pWtEgxltG1El3IeZOOapKxJr0zlf+Vk+miP3AMtMJQI=; b=oEoHHl2W31KGHH71Dn3qdDuX+3
	brkVLSUiOVnbJGn7A6NaU4C0yMUxHTUHApY1gzJCrXtbdF2AYiPVUKhrsdPgl7SFaDjhOiLEXW95g
	17ghHUInfH6z0MNuCj9FE7xLmMv8A0SiLijVevCJklre+eppuEObuv40ehXHtvsoTasY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wwn2A-000fe1-Jt; Wed, 19 Aug 2026 22:37:14 +0200
Date: Wed, 19 Aug 2026 22:37:14 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: David Yang <mmyangfl@gmail.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	pabeni@redhat.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v10 2/4] net: dsa: motorcomm: Split SMI module
Message-ID: <8141eb90-bdc2-45a7-ad4c-99e92e9b7983@lunn.ch>
References: <20260816193905.218112-3-mmyangfl@gmail.com>
 <20260818171025.4020314-1-kuba@kernel.org>
 <CAAXyoMMUWGjokvaDAkgbDM0=6SZQ_B0Vos-wNUF+dun6W_7qAw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAXyoMMUWGjokvaDAkgbDM0=6SZQ_B0Vos-wNUF+dun6W_7qAw@mail.gmail.com>

> > > +int yt921x_reg_read(struct yt921x_priv *priv, u32 reg, u32 *valp)
> > > +{
> > > +     WARN_ON(!mutex_is_locked(&priv->reg_lock));
> > > +
> > > +     return priv->reg_ops->read(priv->reg_ctx, reg, valp);
> > > +}
> > > +
> > > +int yt921x_reg_write(struct yt921x_priv *priv, u32 reg, u32 val)
> > > +{
> > > +     WARN_ON(!mutex_is_locked(&priv->reg_lock));
> > > +
> > > +     return priv->reg_ops->write(priv->reg_ctx, reg, val);
> > > +}
> >
> > [Severity: Low]
> > This is a pre-existing issue and not introduced by this patch, since these
> > two lines are moved verbatim out of chip.c.
> 
> It would be better to address it in another commit. Also it's the AI
> who suggests not to include such changes.

Since it is pre-existing, a new patch would be good.

      Andrew
