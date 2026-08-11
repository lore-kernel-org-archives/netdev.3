Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 345992EA754
	for <netdev@vger.kernel.org>; Tue, 11 Aug 2026 01:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786412292; cv=none; b=YDeRF2AmC+WN19yhtKLWr9hLhCEADmweeA6P4o/W95e5V9Vo4wempFYtAxa5g8bDmMAWoL09ccDL2U+ETUQBrdqxFflm79qB38qIHsd1WBFDG1KWj6jkw3jEGDv778vvov53TPoA6FVzi6lwxtLz8pYaAWC9Xuv5qNn/+QoI62s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786412292; c=relaxed/simple;
	bh=eFdMPqMjQnLoYQ/n60KlCaV/2jQp99ayQWkJwDD5gj4=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=MGmp31bnvoBaaT42R2plVre6WHhKX+WTtM+/TXR7uhGo338FIttiPIxsOoyjDleVV8byWcaSdjsc756VCrCkg5O8W/8zAk1Vf1SrsASO81Q3y/cGszJf5VuHiTqyDsShuy+fZRaqzkpf2IT+WlL9FOQmgk6thDPeCkhOaF5snkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JSiYikb7; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JSiYikb7"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-825fdc558d3so20276907b3.2
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 18:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786412290; x=1787017090; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lJTXUn+83AudIX/W86BCPhPdhN//muk9TL35yAJQ0t8=;
        b=JSiYikb7tjjqMToPSmFqt9EZcQ6UPdE9ddHYI9CBcr4w0fDC3ZyZF55NKYgxTRHdUE
         2Qy6KABTuRjMBqJWthC/bbOSdR8+Gtv9cjb8Eap2fcz8L0mk/2Uiy4gpmGSckAyRu1qP
         w6Y2E7gV6ssmtzHEehkQc4RgEAoLS4NRzg5taQdk0gBpsRzFkg+RVekEWrLh8ZjUKth3
         FJ3DzTOjOZ5yzFW3l5L4WfQsfCmy/PsxqkqL9T0aNDucEu89W/AX2JdWATSwYBTpARvX
         FOVn+cLegoURSrCAZcgguAGJ/lLY5E8JLJgCYZagP/5awQ9+sCgRnhkSS5QGPtVguYrm
         8A6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786412290; x=1787017090;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lJTXUn+83AudIX/W86BCPhPdhN//muk9TL35yAJQ0t8=;
        b=geLCodc3PVbgTJBPxw7Is7yaDPQtszSpLo+ddsLpITBcakKJ3JZ1bDiEBCs6IO33V4
         90+Le0dMLUYFDDz4CmktNJzrTXGcKKZsoCeBP7pcYwLR/XjCw2kRHKZZXRR4kXVITKya
         eCP9RFDbGVHUv+l4yceH8y5Zqc8Y8rorKdMjNuc5q8kwgjs7fymkuX+a5Hy95cgf875e
         1ZJt4jPePe+PZoKiN9xLXQfxHFuQk4TCYpUBoPIJhPn85X43yJSmjbrdssp3KYbkvzo9
         J0q3cUsVCTfHcexBdUMZgzNY1sqL+QpmCRj4CxpN8vPyOKKDIC56zbphvz+qMnp55+zR
         W33A==
X-Gm-Message-State: AOJu0Yw19W8hUoMFXZLz+H/csNxgMDQP8pEJmpeYNtiqJWF7IQmWlKyC
	zKGOjWuFjjv6S4S2mv8QW5gw+IuaPg4ailTcWRcWGDdV5I44qfZE0ST7
X-Gm-Gg: AR+sD11Y8TVpW8bDnUdo6Oc8srsDWZOkKf21gY05FkNc3oKeCnsrra8i8IsG+/w4vSN
	6xZxMHpZgBqECgT7KkCrhq/BxlQnHrRZ0/fh66bzgSrNjR/xSUTiaxqATZ9IIUOsps5iy8Wb0wq
	VM6rq56aKBIBVlsrvqgfOBp68Ga3xdhL9m5yTgwFi+43nA6UHhAtUBDypq6hi1rh/ruxgjL35rM
	uXBR1evZTV917LsisHyVPb+zZeScjm20alOzZZRwfJyEWZt4A20wvoh0dd3La7PONZ8Acvr1/5z
	LZseu2nCPsM6s9iBKPdd5f2VjXguj4p4y92GWHGU5PFO7DkZBiQYDbbc9j/EvlIfr/pWEW2bfoY
	geW1pk6dD+h5baTj+xjkir2+xUkwRocJfvx3kgFJZPYIMSRCqnEgVLPdE0rB2d5R5Dl+g/WViPm
	pKk5sUpBS187XdHXcF+ysJt67c0i4N0EDRCbE7x6oDmKkXc0TRgfeCzfEnogWBCBMbPRzeus9vC
	Mo5UvJvSJYCivCcsdESU11bYHEOEZuxTTE3
X-Received: by 2002:a05:690c:a89:b0:80c:b92c:77a9 with SMTP id 00721157ae682-8243fdf21a7mr163377117b3.6.1786412290012;
        Mon, 10 Aug 2026 18:38:10 -0700 (PDT)
Received: from gmail.com (250.4.48.34.bc.googleusercontent.com. [34.48.4.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-82ec534f680sm1156187b3.49.2026.08.10.18.38.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 18:38:08 -0700 (PDT)
Date: Mon, 10 Aug 2026 21:38:07 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Jakub Kicinski <kuba@kernel.org>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew@lunn.ch, 
 Willem de Bruijn <willemb@google.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Joshua A Hay <joshua.a.hay@intel.com>
Message-ID: <willemdebruijn.kernel.2f01b2b7b1be5@gmail.com>
In-Reply-To: <20260810181248.7b05c051@kernel.org>
References: <20260808155217.885299-1-willemdebruijn.kernel@gmail.com>
 <20260808155217.885299-4-willemdebruijn.kernel@gmail.com>
 <20260810181248.7b05c051@kernel.org>
Subject: Re: [PATCH net-next v5 3/6] idpf: support pacing offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Jakub Kicinski wrote:
> On Sat,  8 Aug 2026 11:51:41 -0400 Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > If skb->tstamp is in the future, program this future delivery txtime
> > in the transmit descriptor.
> > 
> > TCP pacing offload is only offloaded if SK_PACING_FQ is negotiated and
> > the FQ offload_horizon is configured. But device support for pacing
> > offload must be more robust: it can also be reached through SO_TXTIME.
> > 
> > Bounds check txtime. Only packets with timestamp between now and the
> > horizon (pacing_offload_horizon) are offloaded.
> > 
> > Negotiate the feature with the device using virtchnl. Support is
> > conditional on
> > - splitq mode, where tx and tx completion queues are separate, so
> >   completions can be returned out of order.
> > - flow scheduling mode, where completions can arrive out of order.
> > - PTP to ensure the NIC clock is synced to CLOCK_TAI.
> > 
> > Do not explicitly check for these preconditions. Trust the firmware to
> > only advertise EDT when they are met. These features are negotiated
> > per adapter, but expect all vports to uniformly request splitq
> > (req_[rt]x_splitq) and flow scheduling (flow_sch_en) when available.
> > 
> > Disable if in netpoll. It does not need the feature, and the ktime
> > functions are not safe to call in this context.
> > 
> > Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> > Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Cc: Joshua A Hay <joshua.a.hay@intel.com>
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> 
> Sorry I said it looks good to human eye but *shiko brings up some
> extra good points.
> 
> > +static void idpf_tx_splitq_set_txtime(const struct sk_buff *skb,
> > +				      struct idpf_tx_splitq_params *tx_params)
> > +{
> > +	struct idpf_netdev_priv *np = netdev_priv(skb->dev);
> > +	u64 ts, now, horizon;
> > +
> > +	horizon = READ_ONCE(skb->dev->pacing_offload_horizon);
> 
> Per *shiko, the max_pacing.. and pacing.. don't behave like the user
> may expect them to behave. FQ looks at max_pacing.. to decide whether 
> to allow configuring pacing offload. Driver looks at pacing..
> 
> Why are we letting the user create an obviously invalid configuration
> where the FQ is configured to offload but the driver is not respecting
> the requests? Since no upstream driver ever set max_pacing.. we can
> still adjust its semantics.
> 
> What do you expect the driver to use pacing_.. for?
> Currently you use it purely as a boolean but even in this case the
> semantics are unclear - is it purely a user configuration handshake
> between the driver and the qdisc to respect timestamps?

Yes this was the real regression with fq_change I referred to. That
bit got lost during revision. Patch 1 needs:

@@ -1179,7 +1179,8 @@ static int fq_change(struct Qdisc *sch, struct nlattr *opt,
                u64 offload_horizon = (u64)NSEC_PER_USEC *
                                      nla_get_u32(tb[TCA_FQ_OFFLOAD_HORIZON]);
 
-               if (offload_horizon <= qdisc_dev(sch)->max_pacing_offload_horizon) {
+               if (offload_horizon <=
+                   READ_ONCE(qdisc_dev(sch)->pacing_offload_horizon)) {
 
> > +	if (!horizon)
> > +		return;
> > +
> > +	/* Skip if netpoll: not needed and not safe to call ktime helpers */
> > +	if (netpoll_tx_running(skb->dev))
> 
> Is this due to Gemini's complaint? netpoll sending packets with
> timestamp in the future seems unreasonable to me, no?

It is. Makes sense to ignore EDT request when running in netpoll right.
Do you mean that we should not even check for that in the hot path?

> 
> > +		return;
> > +
> > +	switch (skb->tstamp_type) {
> > +	case SKB_CLOCK_REALTIME:
> > +		ts = ktime_to_ns(ktime_add(skb->tstamp,
> > +					   ktime_mono_to_any(0, TK_OFFS_TAI) -
> > +					   ktime_mono_to_any(0, TK_OFFS_REAL)));
> > +		break;
> > +	case SKB_CLOCK_MONOTONIC:
> > +		ts = ktime_to_ns(ktime_mono_to_any(skb->tstamp, TK_OFFS_TAI));
> > +		break;
> > +	case SKB_CLOCK_TAI:
> > +		ts = ktime_to_ns(skb->tstamp);
> > +		break;
> > +	default:
> > +		WARN_ON_ONCE(1);
> > +		return;
> > +	}
> > +
> > +	now = ktime_get_clocktai_ns();
> > +	if (ts < now)
> > +		return;
> 
> makes me wonder if FQ should clear the timestamps for e.g. now + 100ns ?
> IOW I wonder how often we end up taking this exit?

I'll add such a slack value to now in

+       if (q->offload_horizon &&
+           time_next_packet && time_next_packet <= now)
+               __skb_clear_delivery_time(skb, false);

> > diff --git a/drivers/net/ethernet/intel/idpf/virtchnl2.h b/drivers/net/ethernet/intel/idpf/virtchnl2.h
> > index 39fea65c075c..7525146491cd 100644
> > --- a/drivers/net/ethernet/intel/idpf/virtchnl2.h
> > +++ b/drivers/net/ethernet/intel/idpf/virtchnl2.h
> > @@ -457,6 +457,16 @@ struct virtchnl2_edt_caps {
> >  };
> >  VIRTCHNL2_CHECK_STRUCT_LEN(16, virtchnl2_edt_caps);
> >  
> > +/**
> > + * struct virtchnl2_edt_caps_ilog2 - Host parsed EDT caps.
> > + * @time_horizon_ns: Total time window in nanoseconds.
> > + * @tstamp_granularity_pow2: Log2 of timestamp granularity in nanoseconds.
> > + */
> > +struct virtchnl2_edt_caps_ilog2 {
> > +	u32 time_horizon_ns;
> > +	u8 tstamp_granularity_pow2;
> > +};
> 
> *shiko:
> 
> This isn't a bug, but this struct is host internal state: native u32/u8
> fields, no __le types, no VIRTCHNL2_CHECK_STRUCT_LEN assertion, and its only
> user is the edt_caps member of struct idpf_adapter. Every other struct in
> virtchnl2.h mirrors the control plane wire layout and carries a size
> assertion, as the neighbouring virtchnl2_edt_caps does.
> 
> Would idpf.h be a better home for it, with a name that does not carry the
> virtchnl2_ prefix, so a future firmware spec sync does not mistake it for a
> message struct?

Will do.

