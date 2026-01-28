Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6018633DEF7;
	Wed, 28 Jan 2026 09:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769592121; cv=none; b=tU2VCHQaf7JXqeO1xQj1pPf99IJczyEsvLcOM8DZp6WOq4zs1zcNsqqS0bvw1vO7y6PZkHKcHFF8SiHv792mb1l5erwqbbjLfgyAN6rd8n/FwFIDHLFOMjGUdEvmDia/u7UgEsBniN/EjpsoKe6sNoIN58In5Y39uZrbURHI6e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769592121; c=relaxed/simple;
	bh=2fjoNUbfOIM8UhUstTCpYZgfZ8OMpqLgrhdWkrlQ4T8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUDpTJ80ILnWUVx6OEzOlsJGUlJCCV76gPCHVbirD0cA/Ssy2so5mVyLs3uwlv7BnBa13eOZMRnE7koJsLKz/FWvrJoslLAWGRs1mHyX22utlLTe/bRPJP7ppq4IjlwDeAMamRpI1ws0mTUnTJgI2+D3RczdM8vYKiaNvXEJfcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f03/7C7N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f03/7C7N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0CBDC4CEF1;
	Wed, 28 Jan 2026 09:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769592120;
	bh=2fjoNUbfOIM8UhUstTCpYZgfZ8OMpqLgrhdWkrlQ4T8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f03/7C7N5F6vtRxB7CndZoLyobtXPUCg6ICyN3DjS2ENDHcR2YY/6NPBMw2RhJDqe
	 xTtNVrHgp+cc98ai0UoIDj+9gkaJBCHajjYTEuxIBijx32xKg9oG5Aa+ccbDGP/C1N
	 WM4LzQA8z6/lQncvDI56B6yFkq25IZlcRnIGIVLBIFMqqytorNTBx9nHQV7yenJpYl
	 0brQDtdVVvNsMCRgI92n1MqquU4CraHyyvYmu9H7nrNcnRwEmswdY6057wwP8R83zk
	 DvxcICzmKkplfwzjgISpC7K7lVD1ag64oRBNBQGcY14+c1Hjn0rT5jHCTukR4OPWi0
	 VSBiRdVAuYf1Q==
Date: Wed, 28 Jan 2026 09:21:55 +0000
From: Simon Horman <horms@kernel.org>
To: Brian Vazquez <brianvv@google.com>
Cc: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>,
	Brian Vazquez <brianvv.kernel@gmail.com>,
	"Nguyen, Anthony L" <anthony.l.nguyen@intel.com>,
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	David Decotigny <decot@google.com>, Li Li <boolli@google.com>,
	"Singhai, Anjali" <anjali.singhai@intel.com>,
	"Samudrala, Sridhar" <sridhar.samudrala@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"Tantilov, Emil S" <emil.s.tantilov@intel.com>
Subject: Re: [Intel-wired-lan] [iwl-net PATCH] idpf: change IRQ naming to
 match netdev and ethtool queue numbering
Message-ID: <aXnVM9MBRuXWgACz@horms.kernel.org>
References: <20260123204058.651080-1-brianvv@google.com>
 <IA3PR11MB8986BB2FDDBB664CB318FB15E593A@IA3PR11MB8986.namprd11.prod.outlook.com>
 <aXj652w2_ogi6ysW@horms.kernel.org>
 <CAMzD94T=VS8J5A1VZH_KriY7BMHf90rrGEK=4Jyuzc3SxHJhKA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMzD94T=VS8J5A1VZH_KriY7BMHf90rrGEK=4Jyuzc3SxHJhKA@mail.gmail.com>

On Tue, Jan 27, 2026 at 06:36:14PM -0500, Brian Vazquez wrote:
> Hey Simon, last version is v3 it does have the Fixes tag now. Thanks!

Great, thanks.
And sorry for not noticing that earlier.
