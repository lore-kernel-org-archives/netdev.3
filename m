Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65572E7BD3;
	Sat,  7 Mar 2026 15:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772898211; cv=none; b=PSSIhYkrUcb9jjnFXAEDGS2fp+rTuMq6WymjBbpiRoih10CAHCen8yNshw4Qa0xXelJt5tcQU9O0qMzxGSqLqJMCgI8XcjGrdAk90hXUNyhxsoP5VM3CEagJAr8lL/ZCRbbsKtI1jXxiWMfukUG6y3bOv9N3uJtmuf1Ouj460HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772898211; c=relaxed/simple;
	bh=60hX1/t2kn+t3Yxt2I26gSEsLY4qMg+UV+WRDWD82OA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=is8gDYV2I3Rnz2OeJHcNbvWqw15OjnZZBffcazavwBEShA+2U+EtucJk6umBSr4F2bM64Vhdm6arSu9auV4Vk2BfJpw57lqJjZ1wcZ3SutePUy9OK/Uvgi6hDEvn7vLEvdtpfRTkFm2NTCOsBYvSupKqu6gGj8feEg6Q6qf1n5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=lsIQHBFm; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="lsIQHBFm"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=6sSWECW9cSNvBC8Vyv+qYvqX7Epxph3r9VYaDNQOzOI=; b=lsIQHBFmJyk3Pgv1AmX8lDgkLG
	eYf5lPbJE4zSzy/CcsASmjCxo9LgdfGEzw/qF0Wi8sNKA8aL8xt9ejbi9B5O7fb6Tlnmq9eQBe1qF
	/pQ3teswkaNP+edTlVcAF/p/fAy/GDonJP6jgY/QweBrgwA4At6Ens99aXDaKIBS5f/o=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1vytny-00Ad2G-8R; Sat, 07 Mar 2026 16:43:02 +0100
Date: Sat, 7 Mar 2026 16:43:02 +0100
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
Subject: Re: [PATCH 1/4] rust: netlink: add raw netlink abstraction
Message-ID: <081b1f16-5c8b-4a18-a9f1-d56e757de4c0@lunn.ch>
References: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
 <20260306-binder-netlink-v1-1-daceb5bc83f2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306-binder-netlink-v1-1-daceb5bc83f2@google.com>

> diff --git a/rust/kernel/netlink.rs b/rust/kernel/netlink.rs

...

> +/// The default netlink message size.
> +pub const GENLMSG_DEFAULT_SIZE: usize = bindings::GENLMSG_DEFAULT_SIZE;
> +
> +/// A wrapper around `struct sk_buff` for generic netlink messages.
> +///
> +/// # Invariants
> +///
> +/// The pointer has ownership over a valid `sk_buff`.
> +pub struct SkBuff {
> +    skb: NonNull<kernel::bindings::sk_buff>,
> +}

struct sk_buff is a core data structure which appears all over the
networking stack, but also other places like crypto, scsi, tty, file
systems, etc. Since it is a top level data structure, it seems odd
Rust puts it into netlink.rs.

How do you see the Rust SkBuff evolving to a general purpose data
structure which can be used everywhere?

	  Andrew
