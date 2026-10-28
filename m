Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793178577;
	b=VXrnAZPtP4EWxaPYQ7DmrZzC4UTrA8Z2jzQcJm8++owqC1DdkvxK/kTqkDmi1Fkw9Gqp
	 HwcL49YKfPs8yJ8xQGhWCyx2FWwDvPkMc1HA6RR6YDu4QvPGFx0GQqijkInKyXoVYGz26
	 l7qzWxjems0OUsM65HFjwz1vyrXdSQnLTAsb4KEAxrIVZLg4RlIs5+HUrGYUfHhjKk7/P
	 dCGO2oKWb20CzS8Yrq2Q8P1bgPj674mKujSUm7YE3Op/2p5uDN2TGX2MYUn6y0jHhugfz
	 4RDA7bOGLaf6gV2mKJR4qY9Rj2PIzwSuXZ9aejfBPZ1MNFyeo9AORFIdlWrB+x2HLVQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793178577;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=8V3vKlQqADekuYChxRGPaw/nmB5SOwI58nVZf4lvwQY=;
	b=JJQzcYwUJi8Kpb+NRVfg0mXcdH4aGuwF9zzuYRgQOBl0HpjL5mglaPMQPVTEfXr8zsVl
	 7vrdbsmjbZdf0ADw5Y28d3aNlwGG3JysypIUl0XoK2ZsdWSWGdNpP8iUMU8M6x7Y4Ui/h
	 JdcL6wAfc8FWywB6XQySFDFvrrW3/r+6r1ituBkwD6TfZjerZNLEJho5n7qirqbgVy7wt
	 Fzozo0VJ241dmuxi+qSCwdBy1g8psZ1jkxQ7wTw+ph0UZTm6PtRNcksi9I1eZBln9aSp9
	 B+4TmwlN4fBSwvD5OAPvrX2D6+mE4DI6vBfmqdQxW4FBhHVfuPCyYzVfDFhhJjWhbPQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="y0Y7Bj/r";
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.128.174
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CAD3606A31A
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 09:09:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7CAD3606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=y0Y7Bj/r
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-8b0ca1ebc8bso5655347b3.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 02:09:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793178575; cv=none;
        d=google.com; s=arc-20260327;
        b=XRLWMERkBPnSii6iOFs+Qs6NhdFbN+WFv5JL0pQbyo1YNQisoZdpJL4pnZOJPOiXih
         KEiTZlZ8wnua85teESM4US95EPy00lKgH06ZMyWz7djU6J31y8STk8/QJ8+TxqIjfx7/
         Kmc+/Y0AaZDTN1KfuHqyh3OSRg0YDn1y5PAtNizxth89Jyq/eXFbyLA9/BOcjmWbI56v
         keH5rIhFf5tQx+YoKO/qT8/1kMeDXxeEnkPzik5loSxxejAHlCevkF1lQCTucJG2nMj6
         mpRVuyEAIGAisi+enW9rBzd1/joguyWmqp1ykcjTR7Ku/o92IullNFXLouBLA8wirF0G
         2hCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=8V3vKlQqADekuYChxRGPaw/nmB5SOwI58nVZf4lvwQY=;
        fh=3rM+mk4x3Nd7dZrGPPzl8nXyUwXhAg6S1dYaTlDEkdw=;
        b=H4gWP616yNMlPcxy8cx+N4Um1ep56Tul4kJm+Qd1LD9mi36SmGo+/gJN0ON5/UbTKQ
         GLE1ctvxE36803tNBEF8J4gSaMkKCcK9JptLHhBrV69nzZGXDdaNwN9PnYrMa2SoEe+7
         JCRMOIrNothLmj3aWgMoI6JcYghLzjEzrO3WKs591WyPOSg1leDk8TRF+R1nIixvf1PO
         ICe4RqbSGbkLqRRrDitquwbTsC5YFM/yNCIbAsr2EPNeS+IagY7dzsz4fNwJa8OEPWhe
         RU8cho+7UPPMuST23W59UolJ7MbaCsipYXrVVnjWjR3lghE2SnCMJQILJ1P8saAPO0rT
         sdow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793178575; x=1793783375; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8V3vKlQqADekuYChxRGPaw/nmB5SOwI58nVZf4lvwQY=;
        b=y0Y7Bj/rx+OCyXMC8sGtJV2TyS3aw/sNv3z6PQrCncJUU1o7y1ypCV6gVCiDPhuTxW
         X+5XmXkUjiA67QznRmy+C3ilCr4GRwT0khv0oiGXjAM67mcGTUtrtpGRiPZsJ6glj6Hn
         qzAUKXSChy6V57mVAkSYAsZVFghsFObVMtrfsz8VXyKEwvucowIT+1SWDdH5IiXggPDD
         9fQgWHQWHcIfALC2NSfgcPf6pKYhNwxnKdLzgP5IDNczmG9Hyd5Qcuwvw7c6yt9rKwYu
         PAoK+lKqDi5JBoFq3zZl4/kP0v46Fe7/PYeS2MlDAcPQOv+6GkPwAaEG6G1lP9J2al6P
         ZThA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793178575; x=1793783375;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8V3vKlQqADekuYChxRGPaw/nmB5SOwI58nVZf4lvwQY=;
        b=OA+2cz9S2+aMibvpgzp2fSdMUxfXIK+etBq11FNHgHYCSWV9R0Shfeoc28HmPLmAHG
         K8Xx5+Mk/qJym1dKt6m8Lqvw/mnub5W0RpLY0g7pcIUhVviw7ppn0fYBeDEsXmh+7h3L
         tnCpivU8q64YaTRDVmSEfeST3w0QBy84cIHKTSd1rGzTYI0d/ukfQWSyZtlf5wNiElnU
         wfXowmRJHYi3WJxWVLuS7viQ298tsPLNQCwXdJzJlsEsTzzSO70Kqw7Ix78UkxYXl0PC
         KOnQ8TVpidM2f0Vc5PY1nLpR2Ics4CvwVNlO80hCTZ7oiWi1fid9xjrtEBUdJ0yKgf+3
         OYVg==
X-Gm-Message-State: AFq9FYJBVznwsAmU9J2HRkl4wO5tCJqyiRNW4Y04tWCtQ3PJs8e0Oj6C
	CNMGsmJICpE3jUdBWHBfzN1W5kKK5sGKCgCuuguNpkn75Py9N6AwzFhFkJ6Yw9kHx5/G2LY4z9+
	O8/wYPg7th1nQn5bOh4br0ps7jGF8H0A=
X-Gm-Gg: AYBFou3k0QvDIjEtClldvO+yaMT6DAjkXyG0dne4m6bAAGPKKbGMRN/XcSrpsC2va8s
	M7M80fMQCiUzVOAL//NtIspcLIbzG6fFQfiPwVr6uGhsiHbGT2l5tz65GEvrSd2uMPr/7D0Gi0C
	Vkc1pJcZN/0YJEo8a0Km72V7wTBXSoTO8x8y4Bwz7fbKy3ICecvOHuS5JSMxBhEabZL9bs9T7xv
	RoTw1VwvMhfS11tPgUC91bTgHRijh2wkUWMmQx/qpb/smvrOA5011nJgzaw97tl8SbiH9AW684A
	OHx/8slK52W7uBgssYWg0ds5EkzK4/e16Mj2yAjnl/+nTM9MAk1SYZKmsP6RsvLaaqyJc/vjkpN
	EWsm7fVEulhAb0FSfOzYmUvD8Po/DhDfXHLAbbCdMCOnjr77QkkTl5ebIvRQwFsmTOjWUsXlzzj
	zswRFkN7JKX8Xi+tQNO7u4l2oF6VKRB+Zn6S3WYcfibMRvNFJf9NBFTpG+CoWogTPMF6w54HF8z
	ynU
X-Received: by 2002:a05:690c:e3cc:b0:8b0:d4bb:c9e7 with SMTP id
 00721157ae682-8b1b5ce052fmr11702967b3.46.1793178575340; Wed, 28 Oct 2026
 02:09:35 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261027202230.3539646-1-florian.fainelli@broadcom.com> <20261027202230.3539646-2-florian.fainelli@broadcom.com>
In-Reply-To: <20261027202230.3539646-2-florian.fainelli@broadcom.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Wed, 28 Oct 2026 10:09:24 +0100
X-Gm-Features: AclHuK-ovVXCbI-zwn7qh1kikdJ9e3riBKCGOQhvdBZS9sM1LitUGyq7XdqjpQM
Message-ID: <CAOiHx==vXaMg2aBtnnO8F0hB=kvTr6R=Bq=CdqMX-uOjL_DzWg@mail.gmail.com>
Subject: Re: [PATCH net 1/5] net: dsa: b53: initialize the jumbo frame size
 register offset
To: Florian Fainelli <florian.fainelli@broadcom.com>
Cc: netdev@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, 
	Vladimir Oltean <olteanv@gmail.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Russell King <linux@armlinux.org.uk>, 
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 27, 2026 at 9:22=E2=80=AFPM Florian Fainelli
<florian.fainelli@broadcom.com> wrote:
>
> The chip data specifies both the jumbo port mask and frame size register
> offsets, but b53_switch_init() only copies the former into the device.
> Since the device is zero-initialized, b53_set_jumbo() writes the frame
> size to offset zero instead of the chip-specific size register at 0x05
> or 0x08.

That offset is reserved, so (hopefully) was effectively just a NOP.

Which reminds me that I still don't really know what this register is
good for. The (bcm53115) datasheet says it's used when jumbo support
is disabled(?) to determine max good frame size for MIBs, but also
that it controls up to which lengths frames are admitted, then dropped
(and only allows the values 1518 and 2000).

I tried writing various values to it, and never managed to make it do
anything; neither did the switch start dropping frames longer than
that, nor did I see any effect on the MIB counters ... .

> Copy jumbo_size_reg from the chip data along with jumbo_pm_reg so frame
> size updates reach the intended register.
>
> Fixes: 967dd82ffc52 ("net: dsa: b53: Add support for Broadcom RoboSwitch"=
)
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>

Reviewed-by: Jonas Gorski <jonas.gorski@gmail.com>

> ---
>  drivers/net/dsa/b53/b53_common.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_c=
ommon.c
> index 0880310c9ce3..559d4b360c82 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -3109,6 +3109,7 @@ static int b53_switch_init(struct b53_device *dev)
>                         dev->vta_regs[1] =3D chip->vta_regs[1];
>                         dev->vta_regs[2] =3D chip->vta_regs[2];
>                         dev->jumbo_pm_reg =3D chip->jumbo_pm_reg;
> +                       dev->jumbo_size_reg =3D chip->jumbo_size_reg;
>                         dev->imp_port =3D chip->imp_port;
>                         dev->num_vlans =3D chip->vlans;
>                         dev->num_arl_bins =3D chip->arl_bins;
> --
> 2.53.0
>
