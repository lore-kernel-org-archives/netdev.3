Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F61B3B28D;
	Tue,  8 Sep 2026 00:47:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788828438; cv=none; b=UIDoPkI3tCMhWak6aD8BBEBYfQJY3gv/w5diloUgZpejQQLO2xndOWanNXFdDWwaGA15vk/dpzhrVMaWadTn9SgfcxCGTkbV582B4Pp1Lg1ivjykaIoUMcc5MAIcB/zM/vSzLPumZ9XEpLDSH+mHeJBbxZ8aE3phAcIhrKSkyHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788828438; c=relaxed/simple;
	bh=68PSLSNI0tuRek3BC2+AUVXpnakPjEP2h6pfVgUnb3M=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAFtTxz3ELj/NL0hmBNVUiOxFZtVdbXa9vuHlRm3zXzZSBb0kJWk680k4fepBsE25kpkxe6H87MW59+R+RABJq4CC+VdaAhhlHlNDOObGwRuhjdY/VspTmFtjEXpVU/1rZNZRGGSCxmhkgAKCJxoLeSbBkmd/JGqmEi/vOkeJPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XpUpTew/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XpUpTew/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 881C31F00A3A;
	Tue,  8 Sep 2026 00:47:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788828437;
	bh=5DfIWiQT3PACF1uFlLxo21CKnFOLI02Zq+JJWv/Bl3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XpUpTew/v3vfXRDnYpJXMhl6sARedQ+xtRLkdCLR8VVZyYRGjiefqjRbPiogmAcOd
	 d1wc5S9QROFZwWIdhCF3uhl3YOVakdDZoazvxjCQuu0qumalY7msOEuJnFTw02TCjj
	 LjIKiQ6K9PGjmnt5hNL8Lw0w1DT2Iady8lQ4lOl+LF4a5eMZsU61OYLOe4lb+swA4I
	 9BbSLLcunZPyBgcEX7GYXehTFvQlzfYr777E0QU60eEdSv1uQ8P6z5w/kQkVNLbMua
	 oj/yAfD2bjeNMQuik9CW4zMGF5hF8unR8I7NOgp/xOGqhyx2FTbGJtpViD+OPgBxqj
	 UD6GnHrNi5fAA==
Date: Mon, 7 Sep 2026 17:47:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Chuang Wang <nashuiliang@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, Willem de Bruijn
 <willemb@google.com>, Stanislav Fomichev <sdf.kernel@gmail.com>, Hangbin
 Liu <liuhangbin@gmail.com>, Samiullah Khawaja <skhawaja@google.com>, Neal
 Cardwell <ncardwell@google.com>, Martin KaFai Lau <martin.lau@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8] net: reduce RFS/ARFS flow updates by
 checking LLC affinity
Message-ID: <20260907174715.0c00501d@kernel.org>
In-Reply-To: <20260902025203.4741-1-nashuiliang@gmail.com>
References: <20260902025203.4741-1-nashuiliang@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed,  2 Sep 2026 10:51:50 +0800 Chuang Wang wrote:
> Subject: [PATCH net-next v8] net: reduce RFS/ARFS flow updates by checking LLC affinity

When you repost v9 please dial down the slop in the comments 
and the commit msg.
