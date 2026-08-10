Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C3D7416102
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 14:53:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373600; cv=none; b=LHVrPmVKjhtSNgEei/TAm/3aBUWGPZ75CXpYbRf4R1fXi712hjHUNWMFHEAHRczkpc0OBsMwov2mD9bH541d+IU+ohQKPxZrH35AHkcodr5rvt3NDG+ltdboMO7lZb4m8oEXUE70Lf0LKtkjUklzHQrtqPB+tBJu1I7Ml+eceaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373600; c=relaxed/simple;
	bh=puvTQrdNL+zeyLDbRryXqFnpgF6SeGht9ThigFsj+/w=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XChRSUURYdluveZU5ddNBogHixwXfNIuajw4RzKH0piPwYeE7EGfmPgmrqCHkQsXXlPGyr6aiT8gscj7zPOUmMdNWlXiG+WwNAb1CL5pS22NdyFYp8hpDA/+VnuTu58JnPll3kH70M2BHy9x5sqr1QRqrD9SmhwGEKXXRWbTsl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oChOaoNX; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oChOaoNX"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-381c51fde6bso2326641a91.2
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 07:53:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786373598; x=1786978398; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:date:subject:cc:to:from:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1FTEinRulpP7lLTXBQXg9MI8eot7c+5tWGtfBG7cU8g=;
        b=oChOaoNXEjHcqvsMihyx1ZrZhYStcRH505Hjo7iAZcM5Nd7bqe/SZIHMg21DLq1sOX
         yh5BCRHNL11052w/nlTZo/SniXLm7SviglHA3XaHZD0+CschBbfhJbTq+LivYB32mF7R
         tcUzZzPYMxKr+M1XiKPwd+WxfoNiKtlIzRGJ85F9ZUoixiedglUgXe1txA6377AXLoGP
         iDRe6y11yb01KlbdyEp5y3UpmAKUHmDs9e1wdhkTNf1Lw2PIX1ArZbeBGyG9zGIsWuGF
         AMXctJv/p5pkmGasOVAf46NGSgj84Vlj0UHJ/wRg92fNbOvb+TETJMAAbAVrBtr9OGuH
         NfQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786373598; x=1786978398;
        h=mime-version:content-transfer-encoding:content-type:references
         :in-reply-to:date:subject:cc:to:from:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1FTEinRulpP7lLTXBQXg9MI8eot7c+5tWGtfBG7cU8g=;
        b=M4s1JKa7MFKB1QThj0ovAIAxo+cTtlYCNkIMkfKsCysP+S72UDJjr3bOzARLQNAEpa
         N0fOMR3X7nPQQT33airI5qEJld0gWY9HxUsJUMKR/pLx0n3kRfoS7kuDPUsYh99ah7I2
         obh7iYrfOcVKfet4C47dB3NQiknCbxySquOZHYQjCPIK1vcXA44wQ80MdDIaoevfFqez
         uYH0Y6glpe1VwMWoxmL8J2NJlCK4NQmYwe60K7KUA1baTGQhM26wK+QJNsee49HuJsPu
         jAL46/8pGSsWp9/I9jrFNFY790MVLiYxFv5yn/+pKdbSjXrVLvQ5j64JenlB5LeBt/A9
         7R4Q==
X-Gm-Message-State: AOJu0YwN451UFZszJQieZZtqI3HwiW+dARcGAhnBi9fos3Czs9yQ4E2G
	+aEyq35vJK9wqf16wCRmLzE6ErgTi9UuT3oY+IRSpyARcUpqE0SBG/MJf5TYnk/V
X-Gm-Gg: AR+sD10fpQIrcTSbeVAWi/hKkgLxLmqVRdcYx5Kiah33QRZop19+CssRdWJFg+lixXJ
	by1AoisHyOz9sS9nuvyuRzCmFaH79qlENK4rsF6YGeRWcxFhmbYl9lWHaywcBR89Jet1bLD/H+I
	9mhLgw+nQIgWKLdqQT92FsSDtkdavOH9rvFgCKOvAj8+kVRsSWyQjudeVpmPTH+eb81pGfEXUTW
	PwGGNrGu2N2dvwsK0jzg5HLo6y01Heqk4iqnGoFqZ8ls5RHKkXAB2KxyXYFpvjeUwoITXeiwuT/
	Kvmu7VdSEFLZhUTtqLgvFireH0opcEojYfDAA5OAL69vUP3nP+wEbZflP3uWHu/QLgX+vMo0Tuq
	1899R7ITKtWMLLWOfzVe1At11rLOI0TOYdEW9tdEfAaxEJJ1IJYWpQQuyhLBWi+2N9fgar2yATM
	lkHib7RiR+m/QnVh0hvN2zAEcWahiuOx85y4S+KPDpVxW1fcozOHYRqg==
X-Received: by 2002:a17:90b:5845:b0:381:a766:efcc with SMTP id 98e67ed59e1d1-392824a9a40mr21744584a91.14.1786373597627;
        Mon, 10 Aug 2026 07:53:17 -0700 (PDT)
Received: from [127.0.1.1] ([47.253.114.73])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3925fd95c40sm12983263a91.8.2026.08.10.07.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:53:17 -0700 (PDT)
Message-ID: <6a79e5dd.e59e62a9.3bd15b.cd58@mx.google.com>
From: win847@gmail.com
To: Christian Marangi <ansuelsmth@gmail.com>
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v12 12/12] net: airoha: add phylink support
Date: Mon, 10 Aug 2026 22:53:13 +0800
In-Reply-To: <20260809203116.640271-13-ansuelsmth@gmail.com>
References: <20260809203116.640271-13-ansuelsmth@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 9 Aug 2026, Christian Marangi wrote:
> Subject: [PATCH net-next v12 12/12] net: airoha: add phylink support

Hi Christian,

Thanks for the series. I have a question about the error path in
`airoha_dev_open()` introduced in this patch, and a suggested cleanup.

In the new code:

    err = phylink_of_phy_connect(dev->phylink, netdev->dev.of_node, 0);
    if (err) {
        netdev_err(netdev, "could not attach PHY: %d\n", err);
        return err;
    }

    phylink_start(dev->phylink);

    netif_tx_start_all_queues(netdev);
    err = airoha_set_vip_for_gdm_port(dev, true);
    if (err)
        return err;

If `airoha_set_vip_for_gdm_port(dev, true)` fails after both
`phylink_of_phy_connect()` and `phylink_start()` have already run, we
return `err` directly without doing `phylink_stop()` or
`phylink_disconnect_phy()`. That leaves the phylink in a started /
PHY-connected state. On the next `ndo_open`, `phylink_of_phy_connect()`
will be called again and may fail because the PHY is already connected,
preventing the interface from ever coming back up again.

I understand `airoha_set_vip_for_gdm_port()` currently always returns 0
(based on v12), so today this is a dead path, but it is easy to make the
error handling correct and defensive so a future change to that helper
does not silently break reopen.

Suggested change: add an `err_phy_stop` error label and unwind phylink
before returning:

    netif_tx_start_all_queues(netdev);
    err = airoha_set_vip_for_gdm_port(dev, true);
    if (err)
        goto err_phy_stop;

    return 0;

err_phy_stop:
    netif_tx_stop_all_queues(netdev);
    phylink_stop(dev->phylink);
    phylink_disconnect_phy(dev->phylink);
    return err;

Would you be open to folding this in (or reordering so `phylink_start()`
runs after the VIP setup, leaving fewer error exits that need phylink
teardown)? Happy to write it up as a proper patch if useful.

Best regards,
Wayen
