Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079B638836A
	for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 17:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790185112; cv=none; b=dz0OhXvumFvo5ZFaF4v7IVzGj3gLyktYzzcYGQ1rfNms+qq7cr+EOB0RDzpny/TaNBTqKxfcfFzo96SPozej8X9Z3s4CpK44hxZ49mBUibGR6qlFVc4sXaYqZO/YT9vzS8jjq9RmYBj/08gz3mu96mRlSki/aFG5lBvbjYe1ukM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790185112; c=relaxed/simple;
	bh=pV+1D5vSrpBEiPdYYCuKzOStJttNKVhJ4dZ4A9bnN/s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dfIajNG2E5PBtBKVpIBDTVhWpAXKxXkilPOFvDnbn9jzXyEP4bJllTumAQfH36zAXUOSLQM7hG69P5Hogmxmn45Js8xv6j0XHSeTj/YUSRaM7QeaDDsrhhp9gBqJBYBM+LcjtX52yzo08E3daXzUxhbUvs1Oi6IjZcquzqimn0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=EXpzXTtC; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="EXpzXTtC"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2d8facae850so6665ad.0
        for <netdev@vger.kernel.org>; Wed, 23 Sep 2026 10:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790185110; x=1790789910; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D1AquzIApwGo2FvNhSKw8uhRmWAtNmW1t7wHGg5rKrs=;
        b=EXpzXTtCj8ztqUvIft+WiLrzGaKaHL1NXJ0cS8TtZePNF9Wjoe5TiNES6nZ1cLIaCf
         C4DgJgKP4N3FlFL3ANoU5RWJoWlRmWp5XxHVHSj9uHuoxDaVIeEqAdSWJbAJilENn213
         pAtayeMHjOk57biEwRw43UiAbPXw5+vIhA5nAqDdI7zmD0q7qcWHMYrj06LdWuniqhmn
         ogo4zlPHwAKXXgv9uvSsH2wf3o6iLNTyJDRQt+jPE4+gfnq+omDTjUkqmOVhWhfK2J8Y
         4O0adTAXUgpibLcTcqXYlbq5EzoxaLPUmrEd8PQjJ+W9QnnJgUGX2/63VGkn2GlNgT5j
         hfFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790185110; x=1790789910;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D1AquzIApwGo2FvNhSKw8uhRmWAtNmW1t7wHGg5rKrs=;
        b=XDdWwK0VtFHkFE9V/RLL0RyaXy3s3gTcku6W/nCweeS9J9JzGMpUORpxGwyJMMpE3a
         LN1hr3br9D55PSkpsmA/fgpQicGH3m46SB58tKLKkYbQhCmNf1ms0btcyE3VgQa/qR2h
         0bZqmHdZgBEiB8kkzcRMptRuv9MZg8jk+4Wv6nyYtorybCGvMkYOyyw2EIPopqaA8RUZ
         igPNgmj4ufp4dv8nKYFBx42snuhvyO7yflTtlB6C0JT1p5SSwYNX2M/KEMtlZ8KkL5F4
         yn90V5q5+9F1sywHErA6kE3DGaEJnpcT+RcgaYpSxDZK1XjbgNfpOpddNQRFUaadTo3j
         6yzw==
X-Forwarded-Encrypted: i=1; AKwUvBwUJFL0TAg9qMiE/iX3A1jreuetcNJaoQY4k9v02PTnZqXtnztGiKyWJKjXlV67rmmKYwYzcsU=@vger.kernel.org
X-Gm-Message-State: AFuF++nq7MgR3e+crQG6VTikbngTcisc+NkD/iuIZa1Pz0tmn2ZGBy8y
	mMgheEPq2ZTA7uwxlPrL7feph0J8EZC+u2yvO2ntNf/HX2wGfvfBXEcA8GglbGjU6g==
X-Gm-Gg: AYBFou0TOfrswhPwMNoxm/ohaCK8O/fp6FelgtI+dcxBWisnZ3C7PmGEPW424yQ6bkf
	YSJ+xsk8RoebEoaCm0/2+2uSbEhAj0dhtU6jPaenKKpglpFI1PmikRiprXcDlW4AMbQXwdfl4k2
	26k+L/DeT75InlXX1sRwK9a8dDHI+9jBMPytIWXmInUx1tcnBMh7fuxsUavygJhVUf3GbWR+4w1
	AX13obJoCkhT+leqSEuk+Ux/auRH6UGmqRSQ+3YFo0bbNHA2/GS8SoSOB9NoekOE7/sOcpeoa3f
	IlABh2Oqti5U+L8QvAVgaLbZHtyTMUcr+7sDAXy/egPU/OIp3uuw1UWq0TE7UJG052nKmKvdK34
	M/0FpBC9VKbbDtpH2Z2ZUFes7SveLzVqIROEVv4suoITl7Ghv70Wj+ze3McLI1qhYH4wxMHUN9Y
	bfaJ0vnaJUp2HuG0PY16Cz8TEe4K8QDBfHOZxnOViaZvXSp7bUC10JbMW4BPUXj9iCC6GuzrzQ4
	Mf8/Bnzi2Cqahh+pTpiYBRRy/Igqh1sCoM8Y/D+W57TjDx3L9SWRo8a6l+v6VoNWO2p0GX4CKmG
	3aYq1JtDSkYXLjejgHL2Fvtujg53FAQo+0DfzB4wLnIqqCc=
X-Received: by 2002:a17:903:90d:b0:2ca:4bb4:4bd with SMTP id d9443c01a7336-2df7bbd799fmr625835ad.5.1790185109816;
        Wed, 23 Sep 2026 10:38:29 -0700 (PDT)
Received: from google.com (99.95.125.34.bc.googleusercontent.com. [34.125.95.99])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0974ec5c4sm119346a91.5.2026.09.23.10.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 10:38:29 -0700 (PDT)
Date: Wed, 23 Sep 2026 17:38:24 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Sagar Taunk <sagartaunk@proton.me>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, rust-for-linux@vger.kernel.org,
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH net-next v4] rust: net: netlink: validate attribute
 length before casting to `c_int`
Message-ID: <arQOkOAcTTt6dCyr@google.com>
References: <20260923120504.9100-1-sagartaunk@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923120504.9100-1-sagartaunk@proton.me>

On Wed, Sep 23, 2026 at 12:05:17PM +0000, Sagar Taunk wrote:
> `put()` trusted an unchecked `as` cast from `usize` to `c_int`.
> When the length exceeds `i32::MAX` that cast wraps around to a
> negative value.
> 
> This ultimately resulted in a kernel panic when the reinterpreted
> value via `__nla_reserve()` and `skb_put()` became enormous.
> 
> Validate payload and header both fit together in a `u16`, rejecting
> any payload that wouldn't leave room for `NLA_HDRLEN`.
> 
> Fixes: 5eaa5fbb6e6c ("rust: netlink: add raw netlink abstraction")
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Sagar Taunk <sagartaunk@proton.me>
> ---

LGTM,

Reviewed-by: Carlos Llamas <cmllamas@google.com>
