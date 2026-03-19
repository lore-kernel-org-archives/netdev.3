Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12A823DEADC;
	Thu, 19 Mar 2026 14:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773932373; cv=none; b=MWcRPM1X3tp2pQi55A389MgwQvl/2UcuU7H/oQqR6oJsscWE6HgoLRxg31t8AfhU2uz9MjyQXxEW4qRejfFevAFC3iT0A7bMFm+SbZucVIhOnDk7ZpGF5ZqspdXs5d44RFWo8lnpdymjZTHF38+5kAM1h6207hVuNRxBkg+aWJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773932373; c=relaxed/simple;
	bh=wRKFuj1RBd5OZOCmeqHIDv8olqwZDaGYrjqF4N72VFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RHlJ8dRZlQMbtveTVnNUfA2nqWwB5Z2gFpisORQWjILR4yQHFNG46SZfesnLqbu4Pn/XPv/1TyZZDg0IuxeLs1yvDh+rz+8GNGId+0tUOPvT9jzynvwCf1QWsoNeR+ev0A89r0MXgUfN3UDB8ZixlBWFSpl66I16PPygNa+J4h0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jW7rO0Qy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jW7rO0Qy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53334C19424;
	Thu, 19 Mar 2026 14:59:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773932372;
	bh=wRKFuj1RBd5OZOCmeqHIDv8olqwZDaGYrjqF4N72VFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jW7rO0Qydnm24fZKKcNCk97+5Di3gMM+w16JSsYYW7tDtJp8J3pvi9WBBBzht7Zxh
	 dNFCYlDNcdV+fZwaxhrxXOFxyAJhHxe+vHCiZdVszjUQ5eoOuoP9OmqFA0zGMVzliZ
	 h3HPi7AKag3uiE8aF1QXJXkXLsNp0vgEZ+WH7Qmfw4+ljSIfnVFtuMu0/REh97DcxT
	 7iR6kJkVmbQgIKxp3tA04eOS4QpiNxsJ9oUo+gVw6J6QA+5Mg3ZILbvmV+swM1MKj/
	 XjUC87ffsuXDpc8EQPT37CLR67gh92yBtV1tpDAr22vxx6BSKO/Joi/klO/asPmBES
	 zjxeZO8y0oMVw==
Date: Thu, 19 Mar 2026 14:59:18 +0000
From: Simon Horman <horms@kernel.org>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: wei.fang@nxp.com, netdev@vger.kernel.org, xiaoning.wang@nxp.com,
	vladimir.oltean@nxp.com, kuba@kernel.org, davem@davemloft.net,
	linuxppc-dev@lists.ozlabs.org, krzk+dt@kernel.org, frank.li@nxp.com,
	claudiu.manoil@nxp.com, chleroy@kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	robh@kernel.org, imx@lists.linux.dev, pabeni@redhat.com,
	f.fainelli@gmail.com, linux@armlinux.org.uk, edumazet@google.com,
	conor+dt@kernel.org, andrew+netdev@lunn.ch,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [net-next,13/14] net: dsa: netc: initialize buffer bool table
 and implement flow-control
Message-ID: <20260319145918.GF1753385@horms.kernel.org>
References: <20260316094152.1558671-14-wei.fang@nxp.com>
 <20260318145452.1898637-2-horms@kernel.org>
 <3dab3f5b-fb94-4c63-bcfd-aad4268e2ac3@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3dab3f5b-fb94-4c63-bcfd-aad4268e2ac3@kernel.org>

On Wed, Mar 18, 2026 at 03:56:39PM +0100, Krzysztof Kozlowski wrote:
> On 18/03/2026 15:54, Simon Horman wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > 
> 
> Why are you removing the "PATCH" part in the email subject?
> 
> This completely messes up with the filters and causes this email to pop
> up in places it should not.

Thanks for pointing this out.

I sent this patch using some tooling.
I'll look into why this happened.
