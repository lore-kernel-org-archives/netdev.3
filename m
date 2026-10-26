Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793054553;
	b=GmZjenBB0NfJWHwIBrl6egHpUER/kNJStRf1F+5BUUTCGBpy+XzMfjGCPMOn+ICYjxmB
	 zEYwFLre4O2ZGmb9sHdHWeTzdczESGJGvmy+zBRyzLUQFjzjz5Ug0P/F6hpxUQ3ql9+bX
	 c3oZgHHkKphiQy6GWEK6Qb8RRQQVG7NPyxqsDtp0+v4PYWgTVj+00zKRUmvj8Sce/nRZv
	 l0KRr9/syQRUW5vmPoSbxbxWC7OSisbC6L1MP2JEttnNURb1mcnU0A8ABKPy2VDqw2258
	 GoUCe+MVyCihARhBOELphEBmT5AHsgPEsnzCNcxlx81lkdnRwoVMVHKOXdUGCOHS4zg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793054553;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Mime-Version:
	 Content-Transfer-Encoding:Content-Type:Date:Message-Id:From:To:Cc:
	 Subject:X-Mailer:References:In-Reply-To;
	bh=FA3eo9Ml5dMrUZqSyy99rnSaNT5Gvkpu1eGh6dR+CIA=;
	b=r4BldNBvOJShdhvIIiH6u9bjZ2+JlRqQb7FCxPgbJXg7C8HWiR/5UzFm8amb2QP3ofGf
	 rWVrDmp0M3z7GZ3Ih8rDys1dzQXk7Gqxus8ZoPQmjr6/TR6Nab00QetKUGM7zKwp7I6J/
	 GhHrpsgKmHA6rCDkRE0eFsXEVokwv6ctGitIfqwmIlNcvIqSKzuGavBiLxEeGwunJliDl
	 y8PaNWhNch5/8ByBmuR3lnpule4p+QlctFmKfbR74RV3tm4XzIwcHM3rX183rYpGzYNc8
	 j12Pj3SYk71Cm3x0YZHqidP+Pepzg9tef//iJONckJZAzcuT378yQW4tgjS3en8GkvA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pURyyqNk;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D18F606A321
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 22:42:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D18F606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pURyyqNk
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a20a37703bso27180305e9.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 15:42:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793054551; x=1793659351; darn=vger.kernel.org;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=FA3eo9Ml5dMrUZqSyy99rnSaNT5Gvkpu1eGh6dR+CIA=;
        b=pURyyqNkKDHarBqDoX2O5yAmjoxUoo0s3xrIN58Sa6ATNJ4JBBCpAogmB2eIbqm6zM
         2CXNvIxCfGpNzXlKJct6dBNsJbpDZOz1zvp41eNlNKEoeBMEzgN3aOvnC9slmy1QMJzs
         ZQdWZo0/soNsaplv7BjmwAFN0mA79rSbQkxcSyd+FXyOgrRMv9p7rTdwvTTv1nmbZyvG
         WVJ6Pri0pmz2rSGVJQIM6EswrqwqcVGzq2iYZJCTAVmWKCn9YsGaqgBvqD60gBR+Bjuq
         wCcXNIKlnNKSRG8MhECsh7kK8bgaJ/efa+EYMrEzzcVa4vbJiKPOsL6KjvygNmHDLNfF
         21KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793054551; x=1793659351;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=FA3eo9Ml5dMrUZqSyy99rnSaNT5Gvkpu1eGh6dR+CIA=;
        b=rVgVP4ROz5lKBTgoj6FNvGUK8v7rlhJn5R4D52typEd/YZtWUhmmq/MD8lU65z+9K4
         9IJZA3z/zvdJ+6fWMlrE6Yt0WnkfXVo/Txj2KtkkrQm/IUohSBhP4n79SJfKRxzdnP3O
         VMZnbeQRb38x6gOTktpOQHo0kHL1Q4ZEpyApIKtSblxAXY09Bb8pkWfHBxxZn1oymepZ
         TXABYtwKMVzlTZeb2R+WQ6c8vevfBeHVlscOoOc5ENkHLeSXUT8zYkI0Z/LAe9gcTKNi
         dZUete3m/2MGWTya2vtX0pMjuL6CjLLWIPPBSdB03iZyTz1mfO/yFYZoLkKMmSkrVHdC
         mEhQ==
X-Gm-Message-State: AFq9FYL95di3Ozva6+eEffSmcD+1pXw0CWP3j5dSt6/s3plRW4h8JqHP
	EY8nGVeOfJfNQjpAQlYKi4aJlgQTDjIhWV9XLH4p48wKo296rhnftR0Y
X-Gm-Gg: AYBFou2IT6ZQg33QGdUrfFrgkafn02YBkFoReXQKO3aQhIM1flo89LzSmEYFtrnGoA4
	uumtB6gjvv83PckImIq1H1vzpTrB/d6L9OyNw+80h8i7EOb9qTRdhXeZPBOpSd4pem0TkztMpvT
	sr9NRiQUvPnUdeeEYjGfDEY/Er/fBVVVexv1mt/uN5rJlKILuywbWBqt6C4WLo1ivNYtUXPXZFI
	1EMXdFo/JDlzCIWOKP7d9frcO1awkcv1hRvi5rKgFVRNLjTEzjtN7cFs/KXF2XL6BM5k9G+fyEJ
	dfDcGnwZvDKjQbj0JB6ftvCguNiP45i0Uh/8M5UP+E+9uiOF8qmHV2KJTsRfScYmNNfPgElFbIz
	DCAcgUOz9m3etk+qejg/jWV/Sl1mk3EXczPTp2WOflCQ2v4HrmmIU6mCIHP8loTFRnCwZC0lVxt
	WkJlvtWIWerlczfExDmqTdKsuyktDFTcWsKK0P3m9vuUgo8sxoYFA8jHtcyaINZF7ORANEjyXPc
	mhLCvZI/d7tdAumOlle3g2T6ueV6yPl4HxAxkzX+yP3vC/vzld3WCNe6XJfAkDGrvo7mznGlW7u
	j/yVyUvn65+lim5n0JjX
X-Received: by 2002:a05:600c:609a:b0:4a2:fd2:985d with SMTP id 5b1f17b1804b1-4a35ac95969mr132696405e9.12.1793054551580;
        Mon, 26 Oct 2026 15:42:31 -0700 (PDT)
Received: from localhost (bzq-79-181-189-120.red.bezeqint.net. [79.181.189.120])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a35a0bac37sm239054165e9.6.2026.10.26.15.42.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Oct 2026 15:42:31 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Oct 2026 00:42:29 +0200
Message-Id: <DMF4SGB80HC3.36K88VCSLPHHS@pve>
From: "Noam D. Eliyahu" <noam.d.eliyahu@gmail.com>
To: <netdev-bot+sinfo@kernel.org>
Cc: <netdev@vger.kernel.org>, <pavan.chebbi@broadcom.com>,
 <michael.chan@broadcom.com>, <kuba@kernel.org>, <edumazet@kernel.org>,
 <davem@davemloft.net>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
 <horms@kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH net] tg3: Invert restart quirk logic to restrict SNP
 power-down bypass
X-Mailer: aerc 0.14.0
References: <20261026220955.473247-1-noam.d.eliyahu@gmail.com>
 <179305291274.3327.7897598693564915611@kernel.org>
In-Reply-To: <179305291274.3327.7897598693564915611@kernel.org>

On Tue Oct 27, 2026 at 12:15 AM IST,  wrote:
> Hi!
>
> This is an automated message. This series looks like a fix, but its
> commit messages seem to be missing some information:
>
>  - How the issue was discovered, e.g. hit in production, hit during
>    development, syzbot report, manual code inspection, LLM or static
>    analysis tool scan.
It's mentioned in the link to the mail discussion earlier, I had
discovered it on my own Dell PowerEdge T440 in production it caused a
reboot hang 100pc of the time due to the known AER issue that my model
wasn't listed in it's growing quirk table
>
>  - Whether the issue was actually triggered, or is only theoretical
>    (e.g. found by code inspection). If it was triggered please include
>    the symptoms, like the stack trace or error messages.
Yes it was triggered the AER logs are identical to those in 2ca1c94ce0b6
Fatal AER event regarding ACPI _PTS and the main symptom is that iDRAC
regards this as fatal and hangs to restart until manually interrupted
>
>  - What hardware the change was tested on. For driver fixes please
>    mention the device (and if relevant firmware version) used for
>    testing, or say that the change was not tested on real hardware.
This change was tested on said Dell PowerEdge T440 which shares the same
Dell Firmware as the R-series and has the same physical NIC mentioned in
all other relevant commits (BCM5720)
>
> Please do not repost the series just to address the above. Instead,
> reply to this email with the missing information, so that reviewers
> can take it into account. If the series needs another revision for
> other reasons, please include the information in the commit messages
> then.
>
> The evaluation is done by an LLM so it may be wrong, if you think
> that is the case please reply and explain.

