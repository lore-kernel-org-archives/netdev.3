Received: from mail-dl1-f53.google.com (mail-dl1-f53.google.com [74.125.82.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE98339386
	for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 16:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791735932; cv=pass; b=XdjBUC1hXLMFM53grtFYF9iQqnGpwD0ieLko8E7AMu9pRe/7isU3gi/VhbsYr79Xh9CfQB/YQbsExGC6zd0sgg2xZcVFuL5GRnxsXbD+r93JtJOHRV+pjybFg9/xPSAu8+Xq8XtJiqW6X+v5xJN0XVdlECCtHzPBDLwtclOATYk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791735932; c=relaxed/simple;
	bh=ba9QqDkcrd3Mro0zu2+iADvo+PIFbtPGZiWLHSGlxdw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=t0T1mY5ZjK2qhjywaOYD/9pkOojJTs81It5SBH7L+/T+zNm6Uo87EEEmfuN8guK5foEQSxvkc+NwEDEj9hitXio49uAokLvinZhZtxLxJSbC01Csp6IB0USwo24JGoxvzbuyQ8NOWfea2wUOzUrWZVa0KE0ouMQv7efzpv/NGug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T20g+rKu; arc=pass smtp.client-ip=74.125.82.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T20g+rKu"
Received: by mail-dl1-f53.google.com with SMTP id a92af1059eb24-150ef97e790so4000c88.1
        for <netdev@vger.kernel.org>; Sun, 11 Oct 2026 09:25:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791735930; cv=none;
        d=google.com; s=arc-20260327;
        b=qm+hW8apLP//Yv18FD7BQxsNoE0qXQ/dXX1p/p1AbIIQ0lyepBsyf+vZBRbDqVSu82
         HuVLOd1yKpc5dzlIT4Wb22koLIe15mY9vNuQB0I/rMQgqFNzvoCzOXR5VeEMkjDh73CO
         viae1S0kw44N26P22XOaQjnAtxa8K/RDQJmpKEQp7ruwMDbj+2/WmHLNSmSzf3UtjZiH
         RhlNzfHsSWjwCe7zkUyuuUC/IJF7iSqyudk4M5FL9pQTRBfcbiFLKsHihEVJHnR9XnnO
         jORULXp+Y3imPpzlVVHqFGhQD0ibqpLqR/kqdWxRbk0Rls5ME3U73C+K/w7GiN9jLkK+
         pE2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ba9QqDkcrd3Mro0zu2+iADvo+PIFbtPGZiWLHSGlxdw=;
        fh=MCLNLOsAYM22HB8/4GjlfJGbZKg9Ri3tSUc6hHxm4qo=;
        b=HGpCklupFxB7/Mz0YZ+VltSgi1w4Fc8CBC4oqQbNC7HGKUOim/h9KgTz1IPllZ69ve
         WdgTVKQcuqKox+WCmSNPAhoi9mwQh2VjiZfnqypImZCODR6AnqF9wbuge7fnwjKNAT72
         rdRRC1vGT0H8Rrto0lXKs0+XWEctgplgsyHOS7PgHQ7WPr1S/Vb3doFsXnsk9z8aWhpK
         JRt3yXF0Gcbron/0I1gcGTKCb/tEisE6seDY1xomvpKHNthF0AyYXIRieE2W2Caqylgd
         8YyDzJCIQuKpoiLC/WsqmJm5wkqo8M2ze7Ky9kWe1xIu7DnBsezlal/7XYiF69Xik11O
         iBrA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791735930; x=1792340730; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ba9QqDkcrd3Mro0zu2+iADvo+PIFbtPGZiWLHSGlxdw=;
        b=T20g+rKuexDaHBgmTj1yywctFL+KVF/SbLOdMmQOURWO5WcdxJzpUSn5jxAEGQzMcn
         mhGExkzNY3IZnf+g73vFED5aod1Qm+TTlGeOCjNFtzZRbBRSRiBS7jHHXyIGlSY1w3Mi
         MuDv8ylqIpFxdXTW2adfi9gP4ZvpBTpSJgOPRi219FQczvzjyjdx/5ydP9h2oK5aJPqw
         ZIHm6yW3oZMQyEYHh6U6/Q0GBUkkDPL6Ss+gXwWLM0SY9xkcbO4SLjiXS0Nv17449WIY
         JgjKKR20mOoETyTtOhp3t4voU1/KkUQlfdYRcTJEMpEN3Lw7gudOl0ywbRsormauNb7V
         He5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791735930; x=1792340730;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ba9QqDkcrd3Mro0zu2+iADvo+PIFbtPGZiWLHSGlxdw=;
        b=i4GGfRqdjy0PQhTZMMpa6rIU+9Wls26r3hWvzu0LKGDFdn8D35x/jqAGDpzjlxrCbU
         Ap1VPw0yRZChrH77i2KnpXd5/2LyMezRu6F6Sw0cbAoYc3/B7T4v8f6fihqH0uCiHvDw
         LS1dlP2hTdaXMXYdCR58/4heBEbQ2Q+zovPZnF4gLmSefhLFvAmcjUrUdBIYw4ospA7g
         0E2nyQTsDvVnRo3ol6GuOo7mphMPJmT03JxSd3Z7Wqo2sWZ3kFuc95CPJ0Pkzi5XS0tX
         merwIhZN2Kaub52gBzGIzcNJpikdhxMBHr9v2Cqq0y5FVlNr04kKUK1vdeizgF4ogGca
         V10g==
X-Forwarded-Encrypted: i=1; AKwUvBzoELb2LpdewihyECatNKWg9GGu2zcy2XslkyWqVJp/RX7jaRKcC4nBp8MlUyfriKkksniWCos=@vger.kernel.org
X-Gm-Message-State: AFq9FYLUSwUYWSc0vJOvKOs/WkkhNzPn7kyEt/cmJzoVLwGDERnBZc0H
	t9UW5hOCzYFAfN37c48ZZvSlXuugcpAqBvWqpMnl1ywK9oXuVaug96GsAFvnn6CDwT32M/Ikpa9
	Ece0r+Kqf/CYt2e3VXkkvwVLo0jtc069Ja7bx38PS
X-Gm-Gg: AYBFou2bvexpW+oNb+NtCn6YC0H1qEfqJQ0UhjqyQx/BD1fSBPUy4L1EzjUK74WX7al
	n6rou92cYPV1MYMvY9AVi1z40ezxAXzm4L9fqdoW2YcTcg+rvAtkGf7PWrBdqp0oN+90UQJvYri
	7vxYN1oWMzhy9emRrOyeWVOFQSfsiuCLtfU/p74v48YkCViMHQBndkFerq71JAi5EorcdWZXviw
	8pXEH5SDeYW7auBq8XQVEXZfUAvsI+e66H65UMW3oBOHQRgnouzzV9OOj20XWKXG5ekkAdRMeHk
	5//L/dFz43ThrkTRGzZ09vLdz87SeNb/SJZJdF0OUpT/1n7swALNGg==
X-Received: by 2002:a05:701b:2046:b0:12b:ff98:1ed9 with SMTP id
 a92af1059eb24-16ef393e90bmr155257c88.12.1791735928492; Sun, 11 Oct 2026
 09:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008132815.654147-1-tariqt@nvidia.com> <CAHS8izNSo4YzXxD3C6c2HohdOfH2GK1M=51biuevLUk3vz5k4g@mail.gmail.com>
 <CAHS8izMKNeEmJM0wOgtoz9_3WRLUOqP0PEDMn5SZ+hXTKTwSyw@mail.gmail.com> <7a0bff03-2a7d-4819-b96e-a5ad8a5f6bf6@nvidia.com>
In-Reply-To: <7a0bff03-2a7d-4819-b96e-a5ad8a5f6bf6@nvidia.com>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 11 Oct 2026 09:25:12 -0700
X-Gm-Features: AclHuK96WOT_SJ9p7jbqKZ0R6AaK6MLbmYKOL8eVilAIXlLow0JHMppEEuz4fcY
Message-ID: <CAHS8izOPRjO54w0ehXCXahn3LPD7uqyJYX=zBeDDYG91Sm+DXw@mail.gmail.com>
Subject: Re: [PATCH net-next 00/10] net/mlx5e: Add netdev support for data direct
To: Dragos Tatulea <dtatulea@nvidia.com>
Cc: Tariq Toukan <tariqt@nvidia.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Byungchul Park <byungchul@sk.com>, 
	Carolina Jubran <cjubran@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>, Gal Pressman <gal@nvidia.com>, 
	Jacob Keller <Jacob.e.keller@intel.com>, Kees Cook <kees@kernel.org>, 
	Leon Romanovsky <leon@kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	linux-rdma@vger.kernel.org, Mark Bloch <mbloch@nvidia.com>, 
	Matt Fleming <mfleming@cloudflare.com>, Nikolay Aleksandrov <razor@blackwall.org>, 
	Saeed Mahameed <saeedm@nvidia.com>, Shivaji Kant <shivajikant@google.com>, 
	Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, 
	Stanislav Fomichev <sdf.kernel@gmail.com>, William Tu <witu@nvidia.com>, 
	Yue Haibing <yuehaibing@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 10, 2026 at 7:16=E2=80=AFAM Dragos Tatulea <dtatulea@nvidia.com=
> wrote:
>
>
>
> On 10.10.26 01:54, Mina Almasry wrote:
> > On Fri, Oct 9, 2026 at 9:42=E2=80=AFAM Mina Almasry <almasrymina@google=
.com> wrote:
> >>
> >> On Thu, Oct 8, 2026 at 6:28=E2=80=AFAM Tariq Toukan <tariqt@nvidia.com=
> wrote:
> >>>
> >>> Hi,
> >>>
> >>> This patch series by Dragos adds data direct support for netdev devic=
es,
> >>> allowing a mlx5 netdev to issue DMA commands through multiple paths.
> >>> This feature is critical for improving performance and reaching line
> >>> rate in certain environments where issuing PCI transactions over one
> >>> path may be significantly faster than over another. These differences
> >>> can arise from various PCI generations in the system or the specific
> >>> system topology.
> >>>
> >>> Data direct for netdev will work with devmem by returning the data
> >>> direct DMA device instead of the DMA device of the NIC. Each PF netde=
v
> >>> registers its own data direct device and support for RX and TX datapa=
th
> >>> is added. The feature is selected through a new data direct priv flag=
.
> >>>
> >>> The feature is enabled though a ethtool private flag. When this flag
> >>> is enabled, the driver will return the data direct device in the
> >>> ndo_queue_get_dma_dev op.
> >>>
> >>> During data_direct device unbind, a re-creation of the channels is
> >>> triggered.
> >>>
> >>> A note about the unbind: it does not does not tear down dmabuf bindin=
gs
> >>> attached to the data direct device; the recreated channels will still
> >>> pick up the binding via rxq->mp_params and post DMA addresses from th=
e
> >>> data direct IOMMU domain to the PF, causing IOMMU faults. A devmem
> >>> revoke hook is needed to close those bindings before the switch. This=
 is
> >>> out of scope for this series.
> >>>
> >>
> >> Elaborate on this please. Are you referring to the fact that on
> >> page_pool_scrub we unmap the netmems dma-mapped by the page-pool, but
> >> we don't unmap the netmems dma-mapped by the memory provider?
> >>
> >> What's the impact of leaving this unfixed? Is the machine going to
> >> crash if the device goes away but we don't unmap the dmabuf?
> >
> IOMMU faults because the dma device is invalid. Either because the
> DD dev is still in use and was unbound. Or because the non-DD
> one is used and is invalid (due to channel reopen).
>
> > Oh, you're referring to an even different bug than the one I had in
> > mind. (I'll see if I can submit a fix for the bug I had in mind).
> >
> > But in general I think not addressing the issue you're referring to is
> > way too messy. I think we do indeed need to unbind the dma-buf if the
> > dma-dev is going away. The invariant should be that the
> > binding->attachment->dev should not change at all during the entire
> > lifetime of the binding. We already 'revoke' the dma-buf binding if
> > the netdev is going away, sorta (there is a bug there I need to fix.
> > The uninstall function in the provider doesn't actually unmap the
> > dma-buf :sad face:).
> >
> > I've worked with my LLM to suggest some changes that (we think) make
> > this work, but you may disagree. I'll post the suggestions. But please
> > I think this should be handled one way or another.
> >
> My idea was to handle the unbind part in a subsequent series because
> it probably needs some more back and forth to get this cleanup path
> right.
>
> If not acceptable I'll work on adding it to this series.
>

Since these are mostly driver-local changes I don't want to be so
forceful to block it by saying it's unacceptable, but if at all
possible lets try not to exacerbate the current mess. It looks like we
already a bunch of lifetime bugs with regards to the device going
away. I've posted this series, which - I think - gives you the devmem
'revoke' mechanism that you want:

https://lore.kernel.org/netdev/20261010025532.839559-1-almasrymina@google.c=
om/

Also working on that, I realized we don't use binding->vdev and
binding->dev correctly on binding rx. binding->vdev is meant to be the
device we do the bind to, and binding->dev is meant to be the
underlying dma_device (if they're different). That fits into your
model where you have the netdev you want to bind to, but have an
underlying device that you want to dma-map to.

I've gotten some feedback on my series and I'm working on v2. If it
makes sense for you to wait on my devmem core changes so you can
integrate into them better and avoid these lifetime bugs, lets do
that.

--=20
Thanks,
Mina
