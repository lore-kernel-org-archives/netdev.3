Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD6E241DE14
	for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 12:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784204189; cv=pass; b=MFzF1Y7GCsJrcLx9cCHwfkPluULXgKOoxTUMwdpOOlXYcV7uq0Q2M4VafDnUo821VMlHbIBSltmDtCN+DcJI/6A6MpD6TW6u0FDRmIBCZZxA6usjhgsoXuk/FT4dKVJvZMp+n+0ipflq+UQ2jCHxHGslltxcgeGu2DPLwVkEOr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784204189; c=relaxed/simple;
	bh=OI5CR551vZ38Fw1JyzAypqs6isFToLHGY9xedqEEwUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+zO2w1T8R6lsGA6BRCFlMG/+jW1GpmLW+2h0zH0RfrGGboIkueKa9o0OMmLEWr/MVduLrtSQF3gwSYxvb70k3YWoQihAcfZ6QqTYfIe2UAyJh3nxX2LU2T3T656rHRvR+Izdb7HagbgW3/YtDPye2/IURS2ekb8iiHi1zWHol0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bG73Slvx; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bG73Slvx"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b0117dda13so2979538e87.0
        for <netdev@vger.kernel.org>; Thu, 16 Jul 2026 05:16:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784204169; cv=none;
        d=google.com; s=arc-20260327;
        b=RQ1N2wL3LxuxpmCC1OoidYBEJxsfTV7xnjmO5jyxT3fQscuV4B0inPm3UY3YFGCqX/
         uRY23/9/XEZaHTrsRhWMH0VV6BX7Sy3P++0s+PQVAwoPa28iFfo0XKeVrwHG0M/48Ba9
         lrz6dDQNjcSQbBcB5DKPmzux+/oTO6JX8B6RYuvS8FGSv5/5vL116vfhMqYzwcyTx4um
         YrES3ZUfQSLTE6j5u9s4nO3qbxXrtbjYHcPm9mr/nvzZ2tpSdMElVhe0wMlkk56pVn77
         LE3H0JVRFifAqVcW/IZXTQwK959jHrmq6BKryyhIdIfxttAZ19tZHrKcCq/KYqs93ptC
         oiXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=DvPcLTIf8tzenpklFTitrlKKvKQ7nhdgU0jncYQi+RE=;
        fh=iQyfmahMB3C/1k5ZOqTpS1ZCAShbyOWo1k7gUDQ9Q6o=;
        b=qiEngRlbiwYsNv4VXkj9rBjC9b9DLpIEuI8FZDtNH+dxhYcHqvXmmVQ6hcjJCirH36
         zYO7PCa8KPxVs3kbqRcvhn6modgUNgmaGSXysLdJy2pp0UPc3z4vWxr1dLT6h0GhgEYR
         gMa9zvxegsFlwarLCT8TTqVcOZtRMq9nGWLsen06TIdCZs1klcvzUoJ8nDnUg/OvNE0z
         6n72tIb0S8dT8V2HKhXK+uvLS+9UEETOFLa0f5SAnSbhsbUv2xQYIJPNMHBPIRyDOeHH
         dEJ8kCWKJLIJpWl9qsC3TBbQ9W7V0Q6RMlPIPpTMHYFCn3+Fp+qme2/jYi+GM1zQphxl
         20vQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784204169; x=1784808969; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DvPcLTIf8tzenpklFTitrlKKvKQ7nhdgU0jncYQi+RE=;
        b=bG73SlvxuAq3lrT+7hYy0v2BN6gwq+ym+ffDHO9SvyAkSck04d5gKymRrXmSMtQoWj
         jXDKhECcQbGLVa5G6gIS98AgiRp+NwSmVsxNNnOX4J+X0oU22ZLujlwgOwYwHbfggyLZ
         w647QeYkgwAlDb9e4FJcuVlf2NDr9vZ/+YCghIwVgoFkLs5PmNOD7rmQepYqZa9w5VB4
         qrAxWb5M28cP0VPnGCa9aJ7Yjr6aYnGUDQHWGRo+9VwMoBrrihlXVGe0v3V59G+/KZps
         8egEGgy8M0U01f/89RRlW8ZD7pPI2A7CE0PyADpb0OsGOanoUl7Cfh9GTz4qBkvKZhNg
         fGCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784204169; x=1784808969;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DvPcLTIf8tzenpklFTitrlKKvKQ7nhdgU0jncYQi+RE=;
        b=f5sWg8tPYn7z/2f9BzHJ3RB26ui/wTl9KTkZOW3I0MmPNfLMatUGwkyzMfAlfLQRjN
         f1Qza8//SU+cMwlU6NBy7KUQ/42NNZyV/zk7Yj3du/C+tESeO7SN4O4rSvGY6Q88Fdg5
         cTJkiNC3prn0QtW3rT7Straf8gkBxaDuao+6WUxxNyAkEOUqfZSntnPkw9lXH5Vjs02R
         nRBMS+bJycB0Ghnxpj+XNa+YiqZyacBkis89awfT+qcOe4M7Wq4ZTQE01Nh3KrpMzgHS
         YhyGJ+cyHo6b3QLD9QVoekYeU5ezAaZSXXKsf5/E75yWb6QkCWOayoWWCT886Hez9Po2
         GZ4Q==
X-Gm-Message-State: AOJu0Yx6Mhf2/A7QymPQ4XmIQHXkhfXJhdvK74Re34fQLZzS65BoJBHU
	JXJzkwGDpA6+9kCgR2Hn6c1UwZpshF0mrmiviV3xqM2KFmF8JreIMpvejDCx7IO/uHvTLvh2nTr
	qoMSXgyqS41t6WQ6paGzybG1WaR6vpSw=
X-Gm-Gg: AfdE7cn50GpQOskHGZZED+rrcj8DEy9MUNfzjQJ7bq/CVCZdR0iHiRpNV990tW2i5Pd
	lDgtl0oWyvc/0LOQ8Lob002iQDq/e/pF+c2hQEqhopNS7tN0haJPgAr+k3dfPbm+YOXCHPynzh4
	74u887ssijRZE9EeYSUFZwZtlN2qndeQlbeDAyNPE3QRgrdwuP8vbBBRmRgXNrM/BahFjTIeroD
	LmwKX6O8BzTpKdA5Dwsi3+jvenENVgo+/mlr3Ibx1ASk5MlFcp4mo2HTOTgCjB/7Q3/KbtBsj+2
	E87vMCn1/J72G++JNOL9J7IE9GrCp0qH3pDdrEKa8uFBIhiSAm9PC9U+/yF1oaJ47EEOL4fPw/L
	X4Q==
X-Received: by 2002:a05:6512:61b:20b0:5b0:1f7c:254d with SMTP id
 2adb3069b0e04-5b0236bffb9mr3464136e87.58.1784204168645; Thu, 16 Jul 2026
 05:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260714140722.111645-1-maciej.fijalkowski@intel.com>
 <20260714140722.111645-2-maciej.fijalkowski@intel.com> <CAL+tcoAc7d8MSCqK23_pmL2G8tSS-MpfM53brijPntv5A+BA2Q@mail.gmail.com>
 <ali/sIjljiNm9RmI@boxer> <CAL+tcoBGJDC-Kx=qvxoQtd4BUPCDBv00Gta1SOvejx9nNvVo3w@mail.gmail.com>
 <aljF91Tx804Lcwyx@boxer>
In-Reply-To: <aljF91Tx804Lcwyx@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 16 Jul 2026 14:15:28 +0200
X-Gm-Features: AUfX_my_rcqL11Tq6EEIJwAiGe0ryqzI-IibSTvULZhec0d8Qy7DxzNB3yWQCUk
Message-ID: <CAL+tcoCz+eMqpZoEB7JVHazzeQpMk-Yn917W0EBGtRbFBoq0mw@mail.gmail.com>
Subject: Re: [PATCH v3 net 1/6] xsk: fix buffer leak in xsk_drop_skb() for
 AF_XDP multi-buffer Tx
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	stfomichev@gmail.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	bjorn@kernel.org, Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 16, 2026 at 1:52=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> On Thu, Jul 16, 2026 at 01:42:28PM +0200, Jason Xing wrote:
> > On Thu, Jul 16, 2026 at 1:25=E2=80=AFPM Maciej Fijalkowski
> > <maciej.fijalkowski@intel.com> wrote:
> > >
> > > On Thu, Jul 16, 2026 at 01:22:24PM +0200, Jason Xing wrote:
> > > > On Tue, Jul 14, 2026 at 4:08=E2=80=AFPM Maciej Fijalkowski
> > > > <maciej.fijalkowski@intel.com> wrote:
> > > > >
> > > > > From: Jason Xing <kernelxing@tencent.com>
> > > > >
> > > > > This patch is inspired by the check[1] from sashiko. It says when
> > > > > overflow happens, the address of cq to be published is invalid.
> > > > > Actually the severer thing is the whole process of publishing the
> > > > > address of cq in this particular case is not right: it should tru=
ely
> > > > > publish the address and advance the cached_prod in cq as long as =
it
> > > > > reads descriptors from txq.
> > > > >
> > > > > The following is the full analysis.
> > > > > xsk_drop_skb() is called in three places, which all discard a par=
tially
> > > > > built multi-buffer skb:
> > > > > 1) xsk_build_skb() -EOVERFLOW error path: packet exceeds MAX_SKB_=
FRAGS
> > > > > 2) __xsk_generic_xmit() post-loop cleanup: an invalid descriptor =
in
> > > > >    the TX ring prevents the partial packet from completing
> > > > > 3) xsk_release(): socket close while xs->skb holds an incomplete =
packet
> > > > >
> > > > > In all three cases, the TX descriptors for the already-processed =
frags
> > > > > have been consumed from the TX ring (xskq_cons_release), and CQ s=
lots
> > > > > have been reserved. However, xsk_drop_skb() calls xsk_consume_skb=
()
> > > > > which cancels the CQ reservations via xsk_cq_cancel_locked(). Sin=
ce
> > > > > the buffer addresses never appear in the completion queue, usersp=
ace
> > > > > permanently loses track of these buffers.
> > > > >
> > > > > Fix this by letting consume_skb() trigger the existing xsk_destru=
ct_skb
> > > > > destructor, which already submits buffer addresses to the CQ via
> > > > > xsk_cq_submit_addr_locked().
> > > > >
> > > > > Note that cancelling the descriptors back to the TX ring (via
> > > > > xskq_cons_cancel_n) is not a appropriate option because an oversi=
zed
> > > > > packet that always exceeds MAX_SKB_FRAGS would be retried indefin=
itely,
> > > > > which is an obviously deadlock bug in the TX path.
> > > > >
> > > > > Also move the desc->addr assignment in xsk_build_skb() above the
> > > > > overflow check so that the current descriptor's address is record=
ed
> > > > > before a potential -EOVERFLOW jump to free_err, consistent with t=
he
> > > > > zerocopy path in xsk_build_skb_zerocopy().
> > > > >
> > > > > [1]: https://lore.kernel.org/all/20260425041726.85FB3C2BCB2@smtp.=
kernel.org/
> > > > >
> > > > > Fixes: cf24f5a5feea ("xsk: add support for AF_XDP multi-buffer on=
 Tx path")
> > > > > Signed-off-by: Jason Xing <kernelxing@tencent.com>
> > > >
> > > > Maciej, maybe your tag is missing here?
> > >
> > > IIRC this has been taken as-is from your patchset. The next one has b=
een
> > > touched in few ways and I included my co-developed tag there.
> >
> > Yep, I mean maybe you can simply drop your reviewed-by or acked-by tag
> > here if you approve.
>
> I see. I am not sure what are principles for such cases, I could assume
> that if I include this as a sender then it implies my ack on such change.
> Anyways I can just:
>
> Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

Thanks.

>
> BTW now I reminded myself I dropped Stan's tags in whole set. I think it
> was of changes on 4/6, otherwise I don't have other excuse.
>
> So Jason if you bump at Stan somewhere in the netdevconf's hallway could
> you ask him to re-ack it if it still works for him?

No problem, but I don't see him appearing in netdev today. But yes, I
would if I saw him.

Thanks,
Jason

>
> >
> > Thanks,
> > Jason
> >
> > >
> > > >
> > > > Thanks,
> > > > Jason
