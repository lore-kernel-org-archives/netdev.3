Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B196407CEB;
	Mon, 15 Jun 2026 16:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781539556; cv=none; b=Bj0/vHblkvNOEwMh2Zdy0/NFwcRp0M5ZJ1UbqR4o/0Q3FRvpqUozBQaBU9RiM8nwN2yNtmHdzp0wwY4fYCWr6ubyoq4Slh0LgfrlO+F+2r5u1R/buEbSCyhjEHVy3HGXkQ4O/L1GCkgWWZLDmzs7h/KOZIgtSpATl8dU3zZ5keM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781539556; c=relaxed/simple;
	bh=fBbfrhRmn79BbyB6fl7nepQa7aeEvtcqLvtOQ5Xd/zQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ENuKNMLeJ9PeKzUO3sHE04EBBtub2g1IAem0hDQxP+is1XWPhsM7ormsOeuak7hqieE6ETeh2c18G+aRGc1jbIxsyp0wGU3825N8UC4KJ/QNycDw9fy5uhW2wgTrAVzYuEcTU5cqNZpRFfJQBvyoJgGfgBjf5LzqqAI8RFodcKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nF/OZxAk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nF/OZxAk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 609661F00A3D;
	Mon, 15 Jun 2026 16:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781539553;
	bh=EPEnTrHOuobCHBhSsHMA1ddaIk4T+rSZhGNFqQ2unyE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nF/OZxAkSw+m4Yo4RB1aBvU/tEFoDdMvgq2UoOFJ+vWRIHd0fTryNKZJZcQkfD/Go
	 /IC3sg4JkKiwabevrkBMIUfIi/LAFu6gOwGiYYktut5d6MNG/0NN1Z0c/Cbumq9L9B
	 5YaltwYO7d5pb83rgB7/nU/HBMNPr0ixzEmSgdQJTKCqzYxGzpG0QCDWtDAF80yqDV
	 IoumVw9dWCx3ChAofDwxLShktF2liEZiUhCEGDp5hgIeUbXamT+wBSNP/dgS53SDo0
	 OTnf3yt6HEtToz16fXUFOa2ODPWA01KfTj39rJ1/KL1Sop+08rKSB35/OV7nzJecLs
	 PV918dG5Lc1ZQ==
Date: Mon, 15 Jun 2026 09:05:51 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: David Yang <mmyangfl@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean
 <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2] net: dsa: yt921x: Add limited ACL flow
 statistics support
Message-ID: <20260615090551.069b951f@kernel.org>
In-Reply-To: <20260615130356.1150110-1-mmyangfl@gmail.com>
References: <20260615130356.1150110-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 15 Jun 2026 21:03:53 +0800 David Yang wrote:
> The yt921x supports flow statistics, which might be used to implement
> .cls_flower_stats(). However, the number of flow counter are limited,
> and you must choose between byte mode or packet mode. As there is no
> interface for statistics preference for now, we pick one on our own
> initiative.

net-next is closed, please repost after the merge window
-- 
pw-bot: defer
