Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793997381;
	b=ucidKvdYqrhAtgS2aeXW+GSIpIqL0Y8uT5V96WJZLEkKK3fWjLnbVtCX2InXwOZsRvG/
	 oq9K3x3vuxLMZm2q2K5ACEsApgDohnK7T8pwRte1sj5fIqMoNT1RxaYiSn01gYOtdwsDL
	 FTJ1Am+u6FlliHlhldkROfGZplMshFQwPxBBC7BEW2PvbX0R1WztjiZW4wOt5pfbyh1m+
	 qci5m2cdfuwxNJk7wOs6/x1QNuCdfefUpqereShvJKt642zhz48BNVzcbDs82APalp0tx
	 2xlMKcJ20wyvqPXl6tlcmHc2csYDqeTjDZ7xm093DdlPaKEyblpcVEhaZKXti3B6hNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793997381;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YdwH6MbSdlsrCf4YgApBgw3WaVWl4RE7XPNP1oLH4co=;
	b=dbKPGX6uNd9bUWUEksUw6MUwPBmcT70P9AASL1/2y3Ieoqd4ZQE7suzcuDtLEBEu5F7B
	 whGhK9ij8id1a2dUgTNWtDtrDPQw1fl4PeX1Hyvtt7SsgPh7K8KqRGwDXwl9AGiyuUZcI
	 iePRKsVQl6O9SbamYE43WK0R84zdRBPAzPLlZHCdfbogMAsT+p9bvngxn4TkONsaoREdm
	 0AShM1RNE5NTc+tDdUo9+f8G9sBucWK4M7skYeoTduF/nF5yTWO5AV2+K1vzl2HAvjGtE
	 XJjCLe4GLeUnJTR3okvLowhZhpImijyOK6SMBqpSTdsb6rF2JcBbxMoCexYVRaDyGlQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w1qn420f;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0CD606A326
	for <netdev@vger.kernel.org>; Fri,  6 Nov 2026 20:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC0CD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w1qn420f
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a5036bbac7so6970285e9.3
        for <netdev@vger.kernel.org>; Fri, 06 Nov 2026 12:36:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793997379; x=1794602179; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YdwH6MbSdlsrCf4YgApBgw3WaVWl4RE7XPNP1oLH4co=;
        b=w1qn420fLHO7PyujizRYZqZsJNPZgFZ86LIOQCgn518ex5BIAShd77wXlnZh7jW7oQ
         w0tTutzajHzCYrREnzMMP9n5NTOlXdGxFc10GdxfELvR/nbDOhtkeUx3maaDEiyJYsM2
         SOWAIXqbqKIY4rfyS2YNSASKW+9xlurrfExXLjk4cHJzGxZCX/yn5mmv6Dyv2SEMwep2
         mGILuCFzrX57pZucbVrQKhj+o4eckBQvY5ZLEpAqqG6wmnZdbP1QIzTnMzHBNOOhNde/
         TMawIMJZKr8kqiA+/zuwlyAS6eupqzdMUIm7Tf9Xeh4n9BaFxLLtdu/VqpFjLV9m+EIw
         NFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793997379; x=1794602179;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YdwH6MbSdlsrCf4YgApBgw3WaVWl4RE7XPNP1oLH4co=;
        b=UM0cILOWmIiKDtpZXGR8LSiGvvAiw11GjE6j91sAkiwOJisJnOACs4ffAi72CZDW9o
         J15XxJNEc56+DJBzn0kreP5By8M3oJewpVTxgJnMasiHEizGTgkW38oaygE1/TfXCQjz
         G0mSr6z9qPZFE87YnQB2/OFjWVSiRsKMa+OHvOnflsMci4OJS3Tjf/9gJEqV3FXoPdhg
         9xYV0hFQmWatjiw4AL99MDnH9F3PnGJrhozr15fnbkKjUepGMVaJe6mMenKpW6b1RMln
         8l8Q2q//m43mzIEIg/LvkM+l3DdmUb4R2QFwHipd/nFsIx98KIhols5nfGpO65rtUx4Y
         7j9w==
X-Forwarded-Encrypted: i=1; AKwUvBxqIm11HQgyH9aC5lnjRjLfxnk9Cp2jFYjyG+8LC49ioyyZeun3dcKQwORKrKYkATPlJu1tsK4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/IN7ACyFFMc4DkRo4YjvQ3tVaKVT3RrnXNgy+0cDTOoqA9+4Tl
	CGGRX3EPTQWf0mWX7BthfT8lVPG/4DRWh8PsmqD8+k3zBAg9ry9elELy
X-Gm-Gg: AYBFou3866WfjELxFkp6npmrk0l5e8jhtOiHYUF0jYdkC86QBsIvSFkCqkAp1J/m3zL
	I9l/jrYqe+BFqa8F4+IkKlEwXs5AKce7ZjFO+vP3DD/oUljcpr3j8zp8GC4LuvoLjvPMhhS3i67
	dK+LSVdgFSYTbKnKMFSH8TgFRnqos0tj9GdIvejh1aBUgf7tp+X2gIaX8iQgtAjFpFcMpjSoRN+
	qBDKrkUL2V8t/8xquKjoBHjZLKtPeDtLEwUc3BhZwyIgpVsQkh87euwgNCZWzWAEPMMoPPTZV5/
	KGYjw+dGrg8PbMPywcuGnn9ld28/XhzXe+X/HQSAxSrZuO7jTqeebjYGTHouG/m0snw6gRTblIw
	APOWZ4qn+Dq4AhQHXbsb4P2bzX5OWisYhSDQixC7ryJ1kBKC7pYQWRrbfaM3pb8rIKaoP4+Muwn
	k0dKS+Gn/vJdgpHENuCw4bTl6al8kllWmMHN/6BCepLevQeSHdgqKjzcqYTQNDsi1vtxzs15SIE
	IeqCpigzC8c3cr80gXSSoHSJyJxRWz3uQvyXbTU+PuhCvVeSm2Ih1RxHlg+zJ8sSeYfJCyLlbZ6
	MZHgzNOjf9qVbljlGhsKjq5e7UB5NxsAWxe88VxWtwxRZgdz1v9/2KSXwxzGhtmBTh8SfLPfqMc
	5TZs=
X-Received: by 2002:a05:600c:4fc7:b0:4a3:5a42:b2a4 with SMTP id 5b1f17b1804b1-4b6dea69b10mr67372135e9.12.1793997379131;
        Fri, 06 Nov 2026 12:36:19 -0800 (PST)
Received: from VivoBook-ASUS-X712UA-M712UA.lan (public-gprs171435.centertel.pl. [46.134.8.236])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b7efb1547fsm10183925e9.11.2026.11.06.12.36.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 12:36:18 -0800 (PST)
From: Stanislaw Pal <kuncy7@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>
Cc: Yongzhao Chen <yongzhao.derek@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Ziyang Huang <hzyitc@outlook.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v8 1/2] net: dsa: qca8k: let regmap serialize register access
Date: Fri,  6 Nov 2026 21:36:15 +0100
Message-ID: <20261106203615.19274-1-kuncy7@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <6aee175b.f01aa0c8.37eba4.18ea@mx.google.com>
References: <20261104120130.48455-1-yongzhao.derek@gmail.com> <20261104120130.48455-2-yongzhao.derek@gmail.com> <6aca850a-ef67-4451-aaf2-977be884d1b0@lunn.ch> <6aee175b.f01aa0c8.37eba4.18ea@mx.google.com>
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

On Fri, Nov 06, 2026 at 07:07:19PM +0100, Christian Marangi wrote:
> Both mgmt and mdio operation locks at the start and unlock at the end of
> the read/write or rmw operation.
> Using the regmap lock seems redundant and this is why I disabled
> originally.
> I would like to have more explaination for the
> "regmap formats the register and parses the value in the
> map's shared work_buf, outside of the callbacks, so two concurrent
> users can swap or corrupt each other's register and value."
> case.

The qca8k locks cover what runs inside the callbacks, but since the
map uses .read/.write, part of every access runs in the regmap core
before and after them, in map->work_buf, which there is one of per
map:

- regmap_read() goes through _regmap_bus_read() and _regmap_raw_read():
  format_reg() writes the register into map->work_buf, ->read() is
  called with reg_buf = map->work_buf and val_buf = work_buf +
  reg_bytes, and after it returns parse_val() reads the value back
  from work_buf + reg_bytes.
- regmap_write() goes through _regmap_bus_raw_write() and
  _regmap_raw_write_impl() (no format_write for 16-bit registers with
  32-bit values): format_val() puts the value into map->work_buf
  behind the register bytes, format_reg() puts the register in front
  of it, and ->write() is called on map->work_buf as one buffer.

qca8k_bulk_read() takes reg = *(u16 *)reg_buf before it locks
anything, and the value it stores is parsed after it has unlocked;
qca8k_bulk_write() likewise takes the register and the value out of
work_buf before its lock. With .disable_locking nothing orders two
callers around those steps, so caller A can format its register,
caller B format its own over it, and A's callback then reads or
writes B's register; or A's value is overwritten in work_buf before A
parses it.

Two callers that can meet there without rtnl: phylink's resolve work,
which holds only phylink's own mutexes when it calls
qca8k_phylink_mac_link_up() -> qca8k_write(PORT_STATUS), and the LEDs,
e.g. activating the netdev trigger, which calls ->hw_control_get() ->
regmap_read() under the trigger's locks only. ethtool -S and the bridge
callbacks hold rtnl, but the two above do not.

On Fri, Nov 06, 2026 at 02:38:37PM +0100, Andrew Lunn wrote:
> Do any of these operations which don't take RTNL do an open coded
> read/modify/write? Does the regmap read/modify/write operations hold
> the regmap mutex over the entire operation?

No open-coded RMW that I found: the phylink callbacks do plain writes
(and regmap_set_bits/clear_bits on link down), the LEDs use
regmap_update_bits() or plain reads. Whether regmap_update_bits() holds
a lock over the whole operation depends on the path. With REGCACHE_NONE
every register is volatile, so it goes to qca8k_regmap_update_bits().
Over MDIO that holds the bus lock across the read and the write. Over
the management frames it does not: qca8k_regmap_update_bits_eth() is
qca8k_read_eth() followed by qca8k_write_eth(), each taking
mgmt_eth_data->mutex on its own, so two updates of the same register
can interleave between the read and the write and one loses its bits.
The LED control registers hold the rule bits of ports 0-3 and port 4
in one register, and the LED callbacks run without rtnl, so two LEDs
can meet there. With the map lock enabled, regmap_update_bits_base()
holds it around the whole update, which closes that one too.

To be clear about where this comes from: I found it reading the regmap
path, not from corrupted registers on a board, and I have not seen it
happen. If that changes the case for net-next versus a lighter fix, I'm
happy to rework the commit message, or the patch, whichever you prefer.

Stanislaw
