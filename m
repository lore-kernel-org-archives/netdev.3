Received: from mail-24416.protonmail.ch (mail-24416.protonmail.ch [109.224.244.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D011F392C21;
	Sun,  6 Sep 2026 10:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788689564; cv=none; b=NmObjCU09C9O4oaTghkcdMbIkupHJBUWHg+17y2pgVWmwq1sds2PTB+SUsqZWKEGl9BZe4pSm/sKpjhtF+CUGSGsL9VYrZVuy6qsZTV7QVY6gfsnATQQeZTKt7OxkXvl53DjTRlAXa/Q9280bpoZJ1AxBXfMFy8iVrRo5hs7QRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788689564; c=relaxed/simple;
	bh=62t68vJxET87LvpyIM/OSNaziUXNDoGAJ1DP4WFiAg4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=W2sFnjNE9NstRKqdrVM9P5P4jN89tky29vnh647O2Wqo3OzGd1mPQoXRQIkKNu7HQKcWpFbJPWCEstL6t8SAfr1wIrVuNWY6n68gh34tnvtmZve4WwW97TYNk3Vci455F1+ZodB28XyWh1Nfhl0aej9woIbdxSHVV72vuFg/iM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me; spf=pass smtp.mailfrom=proton.me; dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b=BizC1bnO; arc=none smtp.client-ip=109.224.244.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=proton.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=proton.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=proton.me header.i=@proton.me header.b="BizC1bnO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1788689550; x=1788948750;
	bh=BoOFXSWJsbe9xEWFNa53+EhJzDWNcTy3OcDqZ6vqHYQ=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=BizC1bnONXqubFDpE9wv8pmtb6zifU+V12M7Y5NEg5ec4JJQRPj/x7BHDTAxsnn03
	 CllMFbRLMLIDBgYgFf0dFWYtg93WHB42q/35dZyEXxOOWdGKTEFPvt2q86AYYcJ/xk
	 BzfOnO1vJpEjg0wFyxL2rDot5xR4cudHJNDkhG6hTXYvNPX/xjl1LJNIBfYo0Ow4h3
	 pL0XbYr/EXWC4AJmL3tsCrM0TwwrQ5B+/zVvr67nZ2xKIf8jtdmYWqmhvRJEPuFFgB
	 kfXSJ15Bad9x2kZHycEbeUGlJwK7HeIWBTSaLILulG5nI/Qw7oDkQJOWXZf8oy/WB4
	 0pS8RSPedVs5w==
Date: Sun, 06 Sep 2026 10:12:24 +0000
To: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
From: Sagar Taunk <sagartaunk@proton.me>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, =?utf-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, =?utf-8?Q?Onur_=C3=96zkan?= <work@onurozkan.dev>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rust: net: netlink: Migrate to zerocopy's `IntoBytes`
Message-ID: <5Lv6zXpygThzdV6Dvo0JExSOQ_f9mQDu2BcCG4aQEwczgpwywMzaFY09RfL6vkMPZ8niwnrXdg4vC9tCJYkQMNDWJqAPsByKhqk8Ej0jGUs=@proton.me>
In-Reply-To: <CANiq72kUVbdGGbMnWTQp6kAoq8pbddRVUOPzT=0RjWFf5dtQ4w@mail.gmail.com>
References: <20260906071635.160615-1-sagartaunk@proton.me> <20260906071635.160615-2-sagartaunk@proton.me> <CANiq72kUVbdGGbMnWTQp6kAoq8pbddRVUOPzT=0RjWFf5dtQ4w@mail.gmail.com>
Feedback-ID: 130121444:user:proton
X-Pm-Message-ID: 530eef4408cb2265819ecc6c172eafd02688fefb
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Sorry, I missed that while checking. Let me send a V2. Also, are there any =
other changes I should make ?



On Sunday, September 6th, 2026 at 3:19 PM, Miguel Ojeda <miguel.ojeda.sando=
nis@gmail.com> wrote:

> On Sun, Sep 6, 2026 at 9:17=E2=80=AFAM Sagar Taunk <sagartaunk@proton.me>=
 wrote:
> >
> > Signed-Off-By : Sagar Taunk <sagartaunk@proton.me>
> > Signed-off-by: Sagar Taunk <sagartaunk@proton.me>
>=20
> It seems you wrote the first one by hand? There are two typos there.
>=20
> Thanks!
>=20
> Cheers,
> Miguel
> 
