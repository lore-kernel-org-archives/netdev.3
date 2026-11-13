Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794592167;
	b=JN+7VThmPLJvfaO4OB8VZ1+/T4ddBJCaVpqjV+uXBH8vI06QNJRS5x72YUkPisaogGHt
	 xjykSRrygLrjTznStOonbq2fVyjqZWND6okVBigopAe50d2h4ZslHPDL4E+RZanUD0mNi
	 LiPc1vlBlPnN4JLChqtb/L32A+sDJOGJoKKKLyLmNZdWi1cGm9rUK1c41zf65EUW4OTZt
	 Ie+qj6pC6jIit+Uea0dIrcN94F9ssxwCz/74eIe3MrcOjyuiMlrqbNrOiPLEeQca7Q7Y1
	 jY8cTfdiU2u0VmmECqrfPE44H4V2QWX7nmbKfT6Sewz67/Wmc56g9ylsQ916WQf/hFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592167;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=1qoAEFZuoRKNKj+7J8hCXBIt3RIFn5aoPyFdLTSqWQ4=;
	b=CUSVDN3Ui9Z0gYTijA1aATtx0uzk6IxYvJUSMszpVupHRyiT8a3QB1sHYADSuaxV/16C
	 BB+HYmFzwsl7yc1jECweQPT82BGSefzPQMyDfKXyOTbPmCiO7dLqLGUkfN/1Bjl5cCZ75
	 02dewBl0pKdiDpEjHPw1WdPoK+gwnbUVM0w8pHN3Tax5AckOw4T4xssBrjGW7Bia52E6Q
	 hzmIBw+GVRXnylEadkl9zBBtYm95sosvBHOjMWPz2bIeH09eZM/HaUVJ2Ge4ThyHioyPm
	 85jrgWXF/boB0lNoTLFY40hJVYzhZ/HZFWKWuVgJs+fL2/Vnww6N68yIW+mHtEEVroQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SU3em2n5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12A26079D5B
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 17:49:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E12A26079D5B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SU3em2n5
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c5067a2411bso241729666b.2
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:49:26 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794592165; cv=none;
        d=google.com; s=arc-20260327;
        b=CTDUD8aFf89nbRAe89sJFM7s0P4Pn4aQDLKQozMHkJiABPXpnxCElmM059CLCKa45U
         e0/l50L+/LAHpILUYDEdnm9t3XQq29+V1Jc1DVaM8qu6XbuinlUceu5epG4ROGBC3tkn
         GYDdWonbJJJgwA7j/Ay0+koIp/M2dJskcy1i0cqOiG09r/4NDiPN6bE17SmBp+1r+rOG
         bZL3OKczYJx0QnTqtteiOEok1uod0Jz3+C/UdJmfsamck+nU1anB2b29WbAOnSycCN8o
         dUXV2tCEUVq7nguawGbqClVK7lEjr4zgK5qiqzM22pLK6zTRFVCXN0lEn6bsERpT5kzx
         Maww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=1qoAEFZuoRKNKj+7J8hCXBIt3RIFn5aoPyFdLTSqWQ4=;
        fh=I5H4/Vf5tC4aKpVfCWF0gcxRYrYsZR7c/k3aZKp3pB0=;
        b=iJpxTxbbAT1rezfZD7vfPg9nrhFytV5ppjMw8BBV4mFnTFjmNmv2OC6/CjXz33rPol
         chMxIUAG3e510QvvNfPjaF1EI/Bc0NWiJvt29tulnJz4GdCX6VgQ8rDx6HBxgtsyq7gV
         x/dNHH/4VAIznKA/8j+aT3M0vUiS7MlT+U3KOB6GjwtsMtTFTLsB13Lr6yZo15yjLouB
         N0WtNSkS8+K3dkFUeNqSr2jqUJjLYnlldL3rLKWnJgpbc2hLSvdoriZcfk+JKiXSjVdn
         +tnqoIGJ5L6RtAhxCsCOg8nJba2xz9HoPC0qC/H/D8onYJDEC6trYZRNHQXp81gqTjun
         4r9g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794592165; x=1795196965; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1qoAEFZuoRKNKj+7J8hCXBIt3RIFn5aoPyFdLTSqWQ4=;
        b=SU3em2n5FzvbGtn5JN6OOJQc2zPRYQVpL1O2W57X89BWZPiFeqvVjlQGk4oyMCp2XJ
         MmIuIGWNCpaYdmVt9Z/v3AuZWvq8wBAa0tJ4uX1hqo5XoJhsZiGZnenGb9uSjnFLAp4l
         /Nj/pNHKV8BsOv8M9ldbCSBGtrlEe0lcyeTKPoFnEErwkCg2UeaSOTkWuxPZJqb6wexA
         NVR7cA3phbStjZOgbbRHF3KQ/HjTSuW9+wU/Kbmqs/LeSr4mbfqJib+SRzQoUxPTPMgw
         4gnY5JQFe8oKkd0gqAT3TaD+z5qdrFGhD1zm+N9pX0WzR8ScK8PHOERn9OrO39UUuRMa
         CoyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794592165; x=1795196965;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1qoAEFZuoRKNKj+7J8hCXBIt3RIFn5aoPyFdLTSqWQ4=;
        b=F+0+G8QsNRPFuxD/Dzst5limgTCfdbFJRU8Qn0n6FFV/IXDqDYwoTfMj1yy40cUcvW
         HtbjDgWCJno6JB9CtNnPA+I5pIgy8yT1BDpGK01Ti8ycrHyeVCgCYkHS/8hyt6xRnG7m
         qazGURJrvl4x/T9Jaqqwii0BXqPGFYNmNBqFzicc+uWh5oAS3c7oauSnU0InJExSJ1u2
         FQyIGCcgaappnk5WzmDu3K5GQxd++OP/BEwRJD3Sc5SkCspKSZZHmwCie0q6f8oU/0M5
         5kHH84IsGDJrdXpv7XREkoP58vyuk9rYjk21zg8+n8zrIrGzOv7+J3GWstLTm/NCGwXm
         O6HQ==
X-Gm-Message-State: APuU4Z9UjTOMb2WP6sd+wM8ODU61yZ/YZbWcQiTNWjc7lst/MRdNA+2K
	+U/aQEQ5REMYkO/FaklFaaKzlu3VSexi/hy/QXTNUOl+EV+ZtavGTXIMgmHL/XafT7nPkdTaG2w
	BusUp3Dhp0NxyQoNn70dagsY0YpgRL0Y=
X-Gm-Gg: AYBFou3jtJggykPyngxw8yyKLKbPA11l6OeCxzwb3qMkT/kpZ0zg8dctm9AbvSv/Tni
	VNfIlFrwaJqclbuPwa2pDnZj+j8UvzDrWxAy36cBEp5KR01Pz+hpZLiVp7M9DprtUPz04BoYNgE
	SUljIVFKwhOpTC9qkYwnN/zDw1hQP4cVF1Ezfywur6kmoGg7DWEzjfGVhGE4wyHQJsTm90kdS7+
	BICklTWy5rYG8hp8PPda1ELJX4pezMxnd8WlmolnoOZ2IlWBbA2hHjzDK2Sa/VpsOK76f5s3CNt
	S0cRykTu/qYGyYYA10eekEuoU6vH3wpJdX0p7CFEJtRK/eU2DHwjPeXnLe7M7XEtQ5CO/3monjO
	Fbt3w+jwJl7BuOZY4Lb4ZERsqmU2C3KpfufEyEdVncFI7S5FmGrWw93V14Iupe2suhIbHWkb8DQ
	cjEQXpO+T0IDU1IGtJioRxuw==
X-Received: by 2002:a17:907:ea8e:b0:c50:9439:bffe with SMTP id
 a640c23a62f3a-c509684d717mr313677166b.47.1794592165236; Fri, 13 Nov 2026
 09:49:25 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113132435.434615-1-alitariq45892@gmail.com> <20261113132435.434615-3-alitariq45892@gmail.com>
In-Reply-To: <20261113132435.434615-3-alitariq45892@gmail.com>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Fri, 13 Nov 2026 22:49:13 +0500
X-Gm-Features: AclHuK9vLFuFj8StJfQb0gQfm2zMdlEC8vjTlUvEUXwD7gdAHCOcMYM38gGZrFA
Message-ID: <CADqcGBmdLC9jaK4HSECeSO=DtyZ3t-aoaBRUYV2cEQRBPOwuow@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] net: spacemit: Hold RTNL lock in emac_resume()
 and emac_suspend()
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

Taking RTNL before the netif_running() checks is the important part
of v2, otherwise the check would race with a concurrent close.
Depends on patch 1, as noted.

Reviewed-by: Muhammad Bilal <meatuni001@gmail.com>

On Fri, Nov 13, 2026 at 6:28=E2=80=AFPM Ali Tariq <alitariq45892@gmail.com>=
 wrote:
>
> The emac_resume() calls the emac_open() and emac_suspend() calls
> emac_stop() functions directly without holding the lock through
> rtnl_lock(). These functions rely on phy_disconnect() which reads pointer
> with rtnl_dereference(). But since no lock is being held,
> rtnl_dereference throws a suspicious RCU usage on
> Orange Pi RV2 (SpacemiT K1) warning when lockdep is enabled.
>
> WARNING: suspicious RCU usage
> drivers/net/phy/phy_device.c:1831 suspicious rcu_dereference_protected() =
usage!
> Call Trace:
> phy_detach_internal+0x490/0x5f2
> phy_disconnect+0x90/0xc0
> emac_stop+0x114/0x626
> emac_suspend+0xac/0x126
> platform_pm_suspend+0x72/0xe4
>
> Take RTNL in emac_suspend() and emac_resume() before the netif_running()
> checks, so the interface can't be opened or closed between the check and
> emac_stop() or emac_open().
>
> Found by CI suspend tests on Orange Pi RV2 (SpacemiT K1). Tested on the
> same board with lockdep enabled: 12 suspend/resume cycles without the
> warning, and kselftest with no new failures.
>
> Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
> Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
> ---
> Changes in v2:
> - Moved the rtnl_lock() before the 'running' flag check
> Warning Log: https://kernelci.cloud-v.co/scheduler/job/549#L2168
> Fixed Log: https://kernelci.cloud-v.co/scheduler/job/589
> ---
>  drivers/net/ethernet/spacemit/k1_emac.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethern=
et/spacemit/k1_emac.c
> index 51edc95f54c8..d07d8a1aa5ee 100644
> --- a/drivers/net/ethernet/spacemit/k1_emac.c
> +++ b/drivers/net/ethernet/spacemit/k1_emac.c
> @@ -2031,11 +2031,16 @@ static int emac_resume(struct device *dev)
>                 dev_err(dev, "Failed to enable bus clock: %d\n", ret);
>                 return ret;
>         }
> +       rtnl_lock();
>
> -       if (!netif_running(ndev))
> +       if (!netif_running(ndev)) {
> +               rtnl_unlock();
>                 return 0;
> +       }
>
>         ret =3D emac_open(ndev);
> +       rtnl_unlock();
> +
>         if (ret) {
>                 clk_disable_unprepare(priv->bus_clk);
>                 return ret;
> @@ -2055,12 +2060,16 @@ static int emac_suspend(struct device *dev)
>
>         disable_work_sync(&priv->tx_timeout_task);
>
> +       rtnl_lock();
> +
>         if (!ndev || !netif_running(ndev)) {
> +               rtnl_unlock();
>                 clk_disable_unprepare(priv->bus_clk);
>                 return 0;
>         }
>
>         emac_stop(ndev);
> +       rtnl_unlock();
>
>         clk_disable_unprepare(priv->bus_clk);
>         netif_device_detach(ndev);
> --
> 2.34.1
>
