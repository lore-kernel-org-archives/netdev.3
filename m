Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE501C695;
	Thu, 16 Apr 2026 00:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776300203; cv=none; b=Rcz1rf3XvKnLxcIrF1Q5RsJVW2Ksf6Iycw1YdAclWC6MI+ds7FdnGOKBKswTGCgw2J2/ufnplDYea0c+s45QmOrKW8P6a46Xm1IMI4WYSyQnzqIEMNi1yA5vWwBFKnHjSVTDnjuwXzWgDSJUFp+7BBd3PgOAD4dDYrm8Xc6LLzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776300203; c=relaxed/simple;
	bh=lQv0RrnnKjrsrz3OfpAB7H9RZq1x1kFzHaHJw9VDgVw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lNts5G3XOIHMZj4M2rKo+BclOuc/I5LINJ3vIs41NM4hAqHmJ1zLRLXQqxiymIUwbeEu9C2xRy6C9zy08BaOyYK7+0GUCRd8Kkiftdw9NlpgvnBkF9yqw8UsTENEoTI/50kN4AkOdQ4i+FSuM8uo/CuT22zD19ZjplWaipPoD98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=Rd6bH6pb; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="Rd6bH6pb"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
	Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
	Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
	bh=QwwpPMeXcqgVS3p4zP/MvEBTtT1TcMx4mqU6gSoWG44=; b=Rd6bH6pbTu/TXQmeEjPzoeYA4f
	bKKjflY+DmB/3kutQngE653je1dDqjLiAqBG/MvyzKAmx0Ve4SFst6NYUrwA+nUo6ivQGuIL+xHdA
	TurvxQAa7VnTt+Xa4NOU+ShgXPc2WCci+ragGgHsRp3Z05ydWySP/Ff4pza+hk2xvA8g=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1wDAoq-00GEEl-LQ; Thu, 16 Apr 2026 02:42:56 +0200
Date: Thu, 16 Apr 2026 02:42:56 +0200
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
Subject: Re: [PATCH v3 1/4] rust: netlink: add raw netlink abstraction
Message-ID: <e8875c97-ddc1-4eb2-85cf-27f34e0d9e08@lunn.ch>
References: <20260415-binder-netlink-v3-0-84be9ba63ee2@google.com>
 <20260415-binder-netlink-v3-1-84be9ba63ee2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260415-binder-netlink-v3-1-84be9ba63ee2@google.com>

> diff --git a/rust/helpers/genetlink.c b/rust/helpers/genetlink.c
> new file mode 100644
> index 000000000000..3530b69f6cf7
> --- /dev/null
> +++ b/rust/helpers/genetlink.c
> @@ -0,0 +1,46 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * Copyright (C) 2026 Google LLC.
> + */
> +
> +#include <net/genetlink.h>
> +
> +#ifdef CONFIG_NET
> +
> +__rust_helper struct sk_buff *rust_helper_genlmsg_new(size_t payload, gfp_t flags)
> +{
> +	return genlmsg_new(payload, flags);
> +}
> +
> +__rust_helper
> +int rust_helper_genlmsg_multicast(const struct genl_family *family,
> +				  struct sk_buff *skb, u32 portid,
> +				  unsigned int group, gfp_t flags)
> +{
> +	return genlmsg_multicast(family, skb, portid, group, flags);
> +}
> +
> +__rust_helper void rust_helper_genlmsg_cancel(struct sk_buff *skb, void *hdr)
> +{
> +	genlmsg_cancel(skb, hdr);
> +}
> +
> +__rust_helper void rust_helper_genlmsg_end(struct sk_buff *skb, void *hdr)
> +{
> +	genlmsg_end(skb, hdr);
> +}
> +
> +__rust_helper void rust_helper_nlmsg_free(struct sk_buff *skb)
> +{
> +	nlmsg_free(skb);
> +}
> +
> +__rust_helper
> +int rust_helper_genl_has_listeners(const struct genl_family *family,
> +				   struct net *net, unsigned int group)
> +{
> +	return genl_has_listeners(family, net, group);
> +}

The C part looks sensible now. For this bit only:

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
