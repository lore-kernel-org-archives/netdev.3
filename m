Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACD528466C;
	Wed, 11 Mar 2026 02:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773194497; cv=none; b=RbY7Tse/g5nKb2A0HQjR2QBOb5Mj9AA7i/l2T8HN47glFQKR5MlbQ6MbtzWhhh2uEsyNzCjbLwnGI4G/2aqPDqZdQTwGKdgGOi8z4MJmmT2N5lhPcPVnansSo+WEOoogftS/NICN49AX8yroK07izkTjtOeLOwmRHUdhox9hmrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773194497; c=relaxed/simple;
	bh=jjSf6t0rz0WN9K4TZKbj7NWiKQ4Tck4SVuqN+DqDt3o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rN/tLkysEt+96aKxE/edIPD3fu3sGqTxBENIEfzbNm/UMO0QeoyNdq/auMxkity6AZCNqF8y3d2BnRb2qAAeqvmAjwl7UjQq+Q6OxbmeE8c+O4xe3FDgsnNdx9RWMgG3nVSe5P6qTWxAnURRxUNWJrqp2MrwRfQcoYbOa8YaHDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D18de6zN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D18de6zN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F065EC19423;
	Wed, 11 Mar 2026 02:01:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773194496;
	bh=jjSf6t0rz0WN9K4TZKbj7NWiKQ4Tck4SVuqN+DqDt3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=D18de6zNMT5FsImD9VgfA8IgzsrO4FGcav/px+r4OAr5LHzKOqoyUOkYzn7lrSxvy
	 pZTPULvni91FgWm0TUP7D1iAtomIfTZJ0uHRGL3ABlwj5hWLNXlX6qokviCAS5WwsQ
	 lRHE2vyGXOei+tguyXBBu5VoSOVsz2pwPR3bQGSquVp/JE2pQFSv15PHYqyA4xjfr5
	 tCeEhqKgSw8F4ncJfx5HATLPrMCJQRRALMkZXMlHjgCkwmavD17vFpI5+yrRSJKbvO
	 EznkeaBVTVQCTxPmMxhdekiM1g/xz6WgM8wuzjTwnH7T/qazfxI/XESL3PmiIMt1me
	 Mi8ZeS0YTSOuw==
Date: Tue, 10 Mar 2026 19:01:35 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: ShravyaPanchagiri <shravy112@gmail.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, sgoutham@marvell.com, lcherian@marvell.com,
 gakula@marvell.com, hkelam@marvell.com, sbhatta@marvell.com,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, corbet@lwn.net, skhan@linuxfoundation.org
Subject: Re: [PATCH] docs:octeontx2: fix typo in documentation Fix spelling
 mistake "Crate" to "Create"
Message-ID: <20260310190135.422b6074@kernel.org>
In-Reply-To: <20260308191142.172363-1-shravy112@gmail.com>
References: <20260308191142.172363-1-shravy112@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun,  8 Mar 2026 14:11:42 -0500 ShravyaPanchagiri wrote:
> Subject: [PATCH] docs:octeontx2: fix typo in documentation Fix spelling mistake "Crate" to "Create"

space after docs:
I think you wanted the repetition of the sentence to be in the commit
msg body? Please fix and repost
-- 
pw-bot: cr
