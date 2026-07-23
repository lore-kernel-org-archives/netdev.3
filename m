Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25ED36167F
	for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784842034; cv=none; b=owJnhIcJMOz3MCORH86S4KmZqQ6d8ks+0dmP+Bqgc266MO+UpcKB6Ki8R9OTEjK8QH9mdsm42BpziKKjrAtFumFLBW9BM5QxD+cP6Iu76Rg+u6NH51ELEt33LIb/vsMqcIwrbVN+9Nu1r38RDNtzeBM+4aOcdA/qyOtKvuzOk3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784842034; c=relaxed/simple;
	bh=UWzRWrIEXjrNES1A8NVqUZ1Zsnc09Ouw5qAM+aLrLKk=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=NeSHs5cvioTgvQ1b/qLxrXB4cLxQuQgqKzsapakdNrqEVRHJXIs1jZCY5GamxPyH5lUgdsb6KNMJBRoTkMgCnu1KAngcyqA1yhZp1T4B8w33XuB7iM7qK9yimb1qsg+z+JkYtRRJrDDmMLtfRBY1A1t0sAPzGO7SXgYXUBzPnZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cf0hLFIJ; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cf0hLFIJ"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81ed000b507so10036427b3.0
        for <netdev@vger.kernel.org>; Thu, 23 Jul 2026 14:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784842032; x=1785446832; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Duh9cBsk0MxTDxiDDGr/+JshAWLGdlOl+GBYIvU1QGg=;
        b=Cf0hLFIJgTRvC3RKNHC+tW7uz9x+6XHD2enRsW2jyfR/cApkLTqnXL4peDgYmrVOj+
         RVAEA3MT3T2PZf3XXsot0T02+bbPd0Cn4CSNU6BZbSoBaW3/RXIq3oceE/7kOT2ZdHYm
         2AUysQv+knjOgGxgrLz7SssSLFu+YdPJGHoldxYg9SurP7/pxuVGeuNMIl/G1XDFUNuU
         Z5q0fMeDBML3KhwjGZqXTEX+xUvFmbW90RYzT36m6IZbQkXk6uUDmOAbWpxHJ5lZpNx+
         zeFPSM3nv+d309tvThBzI0WgiIgShExJ6AKJJA4lCpXMEagzV2kKcKgSpxhk3lAfBplo
         hcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784842032; x=1785446832;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Duh9cBsk0MxTDxiDDGr/+JshAWLGdlOl+GBYIvU1QGg=;
        b=dntXPjcslDp+Cad/2w0YFgG71Nm16QtGaIvVFc+JAIV8e0H8nB+v6/NLUfdViT9FB6
         4SxW5IVHBN9GvXEPahvIn82B9ciPoWS1CD4g+0AK2amtXHsab64bPbhnKe9GjGA/RkOL
         9Zldfb/+mEEmT5LG2Yf5lug9zgmGq5+2sV2VafewbMO/nanBM/JpLs0l3zF/cykUFtp8
         m35QnBuW0VRcPEtWvMNLV5Cd0aaMOrcIkBb8TcWUTZfdAb+v5VdNB/Pb9URrR7+AXG6s
         KNuILeRt0jfCpV9JbnPLB7rT2x3NJEMESYYT7W7G0U3oNHei7mDA3cFOZbjQw3v0Nuiy
         1Tvw==
X-Forwarded-Encrypted: i=1; AHgh+Rq/vMU7RdUutxVVEPSvdwXSe8v71PC4E7kXD8SdVXWgNrpzXSP2l62foYYo1tlDmaP1aCEckXY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvN9OLyGznDKV8B1UJuBE/3fGgNyxZtOrd3QzVRREIBnKwDj18
	NRs5vAKkDe0O16Czii2pKmvcNstu2IWmWpk65macQ5c76BbXCEjPXXG3
X-Gm-Gg: AR+sD13q+jU9dMPIq/au3D+lj2P4gRjmRfRDbPmQmhx90x8Vzb8NcQaKm0vfFmnOO3+
	RvW0qcdijktVwLrmQgV4VrPJoChP+LWZNuMx9LRf2LDcqrlFdUawpymSEChE5AGciwgewwQuoyV
	tnD8mg2nVIBC/Y2PNLjcwkE2MgVub71xlQWN0pwGakzoZsRNrxiXsGPVgYGprOS2+A5/u8HTf2R
	YPbcnXcxnReEwW7nX1NDqnvB0RXDpsm79pFU9Vzy52qmcdo19UubM011CM4rOroagzkTUSLGTv4
	IYjglpOcTJcKmFBdbEBUgLMuq6CvwMswM8BTal9O2gP/4rSESCrhnf64PI7uJblCbH3OU5x5Vc3
	OqkBK4esfnobQEzjepzklPikU2Hs3gFdIZFSG0kWEMrRGz8Hg859IHuSRpx6dVUST9hG7HFtDAJ
	9CpPSQt2RV654aZ/wAzYx9NQDw0j1Q9vy05WJswyX1HwJKBqKykZt9DkU=
X-Received: by 2002:a05:690c:7343:b0:81e:84dd:213b with SMTP id 00721157ae682-81f4c36f62fmr13435707b3.71.1784842031718;
        Thu, 23 Jul 2026 14:27:11 -0700 (PDT)
Received: from gmail.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81f33c2df04sm34039557b3.12.2026.07.23.14.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:27:11 -0700 (PDT)
Date: Thu, 23 Jul 2026 17:27:10 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Mohsin Bashir <mohsin.bashr@gmail.com>, 
 Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
 netdev@vger.kernel.org
Cc: davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew@lunn.ch, 
 Willem de Bruijn <willemb@google.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Joshua A Hay <joshua.a.hay@intel.com>
Message-ID: <willemdebruijn.kernel.12dc80a02fdfa@gmail.com>
In-Reply-To: <d9a1d0c3-c097-42a1-a26d-7291a762390b@gmail.com>
References: <20260722204454.3234605-1-willemdebruijn.kernel@gmail.com>
 <20260722204454.3234605-4-willemdebruijn.kernel@gmail.com>
 <d9a1d0c3-c097-42a1-a26d-7291a762390b@gmail.com>
Subject: Re: [PATCH net-next v2 3/7] idpf: support pacing offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Mohsin Bashir wrote:
> 
> 
> On 7/22/26 1:43 PM, Willem de Bruijn wrote:
> > From: Willem de Bruijn <willemb@google.com>
> > 
> > If skb->tstamp is in the future, program this future delivery txtime
> > in the transmit descriptor.
> > 
> > TCP pacing offload is only offloaded if SK_PACING_FQ is negotiated and
> > the FQ offload_horizon is configured.
> > 
> > But device support for pacing offload must be more robust. It can also
> > be reached through SO_TXTIME.
> > 
> > Bound check txtime. Only packets with timestamp between now and the
> > horizon (max_pacing_offload_horizon) are offloaded.
> > 
> > Support only in splitq mode, where tx and tx completion queues are
> > separate and so completions can be returned out of order.
> > 
> > Assume that the NIC clock is PTP synchronized to CLOCK_TAI. This
> > can later be refined, e.g., to a custom CLOCK_AUX.
> > 
> > Disable if in netpoll. It does not need the feature, and the ktime
> > functions are not safe to call in this context.
> > 
> > Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
> > Cc: Joshua A Hay <joshua.a.hay@intel.com>
> > Signed-off-by: Willem de Bruijn <willemb@google.com>
> > 

> > @@ -2408,9 +2410,13 @@ void idpf_tx_splitq_build_flow_desc(union idpf_tx_flex_desc *desc,
> >   				    struct idpf_tx_splitq_params *params,
> >   				    u16 td_cmd, u16 size)
> >   {
> > -	*(u32 *)&desc->flow.qw1.cmd_dtype = (u8)(params->dtype | td_cmd);
> > +	*(__le32 *)&desc->flow.qw1.cmd_dtype = cpu_to_le32((u8)(params->dtype | td_cmd));
> 
> Looks like an independent change (potentially a fix)?

I did not seem important enough in practice. I'm not aware of any IDPF
on big endian. But I can pull it out if anyone really prefers it.
