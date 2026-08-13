Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91DEC29BD8C
	for <netdev@vger.kernel.org>; Thu, 13 Aug 2026 02:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786587779; cv=none; b=GG8CcNtyDG3uCZJh/ZlOBqOKO52A7RWLcmIFQxdKKvgN+mZkFU+OiL+VwIyGvayqhmThynMJZDgRd450fraph5sMFUsQsLfcaCPDI7vzsyiSsC6gLUlUSm8aLPuD9kfa3I8MzYLE8wXPjyaCzTvr113c7o5GFChChaXrJFFzmhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786587779; c=relaxed/simple;
	bh=N0CDGf91ShSNx7NguKzYYvGCEE+SoDNyK4yIYae0qrs=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=i7/jcDxeqL2jdx5+gkJHA7LsAaFrWgvO3mVAhm0Q6aoLm2QBVqGqQSpKyngesioKPaM2oW2nflXR40Kzy2chNYXXclslyD5JlhlsS/fclOHlBgkC2wPcECeah0Xv5FsDgR/EWdqwS9Rzjp8jynGF7UjuEbAiDyGixOq3ZlSRous=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YahkbhiM; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YahkbhiM"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-821106b5b64so10198407b3.1
        for <netdev@vger.kernel.org>; Wed, 12 Aug 2026 19:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786587776; x=1787192576; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=COmSqf8nOGF9mKdU2rDmrVyiOuyrEua4dYaRNW04464=;
        b=YahkbhiMNxKoh532gMxgB/p45FBlZepvAdHT+SVv4Qx+FN26qo/otSXWYcKZsxMpqw
         LRLEMMznWYQ520udd12SgyD4RruuYe19cL5xBE6jgQFES+4Y5sewPprBSpN8DHgGlu2y
         b9fGUhx9ok+Z5ayhtSp/FVcYkAOY2bhtO1BMJL8LaOeODkxu292BRBs8v3H26MVKgSeB
         DghC8lz27vDij7O2XNcV3GhA3fqAivCKhHWeCMUn/G5Xw2vSudtfM1z0yX8Ei+dM8Kgf
         oixdKky2FSXJHeCAXw5eEc2r/qh+OTDSZMutevjo6FrKtSZjYdR3BGMWpoc65wW+0cGb
         ceBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786587776; x=1787192576;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=COmSqf8nOGF9mKdU2rDmrVyiOuyrEua4dYaRNW04464=;
        b=E1Ymyheh7LwbOUN44Ee3YCMPOy2Y2speROT5J9D28wD4/n5H3QQ7uLVWBxQX72E/MC
         QffvwONl9Uj7Mt6UCd1IDzfUmp4OyE+gQC5981KR35rtg2KGhZeL9RCcUo7fGwLlW5uD
         N3f7bqGe5j4t9UUfMLFrnmai5eNxWQMeIrW7Tm3Bi/9sZq+j7oUpXJ117wCcLyweDTcK
         Mta+8ot+PrNvUC4kf3H8i3v67NNyoQQEpsLF9ylG54/uMPayD2ASMVcAk0793oe10OJ1
         yGp+dEP6CwRGw1zmK0rgwxWUEfsOqopKzfdMHRLq6ozbdX2ZsjwixtbFiPInTTH7ITMx
         VGLA==
X-Gm-Message-State: AOJu0YxJsOgOE9LcxCIYDd5kE4Nsyk7FLJykej09m9OQYMF+QDNP7Q5G
	GwVplb6NC4MOMmtNbGvPZMPzCjxayqi78th8oW6t7Zu8IN2++VN+9BLM
X-Gm-Gg: AR+sD12gNAVY1AWfcoAlEbAP9heMpTMZGJ5JTad3gmJlP2SL4NlEn5zmnektDeEpKh1
	Qsn3mWlsa2Jq9smSDn8N3wjya8b2u90LgkaryDHde5NtxPDMA6Zkdq0mNC70uJwfzabJqLqeTs5
	bnXz63Hg0c9crPFgkm6Yn5ySAgkwHw9OIuXKOG9UiZEMGDQwJ6V43OdNOKxWMeWmXYP7LbdTDTR
	QH5i7m4cvkPhu6PQZm7PcX7+bliBRxacGA0SInqHAO3T0h19Hi6hvZb7FYnX5eJ9YDdo6mN6Z9E
	acmvH0QiRtLjty4r9mfyeJvTZLfECSosEFd1ZGpInl5iHmgUqQcGthfzVCdfAtkra9HdAH92ui4
	lOTEb0x74Gv35kPhJCbgpSIg2RnCjQXsPoPxFX7vDhmHjuK2XCOKTQ1iQDlDzHHdwkjmnhaoPom
	zKjLmjY6L9Rsd8QZSyuLBQ23vpgJ7tPCCjF7IPMBpaWS3INaUz0x4jwFPtZ8v4h3j0UcDYuq08Y
	LMhrRwUF8+Wvnp5+jXAyV4qiOZ4mFWhrYo0
X-Received: by 2002:a05:690c:385:b0:81e:f308:cfa3 with SMTP id 00721157ae682-83487fa7756mr9996857b3.14.1786587776591;
        Wed, 12 Aug 2026 19:22:56 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-83465b080dfsm4775547b3.3.2026.08.12.19.22.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 19:22:55 -0700 (PDT)
Date: Wed, 12 Aug 2026 22:22:55 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Joe Damato <joe@dama.to>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 andrew+netdev@lunn.ch, 
 willemb@google.com, 
 linux-kernel@vger.kernel.org
Message-ID: <willemdebruijn.kernel.1ea7511ccd4a1@gmail.com>
In-Reply-To: <any6TenWsCUdIPvX@devvm20253.cco0.facebook.com>
References: <20260811184722.2612345-1-joe@dama.to>
 <20260811184722.2612345-2-joe@dama.to>
 <willemdebruijn.kernel.57d27685522a@gmail.com>
 <any6TenWsCUdIPvX@devvm20253.cco0.facebook.com>
Subject: Re: [PATCH net-next 1/2] net/packet: Reduce VLAN tag code duplication
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Joe Damato wrote:
> On Wed, Aug 12, 2026 at 08:28:39AM -0400, Willem de Bruijn wrote:
> > Joe Damato wrote:
> > > Reduce code duplication for VLAN tag extraction by factoring the
> > > repeated code into a helper and using it.
> > > 
> > > Signed-off-by: Joe Damato <joe@dama.to>
> > 
> > Especially with the improving AI bots, we're getting even more fixes
> > to PF_PACKET lately. Cleanup patches can block fix backports to stable.
> > The bar for pure cleanup patches has to be high to warrant that.
> > 
> > Plus, they add risk, if it is not trivial to review that they are NOOPs.
> > 
> > Subjective, but not sure this one warrants the cost.
> 
> OK. In that case, I'll mark the series as rejected below. I was also working
> on a test for ORIGDEV because many, many years ago I got bit by unexpected
> results mixing packet sockets with bonded interfaces.
> 
> But, I'll refrain from touching anything related to af_packet including tests
> from now on.

It only applies to pure code cleanups.

> > > ---
> > >  net/packet/af_packet.c | 95 +++++++++++++++++++++++-------------------
> > >  1 file changed, 53 insertions(+), 42 deletions(-)

As said it is a bit subjective (I did add a Reviewed-by to patch 2/2).
And my opinion is just one. But this one to me makes the code less
obvious, and no shorter.

But, the real point remains that the bar for cleanups is high to
offset the dual risk of unintended side-effects, and especially
complicating (security) fix backports.

> > > 
> > > diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
> > > index 435756877aba..ee60dcc639ad 100644
> > > --- a/net/packet/af_packet.c
> > > +++ b/net/packet/af_packet.c
> 
> [...]
> 
> > > @@ -997,20 +1018,19 @@ static void prb_fill_vlan_info(struct tpacket_kbdq_core *pkc,
> > >  			struct tpacket3_hdr *ppd)
> > >  {
> > >  	struct packet_sock *po = container_of(pkc, struct packet_sock, rx_ring.prb_bdqc);
> > > +	struct net_device *dev = NULL;
> > > +	u16 tci, tpid;
> > >  
> > > -	if (skb_vlan_tag_present(pkc->skb)) {
> > > -		ppd->hv1.tp_vlan_tci = skb_vlan_tag_get(pkc->skb);
> > > -		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->vlan_proto);
> > > -		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> > > -	} else if (unlikely(po->sk.sk_type == SOCK_DGRAM && eth_type_vlan(pkc->skb->protocol))) {
> > > -		ppd->hv1.tp_vlan_tci = vlan_get_tci(pkc->skb, pkc->skb->dev);
> > > -		ppd->hv1.tp_vlan_tpid = ntohs(pkc->skb->protocol);
> > > +	if (po->sk.sk_type == SOCK_DGRAM)
> > > +		dev = pkc->skb->dev;
> > > +
> > > +	if (packet_get_vlan_tci_tpid(pkc->skb, dev, &tci, &tpid))
> > >  		ppd->tp_status = TP_STATUS_VLAN_VALID | TP_STATUS_VLAN_TPID_VALID;
> > 
> > Does this change behavior, now setting tp_status also for the second
> > branch, where previously the flags were not set?
> 
> If you apply the patch to the tree and look at it, it'll be less confusing. It
> looks weird because of what git generated, but as far as my reading of the
> code goes, there is no behavior change.

I see what you mean, thanks.
