Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.172
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793112722;
	b=WXNQcA7N3KvbZD3L3+cDbqZrmIPw4qnC4Pw+7rSSnhxY0OTAeSGRrXuZafGwOoHMXiE9
	 8g84aqv9cQ+Y4wjlecaigOHl8qoYmeqmMyjKcjT9PeltjcKWFHmsrKSUajcUqnmotmmhD
	 Ep/hJPn1VqK/UmFPZhA2QvUlKQvZbEEwO40i3fOPVKKo8vORk6tkhDZcwktyGPmLziFFV
	 X9fhCyCrQ815od7JFVcjb+TPiFKJ9XZkHDlJb39bNjFSCijEhiE12XF9cYZaO3CUhpAVG
	 f2HpT9UfRgEpGWJxQJWInoW0NRAb7OkdR2kcsWxZnJP0S5WwuNZN1619cUHeiV6LlVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793112722;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=FU7pIPRd0mpxW1uPh7JiRsMpomfdTBJ1PVqebYQBX/w=;
	b=SBAdWJYOmEOyD/udpj88pIR3nZoIRMgNH8tXdbUozXZs4g7jV3p8mknB/fT/vT0IvbZb
	 ZpGUFuMafJDDwETUypCgwrBB0BGqROcXtLMQSpc2gU3ZKCDHUJ95tKtUFvXLR/iYEcswG
	 JFsTeuO0grDr0swGeoM5kD5P8AVCDKBRhyRFfAw3ndQbnvhbn5y3ogn6lG5cYvdVymTc2
	 Id8kKOT+rVvKiC1ZRmlmP16trFwc5cnLLeLaJZUhiQmgRiphWXKpu1zaFF+R1M8OPXsqO
	 1Z2JomqWTO4Y70QHNkY7hcJHt2x7GNTJM/l009KEXOuKETET9wv2tezN24SvwvPurXg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DqjPCs4d;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.214.172
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0732C60A2609
	for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 14:52:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0732C60A2609
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=DqjPCs4d
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ea94541adbso14545915ad.2
        for <netdev@vger.kernel.org>; Tue, 27 Oct 2026 07:52:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793112721; cv=none;
        d=google.com; s=arc-20260327;
        b=E/lMXVhVKx7eyWTjEfsuHDOKdeQ2MhfyGcveUeyAxVqHKUjJ+HfJ0TamDHCvWcJzi6
         j3CJ35Mx8BYPxxUAlBISVDrLemhNWerW37u9M5n7owEjHPpYogce0BbqO2FuULCMjHSx
         5fHsRY3rN+Bwhy3rb1d4WANC1D28vj/cR5GtHMBvVj4ACUF+bU2eYO6O01s+DfBBpbkt
         r5aLF8qwnDhB/qqa1G0uYBoDq8OMsPSNmccoARef2iLqXJm9S5VfQzj6sjpiWEcl0lie
         P8ceOKtEwstaFNb0Smqf1TcT+ezWECsCKuTk2PlV7Z+zIcBATPsGvsqI3NTS1EJFFMit
         MaFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=FU7pIPRd0mpxW1uPh7JiRsMpomfdTBJ1PVqebYQBX/w=;
        fh=gE7Gm33YqLWfyFVYX+XCEINRPpjzybZ7N39/QGDfXxw=;
        b=ATgSFCDqHvUV5rXipxFOdLBO4Cj3hesXH89qn9GZTOcxIbX+Pkg5L1ivPG3jdJXAUW
         ycIF6bs++h0qb7UGd1YQyQIylo3/8VlezoOzh59KYMjhLfMLWri02OntS0XY00XKdHYt
         ifZZytoK0YlmymyAdLhSGnGgi/ZFccuXvk14fhN8SCq5Tauz4whi7Pd+umBAcSJCReyy
         Uasts+tG923t+wmrZK1CahhFpVTE76MeJtECWyVcE0dZZaOdAHBgCowX/sLjF9jkNDCm
         ZCSTLOJ0DBQv07PU4WLtgTF09flQe+LiSS1WXKx8OLnRAOG5dhls2aM58I5oC5ka2+pV
         3WeQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793112721; x=1793717521; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=FU7pIPRd0mpxW1uPh7JiRsMpomfdTBJ1PVqebYQBX/w=;
        b=DqjPCs4dJ32bm7zSatdTMph8eLbrIiZizD/FLI1JoVoFvAmjQIOJhUuqKpg99V5b+s
         LLS+kBx6KBM8bc6Ni0PwXyd+NTKfacgRn/deaixv/tVlbXPDlA/Ca2On1e1TR1EFh+Br
         c1UUutur0IRU2qhpeDblRoVuCg/hmdOs/bxqb0UzpgRT9X+fREQJOsdQzhUQJTS12DBb
         KXfYFt3x79maA41r7KXzXiAL5gTDPnBnp2veRyQWM9pdLidDAhrilD2g8v685KXVIbPe
         6JwcjYXy7pWwc4D3RfOYB9ronLD89y6YutbPrktosT1/XrYkEpAmBnzk9gZ1f2PkR+gI
         zRtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793112721; x=1793717521;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FU7pIPRd0mpxW1uPh7JiRsMpomfdTBJ1PVqebYQBX/w=;
        b=QW4WzU0WiRZRwxfcBLHkp35wWAX4Z24H+YE9fP9TOcoLo2GOvLRORvGaIgDjmlyhwD
         cBKlUiOFKMe3w01q/klaVxDXer8IjuQ84FQQ9uj3irObaiw/9rov3YBMlpWzOQF70ARI
         W+O++9j9wARPe0shiJNo1f9N3Jx3rcMQJAIvFZ3/XJcWfgglJRBOeM88BUtjGl1sm/qV
         5HIFHS0DVj0h8jOciTOLjQhqQukXYLM2cf1HahtMv4Z8O13wEZwPPZwv6QSvEDwrK5HP
         aoCT5XNByb4l6B3PbSJfDI5nUz7ftcrZp1UR5IU1sWM5QCLVoUfkLmhqknO7W25mcPXJ
         m+8A==
X-Forwarded-Encrypted: i=1; AKwUvBxkQUdE78wBUS2upBk3spbbc0150l6pvvQtRd/R3CAtc/RoYdY+r0NyB+Q8b6kNb6Qg/KD27yk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJhDn1t6VDFs2nNexJBOcT3ESij6HdmgTXIcMwRubrrHRtVKKnP
	/R4iU+4rULKyNWsb3Nzl14O9w/C6dltLMUetDs72E3OUJbQrYSJa1mRiiW7d/duRIAWmQj+qwta
	upjsJQd2lku0iIvgfFVZLk9K7cxh/bmY4yq+iyNyj
X-Gm-Gg: AYBFou2LIzgGPQHyRRykchH7Af2rgurrTKnF0OUVH0BRTKcoAXDorbKfuvlMQXEcx50
	vJXAHdiPZGbZ97u4NQTIhyd0dQLeEo9HlRtLP2+up35RU9Iit19JEcvi3ZAjzrmpQ3jrPI8P7On
	6fqWb3cozUVp8kKViDiV+TYHogvSpsJAJC0m1/4oupq8AGrRnp/GRaYytHPGxll2nSQMS97v0UX
	sNI8OitDdypyKBNWLMfiRFp4e5ExF6Kxena53K/NASr5b2HIrndB9bzaro8L+50Qu9Q2q1a0Vgd
	XQynHyqmXei7E7BzPXFLKVDVfke//HCGZGzU6uYey84UgNfF/Mlt2A/pP4LoUEDRYbw0eOtIkOS
	F05mAlC0XYFja1+ygdDw+qlS6/iXqpjmnT8iB1psx91rPEQsyMaUFVjUjSWOfxXw9vHBcoDJuj9
	6H9ikj9YtZ7uwOP3g2
X-Received: by 2002:a17:903:1a30:b0:2e5:467a:7a6b with SMTP id
 d9443c01a7336-2ea9c69aa27mr88146155ad.10.1793112720805; Tue, 27 Oct 2026
 07:52:00 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023204706.3112215-5-hramamurthy@google.com> <179306532917.3134.3709041101906222542@kernel.org>
In-Reply-To: <179306532917.3134.3709041101906222542@kernel.org>
From: Pin-yen Lin <treapking@google.com>
Date: Tue, 27 Oct 2026 22:51:48 +0800
X-Gm-Features: AclHuK_CgLe0wYbEvzhKP5oLFw9n_XNsuU2Vaq53lhDlTw36CwDa4KLyFY57Fxk
Message-ID: <CAHwYsip9e1H4+g2FS-t_TBGkG+f4E0w+kc4r0Ni6ODnA57cpCQ@mail.gmail.com>
Subject: Re: [PATCH net v3 4/4] gve: Fix link flap after ethtool ops
To: netdev-bot+sashiko@kernel.org
Cc: hramamurthy@google.com, netdev@vger.kernel.org, joshwash@google.com, 
	andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@kernel.org, 
	kuba@kernel.org, pabeni@redhat.com, jordanrhee@google.com, willemb@google.com, 
	przemyslaw.kitszel@intel.com, nktgrg@google.com, maolson@google.com, 
	jacob.e.keller@intel.com, pkaligineedi@google.com, yangchun@google.com, 
	patricion@google.com, awogbemila@google.com, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 9:42=E2=80=AFAM <netdev-bot+sashiko@kernel.org> wro=
te:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 0 =C2=B7 Medium: 1 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [Medium] Synchronous link-status update in gve_queues_start() races
>   with gve_service_task(); the carrier can be left in the wrong state.
>
> --
>
> gve: Fix link flap after ethtool ops
>
> gve_queues_start() now calls gve_turnup_and_check_status() directly
> instead of queueing the service task, so the carrier state is updated
> before the call returns to userspace. This avoids the transient carrier
> drop after ethtool reconfiguration that was breaking the
> drivers/net/ping.py selftest.
>
> > diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/e=
thernet/google/gve/gve_main.c
> > index 52c152a986eb7..e2a016f4430a8 100644
> > --- a/drivers/net/ethernet/google/gve/gve_main.c
> > +++ b/drivers/net/ethernet/google/gve/gve_main.c
>
> [ ... ]
>
> > @@ -1486,8 +1515,7 @@ static int gve_queues_start(struct gve_priv *priv=
,
> >                         round_jiffies(jiffies +
> >                               msecs_to_jiffies(priv->stats_report_timer=
_period)));
> >
> > -     gve_turnup(priv);
> > -     queue_work(priv->gve_wq, &priv->service_task);
> > +     gve_turnup_and_check_status(priv);
>
> [Severity: Medium]
> Can this race with gve_service_task() and leave the carrier in the wrong
> state?
>
> Before this change, gve_queues_start() sent its link update through
> service_task. A work item never runs concurrently with itself, so these
> updates were serialized.
>
> gve_queues_start() is reached from ndo_open, from gve_adjust_config(),
> and from gve_reset()->gve_recover()->gve_open(). It holds rtnl and the
> netdev instance lock, and it now runs the same sequence as
> gve_service_task().
>
> gve_service_task() is queued from gve_mgmnt_intr() and holds neither
> lock:
>
> gve_service_task() {
>     ...
>         gve_handle_reset(priv);
>         ops->report_link_status(priv);
>         gve_handle_link_status(priv);
> }
>
> gve_adminq_report_link_status() reads the register and writes the
> cached value in two separate steps:
>
>         status =3D ioread32be(&priv->reg_bar0->device_status);
>         WRITE_ONCE(priv->link_up,
>                    !!(GVE_DEVICE_STATUS_LINK_STATUS_MASK & status));
>
> Here is one possible interleaving:
>
> gve_queues_start()                  gve_service_task()
>   ioread32be() -> link down
>                                     (device link up, mgmt irq)
>                                     ioread32be() -> link up
>                                     WRITE_ONCE(link_up, true)
>                                     netif_carrier_on()
>   WRITE_ONCE(link_up, false)
>   netif_carrier_off()
>
> At the end the carrier is off while the device link is up. The service
> task run triggered by the interrupt has already finished, so nothing
> checks the link again until the device raises another status interrupt.
>
> gve_handle_link_status() has a similar window, because its check and
> its action are not done under a lock:
>
>         link_up =3D READ_ONCE(priv->link_up);
>         if (link_up =3D=3D netif_carrier_ok(priv->dev))
>                 return;
>
>         if (link_up) {
>                 netdev_info(priv->dev, "Device link is up.\n");
>                 netif_carrier_on(priv->dev);
>
> Suppose gve_queues_start() reads link_up =3D=3D true with the carrier off=
,
> and is then delayed in netdev_info(). In that time gve_service_task()
> can write link_up =3D false, see that it matches netif_carrier_ok(), and
> return. gve_queues_start() then calls netif_carrier_on() while the link
> is down.
>
> gve_set_xdp() and the per-queue start path already use the same
> pattern without a lock. This patch also brings it to the common
> gve_queues_start() path, which used to be serialized through the
> service task.
>
> Should gve_turnup_and_check_status() and gve_service_task() be
> serialized against each other here?

Yes, this needs to be serialized. All other callers of
gve_handle_link_status() already run under the netdev instance lock,
so in v4 we will take netdev_lock() around the link status update in
gve_service_task() as well.
>
> >       priv->interface_up_cnt++;
> >       return 0;
>
> [ ... ]
>
> --
> Sashiko AI review =C2=B7 https://netdev-ai.bots.linux.dev/sashiko/#/patch=
set/20261023204706.3112215-1-hramamurthy%40google.com

Regards,
Pin-yen
