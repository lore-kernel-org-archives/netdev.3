Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AA6338AC6E;
	Wed, 10 Jun 2026 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781076599; cv=none; b=i2hxOBbw0G8ox5OfdG006iljEqahX5FMtqoSTCQN/2TWREDZQqi4Q4F/idx8+BefxAZUPKY92Y49v4yVVT/cEBxl7VDkDCSeO7yn5W4TS0aNH03l6p2ELbEyF/r5k4qX2MM39V2MSUbi8aLB/ASEm1IRzzuOw51ylpheRF16ZG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781076599; c=relaxed/simple;
	bh=AiSFfMoIY2TE+nHxtwX/bpt7ovICgLMC4JbA8Q1cu8w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U5YpD6dE2QNCEBkdV0CHRcOcgGNnH7fPOMzdj5oEo+HvkyAId53qA5BBEvAtYLest2RVjvq76m9Hc8VCEzm3AntJRsdK5jaQeyCuOa4tCFmTFfB9X+r7JT+8QLl5Vmf4pzMWn6xy6aUEqGm9ASfbqEEXPGElETsUyBufM+J6iQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZfgQ9Ljx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZfgQ9Ljx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2E31F00893;
	Wed, 10 Jun 2026 07:29:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781076598;
	bh=AiSFfMoIY2TE+nHxtwX/bpt7ovICgLMC4JbA8Q1cu8w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZfgQ9LjxioHkZ8YmzINDziO5XNY3bRg4375unc2i/iSTsSx/Jf6jtcxsX1oVw34A2
	 Maf7TTGdgfGi+Txkn/Iv9h8Thn4iKD0Hxas9qKpQwjYc73/VkVbjnajBP6xGu58eMH
	 7cgtoE8Fks9ZbYWqYxMw9J8XZYy+BZpTny4HvF2HHyG8rB5J4n3P5vm9tw26sPRIME
	 h7uWafB37kG+MmaIz0+uALe77dnFgyQJey/7f7J6v3FU/boWoLfLPqxfqT65JM6b8P
	 ffLt+NgkW0QM7H1eQZQHDi4d15RamybNOry6SIKA4jD4d75nf7qbPwJg7ZOkVZ9cEZ
	 FROfc4w+6TjWw==
From: Miguel Ojeda <ojeda@kernel.org>
To: gary@garyguo.net
Cc: a.hindborg@kernel.org,
	acourbot@nvidia.com,
	airlied@gmail.com,
	aliceryhl@google.com,
	bjorn3_gh@protonmail.com,
	boqun@kernel.org,
	dakr@kernel.org,
	daniel.almeida@collabora.com,
	dri-devel@lists.freedesktop.org,
	driver-core@lists.linux.dev,
	fujita.tomonori@gmail.com,
	linux-kernel@vger.kernel.org,
	longman@redhat.com,
	lossin@kernel.org,
	mark.rutland@arm.com,
	miguel.ojeda.sandonis@gmail.com,
	mingo@redhat.com,
	netdev@vger.kernel.org,
	nova-gpu@lists.linux.dev,
	ojeda@kernel.org,
	peterz@infradead.org,
	rust-for-linux@vger.kernel.org,
	simona@ffwll.ch,
	tamird@kernel.org,
	tmgross@umich.edu,
	will@kernel.org,
	yury.norov@gmail.com
Subject: Re: [PATCH v4] rust: make `build_assert` module the home of related macros
Date: Wed, 10 Jun 2026 09:29:47 +0200
Message-ID: <20260610072947.338278-1-ojeda@kernel.org>
In-Reply-To: <DJ4Q5J5OILOX.1KCPFIVUFN2VV@garyguo.net>
References: <DJ4Q5J5OILOX.1KCPFIVUFN2VV@garyguo.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 09 Jun 2026 19:19:42 +0100 Gary Guo <gary@garyguo.net> wrote:
>
> I think I just kept it as is when rebasing. It's file to have them grouped in
> the crate to.

Thanks for confirming!

> This one is using size_of, align_of, c_void which are all in prelude. However it
> looks like I forgot to actually remove these imports in the last version, and I
> didn't change it during rebase.

Ah, I see, makes sense.

> Are you okay with fixing during applying, or do you want me to send a new version?

I did it on my side. I also tweaked a couple more bits: they were already
`no_inline`, and I noted that they sadly do not appear in the prelude anymore,
but the change looks fine and that may be more of a `rustdoc`-side issue or
design choice.

Cheers,
Miguel
