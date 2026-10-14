Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B024A8FE3
	for <netdev@vger.kernel.org>; Wed, 14 Oct 2026 09:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791971925; cv=none; b=dm2Umv2XLqFP9T7WK7oOQzSOPH0cWS68UefGhHMXdufLgoL7eNuutvhBgE54VvAMr1NWH7EIEMhOBq6I7kSogurTBFvI19hU5ja3kL+IrBUPKALG7cJs+hrqPR5c79O8rai5BxUnQf9IqIg23edCubGSh9EcgSRDU/wqCsqcYbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791971925; c=relaxed/simple;
	bh=Fe0pTB9v/NMFWEIVJRlbAaqpbgHkY6H3tbwL6WJVDE4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=m9+5mplbar+0lcC6uV6ewQcHIFXOIjDYPfUabULW2dcnZL+qWjsVLiI2KhGfrecX0DnLuoBVI7fRUbMqpTeJ1Zgl2h6c6yM279Bo9oQHXZWF8abVaVfzsMY9pl67m7AMCRWxDqNU8g0wnAX/ikSJzT1rt0Ozbfsm8Fal/yUJT/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DomwINdy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DomwINdy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7845D1F000FF;
	Wed, 14 Oct 2026 09:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791971924;
	bh=5TjIajZe+VJN/YrB825hynL0UXMtHVnL909qBuZMkHo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=DomwINdyBQLytcOzRpIbRo+Hqkgqh8nj1cC6oAxPnvDVYlShBmyPAFO2YhM+93ZcO
	 1x1XbuuhZlsz5iwGipyhsEBqkvXcLfxZhBHdri3cawdCrCHn9xJcsteIFvqar4Lk2Y
	 KF/37l/y6C3arqkpJuUCN5k19qERRIqTYgHBPnUIsDee8MAVAxkmVEULA307MX2GNx
	 2mtoGY4lsjky1kQ7lYh/yOkZC0ypc7wCEDQyRoRB9/hTW158S/YU80JoIMlGri8ggk
	 xHIarhttumgfA16mRlp3LXZ92MVjv8U/gIgGjJs/e5SHdRuTdvCEY4x4/oezC2nSt2
	 2Pvq/QMEI3GOQ==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Ido Schimmel <idosch@nvidia.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
 edumazet@kernel.org, dsahern@kernel.org, horms@kernel.org, Ido Schimmel
 <idosch@nvidia.com>
Subject: Re: [PATCH net-next 0/2] ipv4: Remove netns argument from
 fib_table_lookup()
In-Reply-To: <20261014082612.1280756-1-idosch@nvidia.com>
References: <20261014082612.1280756-1-idosch@nvidia.com>
Date: Wed, 14 Oct 2026 11:58:40 +0200
Message-ID: <87ecds8uy7.fsf@all.your.base.are.belong.to.us>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Ido Schimmel <idosch@nvidia.com> writes:

> Commit c436a624f89e ("ipv4: Pass netns to fib_table_lookup()") added the
> network namespace as an argument of fib_table_lookup() so that it could
> be passed to the fib_table_lookup tracepoint. As noted by Paolo [1], the
> function is called in the data path where the additional argument is
> unnecessary overhead, as the namespace is only needed when the
> tracepoint is enabled.
>
> This patchset stores the namespace in the FIB table instead and passes
> it from there to the tracepoint, so that the namespace is only read when
> the tracepoint is enabled. The tracepoint itself is unchanged.
>
> Patch #1 stores the namespace in the FIB table.
>
> Patch #2 passes the namespace from the FIB table to the tracepoint and
> reverts the signature of fib_table_lookup() and its callers to what they
> were before the above commit.
>
> No functional changes intended.
>
> [1] https://lore.kernel.org/netdev/43857d08-c4f4-44ce-a0b3-0e7fcc56bf90@r=
edhat.com/
>
> Ido Schimmel (2):
>   ipv4: Store netns in FIB table
>   ipv4: Do not pass netns to fib_table_lookup()

For the series:

Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
