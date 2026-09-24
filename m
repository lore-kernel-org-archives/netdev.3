Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C0EB4AD4BB;
	Thu, 24 Sep 2026 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790274719; cv=none; b=kveuTMHxQ4sRVVNaAu57Ut318jAv0vXOEKFkX0exZFx3Jq/MgNo41j4V9unkUjqEt++8jAJJAGe6Ye7E6UJbXQY6DzvDO//EskEmqqU11/Hnouc+zfdhQ7RdswFLbk9tSYWkSk199b7d5U07CMdYxf9e6G+BIszHg6BE/zGru+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790274719; c=relaxed/simple;
	bh=R93BKG65dBqOrPkEPHjqkNBqz1rqBJKwdOjZnJxbrSg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o8SEN1227A7RhVebviBn4SrWe5YzOZxWpfN0mEoU3sRDr91HWKaE1XFIB12VRjIFH8B9WyJ6jyPc+Z2Vxh0/tKlgBnTLp3OZ7BDcU2B6n2iscP31JzfdDn2wDMOG0n1npfGwX+IiEowcoM5JDgrC2WEV4Ibkw9jD3C/Cp2njZpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B6kLAkCc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B6kLAkCc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB00C1F000FF;
	Thu, 24 Sep 2026 18:31:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790274717;
	bh=HaaxkVlSMKZnZBamhj2cYrazCxmyr+8layTfl9HvauE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=B6kLAkCcQEcLNHy5nwQvS32X4+uIaFUlPRY22+BlMpoTfUREtFLWpfqYF+Bitpqoh
	 5ShX5/a4Lp9JiuzB6Mw9lRmCXebAVk5FCdXMC50chxIDwLQEDiWXlLgPbC4LspzEsT
	 yB/a094bjBEtLvAusDlCi6goksbkCp1pzanb8E0y4FR1rLQghNTaGEmd6GFsoR7uBh
	 56xsoR+W5udmxmK/XTZ4ywkqlYToku9kSiM6lOIqt86B6Bpalh6zpIqvUTY8UPcQmO
	 E8DGPn91PoWN+KkGEVxUK0WiRwkdYrFxFL3wOOt5Vnt6mWMdpcbMzOovP0inYezfLD
	 U8fwmk9via1dg==
Date: Thu, 24 Sep 2026 11:31:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sagar Taunk <sagartaunk@proton.me>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng
 <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?UTF-8?B?QmrDtnJu?= Roy
 Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas
 Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor
 Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel
 Almeida <daniel.almeida@collabora.com>, Tamir Duberstein
 <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, Onur
 =?UTF-8?B?w5Z6a2Fu?= <work@onurozkan.dev>, Matthew Maurer
 <mmaurer@google.com>, Carlos Llamas <cmllamas@google.com>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, netdev@vger.kernel.org,
 rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Lunn
 <andrew@lunn.ch>
Subject: Re: [PATCH net-next v4] rust: net: netlink: validate attribute
 length before casting to `c_int`
Message-ID: <20260924113156.02bc8900@kernel.org>
In-Reply-To: <pg6AgjGkbepQeI2FIcnGmFk79uPhI0wShhVJVNbvrLkULQtO4jco6gm4xKaLiGFV9UVZBVK_h-sDlHtVip5s34SkCRyDoE47V9Zse9GsLAg=@proton.me>
References: <20260923120504.9100-1-sagartaunk@proton.me>
	<20260924104645.4764dbba@kernel.org>
	<pg6AgjGkbepQeI2FIcnGmFk79uPhI0wShhVJVNbvrLkULQtO4jco6gm4xKaLiGFV9UVZBVK_h-sDlHtVip5s34SkCRyDoE47V9Zse9GsLAg=@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Sep 2026 18:02:24 +0000 Sagar Taunk wrote:
> Am I supposed to rebase on this one? 
> `https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/`

Yes, afaiu, and please don't top post
