Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEB82566F7
	for <netdev@vger.kernel.org>; Fri, 31 Oct 2025 23:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761953475; cv=none; b=qqzSRMFZjxCNzaF0rdQezj020XEyTsQRLrCKO8KyLgFpaGltdivzG7cXFMYfi3+R8Bn9zk6AiCxF7j8v+HLQsrKdW5d7z2Q6+brMpiOe6NtJ83H8P3VHLqJJME/tpbFewqWXJOJnNwR6jPBNcBDFDhgnbtVsM08q34ZxytO+SdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761953475; c=relaxed/simple;
	bh=c9bkJJ6ecUz1Uw6yvqxhlw1m9bOYsB1z0w2ijgH9ax8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EX1Ksq3oPwUr2ZIGkQZVOsMiCkHrwvFQs75sgSlCb4yNST2gpXVWpT1ZgLhuHniJcD8MZFXkvN9dV7nJtKHmatz+p5p6dvzIKY/d2T1sgXDpysaqxuG35AmzyGhFA4qE4FP0iC3VbF8R08MYURyCjoQCu5idmWtLVnA64aMUWfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BrZEDEuO; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BrZEDEuO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0CE5C4CEE7;
	Fri, 31 Oct 2025 23:31:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761953474;
	bh=c9bkJJ6ecUz1Uw6yvqxhlw1m9bOYsB1z0w2ijgH9ax8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=BrZEDEuOTquL34njO/rVHQ3voMlUZ9MUNmE8kLiybSbVHx3ez5ngVlZNvWdFSZTzx
	 50NTIcFNzazB74xsuWXuRhofZX5/Fth9R9k6zzV06sZWNizOg5ocJWEiOw5uifdzQ2
	 PiTUac6mrvLvS4lwkTqBrwLoxBZr1KhT7IYOzBJIs/Gmots9U+XmK6nfAkaAftD1if
	 3MOUC8I3hdYnidHDF5dfGkp2uvfgaVFwyulvwsuV1RoOI3ZRjFbmuljLX7LlYg74Y/
	 Wc/xexymT0Uxmd8TA8u3A4Ha7OMOO3o3h5jUNTAdoLrFe5HIOAt8kmAF5+prjn8Jxc
	 E7xYjFOBlVO3A==
Date: Fri, 31 Oct 2025 16:31:12 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zijian Zhang <zijianzhang@bytedance.com>
Cc: netdev@vger.kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, andrew+netdev@lunn.ch, saeedm@nvidia.com,
 gal@nvidia.com, leonro@nvidia.com, witu@nvidia.com, parav@nvidia.com,
 tariqt@nvidia.com, hkelam@marvell.com
Subject: Re: [PATCH net-next v2] net/mlx5e: Modify mlx5e_xdp_xmit sq
 selection
Message-ID: <20251031163112.14cdc36c@kernel.org>
In-Reply-To: <20251031231038.1092673-1-zijianzhang@bytedance.com>
References: <20251031231038.1092673-1-zijianzhang@bytedance.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Fri, 31 Oct 2025 16:10:38 -0700 Zijian Zhang wrote:
> v2:
> Suggested by Jakub Kicinski, I add a lock to synchronize TX when
> xdp redirects packets on the same queue.

Oh, I definitely did not suggest that you add a lock :)
I just told you that there isn't one.
I'll let other people tell you why this is likely unacceptable.

=46rom me just a process note - please obey our mailing list guidelines:
https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
--=20
pw-bot: au
