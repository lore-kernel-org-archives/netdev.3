Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C9345FFB7;
	Fri, 14 Aug 2026 11:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786705346; cv=none; b=Sj/QwN2XvC4+BJxEOA/QR1NdFtqAwSZuzBMF0bqevbje539pjoClYxNOWI8kwewiSVLf6s9wPUdKIXOABPje+CkBb5TQHaCDbhfbfd7eDKn3zEJo6XPFeQryCl0lhrOUFz5MSQwBX9M0vLL8OhNgVDZjOXJ0PVHOGf2Tmg1Z3CI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786705346; c=relaxed/simple;
	bh=LFOQjVIzE+eLbQNvpUYcR6LoE3R/CAlRm55BCbOeUPQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=JxLbeLAeD17tVztamSyYwPNqzhwUlf1X3NUzWEUXL9wiWejwabX220lyu2NSWcykuvBouU4NuzS68TWqG//XEFp9kKTHL+dAj8ftos9hve9UVvbM3ZM+EqdBT9p3ubYyxNpzG+69dUY6vX8JoDoTTJdrLoIbbqVfyUADtLuSovo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net; spf=pass smtp.mailfrom=marmottus.net; dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b=og9MtNoB; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marmottus.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marmottus.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marmottus.net header.i=@marmottus.net header.b="og9MtNoB"
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8E37E3EB9A;
	Fri, 14 Aug 2026 11:02:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marmottus.net;
	s=gm1; t=1786705330;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LFOQjVIzE+eLbQNvpUYcR6LoE3R/CAlRm55BCbOeUPQ=;
	b=og9MtNoB4rmNTaH595TNA8Ik63MP4CCDbNKrE/mX9C0qPCl0e5i4zVvOAbFVyzK5RTO8ge
	ZI1apYQ/NEyX0mxgkEYift0z6UGPNiNsWJEu20iXtH3FTS7IyfsJVuh9u9Z6PcB/85EB3P
	JSqh7sp241ahdHR05TXYALrpFa4RUxSboRQX468k2OykMJuTgEDQqofpUH6XM3StOQfbzD
	ncwqKLR+HTYOpW0ONHO0hvVfy0Ywh6OZDAiWu37tbrWJENXh+yfubzw8SC1w/gazUYB0me
	xync69EAOX7gfSQIZ9tyNjPjX9qYyYFHOfNZmLazBpXxvdzTvF/sd/wlRJ36Qg==
Date: Fri, 14 Aug 2026 13:02:07 +0200
From: Arthur Crepin Leblond <arthur@marmottus.net>
To: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
CC: Arnd Bergmann <arnd@arndb.de>, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_net-next_v5_3/3=5D_w5100=3A_detect_carrier_?=
 =?US-ASCII?Q?state_using_link_status_bit_and_optional_interrupt?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260813-wiznet-link-gpio-v5-3-ac8046f24413@marmottus.net>
References: <20260813-wiznet-link-gpio-v5-0-ac8046f24413@marmottus.net> <20260813-wiznet-link-gpio-v5-3-ac8046f24413@marmottus.net>
Message-ID: <806484F9-D124-45C9-8EF4-BA2722EB9F68@marmottus.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: arthur@marmottus.net
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: dmFkZTGX0ycYVW0XRSOzBY5CX70VzHxZfqvhLV9O6GvxX+njZXPqeiWPh0XdiTuA3sekQjmaDgnpGPbzOcLzJWf14pkm7Ux451+CLPQrpVtzQpwaSHzmBtFCeqVQWBz9GkiEpogWuaFIWuY8pKKUi1CgH5YdC+hzZMJifi+yOPOfBq9Ao08kZeBpkKnIVtAOqVWSimJ4g2JmJeKF7GohfMdlKDk1RoqB5QV6E0Hasd6fqC41M7y+SntCzq1giyi5/t/4A3Ie09APF7zosjR+WZk43q1+gLGuI8oAxSxMx/k20trXTcAzZDFrZD8yphCgDRlYxsFzybpoVrcyWj4aDp5NhoVCtyg6set95eG071X7nvS6rWYGbL3auwhjpJMzBnFmMuCqlrWUylDxOpydUXMM60U+i1P8ct8rD/ishYgoerC+EwdOmdZIg/DvWeskLFhgClLzoU5k2aNIFZgZOK09YvxGoJRuZukrITEk16mfPP12uwR9+Mcvj9IqFt9XYXso2wHJ3/Dla4iUYLecGnR2EPJk4VmWt6YxmpDn/HQRb7cT+8+cNBCw+vYlAw3FfLhJhfNNddXbzwwLy8uP8Ol6Mlu60ry3IhqveDICNDYQl9UqWUeDXBGROkyetbs3ofkszgbGlYn/WfPtMcUUYVpa4FY4oD4f2i5cwPB8bbhGKk/T+w

On 13 August 2026 10:58:16 CEST, Arthur Crepin Leblond <arthur@marmottus=2E=
net> wrote:
>Detect the link status on the w5500 using the Link Status bit from the
>PHY Configuration register (PHYCFGR)=2E
>
Ignore this patch, I went for some changes based on sashiko review but int=
roduced some extra issue when on w5500 but without the link irq set=2E
