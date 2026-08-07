Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E36C376A12
	for <netdev@vger.kernel.org>; Fri,  7 Aug 2026 14:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786111953; cv=none; b=LrqKswUy+y5sQsaei+UM6nWNOFXPV6Ya8UmKec2USiO6KJ9u8+oUty/T+8iBAdNWRBUJvMNEnnkqXQ8rU+WKMN5lSa9FzbiBxW7j3ia6/Mho5HkXRfhM6JovWuq8PCd7b5W++xKWUyq/tohIuJictXQPxdbLcCvrYFei4k+BnK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786111953; c=relaxed/simple;
	bh=A24xMRWL41Y0AFDnatSHReoFJz254rfaKzsY96sxewU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=loAKGarA/nzZDZeVye+jzBCuK0BMmHs5Kaysm1nv1jLG3ooSXXYklAtjnND0BIgR71RAMDNGQmB9yepGuh9y1YivBtLUP2/sbCz2j/kDegfZmJ2SRDMH5DGpRlVvt82m1/gsxdGsIgZtpg04/w6PhIMGB8zLIfFeqJOl3mzpWcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DoFpb+Tf; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DoFpb+Tf"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-2cc7ef7ec27so42740595ad.1
        for <netdev@vger.kernel.org>; Fri, 07 Aug 2026 07:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786111950; x=1786716750; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GKZudACgBc9Y4gkvs8Hu0dK6LGZq7Zb4IZKS1KUbl50=;
        b=DoFpb+TfzGEg8lFiyG7T2DrNsM6yRGfXS6JtihtqPLoaN8y2RKEc0WsNz5yfZc9YV7
         4mCRB79U4VVscO76sYWw2lIDU9N4NRvG9zgCiqiSGOIIJt0lBuAQkUaP2FtGYA+Vpeqt
         Yx0AZLimZATWzF2L9edR7BFmJD3HHhW55Bcd/8X9zDzZpIwBj9qKjaAhVKk6QiWrPjIt
         5wswPhlrdO3Db7f6NeAFhwMpgr+gPRxxQg9wL+Ax4+nI4DdGqC0CyiI2YiK7en6nu3W5
         vQ8yztL2E2P7NSvJE4FkEPm4psLIZPObj6H13Yv+hgm4KEEBkQCq0a45xgMB/73KSxtk
         xJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786111950; x=1786716750;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GKZudACgBc9Y4gkvs8Hu0dK6LGZq7Zb4IZKS1KUbl50=;
        b=Sp49rqWNXywc6t3W6DuyQrS5K8N4up8NZYtXedTXPMo3U9vJlmW6ymAUCJLNg6Xedn
         UjRu0wCuMDFGSwJJ419NnCaPMHNPLL5iQJH//UQR1DEvVw7cQemOnhUVHd9bQU4PkIKD
         XncctUml5xpIPsGK6nj3g429vJMlmbQ1K0z1CBQARlitsVk5emlCtzmBBCdQc+0S1GVO
         fYBAbkDmcuGou7ZRHPbbZ6xJ/qbpiKaVTIF+E5JGn44FueIi2M82VxI6zx25j1FtjGuX
         bOwRHakfBOgweMD7oJjz43Q12Zx76ySy0oI8BuDG98dQYqgjqqPvw3J29TnWJL5BKvL9
         itow==
X-Forwarded-Encrypted: i=1; AHgh+RqtipJ1b9zpY6YA589N0wFdxE66OScOcH+M3MtO8C5Fs3kXUlg4PqoAVIdxOVaAL1xM/e2982A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3A3qXb3yI2CQVdNuBxXmTpxmFOBuZYUc2XF1fKexNcpBcMAsY
	JP8mjcygyuYFqdFmgYkYbu70amaQjneEFLshYfzEjt3cfHjyzqCuCtTu
X-Gm-Gg: AR+sD110Zv3qID3Yp2g5LbAfgU8vGiS0cvcwNzb5tVlwsyAcq4lm3mwio5NaxlqqqZ/
	OmuNQRMj8SkeumKAWWzIHWYbxiu23apamuHUjF1DGH0cDgRR0M20rejjHpNwQfJyV3qBZGTv0HY
	Nf0Gfy/pbtqlUOmbblrhp/SxnXDa4yzsyGPauLz4fjYPOUeCI/g3RAfm+uAMKFarAynjruip4wk
	hOsLXFOprkoknUnyQGcJ3aQaiDnfjRonZEjtpSapNg/+qAq3Vl3IW5K7CQ9GybRM/Iv5cWW58oF
	Dh5Mr5q2PtEOzHqmBVAmwUR5fFDirXzEZBPs3b7GeAp6Cmjilgo077gmHfovLLJiUp+8Cg5eUk1
	/etyT6k8KS14lsLlCfqdr+o+2lnEbF/yFRwT6jUoAWPCIiqqWQVVTe7FAn+E1qMV08AyM1zcuHk
	5ud8YtJgYLufSkdZkbi67GW0CEwpriHEb103ZRL/07h+pMzivvOndzvnsx9rhsMbT0UA==
X-Received: by 2002:a17:903:32d2:b0:2ce:e75f:b713 with SMTP id d9443c01a7336-2d2a8fdfffdmr10133375ad.23.1786111949775;
        Fri, 07 Aug 2026 07:12:29 -0700 (PDT)
Received: from fedora ([203.175.12.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d14ccd8032sm9949845ad.23.2026.08.07.07.12.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 07:12:29 -0700 (PDT)
Date: Fri, 7 Aug 2026 22:12:22 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Felix Maurer <fmaurer@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Lukasz Majewski <lukma@denx.de>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Hangbin Liu <liuhangbin@kylinos.cn>,
	syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com,
	Xin Xie <xiexinet@gmail.com>
Subject: Re: [PATCH net] hsr: Avoid holding seqnr_lock while transmitting
 packets
Message-ID: <anXnxn-PBv8qH6VB@fedora>
References: <20260805-hsr_deadlock-v1-1-d8a6f06fc5a8@kylinos.cn>
 <20260807094325.GG51943@horms.kernel.org>
 <anXStphPD0z-ystm@fedora>
 <anXatDPkcVsCTB36@thinkpad>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <anXatDPkcVsCTB36@thinkpad>

On Fri, Aug 07, 2026 at 03:16:36PM +0200, Felix Maurer wrote:
> Hi Hangbin, hi Simon,
> 
> On Fri, Aug 07, 2026 at 08:42:30PM +0800, Hangbin Liu wrote:
> > Hi Simon,
> > On Fri, Aug 07, 2026 at 10:43:25AM +0100, Simon Horman wrote:
> > [ ... ]
> > > Simon says:
> > >
> > > I don't think the advice on how to annotate this is correct
> > >
> > > Tags trump freeform text, but Depends-on is a not a standard tag and as
> > > such should not be used.
> > >
> > > I believe that the correct approach would be a tag like this:
> > >
> > >   Cc: <stable@vger.kernel.org> # aae9d6b616b5: hsr: Implement more robust duplicate discard for HSR
> > >
> > > Link: https://docs.kernel.org/process/stable-kernel-rules.html#option-1
> >
> > Thanks, I will update with this.
> 
> Thank you for the patch! Just to let you know, there is a patch
> addressing the same thing in an in-flight patchset [1]. Unfortunately, I
> didn't have a lot of time to review in the last weeks, so I'll just
> leave this note here so you can coordinate if necessary :)
> 
> Thanks,
>    Felix
> 
> 
> [1]: https://lore.kernel.org/netdev/20260803222211.877-3-xiexinet@gmail.com/
> 

Oh, interesting. I just came back to work this week and found this issue
when reviewing the syzbot bug list. Since Xie Xin has worked on this,
let's drop my patch and fix it in his patch set.

Cheers
Hangbin
