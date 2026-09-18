Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A9B4086A;
	Fri, 18 Sep 2026 00:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789690014; cv=none; b=NLw5JDAfNeN+ku1Tbuw027rR8CX89D7oqh3kC3Pqdv/d9sj35dUEQRWatGgx7urG4wHEt97QYWpmp4gNw+2b51M98CVED2/5b71aLzcdkwnPNlYMbA7loqSmELqKJmvy5gmSoBqSMJI5ZRxnqmvoV5PnbjKD6Je5EHdIJKvOXW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789690014; c=relaxed/simple;
	bh=A/V1IvITdPVEnXthdjdE9N0/38n9yb5KdPYC5oGf6pU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eo23C4C62kDeoanHT7JD4SvD08r6XbvOoHupe/d+kfzjkwFTaLbWxXQidqYipGVnINUk99zoc0QVpRm/yzW3UvX2sYn+EYENrmjbzRI8f1rxAsnuhbNwsfetjvYyLmfVwc+G3RDzfsNA3oqG5OouDBaMYq2Gyx9MknuwPFakubQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OmL3vaTN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OmL3vaTN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C255F1F00893;
	Fri, 18 Sep 2026 00:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789690013;
	bh=iPgw9tRhTGr3grza5tzXt2V01AODVDU/p+Xfj8rpR0M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=OmL3vaTNvgJJhDL8VdfC3ElpSzJj+ko0u/NPvr5MvrgNyNjD2HTr2CDAuyJXVLfoI
	 8yVxyfrmpVyIvdAnvbYVLi8BEiaBp2VXG3NtcWGgo80wRtS31fH0hD13bGJ9q0+E1A
	 k6g0zT20wKgM88PBj2OB5uBbHdgbWBUnn96B+9yoXXTHqNUB2Fy4qdGdK3i6rTqUjR
	 xjdqoRO15fOjwlFnrhxfLO/fdT4TfwslH3Hk1tqkxIEGydkIuYSKsyKEAyn/zo9ZJs
	 pXlgR0slz3ro4juei0ThVuSrLjCiYcQRArB1Regr7x8ymdzr+VLfksZRO8aAyNGeEp
	 6xKyUz56qsCGA==
Date: Thu, 17 Sep 2026 17:06:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Alice Ryhl <aliceryhl@google.com>, Sagar Taunk <sagartaunk@proton.me>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, "=?UTF-8?B?QmrDtnJu?= Roy
 Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>,
 Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>,
 Danilo Krummrich <dakr@kernel.org>, Daniel Almeida
 <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>,
 Alexandre Courbot <acourbot@nvidia.com>, "Onur =?UTF-8?B?w5Z6a2Fu?="
 <work@onurozkan.dev>, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] rust: net: netlink: Migrate to zerocopy's IntoBytes
Message-ID: <20260917170651.393f4468@kernel.org>
In-Reply-To: <aquzyg0T67vu43T3@google.com>
References: <20260915144231.31932-1-sagartaunk@proton.me>
	<aquzyg0T67vu43T3@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Sep 2026 09:32:58 +0000 Alice Ryhl wrote:
> Can you send this to the net folks? Please update your patch title to 
> [PATCH net-next vX] according to the guidelines outlined in:

Good note, please remember that next time, no need to repost this one.
