Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793175938;
	b=uZhftD0T1ONrc+0pcK2UGs34FkLkd3rl283qvYsTlgNXwS0FbVYF2G+w7wmetnz9rdwf
	 tViWWMV3M4gh6bqM0nGmDk5z2dPlWEcGAWTDS9ZjEL/Nli6Ov1WI93/aIi52zdIpCWif0
	 sFtXeW+rpHraSH3Gen96azCqyF7qaT9fJQw5lK44rTQCGk1k7bdlRt9ylfjFXWwRepA6F
	 CUSPOT690aO0I3XUnENj1SbrHi7Vkrj97f+VwdxbV1DAXJM1qAV6aePUEF5GonXA04Ild
	 fF9Eeb9dfRZsPySmhjLUvjQzU5ou6SpGgVZy+CTfm+u/Crq3V5qROomG5EzrA3DXSIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793175938;
	h=Received:DKIM-Signature:Received:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Received:Received:Received:From:In-Reply-To:
	 MIME-Version:References:Date:X-Gmail-Original-Message-ID:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type;
	bh=05l+8JW812QvmCS5ASRMEsto/MViEuxLP3EanVEdMuk=;
	b=gvUgCY+5UNZKbEhjoIx8Dv8odOCjT54IYl7Wk/exv0B/+7hJBSgIGGuUKzDPhwU7HUc2
	 YGToN9593v1kesP/NjmTbouYkc7gApoBduZkH0IA9TIVw2JNEitKmNWnA0I6ayy5RTKNk
	 lm8wlI9oE9foGS83HAVvk65j1akjymBpcZJmOr7zIkVnoXboXPkeYvRmKWDZqLls8Jvr0
	 GeJTXdmm/4VgZ2DRWRnC8kHPe1gY4SUBFdtb0LWFyHwj5APjlNbLP0SIe0lh4Hy1BQraV
	 wvniJ1sZYsk0arfSkDWDwUor2nFz9GZFzsOjD0nrpv5xm+KpWAlhrtwTpiHrEa/rhiQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jh5UxeZ1;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C64606A31D
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 08:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jh5UxeZ1
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 165131F01829
	for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 08:25:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793175937;
	bh=05l+8JW812QvmCS5ASRMEsto/MViEuxLP3EanVEdMuk=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=jh5UxeZ1SiyWyhZKrGsTkAzISKGPgJzuHiQjD/CYuFRgCLjIUR4rvYsQlagvkehTX
	 AoImjCrz/jrmRZWqqkwlkiTTmHGQcA13o66ATdXUXGMGVTNEfHbPfINtsYDQIreQv7
	 8Hg//W1tQYaDp+WuBPFrbVuUdiajFX0zCTQBAxXIdK5fWL36Sxc4vn51ZYmUEmUPRK
	 fdosq++7MQwEk6lAW4ydudWaxq6flnmDG9jGJNoEDLgqtAKlvcMb2ZfRpFNzUCMu/u
	 o5zPzTmtXIj+LwG9ANVDcNHYa7166zyzBo6CBh34bjNehhTv2d8OyDxO5ObEJmrUxp
	 19bkzFKFiwQvg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a9841363b5so5675591fa.2
        for <netdev@vger.kernel.org>; Wed, 28 Oct 2026 01:25:37 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy+fxYpgopGQ2zjzhFuok1tV/ZTLzbfEYqwNRBvdZlvPEMFuxX4CeuupCXDwAqEEStDrqR97Kk=@vger.kernel.org
X-Gm-Message-State: AFq9FYJbrSq2+BpHndg3GJvBoT15o+CrBNjVhvdJO8/AYPiNxXjNuuuz
	rmST6j33QoyyUWFOi6h5HPAAf9DnMlllvKKxqRDaPFa9s1o+PyF4VX1LIctgZAixBqnWzDSdgoN
	Ad7GBN9EYDQfg1W2gTORoUSmwWEshfKRFI0cjENt1Mw==
X-Received: by 2002:a05:651c:198e:b0:3a9:87c0:7737 with SMTP id
 38308e7fff4ca-3ac9cf81e73mr3153621fa.21.1793175935670; Wed, 28 Oct 2026
 01:25:35 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 01:25:34 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 28 Oct 2026 01:25:34 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <at8Q9umfE2AP24lI@QCOM-aGQu4IUr3Y>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261023-sa8255p-emac-dts-v1-0-a34d778ce9ac@oss.qualcomm.com>
 <20261023-sa8255p-emac-dts-v1-2-a34d778ce9ac@oss.qualcomm.com> <at8Q9umfE2AP24lI@QCOM-aGQu4IUr3Y>
Date: Wed, 28 Oct 2026 01:25:34 -0700
X-Gmail-Original-Message-ID: <CAMRc=McYTWmV6iAbm97C-xs1vh9Atvy-LivQBW10iHQh5+rPzQ@mail.gmail.com>
X-Gm-Features: AclHuK_avRcSyuEchrSyhnDYEBcfCksI2Ibe_hZLUqTV6ryNiIHPJk3TgyKxUG0
Message-ID: <CAMRc=McYTWmV6iAbm97C-xs1vh9Atvy-LivQBW10iHQh5+rPzQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: lemans: make the emac compatible
 specific to the embedded variant
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"

On Mon, 26 Oct 2026 09:36:06 +0100, Shawn Guo
<shengchao.guo@oss.qualcomm.com> said:
> On Fri, Oct 23, 2026 at 11:02:23AM +0200, Bartosz Golaszewski wrote:
>> The embedded and gearvm variants of the ethernet MAC use different
>> compatibles so move the one for sa8775p into lemans-embedded.dtsi and
>> make place for the gearvm variant to be placed in lemans-gearvm.dtsi.
>>
>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
>
> Do we run into any problem if lemans-gearvm.dtsi simply overwrites
> the compatible without this patch?
>

Technically no, but then lemans.dtsi is incorrect as the MAC compatible depends
on the firmware variant. I'd move it if you're already touching the files
anyway.

Bart
