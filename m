Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB19D288B8
	for <netdev@vger.kernel.org>; Wed, 15 Apr 2026 03:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776223352; cv=pass; b=pW5ujOerYUqS8Uvn+0LVt43SUHP7otUU9dOZOV63rR/MFGhZzaIXD0zZUWpkwBvlIlJksaAispbPwwRXGrtIUL745vCwKbmAuKL247t7h6LVFl1k4uiuZ1FSfpD7bCHstXSemfuoAQx9swvZfZlwvJRojyV+Xty3ugMrYpQsRmY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776223352; c=relaxed/simple;
	bh=c4onuS1GRSAjfT7aJOqFbi5T6EuvpcHtSN6WR6LagfY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=W+M1JehQxjEq0Cn5hd0/wQJdWuKFbVyeiyovbAcTlbFJgN4rp/N2KOCk4v8/UXpmmGUfEG2tdszgrx8IoTn9DPpMEXFQwWPQfBDh+DWcM5y8p1yZ+5B0Kr0QILLiN0sAUMd9bTv2aavsLaOjVQ60YIq1xhiCvIZMIyh4RFtElDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oY84GHcq; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oY84GHcq"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5675d609621so4859594e0c.2
        for <netdev@vger.kernel.org>; Tue, 14 Apr 2026 20:22:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776223350; cv=none;
        d=google.com; s=arc-20240605;
        b=KRA7ySubSLvYO8pk3NO83HfJUvsXw5X3ntZWOOe9ezWhFe2zkLVZjumKzx0L2l7vu4
         /gO5HqeiDVAfq2SyFFROGCx5CUZEwKaH/hIA40CVDKShzJ27KpR0bJL43n6Qk8iVQe0B
         1c2jpTArJbxPWawYQ65jcRqanEoYDh68GGTsAwzKHqRu76YNmRg41e8thxl/3dEfRs2+
         xCNgo9Lvdbj2eSk3+MQZF7kTQDnKLABx5xv08TbxMqWSMauVAaVHLC1TGogqgXZvqibv
         FeSm/eylOXB5NZF5jYQ6NZ52hJBZa00biWEYr9qIpPeQmtVt+ta1TBfqczxWPthYnfeK
         rYow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=c4onuS1GRSAjfT7aJOqFbi5T6EuvpcHtSN6WR6LagfY=;
        fh=hP4TRSFeG2+nLEURD/+NDx9PjPmD+dKACS1VZ8zr3to=;
        b=U7QHBtdjAoQhcUF4NrCbak78pRA25FQDUEiAfO+r4GKlhZFD5E6KWOK1ERQYv65H2H
         xbWQKOvvDPlK5d7hEk2HvGj+cS/UEJu+i8uvEM4e8C9MDtXMLX+wz8bnWRVRw6xIxpP/
         cIbpGHXummehzVuxqE+CDVXSuOSBGZRh4RprMLe68PEczAisXuKfW/fvy5Lgvjzhigrb
         mv7HIdtXsC6fJP3O47NcnS89NU5mCEyJH1552bGe9sO1LHKgjyeJblOzJEnZFsORX9DQ
         7n7UT7ZmLtG+LUR0pLfJHLHdqWxlD6us3/JvvXeEbBr20CE/0ksXtwXu3p4VOcrkTZz5
         hBgQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776223350; x=1776828150; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c4onuS1GRSAjfT7aJOqFbi5T6EuvpcHtSN6WR6LagfY=;
        b=oY84GHcqS1YVypPnD94vDCvpmOqfruTYFyV0hdR9FZEoeOrwF565yj/R3Fl7GAvwHh
         xEWzNvUrINT+ICZaGpAalw7QkMX7uOwR5mEgGcnJ1rQzL0A3HGMLOoaTVFtMVEdTsqRS
         4oWN23OCeW6n4AATW3ld7v7OADJVe4UWJGC1l3duW0cqyS5ldqCWcZU/jUbL9e7Nm2V+
         hJ7Pz+Z9hR3lFj+13q4N06VstborTPHDowbVQOMQZKUVuUESRWvS/g2e+9QL/jTh9cmv
         PzE5oN1zZqrdkd4ty6/O39nYB6vNtEzlEZzr7/zM6XtVHNfaP6JO16Ys7KD9c1EwcxEI
         7Eog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776223350; x=1776828150;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c4onuS1GRSAjfT7aJOqFbi5T6EuvpcHtSN6WR6LagfY=;
        b=MhnXD38DVU6GN8t2u7AVNqpiLNMq6tKjy6xsEZ/2UUoCS+xf2B8m9aOmYG4dCcJj65
         hWrY9F+Ukm+gDXrEf4rhiOvtU+8FwlDNftPNTU9T/obVroyYvwQL8Hh4mKj23I4tbSuR
         iZtCQnYNh0Qm2gGrwFdEnkhgiyEMdr8TYbO8vTDQXZ95i5l125Y1e9hwLiIgTUW8SvcX
         v1UtNcMNqMiF0PONIuDaBYT4cVt8EF+lVYHmL4ciM8+pMJopYU5qjub0T2jSGw9Zh5yf
         k5qJ/J0+qi99KM9IUjJn4sXVkhKJquGDMdzLuZsoeMeHiZFEA8vU4M0PxOVYsaELdCAl
         zgwA==
X-Forwarded-Encrypted: i=1; AFNElJ+8hwTavD7E/ovn1MxOjLkqzoqM7i2r45j5o2utllsIRFL6j5vr7zwfecbi3bA5UK+/7zenW90=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5Eb9A8VlYauNy+b7QxOAEI1pCInvNET7Bgh8YSc6zp/uiHE0O
	dTaziR6hocSXxEgmIrnHElcf2h1v/ZM04Vz7VkTOZff5rU5sMoiLU8XKQpTIXHIxwWx4YP5V4Cm
	FknXCQIcrCmFH5J2+SU4lBy+Vpou3ctU=
X-Gm-Gg: AeBDietxP+oFSQv21+Ka+LbLcOWFKosuRputp8eskL1RyKJgsXnEqVICo1tc82TGetj
	0bj2FaQ78pd0KdnoOzGGGO/QfotEG7x1yLlXAlIrSlj8QvbMaUfNKvMoFnhtFkECPl9pvip8VBn
	sSR5b6lwi1jrrF2aL+J74hiWEDGHvxtbdHSZP102tAMrNE5dpOwc3dxKCeoHiBOBLs5D1cwcVYA
	OvV0PhWogGTAYm2w2r/lyI+okEllqkKNKKbGAU5PVUpJTsCVmK0lchFv34vAekJUgm2kqQwy3Vi
	Rjl1Og+Kth8wc601Xd+usSnf+HQlNzNS1v3lPO3RuCVeppM4+rA=
X-Received: by 2002:a05:6122:e24f:b0:56b:815c:961d with SMTP id
 71dfb90a1353d-56f3bb904c1mr10409428e0c.5.1776223349721; Tue, 14 Apr 2026
 20:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260411115958.64827-1-shuvampandey1@gmail.com> <f9c028ef-9021-4405-940d-4630732cd122@redhat.com>
In-Reply-To: <f9c028ef-9021-4405-940d-4630732cd122@redhat.com>
From: Shuvam Pandey <shuvampandey1@gmail.com>
Date: Wed, 15 Apr 2026 09:07:18 +0545
X-Gm-Features: AQROBzB6ElzhyE09bnLe-Wo93T_M_FoFjdTgNEszNGZdZlLQlDJqmEWbUxuk_k4
Message-ID: <CANAAWH+zBpk4JRNpc_HYbsgpVZk=SxwpyuYSjRaGYm6J41R7ug@mail.gmail.com>
Subject: Re: [PATCH net v2] atm: mpoa: keep mpc->dev referenced across mpoad restart
To: Paolo Abeni <pabeni@redhat.com>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, 
	syzbot+5ec223ccb83b24ef982f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"

Hi Paolo,

> Since this patch removes the dev_put(mpc->dev) here to defer the
> netdevice reference release to the NETDEV_UNREGISTER event, does this
> introduce a leak of the netdevice reference on module unload?
> ...
> Should a dev_put() be added in the module exit function atm_mpoa_cleanup()?

For the netdevice reference itself, I don't think a cleanup-side
dev_put() is needed here.

unregister_netdevice_notifier() synthesizes NETDEV_UNREGISTER to the
removed notifier, and mpoa_event_listener() already drops mpc->dev in
that path. So removing the dev_put() from mpoad_close() should not leak
the netdevice reference on module unload.

I'll fold that into v3 together with the full decoded backtrace, the
syzbot console link, and a clearer lifetime explanation.

Shuvam
