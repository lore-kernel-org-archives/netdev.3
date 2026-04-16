Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7891A34CDD;
	Thu, 16 Apr 2026 00:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776300394; cv=none; b=F9w0+xY6mTkf43razsI8j/IPc54UqmEJu70LRxXGNAizhDv2ZzxVZKt/34Ryfh4rCoJIX9jxrCOrMjr2rTzL7ND1m6ooQwUaWLaU17mW+lBfrFPbgvqHIYnrh6YhHYs2a4TXFLiSlp2MgSYAt59CqVZH9M4iMmXhzhVgMJ1BJu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776300394; c=relaxed/simple;
	bh=A4lDkZgxt3qxunRQFKvAnO1AsAancuPqun89dMVEEFg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=F8W/RkCWJFfLviKjFE0QaAxsb8Y0AvKVcbAnfk4r2HbTc1LygMd4rlA/4nfUfcEu8M+xfIhaEMli7TtLfHPgoaibZj4eKrsJCI/h6OewTb4t6w4CLrYBn8zF3RzaUnprQLZkqWxaU7Uy4qv0tX/hPYDirrQDP97C3fCEc/qmU4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Mb4X7Iny; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Mb4X7Iny"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=AUPYDuIK7EnYEVAgPyrscpRDlpVzL7lDx9pJpl4FwIc=; b=Mb4X7InyMHy6BhV36/6HfsVBn0
	ETE9lblD7xtTThWrMEVo8uXnFvvtWuET1+9jA19l1N0bP2eY8q4DPOeZ94WK8D5HCiQgSDPsuNsgh
	9mxaYzwt1ecAc3V8V+V9gs4jE/nQtQd/66yCDGsy6VJEsOYJAlnRS+D5Tvfu9BcPaC2U=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wDAs6-00GEG9-3Q; Thu, 16 Apr 2026 02:46:18 +0200
Date: Thu, 16 Apr 2026 02:46:18 +0200
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
Subject: Re: [PATCH v3 4/4] rust_binder: report netlink transactions
Message-ID: <96fff93c-c7ae-4480-8e0e-9f72c02a7b34@lunn.ch>
References: <20260415-binder-netlink-v3-0-84be9ba63ee2@google.com>
 <20260415-binder-netlink-v3-4-84be9ba63ee2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415-binder-netlink-v3-4-84be9ba63ee2@google.com>

On Wed, Apr 15, 2026 at 09:37:54AM +0000, Alice Ryhl wrote:
> From: Carlos Llamas <cmllamas@google.com>
> 
> The Android Binder driver supports a netlink API that reports
> transaction *failures* to a userapce daemon. This allows devices to

userspace ?

	Andrew
