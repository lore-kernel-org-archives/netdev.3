Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EACCA6F;
	Tue,  5 May 2026 23:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778023006; cv=none; b=LTv5jy4FY3J+4IrVncbrB3r7a1h2O5ugtZupQkAeahmzB/fjadxrB5ORq45MkWAYxk7wo6qbzhe2WTJ+br9ugg75XrVe4hJ1plUhap0CLiipPzzHF4w0XW96vJnuBKcv9xnJHQxXeIZZycweyYMbtMeJNvDUzMqAKFSxa2/XUrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778023006; c=relaxed/simple;
	bh=nS9bfT8zK49jmC0dUWw2ngeOCqazm+jrd5fomE/rMiU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8EOxbgJ7krqut+jg1xrArmoiYiSRZP2tM/ufdOEelAUq7MNo8ttUGCa393cI9futnQZHSBQCiZFvaSJk6Q75FZMJNfoQRFd4nmjvTJ7UzFEOEUbA8UdGGBwZCLMZgtze6aSuofSj7canGaC8wmhIeMgPWVSYbqf+CorJWJxKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxmfHOtZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxmfHOtZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D125C2BCB4;
	Tue,  5 May 2026 23:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778023005;
	bh=nS9bfT8zK49jmC0dUWw2ngeOCqazm+jrd5fomE/rMiU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nxmfHOtZkFwnqyialFj7b4w6ZbInFQOh0/D3MpisbSYfSAqbpTBsb2tooOsrOIXn5
	 ixlSAZad21UUwZZArngr8+MGVBDGT8t4EgkOBQmXo6PnAIYwUsmyqZKdK6dFD5Gy3g
	 LruLgIjMpePrMNAcqlp1pfH3HMatWqVhXIaBwkmm/MPzTQM5dfv4S+Dhcs/EuMkONA
	 TJfEUJ23UyKnhIU2gPxLv4IZrG/p5lBM+Fl/CKKJ5LAs19M6Ul9jVGjFxpD5Ozau/f
	 EFpK57/5w0g4UpEmrFXa1vdalV2kRpFf0McozQAGfmqaBRvrQYwT4XQiZyHwXJWi6S
	 wkNrvvKb3O7bA==
Date: Tue, 5 May 2026 16:16:44 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lucas Poupeau <lucasp.linux@gmail.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] llc: fix coding style and memory barrier documentation
Message-ID: <20260505161644.0fd7e3ed@kernel.org>
In-Reply-To: <20260505192549.74382-1-lucasp.linux@gmail.com>
References: <20260505192549.74382-1-lucasp.linux@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  5 May 2026 21:25:49 +0200 Lucas Poupeau wrote:
> Fix multiple style issues reported by checkpatch.pl to improve code
> maintainability and compliance with kernel standards.

Quoting documentation:

  Clean-up patches
  ~~~~~~~~~~~~~~~~
  
  Netdev discourages patches which perform simple clean-ups, which are not in
  the context of other work. For example:
  
  * Addressing ``checkpatch.pl``, and other trivial coding style warnings
  * Addressing :ref:`Local variable ordering<rcs>` issues
  * Conversions to device-managed APIs (``devm_`` helpers)
  
  This is because it is felt that the churn that such changes produce comes
  at a greater cost than the value of such clean-ups.
  
  Conversely, spelling and grammar fixes are not discouraged.
  
See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#clean-up-patches
