Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D03221FF23;
	Mon, 27 Apr 2026 16:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777309013; cv=none; b=oh1S5OwRcZfmr2RlGwxtxfk0W2qDXwJnKzp8jrksfgU/IL5eUiUUIenMtR0hZapRdyL/YXUjit+9wVciQ0FZRwsiKtoVUXGpsZ29OyrqOrqeG3tiVE7uFNGhMJglfO70LNIboiGERJQM+NTvJD7I2qVaz63rv62VRacxy6z3z1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777309013; c=relaxed/simple;
	bh=f27ZLtfQ2psiLDLiOwH5MCujuxwYVldjPQ50+2ta5yE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ptp7tl/LHv4ECoJN2KO81O00G7ja6vVGka3z9NPB8cq2tCrQRZhpq53SI3STmTtT6BaQHECBvSWtbFeWthfO2toc1WpYDB0Darrdj0EH26IlCuzAJK61LklFje0ZYD+Y1knXIEIutrJhEIG3/PdLpH9YyVLG9PwN9ufryAyBP3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n/Y8fswy; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n/Y8fswy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E1D9C19425;
	Mon, 27 Apr 2026 16:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777309012;
	bh=f27ZLtfQ2psiLDLiOwH5MCujuxwYVldjPQ50+2ta5yE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=n/Y8fswyztEfU5UCdECt2vxG0crOGwPn9E+G+IXW5EbYezLN7WziDS06zX+lCHQae
	 /tQdFN1U9JRfNZ0OB7CUM27yQIoNZ8NXF8svD7CF+krxI2Zm40wsvqPlU3jS7+DJF6
	 d760vP5NvxKECyVmnb7pqVD9xt2SDF3Vhv7Lx+G/OfMoSBHtTaC+3bd19YomRc9JOM
	 pRgXUCA5WNS9XPbxGlux4RKADCW8Hkxhzo+uSVMuw8Y2ozmej6oQtENwR/B2EMeHLX
	 49hgWm6ZXog5gs0VYUXjFS0X5/veSZJxdNuCeUMjLndL9YUhMrkWgMT8tfDV4+G7Qv
	 jljc+PFP+Mdag==
From: Pratyush Yadav <pratyush@kernel.org>
To: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Jakub Kicinski <kuba@kernel.org>,  davem@davemloft.net,
	netdev@vger.kernel.org,  linux-kernel@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Pratyush Yadav <pratyush@kernel.org>
Subject: Re: [GIT PULL] Networking deletions for 7.1
In-Reply-To: <7ia4se8lb0vf.fsf@castle.c.googlers.com> (Roman Gushchin's
	message of "Fri, 24 Apr 2026 01:31:00 +0000")
References: <7ia4se8lb0vf.fsf@castle.c.googlers.com>
Date: Mon, 27 Apr 2026 18:56:49 +0200
Message-ID: <2vxzwlxs4a0e.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Fri, Apr 24 2026, Roman Gushchin wrote:

> 2c on Sashiko:
>
> 1) I'm working on an infrastructure to separate pre-existing issues from
> new issues. My current thinking is to stop reporting these issues with
> reviews of new patches and instead put them into some database and give
> maintainers access to it. Sashiko will automatically deduplicate issues
> and index them by the source file/subsystem. Hopefully it will mean that
> maintainers will see only a limited number of issues in source files
> they support. But I have yet to see how it works in practice.
>
> But I'm somewhat concerned that this way many of these issues will
> remain there forever and by reporting them with new material we actually
> have better chances to get them fixes. Maybe it should be configurable
> per-subsystem. I'm very open for ideas here.

Yep, I agree. When I am looking at a series, the context is fresh in my
mind and if there are small fixes I can write them and send quickly. I
would be less likely to wade through a database, since it is a lot
harder to build the mental context. But then I work with subsystems that
get far fewer patches than something like networking so the noise isn't
that much of a problem for me.

Maybe you can visually separate the pre-exsiting issues (perhaps also
allow filtering?) so people can quickly see the problems with the patch
and don't always have to parse the rest?

>
> 2) Re false positives vs finding more bugs I had the same experience.
> It's easy to tweak it to be more conservative or creative, but it comes
> at a price. It seems like the real answer is simple a better model. We
> saw a big improvement internally switching from Gemini Pro 3.0 to 3.1.
>
> Thanks

-- 
Regards,
Pratyush Yadav
