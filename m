Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E99C914F9FB;
	Sat,  7 Mar 2026 21:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772920784; cv=none; b=ESNJ5FJAD9LnXTPNxcQElzXdowAtTeP4WK6BQxGUX7C4H1fbXiGZROxk5Ubb5I2nkUnFwp1LZ3sYVVRsIjWsWeaE2EZ9PEgQnORYZctMLteA54HyoAkTZ5KquUO5nOx0EHA2bL5XtejMriAhCiLOTAwyEGrgCFxZql251hAGj2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772920784; c=relaxed/simple;
	bh=vYR50fxKZxiDLmX+pEOc4uv+UC5xHS1Ej0h0VOgf6Tc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SiovD2a+ecBT3yTRfiewek13quQ3KHbHdmwqb5liOFvxzky6ZC87eq45CO0fvidzODoIPunngRxo8104vicLfJStUZTyGU9rKjRnWllp5XK+xs8o2fcxXItvXhCx4YIsKDI3bHUHvcP6ZQ9/skG+zaHRaYMOBIY64VDN4mxBTGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UIi/QH82; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UIi/QH82"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B243C19422;
	Sat,  7 Mar 2026 21:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772920783;
	bh=vYR50fxKZxiDLmX+pEOc4uv+UC5xHS1Ej0h0VOgf6Tc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UIi/QH82Rwi+fgVrxBGfbeyUiJLVkcPi4gVI7W1IkWwrHAoCkcoU3gYAQC+xCHaXI
	 1DxslLuHzG8JucFxevAR7xEvcD5f1V83Anz68dKC59EB36AOBiWbLFnCtziyHhWPko
	 eFa4QbVvKmNQHqWCUmwnlTIyoO4NkJhsdFggUyRQI8szLQGs8RokQ3pRKfgW1/TI0X
	 RV9ato+mWdeDCSGlNdmwEL2uKWeGHExOYnVtAk7ZWkOSucbSmSbSEEXquYMQZBQsuF
	 MxGLdqGlgtMKK11BdRBMUkn2LQRoNJ1w/Ru7NQL5hlzhvWUFKVbNiokN7couwaESaK
	 jMDP9OHdUen9g==
Date: Sat, 7 Mar 2026 13:59:41 -0800
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
Message-ID: <20260307135941.51353a4f@kernel.org>
In-Reply-To: <aayWSuOM59uojtuG@google.com>
References: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
	<20260307104131.4c1d0de5@kernel.org>
	<aayWSuOM59uojtuG@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 7 Mar 2026 21:19:06 +0000 Alice Ryhl wrote:
> On Sat, Mar 07, 2026 at 10:41:31AM -0800, Jakub Kicinski wrote:
> > On Fri, 06 Mar 2026 15:12:12 +0000 Alice Ryhl wrote:  
> > > The C Binder driver exposes messages over netlink when transactions
> > > fail, so that a userpace daemon can respond to processes with many
> > > failing transactions.  
> > 
> > Ugh, now I regret letting binder use Netlink. Should have seen this
> > coming :/  
> 
> To be honest, I'm not entirely happy with what Binder is using netlink
> for either, but it is what it is.

If we're both not happy let's take this opportunity to find a better
solution?
