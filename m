Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66242F9C0
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 18:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770920154; cv=none; b=ECp504MN15mn76zwdiRMWxwkWI5obXqf17B10ghX8cu4OlLIxG1n8OqDbgqOXZNxkFGsz7EEvoEI5lefNwdUeVCpXDNlyWA7IemP+Ura7U7YC8/+ZwoHaAR2kedWsGvjD6gWPYgmVEEubLGKnepnHwGBoxti4NeeYTlWwfPxJps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770920154; c=relaxed/simple;
	bh=tEAzlX5yySCeP0MGLIHfkvTTcVSoKsrQmENpamyS9M4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KI16aXhhZntsUbc0t8Nob0U41nDT650FQGeEUBjW9GZJ0NVRrCfzoWlpwtjDuLr3qR3Gj6Pc6EyCWk/bqPWtOiWccxA/pGUG9NB2OTDtfXM0pDMUmmRbjZwzd3pRQyMWVzR8VKvS0hYz4HJWb4+duly4mOTluBZ/h2t77aGtVns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=csnD6ELX; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="csnD6ELX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87DAEC4CEF7;
	Thu, 12 Feb 2026 18:15:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770920154;
	bh=tEAzlX5yySCeP0MGLIHfkvTTcVSoKsrQmENpamyS9M4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=csnD6ELXWMk5Xry2taM2yu6mgKghYM80bdIZzLVGajErL88mLZ4o2oDS63tNAIl+J
	 GxoqYvJQN3S9a4savA/dDYZh3hkcvm05KmYPqPAAxUrcE8m7Dh9BjIWtwBonUaVw3p
	 rjQYQp8+oCBQFREcaX4P1Wst8eJA4QX8JMsI1si7c3pHN4E123zxtQCufTrK/itcro
	 mX2+zbfIHNzYeuig+Vt+8rI0GUmd3SVGXDRmnw+y9LNqivPl9kCA9Ue1R3aDEDRl7O
	 yYx9BwY6FbbR3wfmR6b1s7/W75UiBKFLkM8uerU2ilUZhpebQ5Q/nwMrt/cEbJzsyr
	 H9zGYXgs6Ojow==
Date: Thu, 12 Feb 2026 18:15:49 +0000
From: Simon Horman <horms@kernel.org>
To: Kohei Enju <kohei@enjuk.jp>
Cc: aleksander.lobakin@intel.com, andrew+netdev@lunn.ch,
	anthony.l.nguyen@intel.com, davem@davemloft.net,
	edumazet@google.com, intel-wired-lan@lists.osuosl.org,
	kohei.enju@gmail.com, kuba@kernel.org, netdev@vger.kernel.org,
	pabeni@redhat.com, przemyslaw.kitszel@intel.com
Subject: Re: [PATCH v1 iwl-net] iavf: fix netdev->max_mtu to respect actual
Message-ID: <aY4Y1a8QbN18kkPm@horms.kernel.org>
References: <c48f08ad-b402-4cfe-a362-4cb0c3a7801f@intel.com>
 <20260210170603.149842-1-kohei@enjuk.jp>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260210170603.149842-1-kohei@enjuk.jp>

On Tue, Feb 10, 2026 at 05:05:55PM +0000, Kohei Enju wrote:
> On Tue, 10 Feb 2026 17:37:23 +0100, Alexander Lobakin wrote:
> 
> > From: Kohei Enju <kohei@enjuk.jp>
> > Date: Tue, 10 Feb 2026 15:57:14 +0000
> > 
> > > iavf sets LIBIE_MAX_MTU as netdev->max_mtu, ignoring vf_res->max_mtu
> > > from PF [1]. This allows setting an MTU beyond the actual hardware
> > > limit, causing TX queue timeouts [2].
> > > 
> > > Set correct netdev->max_mtu using vf_res->max_mtu from the PF.
> > > 
> > > Note that currently PF drivers such as ice/i40e set the frame size in
> > > vf_res->max_mtu, not MTU. Convert vf_res->max_mtu to MTU before setting
> > > netdev->max_mtu.
> > > 
> > > [1]
> > >  # ip -j -d link show $DEV | jq '.[0].max_mtu'
> > >  16356
> > > 
> > > [2]
> > >  iavf 0000:00:05.0 enp0s5: NETDEV WATCHDOG: CPU: 1: transmit queue 0 timed out 5692 ms
> > >  iavf 0000:00:05.0 enp0s5: NIC Link is Up Speed is 10 Gbps Full Duplex
> > >  iavf 0000:00:05.0 enp0s5: NETDEV WATCHDOG: CPU: 6: transmit queue 3 timed out 5312 ms
> > >  iavf 0000:00:05.0 enp0s5: NIC Link is Up Speed is 10 Gbps Full Duplex
> > >  ...
> > > 
> > > Fixes: 5fa4caff59f2 ("iavf: switch to Page Pool")
> > > Signed-off-by: Kohei Enju <kohei@enjuk.jp>
> > 
> > Reviewed-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> > 
> > Although I'm not sure the 'Fixes:' tag is correct. Was vs_res->max_mtu
> > accounted before switching to Page Pool? If so, then yes, my fault.
> > Otherwise, this issue is older than libie.
> 
> You're right that vf_res->mtu was also not accounted before the commit.
> 
> The commit changes:
> -       netdev->max_mtu = IAVF_MAX_RXBUFFER - IAVF_PACKET_HDR_PAD;
> +       netdev->max_mtu = LIBIE_MAX_MTU;
> ...
> -#define IAVF_MAX_RXBUFFER   9728  /* largest size for single descriptor */
> 
> and thus netdev->max_mtu was already hardcoded, but just because
> IAVF_MAX_RXBUFFER was valid for VFs there hadn't been any issues, and
> invalid MTU could start to be set after the commit.
> 
> > I'm asking as IIRC before I did set max_mtu to the libie definition,
> > there was a hardcoded value already.
> 
> Yea, as far as I checked the value was hardcoded from the beginning
> (91c527a55664 ("ethernet/intel: use core min/max MTU checking")).
> 
> Although I'm not attached to the exact commit as the Fixes: tag, I chose
> that since (coincidently) that commit made this regression.

That seems like a reasonable approach to me.

Reviewed-by: Simon Horman <horms@kernel.org>

