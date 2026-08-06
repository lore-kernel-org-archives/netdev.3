Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D22335674E
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 18:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786041412; cv=none; b=ZTXfF025iN4U7OL6uLcCvOzEvRKFBppWEYsBiToKr17T7nCtkvzWB+XofaiCRwWaXROnKkmX3mItrHoe8ZFUaQn9FUsDB3ENQHBaUHX99ispZfvFmDS+BRsQMrB95UZcTIsfIAQf5CrX9UB3UBtr36Jx/HkIj2hyUd/1/nG8C6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786041412; c=relaxed/simple;
	bh=FOvblDs7fFf1LN5WD4DVzA5t9BKd9Bi/2qhmqIHr/yU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oSsE54LdlvbiuaWFEANcLZU9oA0cQw9TQUGXjELwBGVA57geE3wmhcMcUETyTFqSMZKT5ioJaLXTyHYFowxljWoWfiISYi9S1rT0ReZ8nJZ2F837OSoG9ltrL0LXt4zfnNVnOdTtC2T/POmrrEMPnFAw3Y1H/Fbhhvsknmm2jis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kieO5jrv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kieO5jrv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EB391F000E9;
	Thu,  6 Aug 2026 18:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786041410;
	bh=FOvblDs7fFf1LN5WD4DVzA5t9BKd9Bi/2qhmqIHr/yU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kieO5jrvcw7Gvsrp8TEdACX63Zw8N+zwEhVc0u02GWPQSg8gP4npYAHO7gK/GDBdo
	 s7WdbU4p9Sx9/7bTyh6aLwbaMFohAtYQu+bZQFJyUUXA1HCAiZnhvvua9ar4YUddyX
	 RC4Q9E7c9idDBrNJxMHMJ2j663GDTW9Z2trirFtu4nrb/k2o/kAZ4Z/zcUctiqUh9k
	 //TUVAsdaybBdcy5bb6wP7rWpqou+8iiC0CBLJeqeY/Rn+zbB5iWcZQzQfI3B9mWn6
	 9PLZ/aEfDF8peUqSv/xQYrFMU1BXicO0Ig374oqBBkGQijDHl4Zcb0A1Zo4WOubtpf
	 yqPiKsmzTSN6w==
Date: Thu, 6 Aug 2026 11:36:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 kylebot@openai.com
Subject: Re: [PATCH v1 net-next] af_unix: Unlink scc_entry in
 unix_del_edge().
Message-ID: <20260806113649.4d7f12b9@kernel.org>
In-Reply-To: <CAAVpQUACUFcdUV_TURigYp=-wDamvN2PBQ+c+njYxAyDvmq8cg@mail.gmail.com>
References: <20260804002155.2233594-1-kuniyu@google.com>
	<20260806172900.2962014-1-kuba@kernel.org>
	<CAAVpQUACUFcdUV_TURigYp=-wDamvN2PBQ+c+njYxAyDvmq8cg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 6 Aug 2026 10:58:56 -0700 Kuniyuki Iwashima wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email says "I meant to send this yesterday, damn. This is completely
> > separate right?"

=F0=9F=91=86=EF=B8=8F
