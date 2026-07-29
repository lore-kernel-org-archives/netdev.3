Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCB04ADD93
	for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 14:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.178
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785334160; cv=pass; b=UcUkZ+vFEDsPA3AsFnw/xuvpw7g0VSNCiOcDBQu8r4ptB7Rb7DAcF1jXelY8CcID7N7QBaZ6HaVsOJQpBjTwZKjiE7zjdNFCgfS3Ba1zBndAjeiBMuWQhlABDYzZfrp6+BtCYMg94Am/QkwYGzyNkBuysSGktt7ZFfIS23rRVlU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785334160; c=relaxed/simple;
	bh=MNYoGZus+xhWAqSQfFrGzVLud6+ETt1Gl8AwDyHWw3Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S+Fe6t+rQzk90kO5o38RlsfSXTp1n41EFN4/EDBRzdlprO9HD45VCctUSMAvoF7sEyTPYyyJL4dMEdkvNLlKehxToHAMib+VbXbboMyJH+sjU9zgyFyS0SZq3SEKc59t8961ygQ8RiThAsW52fqc46kJOUjjT6lIIa9ItA+7ADc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a+BVeJH0; arc=pass smtp.client-ip=209.85.167.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a+BVeJH0"
Received: by mail-oi1-f178.google.com with SMTP id 5614622812f47-486db28a56fso31912b6e.1
        for <netdev@vger.kernel.org>; Wed, 29 Jul 2026 07:09:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785334158; cv=none;
        d=google.com; s=arc-20260327;
        b=ZhX0p2LOjeZtbIaImG0hXH76Fp3hxM9qVAHmlSsqPFJaQfRXvGxtv97I+QXb68ABv9
         BuAYzHtfb7IIzbwexwuue2DAkleGpdNPIWfYITwpIGHJkKy5mVKDDahumzkzWHcA/0gD
         czVUfeQ7mVoY1YKu72u7rnJYY1FhSiyxarPSKbgMnQ3V3ZIgsNscqJegF7vy3yys33vO
         2VFMx/PNTei4hjZyx9Spw+iYq1Ij1F1FsJiUPq9Q/fqDSfwzIWPCIzqIp5YU5vpGHCtr
         a2uXTpJqXDYiX03+SPzRXxvUDstApxOMtVIlEfpW8rHs8ogkFgA0jq336Xd7eN8aWv3X
         Ql7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MNYoGZus+xhWAqSQfFrGzVLud6+ETt1Gl8AwDyHWw3Y=;
        fh=chMXMEZ1vrKFbqlYqYDHvf+NvS3sTVwqi0GbhIScnLs=;
        b=JKiF25oFJW+C50LHYt8hKHGfV0RvkNF+R1IlCEsxeKqQXoYARmCyG19xbd1gQ488BF
         5SXGFPU+08daK7iSjK61V6/FHzvVOQm6cpFJqUiTL696nDsBV+MM/T/njoA2sf+xrTnn
         1zjX3hLJ5ROOaAfTAeoOBHopa/Mia4Eb+Wg/fD6DUHnZRuHofsFxdBhZBgLZIIN4/BSO
         uakWl99q/4x7Ed534YhnIMxj2ZOh9ToQMkvfDt9YpRDao5GzIuOA7enLJWvXI8cXhOoi
         kHamNp8n6RLyu2lue7jy+X8VWrevwa6z3O6YGonQS0DnXRe2i5WKUPledYAb9uPZ2JEH
         sndw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785334158; x=1785938958; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MNYoGZus+xhWAqSQfFrGzVLud6+ETt1Gl8AwDyHWw3Y=;
        b=a+BVeJH0swPnXPjmlh1xkm+p77vkP4+S8S76QWh1ErNvZMcc07UqtUQ3egE4vFVkCL
         h8CE+VxhFpK/vEhejst1khby3oZPOwWJI1ZTOpxM3LWvvJ0Hyv2+aTICkKC8V27U62Tv
         ZUCNPlgRAMRqLXsxWj30/auWB0/+jkshLWXw+obMRICsI1DyWDpjMZKQNh33VhmbJT9k
         VOWe8SMS8/Z35uq71T8WIhTNfUbiKH4xhTeLfvsvM4kO7Bp7jVtuvqbCARn4kJy5HIPm
         u9pxNQx/UDk1pfKayowSZ0V0lE1N4YJcplMBDiP9HcV25KdIcK3l6W0whuy1VkU9VJuk
         H4KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785334158; x=1785938958;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MNYoGZus+xhWAqSQfFrGzVLud6+ETt1Gl8AwDyHWw3Y=;
        b=U4Jmqn0N8effqSxky5HPYxjg2OkRreluJi4OyVjmXHCZOlXh875RUo0zJkswm1Y8mg
         wQx+lJIqvp5BeI/vGdFsn7ge+VlGTNZ+TLD7BkJGAdbmSWKW4jF61SWsHVbhfr9Kq1lG
         To0a7ZIlDftH3lRXEaZSGmLOsn5mVLOn57C3X2vqDegZJRFBGGe6c1szEF5tAZT8Y9Sn
         1S2nHTM2zX6a3b/ToSWqE+I/KLuHSkGmKW9SEWXSaGbHkICMmNvwZEWAx5hWbocXIlKi
         neeOjL4TlHVNHx+FQhh3wAQcLw9URWaUkWdZw7EUDXuILVsIL+/qBCqMeLYkqSlLlrtb
         K/MQ==
X-Forwarded-Encrypted: i=1; AHgh+RrTp8m6EgufYkLeMaZLgGsQO0QSmNJzNQDTvsC70hVmvwNMlftwQirGdC1ZLGC3zpeiMupJcsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzbmpqbcSJS+LkqYKdjOxZPknoHewfx5kUBjYscd0ygDGR/NOgP
	hd7YXFWEer0t6+BgOsucGwtFVcjFtfblRf6Q98r6A2dzavjdyNMh1QCgtLcOsaTOQeHQdXcp09J
	PjUAbln/xj4ot2hCfysEd6hmaXaUEPkQ=
X-Gm-Gg: AR+sD1260534fwrQ/gChJRvuFz3vG1qO0WB8Xrvk0AWvVZMUHWvGjFOMM+EUUHWP0F/
	6nKmRuN7C0q3U7vhmSGRaTHQgPkklX9AmuuYtJPtiuFCMaFtxVGyv9M6GY8ByTyUvLlza8AZ3EA
	oRDQgt0TfR+BFfqNO+28OoJq1iSi3/wQqob0l8puoEPWx2uHhDkVIbLZEYc9b6ywhRCOU8cgiFx
	PS8tDTeAB2VoQkgV5ZNtU8P8+8rrR9Bc46GvPCMQ7lLscUiLXz+rHBvclZWtxWD+du9O2lXzKvo
	gpP/uG9Q16RWZnvGVYBaTMJeUlkfAYGgQCmhIOhLJsqNvCEkwYFKI7WDzlPT
X-Received: by 2002:a05:6808:3010:b0:4a4:82b:2a35 with SMTP id
 5614622812f47-4ad5b78e2d1mr2703607b6e.1.1785334157515; Wed, 29 Jul 2026
 07:09:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724-netconsole_move_more_final-v1-0-a5f7691db81c@debian.org> <20260724-netconsole_move_more_final-v1-9-a5f7691db81c@debian.org>
In-Reply-To: <20260724-netconsole_move_more_final-v1-9-a5f7691db81c@debian.org>
From: Gustavo Luiz Duarte <gustavold@gmail.com>
Date: Wed, 29 Jul 2026 15:09:05 +0100
X-Gm-Features: AUfX_mzZ3PUhekmsXFQ0GhvstJao6iMRguXZQhDbh2v4p8cX4LL9_QkGlFWf1tg
Message-ID: <CAGSyskUSqiAPsUVWStQ9xL-2RGCJ7avU4UGdEB0rDukGqgpvsg@mail.gmail.com>
Subject: Re: [PATCH net-next 9/9] netconsole: move netpoll_wait_carrier() as netcons_wait_carrier()
To: Breno Leitao <leitao@debian.org>
Cc: "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, asantostc@gmail.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 4:05=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> netpoll_wait_carrier() waits for the egress device carrier during
> netconsole setup. Its only caller, netcons_netpoll_setup(), already
> lives in netconsole. Move the function into drivers/net/netconsole.c,
> drop EXPORT_SYMBOL_GPL() and remove the prototype from <linux/netpoll.h>.
>
> Rename it to netcons_wait_carrier() for the netcons_ prefix. It now reads
> the timeout through netpoll_get_carrier_timeout(), since carrier_timeout
> stays in netpoll to keep the netpoll.carrier_timeout parameter.
>
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Gustavo Luiz Duarte <gustavold@gmail.com>
