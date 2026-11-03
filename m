Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793702786;
	b=3kDnxpDLvgV6v6FUmYWN3D9TTVbLGXg1SijPQ4f8Z4/EX2WwXgHebRZeYRLu0WDHsqNI
	 DCcGQt4uZ2tc79NTfxh3QmUVP6GZSNWqwav+TTVWjwnf8HDTVusVn3p2+uSuFDM5uLOGs
	 nVfJCBoyqyx73YxodhodR9Src5xIkypEKy83eWLFZgy17mv4+/+41mEZHjRTX0Z+E+hAY
	 DdtcgNoHpEC0Gi9RO0JlzBU23+gG/Ml7nfYHWDIsl0w7Ro8tBpm4+sizefsDMBM/6JZw8
	 kffyjdEphxiKYze92f0Awxb1CkcRjQcWjTO/7PmMqvJ8DJTA0qj5Gh16253gT2IwrTg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793702786;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=1G2PsQcnNgl4KmAucIRxC3xX4zfowwgWE94gTqwm+b8=;
	b=txKqK1XvmCBlbv0KDjsb39toUeBxVxdSUbaayv4cKZuuvsvbqMgh0rUUYAY+i6xddwgm
	 mm4/ICSWAFvFP3mMI6B8yg6kM4obkyENa/jY7xv4WbOvzPws1QgwjexJIt3CssYUFD4BJ
	 6vqyVTB9wsC58opQrcFowU2GF7blASU402lYUxJ4afHlkTrfr0NVNvBeRlwlRI6SgsiGO
	 C4Bb/Y5MXdmvho2eNW44Q3B11HY+2ow893NyJlwbTU0RbrJ58jp++Bpn8SWsmbT+jqoj5
	 89gR+AZl0jwSF0fPvDQuzlrg0L2R+O8I0x5AGV4tEeOCCMR6SvsM5zpZwuHANq2lGqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUgHXZXd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C660606C5AE;
	Tue,  3 Nov 2026 10:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FUgHXZXd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF1961F000C1;
	Tue,  3 Nov 2026 10:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793702785;
	bh=1G2PsQcnNgl4KmAucIRxC3xX4zfowwgWE94gTqwm+b8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FUgHXZXdEYALJR8aUoYGIaet3qMZH7hTArHG4Ubz3xnuONCWv7aVi+fFYbEYLKyQX
	 Kr+aEnenkLGKEtt0YVYOMOgiK/p26c9PmHFHk6ipiBXIPuSRsLlvlWYkf14jDFrJGg
	 kvyiAWEftWgFhTYofTrfpgoYcP3Z/Lo4PrEizo4TUfvmn+O3cVKZMvxH2BCmsBU6Q0
	 4Eqw0taZVO5J+xmnoZ64jFKPu3PdSthWc2KcL37AOyo3diXs4SFySIGivEIyGgM58f
	 gEJ0lsFdoWRZjhfuBelRstfn2/EKuC5zL+a8cYMbuNTTjME4wa148Ro6qSIsyqwaaP
	 CbyEtaX2VBHfA==
Date: Tue, 3 Nov 2026 10:46:21 +0000
From: Simon Horman <horms@kernel.org>
To: Linkui Xiao <xiaolinkui@126.com>
Cc: jiri@resnulli.us, davem@davemloft.net, edumazet@kernel.org,
	kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Linkui Xiao <xiaolinkui@kylinos.cn>
Subject: Re: [PATCH net 0/2] devlink: do not dereference a missing param item
 or shared buffer
Message-ID: <20261103104621.GD865646@horms.kernel.org>
References: <20261030033332.3685172-1-xiaolinkui@126.com>
 <20261102120504.GD257209@horms.kernel.org>
 <84706e2d-5196-4e40-8bf5-122a0c54eada@126.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <84706e2d-5196-4e40-8bf5-122a0c54eada@126.com>

On Mon, Nov 02, 2026 at 09:12:16PM +0800, Linkui Xiao wrote:
> Hi Simon,
> 
> thanks for the review.
> 
> On 2026/11/2 20:05, Simon Horman wrote:
> > On Fri, Oct 30, 2026 at 11:33:30AM +0800, Linkui Xiao wrote:
> > > From: Linkui Xiao <xiaolinkui@kylinos.cn>
> > > 
> > > Two devlink helpers look an object up by id or index, warn when the
> > > lookup fails, and then pass the NULL result to code that dereferences
> > > it. A driver mistake (a param_id that was never registered, an sb_index
> > > that was never registered or is unregistered twice) therefore costs an
> > > oops instead of a warning.
> > > 
> > >    1/2 param: devl_param_value_changed() hands the missing param item to
> > >        devlink_param_notify() -> devlink_nl_param_fill(), whose first
> > >        statement dereferences param_item->param.
> > > 
> > >    2/2 sb: devl_sb_unregister() runs list_del() on the missing shared
> > >        buffer; list is the first member of struct devlink_sb, so it
> > >        reads and writes through address 0.
> > > 
> > > In both cases every other user of the same lookup already returns right
> > > after the warning, so the fixes just align the remaining callers; there
> > > is no change of behavior beyond avoiding the dereference. The param side
> > > follows the example Jiri set for devlink_param_unregister():
> > > 
> > > Link: https://lore.kernel.org/all/20230126075838.1643665-5-jiri@resnulli.us/
> > > 
> > > Both Fixes: tags point at the commits that introduced the unguarded
> > > WARN_ON pattern; the current devl_() functions are pure renames of those
> > > originals. No in-tree caller triggers either path today (the audit is
> > > part of a defensive hardening pass), so both are aimed at stopping
> > > out-of-tree drivers from turning a driver bug into an oops.
> > 
> > Thanks, both these fixes look good to me.
> > 
> > But I do wonder if the hardening aspect, from an in-tree pov,
> > makes them net-next rather than net material.
> > 
> > I say that, because my understanding is that there is some pressure
> > to only push critical bug fixes via net. This is because of the recent
> > up-tick in bug fixes driven by AI-related activities.
> 
> Agreed -- net-next is open now, so I have just resent this as
> [PATCH net-next v2 0/2]. Only the prefix and the base changed: the two
> hunks,
> the Fixes: tags and the commit messages are the ones you reviewed, and the
> Reviewed-by tags from v1 are kept. Neither patch carries a Cc: stable, so
> there is nothing to drop with the new target.

Thanks, much appreciated.
