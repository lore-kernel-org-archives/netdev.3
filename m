Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865401CAA78
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 09:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786957279; cv=pass; b=JleNrYzedcDQdj1g58BSUafaRtTzlGk9yU2s8uXJFgr8jugrOszdLoxbfbOYPTgp/w6pxgPEzhBqANuf/tz/6VsmYSX0zPU1BL91LTiq06NTT8tRV8yXs0B3jIf+dM/FsZWb71wGexbc3H/Yf2Hyg3NZcJKb/G5kv9OBTyzrir0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786957279; c=relaxed/simple;
	bh=fnnT9spj/ld3n/ZY4nBAciutXyMD1RIM5isnxfT60Bs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ufHmuqvbQP1eU7Smhu68FmK9kX18kP60cQZinc/iOzOfSPH2nWI4pAkL6za1yBHWdz5z5VUhAfLA5CxjDAK4LTEDW62JZ8H7HI8XRgoFZMvOmfvwaPV6ZHVcO2X2Hr0d5+k3Ei4vdWxqgG4sp3YhbvOkcyuir6/ZK3N+e3dTB7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=YNHst+Yh; arc=pass smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="YNHst+Yh"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b0117d49dcso2724370e87.3
        for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 02:01:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786957275; cv=none;
        d=google.com; s=arc-20260327;
        b=HGAzYS+MK82jPnFTZgiD0O5THU2XJviwUGSK71FxAv4SZ8IAq3qetXibvS1508vil3
         TzoT2r83bkJstRGVLLGqWmyIZikh58EssQODCYCURhpGZ55wSFUrP6QEP3EKcu5QkyaQ
         WojOwYbTTfXNjj2J4QDWyVi3ZnlMTENV5+ccNKiRCP6kuYHuoEzq6yA09Ru3fkBU6myr
         G89EfrHXElAQHPgSMJ+Zd4gRg5ukafzY4cbc0xXMz7l1tAKGmQ7+E+K0xYRPbnbuQOVc
         uCXxuUBxAaQ2yCG41X05+CIRtnNTrBxwPaEArO3iOdRfJk2vzetM+K9fs9Tk1KuQg4AO
         JK+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mhNdsAtpolFRbD+SVoIg1D1y5uYtut7bPtoWpOKh6Fc=;
        fh=XvKU4in/WRyl/tfOLAU3n7Vedg9h+btEQ0AsShL5AWQ=;
        b=aI9b73vfqMQnzmT9OxaXnuVp3Nu08P15Rs62yIJ7veLoh8Nc2bamNuGAAQZk2tBlxL
         RnhKdW9V7HOph0lioj1HkIaOJ7HWD5EnAnJwPJFo+29Ds35hSPc+rZwYvWQb1wuwEFka
         xRS1O0k/yze632GrbUUxCzx1WlNP5OMBOumPWvQFt7UJ5joaJXFc4jBFCsjGO5xTPfg2
         FrLzR3Pmaqpdnaa9InpbPOL29eKnBJ+LUqNcCrfbQT5WYyuC9OyUNTup9lXGYpxCtM0n
         W1QKwioScDK3apqpFhYzfd43tsf90lTwCkZyAAv2ug/4/gda6zeKttfyxVG93alYeEAb
         FSGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1786957275; x=1787562075; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mhNdsAtpolFRbD+SVoIg1D1y5uYtut7bPtoWpOKh6Fc=;
        b=YNHst+YhcMvq/i1dapzRrEvdHti6gSuoHuf2mrglIJK6/g/D93JnzL2JgipUEQfpwd
         94qCNbqXjO+BJ37HfcKTlX1OSiIJ2sGk/R7A+rBGRUrjOCFAtyx0sRg8d1NkP3eLNKIM
         GoEHo7QhW9kTBmAr1hzh0b98BiMZx4K2KdVZCABbwVEM7Rox+XBGqQeaG5Zh6elNsxQO
         FvqhHsyUTkGw3dJzAlgy1gbLScyS7F1C3WxmPpRqhxf1aTpBzTiGsNx6B3IDLXKNrNZj
         +1m53GtT2QB8nt+lQzmROeDpJ+3+lS7Xlo7X83AHfU3U56lcKTJ9BZuOS3vfg93XVNQ/
         GPAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786957275; x=1787562075;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mhNdsAtpolFRbD+SVoIg1D1y5uYtut7bPtoWpOKh6Fc=;
        b=YAj2tvi3ryrU268coBOe3Wq7s6y/V3yYLfFzBAT2aMsk8hOsufFF59X8+vXEZ3DfMf
         Y2dtRxNpE3RM9hWbycVZAr3Wcsbsq0k7FOfOUFFS85+8UpKOXixU3v7gPbnQ/vSE7aU6
         FV5PoqNksVgpKMSKBZ9vnfn4Enu7A8A3wkLG8CIViOX58rNS5XRnBbfRJWnQ534g4o7G
         qYTm+UZhK/VGreJhhmLUeUI8V4UMKdfy6dZe4DgwbBGuEukcXC1ZfZlyXpFklo0gjjCD
         /6Of61YQ7JB1zhhdvoAT+iysx9EipjqPo1n6eIGGyLxvGTGvDGnPPZWoqVshVLV4QKSc
         z7LQ==
X-Gm-Message-State: AOJu0YxUe+bTZu18oFJBh49FDGzrzsNyxQDxaaX6WPcvDpFSjOn4xWUS
	8aFFJgp3Vjlu6M5PcxO7D0b76jwLB0/gSx/5B+dbJSqCHzGLTOl9ZPUiY6V0hBCiLWI5xA/ljC3
	9/BhzLzvm+cjJF/ESnXjN9k0cb+xhQlM9tL5wAbZAnCk=
X-Gm-Gg: AR+sD1331Wed5c65KHg7iU16U8yRcyMiic0NeIwiYK9LvntishUZubZAqXYAfmQZ9IL
	Ro+cXr4UnRhPmtHXf5/QGjjIVuntC8kvz/hE+D/4EZlrMFg8GWsBHb/K24MqdjYWtzHNYfdR0DW
	wgr5JQzC2a2NJwPy7rpVns0fH+hCf62+qb9NZ2IEtniARIcYOpY8yab7xEQRFhRXiWb7xmxxfti
	gXiJDyMMMTo97w0DSIKOpCFGDYoJjq9uSIN5HZBedYTP2IWbfdt40NXLMd0ZstbZXPht36Zg49M
	LpwMwIoMbdhGlGqy20UySzJY/gnh15JvXwCxq5fIai8=
X-Received: by 2002:a05:6512:224a:b0:5b4:59a3:c6c with SMTP id
 2adb3069b0e04-5b459a30dd4mr3386311e87.29.1786957275225; Mon, 17 Aug 2026
 02:01:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785861392.git.zihanx@nebusec.ai> <fa79c742acdfc25678e6807d4cad766edaaf1d59.1785861392.git.zihanx@nebusec.ai>
 <aoK9ILxoOLvOoTQ5@secunet.com>
In-Reply-To: <aoK9ILxoOLvOoTQ5@secunet.com>
From: zihan xi <zihanx@nebusec.ai>
Date: Mon, 17 Aug 2026 17:01:00 +0800
X-Gm-Features: AcwNN1VqLAS5co__LQZCUpwvcl9Qpwno_L-59Vc2cP43YmkNDH1CcEqthEdQ92Q
Message-ID: <CAANe3eRgs64rfsUYZHqr9WdCmj+HVGnxzz+18-hPsfonyLSd1A@mail.gmail.com>
Subject: Re: [PATCH net v2 1/1] xfrm: avoid lock inversion in nat keepalive work
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: netdev@vger.kernel.org, herbert@gondor.apana.org.au, davem@davemloft.net, 
	eyal.birger@gmail.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 17, 2026 at 3:49=E2=80=AFPM Steffen Klassert
<steffen.klassert@secunet.com> wrote:
>
> On Wed, Aug 05, 2026 at 04:51:25AM +0000, Zihan Xi wrote:
> > nat_keepalive_work() walks the state table while xfrm_state_walk()
> > holds net->xfrm.xfrm_state_lock. Its callback then acquires x->lock,
> > which conflicts with the delete path taking the same locks in reverse
> > order via xfrm_state_delete() and __xfrm_state_delete(). This creates
> > an AB-BA deadlock that is reported by lockdep when a NAT keepalive
> > worker races with SA deletion.
> >
> > Fix this by splitting keepalive handling into two phases without
> > reversing the lock ordering. Walk the state table only to collect a
> > bounded batch of candidate states while holding xfrm_state_lock and
> > taking references on them. Then, after the walk drops xfrm_state_lock,
> > process each referenced state and take x->lock in phase two.
> >
> > Use a small fixed-size batch and the xfrm_state_walk() cursor to resume
> > the scan when the batch fills up. This avoids per-state GFP_ATOMIC
> > allocations, avoids aborting a full round on -ENOMEM, and keeps
> > nat_keepalive_send() in BH-disabled context by wrapping the phase-two
> > drain with local_bh_disable()/local_bh_enable().
> >
> > Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UD=
P states")
> > Cc: stable@vger.kernel.org
> > Cc: Eyal Birger <eyal.birger@gmail.com>
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: Codex:gpt-5.4
> > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> > ---
> > changes in v2:
> >   - reroll on top of net cf6f8b29befb so the patch applies after the
> >     nat_keepalive_send() default-case change
> >   - replace the unbounded GFP_ATOMIC state list with a bounded batch
> >   - keep phase-two processing in BH-disabled context with
> >     local_bh_disable()/local_bh_enable()
> >   - clarify the validation permission model and reproducer scope in
> >     the cover letter
> >   - refresh the cover letter with cf6f8b29 incremental build and PoC
> >     validation results
> >   - rerun decode_stacktrace.sh on an LF-normalized crash log and
> >     document the decoder truncation in the cover letter
> >   - add source locations for the key lockdep offsets from the same
> >     unfixed vmlinux
> >   - add Eyal Birger to Cc for the v2 reroll
> >   - v1 Link: https://lore.kernel.org/all/cover.1784645321.git.xizh2024@=
lzu.edu.cn/
> >
> >  net/xfrm/xfrm_nat_keepalive.c | 51 +++++++++++++++++++++++++++++------
> >  1 file changed, 43 insertions(+), 8 deletions(-)
>
> Can you please send this as fix for your original v1 patch
> on top of the ipsec tree? That way I don't need to revert
> your original v1 patch.

Hi Steffen,

Sure, thanks for the guidance.

I will prepare a follow-up patch on top of the ipsec tree to fix the
queued v1 implementation, instead of sending this as a full replacement
against net.

Thanks,
Zihan
