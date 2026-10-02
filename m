Received: from mail-pj2-f9.google.com (mail-pj2-f9.google.com [74.125.227.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1351C3290AF
	for <netdev@vger.kernel.org>; Fri,  2 Oct 2026 15:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790954810; cv=none; b=B6yyc1/jGUm2zPuHgr9qMgGrKDEhB9gaL2ZaSWdG1ghTf63NB2kjLnXS5eqT7afuYdXZtrDwVKVJhMHwjaQH3mcCRUtYQLP4yqd8XDog07rU8IVSZ1phoKgC4Ag9TIHbW9e7Jgk92wqzRErPocipre29iQFH78qsfSzEN/lY4a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790954810; c=relaxed/simple;
	bh=OQv4CvcMyfHqI/r1WBFjYAdH2wtEAKeV8/7u4d2GBBU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zx+M+HdVtFKb1x4+qpdb3YmiYgL/ZnspkEr2TiNWwT1EN+c1WLdVECL09zexqdRBJIQM0uGQNyMIx6otNZPfmNUtv+/EOP2ClvioGYpq9POaM1OQtwZYSgvp5wgyxDYxg3SGCvruupfL+SR2vqnNdlgHFZ3cQ5UbTMCn0PEKoEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h9MxLXVd; arc=none smtp.client-ip=74.125.227.137
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h9MxLXVd"
Received: by mail-pj2-f9.google.com with SMTP id d9443c01a7336-2e4a61a2ff9so2751065ad.0
        for <netdev@vger.kernel.org>; Fri, 02 Oct 2026 08:26:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790954808; x=1791559608; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FFgjq0ifm7DPaT6ixbrIMaG0lDPnL2tBtGxhUZ+K2DE=;
        b=h9MxLXVdSrUijSCKZOd4e7+WxT0FWnxVXvSzgnom+wf3TMMx+W0nFCpNS0gfN+QYRo
         1dDkCzb4ynh4HP/+JlOElksuFNnw2AVBMBNtoeLTBiEM7lC/e0mqsPgQjJR8UW+6xU51
         0FBUwgkFhvyP6IUL0WiUD5jrKWOpB0ZW8Ri5MB/3HoxEA3kn3akU+aTYBfXhF+xHswLJ
         0pc796McnB1+kPpl+nnRDFXWQBTu9hjtJr8dLOpnZvbFFDiVvAHv5T2k3XHMR/HSdTUq
         7o/t/GcP0aLRqgOyMKsL4M2vrTXUtJvuzU67JAzMIHKHcrzvA2bwsTSyIjie1kOnYIVi
         LsOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790954808; x=1791559608;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=FFgjq0ifm7DPaT6ixbrIMaG0lDPnL2tBtGxhUZ+K2DE=;
        b=23QjEoHtYcH5FZQ1ijdPiNckFbyVNAJPU78w5mWNubk8hGwXfc1YyChyjYnhJ8G1ac
         wytRScC4qqjrdBTln8OD7R38GW5OFme2pq6shbpCq5zE2Uu5Y9muGoA/67K89WDO9q/W
         XiHL/UmTDyFuMfj5jgjjESltxxQFiw1WekFx06zBY+iW0p9KWZ2gufe8UPmExICvPsG/
         rlhOUCH1BZyy45ZMEyiSO1fpImEIj+h5GP5gb7Z7QR7VzIgpFOiw2NNKBw0Rm5g9gHUb
         jc4VFbaRB9B7+CkIeZHRnjN0YG+nltLrN5xpAGV7EKeJYVIBZGgIgcu7uTQj7xVJB5Eb
         K2YQ==
X-Forwarded-Encrypted: i=1; AKwUvBzZG3L75FIHkZDVhgga7hDWH6eqLub9TPBLTQBerWJqFa3TZEnA/Z4eOgk51xalNDAIk+suFfA=@vger.kernel.org
X-Gm-Message-State: AFuF++nE6eGJpCr336RF2Se2ynLQf/jbmvrz+NxTZ5lcRf7QdI9//M3o
	yMl6rWhdxigbvSQyLHbzpBjsSQdYtYI9Z4149HWSqUfYOVeqFLkYdKX3
X-Gm-Gg: AYBFou0SrVT8f74QAt0ETBDUiKSPOxzGiBu/xTXXvDcyOcV9DNRXgFW6poHrTSK0RAT
	bWyCXInATqiz9oa8WWzXP4NS0+H9/CguD785UDbtLtwArtUkC+DUkHxhhf+Uxat6B+OR5EJJAz+
	tx5rkO6yPFAd8A0rkkZD0OX5z3/xpruDnjveExYaYvXES9vALwTDxk4JD2tjhBV0f8PDDdzTH4L
	CUbcYpoSwq54hhCtYk/tqQ6/2NRm09WPKP8VCUNOTWEJ0/FMAQVBRpxk9ouwJVFZkcMBKqABLxi
	6kaCcztnNY7v8wEc+qQtC7qY86lhPCPKk1KlXALOjvr/FBFjj+v5AO1GwDw+Z+BOns2Bil6su68
	Vglw3szfxZJBLd52BJHKpkx4PtfsLA64eh3A4ter9gOYUDnmGubz0oDaGPHTKorMx1DQuUovFVP
	/GCuPZDgQfi9nfAJYZIfh34tQ4E6Ah2G/mKLIJtepcs1+5ClocDhNA427UXeZGfXXB
X-Received: by 2002:a05:6a20:d4b:b0:3e0:b445:5609 with SMTP id adf61e73a8af0-3e0bd4ac5ecmr2949551637.76.1790954807680;
        Fri, 02 Oct 2026 08:26:47 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:50::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88b0d3449b8sm1070016b3a.58.2026.10.02.08.26.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Oct 2026 08:26:47 -0700 (PDT)
Date: Fri, 2 Oct 2026 08:26:42 -0700
From: Stanislav Fomichev <sdf.kernel@gmail.com>
To: Eric Dumazet <edumazet@kernel.org>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>, 
	"David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	edumazet@google.com
Subject: Re: [PATCH net-next] net: inline eth_type_trans() fast path
Message-ID: <ar_NFo4DXUw3i_H4@devvm7509.cco0.facebook.com>
References: <20260930172957.897342-1-edumazet@kernel.org>
 <d6170c1d-d8cf-4fd5-b0f2-361b89902fe7@intel.com>
 <CAL4Wiipep_WhfWBGov3vbOCLNKd0oQzFkX413AMU6V5DNN5Pmw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL4Wiipep_WhfWBGov3vbOCLNKd0oQzFkX413AMU6V5DNN5Pmw@mail.gmail.com>

On 10/01, Eric Dumazet wrote:
> On Thu, Oct 1, 2026 at 5:58 PM Alexander Lobakin
> <aleksander.lobakin@intel.com> wrote:
> >
> > From: Edumazet@kernel.org <edumazet@kernel.org>
> > Date: Wed, 30 Sep 2026 19:29:57 +0200
> >
> > > eth_type_trans() is called once per received packet by most
> > > Ethernet drivers, and by core helpers (napi_gro_frags(),
> > > xdp_build_skb_from_*(), veth, tun, tunnels, loopback...).
> > >
> > > With CONFIG_MITIGATION_RETHUNK / SRSO, the call and return
> > > are not free anymore.
> > >
> > > Add eth_type_trans_inline(), handling the common case inline:
> > > unicast frame sent to dev->dev_addr, with a real ethertype,
> > > on a device which is not a DSA conduit. All other frames
> > > (multicast, broadcast, otherhost, 802.2, runts, DSA)
> > > are handled by the out-of-line eth_type_trans().
> > >
> > > eth_type_trans() is now a macro calling eth_type_trans_inline(),
> > > so that all existing callers get the fast path. The out-of-line
> > > version remains exported, and can be called with
> > > (eth_type_trans)(skb, dev). bpf_prog_test_run_skb() uses this
> >
> > Shouldn't it get renamed to e.g. eth_type_trans_slow() to avoid this
> > confusion?
> 
> This was my initial idea, but this would make the patch a bit more
> invasive and touch bpf selftests, something like:
> 
> Let me know if I should send a V2 and CC bpf maintainers, thanks!

I prefer this _slow version as well, less magic.
