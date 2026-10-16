Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4765B335564
	for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 13:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792158639; cv=pass; b=AzKrj4Ef5uGUo6GGg8k3AlhAK4zL7UGBzTNM/kmt4zO001ZMfvXrzDgzh6I+nNO4dFGFb0LKSu+1gEwZCKzm5R5cjTE/WETGnsm0oQZynfo5Lck9DultuUOZimudQjlcS3PzGCPqyIWZuT/42uU6ASbbVEo6h8PuYlc18qortbY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792158639; c=relaxed/simple;
	bh=EnWk4CEIPOVMQws6KYFkC+XMwt0JNb6o6tfr4D+75nE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I6XEKQX3PfPxgqL/H/ABG6Q7n8bF49XeUUAE/q5E4hirax8/ValYDVepMTqWUHKvDvKL+vbLtc1qn/UKsZZQd4yEVyKRxgy9zD883RB0Erb2/IY/aprDMvNNTEgifG7mX8eRBDO9c1w9eh0eTl/pjdHHRSTFrGZ9lFrhaBfRbuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rz2f/tQ2; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rz2f/tQ2"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b1b13e09ffso7362615a12.3
        for <netdev@vger.kernel.org>; Fri, 16 Oct 2026 06:50:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792158636; cv=none;
        d=google.com; s=arc-20260327;
        b=Tnl67gk2Um1XD0vU83szqUrZFILYS1mgXRUNwV/aIKI1014qvIKZb4jGjJNfGacYXO
         NvYmacX1DtUQfbWiDTSaM0VRVbtvu7O6ZlTOruzrz/MgaJ5e/LryyIov3uLiVhVgHRr5
         9ellKfQvBZaazwazWuPMJewYLq91n4IdNpyFb9s7LeCSUhiRycS0V9iFpyLoH2Flt26M
         Ox8fchfaNlGxkXCVdHB4Mauz5LLuxwAWwB5JxSh1V+XR8EZzmD+xeL8VNo6gp6uefVIl
         ESARZaIehv3wFffX/smOqBU5IQSkRytwmxhqzgpkQhHcqZxjt0BSP7WF9vyKZoqsVWsf
         GOIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=EnWk4CEIPOVMQws6KYFkC+XMwt0JNb6o6tfr4D+75nE=;
        fh=tF0Bmb2Kn5Wz4+S89043XoEeQtc43qcdF3euNBsF0MA=;
        b=WVyY2lzxpSrMu920EX5yhFXSQ9lRY5galBRnvNIDZOOtdYueA0Rzm0VWkHLXWJ9EEh
         PKNfjNGlaR79iJp6GYsmcsTiX1tV7JXR7XyTlhsu+FeQRDUlJibE/jsWRp+oMBOEGGmC
         Y9ADdieZAaRV/yCpzPtw3QfOcHNufSeawz3gwbU4L3nMux/v9UJTaQsllt3BcO/TQc8i
         wfsqqg4ckuOyA+KcgP6faJaIMH3UJw5/B3kVtH0mSFJa6nRHWf8oaJr14b7NGAXqbtsY
         tzhiOPP5ZGpWZKLr0+BURQIWn04AmlXwFhd5b5L56faSMaWSV6t+HCTIDiNK1aE+0xfv
         G/iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792158636; x=1792763436; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EnWk4CEIPOVMQws6KYFkC+XMwt0JNb6o6tfr4D+75nE=;
        b=Rz2f/tQ2LrrHWac2uBvYj7XkeqcoYZU0vGR52CgGv3ycT4i72oYVlWGYOYRTHIb0p/
         RZbYoKJ2mxBo4aadEsbye6uVZcFA55vBrexwXrCwXSaM4iqDQRklN6+Sgj8Td28OVEOK
         MwgXZMHh9l9Yze4q592nZQsDHM9nXutF+QryqylpNLCHDc5iPhPoKbgMgpZVeGkL12E+
         sAlhK5amom0xeFioXN1QiphUp8HNkeQnLZo7Hx5Vm1hoyDd353+BtAG0BlU4hOxbZRzq
         73yRTd4+MqgItrmuVc+l3StGNsV7kl85LF1W8RwIQQajRYaxeJONd/pdNPZ4jRD7NWoX
         MllA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792158636; x=1792763436;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=EnWk4CEIPOVMQws6KYFkC+XMwt0JNb6o6tfr4D+75nE=;
        b=A6SB8usXDPbqCVB0kr4DFDk0eFELERrVpyRFe0p1KfCTxPi8VLU2gMlTxu/ZzDpbU3
         U+4U9m0cr81AIZr4qtHDXkKlK7g3zARCBAiWf50jcTfJEib2zI3MQfhPchzHaDZkfsI/
         cFKtDbJCOe9n2+J39vUWoRXNdVShiSPelmnmmbTBWNXcUk4Mb64BAsgobIi62ZkLIcXQ
         CLPMJqwLMe8DtBEqoUdA3wzMfxy3UwTf54Hpwzm0f0NRiYrjtOgEehzpGV63VngBmWNA
         mSQH3dCv6BkE8Ad41DOakR6TzEVt7/PTBl0A7iVyU50LDOT5KB+1NuCrCDL6j9CCBoB4
         cjhg==
X-Forwarded-Encrypted: i=1; AKwUvBwfseLXcOvTBJfRbKkyG2UB9df3fu3j1egoCs446ONqCRzcZySgQncolSwSSWH+1eEgibuhGOs=@vger.kernel.org
X-Gm-Message-State: AFq9FYKKL55bw4HkAkiOjUmYjJvo1D5ZwdWkRrlVV9mLcqLVTKs5BFno
	dBEOmnb6kItjq7KFIE2JyJxOphpZ+IbmhrHSe0R6bWuE2bnfkqaW9MdjAcr0NigMVKJ1eBl1B65
	u7789GDIxlOjAjvsckupGk+ES3Cs67JM=
X-Gm-Gg: AYBFou1QOujT4WnoVO3SRkGz58oUFQcIeEskWmHDBdEF7ts98iu5xwu80M0a6vjkDBl
	8bZ/6fz0aV5UOY5ZHFQBPndjslv4hdHGVMNermGH9ODS+ZsLYW9xbr5PeHTAObzOhY2W6IStA+8
	l06cJMxcaKHFkWxOGKKYVIDoQBce5eN3iFKdySNVTdmdFvbNd/tRFib1jJl1uqXjDlFMFUy1VCa
	zvkJzNBt2rmb5GbxSMD6vwqtLEigBRcbPM0GFg0iUpFAjBz9gYQX3zE7nmfJu43k90Nnq6NT5bl
	oZWPAsAnPqOuZ2+gtK3zOfXYbHCKw85tnUCahxKabZkc/IPlbZEmOQOIRA==
X-Received: by 2002:a17:907:960e:b0:c41:30be:4f84 with SMTP id
 a640c23a62f3a-c4130cd9cecmr98912066b.9.1792158636247; Fri, 16 Oct 2026
 06:50:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <5a4715dd-89e0-4868-9ffb-c8fb73b18d04@yahoo.com> <7bc13c51-6e93-4dd8-bf4d-b65d87fb36e1@yahoo.com>
In-Reply-To: <7bc13c51-6e93-4dd8-bf4d-b65d87fb36e1@yahoo.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Fri, 16 Oct 2026 10:50:21 -0300
X-Gm-Features: AclHuK9gnSAfyz4LIToQnUxhKHIgo22W-MecVImvzd-daSoaPswgwHlQNEh0rNY
Message-ID: <CAJq09z7zJiSpVApcqsp9B=Kx6TcaBoom11jn4GY2fnPyjM7P4g@mail.gmail.com>
Subject: Re: [PATCH net-next v6 1/9] dt-bindings: net: dsa: realtek: add RTL8367S-VB
To: Mieczyslaw Nalewaj <namiltd@yahoo.com>
Cc: linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, kuba@kernel.org, 
	davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	linux@armlinux.org.uk, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> The RTL8367S-VB (chip ID 0x6642) is supported by the rtl8365mb driver
> with the changes that follow in this series. It is identified by its
> chip ID register, so it does not need a compatible string of its own.
> List it under realtek,rtl8365mb.
>
> Signed-off-by: Mieczyslaw Nalewaj <namiltd@yahoo.com>
> Reviewed-by: Linus Walleij <linusw@kernel.org>

Reviewed-by: Luiz Angelo Daros de Luca <luizluca@gmail.com>
