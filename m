Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794232126;
	b=kquFp1nPuKd+jSWv1X1h50TC6Cn1OJ1qKY0hi1tWEosXUHRDqXCiXlSApcnLiouug8RO
	 g41fZxNEaIo8r8bpswnwOOPc+3KLmqzz1p5b05jwHOPwe6DsF/q7TcYlblr3+NLX9aTux
	 1P000NhPBU04StS6EqojL0vB5sY41twtdwivzL2Vyn1EQ4StuefskIIwFr+jNBlBFNwC7
	 RCiRTyzEBnaFh4tBDXWczbVLRoPIsp1R5msv7MLd9Hv8T6gLN1gxfQlgj2QNEXDEb5SpX
	 CudU2cAn9eb2EdxUGLYyZUw2VFQYZ7QoJi1/68IJSe/grnO8hGGA4B5fcW0NcfQXOjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794232126;
	h=Received:DKIM-Signature:Subject:From:To:Cc:Date:Message-ID:
	 In-Reply-To:References:X-sashiko-severity:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	bh=Y2/1OzJ1M6XNzCIIpXMSbzY6xvvbz9HaNJEuYUnzV7s=;
	b=EbHQNVxdUuuN9BDLanelazsXrgPaKIAl1tEwYKcFoNHz3h8UlAKWMN0LFRf+U9BL9ScO
	 BcErjJGBQrXRnPUESLmizDaIHjwoH2j5+kgAMCBqOzwRHTEB/5sGUa/M8nbal+3oOxTin
	 Nd5VOcYm+PU+AgXehWMWY4TwXlnkWOVVg/wlbpkF4Xrrm6rET8merGMmC48P3CyA/gnjH
	 1T9araImt9E4IW10p0BObMZSESw5FTC8zxDgLJQqJS3jqS3uvZ7i6mJnJCvYsj/3S9ZH0
	 THw21g45D1u7Pc9JJQmKDxOspWZl4wgMNo9qi+c2FOezs2d+H8faVzEszx0QXfTmesQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B64GPlDA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B57AC606A334;
	Mon,  9 Nov 2026 13:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=B64GPlDA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC29A1F008A1;
	Mon,  9 Nov 2026 13:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794232125;
	bh=Y2/1OzJ1M6XNzCIIpXMSbzY6xvvbz9HaNJEuYUnzV7s=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=B64GPlDACV6LSNHTN2w8BkRRqH3wYjHfU9sD4mxUWD9lxu7lD2sF1HIOM637Dq87g
	 rOSnZ1v/Rq3q3ZdfHyI8rc1l/M+mDhM0DHiPlOI7aS+V5KlZXAjpBOljurYQedv6Dw
	 NIYbeDvKuMFex29rTthdm7CwStHfAdesU7OhQK/p2JcAf6QRmHZhLziYRezM7eH/Yv
	 KUnz3ko7L8+m7ssx0Ce1EzZ1nWoqpEyO88TXaBEhF/LNUDk9zWN8VOl/7kwW40O9YR
	 GVJfn7HvwuVf2rzUaRPs/l04vej59oP8VFHGfaGh0ZvSR6OqjdO7O23fA0WlBUfbu5
	 PDbdx8G6gN/XQ==
Subject: Re: [PATCH net-next 2/2] net sysfs: simplify creating empty wireless
 directory
From: netdev-bot+sashiko@kernel.org
To: hkallweit1@gmail.com
Cc: davem@davemloft.net, andrew+netdev@lunn.ch, edumazet@google.com,
 kuba@kernel.org, horms@kernel.org, gregkh@linuxfoundation.org,
 rafael@kernel.org, dakr@kernel.org, johan@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, driver-core@lists.linux.dev
Date: Mon, 09 Nov 2026 13:48:44 +0000
Message-ID: <179423212421.994134.15099883810255197611@kernel.org>
In-Reply-To: <675f4353-125e-4168-a617-c0d1fb519045@gmail.com>
References: <675f4353-125e-4168-a617-c0d1fb519045@gmail.com>
X-sashiko-severity: Low
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Thank you for your contribution! Sashiko AI review found more severe
issue(s) in other patches of this series. This mail is only an FYI, in case
you want to address the nit picks below when you respin.

Low priority / nit picks for your consideration:

- [Low] The kernel-doc for struct attribute_group in
  include/linux/sysfs.h (line 103) still says "@bin_attrs: ... Either…

--

net sysfs: simplify creating empty wireless directory

The patch removes the dummy wireless_attrs[] list from wireless_group in
net/core/net-sysfs.c. It relies on the earlier sysfs change that lets a
named attribute group with NULL attrs create an empty directory.

> diff --git a/net/core/net-sysfs.c b/net/core/net-sysfs.c
> index 5c0402389c6d1..f58b59e112620 100644
> --- a/net/core/net-sysfs.c
> +++ b/net/core/net-sysfs.c
> @@ -910,13 +910,8 @@ static const struct attribute_group netstat_group = {
>  	.attrs  = netstat_attrs,
>  };
>  
> -static struct attribute *wireless_attrs[] = {
> -	NULL
> -};
> -
>  static const struct attribute_group wireless_group = {
>  	.name = "wireless",
> -	.attrs = wireless_attrs,
>  };

[Severity: Low]
This isn't a bug, but should the kernel-doc for struct attribute_group be
updated along with this change?

After this patch, wireless_group has both .attrs and .bin_attrs set to NULL.
The comment above struct attribute_group in include/linux/sysfs.h still
says:

 * @attrs:	Pointer to NULL terminated list of attributes.
 * @bin_attrs:	Pointer to NULL terminated list of binary attributes.
 *		Either attrs or bin_attrs or both must be provided.

The new behaviour is only described by an inline comment in
internal_create_group() in fs/sysfs/group.c:

	/* If name is set w/o attributes, create an empty directory */
	if (!grp->name && !grp->attrs && !grp->bin_attrs) {

The paths wireless_group actually goes through (create_files(),
remove_files(), sysfs_group_attrs_change_owner()) all check for NULL attrs
and bin_attrs, so nothing goes wrong at runtime here. Other helpers do not
tolerate NULL attrs, though. For example, sysfs_merge_group() dereferences
grp->attrs without a NULL check:

	for ((i = 0, attr = grp->attrs); *attr && !error; (++i, ++attr))

The same applies to sysfs_unmerge_group().

Could the @attrs/@bin_attrs kernel-doc be changed to say that a named group
may leave both NULL to get an empty directory? Could it also say which
helpers still require attrs to be set? Neither this patch nor the earlier
"sysfs: facilitate creating an empty directory" patch updates the
documentation, and this patch is the first in-tree user of the new
behaviour.

-- 
Sashiko AI review · https://netdev-ai.bots.linux.dev/sashiko/#/patchset/0a0a7987-abb2-49c8-bc16-3938233ae9c5%40gmail.com
