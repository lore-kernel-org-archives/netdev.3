Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AD0933B6DA
	for <netdev@vger.kernel.org>; Fri, 28 Aug 2026 02:43:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787885011; cv=none; b=hbGavHWKdm8VU+sYyeWJgihOUdxnqubGXvS2wN48+VIdk7x7Ok2WLNDw1md/SM17/SH6qQ9btf32itr5wQCWk1uq5FgPXk97+NWLdQl5R1qlR9P9b0fqgEbDGBTHZE9VzUHzU4NQCtsG/iIEiCFuCAeu1NPkRD32N8ds3iMGr70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787885011; c=relaxed/simple;
	bh=x+NfT23xtsOuMyluadpQItVxOmRCcSjP7wwid4hR0yM=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=nbPUqjCr38eAZ3lLnQhjgvYH+O/vl6eqH41Jx8Icb3SyBxL+bpz2wNA8LUxhLPyogf4pZuGeljJCCRnHAIHUkJS4Icw5l2lYltSfkTS4kmiKwAGIWNiBzo3E2EHAoVNKTjKuXfkoKbZ8A5y/HPwJ4sVqeh4aBjS1tWUufNBKaUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hevJ+5KV; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hevJ+5KV"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-856114a8247so8111957b3.2
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 19:43:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787885009; x=1788489809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=bKG9LeGJl4HRaolEQhjC7Ndckz2inmxAZZ2u5dpOI+A=;
        b=hevJ+5KV009uiIIYQtLol/qzXGZpNlWLvKfED7FSYk6xp+4bypyG9BqqsYfJoQJTeG
         QzB6qqPeM4CzFWL/AD2AgUoxJeKUQ2fTJTVfaUcVVVjFs/pFs/FfU+yOYPTUSSyUKuQp
         zz6BP+JAbRdhQ6FR+8GwFjkK0Wyxx+LbTKD+weYkWr9yg2FD3FfQ3jGBHaBBH7ER4h/O
         eQajal4wX1qGerwK3Uhu1guLodApb2cKWVMsdYUXxNBZiM6QXelcD25UzMAnog/nSvgV
         6kdGMh9/6rsq+DsDDUxkxAQJOzW80fQuXPmWMogZk64BDFe9ML7JDdQLotD/wcLBXUPb
         eyRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787885009; x=1788489809;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bKG9LeGJl4HRaolEQhjC7Ndckz2inmxAZZ2u5dpOI+A=;
        b=sRCCW1mFYXjIFzFkprlearE5CjOhk1VHwTu/TvD5DBFbuA3q9Md2738lnjeaAFt7vE
         8e8tV1BA4his4V0IxauJE16x9Pqam+0VEVLobVnaptFf2g+vAAjrRlPuKBBceVrkmFQ/
         rE2HK1jBwKVFyqswWEvBc3x8jvu13GeY2AXpfz3ANMlXdsXn0DJrPlv4e8uR3KBCs171
         qADD7Y7dzQaG9sP6loIzNKZhagkr47A97UMXSw21XniyOe2vtCtA/s+VgwuGduOBvT1b
         tX/G+/cMKiFHvKP/Vn0ayDs4VQJF3eIj0Q8RvWrQ8GqeQ+IXZv0zgCAepoTYnsLuEWB6
         7PSg==
X-Forwarded-Encrypted: i=1; AHgh+RrJ3ncD4WqcHyhWi4dJ7IiSBFpuMk4644WCf1K4y1mzc3EFlkVi60pN9Nt1g4D76+PpagllJII=@vger.kernel.org
X-Gm-Message-State: AFuF++nQp2WQUp08F9DQnf2ayPgckD4pNLWwAXLnJJYajwL+LlTTnMZX
	K8nKeq7RCcal4VDLI9hb0iDq+f+COhIsMb1wAeNhiGGLCPt0fOz2IP/R
X-Gm-Gg: AR+sD10/3pS9lODW6kZpdiXgnIJuy7bVkZqpvofTSRV5pKfbIPoIKMlTHJjqYsjl4zn
	m1n1U1zAeIRnVaIIrgblW1NpksO7yHv1VH0yfaeMu3M4WCJ5z/VqJFtUN89vG4EvQUCHauo+zAO
	ARDaFtpiAmkCr4Os6l/WCr3OHgCBg/5Ru5M3JPf5boIp3jwdOof5RXQeKBVtLga9oU9qec+i1HY
	4zf7q8xS+bu0gbFNR9114DWxCUG7u1sJTr0s9pg6ab5PE1I3DshTWzpHCMsqp+hKr9BKcSnZsi9
	ZkFewA9l8Xnzdvi7B8NMcr0ptR3zHeTN3pKCQT1CicWG4VUSfcxE59oIvhFA4G3JxudBVUya/yD
	6MGJxp3A60uLwKSYJ4ABt1mlkk4MudNnzWgscZGqNSDKw49zQVlOwVCxBRssTxVwrHTenkflbhB
	lYp6PxEfiEh6f7UNr2UzBGEoqxbDcSd32ifvvz6usZXXBjI5xMP1QsyBzTdXmmi2Cqqu57MMIIQ
	2y3lHCmJ81LVh31TnCVnx1WbjhQO6SL6nSr3TgnDA==
X-Received: by 2002:a05:690c:319:b0:80f:8faa:b8e0 with SMTP id 00721157ae682-85d69e009femr21839417b3.8.1787885008958;
        Thu, 27 Aug 2026 19:43:28 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-85e7163c4dfsm953097b3.15.2026.08.27.19.43.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 19:43:28 -0700 (PDT)
Date: Thu, 27 Aug 2026 22:43:27 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Hangbin Liu <hangbin.liu@linux.dev>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: Qihang <q.h.hack.winter@gmail.com>, 
 jv@jvosburgh.net, 
 jiri@resnulli.us, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 willemb@google.com, 
 netdev@vger.kernel.org, 
 stable@vger.kernel.org
Message-ID: <willemdebruijn.kernel.3786f2ddb8b17@gmail.com>
In-Reply-To: <apDgeCLGiHTd7fAC@fedora>
References: <20260824021802.90369-1-q.h.hack.winter@gmail.com>
 <willemdebruijn.kernel.2ec10017f4836@gmail.com>
 <CAH78GvvF-mBij7exwgkthJC2puz1-1Ti=WkNr2PwFcKr_v5U4Q@mail.gmail.com>
 <willemdebruijn.kernel.361c9e585560e@gmail.com>
 <apDgeCLGiHTd7fAC@fedora>
Subject: Re: [PATCH net 1/2] bonding: reject frames with insufficient headroom
 in bond_header_create
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Hangbin Liu wrote:
> On Thu, Aug 27, 2026 at 05:37:09PM -0400, Willem de Bruijn wrote:
> > Qihang wrote:
> > > Hi Willem,
> > > 
> > > I'll resend this as v2 with a cover letter.
> > > 
> > > On scope: I grepped every header_ops->create.  Five devices delegate to a
> > > lower device (bond, team, macvlan, ipvlan, 6lowpan), but only bond and
> > > team re-select that lower device under RCU -- the rest bind it at netdev
> > > creation.  So bond and team are the full scope.
> > > 
> > > Re Fixes: I used 950803f because it introduced bond_header_create (where
> > > this check lives); before it the type-confusion BUG masked this race.
> > > Happy to point at 1284cd3a2b74 instead if you prefer.
> > > 
> > > On the fix location, I'd rather get your read before writing more.  The
> > > options I see:
> > > 
> > >   1. per-wrapper headroom reject in bond/team only -- small, safe,
> > >      backport-friendly, but not generic (the next stacked device needs
> > >      its own).
> > > 
> > >   2. central check in dev_hard_header on dev->hard_header_len -- one
> > >      place, but I think it's unsafe for bond: bond_dev->hard_header_len
> > >      only follows the first slave (bond_setup_by_slave),
> > >      bond_change_active_slave flips curr_active_slave without touching
> > >      it, and same-type slaves can have different hard_header_len (two GRE
> > >      tunnels).  So it can under-reject.  Would need bond to maintain
> > >      hard_header_len differently first.
> > > 
> > >   3. resolve the effective {dev, ops, hard_header_len} as one RCU triple
> > >      via a generic callback, so the caller never cares which subordinate
> > >      the master picks.  Truly generic and race-free, but it's a new ndo --
> > >      net-next material, awkward for stable backport.
> > > 
> > >   4. make header_ops->create() take an explicit headroom contract and
> > >      fail cleanly instead of pushing blind -- cleanest long-term, but
> > >      touches every create() in the tree.  Too heavy for now.
> > > 
> > > My v1 is option 1 (per-wrapper).  Want one of these, a combination,
> > > or something else entirely?
> > 
> > Thanks for the analysis.
> > 
> > I agree that 3 nd 4 are too invasive for the scope of the bug.
> > 
> > It's a bit odd that bond and team just take the hard_header_len of the
> > first slave. And that bond_create_header just passes to
> 
> Actually, bond will use the max hard_header_len of all slaves, see
> 
> netdev_compute_master_upper_features()

Awesome. That should address the issue.
 
> 
> > curr_active_slave, while various bond modes like LAG will have
> > multiple concurrently active slaves.
> > 
> > That indicates that the intent is for all slaves to have the same
> > header length and header_ops->create callback.
> 
> And here seem you want to all saves also sync the header length?
> 
> I'm not sure if we should/could do this in the same function
> netdev_compute_master_upper_features().

As long as the header length allocated is the max of all slaves'
requirements, no need to check again here, I think.

> Thanks
> Hangbin


