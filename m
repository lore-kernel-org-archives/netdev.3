Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB843346A8
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 05:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786943253; cv=none; b=K3nGF9xwbUj/hgInvkR/WHE9PeaBIWilMdO6RqEsgL5x1YW8eTrW6fIUCpvvumf7wIbyiX8jnIB22lk7rcP8j9lTNt+Wc+ZB6zj0jTb5kAU7FMsRZ0Ai/ZhjfbuSq1fvk8F8wgU59D5DupO5RQokrsAuFEE6KIevpcVvyS9m3a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786943253; c=relaxed/simple;
	bh=aZ/gxhxC7X9QL0sg/xeB3UipbqHzc4psBa48/iec1kc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZAlIfoZHrn8XKerMgjHGTIKwYwy37U103cWwdocrB2PvTOJCaQATxHgrvbTcozrX3pSh/pmIa+AL3G112VslTGzixNnQuSkdlXCj1TboybEagDiaRet3TJYvqjzVkDlUF3wk6kRpzZgE5t9nEziGfoQym/a8KMwXYCzCGhDdlys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hj3/b+dm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hj3/b+dm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EEF71F000E9
	for <netdev@vger.kernel.org>; Mon, 17 Aug 2026 05:07:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786943252;
	bh=c3qRbYENTbrNx1zwHF3ytg1UJB2xVulUjUF45wJgXEg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hj3/b+dmRIf7suT0+eLQbyUduaA5Nf0l81T3tGQCP/2qUOVR1gA9DZhkKIFonTVGZ
	 MBwanFbP1GYcWLxj8ywbUZEmK2HQigSEm6M7LFlgRv4qtq2E8NQN3RuppcdQ+v/57M
	 4LJf1yHJbsvS8/9n5IYYWHUeKs0XPYEC+QXrJf5g94d28EB4dPX8zJ4JDYJpaSeiyr
	 RDiwGaROuBgXhiIEeUYNDXCkN9aVeC5NjQHtJSIc7RLH8Oo8kXsNxYuglCBac4lFEU
	 UZqFt+nB7KrWwnuQnnwQ7xFAFLMw681F6xQO+xd8VbTSiFMIaoWpCK9xm8rdBGMocO
	 1ershXL8oWOug==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a15d54ac95so4216056a12.0
        for <netdev@vger.kernel.org>; Sun, 16 Aug 2026 22:07:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpJBrQGu5B1IG5Tg0JH/I21Wrm2LYg3z/2IgJmpskzGIHsAny8Y+990IeZvqXHYH8u9ICC14ns=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQslNJHP/axG0aaDc60cfqk2SJHRMPf5knssTGJ8Em2INc7HwE
	z7KcCSY8Qc/ikMBjy6uUXsJyU6FwdemjVOWGFwMmcVmjIr0IZK09uC1rMMffpW41ouxSyI3utYl
	FCzw/eZTRQjpmpwF/BDlXyN6kZzA1+Pg=
X-Received: by 2002:a05:6402:4613:b0:6a3:691a:9d82 with SMTP id
 4fb4d7f45d1cf-6a38a8dc189mr7610607a12.3.1786943251016; Sun, 16 Aug 2026
 22:07:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260816-submit-phy-package-fwdevlink-v1-v2-0-23e55dd59fad@gmail.com>
 <20260816-submit-phy-package-fwdevlink-v1-v2-1-23e55dd59fad@gmail.com>
In-Reply-To: <20260816-submit-phy-package-fwdevlink-v1-v2-1-23e55dd59fad@gmail.com>
From: Saravana Kannan <saravanak@kernel.org>
Date: Sun, 16 Aug 2026 22:07:19 -0700
X-Gmail-Original-Message-ID: <CACRMN=eU_C=sSXxoR_WY-LMPwD6H-bi366TXsbbDt0tPBmPA=A@mail.gmail.com>
X-Gm-Features: AcwNN1UCpzh4GwzuiKfa7KvTtq6D-0aVkeYlIT1yvk2UtQEaQ7eB0voMilubx0Q
Message-ID: <CACRMN=eU_C=sSXxoR_WY-LMPwD6H-bi366TXsbbDt0tPBmPA=A@mail.gmail.com>
Subject: Re: [PATCH net-next v2 1/4] of: property: skip links without a
 consumer node
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
> Supplier bindings can map a property node to the device node which
> consumes the referenced resource. The remote-endpoint binding uses
> of_graph_get_port_parent(), which can return NULL for a malformed graph
> node without its expected parents.
>
> of_link_property() currently passes that NULL node through to
> fwnode_link_add(), which dereferences the consumer while adding the
> link.
>
> Only create the link when the binding resolved a consumer node. A
> malformed graph property then creates no dependency instead of crashing
> while fw_devlink parses the tree.

Is this a real issue? If it's upstream, should  we fix the DT? If it's
off-tree/down stream, should we care?

If it was reported, can you please add a reported by and link to the report=
?

>
> Fixes: f7514a663016 ("of: property: fw_devlink: Add support for remote-en=
dpoint")
> Signed-off-by: James Hilliard <james.hilliard1@gmail.com>
> ---
>  drivers/of/property.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index 72cf12907de0..38c0c7dc428a 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -1620,7 +1620,9 @@ static int of_link_property(struct device_node *con=
_np, const char *prop_name)
>
>                         matched =3D true;
>                         i++;
> -                       of_link_to_phandle(con_dev_np, phandle, s->fwlink=
_flags);
> +                       if (con_dev_np)
> +                               of_link_to_phandle(con_dev_np, phandle,
> +                                                  s->fwlink_flags);

This shouldn't be a normal case. Can you please add a WARN_ON() for this ca=
se?

Assuming we choose to fix this, I'd recommend sending this out as a
separate patch so it's not slowed down by the more complicated patch
series.

-Saravana

>                         of_node_put(phandle);
>                 }
>                 s++;

>
> --
> 2.53.0
>
