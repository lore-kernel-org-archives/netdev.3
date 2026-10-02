Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0891A2DB788
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 00:50:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790902252; cv=none; b=ZzuUZvhDzJhnkLPKtw+l0X0pDmAxfEU8ixMrwN/0zx0+m4yNkTrH+StpLBZo5zq1PPSj6Ub3QAsIoapTJ5Bp6Ts3PzqAwMNxTSfwrNhsw+YB/NjzOQwz7W/dfJ0PLzN4fhBBwfM0Ii+FRnAncQLUy8QSOcP9qFmjEIENBYpWCfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790902252; c=relaxed/simple;
	bh=+Owkm29q/2YMglS8KaoH988fxptgi7KNs9wseSGRAys=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ch5Ly/zj8DLlmkEJm2cB+eI9Zk0+ia1+ND2eEZqx9Kc85nLQVyWC5JejtqtYu6wO5Gqb7N841y31Pfl2WjFjw6AjKe5KakugxFye3F3l9g3AvsMd1j00weXnGhiVmxjFEFldnnxMNDGwEiZutEO64Vq6F4ykl+Rlnkl0vrO9x8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SCGmYDtk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SCGmYDtk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523701F000FF;
	Fri,  2 Oct 2026 00:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790902250;
	bh=YflJ4aikgZ46Gz+HouBU0ClKajGwdVl4FQszISMveAQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SCGmYDtkBaVzPbxy7DJNyIVy3OX0rEQkJ3KWwryEVzccyuK5bzx3ZKqnXd/hz6MCC
	 X/nZgxxD9bFpx8N64F58hCG9355zWxpCDXZiFdIUZCFmNv2Z76Ppk6eC43ClAL8I3K
	 FxpTC0q5ft8LDeK8ujgC+eEvl0Xpyw0odUhCoz1KmYNa6MDVzXUk0ibY6GMy75OXQ7
	 HZX54p4JHJ22cjsnS1rXcZZUWHzBk6hJ0130yfSrxFSRrMKbWlcuVTHABXQ9GDm48C
	 G41Z0moE+PrMDS/XEHkjMCXZgN53wfdjzVwCLjz2pYg+ehI3FjA58iMuHuaxhb2TrZ
	 WapcaKTa07U0Q==
Date: Thu, 1 Oct 2026 17:50:49 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, "David S .
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Victor Nogueira
 <victor@mojatatu.com>, hybris <hybris@mojatatu.ai>, Toke =?UTF-8?B?SMO4?=
 =?UTF-8?B?aWxhbmQtSsO4cmdlbnNlbg==?= <toke@toke.dk>, moeller0@gmx.de,
 cake@lists.bufferbloat.net, Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v3] net/sched: cap the accounted backlog before
 it can wrap
Message-ID: <20261001175049.05faa751@kernel.org>
In-Reply-To: <QDISC-BA27.v3.20260929142417@mojatatu.com>
References: <QDISC-BA27.v3.20260929142417@mojatatu.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 29 Sep 2026 14:33:32 -0400 Jamal Hadi Salim wrote:
> A crafted tc size table (TC_STAB) inflates qdisc_pkt_len() up to
> QDISC_PKT_LEN_MAX (1 MiB),

IIRC Eric was pushing back on this as silly, which I'd agree with.
Not sure where the conversation ended. But anyway, AI found some bugs,
so..
-- 
pw-bot: cr
