Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47BD43800D
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 14:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783951392; cv=none; b=rzlh05ivCktWj3vDb+x8W7WW4+15aVP+azsvetszNVBvuDDwXT4+pEkxD3TNgq5OFZykR/GMYodg9oJOnXUCtPhXlcvOwfDP+d1qx2NPq56PjyF7hgkrTDW7ts7DL/gP/aw1FY+eFgltjHhlGkS7x9QCTx1d6VxRou6avmpPlV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783951392; c=relaxed/simple;
	bh=V90EOyFLkH2LIcv/ftDs2X0OqpyzE3zQaDVhjNmWhyQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KkDDURtCF8Qyor9EJ7jh98BgMccQBXQGCrMstrRE2KP7JB2Fq4NaI+ll7wTDSl5fZVClEy0npvgCif9si5Y057aboHYD+9GKbFRDJvDPgzOqeJSlqDd46nRzJiRvCCiQUs7WlYDrr0kT8DLl5uF+nY+b7DYCREk5ZsziplSIGak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ii7998XD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ii7998XD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA4221F00AC4;
	Mon, 13 Jul 2026 14:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783951391;
	bh=0hjN4HS/zkq2rChROb8fzZV2btFVNjvZd6ow0mvbuL8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ii7998XDyvrbLeF1FDeX5yqnEmUmiLrqF7e19daHNAjp+KW8yjCjC4udPUEWyU0qQ
	 XCrE6sRROWst7M+Md4i7uC+ThAAZVCHKYdVV6EgoKgrXnOyQ+o2bCMYrpwRWCndgx4
	 R5tzlBJIlzDmV9/ix4xqh1aNI4cb3YCsF8MxmukmZfJb8O1U4hZCvqxggJUFftyE8u
	 QoUXhx3BKWgOfGBe012twWz9NE/faHTaX0qrkAD6GekzHKYb4RRxh93VLFMj5Dz35e
	 He44+tE5DG4ls0yfYTttk/B/8p5vrES1Gjegk2S/EpKnLROH/Rp3+s/yBN4b8Vxy91
	 F5dHi9lzPV0eQ==
Date: Mon, 13 Jul 2026 15:03:06 +0100
From: Simon Horman <horms@kernel.org>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, Michal Schmidt <mschmidt@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: Re: [PATCH iwl-net v2 1/2] ice: move ice_vsi_realloc_stat_arrays() up
Message-ID: <20260713140306.GF1364329@horms.kernel.org>
References: <20260706224346.22546-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260706224346.22546-1-przemyslaw.kitszel@intel.com>

On Tue, Jul 07, 2026 at 12:43:30AM +0200, Przemek Kitszel wrote:
> Move ice_vsi_realloc_stat_arrays() up, to allow calling it from
> ice_vsi_cfg_def() by the next commit.
> 
> Fix kdoc for touched code. One line break removed, "int i" scope
> minimized to the loop, no changes otherwise.
> 
> Reviewed-by: Marcin Szycik <marcin.szycik@linux.intel.com>
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> v2: no changes

Reviewed-by: Simon Horman <horms@kernel.org>

