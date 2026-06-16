Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0270144DB64
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 16:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781627255; cv=none; b=lzGq29lwSZScll33xJCQ+mrDNoAHtcwxZK1OM2bXZlJcFnQGSoR0H6Rryu8APx8sDIL3aJ8y2ob+QBhQsBTlcI78UFAv2nx66xCuOLaUlWVcQAtWk9hwQzH8GJhz0wpdbUgg7o+9yaNtaTP/Lz/N4+Ivlzy4h+2Y7NUp2w3K5wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781627255; c=relaxed/simple;
	bh=MkrbDUNMNdcjIZmVKNfjT0xWzcPyS9gBN2jyTz3iQUk=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=jYbendROgKnA8sb+oTn4OcUie15d4/N0WGqSMz3vMZuNNPjo64VAPzEOLKjVJDX/Org9xc3ixbhe7tyWBZS4FqmHMsZsv/2thtU4g6MbYwkrBA59gekRFPW/fzCeaL6NW5TdJI/9n2YwFVdSVqQHgPnprl6H7tYDw5B0TAnDnTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kiy5i/ui; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kiy5i/ui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96DCE1F000E9;
	Tue, 16 Jun 2026 16:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781627254;
	bh=MkrbDUNMNdcjIZmVKNfjT0xWzcPyS9gBN2jyTz3iQUk=;
	h=Date:From:To:Cc:Subject;
	b=kiy5i/ui4nSDegkWY+XjaAN0GbKXgk21Phv9vy8PygdgAifY+E+r3n6juU2uuuXzL
	 8lsLmWMJVF4H+c1nDSzp3lOSKQCs+t78FHvR1K490RR/J5toBYW68dO6HmxI5G2xXK
	 BAjX/NrAuCK/Iqp1AozXuMoK6wMmxKICFF2HRjOmB9K5nn+ZDNk2DvxJxqK5ZvGTxq
	 QLy2aOz2bkJSokT7Uxb50O+KGLpKkkrNDN4ZlZXKgC2dxi1J8YmKsCQkjqBB3utqbR
	 3kqfe+TbuzBSB9vZ4LO+SrYr8PJ4+W8TS9BuKsiIgfPa10kEHIugtyD2gb903KjNJU
	 bjB56Jr2XXA2w==
Date: Tue, 16 Jun 2026 09:27:33 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>
Cc: netdev@vger.kernel.org, Petr Machata <petrm@nvidia.com>
Subject: [TEST] vlan-bridge-binding-sh flaky
Message-ID: <20260616092733.3a31be4d@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Ido!

tools/testing/selftests/net/vlan_bridge_binding.sh got flaky recently.

https://netdev.bots.linux.dev/contest.html?test=vlan-bridge-binding-sh

Is it due to Eric's change or something else? Used to be pretty solid.
First lake a week ago and 8 more since, before that for 3 weeks there
were 0 flakes.
