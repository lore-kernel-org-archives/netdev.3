Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FB728C2BF;
	Thu, 11 Jun 2026 10:06:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781172398; cv=none; b=TxElBqU4wZMnEvZlJ93Df9WlYpkrUarZQXvgC7C0BZ0oRTPo+WZt7KaZe0M9pt7l6oqruzKqCHNan4+3ggmUjlIahubk+MEKO6CppSKbFxMBUdjU+FwtFXlRFzDTAGue08/BGAfa/Q3s3UY/2wmRj22mGrnfADgNK1T/f+iZuWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781172398; c=relaxed/simple;
	bh=D9BwEnLq0u6D9BqWWpwB9VwcnLgwrDz8r+Z3rVSZMlg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lTKgi91ejKMq8mIZH7TycfVdGUMB1KSBya7xxM1W5bydxS0ld2v4o3AwDlITsMF9Xp6lwPBgX9JSH6Dp2Hbd+iA+Wtl4QfWg5MPBghwtZCNsxe4s5WXnCwJIFE9vKze3M6X++sDWwzFwH208Seg1We7kAx0FjjRixkigfxx2bUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gU7wJWFD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gU7wJWFD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A22A61F00893;
	Thu, 11 Jun 2026 10:06:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781172397;
	bh=GYxcvLkfQTMvWdhd9ItHBPbyoUGkUro9bwHXfPvnuPY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=gU7wJWFDeOlvJkH6MiCVDuks8Ekx042gPMobSQdMzd0lxYlLuL0naDfZy6zKzZGqj
	 7LKWBWL0nd0kCQ9zlN3pbdY9xusjat3Q+GmdKyL1g+75Rv0er9W+01I1jdTstE47Wo
	 I0wSGGSz5kKNAF1UnjqkMnz6xtT4rxjw+AEtXW/g1vBbYGjzXNpPg3ZVB+YiG32sXQ
	 Q4zgRB4fyiO3PsZfqvpUFdQgFzQihTltHeSiViveVCkqFR0cH9IVVZLeHSNt6iI3yD
	 k3mCKa0C5vfjnsiZiv+L3bSedbtkBLYNmjFyhfXbx8XqQ9o4ojWxkNr703n8lVfG8r
	 vRHCqtjQRDbEA==
Date: Thu, 11 Jun 2026 13:06:32 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jihong Min <hurryman2212@gmail.com>
Cc: netdev@vger.kernel.org, Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH RFC net-next 0/4] bonding: support LAG IPsec offload with
 replicated SAs
Message-ID: <20260611100632.GL327369@unreal>
References: <20260520081004.2232091-1-hurryman2212@gmail.com>
 <20260610141843.GI327369@unreal>
 <a7f661e5-61ee-42d7-be9e-5569e0f16e28@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a7f661e5-61ee-42d7-be9e-5569e0f16e28@gmail.com>

On Thu, Jun 11, 2026 at 05:56:17PM +0900, Jihong Min wrote:
> Hi,
> 
> On 6/10/26 23:18, Leon Romanovsky wrote:
> > On Wed, May 20, 2026 at 05:10:00PM +0900, Jihong Min wrote:
> >> This RFC adds a bonding model for IPsec/XFRM hardware offload on
> >> 802.3ad and balance-xor LAG devices when the transmit hash policy is
> >> layer3+4. This is an intentional scope limit rather than a hard limit,
> >> as this is the configuration I can test with my gear.
> >>
> >> The main idea is to leave the existing upstream single-lower-device XFRM
> >> offload path for active-backup intentionally untouched, while adding a
> >> replicated state model for LAG.
> >>
> >> For LAG bonds, the bonding driver installs the same XFRM state on every
> >> eligible running slave and stores the per-slave hardware handles in
> >> bonding-private state. Lower drivers that support this model can then
> >> resolve the handle for the concrete lower netdev used by the datapath.
> >>
> >> LAG IPsec features are user controlled. Newly eligible LAG bonds start
> >> with the ESP/XFRM features disabled, but advertise supported mutable
> >> features when all running eligible slaves can support them. Users can
> >> then opt in with ethtool. Feature enable is propagated to the lower
> >> devices and rolled back if a lower device cannot enable the requested
> >> features.
> >>
> >> The series also handles LAG membership and eligibility changes by adding
> >> replicated SAs to newly usable slaves, removing the departing lower
> >> instance on down/remove, and flushing bond-owned XFRM offload state when
> >> the bond leaves the supported mode or hash-policy configuration.
> >>
> >> This series does not convert any physical NIC driver. A lower driver
> >> must explicitly opt in to the replicated-upper-device model before it can
> >> use these bond-owned states in its datapath.
> >>
> >> For example, a driver such as mlx5 would opt in by marking its
> >> xfrmdev_ops and by resolving datapath handles through the helper:
> >>
> >>         static const struct xfrmdev_ops mlx5e_ipsec_xfrmdev_ops = {
> >>                 ...
> >>                 .xdo_dev_state_lower_handle = NULL,
> >>                 .flags = XFRMDEV_OPS_F_LOWER_HANDLE,
> >>         };
> >>
> >>         handle = xfrm_dev_state_lower_handle(x, netdev);
> >>         if (!handle)
> >>                 goto drop;
> >>
> >>         sa_entry = (struct mlx5e_ipsec_sa_entry *)handle;
> > 
> > I’m curious how you replicate and maintain the hardware state across these
> > devices. How are you handling the anti-replay window?
> > 
> > Thanks
> > 
> 
> The short answer is that the RFC I sent was not complete enough in this
> area.

The issue is that you are adding support for crypto offload where the
anti-replay window is managed in software. You must ensure that all SAs can
safely share and update this state.

Thanks
