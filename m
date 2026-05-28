Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BDB13164BA
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 05:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779946737; cv=none; b=R6eTkd0qhjWmRrJ7N+9UgL8DZAa4dePvMlIIDg7Pz/lsw0nl+04tZXVtPnGRXFqD3iiNGTNhqJtv7TYphK4RF869JjwXcslv43U08w6/yrEooEyaV602xwQ/jaIgtpPa7eHRF2LVUElUf3wHaUmaL/8Q8HcvFUzTOOdZrUsTdy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779946737; c=relaxed/simple;
	bh=KvtRzsXlR1IOIirGdws2OB068oH4Gsppr2ypsb1QcAc=;
	h=From:To:Cc:Subject:Message-ID:In-Reply-To:References:MIME-Version:
	 Content-Type:Date; b=QWh9z+jRYuOG0PhJzRAHZlRf+IhL1AHD6tCMznkh4l9HqgzAdPj1I9vkG1P9IkhXT9Lyjtj8bJSHGiD1asCViCrsdbuwhySSDR3HF+CeqrMbZ41VXFIM+EWybrC8/+WFb4fS48Kt6RyD73Nc3/D1q59PyTwEkQpyW88IlzXxuZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HwDKyL7m; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=lDyueXWo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HwDKyL7m";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="lDyueXWo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779946734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qIsFEeFjWD++dcOT8T6bFTLGCiYf/sLMfihPVw6P6Is=;
	b=HwDKyL7mC7q3RCcHXWP40rSYnnvUyLtFutuHm4kI7VeoA0hOdJAVU6eK+O2JZ263YSsh+y
	orjcN991swW38ACZ9IhYKQHvqYzwqDPfwS9TJWwQEx8Vx6HsJmm4vWHe+SwkGrUcVAHXT6
	QyMCRvsEOvaWol8TiPuBoRjIqNj8mTQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-hzcpg08FPSeo9Um84m3DLQ-1; Thu, 28 May 2026 01:38:53 -0400
X-MC-Unique: hzcpg08FPSeo9Um84m3DLQ-1
X-Mimecast-MFC-AGG-ID: hzcpg08FPSeo9Um84m3DLQ_1779946732
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-49081106196so13458755e9.1
        for <netdev@vger.kernel.org>; Wed, 27 May 2026 22:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779946732; x=1780551532; darn=vger.kernel.org;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qIsFEeFjWD++dcOT8T6bFTLGCiYf/sLMfihPVw6P6Is=;
        b=lDyueXWoMNV5S9Eh21HNx9k/cvrhqsxNasDlwsOZH8z2m8JGJrE+l7TzaTEN8+5989
         SmljA+g+oh5ZVyp3dnzXNgYwVYTeWRZG4opPLEnJqPvvFg5nLNyce1Ap9IHrWT3GKj9X
         4TPnofZRm4Nid0UCsv4syoFcn/17U9SWEqZAUxREq4P68Nk+IMqMkCF+7KU/f20VcRm9
         0rrDcbYXcjTXIimRJEiKsEFJVTU3UqMDQSoxpbot/EUlueJb0gmrGAClExJawREpiHxh
         nYvSQm3RlHiI9TrujsZS1EJZ4/S62zgeaaBBaHHEmep9ihnsUQURL777+MVSaZvE5wvf
         A/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779946732; x=1780551532;
        h=date:content-transfer-encoding:mime-version:organization:references
         :in-reply-to:message-id:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qIsFEeFjWD++dcOT8T6bFTLGCiYf/sLMfihPVw6P6Is=;
        b=GsQaNs7pCrBNDnvWb+xLchN3MiWDDisDmE/rXrDGlrfJT3hVT9TEyOeKfgZDx/PB7X
         /vka4iPKhKyy65MkvdV9ki8/e+phnuyRLGoB+fVMDdtCfgQuE/GQ69RDgh5rTkJBCwQb
         9p9+klpgPmr0i4mirqBjgHkQah5qeIQltcj05Eh6s3inq4+grRtohxkhLt9hxn1hgFt9
         PhJirWGkoGE9vVmvyjC0xqElWkEGVBgDz5ATtcMlUw6oj/a7bqimrkeFfjCCczLrKWoF
         mUXL6Yzy/iTWrEtgcVTC+9P2RDSK3GyPx4e9q9bu4ZXaqGgvQC9qyZRL0zdTqlGD6xZF
         mMXA==
X-Gm-Message-State: AOJu0YyANjRxLpb5lsQfxrtD5ubiy8ZInDrtpZ2SidZEvSL/y14/mNxU
	FlfMp20oW/SIDeGl9FG+nORrDT6NYEg14wgrkzVurWAAIwBnE+G1UOPNxwzrSOMg7rXiITCumSo
	MhhrTqU6A9xV7ktRfqtrmAlmXs3UE+r6QZYFDDbFpD3hbrDSOEpoOQJoAyg==
X-Gm-Gg: Acq92OGJhbUHO1luVTBAHwUj3NKnZrD7Hd7IWmT5a09au8Ssg2Qm25EzoUbA/hLjdWF
	lzMDRx3qEGRv5ttoVmsRKZ5pnfbkCMgMT9rPpTQrdSDoU5NTS4ZkpyK7kxiUz3yV31DVGhs5btw
	ek5e8uY1gdcHKNkzsEjotrzASU9jrow+vdTvPsKkoleOeRjBYm/GX/X3G2Gj4AaPCt+AWMkRFhU
	3w6xgq7BHmZVCsMBzB3TaKz7FmTZNXU3HljzikcBT0PC0IKVCID45I9641Be8h4QdJ1bo950O4b
	pEz+FiyrB5++hbw3z/Rinsu2FDiq3wnXvVpf6FRwYd9lWXUYaWnmNfkyIltXADqA29u8AnXntjF
	WghZMsrjPe6ajyO7TdrEsXskIQMgzh8DOSq6xF4hVdmp9jZ7ENPVhEdE3yDQA
X-Received: by 2002:a05:600c:4ecb:b0:490:44eb:c1e9 with SMTP id 5b1f17b1804b1-49044ebc303mr423541505e9.26.1779946731727;
        Wed, 27 May 2026 22:38:51 -0700 (PDT)
X-Received: by 2002:a05:600c:4ecb:b0:490:44eb:c1e9 with SMTP id 5b1f17b1804b1-49044ebc303mr423541105e9.26.1779946731274;
        Wed, 27 May 2026 22:38:51 -0700 (PDT)
Received: from maya.myfinge.rs (ifcgrfdd.trafficplex.cloud. [176.103.220.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49092a92594sm15768495e9.13.2026.05.27.22.38.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 22:38:50 -0700 (PDT)
From: Stefano Brivio <sbrivio@redhat.com>
To: Fernando Fernandez Mancera <fmancera@suse.de>, Jakub Kicinski
 <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Yumei Huang <yuhuang@redhat.com>, Ido Schimmel
 <idosch@idosch.org>, Justin Iurman <justin.iurman@gmail.com>, David Ahern
 <dsahern@kernel.org>, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Problem with IPv6 privacy addresses in 7.0
Message-ID: <20260528073849.759da84a@elisabeth>
In-Reply-To: <675083b4-e015-4ff3-836c-798e0a971194@suse.de>
References: <20260521135310.GC977@cmadams.net>
	<20260526175743.1f2c3761@kernel.org>
	<20260527010641.GA21073@cmadams.net>
	<20260526183122.348e44e7@kernel.org>
	<20260527215135.GB16443@cmadams.net>
	<675083b4-e015-4ff3-836c-798e0a971194@suse.de>
Organization: Red Hat
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.49; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Date: Thu, 28 May 2026 07:38:50 +0200 (CEST)

Hi Fernando, Jakub,

On Wed, 27 May 2026 23:59:47 +0200
Fernando Fernandez Mancera <fmancera@suse.de> wrote:

> On 5/27/26 11:51 PM, Chris Adams wrote:
> > Once upon a time, Jakub Kicinski <kuba@kernel.org> said:  
> >> On Tue, 26 May 2026 20:06:41 -0500 Chris Adams wrote:  
> >>>> Hi! Adding more people to CC. Do you know if you upgraded from 6.18
> >>>> or 6.19?  
> >>>
> >>> It was 6.19 to 7.0.
> >>>  
> >>>> Would you be able to try testing with some commits reverted?
> >>>> On a quick look the candidates would be:
> >>>>
> >>>> cb3de96eea66 ("ipv6: preserve insertion order for same-scope addresses")  
> >>>
> >>> It's this one.  
> >>
> >> Phew, the second one was mine :)
> >>  
> >>> I figured out that it happens after stopping a VM (and I usually
> >>> start/stop a VM for a bit in the morning, which is why it happened more
> >>> than once).  So I set up a VM with a nested VM, running up-to-date
> >>> Fedora 44, and then was able to bisect pretty easily, and it landed on
> >>> this commit.
> >>>
> >>> Fedora is using NetworkManager, and IIRC NM does some part of privacy
> >>> address management (right?).  NM didn't change, so maybe this commit is
> >>> confusing something in NM?  
> >>
> >> Sounds plausible, pretty sure we knew this commit was risky to begin
> >> with, but we had no direct proof that it'd break real life users.
> >>
> >> Revert is the right course of action here. Would you be willing/able
> >> to send the revert with your problem description and a Fixes tag
> >> pointing to the reverted commit?  
> > 
> > I did want to add a little more test note:
> > 
> > It's definitely an interaction with NetworkManager.  If I stop NM and
> > run my VM start/stop test, nothing unexpected happens after.  If NM is
> > running and I do my VM test, when the next router advertisement is
> > received, NM replaces the privacy addresses.
> >   
> 
> As someone that is experienced in NetworkManager, I can confirm it is 
> related. NetworkManager is querying the IPv6 address and when the 
> connection is configured with ipv6.ip6-privacy=2 (prefer-temp-addr), 
> NetworkManager creates a route to make the system use the temporary 
> address for outgoing connections by default.
> 
> If the order is messed up, the address picked will likely be too. One 
> could argue that this is partially fault of NetworkManager and that it 
> should check the timestamps or preferred times rather than order.. but 
> well, the rule is "do not break userspace".
> 
> I hope this clarifies things.

Not entirely. I'm looking into this right now, but note that the purpose
of that commit is to *preserve* the order of addresses as they were
inserted, not to mess it up.

Before that, addresses were stored and returned via netlink *reversed*
compared to the insertion, which is rather surprising, also because
it's the opposite of what we do for IPv4 addresses, and caused issues
with pasta(1) as it copies addresses into containers in the same order
as reported via netlink.

Do you happen to know exactly in which way the order happens to be wrong
now?

Also note that userspace was broken and fixed a couple of times:

  https://bugs.passt.top/show_bug.cgi?id=175#c10

so I would look into fixing that properly if doable. If it takes too
long and this is causing issues for a lot of people meanwhile of course
it might make sense to revert, but I'd give it a quick try at least.

-- 
Stefano

