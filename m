Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74BED339B3D
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 22:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775687073; cv=none; b=bYM7clFi1DphgC4HP6ujLYw8wnErmvRvtTcQZV9TTrTdV69HW4qLOerTBu1UUcxLDu3ZPkLoK454iA1ctW2gTAoZJ+NcZMRfQ5ZARN+ndSerPNSSKOhG5pU7VVKpKbfFP2I2kC43YiXZA2uqh7cgrY9F1Zf6nUufnMI6cGPFtdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775687073; c=relaxed/simple;
	bh=AwYvYgf/qFe/7K7f5SHCHhSFc8OcuLCC6eLIYlyhlok=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=txYTn8JgeMK+A36gfnEW4wYkYiEkb5hc/dfaQOvPo3KcqfTbhRTMbwgoUTgd1ohrD0LiOuQnxrmLVvbft0dm9TcSnloRXrF1ED9v6hJzh5tApsnb81XyhT6xzwwQq4aV8Wvjvg6QGjzOFwkeu/joWIWdQK+ZboJznfeYTf0B2to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d+aEpac1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d+aEpac1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBD84C19421;
	Wed,  8 Apr 2026 22:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775687073;
	bh=AwYvYgf/qFe/7K7f5SHCHhSFc8OcuLCC6eLIYlyhlok=;
	h=Date:From:To:Cc:Subject:From;
	b=d+aEpac1uMRy1XseQz2Asg2RMJLL3UIWUDYlUxpjTYWWEczZ1NwCSL9fcNtssOBwO
	 c8oXlQLPafl8t5RPWRyFrP0JqZ5wkVBkXqPGQP70W8p62GcOcrPKr8Mdr4aA8d5R2V
	 cmX3+20B2cu2kbYVUGGhwMNVtvK+NlRXrGOhRZFBNPf8dgOIbv89fx0lYIsISLFMJd
	 sxlAr7zynEv86oAZgTaSnFQhP5o4q6vLesDJzcDznhIwDa3bi23OkxooeBk49ZV/+V
	 B57nW7HkYvcYGw8YSnnmyUYqOMXrWoHGTVQBkLpOAE9fGSDuQxZ8rtnvtyUrnhqe0F
	 L/6kHUrlLv0sQ==
Date: Wed, 8 Apr 2026 15:24:32 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Florian Westphal <fw@strlen.de>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: [TEST] nft_tproxy_udp.sh flaky after Fedora 44 upgrade
Message-ID: <20260408152432.24b8ad0d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Florian!

When you have a sec -- we upgraded the NIPA systems to Fedora 44
over the weekend, and nft_tproxy_udp.sh has gotten quite flaky:
https://netdev.bots.linux.dev/contest.html?test=nft-tproxy-udp-sh

One thing that we hit immediately is this, in case tproxy test
uses socat:

commit e65d8b6f3092398efd7c74e722cb7a516d9a0d6d
Date:   Sat Apr 4 16:01:03 2026 -0700

    selftests: drv-net: adjust to socat changes
    
    socat v1.8.1.0 now defaults to shut-null, it sends an extra
    0-length UDP packet when sender disconnects. This breaks
    our tests which expect the exact packet sequence.
    
    Add shut-none which was the old default where necessary.
