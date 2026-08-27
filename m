Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6B7841B362
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 19:28:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787858939; cv=none; b=JBMzJfdWV3AhCbq9vF+ZQLVQYIfSbPQJGCuCpUACyLrDu/P0sITfPmXyORHAQ5t4x3Rt2yNcG/nwypH9mgJUBZFK6VbQn3L4z4pSyqUUo8K5BjDQ843zCNR7ycWbaBCX1AE5ScpWC/6SczbQL49CUcrO/s4CRhY5dbItfJwH9SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787858939; c=relaxed/simple;
	bh=FeIQxdHTOmnZW9Dnr7VT0fAS4Xz1OIJ3XG3A0mrPwvU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g0GEa5WSC+sDqCKecDmdGOi5IAnh5IbKivDsCRW37mhWOr9JdAOrVaWXGZmiGz6c0TlPC957huQUQiosyZoh3TLKJfcWGMZ1PutmGZ9hIDhwHtqP6czfoyNcAwjNluUw60k9JYfIzB+l9OLy+5kq9twSIyvD6oAD7wzO4MDe9a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b75LpZFh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b75LpZFh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 181351F000E9;
	Thu, 27 Aug 2026 19:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787858937;
	bh=nVoWYJIvXuPpaTPyefii3VMp5mMbMwdJnYiLZebYbpU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=b75LpZFh95XFekwxl6N2GzdK2tJnTscpr/gXosixBa2EG9sneyGSdw/L05DIJj2hv
	 DGpd95JZgmIz8Avso+LpS/z5GjTHX31iiaYNviMBEu2F1OFYXT3/opzqXQo9f4KtIe
	 TXZlHrekZnu63vaDI1z+zanAnTilR5OJB+ruqwv45voFC/liVuJ2iFejXusXNy/FCO
	 ADHuDqgT9IP8uAgvHlfYAxRm21v/cxvbGFhCQI3sO2GueK1StHNm7OFza1Nb/PZAQf
	 GDW5i0dqj0hKMlvklN7hMBU+UZqvqfd0wDjoqd5rMLIlR40tWVtGqwuCZglV9f5NT5
	 2pPJ3BmFDLtkg==
Date: Thu, 27 Aug 2026 12:28:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, Alice Mikityanska
 <alice.kernel@fastmail.im>
Cc: David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, Shuah
 Khan <shuah@kernel.org>, Hannes Frederic Sowa <hannes@stressinduktion.org>,
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, netdev@vger.kernel.org, Alice
 Mikityanska <alice@isovalent.com>
Subject: Re: [PATCH net v4 3/4] selftests: net: Test UDP length overflow
 with PMTU discover and big MTU
Message-ID: <20260827122856.4b6eeb96@kernel.org>
In-Reply-To: <willemdebruijn.kernel.3645a45d69737@gmail.com>
References: <20260825200215.90326-1-alice.kernel@fastmail.im>
	<20260825200215.90326-4-alice.kernel@fastmail.im>
	<willemdebruijn.kernel.3645a45d69737@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 26 Aug 2026 13:18:18 -0400 Willem de Bruijn wrote:
> > +def check_dmesg_clean(func: str) -> bool:
> > +    with subprocess.Popen(['dmesg'], stdout=subprocess.PIPE) as dmesg:
> > +        res = subprocess.run(['grep', '-q', f'WARNING:.*{func}'], stdin=dmesg.stdout, check=False)
> > +    return res.returncode != 0 and dmesg.returncode == 0
> > +
> > +
> > +@contextmanager  
> 
> Interesting approach. In ksft the built-in defer() mechanism may be
> preferred. Not sure.

+1 small preference towards defer() if Alice is willing.
It's be more idiomatic for our selftests

More importantly ruff check and pylink --disable=R have to be clean
for new tests. The test cases need a docstring explaining what they are
trying to test. The helpers can probably get a _ prefix to mark them
as private and silence the warning.
-- 
pw-bot: cr
