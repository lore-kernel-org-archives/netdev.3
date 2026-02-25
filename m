Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24B2D273D8D;
	Wed, 25 Feb 2026 14:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772029881; cv=none; b=Zc0N8mJ2eGyZD4WkbJvj+RXg15HlShKAD54rsBc897HDuIqs73oPyl5Wgc4+1aHqV7hZoeB56A/zaGtbb3Qvgm1CV/tcfTc9iWSkGCpc1ssSzPAhLZ5KkMclONSnxLAVBfwo0rdoYia+xWDQajoVPr9oLhpPOykgdK7TQhtFVYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772029881; c=relaxed/simple;
	bh=B0S7Rd+h6N6IKNOomazsVTs7waWASyt1VkHyU82BipQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m9v3ZIzemIyHuctWhn/WvJ2iR7aeOoYVc8mzhJuboi6TzJBvxOZGOT55nZxbKvfXmOhSqdudHA2oiwguKtfcf4oTr9h3Y0KLjxtxy5SuQuRxE589n8wcn4zZMYMCfbgLAYBFBsyXNqjOvXkf7M1b5e1csiJXyB9u85J1ORtd0N4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U/GUKXyN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U/GUKXyN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86CC9C116D0;
	Wed, 25 Feb 2026 14:31:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772029880;
	bh=B0S7Rd+h6N6IKNOomazsVTs7waWASyt1VkHyU82BipQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U/GUKXyNBZFnLpUyW4VCTGCc/YVR42bktsNoX6LC5kipIZ4p/AuC0+ns2Etn1tKr9
	 k9pS+SDKJpncptztmrQflQ9PIqSVbB1SPYgz16+8v5Awupbi3oe8jVjRMsXjenwO+a
	 Oiwfrm+YXdCTG/VcMyYio9hVQczghz80rS1uzQZI=
Date: Wed, 25 Feb 2026 06:31:12 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable <stable@kernel.org>
Subject: Re: [PATCH net] nfc: pn533: properly drop the usb interface
 reference on disconnect
Message-ID: <2026022536-douche-concert-544a@gregkh>
References: <2026022329-flashing-ought-7573@gregkh>
 <aZ1sjK3LwiLDt4F2@horms.kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aZ1sjK3LwiLDt4F2@horms.kernel.org>

On Tue, Feb 24, 2026 at 09:17:00AM +0000, Simon Horman wrote:
> On Mon, Feb 23, 2026 at 12:28:30PM +0100, Greg Kroah-Hartman wrote:
> > When the device is disconnected from the driver, there is a "dangling"
> > reference count on the usb interface that was grabbed in the probe
> > callback.  Fix this up by properly dropping the reference after we are
> > done with it.
> > 
> > Cc: stable <stable@kernel.org>
> > Assisted-by: gkh_clanker_2000
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> 
> Hi Greg,
> 
> As a fix, a Fixes tag seems appropriate.
> This seems to have been there since the beginning, so perhaps this one:
> 
> Fixes: c46ee38620a2 ("NFC: pn533: add NXP pn533 nfc device driver")

Fair enough, I don't normally add Fixes: tags for my stuff as it's me
doing the backports to stable kernels once they hit Linus's tree :)

> That notwithstanding, this looks good to me.
> 
> Reviewed-by: Simon Horman <horms@kernel.org>

thanks for the review!

greg k-h
