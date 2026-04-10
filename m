Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3643A75B6;
	Fri, 10 Apr 2026 21:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775858090; cv=none; b=jnNj/9Du1reBzaOKXnn66uIi/hwDWA58q2gHPyiNRxaRiQ+4QBBX9ky8txObpDgdHb4Si14RJanISPUhlK1sHd6CHgiYMtTU3rGLhhjFAt8Yv1AFwH2Wco3exnIFHRIvnlGVexg9p2AtCmVWejIgJKa6n8cUDhnD2lWicMg2ycs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775858090; c=relaxed/simple;
	bh=X5q6z5H3y9WtQ8e9BvApszu5+3oTNauKE1NviLWyRx0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ME38Nc6TUOcczf/fqra5AbqS/OVcae0qG+nx9JZO7vvMpaHMrewxA7m+kqgn2xuifpvLEXxtSp2bBjQVonhqziY0m/KzmFuIJgikKpq8jk+NY2Pc16s+rluJnu5DbLd8oSaFm5a8iz1wl3evCST07ofD7xowBTeD2/z5fF2FypM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDZagmWG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDZagmWG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B6CC19421;
	Fri, 10 Apr 2026 21:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775858090;
	bh=X5q6z5H3y9WtQ8e9BvApszu5+3oTNauKE1NviLWyRx0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UDZagmWGncye94QHcmv5bn8sAWZonPeQYtjrep0KwwC6BnmbtGGBHgCGWCmKHySjq
	 yTBEO/wIMegET6YOOxPWUWz3uK5txFaOPE2ZSb4VR/xBGH75T+4s4/JqAJHe4Y3OJO
	 uEQKwASj4bZcEKp8Jut1YtN3aMSTzUGBQdHee5YKsPX6nrnUQaQjU3v9L4Nv99KToM
	 POdDTWdkrcIVCFcz6052ioGnx1ccepJ6hKxJlKC1Wsi1PZZc1sPtaAwfI+H1lwfNrg
	 VnBYFAkp6K9sDKkwv31i+KgXiC1WB+5BgUks+G09T+8kvFoKKC9RQ6fwvTn7iKuktX
	 uY3NRKSMv4LHg==
Date: Fri, 10 Apr 2026 14:54:48 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 linux-hams@vger.kernel.org, Yizhe Zhuang <yizhe@darknavy.com>, stable
 <stable@kernel.org>, workflows@vger.kernel.org
Subject: Re: [PATCH net] netrom: do some basic forms of validation on
 incoming frames
Message-ID: <20260410145448.38253e3c@kernel.org>
In-Reply-To: <20260410143042.1d4436de@kernel.org>
References: <2026040730-untagged-groin-bbb7@gregkh>
	<20260409190328.GS469338@kernel.org>
	<20260409203235.6b9329f0@kernel.org>
	<2026041026-excuse-slashing-c4ee@gregkh>
	<20260410143042.1d4436de@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 10 Apr 2026 14:30:42 -0700 Jakub Kicinski wrote:
> On Fri, 10 Apr 2026 07:24:36 +0200 Greg Kroah-Hartman wrote:
> > On Thu, Apr 09, 2026 at 08:32:35PM -0700, Jakub Kicinski wrote:  
> > > Or for simplicity we could also be testing against skb_headlen()
> > > since we don't expect any legit non-linear frames here? Dunno.    
> > 
> > I'll be glad to change this either way, your call.  Given that this is
> > an obsolete protocol that seems to only be a target for drive-by fuzzers
> > to attack, whatever the simplest thing to do to quiet them up I'll be
> > glad to implement.
> > 
> > Or can we just delete this stuff entirely?  :)  
> 
> Yes.
> 
> My thinking is to delete hamradio, nfc, atm, caif.. [more to come]
> Create GH repos which provide them as OOT modules.
> Hopefully we can convince any existing users to switch to that.
> 
> The only thing stopping me is the concern that this is just the softest
> target and the LLMs will find something else to focus on which we can't
> delete. I suspect any PCIe driver can be flooded with "aren't you
> trusting the HW to provide valid responses here?" bullshit.
> 
> But hey, let's try. I'll post a patch nuking all of hamradio later
> today.

Well, either we "expunge" this code to OOT repos, or we mark it 
as broken and tell everyone that we don't take security fixes
for anything that depends on BROKEN. I'd personally rather expunge.

cc: workflows, we can't be the only ones still nursing Linux 2.2 code
