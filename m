Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A01A3BFE3C
	for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 16:08:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.181
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786723707; cv=pass; b=Ukmm7Ntdetn2g6nEYmCTx6RhFAC4p0O+dWNc4Q29AXQfKaKicumA5rwnQKVpXXJ/sHqPC4qD5Ng36iyb9Ru7K6OR6AswERk2wv9BarlE5mCjMvOt+CVq7i1/2hb1bUonBSwT8/mHNt+iXqPSVF+s3xOS7Uqd9Z8XgNQk2Am9HL8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786723707; c=relaxed/simple;
	bh=jSdd9p2V3k30mbNVX/TWrC1/BDiG02JSQF1h1wOMsXk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kXWxELW4mkNWcC+I2oCp9lYW1y3vQD19ITt36fv/agGPPV06UyXdPiu217BNvE81jdG+397SxBNNAXWmcMrirPdg83Bo+Dqoeq6NmuhqiyT8TxlJuOkzzT+ko4lMZhvCIwSpfZ+hsz7Rqezl5XbSyLaPBwJr3GmjDREbkGVpg+E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e19qioLJ; arc=pass smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e19qioLJ"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2cede6375caso126465ad.0
        for <netdev@vger.kernel.org>; Fri, 14 Aug 2026 09:08:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786723692; cv=none;
        d=google.com; s=arc-20260327;
        b=FR1l81Mui0H3VfTC4t8widQQe47Y/fTMZiduf7w7yJ+rNbMzeelQbXMlx8b0u1wdoW
         sNbMi1HYGzp+nKJhIUCjvGamJAxI+wzMF9BFN6LICTOm6mW4OWxvcluidtYSVCh2aYSL
         x+lO0suswvOkDxv97JY37wCZpgloUjsC4nvuIaS4AE+k70E117uMxRFrEenZ+vcr672i
         zPf+O+6Ci5jL1bml/VyBpA66k1p6cuX3s8c65KBI7XSyoGO5juwBXThdXEyDJaAfcIBN
         gBLYwISxyNacohGFA1lJB7ciBPLSwrl2l62/zOT5BPRne6eeoMYnrUyudjZi7UtnSTuz
         uCbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jSdd9p2V3k30mbNVX/TWrC1/BDiG02JSQF1h1wOMsXk=;
        fh=bepHynd6dELgt9s+VtU+NEGntPD7c0zqFdJ3u5DAStM=;
        b=K7G69Qqtp02BUjfSg0UWlWnEeyOZS2k8D44+GBp2Vaat4GYp1DCWGvLE9KzbEfBZEZ
         Wkf5sG/xo5cCo3HEP77jZRYBO4IVSHssO+/4FUMwsBh9P+H8RcYrSGpEGNwgTrlQNOAs
         Ks5/ORLVAC9IvgyT21iItnD6FXtlakMc9ndA9uE/ULVmabBgSkhWjO4plvRih0sHV9kD
         11TpJT608SlHvGBXoTv8POs2AwpmleoFDzqwTxW09E8oyil9GapZ9p8XjKZfE1D42V0x
         ejxGmuoTbJYcBJgEy+eDjXzbiqq0qkYvq/ApH3pblL68kd7WgOjx2RhDaXfJMUZiP1dW
         UiuA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786723692; x=1787328492; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jSdd9p2V3k30mbNVX/TWrC1/BDiG02JSQF1h1wOMsXk=;
        b=e19qioLJZzkGCqWbzQIOYzYcMfT9Zlnyo7LdFLq3SkpzgYzdmGsStlQws2n/xsguk9
         UDLioN7xDFHXmdOPis7Mm68GSO9KnOMh67tRmiNVoCcSSx3dUkpwDJP1JWrBCZ1K34u4
         EZkPdMojzYK3QkEjGDi0jZ8BjulfWKV8pskTdYYq2ft1F3ExlGR9XipYGKQmuFyUvJzK
         3Rir/Koy33AmzjDVcfizXPr0V6PDc7Fdt1w+23/5w+hme9tuzi+OtaXW+uuAbfQqQmi4
         C//Kk7s83VStKJjDurqNnpC8OfJqN4iUJbXYfikcmq4wQmjDWl81d2p7DMe3MdRm3TPG
         rT7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786723692; x=1787328492;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jSdd9p2V3k30mbNVX/TWrC1/BDiG02JSQF1h1wOMsXk=;
        b=AuhojBWQ2adWIBD6G9aqEnUcEtZ8tZ3pXiPkYNrsqR07L1a/6BxSxdZlZ1AhTpSMVy
         13TVmOYnqqGBroPmR9xjHOZE3LZH5hvh4C4/5hCrNmSkj6atAAm1vg+SklvW8IESl733
         zguprleFDkVJ14UmIF7/9G9rvm/W4xn4XleFUSlcbZcpEedoQl7LKx5/ZV9eGl3d1GpL
         EGZBe5p/nAKQX3kYd3G0MABhJnUWiIVOTOqGdFe35X0DtHIXK91nJJWTDEZXZHvBsLRF
         Sf7HzgyU1Pb+y/9FOBj6cx1yUWjmV/lGFb6mI6jNGGeSdEV/txR+2YbtOGLhvabu7RVm
         xQ9w==
X-Forwarded-Encrypted: i=1; AHgh+Rrcqg7jTzZ2aJw+ws6sA90xK89YWSNx3ApiUhFqrBAEqNHBTa7K+EuR3nloUKwF6NugCRdx7Sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwR/vEqCsOcc6lPC4Azsl7AUJlYuNBFWySwHmCQbU2800+VVtmt
	SrZSfq+rcic+8g9d0fgF3U9ECNR/hM5u6L4FoIj1QJfVRigzP3wP9ya+Wh9glx0WisiEdsNaZqb
	iqVjdektI9C4DKLnDZ0/ebY+V8st2YDgBkHTv+YE/
X-Gm-Gg: AR+sD13plcT9PZzpBwRA3NKxKTDcDADKceX6OYGZT9eFljKED61EHq7teZW/sKvQntv
	msqMPz/XcMEwTJfWh+Vdb/VceswpgvsPPHK05fMktJCSnALvZxvc4XZU8rbAwRaSKU//J5/LF6H
	DBGfwmnBQbAnVKj2VUQ3qqSOosvfPAkzOqJdG1uC0+ckdft+b9VE92WHqsqtGi4lEQpJC1Pg1eW
	vIUDyMXAzrfjF7xFBCa8S2BEIZ9/nzEkr2t5IjUWAp0IcpJZOby8Xjo3jRIzZ1NJpnmCHRT6TAj
	4mygxZwhm6fvYS5Mn/K3aYs8LsCm1SK4HegohT8HaKEU9uFEkICbinJrHILZCoPJ2sEaDhFNrEA
	=
X-Received: by 2002:a17:902:e54c:b0:2bd:3bfd:74f1 with SMTP id
 d9443c01a7336-2d3aef4c328mr9091665ad.2.1786723691080; Fri, 14 Aug 2026
 09:08:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260811142958.160088-1-shivajikant@google.com>
 <20260812172824.724ec190@kernel.org> <CAMEhMpmq7ZrW+4Q19gsF9k3v6S90k61oEXB6t4Oc4d9EU_QAbw@mail.gmail.com>
 <20260814065054.55333a89@kernel.org>
In-Reply-To: <20260814065054.55333a89@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 14 Aug 2026 09:07:58 -0700
X-Gm-Features: AcwNN1XmYQtLYEPfdFDj93v3iXF6ptcsl-9oVEUHFiyvmnmPUGim2Kmsw7vpEsg
Message-ID: <CAHS8izOyEXCPPBfM_-Xtz5W2ULG8gyT9batC5aP7hvXNpw3seQ@mail.gmail.com>
Subject: Re: [PATCH net-next v2] net: convert netdev_nl_sock bindings list to xarray
To: Jakub Kicinski <kuba@kernel.org>
Cc: Shivaji Kant <shivajikant@google.com>, netdev@vger.kernel.org, praan@google.com, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Stanislav Fomichev <sdf@fomichev.me>, 
	Dragos Tatulea <dtatulea@nvidia.com>, Kees Cook <kees@kernel.org>, 
	David Carlier <devnexen@gmail.com>, Yue Haibing <yuehaibing@huawei.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Nikolay Aleksandrov <razor@blackwall.org>, David Wei <dw@davidwei.uk>, 
	Maoyi Xie <maoyixie.tju@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 6:50=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 14 Aug 2026 12:04:59 +0530 Shivaji Kant wrote:
> > I understand, my thinking for this was removing priv->lock is more
> > than just simplification, it can be a concurrency win. Sorry for not
> > making it more explicit in the patch description.
> > As you pointed out, priv->lock current serializes the entire doit
> > block (including netdev_get_by_index_lock() and the entire
> > net_devmem_bind_dmabuf_to_queue() loop). Furthermore,
> > net_devmem_unbind_dmabuf() blocks on synchronize_net(). With the
> > current mutex implementation, if one thread is destroying a socket or
> > unbinding a dmabuf, it holds priv->lock across synchronize_net(),
> > completely blocking any concurrent netlink commands on the same socket
> > (e.g., binding to a different queue/interface).
> > Converting to an xarray allows us to cleanly dissolve this wide
> > serialization scope. xa_for_each() handles the RCU grace periods
> > internally without holding a manual lock across synchronize_net(). I
> > agree the changelog must be updated to clearly state that reducing
> > this serialization scope is the explicit goal.
>
> If it's an optimization you have to show prod data (as in not a micro
> benchmark) that the problem actually exists.
>

Sorry for the late reply. My reasoning for this change is code
simplification, not optimization.

The history of priv->lock is that it was added to protect concurrent
access to priv->bindings and only locked around list access to
priv->bindings. But then Stan and Taehee ran into deadlocks in
relation with locking order with the netdev_lock and the binding->lock
so we ended up defining intricate (undocumented) locking order between
the 3 locks and expanding the code serialized by priv->lock and the
code now feels confusing. Removing 1 of these 3 locks to simplify the
mental model seemed like a clear win for me. We do not need priv->lock
if we use a data structure that manages its own concurrency like
xarray.

But this is not a huge issue worth burning your review cycles on. If
you don't want us to resolve the clashiko issues and follow up on
this, we will drop it indeed :-). Sorry about that!

--=20
Thanks,
Mina
