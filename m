Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2CEA376A13;
	Tue,  2 Jun 2026 19:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780430398; cv=none; b=lNQshrQ8jD36u61JxSZMFdL5XB8fAMByuYnAUSQDiMqoOSuXlnRc4lmKQoVdF7D2ngTSVBS48LmjkJmrx7YDZIu1qNyhzpNo0ulJr/sGbgYuTFye5+57wRjSxE3W+jh+wCaRLSS/tNZuAqLfkPpAw22h13c3EcWbHyTzCaSwk3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780430398; c=relaxed/simple;
	bh=ywSD0fPdkOV3PRi2wNsFq0uZ4W4kD8z3znRDzIGdc34=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lbrYrsWZlU+mzRj+d4KvLj8HlGeF5sS6kFPOFnOeuy5J5UN1MYgLk1+ZWiackx8Jl3dsMRN0qQwfUXFkCfvciCRFHysqxd3DIaHF0yBCmwBAs/hZ+e7FQqaMc4UXMVoyoq7HkX2u3Z4Vt9lvKII4PGpZUUX8SEjxYDmYTFhqKs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ERsIXOq3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ERsIXOq3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7F21F00893;
	Tue,  2 Jun 2026 19:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780430396;
	bh=ywSD0fPdkOV3PRi2wNsFq0uZ4W4kD8z3znRDzIGdc34=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ERsIXOq3+goH1skhNWCqoJdjeeyftXXtO2tXIn0yfN5hvK5dJhQm6YF6SZB1krrLJ
	 ZTogZGUaJpc9GqmjNLzCBrJErPh/fRCk+gBhV3qj8WWn5AOXYJBgKA93/GjnvGDDY8
	 aL4GeKKi8NBauFDtK8aoof5dQ8PxuSFQU9TlED2X4NAaW0L9+B5CGv3qzqzZCgplq7
	 lIGKpdqLP9L7/2upys2x72kOQZK7/xkgjCMC+BJ5s7x0QFR1Wz1zI+GK65AoEfH0pg
	 aExjWIk1Ryh94RGSOR8yZdudVPl747IeqPHyDkrQXyjS97xsYwO3cjLgBIDmH4wUTu
	 t2gE+0S9C50ug==
Date: Tue, 2 Jun 2026 12:59:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>
Cc: Carlos Llamas <cmllamas@google.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Andrew Lunn <andrew@lunn.ch>, Donald Hunter
 <donald.hunter@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Matthew Maurer <mmaurer@google.com>, Miguel
 Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo
 <gary@garyguo.net>, "=?UTF-8?B?QmrDtnJu?= Roy Baron"
 <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, Danilo
 Krummrich <dakr@kernel.org>, Christian Brauner <brauner@kernel.org>,
 linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org
Subject: Re: [PATCH v6 1/3] rust: net: add rust/kernel/net to NETWORKING
 [GENERAL]
Message-ID: <20260602125954.2a1b09dc@kernel.org>
In-Reply-To: <20260529-binder-netlink-v6-1-92dd74b6a32e@google.com>
References: <20260529-binder-netlink-v6-0-92dd74b6a32e@google.com>
	<20260529-binder-netlink-v6-1-92dd74b6a32e@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 29 May 2026 13:28:38 +0000 Alice Ryhl wrote:
> To ensure that networking code can be found in a single shared place,
> add it to the relevant NETWORKING entry. The net.rs file is moved into
> the net/ directory so that it's included under the MAINTAINERS entry
> without needing a separate rust/kernel/net.rs entry.

Acked-by: Jakub Kicinski <kuba@kernel.org>
