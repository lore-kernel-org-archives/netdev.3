Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BAFE145FE0;
	Fri, 22 May 2026 18:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779473737; cv=none; b=IjkaO57B8zAI1mniP+IwT1wMuZawBiTcZJYkOLLUc8KPHPCyu940AWvZZVY86LNA+PMfcHwyHFxrQQi8EkURutpToFmqbzVSG7+xMfsj2p0d+UgqDDhVG0dpXicHZDzdMdhqUwEdPW+h3/ReaUp+YfHwLXXGFdt3YcorBnKpNqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779473737; c=relaxed/simple;
	bh=lHhv0VS01ysseP2wrZ7R5iwRjIlLM28CRhatcx+WTiM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YYaAUo305qvcMks5o2UixnddOtwjs3BapWFE8zlmtkycm6jT86FxcSKS8oN5/Z2HzicjFK6T05hwe2xFnjkvhUdZ5puy+HpHnawFWkAEljJRLqQsG1Htrv3ONU+PNGoUlgdbwPaGTySNWyX2P9h9db3C0muqjnC3ulYp9PffNGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NAxcseK+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NAxcseK+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA291F000E9;
	Fri, 22 May 2026 18:15:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779473736;
	bh=mmlduE3cYDz2ue5ubg2ggOIsEdEHhcKK/FiYOfvanHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NAxcseK+lAIBSd50Jcv9jEz+q96Mujtn2uQeSwxpr3ocWkdDmYVRE2kJBAxe9J9fO
	 DoFF6aEln9c4ibln04wOZHOmdXdB+j+rgqQgbi4nYZ4xHMxxVMZHUd+7AzsFCYVs/i
	 MKFX/u0fOeXHmJisrVXm3ddcJWK+GzzAjmX0XStk3pnFwWwJW9evDJtfCuj7/ffF4D
	 Lau1haLbZ8MMDipmRM54fxbz+BCztSm1HJgNexD/dO68ID1wt25iveAcD5vs/ORGUH
	 GbGhwy3B7mcgxOfG/jXh/Nvi83f+ynSe+73gWfthzG08G2FCYOAYP4rFia0pmCCXot
	 SN23qZuUH1y+w==
From: Jakub Kicinski <kuba@kernel.org>
To: lee@kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>,
	jchapman@katalix.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] l2tp: pppol2tp: hold reference to session in pppol2tp_ioctl()
Date: Fri, 22 May 2026 11:15:31 -0700
Message-ID: <20260522181531.1491908-1-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520134837.2780050-1-lee@kernel.org>
References: <20260520134837.2780050-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.
---
l2tp: pppol2tp: hold reference to session in pppol2tp_ioctl()

This patch addresses a use-after-free in pppol2tp_ioctl() by replacing
the direct sk_user_data dereference with the refcounted helper
pppol2tp_sock_to_session(), and refactors the function to drop the
reference on a single exit path.

> diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
> index 99d6582f41de..9a2243a32ceb 100644
> --- a/net/l2tp/l2tp_ppp.c
> +++ b/net/l2tp/l2tp_ppp.c
> @@ -1045,64 +1045,57 @@ static int pppol2tp_ioctl(struct socket *sock, unsigned int cmd,
>  {
>  	struct pppol2tp_ioc_stats stats;
>  	struct l2tp_session *session;
> +	int err = 0;
> +
> +	session = pppol2tp_sock_to_session(sock->sk);
> +	if (!session)
> +		return -ENOTCONN;

[Medium]
Does this change the behaviour of unknown ioctl commands when the
socket is not yet connected?

Previously, the default arm of the switch returned -ENOIOCTLCMD without
ever consulting sk_user_data:

	default:
		return -ENOIOCTLCMD;

In sock_do_ioctl(), -ENOIOCTLCMD is the sentinel that lets the generic
dispatcher fall through to handlers like dev_ioctl() for SIOCGIF*-style
and similar generic socket ioctls:

	if (err != -ENOIOCTLCMD)
		return err;

After the patch, any cmd at all on a pppol2tp socket whose sk_user_data
has not been bound by pppol2tp_connect() now fails up front with
-ENOTCONN, including the generic ioctls that previously fell through
the default arm.

Would it be worth either keeping the per-case session lookup, or
mapping the no-session case onto the default arm so unknown cmds keep
returning -ENOIOCTLCMD?  The commit message describes this as a UAF
fix and does not mention this user-visible change.

>  
>  	switch (cmd) {
>  	case PPPIOCGMRU:
>  	case PPPIOCGFLAGS:
> -		session = sock->sk->sk_user_data;
> -		if (!session)
> -			return -ENOTCONN;
> -
> -		if (WARN_ON(session->magic != L2TP_SESSION_MAGIC))
> -			return -EBADF;
> -

[Low]
Is the loss of the explicit -EBADF magic-check return path intended?

Each cmd arm previously had:

	if (WARN_ON(session->magic != L2TP_SESSION_MAGIC))
		return -EBADF;

pppol2tp_sock_to_session() does perform a magic check, but only as
WARN_ON_ONCE() and it still returns the (possibly corrupted) session
pointer:

	WARN_ON_ONCE(session->magic != L2TP_SESSION_MAGIC);
	...
	return session;

So on a magic mismatch the function will now proceed to dereference
session->session_id, session->tunnel, etc. instead of bailing out with
-EBADF, and the warning is reduced from per-call to once per boot.

The commit message frames the change as purely a refcount/UAF fix and
does not mention the loss of this defensive path; was that
intentional?

>  		/* Not defined for tunnels */
> -		if (!session->session_id && !session->peer_session_id)
> -			return -ENOSYS;
> +		if (!session->session_id && !session->peer_session_id) {
> +			err = -ENOSYS;
> +			break;
> +		}
[ ... ]
-- 
pw-bot: cr
