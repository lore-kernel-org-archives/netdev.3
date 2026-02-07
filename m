Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8F792BB13;
	Sat,  7 Feb 2026 15:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770477810; cv=none; b=mw8KM/S0F0qdseKSWtRuKUlTjX80E17wUdKY0Xi6f3NPQj1uwQYa5WPoRZ7UjpptA4j9l+3eEXhExSZ/0PN4fNdwD0UXoH5dNtw8TKG9NCY1+/0gfSQyFo2O27Z8mm7Zvbz4HWkcMhwW0sAUCdaHRcPvsxmQYO3ThB+DlUtTWVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770477810; c=relaxed/simple;
	bh=yb0vu3inmeFuOijnyY/2ABRIYBMbEedwtQP0k/x11NM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BVUHrE56CkhmYZtRBdMTbRT3OCq3g5W7mLmEoLpajpJlNrSa4gLdxGIakFTp4NQTzKXqZa/ckq7rzLeiMexSylZiWxGC8QRgLbaeqMPXtrvX2jck/xBQHoKbGbia0UzgL/c85lWq9gfc2lb9xkhotPNPX7uZmL6m5UQ0aRjbgkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WN8M8Irn; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WN8M8Irn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B740C116D0;
	Sat,  7 Feb 2026 15:23:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770477810;
	bh=yb0vu3inmeFuOijnyY/2ABRIYBMbEedwtQP0k/x11NM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=WN8M8IrnsS+GXNtOXULaKpy2m5v2nEI4Dugpo+HU0dmrOo+BA0iHNmvKEHMjgiJMC
	 f+6wi0Mm7iGqKL0CgA1nH1IC92srH/UNYAVmg7WmDhqOfHQZTKbk4G70FKHCCiHLqh
	 qbg/6MSLeN014ASA6lq6asNHxyvKFvYT0OjWEjys=
Date: Sat, 7 Feb 2026 16:23:27 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
Cc: stable@vger.kernel.org, davem@davemloft.net, yoshfuji@linux-ipv6.org,
	dsahern@kernel.org, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, kafai@fb.com, weiwan@google.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com, alexey.makhalov@broadcom.com,
	vamsi-krishna.brahmajosyula@broadcom.com, yin.ding@broadcom.com,
	tapas.kundu@broadcom.com, Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v6.1-v6.12 ] ipv6: use RCU in ip6_xmit()
Message-ID: <2026020719-gone-renewably-f94b@gregkh>
References: <20260205074722.2091297-1-keerthana.kalyanasundaram@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205074722.2091297-1-keerthana.kalyanasundaram@broadcom.com>

On Thu, Feb 05, 2026 at 07:47:22AM +0000, Keerthana K wrote:
> From: Eric Dumazet <edumazet@google.com>
> 
> [ Upstream commit 9085e56501d93af9f2d7bd16f7fcfacdde47b99c ]
> 
> Use RCU in ip6_xmit() in order to use dst_dev_rcu() to prevent
> possible UAF.
> 
> Fixes: 4a6ce2b6f2ec ("net: introduce a new function dst_dev_put()")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Reviewed-by: David Ahern <dsahern@kernel.org>
> Link: https://patch.msgid.link/20250828195823.3958522-4-edumazet@google.com
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
> ---
>  net/ipv6/ip6_output.c | 35 +++++++++++++++++++++--------------
>  1 file changed, 21 insertions(+), 14 deletions(-)

Does not apply to 6.12.y :(
