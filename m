Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C68AB48425A
	for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 18:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787076772; cv=pass; b=rJBCU/l6TefuLVVuE0zkHEwR+wTqSeHD6N8zVwltAKD0gJZrZcG/N8QKcjbnVSM6Gw0RVZW7jre1uBeMysIFser+aX2FlzudgciF7W1vyCk6aj2uY3rWMZLgdkEIw63wVz5mO2AvWOetzxESwP09ceb6Y53WNDoDrUCawpUbEx4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787076772; c=relaxed/simple;
	bh=B+nSapg+VaNPr8DnhnnL7hC/4rF/jenHxFH+cPq0Tb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BkfeqcBkr6mx89+TWQ8iE3xeamLkYHsR9GYGVg/o3Oul4n4L7TDcugk+f5KsgHHQrLIArOkl7oGZBN+/jUuCa04DhbePWhKIgJqUiqrwqI8GQ/2YM3kYonJ6KAgk4joRTyEfagImMewg59pTAcGN99gZsDaNXVgnHOY0SWZI7Bc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cI9EFXIq; arc=pass smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cI9EFXIq"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5b01cb18515so223244e87.2
        for <netdev@vger.kernel.org>; Tue, 18 Aug 2026 11:12:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787076769; cv=none;
        d=google.com; s=arc-20260327;
        b=qWEvLU1iaIZxYcaNsZk0sAFP83LludF3rGVNxd4/abYPIY+DIFBFg5+HnkH7/VVuk9
         vO3Od8e5RRZff61YpdLj1FVgqiUIqvLzYmTLdq0XCuzuKxT0E2p1UN5u6v3xNiFpcySi
         Khb5khdy4skz+ar8z3Tibq3qxb6QWgGc2LHzZgdphj/vPP0E/uTSMfM1phIeAsOSNJeL
         6+XmoFe1neDKlKmNvFh7ibk8Az9wfjFjl4dJvxNyqlATBWXuNKPZJlEx04917iz803qS
         zEhKgiIa31L8srE9NPieHrjgJOGp3An9wO+KNC967j5xjZhXYC/rB5cVSMzv3G6n7Avs
         he/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=B+nSapg+VaNPr8DnhnnL7hC/4rF/jenHxFH+cPq0Tb8=;
        fh=1uHUFJC9A0b0PJrXSiu5aJp/GLDnr7zj28CZ96VDHAk=;
        b=YubYfPgzQqfoe3FFCKIBmE0wKpkt5ipni7VUNkO01ewX5m+nvTaGpxQTWvM1R7OV9V
         8z3eLVOfv+9D/pXG2IReeKztoMpqzNcbLlmNf2OGG74GESfqcyDVrVSAxLa+gGAvpr9I
         1PG1X+ow4zo5+zQhVyrCZeKB90Amvpoag2lDrwcaU6j5/e1Vi0bzl1KSeH96S3IK3apn
         mJnQo1i93F/fGUnA6vY/DvzKMcTToB90HADeBqzFta7jceBuqLdVHp1DKqHrC4fcd04s
         MXk+5L5OvHNd2o/9lXmWapgNuyziXEHx12/5akuDK03HRaOTHt1hfa65UptK/ZS/Ecpr
         0YqQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787076769; x=1787681569; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B+nSapg+VaNPr8DnhnnL7hC/4rF/jenHxFH+cPq0Tb8=;
        b=cI9EFXIqLZtxOwbcPy1n/SwOyM97CkaCGCO32tIyKapOrco9zYL8GSxSqEz+0pdZGl
         eRdXau6DWUtlljJX5siu+Qa4bBcPCG2x78BsZc/yP3+b9T8627tXDp96yST3gpI5hvZj
         caDeUzz8f5mECkDvRl3hldBuC/OB7cRpdQoNHql5Kr6EiWVncMXq8di57OMtoeMBexNt
         YG9n/9LxlrQKTaFLS4JgSd+h3XKqo0PrpL9w6SClRm4TrP3HGB+bmyC5bInfa9fMZ/vg
         J8c1uHVEz2GO5NlDvOb6H4HpGMNfjXOhzQLinkPd0kTG5qQOn23C2UQ7MuzDFev2+ayU
         hdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787076769; x=1787681569;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B+nSapg+VaNPr8DnhnnL7hC/4rF/jenHxFH+cPq0Tb8=;
        b=QgdxyzeCUngi0G5TCqPF7iffHwE2GgyKYnHhgn5xMo2uLDSTY+9+GJVwGXdap1Szn4
         lV0ecvir7UYD4BrhRcmzYC7vSuVryaLofP0xe6TOasIPuIo418uUhBCGZB2kEJ4deEqQ
         nWwz9rcMK8JB1wDBhUw5EFJv1rnUZmP7arkxEphIiKFzsIQFccvH0ISOZHAifw9vYLk6
         lhQCOh/VqBAAL1Q16ezOOWtSie/kjMMSbnNV2ONSxwpKPkoYLH9fkW+v0SJPdR5GnML+
         V0bm5aXcl6E43sMtiemF3lwBGkncE99bk6Fda9w9DqxO2VuccZDh/A5h6GVyaIZh4kLY
         5p8Q==
X-Gm-Message-State: AOJu0YxCIV/Fm/1l+u5gyRMX4Glq9Yy0EV99CG0XwnVlZ4Cx2qvIDC5i
	bHT8axBnjDraWo6+j6hRmtUHKeiZV+bbRCIIwA/Nnu8PT9nF2lTOU9zJQA1+F9KbXHY1mLnaCKu
	/Z2tpo/PVR2RguJT2g8nNMW6HrWcky+Y=
X-Gm-Gg: AR+sD12gpWjQKrjPd1noq/Qy7NA9CIEWJLuTOPYPISJnxsyB1NmJqj14gUtE2nIakoD
	FBk1qX9XXLUOogtbxNwdvufHrLdTxm0C70Mj1HqMSu59SIgbYG6MipFrH47thSxf2CHQz4CECAp
	RW8aqJnGqhBcLZ7Maem7f8tMPzpkV178gK+5o6KPsfBw740dHendrcoffHJydc2VOchCNl+cVBG
	OxsrqlVWE456NIbg0DJ6vPYAD46Ci3HOeOqVlzEcrnjaspYiuUerX3NOzk01CSAk0F9I6yvgBDD
	LrjvuwOj1mn50D2RonJX53ghtFZeg887p7hqLw3g2BpW9ZKbnmRALU/R8Rso7ZqGgR4OPU7lHPn
	ZNElcbA1RvZgySlNCk10/IGTEeg==
X-Received: by 2002:a05:6512:10d6:b0:5b1:5ab5:ea09 with SMTP id
 2adb3069b0e04-5b477c6091emr111830e87.0.1787076768577; Tue, 18 Aug 2026
 11:12:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1786746757.git.ahmadexp@gmail.com> <20260818095654.5357db1d@kernel.org>
In-Reply-To: <20260818095654.5357db1d@kernel.org>
From: Ahmad Byagowi <ahmadexp@gmail.com>
Date: Tue, 18 Aug 2026 11:12:35 -0700
X-Gm-Features: AcwNN1VFdbc7wToCDqu6OVpR2tD_blBihPQ30U0mvdmP813mFMsjtyFeEMH6kL0
Message-ID: <CAOQiBWM57ZBafMcj9MaegHBuM21313O5PqAAGXdHfvmHxHp48g@mail.gmail.com>
Subject: Re: [PATCH net-next v5 0/7] ptp: ocp: Add R4006 and V9 I2C peripheral support
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Andi Shyti <andi.shyti@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
	Nam Tran <trannamatk@gmail.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
	Richard Cochran <richardcochran@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, Kees Cook <kees@kernel.org>, 
	"Gustavo A . R . Silva" <gustavoars@kernel.org>, linux-leds@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Jakub,

These RGB LEDs have been part of the Time Card hardware since the
original design, beside the four SMA connectors and the GNSS inputs.
We never had the opportunity to add Linux driver support, so they have
remained unused under Linux.

There is recurring confusion about which logical SMA number
corresponds to which physical connector and how each connector is
configured. The LEDs address a similar operational need to ethtool -p:
they help an operator correlate a logical interface with the physical
connector. Their colors can also represent the SMA input/output
configuration and timing status, together with GNSS fix or lock
status.

This series exposes the LEDs through the standard LED class, avoiding
board-specific raw I2C commands. The generic LED controller driver
provides the standard interface, while the board-specific status
policy remains outside that driver. The second GNSS LED supports the
card variant with a second receiver.

I should have stated this existing hardware and end-user use case
explicitly in the cover letter. I will add it to the next revision.

On Tue, Aug 18, 2026 at 9:56=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Fri, 14 Aug 2026 16:10:48 -0700 Ahmad Byagowi wrote:
> > Add the generic LED and I2C-mux support needed to describe peripherals
> > behind the FPGA I2C controller, then use it to instantiate the R4006 an=
d
> > Time Card V9 board topologies from software nodes.
>
> Ahmad, could you explain why? What are you going to do with these LEDs
> as a end user?
>
> The influx of the LLM generated patches has a hugely negative impact on
> the community.



--=20
73
With best wishes / Mit herzlichsten Gr=C3=BC=C3=9Fen
Ahmad Byagowi, Ph.D., Dr. Techn., P.Eng.
Phone: +1 (650) 924 6653

 Please consider the environment before printing this e-mail.
