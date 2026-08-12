Received: from stravinsky.debian.org (stravinsky.debian.org [82.195.75.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1AB8423A72;
	Wed, 12 Aug 2026 10:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=82.195.75.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786530363; cv=none; b=Tr7G9KuIxL4dq/YIGucU5k4PTkcnP26sEpTsdS4xkvsSzInys6zC3pkuDdQNz3FKkO/XFUOzGTMbzQGHvBA6XCTNPO2w1jXoIUJh94v3iWZpmdvu5vwpio0NUuTrMzEdb7YbJx4G6g+Gji7co7xc88JApxqTMKNKDk0y5Zi+rQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786530363; c=relaxed/simple;
	bh=mbtp6fIcU/mYc0DgGgiAALICk+fmR6QcifEPVQRKLac=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YVGeTMGGraHwrObliCia1VeAtccpBALrIrm4dsR75UN+lxdHwoKDDLql2pB+DqvPqNzb0pKf7coJZfpq/1cU1snHSxu0wLH2bK+JDUNxZP8FXd+8D78h1yb6y5yWCritJ6Og6KFcmcU9ckz+YxjnX3pxXr9Ev3PeXhUwhfUXbFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=debian.org; dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b=lSAcExCg; arc=none smtp.client-ip=82.195.75.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=debian.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=debian.org header.i=@debian.org header.b="lSAcExCg"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=debian.org;
	s=smtpauto.stravinsky; h=X-Debian-User:In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=ZG4/tOtlMC158ODe2VldmC4AlBAtVsrwF/kxgDvALCk=; b=lSAcExCgkv7JFF8abjQmGTzinA
	C710Oc8Y6zx5sUg3J3wph9WNA3perleERbT/7QyXOlDJ+vOvDl0dYqptiRwFxTx4QbaQUD9P3PtfD
	fswMg+W32fvY5unwfZYf7ueE8y5c/gR/3qUPDlyblNMXTVwEXf2A9pOhpQxyxwH9T1kFKAHv1cL9A
	LpMz4ifFP/QMGWevxjzdYWKVg8LWB37hOor51gXYNiLOvAi/KPla9B3UHY8dw7eYqt2S+/DOJbzYl
	eB7L89MENlfWwc/JwqYXYlZ6IxtmM/NnZUq+IuPdzQnz1R08SvfEgkYKUITVdO3HfFQKZff5BWxrK
	sLjBqlTA==;
Received: from authenticated-user
	by stravinsky.debian.org with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <leitao@debian.org>)
	id 1wu69X-004HDL-1f;
	Wed, 12 Aug 2026 10:25:43 +0000
Date: Wed, 12 Aug 2026 03:25:38 -0700
From: Breno Leitao <leitao@debian.org>
To: David Heidelberg <david@ixit.cz>
Cc: "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, oe-linux-nfc@lists.linux.dev, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, sdf.kernel@gmail.com, 
	kernel-team@meta.com
Subject: Re: [PATCH net-next 0/2] nfc: llcp: Move to .getsockopt_iter
Message-ID: <anxJuZZ7w2x7tkBr@gmail.com>
References: <20260708-getsockopt_phase3-v1-0-d8394f2fc554@debian.org>
 <amtMjiKCFJGY6DAY@gmail.com>
 <8536d413-a46c-4798-8feb-d4a0e0fa78c2@ixit.cz>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8536d413-a46c-4798-8feb-d4a0e0fa78c2@ixit.cz>
X-Debian-User: leitao

Hello David,

On Tue, Aug 11, 2026 at 08:46:11PM +0200, David Heidelberg wrote:
> On 30/07/2026 15:07, Breno Leitao wrote:
> > On Wed, Jul 08, 2026 at 04:51:57AM -0700, Breno Leitao wrote:
> > > Continue to convert the protocols to getsockopt_iter callback.
> > 
> > Hello David,
> > 
> > Have you had a chance to look at this change?
> 
> Hello Breno,
> 
> sadly I don't have it inside my mailbox nor archive.

No worries, I see it in lore:

	https://lore.kernel.org/all/20260708-getsockopt_phase3-v1-0-d8394f2fc554@debian.org/

> Can you send it again please?

Sure, I am happy to resend.

> Preferably in a week after another batch of fixes will land?

Sorry, what fixes are those?

Thanks
--breno
