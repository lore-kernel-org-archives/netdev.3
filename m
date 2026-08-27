Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6A9366075
	for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787854001; cv=pass; b=VE72UFCJ9kwWFmAM1axLkyGb0lT4uvKUFm4dQhJ0bqIelkBXglmSePer54c9K9AXVlv+wTM13bjRaBEJry3MjB07y57LoHn+gGCU4tBL5MUxqzHOlQE9KITPUT8NZyDOw141RE1Z6yMWcApneN6mSbdDQ50HhvYGRTKf86AnGgc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787854001; c=relaxed/simple;
	bh=LpHBYoHMdiPAajZy9sdCErHDZwuWgnrQOGAixrVAF4s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Pjc8j1N5mIPni43CpdsqdJFPF2otWjBq+7jMX408YL4e49+e0wrPK/QC16KNXoVx6vzvyUl6YN1BVqFJAtb0TsVLOECMEgD1N32efKhhy2BdWa2u32eWDYvnUZLTHn9N/BujhUCAYzy8oaFckCVzK+gj0ZmK1nQ805+YdVWqh9k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FLDVAU0V; arc=pass smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FLDVAU0V"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a18840e2abso41509a12.0
        for <netdev@vger.kernel.org>; Thu, 27 Aug 2026 11:06:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787853998; cv=none;
        d=google.com; s=arc-20260327;
        b=gGo4xLLlwEWEuGqXcrOuW+3TrvHrFgnZta6N6zTSXzLWttxL78NFfY7NhbTgJ2u3OY
         GT8kREUQ3TKJfChZkA2JvGXGdDZ8FxNUC90MEfQI7lWHeb/9zZv7iArwFfG/EpW3r01W
         jR9oBeh+PF+WiZiddN4GyVu3qlGxkjLdZumCeVge/nWBN54IZAKMQOMj/3nGQIDII4Ns
         xv2YiiN8DJiFmHusfPoOKj1d4Xfnas7o3/049b+S2Rsa9pYpjrx5trDax59ZhE1iA6iA
         8hJ1BR8vNYaOWnLG8bgefKDcdERulx2aNa3wwlEz2K0bqwqcLmD2y1n0WdOHBNKLHfni
         S5zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=BaRKrIMZE6CzZHQFer6xDBywTcO73BRi8oQHQ8vhuLg=;
        fh=kahni9W3xYJuHWndbBo1/XmAshQKzIls8oh1sv9E7tk=;
        b=E3/zQMawaJJH3nyyrF5rkaFo1D2Ymyq9Wm3pODG16c0BaHeyrVTrV8w67Xgso4gNMD
         appouSxXRookiUy7hNi9oUwISwvZhXanbTQ/OF1ReCrUX/rGRdgc+LFSLCHJHCy0xBwm
         xYItFJeL70Md/WUtsoIZG0Ow7rNK6gwYUWv+4k3mm4VnCgXO67y/WlmMym3J0Fu+TEWz
         TvAGZKMnNL/UixYd7b85l6d779/u7Df6vjUKx+Bq493D510oP3+fnQWrSdZ/u/dM35gG
         zAZN4m8bXLrojriks9pXiyiv/xaiQ1kbdx1mGzLzhPGFW5jvQqiICc441Cz4vGY0Qq7K
         CLVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787853998; x=1788458798; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BaRKrIMZE6CzZHQFer6xDBywTcO73BRi8oQHQ8vhuLg=;
        b=FLDVAU0VKK4IrNhJa0iPCfdvmBhzRg9Noe1g5/K6dWDsmHblILi0+43TdVYSgVFoCD
         fdX2pInkAQV2rvtpiTGDMCl97OqX/NwMv+JmVj14BzktNYv5tqGVdDP8yJmL1aeVs5Ny
         OFXxHbfVWDIOcwT0RKah7OouVUVpVCKapl3b7ng1P0I0ZtsjKrsJih+TeRbqC3amYaFn
         kpoI2SQsZnsU5HK7TeEK20Hr2tkrcGJkkvRCMVXdq9M6LatTi2jDQ1cqTKfpQgvhnrX4
         a7Bz30ACJrSQFVuc9wfJIIEOErTfdeE+usZb385B7uaG3kXc1hJpaNJbqVlRui2+AKPY
         826g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787853998; x=1788458798;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BaRKrIMZE6CzZHQFer6xDBywTcO73BRi8oQHQ8vhuLg=;
        b=fPkCskBN6b3zf3Bhz3PP+tde4YbI4YOqUdAiceWRVL1HI/7L0Dl8xo0vpybxBhppLA
         EpPP15Vixy/xgzq97R37Zm9wozDJcSzxoovd5KorP0y8ScsRnE/1gIs1oh1ayhwZvpzd
         TGRSMPbyMqLW/e5h6uM0CkYMq1PdEc5b//z2tzJA6C/DWRbR6SIxLqsgkPW+j/VOR/EN
         2UKUEXtcFLSN0APumiQMnQHvoyuK3ajrv9Da9GkXAtKl8+2wuPuOtna0ICGl8zEHQ9al
         y9rXUr4EKyp7Q9CW+/XV9ybLAG/Ivj9ftnCSUjWPzro1VdSF3kVcUdcBPOPhmdYzxtZC
         sL5Q==
X-Forwarded-Encrypted: i=1; AHgh+RpwAqbF6d1atnCynWQx7xGNRwlzFvr2j3BwjleBa3uOvhPqlsAyKEM2m8PGkYTTYQpe06mScTc=@vger.kernel.org
X-Gm-Message-State: AFuF++kVs8lpv5XZnY2AiwuEQRZFnDHDegXbQRrzEqU2oGD+G/XNs3F9
	gDlSCBX8zIASYH321NA3HMteC2sEZI6qyRTvmVCZD6TiTVoz4dOeRQ12bkXV3dhUtjBEJdwqk2O
	K3vb5mdqHn1zJx9KeNo1kYD5Gerx+WMGZthHhE6k=
X-Gm-Gg: AR+sD10wOm9kHmQxR8uM03cHxpunBuc5jzVgYUTT0TOTL8rZzD/ZYtut4kBNeVoyAtW
	Sxk2/fqFFkYhoz65YPO00s1aW/4jI6EyDpjFcFIcjvAPOxoqtSC2XChNBQZI9s4ZtkfvJPxwirM
	3dXrZGWHIXIfFoYD3M3E+QzfTRqGMszmgl0qhnCh0xlwZXQeETCcGfzNMQRQsVGk48DFzlbFy0b
	GDiiIuAp2VDJGv0UN6Oo/xpapiJjBy6bzDz9w/RUtmtrsEbkU+CUGys0uUe7sbsRGz+Oqgrd7Ul
	446ta7nD7QsDriApyaRZp20i6lnbDPC4fcGYgAh7WX+VL9NfN9/V2LTm1qszM7NiVd+9KbdnrG6
	syjUp+vhNs1sHTNGnuoc2lyqIy+F3vea0Zh54uMETeUcawzJOKQMM4nACGJbX
X-Received: by 2002:a05:6402:218a:b0:6a1:f95b:8cef with SMTP id
 4fb4d7f45d1cf-6a60d307486mr226383a12.4.1787853998162; Thu, 27 Aug 2026
 11:06:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAMSTZOnSYZjqj4AyBpLg2hQfRs6JYZA5H26MwQ+G2WMGgNzBkg@mail.gmail.com>
 <025FFEEC-E57A-4C74-BF1E-D273253F4D9A@gmail.com> <CAMSTZO=2dm21hYcKKeDGCTb4KJ6R0ukDAFBQtsp4QVzPmCfcSg@mail.gmail.com>
 <1EF6CC70-90BC-4B9F-9F96-9DB1F3A69F1E@gmail.com>
In-Reply-To: <1EF6CC70-90BC-4B9F-9F96-9DB1F3A69F1E@gmail.com>
From: Mark <markmunene827@gmail.com>
Date: Thu, 27 Aug 2026 21:06:26 +0300
X-Gm-Features: AcwNN1WCDMEpxuTdD1sfPSRVH8kzJ5Pl7DkCB7LcSGYEaQVAh2cdk_LQ0bAeKYI
Message-ID: <CAMSTZOkWe9C2pGS75zX=_H4_Up6B6qSddkUPeaU8=br0geh-xA@mail.gmail.com>
Subject: Re: [BUG] iwlwifi: Comet Lake PCH CNVi AX201 (8086:06f0) fails with
 error -110 on warm reboot
To: Bohdan <boulderobscura@gmail.com>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Bohdan,

I ran the test in a clean live environment running a modern upstream
kernel (pure open-source drivers, no NVIDIA or out-of-tree DKMS
modules).

The behavior reproduces identically on the clean live session:
1. Cold boot: AX201 initializes and detects networks.
2. Module reload (modprobe -r iwlwifi && modprobe iwlwifi): The driver
fails during the bus reset sequence and drops the device.

Kernel log from the clean live session:
[   72.114520] iwlwifi 0000:00:14.3: Host monitor block 0x0 vector 0x6
[   72.114522] iwlwifi 0000:00:14.3:      value [iter 0]: 0x00000003
...
[   72.114548] iwlwifi 0000:00:14.3: Host monitor block 0x22 vector 0x0
[   72.114566] iwlwifi 0000:00:14.3:      value [iter 0]: 0x00000003
[   72.119890] iwlwifi 0000:00:14.3: probe with driver iwlwifi failed
with error -110

This confirms the issue occurs directly in the upstream driver's
CSR_RESET and Host Monitor polling loop during PCIe/CNVi
re-initialization on this Comet Lake PCH platform (8086:06f0,
subsystem 8086:0074), independent of proprietary display drivers or
local distribution configurations.

Please let me know if any specific kernel debug flags or register
tracepoints would help you isolate the bus timing issue.

Best,
Mark


On Thu, 27 Aug 2026 at 20:47, Bohdan <boulderobscura@gmail.com> wrote:
>
> > Hi Bohdan and Boulder,
>
> Both are me, for some reason Thunderbird on Android decided to use "Bould=
er" which is Google account name. Hope this won't happen this time. Please =
bear with me while I debug identity settings.
>
> >I tried testing the mainline 7.1 build directly, but on this Precision 7=
550
> >the generic mainline image hits an early boot panic. It looks to be rela=
ted
> >to the out-of-tree proprietary GPU module and its initramfs hooks, so I
> >wasn't able to get a clean 7.1 boot on this installation.
>
> We still can debug this, but you'll have to blacklist the drivers that ma=
ke your system not boot (and lose the graphical interface in the meantime, =
or rely purely on integrated graphics during debugging if they are present)=
 and try iwlwifi through the command line. In the worst-case scenario, you =
will need a USB with Linux distro ISO on it, and a guide on how to use chro=
ot. Keep track of the changes you will have done, that way it will be easie=
r to restore the system.
>
> If you use NetworkManager for wireless (you likely do, most Linux distros=
 do), you can use nmtui to connect to Wi-Fi from there, which may be useful=
 for further testing.
>
> Hope it's not NVIDIA (it will surely be NVIDIA),
> Bohdan
