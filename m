Received: from mailout1.w1.samsung.com (mailout1.w1.samsung.com [210.118.77.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDE994156FA
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 12:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.118.77.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784894608; cv=none; b=rqu5g8rt8VUIM6UAOlXRzd+MR9cv6NN5BkxPPO46u1MJuhZZjIuFZAHLxWEgkEeUIQ5Hh/KNnwWHDPZYQkhQGhXr70Z/d1jh0A1J+yNQBqYGhgROjidQWeMlTnUu5Dv3cIYt+sD72ezx7jXz4WVAhgNpGldScl7rNN10J2TFLno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784894608; c=relaxed/simple;
	bh=//yXQ/W6uM/S+a56eSp0TzLsNtInVBXwJ6HtOns0TBA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:In-Reply-To:
	 Content-Type:References; b=EjJZl7mvrdg0N0ObmPSURdE2MuSEW8FZUK718nCKjlLYjplsL1lKVEGMi1yPc7MndEJSJ2RPy2VI5EPhqfCWi+Ex8n3wmxuKm68+38bYX82+01v0WTqQbDpu1hYbTsybHKMabrfD0Uv4+rt2ivX7ZUgU3UDPP2eZLmDDtLbixqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com; spf=pass smtp.mailfrom=samsung.com; dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b=WjlbX/1r; arc=none smtp.client-ip=210.118.77.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=samsung.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samsung.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="WjlbX/1r"
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260724115643euoutp0192c8b6c4179691a2700dd61f263aa4bf~FN9Ims3rH1119111191euoutp018
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 11:56:43 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260724115643euoutp0192c8b6c4179691a2700dd61f263aa4bf~FN9Ims3rH1119111191euoutp018
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1784894203;
	bh=//yXQ/W6uM/S+a56eSp0TzLsNtInVBXwJ6HtOns0TBA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=WjlbX/1rvUBZ1jq3NVps2A2yWSOol5HlWDDk3w+JvV6J3QXZzyaXMj2Z7bweLQKLY
	 6yJpI2HJ2fLUfCVEqme3k4/yPwrUx5A1yFXkuGKXwL5+Q/ghPgcoq3kgslTL7O9S/o
	 cnQW65ReW+Ih7aK7jLra3xaOAoKW/sb/Z82EqytU=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260724115642eucas1p29f9c8bdc59a889ad66cb7b2a52cdaef7~FN9IWzwZl2916229162eucas1p2Z;
	Fri, 24 Jul 2026 11:56:42 +0000 (GMT)
Received: from AMDC4622.eu.corp.samsungelectronics.net (unknown
	[106.120.77.34]) by eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260724115642eusmtip2fe7f214d29c1a5e52a2e0c3526ba9c8e~FN9H4xDlA2836828368eusmtip2n;
	Fri, 24 Jul 2026 11:56:42 +0000 (GMT)
Date: Fri, 24 Jul 2026 13:56:39 +0200
From: Jakub Raczynski <j.raczynski@samsung.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
	Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Simon
	Horman <horms@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan
	<skhan@linuxfoundation.org>
Subject: Re: [PATCH net-next 2/2] docs: netdev: clarify expected
 interactions with LLMs
Message-ID: <amNS9/owsgr44v7w@AMDC4622.eu.corp.samsungelectronics.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <83360de7addb13a3b5f4d5e722148f248fdb2ae0.1784884817.git.pabeni@redhat.com>
X-CMS-MailID: 20260724115642eucas1p29f9c8bdc59a889ad66cb7b2a52cdaef7
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----F80QVkSs0AhR68Zg0oSW-b5-i4-oaHVRPVEJevbh2s58A1oD=_89530_"
X-RootMTR: 20260724115642eucas1p29f9c8bdc59a889ad66cb7b2a52cdaef7
X-EPHeader: CA
X-CMS-RootMailID: 20260724115642eucas1p29f9c8bdc59a889ad66cb7b2a52cdaef7
References: <cover.1784884817.git.pabeni@redhat.com>
	<83360de7addb13a3b5f4d5e722148f248fdb2ae0.1784884817.git.pabeni@redhat.com>
	<CGME20260724115642eucas1p29f9c8bdc59a889ad66cb7b2a52cdaef7@eucas1p2.samsung.com>

------F80QVkSs0AhR68Zg0oSW-b5-i4-oaHVRPVEJevbh2s58A1oD=_89530_
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline

On Fri, Jul 24, 2026 at 11:24:05AM +0200, Paolo Abeni wrote:
> +both use the Sashiko infrastructure on top of different models. Reviews are
> +available after 24h. Patch authors are expected to proactively look into the
> +AI-generated reviews and handle such feedback as any other kind of review:
> +either debate it or address it. In both cases a reply on the mailing list is
> +expected.
> +

Would it be reasonable to implement automatic response from Sashiko to
mailing list? Some mailing lists (eg. dri-devel as far as I have seen) post
all replies from Sashiko to thread, which is imo not bad,
although it could be filtered by High/Critical severity.

What do you think about potential for similar solution on netdev,
since AI review has become 'basic' check in patchwork?

BR
Jakub Raczynski

------F80QVkSs0AhR68Zg0oSW-b5-i4-oaHVRPVEJevbh2s58A1oD=_89530_
Content-Type: text/plain; charset="utf-8"


------F80QVkSs0AhR68Zg0oSW-b5-i4-oaHVRPVEJevbh2s58A1oD=_89530_--
