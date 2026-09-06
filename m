Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8482237269C;
	Sun,  6 Sep 2026 15:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788709713; cv=none; b=izJTfnHR3QemKJBJ8BgDpSXXwdewRW231PONFGgSsReZVDLjCCdp3wJ01nHHwvpd9evobbXi5FeAM0nGlojBbk7YMTR4zho/Mba73PlFn9Zds4MCAjjEhPXJRECiyiuP9P0N3j3NBrHPGw9tqTB1W3QloJTTeC0J+UCeSR9hCNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788709713; c=relaxed/simple;
	bh=CxVdC86NibetUJ1BoN5X0bntQZCOXiVjDYGYA1pdXXA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=js55kAkninHUuLy5aw1I2KbJBZXdH1BltN7CtQ1Weix1Qu2Wu26tfFI5OGLxofmNPgYF/JN287zIKmLj0uTgiF40A33pbCaJYN96QwRvfxcALqtFKW1Gy5LpYwfYatIx7TOE4S8FyrAYNwG7n0KUSJT9Yh9chAFR5V0Kl0qdNts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SKdgoEC2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SKdgoEC2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85631F00A3A;
	Sun,  6 Sep 2026 15:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788709705;
	bh=IDFseMZa4azllhHFWZJmTM2RIwtY3xXXrSyX07T869g=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=SKdgoEC2SG6+Ns29lNiSl4KlLi/ziU9o5/4Fp5nGUPrSSixPZC33BaZDbId5+QyP9
	 cde4cf9ud3IYLvMN1z+Bk0X4cOuKCpLMiv0Tx/mz4sOnSGhLLJAqgNa0zvLobPwXB3
	 D3COFSC2VIFrBtPiYr06Z0mVf6QCj5TO5sxnqDqaUkx/5/+D/FIGTyLbPr6Lz+Owz1
	 qfysRuFi1OMxetE33GWaVHc0MIF6aBZzVh19gpXoNzIspnZmkxLCanDgVeE1XKD09d
	 di9nRksZWlfhX5X8ji/8ceEx2ErG0JJtFSx8vifTsc+ZhC5FqgkY9RIeCrzFPz5WD9
	 GMo9QqP06PR5w==
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 06 Sep 2026 17:48:18 +0200
Message-Id: <DL8CO3P0U67U.10GU95WWXFSCN@kernel.org>
Subject: Re: [PATCH v2 3/3] rust: dma.rs: Migrate to zerocopy's
 `Frombytes/IntoBytes`
Cc: "Sagar Taunk" <sagartaunk@proton.me>, "Miguel Ojeda" <ojeda@kernel.org>,
 "Jakub Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>,
 "Eric Dumazet" <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, "Simon Horman" <horms@kernel.org>, "Abdiel Janulgue"
 <abdiel.janulgue@gmail.com>, "Daniel Almeida"
 <daniel.almeida@collabora.com>, "Robin Murphy" <robin.murphy@arm.com>,
 "Andreas Hindborg" <a.hindborg@kernel.org>, "Boqun Feng"
 <boqun@kernel.org>, =?utf-8?q?Bj=C3=B6rn_Roy_Baron?=
 <bjorn3_gh@protonmail.com>, "Benno Lossin" <lossin@kernel.org>, "Alice
 Ryhl" <aliceryhl@google.com>, "Trevor Gross" <tmgross@umich.edu>, "Tamir
 Duberstein" <tamird@kernel.org>, "Alexandre Courbot" <acourbot@nvidia.com>,
 =?utf-8?q?Onur_=C3=96zkan?= <work@onurozkan.dev>, "Greg Kroah-Hartman"
 <gregkh@linuxfoundation.org>, <driver-core@lists.linux.dev>,
 <rust-for-linux@vger.kernel.org>, <netdev@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
To: "Gary Guo" <gary@garyguo.net>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20260906102826.202874-1-sagartaunk@proton.me>
 <20260906102826.202874-4-sagartaunk@proton.me>
 <DL88TLWYE8H8.1FP5GCIYUL1BN@garyguo.net>
In-Reply-To: <DL88TLWYE8H8.1FP5GCIYUL1BN@garyguo.net>

On Sun Sep 6, 2026 at 2:47 PM CEST, Gary Guo wrote:
> I am surprised that just changing this is sufficient. Are all users of
> `CoherentBox` already have the both zerocopy and kernel traits implemente=
d?

No, and I think the uaccess patch won't compile either. It breaks

	impl<T: KnownSize + AsBytes + ?Sized> debugfs::BinaryWriter for Coherent<'=
_, T>

from the DMA code and I think it also breaks binder and tyr.
