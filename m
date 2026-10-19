Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792431434;
	b=bNpD6LAdJkmO76jt7FpstH6EO96JnsDSwzOmHvMQwTk0bBXDOOOJGTMJbU1XKpj37x+x
	 uhudbuuPBWeJUMY838H5KHD+ITsDmEsDzEMQVdvMdIrkean9Qe49pZ4MrpCT6O3J4yuVE
	 xW9WElxwKJpO6OJzaL03h0G5SIEkKpr4QNbNDswY6o20rLScxUUxNW2O5BdAloeZNzaG6
	 ey6ayt/eP+5cUHSP8cOcYKoFtHA3QzC8b6gWeytJJoJVOKQwTD6EWONiZLgmIbaZD69SV
	 uqBJjDENN17qh2Dsw/ZEEgUMOR1J23bSfUVlHetFv/2DO26Oibb+AzedMzuEPukuE9Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792431434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=X7SfKpkZEyou8apB+p/B2J6UWfJlZHexvBzvKG5arNU=;
	b=qHsnaOWQEXC9mmtgCvriFTT9VI2f4i2MF0fjy/sDcvJ/KNoYEH1WZgjlfDSqFlf0aDIV
	 fmFfQA+TwzAyLUwg6T++t9YMtUvIYaODj8Vve9d3VlU+6xX7lhzVesFk7S2KkV8SWnK43
	 AIbu64Xti9eDkhrwt+Hb5OkLMY3OxQiqUXQXEFx5Jdb9JfSz5o4QXl3WwuVX+baLd3NOL
	 90FWGPvBNf0VuaLGzE1GaEjUigonE14suEI3SOlRzdux8goTv3g0PXarruXFNIOh1/I8d
	 ED2gBvvyiza6kG+tkZ+0Km1Vls3zbOMrAuTfG0dAHBi/8jyxbQjvMuvm4c9MeTvORnA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W3e+jzOX;
	arc=none smtp.remote-ip=209.85.218.44
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C146606A31B
	for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 17:37:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5C146606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=W3e+jzOX
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-c20ce3c118aso438570866b.0
        for <netdev@vger.kernel.org>; Mon, 19 Oct 2026 10:37:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792431433; x=1793036233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=X7SfKpkZEyou8apB+p/B2J6UWfJlZHexvBzvKG5arNU=;
        b=W3e+jzOXCY7H2t+R8eQRvZ6ycEKAxC/TG3tmAYpTO1zl3QcoJV9GXMq/+dgDTS0cCu
         0p9osOW/GqfTTSebAtPhou3iHW2o1P8Qur/06Aau/yawerGMKkTij5/gxlXD9Z0oxHe2
         JNDwh327ZjHw7DCVvQXBMEYOkaAsuzRX4FMUA4J9kL0T45i4/K1F/Ke1ROoSE4hruE5x
         TkCuOb5/VXUD5R872BPBdYlabV5+MJr6q/2n8EmqwcJPejJNUiEyFPeiRNc6A6wT0rOD
         Yo4dPBqsj3uLT70FGfih5zO8DJCZ4QAOu74Dkok5FXb8iw8DHcwTVa3sLbHhoQt2MEPj
         tr8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792431433; x=1793036233;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=X7SfKpkZEyou8apB+p/B2J6UWfJlZHexvBzvKG5arNU=;
        b=xHagH4vO9j5UISDzrC+jNi4rACDAlg0E98ZXql3So6ViBUwFFNJ2EI0g/KwMolWJpm
         8nSpt87xOIpMYs1T3inNWFZe6H541p9ao4sJE7a8NF9UwEHn9OtQPlL85QOIR5gqRXYT
         V8MzE/s6+50BvrVlkLRLIrOOjzg5sxoAnRvkZM+qz+SLlysvNRBO396wNMOO3gA+TZfi
         MBqpoA68hqt1d+VCmEnCJOvaGhFfZVT/qVPqRmuWSDhtlzgnH26CduyF8xLa+36wpMja
         e1zKyOjRcNfuPNycoOr24b7BlWjkecwTT7TZQGTLtlyEk6MdxYYK19T5bqdueMvXurkW
         gEfQ==
X-Gm-Message-State: AFq9FYK+iTBRWKBZBJDWt/jP/1JPmf4gPJZWxjOMKgs5cx6Uy/S+qvZh
	YwZcrVz/k6DdcHlGXNjikhDTE7AhW12hKCj86cvLp9JYgBnrDI8bGgTu
X-Gm-Gg: AYBFou1Rj2LR1KnlOE3862FWR2kjCWITbq39ugICRCl1DR9mTImKbiWTvRf7Iq13tLN
	8hHmTfK9RB51+0kcBbDDW+m/Ofa8Dgu25q527KlkIeB5k7712QM1AOSgsl+rmJDTYnUuvnp+FPd
	BGkH+pUTZTplSASshibTElx4zZsX7M+YfZ7eLeUwk7fGcKQza87V7xSWJ6pFFjC4qreynsjRrr6
	VEgHx3lQJ6JoJfLibXZtQVsaEjcprfLwMl7fXtCbtyZxRrSFAB8NBScQhjm1bJTJr4HaIHP1IEN
	R/1PbfUn0SYCKkN+w7Gm/mwEcblnbMM3N5oPm9x4CzNe3UWk/vgf9CPmeMw5sQV1wGV9qh7tM0C
	UZ1YMPoTCVxyE40lhJzJjMqgWZ7lTUHPGMYFDyP43lTv2Kg1iW77kR9gz2l3qJtMwwUcjFbuLE9
	gjz0e2o2nIQyPLKWdLT4XB9A+NaADcTiGFVf4jrlmehK9AIz3KMHjoI/LwCyIK3eh03eSK55iyr
	xWNK0TsEPwTnVLh9SmR6jm8/OJF2MUThEpeS7UMWCNHuEiw4TT/8Uy5ARoPk65Yu0+94iFBY9UU
	1lQ=
X-Received: by 2002:a17:907:a317:b0:c3f:2:6faa with SMTP id a640c23a62f3a-c401e136d98mr974748666b.1.1792431432318;
        Mon, 19 Oct 2026 10:37:12 -0700 (PDT)
Received: from CCM-PC (94-255-221-162.cust.bredband2.com. [94.255.221.162])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1dacb6sm4299381a12.28.2026.10.19.10.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 10:37:11 -0700 (PDT)
From: Yongzhao Chen <yongzhao.derek@gmail.com>
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org,
	Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Russell King <linux@armlinux.org.uk>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	linux-kernel@vger.kernel.org,
	Ziyang Huang <hzyitc@outlook.com>
Subject: Re: [PATCH net v5] net: dsa: qca8k: preserve port state across MTU changes
Date: Mon, 19 Oct 2026 19:37:06 +0200
Message-ID: <20261019173706.198461-1-yongzhao.derek@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.5
In-Reply-To: <179240775070.3135.2434822808609533404@kernel.org>
References: <20261015104550.43169-1-yongzhao.derek@gmail.com> <179240775070.3135.2434822808609533404@kernel.org>
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

On Mon, 19 Oct 2026 11:02:30 +0000 netdev-bot+sashiko@kernel.org wrote:
> That path only reverts the conduit MTU. Does the switch-global
> MAX_FRAME_SIZE register then keep the new value, while DSA and the
> conduit keep the old MTU? Nothing seems to write the old frame size
> back.

Yes. With v5, a failed restore after a successful frame-size write
leaves the new frame size in the switch while DSA keeps the old MTU.
On a fixed-link CPU port the same failure can keep the MAC off until
a link flap or reboot.

> Two options: keep returning success once MAX_FRAME_SIZE has been
> written, or roll MAX_FRAME_SIZE back on failure. Either way, should a
> failed restore stop being treated as the saved state on later calls?

v6 takes the first option: it returns the result of the frame-size
write, and a later restore failure no longer replaces it. A failed
PORT_STATUS write now keeps its target and is retried every second
from delayed work, so a fixed-link port does not depend on another
mac_link_up(). Newer port decisions replace the pending bits. The
next MTU change first recovers pending writes on ports 0 and 6 and
returns an error if that fails, so a failed restore is not taken as
the saved state.

A userspace harness that compiles the driver functions and
dsa_user_change_mtu() now covers both cases, and v5 fails it. v6 has
not been tested on hardware. I will send it separately.

Thanks,
Yongzhao Chen

pw-bot: cr
