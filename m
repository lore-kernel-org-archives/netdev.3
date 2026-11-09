Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794187902;
	b=xShbJf1YFDILKQf5y8k2sofoqcwD+zqWjQfhWmy3ieGYd7gsJaKAHmb3hkWLq5/uh03k
	 uxjrvuyvUexNLWuw1ESKHkhBvBb+HtKBrAClzWFIbzrh3eUX+x0y+GAzx4zAg1RADV9Mz
	 lCfP9KjiBIgBqcmLovwVLfyG2tCMtoXRwmKdE+JQa0HkBpMGeBiXNJVc4zQ8PkO/9m1A4
	 ftDVUV1B2OrvS8KG/uwthmB415lYNc2apdnsqes4MMI2fR5tNBGDYq4Ndgi+MdJwTuVAc
	 NBXh3wUEcdBkPcsDlT1vowsB5BSojANBtfLjfHsWFYLKXkEljFD12dFmTxlrodbGIDA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794187902;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type;
	bh=8BIGtN0edeJ4AHaRHTPlYTsz9LtH9rZv7+zpPDlG/eE=;
	b=bKax+x4O1CuTAN291VvlO6qj7o+rDAjss7nbdpSNoIcIwjzCODoDW2oSxnYE76RJEFTn
	 5zQHctbFkTd9aVhxFks1JNrFPuqCLnVmKgjdogzO/NqMEG4vpAlJMFvPOefy7Joo4/YR2
	 rllcSgmbPRqromFWXNIMoTQDKcbBCBTzLSTiDBg5d4Q63f0PxMT4L/iWoGlMnzlxi7+jl
	 8Y72i9jAqr6ioCHQchYOvgCbb36sHHwIJ0vxaXwXX7s8ta9fwDfYnsSlfaRaYzY5Go5gK
	 dKrPVeljL2VZ6rzMX/WrUW7TMXfBCfZtPxsKomhK5c5iZUy7FWlJV07MtD4RyHdc94w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ge+LOS3W;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.43
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFB4606A320
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 01:31:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BAFB4606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ge+LOS3W
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-c4d427836e9so47691366b.1
        for <netdev@vger.kernel.org>; Sun, 08 Nov 2026 17:31:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794187900; cv=none;
        d=google.com; s=arc-20260327;
        b=Q/eC7iMnszMPSQq0hRqxQ8degkeVoMagJCrv1CjOlHZbpiJ6RDNJin96S6tZ8TueeH
         AfCF8ZXIaWMDbdFFjMLl420/8oIZehc34//OOeW4hL75RP9Vo6XfhttnsnOaedlyu6yQ
         nHSXlT0ogAZaW2/4TauHukWpnJisyC54V+B6x9eT7qX5ezeCWFkzMpZIfglDeRe82kz5
         h0Nudhe53sqRtkRq+SWLTYakuO/nxHLcf+zdhvf/ZI2fK7HTddZi1FkdiQA1DEllrhii
         /ycY7Q8R+jKz+LLEKiuC5SPpORnOcsCaycqSOd01GvnvcSpBllK61P013EEageFiuyyX
         A3Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=8BIGtN0edeJ4AHaRHTPlYTsz9LtH9rZv7+zpPDlG/eE=;
        fh=cwXCpR1oWeROSpQherp1pRhNlgSzkAvQwZA6dF4M9pg=;
        b=boB5HiP4Zlghu0WCHJUtDYssuMlX4KcfOVVMo5ki354bn8iU+Cro5tDqLNF5b8Ux1F
         S5YTpXAx3UO8HfYBYKkx/9ph7yLBRcMcwgacDSInbOYJrm3Pb0ionOp6uvinMEEIx96w
         93WrUJEyPWnRJxL6Flf70Ix0Ctvl72G6co7y8flLvWz9MG0op5/NLkggyhd8PeuXdw6+
         PerkbMXKFWXUWpO5KUJ4D5+uHPTT/GigrftfKXzRa7m2w4JANmGzX0RgJbdkYYdmnmBO
         L7NPVvTWd85uFpXmnkD8s7w67SLdtxSr6HIHHD1SwDtuPYZSre42e6T20zngF6bic6Kp
         9tGg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794187900; x=1794792700; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8BIGtN0edeJ4AHaRHTPlYTsz9LtH9rZv7+zpPDlG/eE=;
        b=ge+LOS3WxfnHTEwdhQ6dKX1jbsxpegXgckUlJ6y01orTMKd+m5sibi7bInvWsMo78h
         C2/zNnXG1VC3f5bz80QMZyKB6evOJV/x+PbT8cXasMtrkA4aJNuXmv3LGwDVlLh8tzPY
         6dB1QX+GBwsRxNZAxp9dR+31OSw8XboQB4H57FnJUu9epdoHupDM9ZrWSLdL6eC9izuj
         libw1te3jgL/ek9dbuZNL5DUuTP600NCQmYIt8o8ah1beX49iSO/BryQbq99vZ49+fme
         xUis1ENCn9E5ote723ny+P/OTkxlK/ydftsYyzkal0mxjNOX4mdY6GBVYEabWs8M+rs4
         Jpmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794187900; x=1794792700;
        h=content-type:cc:to:subject:message-id:date:from:in-reply-to
         :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=8BIGtN0edeJ4AHaRHTPlYTsz9LtH9rZv7+zpPDlG/eE=;
        b=TqA/5H4joPtdBv45e18afXiPq+lXRwkie3S48Vdmu4xkJEV25c9nEnm6fUFkhHmRLB
         DluQR6PGoQIN2pb4aetc049mEd1QZqT3Caq9fDiQ+FXcIGkYIyWoHZuJNpeQRZQsf2Pe
         OXdtATQoqSl0f7l8Shdnx9qR5HN8XrQh52ssLwXa3dbcf7eASJvD2XvC7PkN0dJxuizN
         quFDcHyAMwvzQrPAwhH/V5mYrqmNcwSNwvavhVOAk8Who1hiU7n0gOZ+JQaCNntH0HS+
         +TWLroEPfiAgosuXKGuXeIIZUAvFltslKO/KCoGLmN3KyLOvoRG/dWiB/Cm3TiR7JnPT
         gk+w==
X-Forwarded-Encrypted: i=1; AL+hErEiId61OJ7Kqy2NIjKqciOPQtmPboDk7RuULj+9mwrMQLAza4dXMNvgjD1+vMmGcCkBWxsJbrY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+uq0m0VSW9ex0Uy3eTS0caim3Un7h9L62FQsNw+ThP72km1VLt
	i6gbuSJBBMKm0798LunZVQnwV+f2Qxt4/K4lfGz9LzU65HZnf2KyTmN3bVsgAGPu+ATmQeuXIPs
	hIM2gtoHGFkvSdm9Ftm1n5+6VmYdzykc=
X-Gm-Gg: AYBFou0BFevQFXS+zb4N3srWCg4SVaACpRJkjqMnrBs5g2G4g6zCtcjrDjwOeK5aeS0
	iNfWLh6VLJXsNa8qbm7AXuksIySGVDx6FlzahZgXa//xvetMDTl0ep1T1HxHutRJ9jreNFd8rnc
	+HZnBYbDmGAQzbjjcJTT7B6rnDEoQWSsgeoboFI3ASDr92u9q4103u4hcidnADPu7Fj59Ur3ffs
	U2fipR/pLDPhS46SAndhv9HcMwwokwUEYvtWlgrbMcY0QZP4SOrP/57FOY3mHUD2Lkz9jX47rR1
	x2S93H0ft46/x2dEK82QqU+l8Q4BpHrX89rN8wV0lI/RoLXQLI85xP6oqsLOv5nL5QszZCcbRYN
	ZrxPHTNVcDqnVspS3B2nSWRS6nZEQHE8XUuIpTlFbq0NBay+/C8dxIHPBUg7uwUQeYAekSQ==
X-Received: by 2002:a17:906:9c86:b0:c40:4320:de2c with SMTP id
 a640c23a62f3a-c4d6db2544dmr166233166b.15.1794187899962; Sun, 08 Nov 2026
 17:31:39 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <3bf4dd70-9771-497b-8c27-e925e0ef81eb@yahoo.com>
 <1ccb6acc-0809-4abe-8443-576f6727a6d5@yahoo.com> <ausoMS5PcpEFz02i@analog.com>
In-Reply-To: <ausoMS5PcpEFz02i@analog.com>
From: Luiz Angelo Daros de Luca <luizluca@gmail.com>
Date: Sun, 8 Nov 2026 22:31:27 -0300
X-Gm-Features: AclHuK8yR5gI4v3iGi6WeBIKPSmMJ43uWzE0QqErM0CadYyGtJ6MIzDVMxKV56Y
Message-ID: <CAJq09z7djw7MAbjc8jZuNsj12JhNCUOsGj-Ve73XwRjjHHO=JQ@mail.gmail.com>
Subject: Re: [PATCH net-next v7 05/10] net: dsa: realtek: rtl8365mb: set and
 get vlan 4k for family D
To: =?UTF-8?Q?Alvin_=C5=A0ipraga?= <alvin.sipraga@analog.com>
Cc: Mieczyslaw Nalewaj <namiltd@yahoo.com>, linusw@kernel.org, andrew@lunn.ch, olteanv@gmail.com, 
	kuba@kernel.org, davem@davemloft.net, edumazet@google.com, pabeni@redhat.com, 
	linux@armlinux.org.uk, maxime.chevallier@bootlin.com, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

> Don't you think it's better to just split out into family C/D variants
> for these ops? If you do so, then I think relabelling the old macros for
> the C family with RTL8365MB_C_ prefixes will also be appropriate.

Adding a `C` prefix is a clean way to organize the code, and it avoids
scaling issues with `is_d` checks as more families are added.

Splitting the logic into subfunctions handled via a family enum switch
(or eventually function pointers) is much more maintainable. Using a
switch statement also has the advantage of compiler warnings if a new
family is added and forgotten.

Here is a revised version of your response, keeping it professional,
concise, and clear:

---

> Don't you think it's better to just split out into family C/D variants
> for these ops? If you do so, then I think relabelling the old macros for
> the C family with RTL8365MB_C_ prefixes will also be appropriate.

Adding a `*_C_` prefix is a good way to organize it. It will get a bit
messier when I submit the RTL8367R support, which I arbitrarily named
Family A, but extra macros won't increase the final binary size. We
might need to duplicate some macros once we have a register used by
more than one but not all families.

As Alvin mentioned, splitting into subfunctions when each family has a
distinct implementation is much cleaner. In my WIP tree
(https://github.com/torvalds/linux/compare/master...luizluca:linux:realtek_families_wip),
I handle it like this:

static void rtl8365mb_l2_data_to_uc(struct realtek_priv *priv, const u16 *data,
                                    struct rtl8365mb_l2_uc *uc)
{
        switch (rtl8365mb_get_family(priv)) {
        case RTL8365MB_FAMILY_A:
                rtl8365mb_a_l2_data_to_uc(data, uc);
                break;
        case RTL8365MB_FAMILY_C:
                rtl8365mb_c_l2_data_to_uc(data, uc);
                break;
        }
}

This is how I'm structuring it now, though it might migrate to
function pointers later. A family check inside a shared function only
makes sense for very localized differences. Since family A is shaping
up well and family B sits conceptually between A and C, `is_d` doesn't
scale well for future variants. Using an enum with a switch statement
also ensures the compiler warns you if a new family case is missed.

Best regards,

Luiz
