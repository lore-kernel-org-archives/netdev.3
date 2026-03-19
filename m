Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E767E3E7148
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 16:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773937546; cv=none; b=pvNyxXIFqHDkfHS6yRTaog/bFi6c8Tj2cxBpMrXhskdoFEQcEEjt23XG4MFIrdtRDkFqiOX8zS8MhS+85ploWWYBORkyA0WgeFQG6OfGkinjn6t2jjyfX8EqJky2an9/MPeYwhtDy6+OYQArNrSsG+KVpMOOp80+Ef1gPSwdsvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773937546; c=relaxed/simple;
	bh=dUZuk0HtTKH2Co8fmRPKVuD/r3DC749N0V6aCj80dZE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=h86pPXJHoIl0zJLd8tRNLFBO8IpGosmuMDFcaZHCS80V46ryGykcZvHWhOdNVpZmODxQJ8IHzbNOkPtHQv0Z/7MEOYxNQOS+2T6KHrIRF73+3XtDO/HYicXiyck3zq+PKH/ECkb4xie1NfXxnpdYJBIpyATlopx2SZiApHA91WU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bfEMIOex; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bfEMIOex"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75524C19424;
	Thu, 19 Mar 2026 16:25:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773937545;
	bh=dUZuk0HtTKH2Co8fmRPKVuD/r3DC749N0V6aCj80dZE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bfEMIOexVoOpuK3GgQ9tTajauzOvYlvkCFuPgAJPJU3TjFL3WcMMiP4ey7qgWN8RM
	 IYCLR+03zUTbbSe+3usAY/xdeA6EXXi772u0Ngxqxk1vAVVQe81okOCdYKAv9/a8WC
	 9A0ARr0epIzs9b9EeA5N81p078pq2hHgQlQKVxzK52fg6U8iocG/138Ln8wuErc/Bz
	 J3fJS5DnMdqZf+5sNN0x5wjTtLuooliqvVFvc88bxDi4BkSn/I2hY+B7Ceyu8hTHMX
	 9T0qZ9aY219mP2gwnNgkrvNFHofnMHGhYWbyUYHcN2ReShOCbZ2sBPP4cm5QWhU3xz
	 h/TjmUHT3ltWg==
Date: Thu, 19 Mar 2026 16:25:41 +0000
From: Simon Horman <horms@kernel.org>
To: mheib@redhat.com
Cc: netdev@vger.kernel.org, mohamed@pensando.io, brett.creeley@amd.com,
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, sln@onemain.com
Subject: Re: [PATCH net] ionic: fix persistent MAC address override on PF
Message-ID: <20260319162541.GJ1753385@horms.kernel.org>
References: <20260317170806.35390-1-mheib@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317170806.35390-1-mheib@redhat.com>

On Tue, Mar 17, 2026 at 07:08:06PM +0200, mheib@redhat.com wrote:
> From: Mohammad Heib <mheib@redhat.com>
> 
> The use of IONIC_CMD_LIF_SETATTR in the MAC address update path causes
> the ionic firmware to update the LIF's identity in its persistent state.
> Since the firmware state is maintained across host warm boots and driver
> reloads, any MAC change on the Physical Function (PF) becomes "sticky.
> 
> This is problematic because it causes ethtool -P to report the
> user-configured MAC as the permanent factory address, which breaks
> system management tools that rely on a stable hardware identity.
> 
> While Virtual Functions (VFs) need this hardware-level programming to
> properly handle MAC assignments in guest environments, the PF should
> maintain standard transient behavior. This patch gates the
> ionic_program_mac call using is_virtfn so that PF MAC changes remain
> local to the netdev filters and do not overwrite the firmware's
> permanent identity block.
> 
> Fixes: 19058be7c48c ("ionic: VF initial random MAC address if no assigned mac")
> Signed-off-by: Mohammad Heib <mheib@redhat.com>

Reviewed-by: Simon Horman <horms@kernel.org>
