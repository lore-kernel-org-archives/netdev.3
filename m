Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A1C385D69
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 16:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787848041; cv=pass; b=XjSxEXkUbo0yyKmcucGOxFkthj/WPHORfIDikIP7cwlNnBT3pIXpWYv2JGksfHWuR5an21qcookpznN8o/kLWV+Nt7XCSYnyQ29fz5JN/xtjZRJQzloWVdBdq30IKle3dKmZghQ8+oBidZ9qgjNJJTLzrCr2Cprm+c/Aa0f7Yxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787848041; c=relaxed/simple;
	bh=scHt+iyBMWOylqgViJ5vWUnmhF3RxYRWmtqm5Y6wxgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Radgyp4ugBpafXrYTJx9jq5gmPZHe7bpIdKBLCNMZU92YrZGWgukSEI/Am89US73tQk5quDDbdlU0xpyuRV5GWeiclkR8eZ1BgqN2BQ3qKjmPf0ll0fYV7sH1KV16Xus2j6zPZY4+XhUZjnbCFXTzbHaGKDU7SndN7rqT577c+8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ohb0qiN/; arc=pass smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ohb0qiN/"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so215415a91.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 09:27:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787848039; cv=none;
        d=google.com; s=arc-20260327;
        b=D606S3kKDROV8bLlEw4QWFBbpSuC8K43oT4XX2KkI9Q2/Td42j7BNiGPEz73IKjGqM
         4bj9muIPxAbEObulYS3aJWh9frTu07Ud4lYUns/CyZYYW2CQdrCHvRFo9kQl8mejn+ZA
         vVqO45z7y4uVh4rGxGEv+S3Pfvi1yuOhzvjS5Z5euH33zCraizqFFitpbbuBZ6XdU6rD
         3Z/VOa5cXljh15tuCNP07fR687G10IY2BwbtXj3y83QMRlBQ90G3aA/3dGZMmWLQYQBr
         8/AvcQNZP5ZoizM/PoNMa3XwiXNoJo10hT20ZbYZDBZ5tjbiV9R5dRZM0fM52YU1b1rk
         /q2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=UbwPgsLbQuTsRud2Crpt7fzATm/uz+C7nDTDVjlvWGE=;
        fh=CM6Ntgcrc5CBOengnrZSlNNW2cBUa26DOsaKUBS1WOY=;
        b=Ybk2RrqeuwthT/MUMVe/9BWVINlak2sK0uG9czL2F5DuoOXbfrm2ZwS0rQAPDd/Cxl
         fUkzBJjtS3vf31LG4FKWa9UIEJHA876a+eeys/LfyHnqhftWQ0Jr0aXa+nCXWN4w61Wx
         CNttSxkPtxTrg53ajyXTokw2mDqj0quPpeKj/vrlGsjn16E6b7zLu9u1i9zZ7udvo07z
         +VVUbpT7ZOAnaOpcAoPpiaMAP0Vjmds4mposR55sF8MDqAKUK4Yq0YCgVUq1apoKcBXQ
         CFrL5Ewj+/a2Z9leDuhF/CvtLQjsk54V3tFnGoF2OHdsLEU6QeFq14kf4EptDnPKV+uE
         vpNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787848039; x=1788452839; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=UbwPgsLbQuTsRud2Crpt7fzATm/uz+C7nDTDVjlvWGE=;
        b=Ohb0qiN/o9MPjWTxdhYEPdUKbMjegC1R6w8c1yEUzH+3AEVpw7v9mnjOE5I4ssvBwR
         gbGYzn/NNzvWTNUyhjmJJZ9wGY33PrB3H23hX09TUj8BBeWQOYEBbQRlqB90VdVzjh5z
         6Z2E+6ehJv377Yp+lKZ5xMRm2x+KlOnU5YqoGPm4kao1b6KLY+a/pkuAWjPVjWJBlf4r
         LY95nHIGm7oNTYVQJ1QWxLxUtzOIRrWWmfSFgw+n7+V4TD5qUrGs+CP75reU+sGrSRZC
         Y5/1UQLe7i8C+s3H+mjPxGcGVRT4/fhifK1VKfnKMdlyCDlyzCwqU1k1AH/E8wGhtOk9
         loJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787848039; x=1788452839;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UbwPgsLbQuTsRud2Crpt7fzATm/uz+C7nDTDVjlvWGE=;
        b=VvnyPhLGPmAehQSuqYh8kAJ/NCGshQ+xF937WIOvu+3zrCZaQ5N7GgaFEenmveu/n1
         96FtGEcIkAR37d/T5IhlEuJyz4SX0O7NtbnlTlYlYsWyNw/xMSQ65yCX74Aj16STP6rm
         XfCvUXieoUywCttN70p8iph0BYNPADRuBeWRG6DAfQ3tnow959ruNMFm2yfKyDoWxvWG
         nroyd6OC0bU1HZ+nQTghr3F+WgCrKV8syEJUzhqvedUk8Sj8M2vgukjPIh2AkbGKl7wj
         mjBIItHM++WraJYO465hMymHS/EXOm7wKjX1AtYsajMJPPuepsx6ayMwNpJZ/SpF/aMt
         2YRQ==
X-Gm-Message-State: AFuF++nFHA0asgYfgEFLyBYDqereB7BLpX/9KJrqI6QxlN/UYVBb1re5
	8uyjF3zl3I/U+16bB38ypdYverR8htNj9u3eHe2ddlhVJW7N+7IQ7ZxQUDxlQj9l81XekIVvWJQ
	5FUC2iOxYHWx/G7jc7GXkCl/4RX0xKuJD/R8uhxgXVLfJbOkhbUFBGAgCHVSqzQ==
X-Gm-Gg: AR+sD13lHIMXrmALe9jwxqU0qFLyvLrzG20hNmaW5ZlIHEZxIjkJIrhQv8TZw7/Aey3
	eAL1dUgCAxH3MEn5sQ4FdvphoAj7rHeftWFe9xCLzib9SO+TCeR1FcYpBRCTDTzUeO/N5ZfMQsM
	tbToi9Zhg33DMzEChtNJoXdpsle1MNII7649ndi0k+MeoQdFeDmM1sjbxD4mgZ9YYE/E6X2kKQK
	YIPBGbzQh4Sb/3YdGxL+I/RfTMbn2DxZvvxjht+DJ7XqaGySuHKqrVw5TED5+RV/mVTo7dtFXgE
	Tn5WKLMEyBLSCeVcS1WgydHJ8uOFIoPotYLRaw0BV6B54UWuPeMYvhfCD8ELaWG7ol3flw2OQeu
	JrTqqurWaB4h5axhUKGXYtwJitsxgQ2GF6r4ugCLii5lXpvOmSrCuo3RgvZIqF2CBxZADX6RdJy
	r2H1pdeLVOuNcP4w==
X-Received: by 2002:a17:90b:5905:b0:381:a766:efcb with SMTP id
 98e67ed59e1d1-396d0d7b94bmr843184a91.4.1787848038204; Thu, 27 Aug 2026
 09:27:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827132133.439890-1-maciej.fijalkowski@intel.com>
In-Reply-To: <20260827132133.439890-1-maciej.fijalkowski@intel.com>
From: Kuniyuki Iwashima <kuniyu@google.com>
Date: Thu, 27 Aug 2026 09:27:06 -0700
X-Gm-Features: AcwNN1X4yW5ISKKrAOkksq3luyXi7C-3OgDl_XVbJ7UICT5kfCRGrl2-Pqz4EZs
Message-ID: <CAAVpQUC3w4b5KG+YGrK7bDNoaL-RPpmEu3FVJiyzWPewoJt2=g@mail.gmail.com>
Subject: Re: [PATCH net] ipvlan: unregister upper devices outside pnodes_lock
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, andrew+netdev@lunn.ch, edumazet@google.com, 
	kuba@kernel.org, pabeni@redhat.com, magnus.karlsson@intel.com, 
	sdf@fomichev.me, bpf@vger.kernel.org, 
	syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 27, 2026 at 6:21=E2=80=AFAM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> syzbot reported the following circular locking dependency:
>
>   xs->mutex -> netdev lock -> pnodes_lock -> net->xdp.lock -> xs->mutex
>
> The pnodes_lock -> net->xdp.lock edge is recorded when
> ipvlan_device_event(NETDEV_UNREGISTER) calls unregister_netdevice_many()
> while holding pnodes_lock.  A nested NETDEV_UNREGISTER notification for
> an IPvlan device enters xsk_notifier(), which acquires net->xdp.lock.
>
> Keep pnodes_lock only while marking the upper devices as dying, removing
> them from port->ipvlans, and queueing them for unregistration.  Once the
> devices have been detached from the protected list, release pnodes_lock
> before unregister_netdevice_many() invokes notifier callbacks.
>
> The port remains alive across unregistration because
> ipvlan_device_event() holds the reference acquired by ipvlan_port_get().
> The dying flag prevents a concurrent ->dellink() callback from deleting a
> queued device again.
>
> Fixes: 35add1093e2f ("ipvlan: Protect ipvl_port.ipvlans with mutex.")
> Reported-by: syzbot+aa48b5fe7bfda62d1682@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Daa48b5fe7bfda62d1682
> Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
> ---
>  drivers/net/ipvlan/ipvlan_main.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ipvlan/ipvlan_main.c b/drivers/net/ipvlan/ipvlan=
_main.c
> index ee46a55f73d1..2730581e0a56 100644
> --- a/drivers/net/ipvlan/ipvlan_main.c
> +++ b/drivers/net/ipvlan/ipvlan_main.c
> @@ -846,7 +846,6 @@ static int ipvlan_device_event(struct notifier_block =
*unused,
>                                 __ipvlan_link_delete(net, ipvlan->dev, &l=
st_kill);
>                 }
>
> -               unregister_netdevice_many(&lst_kill);
>                 break;
>         }
>         case NETDEV_FEAT_CHANGE:
> @@ -895,6 +894,10 @@ static int ipvlan_device_event(struct notifier_block=
 *unused,
>
>         mutex_unlock(&port->pnodes_lock);
>
> +       /* Avoid invoking nested netdevice notifiers under pnodes_lock. *=
/
> +       if (!list_empty(&lst_kill))

nit: unregister_netdevice_many() takes care of this.


> +               unregister_netdevice_many(&lst_kill);
> +
>         ipvlan_port_put(port);
>
>         return ret;
> --
> 2.43.0
>
