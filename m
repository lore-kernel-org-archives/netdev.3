Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6407841441C;
	Thu, 24 Sep 2026 19:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790277573; cv=none; b=oFp3WkhCNP1pm2/UQPwu4SYjrEfe6jKXiXxqwkkW2lwnGP0jyvZEZyw1C/fSalwecxqq3C3apdCeW8ahkB9A7mXaGO2BM8BogSNiqTsXKI/waaqLqZt0vnrEfHoqXKdQb4Tem0ePlAW40V3xIh72DERNMN/9UFOHeWbIGeTwec4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790277573; c=relaxed/simple;
	bh=P7xtI4Hbsog84LYM0yXS0wv2ggHG4xWSucQQC7Ido2U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OaDOkPws/uy70DNh5q2kbGYGPz3W6oAp72ghjG3xAm5FUUr/8yZzgayM9ZwQ5riRT75iyQgAXyhw/Xx0dTh528pkAmK/Soh0xCTRp09yeyiEGdUS5ljQ7oHeZMfi4z0be4nbFmSqgPKkrbBd8y4YHRJH2c4e79/jMH8ikfkluwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=xnpD2gGc; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="xnpD2gGc"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=aR00lvR/9mHZfHucYZIWDLJfDI8am5BoeFpz5I8+J/w=; b=xnpD2gGchuhD/Wl6N4UKwp0z4q
	ordZv1s4/msxqCgaRWLfdA26TXCnUj/vM/ODefOzSL2xRvikCX0lFHxAjSxVsBuT52Mk1UHDPzMW7
	aTGXIG3ps9SKKJkGPh/EVJ0tQY4/vzIKWd3bY9NyYMcps5DgRr56VCd7e4uSOcc3hmWE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1x9oyG-0074I0-MC; Thu, 24 Sep 2026 21:19:04 +0200
Date: Thu, 24 Sep 2026 21:19:04 +0200
From: Andrew Lunn <andrew@lunn.ch>
To: Sagar Taunk <sagartaunk@proton.me>
Cc: Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Tamir Duberstein <tamird@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Onur =?iso-8859-1?Q?=D6zkan?= <work@onurozkan.dev>,
	Matthew Maurer <mmaurer@google.com>,
	Carlos Llamas <cmllamas@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v4] rust: net: netlink: validate attribute
 length before casting to `c_int`
Message-ID: <88add083-f2c3-4eac-abc6-e37e40846a9e@lunn.ch>
References: <20260923120504.9100-1-sagartaunk@proton.me>
 <20260924104645.4764dbba@kernel.org>
 <pg6AgjGkbepQeI2FIcnGmFk79uPhI0wShhVJVNbvrLkULQtO4jco6gm4xKaLiGFV9UVZBVK_h-sDlHtVip5s34SkCRyDoE47V9Zse9GsLAg=@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pg6AgjGkbepQeI2FIcnGmFk79uPhI0wShhVJVNbvrLkULQtO4jco6gm4xKaLiGFV9UVZBVK_h-sDlHtVip5s34SkCRyDoE47V9Zse9GsLAg=@proton.me>

On Thu, Sep 24, 2026 at 06:02:24PM +0000, Sagar Taunk wrote:
> Sorry, my last patch was based on the rust-next tree so I thought it was not applying because I commited this on top of that so I just removed that and rebased on rust-next again. 
> 
> Am I supposed to rebase on this one? 
> `https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/`

There is some documentation here:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html

which explains the two trees netdev has.

      Andrew
