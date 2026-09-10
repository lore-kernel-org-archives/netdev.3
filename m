Received: from mail-yx2-f12.google.com (mail-yx2-f12.google.com [74.125.224.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57037549367
	for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 17:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789060484; cv=none; b=HUfZxWpMujl7AwQGV+o/oOm1s6UV7l/qx5VSsGJfN8ATC6wyxyhWHEIZERUaTlicBb78RGeGBs2UJxNZaQgl/mh8SF6vI2fdNCJO77Vdd/nN9G8WfRnjeZYcCXohix3UgwdTTnJcbfpPIs0pqPqUZ/19BXWWUAd6dU5MDSWZsVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789060484; c=relaxed/simple;
	bh=JLBhlkHptkt8vky6GLAstauzobrjbn9VVeV8Evtsrnk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=DHZGAPiiMohdy5kG1VCh2fuvQGj44oLPc/dak9PlBPEsJVHuUKsSoSQvpBh0Z/0QBsC84c9kyaLb03mRj8iJIX1vXrQ5XqMjZh67fZqV6oyyPilxFOc7yy3CuHqDkKz2WxwYeEHtUhxiukYP5tMKenpBidRMJxIrxkwooJopmUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gboOMDT4; arc=none smtp.client-ip=74.125.224.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gboOMDT4"
Received: by mail-yx2-f12.google.com with SMTP id 00721157ae682-85d46e4cdccso25858287b3.1
        for <netdev@vger.kernel.org>; Thu, 10 Sep 2026 10:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789060478; x=1789665278; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=lColD1ZL2PEnWVJ4X/KoxCSKUdg/1PMxu/Z4jYoZMDU=;
        b=gboOMDT4lOCICX5PqX7ttfofqkfgIJMzt809AeStMgtqsS9cs/nN1DL3dv1NitewOq
         2bDEpDh4qlSe+Xe4E5+9KcY6t5XuNFjdUkLjX7D5wSiWT25WRXeZOqv/u+3kxV1Od/7a
         5m4qGjy9zFt2VJubq3HC9lxJtGQ3d1z6Ga1VDmuqVhHvnKEKcVsFofNZTZ41M8IuPQsV
         rviXrGT2MEf7mF1JyL2yxmJhh3HLJVhUd4AmeOlORYqG//md9s7CHKM1IRxZvGYvaGg7
         7pIs2tBxFLmLDlKMYM+Y+xfg6wah2QrKH+sl6VwCHh5LWH0NluZH+ajTr2ktZAQX+edP
         FBOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789060478; x=1789665278;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lColD1ZL2PEnWVJ4X/KoxCSKUdg/1PMxu/Z4jYoZMDU=;
        b=Woe77lza52Ct+/35VpqDv2O1+IooHWg2zzibs+ej9l7YMRJDzodMRK+iwiAohmWqZw
         92a0hp/vUaBN50+kkjNK4NK0SvNLG0IDJtzodLiFUE5ZXlmGBe8WowMvAxSuT7zbhqwC
         h9z+BLdXoyCHfShbBw+1PA83tug3cjL8yeskcjbLYCqEA+DBezxNuMb8YldpPkWENLdy
         wXxgzl6seoZByrbbYIUm7JSQqAgv5wo06et/F3K2bOyarGrsee7HwJFNNlx9zDxyniXi
         4Zj9BHOwYbr4JoR5yrSUQN/dzzJn03VDzxPbnkeNHvWL36at6fKyf0RWTKma7x+Eq++q
         u1SQ==
X-Forwarded-Encrypted: i=1; AKwUvBwUwGdGp1Bvce3HQQ4bJ0wWre2RNNaYGq+faPqWIpzySW3azNnL/+dUJsQtg8uXdVW8No7joEA=@vger.kernel.org
X-Gm-Message-State: AFuF++nQagifIXnLw5pSYYOwoaPvuz/p7PZOqh1qFrH/AJ86rCaNJNEg
	m9JbGbp4oOY7LXgeYWL09yUavU9Rg24YMnUkYGyqzF6z1Ih8QByPtjNy
X-Gm-Gg: AYBFou0B8NSY9YE/sh1FGm3I1v09DYHn2jJQuiF3bPAaSYhzSo/bQvQ31R7hKw20QkR
	FODOqa8cd71y8j/SbnBn7PHVbrODZ1OcstMqCUfK7rZ/HUwtFSqTC8KHggVIgI6tZYJt/omiCNR
	B9C48X0+8XjjVdF/TshfjksgHWPkxB4ifRH1S3ycOwILDZP24cyLsqC0RG8axBmJc0DlW+P14Gf
	anDuEPSepMGCeNVCdtSml1AnqPT2oWDJgMAg/qTStrg700SQ0XfxnMK6T5Zolnw1ShjpL31K7DK
	1k5+r4CaJhThKS7gDaE57+9Sf4IbY4+AW+PFYlXn0TqUbLqKzbQakXUY5YBUE1U+57K9CSkWHQt
	nkzjOmpLhyWhhYWD0oXhH7rZOfpRqZ35sO2Nc0a+wuLceilAARRZ2kq+U6n7GXIa26F/cmGhbjS
	b1xVpxns364SDhOxdFYJ+X6sx1e232DKbtX6wSwAAq6fMIWPbLFRa8uX1zZwzMr6mC+9cJw0eow
	qDzubl/mrgtpqlEJ8ppySW+1RAjd1Zs0u4I1UfFfPcJruIi5OZd
X-Received: by 2002:a05:690c:d94:b0:854:27c3:5cd8 with SMTP id 00721157ae682-884b387a6ecmr939577b3.27.1789060478657;
        Thu, 10 Sep 2026 10:14:38 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-88487ea6026sm2255367b3.32.2026.09.10.10.14.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 10:14:37 -0700 (PDT)
Date: Thu, 10 Sep 2026 13:14:37 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "davem@davemloft.net" <davem@davemloft.net>, 
 "kuba@kernel.org" <kuba@kernel.org>, 
 "edumazet@google.com" <edumazet@google.com>, 
 "pabeni@redhat.com" <pabeni@redhat.com>, 
 "horms@kernel.org" <horms@kernel.org>, 
 "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, 
 Willem de Bruijn <willemb@google.com>, 
 "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
 "Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, 
 "Hay, Joshua A" <joshua.a.hay@intel.com>, 
 "intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>
Message-ID: <willemdebruijn.kernel.2baa66372628@gmail.com>
In-Reply-To: <IA3PR11MB8986BD23939D98382AAC3971E5B22@IA3PR11MB8986.namprd11.prod.outlook.com>
References: <20260902181747.2483351-1-willemdebruijn.kernel@gmail.com>
 <20260902181747.2483351-4-willemdebruijn.kernel@gmail.com>
 <IA3PR11MB8986BD23939D98382AAC3971E5B22@IA3PR11MB8986.namprd11.prod.outlook.com>
Subject: RE: [PATCH net-next v8 3/6] idpf: support pacing offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Loktionov, Aleksandr wrote:
> 
> 
> > -----Original Message-----
> > From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> > Sent: Wednesday, September 2, 2026 8:17 PM
> > To: netdev@vger.kernel.org
> > Cc: davem@davemloft.net; kuba@kernel.org; edumazet@google.com;
> > pabeni@redhat.com; horms@kernel.org; andrew+netdev@lunn.ch; Willem de
> > Bruijn <willemb@google.com>; Nguyen, Anthony L
> > <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; Hay, Joshua A
> > <joshua.a.hay@intel.com>; intel-wired-lan@lists.osuosl.org
> > Subject: [PATCH net-next v8 3/6] idpf: support pacing offload
> > 
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
> > These features are negotiated per adapter, but expect all vports to
> > uniformly request splitq (req_[rt]x_splitq) and flow scheduling
> > (flow_sch_en) when available.
> > 
> > Do not explicitly check all preconditions. Trust the firmware to only
> > advertise EDT when all are met. In general, firmware response is
> > trusted to be correct. If not, EDT would be the least of the worries.
> > In particular, granularity is trusted to be a power of two. And
> > time_horizon_ns is a range expressible given the chosen granularity.
> > 
> > Packets beyond the horizon are sent immediately with the overflow bit
> > set.
> > 
> > On device reset, dev->pacing_offload_horizon, fq offload_horizon and
> > granularity are not re-negotiated. It is safe to assume that firmware
> > does not change these EDT capabilities across resets.
> > 
> > Must not be called from netpoll due to ktime_get. But netpoll does not
> > generate packets with EDT, so no explicit test is needed.
> > 
> > Do not fail device initialization on EDT init error. Log an error, but
> > continue without EDT, similar to PTP.
> > 
> > Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> > Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> > Cc: Joshua A Hay <joshua.a.hay@intel.com>
> > Cc: intel-wired-lan@lists.osuosl.org
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > 
> > ---
> > 
> > Changes
> >   v7 -> v8
> >     - remove unused variable np in idpf_tx_splitq_set_txtime
> >   v6 -> v7
> >     - rebase onto libie changes: adjust idpf_send_get_edt_caps_msg
> >     - only set horizon if splitq with flow scheduling
> >     - fail on illegal granularity 0, rather than use hardcoded default
> >     - zero edt_caps on negotation error, in case of call after reset
> negotation -> negotiation

Fixed
 
> 
> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>

Thanks for the review Aleksandr!

I did not keep the Reviewed-by as sticky, because the patch saw some
changes in v9. 

https://lore.kernel.org/netdev/20260910171131.2532487-5-willemdebruijn.kernel@gmail.com/T/#u
