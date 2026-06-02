Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3F9539A068;
	Tue,  2 Jun 2026 05:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780379903; cv=none; b=qYy06B/rrKOTB4KTZTrCRuIEwxfyeCKCzH0u8oakevKQYQk5qzxa69XwGkj1EKeF5do8k0kBjGGdgr0qBxWkCwzVyCnczLqKTWEae+aDvp0TBIGfkbOoZzfbVM2L3FQvZak1qTKrvsfZTJ5C5NGmXGtL8u/j55/KS8p8ZjnrHLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780379903; c=relaxed/simple;
	bh=w3MH5hburrr3G8LREx6PSGdPBu8q1gO/QTJal4Ijyx8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OTkcuY33w9tJ35FpdeFn0uG/tSRr76anG0VnYp6SvxSxklXSGocOzHYU88SFgJch4AAfP5QrE+lhGLQPh+bMa0cTBRD6n82/ZB+qcK/v8FMsBLWwqpD3xY3nOH5+MCaBZBkmAcdEtPXHU8cKwvGAkAvofdrIBn+F47uU3l9VBp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bJW1kDdf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bJW1kDdf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFBCB1F00893;
	Tue,  2 Jun 2026 05:58:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780379902;
	bh=i/FErISb+2QnG1P6pu4OzfuEn7EsXrCTB7tFZI6xt/Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=bJW1kDdfNtPpXHSmmydgicC+jRCKoyenJ0pTetch8dufqFBZT8OAnclAKC+6nmeGW
	 1+nkcnPHd4QwtYeuhmTNl9V3QI5TfdCmZfp5IjG2nknuig1l4SPcxjuIS0Qwh1J7vT
	 0xvVp2qmHWksOHK5+wOII9EPoLxHsBpmdIPJJemU=
Date: Tue, 2 Jun 2026 07:57:26 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Grewstad <dogestad24@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, jic23@kernel.org, jacobsfeder@gmail.com,
	linux-staging@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, hjk@hansjkoch.de, davem@davemloft.net,
	netdev@vger.kernel.org
Subject: Re: [RFC] drivers/staging/axis-fifo: TODO file and subsystem
 direction
Message-ID: <2026060202-wad-skittle-263f@gregkh>
References: <CAD03fjaBJGtNATBxaYO-PAxdKC=HxYgE+M7HQ_a0O+3Sp9Mruw@mail.gmail.com>
 <84d8f2a1-6562-47a9-93d7-2d7ff33c31c0@lunn.ch>
 <CAD03fjah2GMedDtauPQjP0++3USpy6tm3AUemgAjVHS=5Nirtg@mail.gmail.com>
 <8f7eb9c7-6695-450c-81c4-fb96643adbc2@lunn.ch>
 <CAD03fja5oG3-BrQoy4+LEmCWPYGW_JWDEkaPndjSVz=PbRj4wg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD03fja5oG3-BrQoy4+LEmCWPYGW_JWDEkaPndjSVz=PbRj4wg@mail.gmail.com>

On Mon, Jun 01, 2026 at 10:15:49PM +0530, Grewstad wrote:
> Thanks. My research shows that no user-space application depends on
> this driver. As you said, we cannot determine the subsystem without
> knowing the actual end users.

If no one is using it, why don't we just delete it then?  It can come
back if someone shows a real use-case for it.

thanks,

greg k-h
