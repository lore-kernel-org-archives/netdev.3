Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAF9261B91;
	Mon,  9 Mar 2026 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773091442; cv=none; b=ugQgM/Miyn3b3jm3CPLbaEckp/VVMHeZrLoddDV7lb3GqUFhIGCsPGg2EkTT3WFQg30QJc49W3cmD1ldeQX9vhXVzDcdOrXmbgJgm4yYhBYCoSXqa+FWr9xG/ZCjitKftmjZGzcJ/XxRNNfWg5PJeIftA+CIwLLtYVVvwosOKH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773091442; c=relaxed/simple;
	bh=1FJDNfQwipysOvEBhw7Ce0CMwITyjcXoF0pM/klMZ0w=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSyfoIB65Ys7TZKToRaJ/ue6sb/AaSgjN4LxCR1G8IZPB6Wy97YUGRBRaKO/zrH3FBTmF0qNXKd+2pxXUbRs7MjFg9Mfu96QAsrkuMOaB2uaSgMMyrWsKuWQ7W1D6qd3rD5PGdTlTg2rCuUUeRDKy5ptlWmIxmDtnjgkRGfFIsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sVFknAN9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sVFknAN9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79B9DC4CEF7;
	Mon,  9 Mar 2026 21:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773091442;
	bh=1FJDNfQwipysOvEBhw7Ce0CMwITyjcXoF0pM/klMZ0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=sVFknAN9jv2McJvnI84vxKelA/W2ZXMvH74AR3dOW6giv3pz3kagLOJiSHyiNQawg
	 Yc27mbumCgMyXNqw+k0IiFm3tcd1y+qqODsQ+5f+sFrkuxjuPOPb9kkuu8mJ1eqC/5
	 Xn122dcpkn+klmTdfF0dymgBoMtlYhDMl2ak1piMwXL4V2oGI9vjgwSVJhp1AblUlH
	 AyCvPVjJ9z2s/ETxCqCbKo+itoeDgIxjGfMWU7Dq7rDQ/6ZNUEyfnjwM4WWQ6ffWJ/
	 VzM9MjAyicDjUhDBjp7g1uDkTzIhYhN19uFpQRaa9B2ajsqGTSQeFqt4r0/YIeeRyo
	 b4S/Phu6+IcLQ==
Date: Mon, 9 Mar 2026 14:24:00 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Donald Hunter <donald.hunter@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Arve
 =?UTF-8?B?SGrDuG5uZXbDpWc=?=" <arve@android.com>, Todd Kjos
 <tkjos@android.com>, Christian Brauner <brauner@kernel.org>, Carlos Llamas
 <cmllamas@google.com>, linux-kernel@vger.kernel.org,
 rust-for-linux@vger.kernel.org, netdev@vger.kernel.org
Subject: Re: [PATCH 0/4] Rust netlink support + use in Rust Binder
Message-ID: <20260309142400.596f5010@kernel.org>
In-Reply-To: <aayrtyPKOqVGpich@google.com>
References: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
	<20260307104131.4c1d0de5@kernel.org>
	<aayWSuOM59uojtuG@google.com>
	<20260307135941.51353a4f@kernel.org>
	<aayrtyPKOqVGpich@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Mar 2026 22:50:31 +0000 Alice Ryhl wrote:
> > > To be honest, I'm not entirely happy with what Binder is using netlink
> > > for either, but it is what it is.  
> > 
> > If we're both not happy let's take this opportunity to find a better
> > solution?  
> 
> My understanding is that userspace is already using or looking into
> using the netlink uapi that Binder exposes here. I don't know to what
> extent; it's not used *that* much yet, but it may still be tricky to
> change the uapi at this point.

Let's explore it? What user space components would need to be updated?
What's a better design?
