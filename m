Received: from mail-qk2-f4.google.com (mail-qk2-f4.google.com [74.125.230.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A60F40488C
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 03:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.196
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789443387; cv=pass; b=hh/PDlqYxK0cb5AWJQf5oGEGnHHV+AMfMiDXZAV9jIj1Yj8YNr6EIQtybhL2qP514PZIJnXhX4bjsi+CF6agcxVoXESz8BIA0C7HRSFAY6qFZsLEPsTkUihydpq0Ec2g4vbeCUDLPOiKUFT5M7K5rSuTZPMqv85mSRT8uHapha0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789443387; c=relaxed/simple;
	bh=hZYMHGu9n2q61eOftzQIb/1nkREIqMgUQN46A+rGY6E=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=URVCP6oXMoAZqzDGKCsUOLBmdBpGj0ImJYc6xg0MhB0p5zfUTSHnYEPBfvdDpMg3j6bJx3gaq6eQIvErgE8zOZoCK05nSRrxG9hvnTEIh2JKngcNPB/0qIzJiUmMB61aebmJAje7dOE8evlfaJPtur5+XPxs1GDcktGPfsbaKNM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=njoDCbwt; arc=pass smtp.client-ip=74.125.230.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="njoDCbwt"
Received: by mail-qk2-f4.google.com with SMTP id d75a77b69052e-530e4e8c32fso18223981cf.0
        for <netdev@vger.kernel.org>; Mon, 14 Sep 2026 20:36:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789443385; cv=none;
        d=google.com; s=arc-20260327;
        b=hS7KmaXl32V0iIwlxNa/Xdclqv7Di3dXqcvBQrzQb9P29tuFW60MdJg89l+mce71Dz
         QDtRnTEhEWYX2YOY0DxUYDr9u96KXR5G1t3uhm5cGy4CndV+Tw1dHG1Hc4rzj6ALduug
         HyEiM0RzeijxGnyPPcMnc7mOb+6FaemMPSYbED8V2CvJQBrYsaeLxZbaNNChJUsm1V0N
         OaTsq7KLCPtihrCsnhfwyNfQQv6xoHxh8u7mY29ExhNi5FUhAudJHdMPuamis8/qaCwi
         H52VWBtJeZjT2kP3y2x1XDjJHGFYPnMamkOz32al/VdckmtBWwlNpaU6Z1tNvRhwLDNl
         025g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=hZYMHGu9n2q61eOftzQIb/1nkREIqMgUQN46A+rGY6E=;
        fh=D3Qeb0UqY3iI+WdUZGkpIAXRo7hQpDPckdl4MeU4ryI=;
        b=bImog3N6TI+8464A++sf1ZNyhn3N21+rBUTbbF7m2iiJ3lx789q0S9JMr6PdQmrcK+
         VPKk7Azo8qku6CW/UtStj3UkmvhTKnh9lUfKOH1oYJThdN3iVp7ZXCM38HAuG1F6XK42
         KNYvt6ev0iisY/aFoWoDBOMTG1lRUqP/VuRzUPX0eAkWPNqYQOfkc/auSDtB3fnkAeLt
         EUvUvE4tzsZh1kQWvT2Mm6+uTQiolPmGAKFxtWDroQ819rea0lfl5tfmvM0/6VpSjoGs
         n5Fl6xaYWgyZaCKmaavNucQBMR9R3cCKLThiXjvsjMvVOBzuL7txe0De1OK/IQrohqSM
         RxMg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789443385; x=1790048185; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hZYMHGu9n2q61eOftzQIb/1nkREIqMgUQN46A+rGY6E=;
        b=njoDCbwtKou8MdvFhjR14Z4/GuXV5OOn+4YpYUO8aj4dQvN20I8DJCLNNdWbNQ85Ay
         rZXmZujSaM/Y7mkIEnoAw3Y1ZKip3ID2ZSFrzq9rskxTPGbJNFG/7Bkz9kqHUmfam30t
         7ohKTgezY64IGiqvpZQ8nP+5IoHfcgSEWVuD5GyyGoVUOP/y4oKSva9zTZspvj0K1JWP
         AzyBxgQULVnOSZAUAq/04Ui4zoj5I8qqEJqpQjSyiifwiiwkPjWuD/5ibRB57sTaVbla
         EzJwwl2TwClsWAoomKzjyg1dieeE002NzaS16roRfyI9cm4NelUe+WRW+fnZCgjLIw0X
         xSRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789443385; x=1790048185;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hZYMHGu9n2q61eOftzQIb/1nkREIqMgUQN46A+rGY6E=;
        b=ujGiBbbJq85QvXN1NX4ciEJOk+wjn2tkqioKOJ3aD4NJWFaZVkmUdy2UUB0MoJNmvP
         ayE2styE1xUvu6PWMXZ6r+ypccgUKirTGSpafpbAeN3HDpiyek/RI5nF3QFWUDRaeCD+
         wsNzLaDtXM0v/Z0Byqy8YOJwD8XUG7j8OOzq9sSE/UtB8YGyC0HcCP9GtTZDcgGfZZbJ
         7twl9Ytj0MO7N1UjnsXhaF08Ok5KA0DZKb/3l4F/KVlUuqwSmJeOpUx1EcDFMNrF1CN9
         IO8KB9wCoHvmB/enUFXHUQ0rHHf4+UQoHesJA3JCZdSR0nljsdmA3yRjsDcZHIZCrCvy
         U9mQ==
X-Forwarded-Encrypted: i=1; AKwUvBxlYAbRHIYNwpMH504ctVUcbVc7AwfYwBw5LQFY3JfxrTLos9CwIXDSJ7fk+P6BBFba2Nak6o0=@vger.kernel.org
X-Gm-Message-State: AFuF++mL40It3dobQl9Ec3YTGtQP1lHrgkMCIwaCkGpX1xhgc7uxnnTd
	W37dxxbtNIjMr21jWTsgjO6hpcgj/nNyTn1iw8BgoBV5ZXluyErFtilacTJi3teqiFSA3zo552J
	8iCzyyjwbCZWCFsz0t/LdOoNXwYw5G4M=
X-Gm-Gg: AYBFou3jfRbsbZPyqFwyTT3eTPj0hCJYPTAiK6VcJPiIpsjd0vX2K1kyqq0YjMU80NW
	X+lXAZPR9bzs2BoLkMqvibkrqIq3grNj72/CU0n4JNiKqvKWm2cWHO6yaTa3GOxFV9p0rvZ0cDw
	pcIT39AAeFMZbO+i0teCrbI5nz9hT+xsSCFuvGjDfO7C+xrfuzNGPbnDzzi5O2lAPjWyYFSfvAI
	q9q0NpQqqlwI2ANTScHbVoSvb5Umtn0xQ9HKRIbr9UuN388rSWVn2PmyOQ8ZFfFp93hYZ+fdhZ6
	uv3wS0h7p180Un5sp9EIOqoCK/mQb7H8C8IVOQdDw+ttFsFcYnk0nWgDGSTEn9TsMNkkUwUCrou
	FRlBotN/iXvRJztQIwK3k9sCeiepdahvjyxpA6SLn
X-Received: by 2002:a05:622a:d0:b0:530:e7aa:ef50 with SMTP id
 d75a77b69052e-5310cf0df29mr78559941cf.4.1789443385492; Mon, 14 Sep 2026
 20:36:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260915024551.196126-1-enelsonmoore@gmail.com>
In-Reply-To: <20260915024551.196126-1-enelsonmoore@gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Mon, 14 Sep 2026 20:36:14 -0700
X-Gm-Features: AcwNN1WsoDxBDkSxIV_grc7mDaj8ge5NA65R7aljjtw8l1KlfRcbqBeeoekJG-M
Message-ID: <CADkSEUgUuoy4Kh_dp-LJDfEp3+A=YaNDnqgROq25xJHRiAv7rA@mail.gmail.com>
Subject: Re: [PATCH] net: tulip: winbond-840: remove never-true 486 CPU check
To: Arend van Spriel <arend.vanspriel@broadcom.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>, Jijie Shao <shaojijie@huawei.com>, 
	Petr Machata <petrm@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig_=28The_Capable_Hub=29?= <u.kleine-koenig@baylibre.com>, 
	netdev@vger.kernel.org, linux-parisc@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Michael Grzeschik <mgr@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 14, 2026 at 7:46=E2=80=AFPM Ethan Nelson-Moore
<enelsonmoore@gmail.com> wrote:
> The winbond-840 driver contains a check for boot_cpu_data.x86 <=3D 4.
> This field encodes the x86 generation (3 =3D 386, 4 =3D 486, etc).
> Therefore, since 486 support was removed from the kernel in commit
> 8b793a92d862 ("x86/cpu: Remove M486/M486SX/ELAN support"), the
> condition is always true. Remove the check.

Oops, never true*. Should I send a v2, or will whoever merges this fix it?
