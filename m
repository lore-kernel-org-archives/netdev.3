Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943D5233704;
	Mon,  3 Aug 2026 19:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785786856; cv=none; b=M4Ww3PWWqv/gD9Ld4vMt22CsvRZbUrCJSzR/1YbyZytbVrW/qGgvovaIX//6k6B/txY7cD0QMXwkxY/Z5Jy39xIRReejZuHwdpqNE3fv3896Ku058ZrsirFOOJVDQ1PV27Gaxoj4RF2MTGDh1tU+YTaFVhfv2ONL5XKVYmgdql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785786856; c=relaxed/simple;
	bh=4/8JA+/E86zx5o1I8efRaGQ/6w0WybcjIjI1xUOmJt8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ST4t9jDR5+0KIF5vm3Csr1DKt1Oai/I9SfR4oY7YiKlpUOssPT8C+jIviMnHwTYdfF/iFJX600ZxokbOxA8mZf2DdvzIsoIIiaoK0QAwWxtZNqTvR0qlZwbk87unW9KfbAJJbAVQMHzcs/ARUeLNCqKjCLBDipoLoGftUUxu3y8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i3syKAM3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i3syKAM3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0B731F000E9;
	Mon,  3 Aug 2026 19:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785786855;
	bh=V3Zh+nEQDg8Cy7ua7Zb9bUcQIetNhQ//I+wPohxqzNg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=i3syKAM3zLv0s7tS6mer2pLKjeJvdcwGaFp74TCwZNbSFTqHyqQBZgL6Cd1D0cmzA
	 PWYS+1Rau7qCR1GaMPQP3Qm5BHFndOJ57h8Y5ZeEL8hu3y9nitgtQ4oCE0TMwx7yEE
	 QfalhyRjgrqe27iWuDXqFY/9VhyI8M+mF3vq8upzaMxy7lLQtOmH8dD5R6FEjKaygQ
	 //P5WD2k9SWGMv0OwCPfex/OJEBD0n8+9yq620F0HCAxL8ws0lrG1yyeir3u1rbTDc
	 7dnYdvbbnAQchg7vZZ4wrpOKziWpPbSUtdJqDLNq8dxwJEsMBz6HIukQw8Hu1rpBAY
	 c8FlAU4/I7pXA==
Date: Mon, 3 Aug 2026 12:54:14 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Mina Almasry <almasrymina@google.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, kerneljasonxing@gmail.com, kuniyu@google.com,
 bjorn@kernel.org, jiayuan.chen@linux.dev, kaiyuanz@google.com,
 willemb@google.com, asml.silence@gmail.com, sdf@fomichev.me,
 bobbyeshleman@gmail.com, fw@strlen.de, Neal Cardwell
 <ncardwell@google.com>, Ralf Lici <ralf@mandelbit.com>, Will Deacon
 <will@kernel.org>
Subject: Re: [PATCH net v2 2/3] net: devmem: return EMSGSIZE on type
 mismatch
Message-ID: <20260803125414.500138af@kernel.org>
In-Reply-To: <20260803171441.408014-2-almasrymina@google.com>
References: <20260803171441.408014-1-almasrymina@google.com>
	<20260803171441.408014-2-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon,  3 Aug 2026 17:14:40 +0000 Mina Almasry wrote:
> When a devmem payload mixes with a standard page payload, return
> -EMSGSIZE instead of -EFAULT. This enables tcp_sendmsg to seamlessly
> fall back to creating a new segment instead of failing the socket send.

Sure but AFAIU this was discovered during a ML discussion,
so the change is an improvement for net-next rather than a fix.
Do you have any reason to believe that real applications hit
the error?

Also please add cover letters for submissions with more than 2 patches.
