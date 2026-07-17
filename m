Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCF530568E;
	Fri, 17 Jul 2026 08:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784277476; cv=none; b=LKX4BVZ6rCTjkNXISqX5d47BBU0pVhld1yklem0VuraPKqGb1O6xQMDGqaS1g7ZObHsBKQxo4dHlbbk9GjDeoNw0E83mjTrBaCky9MLixsE9P6RWrioPvdTQr9bLuYEd+USSY0eFefIbg2xadfNal7KcB1I9t+DULeNxPsePYkI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784277476; c=relaxed/simple;
	bh=SkZ4VPIr5uXS+R3g4GxzCBfae59dluKWDxW+Wx+22RA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ffkd7vMd+5zv8XfyGjw8Pa/ceUKB/QgZsH9rPgdhh4MWF/qlZ90tZOy8EFDh8/usqMCiadkxN9nrsEffJDJ6DTT8kseA2qNniSZDJZ9pRkpyZfW4p2QkDqXWePevSj7X/mpIEF6FZ05pPa3kG5/nW4rSmmROI0gONqcdW5uQOI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
Authentication-Results: mail.toke.dk; dkim=none
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
To: Jonas =?utf-8?Q?K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>, Jamal Hadi
 Salim
 <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
 <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>
Cc: cake@lists.bufferbloat.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, Jonas =?utf-8?Q?K=C3=B6ppeler?=
 <j.koeppeler@tu-berlin.de>,
 Mike Pham <mikepham4321@gmail.com>
Subject: Re: [PATCH net-next] net/sched: sch_cake: skip clearing unused tins
 during rate adjustment
In-Reply-To: <20260716-sch_cake-skip-clearing-tins-v1-1-d9787df20c28@tu-berlin.de>
References: <20260716-sch_cake-skip-clearing-tins-v1-1-d9787df20c28@tu-berlin.de>
Date: Fri, 17 Jul 2026 10:31:37 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87wluuj9ue.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Jonas K=C3=B6ppeler <j.koeppeler@tu-berlin.de> writes:

> When cake_configure_rates() is called from the dequeue path with
> rate_adjust=3Dtrue, it only needs to update the rate parameters. The
> loop that clears the unused tins is both unnecessary and harmful in
> this path:
>
>  - cake_clear_tin() overwrites q->cur_tin and q->cur_flow, which are
>    actively used by cake_dequeue(), corrupting the dequeue state.
>  - iterating over the unused tins and their internal queues to purge
>    packets adds needless overhead to the hot path.
>
> Skip the entire loop when rate_adjust is set, as neither
> cake_clear_tin() nor the mtu_time update are needed when only the
> rate changes.
>
> Fixes: 15c2715a5264 ("net/sched: sch_cake: fixup cake_mq rate adjustment =
for diffserv config")
> Signed-off-by: Jonas K=C3=B6ppeler <j.koeppeler@tu-berlin.de>
> Tested-by: Mike Pham <mikepham4321@gmail.com>

Do you have any performance numbers to show the impact of this?

-Toke
