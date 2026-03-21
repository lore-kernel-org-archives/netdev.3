Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D79276058
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 00:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774053303; cv=none; b=GT7AbgGEgOyJmhlEsbv89etqyLlaI3I+oEmxQLZ3pGLVkVPDLmI79ilmuMMY7uZT+TcN/xDq8/TD8GieUvHbCtmQ0FXKBNA6cuHq6TRalYHtTuU+psg5EtR/9OuFU5H8ol2/FotfQd4KWP3Hd8ljFdkrjCz/QZALZSPEd87aAxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774053303; c=relaxed/simple;
	bh=04xS8UG35du1aMjwH3VDhtSpIuCIR5x02bBi3UuvsUw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IOgzvJG8fsEtJ3K2xx0Sx/wpybvJfw8rxga76q/mmVhH0eul4GyRlACxuKYP6UzpwFJ1Lleh+IKJbN0x/xazRkM/PNZGz8kVRYMxPXQRlh6wSfdEDOlduPAbTVq4e/Z+6lmKxUhKAJfJtQopqPsMleqhiVP5AJEU7WNVcEyomcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=etcwypqI; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="etcwypqI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC7FAC4CEF7;
	Sat, 21 Mar 2026 00:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774053302;
	bh=04xS8UG35du1aMjwH3VDhtSpIuCIR5x02bBi3UuvsUw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=etcwypqITwNF7a1iFi06B733cXap3jgKr03guA8zZfyuBMKuJWPd9t/IT/QGqkPIl
	 QtUJSRs+yy+wo1g9EqB9zZyFrtZlfGqfHEt1yVHPQZUJirxgc2EX8D0z/3D/TcEnEc
	 J7bTWn7Uol2goVTaRvHF6+NN8r22LyDaj2ZwS50Shq3Q2Yk7x7VmXHJLzg+jKTkPRx
	 JgKRYXQ12D3kb9thWdy6g6fKGniEoYFfjLlOUbMU8LwKO0erxy+5a/SavlUY/R80O2
	 c0IdT5oZr8rrggcR28hKzntxxS7xWyfA0AwOfs2nib1aZ15YHR5AV4jS/bG1CeHvyz
	 9QB0V9YOgnDkw==
Date: Fri, 20 Mar 2026 17:35:01 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@google.com>
Subject: Re: [PATCH net] rtnetlink: fix leak of SRCU struct in
 rtnl_link_register
Message-ID: <20260320173501.5f9adee0@kernel.org>
In-Reply-To: <abz1_nbd2ep-RL6Q@krikkit>
References: <5ed5489ecdd05c43bd551804f3bd020ae349f3ca.1773849195.git.sd@queasysnail.net>
	<20260319170541.27c75eac@kernel.org>
	<abz1_nbd2ep-RL6Q@krikkit>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 20 Mar 2026 08:23:42 +0100 Sabrina Dubroca wrote:
> 2026-03-19, 17:05:41 -0700, Jakub Kicinski wrote:
> > On Wed, 18 Mar 2026 17:15:15 +0100 Sabrina Dubroca wrote:  
> > >  	list_add_tail_rcu(&ops->list, &link_ops);
> > >  unlock:
> > > +	if (err)
> > > +		cleanup_srcu_struct(&ops->srcu);
> > > +
> > >  	mutex_unlock(&link_ops_mutex);  
> > 
> > Does the cleanup have to be under the lock?  
> 
> Right. I'll send a v2.

SG, I'll mark this as Changes Requested then.

> (OTOH I don't think we'll ever have to worry about contention on this
> lock, but we've probably said that about many locks in the past)

Right. I'm not sure why I feel this way but the way the condition is
placed makes it read to me as if being under the lock was important :S
