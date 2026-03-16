Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90DEC2BE630;
	Mon, 16 Mar 2026 12:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773662837; cv=none; b=WEyxTo9fgh6h/V04wVKbEYRquRyJGvZc3xRzAg/Tq1FYCwEQdPpa6Su1+WWpdddqfWHkSRPPxiIRNGOcQsJepe0fUu2s96H311JizRm6chPCuJ8rGyXXeSooV0T79N7JUilr9vbmZ0AMXF9JINpzB1U2timEv7VwNRvAxfxxry8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773662837; c=relaxed/simple;
	bh=URL4i9UyshPMFgOLM1JaJatwjE1+ZpvAbJqqQq53mZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hgyAf7v9KxeSqab5dWuq/n6fXX8eLEy9hY8OHScsVQe0DkKGIqcE+FbV1ddc7oHiyY+uJM12ybG1fjwZlYoOZFB09WBX2X89oA905xGVdXK30xdZ4YXgttijCwvEh/lcBj7sP3l+YjUr/QICIWtdGZkNxKLxYuLYHdEKvrs2lXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lc3nxCdY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lc3nxCdY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4BA87C19421;
	Mon, 16 Mar 2026 12:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773662837;
	bh=URL4i9UyshPMFgOLM1JaJatwjE1+ZpvAbJqqQq53mZ0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Lc3nxCdYfpm7isy6geWijbDvdxw55V2SGO+m1jQRixrGknpgUnavxmwX8tLM/uXnw
	 wgrvmfS1aedJi373FFnOJ1hLYwphqMYTczJRfMDgclWuNPO/XBLw2WV0KxGDfCkgbP
	 sHrvQHMO79E19f7etcxLc1iIoiJkEos/Jbn+lrXFQNhqMsoWOA1dK0v3rfztO+qPkl
	 VWvBzDS9zeJI7utpDSOLV0j2YGhN2Uuz+vk5L9541MWAGIgOwxc/8qHSytaBbMbSU9
	 bViSPlG4GnwKiWfoC/YOXhr2chuCEIetYHai8pC65+U7C+WnQQsu0Nt6sjGXTY0yqu
	 zTsUz48xGimvw==
From: Andreas Hindborg <a.hindborg@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
 Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj?=
 =?utf-8?Q?=C3=B6rn?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Donald
 Hunter <donald.hunter@gmail.com>, Jakub Kicinski <kuba@kernel.org>, "David
 S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, Arve =?utf-8?B?SGrDuG5uZXY=?=
 =?utf-8?B?w6Vn?=
 <arve@android.com>, Todd Kjos <tkjos@android.com>, Christian Brauner
 <brauner@kernel.org>, Carlos
 Llamas <cmllamas@google.com>
Cc: linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
 netdev@vger.kernel.org, Alice Ryhl <aliceryhl@google.com>
Subject: Re: [PATCH 3/4] rust_binder: add generated netlink.rs file
In-Reply-To: <20260306-binder-netlink-v1-3-daceb5bc83f2@google.com>
References: <20260306-binder-netlink-v1-0-daceb5bc83f2@google.com>
 <Z9uvI-oeTc91D6icq79BKUFHtScNx6Mrzg1HyZY7thqi3mSKYpqiBf4IycUfvRNMY_3aQiRQWeRxdG1CBz_TuQ==@protonmail.internalid>
 <20260306-binder-netlink-v1-3-daceb5bc83f2@google.com>
Date: Mon, 16 Mar 2026 13:07:06 +0100
Message-ID: <87h5qgrn9x.fsf@t14s.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alice Ryhl" <aliceryhl@google.com> writes:

> To use netlink from Rust Binder, add a new generated netlink file using
> the new script and Documentation/netlink/specs/binder.yaml.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Does this have to be in tree? Can't we run the generator during build?


Best regards,
Andreas Hindborg


