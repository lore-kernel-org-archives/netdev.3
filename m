Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB44FB672
	for <netdev@vger.kernel.org>; Sat, 15 Feb 2025 15:55:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739634945; cv=none; b=Sxv0pBtYsp88348UhteHVWVSV41+QAX4gEkzYCLHyKOIptm+PH6DM6iaAv8DjRckzovGdZNYtPBw7A7LM6FUr3VjGUbKlqcaEotyo4XAdIP1aZUUl8hqK22mcb+6oQ6qwHTClrlT6TNJsfEnHROGLkAEEXQHkmUchRDxnjKIZKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739634945; c=relaxed/simple;
	bh=l3nOcP7DkQIug/tIDXJYSCM4q7onawfsbPY+4MpquDc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mxTcxHA+2UovyYZYisp/Gy0TPc2D+vtQLYZOAgZKr7WEr1gZFHK5WmxLuUpP9skNPG3ya8Rkl2Z1QlpFO4O89HLSsXcA2P53YIm5L/4SYFvyQPbJ8y4SvX4qfIm4tPj+tA8FleEQKZEQw7qrCyUjoeJsMDXvzKmCQv6sf4oSW+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kh9BbwB/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kh9BbwB/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FBC7C4CEDF;
	Sat, 15 Feb 2025 15:55:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739634944;
	bh=l3nOcP7DkQIug/tIDXJYSCM4q7onawfsbPY+4MpquDc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kh9BbwB/mbxxW6ZJ30+bz5jdX5VNt5SbUPWSQ8k5svm5e6ZAQ5T+/eEwzhMdH8W3M
	 02xB1+92LSMLnbfE1E9TLBRL++UVghw1jdG83SowI4oYUCgqGrQVzPcGnDBisuWg2+
	 fxJlfoQvzOgFGkj3WbldcTj28F2ssWQyHq2/1/1wZlkG5HXEqlUBbypYoQ9G94nu94
	 dWBZmFM3oRDuG5WkRZ1e4rdQGKNRkKoWkDTxCUtxQoeDqSyTSZ+M+CF5b7d/lsiqYe
	 OCrde9DWGlebNef28zuxXWGil6CfZmVxKaZw1tJrKkcEIeH9VOBHuPhclbRkxv0k/m
	 0T41tsOV4vqQA==
Date: Sat, 15 Feb 2025 07:55:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <sdf@fomichev.me>
Cc: netdev@vger.kernel.org, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, Saeed Mahameed <saeed@kernel.org>
Subject: Re: [PATCH net-next v2 00/11] net: Hold netdev instance lock during
 ndo operations
Message-ID: <20250215075543.4ca1cd58@kernel.org>
In-Reply-To: <20250214153440.1994910-1-sdf@fomichev.me>
References: <20250214153440.1994910-1-sdf@fomichev.me>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 14 Feb 2025 07:34:29 -0800 Stanislav Fomichev wrote:
> As the gradual purging of rtnl continues, start grabbing netdev
> instance lock in more places so we can get to the state where
> most paths are working without rtnl. Start with requiring the
> drivers that use shaper api (and later queue mgmt api) to work
> with both rtnl and netdev instance lock. Eventually we might
> attempt to drop rtnl. This mostly affects iavf, gve, bnxt and
> netdev sim (as the drivers that implement shaper/queue mgmt)
> so those drivers are converted in the process.
>=20
> call_netdevice_notifiers locking is very inconsistent and might need
> a separate follow up. Some notified events are covered by the
> instance lock, some are not, which might complicate the driver
> expectations.

Appears to break the CI build:

net/core/dev.c:11392:12: error: =E2=80=98netdev_lock_cmp_fn=E2=80=99 define=
d but not used [-Werror=3Dunused-function]
11392 | static int netdev_lock_cmp_fn(const struct lockdep_map *a,
      |            ^~~~~~~~~~~~~~~~~~
--=20
pw-bot: cr
