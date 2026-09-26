Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72746374E6C;
	Sat, 26 Sep 2026 17:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790442388; cv=none; b=OYYmBjUA/s6e9353dkkaf+YDfhoyrEoc8a/5RVZuebfSLqDU+YHhrWmi8Gjg8LZciuWxSriL5FS1yOeptzS6dvRtFSHHlc3K0MQjdehkMusg4dAjCMJo19q1tbbW1QM65PzCgUoTGMNcEZUDoS+AY3uqrkdajWp3XVfkrZN+/VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790442388; c=relaxed/simple;
	bh=vCd5Y3vvzb9+oOaMV+TFqQIOG2qOzXkNRwcf0+3Qdo4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=teD1Y8LMEp+jStxNiOg/4Aw05s2HZ+EsQrM1WlR4o+cN7L2jMVv8SlceXKKbYtz88gff5tH+cei3PLrL1FLteHXw7LuTnCHkNEEKcAPlasyvrIT5Zy4raQIj2ObewDtCnH6TcKumyGFSMAoOIdJ86s169q6dFXtvwEFEoEhBqic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QzzslouL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QzzslouL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C04651F000FF;
	Sat, 26 Sep 2026 17:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790442387;
	bh=9BtdidpngfnWVUC1HsuxdkJBJ3X8fnJBx/TSKgGd9xU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=QzzslouLHrok74kyX6JcCbT1TmdPtqI/kWukYFpYCCvLd6Xzwqq1uBE81GDqzW7nM
	 jvjh0iawlHEMy5CpDSux0SWmAdatDap5JO5rAoynX9ztee+sRf92eOWjR3W60/IM//
	 Qb55zAmOFE3HYfGcNmq4xrINtemsHFZYtLEWf/eG85kS4gCXFUtv5UPY0zBdO/GCE7
	 FBH6Umm2ytvp3aq45BG04eacit6EX9RRCCKVcOvl05RfFa1DQVr1iICFsmeI18Y63h
	 bJo285q9xd3wHX0GT3ds2hq86s0+pnsoFt1XXFYy3ziGITav66eVIul0yM91bqWuq7
	 BR69WOo6hNBJA==
Date: Sat, 26 Sep 2026 18:06:22 +0100
From: Simon Horman <horms@kernel.org>
To: Grzegorz Nitka <grzegorz.nitka@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, richardcochran@gmail.com,
	andrew+netdev@lunn.ch, przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com, arkadiusz.kubalewski@intel.com,
	davem@davemloft.net, edumazet@google.com,
	Sergey Temerkhanov <sergey.temerkhanov@intel.com>,
	Milena Olech <milena.olech@intel.com>
Subject: Re: [PATCH iwl-net 2/2] ice: remove redundant cross-timestamp PTP
 command
Message-ID: <20260926170622.GB13925@horms.kernel.org>
References: <20260925222824.270640-1-grzegorz.nitka@intel.com>
 <20260925222824.270640-3-grzegorz.nitka@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260925222824.270640-3-grzegorz.nitka@intel.com>

On Sat, Sep 26, 2026 at 12:28:24AM +0200, Grzegorz Nitka wrote:
> The cross-timestamp capture path programs GLTSYN_CMD with READ_TIME before
> starting the ART/device capture and clears it with NOP afterwards.
> 
> It was assumed that this change was needed for E823 devices, which
> turned out to be not true. The hardware supported by this driver
> does not require it.
> 
> Since GLTSYN_CMD is shared with other PTP operations, touching it here
> only adds a potential race source.
> Remove the redundant source command programming instead of adding another
> guard around it.
> 
> Testing hints:
> Verify crosstimestamp path, for example with phc2sys tool, on
> E822/E823/E825/E830 devices. Please note that the phc2sys tool performs
> cross-timestamping by default when supported by the hardware. This can
> be observed when the reported delay is 0, indicating that the system
> time and PHC time were latched simultaneously.
> 
> Fixes: 88c360e49f51 ("ice: Support cross-timestamping for E823 devices")
> Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
> Reviewed-by: Sergey Temerkhanov <sergey.temerkhanov@intel.com>
> Reviewed-by: Milena Olech <milena.olech@intel.com>

Reviewed-by: Simon Horman <horms@kernel.org>

