Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A4EE3F0AA9
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 11:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785496444; cv=pass; b=AjugDjJvlJWFuxHctA2G1yoUwFHKRPkybeAQK5cynK7m9SdMyN+ccQKLwSKSUbyBHxwvBO+z3ga3icEPjS59s8leQCjf0grmVkxBP4cqpXco+0UK7oHk/+TUkLpuk4B1jKjy/bfCnNEgMyB2PD7bxiCQQg/77HCElMNYca7oMaA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785496444; c=relaxed/simple;
	bh=oZsJpVaNEkQDcHixw3LBHnxAomUzHf9H9YdzNddkPzk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qR5fO0RA1iaLNH+Xi7XRq7pgQcCG+jg4q0UHnMwwGNqDE18DxktISI5mh/KB8CBt+lDiBwg0sJA3sMGdahGogGmknSqTFLdO9wRx3aZOGmD8iqefmPLQ/2R0yQ+HZo5x/poOUpu0h+oZU1QdptjN8P7bEreDqrny2U5iYwwpzTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=aJOsqBaO; arc=pass smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="aJOsqBaO"
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com [209.85.218.70])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 1CA583FC09
	for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 11:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1785496440;
	bh=wAU2ZewH0WgY1G+zytmo33JeSOSlAxzihbl4tS+Xfw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=aJOsqBaOVUroornroTImHQ7/bUdleSXMBnqykBJHblOAIMmGGTLqrHlBflNDPZcJN
	 k8J2/lhjk7bWoSg9k8TQPnTOR3XqwZSUgaiYYifPRL6yGwPfBCJCMkBWwO3r+zKKFC
	 bBapLV5yhJVC/BIFU+OumZ6gaf0I2AxM3/zjQzLPjVdPdfWq632nF7YzPz2zUpncNT
	 OY/3Kc/7kSr0Kl1uFOTrRDu7n3Wo7DoeOoWPldbXKc3voG0cztiz+s0v+W1TRCHop0
	 5ZdSn2q17+94YmC2Xef1igxJnPGaqoSnsptR2nLwAtDyWxphHxJWuKjeIHHfK6R9re
	 s4BGNSRFl9DW+18hkRwGfg8VZwZa2Lyh+AHdaouDietF0cPVChwgo1S+SV2uItTNsy
	 jMVbZ8MMUIaNjSI0roNA6VVtV7vNHgBcXLpmCmPF7sUvP32NoDOGUda/vgqK1iILM6
	 lJ7iFHJn6iq2ciMMEsjhtrc66guO7yr75DAM2YekwfqBNHC2WYEGKYVZmDOjBpvTR9
	 zP6eRx0XATLJmF+CiNSVUBUNDGnRxk0UERQa/EUYHXN66M1Z7Iaq+ShfmXYNVWLvPE
	 dsFkaHilpvOoTpx5+oLlEWbo5468030NMPRX3WRyKnhh0wrJOWjizAHWY3AEgh57mp
	 M9HtRAgPy5POGUXvSP1oJsLg=
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-c1c232fa136so119259566b.0
        for <netdev@vger.kernel.org>; Fri, 31 Jul 2026 04:14:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785496439; cv=none;
        d=google.com; s=arc-20260327;
        b=liNUZ6KU88ivkhfE3WGuqk6qUWKnCFGzoAppFYq1m5W9cM/xHLvjafetBVtp+3prcc
         tZM73EpC4oR0XtDePwremfB/1WD51WcZ8EhBquk9IG7BgDOhvbEhp3DELjuiJBhIAVpK
         4p67ANlgXI7lKZwUCqMpzvYcMbgi9gbWPabhKeBRvpPQ8U7GbY/7l3PHZ83OgCFXxGlg
         Ool2ag4e5N3YoeCqE7EbdxN/+b9hksmvRzzC7QUbAPkZjKS95w0v3TdqyhxV1nGYenKV
         BuGYaQMbB8Vbh2sK6OieqOuRcVmd1yWDYEGuNeH9dIebNHT658RO+RdOIcVjm/Qtubsx
         75gg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=wAU2ZewH0WgY1G+zytmo33JeSOSlAxzihbl4tS+Xfw8=;
        fh=cgMkmj2gBuBRNHNZyvHcYeO+Ie2teP2uKkXmykQL/zM=;
        b=s12PT5sSUdV9KIwsPjodP1vuCXUoJ2aumUNMHFMJAIonC4yghCagTdjH2CnTRa/eS7
         4ALzYUHWPuyq/Pp/7dSUCLz9v6s2i27joWdAp8GO9lPggw2qWa4I/3+I5UXiswaiTjke
         WEGn5d1d1MJNvr4n3XFybXHHGuus3a94Ii87pUNxA3qFzRKMFoz7ntxNgKivLV7VjMf5
         hsUKEiGqzDzLEAL/pOOLC+9a8YuC7vG6M2/Tew/UPBpmwILjzLio/jyijf++Y/zYuVAm
         WXbz7VBBqLqX0NyBhkQHPAflWIkcK6Yz1IYOBebnkW99KWtIPbAnWCSjhp2/qiZ4/PUc
         e2xg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785496439; x=1786101239;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=wAU2ZewH0WgY1G+zytmo33JeSOSlAxzihbl4tS+Xfw8=;
        b=B6FPgpdPlz59qi40skuZO+pLehW8morSu306SxxQAos3jZwn+JtFPP+240TbVWlOz9
         fPUkcjZULHGH23y875GJqVlp0zFbppzgrXbSZqoaDQPi0+5m87sdmHfDAIT8SImqxGkb
         l5gzV5T7xoqV2PQxPJubYuAo2UnObgBvme9dR3NT7qazTsEtoRxyYK21y0s74e3qgSUL
         sp63B15P+4JyezZm/qmHYlEINF0ekMpgSlUgGojONGMtjN01hMivF9Iq5ZqAefX3KBzo
         6jUOaLOBKg4j93uZChrbfk6N6NanHX2dmPVSaB6QmRrJtzNKesan7yGGHgc2vDDv+93h
         QKvw==
X-Forwarded-Encrypted: i=1; AHgh+Rp1i3GGQTIJioG8bOxjX/2zf/bheTGYvluaC2uUIrQDp9MzQGkyVVHxuRTIWnxZTh7cUhnr/D0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXONmVHCVDonRU5OIj9xZVHyLmEKlb5C4TItz0m0TdBFg4bMJV
	/WEf/tg4VBIx3u6zSzZvLTjHZhEEdg4Zf03ihUpGBMi8/1/yUTJ1jTxk1dxYO+5mQTiyj4e3hcU
	ZS7AV+2E8DOAqOOwLtxutaZUuG8EsB7l9YwtL5z/vzIu38Ucjv5XexuCJltZYOk3NNmilS2V5KI
	useAEidzEdwDiLl9uo2YkdsOE/vcpzJPZdEqrmk4oUpgIAzwbX
X-Gm-Gg: AR+sD11S9vgkEgGm3RFrJ3uI4qwZhVrF2lXgIsyPAJHF99LgqFgEUN+DjGhIv5yGpO5
	S6wiIqKRCbCXAozABfTFeXKapmgLG2ZxXSbRULV9GF9c07+hSpjPgLoNbUoIwHWcaiKC9Eotq3z
	Py9/Dd0HymXhvRzPg1MW4KSoszrO+v+41751GZlylWvj1nDAzeD6fDa/8=
X-Received: by 2002:a17:907:c24:b0:c16:aee0:5422 with SMTP id a640c23a62f3a-c1fd3168c63mr90468866b.6.1785496439598;
        Fri, 31 Jul 2026 04:13:59 -0700 (PDT)
X-Received: by 2002:a17:907:c24:b0:c16:aee0:5422 with SMTP id
 a640c23a62f3a-c1fd3168c63mr90465666b.6.1785496439129; Fri, 31 Jul 2026
 04:13:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260717121224.3908963-1-robert.malz@canonical.com> <IA3PR11MB8986E2BE513E6BA3AEAABE6EE5CC2@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB8986E2BE513E6BA3AEAABE6EE5CC2@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Robert Malz <robert.malz@canonical.com>
Date: Fri, 31 Jul 2026 13:13:47 +0200
X-Gm-Features: AUfX_mzoxeJQ5WIo0tJ5aZ1g3dKP61ZkHXfa_nLqpwgqBsAVQgT0uwWoKQPDRbs
Message-ID: <CADcc-bxGVRYK3GfYa_sCaFgQV1EvwOzm+mxFuV4eG_XPgoPBKQ@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl v2] ice: acquire NVM lock around
 each flash read
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Lobakin, Aleksander" <aleksander.lobakin@intel.com>, "Keller, Jacob E" <jacob.e.keller@intel.com>, 
	Jesse Brandeburg <jbrandeb@kernel.org>, 
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>, 
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Aleksandr,
Thanks for the review.
Added debug logs instead of warning as some callers are already
logging errors in case of ice_read_flat_nvm failure.
Let me know if that works for you.

v3 for reference:
https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20260727/056=
245.html

Regards,
Robert


On Mon, Jul 27, 2026 at 10:27=E2=80=AFAM Loktionov, Aleksandr
<aleksandr.loktionov@intel.com> wrote:
>
>
>
> > -----Original Message-----
> > From: Intel-wired-lan <intel-wired-lan-bounces@osuosl.org> On Behalf
> > Of Robert Malz via Intel-wired-lan
> > Sent: Friday, July 17, 2026 2:12 PM
> > To: Nguyen, Anthony L <anthony.l.nguyen@intel.com>; Kitszel,
> > Przemyslaw <przemyslaw.kitszel@intel.com>; Andrew Lunn
> > <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> > Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> > Abeni <pabeni@redhat.com>; Lobakin, Aleksander
> > <aleksander.lobakin@intel.com>; Keller, Jacob E
> > <jacob.e.keller@intel.com>; Jesse Brandeburg <jbrandeb@kernel.org>
> > Cc: Robert Malz <robert.malz@canonical.com>; intel-wired-
> > lan@lists.osuosl.org; netdev@vger.kernel.org; linux-
> > kernel@vger.kernel.org
> > Subject: [Intel-wired-lan] [PATCH iwl v2] ice: acquire NVM lock around
> > each flash read
> >
> > FW caps the NVM read lock at a maximum of 3000ms regardless of the
> > timeout requested via ice_acquire_nvm(). ice_read_flat_nvm() splits a
> > read into multiple ice_aq_read_nvm() commands, one per 4KB sector, all
> > issued under a single lock taken by the caller. Reading a large region
> > can exceed 3000ms, so FW reclaims the lock mid-read and the remaining
> > commands might fail.
> >
> > Move the lock acquire/release into ice_read_flat_nvm() so it brackets
> > each individual ice_aq_read_nvm() command, ensuring the lock is never
> > held across more than one FW read.
> >
> > ice_release_nvm() issues its own AQ command and overwrites
> > hw->adminq.sq_last_status, which some callers inspect after a failed
> > read.
> > Add an optional read_aq_err output parameter to ice_read_flat_nvm() to
> > capture the failing read's AQ error before the release; callers that
> > need it (ice_discover_flash_size() and the ethtool/devlink log paths)
> > use it instead of sq_last_status, others pass NULL.
> >
> > Callers that previously took the lock around ice_read_flat_nvm(),
> > ice_read_sr_word() or ice_read_flash_module() now call them without
> > it.
> > The now-redundant per-block locking in ice_devlink_nvm_snapshot() is
> > dropped.
> >
> > Fixes: e94509906d6b ("ice: create function to read a section of the
> > NVM and Shadow RAM")
> > Signed-off-by: Robert Malz <robert.malz@canonical.com>
> > ---
> > v2:
> > - Replace the save/restore of sq_last_status across ice_release_nvm(),
> >   which could race with a concurrent AdminQ command, with a new
> > optional
> >   read_aq_err output parameter.
> > - Add missing "Return:" kdoc to ice_read_sr_word().
> > ---
> >  .../net/ethernet/intel/ice/devlink/devlink.c  | 32 ++------
> > drivers/net/ethernet/intel/ice/ice_ethtool.c  | 16 +---
> >  drivers/net/ethernet/intel/ice/ice_nvm.c      | 76 +++++++++++-------
> > -
> >  drivers/net/ethernet/intel/ice/ice_nvm.h      |  2 +-
> >  4 files changed, 56 insertions(+), 70 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > index 22b7d8e6bd9e..5a1ab9654fb8 100644
> > --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > @@ -1856,6 +1856,7 @@ static int ice_devlink_nvm_snapshot(struct
> > devlink *devlink,  {
> >       struct ice_pf *pf =3D devlink_priv(devlink);
> >       struct device *dev =3D ice_pf_to_dev(pf);
> > +     enum libie_aq_err read_aq_err =3D LIBIE_AQ_RC_OK;
> >       struct ice_hw *hw =3D &pf->hw;
> >       bool read_shadow_ram;
> >       u8 *nvm_data, *tmp, i;
> > @@ -1891,26 +1892,16 @@ static int ice_devlink_nvm_snapshot(struct
> > devlink *devlink,
> >       for (i =3D 0; i < num_blks; i++) {
> >               u32 read_sz =3D min_t(u32, ICE_DEVLINK_READ_BLK_SIZE,
> > left);
> >
>
> ...
>
> >  {
> >       u32 inlen =3D *length;
> >       u32 bytes_read =3D 0;
> > @@ -92,12 +102,27 @@ ice_read_flat_nvm(struct ice_hw *hw, u32 offset,
> > u32 *length, u8 *data,
> >
> >               last_cmd =3D !(bytes_read + read_size < inlen);
> >
> > +             status =3D ice_acquire_nvm(hw, ICE_RES_READ);
> > +             if (status)
> Silent lock failure without any traces in dmesg looks scary!
> I'm pretty sure we need at least log an warning or error.
> > +                     break;
> > +
>
> ...
>
> >  int
> >  ice_get_pfa_module_tlv(struct ice_hw *hw, u16 *module_tlv, u16
> > *module_tlv_len,
> >                      u16 module_type);
> > --
> > 2.34.1
>
