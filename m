Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3FB0357A20;
	Thu,  9 Apr 2026 21:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775771454; cv=none; b=D9j1mSxJ4UBcZ4zMSYAj4hMsk2hr38UZkBWjSPTc/OgosOmjUsVyalYOrlP1twXTwAX3mxcdzC3y6ZNizkZRT/jzwm0EuDI09tDYUvsvgf8vqO7LtKPcAZhcvf4U0hiDpAD2dp1INoR5q6O9T06wc7GRsz8VGP6BP1mWVymwvII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775771454; c=relaxed/simple;
	bh=7Zd/0SQLuYkQ67Zhg65ofr/Sd9wW7HGj8B+JFtSCZNU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FyXDCbZA8SbcoXjxNEzgID94dSUUJhrfsPEhSlTlGyymraegBkgYXbGAScLn2nuEqYVvVQJPdpQTJZyagPn3h2MsguvygL84lzleluaEnG4Nnf9jJ7CAXIdA+JhvuFEA4QRscxDvxaDcxFUvivwr5N+Ss3EwM+B1747yek6qvF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=kAicLZBW; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="kAicLZBW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=dY6Vz6hAAaV9HJTxqrSa4xia+kLa4HpIOsV1PmnpJfE=; b=kAicLZBWXdTIK3+Y9HbhrWkoSH
	orhfwAbdjXW8S0NeXhSfA3OYo8cUkNPkJ44cWO1dB8QMl+sbL9r14zXcxjTf8jYieNgGLUfyFW717
	mHLHNOEovoKlC+W1l/JyDXdfrHZHSJn/IFlwmWfUjHaV5MtyY8B3HsIHh3Yh8W3gYYUw=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wAxGl-00FUTN-BF; Thu, 09 Apr 2026 23:50:35 +0200
Date: Thu, 9 Apr 2026 23:50:35 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH v2 1/4] rust: netlink: add raw netlink abstraction
Message-ID: <a12cc023-629e-457d-af02-4c481024dda0@lunn.ch>
References: <20260408-binder-netlink-v2-0-c0d327d15435@google.com>
 <20260408-binder-netlink-v2-1-c0d327d15435@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260408-binder-netlink-v2-1-c0d327d15435@google.com>

> +__rust_helper void rust_helper_genlmsg_cancel(struct sk_buff *skb, void *hdr)
> +{
> +	return genlmsg_cancel(skb, hdr);
> +}
> +
> +__rust_helper void rust_helper_genlmsg_end(struct sk_buff *skb, void *hdr)
> +{
> +	return genlmsg_end(skb, hdr);
> +}
> +
> +__rust_helper void rust_helper_nlmsg_free(struct sk_buff *skb)
> +{
> +	return nlmsg_free(skb);
> +}

It is a bit odd for a void function to call return like this,
especially when the functions they are calling are also void
functions.

	Andrew
