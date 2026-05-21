Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED4362765C4
	for <netdev@vger.kernel.org>; Thu, 21 May 2026 14:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779374128; cv=none; b=HrA/1PaKLTSkHlSGR/bNF6df6LHKwVyDGIrsPrCRr0Lw8IV1ShwrAPhL6T9TVTCFbaIdNgUgck6reZ6deHbmPr5CYsKSLHsvMyizZqrxtqvPna5gSOa2Rj6LZye0kimc1SqtfhiU+l8WsknfzUE5lEJE1YCgvloQwDTQTSouDeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779374128; c=relaxed/simple;
	bh=tQDTeCG55a9v45cS8pokxYRImnjJwDJJ8ZdK0s2BXNE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MqDt7c+DdXg4oah/OV2gbFgyUdDD4A0e4ovtsoxHZn9DPTtpnzPrRlDTckX5vt5fC0lrxLBEyaVw/YMRG9jXENIhsqdM5EJPhDRzAwPSP85qf2QbZhvYvwxAL1tVnJjbml73y8A3JBQ7BvroCcSb9B10RANxqTlh79qizO1A9UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FOk4WR0+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FOk4WR0+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C641F000E9;
	Thu, 21 May 2026 14:35:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779374127;
	bh=5p3KvjlCX0IifGl+04Sx/DZ1HofmaqNkGakQk6OoiCg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FOk4WR0+x+86BogWcyPhEp8EUPHTrL1cHAw2zjJ7UqSiuDuKldeKtUPkqORU+5mNx
	 DpJXYvgFWsHv5CN+e7bmAd25dhPTQVYrDOrO4W98BLnVaywhLqwf6hOJzTnCuxPteE
	 ZXJ5nCqIDPjGoAAj8O5zdaJwQJyOTR+ynrUHuuATSvMOcrZXBI4/SQF/8AoUYxDAkl
	 RIRhX6mNfD1pqgrxh3POMFoKpOWpoi5PGYuuYUkOh1Ww9KSYRa2xSGcxhGEVydYB1i
	 6vl35qj3Lvz/f7GkcXxw9BVXzx2qZYuK7EnLUJp2CGqVtIZjsx785xmg9Ud/MsNCZo
	 j9B2NlxUJsyQQ==
Date: Thu, 21 May 2026 07:35:26 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: Rajat Gupta <rajat.gupta@oss.qualcomm.com>, netdev@vger.kernel.org,
 davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
 horms@kernel.org, jiri@resnulli.us, yimingqian591@gmail.com,
 keenanat2000@gmail.com, 2045gemini@gmail.com, rollkingzzc@gmail.com
Subject: Re: [PATCH net] net/sched: fix pedit partial COW leading to page
 cache corruption
Message-ID: <20260521073526.793d30c3@kernel.org>
In-Reply-To: <CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
References: <CAM0EoMkUPYSXKr2=+mR8YMq2a0TFdYPdzwPGob-UyU1fUWP9Ww@mail.gmail.com>
	<20260519033950.2037-1-rajat.gupta@oss.qualcomm.com>
	<CAM0EoMmj-9uDpKBN4vjJqzaLQL=OZ-sdFO_pHPFp6kL6hSVeRA@mail.gmail.com>
	<CAM0EoMkDwdmP94yeoX7W-DOY3Emcq84jGcPf73vtRTpDf1N3-w@mail.gmail.com>
	<CAM0EoMn-O7KU1R=b8jzb=DmMtRCuoEVmAH9hEsKehrdbmODAjA@mail.gmail.com>
	<CAM0EoM=sCnT69uPzB+HjOdRP9eQXVA+AcvPsBA80=dtQHi5sLQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 06:15:17 -0400 Jamal Hadi Salim wrote:
> > This is the same claim as sashiko1 but sashiko2 gave a much more
> > convincing description ;->
> > skb_has_shared_frag() is only true if the frags are flagged as
> > SKBFL_SHARED_FRAG (which is what the repro did); however, if we get
> > frags from eg a driver on ingress and that skb gets cloned with frags
> > we won't catch it.
> > One approach is to do an if (skb_has_any_shared_frags(skb)) and then
> > do a skb_linearize_cow() but that sounds like overkill.  
> 
> Yeah, this would be overkill - imagine running tcpdump 100% will be cloned
> 
> > Another which will make the patch even uglier (but less expensive) is
> > to add an extra check insde the patch's "if (write_offset < 0)"
> > to do:  if (write_offset + (int)sizeof(hdata) > 0) { skb_ensure_writable()}
> >  
> 
> To be precise, something like attached (untested, uncompiled)

Can we not pull the headers? Do you know of anyone modifying payloads
with pedit?

The concept of "shared frags" is silly IMHO, if I'm checking right only
rxrpc and xfrm think that it's a thing. I'm hoping to delete that and
reclaim the flag id in net-next...
