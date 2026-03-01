Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2761459F6;
	Sun,  1 Mar 2026 15:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772377221; cv=none; b=lb2KLjVIMnBUKgp+rtp2ytFjf144GB2Ll+5tE+wLxYTp0mAt/MEVDV5ljn6DqEVZsE5vzh+QF/OAy8LVlBsWG+7GJn1l0AbIRMFH6Wuc75arJXB+ZOzeSTdiRQVOfgZJB32orA5yfWVUk1w43yd6Dn4VnaehDvO2tn1BhiflqBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772377221; c=relaxed/simple;
	bh=SnWSj9ysVZ0PhgcjTRZP/9YT2tmar2+AIRMDPlOAwZk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WatqlXx8LDX52iPykIVioSnE346PitU9G1C+VUtSGGAC6ByivYydyWIefmWQSIM6fxA9zlt+hHSV1sNDs9KoSJlms+JfoUde97pTHRduB6n2m3AeuRmECxQf8GCBccuWCnZh0SodCRRXXIL3km3Q3TTzLHULhAVdD0xvNJ2WQyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lBuWnjRx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lBuWnjRx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07E2DC116C6;
	Sun,  1 Mar 2026 15:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772377221;
	bh=SnWSj9ysVZ0PhgcjTRZP/9YT2tmar2+AIRMDPlOAwZk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lBuWnjRxpyKCvjDZ7wRqjY3C+Nwh1E/iAXoMLSMxR/BV+XyN9QvyKkH4EjemLjgD7
	 qNanw5c+dFuP7BfMKWerDxPMvCRAJKcSAb65+wsV3eF1U96R2vUWA6RYdKkIjnYllP
	 d3gpU0tgJyiWiZ3CVaAqjx+hvDYVw08ZBCj3eb7NjDWy21fVF+WSFMoiDFiBRRuE4N
	 Y6DVqzgxib/kv0qg747tKKXCD/4KazvM5r4h6kqirxLL6qxkC29qPP49zwAfN0EiQu
	 0QJ/w32/WZ1oHw3OdNhYinlihs4RE/0kULGtQnMt+QUP89LxzRbhn92SVIKZak7Lmv
	 +ydvOWe42lvBA==
Date: Sun, 1 Mar 2026 15:00:16 +0000
From: Simon Horman <horms@kernel.org>
To: kexinsun <kexinsun@smail.nju.edu.cn>
Cc: steffen.klassert@secunet.com, herbert@gondor.apana.org.au,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, julia.lawall@inria.fr,
	xutong.ma@inria.fr, yunbolyu@smu.edu.sg, ratnadiraw@smu.edu.sg
Subject: Re: [PATCH] xfrm: update outdated comment
Message-ID: <aaRUgLEWwgqaNGZ_@horms.kernel.org>
References: <20260224021821.1502-1-kexinsun@smail.nju.edu.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260224021821.1502-1-kexinsun@smail.nju.edu.cn>

On Tue, Feb 24, 2026 at 10:18:21AM +0800, kexinsun wrote:
> The function __xfrm4_bundle_create() was refactored into
> xfrm_bundle_create() (among others) by commit 25ee3286dcbc
> ("xfrm: Merge common code into xfrm_bundle_create"). The
> responsibility for setting dst->obsolete to DST_OBSOLETE_FORCE_CHK
> now lives in xfrm_bundle_create(). Update the comment accordingly.
> 
> Signed-off-by: kexinsun <kexinsun@smail.nju.edu.cn>

Reviewed-by: Simon Horman <horms@kernel.org>

