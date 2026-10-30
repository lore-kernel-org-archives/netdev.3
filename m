Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793395125;
	b=aA2mKKw/euVDbiwxrjsu3O8VbrMZyaaU/bJ2xNpP7a+odgv+UmX2L+5XJWWjPDQf6pN9
	 yzRFKNGk9uLhOa0mJA5UuQLMotZZiIjFggsSupcQWoskN358bxZAkghwsxpjzc7R1ccUo
	 wI6MG0wfHhci9ySfn3rEWAJ0jazMKmJK85PBZwjkfGWLcBm6Rem3/3MSN7hdHTzVv2n/V
	 5Wgu0eiG46fOpX589jTjffm26ZJId9OJ2BmBoxgZwoVPI/oHx11Ls2KJbIaMQisCyUg1y
	 qmxK3Fl/2iQPu+b41Kne35b0AAr4enMMGIuXRcaoRx4W5X+dm3BGinZsRjiexq7Y1Mw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793395125;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=+vQK2+ntVD6NUjQ6dWHwZzvu5iqvUOH2VFUkSssBFQg=;
	b=KwDc+JVrFaDV9f8IUTitfjNfWDApxlVRPOsYn5KsNbIAGu6+QcsyPxftCS0/Z4jeaw1x
	 F2ZaR1c4vN6X/FcrgPyOdFs1jtLxqD3yixPzytnxIsaKQyjeI/HAL9QEies59oppoWvQy
	 zYJJDOrG0b+AVsx8cc2Zx2er1caavIaZcYL6MS3VdPHNWrUhDEL4SbmQi0xXiIlW5FxA0
	 VNIGbsc41jjNxMirdDFpnFhMAY1fvUO2het8/FWxutpUFHDKztAGvCgNDity75ElJMSeh
	 WMOV7vZWmna2V6zqX70vxSqU4fA7iVcqPA7+BMzyU40+Rz6lh29L1YioRedDiRhGnyw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r5B6ylBT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.180
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97799606A31A
	for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 21:18:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97799606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=r5B6ylBT
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-8a06ca6e8f4so783126b3a.1
        for <netdev@vger.kernel.org>; Fri, 30 Oct 2026 14:18:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793395124; cv=none;
        d=google.com; s=arc-20260327;
        b=om3QyFcSK7PCZRZBi7svKmO64sBKFITVJcery0UHKLc1EN0q+VsPCl9HF/NCGwU9E0
         izjQdynjKkHsU3K/uQEsETg4asQgolnlSpAiOwh4uuHEKh+rAdhqrCiqT8PxZB5IKyg0
         D67ZLz8NBPI27pgxhpzZa/hrBpXbpHecg+ImP6JRQub7Uo1IXtYp3t/D6+1TElTSYIbe
         eJPJQc1TYBqec/V2I+5QwzI0h8V0YhJU2jZiJsZPTe6xSKdE/Z968Gi3+Ccb8X1nh8J9
         NSsHzrlAZrVreyc5tV8GXinQz0p7FKWzlH/JA2Ac5/8N77Dcg8PNNuJDMia/5mGr6bwr
         KrCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+vQK2+ntVD6NUjQ6dWHwZzvu5iqvUOH2VFUkSssBFQg=;
        fh=NImox0BHC4dGuPvklNrON8lq9hDBJ+EUWPHUMcSMGpU=;
        b=SrjwUczGZLLFOOX8mg8QViavQrP9BWhz4+wLtq31seiK8Hc6s1B+YzqUuSC/KqDlT+
         kX40DFJ/OwA89yFcBY9qF41ecXB8PD6hgadO1kASxfERBWAgrDSF6gV71Hd85B/7GWS8
         EGosSYO2GG9NPmHJhElbixSScuoltit39UwPaQtfnBHPpk4e5m8F+qN1pdwC52fD85We
         fbLEeKvSEQrxaQfoQdo5MyyNLWZfM3mWmhUkUig7W2y7sM7mphp5ZIfJLHstb2HEFlVA
         y8lZ472JV4OuoEAETJjvdNmErXIki8JjEjVU7jlfKgweXfDMn0rv/PRZdMgr2qhoJUPd
         mDMQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793395124; x=1793999924; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+vQK2+ntVD6NUjQ6dWHwZzvu5iqvUOH2VFUkSssBFQg=;
        b=r5B6ylBTvo/Ju+OlgqMGr0hjJNxyfIXXN3esO5kDgBHid/5rGeYmWT0HpzFC1Yfqf3
         sGx4ocZFSvvCyzE54UT4IMtAv01ddP75Dnvj+yM1e5dBWhfV+lUg48hGgm/t8dUMpdqu
         fUJOKfipBaVrr+absl63uqx9gpEb8HPgR+frrjewID1xQbSbXTj6uJcJW1IkQ8QpCEL0
         UqWNnVkJ7R0y+h01fr7nZyIEBTI0IGHwg10mFuGJ6llkb1DmcS4SmrpQEtFZ2ol/8Ddz
         Lx9D9h45i1DiqfTQRCbLS0cqOaZhck7Jyj+0ptqcsechJebT9y8NKvsBGKn8MazCWdGy
         rZJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793395124; x=1793999924;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+vQK2+ntVD6NUjQ6dWHwZzvu5iqvUOH2VFUkSssBFQg=;
        b=Pvv+gIlM5RkqoeG4KyoLYOVbzz0uRp9gv4KPtq00oFJV8LpsRfslY2HSFvbt1biQpp
         03pnL8zkIQvovaTs9gC3XLwC+W4p4caxpR06soHbdoIalsH9MOQwoHsg8RSFni4B9KoY
         vxsEXCjyBP0i1cG+f2C79QjgJsayhyMrwKl3RRDWIUXbyfNPovi6KhHhcRd5hEJp5J4K
         /EfcQjt0EjYxwguDYz5E/ofAHh4IiZUWR7TwI/c+mhRM0I+ApfkinvdyQzUAkfEt0IZT
         ESTQC0ztBuq3S0m4nnYTNIos4V5c/BHb5gYYqjLpBbv9oIQinz1dZtB2/LPjp4NyPdYW
         PfAg==
X-Forwarded-Encrypted: i=1; AKwUvBzZ036X70cJNcoU7LFza62Yhf8hh/Cd2aVuc0RHLxFK2vracrNzVobJ7wj8lXtYbO7JCfq3Igo=@vger.kernel.org
X-Gm-Message-State: AFq9FYIRPtsH8AB0eENQQ4fUgWoAG3nPtqVs9ErDOHyjeXENMWDxhfxO
	M4Ltr1+geZMpbFF0WlyNSZH0W6V22R+5TqAZdjmwPKVG9H6vrk2M30bPX45fY13+ECSKbBBmXNw
	5ldmmhPQft/PWJQCTGfr8ISzzFzWVoZ9PHUCz
X-Gm-Gg: AYBFou1iYdepMuXP1HnKLRn8vSY1f9jWSmvsbuWgbATcnwNIA/rk6t69ex1DyaeVaBu
	O/xFl91IpTPR6aI2K5BxR8x0CPPSPrUNsaJWRF78XDQeBEGEYJ4rdvSMSjb8/2ggaRxWRiT5GVg
	2YOzBSBQbDNcoI5JbalXeRd39Aa3zjIdkzmUSY2FhNkSsh+clp5nUlb3wiAKvQ2ZmxEFSVGesfR
	vUFe33lpJbhrz5EuIgyhvdNvftMjPKEQfDJg9m3c8/ESXlRAynSLL1w5zJL3ZhRGBv17DnljFv5
	t7EZ12X56H+7+N22v9f3qnLvVL2OX6ERu6LuD26CG52M/j5jzZKrqCRvmDbvL9YA6mZiG7kzMm+
	KmPUB2NvR/3NER+lYOtvGTFfEYuZjiFcf15tsTCwZ2aH5ER8TDJUV
X-Received: by 2002:a05:6a00:2395:b0:8a0:1435:fda0 with SMTP id
 d2e1a72fcca58-8a9bdacf6c9mr3330870b3a.51.1793395123940; Fri, 30 Oct 2026
 14:18:43 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <CAOr6SmEW8ZLjMzqCWdQL3W0DKwZCVaRL+DbhrSEZu7SeZRiVpg@mail.gmail.com>
 <34a6dde6-7a4e-4291-9f13-22d56793c866@lunn.ch>
In-Reply-To: <34a6dde6-7a4e-4291-9f13-22d56793c866@lunn.ch>
From: Zhineng Lim <limzhineng2@gmail.com>
Date: Fri, 30 Oct 2026 14:18:32 -0700
X-Gm-Features: AclHuK-euwuRKwlf0Ac6JKuPP3yMm2EBraY189A6yrxw0gpschvhjcL8HBl3Il0
Message-ID: <CAOr6SmHqg5mH9W7LvruknDDohTAUwQTTxSsUN5mCCu9WV=5WJg@mail.gmail.com>
Subject: Re: Netdev devlink A/B firmware bank selection feature
To: Andrew Lunn <andrew@lunn.ch>
Cc: "jiri@resnulli.us" <jiri@resnulli.us>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

devlink dev info+flash are implemented to handle 2 banks only. For
instance 'devlink dev info' shows a "running" and "stored" field to
represent the current FW that's running and the inactive FW on the
other bank respectively. There are a few architectures out there with
>2 banks but as far I can tell, devlink core only handles 2 bank
cases.

Currently, devlink dev flash does not select the flash bank, it just
passes the image to the driver's flash_update callback and the
driver/firmware then determines where to write it to. I don't intend
on modifying it, instead only expanding on 'devlink dev reload
pci/<bdf> action fw_activate'.

Regards,
Zinc

On Fri, Oct 30, 2026 at 1:19=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Fri, Oct 30, 2026 at 11:28:52AM -0700, Zhineng Lim wrote:
> > Hi Jiri,
> >
> > I'm from the FBNIC team at Meta, working on firmware and drivers. I
> > realized that devlink core currently lacks a feature for selecting
> > which A/B bank to use to activate the firmware, i.e currently we just
> > have "devlink dev reload pci/<bdf> action fw_activate" to activate a
> > pending image, or reload a current image if none is pending.
> >
> > I'm thinking of adding a feature that allows for A/B bank selection,
> > something like:
>
> Any hardware out there which supports A, B, and C?
>
> > devlink dev reload pci/<bdf> action fw_activate bank active
> > devlink dev reload pci/<bdf> action fw_activate bank inactive
>
> How does 'devlink dev flash' work? Don't you also need a bank
> selection?
>
> Seems like 'devlink dev info' needs to indicate banks?
>
>         Andrew
