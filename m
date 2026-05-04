Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2CBD3FB7EB;
	Mon,  4 May 2026 23:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777939140; cv=none; b=OAfv2Zi8MtCLjLKQy5Qkf0ao0M4fe3G6fipYTPEqFUiWw24Rqq16dpda38aPpsaWXN7df18cywIDrijPiy8OX2CPTIQo1ErjiFkIqR8TJ3lHhLJnGiGhbPzye14GO+oblNA1dOIp8HozcSN+wYC8FsagMFXrm+ZGS/kCejSXFrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777939140; c=relaxed/simple;
	bh=G78gkkTB3+nUxbQ0sEh+cB10zCIPgt3BA3kgSBxBQN4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s2wN5JxZ8rG+LYN7EexQIPhdUYy+gZYhcaGd6cjSLs8ckiwfsJ2P+6GJYbAEsbGYOmufmiHkLsP/X4dYypI+4u1yEuTom7fPULJLHaltXHwpc8Ii6wDK3DGoSVNkS0Ht5/6U72VsRhRzlN8iefvVaikH0UP1tzwIsnWByrVrAvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eJA2bxZs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eJA2bxZs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFE4C2BCB8;
	Mon,  4 May 2026 23:58:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777939140;
	bh=G78gkkTB3+nUxbQ0sEh+cB10zCIPgt3BA3kgSBxBQN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=eJA2bxZsbYEj8zvHRQYdifekgZDfjdBdbS0c2t9kJGGoH0YkBR8V1+DmrqR2fFDBW
	 SRzgB4W7puSJx+cZSCR82FShM3urezn53PrmPTIET8RFC928s0UBmBUqAQRdFraRIb
	 MPWTHICnQbpZSWN84PYcZ3bN4ebnyXNlVLhZMBrRHSiywDgix5qIexor1gR7Ech9NZ
	 X3jtTyLojQNYXixdwv6/yaUqfZ9zrNVprTO/tju9lNM9X6STCQa5p9/aIRTxkEWLJu
	 jor+dJmwXDUbokcaLACFAmwLgoVZLtHfinDcGsZZe9AXZX11iektKnq3P49sigcirl
	 G6/F8omOhx37Q==
Date: Mon, 4 May 2026 16:58:58 -0700
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
Subject: Re: [PATCH v4 2/4] ynl_gen: generate Rust files from yaml files
Message-ID: <20260504165858.4882730b@kernel.org>
In-Reply-To: <20260504-binder-netlink-v4-2-601b41cd25b2@google.com>
References: <20260504-binder-netlink-v4-0-601b41cd25b2@google.com>
	<20260504-binder-netlink-v4-2-601b41cd25b2@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 04 May 2026 09:04:55 +0000 Alice Ryhl wrote:
>  tools/net/ynl/pyynl/ynl_gen_c.py | 139 ++++++++++++++++++++++++++++++++++++++-

No. Rust. In. This. File.

Just commit the artifacts. I truly hope that this is the only Netlink
family we will have in Rust.
-- 
pw-bot: cr
