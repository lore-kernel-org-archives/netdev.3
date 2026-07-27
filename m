Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AEE63D4108
	for <netdev@vger.kernel.org>; Mon, 27 Jul 2026 22:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785191120; cv=none; b=AeFhZAoc2/bvLMjAPyw+Sup9nLaZouECZZimb6jlLCg+YKDdnwfAtw3KRf8uNjD0n2NnT8rTp6ManiR/dOQ9I3SOy3QOAY1UdxJosK5GlX8rf+G19uFSfp2UqH7CbhQwdEn5r80ZabAF4pcil6SEAuxWWYil0C7iFNAIN1VPNXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785191120; c=relaxed/simple;
	bh=HusUj4PtiG4aXS6ZTL72Vj2Ia5adJqJL2SAIguW7WFw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ji9fRUnMf+iu4D7C3vUCZ/WVhkBRuPvDfwyQdf7zY0Lv2ZQd4M2X3xuvMa9ze9N04Gu46V3oHTW6yqZ46sXDMuVhkI0VDge9G3baxqDGLwsEURchMc2BB0669t6zry2scDXTk7kI6ZpR//OD4xpgaGWqvNRKi/QM/Ydrz+maf9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBlHENNl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBlHENNl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E238D1F00A3A;
	Mon, 27 Jul 2026 22:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785191119;
	bh=HusUj4PtiG4aXS6ZTL72Vj2Ia5adJqJL2SAIguW7WFw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BBlHENNl4V9vUxKxZoFkL8pG5A43gESiwZ3hYDD5Mvq4P8I+doMSO7Otd6ot+To13
	 B0ow2u7ABK13hoSCJY8rE2fZvYhhaqNHxCL4dlsf3Eo/+nrok30kMTmXblTRDKPalh
	 a1v+MGq7Vho9L9GkQRdYGIcOrxshOZnyvO3IJy2KYZPAlfhBQDcVaCbZxeduUEDG4u
	 Gd5oqhbX6S2LKqYxTFGGrhbmW7qr6jNLB3LebJaQOB99cAdzWn9AdJk8bXVo+HxwFh
	 9A+FtkAOZh6SB5JyQ+hhO4lTWFOzUFjJde5AF+G6Yiszb0yXHbwTk+iaHQ4QiPvixl
	 m0MjtEmK6Du+Q==
Date: Mon, 27 Jul 2026 15:25:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org
Subject: Re: [RFC] docs: netdev: additional info requirements for bug fixes
Message-ID: <20260727152517.312895f3@kernel.org>
In-Reply-To: <20260727204724.2787038-1-kuba@kernel.org>
References: <20260727204724.2787038-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 27 Jul 2026 13:47:24 -0700 Jakub Kicinski wrote:
> +All bug fixes must clearly state how the issue was discovered and validated,
> +and how the fix was tested. This should be done in plain English, not with
> +special tags or annotations.
> +
> +Example statements describing discovery:
> +
> +- discovered by a non-AI static analysis tool.
> +- discovered by an AI code review agent.
> +- discovered by manual code inspection.
> +- triggered during code development.
> +- triggered in CI testing.
> +- observed on a machine in real use.
> +
> +If the issue was not observed in reality (e.g. it was caught by an AI tool
> +or manual code inspection), the next sentence should describe the
> +reproduction. The reproduction should state whether kernel modifications
> +were necessary (e.g. inserting a delay to widen the race). The commit message
> +must disclose if error injection or loading a special kernel module was used
> +to trigger the issue. The reproduction steps should be included in the commit
> +message if they are short (roughly 10 lines or fewer); longer reproducers can
> +be posted online with a link included.
> +
> +The testing statement should explain whether the fix was tested against the
> +reproducer and against kernel selftests.

We should probably also add that the commit message of a fix must
describe the impact to the user.

FWIW the intention is that we'd either quote this text at people
until they comply or even get an AI bot looking at all patches coming
in and deciding if commit message is good enough. With some tuning
LLM should be able to check that the 4 items are covered.
