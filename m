Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFDCA3A640C;
	Wed, 21 Jan 2026 16:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769014436; cv=none; b=WVmd0IrAiZbybeg+iD2BvIcgxfxOlKpZH65rrti1MLgbb5Y6t2doNKgmLbIs12CLXeC4gGkGShBTbahKB92UsCpOpM435XNziz39lxlWs7OMPwPhvCF9ifP17krdTekSc4UTR22ZMssi0xtEyxu3vb7qXlBzOMyBVK1+9Mk/qO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769014436; c=relaxed/simple;
	bh=ce2ib89RDMtbxxAtxTKaJmyqjjkjqMMIBOMkupAxUpw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=c53LrhR8IUF+n+AqtaN9x3k/HEi7bEoMBDE0HPeq8SYjgYA/B/388TGP1UjlPxeN+Jb1RzxJQkAfikf4BQyrCszDsvHKo+KRVr0fV9tXNUNIpgZTDe++xWdZDuFIunpZA+TwG6DFusNWBsLibHTinOsVWWi47lEDvKFOSqrHgo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nQdj3WUq; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nQdj3WUq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6011EC4CEF1;
	Wed, 21 Jan 2026 16:53:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769014436;
	bh=ce2ib89RDMtbxxAtxTKaJmyqjjkjqMMIBOMkupAxUpw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nQdj3WUqaBVg4pPse1NvPmUHw7B6eD6CUpbq/vMG62nZmRkwZyNU5F4GZ4kj3sbsl
	 n94RPO1csR54fCvbIm0ZTVWO26FDAvXVz11Ra+W2Nvl2NWbIxTStWMpQh7YjDbBURb
	 H9r58N7EMcSyJktsG3iAGFl312znchVCTI+13ixGSm8kg3Rl34MoMbVxA9kvp+THf0
	 Jw8Dt6lWcQ+m3whU3WfdmR3y2tMf3lAMYneF6gOgOsEhtdDxax56g6mIH0sM8xfbR7
	 pcnabniBpp6gAVd3OIXDaTVeXy5+SzhInrf/O9FhSpwUkICfWWf6y+BEOMw6WTgeTY
	 lQOCPIde76BqA==
Date: Wed, 21 Jan 2026 16:53:51 +0000
From: Simon Horman <horms@kernel.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Slark Xiao <slark_xiao@163.com>, ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net, andrew+netdev@lunn.ch,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, mani@kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Muhammad Nuzaihan <zaihan@unrealasia.net>,
	Qiang Yu <quic_qianyu@quicinc.com>,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
	Johan Hovold <johan@kernel.org>
Subject: Re: Re: [net-next v7 5/8] net: wwan: add NMEA port support
Message-ID: <aXEEn4mcrUGj3Knb@horms.kernel.org>
References: <20260115114625.46991-1-slark_xiao@163.com>
 <20260115114625.46991-6-slark_xiao@163.com>
 <aW91bYu1ueczfGTh@horms.kernel.org>
 <386ee1ac.1e15.19bde4f5bac.Coremail.slark_xiao@163.com>
 <CAFEp6-1X4=70mCGYQYkvDqeQxgP64=Nu=yZxgBqDAK-hbYN-Mg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEp6-1X4=70mCGYQYkvDqeQxgP64=Nu=yZxgBqDAK-hbYN-Mg@mail.gmail.com>

On Wed, Jan 21, 2026 at 03:16:33PM +0100, Loic Poulain wrote:
> On Wed, Jan 21, 2026 at 3:09 AM Slark Xiao <slark_xiao@163.com> wrote:
> >
> >
> >
> > At 2026-01-20 20:30:37, "Simon Horman" <horms@kernel.org> wrote:
> > >On Thu, Jan 15, 2026 at 07:46:22PM +0800, Slark Xiao wrote:
> > >
> > >...
> > >
> > >> diff --git a/drivers/net/wwan/wwan_core.c b/drivers/net/wwan/wwan_core.c
> > >
> > >...
> > >
> > >> +#else
> > >> +static inline int wwan_port_register_gnss(struct wwan_port *port)
> > >> +{
> > >> +    return -EOPNOTSUPP;
> > >> +}
> > >> +
> > >> +static inline void wwan_port_unregister_gnss(struct wwan_port *port)
> > >> +{
> > >> +    WARN_ON(1);     /* This handler cannot be called */
> > >> +}
> > >
> > >Please don't use the inline keyword in .c files unless there is a
> > >demonstrable - usually performance - reason to do so. Rather, let the
> > >compiler inline code as it sees fit.
> > >
> > >Using the inline keyword in .h is of course fine.
> > >
> > I think this shall be a mistake.
> > For a GNSS device, these 2 API shall not be called frequently.
> > So there is no necessary to add "inline" to improve performance.
> 
> Indeed, it's fine to remove that explicit inlines here.

Thanks!
