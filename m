Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5B23403E3;
	Fri, 31 Jul 2026 23:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540675; cv=none; b=QH/HbE0hT3WIkcVBwstdirCZuc7ud8rrYGjASKU+9/LLxCCfEE9aKlT4AUSMISVkYiYid6ugbYi7DWv4iaaz0RA8hLk0nvkJ0RGKkbBvRPzCg6X4nB5eTKv7Qaj9Kw12bTwGnS0kZfHfXZWmTJw+whpml/GMU1oje5yG9aP0uDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540675; c=relaxed/simple;
	bh=WYeyGVicDeqKbISN2mnkTxEQgloRzpurkQOcGqU2rGA=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ddop/DuMSQx+zMA/ya/0tqK+iQQWOVcN8PNmqD5FExXuKAxRo4r+cqP+zAJ1n+jBzm/BXyQXchNIivk4yhzZmTLRNGYefxXqXUqNagNCnE5dgIoFxtPZolWy4xFiG16JIMfHrMuLuo4T1jwFONJ4df1/7u8H3DEd61T34v+rj3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=WZ20SbgO; dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b=l2P8iq6S; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="WZ20SbgO";
	dkim=pass (2048-bit key) header.d=uniroma2.it header.i=@uniroma2.it header.b="l2P8iq6S"
Received: from smtpauth-2019-1.uniroma2.it (smtpauth-2019-1.uniroma2.it [160.80.5.46])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 66VNUFo9024211;
	Sat, 1 Aug 2026 01:30:20 +0200
Received: from lubuntu-18.04 (host-82-61-152-174.retail.telecomitalia.it [82.61.152.174])
	by smtpauth-2019-1.uniroma2.it (Postfix) with ESMTPSA id E54781228D4;
	Sat,  1 Aug 2026 01:30:09 +0200 (CEST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=uniroma2.it;
	s=ed201904; t=1785540611; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSMYR2kvz+j/dEZpxUT5lTGfksuoQPHrdLdMr+9++Fw=;
	b=WZ20SbgOLRoABJ7rlyAAQQA8GIfnItS7kN0EYam3qzAEZE7XO/8zZoXHnzlR75ipw4/wVO
	7SfAltC6UH98KPCw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniroma2.it; s=rsa201904;
	t=1785540611; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HSMYR2kvz+j/dEZpxUT5lTGfksuoQPHrdLdMr+9++Fw=;
	b=l2P8iq6SZSzAljKTUe7Dq+ezFcg/Qou79G4ekMuNNwDBQ5PCo+qlaWGlgbvgUnaMq3hde6
	vqWNS/ekmROzv0bewiIHM289wXYF/RFZkXdCZn72q7TEhyv1R4Mx7By3b2o67Ylnp10oE9
	JYxRoovE7f1cZ1I5RdaCxYntKupsMR+M2Vxxjea2frpcR98UV14AO7IhmQ482NxLi0ibUL
	9RljE92UZqnVw17pvxQ0Aw70TggOqWcWTE4GFHWy4b/Gu82euWMUZzyYtEldvY0BOj1Oj0
	WFgBUlhBZN6OllBH7BTnwD6RR5erpxN950+0PiNFK0MtquV71grGlMAlM7fWEA==
Date: Sat, 1 Aug 2026 01:30:07 +0200
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: "Xiang Mei (Microsoft)" <xmei5@asu.edu>
Cc: kuba@kernel.org, pablo@netfilter.org,
        "David S . Miller"
 <davem@davemloft.net>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
 <horms@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ryoga Saito <contact@proelbtn.com>,
        AutonomousCodeSecurity@microsoft.com, tgopinath@linux.microsoft.com,
        kys@microsoft.com, stefano.salsano@uniroma2.it,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>, justin.iurman@gmail.com,
        Andrea Mayer <andrea.mayer@uniroma2.it>
Subject: Re: [PATCH net v2 2/2] seg6: check lwtunnel state after nf hooks in
 iptunnel
Message-Id: <20260801013007.7019c3d53f1bc8aab58bc44f@uniroma2.it>
In-Reply-To: <20260728215448.1543553-2-xmei5@asu.edu>
References: <20260728215448.1543553-1-xmei5@asu.edu>
	<20260728215448.1543553-2-xmei5@asu.edu>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean

On Tue, 28 Jul 2026 21:54:48 +0000
"Xiang Mei (Microsoft)" <xmei5@asu.edu> wrote:

The code looks good. As in patch 1/2, checking the encap type is reasonable
for this fix too (checking the instance would need new machinery).

> seg6_input_core() and seg6_output_core() are the okfns of the
> POST_ROUTING hook that seg6_input_nf() and seg6_output_nf() dispatch
> through when nf_hooks_lwtunnel is enabled, and they read
> skb_dst(skb)->lwtstate on the assumption fixed for seg6local in patch 1.
> A hook may drop the dst, replace it with a metadata dst, or leave a route
> whose lwtstate is NULL; the last is reachable with SNAT plus an XFRM
> policy.
> 

One thing on the commit message. It lists the cases (drop, metadata dst,
lwtstate == NULL) but not what they cause: they all end in a NULL
dereference and the kernel panics. For that the reader has to follow "the
assumption fixed for seg6local in patch 1", and once applied this message
has to stand on its own. Patch 1/2 explains the failure and shows a trace.
This one has neither, so I would expect at least one sentence saying what
happens.

> Validate the dst and the encap type before use. seg6_do_srh() reads
> skb_dst(skb)->lwtstate too, but these two are its only callers and
> neither touches the dst in between.
> 

Sashiko also asks whether the validated lwtstate could be handed down to
seg6_do_srh(), instead of the re-read it does now. That would help if the
dst were replaced by a later change, but not if it were dropped: in the
encap modes __seg6_do_srh_encap() reads skb_dst(skb) on its own. And
nothing changes the dst between seg6_lwtst_from_skb() and the call to
seg6_do_srh(), so that re-read is fine too.

> In seg6_output_core() the validated lwtstate also takes over the dst-loop
> comparison, so "orig_dst" is gone, matching seg6_input_core().
> 
> Fixes: 7a3f5b0de364 ("netfilter: add netfilter hooks to SRv6 data plane")
> Reported-by: Andrea Mayer <andrea.mayer@uniroma2.it>
> Signed-off-by: Xiang Mei (Microsoft) <xmei5@asu.edu>
> ---
> v2: new patch, split out from the seg6local fix (Andrea Mayer).
> 
>  net/ipv6/seg6_iptunnel.c | 33 +++++++++++++++++++++++++++------
>  1 file changed, 27 insertions(+), 6 deletions(-)
> 
> [snip]

Thanks,

Ciao,
Andrea
