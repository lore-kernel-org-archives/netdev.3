Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793191254;
	b=rw94fNYHLd3tPQZ4QcSCNOwK0nJlNNYaISUV8ZdlRQm7tdPp0oh5X9Qv9n3ddfxBsqM/
	 aFVdFTIuklHDUU6/uQTazZRMT56dYXpnboC5ANA4JWy+Fa9jQ8zvevp2qWhfb+wpNe/js
	 diew3It4EucDe+FJJQVUuth3POEoB/KsAHkho8AT3CIGwAc//HkP4vkTRE8xDyDHmwTug
	 FzWxEE3Phwxcp2ifYJOdRjDxzizuh+yRtx5Mu1J0vrr3BtImigRTgDV+cE6QZKeBznMUn
	 BcYlv8TX/UFX4TYr8f50Xy8F3p8T541j7MBHtyypnSrkkDLv6A2BFptI7mAhC5RQaIg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793191254;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=EvRAg2OM+ugAGhu9Cggh6QaXyo7DsnZV7IjaB9/bEL0=;
	b=wwMsVytqjV0u0X5IVuHWgVMX32qB923y7Ie1Ka6cQ3Owv28IlHt2jYALZ8aGa/pVbbNf
	 /Xo19aE0UD5fW/cFaNfUagcnMcFpo4ufoQm8JpjNGcnKht5zb3hp/W3d5Kus/KzNcZscB
	 ixDu2HFdcnUod6x6Cawq2PPpZo8NvWST4MQhZ+qpZ3j8PJQETlCEo8+NDRBdtXNVSxNnr
	 HH6sJYkY5gBCf3nLltmGs21yyGqZO3w8aOZEeKwNR2v6FLQybw+c4dMbMWJXcmECQhCNb
	 n4MTmlOos8Rs8cpM7iG8L49JMSAGlTJEpnKHHR6TGLf8fCT/PCskexQ8V237oCH0fVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="aZQ/bvCL";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FA6606A31A;
	Wed, 28 Oct 2026 12:40:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aZQ/bvCL
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45EA11F01825;
	Wed, 28 Oct 2026 12:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793191253;
	bh=EvRAg2OM+ugAGhu9Cggh6QaXyo7DsnZV7IjaB9/bEL0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=aZQ/bvCLuJtmFK3p1a4fvb7C5mYtPN28C/I9yKSeqL0qnyZnljcV9Q0Duwm+ragE8
	 4WuRieNPkIpde5yN7LZbpB4ZwXPqXsdapoxVyHRW4UY4yyi2jBsCT939ifQEoEVlS3
	 EGEcZXelnvcY/dr1vq2SoiGgdqV2ufHHJkLgt69uczNsVnR4Vu16Bl0InXNOv3Ysp6
	 WrQFlsIaSMCrLfRPvgiKyFouIKzZZWZBQo1op3/fdwDzNect3rt5wV0eqxmufELch5
	 stmS+t4twhVgfF0LLuF0dmH9ClcCgQKz5zgUaAk44IWLCD5tMu4hEmpWgl4I+3JI8E
	 vFXkza2QL5SvQ==
Date: Wed, 28 Oct 2026 12:40:48 +0000
From: Simon Horman <horms@kernel.org>
To: Yibo Dong <dong100@mucse.com>
Cc: netdev-bot+sinfo@kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@kernel.org, kuba@kernel.org, pabeni@redhat.com,
	vadim.fedorenko@linux.dev, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, yaojun@mucse.com
Subject: Re: [PATCH net] net: rnpgbe: Accept link-down events without speed
 magic
Message-ID: <20261028124048.GR257209@horms.kernel.org>
References: <C2DFBBF04F1DCFD2+20261026075445.920572-1-dong100@mucse.com>
 <179300162296.3327.8577140950893281339@kernel.org>
 <5A927C9600407C98+20261026092615.GA933559@nic-Precision-5820-Tower>
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
In-Reply-To: <5A927C9600407C98+20261026092615.GA933559@nic-Precision-5820-Tower>

On Mon, Oct 26, 2026 at 05:26:15PM +0800, Yibo Dong wrote:
> On Mon, Oct 26, 2026 at 08:00:22AM +0000, netdev-bot+sinfo@kernel.org wrote:
> > Hi!
> > 
> > This is an automated message. This series looks like a fix, but its
> > commit messages seem to be missing some information:
> > 
> >  - How the issue was discovered, e.g. hit in production, hit during
> >    development, syzbot report, manual code inspection, LLM or static
> >    analysis tool scan.
> > 
> >  - What hardware the change was tested on. For driver fixes please
> >    mention the device (and if relevant firmware version) used for
> >    testing, or say that the change was not tested on real hardware.
> > 
> > Please do not repost the series just to address the above. Instead,
> > reply to this email with the missing information, so that reviewers
> > can take it into account. If the series needs another revision for
> > other reasons, please include the information in the commit messages
> > then.
> > 
> > The evaluation is done by an LLM so it may be wrong, if you think
> > that is the case please reply and explain.
> > 
> Hi,
> 
> The issue was encountered during rnpgbe development and hardware
> regression testing.
> 
> The fix was tested on MUCSE N210 and N500 adapters with firmware
> 1.1.8.0, using PCI passthrough to a VM. Physical N500 is used as
> link partners.
> 
> With the unpatched driver, administratively bringing down the link
> partner left the VM interface reporting carrier up throughout a
> seven-second observation period. With the patch applied, the VM
> interface correctly reported carrier down.
> 
> The comparison was repeated three times per adapter for both driver
> versions. After bringing the link partner back up, bidirectional
> ping passed in every case.
> 
> If another revision is needed, I will include this information in
> the commit message.

Reviewed-by: Simon Horman <horms@kernel.org>

