Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89DD71509AB;
	Mon,  1 Jun 2026 05:54:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780293292; cv=none; b=Se6NVSKr/WKs+MLbiAXheDvugMmDPrHHO53uxPc3KAA96phyLWOJukt6m4LE0WYTccQZWXly6ZTygnHlrHjF8dJ1TuSF85f0GQ1RNPLWCiLImE3fwH2fY+skUiZU5ROAleI/B7uTtV7ebbLuXygMhBu0dLMj4wFhCAh1iaRTOUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780293292; c=relaxed/simple;
	bh=wExcRSxFkuXG92zBlQPobM0gnRmiENzxEEfbMcajwwA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mncPG9ZjnHwImQtf0X0lTu/htOLQERVZTkGiI6cz9H1kenNljiYa38UPYK23yl4U5Qx+QdguJiHMkgeYZ3DF5zGnvoN5WUvFedhEnhHAU+u6x8AeEo5TghfBViJKouSLj/H5kDNAIBSFEbj9caLD9IJjEhGx80jZ4ijcXwvGm/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=jFdRYIcy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="jFdRYIcy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 944AB1F00893;
	Mon,  1 Jun 2026 05:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780293291;
	bh=wExcRSxFkuXG92zBlQPobM0gnRmiENzxEEfbMcajwwA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jFdRYIcyAAGbjJXIMXUw03Kp5cBuVOIKu7vaBiMxcS/AzD0pRnkKa5mCqMUYndnAC
	 T+S19C6pFLldq6JH2I0wKKbnObYwxawC/VrKhVuvuKndzHELA7fxUvK7ui+0n0dXXN
	 rqkjMvGOYeAL90+BgtMA2abrAvnT3UFf42Sv2MXw=
Date: Mon, 1 Jun 2026 07:53:55 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Grewstad <dogestad24@gmail.com>
Cc: jic23@kernel.org, jacobsfeder@gmail.com, linux-staging@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	hjk@hansjkoch.de, davem@davemloft.net, netdev@vger.kernel.org
Subject: Re: [RFC] drivers/staging/axis-fifo: TODO file and subsystem
 direction
Message-ID: <2026060113-clothing-chummy-1732@gregkh>
References: <CAD03fjaBJGtNATBxaYO-PAxdKC=HxYgE+M7HQ_a0O+3Sp9Mruw@mail.gmail.com>
 <2026053145-bungee-flyover-840a@gregkh>
 <CAD03fjaxcS0rfZbNPNQjg7HxAhhTvOBxH=p-Rj_ngaGBPmpXMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAD03fjaxcS0rfZbNPNQjg7HxAhhTvOBxH=p-Rj_ngaGBPmpXMA@mail.gmail.com>

On Mon, Jun 01, 2026 at 11:09:36AM +0530, Grewstad wrote:
> I don't have the hardware, but I plan on testing it using QEMU.

I wouldn't recommend this for cleaning up and getting the driver out of
staging, as QEMU might not be working like the real hardware does.

good luck!

greg k-h
