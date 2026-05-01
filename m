Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F7B1624C5;
	Fri,  1 May 2026 01:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777597676; cv=none; b=mHjZ28BJPM6xr/MY4ZOjWbtLiS6EWa67SqJ16iZvlEy/+DbJVL7JnmFc6Sv98vMcA+nfI5x5MeiqXxKIDkxMEBaeDzbaMVG2bQDoDsC++f0JFwngtbA0eQ0zAQWB4dbXJMXwDXPafN9skLbxbx2De3Q7gzpPHQ+STaHRHbZROT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777597676; c=relaxed/simple;
	bh=f27zkwxm17MpnEoSwoWKiQLDnyVy1RpfiTZfdTFc+FU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uOewLypLDA22AJcPkp2LH/tuMzowirBob3JpVCT3zZq2R5nj7y9zHGLXcVg5KdeIhSxzAo/38hQYSxMQP1r0iju319XZfR/oECcXcmTMwVVF9AKED8kPq3OPx+RMdDA5XeJs8oq6Dr+kQ89N7zTXGrINu7ORs4+1BALa9cK4wnw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y8SulLsv; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y8SulLsv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55216C2BCB3;
	Fri,  1 May 2026 01:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777597675;
	bh=f27zkwxm17MpnEoSwoWKiQLDnyVy1RpfiTZfdTFc+FU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Y8SulLsv2T2DgYrtPYcYb2X7sAYx+WBdD/Ug9SpMVQore6h3WCX1fqYz5koE9YXMx
	 B216XG/ZitMVGLC+BQyYTGD5hs4DDTCIgeAgasW5wO0DlG+oVQxXWkqOQczZzM8Zhl
	 chRMemVjtb+kh3ekn/lRkolhPVtcLnzvdCg8iJutu/pVyX57EogsqBKe9QateC8tqi
	 SOUtUjmx5NcJETHtnpXlx7Guuj7r6X5nW/r1o8rAwsRDSihwzUpTYuszsYnXhqPmij
	 O1ApOJWL8wWTt7u3K7u3r2By+zn9ySiTAHizCKErn92RPZR/VTL/yPr2d9l0GO57hF
	 FehiNRyFp37FQ==
Date: Thu, 30 Apr 2026 18:07:54 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jiawen Wu <jiawenwu@trustnetic.com>
Cc: netdev@vger.kernel.org, Mengyuan Lou <mengyuanlou@net-swift.com>, Andrew
 Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon
 Horman <horms@kernel.org>, Kees Cook <kees@kernel.org>,
 stable@vger.kernel.org
Subject: Re: [PATCH net 1/2] net: libwx: fix VF illegal register access
Message-ID: <20260430180754.5e81b6ef@kernel.org>
In-Reply-To: <4D1F4452D21DE107+20260429083743.88961-1-jiawenwu@trustnetic.com>
References: <4D1F4452D21DE107+20260429083743.88961-1-jiawenwu@trustnetic.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 29 Apr 2026 16:37:42 +0800 Jiawen Wu wrote:
> Register WX_CFG_PORT_ST is a PF restricted register. When a VF is
> initialized, attempting to read this register triggers an illegal
> register access, which lead to a system hang.

in the future please make sure that when you submit a series the
patches form a thread
