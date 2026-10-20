Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792535903;
	b=QJpW/sGntuM2drtC3gPXHGPxpFjYyiEOUuG2blgWB41NdiXYh4W1cIcdkYFLZ3aV1z1g
	 jo4itazmxFe4AubbpQyUJr9E74pzSOYXH8aMDNzKPCgJQiGkISLDMZ+ubHZxBLgPzyjK/
	 U4BOCEB1KZ5wmjOVCcBCMkNStFQI3AtCyAljYsZ8yuhFG64yHJiihGPZm6PwH3TIFlIAm
	 3XhpsDmIEwlHU/dONRQmfOX0KPu/W6yk2EfYmZ1w83/pMvYrzQQMajSVtz/G3t4y9AS7P
	 rXWtVQxRdAOSczvixaE63MTkiUdCtIBwQ1dU+dk3VuO26Tzk7tGche9Fj9wSun1t/Jw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792535903;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=TLtnvNpQNgeDJo1fgrIbFUzYRY9b2V2srLedu3XuhAE=;
	b=JC2lKZIbyiST+Dhpe7qRQvCPXtiOOv3NzTN72ejF+HzX4ZBj8O+N2ag8uZPnFsTIahjP
	 mhKGlQMHBaDRR+szGjC7OJlL1KTlpNJs+y6wk97ETAhzTZN0YK3sT5ZLWcUZSdQqImltk
	 5f7qaYAJppVX+fGIaeh9ELalQGinqnlW+gRloNB5YF+HPa77MeQXfzMvaLknftOIqNqzV
	 Wqtt/k8mXylYmhq4oZ9cshUdt1Fs5gVCuBEipxmeymBb0nMe93Htvl3VmSvpSh7uwaM78
	 31sz8qWCeVzY/DTDhVe3NcE7W7Ov+k4sLld9TMwGaJ+AQkPzfuD5BXnlqiYFh/XtYoQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bTqj1INU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.54
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D933F606A326
	for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 22:38:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D933F606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bTqj1INU
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-6b1aa377c61so54639a12.3
        for <netdev@vger.kernel.org>; Tue, 20 Oct 2026 15:38:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792535901; cv=none;
        d=google.com; s=arc-20260327;
        b=Y0eqTk6Y8hux0E8e1B51yrrYAj6vgPDD/CE5/oFx9p4KQsl6wfhPX8gw7DycRV322n
         HA++Ibc9vA5sB7SSAGZb++k8BkiNUjzWidNfE8n2FAD0IdnJFN8zjKT8Yjt1kszMAwze
         0pgmdMGbN/cYg7NtRoEikBHIg049LTi3gkXA3Cws89XqGx5AfkxkxK8I81Zcj83t8jjR
         /+VCIlvsKu2i2nv9p6a1Y9Cio8iGSkU5YZgP5pNXgNbKQmKbECaLIDaIwqfzhpHj5fD6
         YZjHpJnhumUbNnc6UJLU+ONGQ8DqA+olym6ei6uasW+4/QbRVgXKPldRkwSBR2YbPp90
         hwAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TLtnvNpQNgeDJo1fgrIbFUzYRY9b2V2srLedu3XuhAE=;
        fh=V5U7T/5ctoZE5+Z/g0fsaNYtE0pfnH1MnktA0yAHIvw=;
        b=cEAYQvL4xpXw9oARNux/M0USsnGJ30ntW7Q/OJbZdvWvs8rZqA4M2Iaa6zcDRzSZ8T
         GrYKXFAzme+XlaAXRFKFg46SE4pEIL/InY1th0mKW/D/4zJ+ggsDYMPbS8VD9UcvDJcs
         cjsI6I4IQ112PcAGZ8gJ3taVsSON4IaevVeUkL7j2DPZctiTWAVX3qTIrTYSeY7RZfGw
         5+DX8eQnRIt3IS3PIe2EAy7RZzth3b/cyZJieGAcz19JmTCmWJ2s10VrUwetNG8oPYXL
         Jm5SQOhrrV8F+RJntnIqyBLTOa2Ln9wNvvOXzCHm/pCn486Jmioggo3ED9r/E7QMKEly
         l+ag==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792535901; x=1793140701; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TLtnvNpQNgeDJo1fgrIbFUzYRY9b2V2srLedu3XuhAE=;
        b=bTqj1INUnpvGGlVUjY7GkKUZafE1j56RBFdMn+RlJr32l0E3eKTVhgPrSDLschU2zL
         k5+ikf4+iLlwaq4SIKAs5qCcc332WatzLHXP0li7rQmoFDPxdUe7txkt/BgPDR698bVm
         YMQ7ZVPHwUe/bBEY7QEtn0/bEkCmk4OuNIsmeCJ1NfRa825n37fzCVrzdHR+0Qhcz8tc
         GAT8TYrW2n9WeWu2GmIa+mBkKzO24XPMhIHTxGWxGoIol0YbdZcKT4tp9av9ykd9q7Eo
         qpOE/VtJT2+wcTz1H3XI2iQ0cZxcdTblyOvORH1adV6xhqw8l+9psvQTRTR3GR2WwVlu
         RXTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792535901; x=1793140701;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TLtnvNpQNgeDJo1fgrIbFUzYRY9b2V2srLedu3XuhAE=;
        b=f86M27EEfKG7yUq5zKKghffh7UrUmW7L8a2Q5FE1TgJrF3umj9MqvNz7b0KkUXD3u4
         MkTWj/s4uplqkUi9rTPCetTZuQ/sa1d+1LgAnKyQPEka3QMZ6JcTwYs7ONppxwpzuvQR
         /ljbpuiF++e5rDurBCf2XIGkL8IQ4MhanbcfpvPXjarHo0FXVDa/IrJ5RKhBBCOczLRG
         72QEypo2nDANokJ758oelLKv5++pRfCUtE6lH4eESYyrU7VeYeMSw/FJ1z/gIh7b0Q0b
         2lRT2cxNxp3IFvZM+tiUD6Z/yjQXQ+/+EnMix+GlcuSA2NOYHBBBDmAacnJFHFCpNj0R
         tEzQ==
X-Gm-Message-State: AFq9FYLUiIzFbNTmGS+fWRksGTGb8rM1D3a/4TnPAfpC4Q8owtX+19aZ
	sNKecD5v4/2PnVqNB28C1Rlls2Wit1GO+cLYcKYs9A/AwaTubl5NR7gf8YE1BGzygRqmkl6zUDG
	E7Xayi4eTDB2WlPrHF1cMW3cn3LF8g18=
X-Gm-Gg: AYBFou3C+ErxCibOCyhrrFbNi/FNFHH4iwL4y9oD6w/DKw4TWIRRtDG/s/miaWdlZwZ
	cVTp0nODCygrEjebY/UOwWSc16mN6F8cgDL4K/3paKmwsZjxt8fWitp/TahoJZ3pHZIX+Z1aog4
	7B21jZ6ogYMZxed/VSPIBHAM4Hz1dsJpyxRO9dbCRcmqWyHbvRnzXt5Z5JhImUVlK+IG07gv92Z
	qsSXQdGPUOuA2MY41v1RlT0oFzqlpyQT6zf7BIyrIalGK09afaokRt/IR5ATfIsilSjMoi0FVYf
	cS+pIH2CROfiKroWDEcmNJ7GLzotVHDhRYTP/itvjSRi/dsPdi5rhWBByQHSpMV5x+K6pkUyKlN
	MHL2xy6Lhn76yTWtCp07oTqgbasQ0pOq8OL8UeDgAbAy/k4aJvey8AaHAgeptpCOnBUxaEnXqhu
	6hqZFvZ2Gz1Rj8yLKWd+6dVxzXYUWiW7Zh7h3/3qcov9GPNYleCfjX89LEdDKXRFeb
X-Received: by 2002:a05:6402:11cc:b0:6b1:c774:58c4 with SMTP id
 4fb4d7f45d1cf-6b408ea04e3mr64015a12.7.1792535901045; Tue, 20 Oct 2026
 15:38:21 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261020222723.1746201-1-rosenp@gmail.com> <179253559962.3290.16612111135539202564@kernel.org>
In-Reply-To: <179253559962.3290.16612111135539202564@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 20 Oct 2026 15:38:09 -0700
X-Gm-Features: AclHuK8h3OnfDuJ5gM7IeNqQ0bSvNuR0heQI9VhNWlxFn25mwpxLHGb_qqiceL0
Message-ID: <CAKxU2N_y6x3zEugwj935zFoA17mf9RzfUikPq8sT2EVPRB0AZQ@mail.gmail.com>
Subject: Re: [PATCH net] net: emac: guard PHY bitmap teardown
To: netdev-bot+sinfo@kernel.org
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Wolfgang Grandegger <wg@grandegger.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 20, 2026 at 3:33=E2=80=AFPM <netdev-bot+sinfo@kernel.org> wrote=
:
>
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
LLM
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.
