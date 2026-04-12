Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DA037F8D9
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 21:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776028413; cv=none; b=lkbS/e7ZOWWrRA15c/tp5pDriF7j6wrlo2hD6l0TRbczAbKbNVIQqOybiorcUaSkJYATbpboESaUu1bK+RHt/ytxy1Kr+z6xwB0gdW8QOaT1K4W+N4hEHj3kF9SRWphktKCA1PwmR6o+hwix0cqd+7Boe2DrSGN2YZgw91lUpdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776028413; c=relaxed/simple;
	bh=EjSOrKKJHdn5rbuG/d08ofPzDKjbLDbrDrAy22nX2FQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2EHB1oErsoNBZvsTPW5wQExpA1oPLoE8+Pv/h8N+ZxZzcLvPZJ+0Zzi4PXIAg0xfQaHPVtkw+zVDvJnsNuqsrY9p/UZGcK4ZodoJybAVbM1TlJqyl12O3+mr40Yz8r/Hgnb1UuLXMkQ6qzys2wYmYO+GTmDidwMTa20fAbu3OQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pUvdquFJ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pUvdquFJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC800C19424;
	Sun, 12 Apr 2026 21:13:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776028413;
	bh=EjSOrKKJHdn5rbuG/d08ofPzDKjbLDbrDrAy22nX2FQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=pUvdquFJpvkALwJHmRm7veSl44erUNxkj0auhivzUw4dfzJNof0UjsS0yMQZ8zDDN
	 q4vytYuk2k+E8CKGKiq04QjwVDHJB3nH7YL9GQFZQaxfnp3wF7PWmzZ0sS+BS0kRu0
	 Vjx6CieBI9gRZhyNKvoa46dNC8b2Wb+ELbW8fhTPQYj5XRnQyPkLhlsKE7iZSAr6er
	 koC2HBoFyN9+i6TC3aKHXxSW+Iq5gLJMv1gxKq5Cnxv+JCrw12RRVeh1ElU9b4rJFa
	 jpNdHFGHK6zuo5g1pvSf324cP36EvgQ3hEpaGlCGxJ8oy3AcCSHXGPX9BTcy6DNq5a
	 m7mb2p9GAGZYw==
Date: Sun, 12 Apr 2026 14:13:31 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Luka Gejak <luka.gejak@linux.dev>
Cc: davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 netdev@vger.kernel.org, fmaurer@redhat.com, horms@kernel.org
Subject: Re: [PATCH net-next v5 1/2] net: hsr: require valid EOT supervision
 TLV
Message-ID: <20260412141331.5cf4d750@kernel.org>
In-Reply-To: <0CA147BE-C5AD-4B02-BE57-B586218B52A2@linux.dev>
References: <20260407162502.19462-1-luka.gejak@linux.dev>
	<20260407162502.19462-2-luka.gejak@linux.dev>
	<20260412124558.190c725f@kernel.org>
	<DDF9CC02-6FC1-44F0-B95D-967151BF0592@linux.dev>
	<20260412133157.3b335e1b@kernel.org>
	<0CA147BE-C5AD-4B02-BE57-B586218B52A2@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 12 Apr 2026 22:46:48 +0200 Luka Gejak wrote:
> On April 12, 2026 10:31:57 PM GMT+02:00, Jakub Kicinski <kuba@kernel.org> wrote:
> >On Sun, 12 Apr 2026 22:13:35 +0200 Luka Gejak wrote:  
> >> Regarding the TLV loop: I actually implemented a TLV walker in v4 [1] 
> >> for this exact reason, but I moved to strict sequential parsing in v5 
> >> based on reviewer's feedback to keep the implementation simple. Could 
> >> you please check if the approach used in v4 is what you had in mind? 
> >> If so, I will rebase that logic onto the memory safety fixes 
> >> (pskb_may_pull) from v5 and submit it as v6.  
> >
> >That's not really what I had in mind. I was thinking of a loop which
> >just skips the TLVs in order, leaving the parsing of known TLVs as is.
> >But I've never used HSR maybe this sort of strict validation is somehow
> >okay in HSR deployments.
> >
> >Please just undo the comment tweaks then.  
> 
> So keep other changes as is and only undo comment changes?

Yes, how is that not clear from my previous message? :|
