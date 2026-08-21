Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64D5F4334B0
	for <netdev@vger.kernel.org>; Fri, 21 Aug 2026 23:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355023; cv=none; b=iqP5NSozBmapysDF1+fGeeoGnlJb8gw+hPR5Uv1h8IKPBgtCjTybaDYOAkoqVWg1VHsnFCmYtAk8zc8Nd3TArlgmlq6tRZXZ5DnzNppe67m5BGLodh4RiJlJSB4DAARrStaGamX1sBLHLolLOpCzZPpNjG2SAtQnjYZAjA4E+F4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355023; c=relaxed/simple;
	bh=ABbydjIemtazQDSlVhqA6jJhx8Mkv5TPwUtBqes/IWA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ebk8BBBn63jzqgrNQlgbaIqNE5rTJo8G5dCRhyQnfscwgFohoC51KIvHqYRT+Fl4/Jfz7goMh+85SHfNCbiIQ5BINTQjhx8GJDUUjh4elY8aNZ7YOJ3kESV8PPd6osJKJ1/jJKjFeYuY53eHY/qwsn9rbhngK2DGCvzUQMGuB/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SiRkWCjr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SiRkWCjr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A91131F000E9;
	Fri, 21 Aug 2026 23:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787355021;
	bh=nPqaZl8GDOtgTuIcCqRNYTfg7NHyjK/XKUn6iAJrW0A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=SiRkWCjra8+B3T1luZ87OI6ccMdoD3C/Db0wTS7RmVR28ecnZxZqc+Tfk1XvJ8SSj
	 mA5rU4IE0NalE3radGhemsFUG0csLC7csr0R6Zt+9wk449KxliwMT69TBLUdSIfQzV
	 iZSADtP29ZWRZLpkhy+tQxkBOD5oC5jPX2uPIgQa1gBYQpSRv17FzDf1uHhEeSGhhy
	 qNS5NZIXJQ939M+iFxMUCU/uM444ioMfDsz6AdvGmTi3zDH/W5Yk1mKHT0duYK9B4Z
	 vDxqnY2hfjVarL1+fis1eCPUu70KHjHQiK8G++I2LK2G2OfZzFevK6dg6yf6fIikpK
	 qVPdFMT2G/XqQ==
Date: Fri, 21 Aug 2026 16:30:20 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: victor@mojatatu.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, jiri@resnulli.us, horms@kernel.org, bestswngs@gmail.com,
 netdev@vger.kernel.org
Subject: Re: [PATCH net] net/sched: sch_teql: restore skb->dev on the slave
 failure path
Message-ID: <20260821163020.41d2d5bb@kernel.org>
In-Reply-To: <CAM0EoMmXhqmuSkLCS1hXczFK4GZtQR2Gy1YZ5Vx2wfqCD87PDA@mail.gmail.com>
References: <20260807133155.1242599-1-victor@mojatatu.com>
	<20260811001150.1034738-1-kuba@kernel.org>
	<CAM0EoMmXhqmuSkLCS1hXczFK4GZtQR2Gy1YZ5Vx2wfqCD87PDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 21 Aug 2026 12:04:12 -0400 Jamal Hadi Salim wrote:
> > This is an AI-generated review of your patch. The human sending this
> > email has considered the AI review valid, or at least plausible.
> > ---
> > net/sched: sch_teql: restore skb->dev on the slave failure path
> >
> > teql_master_xmit() used to leave skb->dev pointing at a slave after that
> > slave's ndo_start_xmit() failed, so the skb could end up queued on a later
> > slave's neighbour arp_queue while referring to the earlier slave.  The
> > patch restores skb->dev to the master device at the end of each slave
> > iteration.
> >  
> 
> Let's please apply this patch. The patch correctly fixes the reported
> UAF (namespace-reachable, slave deleted while skb queued on another
> slave's neighbour).

It's way too old now, just repost if you think it's good as is.
