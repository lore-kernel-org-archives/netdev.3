Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B48B331EB0
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 05:07:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786943265; cv=none; b=liIYi3bFLFnIHBGi6zelj3NsFvPHcjtWqnhJEuZG8MG9+R6XcqSKewkfU4u+OGeN07Dn3ylXXwZ2Wlab770h9vdpgao2/zfx7Ut8vghlKEF5yseHS6MOmDq5kgimH5dJiGgjzF3gMjiI9i7bUwupHFnAlHLu5VrAtofIibAlYLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786943265; c=relaxed/simple;
	bh=dPdK35nQcum4LxmgZ8oOradsegL8DIEO3t2hgPi4aF4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sjSgCh5+5hq0oYD6mvJEaPMbUsUpG412LDY+KxircrWCwuY4ob4IOJEYEAzAm9bO/N+YwE4VXJB0RimTp4My6wlSytRqvtNSDumHWxmiXtkOmy39EfKRD2VBYfNLOtapq3yczGiyC0XSMNCaetvmG12Oiiweu/EvCUnrGTtv9CE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wdz4POjp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wdz4POjp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA5771F00ADF
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 05:07:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786943262;
	bh=kV2dQJ1wdbf80yA17SwceIH5aqksXR1V0JnBd9JZWnU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Wdz4POjphJSJRl9T95Y3n4qJvLYjn0MbN1PiJ+eOL7ux+2C/p3y7lXzTbCqkx97Et
	 DzDSsSAQ8YA4WUy47y0Gllxh+MpTimRE12WVwoOmhK7X6KroaR8zop5VtXZeLwQZgm
	 uBonCLgJbiPwrmm3IzYmqCMYev/FB9JEzojZYGRdVD3WuyoQtu2k5p2pT89Y0LlaIU
	 5E6iaFoMsWiaioB49WSXFuMYeKLw4ECTaoro/IeempszirY1n9znXF5TUs/l6RH3S1
	 LjYjGKsZLTXWMu5as3jbHR8bqKiD4BN/XXJcamWSpInkOL/iFx7MAolT3lk/Qam25O
	 kgajiHXTau41Q==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a0c8283146so4128669a12.0
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 22:07:42 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Ro7XfahxUv44OZYzX26D9or49yuKaujV8esK17l3UcPBUXelbHDpEXmDYVXu1jWyuBdB2jZrO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzu+xmn6p48rFDCUiq6kDRLIawPKF48ggKguGycgtdA+XptgZpu
	cYmr1Lr6ENuLXsNOA0bYo3vH8gQxhmUR+FxWXtCUhPSP79KLcOd7XbRXYo4wgjdqxvzJy++TmYf
	n9vbPf98EknfmAqW4PCvQE26JBfmHsqg=
X-Received: by 2002:a05:6402:434c:b0:6a0:927e:39e2 with SMTP id
 4fb4d7f45d1cf-6a38a8d621emr10831780a12.5.1786943261668; Sun, 16 Aug 2026
 22:07:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816-submit-phy-package-fwdevlink-v1-v2-0-23e55dd59fad@gmail.com>
 <20260816-submit-phy-package-fwdevlink-v1-v2-2-23e55dd59fad@gmail.com>
In-Reply-To: <20260816-submit-phy-package-fwdevlink-v1-v2-2-23e55dd59fad@gmail.com>
From: Saravana Kannan <saravanak@kernel.org>
Date: Sun, 16 Aug 2026 22:07:29 -0700
X-Gmail-Original-Message-ID: <CACRMN=dWjKL48Ckee1nEVF02VG0ccDrE-GM7mqV+TqgraVveiw@mail.gmail.com>
X-Gm-Features: AcwNN1XNWetLFsigq420z2tJ-9wlUPXUaxvFZBqntmxU7fNoGFy7GhGBob0Dpw0
Message-ID: <CACRMN=dWjKL48Ckee1nEVF02VG0ccDrE-GM7mqV+TqgraVveiw@mail.gmail.com>
Subject: Re: [PATCH net-next v2 2/4] driver core: factor sync-state-only link cleanup
To: James Hilliard <james.hilliard1@gmail.com>
Cc: Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
	Christian Marangi <ansuelsmth@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	driver-core@lists.linux.dev, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 16, 2026 at 5:00=E2=80=AFPM James Hilliard
<james.hilliard1@gmail.com> wrote:
>
> device_links_driver_bound() drops managed sync-state-only links after a
> consumer successfully probes, then re-evaluates each affected supplier
> for a sync_state() callback.
>
> Frameworks which populate child devices below a driverless device need
> to complete the same lifecycle step, but cannot rely on a successful
> driver probe to trigger it.
>
> Factor the existing cleanup into a lock-held helper and reuse it from
> device_links_driver_bound(). Add a public locking wrapper so frameworks
> which populate children below driverless devices can retire temporary
> fw_devlink proxy links without affecting real dependency or runtime-PM
> links.

See reply to cover letter. I don't think this patch is necessary.

-Saravana

>
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/base/core.c    | 74 ++++++++++++++++++++++++++++++++++++++------=
------
>  include/linux/device.h |  1 +
>  2 files changed, 58 insertions(+), 17 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4d026682944f..627fcfa274f0 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1305,6 +1305,57 @@ static void device_link_drop_managed(struct device=
_link *link)
>         kref_put(&link->kref, __device_link_del);
>  }
>
> +/* Caller must hold the device links write lock. */
> +static void __device_links_drop_sync_state_only(struct device *dev,
> +                                               struct list_head *sync_li=
st)
> +{
> +       struct device_link *link, *ln;
> +
> +       list_for_each_entry_safe(link, ln, &dev->links.suppliers, c_node)=
 {
> +               struct device *supplier;
> +
> +               if (!device_link_test(link, DL_FLAG_MANAGED) ||
> +                   !device_link_test(link, DL_FLAG_SYNC_STATE_ONLY))
> +                       continue;
> +
> +               /*
> +                * DL_FLAG_SYNC_STATE_ONLY excludes all other managed lin=
k flags,
> +                * so it is safe to drop the managed link completely.
> +                */
> +               supplier =3D link->supplier;
> +               device_link_drop_managed(link);
> +
> +               if (defer_sync_state_count)
> +                       __device_links_supplier_defer_sync(supplier);
> +               else
> +                       __device_links_queue_sync_state(supplier, sync_li=
st);
> +       }
> +}
> +
> +/**
> + * device_links_drop_sync_state_only - Drop managed sync-state-only link=
s
> + * @dev: Consumer device whose proxy links should be dropped
> + *
> + * Frameworks which populate child devices below a driverless device can=
 call
> + * this after adding all of the children. The children will have acquire=
d their
> + * own links by then, so the temporary links which only prevent supplier=
s from
> + * receiving sync_state() callbacks are no longer needed.
> + *
> + * Re-evaluate each affected supplier for a sync_state() callback after =
its
> + * link is dropped.
> + */
> +void device_links_drop_sync_state_only(struct device *dev)
> +{
> +       LIST_HEAD(sync_list);
> +
> +       device_links_write_lock();
> +       __device_links_drop_sync_state_only(dev, &sync_list);
> +       device_links_write_unlock();
> +
> +       device_links_flush_sync_list(&sync_list, NULL);
> +}
> +EXPORT_SYMBOL_GPL(device_links_drop_sync_state_only);
> +
>  static ssize_t waiting_for_supplier_show(struct device *dev,
>                                          const struct device_attribute *a=
ttr,
>                                          char *buf)
> @@ -1418,6 +1469,8 @@ void device_links_driver_bound(struct device *dev)
>         else
>                 __device_links_queue_sync_state(dev, &sync_list);
>
> +       __device_links_drop_sync_state_only(dev, &sync_list);
> +
>         list_for_each_entry_safe(link, ln, &dev->links.suppliers, c_node)=
 {
>                 struct device *supplier;
>
> @@ -1425,17 +1478,10 @@ void device_links_driver_bound(struct device *dev=
)
>                         continue;
>
>                 supplier =3D link->supplier;
> -               if (device_link_test(link, DL_FLAG_SYNC_STATE_ONLY)) {
> -                       /*
> -                        * When DL_FLAG_SYNC_STATE_ONLY is set, it means =
no
> -                        * other DL_MANAGED_LINK_FLAGS have been set. So,=
 it's
> -                        * save to drop the managed link completely.
> -                        */
> -                       device_link_drop_managed(link);
> -               } else if (dev_is_best_effort(dev) &&
> -                          device_link_test(link, DL_FLAG_INFERRED) &&
> -                          link->status !=3D DL_STATE_CONSUMER_PROBE &&
> -                          !dev_can_match(link->supplier)) {
> +               if (dev_is_best_effort(dev) &&
> +                   device_link_test(link, DL_FLAG_INFERRED) &&
> +                   link->status !=3D DL_STATE_CONSUMER_PROBE &&
> +                   !dev_can_match(link->supplier)) {
>                         /*
>                          * When dev_is_best_effort() is true, we ignore d=
evice
>                          * links to suppliers that don't have a driver.  =
If the
> @@ -1449,12 +1495,6 @@ void device_links_driver_bound(struct device *dev)
>                         WRITE_ONCE(link->status, DL_STATE_ACTIVE);
>                 }
>
> -               /*
> -                * This needs to be done even for the deleted
> -                * DL_FLAG_SYNC_STATE_ONLY device link in case it was the=
 last
> -                * device link that was preventing the supplier from gett=
ing a
> -                * sync_state() call.
> -                */
>                 if (defer_sync_state_count)
>                         __device_links_supplier_defer_sync(supplier);
>                 else
> diff --git a/include/linux/device.h b/include/linux/device.h
> index aee79fd6b32b..8afb9f2b0d82 100644
> --- a/include/linux/device.h
> +++ b/include/linux/device.h
> @@ -1381,6 +1381,7 @@ struct device_link *device_link_add(struct device *=
consumer,
>                                     struct device *supplier, u32 flags);
>  void device_link_del(struct device_link *link);
>  void device_link_remove(void *consumer, struct device *supplier);
> +void device_links_drop_sync_state_only(struct device *dev);
>  void device_links_supplier_sync_state_pause(void);
>  void device_links_supplier_sync_state_resume(void);
>  void device_link_wait_removal(void);
>
> --
> 2.53.0
>
