Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F7C35BDCB;
	Sat,  7 Mar 2026 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772920640; cv=none; b=gd8Mum10R0hJ2U1UZzUtlIq7/VBHzL4p6778i28Nzrj5nBAAi8Csxi/+HsPW6ubii+1pLSNqu6m0rxw576tApYSeKr9f4pfgA6BnMYHenL2b6IoKt526pu7SZg0eS+xItbCClROgvtdfgwRPgNz04e01E2ouB1NKbJkf7cnLsq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772920640; c=relaxed/simple;
	bh=99M4VuiUwyQ2j0+BsOoEDhTe6t3pSU59HjbXD5IpkVs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NWxKVKHIjuuyJqd2zEtxj3bu2Ci+Uij0C+eriiFH2OuIlSFQo6JXvz93wf/27ljsaxHqLjmWpyZUOyn/+aREWQ6w+vAaQ1UqI0MJ2F6sKwTm/6HF2nS39cSWV+9U5PFPrR6DWIMYgdp0zxshWRlvNS/QWVVZ3qcCfQjTsLKfmus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=gnxNrxDG; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="gnxNrxDG"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=WyD3akZ6snIIF8wdvZDEhv9RdHIGsOCzt0lWUwHBS0k=; b=gnxNrxDGKhBw8txpCJD3Xsr5rq
	99pgbNCWaKQ26if8o04Ee1hqvDneQLjU0s7ulkMPKdUXqhVmsliSaROBJqlF+iyn/COsXdOu20LG0
	nCPva+ysB+S/jzYRyUdU/e1DiN44aOA3bExEuMPwD1s2Aj3D9gJ2x41an9ylRoF1S+lg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vyzMu-00Af0y-Vd; Sat, 07 Mar 2026 22:39:28 +0100
Date: Sat, 7 Mar 2026 22:39:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Arve =?iso-8859-1?B?SGr4bm5lduVn?= <arve@android.com>,
	Todd Kjos <tkjos@android.com>,
	Christian Brauner <brauner@kernel.org>,
	Carlos Llamas <cmllamas@google.com>, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/4] Rust netlink support + use in Rust Binder
Message-ID: <42407d43-00e9-4938-8d6c-70d83b0f2ac9@lunn.ch>
References: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
 <20260307104131.4c1d0de5@kernel.org>
 <aayWSuOM59uojtuG@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aayWSuOM59uojtuG@google.com>

> > Please no duplication of existing code in Rust.
> 
> The plan is certainly to get rid of C Binder, but it was unfortunately
> not possible to get there without a transition period.

Dumb question....

Why?

You are just sending messages to user space. Does the rust version
send different messages? Can user space tell the difference?

     Andrew
