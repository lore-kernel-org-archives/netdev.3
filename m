Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C024B38F627;
	Mon, 13 Apr 2026 18:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776105706; cv=none; b=fvrJ3txs+nhKUMLe5f1vo56U7XRbM1PgWr3lFmHvoX9uLl/YwFpbdTnAWLorJ6l78uLKd4w8rWvq4PQ0BmRf1fiVQ/9JqItwrjswFscI+XzdDccioTDOURZ4CYpHtdEflD/wPBEh1Xj4iFGgHhd7tJbwKPX2ng7v7/eb9EYPwt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776105706; c=relaxed/simple;
	bh=56haOpwU1zrLkJWy16IfK2PDvKJZWSvTlV7JggOvfK0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ca1Fr4kbOl0gysf7IWAmNYSGG8oTu63n4mJCTwNuAHNSUqqStqOmFjo9Dhrt5HLHU+z0kr9xRNUzCKr1C8mU8EDtYtkzNzw59PcOirPS6fCRhe8N076cfujzFRtQz2j4EeW2HyAiUIfOs5sQZpVANb1WmVLqOTAuqy7bOnnFnIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAc+X7Hx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAc+X7Hx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 004A8C2BCAF;
	Mon, 13 Apr 2026 18:41:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776105706;
	bh=56haOpwU1zrLkJWy16IfK2PDvKJZWSvTlV7JggOvfK0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=NAc+X7HxO9n1Y9p6PgmSHRlnIvl/+s2SiWwrWSkiWIbspQSoGPALYrY3FHPRwwIUD
	 wqwNof3IovgLGdx4usoA3rM8OVkeoMEtArwRS5slOc9Q13PZJGZMFOnXSYe8aoaHQA
	 /HPhIXVB73fvXUXT6GDsrY8Mxcl2edlSBdFGYbWyeRexBFLFx9UPB/zrJgZjHfbhH+
	 iMkj397HIiB2wEX3DksxqBbWz4VLS5EPhmC8zsRU/IVWBQFKT/cDqdUCJMFc5V6cK/
	 YgtwP4jSGNbHyfBtHQKf9NjWd1ALCzMe+qTqnh92TF6go+h+abbTKKa6f6EhcGm0Sw
	 MtfaWj0fYsqYA==
Date: Mon, 13 Apr 2026 11:41:45 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>, "Kees Cook" <kees@kernel.org>,
 stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] NFC: digital: bound SENSF response copy into
 nfc_target
Message-ID: <20260413114145.24ad64a0@kernel.org>
In-Reply-To: <20260413174715.197640-1-michael.bommarito@gmail.com>
References: <20260413174715.197640-1-michael.bommarito@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Apr 2026 13:47:15 -0400 Michael Bommarito wrote:
> Assisted-by: Claude:claude-opus-4-6
> Assisted-by: Codex:gpt-5-4

Could you do some experimentation and figure out what we can do to the
kernel to make the bots check the submission history? It's the 4th time
we received this (incorrect) patch.
