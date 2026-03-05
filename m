Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BFF33688A;
	Thu,  5 Mar 2026 01:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772675529; cv=none; b=hY2D6230KcWayaZJG7+gZe1MuR52v8sX9ltdUrXnHxlVdVy1c1Js4IPLZ2IF2ZgnC9v8IXU0gWnOVBAmd8xoGzlEKR4pkq9bqtavXY3cCxBMkckICEQOhHwCbSmvvfhEubRG6AOW3O/pnlfzGHXuMiVO8OebR5RbgBiWXV56aMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772675529; c=relaxed/simple;
	bh=38eLZwa1N0ky1cnFE0vVd+2D0Z9IYQ6iTYvraDEsKDc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIcdsN72nL+Dzb39n8JySqUroyk1TrnnDUtE7eNP0M03gzqNldsKpbN7Xbd/RUZkLnYvvYNxg+kysmpIfxF+ENgIANVElwBDfk+m1dHUD7AC2MbWOnpz6vMFgV9mT/opk5PnQobyxZ8ycQLXG8R9PuVZQ296QUMjYPx0K7FLmr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bBmaYtjc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bBmaYtjc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C55CC2BC86;
	Thu,  5 Mar 2026 01:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772675528;
	bh=38eLZwa1N0ky1cnFE0vVd+2D0Z9IYQ6iTYvraDEsKDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bBmaYtjcOq+PIL5rFrnuTXt90GUi5bm5CwLtddqFLe3Ui5tU0eibdqimmIQkjCyWY
	 BA5Pj584mReZsSei0lTOLv7rQmxA1AYbJid8mm3BzGEuFGH0dNyVGgaNq5qymls594
	 +9wELwI2SMA2aQksR6w3KI5wQVIbz2jQukN8JKwyUZTycLTQcnW1sj6iHClHSvElnO
	 Eq5n8uS6wXaqNhJEuLxAQV+RUd5l/jz5NhAD+N9xjHi5CK6UMcVTZKToRGWrOir6ED
	 ndTgSY+dW1PwsaOvx6Ci4UtGHeOyF4XZQPZFxwcPA/rBExoDgomASYDhmZzsmkS+Ot
	 0U93RX0D6uT+A==
Date: Wed, 4 Mar 2026 17:52:07 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Chengfeng Ye <dg573847474@gmail.com>
Cc: jeremy@codeconstruct.com.au, matt@codeconstruct.com.au,
 netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, horms@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mctp: route: hold key->lock in
 mctp_flow_prepare_output()
Message-ID: <20260304175207.34579d99@kernel.org>
In-Reply-To: <20260302174056.796540-1-dg573847474@gmail.com>
References: <20260302174056.796540-1-dg573847474@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  2 Mar 2026 17:40:56 +0000 Chengfeng Ye wrote:
> mctp_flow_prepare_output() checks key->dev and may call
> mctp_dev_set_key(), but it does not hold key->lock while doing so.

Please add an appropriate Fixes tag and repost.
-- 
pw-bot: cr
