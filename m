Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C64472F95
	for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 10:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791799659; cv=pass; b=rmfDoKf3VJFEsW7ZF99w2+IGdoSS0CMdmnWukW7qF5b0LyvsYwBwGAiJXPFy/wAbQg/4VpLJKucFLq1OMI/xOxlysqj/Utzwli6CsK0U7B61IG2ZsBDXW4h1RLhaYzoPlGDZ5hUDmnzXj2YYD9EnH9kgaYdKjdQj/reVf3CXC5Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791799659; c=relaxed/simple;
	bh=ngoSFJKCcMjqIKaYPLntMoiTZq1+aK2iDToLFmsMqUQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PRRn9yEvJX/VAmqdVv69FubdjRe3fVbW8Nv74+jX6BNY5MVAovJEgmcT0ukH/LRSDWjr4pI7KC4hd+RCPGy3LpwF0zaEU5OFexfr3IonohP0CFc5ET65TCcYENBDXdpNrg5vl5iMtBtrNJtGVWhN7cWmHBUjab1/8aXgC+80H34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YqxeuCqt; arc=pass smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YqxeuCqt"
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-93e4c00d71aso131397785a.3
        for <netdev@vger.kernel.org>; Mon, 12 Oct 2026 03:07:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791799652; cv=none;
        d=google.com; s=arc-20260327;
        b=QrgfpLrqh0tIYt70M1IB2PBzOBUvNo3l0DfoYDKac0BNi+X3SmhR+Roc/tG7qHNExH
         7XS5npT/jpvwr6PA6DNCB+pBCCYBV5CwqW7d3TyaXcs137iJ/OzYKGICcigRLX4C2xUV
         PVeQ4sJCcHtv45zy3yTDWVreiOiWcWzIbYJDMwzUyumKHx1quGlSquj11iSE3Oak05WE
         qcS+oxBr5loyOEYS2bDVgICEQ2Oi1wmxyf/MCCTz8ysW4Hi0aT4YwRKlpOkk2cKfwc67
         u9TKsX+ust+DhVGq932pOOWFn4ZU4n60yOmxCyAv1nLtTPLA/mRyhm2QtZ+nAUnYSTKG
         9vkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=Z3gPxzFUWOWhxxZIc6/y8cCD/Xx0PXySz85Q6RMiuY4=;
        fh=mj/SRP/meHBahfteH+1z0iy7FGokTSghNYibzlB6Xks=;
        b=Dg8yghzPjFMVwnoXLm9MJS3BYilbJqY4fUSEafV4njLs1InjfTGSw4es43tWG9cHdk
         m1+a+J9NvRGliNhinoMC4CWFMbJlF8NnWLSfOodnz2qlXn/MXe6rbDDY8/DGDtAIll+S
         661gWkjyEV8wbRMUvQCvMRZfLyEtSF1F3mEuTrDd0OnFztPQaUWO/YBKGxJqPoZoHDMP
         2qGoAtSZ+ilJGYyfnpUhg2u+/1HKwhFQ/Fc5xCotnEmAqcaz5/l26wA6AuY9tkzvV03B
         rD3nxy9mocN1v5SfgrcB7b3hwvgamnqI7StUzc8I73bTk15M0Kh7OV8p/K0RgSUFF6vq
         0gPg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791799652; x=1792404452; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z3gPxzFUWOWhxxZIc6/y8cCD/Xx0PXySz85Q6RMiuY4=;
        b=YqxeuCqtkxtuUJZJlw95ZalpF1RSjwb3b7ytIvMbj23gOYSs+nMc1EDzPKPzZLBScp
         jNAxh7mZ9VAxqSTuCFpTyIA0S2N1u17shw2Way01dAigJz4QEVOEuaTGdZs8ORvFE2mM
         GnX31er4fJKjo2K73S1UD7sCVCwXDj8Bo/MPlS8pfOSzsejwnmvlNzxK7WybQHO5m1/4
         IKZBU9b9yXnT0Ab9Viq1N6iCypO+rBF8TIaOjy2im3eu+QBEVTRdcB03Rg47+ZomL0C+
         1GvvCdBLunkODaLxh/IF447iPN13Ww39r88FTVxuQrvwuTHWm3VmD3COEtt+zaxKqinl
         SDAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791799652; x=1792404452;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=Z3gPxzFUWOWhxxZIc6/y8cCD/Xx0PXySz85Q6RMiuY4=;
        b=JNsPY/zq7bunIaFLX18whPOMpWSexWaqQbWWtRmSU2a4uk+a5rXTwZ93K3sTBYYdhq
         3xj4hmASrq+PAdjAtF1OyjOwieQZNmQXtN2YKiIKXnAW7kXqeIv1MDdAmLRS5e8gPHCB
         PaZo/dvh6lfZ4mFhMjosTx3RKSWznI83NNFme32MbTOX+znSXuovQVBvIQO+l3oRpYlw
         KOGjXrNa5ggST3Zu7V6zV+G9J3P2nqEdt/nkszOoDZpn8N7/2ULcXMiyV8YDEo1OAMX/
         15fgjob0W+gXyUD1Ls0swUMhE2FxUBg6rVrFvedwedztK99Jr0sg2Rb9RBZpe5B2Gtlk
         HLdw==
X-Forwarded-Encrypted: i=1; AKwUvBxRY9JILftTERvIuSWB92IQvFnVjPbd4UtJtnnHKTvE0vQC+TY13mkUkaxaUMw092mj96sKNsM=@vger.kernel.org
X-Gm-Message-State: AFq9FYL/PnLDv7nvbQQ3gYWdjZuHU1GCewzI/IfJFK7o64GfM3BePGjK
	1EMy3BuWkGly+mASUglB6VL5ISkVOSZtl3R5sApseNS+i/B0n9vorQHe4DAou59JcRfA0n41qZt
	O7zng9bwt6CMd/XfHCeTqf3ywfi3m5V4=
X-Gm-Gg: AYBFou2iTb2uZuiB7bO1lcvphKVisjq1+aiHWo5sVYYLXXoWDdnQJdj5xehaNYqXsCJ
	8sKkEaHU9x1a2NbsU8+qPfBpIn9AMJC0Zymb5vcXmtnO35IAoKA00YlrWb4uljik7t06sadJhSQ
	JMTwev0mScmDbi4MW6YYKhrWw5UU18wkZYRFwwx/8gJbx4cVZT+062WWKlXduC8FrqTX4jdlqpq
	ye4eGggJ07GOJXAA92EoTky8CHd9KmZraRRLQ4aTYaEY3jQ8Hd+qk1o++AW/DWgBtRdeze3Ow/6
	LkrL0IcqHY5Vc1RPSuA+v2GXb7jwmqgsj1P/yk+NmUC5W7oabmFdq2s=
X-Received: by 2002:a05:620a:1725:b0:93e:94f2:adaa with SMTP id
 af79cd13be357-93ebd1ff9e0mr1625320185a.32.1791799651780; Mon, 12 Oct 2026
 03:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261011014803.100454-1-physicalmtea@gmail.com> <20261012015950-mutt-send-email-mst@kernel.org>
In-Reply-To: <20261012015950-mutt-send-email-mst@kernel.org>
From: Jia Jia <physicalmtea@gmail.com>
Date: Mon, 12 Oct 2026 18:06:54 +0800
X-Gm-Features: AclHuK81b6ciDOyZt3Ymreum_6B8T825nAgthHuFC_f3e8ltpzVIpbuECAmYi1w
Message-ID: <CAJwVaM+Lw8kJRbpMrC29QZQeoJUyfCRvic32J2huZFFTyyjekA@mail.gmail.com>
Subject: Re: [PATCH v2] vhost-scsi: do not count PI bytes in the data length
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Mike Christie <michael.christie@oracle.com>, Jason Wang <jasowangio@gmail.com>, 
	Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Nicholas Bellinger <nab@linux-iscsi.org>, virtualization@lists.linux.dev, kvm@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

>
> On Sun, Oct 11, 2026 at 09:48:03AM +0800, Jia Jia wrote:
> > vhost_scsi_handle_vq() moves pi_bytesout or pi_bytesin into the
> > protection sgl and subtracts those bytes from exp_data_len.  The length
> > passed to TCM is still exp_data_len + prot_bytes.
> >
> > prot_bytes comes from virtio_scsi_cmd_req_pi.  With
> > VIRTIO_SCSI_F_T10_PI negotiated, vhost reads that header and does not
> > check that the CDB is a READ or WRITE.  sbc_check_prot() replaces
> > data_length from the CDB only when the protect field is non-zero.
> > target_cmd_size_check() leaves a write's data_length unchanged when the
> > CDB size is smaller, so a command that does not get that replacement
> > keeps a data_length larger than the data sgl.
> >
> > The KASAN report is a MODE SELECT whose header had pi_bytesout set.
> > The data sgl held only the parameter list.  spc_emulate_modeselect()
> > walked data_length and read the next physical page.
> >
> > Pass the data sgl length.  Protected READ and WRITE still take their
> > length from the CDB in sbc_check_prot().
> >
> > KASAN reports:
> >
> >   BUG: KASAN: use-after-free in spc_emulate_modeselect+0x145/0x380 [target_core_mod]
> >   Read of size 1
> >
> >   spc_emulate_modeselect
> >   __target_execute_cmd
> >   target_execute_cmd
> >   vhost_scsi_write_pending
> >   transport_generic_new_cmd
> >   __target_submit
> >   target_queued_submit_work
> >   process_one_work
> >   worker_thread
> >   kthread
> >   ret_from_fork
> >   ret_from_fork_asm
> >
> > Fixes: 9f977ef7b671 ("vhost-scsi: Include prot_bytes into expected data transfer length")
> > Signed-off-by: Jia Jia <physicalmtea@gmail.com>
> > ---
> > v2:
> >   - Drop the claim that target used to subtract prot_length.
> >     9f977ef7b671 cites 14ef9200, which is not in the tree
> >   - prot_bytes comes from virtio_scsi_cmd_req_pi
>
>
> you can mention the other patches you sent fixing
> security maybe this will calm down sashiko.
>

Will do, thanks.

> >
> >  drivers/vhost/scsi.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
> > index 4f8c0260bc9e..4bd29c2ceed9 100644
> > --- a/drivers/vhost/scsi.c
> > +++ b/drivers/vhost/scsi.c
> > @@ -1534,9 +1534,13 @@ vhost_scsi_handle_vq(struct vhost_scsi *vs, struct vhost_virtqueue *vq)
> >                * vhost_scsi_queue_data_in() and vhost_scsi_queue_status()
> >                */
> >               cmd->tvc_vq_desc = vc.head;
> > +             /*
> > +              * exp_data_len is the data sgl. prot_bytes already sit in
> > +              * the protection sgl. Protected READ and WRITE replace
> > +              * data_length from the CDB in sbc_check_prot().
>
> this is barely readable - could you improve pls? even if that makes it
> a bit more verbose.
>

Thanks for the reminder. I'll improve it.

>
>
>
> > +              */
> >               vhost_scsi_target_queue_cmd(nexus, cmd, cdb, lun, task_attr,
> > -                                         data_direction,
> > -                                         exp_data_len + prot_bytes);
> > +                                         data_direction, exp_data_len);
> >               ret = 0;
> >  err:
> >               /*
> > --
> > 2.53.0
>
