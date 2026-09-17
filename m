Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464DA4AE8CB
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 09:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789637594; cv=none; b=djZQEi0UfOtl1q0LfRZQEpsP+pauOocQRJ73zGdGU2XpXWcCkLnpBv84ivcjz4icMWrCMIRm5PWNw3AaRVosG5JBjjaPmvFU+9pV3YJ6iaAJDLNlirKCV3qjJM+AuFN9REH/68PbPPrXDPOcqcoIHGsbvM1wuNDAWr9iNRR2fu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789637594; c=relaxed/simple;
	bh=3XVhvX9FaSzMPLV1sM5AoC9g2JGZvqkXTdE0PlcL4z4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=vAX2t+ewrpi5k3nKe6zRBRg+SP2+hBNvtBQGACSAA5oNAe6y9xTLyX3PR1mzCGdxJ7ve6f4fsRFtnPU2g+evXj6TZG7O2uEBZHTjW32LRcZsYCLkRwSDhMnXZcEScFyJb90nd30DWmkSRR53eakpVMEoYvEwAA71Gxrsx5HMPbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lGGXzoSX; arc=none smtp.client-ip=209.85.221.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGGXzoSX"
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4870ee5618aso369222f8f.1
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 02:33:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1789637579; x=1790242379; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=XLg+WWoCYgCGUuXdz7tNXtS+CEP4a258vdZIA6xLWNg=;
        b=lGGXzoSXKH956DfJfYojBwngDmyfsAWeIjw9eDgLPuna31En2aIho92UypPv7am1VR
         /USN+ShizLse5PNckQZFarPLialVznoEsDQrHu+2N1yHx3TLjCxb8Fvqsjvvh6NwRtAx
         COe6GXAR8xkxfaEV2dNnAEJ1cI1DsXhHdM45rkjrsogrGJHYrLTA7GbU7y8lBY/Zl2tn
         f1X8rkzedCG5cm2dsBwVlFFPRLQTt43tRTHsFiOKEnH/AuJHGlYFrSMkIn+5vqnCeGWC
         F6T8Ytk84w5vDdr69jvEhkhTFVaSEbUonbOWlkGXm2vRZFDwKU1VrtPtJLpPnLNMqmmF
         4dvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789637579; x=1790242379;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=XLg+WWoCYgCGUuXdz7tNXtS+CEP4a258vdZIA6xLWNg=;
        b=fXCJ4dSYmlrCFcW6CQLI8sOSUtUE86KmGhrhwz/uTdDUNd8UAxUEyxYn3Guw9PYca9
         Ty1MEMS9OWC0O8worh3v7R0PJHvP7gZII1aFNe4ckaNO7who+Erv1rH9LWyPDagu9uUc
         rJAiqJ9Ez78MUu4MA6BsTKtgVy0vVEJh99tBPmhxJva2v9rsWt+N4VjUxyj6AbRpWu80
         XuFq5xvVT97NeLmD7Ud2CrMTZtMjsxZq1c6Ki8mF4JV8bR0nwCL9zdRIEiPD2N19D1Og
         Q+eaPlwJqAmCf6FWtngw24Ax2Tb6SIgYeDwUrXEVMj4WIOnHXQHcnCU9JQLpWTQAhQG4
         CyUQ==
X-Forwarded-Encrypted: i=1; AKwUvByT0XxquWZmtodwCxVgPJcwaiPWPk1todEaq8QSE6wGy9EG8tovyV6M2s/1g5MDea7nYMgb3dE=@vger.kernel.org
X-Gm-Message-State: AFuF++nzQRszDxkArnS7uXn8K6fFPNFTSSlFhFL+545MW+Xz5l+wV9+h
	UIhDJE+1M9NzucxzPE4zxv90rU3zqxxJfb6tDbjCVVztQ5BZwiswxEqxwjvbvjjfH5tTxXI7P+V
	Nk+UHJbqEDP+1whZO7A==
X-Received: from wmwb12-n2.prod.google.com ([2002:a05:600d:444c:20b0:49e:eb51:f8fb])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600d:1b:b0:49b:9105:cdaf with SMTP id 5b1f17b1804b1-49f1d516a12mr138409325e9.8.1789637579365;
 Thu, 17 Sep 2026 02:32:59 -0700 (PDT)
Date: Thu, 17 Sep 2026 09:32:58 +0000
In-Reply-To: <20260915144231.31932-1-sagartaunk@proton.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260915144231.31932-1-sagartaunk@proton.me>
Message-ID: <aquzyg0T67vu43T3@google.com>
Subject: Re: [PATCH v3] rust: net: netlink: Migrate to zerocopy's IntoBytes
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

On Tue, Sep 15, 2026 at 02:42:44PM +0000, Sagar Taunk wrote:
> Replace the kernel's own `transmute::FromBytes` and `AsBytes` traits
> with their zerocopy equivalents. Specifically, this updates
> `GenlMsg::put` to rely on `IntoBytes` for converting attributes into
> byte slices.
> 
> Also, add `Immutable` trait bound on `GenlMsg::put` as zerocopy
> splits the `no interior mutability` guarantee that `AsBytes` bundled
> together.
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/1241
> Signed-off-by: Sagar Taunk <sagartaunk@proton.me>
> Reviewed-by: Alexandre Courbot <acourbot@nvidia.com>

Thanks, this change is ok with me.

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Can you send this to the net folks? Please update your patch title to 
[PATCH net-next vX] according to the guidelines outlined in:

Documentation/process/maintainer-netdev.rst

Alice
