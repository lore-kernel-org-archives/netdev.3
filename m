Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A687E1D5170
	for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 08:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774774061; cv=none; b=Gge9dQi995W/sLh6QYCUDyROQKbfz38PLlFlewVKmkJmhasbxYnh+Vomwv8Vjin/zhSyhtOtdjz8Qs7dTt3V873Wr3vfaVWyckST8c0morob0yaKH8AxBnTxPS6eYzh0xfKAmCYWWjH35/gTF7wNtZrksWA6KF7jPsVlPSPR5Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774774061; c=relaxed/simple;
	bh=VSNeHqGQi5UQv8ev4baa9U74XQptxaGjHqWdFvbM9Y8=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=aKD+Wsuxg2Uy16VADeBRH5FPpsIqu70m91I1k4YF6tiBw6LfYVXEjqfxP0P5zQHv7WLRJwWfbMHZ5fItLFEVN2yyBaHAyv7VDtOPaGtbZn3md1wi730taVyhBuqMPOvSEnWRp4ruxxz2iw/CMG/X+nz4kDTT5N9LTth43nM1ArE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-486fe655187so43958695e9.2
        for <netdev@vger.kernel.org>; Sun, 29 Mar 2026 01:47:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774774058; x=1775378858;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nh6wi43WlvRbTT2tXYoTLwx6uE0Pvl9KzxXhavo8nbU=;
        b=fJqlTJXkvn+bvqzamZLTFP1UYSZCYSPWEtm+Im27lv7AdWdSmPB4uVZtt6hpOrgp1g
         gK8uYBdWUM/1fCZGmnEC4mvXfoKstHadCgBv+8tqXuIn1YRb9Hv5QzC4sW21BU4W5/he
         gaJzBriEj/5EF9p3QhtSQxiDr+/RDZAVRtQOjASkXZeLJRcueMQRqfXGpgCN/LvHJdxb
         ycPaln1+wpAnXrQ2GKBedpAAABehUwgZoEdHSldWpVx2ofOh2bU8qZjrFYiCGKoyQ055
         F2JGDYcJM263hglCNmuil0MzFw3VchGFs+A2V/bZ5YCxv6z//DtqvxOuTrI4JRbCCBt8
         inpw==
X-Forwarded-Encrypted: i=1; AJvYcCXRqUU2Vr7X+m+7kvtDphWv5MwYZkMFbXxxapHEhUHFht7EJpOUqnYzdodMIn9D2I1IZLQZQHo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBWWRh1lUsaHkzo0ZfLryMQOE5dgzmrc2yEO+IxnzqjGuy8dT7
	DY3gk51M+z4Q1QV6arMxfozYBXdrOy70h4XmgPoa8Yloe7bZXLBfq55N
X-Gm-Gg: ATEYQzwCp4XHtf4yK2Sw03Q/6VPKipezH090rXoBtNc9EWpHus4rgdF2q55cTO7ckOm
	aaGG4wVqzNsBwDTJOR/v9eQYzbShujyOk4MVAuPIR7zTZFGTcp9Bi3+c4LwGYd3il6/z5di4O0J
	M0WQKGw1672/DZVtNko9Csp/6nmofnshem+S9NvnR0l6ZpZVdnIDQ6pklu9BvXeLyGj9ODlkc29
	i7KNArY39v3v1Q37s2cEj7IHpxootMtRF1k2lCeHdgDcURUecXqIgQzBmUj2cW8aYFttG5Jnbub
	TAajZAwNv5kEnmAj9iTo15xt7y7k6hTHWeVMijw59YjLuOobn+SL6SUPKIHYopOwheyvYtYu1gh
	bs9YKmk2bPAO/Wt4gHuatV6SW/bnoYfVX9TSqyzDtaBgzPr8J/dEgLsql38hdNwyObPAZwZ+MDT
	6s5yh0ldzsvPVtA4WMEzZp5t5rBLWJUYMRDA==
X-Received: by 2002:a05:600c:64c8:b0:483:8062:b43 with SMTP id 5b1f17b1804b1-48727eb7f4dmr138474605e9.19.1774774057894;
        Sun, 29 Mar 2026 01:47:37 -0700 (PDT)
Received: from ehlo.thunderbird.net ([94.156.174.93])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf245f8a3sm11258404f8f.24.2026.03.29.01.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 Mar 2026 01:47:37 -0700 (PDT)
Date: Sun, 29 Mar 2026 17:47:30 +0900
From: Alexander Popov <alex.popov@linux.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Andrew Lunn <andrew@lunn.ch>, David Miller <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>,
 Maxime Chevallier <maxime.chevallier@bootlin.com>,
 Michal Kubecek <mkubecek@suse.cz>, Gal Pressman <gal@nvidia.com>,
 Kory Maincent <kory.maincent@bootlin.com>,
 Oleksij Rempel <o.rempel@pengutronix.de>, Ido Schimmel <idosch@nvidia.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Greg KH <gregkh@linuxfoundation.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, security@kernel.org,
 notify@kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_ethtool=3A_don=27t_touch_the_paren?=
 =?US-ASCII?Q?t_device_of_a_net_device_being_unregistered?=
In-Reply-To: <1c41e408-15f2-4c83-8a0f-24b46b1ec1c1@linux.com>
References: <20260322075917.254874-1-alex.popov@linux.com> <3c07c51a-421b-456f-9819-9021ddd7b22e@lunn.ch> <eff8cf89-fc3a-4aa1-bcfa-c939c9e7d853@linux.com> <20260323150827.24a6259c@kernel.org> <1c41e408-15f2-4c83-8a0f-24b46b1ec1c1@linux.com>
Message-ID: <676733D7-814A-4B66-9E49-93DD1259ED48@linux.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 25 March 2026 03:46:20 GMT+09:00, Alexander Popov <alex=2Epopov@linux=
=2Ecom> wrote:
>On 3/24/26 01:08, Jakub Kicinski wrote:
>> On Mon, 23 Mar 2026 02:08:53 +0300 Alexander Popov wrote:
>>> Hello Andrew, let me describe the scenario that I see:
>>>=20
>>>    - The netdev_run_todo() function handles the net devices in net_tod=
o_list
>>>      in a loop and moves each of them into the NETREG_UNREGISTERED sta=
te:
>>>        netdev_lock(dev);
>>>        WRITE_ONCE(dev->reg_state, NETREG_UNREGISTERED);
>>>        netdev_unlock(dev);
>>>=20
>>>    - Then netdev_run_todo() frees these net devices in another loop=2E
>>>      On each iteration, it chooses a device for freeing:
>>>        dev =3D netdev_wait_allrefs_any(&list);
>>>=20
>>>    - At the same time, the ethnl_set_features() function calls
>>>      ethnl_parse_header_dev_get() for the child net device=2E
>>>=20
>>>    - If the race condition succeeds, ethnl_set_features() takes the re=
ference
>>>      to the child net device being unregistered=2E That makes netdev_r=
un_todo()
>>>      free the parent first=2E
>>=20
>> That's not sufficient detail=2E ethnl_parse_header_dev_get() is under R=
CU
>> and unregistration does an RCU sync after delisting the device=2E Also
>> not sure you're distinguishing struct net_device and struct device=2E
>>=20
>> How did you hit this issue? What are the net devices involved?
>
>I've provided additional details about the reproducer of this vulnerabili=
ty to Jakub and to security@kernel=2Eorg=2E

Hello! May I ask about the decision on this patch?

At patchwork=2Ekernel=2Eorg, it is marked as "Changes Requested":
<https://patchwork=2Ekernel=2Eorg/project/netdevbpf/patch/20260322075917=
=2E254874-1-alex=2Epopov@linux=2Ecom/>

However, I don't have any instructions on what to change in it=2E

Thanks!
Alexander=20
