Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D087D2E8DFC
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778587605; cv=none; b=uOVyRuewFkC4MLFdt9NJETVlg8soHf2ZL/vI0T7pQdVeBKvDGCFDW+Vmqo80iGlNoL51pxj2++Dae8v08gYneoq7ZfC5iYSJ6WMm0zjLOAzsUukCn9U61RNwfVwe19Ay2qT6lbSCDr0/3UhFJEZpGMrI6UW874q7teQdGKqj4Zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778587605; c=relaxed/simple;
	bh=EVoNlwNWuHAt+iTON16hIQS0CWrtlOivBnhdB/Ai3jI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=V6tSAqg3YaVfY1nkLOxRtpUrceRlBjKlIaFB+/6IncHEYLO36mEiuNuBnhqy2OlbsNwtzpglBNotzQ3DvEb9OY1BNj+rWlX/wFAOQbjakgY7/Y04GeCrmuJSNzH0DtMuuR45v4SyxEx5HEMMSVzyTLBMEQp6YDMA/lcwRHQKLhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Authentication-Results: mail.toke.dk; dkim=none
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>,
 Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net-next 1/2] net: make is_skb_wmem() available to modules
In-Reply-To: <20260512094859.3673997-2-edumazet@google.com>
References: <20260512094859.3673997-1-edumazet@google.com>
 <20260512094859.3673997-2-edumazet@google.com>
Date: Tue, 12 May 2026 14:06:32 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87qzngygqf.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> Following patch will use is_skb_wmem() from fq_codel.
>
> Provide __sock_wfree() only if CONFIG_INET=3Dy
>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Reviewed-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
