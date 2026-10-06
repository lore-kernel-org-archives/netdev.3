Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12FC01F192E;
	Tue,  6 Oct 2026 01:41:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791250919; cv=none; b=ML04JtkW0O7xoWePrUJ2QJMDemGf/EWTi8LPc8MYCftXP+L2uhj+14lbpsh97VT2ZqN5TOOQAJtClNoPQtpSJsUGKJvz2VHIPjPY6j1BVX7/Z5kD3EbkFsuEe9jH+oA58Itu+dl0uMkK0Xi8PMk68Ivcwl3e+FT/fQTdQH58tio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791250919; c=relaxed/simple;
	bh=oVavFehRKjJ3j8u3e3/F5BMFhqY+Ys4tqJ4u6Kl51ZA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+N13aoJB9db0oXBR+CaT93k7Dd+n4Z9PHtdTM4KhLmdDa2w5G3WjgATNfo82kH8EVkoh4dTy7rb6CMbj5h5ilSJUcsPoiIvLsEgRoJJeWSmmF1XGoZUEwLveQR/cuDXUvb0Fa36vpy7iN3wkOoh6gHoa51rCU3e3PQVXM4V+K4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C5vtaUl0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C5vtaUl0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AE301F000FF;
	Tue,  6 Oct 2026 01:41:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791250917;
	bh=VT3bLU0875jwYRkA1BtS6B+j9eWHcv4+6r/hnIidIEs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C5vtaUl0UZYYjklJv/lHK/X6I2aqeEjEzuUe9u89v+1OqWaCxI23N5V+P8ldbNq+i
	 ixE7gTJxCoAvQYa9V1093+QmakyYVft8ERiT68J5J2IRo5N86ZbA6xESNKxkge4M2x
	 HqIWE+I/Wd/HSZrhhE3UwCOKtjrBliHwfKKnZ3Rh1OoOVDAVWzl0HBWs8nWxs4ONQ2
	 ZLJDFaf+Th0I26GoJZP5kodMWukmKXq6xYYL+JKbQIaLkRQfmNMqIIf3idOjmFMKa1
	 FlbohyzyYRfycei8GsYOZILbR2wAofp06xDWZ6QLC65TGHrjRmU86CUjpnFYWMU6pk
	 zX3w0PfbpaeMA==
Date: Mon, 5 Oct 2026 18:41:56 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Zihan Xi <zihanx@nebusec.ai>
Cc: davem@davemloft.net, edumazet@kernel.org, pabeni@redhat.com,
 horms@kernel.org, kees@kernel.org, ernestas.k@iconn-networks.com,
 leitao@debian.org, tim.bird@sony.com, shuangpeng.kernel@gmail.com,
 luoxuanqiang@kylinos.cn, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net v13 0/2] llc: fix listener child socket leaks
Message-ID: <20261005184156.01eb0ebd@kernel.org>
In-Reply-To: <cover.1790688018.git.zihanx@nebusec.ai>
References: <cover.1790688018.git.zihanx@nebusec.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 30 Sep 2026 13:29:40 +0000 Zihan Xi wrote:
> We found and validated an issue in net/llc/llc_conn.c and net/llc/af_llc.c.

We found it easier to delete this code.
Please look at the net-next tree, and resend the fixes there 
if the bugs still exist.
