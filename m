Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794592125;
	b=MeEzk3srWuhhJ2LRWA/MZq0Vir6D0de7V17a6OSgi4P9jgqyNvYBGcDEEA22k5cZor0M
	 MohN6EsR/AuYYZes7qSg69RaEdAcJAYgHbfFUR3MxF5Z2NpjmZ+9vKu+5o9o3btccq5Mv
	 Nod15gexb1V9TefsmwlobALn+9aaSzTNSnlMeTIovSOJMgsxc0Ww5rhEkgRKrD48I8JrW
	 S0dAIoDiTjyCpySxsvgX9DXkOerako/81mnGHR5UEkYuQTJYOk93yPSbgbCCzDmzliZWo
	 4D2WgFXbfEQWkiMGdgVPcETaNRtzGFxpPvsDjoI0uJ6HjtJ9WWoqoo+rXeGLSYZ9ehw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794592125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=oNynPIYr0dE3TxyMaeHySnLJJrKQN/vNpl2l1SdArA4=;
	b=MmTDS0pU2IMlPXb0GRlk7PPQY5AUMAK8xTTA9KB4ugJcvPtVOmAqJAqhqHB6Y8n8XBS2
	 XKd/Rke7vTuxkwpzaGKdFabpvtJxLhPVJC/uRLK61LxT9iwo6m/4r9b7n0Vy6JWvAXPCQ
	 3EMEFLmFUqJuFfwzgmWG0zwq/d3KX/xqbLKozjXIhpEl27QHXJsO+SsS+mAtZgWZPLzp+
	 gSgCAcKlP6ycjW8Rhyh/kRG6zVt9L5FwQtbk3wRMM77Yb/XYGlbZKpynHRhzOuv9U+ict
	 Ifil4qUBQ6qtoJmdQqASlJ6ICN0SpGw31kMY9s0x+NvgNJoHpHAMZ4uxNPHNSl/lV/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="krnMCu/p";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.46
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1EDB606EDB9
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 17:48:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C1EDB606EDB9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=krnMCu/p
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-c4d5b2db4bbso326945466b.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 09:48:44 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794592123; cv=none;
        d=google.com; s=arc-20260327;
        b=MeJ207RG4vBNWyfYQJC4JMZ793ZXEcKCtnVPX/gWzYY114sA5jCeREfKalWpQ4+K56
         L/8MRVOsXRwup9tNEfxKJoJqIaVvyp5KSq2/6d6iAlxuxB6sG8bEL5KFiYNFYltgIu5Y
         VKkJUQO3UPVYZs1WZYi42LMUgJPkO2+2QjvrJ2xwfuKx8XvEmk5aTHjD38vc6Xdk0DMu
         7oR/lvVcOKHJ9x8h6zpIseZNhQvyA02mP4JNCbpX5Qs4HhTDN6ixaoj5SjfKnZkIo+6G
         Wx2ZGrUdpKc9inhMoHQ3hqWsSXCFvydf1ZE2A5e5k7kxoOU94rOmSfIwfVePg8brtIdt
         t1Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=oNynPIYr0dE3TxyMaeHySnLJJrKQN/vNpl2l1SdArA4=;
        fh=I5H4/Vf5tC4aKpVfCWF0gcxRYrYsZR7c/k3aZKp3pB0=;
        b=QxSwJSX9QVBHnGXbK0/SU+3cjwNYezpwKFpOB/F2iTicwJTaYizMb/hyXsKvHkRwCI
         IvxBNZ5W7B/10l3ZhSYCVhbcxF+ho9utX3oh5YziP6LmA/MMN+I95GAFxCzXutzX0cAH
         9W6+jivRd0mS1080YFm0Amy4XlsiOBUEYVS6GOZ9ufDd8BvaylndavdpI9uFnPXxqas+
         +bgk9n4wXw8X9bNJ2dNdIwwFYZkFg0Omgu0qamWQJ0yuA7em6bpvLvWz2h1wuscoO+GX
         AMCNHEL/UTf4852iELfLb+WCIOMJypuVnmdRq9QJLBr4ODJ+ZDED6waIJpr91mGrS4Nq
         x0uQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794592123; x=1795196923; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=oNynPIYr0dE3TxyMaeHySnLJJrKQN/vNpl2l1SdArA4=;
        b=krnMCu/pIv+2BNZCz9Kl2T6N0n2YkNCTDfv1sQRh+qPxk08eOSYoB9xrXw7PDundYc
         CIAdiP8zGwF/scWrgUDiUC4r2zOVjFb69USUho+AzheC9DFHlZHI8KZR6NIvJOxVC9NS
         Y7nOxv1v9GrdoiyKHNeK1SOGBlbr7CcuRs/9KPXsd+qrryJUhQ3E5HNFpt6mef0nK2Dc
         Ytf5U13ymQQ7nqndhlGbpASEql4lc4gCtbFKUQnbK1DvFnwGqArP+MLLathsEKak7cEr
         RPzWjd6muhfPQXpyek7l9c79zX0geHfuJZ0TNXfuhkxPLqebXRiyOK2UNQjIGEdTnd8s
         NDuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794592123; x=1795196923;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oNynPIYr0dE3TxyMaeHySnLJJrKQN/vNpl2l1SdArA4=;
        b=ZD+26uzOnME03AmPG1uw7ktBLAF6YdpZeSXNqQL7RKiIyY3E0QvMJCdB00vRFgAyVL
         HjwB435C6TVHx5jTjEPwf9HvTXmAGJm98BLKLF1RFqFBlxK1DKITILkbkV7VbshLhdnV
         yMB7sY9/IKCesNRhiKeDIceJPMTASzOy8qP/20WNy8j2hShDEHm8KcXpsKgVXTrIQpfb
         VqgnpijFPZJndojHtU8DgnVBYQFyeKcM8Pcxf/2cpkXtoPvCHLWKM28BWOdz3sgMN9Q2
         Rj7NwtilbWyESBrFkUzGxQ8SXcb+w4qm5JlFIy48s31wXWPYwhBDQbJFDn6aQrrO45ZX
         kSYQ==
X-Gm-Message-State: APuU4Z+BRpZPDvMvo51P8aIm6lXlYCRUKjDC3DgwvftETdXg9cGZ1N3+
	iL6E1f0wXRjanUHdhznAo/QgIhKOSHY4CNrMh7r8dUtb4Ae0c965tiqRGJyz7lwKez5hRobgfgA
	6v2a+A0m/O4TsHtEr9rCqMeHs9Yl5ofQ=
X-Gm-Gg: AYBFou2iehVPCNeMKbQIx1QsO4JhA+lLZLzyK28mH0HtdB7uMsbA7vjDrymNl6rwcot
	4OOLDsz2AyjEPwX+KARjcVaMFjOEr61Ls1EMqzt6IJVlvZG4/V0+TVj06jsc2Nv5SEl0eHROSVb
	GHI14WhRgGemOK2HRr+wpiIBJ1c5pP1SchwPHJZLbvVfpC/6pbrb5Pzh5cDNayJW8K6Qkroyftk
	CBnJOAfv6DvWklvhuExcq03oiQz0ldP4JRZx67Ilhf6VJMzueNYg98bb3e2QNc37qaYij3FlVSk
	l73pm7JK4WPbnTdFBE6REfiRx/MDhkMiYFJ7R+kHrVqrxx4H0BKzFoEmguHfnLkB7RESb9HK6Qx
	bE0iwmUuRY9YVU1d/sE7uYCqFlBkPqC2PgZrz4Ma9CW9DlLo7sT2WUAvCZZa6JXZ7MPBi9HizaE
	gAqMcfuFQol4TKUJn7jBTNAg==
X-Received: by 2002:a17:907:d01:b0:c2d:d4dd:8d0 with SMTP id
 a640c23a62f3a-c507c3c72b7mr625099266b.16.1794592123102; Fri, 13 Nov 2026
 09:48:43 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261113132435.434615-1-alitariq45892@gmail.com> <20261113132435.434615-2-alitariq45892@gmail.com>
In-Reply-To: <20261113132435.434615-2-alitariq45892@gmail.com>
From: Muhammad Bilal <meatuni001@gmail.com>
Date: Fri, 13 Nov 2026 22:48:29 +0500
X-Gm-Features: AclHuK8Pe1ThNtetEqiSLcWfitdjibDvU0d4btaBsFE8aUM2ODczptrv0nOcYxs
Message-ID: <CADqcGBk==F5ncuWFCec5NKfgqpO1O2sSWVeHY1h-F9MjdbouQQ@mail.gmail.com>
Subject: Re: [PATCH net v2 1/2] net: spacemit: Fix TX timeout work deadlocking
 on itself
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

Traced the paths: the work and every emac_stop() caller serialize on
RTNL, the stale-work case is covered by the !netif_running() check,
and disable_work_sync() before rtnl_lock() in suspend avoids waiting
on the work while holding the lock. Looks correct to me.

Nit: please add "Cc: stable@vger.kernel.org", the Fixes: commit is
already released.

Reviewed-by: Muhammad Bilal <meatuni001@gmail.com>

On Fri, Nov 13, 2026 at 6:28=E2=80=AFPM Ali Tariq <alitariq45892@gmail.com>=
 wrote:
>
> emac_tx_timeout_task() takes RTNL and calls dev_close(), which ends up
> waiting for the work itself. The function call hierarchy is as follows
>
> emac_tx_timeout_task()
>     dev_close()
>       emac_stop()
>         emac_down()
>           cancel_work_sync(&priv->tx_timeout_task)
>
> The work never finishes and keeps RTNL held, so after a TX timeout
> everything that needs RTNL hangs.
>
> Remove cancel_work_sync() from emac_down(). Disable the work in
> emac_suspend() instead, and enable it again in emac_resume(). emac_remove=
()
> runs before the devm-managed unregister_netdev(), so use
> disable_work_sync() there to stop the work from being queued again.
>
> Found by code inspection. Not reproduced on hardware. Tested on Orange
> Pi RV2 (SpacemiT K1) with suspend/resume cycles and kselftest, with
> lockdep enabled.
>
> Fixes: bfec6d7f2001 ("net: spacemit: Add K1 Ethernet MAC")
> Reported-by: Troy Mitchell <troy.mitchell@linux.spacemit.com>
> Closes: https://lore.kernel.org/all/DMO74K2MG3D7.15UUOU1O66K6N@linux.spac=
emit.com/
> Suggested-by: Vivian Wang <wangruikang@iscas.ac.cn>
> Signed-off-by: Ali Tariq <alitariq45892@gmail.com>
> ---
>  drivers/net/ethernet/spacemit/k1_emac.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/ethernet/spacemit/k1_emac.c b/drivers/net/ethern=
et/spacemit/k1_emac.c
> index 71a80838bffd..51edc95f54c8 100644
> --- a/drivers/net/ethernet/spacemit/k1_emac.c
> +++ b/drivers/net/ethernet/spacemit/k1_emac.c
> @@ -1732,7 +1732,6 @@ static int emac_down(struct emac_priv *priv)
>         napi_disable(&priv->napi);
>
>         timer_delete_sync(&priv->txtimer);
> -       cancel_work_sync(&priv->tx_timeout_task);
>
>         timer_delete_sync(&priv->stats_timer);
>
> @@ -2010,8 +2009,9 @@ static void emac_remove(struct platform_device *pde=
v)
>  {
>         struct emac_priv *priv =3D platform_get_drvdata(pdev);
>
> +       disable_work_sync(&priv->tx_timeout_task);
> +
>         timer_shutdown_sync(&priv->txtimer);
> -       cancel_work_sync(&priv->tx_timeout_task);
>
>         timer_shutdown_sync(&priv->stats_timer);
>
> @@ -2024,6 +2024,8 @@ static int emac_resume(struct device *dev)
>         struct net_device *ndev =3D priv->ndev;
>         int ret;
>
> +       enable_work(&priv->tx_timeout_task);
> +
>         ret =3D clk_prepare_enable(priv->bus_clk);
>         if (ret < 0) {
>                 dev_err(dev, "Failed to enable bus clock: %d\n", ret);
> @@ -2051,6 +2053,8 @@ static int emac_suspend(struct device *dev)
>         struct emac_priv *priv =3D dev_get_drvdata(dev);
>         struct net_device *ndev =3D priv->ndev;
>
> +       disable_work_sync(&priv->tx_timeout_task);
> +
>         if (!ndev || !netif_running(ndev)) {
>                 clk_disable_unprepare(priv->bus_clk);
>                 return 0;
> --
> 2.34.1
>
