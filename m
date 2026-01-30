Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D727A21019E
	for <netdev@vger.kernel.org>; Fri, 30 Jan 2026 03:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769742764; cv=none; b=Yi5gQYnR7S+H49t/SpdKuZF87KUp2jt4LyKLAll2vhE/1bH05i6U9GacZNVZHs+NppyVF2nkAkPVYJNieYawaIyuke3qg7eXofH6qkWoU0OlYlNsQ3qm7GarEzo5MKy1fi4/3JUy6yIVRZdkC4ddK12qgSENj+gHLoREFOYTzJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769742764; c=relaxed/simple;
	bh=KYgIkvElZxgfl3T8e47iU+rj6w2oqfJPQFwejpH9LJk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MRSnU+iNL/MxrZ6w/JgTIJmIqAQW6Zhf1fD5hXTclol7RNT3K5AhLysMlasTSvKFfbGt0SNJje9fhB+uSLY38X8Xck1PlrBE/0NeATDxs4zRu99TfR9uU7sZLiHcmLxkIhf2t5AMkoyrJVS+6VL9gtdvh5wSb4qZeYnsMumGOLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PDEPM1yG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PDEPM1yG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BE71C4CEF7;
	Fri, 30 Jan 2026 03:12:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769742764;
	bh=KYgIkvElZxgfl3T8e47iU+rj6w2oqfJPQFwejpH9LJk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PDEPM1yGENV+LmYjWJd/trhbrA31s5NeUKBDeAWtPu4pGagHTtybostE74cmu2U/w
	 AIAVpa7WL5P3EDpr5ci7pnQD31w9MDJL+MFQyVB2rqr6Wb4tjP2rozEmItowqop+yl
	 tVYQ0nwE9oZhU9opxW1X28V09oYDudLyUuskPeE/QQAGARyQEU10TpUweY3xzWTVsx
	 AhwyCSC4DxDqo93FsWESnU8fjlaUp13g0v7NMlGwxrMckbPrlqte+8IbWvYgneuqGQ
	 ILxFWWV+2AWJ8W+ioCIzTOUrZXqr8dHUbJzeSF42nZMKENPt5BqO+orX0ZUetEhkTm
	 j6Ma/YQOakXVA==
Date: Thu, 29 Jan 2026 19:12:43 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Stanislav Fomichev <stfomichev@gmail.com>
Cc: Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>, Jiri Pirko
 <jiri@resnulli.us>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Network Development <netdev@vger.kernel.org>, Ido
 Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@nvidia.com>
Subject: Re: [PATCH net v2] team: avoid NETDEV_CHANGEMTU event when
 unregistering slave
Message-ID: <20260129191243.767e3005@kernel.org>
In-Reply-To: <aXl_MwhS9AJXTYi4@mini-arch>
References: <4d69abe1-ca8d-4f0b-bcf8-13899b211e57@I-love.SAKURA.ne.jp>
	<aXl_MwhS9AJXTYi4@mini-arch>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 27 Jan 2026 19:14:59 -0800 Stanislav Fomichev wrote:
> > problem. Ido Schimmel found steps to reproduce
> > 
> >   ip link add name team1 type team
> >   ip link add name dummy1 mtu 1499 master team1 type dummy
> >   ip netns add ns1
> >   ip link set dev dummy1 netns ns1
> >   ip -n ns1 link del dev dummy1  
> 
> Can we add the above as a selftest to
> tools/testing/selftests/net/rtnetlink.sh? I was adding the quirky ones
> (like kci_test_macsec_vlan) over there.. Or maybe something under
> selftests/drivers/net/team/ ?

Under selftests/drivers/net/team/ please, rtnetlink.sh is too much 
of a catch-all.
-- 
pw-bot: cr
