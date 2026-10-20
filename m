Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792462292;
	b=XT1R4j7WKXNxlQqCWeWk3xeb/ho6SPi1uO5GrgZj3Dr0+EmyXjqumZjPkLaH0e8DydP/
	 4Q4llukhSe5KUBPFGdDI4iG35kogVnzZh7FmaA4IiGmLKPwJ+9kVK+4rFyO0z/KbUo/kL
	 se+X5hDyIn1+aCnAr0BIne2ohPJ68O00HA2LZ73TYWEva/srUZ+1XfnlB7xCCsIF77Jj5
	 4RR/jaY4DcwqV+7BuaqzVssrISzSqorDmRPayvgvZGOtKvkfLELl7fFIZaLjRck8FKMOT
	 V6Vg4m0lQxF8Ed+N9zYyDbOzZ6m2dh/OTWV6wIV7ZkbLTmSqSDU/lplNbqF8fOnUOqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792462292;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=ZaC24Iqo3ndTIUA1NxhKWupBdgg11KL9HAS5HaAh1EM=;
	b=wOrN688/2XGz1THuYjdAEGsbr5C8KDcNGUadId/43VljiVqsrtF5F9w0gOHzRUskyckf
	 eAhJtH4ffYm5D1PvoyxT3p35AoXtGERxAasBAq2ah5C+d0fKkkVhnjecv83SFfWg6G0Fm
	 19Ut4ktF5XshgviXz/jKvDZB94E2fcjC+mu1sED6kPaA4zbqlQObybvY2NJIWalNdDGGG
	 tiGTgbaDmLb+MOOmbpN8gdw+9ztR/51o3fNxDy7u91OTngDh+5Wr6obfrduvLR7W+YI8/
	 Mt/ai2LfM2rJRnHv/09pesLdzD6vdP8Ounw+9Sy+xEDlWAtcTlxj93sQOMf+C5W6asg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0eNF8kK;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1404B606A319
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 02:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K0eNF8kK
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 503591F000C4;
	Tue, 20 Oct 2026 02:11:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792462291;
	bh=ZaC24Iqo3ndTIUA1NxhKWupBdgg11KL9HAS5HaAh1EM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=K0eNF8kKeITKhVhkF40KURK39VhU8Rnk3ksKQ24zV4mJgMlHRhM5FvMH/JLwB9rb3
	 o2PD/4nN1DjBy8SUd9swKBVDYI11jKzPHEUZwXd0xz8B7QpOWJG5H2HUJocD1nlUGV
	 XJPX7AkVl6RGrB3QXZtojBDGgDLZAwu3X/8TVNRCsT/0at2Gjex1X3xrKQJv2US9z/
	 2RLPNXK+9PY4SEDIZJAKcJtNiOGdy80k7P6aY8w7qcyZQQ70XeWZ/yWwYKFfhZ4woj
	 dbn1tsM3Q714iY8X2UT5b6pbhnIRzTfuUeD0EYd2/xf4clNI9ekDfkv9HJHUzq1ocd
	 vf64RjZUVdj4A==
Date: Mon, 19 Oct 2026 19:11:30 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Prasenjit Mukherjee <pmukherj@redhat.com>
Cc: "David S. Miller" <davem@davemloft.net>, "Eric Dumazet"
 <edumazet@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>, "Simon Horman"
 <horms@kernel.org>, "Shuah Khan" <shuah@kernel.org>, "David Ahern"
 <dsahern@kernel.org>, Toke =?UTF-8?B?SMO4aWxhbmQtSsO4cmdlbnNlbg==?=
 <toke@redhat.com>, netdev@vger.kernel.org, "Davide Caratti"
 <dcaratti@redhat.com>
Subject: Re: [PATCH net] selftests: net: fix race condition in icmp.sh
 causing CKI sporadic failures
Message-ID: <20261019191130.2697bd77@kernel.org>
In-Reply-To: <b15ee681a330f9b05a9076a3852c186017f59d83.1791804421.git.pmukherj@redhat.com>
References: <b15ee681a330f9b05a9076a3852c186017f59d83.1791804421.git.pmukherj@redhat.com>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Oct 2026 18:23:32 +0530 Prasenjit Mukherjee wrote:
> CKI reports sporadic failures in icmp.sh, Davide suggests this might be

Please expand local acronyms, no idea what CKI was, I had to google it.

> caused by a race condition where tcpdump starts capturing after the last =
of
> expected ICMP unreachable packets have been sent.
> Fix this replacing tcpdump with a tc flower filter that
> matches ICMP Destination Unreachable (type 3, code 0),
> and match on act_gact counters instead.
> This will remove any race condition to appear.

Would really be great if you could say something like "with this patch
applied I run the test in $my-ci and no failures happened"

> Fixes: 7e9838b7915e2 ("selftests/net: Add icmp.sh for testing ICMP dummy =
address responses")
> CC: Toke H=C3=B8iland-J=C3=B8rgensen <toke@redhat.com>
> Suggested-by: Davide Caratti <dcaratti@redhat.com>
> Reviewed-by: Davide Caratti <dcaratti@redhat.com>
> Reported-by: CKI Project <cki-project@redhat.com>
> Closes: https://datawarehouse.cki-project.org/issue/3658

Silly number of tags
