Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B3614F7995
	for <netdev@vger.kernel.org>; Tue,  8 Sep 2026 10:13:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788862439; cv=pass; b=E2mjG2p/1ueVUHZb21OxntPevBO1jxcb/6wp8CvY6TWDVxFfxKJAE4nFK7G2xz/XKETi05YEx9GipGeZYSylhtelT0L1iUCa7npQfeOEjGdXEIv8RGnOy797CeqEmgiohI1ytjloakBSuWXziJ3tIphw3xhToTiq3Ys6NfS4O64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788862439; c=relaxed/simple;
	bh=kWGLXFyPHplqccz5poLz3IbI50NU/JwnfhfqrKLhw3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pe9+d3J3qi7oJN8PxaeUNrT8owtZs3q6ZARs6RPHGz/u/kPO3kzhcuxAVdEgPPTjgOdU34xdFu9EvG3gj1YS+hruV3wKq5a/8Q4ZfZEXvaZR5sVu6FUluLnyzhhIjfgftPacF8bS2ke/cMrfDg5TcRnbZpuAWwkmBv7ZlGbewzw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcXma+F2; arc=pass smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcXma+F2"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-85590c5aeabso2923840b3a.3
        for <netdev@vger.kernel.org>; Tue, 08 Sep 2026 03:13:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788862437; cv=none;
        d=google.com; s=arc-20260327;
        b=mPMmesQfHTSeaVUjFlcCuq/DaAmCBWdys+2w3EK+sIQsNl0AYUmOwiUz5d2UKYhgCs
         6uM4WNmLYn8mo0zxWMEeSuWnYjfv8n0K4m6Jm2x3QcgxRTU0bcNjFkId2uQU7jSDuf7+
         P0dIW2sXpMfrworM+TzN2MfKQuGwmwqpVOLMPJIKZHweJX8KP7Nuy+WjeALzaSKrlDhN
         FSB2ooWBo3xGqHdoWuDD2jLAxyo9zIV5qlDczIQBGuaRoOzvmpkjIgm6ztjQfL/t4bUx
         LbBTJ+2pZ/UOaExWAvJvylFEur2d28f4Py9Dt7PuhWP8iV0GmJ7j4sLfkQfuHhIBUE74
         WyIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=oLrwfLp8ACywcK6OZDMAVfDPAmy/xkA/7NJ1Wh6BTDY=;
        fh=FKIXz2mW1xCtaYNyVw6pwqrLkP5mn8hoxMoc2TebLps=;
        b=GQGoqtho961d4CHIMJHdFv64IxAXObYDFTEQSeJfuVqf61E3oK9gEkm9Tv9/Smefjy
         L3SL42CwZTvmQktCOPRTDxDvqRH1Ri74n+Efy9NRGTydZI76yQEmYS2BdBXw+iSwN/EN
         dhmNtD0Lm5uhaxHHgtRoN2GAu3tHu2c1+80A3c8QnuqZadZuhKvrX6YXUm857sN/hJTJ
         ukN8vs5LNndCFMLxhsJQOVH+d8Bywk7p0iXid1q62mXweA/XZ995WZWad9sJOP+F19UW
         dqVYhN6efGYt5WV1L/Ph94Ts5bbbDLVLIGt3gG24sPkBbIQT8/LHytZacjsMiNaH3Ji9
         aMNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788862437; x=1789467237; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=oLrwfLp8ACywcK6OZDMAVfDPAmy/xkA/7NJ1Wh6BTDY=;
        b=KcXma+F29IwmkuBQapQkmDnhdA073mi7hJKEUKUC2FKwsLT898hxV9lOHtUrk5iHui
         KkrEi7S2mQ1XYrc4rL+ceO+SUVS0XNIURjyIKZCO6/z7kOZis4jamUb2Gib0a9ltpY6a
         R87H5A3ecQj2V9fG3mg0RU8jRZrhi6+4yr4JQImMLLRR3Rk+EcGbN4vnGL3TxUmuTGYh
         ueKGLTQ39CaZ1L4AlEM6hrMpgHMeT6x6WGJWBTuwkIgU0SYqmTP+UDBXNE3L6lH+GVOC
         qd3r+GRr6A0zGtoQQUb4nhBLZKWSTVjedNUQ3EyrVqdUDVpw1a+A6xVuAocJD4Vh2ALO
         F7JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788862437; x=1789467237;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=oLrwfLp8ACywcK6OZDMAVfDPAmy/xkA/7NJ1Wh6BTDY=;
        b=IIh6MQOaBMOMB449FgXL+lrHI+3H2w1riHvCe1NRzMScCfgTDMelZzSMx6EM05MUQH
         CrmLCwzExdKL6+3ZnO/qNMfbnK2CRUh5uEoLhDGFrfhcpGtnbeGXQ3yrfLRAvRx+UdpC
         jaNZIzofJhAt+MHBwIjKimVXoOqL2k99xHKfyeUtEPFiXz9hnJoDlByV+AYBd+KIxm9F
         BeftBDrPV9Wg7BpACKoSIHcLdA4E5/oAEuExonZBRNkPTl3m9kPApae4Sx+Q25+Vz/me
         +UkdloObQ6c0YupUGt5Jd50I4eRDL5Ekm7WfMkj3V5WPNNhKeAjPr6BsVoal35lmWXLl
         H9nw==
X-Forwarded-Encrypted: i=1; AKwUvBziqp3Wo2x3yS2Lc0CCQ9oGhndBSDHY2+yPv5HARHDW85EC5xRfeKGZK6R3C9Z0oGAf+mE6nKE=@vger.kernel.org
X-Gm-Message-State: AFuF++mUgyAf6b8YKcvIf2A7x6y6XKdlVLE5ATUpajVHxp5qGR/QGHM4
	AlfGxlu9PhetvQO/KgKx2UIgGNfyNZOYXRSPXLvncNs/Et0Q74j6WaKzSY7R8wLNIXV/Fwug65j
	B/3qgZSa6o+NZLdGo+60D/zAr6aw4qng=
X-Gm-Gg: AYBFou1kpqPvN/l+9cwJt1sIhPcUIspFCJ2cRORSwtubftVSn5xDcOXlnVHHNfdYMep
	GbQmt9MM1MXD7qZR+FktOxMIwRGqtgEePlxvr9TrnXGHWRK0rejJRURs0JUA8z/eJlxDVBJcsE2
	RU5qf0M5sWTm4jxn4tN218+jUelSjBPKw5HTYni/ak6/C4P2beVOkSf6L9Lbd1yWMgj7Y+J3cpX
	gSj51N4e+enm/v4uquhEYwVwggL3ohAPrA60FJzAkxNS1SFUWyFvpKtfPJh/ZqV9OUzmXJngeeX
	towvHeRdUcr6dn/VfqCR9WsrPzLOYGvkWrecAmpT4UsasKoIFRnLM9ufc1skiSNQIxMuj1CPt6L
	tRmuq8KgRADesuPnQ50chS3C9EruR0Veqjwa5g3nDuNXjjI9Js2AIQRw4EOR+BjhhNOY=
X-Received: by 2002:a05:6a21:b97:b0:3da:15a9:a18e with SMTP id
 adf61e73a8af0-3da3a0cc429mr41624097637.23.1788862437122; Tue, 08 Sep 2026
 03:13:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260908-fec-ptp-pps-event-uaf-v2-0-2a1d57121ade@cherr.cc> <20260908-fec-ptp-pps-event-uaf-v2-2-2a1d57121ade@cherr.cc>
In-Reply-To: <20260908-fec-ptp-pps-event-uaf-v2-2-2a1d57121ade@cherr.cc>
From: Bui Duc Phuc <phucduc.bui@gmail.com>
Date: Tue, 8 Sep 2026 17:13:45 +0700
X-Gm-Features: AcwNN1VMBv-YMtUDD27KP8tWOFfyKDv8HAQFtZgWktZVu5_za_i0rbJmn6ycjPA
Message-ID: <CAABR9nG49YgFejWRAkJrCcXF8p03A=HwWhbetmoHSjk_L3h9Gg@mail.gmail.com>
Subject: Re: [PATCH net v2 2/2] net: fec: free the PPS interrupt before
 tearing down the PHC and netdev
To: Shengzhuo Wei <me@cherr.cc>
Cc: Wei Fang <wei.fang@nxp.com>, Frank Li <frank.li@nxp.com>, 
	Shenwei Wang <shenwei.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Richard Cochran <richardcochran@gmail.com>, Troy Kisky <troy.kisky@boundarydevices.com>, 
	Fugang Duan <fugang.duan@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
	Simon Horman <horms@kernel.org>, imx@lists.linux.dev, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> @@ -861,6 +865,12 @@ void fec_ptp_stop(struct platform_device *pdev)
>
>         cancel_delayed_work_sync(&fep->time_keep);
>         hrtimer_cancel(&fep->perout_timer);
> +
> +       if (fep->pps_irq >= 0) {
> +               devm_free_irq(&pdev->dev, fep->pps_irq, ndev);
> +               fep->pps_irq = -1;
> +       }
> +

I noticed that fec_ptp_stop(pdev) is called only from the failed_init
error path in fec_probe():

failed_init:
fec_ptp_stop(pdev);
failed_reset:
...
failed_ioremap:
free_netdev(ndev);

There are several other error paths below failed_init that eventually
reach free_netdev(ndev) without calling fec_ptp_stop().

Since fec_ptp_stop() is currently responsible for calling
devm_free_irq(&pdev->dev, fep->pps_irq, ndev),
could this result in a use-after-free if the PPS IRQ has already been
registered and one of these lower error paths is taken?

Would it make more sense to handle the PPS IRQ cleanup separately on
these error paths, or,
use a devm-based approach so that the IRQ lifetime is managed automatically?
