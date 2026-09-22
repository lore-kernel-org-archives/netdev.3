Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7119D3385AC
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 00:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790037756; cv=none; b=L6iwdefd83eirS13O1iK0QiAl8evoNW8yoJ+NcbA9qpX9knKgsVH/t3PP1S611+3DOJczX2bWPVU+aOpNd4vQmYPUJ68vQzrUnN1sQjVoI/4m3Lu18DeV/sWIoNiWWtxQ6JDgCGOblk4OatAhFohP2FF0h5B5/vl5qWlRqJZ258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790037756; c=relaxed/simple;
	bh=UC+u28CzOknk6Bl7uM1FB1PHcM9TThDpGwcLmDudxdo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mRBkV5C70FpaqEjXUlJf/KfjaXm81l6LjzKc5K4fnS1O8IX0arvIFCpPBPMl/VqvSxSZjbpyj+UKLNiF7TV1a5COz8Fv60r3z2cbQQDAlDwWm94dgIvcFHXKlAtWS46gjamVvvIOP7RG7fEr8e/+ldGKltPHImxxn1vMCOjn7+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z6Kki+37; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z6Kki+37"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc5256c2a4bso2415937a12.1
        for <netdev@vger.kernel.org>; Mon, 21 Sep 2026 17:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790037755; x=1790642555; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2fzEHL3uGZbVafqnyo5a33w4pQPCPZyrCo11bWJZYaQ=;
        b=Z6Kki+37+A40nlmMETK9hMq9rb7I1FUBttJ6hjzzRIgFu20p75+ZNRPaYTjqOuIJa8
         32htA9hQEEfUoVKqZCYMiAiWwirBrGvLkelIqZH8A12Scp3Ukv2sk1QnGPQt13tAr9gl
         rGLN1sL+kOcoYReQXw3QV8S+7yucL6hckS27nHipNGzBtALYHNAdScNBZzX6Zv3IpYcq
         3WiJbdbiYhCoUAY1KwJ0xDhgc0O6D3SI2Pm2JOONpUULhtIU67SvLIx685Loh00mSRh3
         WxT2Eupfz2uLurCBE7ha33gYvO5OJ7rMX3We639XwwX/2hcGSjzcyZY4pyUMaygR9QlD
         utPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790037755; x=1790642555;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2fzEHL3uGZbVafqnyo5a33w4pQPCPZyrCo11bWJZYaQ=;
        b=OaNFtbQGdmaiNLEiIIJZ3EiS12rN9t9lIMmcOxdlkcLUzrxiAJ1WIGrMPFPv0Ae8dj
         LUFAGfkfiMMXGFPFCDYpTi6Hdg1Zt0qp1T9XgfPmBOtU0099JbfMQXeT/YLKIKLqrQBV
         7B2TCSQd5BlOy5yFocPlImBeLfInrerx10LTK8RfnPhOeptr4RjUUMTI2bPp1YWKFvz1
         tvll+Af06evaOALF2gnkTvUdNRphKJjl5KFtItBteAvmRmAY9306r5r2M0gS8wugMPCw
         rw4Ckhw+iYufze+iNkI6iALAMUOE7IKPZTkUNhI+oeR5fK71c7eMn/zTggbUWF4ERn1T
         V+BQ==
X-Forwarded-Encrypted: i=1; AKwUvBz4iQP9ov0f5B3MpaiD/sv+OG2P7K3AO8JzHKeIUU+ZB4acCY3dvf1/I3EXH4jbmzmqMHQPTtc=@vger.kernel.org
X-Gm-Message-State: AFuF++kAELUsQLaEOW7ch/ePZhbIrrW/Q9RXhdYJ5h1PZ0OmZgEVSmd5
	XVto4mVYHyuF4Jmgc98n9ftLnJ7jJyS/NzxAAc+4hWCUIx6v+7+t2YMz
X-Gm-Gg: AYBFou3tSK8GLFljoR3Yr+bCIEbTmUSb9EET/9aG4Uw5miIojwxgHffhLBI8LXbmvV1
	bwzpFbzYXCmy+rSQ3NeP2z1oq7ioaahIqZlulN7St8LqBJ0aO02/FF8tmbWSVxfnvx0n0Kecikn
	QmAvAobEZhlr8cNnUylW//tJ8voImZ3nj5EZ9Hogfh15NvCVzC6KpoTJv4AJ6ax64L92xKe/jGh
	/kYmi1rvFdphph6ENoHGEYqkEDnx5A1d45m7tWOYsvr3WnHAkaEss/1hCZbN+1n0pX/JHO6xhtP
	/76lqZJjE02MPqQ9guRtZCjiQmzjCVW7cgiYSQ7WrWpoYiFf9F/BmwjJJT+Z4OerKBdRn8PwWRT
	ntLX5han3Nj17ISWDKAMMmG12UVuQqSHeyl4y7Pn/VHrzLpVIrAEgUQ5yoEYOJsLfSl1NBAtwXk
	5PUqWQm85M/ZsatikXO/mzFMUUV9wqBP9raQh3WxbMFdyIOTT+YWwt4P3DG13AMtcXT9hI2cNfQ
	zN4fVpDoJFRxv+i1Q==
X-Received: by 2002:a05:6a20:6f04:b0:3dd:a195:fa15 with SMTP id adf61e73a8af0-3dda195fd21mr13316377637.58.1790037754689;
        Mon, 21 Sep 2026 17:42:34 -0700 (PDT)
Received: from v4bel ([58.123.110.97])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc756a18d4fsm18626a12.11.2026.09.21.17.42.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 17:42:33 -0700 (PDT)
Date: Tue, 22 Sep 2026 09:42:28 +0900
From: Hyunwoo Kim <imv4bel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	Neal Cardwell <ncardwell@google.com>,
	Willem de Bruijn <willemb@google.com>,
	David Ahern <dsahern@kernel.org>, Ido Schimmel <idosch@nvidia.com>,
	Simon Horman <horms@kernel.org>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org,
	stable@vger.kernel.org, imv4bel@gmail.com
Subject: Re: [PATCH v1 net-next 0/2] net: Disallow buggy TCP transitions and
 IPV6_ADDRFORM.
Message-ID: <arHO9Pk2DBzVOTLV@v4bel>
References: <20260904033543.2635540-1-kuniyu@google.com>
 <aq28mdNpi3ssjgXz@v4bel>
 <20260919142035.4d0e11a8@kernel.org>
 <2026092048-splashed-trespass-d2da@gregkh>
 <20260921102310.49c9e008@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921102310.49c9e008@kernel.org>

On Mon, Sep 21, 2026 at 10:23:10AM -0700, Jakub Kicinski wrote:
> On Sun, 20 Sep 2026 09:45:14 +0200 Greg Kroah-Hartman wrote:
> > On Sat, Sep 19, 2026 at 02:20:35PM -0700, Jakub Kicinski wrote:
> > > On Sat, 19 Sep 2026 07:35:05 +0900 Hyunwoo Kim wrote:  
> > > > What is the plan for stable backports here? Does the uapi change rule
> > > > this series out for stable?  
> > > 
> > > Not super well defined to be completely honest.
> > > My gut feeling is that we should wait for it to reach Linus, and ~rc3
> > > then pull it to LTS. Which would mean 2 months from now (mid Nov).  
> > 
> > Once it's in a released -rc, why not have it backported then?  Why wait?  :)
> 
> To be clear - it's in -next right now.
> 
> > > That said, I am personally pretty unbothered about local exploits.
> > > There's too many of them. And because of the serious exploits
> > > (remote, VM escape etc) I think people are not deploying stable
> > > much more rapidly and with less testing. I don't want to inject 
> > > a de-feature under such condition.
> > > 
> > > Adding Greg and stable in case they have a stronger stomach.  
> > 
> > I like to see the stable trees match Linus's whenever possible,
> > especially when we have known bugfixes.
> > 
> > > Also FWIW I believe that Eric D is AFK at the moment, and he's the only
> > > netdev maintainer subscribed to security@, AFAIU, so y'all may be aware
> > > of more things than I am...  
> > 
> > Not any more aware of anything other than the normal flood of crud...
> 
> Okay then, I think we should just wait for the merge window,
> and reevaluate if^w as new bugs show up.
> 
> Hyunwoo, if you have bugs in the queue that are solved in -next
> I'd hold off on sending the fixes unless they can be triggered
> remotely or from a VM.

OK, will do.


Best regards,
Hyunwoo Kim
