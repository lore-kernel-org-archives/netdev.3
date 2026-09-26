Received: from mail-05.mail-europe.com (mail-05.mail-europe.com [85.9.206.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EB93546E0
	for <netdev@vger.kernel.org>; Sat, 26 Sep 2026 03:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.9.206.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790393200; cv=none; b=hr93KK+RA3h0VD6FIy2wMnsPyn9/tabRebnTm0kEp45arfPjXBQ9UcU4jfy2re9sANc5BzI5dgRYRAfritJJ6Qxqbzs7gDXdJi9I+m23fkT5wxfh60RxmvA0lzyjS72ht5NnZqhGqMXnQdx7be58DFAcjTD848R3B6bVCnqdxZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790393200; c=relaxed/simple;
	bh=JvcoTgqg8ZRh8YOkjedyHUbFmPyPQouMkrQHA/q2POc=;
	h=Date:To:From:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=U1Z/cPtKpwl7NZQ3+dWwXXgGSMe2LtjZT3naQRgjH5qZHKlVkRT0WuQAW89hZWO11IZNEpQXCkYVrRwB6MtKnv4J2YD2vDDQv+DP/UYCw/savuJMpXp8LonxY6oCLUxqTgwH1UAAy9gdng8gfpAqQCYYkJiyVuK1hA7mL/mYB6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=opendtn.org; spf=pass smtp.mailfrom=opendtn.org; dkim=pass (2048-bit key) header.d=opendtn.org header.i=@opendtn.org header.b=b2FdaE54; arc=none smtp.client-ip=85.9.206.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=opendtn.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opendtn.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=opendtn.org header.i=@opendtn.org header.b="b2FdaE54"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=opendtn.org;
	s=protonmail; t=1790393184; x=1790652384;
	bh=FP0n7Wvh96nl9yKUN0yRua+mQwECst1BxTEcwVd6NDI=;
	h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=b2FdaE54P9QAIrJ34ZdFA0T2nKfoGwNmDDYDzIGlgkJvSNlnPe/hCiCwunY2rKhHP
	 WIiOUTjGpy7N/q5bDlWnIcaYwxUDpDvjh/mkLexkR+aBW+18FggwEhNFYs9k6/zAzU
	 zWIOwYPnlsqtxeRSUK7q/OaR4As1qjRHne6OiZCCNcl1b3ytZncaIBIld4kb9Mnquc
	 GsJQbT/O+gg8ySKOXSTnzhmCQM/wayFL+UYHW0AFszMYTuuCkuADZAj3qiHeWl8fKi
	 JydTRDmZgft2FsNOiA/3U6sOMZjn0xH9/0vig7zUGJkdGna4bRatruMDjRdPS02FOC
	 zQHjy5gCmLPrQ==
Date: Sat, 26 Sep 2026 03:26:18 +0000
To: Andrew Lunn <andrew@lunn.ch>
From: Lane <developer@opendtn.org>
Cc: netdev@vger.kernel.org
Subject: Re: [net] Search for net subsystem rust abstractions in-progress
Message-ID: <4465cc61-036e-4ff2-8e5c-9cef97ff23a1@opendtn.org>
Feedback-ID: 224253430:user:proton
X-Pm-Message-ID: b260f93ed378594fca984b3c25fa977c770db101
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 9/25/26 15:03, Andrew Lunn wrote:
> On Thu, Sep 24, 2026 at 09:48:13PM -0500, Lane wrote:
>> Hi,
>>
>> I am following up on some advice given from the Rust forums where I am
>> trying to move some of my LKM's from C to Rust. These LKM's,basically
>> create new address family protocols using (for starters) structs and
>> functions like the following:
>>
>>      struct net_proto_family;
>>      struct proto_ops;
>>
>>      // Add a socket protocol handler
>>      err =3D sock_register(&proto_family);
>>
>> These do not appear in the kernel crate. Per the
>> submitting-new-abstractions-and-modules section for contributions in
>> rust-for-linux, the second bullet point says to "check the mailing
>> list archive" because "part of the work may be already done or in the
>> process of being upstreamed", so I was hoping to see where things
>> stand and get advice.
>=20
> There have not been any contributions on adding new address families
> from rust.
>=20
> It is also somewhat unusual to add new address families. So before you
> go too far, you might want to give a high level description of what
> you are doing, just to make sure your architecture is correct.
>=20
> =09Andrew

Thanks for the reply.

I understand the concerns of adding new address families. The high-level=20
description is I've been working some Delay and Disruption Tolerant=20
(DTN) LKM's as proof-of-concept that I would really like to rewrite in=20
Rust. The Bundle Protocol (BP) LKM is dependent upon other LKM's for the=20
supported convergence layers. These "DTN sockets" are accessible via the=20
POSIX API, hence the new address family and it's integration with the=20
POSIX interfaces.

Lane


