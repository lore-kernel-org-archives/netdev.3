Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 364D243F092
	for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 18:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784141594; cv=pass; b=LMoGXS/8cn3OjqlIjEJY3ZePMbHXKufkq9skHU6oBN3IsnuZ5s4DYJw6ycjj/7kxwNzwEQqGPIttYiRGxj57TBKE+dinGndV25eQOAcySqBS5Rqyd2q7aJLyYlD5Isc3/qgljW7Ia1KJFanA6SqDUXVO50EiZoEAio0hlHZbV5A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784141594; c=relaxed/simple;
	bh=kfnolzMuTVoNIwfZzDEnBRdVxmV36UXw3EPGIYoSQ28=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5zsY8AAeC9U0gAR8DkskywXJh1VU8NEr1/UbaQ4SpnUR4Q/KHIhd6Hv3WQWc91b19rPkIThlKHHSgAQbmhfZlTdJyJrrD6YQYCg7lyWCI5/1RgoyTMDdR5ErXfOGyWw7OPjNzpCrYqK8E0Vi+kNJ29zycv+RGmLoyD/PIzUD/4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=noXpaD2J; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="noXpaD2J"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-81e6f0b4610so62807337b3.2
        for <netdev@vger.kernel.org>; Wed, 15 Jul 2026 11:53:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784141590; cv=none;
        d=google.com; s=arc-20260327;
        b=YxO4WHh0b862iFWNJoqlhFkzEnTMfg7+DHvToJpOODbUkX4wxDPZcPfbgj62Rp6j79
         szmkCw4T5eB4USsL7AMwENoRCSUMaGXHT5p1Ic3j5+eft+aR2DGAaTO6tKfkoKdmmNsR
         4XmnZ/PNd8DJvzrKci+sWG6fwd/1ZvlfuDL5iG48WvtZds1RePgQXOJivF5qBTPU/HRG
         X30deREiTC0ly/40T84LYxgs19wa47Lbh6ViHsuh80jo3I5slp++O7iMIXI+sMRMLBwz
         24CgrlugEB0ZRGibWpcWwiluMCevcYPFMb0gGhG5a1jQlW+FJh+6Qrq3BI2rXix7wGLg
         7i3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=kfnolzMuTVoNIwfZzDEnBRdVxmV36UXw3EPGIYoSQ28=;
        fh=Hpd5uqXVCt2pAsFKPq8Kbq1sZUt0vlcEjV7sxSz6VVo=;
        b=gPzhXRZGj+LexsHGPk9p7f4kPK2npaEMIP1NOOCLwb5EKqixQRqWYugHCmdEmwpbsm
         L6zTCWV+iq4SqdFE1u5KNCwjK829AB5YcfXc+RNDC2A7AjD2tT/Qpbf+6J9AvI4f2qez
         x4SmwG5aox0oNe8swB3cgxu3sWf3+FRi91+3N9QN6WTBsM3vKAB5vIVFkV9Onee7zHYy
         /G49UA/S8sqgWpZpkYaI5A388vOOO0L3SW0QxbFrwIBdADkMpq7NWMs2Isirz2xzh1g1
         M/EAJ1moBZJGfHw3ttdaAx8rxcCawJq192EtsoVJomLnpk7lp20TyCUSzquNIeYMK34k
         AddA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784141590; x=1784746390; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kfnolzMuTVoNIwfZzDEnBRdVxmV36UXw3EPGIYoSQ28=;
        b=noXpaD2Jda8lTWO9KvP+zyYXeNoxBMWZzfBcsCzqcKG/1hQZPNq0rCXOFaiHvmHd32
         YVkdiQhPaJFkbw6zPgwBU87UX85JmJqquxs+x7p+hSbekFn/QYoaSpTopw4BG46gijLI
         YefD4VSSpmGKlJwF1LOLODsHeu71c353dZpGDS0IUOUrdADDcgEIvth6blJE6QU0UjF8
         9aSzg+n4Zb7p2Ewmg/CSBzG0gzowDdCCbkak+3WCWE0ESDyc9soOuLXIfGVwJOEgxGT2
         W8mj9JYOJQc3oJhONiwUJ2EkVg3ggUNAs+dO8sxMjsDGUGz6XXF1xGcbIiUgWVtPhjOu
         BAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784141590; x=1784746390;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kfnolzMuTVoNIwfZzDEnBRdVxmV36UXw3EPGIYoSQ28=;
        b=R0iiCPOKYfPKFR3QHmtuYMv8CJ9o9GTc24j4gDcRSkNnydiuJcq3OWFDxga8z4R7X2
         +aVCvaGLE73E2o+lrSfChH1dr93j7Qlcs4qvOs6phE/Zb+ySOl8LX8Q/u848/sH1mMdm
         AuRRbkKtGnZ63pkqicu9jCoP5MKZr/RqtumZ2XDe9TMkE2t4G1+FokhCTBP2xbJK39M/
         tU2pL1qbaBnRP/omZIi4aJVsiSctQDGHeKD6Yo1Rz0HUYD90kldFQzkrXIvLi+sDhYOr
         AwFxieCog0LytHTXmveETC7Swhjk1wUEqvKC9VWM/Ex+ml6Mq8g7DRJMTAaFJU4oQAye
         tlSw==
X-Forwarded-Encrypted: i=1; AHgh+Rop/xyG+JeAX8IowBZemKa8CE0J3/Jio+40/p4xDgm8hswc2NICLXVe3hasojOs/L/xkIYa4vY=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf/wsICq3TTc3AmVH1WjMK+IMKj++w79iOQ8TOKYBXRUJ41O5w
	PsrhFxozX+visZltOGmO0QU+g6dp8n9bo9dAQHVbaC9ImrkBuMQfVggMd6SUsb96giC1H8BtwOr
	NX1gbNQ+hib2rm64yqcKFBY9PNLHS1GM=
X-Gm-Gg: AfdE7clkkzonFIrlXYhx+l6xRlYd2sgzBC9o4xTN9oGK9CXed2m65GLyu5ObN6l1/5a
	2wkI/euSk9Fy6Vz2NtKyCqs4DLAV/D+aBrmxKRvFy0LhEMDyvIoviaezu0k/2tIZSzzjI/ORQ9q
	/T4VkiPqV1CWLsQXzChOSFnzA4ar0BSyHtij3oret28NDKojy4vXVeBykmEnwHtkyFFVIuvXKc3
	9FHU0GnQhrhYYsLKJ8ZxyvIHakXeQ3iXI5kHDbxhtHTB/oJR3IQ6Z8qW+8uyuxNmA1DbQ7pwb3K
	mmMuOiHY3ninfekFCNmyFhtuUkaAP5PhHvQoj6bBBwZhFTNK+k5pGO7f
X-Received: by 2002:a05:690c:685:b0:80c:8596:4656 with SMTP id
 00721157ae682-81ebb34af27mr71371537b3.72.1784141589934; Wed, 15 Jul 2026
 11:53:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260715-mv88e6x41-fixes-v3-0-9a8702b27ecc@padl.com>
 <20260715-mv88e6x41-fixes-v3-2-9a8702b27ecc@padl.com> <a607d5f5-a315-493c-971c-d5e8cab33941@lunn.ch>
In-Reply-To: <a607d5f5-a315-493c-971c-d5e8cab33941@lunn.ch>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 15 Jul 2026 20:52:59 +0200
X-Gm-Features: AUfX_mx8D6kNn8pw3TLEcYbiZtC7_O-L9Ydy0gE4H_m-Fm07fjIJovNqe7_9VvM
Message-ID: <CAOiHx=mZeS1dZ59grQrf9U2QP3OKEJDahhYpLx5_tKCEUty1yQ@mail.gmail.com>
Subject: Re: [PATCH net v3 2/3] net: dsa: mv88e6xxx: flush the ATU when the
 hash algorithm changes
To: Andrew Lunn <andrew@lunn.ch>
Cc: Luke Howard <lukeh@padl.com>, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Vivien Didelot <vivien.didelot@gmail.com>, Gregory CLEMENT <gregory.clement@bootlin.com>, 
	Richard Cochran <richardcochran@gmail.com>, Cedric Jehasse <cedric.jehasse@gmail.com>, 
	Kieran Tyrrell <kieran@sienda.com>, Max Holtmann <mh@rme-audio.de>, Max Hunter <max@huntershome.org>, 
	Christoph Mellauner <christoph.mellauner@joyned.at>, Simon Gapp <simon.gapp@gapp-audio.com>, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 15, 2026 at 2:08=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Wed, Jul 15, 2026 at 09:29:42AM +1000, Luke Howard wrote:
> > Changing the ATU hash algorithm invalidates existing entries: those
> > loaded under the previous algorithm end up in different bins and read
> > back corrupted.
> >
> > Flush the ATU whenever the hash algorithm is changed through devlink
> > and reload the default broadcast entries. Per-VLAN ATU entries and
> > any static addresses are not replayed, so the hash must be selected
> > before the FDB or MDB are configured.
>
> Hi Jonas
>
> For v2 you said you thought this was a bit of a foot gun. I suggested
> maybe checking all user ports are admin down. What do you think?

Sorry, saw the email, then completely vanished from my memory.

Probably also needs to be not attached to any bridge, right? To make
sure that no additional static entries can exist (because I think
these are hard to recreate).

AFAICT the default "self" entries probably could be easily
reconstructed since they are just for the ports' mac addresses, so
readding them for all ports that are admin up might be enough.

Best regards,
Jonas
