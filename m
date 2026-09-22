Received: from mail-yx2-f42.google.com (mail-yx2-f42.google.com [74.125.224.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F70648E0C1
	for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 18:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790101523; cv=pass; b=L6cG1E1gRVEnF+36+/4rijouTxFFkPudhxzeUg1JemLIWMv2wQ6FSk/R9pvI66m3b1evEkduu0iaIZP3LIgyFXJhgna4Y7IihgfUidcupDqKLmfTuXZ2Ac2GzGetpu6MPS8svJAQ4K4yd0ZiXVRQd3HVZ7uSCQKBYWYdqbp0VQ8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790101523; c=relaxed/simple;
	bh=V0dB/2hLh2BY18gu/5VxbqVPnFHEO7kUHoe9YwYQ26o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mwZ7KEJOMEf9HmrVD2EW30pZlW0lIO8mnrKh9Q5yXX6Eac6vfjPd85Nvr4r3pryE47eaXSR51zjvaBqiWXoWENhxWuiSZ2tHxVsLLj/rKeuAzBIu5ZCc9PuDqr30I3eNteXkGv1hRKgT+bL9N4/cU7siR7ZGsR6oibnJaIsx3FE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZaYZ3Ut3; arc=pass smtp.client-ip=74.125.224.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZaYZ3Ut3"
Received: by mail-yx2-f42.google.com with SMTP id 956f58d0204a3-6729ca45e37so149051d50.2
        for <netdev@vger.kernel.org>; Tue, 22 Sep 2026 11:25:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790101520; cv=none;
        d=google.com; s=arc-20260327;
        b=okrmPuDk/iDdKFHXJVcOOhhamXVBDjpjiokoiro9qlXLE8v0kwHcAgk6VBpSf75hC6
         H8F805Cedkb6X9nvNxGD/w7ChA2sZuVrjezlfpsqFdF6KlC6zhYcWr/WZ6mqpzbTPBJH
         fFtdJvovDkUEIVK/3/QbRUEr7R6/17qRtUKtfH9KoV+Sqk97+IJJK0QP3GJNudfJUriK
         RAQRsvBpRkA+u9z1EqTZ+0JweF+ZWNID/ZjOixumWaL3h49HwMl4A9DPtRKYuOfu92Zs
         ALBVKzJybM8XLtHikGSW8hK2wN4dVXOaVY787JYtJdZQbmUzjsKOgxH/zqoJ67TqZxQV
         Wccg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=V0dB/2hLh2BY18gu/5VxbqVPnFHEO7kUHoe9YwYQ26o=;
        fh=pVXaPI9hC8+1ghpKKRc/xgDsIhHDPKnBroJJLrR6pKg=;
        b=LV9AaPId3ySzwnNPpYGwcSE2Dy47vKH1hRjO96dwuc1+iEtjI9KuqB2+Jq4l8pwn85
         rd538l8pDYdpyYnTKrW9U4lRjr1K4W5W4emBjWVS/4GgLdZsf1LRh/noepisv2rlTqcJ
         HAEbYqPytsy3xXehIFATk8IDvjMY+FzVcV3XwwV/zWtvnKDoC7R3UJ7p3pQIbAqp5kRF
         TXJVS1cUNMwHKijR6q1hwx45y0PaRIUqlqBwMiOfeMuAoDnKoP4vJgyUnRmvboWfDsee
         Om/2UNviWIc5cRgerZWfS8amN5o+8iF4z2SvsysF2+oqn7ML5KlqrPCzrbz8G5/tlXdz
         iLmQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790101520; x=1790706320; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=V0dB/2hLh2BY18gu/5VxbqVPnFHEO7kUHoe9YwYQ26o=;
        b=ZaYZ3Ut3aJMdUl3eV1GZA6DDidQey7eHo0s5JCfQJgmIMPdBAd17eumcVPpM4zACg+
         rQltV7qFbuI+yqJVImMd2gm8DwH0fWFBOCVJmu/e6ZwvIXYS+fbT7Tu3sxA4RWoSXQKd
         QdXqOD4Qt2O1gCeW/qj0fpJaVSyk7EYOfx4Di7se1Hl3nSfJ2yhMOiR7pZ9z7Ng5jwSZ
         u5c8PcFNjY/k49EgHIQk1rXSSIIOBjYm5ZXYYpltkAu0y863Yv3iZiUwnovkRhIn2+OK
         1Neh+yt+H6xOKsf4mySkUHbUtIqHVmAV4m3u21n4yzEWEAnanXVqvMP29mAWNj5LONmo
         rziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790101520; x=1790706320;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=V0dB/2hLh2BY18gu/5VxbqVPnFHEO7kUHoe9YwYQ26o=;
        b=WP3vwHa1G+Wh9SrpsP1DVu4ERQLYbZ1biJRxgV4S1URbEK1TRA9qvoy7acFWlCJCgG
         VaVRRNZZY08gF8j23rfnzKD428GYEyaQZw3ocA0crkWaKslDLf66fIhcNWoN2ExRIHQ6
         dPHAwFYlshUDyj7jw9IY49dklFMeW5B7YkO+tXaf6M0pGm6k0mQM39YN1sVyRrUcx51G
         Gs96S6kMG8gM8L5K0Re3kUFEOQeWFNfGDSQoj1kNCzvq3RUDtmM7QIzwXbJgQoFok6Og
         LdErQW0QAGYZcIsGdoqfFApBwF8W7/h8yNjtoBVl7ZzNMgIdg0qBG2ffx/8LRTMu+AF1
         31fA==
X-Forwarded-Encrypted: i=1; AKwUvBw0wDfhqDx7jHG74Iwec/nMCN5cTAJzlqdsLrSOJ+cyIPoaUf5sdDJQS3e5EI/91jj6u3wqmEI=@vger.kernel.org
X-Gm-Message-State: AFuF++nnqCPRDttdN4LPKI0nUPMQtxhmNOFiIVqgrZIE+Y2InxqTt0M8
	DTAV0JfB2BQKXZs5GCb85Pv69qAbyY6NQWHX++fQHnOFuD6yHXcNtkLDWjmQ29INvO7qB7Y7g0I
	aBb3c9a/JhaTWEikJWztt5FsNQ2RPg8g=
X-Gm-Gg: AYBFou1x9PtGs34bePs23VZpbMct6uXqhjQpbZUHL7iiXhQnApm+s8XCsdx6dXhg9Pa
	4zTXMv+xHy8i2abN6488lvZtHl8NBAhx+fmwW/fxyU7aT6SzPmokc9K5QBD/wZuiAXNAK6zFKL9
	rqcs4N5D9nyEc3n8raSGSk0c2igZcI3G0DsYr2oekoG6fMBU1BFZlXRw4seLSQVmMtxP7nbxVHX
	dniQ/yd4JhMANZPnNJIox95Ql2Fpl6SYtIdCgKG/Laiy34XhCXU9ytFjAwwisYqQhz3yh9WlakY
	ocPE/EdNNJIIaHTs8MpKmy6f3L88gJAAWo6i17V4RjfMKOIK9YZM2Bfil3ek1jgO+xKfULjocL0
	vyiiAy16lMDnZuaJwiMozC2bdYWcx9A3qC9mjBkSGfp5Wwpy/NceNt0RgW5uZv38RBBQULgU2Rp
	Omx+f8s9cfB7E6WGqhewrKzk1GLXZAWw==
X-Received: by 2002:a05:690e:144f:b0:671:2f98:1d4a with SMTP id
 956f58d0204a3-672d57ad1b5mr220702d50.56.1790101520428; Tue, 22 Sep 2026
 11:25:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAOiHx=mJZKk9dT93am0o58Th+yPo2aGj6T4aFWkyeQphPwu4YA@mail.gmail.com>
 <20260922174801.261426-1-chrismelnu@gmail.com>
In-Reply-To: <20260922174801.261426-1-chrismelnu@gmail.com>
From: Jonas Gorski <jonas.gorski@gmail.com>
Date: Tue, 22 Sep 2026 20:25:09 +0200
X-Gm-Features: AcwNN1UEvy6TdjYYAWkeuYOPQ_NK0GTqepljOJUu3EhCkadF-JTRqyfAGfbDh9s
Message-ID: <CAOiHx==_ixY-VNWX=XxqCFoJvE-80i+r2y6SNnxwQe9uZQJL6w@mail.gmail.com>
Subject: Re: b53.rst: is the 5325/5365 "no tagging support" section still accurate?
To: Christian Melendez <chrismelnu@gmail.com>
Cc: =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, netdev@vger.kernel.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Christian,

On Tue, Sep 22, 2026 at 7:48=E2=80=AFPM Christian Melendez <chrismelnu@gmai=
l.com> wrote:
>
> Hi Jonas,
>
> Thanks for confirming!
>
> Quick follow-up on the "configuration examples look horribly outdated"
> part. Once 5325/5365 move to the tagging-supported section, the single
> port/bridge/gateway examples further down only apply to 539x/531x5. Were
> those outdated specifically for 5325/5365, or wrong in general?

Looking at Documentation/networking/dsa/configuration.rst, which has
similar examples, the configuration examples are actually part of the
"without tagging support" section.

And since "without tagging support" doesn't apply to any b53 switches
anymore, the whole section and the configuration examples can be
dropped, and it doesn't matter anymore whether this is (still) valid
configuration or not ;-)

Best regards,
Jonas
