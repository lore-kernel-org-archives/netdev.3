Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D483E3CA493
	for <netdev@vger.kernel.org>; Tue, 26 May 2026 22:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779835499; cv=none; b=tJt33c6uNhRJHql+oSrmumEq79q/b/AtkIhp+GH6Ubx4S4gAXfDE0IROMu7ZZX18jMZd8ywTTQEWCHa6h+jHcN5ps5hVBr2rM6GLf6RMKZmelu8TW5JqDJWuAFWn/8yzeydxMs5HRcqUO1vURd66El4dnytPK2VAzurto1i/LCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779835499; c=relaxed/simple;
	bh=HULnY9ojAYZD4Xu1b40rZ/VLRT9Da9PwoZILDmv7YYM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c6CDJFRXj4UyY7vooWJP5TCjQSi8nBjSjwAfStkQSynXIiCWLtqe4sdSuDEFMhEuyG4Ik8eDWjidpZpb8GpmNUKO9ZUzya8CTjHnQRCRjYEicdCECAeUMSEkeIxrAKzZ/NV5qsTPc/xqWFMUrM9sqGNe004kq4lPKQLD5e0H+aI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DmSD/1pS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DmSD/1pS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 471281F000E9;
	Tue, 26 May 2026 22:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779835498;
	bh=lfsfFOSWQeZsfeh6RXb/T0mED4t6wvi7ICwpA9X0f88=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DmSD/1pSAl/1e8G702OwJ7dCGLWYm1gShyXkUJ7MJYYPZuUoiKLABZUAI2M53I1Qc
	 ARH4YvvTin23KbPlS1Apalp6cUeV3nEf4FU18X7SjwHkBmLDKB/ysMnXy44jNxZYCr
	 Yq3G5fCkno1EM2uvD7Hy6KF9PYLoysWspaVxaoOuFh8iqQN+cZGY2E2dvyLKHcc6NN
	 PiL8PYN75HbDhHem5zReKJLmax6NQ5gKs64+zrlIB0QrDIIgIaabkkL8ncV6yD4sMZ
	 Xca/MA+gmxFG44mVUoJWN7UVQZ10SrCAEi9d+SmkRm7nucsM+uOH7NXPWmZEcf6BDZ
	 zokrjC9lGJEdw==
Date: Tue, 26 May 2026 15:44:57 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "Remy D. Farley" <one-d-wide@protonmail.com>
Cc: Donald Hunter <donald.hunter@gmail.com>, netdev@vger.kernel.org
Subject: Re: [PATCH net-next] doc/netlink: rt-link: fix binary attributes
 marked as strings
Message-ID: <20260526154457.57b16659@kernel.org>
In-Reply-To: <20260526161641.459869-1-one-d-wide@protonmail.com>
References: <20260526161641.459869-1-one-d-wide@protonmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 26 May 2026 16:17:22 +0000 Remy D. Farley wrote:
> These link-attrs attributes were previously marked as strings:
> 
> - wireless - struct iw_event
> - protinfo - a nest of ifla6-attrs or linkinfo-brport-attrs
> - cost, priority - unused

We need your Signed-off-by tag on the patch.
-- 
pw-bot: cr
