Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DC91E7660;
	Wed, 11 Mar 2026 20:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773261777; cv=none; b=DVBrY0g8vJ6/rR2LeF0qpcpWo988Jofu//aZ6n7GyvwHXtFlOh1Xnvp9Z9ujVXh1+ePDrHQmbr84aMkYnjwaNO3hWwI03e/wL9NM66jo93sExR7A/r0rV7oPOnlTZF85EKAD2HKnuBsRKc/opHa6xvn+vwGkx/Fi7tqln1rYwVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773261777; c=relaxed/simple;
	bh=LTkZ06JPyUwSpJKZyfDZsY0nD/XGl5VTF44hLfLyG6s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GSn9hjZZx0qkhv8CSmd+tP6m+LJYq8M0z8irprJL29A/SCsQ+FK4WI+iYIWloK3dPubKXOEQqpy/Zak0Hng2eSa/LI1QBJRStg+dSseQNm/ljzey0YaIIrn8iY3e0MkLe6qK38+vgFaHywFVyX0wcJz7Jx++csHNrcbJyev0EAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/FHjOFi; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/FHjOFi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B92B8C4CEF7;
	Wed, 11 Mar 2026 20:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773261777;
	bh=LTkZ06JPyUwSpJKZyfDZsY0nD/XGl5VTF44hLfLyG6s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=l/FHjOFiYS7ICoom5ehmS1izxpjATWwSkD8+rjF3NMySRgOt0Pdwt+Ja+fPJcym87
	 SOEBT9qpvIy39nqd6wa1M3TSAovZuJtMT+nW2Sde7bSRkFMciqmpoPzahaCMKKuEL7
	 56NAxxGYVdgT00dnclUpyW82ArGQuLfLmwMrJtcMa4glaDoEbnSNyNk6LgrmeSVBXG
	 TngoP7VhShKd1XXMMZ4j3aXONkND+Q9MSplilCitCLPkfdhwLuw2ZFgVlIr0NeGta8
	 J93nDUDLbPEyqE69O6yqcstvklohfOpkfN7u6uXnBWjmlu880lnxZL7xdeByIQiygM
	 WVp6og4MHutfQ==
Date: Wed, 11 Mar 2026 13:42:50 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuck Lever <cel@kernel.org>
Cc: john.fastabend@gmail.com, sd@queasysnail.net, netdev@vger.kernel.org,
 kernel-tls-handshake@lists.linux.dev, Chuck Lever <chuck.lever@oracle.com>
Subject: Re: [PATCH v2 0/8] TLS read_sock performance scalability
Message-ID: <20260311134250.40b91e40@kernel.org>
In-Reply-To: <20260311001952.57059-1-cel@kernel.org>
References: <20260311001952.57059-1-cel@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 10 Mar 2026 20:19:44 -0400 Chuck Lever wrote:
> I'd like to encourage in-kernel kTLS consumers (i.e., NFS and
> NVMe/TCP) to coalesce on the use of read_sock. When I suggested
> this to Hannes, he reported a number of nagging performance
> scalability issues with read_sock. This series is an attempt to run
> these issues down and get them fixed before we convert the above
> sock_recvmsg consumers over to read_sock.
> 
> While I assemble performance data, let's nail down the preferred
> code structure.

Could you check if the tls selftest passes?
It appears to be failing in our CI since this got posted.
