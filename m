Received: from mail-yx1-f48.google.com (mail-yx1-f48.google.com [74.125.224.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5269E2AD03
	for <netdev@vger.kernel.org>; Sat, 12 Sep 2026 00:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789173977; cv=none; b=G20ZoR9BRCkIRYKtal8ZLe0GjmGX1+9Ppuvu2ddZ1fbkwATSF2pdygpmxoLwZP2ILHhMEPzfabPnGu7ZOjUjOAgnGtLwNN+C46SZU9nONCxBMiJidqnC0OOrWHjaCbCVfPn8Kqc/pEirQm85kfyAXmQFbFBTSlatmWOz6qsR1SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789173977; c=relaxed/simple;
	bh=iL+C2LsXy0Wgf2fim9VT4dWmhAZjrz1sVNILciJDR1g=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=Ut1ikLiAHiP+CxcxRodlhqyjc6kKfHFc3RXaaVJqfsm4kxJ8p/fKAjqAuQMFC/1uLuHDbKEByEozt9eQMa9EMhgHibgkLRzYlGbBLHowQUz+iwYs3XeK4NI+MF6hvVIFReybbMIhrdcSxh0Dsbe+6I68L4qqK3bU+d/bY5WnMxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NBUCjWRe; arc=none smtp.client-ip=74.125.224.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NBUCjWRe"
Received: by mail-yx1-f48.google.com with SMTP id 956f58d0204a3-67124ad7615so1642824d50.0
        for <netdev@vger.kernel.org>; Fri, 11 Sep 2026 17:46:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789173975; x=1789778775; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=qpY2ifiVCFCG4RgGzpRbm8TVOV7urSCRJ4S4xxBSmR0=;
        b=NBUCjWReBqnKTrM5AtU3VJmcAoEr3Zk6+KXT0IRSKyxtdtGAkW6Ws8aSWf090NZOJ2
         I/GYPpVQRJYRnn4nQBKFZmYzoomdWuAi4+8SGs/ted95fXGlhDt2sX3keQ6BT1wEDEY2
         OVTTIdCL6NOseQ+I5y0pn7Uqn1Oa0xffRIXHIxdrz3/tBGwM5op6i8anzpN+ImuY/5s5
         eXDRXoXtS0hVfYVVu0PWDOjWPwI3FuM9calB6FzDuHiGWUkXOxoj2iY1MJkkKA/5Hv5K
         914Y4dVcxZ+i7+nYPqIK23wu8E+q00VNmuwoUnkcNl0yZzrvSYmbNk2ybMy6YcKGtAvU
         O6cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789173975; x=1789778775;
        h=content-transfer-encoding:content-type:mime-version:subject
         :references:in-reply-to:message-id:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qpY2ifiVCFCG4RgGzpRbm8TVOV7urSCRJ4S4xxBSmR0=;
        b=DXjwhM1GPwtNCERqjQ9OmcIPjpKb5y/emO4XQEeuL1M+NCxTiPlsA7sGWiYQa9fM43
         3qjEgArA7fTFqjiIqR+IRqgp3hzH6Nd76VWo6Hn/Grm1f5G4IImWL4xPwu7SDkPAFRfb
         IXJY9M7elcm+xk3k1zOgr/8fFFudYG44o0NkloZ5l1aroTyHOTDADgdsHhdY3LmLkG26
         v46JwBOKDHPUUxk+OuacMDZuiavf6zl1UlyLWA/hDL2pNxvEzXtE+o7g2QgFQcnwkePn
         uyAZ2fayoAzW5xBBKFJfjTxqor0mPztfxlPdeaMRNDKMwB6Bl+GJF4cO4UJb1/cQ2HmT
         QDhA==
X-Gm-Message-State: AFuF++k0ytOueUNHGAzxzUGf2C0Pm8a28zRrB8omQpJvmm2r/8CUYhSV
	cOEOjqXEOeovAEekitF0YVUkoLc7phwnNhwjqd1rMfVNYBWxezWY7HDk
X-Gm-Gg: AYBFou2rXFKP3ibl8B689M3FsruAYvvXZLRfhUwJiNrnLUQ/P5+YycWb038xdBixOfr
	o7/o5ZfjhNLKl6/B26n35kmQbKItf60oesgjumXV9kpuv7GERwbbp+msNRRczn1aUHBWQHdrvRC
	7T/0pPYwqnZYDaQ7WuP4D01fXTIYTpisVgUFfyZYT17pHTKkM3VeheQehZ9jHgPqHx0qz4zPzNs
	l57pajV/8jcmP12tDoJLez9DAsGsVrwoqolSB6ygJst3SmHAiwqAsiQuqrFnjtCUzqWobLWsHkU
	ulcWk55Gi2EL1eu8rmn8180LX8TQqk50ulSuXOt+OBrGDbwG1zKmVESy98Dm+IZENkadfuLcPIT
	rhcozOp7Ak4/RRURoG0MUwPEgODzZq/UIaE3r3KBc0Sn/S7vt9dJr24Z+bKX+Ey01OjJ0VlPmyc
	GuNXH9l44bEzsupH8OIpSXp8V+mf5vb5mV0vzldDz3b+CEMbMN4bhRxgGvijikNEldk8tbVpyRK
	1tVnvMg7roPqtEiSjlyKXTYS/LJQHWTA49C9uoxIzMuljG9ZS5I
X-Received: by 2002:a05:690e:4395:b0:66f:9e32:100c with SMTP id 956f58d0204a3-6712455c322mr1822320d50.14.1789173975137;
        Fri, 11 Sep 2026 17:46:15 -0700 (PDT)
Received: from gmail.com (234.207.85.34.bc.googleusercontent.com. [34.85.207.234])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67125e78338sm1718565d50.16.2026.09.11.17.46.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 17:46:14 -0700 (PDT)
Date: Fri, 11 Sep 2026 20:46:14 -0400
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev-bot+sashiko@kernel.org, 
 willemdebruijn.kernel@gmail.com
Cc: netdev@vger.kernel.org, 
 davem@davemloft.net, 
 kuba@kernel.org, 
 edumazet@google.com, 
 pabeni@redhat.com, 
 horms@kernel.org, 
 andrew+netdev@lunn.ch, 
 willemb@google.com
Message-ID: <willemdebruijn.kernel.2c67480e5739@gmail.com>
In-Reply-To: <178914679743.219967.4781990764758262872@kernel.org>
References: <20260910171131.2532487-5-willemdebruijn.kernel@gmail.com>
 <178914679743.219967.4781990764758262872@kernel.org>
Subject: Re: [PATCH net-next v9 4/7] idpf: support pacing offload
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

netdev-bot+sashiko@ wrote:
> Thank you for your contribution! Sashiko AI review found 4 potential
> issue(s) to consider:
> =

> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 1 =C2=B7 Low: 2
> =

> - [High] idpf advertises a non-zero netdev->max_pacing_offload_horizon
>   (and therefore programs absolute CLOCK_TAI departure times into the=E2=
=80=A6
> - [Medium] The EDT horizon advertised to the networking core is taken
>   verbatim from firmware and only bounds-checked against U32_MAX, while=
=E2=80=A6
> - [Low] idpf_vport_set_pacing_offload() writes
>   netdev->max_pacing_offload_horizon (idpf_lib.c:832) from the=E2=80=A6=

> - [Low] In idpf_send_get_edt_caps_msg() the firmware-supplied granulari=
ty
>   is a u64 (gran_ns =3D le64_to_cpu(caps.tstamp_granularity_ns)) but is=
=E2=80=A6
> =

> --
> =

> idpf: support pacing offload
> =

> This adds EDT (earliest departure time) support to idpf: EDT capabiliti=
es
> are negotiated over virtchnl, the negotiated horizon is published as
> netdev->max_pacing_offload_horizon, and skb->tstamp is programmed into =
the
> 23-bit timestamp field of the flow scheduling Tx descriptor.
> =

> A few questions below on the capability gating and on the horizon
> encoding.
> =

> > diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net=
/ethernet/intel/idpf/idpf_lib.c
> > index 827c795afcb62..cd1b173e3b276 100644
> > --- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > +++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
> > @@ -817,6 +817,21 @@ static void idpf_attach_and_open(struct idpf_ada=
pter *adapter)
> >  	}
> >  }
> >  =

> > +static void idpf_vport_set_pacing_offload(struct idpf_vport *vport,
> > +					  struct net_device *netdev)
> > +{
> > +	struct idpf_adapter *adapter =3D vport->adapter;
> > +	u32 max_horizon =3D 0;
> > +
> > +	if (adapter->edt_caps.time_horizon_ns &&
> > +	    idpf_is_queue_model_split(vport->dflt_qv_rsrc.txq_model) &&
> > +	    !idpf_is_cap_ena(adapter, IDPF_OTHER_CAPS,
> > +			     VIRTCHNL2_CAP_SPLITQ_QSCHED))
> > +		max_horizon =3D adapter->edt_caps.time_horizon_ns;
> > +
> =

> [Severity: High]
> The commit message says:
> =

>     Negotiate the feature with the device using virtchnl. Support is
>     conditional on
>     ...
>     - PTP to ensure the NIC clock is synced to CLOCK_TAI.

This is the only [High] in the series.

The issue is that PTP support is expected, but this is not an explicit
condition checked before advertising EDT.

Previous versions of the commit message explicitly stated that
preconditions are not always explicitly verified (also: split-queue,
flow-based scheduling, firmware advertises EDT):

  "Do not explicitly check all preconditions. Trust the firmware to
   only advertise EDT when all are met."

The patch now verifies these three other preconditions, so I dropped
that statement from the commit message (on flagging by another bot).

Only now it flags that one condition is still not checked.
If I have to respin, I'll add back a comment.
 =

> [Severity: Medium]
> Can the advertised horizon exceed what the descriptor can encode?  The
> hardware field is 23 bits of granularity units:
> =

> 	drivers/net/ethernet/intel/idpf/idpf_lan_txrx.h:
> 		/* [23:23] Horizon Overflow bit, [22:0] timestamp */
> 		u8 ts[3];

In practice this is not a concern with this hardware. The driver
does not check every condition of a potential faulty or malicious
firmware.
 =

> [Severity: Low]
> Does this validate a different value than the one it then uses?  gran_n=
s is
> a u64, but is_power_of_2() takes unsigned long:
> =

> 	include/linux/log2.h:
> 	static __always_inline __attribute__((const))
> 	bool is_power_of_2(unsigned long n)
> 	{
> 		return n - 1 < (n ^ (n - 1));
> 	}
> =

> IDPF has no "depends on 64BIT" in its Kconfig, so on 32-bit builds the
> upper 32 bits are dropped for the check while ilog2(gran_ns) takes the
> __ilog2_u64 path on the full value.  A response of 0x100000001 truncate=
s to
> 1, passes the check, and yields tstamp_granularity_pow2 =3D 32, which i=
s
> copied into idpf_tx_queue.ts_gran_pow2 and used as the shift in
> idpf_tx_splitq_set_txtime().  The same truncation rejects a legitimate
> granularity of 2^32 on 32-bit.  Would testing the u64 directly, e.g.
> gran_ns & (gran_ns - 1), plus an upper bound, be better here?

Low severity, but good idea if respinning.
 =

