Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=185.125.188.123
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1792657094;
	b=ppCsN375xXNsQHQP9kTOHs0qSWLXGZxqZYNMrNvPo9ZOwFhOZMOEtueGeqG4J1FEACwx
	 P7yO5tw6Il5Ms7bmbKZ+ve4xiaMCatIxcgOsnlG4ozxSqEE5kRUgcfowN0d8RvHyfkQFf
	 9Io5XlC+3ugtbtixeKcPalTlNHujQNcag027f55HBNxnBy14jdXr/UBmZBNISBuxnCezQ
	 TTwHRmG+fIwlxhmuD5i1VobCIKqjiTWQfHOMoq1jZ9I9/RjQ1bk7fgyTc2lA+0HrtCrQ+
	 jP1N2QY2Ie8Wmfumxh0+db3xEJgUEP2rrEsX34vGQgjEwmvxS+gdg1q/31GA7qlvhAg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792657094;
	h=DMARC-Filter:Received:DKIM-Signature:Received:
	 X-Google-DKIM-Signature:X-Forwarded-Encrypted:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:X-Received:MIME-Version:References:In-Reply-To:
	 From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding;
	bh=w9B1rmI6/iXDz2kHocCk6wWqdAYeBySRJ/WPhz1fjQc=;
	b=qukIzkCpmbo9RCW9cQDAj5q2Nc1QoR05ZTuA2HQBIlcd0HByu0aw+c8EthzR5iRy+7CP
	 GbK27RyBMkcy4Rxh/rPgGCkJLt+wwtk+X/da3PMmeHt8oRklRx29QMwiLWXktwMowKDB7
	 mM9WbUPjVcwWoV9MiSwX88MftKwqkkjWLZD/c4cx2iec9xsxnpPnobEV1xNxyMTYVHAh1
	 970PKicXyj5MSeNBBO10hgMRIqo4Cgg5Wu0SHvYZsqZ5PYiKBUiG+IVp3ko6tfxVJdARP
	 vVE0K2mpZiuw4gdSkb0wM1wBudHVwYBAKH41vH4fGugpe1Yd+JtoPOaMhKyn0oa8gNA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=canonical.com;
	spf=pass smtp.mailfrom=canonical.com;
	dkim=pass header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=bZ390a8C;
	arc=fail smtp.remote-ip=185.125.188.123
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0D1606A319
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:18:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE0D1606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=bZ390a8C
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com [74.125.82.197])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 2D0543FB7B
	for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 08:18:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1792657085;
	bh=w9B1rmI6/iXDz2kHocCk6wWqdAYeBySRJ/WPhz1fjQc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=bZ390a8CAZTJpXzmD8CBlsSHB2OqlSuB7HfenpJcqESalb8pwDrbNVVRVLM+dEshN
	 QAw52mcXEztgzIgbfEKwMaf3ASS0qvInAX1Zog3nThI2uMizD6y3h8SkzgfMMF/VHA
	 TosbI4cdfhVXfkFNaiSrjGi27WlpWNU6o8akxSr93VA+ehFvPciwarIKKUmCQ9InJ9
	 Y9lDt9Bd8lfZ1/EAmS+Bq7lGFVC7XWb3+Bd71Y5X12Awa+cmn+kUcXEx37xK7+rwNj
	 ialPXdUvGnjDc9Caq7hvE7WNQ5PeEi7oM8HKFZVkIotqg9qtSMPJfDUNOiCgiVWBs1
	 kvPm6da+qe1WF7ZMzJiAx7iBHPuKHhL2JAiAfcae9OHA98607tQnLmiasmJOJjVQe5
	 WdhAuxiQIvN1wqJR4cPHfKLgzMXXsDRE8hH1p5Kc6kdN1963U7jBKOgWT8Y6NE6Lcn
	 lNDR9h1GteL1cK/k2d62YlPwugvXCLnUyU3yTTPWZQOqyzt9PZF+nRPK3Uh1ScQdos
	 Zl9l8A3IAQaRymSz584vqPO24NSeUx4VMnQi7t1HCtl/SAIhPsegCmAmuk5ec9Y+81
	 7fi16BfuEsjA6344xfKqSgrySjA1BYfNBWSFihEiVWmR5IzIz419mMP1tTY1p/BHLv
	 +n/AAUNLNRKb8C0S8aj3KV6c=
Received: by mail-dy1-f197.google.com with SMTP id 5a478bee46e88-359b81ad4e8so2708504eec.0
        for <netdev@vger.kernel.org>; Thu, 22 Oct 2026 01:18:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792657083; cv=none;
        d=google.com; s=arc-20260327;
        b=EiZUs3repgPgdkagV+IEpfJJtm3UKgakrKVDwIJFAj5I80Zq9zb8JtdoUBA6GA5AfY
         vkPa0ioZ3uC2zB14IMkPYlMWOsfNiBengJjNCzDqolAMEGdTbgRCyepK+66RRxCZ/JNP
         zpQmZrZj/9bpw/P7dneqfXtvNcOuHISgW2Aiv5C56vb4NtC33P05q1+pVrX44SWsuWA5
         zobmJ9eQNDG7SscwgZVPNTMTPq3wbsvMV2yTXSYowfld4+8UqRbBkJWLySV3sTlU2jTt
         wPhEa6Hf6aA/1RH27mgS9CYgsRH+eFEyaLPRb/TDiUT37tQ9jmuv2NlSbHWGtE/HCMDK
         EPDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=w9B1rmI6/iXDz2kHocCk6wWqdAYeBySRJ/WPhz1fjQc=;
        fh=zt2jicfkqjVhYI1OieBaldttYseFW5rhMiXU9f8Jpi8=;
        b=EQlgPusxElKF+NghW6zCxMfXyISY/6kWbuBT36BXvp96sPHmDWjvvnnETk1iqirhRo
         +P0hb5FLOSCxYffyO1IFnXLw6gC9KvLkBw275FheuZn2O8hVpUtV//7nhAyqCRDjzs4u
         8NSswO73pVy2pEDpE2xoiM5s8O5cLae2foD1VG3Gu6W4KM81Cxekcu5twjroGQ9XBe6L
         mOUUy0c6YNAAQnNOu/+cwrbUSpgTCzVgtdSsmEICATONlN3wTURDvJdvP2camOH+B3qi
         fHWnoOKc0pTF9CaujLtFzJujw4LRTkcwr8k2WC94xc0Y2oiVIH5ymGacN3uhDO6eDKa5
         9y4g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792657083; x=1793261883;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w9B1rmI6/iXDz2kHocCk6wWqdAYeBySRJ/WPhz1fjQc=;
        b=FPyGkRJ6gQDqTLzsQekEalL4qxces020lP7SL9BIqMxyOtxjku50jgbRr+Ws42G+jg
         0vgk2bvvLAB5uSdoLG9YeATX1P9U6MWkxv65aZKIWRXMHmOnXtACEHFFES4dx5BvypQ6
         nR5U1a+tSs4ASdVk/4LcB/urAEW2ExUmGpaUpQ+xrkcsv0qBbfpwlvSsuQjylQkR3e7a
         4Pp2S6Sieu5EkDkyg9DFA6QRyaH37oGkV6ecejxRyPcpzDOJhDD6VWVxJ5F7OnjREkTO
         ZLCyW0x40+z2TkI4cda0QnKAFvbS/HnfT5mfEMlC9Cy8xdH0SvSr1gAXUprgcjxJXYjU
         jphg==
X-Forwarded-Encrypted: i=1; AKwUvByGfaeqRrGYIwiRsZmuiKUyLbnxbq3zvZM8zmCAkqfP6eBsXTNl+7U45yp+PCOtLJH+Kgafe34=@vger.kernel.org
X-Gm-Message-State: AFq9FYKvAIAZ0Imz+j9k83bfY4dogGbiMw+ogY3W7qIW9kR0MnoBloki
	MBVykGDO31n6zrQUENNJNTbxmNL7/odvGIJKMr9CM4NtcvOXJEFby5Z1orlUx5vZd/16p0z3WP5
	SEK1VXejM8HrUUGSc8lM8d5LaXhs3tiQRqVzk+uzVdf4m7ddk7A1UZ51YbmqRijnb8B59EdrzXv
	AhhR0aB2iaVOidMIv5kpdKr/3GZANzCiCAKkNlHS+L7Biu4zXk
X-Gm-Gg: AYBFou0PgXUp79yNtQkNb2dzlLB1yGZibJLYLDwWa40DdXWryI7Wv84ELFtovVVjxV+
	A0ZzQV9bbCUXtN1dlhb4MH7H657EcrRdMLdU8cuFZr0onSNINYoklxFKVm/dvS3gEB5CYlNzgdE
	QbagzH5B/dII/1X12BdvBCnGR2UBeXCikpSFPacJGZ6oBp79MlSd/xmlWqiuGBui2njeV4qAn9/
	usPqgonVypR8lx/q4oMfs2ozah58mCJ+L+Rd2hPixPq3d5xOxGiaCdLGxITOvAb5DKMTF0OiRJv
	TotA/o3LuIM5lrj3/yYYhVQMcvDh5eIUHVwnYZvbmJA1nzWdpUd3KdC7BKfQVbzNSxBp/Ms=
X-Received: by 2002:a05:7022:158d:b0:193:9568:b42a with SMTP id a92af1059eb24-1939568b477mr1517909c88.8.1792657083320;
        Thu, 22 Oct 2026 01:18:03 -0700 (PDT)
X-Received: by 2002:a05:7022:158d:b0:193:9568:b42a with SMTP id
 a92af1059eb24-1939568b477mr1517875c88.8.1792657082883; Thu, 22 Oct 2026
 01:18:02 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261019105155.3793063-1-aaron.ma@canonical.com>
 <20261019105155.3793063-4-aaron.ma@canonical.com> <CH3PR11MB56689592183937149141CA5D6DE5662@CH3PR11MB566895.namprd11.prod.outlook.com>
In-Reply-To: <CH3PR11MB56689592183937149141CA5D6DE5662@CH3PR11MB566895.namprd11.prod.outlook.com>
From: Aaron Ma <aaron.ma@canonical.com>
Date: Thu, 22 Oct 2026 16:17:51 +0800
X-Gm-Features: AclHuK_MWaUe4Kt9JlOwlYzMGPqVeUahl-zxhu0V2P8ckRAI2qMspUXp9TfYrYA
Message-ID: <CAJ6xRxUcCpwdxpiNijA8G+h8wS=RM8T+uGKc+-t-7Gd2_4ovAw@mail.gmail.com>
Subject: Re: [PATCH 3/5] ice: scope global configuration lock to the adapter
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>, Richard Cochran <richardcochran@gmail.com>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dan Nowlin <dan.nowlin@intel.com>, 
	Brett Creeley <brett.creeley@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>, 
	"moderated list:INTEL ETHERNET DRIVERS" <intel-wired-lan@lists.osuosl.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 7:12=E2=80=AFPM Loktionov, Aleksandr
<aleksandr.loktionov@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Aaron Ma <aaron.ma@canonical.com>
> > Sent: Monday, October 19, 2026 12:52 PM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel, Przemyslaw
> > <przemyslaw.kitszel@intel.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> > David S. Miller <davem@davemloft.net>; Eric Dumazet
> > <edumazet@kernel.org>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> > <pabeni@redhat.com>; Lobakin, Aleksander <aleksander.lobakin@intel.com>=
;
> > Richard Cochran <richardcochran@gmail.com>; netdev@vger.kernel.org;
> > linux-kernel@vger.kernel.org
> > Cc: Dan Nowlin <dan.nowlin@intel.com>; Brett Creeley
> > <brett.creeley@intel.com>; Keller, Jacob E <jacob.e.keller@intel.com>;
> > moderated list:INTEL ETHERNET DRIVERS <intel-wired-lan@lists.osuosl.org=
>
> > Subject: [PATCH 3/5] ice: scope global configuration lock to the adapte=
r
> >
> > ice_global_cfg_lock_sw is a module-global mutex, so a package download
> > on one E810 adapter blocks Admin Queue commands on unrelated adapters i=
n
> > the same system. In addition, the mutex is acquired only after firmware
> > grants the Global Configuration Lock and dropped before firmware
> > releases it, while the opcode exemption list in ice_aq_send_cmd() does
> > not check whether the caller is the lock owner. Non-owning PFs on the
> > same adapter can therefore submit exempted Admin Queue commands or
> > sideband requests while another PF holds firmware ownership.
> >
> > Move the software mutex to struct ice_adapter and record the owning tas=
k
> > across the entire Global Configuration Lock acquisition and release
> > sequence, including the core reset path in ice_cfg_tx_topo(). In
> > ice_aq_send_cmd(), require non-owning tasks to wait on the adapter mute=
x
> > while allowing the owning task to issue the permitted configuration
> > commands. Route the Admin Queue fallback in ice_sbq_send_cmd() through
> > ice_aq_send_cmd() as well.
> >
> > This patch depends on the previous patch in this series.
> >
> > Fixes: c76488109616 ("ice: Implement Dynamic Device Personalization
> > (DDP) download")
> > Signed-off-by: Aaron Ma <aaron.ma@canonical.com>
> > ---
> >  drivers/net/ethernet/intel/ice/ice_adapter.c |  2 +
> > drivers/net/ethernet/intel/ice/ice_adapter.h |  6 ++
> > drivers/net/ethernet/intel/ice/ice_common.c  | 63 +++++++++++++-------
> > drivers/net/ethernet/intel/ice/ice_common.h  |  3 +-
> >  drivers/net/ethernet/intel/ice/ice_ddp.c     |  7 +--
> >  5 files changed, 55 insertions(+), 26 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/ice_adapter.c
> > b/drivers/net/ethernet/intel/ice/ice_adapter.c
> > index 7de9223e971a7..17819c3a172fa 100644
> > --- a/drivers/net/ethernet/intel/ice/ice_adapter.c
> > +++ b/drivers/net/ethernet/intel/ice/ice_adapter.c
> > @@ -65,6 +65,7 @@ static struct ice_adapter *ice_adapter_new(struct
> > pci_dev *pdev)
> >       for (int i =3D 0; i < ARRAY_SIZE(adapter->cpi_phy_lock); i++)
> >               mutex_init(&adapter->cpi_phy_lock[i]);
> >       mutex_init(&adapter->rebuild_lock);
>
> ...
>
> >  /**
> >   * ice_should_retry_sq_send_cmd
> >   * @opcode: AQ opcode
> > @@ -1895,17 +1894,24 @@ ice_aq_send_cmd(struct ice_hw *hw, struct
> > libie_aq_desc *desc, void *buf,
> >               u16 buf_size, struct ice_sq_cd *cd)
> >  {
> >       struct libie_aqc_req_res *cmd =3D libie_aq_raw(desc);
> > -     bool lock_acquired =3D false;
> > -     int status;
> > +     struct ice_pf *pf =3D hw->back;
> > +     struct ice_adapter *adapter =3D pf->adapter;
>
>
> pf->adapter can be NULL during ice_init_hw(), is it ok?

Patch 2/5 moves ice_adapter_get() and the pf->adapter assignment before
ice_init_hw() in ice_probe(), and retains the reference until after
hardware teardown. The reference is also retained across Tx-topology
reinitialization and devlink reload, so pf->adapter is valid during
ice_init_hw() with that patch applied.

Thanks for review,
Aaron

>
> > +
> > +     if (READ_ONCE(adapter->global_cfg_owner) !=3D current) {
> > +             guard(mutex)(&adapter->global_cfg_lock);
> > +             return ice_sq_send_cmd_retry(hw, &hw->adminq, desc, buf,
> > +                                          buf_size, cd);
> > +     }
> >
> >       /* When a package download is in process (i.e. when the
> > firmware's
> >        * Global Configuration Lock resource is held), only the Download
> >        * Package, Get Version, Get Package Info List, Upload Section,
> >        * Update Package, Set Port Parameters, Get/Set VLAN Mode
> > Parameters,
>
> ...
>
> >       /* Since we triggered a CORER, re-initialize hardware */
> >       ice_deinit_hw(hw);
> >       if (ice_init_hw(hw)) {
> > --
> > 2.53.0
>
