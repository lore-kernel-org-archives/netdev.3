Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030CB1CBEBE
	for <netdev@vger.kernel.org>; Thu, 14 Nov 2024 01:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731546523; cv=none; b=LhgvFveDe3GPqe5/ZQ0J4c8a/TYUQJkudsCM9vqxOcvJluq05DvNCBwXGQ1L2E3Ir9LaP2dO13OD0bx7f+KYSjSHGrR7wTSEwc3mLKB+e0J8pF/qienZ7v5BURYCWJCtsX363u6KtuhOcogPTZ/x43koHPhV0t7ff9A/mtm0hAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731546523; c=relaxed/simple;
	bh=z/kUcwZByn2wJFZyBqXQ8luOv1mWDw7B4iVvC3VAguk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kt2ojaq5GO6dNEEAN9gdoodwIKyoV5Suv+cDdtUkJizqEj6QGzfx3SqSULjolnvCsoPyyxiwbn7RcRG/9raHEKj+rcbj/TvbrL2nhRRo1XaRX9/gIrWNkS5huHiWYGWrf3fa1o1lB+vkYd9wm5YbNq2ISeRWZWVs8zio8w8nIhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fYReW07p; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fYReW07p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CF12C4CECD;
	Thu, 14 Nov 2024 01:08:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731546522;
	bh=z/kUcwZByn2wJFZyBqXQ8luOv1mWDw7B4iVvC3VAguk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=fYReW07pb9PWPxFxKiEmtA2GtRriGDeIyspz10qtaxdVNBZpkduUrIR7mdsAnItor
	 Qcfzscawtd6oplnug4UOMVTirim0bZsJrewshusreq9Gomz7XPgP5tNsyexw6m3M4e
	 edteT2xp6sS9ReaTgR3dBqFt6Ukw/57tYGXm0EqxeT44loiuHCkdJoLOiQjtsmBxjE
	 vac73LCOj5ftm0zc85T66ypVDIbmB8ACFQPcPYhP5t/j7a7y1adAurSmu0dAXOzPhf
	 OpPzPjPfHtILG24KRtOnzFMwEzeieNcfNJKa0ampuj2XEvnmYmFpBd0xPrhdqXbln4
	 KnOHTqTiYXZ1Q==
Date: Wed, 13 Nov 2024 17:08:41 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Petr Machata <petrm@nvidia.com>
Cc: <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next v3 7/7] selftests: net: fdb_notify: Add a test
 for FDB notifications
Message-ID: <20241113170841.7acf33de@kernel.org>
In-Reply-To: <871pzfjgc2.fsf@nvidia.com>
References: <cover.1731342342.git.petrm@nvidia.com>
	<baf2abd6af2e88f8874d14c97da1554b7e7a710e.1731342342.git.petrm@nvidia.com>
	<20241112142234.7abf2232@kernel.org>
	<875xorjq37.fsf@nvidia.com>
	<871pzfjgc2.fsf@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 13 Nov 2024 16:11:03 +0100 Petr Machata wrote:
> > - A "0 seen, 1 expected", which... I don't know, maybe it could just be
> >   a misplaced sleep. I don't see how, but it's a deterministing
> >   scenario, there shouldn't be anything racy here, either it emits or it
> >   doesn't, so some buffering issue is the only thing I can think of.  
> 
> I think this really could be just a "bridge monitor" taking a bit more
> time to start every now and then. Can I have you test with this extra
> chunk, or should I just resend with that change and hope for the best?

Let's give it a go, if it doesn't fix it we can try to do sneaky local
changes in the CI, without more resends.
