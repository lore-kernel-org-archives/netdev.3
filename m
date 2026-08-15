Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35ED72D3EF2
	for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 18:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786818645; cv=none; b=LsnEuuFsasD+culBRqVS9FFXyD2d2XOAO1fgtTPJ004o0HJYapkBmhQsBWw5mn1vsfZyBgAvZm5se2po6OhmWvYbfbIYvi+19Lcii84E1z6VfG/hJL5BENUdNhzbmnDjpRR7sEikzC7xTPXyRIgRa7Ptxyly1elRWAfk+MDf1Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786818645; c=relaxed/simple;
	bh=kZTfO3uBKI57NTDJR2ykmTrRfYE0b0gP3rPTwHiWlDg=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RsAOyMXFT1UR9p1Puk1Mw9YkdZo+IrxHBrBPaRbkQKA3zfbrzG0xNnv9OOiu/IBxMYjSmDPpx1XafvAzYtiMpoIKjO0AD9WQAckgSZobeyn44lHcHrqafQTYh8mJ/YMFXdJD9I21XrVPH4RDXY/nE5FO71A3NI2e7MgucLjKXRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QUMcL5WN; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QUMcL5WN"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6a082b3671fso2768289a12.3
        for <netdev@vger.kernel.org>; Sat, 15 Aug 2026 11:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786818642; x=1787423442; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bX0B/tvx/xNY4Z8oanBlKNjZDRWTCp9mIncsBbd3D3s=;
        b=QUMcL5WNZ97vXsab3wHFE9ktnGN5ocPotQL03Lov80XfdxfQfkSGgzTAgXtIVNqxJ9
         vvNf/Nf0t5YPAdQbeE4n74iJjrTM1bMw7P6sX+0rznkVcAz2/2pMMr5LI/+VHr4rmllf
         Fb50UADBBG+fqAUpv93RECRm7ju86fML9PLtmYhj0DBW4i7j2J11aq8fuW4t2nlnLz4W
         gPHlyWzoHvYHE3tgm0Tp5jnkpr4hTiFvxOexnDcTKUHZtdPvbjbchh5iyu0JTuMxtqq8
         57rpzb3j5uwHTQTnkUtyeUwKh0NYWXjzt4YHLPAOqxmpPpyyQKfgxD6gZvXApAcmoyRT
         Q+CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786818642; x=1787423442;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bX0B/tvx/xNY4Z8oanBlKNjZDRWTCp9mIncsBbd3D3s=;
        b=jxaEnsk4gmAIxsYnWshRkDKkKgT0i8B54TSrZ6RDSTSKs80lPZrgf+2eg/fS0ZOWL9
         p6BkXzKeouF0rcLzDyEkiE0xntw3ycteAOYSPbCB8IGKd/ZfWCJhiRH3AP7UbZ1QY42O
         CVeEoRjicjf/2LJ10GSb1ajYcB0fhsWAuXQldfhEDNLtIZ4uGw57fQjbUXg8O0QwJAla
         +PO2VgKiMDZDdTzHCOE8bGJpnZhCdDLUomQtHVtfvMSuqq9gqx/vUHIqPA3KXdNF1PdV
         Mt3y7c8taW8ALK7lbhfh2u1/jENYY0xwvG80cDs7Ma3W/jYpU45wvLBBefCpugMWtEtG
         ofgA==
X-Forwarded-Encrypted: i=1; AHgh+RosX8enP7/x9+EohQx1syQRKJjjXV7XbPnqCJhwQCJIZu0WYoIJv8ouPoJyAkmJ4L47hey4NDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWnHtXVs8vMqsJ1/KkYMCic3EbccGrH9q9SbrGAPFKIQqoeRm2
	nWCSKduZPZ3RHKmEk7my9H4GSuWoaNYK1FnY7cTjgmovjuLOJkOcvCnO
X-Gm-Gg: AR+sD100veq8RylfsN3CAjASjCH+mXqT/C5iN43lOoWegwk+cncid2WRFqzAFPRyhgS
	7Lu11LzRzE7ozh1YjjgcbAbeoFOnrZKV6E9vaHNlF/sqfEGlLw+7UFkpRB1fe7SRln/n03aZLAS
	C5/i2eKt/1iLKgqw2pxu+JpihqBsSl7n1pgZwUX2st+uZD70hGI46HDZpnWPGIKhybQNzS8r7I5
	ca+v4Gz0iGWJKgjyz8FEs1YIKq92PQCtMMzf7gY7nh/p55RmPcrNdkzX2M5Kou0e3FPcfSoM/D2
	1+QEIrss1H4++0MbsOIGWk9uUOvVsTNRJqQk5rvPl3VbceFV+nB1jlqoitd12NZhggLpIUVIutN
	NRiPIjUMnzMwyIFFLE6seHb6tNIqt+K/NLF/V3vGogrqNED4FWyAI+OxrAxXAGkWgP5a/1TyvnP
	AA25GX3xCaJdKk8IGL/RiKXQgQpccSfKnleRgU+C3YZX9f5SHFxJPGTB1ZrVqF5EZV9k+5iyar7
	x3KOrrqsWcrDtPpqPi5Dk1mRU6qHOFNjt47TTsy+Q==
X-Received: by 2002:a05:6402:504f:b0:6a3:6943:d64f with SMTP id 4fb4d7f45d1cf-6a38a8bef76mr5798579a12.2.1786818640952;
        Sat, 15 Aug 2026 11:30:40 -0700 (PDT)
Received: from ?IPV6:2a00:1fa0:28f:426f:2aa1:8f7:f8a6:4f89? ([2a00:1fa0:28f:426f:2aa1:8f7:f8a6:4f89])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a38d7698d8sm2205357a12.14.2026.08.15.11.30.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 15 Aug 2026 11:30:39 -0700 (PDT)
Message-ID: <592ff228-2887-4ff9-b110-9f3c0e73a02a@gmail.com>
Date: Sat, 15 Aug 2026 21:30:35 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 03/10] net: ethernet: ravb: Simplify gPTP
 start and stop
To: =?UTF-8?Q?Niklas_S=C3=B6derlund?=
 <niklas.soderlund+renesas@ragnatech.se>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>,
 Richard Cochran <richardcochran@gmail.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "DavidS. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Vadim Fedorenko
 <vadim.fedorenko@linux.dev>, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org
References: <20260811160200.2049987-1-niklas.soderlund+renesas@ragnatech.se>
 <20260811160200.2049987-4-niklas.soderlund+renesas@ragnatech.se>
Content-Language: en-US
From: Sergey Shtylyov <sergei.shtylyov@gmail.com>
In-Reply-To: <20260811160200.2049987-4-niklas.soderlund+renesas@ragnatech.se>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 8/11/26 7:01 PM, Niklas Söderlund wrote:

> For devices that do not support the gPTP clock in config mode the
> somewhat oddly named flag gptp is set, compared to devices that do
> support the gPTP clock in config and operation mode where the flag
> ccc_gac is set instead. The two flags are mutually exclusive.
> 
> For the gptp-flag devices (Gen2) the clock is tied to the AVB-DMAC, when
> it is stopped so is the gPTP clock. For ccc_gac-flag devices (Gen3) the
> gPTP clock is available whenever the ndev is open.
> 
> Prepare to add Gen4 support which will add a third way by cleaning the
> Gen2 and Gen3 cases up a bit.
> 
> Fold the gptp-flag start and stop calls into ravb_dmac_init() and
> ravb_stop_dma(), which start and stop the AVB-DMAC. There are no
> functional change as all call sites to the construct:
> 
>     if (info->gptp)
>         ravb_ptp_init(ndev, priv->pdev);
> 
> are always just after a call to into ravb_dmac_init() and all call sites
> to the construct:
> 
>     if (info->gptp)
>         ravb_ptp_stop(ndev);
> 
> are always directly followed by a call to ravb_stop_dma().
> 
> There are two special cases where the calling construct covers both the
> gptp-flag and info->ccc_gac devices, one for start and one for stop. The
> condition that it is preceded by a call to ravb_dmac_init(), or followed
> by a call to ravb_stop_dma() are however true for them too. Reworked the
> two special cases to drop the check of info->gptp.
> 
> The end result is that the gPTP clock will be started or stopped for the
> gptp-flag devices in tandem with the AVB-DMAC, while the info->ccc_gac
> devices will be controlled, as before, when the ndev is opened or
> closed.
> 
> Signed-off-by: Niklas Söderlund <niklas.soderlund+renesas@ragnatech.se>
Reviewed-by: Sergey Shtylyov <sergei.shtylyov@gmail.com>

[...]

MBR, Sergey

