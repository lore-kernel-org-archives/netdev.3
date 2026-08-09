Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FD030ACE6
	for <netdev@vger.kernel.org>; Sun,  9 Aug 2026 10:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.175
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786272011; cv=pass; b=U/rMcpjfcouOsVgKpzHkTjXU8olNo3+8j6eBUCTADjH2wHj0Lo8UL+bxvTOm0MjyeXDir+QUpSevZ9moOx/Kanqbp7+4ULmM2Gt7vo3/vWs8ZbDGAyv/D1eGPSrWK5LZQK4KQecapPTJOPnDn3wcG4b6FaCiuuTMnkHh4RrsFiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786272011; c=relaxed/simple;
	bh=QM1sGGuS0vaAOd8KtfMYyxFzhT/qyqbhYms3edkJ8fs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YleBgiuULvhLN45ZMFlbSi9vMiriV7y3qYEVnRpO41ECAcBE4FGBywFS0B+XTgolbl2YguFYvaDLLCP7MC3cHswXM6IBjC3kp5AQNvDUAivPv1hGK7czzBLMDJ5vBKhKGmetYmWDjLhCsedG4KtaH/HWs4PY5lRB4a3mm9kAwYk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0QU5pca; arc=pass smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F0QU5pca"
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-81ff017d420so47247947b3.0
        for <netdev@vger.kernel.org>; Sun, 09 Aug 2026 03:40:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786272009; cv=none;
        d=google.com; s=arc-20260327;
        b=SDDFDMOm2FbmmcN+bDlsqpSb7QUf1P6rT8toDdl8qVfO9tFgiRgJFeOZRiWuPBWITv
         YZyHYVYGDxWzFa/TKEuu3+DLoFNzRzMyfqbTlMmH5yZ9hIlDQ/5Bw6KaYpm4Ez+jmZ6n
         rC6DHDedsGZPt1VBidMdY9am8cAryFinF7+cU441jUNmqj8KPJCaa2ifIg/E4ONBHaW0
         dcQyn85q92ykBezcJOEPGR/labjJVahe5/iZ9bhnNW+d3VZKJ3gMKkYOUJz4VvWPHuw3
         Zg1r6vid5nkpXezQ4VE50yNqyJEay8hC8Ws2LC4u3nF/C6s1SyDxvbrNRp3r1fMJdGFD
         XHRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5OEHnesK7EakdoIkkPsJgHCKsy+uVd8phvK+XOFpozg=;
        fh=foAwvQjx0QfPNfNmsDyL0l6VxUVjNeSP8rNLWQUtepI=;
        b=p2Ko9VIeHkX+meHPi72ZzNf9/nJ1VUOGcf+0cRthtnjXp6A8I2dYiLbjpvaFHXsicg
         hjnyrTWdZn4hcojK0VABZVozV3c4mEZbYPw1xhDUpZNPoLZV05tclYPB6wPNLON2S4JM
         0ZgjsT3MZPVMZ+YspiozhmYM88GgEwqLTC0kcmYRI1tpyxLdyqTI2q28e87UYK4y3RT0
         YWMOGLMHF/BstQEJef3V14v37lmEgA69pVgladJLz+3v69wpQ5DbCmFDl6LhgmLFmvdU
         wZ5TArQCJzWj2yuE3BAQ+h0G90doOmpOhvXITp5x8YAl1b4XQ8GsFGkxPWN4jvn3aBM/
         3hGQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786272009; x=1786876809; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5OEHnesK7EakdoIkkPsJgHCKsy+uVd8phvK+XOFpozg=;
        b=F0QU5pcarzCE0nSrGr06qXJHnfL4DtiQVZgX7oFW9S3GzJ6CLq/T7/xXIzFdev3XR5
         aezunP8VllEQ2zHziYmUM1bqmorcCmZ93U6h0v+Ml0mnUbRpBBE928vfZfifTc8DIzme
         Gwc084itHAJJQyP4eSPbqawGYOQrKWtHdQ3XeOFznOPXSjSqZbZoyeibA3lpp3rqOMux
         vQlHmokBLo3gp47LEnCyzSRTwOg2b3v9J3cQGfQ34FOnCnilI/Q0njayimlozZQU94As
         vfUqwd2YIBraWwnOLboBkEP5cWLlcVMsmE3fI7j6to4fgpSNybDmL27Dqy0zAeVD4J9x
         PfXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786272009; x=1786876809;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5OEHnesK7EakdoIkkPsJgHCKsy+uVd8phvK+XOFpozg=;
        b=DlwVOUCBTt3BCtUlxRjQSnEvfiqsN3sg4IVFMg3N8WM0FKZ8MsXFKEs6Hno/EG2oLD
         JO7C4EykM7oKB52Z0j+3e9VmlqzIfznzYr090U7SaWvNKrHNLmCnvR5JjqMOcMZm2rvu
         7n2/IuMA4TMyQqnZ1LsZc4dURVDgBplmlJfw9zVHIVvJeg4Jjxj0WU+2Whd3ozVdVocK
         b/9Dm74AAmim+s6b6ddON2HeVeULei+6xwRCC7WRrhxlqz75KRwlZlHHnZd2iKXwZRp0
         WlAhaM3v3QvSH8XFinZ9+UnpRLmvB32hh/qD2bxSorrZ+QE6jaA2BBeCoMrcbT4bqjeK
         JqfQ==
X-Forwarded-Encrypted: i=1; AHgh+RrIWDaeFCf4lw6UWl5M5AXm2fWM+kMFU17MRLJrsHjEPfI19GSIMINLGt/FSY4VdmdYcCAOfs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyqSDRCPazFcGfvZ4CIlG3xJJUnKUNKGvc1AGH8JtkdVCD87HFP
	UnWnk3cPYqjUuHYFXQB07oQMdxCgXczwszlLGR6lXIgbnYgRPGyFa1NqR6xeFhhMiZ+8OGkFrTO
	6rgHbOe2I2BhRHLfYKlGDsAfFKDmmtMM=
X-Gm-Gg: AR+sD12OJyxcUcKa9/kJLyxJ72cX3JhkXmRMds6gSM7LX3gxC1Gg0CF7MbnX3IFYLZM
	NORYL3N8IzbFbgt9DsptCFnI+CciFAa3kN/hT4tGDvcjTI94TeZZsdkDxNlfom63J4CKYvafTB4
	LM37QL8VZEiZ7Azq+K7GW25ulHBlb+YJEbEQ69RBMUhErp1IKtD5x8Bm7gHHUje7oGVXuwoda6F
	JIlZW1tkaMVUkVL1/jPqS6s8DxCt8vqy6EiJ1nyND4t7kjwoqeEJ53Fhd+GUPLMic9UZKFbp01z
	GU0RpHny5nDGfw8YoHhTZNoh/qUNk62cUiJjsdbOlk3pos8dTJ7tnOvedRHcbbkod2jhVM7zQRf
	Rcn0Vff41oEmKiFCLEXmfNp3RJuPgVGf4OXUByIUPScqIVR+zt8D7mfXAh20C7DgLKxPI90yW9z
	i8qVki5aIcRlvLe+0KwPA=
X-Received: by 2002:a05:690c:6e81:b0:826:8d02:8e97 with SMTP id
 00721157ae682-8268d02e38fmr49818597b3.11.1786272008843; Sun, 09 Aug 2026
 03:40:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260809093934.28098-1-zajec5@gmail.com>
In-Reply-To: <20260809093934.28098-1-zajec5@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Sun, 9 Aug 2026 12:39:58 +0200
X-Gm-Features: AUfX_mzSbd1f7h_hXr21SaLryqm2UUb69zbUmNg27YTIZGmdKgCQY0p4TyF9vDM
Message-ID: <CAOiHx==_HzdmNN5BY4DMh3Cr6JK5oQri3ZCNWN9v+xQPjzQZkg@mail.gmail.com>
Subject: Re: [PATCH net] net: dsa: b53: skip EAP mode setup on Northstar SoCs
 when using port 5 or 7
To: =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Andrew Lunn <andrew@lunn.ch>, "David S . Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Vladimir Oltean <olteanv@gmail.com>, 
	netdev@vger.kernel.org, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Semih Baskan <strst.gs@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 9, 2026 at 11:39=E2=80=AFAM Rafa=C5=82 Mi=C5=82ecki <zajec5@gma=
il.com> wrote:
>
> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> Northstar devices have 3 CPU ports. This design was meant for dual IMP
> setups when WAN traffic goes to port 5 (IMP1) and LAN traffic goes to
> port 8 (IMP0). While all 3 ports support Broadcom header some features
> are not available for ports 5 and 7. Trying to set EAP mode when using
> those ports breaks standalone ports.
>
> Fixes: 4227ea91e265 ("net: dsa: b53: prevent standalone from trying to fo=
rward to other ports")
> Cc: Semih Baskan <strst.gs@gmail.com>
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> ---
> This fixes a regression. A very similar fix was carried by OpenWrt for
> about half a year now.
>
> A recent discussion in
> [PATCH net 0/2] net: dsa: b53: fix 8021q uppers on standalone ports
> allowed understanding the issue a bit better so I decided to send an
> upstream PATCH finally.
>
>  drivers/net/dsa/b53/b53_common.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
>
> diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_c=
ommon.c
> index 3f5b9592794d..4b4a9258ecd4 100644
> --- a/drivers/net/dsa/b53/b53_common.c
> +++ b/drivers/net/dsa/b53/b53_common.c
> @@ -332,6 +332,21 @@ static void b53_set_eap_mode(struct b53_device *dev,=
 int port, int mode)
>  {
>         u64 eap_conf;
>
> +       /*
> +        * Northstar devices (SoCs with BCM53011 / BCM53012) have 3 Ether=
net
> +        * controllers connected to 3 switch ports: 5 (IMP1), 7 and 8 (IM=
P0).
> +        * Each of those ports can be used as CPU one as all support Broa=
dcom
> +        * header but ports 5 and 7 have some limitations.
> +        *
> +        * Setting EAP_MODE_SIMPLIFIED with port 5/7 used as CPU port bre=
aks
> +        * standalone ports, see:
> +        * https://lore.kernel.org/netdev/ce4d9b7b-aaf6-4796-94fb-8c3d6a1=
dcd4d@gmail.com/
> +        */
> +       if (is5301x(dev) && !dsa_is_cpu_port(dev->ds, B53_CPU_PORT)) {
> +               dev_warn_once(dev->dev, "skipping EAP setup because of no=
t using CPU port 8\n");

We should print a bit fat warning at probe time, since this is
essentially a broken device tree configuration.

EAP isn't the only feature not working, anything that relies on trap
to CPU is broken. E.g STP also won't work, likely (if ever
implemented) bonding would not work (LACP frames won't be correctly
trapped), I assume LLDP would be broken, and any other protocols that
rely on reserved multicast addresses as well.

So we should strongly encourage users to fix the device tree and use
port 8 as CPU port.

Also can you try to move the CPU port on all devices you have access
to and send patches for that where it works successfully?

Best regards,
Jonas
