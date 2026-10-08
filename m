Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4298F3D25AF;
	Thu,  8 Oct 2026 10:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791454190; cv=none; b=S2aV9BoIggQETwhqRWlgz4rFzVFtt9DxbVJ+x9acMMbM5ZaB0Wb74j4WEalUndOxi3J5SwzFPmifCV2BKeTUvOGoaW+cD1czcmfLbmzaIoicb/YJXn9Xb/medEw9k1cYpYxjkWEEf3Zn2Xr3zoGBhaplBfbdmmSKnD4s2Og7acg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791454190; c=relaxed/simple;
	bh=x8GQ9TqAFu5driuvo38kqzYt3n324pebOlaNmEELI+s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KjnKVqqp8uu5NHxqQiuXF5bKDp662qgIZ6RW9Zr6wDq61c/tF8tkYrfatgvLkvmZ7ixGiQDQDaXAUADvjHJm96sgDNEPCGKfy+gKPRKIyx9HnLEhW/cCdQr9nQNoFb+wkykPtIvfW0JbOSyAE9S26bNpk53NqyAqdjWMh0JKDZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F5OfPuLm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F5OfPuLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B791F000FF;
	Thu,  8 Oct 2026 10:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791454189;
	bh=PJRu7W6/Or1we5Gv3BgoLEtby0D0Y0UGgfjBHfRc5+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=F5OfPuLm1vT75XQKGsurJFPJQUyvqw2uk+P5V4OHkmdeULjhdt4/GtaW2ntZSMECf
	 XayWL1Q+dMFWHtkkR1PvCazs3GiD2zv5DPevKpH5uH1LaaFNxZWVWtRbczysGhxWbv
	 bSnsY6G1pOnsDkx+p9vluOnOu8KEQDTNFlHcxhULqX6dW8WsxD3V3fCpyQa4yJX2ID
	 +O2HtBnbRsP7Ao4ll08/ntq5mJCcNT6WVhEeNln9k5tPIqjprj6GNPRxx1LjK5VYH5
	 I6o8t28WoMjRsUbBQvFFQL/JFEEq4l3zHXORhcgwZ/fEGqCQO02R+MKCdrP5gSJzt8
	 7cl7gHgPL5Bow==
From: netdev-bot+sinfo@kernel.org
To: Theodor Arsenij Larionov Trichkine <theodorlarionov@gmail.com>
Cc: edumazet@kernel.org, kuniyu@google.com, pabeni@redhat.com,
 willemb@google.com, davem@davemloft.net, kuba@kernel.org, horms@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: use the full socket in sk_mc_loop()
Date: Thu, 08 Oct 2026 10:09:48 +0000
Message-ID: <179145418821.2527009.15076291801199457464@kernel.org>
In-Reply-To: <20261008100423.1256884-1-theodorlarionov@gmail.com>
References: <20261008100423.1256884-1-theodorlarionov@gmail.com>
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

Please do not repost the series just to address the above. Instead,
reply to this email with the missing information, so that reviewers
can take it into account. If the series needs another revision for
other reasons, please include the information in the commit messages
then.

The evaluation is done by an LLM so it may be wrong, if you think
that is the case please reply and explain.
