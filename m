Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD853AB28E;
	Mon, 20 Apr 2026 13:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691287; cv=none; b=fRf9+0PPDTJdFn5Sj/7AN7P1ej5MHxXAnAQnGp8GNRgl0IUasy0dhTZdSrpYl91gJsJ/PKf28KYxQRUoUnlgxnVPCwLCw/Y+hcj5ASq2aws4n/Eew+2MPEakM+P1iIovr8wlIsjHLD2/GW2IadjpzQJnK9ioEUUwr8Fo6iodkC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691287; c=relaxed/simple;
	bh=1129FrYe8MzwETr4Sn9ncOSEEtYqcA4fDE4HHL0JYRI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEER+s7wxy3Yh3FSB44kuZ5v7gObkvVntv+N5ntCUTqSV0ipYas81wJ7zz/2ooKBE3SKcwYpiWPE8bCaYeAwTb2zra/A5j7smS4FoEMl61uV+FWKcyxmGd8eSr+ZupHBliIimM5Q9wNcTE9NRL7js6W0GbQOq2Vtk6OL8HYAk1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d80q3QCo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d80q3QCo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D420DC19425;
	Mon, 20 Apr 2026 13:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691287;
	bh=1129FrYe8MzwETr4Sn9ncOSEEtYqcA4fDE4HHL0JYRI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d80q3QComHDDOuM5vzpZETjsbsDDI1xpm1OQ1yN8NmxPOFcTWfwrMcEU7dn4kA8a/
	 son+wlJNsylIC7yzui23RdwQneURTr2lo/BkQa00Fu0aqv7v2GM6aKb8V67fbnB8T/
	 yd2vkVK/ySGNFlXufd4bXy5nPo28Ga3aq7zWQMcgc6s1lY1btKB4YpfMorcvoKiWlx
	 GaoKwXBDI8pNLfBOadVEwFHqxJfa8rv9N6OIfxmuWf7sQANOhOsaRzmQKVIa5t6hZi
	 5FMxyxmbqrKizHmMXuivT0FhnwzSq4+YGrZGIFyeavcL5jrJ9m0sGJBTz1JskpQd5t
	 GPTV6DaFb2YTg==
From: Sasha Levin <sashal@kernel.org>
To: Rajani Kantha <681739313@139.com>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	netdev@vger.kernel.org,
	Jay Vosburgh <jv@jvosburgh.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Subject: Re: [PATCH 6.1.y 0/2] Backport 2 commits to 6.1.y to fix bond issue
Date: Mon, 20 Apr 2026 09:21:08 -0400
Message-ID: <20260420-stable-reply-bonding-6-1@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415091232.3244-1-681739313@139.com>
References: <20260415091232.3244-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, Apr 15, 2026, Rajani Kantha wrote:
> Backport of 22ccb684c1ca ("bonding: return detailed error when
> loading native XDP fails") and 094ee6017ea0 ("bonding: check xdp
> prog when set bond mode") to 6.1.y.

Queued for 6.1, thanks.

--
Thanks,
Sasha
