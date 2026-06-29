Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A8146AEE0
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 17:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782753910; cv=pass; b=QOKVHkQ8GjdbxYQfM/H4wICMIY1kM9/SMWZ0De4WIlCtsUReIE4c7ju9Ro57BClooIg71fviqyHLnBTuk3xF7O9PFo9Hy3EUaIXgSE82tPx0p+m/4nHlzRyJow2NNAm2fFPYWnNHL1lQYz0+SqDatO0U4peFDDSN5ND+hKTqWUA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782753910; c=relaxed/simple;
	bh=T4Hdp4UqpRyAiDPK4Qxc+FO1sv6/EoKsG757Qnb9PLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QvsfKnjJLEMOHl5SjKnV2bt4NCtaroNxviwJGUNdbW9gM9B+89FeM1AxiHmWZax2zwwMk7ULpHqGk86AK7p46apVRPSmEh0iPWKdgZIp+L62s9pMk2YcdqV5is71R+o0XQkpcXql9PH97hpUW+8ZPq7Rzo+UQ3zq9qr2W15R23w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com; spf=pass smtp.mailfrom=trailofbits.com; dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b=iF3jrPep; arc=pass smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=trailofbits.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=trailofbits.com header.i=@trailofbits.com header.b="iF3jrPep"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5aeb91c003eso1147259e87.3
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 10:25:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782753908; cv=none;
        d=google.com; s=arc-20260327;
        b=hywAHI2iGMuioYINZvSLqcRosHhk+vLjhyymmUx0VQmtcFjEzuF+I6O6GT3lcvyY+3
         SAXijMRdjSJAPTrkych2NGVf+ChH6T9Pn6WrWX/yTWExbfcSBcdSwKkQONRSXr03t+DY
         Wn+t0IHXHX6FQUzrH5Ztegkvbbt46NzuokCLzRgzgjQ+rb8EzUdU7MCh3MSsr6llhM+n
         nfkv/BBcHQbHbf6tcEt2nRSMz5Iy2k62wCMs2jA+BPJaqEIlZoQUxspF3lEA5JteKlgR
         BRy4FTlAJLxIIScAEvnejLCt0pavqOx6LuhklV2yZzkgRm4MhUG9fnkpFrkrNm+d+nsx
         n/rA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RNVxrOq7hCihwcX755hqKJJxRSsbZ+NdSq43Nnq6gMU=;
        fh=Ly9OTtlWTVk+EXUR6kWrYx9F7nbQ2uarXczd/VddIuU=;
        b=AQkdRrtb5z4fpNlkDJ39mkjpRyGpn33fMDlXpillpmlo7LVywbSE2kwZqeLgbIzM4i
         iOZ24SHyiGxkyTwGRh78kN0ADM4CHgNMwyOXa9Utz3eRljOw3gyJ/G5D69BeD93i7DJ+
         7vcYLN6XGUd6sXqVMPYOPej5EshPvDdARcitAOwoBsXYtylDb5Hm/tjybdapc6h0wLx/
         pEpP82oD+a0hcGjXswcEaTGolzAQBsIhVBflLULg/bPJkoVxtRgqyy6yVsJJaAVp/hZU
         iMkxaEFnU2X51JKhfNjpRm/jIY96gbCESn2aZcmXvT0ni0MQuuYmYWmV71SLBRY7MExM
         f/5A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=trailofbits.com; s=google; t=1782753908; x=1783358708; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNVxrOq7hCihwcX755hqKJJxRSsbZ+NdSq43Nnq6gMU=;
        b=iF3jrPepBQ/cNTOMY3YesPMRWCT0Ha5NuA+wQwYY8SMekIM/zgA9Q6sAkbFk5D7IPJ
         g+IGgdD//r4tzlbaRgTUR8w+ew1EzjZORq3fk3378FMtzJ6+B68H/cEALEJowp2Aj47a
         ZFtdxcjc8iZHn8IQ/SZE4/cbm1oWtAV/KyIksNuvA5aXryhrEB4j+9eWICft0/meVh9r
         irTekg082WXLoDKR9fLOxTFztAPxWwlBM4/7YdmWRzkcF9B/E+q8lBjFHsBc0KEnGfOg
         pCiezMF/oQZnIGzpcA8Ghe1jKCEwcj5v0DEy24OMml1ec1JrY0bWCegaw8kT8kw1YJ5K
         UI5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782753908; x=1783358708;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RNVxrOq7hCihwcX755hqKJJxRSsbZ+NdSq43Nnq6gMU=;
        b=NPuM51ac5ALhyNTvNK9Tj2n7Gh6CUNc9VkOI7CzjajzQgRRsiEnOaPz/Q4SsAfVsYI
         4ogz/M6DVDnfqc0I368gSjWOhT8pWYCRTlKYoyv0lHbmoJigbXFhFwRg7oWuz+pK10RP
         l94SAy6vXHpxxR0TfG3yvOFp2FMEdg8diwjfBBs40jxNX3EGySdvOJ7WPOSxte/L9vLu
         Je2vrNV5iGCNO6HnN47wQKwbk3UuVDHaNuv8CvsFO0LFecFpmxKjgEk6TkR+xuLs4B5H
         3IxfBAXRIr5F0mJ254+JDI7/O7SbJSSGdw1G1JLstWJ5ZmQCUIFQnpFE/meIArHqLa/x
         bCDg==
X-Forwarded-Encrypted: i=1; AHgh+RoG3BKe3V1SfWjb7THTHHNkL7yP+ETTRsKaZHqunlmxtkMwPSLME1AWNXfy9WUHQkiAWen7UhA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+EVYUJ4uSxnuOUW9xzzZX1uLia/cR9nlhW2EPevGDL/6qGIj6
	gTUot7Dyd7yUPGsYSCJXTYIWrxqIgMzpx87K//xC4lqhnbF0SCPzqEqkZiSj76bdN/kOQHUtkc0
	CZX/ikjbbhaggLqmSU5RMsF9daE/nkkiVGv4krlQrww==
X-Gm-Gg: AfdE7cnNe86Wpgi3nLyhgJW01ccKkoHrcuINNmWyXLQzIjNZdPpSClSTUPJmm1wN8NI
	xSngH8+KSwhH7CW+cntgFbG+gE8gsY0lFYtsLXUK6L2LKPe90MCW8OjjVlmnwThRh6KOGsEZMNM
	yK05RK4K0ELsJRGgZvv0JuW2PjjfXfI6nDwbJY1B9FzsISiU5w+UJvouReIYkWhjoce1YEfOAd0
	hkJ7NfQas1T6HZcdF1EyZDZbZaX8Fdp+J16XqxSjTo4wsM49pOQi23juu8BaWVY5u7VfC8=
X-Received: by 2002:a05:6512:a354:b0:5ae:9d0f:19f2 with SMTP id
 2adb3069b0e04-5aebdb7d486mr43047e87.3.1782753907646; Mon, 29 Jun 2026
 10:25:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609232935.1602659.8545fdb04fbe.cake-overhead-underflow@trailofbits.com>
 <20260613142626.1b2183eb@kernel.org>
In-Reply-To: <20260613142626.1b2183eb@kernel.org>
From: Samuel Moelius <sam.moelius@trailofbits.com>
Date: Mon, 29 Jun 2026 13:24:56 -0400
X-Gm-Features: AVVi8CehuZasSGDM7tdu5ZNnK7k4rkh3SCVj8V71oPROccnLp1Vsy7jEK2VpmsU
Message-ID: <CAE+C+DZpYpJDJOaCK48KBpayXSYorFRSvTE903RBqyPyYkWcCg@mail.gmail.com>
Subject: Re: [PATCH net v2] net/sched: cake: reject overhead values that
 underflow length
To: Jakub Kicinski <kuba@kernel.org>
Cc: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	"moderated list:CAKE QDISC" <cake@lists.bufferbloat.net>, 
	"open list:TC subsystem" <netdev@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Jun 13, 2026 at 5:26=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Tue,  9 Jun 2026 23:29:36 +0000 Samuel Moelius wrote:
> > +static const struct netlink_range_validation_signed cake_overhead_rang=
e =3D {
> > +     .min =3D -64,
> > +     .max =3D 256,
>
> Both Sashiko's complain - these values are neither safe nor sufficient.
>
> How was the -64 chosen? It looks suspiciously close the min ethernet
> frame length.

That's how it was chosen. But as you've shown, it was not a good choice.

I would like to submit a revised patch that does the check on the
datapath, as you suggested. Should I send that patch? Or would you
prefer to wait for a response from Toke?
