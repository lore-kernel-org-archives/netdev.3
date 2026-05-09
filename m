Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B968C2DB79F;
	Sat,  9 May 2026 19:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778355817; cv=none; b=f+VtxUK+nYb4PmbJD12G1H4LEK8TV4/TvYP6ckzY8/56ZJCKzLZ4dt6vY1vtMJKgt2nn2pU9xv4i3SjIu/Xlq3lFMO3QG7jNbL1mwYd6hy2JXdSTxohjN2rhcghX9JLJ+jwdQamjMnn3YRcp8onOAQ8+XRvC96iyJgbO8QuU8i0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778355817; c=relaxed/simple;
	bh=FHZ6Od0X5fZc57mS2ulH4kYBV/NGDrHi+Ez6WkWuRnw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NiWjAjPK3Sk1I2Tgatue88iJkkVnEEcVHMLo8Nk7kEUOMgs4aQamzWj/xscOpZqxhPV2cBBfOCs9dRPxv2YFh64mtmNAU95F+NVN2l7uvybA/6xWHfi7JiTqMKU28AboyyvoonHIsN7GfiOX3JWtjYkTOwcHUX1lKNpex+YGazc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=rdEHE2/F; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="rdEHE2/F"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=jciCmPafrQJc8P0lqfJxu/JWuFjCcvpFpjFvymBX9Uk=; b=rd
	EHE2/FfULvb68lmwWW7cDL8/4X8OHfz/tTxdC0sJpTTZ0VUMTtP9ak77xyNTqv4fjiIx0xSrhisgp
	Xwt8fa4J448k3y3AHPMut0OJqNHmSPcYtaZSkLC62Mo2W9XGpl5+JdElSwr7bhfxyVzwT4xUBV5Q8
	4/0CMSZ8qcLukHs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wLna2-00289a-9c; Sat, 09 May 2026 21:43:18 +0200
Date: Sat, 9 May 2026 21:43:18 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Illusion Wang <Illusion.Wang@nebula-matrix.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Dimon <dimon.zhao@nebula-matrix.com>,
	Alvin <alvin.wang@nebula-matrix.com>,
	Sam <sam.chen@nebula-matrix.com>, netdev <netdev@vger.kernel.org>,
	andrew+netdev <andrew+netdev@lunn.ch>, corbet <corbet@lwn.net>,
	kuba <kuba@kernel.org>, linux-doc <linux-doc@vger.kernel.org>,
	lorenzo <lorenzo@kernel.org>, horms <horms@kernel.org>,
	"vadim.fedorenko" <vadim.fedorenko@linux.dev>,
	"lukas.bulwahn" <lukas.bulwahn@redhat.com>,
	edumazet <edumazet@google.com>,
	enelsonmoore <enelsonmoore@gmail.com>,
	skhan <skhan@linuxfoundation.org>,
	hkallweit1 <hkallweit1@gmail.com>,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: =?utf-8?B?5Zue5aSN77ya5Zue5aSN77yaW1BB?=
 =?utf-8?Q?TCH_v13_net-nex?= =?utf-8?Q?t?= 03/11] net/nebula-matrix: add chip
 related definitions
Message-ID: <ba0d1a60-3d56-4053-a4e9-e47fda0c450a@lunn.ch>
References: <20260428114910.2616-1-illusion.wang@nebula-matrix.com>
 <20260428114910.2616-4-illusion.wang@nebula-matrix.com>
 <e41adaad-8937-4b5d-bdbf-d57d3efe2855@redhat.com>
 <b240b971-81b8-4325-80b6-5352e1515f07.Illusion.Wang@nebula-matrix.com>
 <bdaf51a9-66d1-4469-960f-d5ec74f870de@lunn.ch>
 <e35c8cf4-73f0-4847-b1b1-8f424a805a71.Illusion.Wang@nebula-matrix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e35c8cf4-73f0-4847-b1b1-8f424a805a71.Illusion.Wang@nebula-matrix.com>

On Sat, May 09, 2026 at 11:38:27AM +0800, Illusion Wang wrote:
> 
> >> But I printed out the results: 
> >> ARRAY_SIZE(nbl_sec009_data) equals NBL_SEC009_SIZE,
> >> ARRAY_SIZE(nbl_sec025_data) equals NBL_SEC025_SIZE,
> >> and ARRAY_SIZE(nbl_sec022_data) equals NBL_SEC022_SIZE.
> >> 
> >> Is the AI making a mistake here?
> 
> >Just a guess, i've not looked at this patch at all.
> 
> >Are you doing this on a 32 bit build? Maybe the AI is?
> 
>  >   Andrew
> 
>  We are using this on a 64 bit build.

And what happens with a 32 bit build? Try think of all the ways the AI
could be correct., and disprove them.

      Andrew
