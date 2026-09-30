Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BBF04FD29A
	for <netdev@vger.kernel.org>; Wed, 30 Sep 2026 14:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790780295; cv=none; b=kDh4GEwz/wfBsfiKdMtRIusHyNgWAggndwmkn0a1ndJ10iOu8NPht5qd2P519PROK6Q5cudiuDg+oRxw9lemwjP/uLdBuVDEoXkL2slCtWObLZmCfn+2H1F+mO4kreWS7a293PMGy1lbvNpRbPIy7OiBS5fyiOsuqkPPMPXadrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790780295; c=relaxed/simple;
	bh=K4N18PNdaYA09EQLDiGOUKt3VW769gBapMHoCR2WZto=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=CGSP+u9Avn0swUtaPJW4NcYLi79mfPJOSag5DS7pwXLAHUywVw+9ekcw3DwL/TXfR04rPenovmA3C2k2PYow/cUiZgmPvaNI1aJteDOgXdVeTpknF4ZuYruoNfiXwx3Xxer9Klui9GTzLysViGicDDBpjXFvwwzmQ4Ofoq4QmvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NUSVi+QY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NUSVi+QY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B861F000FF;
	Wed, 30 Sep 2026 14:58:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790780287;
	bh=bWUFavhFTmoV0T/Pds8uUdRaIfNAmcKDKiMwYPhLUdw=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=NUSVi+QYyqu71Pslpo88s/sHfkiqOCgcitPyh/VOuHM6qG8DmvNrOoIYKAbO2vOAU
	 bMYdlSghXDI6ll9ZgGkdKhtVOrHqleRaUrvwb50Lm7e7roVq9Cdwj7QAzQslk1jXuX
	 m0TTuhFeBPk1ccH9eP1G5LMSukrC/aZnUy7YLB1wRbSYtQplMrCoumokqxtPlVt+FQ
	 L2wZW7Fr+cimxNWdfDhr6VHRmJeVouRtcXf5HVEPaDvqsA+trhhXvsRKMu/N43ps/Q
	 +izjxmGRkIkmOG3jhgQ8dJ7YlB2LNqItOTEw0JQO748Z/P1Av3xU3Fedw+LuhbssVP
	 CsLbjuuBsdK8A==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id 51803F40066;
	Wed, 30 Sep 2026 10:58:06 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Wed, 30 Sep 2026 10:58:06 -0400
X-ME-Sender: <xms:fiO9ak2GFVh3cXwSVZLEV_IKSqEd2j-codHDgxzYPKqQzfvEMEuT4Q>
    <xme:fiO9ap4wXkitlxTb2FDYHWOxkW5CzmfvHpatF5AU_yktWqtJvng97urFr3R1BXNUE
    zXTyJHFw9mCjAUXz2JO-abgvBISG-e3Z89WCZ_L30LcJbw604kQyFqm>
X-ME-Proxy-Cause: dmFkZTG3rOorLEW7fWx3LGh9BGZ7Sll2IaBt2V6RHp0GiRq00j/jI0lByaBOiLBb4IQ3lU
    PEiuVBlRT98GfP7mCq9ioYgvO5TREyJ0KqTTPp2ScmPCfDoixTxYq25MBcjH1C5mydPQiM
    MaRYNazaPG2xx9DpqO/6omN6P6V2B6qUOI+58wUdmpOLfnC8Ofz3tEMcOWBrwfL92Ebl3c
    EV6Zfqzl0MWgfKAi7MiyXP1TeTeBGnBn60rCx5hrfq+PUrredKJn7kyYJ3MRNBsthm/VkJ
    6jy+TpcjOG2BPgVgAfXi9fVah30PxCnVq5/kLKyRt+GTNxPh6sSeHvAqKVftsizeYSkYRm
    8MG8LBe57PZDX4qAenznEh1GO3jBop23/EO82Neun68eQxeC/NWv3Nd12eGINM4fnD0s7w
    Xhi3hS61QiYAbZKJBDqtPsmjL5PpeCNtysMysHmrBdO7keSJ+BqK31IB7fEVEf5zNPlaxW
    DKdo5DyKQ6UI7KDuPZ9QIH8ci5VaNA6/38n2AsOpSafWLjNa0S0oXNE2U9yjRc/0VIuBkc
    IjsM1fcyDHNvK0KiQyx707UwaUDRBXJnU1n5erTg+Y7DsuurHvQFlh7EwdLT1FAL927+aA
    iyGEZMQ7I+r5B8vD105jvjNyZw9Glf1ptajNSv+tQpZ+J6E2DHIzDfOQJngQ
X-ME-Proxy: <xmx:fiO9asYUYEYiko1VdiepsC0xWZKZv-nFvynu__J2t_PAjoho801v2A>
    <xmx:fiO9ajSP_xppfbzt9VGFIMs24yUoKoCNT0rVu4oYQjc59t9722GKPA>
    <xmx:fiO9aj_MMwWOvOdCr6krKWh8rCK9WnL3q2eK2P-LkfEKqLBJTsTTfQ>
    <xmx:fiO9arj702mfMR_Cx8KqYryZOlQGLXveAb6P3IN8mWsI_68wOYd6BQ>
    <xmx:fiO9asa2WumssGUeswhg6yQqvlxnhlD3TiglwKwJUsGU0gwtAUBDXOGR>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 30903780075; Wed, 30 Sep 2026 10:58:06 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: ARQcub8KHhRJ
Date: Wed, 30 Sep 2026 07:57:46 -0700
From: "Chuck Lever" <cel@kernel.org>
To: "Sabrina Dubroca" <sd@queasysnail.net>, "Jakub Kicinski" <kuba@kernel.org>
Cc: "Qingfang Deng" <qingfang.deng@linux.dev>,
 "John Fastabend" <john.fastabend@gmail.com>,
 "David S. Miller" <davem@davemloft.net>,
 "Eric Dumazet" <edumazet@google.com>, "Paolo Abeni" <pabeni@redhat.com>,
 "Simon Horman" <horms@kernel.org>, "Dave Watson" <davejwatson@fb.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <eb175a90-58d9-4cfc-898a-8083633451cc@app.fastmail.com>
In-Reply-To: <ar0iBIUzHhZijRem@krikkit>
References: <20260930052636.166007-1-qingfang.deng@linux.dev>
 <arzStIrdizPp_vbI@krikkit> <465aa0d9-b1b2-4c85-9cbf-e6ed296b7b12@linux.dev>
 <arzawlad0OQ9pnBQ@krikkit>
 <415fb6f4-7ecd-4d04-a3c2-56c186a5628b@app.fastmail.com>
 <ar0iBIUzHhZijRem@krikkit>
Subject: Re: [PATCH net] tls: skip empty data records in tls_sw_splice_read()
Content-Type: text/plain
Content-Transfer-Encoding: 7bit



On Wed, Sep 30, 2026, at 7:51 AM, Sabrina Dubroca wrote:
> 2026-09-30, 06:45:23 -0700, Chuck Lever wrote:
>> 
>> 
>> On Wed, Sep 30, 2026, at 2:47 AM, Sabrina Dubroca wrote:

>> > Let's see if he has the time/interest to continue work on this (since
>> > he didn't send a v2, I'm guessing not).
>> >
>> > Chuck, do you want to pick up that TLS fixes series again, or would
>> > you rather let Qingfang finish off the "splice vs empty record"
>> > patch+selftest based on what you had sent?
>> 
>> History: I stopped working on that since Jakub seemed to think the
>> fixes were not worth the trouble, and my objective is to get kTLS
>> and its kernel consumers in shape to support KeyUpdate.
>
> I /think/ he meant that some patches in that series were ready to go
> in and worthy of being merged quickly, while others were less urgent
> and less ready, and could be finished later on (but not necessarily
> that the issues shouldn't be fixed at all).

I recall the use of the word "doubtful". I'm happy to continue to
pursue them, but I don't want to waste reviewer/maintainer time.


> But I guess we could just ask him.

Agreed, I probably misread his comment.


-- 
Chuck Lever (Come to NFS bake-a-thon! https://nfsv4bat.org)
