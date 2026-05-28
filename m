Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6915523AB81;
	Thu, 28 May 2026 15:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779980684; cv=none; b=Lq1yS304nIdvgBWBLWS8vMUh3mW4xBJHpDObeXYh0Qt/71X5YWvjNv5HJZ4E6F2l/0aXV/Aiqccvl0hPpFn7MNQUnCg+16SkB7L8g3+lt08L8KhdPDYQCAXu2OTiIlIm+uTkZugcCAHk7cfIsROlHsO/scFPl+dBzQxQ7LirTMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779980684; c=relaxed/simple;
	bh=3H2ORX3LaMZZJhQNMwEmqR2+s/uI166hUZt76ChWUqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oOd0pyJg3XKaofNmxiX5SnqrrZ7j4p+0D9zBd2IOZxwtLXPACSfxeHr5dqwdULieWyJAo+9MCZQxUdY5sSFUYx54Wu+0LC4LNWo/VSbZJ+QsWubVMBE43MwQTPpqjPoKFzz444AkRFuS1GERnuNA3AUk+gq/Lkjz3kMyJS5sv5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wjl2Z4Jt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wjl2Z4Jt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289A81F000E9;
	Thu, 28 May 2026 15:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779980683;
	bh=okVGivR6JMzRY9m1e/jRPmfakZm7inVaYkf/GPCmAhw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Wjl2Z4JtMKtSu5lAXWKgaLJS3/SZN7RcBzQE86jhYuZSxHSyW0a3haS4ys3U85rG3
	 p4xSurbpWfuEPR4F+Ekm5Enl6lgUHYLvo4rtC7bLes/pu+cRoL6jmajJMo/BbxOBIj
	 62XBJpnuiu5sTWO8EHkLe5C8B/nC7vOMcUDVvh12sEGeJGP/du6PNOQP5b3ibtUbhN
	 TbZJcMMWQch74a0ZzDxk9cBwsjNujfLqIlU0DAwVTn3MRs1lLmF1sW/pFmu0ozFbqu
	 O/ICRH0+8+DedJhM+JFiChr2lILsFzHa9vWWPW7CbPPrPD92Oz7H7fraJGjzQgMRPW
	 QA40qw59IXXfQ==
Date: Thu, 28 May 2026 08:04:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Carlos Llamas <cmllamas@google.com>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Matthew Maurer <mmaurer@google.com>, Miguel
 Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v5 1/2] rust: netlink: add raw netlink abstraction
Message-ID: <20260528080441.01ab1847@kernel.org>
In-Reply-To: <ahff7OTzS46Rti5c@google.com>
References: <20260525-binder-netlink-v5-0-a90e2923ebeb@google.com>
	<20260525-binder-netlink-v5-1-a90e2923ebeb@google.com>
	<CANiq72kRC_k1cnJLmG+AUSiUH6kDXVsox3nMJnV-c6HkNXOwBA@mail.gmail.com>
	<ahbAyBD584Hk9Mst@google.com>
	<20260527192130.21dabf08@kernel.org>
	<ahff7OTzS46Rti5c@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 28 May 2026 06:25:48 +0000 Alice Ryhl wrote:
> > > Netdev maintainers, what do you prefer that I put for these files? I'm
> > > of course happy to be on the hook for this code.  
> > 
> > Can we put it under rust/kernel/net and rust/helpers/net ?
> > And then add those directories to networking ?
> > Just so that we don't have to keep wondering with every little piece 
> > of code.  
> 
> Sure, will do.
> 
> However, it doesn't look like rust/kernel/net/ is listed under any
> MAINTAINERS entry either.

Which is why I said:

  "And then add those directories to networking ?"
