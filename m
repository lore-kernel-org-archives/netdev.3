Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793816744;
	b=ODnCST9LZ4TIlWzsW+m4NeFKmG3ATIf+Uqprz+9iIHQ3eZKI6+iAVM6TOa9cZo//eu+d
	 GBLQN0clUof0jVZck9wuz/FDLVdaVYUaaqKvvhYgy1I8I8YESkGucAM0jjXL2n0j5oUF4
	 FrSxGjQbD8zpHoO+Pp4DgC7eaWYEHMTgVJ/qPfZOzGmDVWOqFzbZPfYQhZM42/VaqV/QH
	 ArwPokwU1hmSCzg+/aoXpOb6g01iCwFS3pUT5rem/FadhhWtK5wyG/dDwyEO8vQK6sxCs
	 DQSQqRN5LgpR7CyQOpQN/QxS1aUlcXblUq5RRUpiJ1YsSNXSdP7ieBLYrZa8LAXxVWQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793816744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition;
	bh=fptg/GN9hp3PA+p/fi4U4fZU1Oq/WcTwcwO03y32q8c=;
	b=RzCb8OKXHjTPeBndLRVhy8Y3aNs9dZS6uzRcfR5o13JmBNvovjm8Jo3fp3w/PdAM4xR2
	 EB+PAS6R2x/MhVm0amgKeFsefJTNGAhhy+Ewv1CdI2f1NS+VvaznY81miq5aoleoNix1T
	 I8G3NxLjwz1n2I0PpnFQ7G00//Gmt3UbKuCQYBcjhAlfqxDAcCDZOGGr6vQ+7Qqhb8ayr
	 3Y7oY3iM/M0/nl0upV7d47/+kKdeCgcuBZ1dsCmJousyoP52wA//ccC5MXnifZeXS3s+D
	 PuL/BvG6NgZ4t2XEMc6pSBhE1CXkheRSTzJmoKFt2Vus0RUBnn9U+jCEUJsvgU1hPdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RtiBVlUa;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558CA606A326
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 18:25:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 558CA606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RtiBVlUa
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a208d93758so11477715e9.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 10:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793816743; x=1794421543; darn=vger.kernel.org;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fptg/GN9hp3PA+p/fi4U4fZU1Oq/WcTwcwO03y32q8c=;
        b=RtiBVlUapp2BD5jpqUoc2UgPlRWeu3VomA8/dYgkxVkFsxCaggIFbJf0fdGKNeExGB
         F1Pd8Uzs0ds61GnXPpcy547rROKrX2VDLBaQpuvBWU/wevPBG9ym2Azi5miKq2wmpFr9
         XRrTFZtoru0ll4TXBICUTQMX2v/XWTHWgilcmoVyVDBaAPdnBkQn5vweOH9MvKGIKvU0
         c4uBUn2C5P3bZhlrcPmHRpeZLfOZEm0bL9db/MSaivkkNUP+YIetV0KEYo0SXkmDyerA
         Pn9GbEe/cXzsrsqZMeOB/d2pi5LMb9m8eU1G18nBHkk5Em0uEn/+cLdRc1YQ7JXgzSLl
         qedw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793816743; x=1794421543;
        h=content-disposition:content-type:mime-version:message-id:subject:cc
         :to:from:date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fptg/GN9hp3PA+p/fi4U4fZU1Oq/WcTwcwO03y32q8c=;
        b=QbxHGBxDBhH5QBCF6ukxtIWUfY8uD4SxiV3IsJoWr0+BBrwdCUqwqRoEb8JrDshEmF
         rsJ8mHkgal4dngcxEXGc5cOIYjns/+Yl1oAEi+98GHfKBqiUmpnf3LAoEXPLYDDUbgUx
         Ln48JjhCaGYPKj+Lj0D7mRbRFDi3/kZCx9ltA1YFbjN63VlUkbMiQtquPcPKEozLh0I9
         GVmpVqVbusMGyO6eVo37CmENsJZRlO+MjI4LoV7Br8GKTG+0UfDwl6VuiH+/BWFsVFED
         wdeqPEcwD6IPHNn0CAqHSDPSkc2Hr5dUXdE4xGcrswfCRLKpaAx3deio+NDrB6pavAl3
         mS2A==
X-Forwarded-Encrypted: i=1; AKwUvBwPa6COeMAXxP5DzASSwPWvXwaJETG1EmcRlgq2MWg/LgQCGtM8awqy9lbOTEI1pIp9SeWQcxs=@vger.kernel.org
X-Gm-Message-State: APuU4Z+1ytrlsUfdnIeEJ/EgdxuW/9wk+HD3dFf4HShk+wkzJZ7H6HEX
	Bw4e7oAXoVZJvVQdf6P+MYAB1crqMfyzgJWKRjAvulXWO+Uc795uYYXPs/gX
X-Gm-Gg: AYBFou2lBOeJ6pPPSMj+Nca5pOp5n5vLGqX9pUeEDfszEa/dfTDK7WLOTHbPVw8qADt
	m4mP+tMytk35IjQWiPH9LcdB0BoOLmf1/8FC4tnAYvuOyfp8wHuc7Aot9YIbesaCocMtFN5WxUi
	EJB2tlBI8iQMBs1TDZPTj0/qlAkS8aNBNFvmXcQPtQbbOHUmUETYm2mCoFcozB1NVUAqg/YU2GX
	S/hkKNDrhPMPIhf8Tl+jmeQN4+E2SovfF4dXkhA9d1NJx6XAY6FkZYh5glQWFZ5owB2uZ2JivJX
	KJMs5ja0aAe16XJeWHmfcFbP9VfJpv0gbbVYRu+EF2xJOmrN81mLhqtetL0RHglb2wlsycnpusH
	qic/Ll8kFV8uhAOVhKKu4qmKLn193zvcYG/FEH1DUrh/5u8msqoElDIQC3ixc+d8ZWN9S/g+JVF
	WaI0+r+7o1Ks8a0xysBVgXXtwMqLu30uFm8vny84l0bY/NY08+isQFho4MYV+aHmNrfkeXE9qpY
	0pd9rLYLHXEdv91AFQRGL0AnkDlE9XB8i8JtdVPVnd1kUjuicBS7yk/Hq0rzht9F5gI6IP5RtJf
	zimzN0XUJzBL7CM=
X-Received: by 2002:a05:600c:c87:b0:4a8:cb23:f71b with SMTP id 5b1f17b1804b1-4ac186b1a2amr391659435e9.18.1793816742817;
        Wed, 04 Nov 2026 10:25:42 -0800 (PST)
Received: from p183 ([178.172.146.10])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b4533873f0sm68175905e9.4.2026.11.04.10.25.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 10:25:42 -0800 (PST)
Date: Wed, 4 Nov 2026 21:25:40 +0300
From: Alexey Dobriyan <adobriyan@gmail.com>
To: Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: Re: [PATCH RFC 17/38] net: pktgen: reject device names with a '/'
Message-ID: <0233f936-1086-4b57-ab09-b49018e34361@p183>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

> --- a/net/core/pktgen.c
> +++ b/net/core/pktgen.c
> @@ -3831,6 +3831,10 @@ static int pktgen_add_device(struct pktgen_thread *t, const char *ifname)
> +	/* The name becomes the name of a file in /proc/net/pktgen. */
> +	if (strchr(ifname, '/'))
> +		return -EINVAL;

I posted string_is_vfs_ready() to catch dots as well but it disappeared somewhere:
https://lore.kernel.org/linux-fsdevel/vqeq3ioklrgrf227zgdfho4virh74qrt5reoyptmzgktyronbr@c2mw32pqikft/

	./../alexey
