Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CACC72D59E8
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 21:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772315686; cv=none; b=KzrtIe0gCn2GR3/TUuO5pCHg6W+rwusOdZjYuBmfT8NExnPkturhMoZfIsj9f0U3noZEJdnd2Jm49rW7gOIpFlhW+i7bto2p9nZMeM3sbqeBB8mSL65XudxhCefj+CFpBlj4L576N4ZuILDI4y8LXGjJE1Bx0xJkhV2MrHsV0Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772315686; c=relaxed/simple;
	bh=Sht9SFon629cUZSr1CaElu79VWdo58uPyr6GgvLc9HA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qRf3ITE1hKC4FAgYegqcsNMmEfavfJZT6n5bCbmhF24sgtWJU/9QivMeUqCQlOuMkcysVaP9A4WLnd+87ABbxsUW+ofuA29aqV2GhhJm50cs3TeuZ84gbV54aXjL6CVuxe+ItlbxNcghRR3qgNxQra5TocYRX9RnkrWayaU1rSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uQiZYNED; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uQiZYNED"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD8FC19421;
	Sat, 28 Feb 2026 21:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772315686;
	bh=Sht9SFon629cUZSr1CaElu79VWdo58uPyr6GgvLc9HA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uQiZYNED9444lX7cknop9ZKhfBIh4d1sAoTuWO4WlJ9rxUF7QLrghXB8BGAZpnJ4q
	 TcsIREdIlcd1QuGtWIN+OHHC4npsdsi9AEI9aV9hY5k0SU3ynrEwcGWcg3i8mxsgsC
	 TxWk+Jkn7C3nu1MhkckcuDjOlwyrS2RGecQ3PTgnNu3hlZe2Wf8em1XWpDyhvCWKTt
	 Eenti5nyHO9A7nLVGswNcfTSsvch5nXRBJNczh2qU+ExwCACN9BDerNqgUca7tTQuG
	 SEpPp1FdBk2wzhP2GhzIdEn8t4Yx6fOuIr4ibgzIEj01toyxCr9yI6CkKSumo7aT+q
	 uGI23GP5ffPaw==
From: Jakub Kicinski <kuba@kernel.org>
To: kuniyu@google.com
Cc: Jakub Kicinski <kuba@kernel.org>,
	dsahern@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	davem@davemloft.net,
	horms@kernel.org,
	kuni1840@gmail.com,
	netdev@vger.kernel.org
Subject: Re: [v2,net-next,01/15] selftest: net: Add basic functionality tests for ipmr.
Date: Sat, 28 Feb 2026 13:54:36 -0800
Message-ID: <20260228215436.4094668-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260227033903.3307272-2-kuniyu@google.com>
References: <20260227033903.3307272-2-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
selftest: net: Add basic functionality tests for ipmr.

This commit adds self-tests for IPv4 multicast routing (ipmr) that
exercise various setsockopt and rtnetlink paths to catch lockdep issues.
The tests cover MRT_INIT/DONE, VIF management, MFC operations, and RTNL
integration.

> diff --git a/tools/testing/selftests/net/forwarding/.gitignore b/tools/testing/selftests/net/forwarding/.gitignore
> index 2dea317f12e7..418ff96c52ef 100644
> --- a/tools/testing/selftests/net/forwarding/.gitignore
> +++ b/tools/testing/selftests/net/forwarding/.gitignore
> @@ -1,2 +1,3 @@
>  # SPDX-License-Identifier: GPL-2.0-only
>  forwarding.config
> +ipmr
> diff --git a/tools/testing/selftests/net/forwarding/Makefile b/tools/testing/selftests/net/forwarding/Makefile
> index ff4a00d91a26..bbaf4d937dd8 100644
> --- a/tools/testing/selftests/net/forwarding/Makefile
> +++ b/tools/testing/selftests/net/forwarding/Makefile

[ ... ]

> diff --git a/tools/testing/selftests/net/forwarding/ipmr.c b/tools/testing/selftests/net/forwarding/ipmr.c
> new file mode 100644
> index 000000000000..b6b00e36b3ce
> --- /dev/null
> +++ b/tools/testing/selftests/net/forwarding/ipmr.c
> @@ -0,0 +1,455 @@

[ ... ]

> +static struct rtattr *nl_add_rtattr(struct nlmsghdr *nlmsg, struct rtattr *rta,
> +				    int type, const void *data, int len)
> +{
> +	int unused;
                ^^^^^^

Does this code have undefined behavior?  The variable 'unused' is declared
here but never initialized, then passed to RTA_NEXT() which expands to a
macro that reads its value to perform arithmetic.

In nl_add_rtattr():

	int unused;

	rta->rta_type = type;
	rta->rta_len = RTA_LENGTH(len);
	memcpy(RTA_DATA(rta), data, len);

	nlmsg->nlmsg_len += NLMSG_ALIGN(rta->rta_len);

	return RTA_NEXT(rta, unused);

The RTA_NEXT macro performs '(attrlen) -= RTA_ALIGN((rta)->rta_len)', which
reads the uninitialized 'unused' value.

While the modified value is never subsequently used, the read itself is
undefined behavior that could trigger compiler warnings with -Wuninitialized
or unpredictable behavior with certain optimizations.

Initializing unused to 0 at declaration would resolve this: 'int unused = 0;'
-- 
pw-bot: cr
