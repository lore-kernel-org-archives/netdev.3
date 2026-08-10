Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B690941D650
	for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 14:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786373886; cv=none; b=LWwy/3xEWSprlonn9aXeh4AodAfGQDBBDnChUZJFpBdj3gC5UhTsISS8kTlYgfKyNnhYcmfdqTgBzjR4QZJRqNwCTtrA9LpBt5uGELwSt8akPk3I1vb9yDUJEUIWvnjZGnDUvLjBnxNjKB8NoS1WhkhBJxcWkcVlPKBFk75k2yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786373886; c=relaxed/simple;
	bh=4cHvPrven/t3rFp+sVGIdSivHgadia9WTgjF+LFzIUo=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FoZSTONAAu/nyo78bwWxBpp55b0GRs4K2KtJSTVKXR54cMQcLrIbA/9h8YEpLkKc37p0dc51kLfXUDOzOhkt91no8VSlkgtkhctsu8p6vm+H058dasnM13kcV1+jAV2rLn/i+XFdrS4wjtAGUOX688SMTlDBE/AHIapHfFqnT50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DuUGfzrn; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DuUGfzrn"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-47f96c5b722so1109210f8f.0
        for <netdev@vger.kernel.org>; Mon, 10 Aug 2026 07:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786373883; x=1786978683; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=w/Gl87v4Znt+XuHHm3+kxa4WFKqWvFzpNTkn7r5FQfI=;
        b=DuUGfzrnmb9SpA+mGoNTu5VRxxTZpTLRiJrrgV1IzjQ3aoGkFTGVAE6xBO7LEKnS70
         PU1S3HUcVmI46HspT/t4XDcG9RXpuOP36q5tcT705N3FvL8jCbXxdqf51Blhz0nr44bh
         6ZovEfhesUzkH+3MDG2NVpYQUryBnSGuwLX1LtFNGqtyX+00sY9aGDde25DIdaHmMSAG
         tQdsHVqVhvEgCatOK8w211N2AfFk3aGJat3QzsuC+XhI1lptno67VHiWOEZYjB+vckK7
         7LMVF3LiA9Zsp1Afxn95ZynWxkhqUvKZc65873aXdjPArnoLLB/WKnQLJvPJh9PFho2M
         Z/sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786373883; x=1786978683;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:subject:cc:to:from:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w/Gl87v4Znt+XuHHm3+kxa4WFKqWvFzpNTkn7r5FQfI=;
        b=VNvgQrO0LlAqykRe2YQf3fMOXD1HxWbMg6L8ekDIAz7VVmTFvVGxg+nS7g/7EmwozH
         67O8cAxTtaghK04Ub1bTxAGkx8MwWMSSa2TTnTEKQDut7zF+A1Wkce0rWgVLJ3op6JfH
         2pRQt4GFPM6a4H77W7yB+hEuF1j78Ig4VCf70PhpQX4Aii7w6eND68ZJEjfsl4kk+6aa
         v3cspRSSFBqXHo0E6CvrYhLQ9DeCJGFXAlBsw9399ydgsQpm5Wz0Arx1arjIomCnaBCi
         eXKzu9mMtSWEmzR/+APZyR0BQbW1COfOphybPipHf5u539amDYsMKqja9QnJdy7tiHHP
         gc1w==
X-Gm-Message-State: AOJu0YyUECF/cfOt0Xq4BEIpgAUURL7hxXD3+6Hitq6PJYZY7b3bJljF
	u2WbZ29i4zm8guJhxCGnSU2/fidpK+dsQt6IimQKTv02w1advLmiCoBbdhO8s8mC
X-Gm-Gg: AR+sD10CYYjzFlGIEjF59uxZ+s7AxmbSulC/3c4hIYpn4tEs/WfmtTpD9rhwFWm8AeN
	0Teucm/JWGKg3aWbU9a0IZdtgkhSwZIlxAEx/pFXWWKBE/saEvKC0voz63aeBl5Zm7CTe418Xhp
	Ne5QDxU0Nzk6rjm9tuZbbmJczBCtNu7BLhMqbgYM42z7Z5tgBzwgLaznx/XfG4uJJHBfc2wCiii
	O30k7xqBrpkvhEoeKR7OqhPZxjx8nd0bsBrYj8r6XdQp7+yyJcCqQa/+1bFcbMs4CAJwheHjeiE
	Pxoy1f1FoH3AKpQWQVxvAKBV+OBRDv28UVs2UXbBQxUlWRp9ne9Qocy4ZMQ8Wo0jdU0Rfu+HFkq
	2MldM1xJ1Q1Z/fQxjmR1pIG/8lm1p5n2ctzHwrL6jVEj6TWMovm7QzGwgbKRrjRcci8VI6Xy2QR
	F14pQum2cLEi2x/KFiYafj+lEbeF4j/Ds2PZ0hRr85z94wASop7GxpQZTP4r/Vco6EYZ+Rl3nLY
	MN39KxORMsWWOmOYrEqWsJI+hoqxJo=
X-Received: by 2002:a5d:6f13:0:b0:47f:ecbb:5a2e with SMTP id ffacd0b85a97d-4814564fc0emr4540457f8f.28.1786373882870;
        Mon, 10 Aug 2026 07:58:02 -0700 (PDT)
Received: from Ansuel-XPS. (host-87-20-3-207.retail.telecomitalia.it. [87.20.3.207])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-480021e8d50sm34620638f8f.24.2026.08.10.07.58.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Aug 2026 07:58:02 -0700 (PDT)
Message-ID: <6a79e6fa.332d3c56.21a33c.bff8@mx.google.com>
X-Google-Original-Message-ID: <annm9xX93WnLqjOk@Ansuel-XPS.>
Date: Mon, 10 Aug 2026 16:57:59 +0200
From: Christian Marangi <ansuelsmth@gmail.com>
To: win847@gmail.com
Cc: netdev@vger.kernel.org
Subject: Re: [PATCH net-next v12 12/12] net: airoha: add phylink support
References: <20260809203116.640271-13-ansuelsmth@gmail.com>
 <6a79e5dd.e59e62a9.3bd15b.cd58@mx.google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6a79e5dd.e59e62a9.3bd15b.cd58@mx.google.com>

On Mon, Aug 10, 2026 at 10:53:13PM +0800, win847@gmail.com wrote:
> On Sun, 9 Aug 2026, Christian Marangi wrote:
> > Subject: [PATCH net-next v12 12/12] net: airoha: add phylink support
> 
> Hi Christian,
> 
> Thanks for the series. I have a question about the error path in
> `airoha_dev_open()` introduced in this patch, and a suggested cleanup.
> 
> In the new code:
> 
>     err = phylink_of_phy_connect(dev->phylink, netdev->dev.of_node, 0);
>     if (err) {
>         netdev_err(netdev, "could not attach PHY: %d\n", err);
>         return err;
>     }
> 
>     phylink_start(dev->phylink);
> 
>     netif_tx_start_all_queues(netdev);
>     err = airoha_set_vip_for_gdm_port(dev, true);
>     if (err)
>         return err;
> 
> If `airoha_set_vip_for_gdm_port(dev, true)` fails after both
> `phylink_of_phy_connect()` and `phylink_start()` have already run, we
> return `err` directly without doing `phylink_stop()` or
> `phylink_disconnect_phy()`. That leaves the phylink in a started /
> PHY-connected state. On the next `ndo_open`, `phylink_of_phy_connect()`
> will be called again and may fail because the PHY is already connected,
> preventing the interface from ever coming back up again.
> 
> I understand `airoha_set_vip_for_gdm_port()` currently always returns 0
> (based on v12), so today this is a dead path, but it is easy to make the
> error handling correct and defensive so a future change to that helper
> does not silently break reopen.
> 
> Suggested change: add an `err_phy_stop` error label and unwind phylink
> before returning:
> 
>     netif_tx_start_all_queues(netdev);
>     err = airoha_set_vip_for_gdm_port(dev, true);
>     if (err)
>         goto err_phy_stop;
> 
>     return 0;
> 
> err_phy_stop:
>     netif_tx_stop_all_queues(netdev);
>     phylink_stop(dev->phylink);
>     phylink_disconnect_phy(dev->phylink);
>     return err;
> 
> Would you be open to folding this in (or reordering so `phylink_start()`
> runs after the VIP setup, leaving fewer error exits that need phylink
> teardown)? Happy to write it up as a proper patch if useful.
> 

If you are ok, I can integrate the change in the next revision.

-- 
	Ansuel
