Received: from mta1.migadu.com (out-150.mta1.migadu.com [95.215.58.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18F78379C5A
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 06:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789022441; cv=none; b=TvK84pl8ISCLLQIvQDSBMxN+ca3mX9z1kcViMR1g9xM8IGWz3/EPIOp4HSqY8TKcXzhAbsd1FpfwRw9yFs6HoZcJbrgt4p7P1NYs/9NOrBfIWA4oddT4INNlw3Q2rFDxM8Hasx3LBh18NvCrkqRSIrvcHAv+hv3CLRFQXMEwh/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789022441; c=relaxed/simple;
	bh=ks41KwHmMsulS87ELRR9WPe1C8fnlZIsBWBQDR8I35w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q9VpoOaZl2x8kHuNr9zCGoduBgRZnp4EhJC6y66GnoNrvxtJCfab4fG63w+8N5SxfFAKW13NY3i3g4FB0DXTKEQ6xx/d3sdaVZ13ftvZncVmp5EozzJjZgf3FWeMBawTkjp5kukp6p8mirTYpyIlEGIp0jqwjXtxl+AihVsyUnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VBmRvMHB; arc=none smtp.client-ip=95.215.58.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VBmRvMHB"
X-Envelope-To: netdev@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=ks41KwHmMsulS87ELRR9WPe1C8fnlZIsBWBQDR8I35w=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1789022436; v=1; x=1789627236;
 b=VBmRvMHBNjiOI1uuJ2lukCDdhbHWS/8PgBibKPiHsyKyDxS+A+KUAL+MdyTCGawHZdmPpzxy
 Yw7FfFXiTndMr30ArXCU5uAGF56uh9Rp+01Z1jAYmdpsv9vdYwtAq2GDEjyJcUDXEMgJZ5i1rSF
 wjo4ZfWZ+c3WkDTPV6wK4l1E=
X-Envelope-To: netdev@vger.kernel.org
Received: by mta12.migadu.com with ESMTPS id 88ef105204316b9b;
	Thu, 10 Sep 2026 06:40:36 +0000
X-Mizu-Trace-ID: 88ef105204316b9b
X-Migadu-Flow: FLOW_OUT
Date: Thu, 10 Sep 2026 14:40:26 +0800
From: Hangbin Liu <hangbin.liu@linux.dev>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
	pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org,
	donald.hunter@gmail.com, ast@fiberby.net, i.maximets@ovn.org,
	one-d-wide@protonmail.com, fw@strlen.de, pablo@netfilter.org,
	netfilter-devel@vger.kernel.org
Subject: Re: [PATCH net-next 0/7] netlink: specs: conntrack: minor spec fixes
Message-ID: <aqJQ2rz2HDF5FTM3@fedora>
References: <20260910003852.2184031-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260910003852.2184031-1-kuba@kernel.org>

Hi Jakub,
On Wed, Sep 09, 2026 at 05:38:44PM -0700, Jakub Kicinski wrote:
> Clashiko raised a bunch of pre-existing issues on a recent series
> from Ilya. Let's fix those and whatever else pops out in AI review
> and looks relatively legitimate.
> 
> Jakub Kicinski (7):
>   netlink: specs: conntrack: timestamp is a nest, not a be64
>   netlink: specs: conntrack: fix the get reply attribute lists
>   netlink: specs: conntrack: fix SCTP conntrack state names
>   netlink: specs: conntrack: fix the nat-attrs attribute IDs
>   netlink: specs: conntrack: describe CTA_HELP_INFO
>   netlink: specs: conntrack: fix the per-CPU stats reply
>   netlink: specs: conntrack: tweak definition of obsolete attrs
> 
>  Documentation/netlink/specs/conntrack.yaml | 54 ++++++++++++++--------
>  1 file changed, 36 insertions(+), 18 deletions(-)
> 
> -- 
> 2.55.0
> 

All the changes look reasonable to me and the change matches the conntrack code.
For the series

Reviewed-by: Hangbin Liu <liuhangbin@kylinos.cn>

BTW, I'm still working on rt lwtunnel encap support. I noticed some sections
in your change have documentation while others do not. Are there any mandatory
requirements for documentation at this point?

Thanks
Hangbin
