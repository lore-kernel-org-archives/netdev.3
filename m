Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8492343A7FA
	for <netdev@vger.kernel.org>; Wed,  2 Sep 2026 10:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788344213; cv=pass; b=joTTI6uSWOxNwrf+3WpNVnrSKTy1+npXTZuWT0cMI1nMsYQvOqie4FUjyMFkeD998cVnmGsPm5CHZG1+wsS0AKd+giU50bW5jCqcJEzof4i5XDWYUe4MGprtG6rj4YI11gx3NewA2YQ/GwfUDGnfckWrC/ZXOIOnBSohKkuuALQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788344213; c=relaxed/simple;
	bh=OxkC+UQNPmTnPjpxYR7wsxARRTLqWm6Mfgpq9rElfgk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlQEnguae7U31xLaE9AXBwkFmnVGxC+7ScOAaUJzgvEA9nsMbxkOvYeHk8IAtL/+7SCxYSUZWWAXGs2UGQT20uZUKl3eLj0XEsNTDV5b0A38WhcQpcqUwL7zCoyrdlVZRnMLYocxfdkH31hah77IPsFqtgjLWSg4uRgHEAj6TK8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=MTVEzfE8; arc=pass smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="MTVEzfE8"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-3a309f92daaso7828351fa.3
        for <netdev@vger.kernel.org>; Wed, 02 Sep 2026 03:16:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788344209; cv=none;
        d=google.com; s=arc-20260327;
        b=XacxXjq6IyLYiyhzPMm6O6eGWxcOL+94eZL6mL7KePolS1kwrFXVv8q/+MgVVLEeV+
         44Lytqtx70/AfK19WnDPJlv7aYAaFH/URQJkuH0wQhE7GmECqgtglljlXJond6tHiWeQ
         iNG/YnOpiVaN5p4Hs92NGjGtX1tRrioGzB0GhvG3H8pL4DzYUcUwrnmzQbOP1fVP8mID
         OrLCG/gTYYKTcwFq3cMPJSpENoJgKTrrPfAb307YOImQsPRrsI4PjkNKk/ye0mUHWU/H
         3rmq23KQvVg9uR0tD9JoKK1ArcxOXYziorRm2yxsHeQ4Y0EhPBB58I2Bm/myJ2gOjF3P
         tipA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=eB8x9CRrNk1XnJUaioaAbBG800wLPGIMi5GlCYlPpkc=;
        fh=5/BxLna2m37bEJkJg2hvCCngMFuev5/YMYTWmdMPxyw=;
        b=eJ7Ltp9kSvz1tx0nqoBOZVBfBn/lzAzKomPbLnw7b/ukAH5dNFd7FrDXTphJcCnK8p
         yCatN4h5lauz6+TzwHFGmAyc92DwbSzuifrAK/+kSh9Uvhzg3/dX58RpWQ8lLX42wJ/k
         LCUvfYDN4Xdf1nG4rYHxLzqY7F8WffNOTmr6jR42hLkXrCB2UpejNkG7M2oTv1ZKL4HE
         v4uFFJUUSRYtaso8/BOb7ZNXhSddQ5JVSiuXRoX2Zb1mYhTZO3Y0fWaLZj4NYj+8dFL2
         mhmp4xZNmKF8Vae7kpyLJG6aYYbNPUZ4pkaDldq4rUqcGMFMqo0H3xKb7V0Txoyk6o4g
         Cw/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788344209; x=1788949009; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=eB8x9CRrNk1XnJUaioaAbBG800wLPGIMi5GlCYlPpkc=;
        b=MTVEzfE84KflnmDn4ziageLEu/D8SOGpyoyupJ0tsX/G5RunaIwKjo+yGoWN0t9OPv
         VG+tES8SI7L/gKM5X4Ek5KpItr56U2qeDo/Ims5lIWLOCXX1pGNl6rIs90yK8l4XkSuA
         Dv7XfNaiWo5s5HuSNO5W9W0y/6EAai4V8x6NuTangx6dnz7YHjapOn2k7vJTZSCHB/GO
         xwbi+o9aGwKU1pNaXYPfoBroT5RuWwuEzElixpMxOx9gu7+nFuI+H0Zeatbf7pqZxzt5
         5EcAaUWcuHo/WT4zy4Yr7Q9eKp556j2iRqDs7WqQfpenvQCmkTbFD2CVCoGWmMyerTk1
         MEWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788344209; x=1788949009;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=eB8x9CRrNk1XnJUaioaAbBG800wLPGIMi5GlCYlPpkc=;
        b=UqQKeaokxyCvZfdy/Cxh69h6IPWZN+nKQhij2bLWtsb9P3R+hVYmbVNPJnjKQjvdUb
         rZZZHlj7gJ8fyrE/o8dkGzv10L3sXEfxeN/DdZfsk95Gv6CB97UnQD9Dl8uiaCZKxTOP
         2PPWOt9YTTxU5KqKxvlxfafivJu6LveJ7s5gpKQDLAZUoQvv7a0ntAwFnqj2bl5/kBlj
         /yKjDp0YJw25+Un6NhvfjkIYvXQoSTPi1QwHk/jIB53wo3XNHeQpa62fBy2a0Y2aLbBU
         3zgK+JHeA3hfteOlVVY5Vz1gywOQSUQvMk3EErsVKDEu9pV18WDhZXiwR8OyA6Rr3ktC
         jJ6g==
X-Forwarded-Encrypted: i=1; AKwUvBwpEMp2ShuV8VcpDXHWGK0LJ6SHnkXTA8mB56v7bHN35JLBH9fkCc8khlg60Js6cFRocGSovLc=@vger.kernel.org
X-Gm-Message-State: AFuF++mql6GJwIm0LdDOLnJ+5H4x7+MOXWboK83mXOS1HaciHY17O+DY
	OFmnHj/SYvoGwS4e4wpgrvpCFdNsM3w4STlBDbG69phSYlGQaE9HOcKTZz/+Qc9OcZrSqvQVyGH
	v2fcpnGDXNJHqiy0R1yR1KsJfKLWSntoRGSjewHKAlQ7RjvZr9tz1wFOt8GINi7Mb
X-Gm-Gg: AYBFou0L94KTACK0cojV3ZUiEI2G1ePCxT9HwItOThR+Vo35TycQB2aUTozowDQfe+h
	z/kyiMU3AYQEKyIUE4VDQ7/+IrQh+7baJtS2HnPKWj0B56MPzImLq18ZBp+vfYhrMPrRc/DWVkA
	dVPsqkIBi0HcTczcwFPuGEUG78XRwAA8odrLVuPtz+AYAHCW31WjOhZmVPcMN9MmRyYOFXU4IEp
	2/FqeMEyQgxV+JCoetx4FRclX0gBNLKQG74lE5gvI09d/tXf8nk3tE5YLYEk0Mzg2CG39e0IIcL
	vvKexhxPjpDCcFTqCeN1rfcG0NmyFU0/v0LuHwt6Evh+85GopfxjvwclJ0HybjRXfRLH44855xz
	506TVm/+N7CgU
X-Received: by 2002:a05:651c:1443:b0:3a3:1391:fb19 with SMTP id
 38308e7fff4ca-3a34ff11646mr8038211fa.9.1788344209091; Wed, 02 Sep 2026
 03:16:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785596603.git.zihanx@nebusec.ai> <e9a3909c7a6281967961773ca841e860b8ecf40e.1785596603.git.zihanx@nebusec.ai>
 <6326f119-048e-4d46-ab2f-debb20420297@datenfreihafen.org>
In-Reply-To: <6326f119-048e-4d46-ab2f-debb20420297@datenfreihafen.org>
From: zihan xi <zihanx@nebusec.ai>
Date: Wed, 2 Sep 2026 18:16:35 +0800
X-Gm-Features: AcwNN1VJQMwlHjV16Apj6_hoFNf4qd9w8vLJXYoDBFJHRBvXJSk1cx2HQCyvrMc
Message-ID: <CAANe3eSyr9sSS1q1LfFXztXaZGXMR0HAiYmT4=eBhf0M5asrXQ@mail.gmail.com>
Subject: Re: [PATCH net 1/1] mac802154: fix netdev use-after-free in beacon worker
To: Stefan Schmidt <stefan@datenfreihafen.org>
Cc: linux-wpan@vger.kernel.org, netdev@vger.kernel.org, alex.aring@gmail.com, 
	miquel.raynal@bootlin.com, davem@davemloft.net, edumazet@google.com, 
	pabeni@redhat.com, horms@kernel.org, david.girault@qorvo.com, vega@nebusec.ai
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 2, 2026 at 4:15=E2=80=AFPM Stefan Schmidt <stefan@datenfreihafe=
n.org> wrote:
>
> Hello Zihan,
>
> On 8/2/26 11:23, Zihan Xi wrote:
> > mac802154_beacon_worker() reads local->beacon_req under RCU and derives
> > the sub-interface from the request, but then drops the RCU read lock an=
d
> > continues to use both sdata and the embedded wpan_dev.
> >
> > mac802154_stop_beacons_locked() cancels only pending beacon work, clear=
s
> > local->beacon_req and frees the request.  A beacon worker that is alrea=
dy
> > running can therefore continue after interface teardown and dereference
> > the freed netdev private area.
> >
> > The scan worker already pins the netdev before leaving RCU.  Apply the
> > same lifetime rule to the beacon worker: take a netdev reference while
> > the request is still protected by RCU, and release it on all paths that
> > continue after the reference is acquired.
> >
> > Fixes: 3accf4762734 ("mac802154: Handle basic beaconing")
> > Cc: stable@vger.kernel.org
> > Reported-by: Vega <vega@nebusec.ai>
> > Assisted-by: Codex:gpt-5.4
> > Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
> > ---
> >   net/mac802154/scan.c | 4 ++++
> >   1 file changed, 4 insertions(+)
> >
> > diff --git a/net/mac802154/scan.c b/net/mac802154/scan.c
> > index 65089826f..ebd092d40 100644
> > --- a/net/mac802154/scan.c
> > +++ b/net/mac802154/scan.c
> > @@ -416,6 +416,7 @@ void mac802154_beacon_worker(struct work_struct *wo=
rk)
> >       struct cfg802154_beacon_request *beacon_req;
> >       struct ieee802154_sub_if_data *sdata;
> >       struct wpan_dev *wpan_dev;
> > +     netdevice_tracker dev_tracker;
> >       u8 interval;
> >       int ret;
> >
> > @@ -427,12 +428,14 @@ void mac802154_beacon_worker(struct work_struct *=
work)
> >       }
> >
> >       sdata =3D IEEE802154_WPAN_DEV_TO_SUB_IF(beacon_req->wpan_dev);
> > +     netdev_hold(sdata->dev, &dev_tracker, GFP_ATOMIC);
> >
> >       /* Wait an arbitrary amount of time in case we cannot use the dev=
ice */
> >       if (local->suspended || !ieee802154_sdata_running(sdata)) {
> >               rcu_read_unlock();
> >               queue_delayed_work(local->mac_wq, &local->beacon_work,
> >                                  msecs_to_jiffies(1000));
> > +             netdev_put(sdata->dev, &dev_tracker);
> >               return;
> >       }
> >
> > @@ -450,6 +453,7 @@ void mac802154_beacon_worker(struct work_struct *wo=
rk)
> >       if (interval < IEEE802154_ACTIVE_SCAN_DURATION)
> >               queue_delayed_work(local->mac_wq, &local->beacon_work,
> >                                  local->beacon_interval);
> > +     netdev_put(sdata->dev, &dev_tracker);
> >   }
> >
> >   int mac802154_stop_beacons_locked(struct ieee802154_local *local,
>
>
> This patch does no longer apply. Please rebase and re-send.
>
> regards
> Stefan Schmidt

Hi Stefan,

thanks for taking a look.

This change already landed in net.git as 5f26a690e8ef
("mac802154: fix netdev use-after-free in beacon worker"),
applied by Jakub with Miquel's Reviewed-by.

If wpan.git still needs a rebased copy, I can send that. Otherwise
I will leave it as is to avoid a duplicate.

Thanks,
Zihan
