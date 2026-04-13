Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B15CC39525E;
	Mon, 13 Apr 2026 21:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776116058; cv=none; b=ms5MGs+RvvxNulemj/xKWcJ5JkIGrbS2PkCoA3CY4ST6khZesOJQLN03eTSnmRg98m9i5CDn9WmxTLySMdLnoS8x8YjZnjdkkSavR24jkc4EUuFiwgmTXbIYcINhuX/1eHVCSwOIw7CtGASXSoBRnw1rZz4FyerdQ1Wqb3OLW2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776116058; c=relaxed/simple;
	bh=nN6iPHVDoPf1ZiwVgyq8gelm+4dDqyVAlUk3nosHljc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fxud62pVv6kR43gI2IBvQo0rjNM5U65eISE65f123qb3Bb6tAFYeMZ4kOvmtjS8jzIvFQ+htUBndjP/cWUxNgn7SixMwjXqGwxoccU3YkO9zCs0EulddWUwmCgrqvMDvYljh3hllSIX6g4///nRtiJFsuRfW3suwm+HJDlK8X5o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q7Q9N+w6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q7Q9N+w6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FCA4C2BCAF;
	Mon, 13 Apr 2026 21:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776116058;
	bh=nN6iPHVDoPf1ZiwVgyq8gelm+4dDqyVAlUk3nosHljc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Q7Q9N+w6G8zxSR+Ba4ACX80jglvBc1+koXL5NnSGVdREDYaOoiF8YJgARNxekwRY+
	 CV3IW+AV3RKm6NU+0c+y5+XWhOJw1Bra/Af7IyWEESQ+inv57ydGvoH9jt+8H0LvH5
	 gYVIMux8pBvx42b7FlhO6+BA8rQlHlNpghly5088UMFTpoynbfHW36oKLAZx4BJ5VR
	 rK0luuLu6/UzL9NK96QAvua339wHgsOivouVHLLeUd0GnEH9o37U9Uk4/6O7gr9h/4
	 uln9Ysj1CdkFKZxnJ8RWTTrJAgo2UcoTEeWbi93e+tjvmVkVwGENrPeUu0obaW/U+a
	 c2IRq724kNMZA==
Date: Mon, 13 Apr 2026 14:34:17 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Andrew Lunn <andrew@lunn.ch>, f6bvp <bernard.f6bvp@gmail.com>
Cc: linux-hams@vger.kernel.org, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com
Subject: Re: [PATCH net-next 1/3] rose: fix race between loopback timer and
 module removal
Message-ID: <20260413143417.0657ffec@kernel.org>
In-Reply-To: <8e76226b-c861-45f5-9d18-8affa0c80525@lunn.ch>
References: <5a88b747-bb06-4ebd-99de-80ceb574cf22@free.fr>
	<20260413174238.112418-1-bernard.f6bvp@gmail.com>
	<8e76226b-c861-45f5-9d18-8affa0c80525@lunn.ch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 13 Apr 2026 23:21:16 +0200 Andrew Lunn wrote:
> net-next is current closed for the merge window. You can post patches
> as RFC, but don't post anything expecting it to be merged.

FWIW I assumed this were fixes, in which case the closing of the trees
would not apply, the patches should be marked as "PATCH net" and have 
a Fixes tag.
