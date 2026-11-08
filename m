Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794138454;
	b=dABG6shW6uleT2aZWETpwfx1y9wRBxA9q/rY4vdRiPKrX51tAtAsDntxX5UYMV74ChSq
	 jdLk7vupwkwUtCtFNbom17ey0CxEFEtU4XhKDtu4Gs7zhgznho1jorIeF9Ib/mUW/pWgU
	 BvIq86VXtFjG1BAUADy2cmojL0Z/GoNSwdZ+WakIQ0WjzZp/olfa2q6hdqVvNOmnN0wxD
	 BQ+cc9WmrQRCjxE8mvlw+l+ZkBp6o2o4gzlhmJr+g4xdF5cqaszvA4Pnx6DBDefo0jJjW
	 H5qrdNoqSOjXI2APrx5uvnqYIwBchvjVqYuxyy4690bxgqm7Qj86UgwDh+qJjdYPykw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794138454;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1Y8EnhS7o4bUUaMd+9kBk4x0A+szwvlZw6MXN768V/Y=;
	b=ml9KNYDKyOl0pmK0fylUkMZSABH3KV2m1fDbSFEp6t0E5+p26+rSt++TpTjL0rpndLir
	 H148SdTK+hbffGCQ2XG1rQ0/XqwPalUDShhkxIftVFHhpJgAAWlJc92AXKETj1727faM/
	 OKkbpy4O26tI0lkhjDTklbdmDLwwnRUYYXhtl+062txfHHXrmJm8JNlGTLyTgZhKtIPFj
	 g9salnodqe9otTq3rXaIAmdXOKHZC5SkmZtD0kxbPJKj0WbShnKH9hnjbRnOsmiJ4PP5N
	 5ehc1PTiPDf22ohYe4GvqNLbhi4014LPtkxYrC6Ae3gAwollrL/Q0MLKXHRlaEteZzw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bairaktaris.de;
	spf=pass smtp.mailfrom=bairaktaris.de;
	dkim=pass header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=jETELm1Y;
	arc=none smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2D5B606A321
	for <netdev@vger.kernel.org>; Sun,  8 Nov 2026 11:47:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D2D5B606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bairaktaris.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bairaktaris.de header.i=@bairaktaris.de header.a=rsa-sha256 header.s=google header.b=jETELm1Y
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4d21051042so7926666b.0
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 03:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bairaktaris.de; s=google; t=1794138452; x=1794743252; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Y8EnhS7o4bUUaMd+9kBk4x0A+szwvlZw6MXN768V/Y=;
        b=jETELm1Y5XaG/cTJQLXmABBnB7mhSrc9sbdzZ8p6mRRmgHV6onkf4q2pry8PzMZRQH
         CH3dm5/SCZE/MiaWN8wHHtD5qpo7gm7/gf2xECMQK5aRfgidLCfRdXBlZ/8Z84tYRx4E
         L8X7ejBSFMFF0wYbSupve7tvU2wwgTNX0paVCHqto+8VRqZf+zRPv/fYjo+RcUGem6Nx
         xZzYZGGDn7gWrr11CH3oOkoXoDM+rWsPHna29fDctTyHMdBpsJAUCNcBzAOWQ0Q2RXy2
         IJVzJEbaQIPslyg/cSnz/2UpxAYa+aTS3enUxQM2GyQLLYSa9DXrrsmMAb7puxXIafq0
         eSZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794138452; x=1794743252;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Y8EnhS7o4bUUaMd+9kBk4x0A+szwvlZw6MXN768V/Y=;
        b=cCKU1kl5xv0r2lYTeurXttEe5V9qm+ZhCJnuLBWuON/RhXOcsTHK2GurDZTq/8P6e+
         /zrCRPzab2gSiArUv1MZ1GbYgNj/gafAzxE0EkmVWaATGJfdQ+9CpPbqGr526vkMcIQl
         6TTjpyX20UZ1SlQX08vEOYCbz+JQfcyYQ3iFuaatPpyjhLih0+v6HPDYr1yfMqBCjEvu
         8hol/3bKfGeJkMWwUjF5Bsm2ADbmwZX11P+HwaMvpYZSFAT+ruZ5Jsfw4XyIwpDCs4r2
         Rxu+SzVFNDYZui/h9C6cGi1fh6KM2M5535pEZsOlkDMkzupTtwx3X49Ro562ks2kIzyH
         ObOw==
X-Gm-Message-State: APuU4Z/lQT5GH1tWpAijlftSYKsqgmA/57iiRKsgCfgRqWxs4MaEChT3
	Hp54a13aDoEbeznyC70PLjEd2XMukNxTJmEMvYGbGkkhaZdlv4QY4WZxQzjOHt71NA==
X-Gm-Gg: AYBFou04UlTHJqAfrxepoBcgZEf8ndsxf2n6p2OV/urukLpJ2tyFW6AuhAvviC8jLyI
	FFNBe8xjSyh5BmMW01b4e3CD9aW/5/wb5a13B4lXyfMINNOqTyRfWkCKIAvHhUd8ITU950hTjgH
	CvNmKfQerfBmMfa56wdIB9MONdmVNUXxi376h6+nL/m/Ov49Eiiz5eq8b47JcNMGtPcJwLFVjHC
	Y761PPgSIk10fvpF2/XRPv9YrbdP2rPvPgsaexO2if4l6I6SrvVvFntpdVIJHngYocRgNfSwkAx
	Dy6Ws/ZsAws7THrfixoeC4o75XqxUSARnPcjFafsjX/Dd4cS+UBR0KA/d9upor/S8Yv1qlINvYv
	AiPZtRYVfAoKcpIU2IvdKV9njWlAEO0NPKHgRM0JF4ja2Ss2cmcmsd9r5MaXN/xTBGjACbSHG0v
	2Hxv94b8ldsPST00NLtAVwhVES8VU+CwIISya9I9/6bVIWNJxNLRAAyELPFz7gSnVfNgHzyiVac
	EYHqfLYGP5uiRR8jmpmHgNtoG4Nv45zijt/bP37Y7ZHxtWe0W8ID/9IKXxPFz9tOBVSciIBEPhH
	3suk+jPQeJy8tqJ93nbfEETnBymXen8ZqZRBQxYL5jXoY45OxJO82YFlgSnLtNfTNRbquo+K3U3
	ma6rCgjHq+e5vKfHPnnL6WgKkRF8aSQxBK73grLioP7uxJeAcw1dvzASS9EHC1eKMCv9dbc2Lpz
	5pj9g3616gURxzaI6Cn2j6+dgqfHxJhN5q+oLj+iwQmY4kOlrI/N8d2deOxngbyZX5hT5H/vAu6
	jvo9VrTVeJqlJNsu5va+/AZ9mU0/Pq4Fvxe23To2dvWb4ydsJ3KY2shHOXcEOg4o+Cf+7c7I6e4
	xS1Wq0wulWOVqJifiQ==
X-Received: by 2002:a17:907:80b:b0:c4d:2cb4:7bbd with SMTP id a640c23a62f3a-c4d6d7c1ac0mr93601366b.47.1794138452222;
        Sun, 08 Nov 2026 03:47:32 -0800 (PST)
Received: from Desktop (p54afff19.dip0.t-ipconnect.de. [84.175.255.25])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4d6a99320bsm56079066b.67.2026.11.08.03.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2026 03:47:31 -0800 (PST)
From: Julius Bairaktaris <julius@bairaktaris.de>
To: razor@blackwall.org
Cc: netdev@vger.kernel.org,
	bridge@lists.linux.dev,
	idosch@nvidia.com,
	davem@davemloft.net,
	edumazet@kernel.org,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	andrew@lunn.ch,
	olteanv@gmail.com,
	vladimir.oltean@nxp.com,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: bridge: fdb: hold hash_lock when an entry roams
Date: Sun,  8 Nov 2026 12:47:31 +0100
Message-ID: <20261108114731.123174-1-julius@bairaktaris.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <01600be7-3d8b-48b2-a59a-1125eb452714@blackwall.org>
References: <20261004124254.3525496-1-julius@bairaktaris.de> <01600be7-3d8b-48b2-a59a-1125eb452714@blackwall.org>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(Resent with the lists on Cc; the first copy went to the To:
address only.)

On 04/10/2026 15:44, Nikolay Aleksandrov wrote:
> Absolutely not, this was made intentionally. Taking the hash_lock would further kill learning
> and roaming scaling. Surely switchdev drivers must have dealt with this for some time
> now, if you'd like to fix it do it so the software path isn't affected.

The fix moved to DSA, with br_fdb_update() unchanged: "[PATCH net-next
0/2] net: dsa: fix host fdb refcount when an entry roams". DSA no longer
counts the roam events; when it handles each event from its workqueue,
it looks up where the bridge has the entry. The only bridge change is
that RCU lookup and the filter it shares with br_switchdev_fdb_notify().

https://lore.kernel.org/netdev/cover.1794134495.git.julius@bairaktaris.de/

Julius
