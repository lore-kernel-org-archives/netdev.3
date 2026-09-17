Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com [209.85.218.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C77141A508
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 09:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789637769; cv=none; b=DJWH12Ufe1qjaXZhrxls6bKQhOrHPl4nOdTXFaS5SP8jKfzd1NHLuJrDB+OBkc9ka4BeXOktyt37fGY1N161BcbUSh/swRVjblWyBUPTded8OrtlyHjsuylCsViCLFOx4Cc1+WxNCZD3gk7DrG5sBJLK15htF8c949gZHL9smDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789637769; c=relaxed/simple;
	bh=Oz8G4IOR6Gmqkd7yD6cQD3SSfjx7S8ayJRM3R9p6+sQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cJQUtNSSlT4MoqcGvw5ErF0Bxpo3OYk4C3aACIYJCw99huoKhWvr2SeUy3EX6ZBGmRXybDW6gr5t+ScQFUcky9d95cbh3gBmYaGyYSLzEQZvIxAw6bJmc3yh10Ybxv8ZQLMyQAXk0+uGb4LMBDcMm1Dkk4MavQ6W8ZI3Co7eouc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=oxhzcLRD; arc=none smtp.client-ip=209.85.218.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="oxhzcLRD"
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-c294442d71dso83539166b.2
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 02:35:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789637745; x=1790242545; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vsyxKzqLMpsUXo8Lic/w3Wn8v7CPcrVQjEJhvbshmVE=;
        b=oxhzcLRDRuX/gBo8vy0TKlSVL5ziY2v+kKlqu6Lb/KuleKdEBO8I3J+wv6nkrJbiXQ
         vbPNjpLX6bQLTKGZWCcQjw+9UEF6Xceakc1L5R//WszwchnJB+34Kfq2zKLRpFpilLRS
         XW3gYnxLFUCAIukeJNtZ4ZwgTu/nLrv6P3G3hl5IwEShcVD/890hy3mqAr7C6yjA0GYR
         dCPh4LJvm5+AfZoxU/A2h9IahBGWAYbu7NMBY4q5FWV8jKAoYQqx7BzjkHjY1k++s3BR
         2vhkWj9NyFIdj5Rzwr+mfEFi3b/fKWbehFFLktr0aqRSp7teY4QhtgT9zYwzhclfGIy4
         MIPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789637745; x=1790242545;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vsyxKzqLMpsUXo8Lic/w3Wn8v7CPcrVQjEJhvbshmVE=;
        b=rxctsDD1ZTGB6hs6eK3PGeLm8VwinPap6aKMq9LzWYj7PdAlB02hBncwWn+TLWlt4r
         U3VdX/K7tg6PnMm/U9TPcFs4VZkIdNvUf6lyIOWp0sSIbYhrhcUuTnC/vpQj/EGmnhjk
         uogY1h4wei7j3cn0dSt7dwoptrGIjSWVx0tjZoOf0OwEu009nZ9Haoqpb3USwT3ude7o
         2nQYrStjqRBHJ8nNwyFz1yRDrNWhZTP2xIhIcOxvKFLGpZvvNDf3sBvMxOkKjzemrZWk
         fN0LHkFYtvT/EtiQxMWGaM441iFdl74qkCP7gULiGGk7m6BQrh4SDUb2mtS9ybct98RN
         vCBw==
X-Forwarded-Encrypted: i=1; AKwUvBy2BQFy2PFe/0Zy1MhQDCeMSWylpsM/DjNhMtbesNcKg8iNz/ZhnutviAwUtzZoV1m0l6s/Dxg=@vger.kernel.org
X-Gm-Message-State: AFuF++nwxsvQJKXzgirCWRZ0kDdDD8Hm4Ki49dr/vlJZn+O8h01PX7Ng
	Cbv/x23TAB9is6VGRPHiGQsazlxyjkRgfnmAIcXteXYxm/gQrs03bJyLBCIqZYLBMaMFfxmV1Ja
	q6EiXM2ranpbGEEzBqA==
X-Received: from ejoy22.prod.google.com ([2002:a17:906:4496:b0:c29:c42c:f427])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:9343:b0:c29:5712:a420 with SMTP id a640c23a62f3a-c29e51dc1e5mr387979866b.5.1789637744642;
 Thu, 17 Sep 2026 02:35:44 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:35:43 +0000
In-Reply-To: <20260915164000.124340-1-sagartaunk@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260915164000.124340-1-sagartaunk@proton.me>
Message-ID: <aqu0bzgMAUQe_LZ6@google.com>
Subject: Re: [PATCH v2] rust: net: netlink: validate attribute length before
 casting to `c_int`
From: Alice Ryhl <aliceryhl@google.com>
To: Sagar Taunk <sagartaunk@proton.me>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Daniel Almeida <daniel.almeida@collabora.com>, 
	Tamir Duberstein <tamird@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, 
	"Onur =?utf-8?B?w5Z6a2Fu?=" <work@onurozkan.dev>, netdev@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Tue, Sep 15, 2026 at 04:40:10PM +0000, Sagar Taunk wrote:
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
> Signed-off-by: Sagar Taunk <sagartaunk@proton.me>

This should include a Fixes: tag if it leads to a kernel panic.

Can you also update the subject to [PATCH net vX] according to the
guidelines in: Documentation/process/maintainer-netdev.rst

The patch itself LGTM.
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice
