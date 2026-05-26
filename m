Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02593C5823;
	Tue, 26 May 2026 22:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835041; cv=none; b=RiJ8PgjyLRI27kbik5XxoDPkh6tPA5e/hJM5/wXtVFSx1hc6fyrxadY80ij0vP2omFI11OqSsFSST3WO0eXm2p4CZgDyK1O51iAo7+gcxjl4cDFyIDYX0JCkyGXij0jfWmZeZeKKcP3lF8qv9ly1yUnnm83gBY6F5bSTuEA8qGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835041; c=relaxed/simple;
	bh=t3DDdLoiDpa5mzDeyTIAK0ED3ZALYS30CX3shJvZjNM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=b0phnpGx/F+yPEGtXWI1NENA4rB91QvV6zXSgPJ4E+1dT0JfTekXLsHoQO4LEdG+mC3eMt2LewbQzqqXB1UFPP9go7zDiu6DQz0nBa9TXVZflrlgJTC/pqdflhckNqjfAVRNV9wRQhjJQP3Do5I4uW3JB3ZYb5yewHpcgV2buss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DtIR2Glq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DtIR2Glq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082271F000E9;
	Tue, 26 May 2026 22:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779835040;
	bh=t3DDdLoiDpa5mzDeyTIAK0ED3ZALYS30CX3shJvZjNM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DtIR2GlqYowlJKZ/IiOqFfgZPFXIFmw+EyJGl8R2Oi6Nv5TM9WfpLxSMQlXsc53rU
	 q3oy3eg8h/BsMh6eGUMMmQO2dA1Osw6VmkvlJw5p3WFUjyD9SvP9YWqzsxMDhIb3Q7
	 l5jFMpAMZwOS9LgPsD2wvvRpUZfR4ccsby+Tke0YdupjlppBLcEWaOZqDIR96V5FQ0
	 R5CK4U08pLzhgP7CvR/DTDm40QByuiy4KYUVjnTn8cfVD/NseLl8ATrqw3MVppYyoV
	 2TwW2iSGVBWNM+zl8ORfUR48vEbZ0SiJLcL+MYBLyCIgfZeUqIUPvSOneFQPpLNCfm
	 f9vCHAebIY1bQ==
Date: Tue, 26 May 2026 15:37:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, andrew+netdev@lunn.ch, horms@kernel.org, corbet@lwn.net,
 vladimir.oltean@nxp.com, willemb@google.com, sdf.kernel@gmail.com,
 ecree.xilinx@gmail.com, jesse.brandeburg@intel.com,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH net-next 00/10] docs: net: updates for old and cobwebbed
 docs
Message-ID: <20260526153719.7261b7f2@kernel.org>
In-Reply-To: <1c341b25-e720-4f63-9db1-99348c8ebed9@infradead.org>
References: <20260526160151.2793354-1-kuba@kernel.org>
	<1c341b25-e720-4f63-9db1-99348c8ebed9@infradead.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 11:48:41 -0700 Randy Dunlap wrote:
> WARNING: ../include/linux/netdevice.h:2622 Excess struct member 'ax25_ptr' description in 'net_device'

I wonder how that sneaked in? ;) ;)

I'll clean this up separately, hopefully we haven't regressed too many
things while the script was broken :(
