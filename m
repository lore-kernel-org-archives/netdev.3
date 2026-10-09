Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C4B7499F05
	for <netdev@vger.kernel.org>; Fri,  9 Oct 2026 10:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791542126; cv=none; b=hVznSpZHLYQUE6wOaCSeRX6R8YIfrxoajuPZZAqIeDguV4EiV3hvJ3zIexxUIK+yTu/hFugv/sYMIOsnklZQGVX11C3xekH+gAv4OHKIW9MkTK23oMP75gPRrraDFIgr/YbPL72TXyQUq8BY3dbS3a6i0Klm6JIE5ghrLTIeHjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791542126; c=relaxed/simple;
	bh=0TRLS1j67EED53OgXj1cb2Q5pbeNZCctOniaBE6ns3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MyVeFlebZEqjubepCEr3IdZmWlsniQv1s0HDuc7JdaH5UXc+9z/q25CBU5FEg+RB2JoYptFA8qaTMQTVt1CoG1OuzldzonAaAVQE4DdO/3KmX9Qo19OaHwXuIabzPXtTC1oLB6swqpPjZWwwpqp3GMrb9C8TPL1jggMbmKPA63s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Yuxz/crK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Yuxz/crK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C73631F000FF;
	Fri,  9 Oct 2026 10:35:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791542125;
	bh=GYqzy9N4ABK8SnejUCtzrnU99rpVUBuw/ELsYfmJ6vM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yuxz/crKkrs85FWriVqFsZxbdxfDJPhHy0ZPV/+LWggv1unNojnvfyN5SQBHLUiJQ
	 MPe3uMQqhzMi0t0Ckz/uF7iOOkdFGLUvXkKXMiNz1CRFPQ2NjnkUsAFQBKLYvzyj6I
	 sdQ3KWbAlgmT1GndL7Q0HMmS9dyW13T02qX9fHgq8YWNRE0YeW7wf/04EOpQugYinW
	 OaGiEQLdG4fBB71omflaHbfcD9YUTie7O9ddVpOYgqUvLH9sAfZ9TeWCppwQoF9Xsp
	 QEbCNirpoKoG7nMp2F1doVW1H8ERdUky65+9fyQDgfZ8GB97EM1FqvAwf1KXW5Mo8n
	 9w9l+822fsPYQ==
Date: Fri, 9 Oct 2026 11:35:21 +0100
From: Simon Horman <horms@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Victor Nogueira <victor@mojatatu.com>,
	Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	moeller0@gmx.de, cake@lists.bufferbloat.net,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH net-next v4] net/sched: cap the accounted backlog before
 it can wrap
Message-ID: <20261009103521.GX83879@horms.kernel.org>
References: <QDISC-BA27.v4.20261001193440@mojatatu.com>
 <20261006153043.GM83879@horms.kernel.org>
 <CAM0EoMk=RKMafa0tCUmcjFvm3_f=wGZoNAoy8q=i_r8zR2x_6w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM0EoMk=RKMafa0tCUmcjFvm3_f=wGZoNAoy8q=i_r8zR2x_6w@mail.gmail.com>

On Wed, Oct 07, 2026 at 06:13:52AM -0400, Jamal Hadi Salim wrote:
> On Tue, Oct 6, 2026 at 11:30 AM Simon Horman <horms@kernel.org> wrote:
> >
> > On Fri, Oct 02, 2026 at 03:44:31AM -0400, Jamal Hadi Salim wrote:
> >
> > ...
> >
> > > diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
> >
> > ...
> >
> > > @@ -1712,18 +1738,24 @@ static struct cake_tin_data *cake_select_tin(struct Qdisc *sch,
> > >       return &qd->tins[tin];
> > >  }
> > >
> > > -static u32 cake_classify(struct Qdisc *sch, struct cake_tin_data **t,
> > > -                      struct sk_buff *skb, int flow_mode, int *qerr)
> > > +/* Run the optional external classifier. Returns true when the packet was
> > > + * consumed by a terminal TC action (reason in *qerr); else *flow/*host
> >
> > FYI:
> >
> > W=1 builds complain that the line above has a '/*' embedded in a comment.
> > This is likely why Sashiko NIPA didn't run for this series.
> 
> Thanks for catching this Simon. We don't run W=1 - already overwhelmed
> as it is with the flood. Do you think we should?

Yes.

It's important that patches don't add new warnings.
You can use some sort of diff mechanism to spot those amongst any noise.
