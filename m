Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 362D030F52B;
	Thu,  5 Mar 2026 07:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772694927; cv=none; b=jHSUumOILpSvjHfD/jJkipMCk1WP0+dMxCAb02NFT9mUYSBfhgAR5PHfogydEj/Jrr6n4IMkOuZT4mawxldVJUTg5wuVvLs8AAAJqHuGd40JmZWdqtFCvugfys6YF6PwTtnjDvtnqVuwPmGCTt/Cck0jpT4SqkUDOgPdwO35ax0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772694927; c=relaxed/simple;
	bh=YZkWyV9KaGhrSn2F3IIWuBMMR69QfwAtmjviKTU95F8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YUIJHa+qP9UiN/p3WyTqJeKnXnHR7ke1NX1ZpeDm371w/oojtovmBUns/F24+ZX+ixNDYJZATdEGjVNiRPQ3WSCiwn3UNUB+YEIRyUArVbuqvG+n5oXg1q+1zdfh/39jlJcfCyidiz6eZCgOrQODS6go/ecNDeZYLQOZ3o5yFn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=O55qUSAr; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="O55qUSAr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71BA6C116C6;
	Thu,  5 Mar 2026 07:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772694926;
	bh=YZkWyV9KaGhrSn2F3IIWuBMMR69QfwAtmjviKTU95F8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O55qUSArqBm+5jqGYKXKFTwqF9bGDdpw3e6UM90kgpPZ6rO58095BjsVGcbZagmdX
	 amg50i+QM+ED/ocI9nJk8opYTtwODkUuSp+IdH3aJw/fiQmZeyYtnsE3CIL/3u93gw
	 iITyLHJw8yS6otEwHGR+EQu62Hz0KXuWQT4fzGko=
Date: Thu, 5 Mar 2026 08:15:12 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Cc: stable@vger.kernel.org, sgarzare@redhat.com, netdev@vger.kernel.org,
	mkutsevol@meta.com, thevlad@meta.com, christinewang@meta.com
Subject: Re: Stable backport request: vsock namespace support for 6.18.y
Message-ID: <2026030538-nearest-dumpster-481e@gregkh>
References: <aajWMBoSgXafmw8b@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aajWMBoSgXafmw8b@devvm11784.nha0.facebook.com>

On Wed, Mar 04, 2026 at 05:02:48PM -0800, Bobby Eshleman wrote:
> I realize this may be a long-shot/big ask, as these patches definitely
> fall outside of the 100-line diff limit and it is a very new security
> feature for vsock.

It's a new security feature, if you wish to have that, please just use a
newer kernel release.

sorry,

greg k-h
