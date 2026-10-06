Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 506C5547062;
	Tue,  6 Oct 2026 00:12:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791245550; cv=none; b=jxNlJX3OnGyogFoz1ia8IquwnW9MOQFdmit90XbeI3V+hHReiI161qtLJ1IHsjrw0wOz/rSEE4Ci8Dvn5XJUt7cIgD1ADGpIyr3nSJ89EyW3EAxLc5SXsBwZxvjM0i7ZE8ugp9jGqFkdOnhd4Zf6OCuTUdxag4VL4Fyzfu/9sRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791245550; c=relaxed/simple;
	bh=Uw0oDuIE0X5sYRvlamc7dRR8pxabBSZY9fo0/pu4iqA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lfh/pHqKJZDg0+lil++r+PWWtnSuh4/tccnXKTbBG0zrAAAbK/qfV7JP/fCqN+CYh6nCMggu1WUgg6oJwEWstnkPvOgcErkI2SRNcGkhlvUPxfRSfnLD8kfS6ZmoIyYesvFrWqs8z3VeVRETn5be1mLKkQ0a5D5glsmMb0ceDI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aP5KpEJ7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aP5KpEJ7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BCFA1F000FF;
	Tue,  6 Oct 2026 00:12:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791245549;
	bh=hh0YAnpVp5pjEhF2pMIYgehTbixda9fHaQfAAcQGgHg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=aP5KpEJ7af9bGiMNNMAg0fVi99s97tgS5i8QjG6P6GWZi6/vQX8KddEiiyp9KpIAF
	 xhQnhH+l4h4qpI3FoqzbXFGpLKeNBzDOef/8ISqn/YK+1ZQOmPrzxBCr0/8+D87WFZ
	 GLmJ7cmi+xMDcZ5VpHQhOpkdX9yq3OnHmrAJdWmXw3RiQju4bfmOoJK6Qh9LqDNegr
	 lIIXy+skmWckmS5mRJ4hL7TXO4nFzndDNevjGSE/Zl+bFn0evlesXcut0Pfoo5aL9Q
	 GjRYUZbqmbWn8bisNVXOmslrPEOO+b8G/mIecPQE8sCUadQ89dv33ZW9obhyMdh1+8
	 QmE6+HBfvG56w==
Date: Mon, 5 Oct 2026 17:12:27 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiayuan Chen <jiayuan.chen@linux.dev>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@kernel.org>, Eric Dumazet
 <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, Kuniyuki
 Iwashima <kuniyu@google.com>, "David S. Miller" <davem@davemloft.net>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Stephen
 Hemminger <stephen@networkplumber.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 3/3] tcp_cubic: fix divide by zero and
 endless loop on bad module params
Message-ID: <20261005171227.2014f26e@kernel.org>
In-Reply-To: <20261001112948.322463-4-jiayuan.chen@linux.dev>
References: <20261001112948.322463-1-jiayuan.chen@linux.dev>
	<20261001112948.322463-4-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  1 Oct 2026 19:29:43 +0800 Jiayuan Chen wrote:
> Subject: [PATCH net-next v2 3/3] tcp_cubic: fix divide by zero and endless loop on bad module params

if the LLM Medium severity complaint is true maybe also update 
the subject? I thought there's an actual div by zero somewhere
but the commit msg seems to describe the inf loop
