Received: from mail-ej1-f74.google.com (mail-ej1-f74.google.com [209.85.218.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 039A83A7589
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 14:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773930803; cv=none; b=Rl/JomUXuQ9oCZqzgmNd+lboYrHZFZxz+mSnFwc7uXxrrbdlywOoE2bSP6EY7cjpE3XMu/2K+Wt1Hf79IPxkccynyLOO0/0JU9HKspcok8aB37JIXprHHriV/WCbaLJ8Giz+B0yUUD+wg/5j2W6GdPVq3pEbvKA9BYI5MqTKPPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773930803; c=relaxed/simple;
	bh=CUqfhEJRi2PChR2DmP6wNUXoON4jGbn9sMb3OgUY2KA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rAf10DGhIMDBctKzAMcAHBf0dHIjv0rQ/vTa9fK1KkCbddIx3oCBgthDZxoQmcGm6VxQzS5BwN/V6kE3siTlpZQ9cJg+D9pvgWFH5FPXYSAukt5xD+syxIVcpgx6Ps5l85duaZUOKPZQDw5c9htk/XCq/vt5+QGRZMyp/+7qm3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=paZkKt05; arc=none smtp.client-ip=209.85.218.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="paZkKt05"
Received: by mail-ej1-f74.google.com with SMTP id a640c23a62f3a-b97b6ccf166so108237966b.2
        for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 07:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1773930800; x=1774535600; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=WPdU0RGKwneFH7OF6wzVXdtsY6BXzcqmiGE7v4NtV4M=;
        b=paZkKt05xAW/0vOCDwEL8inyjFInGqUxQqcWBo7SRG14qTPNl+6tqApOK7OF9Srh1m
         XUzVgIuKD4vVOYA2Oejl7gOLoNSpN4Q7hT/COg0nmrNy53ktrHThg/oGM4SfmHKYq9r8
         rTscKYuDbSqMK/j4xtgQNItWjd2P1Dscc5/ELULhbdbBpuJqmucQUHnA7B4y+ABLKQg5
         xxX6kgDxaLqz4d/VHgMcWhFPGTENLiHf1m7go4oB/QZNLQmmUNch8X/CvfnJSIdTjqGS
         Jv4yUS330FTXcm+RSadmvcIOihdyiCUbURyFipfVnJITZ47nVKBf22RJvU43F5syVMbz
         sI+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773930800; x=1774535600;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WPdU0RGKwneFH7OF6wzVXdtsY6BXzcqmiGE7v4NtV4M=;
        b=K4TNSgs4STGoeDqcQu+ITJIfp5jUVm2d1yx1FvnIILpPuCZUARZaTwF28OrgS3hZsq
         gFPAiI18kn0ar8h/FoqhM7/B2Yk6JvaeuPFHX2IEmVbI2BHUlkubGQIR5BzJwP+pDQkz
         c+0PkUCyuhuPoESVraR5UauNepMR3XPHX4hnFGpz/2VeV94IkHlKmiTLhY+b9SL5M2QJ
         3SZAGkot0d3kZFV3hVHQsyvnFszStytVxyDoZK/V8Ce540RCwzgX8FDC79BfO6fTl725
         63bLkgxN/yE1fgMSGziGs5Tq80G7zv4tgtNcZylLv6YD8VfDpO0YOVmaJjGylPQDN6ws
         /qzQ==
X-Forwarded-Encrypted: i=1; AJvYcCWkCONEmC07hCBLkY9bB7vWRoE5BQWWPn5AQX6xojgAlYH/biqE4YTgwNmOa8AX5OwvstY949w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/Cbk4MFBnD5jtSHa1h1/ubZ9Zpr6JxJx9oQJq/yI6kT6+2rmF
	TUM2GStfgHvtr7t/wSDifpNfU3N+FtuH4c6xwZUavDdAmmz1loI6LkQ8n8ETPzDlyKluGkhhe5i
	XQY+xXI7Z2V8G5w4F3Q==
X-Received: from ejcdo3.prod.google.com ([2002:a17:906:c103:b0:b97:ccc1:b250])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:1d01:b0:b97:b9d5:4ae4 with SMTP id a640c23a62f3a-b97f48c3840mr428088066b.20.1773930800216;
 Thu, 19 Mar 2026 07:33:20 -0700 (PDT)
Date: Thu, 19 Mar 2026 14:33:19 +0000
In-Reply-To: <20260319121653.2975748-5-gary@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260319121653.2975748-1-gary@kernel.org> <20260319121653.2975748-5-gary@kernel.org>
Message-ID: <abwJL2OTFzSFdVxt@google.com>
Subject: Re: [PATCH v3 4/4] rust: make `build_assert` module the home of
 related macros
From: Alice Ryhl <aliceryhl@google.com>
To: Gary Guo <gary@garyguo.net>
Cc: Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Alexandre Courbot <acourbot@nvidia.com>, David Airlie <airlied@gmail.com>, 
	Simona Vetter <simona@ffwll.ch>, Abdiel Janulgue <abdiel.janulgue@gmail.com>, 
	Daniel Almeida <daniel.almeida@collabora.com>, Robin Murphy <robin.murphy@arm.com>, 
	FUJITA Tomonori <fujita.tomonori@gmail.com>, Yury Norov <yury.norov@gmail.com>, 
	Will Deacon <will@kernel.org>, Peter Zijlstra <peterz@infradead.org>, 
	Mark Rutland <mark.rutland@arm.com>, Ingo Molnar <mingo@redhat.com>, 
	Waiman Long <longman@redhat.com>, Tamir Duberstein <tamird@kernel.org>, Yury Norov <ynorov@nvidia.com>, 
	rust-for-linux@vger.kernel.org, nouveau@lists.freedesktop.org, 
	dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="utf-8"

On Thu, Mar 19, 2026 at 12:16:48PM +0000, Gary Guo wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> Given the macro scoping rules, all macros are rendered 3 times, in the
> module, in the top-level of kernel crate, and in the prelude.
> 
> Add `#[doc(no_inline)]` to the prelude so it just shows up as re-export.
> Add `#[doc(hidden)]` to the macro definition and `#[doc(inline)]` to the
> re-export inside `build_assert` module so the top-level items are hidden.
> 
> Signed-off-by: Gary Guo <gary@garyguo.net>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>
