Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194E03CA4A3
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 16:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773420938; cv=none; b=b/zZBuSH6vSynNfAEjNM4nCgkDwciTPB/AkXx/8YfZABQ3n/tYWyLHlfQ+ur97d6asXNC7vrTDvCHnwoyu8VYDB0AQPYOajNrlYZkyC2HKp0+3BmjKUVUml7marV3PJLSnq/ze6b/P7/kHG6V/884dLTE/c8ja+ImzkPGjcbk4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773420938; c=relaxed/simple;
	bh=bCEib9e61yOx+aorpYgwn/Y8kV+PWIh5u9B99KkhFhU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lgMfTjyiiipOijicvXI+Gihy8ythX3ruypwuu6+d2BpwY4YXpzxvhFUoYh4oDV4nT5mBZ1ua+PfCc2CiZ+25r6f7/IuckdFWV9HT1nInzisxc986iYcS3QRE0utczw1UisJV5VMVLJd0xqS//s/Pt6cYtamApVmHXLNWO6mdcXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFDiDFHu; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFDiDFHu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DACBC19421;
	Fri, 13 Mar 2026 16:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773420938;
	bh=bCEib9e61yOx+aorpYgwn/Y8kV+PWIh5u9B99KkhFhU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=MFDiDFHuE3o4wt0kNO9gCgEBw4mID5LEDbTEjJjzgqYaorbLL9ZlYw0qwM/WaF8xO
	 +k/CriTnanQ8hVgpy268Jc4hALBMJDR+BX8dPyBdLpLQa6RElnwwcC9ZcFVe8ylIc5
	 14T5cCkI8SEyIHZrKoa++HE7lra/mtbOs/dtwifyWRAvxMJLZdoHJIyUfmH6L9Tguu
	 wOsR8isrLeJZyX/uy4I2NoKkROVfsOw24BgbDxyrSJXeP69zXRLQ1AEjVev42YGMz9
	 Z+VGZt+tFvUPDOLcGKXRe8657KrB+HNppfpmMmSf4Rig6s+eD9ATeEh+Bzw2ee2sjE
	 8CD1TO0ZNoTXQ==
Date: Fri, 13 Mar 2026 16:55:33 +0000
From: Simon Horman <horms@kernel.org>
To: justin.chen@broadcom.com
Cc: netdev@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
	pabeni@redhat.com, kuba@kernel.org, edumazet@google.com,
	davem@davemloft.net, andrew+netdev@lunn.ch,
	florian.fainelli@broadcom.com
Subject: Re: [PATCH net] net: bcmasp: fix double frees during remove
Message-ID: <20260313165533.GA1368619@kernel.org>
References: <20260312200814.1977164-1-justin.chen@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260312200814.1977164-1-justin.chen@broadcom.com>

On Thu, Mar 12, 2026 at 01:08:14PM -0700, justin.chen@broadcom.com wrote:
> From: Justin Chen <justin.chen@broadcom.com>
> 
> We have two double frees during remove.
> - We do not need to free wol_irq since it was instantiated with
>   devm_request_irq(). So devres will free for us.

Hi Justin,

The above seems clear enough.

> - Switch to devm_clk_get_optional() instead of
>   devm_clk_get_optional_enabled() so we can manage the clock ourselves.

But it is unclear to me what problem this is solving.
Or how it relates to the first point - usually the aim
is to have one fix per patch.

Could you elaborate?

> 
> Fixes: a2f0751206b0 ("net: bcmasp: Add support for WoL magic packet")
> Fixes: 490cb412007d ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
