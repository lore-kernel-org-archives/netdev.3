Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F2120E023
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 14:20:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791296405; cv=none; b=NCXpnbVRXbaxxja7uxUI2KMrvufdEYL4X6J9R1ywO/+zhmwgnPx7Yc/aIRde062NuqbHehYImR8oZniZOtkPUvDMKWQlO1lzLKoLpU2lBJLwmuhcN/z/naEhgvJNYfFHjkHmV9rjqvco90Yh/P7eykBUdohE+iuH9o4SDoJRfNs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791296405; c=relaxed/simple;
	bh=gp7PRv3WjAiMJrp0DvXpRvTv3mwC8R3NiezXzUE7FxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=o3tU2J6uI0YIlH0+4u/UY3nD28c3uSdGb+VS7Hvu7aGz3d3lrsMf2IBJ/RL4WLwqeRD+gIJRb/Ue6HzBgCMGIKwWCiL1ZtdvW1fvQJr8oAf1FblkR0Nj/lXwcwt3XI6/QlT3qQxIHWCPIc2TWUR10w7IzqlRDotipGwBSzKmssc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YkZ0iiHf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YkZ0iiHf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3925D1F000FF;
	Tue,  6 Oct 2026 14:20:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791296404;
	bh=Z9zRtXHe/J1k/4/9wAeq1n+PwAt+ioXmV3zyjSNrjDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YkZ0iiHfBv3cyh0wgj4LIlrf0CpAhjn93bi/DYzt1OYHwmsr39zkddfO89yMzAncw
	 77qqfMamt+NNvunEqwtZ7jPkfroIcP3/Pwl1yzdvBDvz8jjutidyoti0+QSn8BrvLG
	 R5Ad6mOXn/Na+4IRAMUwkrvIxh/Qu/LcSHy4ymVbp0C3/smn0CLuQyvQK9zu7KYQCx
	 ezxbrfJKRWiEA1Sg6rpd2rkZZNFynCOcG9Z7tgbKqKhWTG6Q27DYsPz3TmnsnAkc6o
	 0ghkQVsqea5KYV4gAn6/+pKNDQSoAsLKZucPK7HL/pgSUhi+cQ7ZxqLpIZEmwfnHeY
	 Y9DOyeK8yo3gA==
From: netdev-bot+sinfo@kernel.org
To: Sebastien Royen <sebastien.royen@armadeus.com>
Cc: Woojung Huh <woojung.huh@microchip.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: microchip: fix KSZ8765 fiber detection
Date: Tue, 06 Oct 2026 14:20:03 +0000
Message-ID: <179129640372.2231598.1056441247005614175@kernel.org>
In-Reply-To: <20261006130006.134847-1-sebastien.royen@armadeus.com>
References: <20261006130006.134847-1-sebastien.royen@armadeus.com>
Auto-Submitted: auto-generated
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi!

This is an automated message. This series looks like a fix, but its
commit messages seem to be missing some information:

 - How the issue was discovered, e.g. hit in production, hit during
   development, syzbot report, manual code inspection, LLM or static
   analysis tool scan.

 - Whether the issue was actually triggered, or is only theoretical
   (e.g. found by code inspection). If it was triggered please include
   the symptoms, like the stack trace or error messages.

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
