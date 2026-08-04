Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9D043C7DD
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 08:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785832665; cv=pass; b=WpGrZG0+HquFTFJIrJp7tGrqsvRHsqhbe2Ohvx/HWv12vDTvNDB5Fx/HD2t4NhAjjpKzm8HaGXOWk55ylKqbpwIcHDHJQXvgFpe1rnoVXDXO9msO0cTE7GAxecGBJJhxlJi/Wm8hh8q8JrR3l+uIMwpEvDmZJ+s7i50fLk5Gzhg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785832665; c=relaxed/simple;
	bh=g13WE+ZHZNFUd7bHV6icamQv5+p7zEb2iX96VPgdsVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pWR8kEFkRAnSfrbPgAN+W+1oVT8VnsRZ1BN9aujfyzoW1M/kRu6ppG/G/UbJfC8q+YOSNT1dYy1JWluYzGOWTkYeA18T4E1bqqw1/nJHv4bC2n8/cNS+uU1hxKVHAjapNTDA/CP2IwZR4Mm728fKXP5V1gFLlrhnb2gopV+tBpM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=jH6oseHL; arc=pass smtp.client-ip=185.125.188.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="jH6oseHL"
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com [209.85.218.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 440C93F978
	for <netdev@vger.kernel.org>; Tue,  4 Aug 2026 08:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1785832660;
	bh=QK2XXQQ2ltf6JIJm9pr2aAQX19gqEISwvzdd/qkFtXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=jH6oseHLZD0nW+2AezxIfZwnVA0jwJNEuhMVpefIdrzNXgco5bG2wuE0bMtY2MQhQ
	 HpU0LjADgfTetREkiKwgBQL1ULc5G85zrIBVB19kSmaVyV7uzz3hHaOyKVV8IAjJa1
	 IVc2tZ00adqmKgCkHQEt/Z7ICrFYy0fxmy+BRyz8ZPS/bCGpKP2DMTDD6UHrEPLAXT
	 XVK9Xd2AReQBY1+cSpEMp8LFPZ/JWJ+hWR8HfvbneWYI/k3T1KlVSLgl1UnOIy9Lp0
	 cAeuGhRK2P9WVORd3v7YJO8ZFSpX/+cMCNuQy33ff31LJM7B66Dhwk8/jc9EGH4Txe
	 Y26AdJ7gzp/PcugTwJfwZacNf9nSsG7yOgvUSvCTInldxma2aDZRN3spHYm9bIPTxU
	 vhiPJAkCPhQjznJJe93BqBGpQRyTkjktI3ALWRzPwRCN4BG9A6zmXlEUx7x0kAeY0g
	 zWKQLIPpAsG78FjFD++X9OIITe4wVyCMX+HAvcltVXiturcIYg2ektwU/ilUI9N8kU
	 OfdFNlg8jWgzbfqEJPE4LeXs/CaWFvJd1IWfBMJptTxlVolSSnIx1ux/LoYd150WKs
	 VVMPqX/JzUtzmbhSi0giCiKfCS9dpgaZ6iuZjEC7DgZCMI/jkelVdEdTPbS0jT7xHq
	 pRy28K6qph+aDg7jQE2Q7j0g=
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-c15d4224f9dso329952566b.3
        for <netdev@vger.kernel.org>; Tue, 04 Aug 2026 01:37:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785832660; cv=none;
        d=google.com; s=arc-20260327;
        b=YwX33Y+bTUMPa5J/aT4ghnc1pMwNt/0INCDoEVmbwX08H/dOEwNRqxgEmXxHucQ1O6
         6IUVEv2uzrKWougUE6fIaGd5Gjlscl3emIafUeom8G5p4nlSvTsrNguKNIwL7Wt+bMPM
         OzH6vlxfq002ROUWaERzt8mVhfEmueuUNb2dzHx5ekb/CQhoyEleUhzYCAnnBbIOlX2/
         KOUhrRqmUM0Q92xgUeLIUVcfxUyTGqvCFEZbS17QdaUKmgngMYi5kZrq9RRV4scsH3VA
         u7VGNMsp9IG/P/VCevxH5mogebXrMyQPlDyZ9GZhwlaYE0eCgL39yB+F0BN/HuXlc0Hu
         lRYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version;
        bh=QK2XXQQ2ltf6JIJm9pr2aAQX19gqEISwvzdd/qkFtXk=;
        fh=bFNbSeVKcDCdVasMXCg4MuCR7/1lrCRGtPL/RCDbLEo=;
        b=UbmPxI/lf9VkemwZr0AEfe27fsEIZcs8sOoyHHB3/ghli+L44eynYNPK//xKblFTsa
         6xOIafyyjV0h8V46+JEptyskxgHk7uXwlMe887AILGci43eiadosZ9cQedmjO4D8drnI
         5nkXCmoVFhqS0gw7+I3/OvsY2ApKgB9WQ5rZacFD0zIAlErrM4PUR/OXfcEkbzJLG3TT
         3861z87NcK9n0k4sSuz/k6n9AzfO3PcR1xKfcG+/Z8qa3vvI548Ephr4qEoj0ZeyvmFZ
         unhwFu6zS3OqO2Xo4mayWQ9vLYmyofOZ3U2zWdiHIX9VTcMITKfVpeElHewhgMJDszln
         zn8w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785832660; x=1786437460;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QK2XXQQ2ltf6JIJm9pr2aAQX19gqEISwvzdd/qkFtXk=;
        b=H55+j4y5dyLiKJ3Z5UqScqLOJ/x6GWQziteTtmMU+/ucJhaAA8SlKxd+LjkK0iA/qC
         GmmbNrlEXY98Jm3KhnOQsMz7MrgElVCbOCutJ+JQS/cWxlaJP+o20SyThD+Tn3kIxpkg
         iqSIkMuTF01l/LccVXdXBHA7bkukJAAbbencP5+bZ61iYfb7G16K5Y8/W/kPHGZPP1zq
         SQ4qH8sQgOpSQRsyNymCGMcWj/nalHP9z6fxYySKwjDzONNPudaMCTrjVvQiTBnzK6lR
         1HDlC9JSaz71FmSeNDKDSrlG61dLp6zwXfWpXCvNhu9E9FhvhbZxvbBMvja32sNPjhwg
         MX5w==
X-Forwarded-Encrypted: i=1; AHgh+Rrt9LsvNn4XQ+N45A37S0iSm2WIMHzIYjOl30XDz2Uz3JweEkdnlrWRI1P4RL2D83WR59nhfV0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/rvTk/s+PU2vfTwUoyBEmpmuk9ukUGjSgyZnjTCM9LsshwDrL
	G/gg7shdKjmp9uVPA8aPD5ogXmQzHrE1bGVJlpnWckWH9G4CQGigqWQqasP7pR+bgxU8ZUaGctn
	Vsm2OI5CbLPrju2sGbYkiX33EbQR5JMIQG/CTF9KEyNrmQBwD5/vdyUWx6CQJasjlKhJ4R8Szhs
	Sy3aIkimsLmpUeHewpnrembeH0OZ1Xj6KFuFbE1nW9ZtisE6Gr
X-Gm-Gg: AR+sD13Q5yIJJKuBfDPURoIR1hqw7C+BUfd92l/iwA6UD3R/fvcFwRprkORVOllKZFz
	r3VXZGFbjNj6K4D2u9R+IZ/VmKtJLzABFiKDht9mHLhypWwd3iWbywhGMRLn2aylRpONTpIBRNF
	Za7CQCMnWcJ0gmsGc9dm0lQJohZBLASHb2jwGo09AwiopTewBzPaIOAzY=
X-Received: by 2002:a17:906:3c1:b0:c16:581a:2a51 with SMTP id a640c23a62f3a-c1fe80c6321mr881100466b.12.1785832659698;
        Tue, 04 Aug 2026 01:37:39 -0700 (PDT)
X-Received: by 2002:a17:906:3c1:b0:c16:581a:2a51 with SMTP id
 a640c23a62f3a-c1fe80c6321mr881097366b.12.1785832659261; Tue, 04 Aug 2026
 01:37:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260731111008.1266444-1-robert.malz@canonical.com> <2e3101ea-13ab-4c9a-913c-999eb15207be@linux.intel.com>
In-Reply-To: <2e3101ea-13ab-4c9a-913c-999eb15207be@linux.intel.com>
From: Robert Malz <robert.malz@canonical.com>
Date: Tue, 4 Aug 2026 10:37:27 +0200
X-Gm-Features: AUfX_mz_Jae7dMx4vYi_J6NQ-TLRVLNHOrhEpeKex3aI5IX41UDwspVk9wh0tZM
Message-ID: <CADcc-bzeA2CeWUttUcPTOhS=4e0k3=NMFS7i4=EgJHe-w=1j4A@mail.gmail.com>
Subject: Re: [Intel-wired-lan] [PATCH iwl v3] ice: acquire NVM lock around
 each flash read
To: Marcin Szycik <marcin.szycik@linux.intel.com>
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexander Lobakin <aleksander.lobakin@intel.com>, Jesse Brandeburg <jbrandeb@kernel.org>, 
	Jacob Keller <jacob.e.keller@intel.com>, intel-wired-lan@lists.osuosl.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Marcin,
Thanks for the review. Changes applied in v4.
I removed ice_read_sr_word_aq instead of ice_read_sr_word as callers
already are using ice_read_sr_word.

v4 ref: https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-2026=
0803/056281.html

Thanks,
Robert

On Mon, Aug 3, 2026 at 12:05=E2=80=AFPM Marcin Szycik
<marcin.szycik@linux.intel.com> wrote:
>
>
>
> On 31/07/2026 13:10, Robert Malz via Intel-wired-lan wrote:
> > FW caps the NVM read lock at a maximum of 3000ms regardless of the time=
out
> > requested via ice_acquire_nvm(). ice_read_flat_nvm() splits a read into
> > multiple ice_aq_read_nvm() commands, one per 4KB sector, all issued und=
er a
> > single lock taken by the caller. Reading a large region can exceed 3000=
ms,
> > so FW reclaims the lock mid-read and the remaining commands might fail.
> >
> > Move the lock acquire/release into ice_read_flat_nvm() so it brackets e=
ach
> > individual ice_aq_read_nvm() command, ensuring the lock is never held
> > across more than one FW read.
> >
> > ice_release_nvm() issues its own AQ command and overwrites
> > hw->adminq.sq_last_status, which some callers inspect after a failed re=
ad.
> > Add an optional read_aq_err output parameter to ice_read_flat_nvm() to
> > capture the failing read's AQ error before the release; callers that ne=
ed
> > it (ice_discover_flash_size() and the ethtool/devlink log paths) use it
> > instead of sq_last_status, others pass NULL.
> >
> > Callers that previously took the lock around ice_read_flat_nvm(),
> > ice_read_sr_word() or ice_read_flash_module() now call them without it.
> > The now-redundant per-block locking in ice_devlink_nvm_snapshot() is
> > dropped.
> >
> > Fixes: e94509906d6b ("ice: create function to read a section of the NVM=
 and Shadow RAM")
> > Signed-off-by: Robert Malz <robert.malz@canonical.com>
> > ---
> > v3:
> > - Log the failure via ice_debug() when ice_acquire_nvm() fails inside
> >   ice_read_flat_nvm(), rather than silently aborting the read.
> > v2:
> > - Replace the save/restore of sq_last_status across ice_release_nvm(),
> >   which could race with a concurrent AdminQ command, with a new optiona=
l
> >   read_aq_err output parameter.
> > - Add missing "Return:" kdoc to ice_read_sr_word().
> > ---
> >  .../net/ethernet/intel/ice/devlink/devlink.c  | 32 ++------
> >  drivers/net/ethernet/intel/ice/ice_ethtool.c  | 16 +---
> >  drivers/net/ethernet/intel/ice/ice_nvm.c      | 79 +++++++++++--------
> >  drivers/net/ethernet/intel/ice/ice_nvm.h      |  2 +-
> >  4 files changed, 59 insertions(+), 70 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink.c b/drivers=
/net/ethernet/intel/ice/devlink/devlink.c
> > index 22b7d8e6bd9e..5a1ab9654fb8 100644
> > --- a/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > +++ b/drivers/net/ethernet/intel/ice/devlink/devlink.c
> > @@ -1856,6 +1856,7 @@ static int ice_devlink_nvm_snapshot(struct devlin=
k *devlink,
> >  {
> >       struct ice_pf *pf =3D devlink_priv(devlink);
> >       struct device *dev =3D ice_pf_to_dev(pf);
> > +     enum libie_aq_err read_aq_err =3D LIBIE_AQ_RC_OK;
>
> RCT
> Also scope can be reduced.
>
> >       struct ice_hw *hw =3D &pf->hw;
> >       bool read_shadow_ram;
> >       u8 *nvm_data, *tmp, i;
> > @@ -1891,26 +1892,16 @@ static int ice_devlink_nvm_snapshot(struct devl=
ink *devlink,
> >       for (i =3D 0; i < num_blks; i++) {
> >               u32 read_sz =3D min_t(u32, ICE_DEVLINK_READ_BLK_SIZE, lef=
t);
> >
> > -             status =3D ice_acquire_nvm(hw, ICE_RES_READ);
> > -             if (status) {
> > -                     dev_dbg(dev, "ice_acquire_nvm failed, err %d aq_e=
rr %d\n",
> > -                             status, hw->adminq.sq_last_status);
> > -                     NL_SET_ERR_MSG_MOD(extack, "Failed to acquire NVM=
 semaphore");
> > -                     vfree(nvm_data);
> > -                     return -EIO;
> > -             }
> > -
> >               status =3D ice_read_flat_nvm(hw, i * ICE_DEVLINK_READ_BLK=
_SIZE,
> > -                                        &read_sz, tmp, read_shadow_ram=
);
> > +                                        &read_sz, tmp, read_shadow_ram=
,
> > +                                        &read_aq_err);
> >               if (status) {
> >                       dev_dbg(dev, "ice_read_flat_nvm failed after read=
ing %u bytes, err %d aq_err %d\n",
> > -                             read_sz, status, hw->adminq.sq_last_statu=
s);
> > +                             read_sz, status, read_aq_err);
> >                       NL_SET_ERR_MSG_MOD(extack, "Failed to read NVM co=
ntents");
> > -                     ice_release_nvm(hw);
> >                       vfree(nvm_data);
> >                       return -EIO;
> >               }
> > -             ice_release_nvm(hw);
> >
> >               tmp +=3D read_sz;
> >               left -=3D read_sz;
> > @@ -1945,6 +1936,7 @@ static int ice_devlink_nvm_read(struct devlink *d=
evlink,
> >  {
> >       struct ice_pf *pf =3D devlink_priv(devlink);
> >       struct device *dev =3D ice_pf_to_dev(pf);
> > +     enum libie_aq_err read_aq_err =3D LIBIE_AQ_RC_OK;
>
> RCT
>
> >       struct ice_hw *hw =3D &pf->hw;
> >       bool read_shadow_ram;
> >       u64 nvm_size;
>
> ...
>
> >  /**
> > - * ice_read_sr_word - Reads Shadow RAM word and acquire NVM if necessa=
ry
> > + * ice_read_sr_word - Reads Shadow RAM word
> >   * @hw: pointer to the HW structure
> >   * @offset: offset of the Shadow RAM word to read (0x000000 - 0x001FFF=
)
> >   * @data: word read from the Shadow RAM
> >   *
> > - * Reads one 16 bit word from the Shadow RAM using the ice_read_sr_wor=
d_aq.
> > + * Reads one 16 bit word from the Shadow RAM using ice_read_sr_word_aq=
.
> > + *
> > + * The NVM lock is acquired and released internally by ice_read_flat_n=
vm()
> > + * around the FW read, so this function must be called without the loc=
k held.
> > + *
> > + * Return: zero on success, or a negative error code on failure.
> >   */
> >  int ice_read_sr_word(struct ice_hw *hw, u16 offset, u16 *data)
> >  {
> > -     int status;
> > -
> > -     status =3D ice_acquire_nvm(hw, ICE_RES_READ);
> > -     if (!status) {
> > -             status =3D ice_read_sr_word_aq(hw, offset, data);
> > -             ice_release_nvm(hw);
> > -     }
> > -
> > -     return status;
> > +     return ice_read_sr_word_aq(hw, offset, data);
>
> ice_read_sr_word() is now a wrapper - can we remove it and use
> ice_read_sr_word_aq() directly?
>
> >  }
> >
> >  /**
> > @@ -856,20 +876,18 @@ int ice_get_inactive_netlist_ver(struct ice_hw *h=
w, struct ice_netlist_info *net
> >  static int ice_discover_flash_size(struct ice_hw *hw)
> >  {
> >       u32 min_size =3D 0, max_size =3D ICE_AQC_NVM_MAX_OFFSET + 1;
> > -     int status;
> > -
> > -     status =3D ice_acquire_nvm(hw, ICE_RES_READ);
> > -     if (status)
> > -             return status;
> > +     int status =3D 0;
> >
> >       while ((max_size - min_size) > 1) {
> >               u32 offset =3D (max_size + min_size) / 2;
> > +             enum libie_aq_err read_aq_err =3D LIBIE_AQ_RC_OK;
>
> RCT
>
> >               u32 len =3D 1;
> >               u8 data;
>
> ---8<---
>
> Thanks,
> Marcin
