Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA14043B6C4;
	Fri,  4 Sep 2026 13:37:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529038; cv=none; b=S9NIE6JE10281HKkN44oyVCcxAyjny7Df9NckgpyTFU5k0XSv/5omEezLxFOSHmTKw27UfXv/53kGc09kodsH9I/cLeYlA/96WJ/yeBfnbXukqjzExBxFChJBrbybNWQN0jGO0+nnTmaRn4/XNJb5AYsGHYcchCY5z1jxDYurtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529038; c=relaxed/simple;
	bh=16aecuGOrIiDRDL6Z0PaISMOQweR9D8YgbKVBT3h03Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uOOk0jfUpCUbEjW1Qs8SSGcRqqF5ywWdox14TpPMzZaQgcPDiWHLZbEdihqBQV3HtUE9ALTmdRVS3xUF5+sNERtcTT4uEvhGJbEOHloujkFdA3O1la38dWxK2+XtYrY04oyHZPNl4N17IZHuY62OvNA+TDUOZdRU8k3Llag0pG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=2t77N9Ip; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="2t77N9Ip"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=y1z8NzF70GzZT5JberU6kWFYdzKgeuIUvY6fIRAsajw=; b=2t77N9Ipr90No1c0Xv4ChyGXSO
	TYSL5H6xSeSE/5oyV2tiBOhexmsF9W8eGod0W+ip3t3yg4cj4Fs/JyIJPDfVvG9SGIqYEpu/r/VtK
	/9oZXPJ7sB7I8TxwHRk2JR0/Z/SeN/iUdKY/+Al5aS4APoQDBWOz3BWltszo8/b/jfNQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x2U6O-002zRC-Oc; Fri, 04 Sep 2026 15:37:08 +0200
Date: Fri, 4 Sep 2026 15:37:08 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Kyle Switch <kyle.switch@motor-comm.com>
Cc: olteanv@gmail.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com, mmyangfl@gmail.com,
	horms@kernel.org, linux@armlinux.org.uk, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, ming.xu@motor-comm.com,
	xiaolin.xu@motor-comm.com, jianmin.wang@motor-comm.com,
	wei.zhang@gl-inet.com, sijia.huang@gl-inet.com
Subject: Re: [PATCH net-next v5 3/6] net: dsa: motorcomm: relocate MIB
 polling initialization to dsa_setup()
Message-ID: <67c8bdef-cf57-4233-a552-ad715f24c47e@lunn.ch>
References: <20260904095416.1692962-1-kyle.switch@motor-comm.com>
 <20260904095416.1692962-3-kyle.switch@motor-comm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904095416.1692962-3-kyle.switch@motor-comm.com>

On Fri, Sep 04, 2026 at 05:54:13PM +0800, Kyle Switch wrote:
> Move MIB polling start from probe() to dsa_setup() so that it can
> be conditionally enabled based on the actual switch family support,
> avoiding attempts to enable it on unsupported switch families.
> 
> Signed-off-by: Kyle Switch <kyle.switch@motor-comm.com>

Much better.

I would word the commit message slightly differently, in order to make
it clear what this patch does vs a future patch.

  > Move MIB polling start from probe() to dsa_setup() so that in a
  > future patch it can be conditionally enabled based on the actual
  > switch family support, avoiding attempts to enable it on
  > unsupported switch families.

What you want to avoid is my asking, did you forget to make it
conditional?

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
