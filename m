Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794591325;
	b=SSPASGl6mzVPMDb+JNIXuWTZU9LWwrY9ZF5KfGFvJVg1Bng8aNOnk373i5OY6LwI6jaU
	 HO22DI9ipzeCTl3z6+kh/3HwrMV1uyxJoNOLHhhxD8hNgRWPFD+hfXy4eX8lUjL2Kh9xm
	 MaY7BYwA17CSHzJOCQFcxVzjSzv6bd0nt2+UKSr2iHYiu7rI4y9Yl3Ijyf9ID/XVr0wOb
	 dDhm7Zgf3cjE0/FAkdU5wmoEFMijU5R3ZviA7oMe3razHW47gqyFqtHhaZM7TsSoBg+nC
	 yAq7Dz7eKLy1Iukqd/MHvkmcMzvsvbOWcExx3ytcoqtqAs5kOzLeqPhAE8OW4rbgJ2w==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794591325;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=jbq0EeLMJFolx1OncOUqeneC72MUep198Aa3EF0wRf4=;
	b=FqQrz1INOxUL//U91hqpL/SE8Dm4I+FvlnkEYdM0iMm3k9hToNoMlEnwh22coTpi5BjM
	 ngz5IXxuF6Nds1baIYXgNeaY1ewPHmj8mmyRmPPXwxHbEhEaxpfKumgpj9bsDkyqghSHx
	 3DiD10wjYoT9g7Ljl+8IevXB4apxtqyW3tiZFL2/JLwiYdWivhEyFMV7/1OFUOZ03axJe
	 iacqo3RV0tZQeaio/G5LyqZZR0MhF14hBXd2MDja/y71VWFDD9QZ5RH4WmvvBfYubWbf3
	 Oc01h70jQeJBKsV2IvJsS9SIFz2YeFfedr053RSqybi3CMFWJO0AAr5mpZHs3Gx/Pag==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="v/h6eiDo";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.52
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5795160776F9
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 17:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5795160776F9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=v/h6eiDo
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-c3f04e0e65fso310895966b.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:35:25 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794591324; cv=none;
        d=google.com; s=arc-20260327;
        b=S2qk54WDIEVDw64K+2wGU7auEFFiGmyXWmekFklEF7W/xqVQH4eL3EES5BdQS8AGSU
         VJjGCCav+pltFoBLZiWWfNNKI0GdewROGpuzNqqPIbd7N30ePYR3mMaAy8f54aNdGdbL
         edbGp0dUqNhp5BSGgfHwpxzyN5zmaB7xjjdFZjMt64rWpr5+b9JMURmJw0oEKRQNaJ2+
         xBYWRmGMAuQWZ1r9+yo1QfH1twk5zjbpmgOE/iL+Zaoc67zZVPBrHi2BJySgUTosnePj
         XchSM7zKhZGkrozU1IWWtFup/wJnnHYmuM3mLvpMmc1GfSFvxXsTCS5CSb6kbTsWlYWh
         YTsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jbq0EeLMJFolx1OncOUqeneC72MUep198Aa3EF0wRf4=;
        fh=I5H4/Vf5tC4aKpVfCWF0gcxRYrYsZR7c/k3aZKp3pB0=;
        b=f/Dzx4QJmGICgxJSWpDusE9Kq+8kVkxm0NTPtbcA+0AMCAf19BUY1cYMjj5RHuIRsH
         f/gbKUonjpuuU6xoSbowGU8X7wBoRn0BWBw8y8bR/FNx/9L9d1qnfQ87SRYIEDSPf1h0
         PCRFEDUFaHDg5o6BoH8MmMBs3lmlnA2wpnaFx0ZsTuR5APjHqHdRa0hr2HNIfqIHtfpn
         V6FvEkjFQEcwOkOK4SxOZ59nsWMiZYu7CClhcbxB3u8kXDnlAtT+PEeh/Ph7nEiw1IvL
         ZhW0+dTAHX/XQLz9yo7fZ8MYJB4z6m4clCAE9EEAy8+WsULGpRz5XIRA79FF7jRTZNM5
         6vLA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794591324; x=1795196124; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jbq0EeLMJFolx1OncOUqeneC72MUep198Aa3EF0wRf4=;
        b=v/h6eiDo1Sz/JjC33cCMKG30lIcuZrUyWPl29FhgUGZ7DoySo0nu8cdsAMG3cfQ1Md
         /W9aGiG7G1Tb7V4682z6GrMqjNsDawDvkc47PYi/YgbdLB2Fa4y9aOyzCvV1eHXkc+2c
         7jWx3WQnWk77/097lJgBcoX19rlASnCcEv/tcCRC0OqN1p7iimXTCffK+t2mAqqL9s1R
         EnasF27yqS3o0kOPM3gemggZcUzy5u7VD9UvtzEf+mH6L23n4rhMcAqmSB1/4bLwTp5W
         BWjt+wijQqLSuFyKNLSsiC1Ns2sML+xYt2piEO1cEFYtJjm4lp+xqM0OwBSNsulC8maO
         oUfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794591324; x=1795196124;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jbq0EeLMJFolx1OncOUqeneC72MUep198Aa3EF0wRf4=;
        b=JXRWyv8kc4F07eu7Nn3oqO6h2UoCBbgAcW3HhOOWYaXdH4b9INDnJ5/h1BjxEneftS
         /8x9ispHN4NjxrNl2y5MvLZv4giO+oFcX+6BLl7nLDUmRKep0zNHuQc/E2dGzuiFVbHv
         kvKZPXw8FH17yi2Sg/s8x8hAEWyn8A2QacNnMnXLIZYf6rE5s0Z2dcmTNdk2RoVWQjyH
         l2olKDq3g6AJTe6CoIBXJ56WhTUEGSvbhGn9J7ISM7ZlXU+QAUqWhdtotwlRFrwRggUD
         TFCfOsJWm7lraZKfQFBY+pk81qkT+w00gnGimPsA+a0Bjv0bkP1a8grTqT2JFy7XKnFT
         WD9w==
X-Gm-Message-State: APuU4Z8nRCfeE+rvgbJtrdQSri7jsmdgZUNJGlYUAnW6hQlCzx+FyVDf
	F7MtPzvUzKKtcDOMHr+ByxM3emw7WuRsVlNXeBrRSOwUoC8pUreo8StSqiGg0IjBCFsQs3rHVXW
	YERUJc0CRlfHEfxLGIlitCg7Q2B2lPvE=
X-Gm-Gg: AYBFou0gdhaSG2DLgvBqFMFTJ5X6SstfceKh2Qnn931LwysltJh1yEH5aLfVcAvU3Iw
	0H5NmC+SGyHGqvBjNV4uYULp5sl1WxN6zdSAYK6+TwjhJuqD/nX8A+PO+HFbVE0XNokPrj+Q0jw
	7yVdKstWnycUto9EQFSgo6ZWiv6OHaUoH6z7UxtFFwPNI1EISWiw1+LHDOCJDYQu5GqF8tZnMq6
	QunBQADsKPLwiP9qWpN+EooglYF12yKBcVIGZcvz8nk1kwnt4gF7cOdCiGfj3AearS3NBBGgFXI
	hOWJ6wPh4xqSqsNdxxsgXTgiuJfCiRQpetyGSxdFIA2bmyTPHYF4RVy8lzsDO/kKgJNTKEqiEii
	jRV664n4VtYyXvh/vYIqRvv/o5JmaEU3/qA7i0DaRmjH2DogIcWYMNcclxhPck4ZEGzhIl118UV
	w6wziRexJzm3oWOnrdquZ1fg==
X-Received: by 2002:a17:907:7296:b0:c40:aa04:18d5 with SMTP id
 a640c23a62f3a-c50963075ebmr332428566b.15.1794591323523; Fri, 13 Nov 2026
 09:35:23 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113132435.434615-1-alitariq45892@gmail.com>
In-Reply-To: <20261113132435.434615-1-alitariq45892@gmail.com>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Fri, 13 Nov 2026 22:35:12 +0500
X-Gm-Features: AclHuK_ygvNFFgMQPh62rnosaTlcWUXJwDufLBrg6ePU0sUvfJ5AaEhA0kGAL9M
Message-ID: <CADqcGB=SFQu1F9zasFC8L3Nm8B+dnPG8UUewL8QitFY7bFuriA@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] net: spacemit: Fix TX timeout work deadlock
 and RTNL in PM callbacks
To: Ali Tariq <alitariq45892@gmail.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Yixun Lan <dlan@kernel.org>, 
	Troy Mitchell <troy.mitchell@linux.spacemit.com>, Vivian Wang <wangruikang@iscas.ac.cn>, 
	Chukun Pan <amadeus@jmu.edu.cn>, Tomas Hlavacek <tmshlvck@gmail.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Maxime Chevallier <maxime.chevallier@bootlin.com>, 
	Vadim Fedorenko <vadim.fedorenko@linux.dev>, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, linux-kernel@vger.kernel.org, leitao@debian.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Reviewed-by: Muhammad Bilal <meatuni001@gmail.com>


On Fri, Nov 13, 2026 at 6:28=E2=80=AFPM Ali Tariq <alitariq45892@gmail.com>=
 wrote:
>
> This series fixes two locking problems in the SpacemiT K1 Ethernet
> driver.
>
> Patch 1 fixes the TX timeout work, which ends up waiting for itself
> through cancel_work_sync() in emac_down(), so every TX timeout leaves
> RTNL held forever.
>
> Patch 2 takes RTNL in emac_suspend() and emac_resume(), which fixes the
> "suspicious RCU usage" warning from phy_disconnect() on suspend. It
> depends on patch 1: suspend disables the TX timeout work before taking
> RTNL, so it never waits for the work while holding the lock.
>
> Tested on Orange Pi RV2 (SpacemiT K1) with a lockdep kernel: 12
> suspend/resume cycles without the warning. The board loses its network
> after about a dozen cycles with or without this series; that is a
> separate issue.
>
> Changes in v2:
> - New patch 1 to fix the TX timeout work deadlock (reported by Troy,
>   approach suggested by Vivian)
> - Patch 2: take RTNL before the netif_running() checks
> - Patch 2: drop Breno's Reviewed-by, since the patch changed
>
> v1: https://lore.kernel.org/netdev/20261105123441.2524171-1-alitariq45892=
@gmail.com/
>
> Ali Tariq (2):
>   net: spacemit: Fix TX timeout work deadlocking on itself
>   net: spacemit: Hold RTNL lock in emac_resume() and emac_suspend()
>
>  drivers/net/ethernet/spacemit/k1_emac.c | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> --
> 2.34.1
>
