Received: from mail-qk2-f42.google.com (mail-qk2-f42.google.com [74.125.230.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520424F4752
	for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 09:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.234
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674099; cv=pass; b=ASvBF3b6q/76kd3GaKSN5gSkAwLIwjD5U+jZOYfaw3SjcSkTp5dHKb2kKbUEMDuM81Dsh5CNIx0u5XH2/3rFZdUiH0QG+pCW9UmUDBQyuqh84h8xWyWftLh0kVRz67kRP7mUI4XvTB7X8nDCnNqN/Cv3XuikFrCEWs1u93PO7J8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674099; c=relaxed/simple;
	bh=7k54aqi82jIm649ecr4wVLrwDqk43k8dDuyIeGVgB5k=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S3KtJk1bri83Lno9jq1dSQljwHBTcHP8esgVflLgHgiNgZjQsYIa3/54Pk1HtbSCMW/MbKCwllbUJRzkcsAP4BggROnUr6OWhHRORCcw+iKYixPuUgIduiCBgdG+DetkH8r5IXmdKqKO88qacy1mx371jMJGz7FxNslV4Whb1cI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Zp/JXUNT; arc=pass smtp.client-ip=74.125.230.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Zp/JXUNT"
Received: by mail-qk2-f42.google.com with SMTP id af79cd13be357-93be29bb454so591389285a.1
        for <netdev@vger.kernel.org>; Tue, 29 Sep 2026 02:28:11 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790674088; cv=none;
        d=google.com; s=arc-20260327;
        b=ZjGZFr0KoZ9bF7FPu9puPmAI64VjTeJoAzIC8RgfnK41FikkJ7LbdDFkJOFh56PmQr
         coI9aoSEajTRniGDL4HxamA3P0+hQBgofAbuI2gpTvFnbcoTqubyfKrC5OnLSEzYcZp8
         NHHBCVXlOJOj7w/u0cPGBopvZHrPl7WvLwYgYRabNb3zK3YyJL/6/EFzzLwTncgAgoNT
         jC48Vie6dO1lgnIwO7NNvA11w8UbmMiG3SaAXh2Qlj6/0d7UkOq9wOdWpPMH0g4VRQe4
         xNqMZwQad10MZcAqeh7ImPrzk+2Ick6BsXoUPZvOuII5n4bQLOkTTaIH2d8jwCDU5s+X
         EL9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=plBZts7qmMjmmbhkJeYq4DD26rs9avPiOAzmb75d1es=;
        fh=sKxfmrTR41+QlmmiCf9eIJasfzYKto7vJEyoZAHjn8g=;
        b=s6bQoaeqSioCB5/RSXZeY/c1MPv7jjxzFU/72VOEsajdKsDH4sZyw8tQQsxQB5ybsP
         hwg54fMz27siasNfGaLhNm953tB043lFAPFjKWy8SzEGPZQw2Llf2ruoMg4M7QpFeP4z
         Mzv+EMJj/Jf/7lq9OvnOiN729gEskDxzSFi7AjJ+cgQWpTG4qNGRXzET8Qht5+AuJK3Z
         yYzJxGXBnffquHBcNhxYC+Emc+ZTcwgZbe0T8HRs9cJT6qIcB7jfJWvVxCNA2ZvjP/vm
         PDC9C6R+GNEwuVhg+SiVDZOsHY5KoNokL5OcS/b4+81/TXM7dw+55IjC8E27JlXkSggb
         zZ1Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790674088; x=1791278888; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=plBZts7qmMjmmbhkJeYq4DD26rs9avPiOAzmb75d1es=;
        b=Zp/JXUNT6G7FUEhUXSgCCcz6tONfi6AW2CGBt7edjRonH6OaUuhBzu4CbEbKb6/UFo
         pmxYEuJA7++dFXHkjKoaN+SM/LBcyciQtGd9mtt6BCF6WegikVewsp8gmxv451G2IoQ0
         3QSU9TPI0M54jp07SeiG1ORWQAIKTGvbHyFMCZCwB6cYH3An6AG6ZvmvrfwgvylQdqgB
         /eEVNA5q4jiB9GByKs9ePbqCr+HFjRm0Og2ninUvi2d6oE8TCt3tB69ctGrIUUUJb6Fb
         2q1Sp6PCmd9R5WgPV+eGesmp+tmyptJB/1tTXvDtWQxglGzpHgkv6k2Qqj8x0siibPW6
         P7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790674088; x=1791278888;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=plBZts7qmMjmmbhkJeYq4DD26rs9avPiOAzmb75d1es=;
        b=uhNs0bEzBXsnIWUiJC9uPs3Tsh95890smPRCrkd4lX5qsc5fU1wBuipXjT4TcemNFx
         NxvPns/FBU7lB8EL+HNRdvnBU2C68Vegp1coh59LJKGiewtSSp+tsY4J6GXbPeTtqcg9
         xCfY3PCoRBjzhUrnyx9UYpUQp7UqP1PkNNg8viK8FT1vnRhykcu1VnWmKD3OAjO5Lmmo
         GD82tt9Zvd/DBm4Iqu7oflYsQy0OIjfcDi9wdHpY2LbPoeK0/4q1FDDBBcu8PhjaN+xG
         gem60dREjVbR/4YKBKqP+eYjQEKZmnRY35ZaLnNeOuUBPvpuAp4tu8BE+7nl5WwPlw3/
         /0mA==
X-Forwarded-Encrypted: i=1; AKwUvBwRfIUTiN93z4ncIxWsfIT8nCnT7LrcRW2Ms9SRknYH+/DR+2O8gryU4s/DlBsQEscPg2MSCEM=@vger.kernel.org
X-Gm-Message-State: AFuF++kmhHsCqOXbir5qa9XemSsHBKUs22rnIH1uPT+QF+O6hhk0+3hn
	N59sgW8KqTJqDQLSG/5SBnbYPJ6Qn88cAPju3upZj+ObGARh/8huFm6fDQIDhmFg58sx3NdtgcA
	xyETDu0tO0Skt4T/X9PzG9szxTa5L29NWiKmr4lkU
X-Gm-Gg: AYBFou1eaQ+NrnrJvh0m2zIrT8OBVuyavT/ZKzFASSi942VkwsiNVpi+f7p6p2rucNv
	ROrI/B82m4jKwz7mrSgl5CBWo/frglgywjt0gHZs/PLcvGq6jlhZiTkbeojZ9wRFRzf2TupgH7a
	jDhHqLYsLUFIgHr+JHB151sa/5PxiVqnfqwdWi6igLNJeEtF3quf7xYMeYC1TM+RfcSQdrI2QAt
	SX+tGAPGQgIuMzfN9VKQuWp2kmeyHydFjWjavYsK87Ta0QHArd9MuFsqasfFviu9Hsr25efCbn+
	WjNZZa20Qi28RMQiOxIQ7MX5vnNeAQgN11oUBWzaebEk/LvTzFP9ld1ur8Tc8ePO5flvt2EZ969
	PnpWiFuPpzngUMkwfeNL2rIxi58X2cZs2dVwrLj1Xcpvg+t/v5RWZlzErhH7i8mRKXyH9
X-Received: by 2002:a05:620a:1722:b0:93c:72d2:ccc0 with SMTP id
 af79cd13be357-93c72d2cf2fmr1237507285a.17.1790674087574; Tue, 29 Sep 2026
 02:28:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260926173315.2452612-1-nicoyip.dev@gmail.com> <arty-oqohbGiefgS@kwain>
In-Reply-To: <arty-oqohbGiefgS@kwain>
From: Eric Dumazet <edumazet@google.com>
Date: Tue, 29 Sep 2026 11:27:54 +0200
X-Gm-Features: AclHuK9c7PvZwZmPzikTgYtVRuxFtCEpTXGrsvZi1CqGH1BjIm6bN6R2TerIyu8
Message-ID: <CANn89iLzwsrka1MUS64RKxx9TbKxGdwzB63nzs6v9endCwUahQ@mail.gmail.com>
Subject: Re: [PATCH net] net-sysfs: release the TX queue tracker before
 allowing reuse
To: Antoine Tenart <atenart@kernel.org>
Cc: Chengfeng Ye <nicoyip.dev@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Mark Brown <broonie@kernel.org>, Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 10:13=E2=80=AFAM Antoine Tenart <atenart@kernel.org=
> wrote:
>
> On Sun, Sep 27, 2026 at 01:33:15AM +0800, Chengfeng Ye wrote:
> > An interrupted sysfs_rtnl_lock() can drop the last kobject reference to=
 a
> > removed TX queue without holding RTNL. netdev_queue_release() clears th=
e
> > kobject before releasing queue->dev_tracker, allowing the queue to be
> > re-added while the old release still needs the shared tracker slot:
> >
> >   CPU 0                               CPU 1
> >   netdev_queue_release()
> >     memset(kobj, 0, sizeof(*kobj))
> >                                       netdev_queue_add_kobject()
> >                                         state_initialized is clear
> >                                         netdev_hold() installs new trac=
ker
> >     netdev_put() releases the new tracker
> >
> > With CONFIG_NET_DEV_REFCNT_TRACKER enabled, the old tracker is leaked a=
nd
> > the new lifetime's tracker is released prematurely. A later queue relea=
se
> > then reports a double release. The numeric device references remain
> > balanced.
> >
> > The kernel reported:
> >
> >   ref_tracker: reference already released.
> >   ref_tracker: allocated in:
> >    netdev_queue_update_kobjects+0x23d/0x5c0
> >    netif_set_real_num_tx_queues+0x111/0x820
> >    veth_set_channels+0x327/0x930
> >    ethtool_set_channels+0x3ee/0x490
> >   ref_tracker: freed in:
> >    netdev_queue_release+0xbd/0x130
> >    kobject_put+0x1f9/0x280
> >    sysfs_rtnl_lock+0x18b/0x1f0
> >    xps_rxqs_show+0xad/0x250
> >   WARNING: lib/ref_tracker.c:322 at ref_tracker_free+0x49e/0x6d0
> >   Call Trace:
> >    netdev_queue_release+0xbd/0x130
> >    kobject_put+0x1f9/0x280
> >    netdev_queue_update_kobjects+0x3f9/0x5c0
> >    netif_set_real_num_tx_queues+0x111/0x820
> >    veth_set_channels+0x327/0x930
> >    ethtool_set_channels+0x3ee/0x490
> >
> > Release the tracker before clearing the kobject. Use a full memory barr=
ier
> > to order the tracker access before clearing state_initialized, paired w=
ith
> > the control dependency from that check to the new tracker allocation.
> > Keep the device reference until after the reset so that the queue stora=
ge
> > remains alive throughout the callback's accesses.
> >
> > Fixes: b0b6fcfa6ad8 ("net-sysfs: remove rtnl_trylock from queue attribu=
tes")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
> > ---
> >  net/core/net-sysfs.c | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> > index 352173df7578..b9aadc4c000c 100644
> > --- a/net/core/net-sysfs.c
> > +++ b/net/core/net-sysfs.c
> > @@ -1906,8 +1906,11 @@ static void netdev_queue_release(struct kobject =
*kobj)
> >  {
> >       struct netdev_queue *queue =3D to_netdev_queue(kobj);
> >
> > +     netdev_tracker_free(queue->dev, &queue->dev_tracker);
> > +     /* Finish using the tracker before allowing the queue to be re-ad=
ded. */
> > +     smp_mb();
>
> Can't you use smp_wmb() instead as it's used to order two stores?

I do not think smp_wmb() would be enough: ref_tracker_free() only reads
queue->dev_tracker, it never writes to it. We need to order a load
before a store; smp_wmb() only orders stores.

But what does this smp_mb() pair with in netdev_queue_add_kobject()?

The changelog mentions a control dependency, but netdev_hold() is not
inside the if () clause, and state_initialized is a bitfield, so
READ_ONCE() is not possible. This works thanks to the early return,
but it is implicit and fragile.

Please add an explicit smp_mb() in netdev_queue_add_kobject() after
the state_initialized check, with a comment pointing to
netdev_queue_release(). This is not a fast path, and will help code
review/understanding.

if (unlikely(kobj->state_initialized)) {
        netdev_warn_once(dev, "Cannot re-add tx queues before their
removal completed");
        return -EAGAIN;
}
/* Pairs with smp_mb() in netdev_queue_release(): the previous
* lifetime must be done with queue->dev_tracker before we reuse it.
*/
smp_mb();

Also change ( /* Finish using the tracker before allowing the queue to
be re-added. */)
to the symmetric one (pairs with smp_mb() in  in netdev_queue_add_kobject()=
...)

pw-bot: cr
