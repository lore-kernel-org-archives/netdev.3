Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFB4F19A2A3
	for <netdev@vger.kernel.org>; Thu, 30 Jul 2026 03:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785383424; cv=none; b=jyWve5dtRNfdGeGMBihE9k+cUDHiKVuTgMBEm06g+9tgjDxcPyb//rtFiE2hCl9nr+YK26sLeiAacLtOUXgAKMrt1iBhewLsBouxsCbVyNGBbzz+b5kcohctpv2m7Banqy83vTjU9UUOQ66g1KP1wQi8dsrMss2AmxwC85ljzGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785383424; c=relaxed/simple;
	bh=+yi6uN5iRBIblyxibTs7ZkXcE1cO2XpCfbfHTAEmp1M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rbMYuZyvkMHK3wUhHgxx2nPM8pi6uROfdsUUm7nhlhHFGxtvBj5VGZre0HUK4wysR3MbcH+/Vp0w13G9qjBs39H6xtcZJ3vone8xztsHdM5pOYdJNQUhwyIiUHMr2xJc3FRHJ0ywBrqs6usSgxzUcR/oXFGzuxKGjwR7g9abVVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pgIgDB2c; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pgIgDB2c"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38e42560ebcso1259535a91.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 20:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785383423; x=1785988223; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=bRToeNqXboRrsPp4rN2QXShTZgRCA+alJAy+M1p+bqU=;
        b=pgIgDB2cBVMsjjHqMGcW2ZYkgIjuZw9KdkoF/21h9PtWIYty4RUkdW2T7hnn4l0xCc
         KmMqhVxBeHS6ovYjFr/VOUUA0PkDasj99ojUoQ7cXATiPze3AcIHIwX3O+unhLA71HIw
         4bpvaUTA0WvbVAdzjRvJVaolF8uixV8GOkaeHtRYCHgEdocqZjN3xiOXbNZHHi13Stcw
         Q9KjymvQSl1UvYt4MVKsFlm2Ooc7Kzt6qePhZfIEawLs75o/1nKa2gqfmLk3wb7gOdvS
         UoDGnCtTx7xT1k92g464Ypteqc42ndlpRhQNVCzBh4UYN2czJsIzhqZKgJDG5Ald5Uqk
         ohvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785383423; x=1785988223;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bRToeNqXboRrsPp4rN2QXShTZgRCA+alJAy+M1p+bqU=;
        b=pfjiKMtzJYy5UN2od+f3GzVtRX7I+mFSG/T//7BIvyTBLtcI6fSwqsl4hLTHnl/B30
         15C1VxNbVeEL6IBwUmiTVMlwuRbq88s4qx903pC6VsawZQozok8xcNE/jwr8DdYQ9crW
         2EhWRLnmU0Be0Kp6gRF/UH7njarWGdzagLIi4PgK6GhZzAbTxxA/wm6i10bshbGUZf/V
         NH85RHwlLgAKWzAZ5Cmm664gbwqe4W2aKodJmgkJGxzVwvKbYSV4Q+yrrk3oCs9o+x6a
         9I3SbOmKRyFvpaECcc46HlDzKnubi6gdidt32O2PYx9jz5AAn5oibTBEwKPRHKwjBVdu
         nFtg==
X-Forwarded-Encrypted: i=1; AHgh+RqAWjWvUifjus3vq64rAmisKJM5Q7yWejTPSqmofdKJcT8X93jsZQiVsAZnWQoLco9gVhYzPV0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzmHdzW2Vsry6kQAwYD3/QkCbrZhM1rpaShWqMpnmyTFfXHAri8
	iamdJDXwr4aCFmiJjEbVn75vhi02GbPyhPLZdJdfWIJbT0hzyM+o725rFrKmbXxm
X-Gm-Gg: AR+sD1013ZL+EeDzSzjvCbMr+2i4bvPgUnKs0XF9LFpEaQZKq+D8o7ug+BXP1q4+ZiS
	rgUnXwACW4sekMsX8VutbbKTPkhKAwQohQRKs8ye2cXP1h76qGpM93N/jbnsb28QZCM8NGWUiNf
	ou/aJ67mHR9DT/+NwyxYr7NwgrQ9xo81Pb9C0om4+fWs4IGRJFiecsJMeozcLa5PVuS1/bLl1h5
	JIdqNByon4/AzuWd/4iRLKh95c1/j2fr2M5kCOH/wg141wK8tYgfT1Qdy1M4G9kRlUGBp9hJuci
	AeHmWXv4Ht7vGGehNQACoIeysQRmuHbf7TVrk8gnB3Xl1809bQ6g1i7QszgGA45LKU2fDCXlFKq
	bmVnZfk8iUm4X917lBV22yL1HgLj5vPw2ICwkknh+cKR03s+oLUrRNVCle5Yb4PTkZ5sfbYjOTT
	RZ3BaDpCPU+xXjrLaMRbmIL0lS83EqvtDn3A8KjDu0pIAOaoan/UWy6bs=
X-Received: by 2002:a17:90b:4c8b:b0:38e:673:5d18 with SMTP id 98e67ed59e1d1-38f9c035ba8mr772309a91.36.1785383422828;
        Wed, 29 Jul 2026 20:50:22 -0700 (PDT)
Received: from fedora ([203.175.12.240])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f9b72d243sm301354a91.10.2026.07.29.20.50.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jul 2026 20:50:22 -0700 (PDT)
Date: Thu, 30 Jul 2026 11:50:15 +0800
From: Hangbin Liu <liuhangbin@gmail.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: Jay Vosburgh <jv@jvosburgh.net>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, AutonomousCodeSecurity@microsoft.com, 
	tgopinath@linux.microsoft.com, kys@microsoft.com
Subject: Re: [PATCH net] bonding: fix skb_under_panic in bond_ns_send() over
 stacked VLANs
Message-ID: <amrIbBqpw9Ol5wPJ@fedora>
References: <20260719232153.1405569-1-xmei5@asu.edu>
 <2820549.1784570299@famine>
 <CAPpSM+RkHO7uEVrEbqgfundSbiLU67enaSXhtk6mL8bXzC17xQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
In-Reply-To: <CAPpSM+RkHO7uEVrEbqgfundSbiLU67enaSXhtk6mL8bXzC17xQ@mail.gmail.com>

Hi Xiang,

On 29.07.2026 16:30, Xiang Mei wrote:
>>         Does adding one or two more nested VLANs move the panic into the
>> above call path?
>>
>
>No, for both of the reasons above: there is no room to add more
>(-EMLINK at N = 7), and skb_cow_head() would absorb it if there were.

What about the scenario that involves nested VLANs? For example:

vlan.1 - vlan.1.2 ... vlan.1..6 - bond - bond.1 - bond.1.2 ... bond.1..6?

>Both symptoms have the same cause, tags inserted before any header
>exists, so the fix is to build the probe in the order the stack uses:
>
>  - push the IPv6 header first, so the reservation is consumed up front
>    and the later tag inserts grow the head via skb_vlan_push() instead
>    of eating it;
>
>  - run the probe through NF_INET_LOCAL_OUT as a bare IPv6 packet,
>    exactly what ndisc_send_skb() feeds the hooks today.  This needs a
>    small export (ndisc_attach_dst()) because ip6_route_me_harder()
>    dereferences skb_dst() unconditionally;
>
>  - only then push the link-layer header and add the VLAN tags, so they
>    land at a real Ethernet header and the target address is untouched.
>
>With that applied the N = 1..6 wire capture is clean throughout.  I kept
>LOCAL_OUT deliberately so NS monitoring keeps traversing netfilter the
>way it does today; dropping it would be simpler, but a silent behaviour
>change.
>
>I am not familiar with the bonding and ndisc internals, so I posted it as
>an RFC rather than presenting it as settled:
>
>  https://lore.kernel.org/netdev/20260729230119.2717507-1-xmei5@asu.edu/T/#t

I'm not sure if calling NF_INET_LOCAL_OUT in bond code is a good idea. Waiting
for other's opinion.

Thanks
Hangbin
