Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C71444719
	for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 15:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905568; cv=pass; b=locDAfnCK0006lQsXP6phM/KXjV4VZCuTjFUl2Wo9H1jjb4NiyZyXPLWlucTTSexixRu+zMwTFiA2DK51legjWVjPqy7m0+R03zk69+toHQCNbe7S31Xf3arZFnmmnll6IKJnP6egBNZRfPpqdA5sh5eVwTHqPJUJ5O8wS/YJ4s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905568; c=relaxed/simple;
	bh=I2AhTyeN3QRdL8SRsF8YtEzSAzEn5+ptNy7HN5yACgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VS46mvZdoa4nGm5fAV8Uxdg4Zl+2cKfkV5dFs7gs2ij0edFvIZwtColSf9W6DmWztHIJbFHJyo0q3XeWvj0TU219HSG+ya3nKM3Lf+3mBz/Mmnxq0j5vL1LyzBbczrVTIlAezPxxxtgMs8+tupQVowVFL0jAe5TMTOWbugUWrGQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QmcEQY5m; arc=pass smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QmcEQY5m"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cede6375caso73825ad.0
        for <netdev@vger.kernel.org>; Fri, 24 Jul 2026 08:06:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784905565; cv=none;
        d=google.com; s=arc-20260327;
        b=UfK6vCsH1mgmzv1nQAhoOH5/aQKcT06vyJxKVS4Rm7iZbmxgW243W5a5OKTv5WE5PE
         Cc2uJJmrUn2dH+6LMVdjHGeZCnJEeUFH8BgJ2gcH27QeY+6iT+nU0p/lweHWXE6sWOeP
         O90K8cJg2GVHJ24Dl7zxpwoORPhOZepfPjsTFaoceEDaxkL97/iY5NMb116x6tlbWeYq
         pyWAHVqaS8ooTL4vhlBKW0sccucefDwyEMh+67iCLuwxfTQca5yILxr6ZVBNJiCcm8Uh
         1Xi18vHcdpB5/b7P2eurqCrSVA3QiYCHodAT3jHhpBcrQ8WXL8Yge+I8o0C/Q4+ekbHk
         IvYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=I2AhTyeN3QRdL8SRsF8YtEzSAzEn5+ptNy7HN5yACgQ=;
        fh=0WtAV0v/cjY2FoyngvHd7nfvfMgyNYfDm5Dy87Ws3vg=;
        b=hGFSmqyfJ7bLsI3EKiQ0BchuQYCjSMAY6C9M3m4i/HyD3qfeG4CBLohT2hbHvm7STq
         V0zDD4L18iu2Offud84GBpI/PeOs0CeYRiXydLhj/c/KdSuhfeGL7lD9BntAhz3yjLuE
         urAkyV5X6u0IRb4jiFNK6Z7zq2xx9Xl6nyrNN5lcJEGPO4Iyb69epiz4TLLnQI3mEzSD
         +Dz3GsGiUebBTc2vMyyazQyDGQuFlhJXJfoxQE5ifEcgj1267xSD7LtubHmTgIKurk02
         3TRdq+avrQXPYYxqvkrwA42ePQeTIPALKsW9gGdcSgPLpVDJF/rc0Y3TalRTK7JdHQWH
         4ygQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784905565; x=1785510365; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=I2AhTyeN3QRdL8SRsF8YtEzSAzEn5+ptNy7HN5yACgQ=;
        b=QmcEQY5mzSsOHqpAYuQdLkTt3hXzp6ENcX3MU+pcHpUaFux9hmDAiBrkujOWmSy212
         GSRbwwgTHBq3oKRdgRdsEevFPh/TtzOnmICS2ssYvVaxXb4Exer+C2SNVIqjRWmV7sE6
         uCM+6SPDBRGqHN3jOSSHC8Pl5CMBjajsu6pmYuB7VrdDGCfVczsO+t5r5NyCMBNwMAqf
         8FLbAqC/JD2l0KspXY5LxD/HYogZKWrTvKHGDNIXqUXZ5/oBjUbdN/ZP6ubocSFv3hKk
         Pdn6+71YBFBpVXO+DIQ1HkAwobhbsSVpchLZGRGpWUh0ipYWVbSCUxu1Y9lJe15RzebL
         VUXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905565; x=1785510365;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=I2AhTyeN3QRdL8SRsF8YtEzSAzEn5+ptNy7HN5yACgQ=;
        b=iVccpMdTM9B0ooB82JeXB6NIZtqwPYxRvg1y2yyTFfeXTtwgnxHtztTmeILV9c8ttC
         7ESwQThzvMAsRMCmFk6PPgLaXulKDsYf34MXtqwYv4FrDDX0fGv70aYy/8lVB8mag+pz
         PDVdM1flY7Eo7rLA3NgUhVKa6YajAU6nB6AyDslDL5r674750TYAO6pJafweDETJnkKw
         aOH0NqksejCwJSdIyU7fCLm0PJKMXpqTOSNT7SJvChhRlbPgQY9LTqDXgFlqDA4hin6+
         iJeUHoXGsIxjdxWUrKYxzSf8h3h9W6s7FbQzYmqtOsMNKcjtErcDXIieUHoOHrYr4N0u
         odJA==
X-Forwarded-Encrypted: i=1; AHgh+RoZP0vvXbPjwuBVR4w61LMSqVEWZ9pFgpeIg4nNZPOc61jAkCbvfniyEFbKgr2ZROUk6+HKsBQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7q1SWeXX+nuLvkgBgPxCi02chh5WjK7UszkSgP7o550WxwX0I
	soOuRbUjrPWXyOeqyGXZvE/cm56c+B4IxWimcSUFwDdWlg7ok/+cacmkg5s+Yr7ATzV+XdYUW2Z
	3/eUdNteHMzcnlTAMYkognSaKts6Ci82q8GXnXfDI
X-Gm-Gg: AR+sD13QN0mF75oLbLVLzLemJH1oP/YQ90zSEurGx1ycJHD/FBp6EqLYFAz30jf+rtu
	STE4kBkezLDom+/f5XXzxbZN3xGUNMcejR1UshOZuC//u/5kTPcMkMLIy/LiemE1wrWFCxYmGWu
	ZD4ZToOe3HUQPB0Zc1ZfZWonc6q5+6i/FPcTb8PhC9me8p5G++2+cSjSn9FkbQVJcSPBV2M9mDF
	a2JFMzGzUAnV8jEely4MI2aJiCECswUcuClHYcOZNxfztmiqGrgxikSBakz1Q==
X-Received: by 2002:a17:903:41c3:b0:2c6:a078:bfb7 with SMTP id
 d9443c01a7336-2cfd0fb3585mr3755725ad.7.1784905564254; Fri, 24 Jul 2026
 08:06:04 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260724150156.72816-1-doruk@0sec.ai>
In-Reply-To: <20260724150156.72816-1-doruk@0sec.ai>
From: Mina Almasry <almasrymina@google.com>
Date: Fri, 24 Jul 2026 08:05:51 -0700
X-Gm-Features: AUfX_mwLgnAT3LWQNCfXsdDgeg6v8reQG-fWkKN1sEa9xceCtFPXGiiL_UvIO_E
Message-ID: <CAHS8izPJK1wm0a2FQA7L-fjKc9pLiqYBDyf_GEb_AvnBL49gOw@mail.gmail.com>
Subject: Re: [PATCH net] netdev: require admin permission for the bind-tx
 netlink operation
To: Doruk Tan Ozturk <doruk@0sec.ai>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Donald Hunter <donald.hunter@gmail.com>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 24, 2026 at 8:01=E2=80=AFAM Doruk Tan Ozturk <doruk@0sec.ai> wr=
ote:
>
> The netdev generic-netlink bind-rx operation (NETDEV_CMD_BIND_RX) is
> flagged uns-admin-perm, so binding a dmabuf into a device RX datapath
> requires CAP_NET_ADMIN. The symmetric bind-tx operation
> (NETDEV_CMD_BIND_TX), added later, was given no permission flag. The
> netdev family sets netnsok and has no pre_doit, and
> netdev_nl_bind_tx_doit() performs no capability check, so any
> unprivileged process can bind a dmabuf into a netmem-TX-capable device
> TX datapath.
>
> net_devmem_bind_dmabuf() attaches and DMA-maps the caller-supplied
> dmabuf to the device and installs TX device-memory state, the same
> class of privileged device operation that bind-rx restricts. Gate
> bind-tx behind uns-admin-perm to match bind-rx.
>
> Found by 0sec (https://0sec.ai).
>
> Fixes: 8802087d20c0 ("net: devmem: TCP tx netlink api")
> Cc: stable@vger.kernel.org
> Assisted-by: 0sec:multi-model
> Signed-off-by: Doruk Tan Ozturk <doruk@0sec.ai>


It's intentional that NET_ADMIN is needed for RX but not TX. Maybe add
that to the documentation.

On RX you'll see any received packets on the RX queue, so binding
memory there is sensitive. However binding a dmabuf to a netdev for TX
is not really sensitive. It's the same as sendmsg with zerocopy more
or less.

--=20
Thanks,
Mina
