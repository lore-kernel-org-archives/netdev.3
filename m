Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CB32248B3;
	Fri, 18 Sep 2026 22:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789769301; cv=none; b=gsSje7k+g3OltuXuZNdBWkZ++AL4Nleahx35qWjhiVDeuyHIWLzzvKsUnXJ495lccvOXshQV5WZhNNmtZaO4z26mjs0sURVF0zBHQswhANRR7FRsmdr2pq3VbPJ0jdGRU/Gq8BVSchHWFMzKEqU4Cvx2ewnHYRQiGi1aYXgsFe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789769301; c=relaxed/simple;
	bh=/affaXZ858bI95xWY+VklhMke5pENi/UOyEsa/ZwDq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AbVQRX6T0uR6XqyUCso7cgqbz8HuwWzDhkM1lrMuLGK6B+Uxac9OwDOOWe+l6mnWedrU97w9/CftRwmiss0guCR/yio5tZMKO+7oX9dXxNeVuTKvRU+/d5lkT5kwjvav0fx3AwbwQzSxv1ZT6iKQHk1MkUQOX9qNIYXdWKQthCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fIZUncTl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fIZUncTl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE941F000FF;
	Fri, 18 Sep 2026 22:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789769300;
	bh=JPUNhhcv7IMHO4fGWmQ7mNAgmfT/KiBR/RHZsm2z6Hw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fIZUncTlha9SkYwOhjXWtKeBc+ha/+UdF0wds0o7FuOHTN5E30JQKIaEmPT7S3LKH
	 QmGVC38NYd13YF/pO1VnEnI5ciLR91HwV7xhV62OpLDXB83WKk6awPSEclTiSXxhBR
	 lxvh1b+ZILVJZk9FJoBvWoN558yqvoSEmL2GyXcPkR4RoznzFGl6+KmlS8ZXWqPzSb
	 o98IFOrahjqcFYZ+WMCZRW3H6cOauRIi5FeJLIi+arg6+7QSUnVGuIbMV72114Zfsj
	 w79MvZMVf7QEYHGIZCIillvlzrbh0ixmS547YRNHmghQ7jpu085796YoglLQyeqQ1k
	 A37KX47fdqfBA==
Date: Fri, 18 Sep 2026 15:08:19 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Lalit Shankar Chowdhury <lalitshankarch@gmail.com>
Cc: Raju Rangoju <Raju.Rangoju@amd.com>, Prashanth Kumar K R
 <PrashanthKumar.K.R@amd.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, netdev@vger.kernel.org (open list:AMD XGBE
 DRIVER), linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH] amd-xgbe: use str_yes_no() helper in
 xgbe_get_all_hw_features()
Message-ID: <20260918150819.68ff0b6e@kernel.org>
In-Reply-To: <20260918133218.39778-1-lalitshankarch@gmail.com>
References: <20260918133218.39778-1-lalitshankarch@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 18 Sep 2026 13:32:18 +0000 Lalit Shankar Chowdhury wrote:
> Prefer the str_yes_no() helper

We don't prefer these in networking
They provide no value and just lead to waste-of-time conversion patches
-- 
pw-bot: reject
