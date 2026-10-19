Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6D23F0A96
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792407080; cv=none; b=hDR9wc7Z3SvnlwFlKN17SYwwmcOxzRmDpY1ByMfjcDz0fXIMUmgHs5Rp2vSGJmK5ApFE9XgS1Y+lQNSf/VpzpQchPNnUx0nqK3MrXUY4OeJArtMRfR/ADsimiMcKsCMf3/xTkmRcVXpFW9y83af8llg3XoE0s6Skzu6q1MhWgg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792407080; c=relaxed/simple;
	bh=mUZ3a4L9u8hGML0HGfu6/nfxzUPptIdNHJ1NPKl85No=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Hk6PqxJFhHCCShL7TVqoBQobHEeA7O7ckl3PNmLomyVe9+sL6W/xurTCEBTkZHFRLo3QwW/rojTD4noUBhObMexjRs1scsnrXgkny1I4/yFUnokyHV3b4OD6v2PPUvpOnOslNDLqWQUlO2rDdswefCiHQ9ByF2DI+y3EVB3xYBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9mFI+SJ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9mFI+SJ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4a018792ab3so14466545e9.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 03:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792407077; x=1793011877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mUZ3a4L9u8hGML0HGfu6/nfxzUPptIdNHJ1NPKl85No=;
        b=I9mFI+SJqjq0XcHwJFkb3M80ErIbN+HqMhWDoNhhyZG97HoZQSqIslgGV3mxXdU3mg
         ysuq1Idipa8p89Gfi+fqm6HebGeSkM7mwbMTmiXTpvVqwuKZIbqX5bET9zmMa5VIVqeI
         crwGAaApdGXW53OPqzRc/lIw1KLNcxkw3j51bw1Lp8e3xvob8PimwM4t2hklKAIrxLBn
         ujeXY6x95chtJKlmd5c7UqONWnlXQ2HADmH7xOmN47AtDIuYyKGTbyS6tUkPD/Ewm8E5
         PhycfHm9ps+TdPUbU44KIjg1DYe2SgvEFIXnhDL4dsbdN5mYS2flLtOQ5e1mfo7MEHqv
         J+Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792407077; x=1793011877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=mUZ3a4L9u8hGML0HGfu6/nfxzUPptIdNHJ1NPKl85No=;
        b=oZrrzgGrACuu4iZVnzx8AunmZZhKp65p8/cpZ5sd1fA0GWKOIFVepWOJei1sYTY0Zr
         hvaeHZ6qAH2iOidPoRXc1cOjZhLkc+A7Nr4l9mBIuqAAoR6Yv3QGfTEWiImnPR9064PS
         fPaeU0odNwTDmaiB5n60nSPmntL3XzuXGqdFxbKKTCTcrA5Lsa11opfz6F20mqIeY51/
         95JxeI5ITGbRA8kJmvuoeliKD69cRi+P2INKiEQgTQOMu4ZUxNhD1Z+e/NvB0xKRK7gD
         LMIILVAdTVHUeKMyYRD62RUZEJHElrDByJpm/xXrVpGiqjK60j4DnXr8uTRPoPCC+pHu
         hczQ==
X-Forwarded-Encrypted: i=1; AKwUvBxw8EdcR+ouDw6CL+dBaIhbb47JnIphzqHb9XcI4bOPyCut+Khc/EjibuMSp20V/niEs1BQfGI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLvW1s3F8/gOsbangBNftSwFk/aAoTKUXL+m9WDR8l2BPsTOgbc
	XWrd+xuVMNXWcGdqcJ8I/3SHQUAn3p3WS9xOkC6l2IfB8XUrirSfVAlY
X-Gm-Gg: AYBFou3+Bq5Oy77vceXh5L9NvJ/3YJHLQpljF4w2cY6kXvQ7OqmF37LTQXZK9jPwMpv
	gPNQKQXMgmma0BblEJBDEUUJkIvF4EpI3UlExHnPoQuv4UAc5p+US03gSBp8ZWaHBsLa8iMRfSF
	Ei8a6RNAHMTv8zO2H6UvSbMpZYUQgWsW6eGqAQTnju6BmxQ7Yk7ThtuerARlJZW5+HEc2ONv9zC
	doRd83ni0A82fGS8QPWHQwwuWlgLV/E9tSqNKGAYbjcFBJT/cabtkgguMqG7Rqpo5uCfEIHksN4
	2nLm18Uh0fEWKA4Ke1q673A/pMt0/slKlaHahEBWu77+xruwSnbIBQrOv87TQ7WJPr13/v5WrkY
	ALP9UwsNHgJgMLtjbejFBv8KE+2OFVx4wTTGo5SYIJH/3DG7+hHxa5ME4ViAYq4lcveQPFuaMwI
	jYJwxNBPnRpMttY8y1kePA5wnFchPIV6neZ8i7gqhKU92tIlOhWEudmCYd5jRQw1MKDYEkfeG87
	1VvXfrrryXkn6WWhvhf
X-Received: by 2002:a05:600c:8b6f:b0:4a1:ce33:1536 with SMTP id 5b1f17b1804b1-4a1d75e37ecmr129613605e9.9.1792407076395;
        Mon, 19 Oct 2026 03:51:16 -0700 (PDT)
Received: from VivoBook-ASUS-X712UA-M712UA.lan ([2a00:f44:cd2:abb8:f65f:be3d:fed3:d2aa])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfd471a1fsm19081835f8f.3.2026.10.19.03.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:51:15 -0700 (PDT)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next] net: dsa: qca8k: report port statistics from the MIB
Date: Mon, 19 Oct 2026 12:51:11 +0200
Message-ID: <20261019105111.210567-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6ad54060.58e5e2d3.9d5ca.ba8b@mx.google.com>
References: <6ad54060.58e5e2d3.9d5ca.ba8b@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, Oct 18, 2026 at 11:55:42PM +0200, Christian Marangi wrote:
> If we really want we can reset after each read but that is problematic for
> the ethtool OPs unless we also update that function to store local u64 MIB
> for everything.
>
> Up to you... I would start with keeping and updating all the below things
> and then evaluate the needed changes to reset at every read.

Agreed. v2 keeps QCA8K_MIB_CPU_KEEP and adds only the differences, so
ethtool -S stays as it is.

> This really seems a task for the MIB from mgmt frame... May I ask why those
> are not used here?

Only because of where I tested. On my GL-B3000 the switch runs with a
tag_8021q based tagger from the OpenWrt tree I work on (the conduit is
offloaded to the SoC's NSS engine there), so mgmt_conduit is never set
and register reads over MDIO were all I had. That is no reason for
mainline.

v2 will request one autocast per interval when mgmt_conduit is set and
take every port from that one burst, and fall back to register reads
otherwise (another tagger, CPU port 6, conduit down). To get all ports
from one request, the autocast handler gets a mode that fills a buffer
per port instead of dropping the ports that were not asked for.

> I would like to see define in the header file, not in the middle of
> functions and declaration.

Will move it.

> Why STATS and not MIB? Also I would like to have all these register
> converted to define if really needed and update the ar8327_mib struct.
>
> Also Also why not use that directly?

Right, the second table is not needed. v2 drops it: an enum of indices
into ar8327_mib[] (the table turned into designated initializers, so
the two cannot drift apart), the counters read by the code that
get_ethtool_stats uses, split out into a helper, and get_stats64 built
from that array.

> Why this? For 64 bit?

Yes, RxGoodByte and TxByte are the two 64-bit counters. With the shared
helper and ar8327_mib[].size they go away.

> Maybe generalize the logic in get_ethtool_stats?

Yes, as above: one helper for both.

> As said MDIO here is extra slow especially for MIB every x seconds...
>
> Autocast MIB is a MUCH BETTER WAY.

Agreed, register reads stay only as the fallback.

> Is it correct to give window_errors to TX late collision?

I went by include/uapi/linux/if_link.h: "@tx_window_errors: Number of
frame transmission errors due to late collisions (for Ethernet - after
the first 64B of transmission)". The same file says tx_errors must
include them, which the patch does.

> No reason to scan for a port that is disabled or not connected...

Ports disabled in DT are not user ports, so the loop already skips
them. In the register-read fallback v2 also skips ports without link
(a bit set in mac_link_up and cleared in mac_link_down). Since the
counters keep their value, nothing is lost: the next read picks up the
difference. With autocast the switch sends every port anyway.

> Considering everything is run under the same delayed work, does it make
> sense to have a spinlock for each port?
>
> Either have a delayed work for each port or a global spinlock for the task.

One spinlock for the whole cache in v2.

v2 is written and tested on the B3000, both paths. Over three 15 s
uploads on the WAN port each, the wan netdev's TX bytes matched the
MIB's TxByte within 0.002% with the qca tagger, where every read was an
autocast, and within 0.01% with register reads. I will send it
tomorrow, so there is time to object to the approach first.

Thanks for the review.

Stanislaw
