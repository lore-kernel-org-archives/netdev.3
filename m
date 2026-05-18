Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D763C5540
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 08:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779093047; cv=none; b=Ito5671bsmsNvVQMgaSgozKZ8EQHOiL1/k7uXXhYKyp9FN83ibYLBj2KkE8dMxuo6vAEPd/KvPcp1+jBVt1VBoAMsWquuaT+/NcT5BCTTH1mX2IAgQRKfvrm+q/GHiSb/NHJYESwVR6ALvkpEt5DRU4FDSBwAiJ69hPvtRdQqoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779093047; c=relaxed/simple;
	bh=9z+sp72f1iKw0nPgNMvIodYgBLWziGaRX6/Ms5G3y2s=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G0j+m8q5spSLuXbrSvHmzECRO9V9T4GVdxx6WoIcKjdDf03InSrN0/3e1HmcBqH4/deSzgUzkSgJ5vzWpfiVpy7yGSFg0bJuDeJsiT+LihLssAlCbYvyAMHtXb1jgDKJ3E6dlMBheDAG8azlkx+jtcfl3hRiuEkTPXnK4W/aqOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UR03GAan; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UR03GAan"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27B3BC2BCFC
	for <netdev@vger.kernel.org>; Mon, 18 May 2026 08:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779093047;
	bh=9z+sp72f1iKw0nPgNMvIodYgBLWziGaRX6/Ms5G3y2s=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc:From;
	b=UR03GAany2qENmnCORdG+I9cu/83k3SV4ewM8k4MEjDzrOIyNxN3y38fIX54QvUAl
	 8J7PbuK/zuYG6rb9MwQHYWX5F/qnE0o05AIQjyeOSpuIVeWE4fM6/CRGADKSAA0y/1
	 Rp9Ys/MF9VKgplV/7fWuCDL8QB2dHOSO/VFVWuoaVsb8KHXzElXBEesjwtGPNX2ypm
	 6BHBO65Z14fRlTmOWByLzJjRqwgIP63nRXxZkBtF7ffRaMOwHyq452y/uUug/pDt3T
	 JzCD+I+otQYUBl/kJVKBfGfu+Q1CU31n0WrGkcWqQZOP5q/pJP1aThuGtqFps/3dxV
	 gAq31G6Mu8buQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-38e8292423fso13791891fa.0
        for <netdev@vger.kernel.org>; Mon, 18 May 2026 01:30:47 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ+FQoRbDPztE3sstK2XpByplV+qmdwgPuui2jPojhCdNOGij/1ckpDke6o+NLgfCTYC91LHTU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBgJuD3UhF6XHbpkUspt1PDVbgcZwHEwzrB22mjO3Jh2WFaq72
	xExjw30FSE8GvCxfdFzMSbqkCBvpSxpKjJp3zr6tzwxwMs6n0xbvzamKphQKJo4ZB18sS4gdTFc
	QAZRQJrWlQnFMJ5NCCKLRVIUkanJGuPrRyfp+vrumAg==
X-Received: by 2002:a2e:8a98:0:b0:393:d706:7bc with SMTP id
 38308e7fff4ca-3956193091cmr39789731fa.0.1779093045805; Mon, 18 May 2026
 01:30:45 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 May 2026 04:30:44 -0400
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 18 May 2026 04:30:44 -0400
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260516-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v3-1-37ba4b6e9086@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260516-nfc-nxp-nci-i2c-restore-irq-trigger-fallback-v3-1-37ba4b6e9086@amd.com>
Date: Mon, 18 May 2026 04:30:44 -0400
X-Gmail-Original-Message-ID: <CAMRc=MfF3Kdz62XWxx_Y=N=bx=PUQ8iDakTYtD_P0gUUsUGKbw@mail.gmail.com>
X-Gm-Features: AVHnY4K990tPUcDP2ohnS68GYVoXfSGX7h4Ft5lim9vMUAsNmJzLrAp6WoPSPNE
Message-ID: <CAMRc=MfF3Kdz62XWxx_Y=N=bx=PUQ8iDakTYtD_P0gUUsUGKbw@mail.gmail.com>
Subject: Re: [PATCH v3] nfc: nxp-nci: i2c: use rising-edge IRQ on ACPI systems
To: carl.lee@amd.com
Cc: krzk@kernel.org, peter.shen@amd.com, colin.huang2@amd.com, kuba@kernel.org, 
	david@ixit.cz, luca.stefani.ge1@gmail.com, brgl@kernel.org, 
	mpearson@squebb.ca, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Carl Lee via B4 Relay <devnull+carl.lee.amd.com@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 16 May 2026 13:55:18 +0200, Carl Lee via B4 Relay
<devnull+carl.lee.amd.com@kernel.org> said:
> From: Carl Lee <carl.lee@amd.com>
>
> Some ACPI-based platforms report incorrect IRQ trigger types (e.g.
> IRQF_TRIGGER_HIGH), which can lead to interrupt storms.
>
> Use the historically working rising-edge trigger on ACPI systems to
> avoid this regression.
>
> Device Tree-based systems continue to use the firmware-provided
> trigger type.
>
> Signed-off-by: Carl Lee <carl.lee@amd.com>
> ---
> Some ACPI-based platforms report incorrect IRQ trigger types,
> which can lead to interrupt storms.
>
> Use rising-edge IRQ on ACPI systems to avoid this regression,
> while keeping firmware-provided trigger types on non-ACPI systems.
>
> Cc: netdev@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: krzk@kernel.org
> Cc: carl.lee@amd.com
> Cc: peter.shen@amd.com
> Cc: colin.huang2@amd.com
> Cc: kuba@kernel.org
> Cc: david@ixit.cz
> Cc: luca.stefani.ge1@gmail.com
> Cc: brgl@kernel.org
> Cc: mpearson@squebb.ca
> ---

LGTM!

Tested-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Maybe:

Fixes: 57be33f85e36 ("nfc: nxp-nci: remove interrupt trigger type")
Cc: stable@vger.kernel.org # v6.19.y

?

Bart
