Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C4237A822
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 18:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482620; cv=none; b=oQ1TaBscMFVbZt4hgs6HA8AjFEqqrgWiqL1KM8MFZeDIB8awy06Po+NR1DehOuU6C++cBHIOSVuhhWsScUwOO+C+Ho68bivs1cYsy52g9au7gdg/lO+99ACwHANygF2Y3lnjPknxDwDsnXtqGfXR3JrJujhVOFr/8kc4XC0cl4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482620; c=relaxed/simple;
	bh=RZt9QAQENB7zZUZpYhZ2vcQnqjSDXFidqXnP7OXSTr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P8BTePfFzdVUVylbuk5ABUhGPtmgGwbDi8lp4oTFP8jQ6gU8gJbHDe6YihgfI1qc622K03PhZXmQE6DBeN4hn2g+/TjijhOV4iTVRC88iFmbHF0RB33PnlW2cHjXBhtk/rfKg2/QHXIJ9h2tHPXCSnl+95aT8JJ6efr70QK2KGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu; spf=fail smtp.mailfrom=g.harvard.edu; dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b=rfua3F+Q; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=rowland.harvard.edu
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=g.harvard.edu
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rowland.harvard.edu header.i=@rowland.harvard.edu header.b="rfua3F+Q"
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-533778ab0bdso34921331cf.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 11:03:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rowland.harvard.edu; s=google; t=1791482618; x=1792087418; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=K4Aor886ezFBw+XHcIPSZWt3mTP6dg1JDi34/oYIQ1M=;
        b=rfua3F+QaCeTUKlJ1/30Y5D0U/CUTEKWNdKp+8zsgZK6Sj7DZo6gRq+g3itBkmxQQg
         RcdsKLJJF4dRPXHIDbKYlGGolmLwcPvQWCK3FiX4/WdEADvrN4C92Pr2gdzHtufdKMDI
         qA0a04cRv2rU1utpbmq6mmsC8drnt7UBuM/1cLMIxcXdJrCzR3L5N560tTeKI5tycrMe
         zMSR2FPCt/tCzk9psFhyO4/5oDiSYWQpjeAUh+tlADz6CCGU7Ksw52OY8S6P/dP27tR0
         fVzwKFXsXOxL3Z6D7DmrsQ7ap7E1/jHoc4Qkro00RSddd2GWRIq2H7Dn4rsmPBI/+WBf
         ASpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791482618; x=1792087418;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=K4Aor886ezFBw+XHcIPSZWt3mTP6dg1JDi34/oYIQ1M=;
        b=lqndjQj0OoyMxTMa8ia99HqVuQoIaokV/kyO965wxTEYoIggpn+frDdlKWDkzRbzKG
         vE1aSiwLZHGIMVupXMn5OEpuVTBUeaYAiLI206mt3r+jHzO0sLfs/V3cRc0tfDgJPyoW
         4/39op0avP1mBvNfN9KvQaxd1B26yfcffqxMuUyCbN1vNzTTyvLhPBPz5DCgTlAXoSqm
         UjEY1WaEXr0UBpSKmLPK6JdfSamBrcD4TnsCJExA0hJipiaVeqkCv2q7p7Jypq9lMQ+s
         TMPQxb/AMUirsWHOR4J1Yspli5PdHpORVqqkLciyzjUNS7aoiHc0fWWn2GTfOxzxCpYi
         NWbg==
X-Forwarded-Encrypted: i=1; AKwUvBw4ICtCEYdDwQRvC8IJCUpAC9ZMTTVrt7tUA5mcRRvX4n3kINk6g/Gqb1JXrpnTQ63R4tvDvo0=@vger.kernel.org
X-Gm-Message-State: AFuF++mRdkafD+1xGs1WucrLCu3hke2nU3XVh0ILMOmrT0kk6cSzCWhc
	T0SNoxgzRKmgljSDZhPVlGo9nQCsjZG2UyRZtZU79R+GEaIjl/kM96m7n1dWL4kbOQ==
X-Gm-Gg: AYBFou3W7k1PsKxhT70DpNET41yVdX675JqFNPDgvpPo6veawav8j9N4wkTZAJb5MQD
	Mz5H7s+cXSPMAxJTwA1GKbl2jHGkZvdqIdDaPpYYI5k1lw2sp6yjydMS0EXWwV4sUma1BvT4E//
	KILc6CDF3spbeJI1Wkw1ApxIWzpXuWxIoWB5detCCBedJgTVKFIWhAjpV9h2IJlFLyBSxvDOd1H
	QE2bYMuM4QSGnWaTq+xDhSf/WhgXl00buiyfM7VeQrVWcj9hC1dx5KO5hszh5TXpbL3r0DjzH4m
	/NMxSprr8QSc/9stsxvmNo5SzRmPIngB43OFZ0khXrlqySQTHONsBMsA7/thMHiNL7NCgRc49ng
	fC/I+rBzghkq6NasSw5nk4r16mDf9IABStxnBoXTKGwnqOmBwKsW5ZGdK+nw7IDRp+c7WWJVGCv
	GW2j4p2wdM4PhOOn6myEd7G3O0gRPy/EtVQltlgfYLFcdz6U3s0lz/N7qTNhSwQ9DqUZRXWLyox
	Ky4COdDX3ttoGlawrN2a9WwG+3WYATf9DBlEi4KPg==
X-Received: by 2002:ac8:5e12:0:b0:535:163d:ad2c with SMTP id d75a77b69052e-5357515d0b7mr111442881cf.5.1791482617847;
        Thu, 08 Oct 2026 11:03:37 -0700 (PDT)
Received: from rowland.harvard.edu ([2607:fb60:1011:2006:2008:aeb7:73d7:d8ff])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91b5199d84csm2476586d6.5.2026.10.08.11.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Oct 2026 11:03:37 -0700 (PDT)
Date: Thu, 8 Oct 2026 14:03:34 -0400
From: Alan Stern <stern@rowland.harvard.edu>
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?iso-8859-1?Q?=D6mer?= Mete Kaya <omermetekaya0@gmail.com>,
	oneukum@suse.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	netdev@vger.kernel.org, andrew+netdev@lunn.ch, davem@davemloft.net,
	edumazet@google.com, pabeni@redhat.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, david.laight.linux@gmail.com,
	syzbot+04cd90bb99c6ef81a65d@syzkaller.appspotmail.com
Subject: Re: [PATCH net v6] usbnet: fix smp_processor_id() use in preemptible
 context
Message-ID: <06a81ea1-b17d-40bd-82d9-922de946b86f@rowland.harvard.edu>
References: <20261004215937.302247-1-omermetekaya0@gmail.com>
 <20261007200049.079aeb75@kernel.org>
 <7c4a2f1c-f16d-479b-a11f-cef962d5e2c7@rowland.harvard.edu>
 <20261008094338.301a75fa@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008094338.301a75fa@kernel.org>

On Thu, Oct 08, 2026 at 09:43:38AM -0700, Jakub Kicinski wrote:
> On Thu, 8 Oct 2026 10:16:02 -0400 Alan Stern wrote:
> > > This looks odd, how did we miss this for 8 years.
> > > 
> > > Greg is probably busy, but would be good to get a confirmation
> > > from either him or some other USB expert that the callbacks
> > > can indeed be called in process context.  
> > 
> > They can be called in BH context with interrupts enabled.  Is that close 
> > enough?
> 
> BH should be fine on !RT. The patch, AFAIU, is because vhci calls
> the completion callbacks in pure, unadulterated process context.
> I'm trying to figure out how urgent the fix is, basically.
> If it's a vhci bug then the usbnet fix is at most an RT problem.
> Also if vhci is doing something wrong we don't want a truckload
> of slop patches sent our way to fix 300 drivers :S

As far as I am aware, there aren't really any guarantees on the 
context of a USB URB-completion callback.  The kerneldoc for struct urb 
in include/linux/usb.h says "The completion callback is made 
in_interrupt()", but that is most definitely out of date.

Drivers shouldn't rely on any particular context guarantees.  Not even 
whether local irqs are enabled/disabled.

Alan Stern
