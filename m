Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2CD3F6C59;
	Fri,  7 Aug 2026 09:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786095976; cv=none; b=MOIZzeYojMfFVPsNBYZqw+HQi0T8ecInoiuCJT1lRdmhzRh57G14t7Ln1/OKkJjtiAeT6gsuuIPkTtMRX4DoAIOxQp8LN9hGG80wCUwYIr04J+LZsGyJb/9caYdJmI8eLaSdGAUMrVvmwLV+AVWah2jyJcxnFcvsb2hKPRblB9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786095976; c=relaxed/simple;
	bh=N9OKWG6I9IaS/RwnlBzT77yvgO42QkjabsDcDXb+ubg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gpCV5AknuvqxXapm+2FcNvSOD4J32nhIPFDcQ9BjFKAbQhoUGoeL3H54OQdoNyx0X8LV2dm2udpoXXzbYAowlZKC1Box7+ciVFtbWZrtiXBVCCUZlU2P7JBz/8UElRbtPeKUCtjfFPoe2rwTQ/E+OmJclDN/ApAHeudO+IH9mEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ijTQHrzT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ijTQHrzT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A0661F000E9;
	Fri,  7 Aug 2026 09:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786095975;
	bh=JrvW/aP9EnaNe+CG46Gc+YyzW5Zy1RMicP8pdsjUpmw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ijTQHrzTO6g23Oyf+GGCatbd+zFM29SxQwWT63hzzOWj8I4rllY8M3z8RJmQ04fD7
	 QMdk5ZOy3nJBUxDYarqWL8yJxYRqqhMujfZBZZMmBS+/n4u1vx/ywHqwvrJAWZ4yQX
	 YTKmfnBmveHcSYc3V9xQPaetqv7I89/WCfpD5B/3o9EoQ0h19Z2hR+AHUgZOJXpxiI
	 o5gNMtAW8f7AnmUkcDsoArRnfyNsoLqbvx5kdlOz+OSccLMj+w9ENiJu0RJHnJ9KWx
	 GfJGjF61xZ8UFPMcqVp41GD2JO8kfVSzsR1USG1UkcGwIB5y6pNS19jQC+Mf61RpF/
	 ZMI/f5t8Dzv3g==
Date: Fri, 7 Aug 2026 10:46:11 +0100
From: Simon Horman <horms@kernel.org>
To: Manivannan Sadhasivam <mani@kernel.org>
Cc: Jakub Kicinski <kuba@kernel.org>,
	=?utf-8?Q?=C5=81ukasz?= Patron <priv.luk@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: qrtr: ns: Raise lookup limit to 128
Message-ID: <20260807094611.GH51943@horms.kernel.org>
References: <20260804201919.1148015-1-priv.luk@gmail.com>
 <20260806132630.GC51943@horms.kernel.org>
 <CAJmEJMzzuY=hJxo-0yPSfnOymcdd=O9zxmOxdeO_hCB3sbSrLA@mail.gmail.com>
 <20260806072702.71b2e604@kernel.org>
 <oqknkvlljjxfo5stpc3yicqzgs6g4an6lg7ybrll4zyvxr675q@hm23pe4cpxhm>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <oqknkvlljjxfo5stpc3yicqzgs6g4an6lg7ybrll4zyvxr675q@hm23pe4cpxhm>

On Thu, Aug 06, 2026 at 06:00:23PM +0200, Manivannan Sadhasivam wrote:
> On Thu, Aug 06, 2026 at 07:27:02AM -0700, Jakub Kicinski wrote:
> > On Thu, 6 Aug 2026 15:38:22 +0200 Łukasz Patron wrote:
> > > After merging v6.6.142 into a downstream AOSP device, it's stuck on
> > > boot animation and following log spam can be observed in dmesg:
> > > 
> > > E qrtr    : ctrl_cmd_new_lookup(): QRTR client node exceeds max lookup limit!
> > > E qrtr    : qrtr_ns_worker(): failed while handling packet from 1:16600
> > > 
> > > No idea why it needs more than 64 client lookups, but it appears to
> > > work fine with 128 as it did when there were no limits.
> > 
> > Ack, I'll fold the explanation into the commit msg. pls don't repost.
> 
> With the added info,
> 
> Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>

Likewise,

Reviewed-by: Simon Horman <horms@kernel.org>

