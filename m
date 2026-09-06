Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0EE235DA41
	for <netdev@vger.kernel.org>; Sun,  6 Sep 2026 10:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788689179; cv=pass; b=G85u0ibV+8dt3vW1rGLRDII3gtyQ9/bAtqWMWJaYNfqVKSRSmdBecDoNoDpKvqQPTq2wH2VEjF30eyLh+6qDiXxMrbZNlR/l7abFNvP+Y9sIubWkrVsh5q9dedBXrAZWXrA/86ukh9C8aZKBggla/1HdqXpPEo2+9zNqPrA6jKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788689179; c=relaxed/simple;
	bh=8a2nj5ism2pVax2zk3vSFrEurXZWIpEdcPZTfWHJ5Zo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=o2TlRhgwh9/ufrM7MhMCCmsADHr8hR6KF3TTxjZDN88DGi97R6fTOAZDN4ISZQwgReyODa/gCibb0foqBKtwJrPgndHBQvh+xofHk1ZAb4VJbhQavo27HK5qQpijag2+xrL0P91sQJhWbBwJsHXhfUqQ7aRE2zrGOylLZqV9MAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PvBEIeea; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PvBEIeea"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-8664769db58so8949057b3.3
        for <netdev@vger.kernel.org>; Sun, 06 Sep 2026 03:06:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788689177; cv=none;
        d=google.com; s=arc-20260327;
        b=fTPI5Zqdzb9ncRl8g2ur7FadYvZjnZvnHuoBYyWmNZ/AJw0azrve1xDRh11rLrfesT
         znCedLS55KeFHphk+6UBV+LiCh9GzaVF3CwUNZT3eGGni09CiYoVnf1LbUCFDV+hmVO9
         fQTd+giKfkX7Csa2SwryNQDquj8ANFa04vCGYzEzOLmjnSlua3HHOFYbV1H/UPxv4seU
         X81p1swQ9EK+ihQhanbpJ/w161H9nHSfiWRG/51sX4ul2I3vFIePunlSLhxjMdf2tIhC
         /OXmr/bDkfY+wkL/PtwC2XTrzteZrjbp0JXdyInHEfycMXXkmcavuOcqoHywYIlpFgHe
         XseA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NUDZMLU37XLHOkBGVp205BWGzlrKXxw3l2yxZUP5mzk=;
        fh=3YB40KJncF0w+Xq3qJJZif1SKvfwVg9seeOgIvyLQkE=;
        b=nqYX2cL4FsvFSmFz14U0OSj115pv7VK9lwcEzVW4fGs6JlpxAI6VtENwYnKp9yvQOi
         K96pIZrtLqCiPdChvxLqJ/TlDsqFpyS5MZyBNjLD5IYjjupDonZ4SUxdfOYRQvf2Km8Q
         hJSyjau6zWX4cv9g3kByPR7vtWPim0jBBjYP10ocXfHGFkyxMj1yYzd2F/k/k8upOAvh
         X0p7roraB/pl/IliMbQU55++8uc1+KAoB8r/VrB6Uq+5xF+Hd+CSRVjsZjW+Qns+oi9j
         RL/Tvb7JSMq5PHAgPeW1eAjIWq3kmXbfspJb8grwBSpIlnB9QBr5Byb7ISZq/72ChYhN
         7XkQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788689177; x=1789293977; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NUDZMLU37XLHOkBGVp205BWGzlrKXxw3l2yxZUP5mzk=;
        b=PvBEIeearfYwFQ5zQRpSxyR7Z+fu6q6sO+rY6F4fdFLCMynO/zBAiE5JbdSkcPgmSy
         vvfi/DHEIM+cc5P44Dpho7EE1PZGewVNtrcNQn0N6po8jwL6VEio8vKPm0kVfX1jOAKF
         i13HRkgwRuVyPZ2mOnO+WvtYZmdDFHjwCbYt3uYD9s5CsNUtvD1Trh/RCGtTQhUjK3IW
         eqV2vj0NmyWmf/zAHNY01O5CD7YfRLr6CY3E1Sz933JYloh1LP6pI0/7DRowHIDAiJl5
         tFINolo15OMURfPtpWnLEsviaLI5Rzt361bEtcC0/zvezX18Ekl8CoZBMXhAPAS2ZiBZ
         G8rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788689177; x=1789293977;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NUDZMLU37XLHOkBGVp205BWGzlrKXxw3l2yxZUP5mzk=;
        b=ckWagjDl8CdotfF9+Qk8pesnyMLQ9SJsyAELLtEhJfOBb5VrwAlCJzMx4GDoqZnb/2
         LxkG7SupSkO/qag/Av48v0qpelrA7X3+RAKxkqRWwKgmgOMSaFj7H4Ip/HS0ZLCxmw7k
         4hz9aGtP9iWqKMd4KxDuf3A0Lwdh/RN8J+32DOrBJNOCSDs8582S3G66mo8rA/RN7+x4
         xBXhQkHPpF8/TKzAk5S7KJsDQjTj1q0ayKXJrnBSqSwXDH3fpz+Tns4z9VroElfTyuZ0
         XSJFNTQ48MmATXYc66vGV8GAjv9SzzFBiigZ+YQ1l+/QZQi2cXGxIOuVA023J5Wj17SF
         dwkg==
X-Forwarded-Encrypted: i=1; AKwUvBxhRxNF8Ho+rxeMDDRaqTzuwEmTD/5xBxIMuusgIr0vP8YAZI3MMw/Bsogv/oNB8DS55IBFzp0=@vger.kernel.org
X-Gm-Message-State: AFuF++lBrJeZmYhDCn/mTZTk7o34wNeGcJ/pHmyyZYZ7Eik7kxoqiBSb
	UB1Yn+9x0qf/uvOLqXY2UMR0ghxze3kNSCjbjBcyyZTuD1oy+rIntLKEubUNyLQx9NM+wbVks5k
	+iPfz2gqhCdFOS8RwLVIa58RjQVVvvC8=
X-Gm-Gg: AYBFou3xuMN6tJRo15YwG+pgFiDs0tDa24PqwGDm/0u2Zfw/TS40kx/bPRCp2OY3VR2
	ZI6/KCJRyqPL39seO8WHk8JgLrWpGwp4KPmLAWnw0YT0bsJ7sOeT6NWjypWMYPBUsnGpTwtHCzo
	1guoUqI6BgB0lGDxSS0fuUgqq1AIc/QlvIt8Ax6JK7mTZoHMXKaTivciC385If9gy5bGeWWdl9o
	FAda2FfS3PkjCcDnH5Ha9hZtSKcQt1Gl02YfrBwnkCQf1nFc/IGQF+FjO9hQmbVMYgR3A1pICfj
	z/DAvuNZW+5atiMW7BYlRw3+R+rZJ7OG35yKnIiH7vl2MT891LDAhTsSnh8/4MmfAqWJ7m7QJoT
	qXoERf9HQ6ERe9a7wrBeLle+h2KEFehcib3vIdXW/G14nP5foH3HW4EQcxtE5o6yO/PCqBiNF4H
	tfk5aBu92D
X-Received: by 2002:a05:690c:e693:b0:80d:f376:5ba9 with SMTP id
 00721157ae682-87127656993mr46931887b3.24.1788689176856; Sun, 06 Sep 2026
 03:06:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260905013404.2712866-1-danesh.petigara@broadcom.com>
In-Reply-To: <20260905013404.2712866-1-danesh.petigara@broadcom.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sun, 6 Sep 2026 12:06:05 +0200
X-Gm-Features: AcwNN1VW01k9UPlF2rgBbT3sZ1KrZVqsfWM92xFXCf1YwwGiT4ONQM9vjjTKilU
Message-ID: <CAOiHx=mhb64eSKVy-HH+dY=F-+1TkGmJOQcUg9UAfwKRNqO7Ww@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: bcm_sf2_cfp: fix NULL deref when port_num
 is out of bounds
To: Danesh Petigara <danesh.petigara@broadcom.com>
Cc: florian.fainelli@broadcom.com, andrew@lunn.ch, olteanv@gmail.com, 
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, 
	vivien.didelot@gmail.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Justin Chen <justin.chen@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Sep 5, 2026 at 3:34=E2=80=AFAM Danesh Petigara
<danesh.petigara@broadcom.com> wrote:
>
> From: Justin Chen <justin.chen@broadcom.com>
>
> bcm_sf2_cfp_rule_insert() validates port_num against
> priv->hw_params.num_ports, but the bounds check was placed after the
> calls to dsa_is_user_port() and dsa_is_cpu_port():
>
>     if (ring_cookie =3D=3D RX_CLS_FLOW_DISC ||
>         !(dsa_is_user_port(ds, port_num) ||
>           dsa_is_cpu_port(ds, port_num)) ||
>         port_num >=3D priv->hw_params.num_ports)
>
> Both helpers call dsa_to_port(), which iterates the port list and
> returns NULL if no entry matches.  With a user-supplied ring_cookie
> large enough to produce an out-of-bounds port_num, dsa_to_port()
> returns NULL and the immediate ->type dereference faults.
>
> Move the bounds check first so dsa_is_user_port()/dsa_is_cpu_port()
> are never reached with an invalid port_num.

While in isolation this makes sense, AFAICT the only possible call
trace here is:

dsa_user_set_rxnfc(...)
{
        struct dsa_port *dp =3D dsa_user_to_port(dev);
        struct dsa_switch *ds =3D dp->ds;

        ...

        return ds->ops->set_rxnfc(ds, dp->index, nfc);
}

int bcm_sf2_set_rxnfc(.. ,int port, ...)
{
        ...
               ret =3D bcm_sf2_cfp_rule_set(ds, port, &nfc->fs);
        ...
}

static int bcm_sf2_cfp_rule_set(...)
{
        ...
        ret =3D bcm_sf2_cfp_rule_cmp(priv, port, fs);
}

Since the port is dp->index from the dsa_port from
dsa_user_to_port(dev), AFAICT it is guaranteed that dsa_to_port(ds,
port) will be non-NULL (else the user port's dsa_port::index would not
the user port's index, which would mean the data got corrupted
somehow).

Also seeing how ds_user_set_rxnfc() is
dsa_user_ethtool_ops::set_rxnfc(), I don't see how port could ever be
anything other than a user port, but maybe I am overlooking some code
path where it can be called for a CPU port.

The check for hw_params.num_ports is sort of valid though, AFAICT sf2
doesn't ensure that the device tree registered ports are within
hw_params::num_ports, though I would also assume it would break at
other places in that scenario. Maybe we should just ensure at
registration time this is the case so we can just drop the check here?

Best regards,
Jonas

> Fixes: 4a5b85ffe2a0 ("net: dsa: use dsa_is_user_port everywhere")
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> Assisted-by: Claude:claude-sonnet-4-6 vscode
> Signed-off-by: Danesh Petigara <danesh.petigara@broadcom.com>
> ---
>  drivers/net/dsa/bcm_sf2_cfp.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/dsa/bcm_sf2_cfp.c b/drivers/net/dsa/bcm_sf2_cfp.=
c
> index 84a086c3e99b..6ac5cf154f31 100644
> --- a/drivers/net/dsa/bcm_sf2_cfp.c
> +++ b/drivers/net/dsa/bcm_sf2_cfp.c
> @@ -867,9 +867,9 @@ static int bcm_sf2_cfp_rule_insert(struct dsa_switch =
*ds, int port,
>         port_num =3D ring_cookie / SF2_NUM_EGRESS_QUEUES;
>
>         if (ring_cookie =3D=3D RX_CLS_FLOW_DISC ||
> +           port_num >=3D priv->hw_params.num_ports ||
>             !(dsa_is_user_port(ds, port_num) ||
> -             dsa_is_cpu_port(ds, port_num)) ||
> -           port_num >=3D priv->hw_params.num_ports)
> +             dsa_is_cpu_port(ds, port_num)))
>                 return -EINVAL;
>
>         /* If the rule is matching a particular VLAN, make sure that we h=
onor
> --
> 2.54.0
>
