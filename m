Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C70037FF6F
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779526524; cv=none; b=tIoNnN/yKuhjGfg6rOOa/GBIk1Kc/Up4Y77Eg3rEdVa4h4cLHHysJSo3UhDEfRfDmYHJUA0d3jUuQeFl/cwTQ19Zjs5ko8XQiQuBHi5ud0bzKKahuCViubBZiIZP1NtFdUrN8LkKL+0DvWj4Q/QFTQtwxBi/KbkjNIWQZfldGKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779526524; c=relaxed/simple;
	bh=MK+cWt2+dxm/Zy157E3RgM1a8/njEplSHB77uhH6MPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXCh6o1tLzMGkSmunK0EKyUp7V8rY9we7HvWnAJmKZhn3hYebtZ3CL3GztFfb7VJbugn5SWqoRYNT7ss9FCLNI0PQ2auPeoWHwt2p0Wh9aktxJb3HHVtBB11ajebxYvHujSfXvczBrJAP2DFwSHt0zVdueGwS1ynOYCc8rmirxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XKZW7Ghb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XKZW7Ghb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1D7D1F0155C
	for <netdev@vger.kernel.org>; Sat, 23 May 2026 08:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779526521;
	bh=MK+cWt2+dxm/Zy157E3RgM1a8/njEplSHB77uhH6MPg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=XKZW7GhbmHdscqotobsonq8zMhztCKaxdIYQixUj63ipAK18X9CBnf3PR3AnE8g6L
	 QiSmzgLcTKp0RwbTQn7dx+AMMe1MsWF9cIggk35KaHXFKjRhw7Sebzv+x2C7eZU9K7
	 3ZwKq59QDm2i7GfrddIQAqt0nTlOqMXXRQJ1hCrqzu9/hla5ZegZpHJ1g75OOAWo66
	 UaK3iyheTBCZ6CvOKB5VWkI/NfvZ4oEp2epRLhX0n4u0PQRcD+oxUhEci2mF/SXqfr
	 KooxVmVEqOaShEkru5Q3yNLF6Emsdmda+99kiUb5IjJ9Tv1qk9N/MLwew0TYA+exAG
	 gv3u9iQEcATHA==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5a88db610ccso8337525e87.2
        for <netdev@vger.kernel.org>; Sat, 23 May 2026 01:55:21 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+pBbeXCKW5k37rGK/XqgtS/fld95Zf8f3zCWDHmN3ohpJRZKf7mU4tEFDXJakAFHqHPgiV8/Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0gm67rzcHHo+gWSwfEI6+plEx2ZiJA1VT8EYdFgdxUD+b0iXl
	KQYHVc8JINLlLXmAt6QrITexQTIblJ7jWDCKxPymzDY72qDKkh9/PHPgO9xQtS6CBV3RlaFR/gg
	IjVIZFexrTQBq+rXL4OiGxwLfnx/u/fE=
X-Received: by 2002:a05:6512:1084:b0:5a8:e5b2:c82e with SMTP id
 2adb3069b0e04-5aa32370d2emr2243452e87.14.1779526520510; Sat, 23 May 2026
 01:55:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512-shikra-pinctrl-v4-0-b93c3a2e4c08@oss.qualcomm.com>
In-Reply-To: <20260512-shikra-pinctrl-v4-0-b93c3a2e4c08@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Sat, 23 May 2026 10:55:08 +0200
X-Gmail-Original-Message-ID: <CAD++jLm8y=HV+d8WTY4E3r1wWGnivM_YXsSFOTa0ywa6SM-bSw@mail.gmail.com>
X-Gm-Features: AVHnY4Ij7YWCSmyxTYMcB16SJJUHHmB_vmAyuKO-SN62ANzVsZ44t3wBMUqIvwA
Message-ID: <CAD++jLm8y=HV+d8WTY4E3r1wWGnivM_YXsSFOTa0ywa6SM-bSw@mail.gmail.com>
Subject: Re: [PATCH v4 0/2] pinctrl: qcom: Add support for Qualcomm Shikra SoC
To: Komal Bajaj <komal.bajaj@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Richard Cochran <richardcochran@gmail.com>, linux-arm-msm@vger.kernel.org, 
	linux-gpio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 12, 2026 at 3:25=E2=80=AFPM Komal Bajaj
<komal.bajaj@oss.qualcomm.com> wrote:

> Add the pinctrl driver, document the bindings and enable the
> driver in defconfig as default.
>
> Signed-off-by: Komal Bajaj <komal.bajaj@oss.qualcomm.com>

Patches applied!

I had to fuzz around a bit because 2/2 didn't apply cleanly
so check the result.

Yours,
Linus Walleij
