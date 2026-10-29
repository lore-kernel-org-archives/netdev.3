Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793283579;
	b=l44OX/ZnmLCjzSDa99T0zSAy4pu9+BZv+RIYYBTEH6ZPmxycXo52iBt05AivbZ8nB+ue
	 wyJu2bkUdovn6BZhc28kORULu0m/g2os00dzI6Ew66z0AyModN1yo347Cwj4dLFTJvbF8
	 5N52aL2ye260eJgRS/ptIHqQUDkqmTfOFHEaNGPS/tY2GQ02rGuajgFPF32XpZ11xkG8f
	 KtSZSwVVXQLl8ddf8BnLCYr2EurWRTeR+WSS67YgotKik7S92ux2ecs8buc/MuAinUvpV
	 3qvsmkZOVcD7Bjn4K0ozsr7AIpTVKXCzfvTX7BqZxZ02VfsMEdyE8HNPiwqWC9ZT91A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793283579;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=9by/+qn28kcO71UCrIacSXbOC8dVdMUGgB4hEtIS4Ow=;
	b=BbihQmgFwbwASkhiISqbVHX9jcIdTe91ZhpdhB2y8D97u3e7UzAV2w0ks1p/V/X6g4hR
	 C6VVCevmtbmYwrn6Z7A2Q0G45dT0HYAV0NzNq5L1m8ZRsC8WoLlz8l2HX5+iQJII5L1aC
	 gTGyjUF3sSaeJlh42bnt1WMP5lOKn22Z2eD5mPWTbD0hO3nmSpwUcRCqfipDQywzFITnB
	 A31JH9US00mXEsQD28/6k7bHg+VNGQ218u0npypw1hy+ZregThar7mEuYU1E6PrFuWnU/
	 E/GtZ1w+U+xLqpDaFAR1yppv3infg0UE6+GALVenJFzy+0QVqvApdIc+8+x0EkqnsiA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZV6gnFWU;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.53
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E57B606A31D
	for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 14:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7E57B606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZV6gnFWU
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6acb9c018ffso1188015a12.1
        for <netdev@vger.kernel.org>; Thu, 29 Oct 2026 07:19:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793283577; cv=none;
        d=google.com; s=arc-20260327;
        b=q9aBL4jtVc/elos5YsUBW+0ZO6Gr8HkFAhwwCkt/ZLRwDfaRs69TeRP3VrguVBMwWe
         X68VE9zJOe/N9vdHrVthpEq7pI99RYGVvudEZYOfOAU3CTEqbj2/+6FMRHeaDQ2bNGOP
         H9tayyov9E/8JsNMaXD/uABK0j3clnw8WQP1jpeZtiJnilkO8i83i9wIbxncjK4INNnL
         E7byh5U+Xqp2OiRLSLJt68fBZ5tWvSuFhH9nGGs4m6uvzW6sj9wTAJ2GfK8HJevcmaGM
         aOuiMJag+3lCen3Ogn2kYSPRfAjAe5GVqBqSBH2w4rxg4BMAXf7qIjwdPCrUOcAxWfRP
         j+tQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9by/+qn28kcO71UCrIacSXbOC8dVdMUGgB4hEtIS4Ow=;
        fh=gMe/cqHEia9Ke8UYxemaFmjh9oh/eUdFQPSoWSt7Yes=;
        b=iTf8eQ8Sy/Pm6HatN4QT0w7T4CryhkGEYPtSxTsIZo4ZH36yYNXDl2sliBg5r9dfpj
         1VCwEfaweLadbgVWjt6Qa6d8UYI8LQTENI9fzCtHE0TaZha1HZUW/RJ1L4ixO9CcOriW
         BO7NArrjGAg1aMrXykq3ad9PuugoQXTGyN9SqKQUf5CZnSDieZ0Xh6j4CyIE9jTqGb7t
         IEDyfN927kU7jVz2YWzSCNF8MMcXal5ljnYpQcfzE0zPdqpWAIlKkRWZ1aVSfQj7tShu
         VKfddrc42HZWp4oC8ZVS70JRR0Y1+OqJ3VZoBWB316qKTIiRO47HvlBiGC3f1bIKqzuQ
         01xQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793283577; x=1793888377; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9by/+qn28kcO71UCrIacSXbOC8dVdMUGgB4hEtIS4Ow=;
        b=ZV6gnFWUEjF2W22PhBo1hYXFtgLZ89QQmovrCEZzBWPoP/4N16PkqWj4HrxA3HeO37
         KGi1spKvsnQCNQTkzowIz8/lS7ImaonvUjMTlrIZ90EZv1tsQXr26WYGXtEu/LmjH3mY
         Sy689n/gnYwDkhbKZ8blHDhOdDIt+HWekavFgA6dJEDZQ+6zcMXhBnn43AmaiCOqJ6/x
         DnwxwbfiXh1LcEswRIiMSF3T4fwkcGmR2qEpi61MjJV8Mt7+buguqeFubW0q6kEgL734
         xV66RovXQaZAyeW49LXGA9GQD0Bd/NfrFYX9+NrOSliA5r+9ngUYu65AdWTQxg+e87NC
         utIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793283577; x=1793888377;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9by/+qn28kcO71UCrIacSXbOC8dVdMUGgB4hEtIS4Ow=;
        b=CFcvz8g4sQM4g/TAIrX3cFArHksP7HF0jw3qNuk4Zy8uRS1xjb7hDsIUrxFXpv59nj
         +/bP8tgRvjLwF/CjLRLe+Tn6seQCP8eMWQU5SelZ2gYsfwwj1pBP5Boet69tScMh3KnP
         hg9hGZiqtL3L4u7hBvUoPo4+4eShfYilV1hDVgJeh3rIbH6h2+1qTyw+OT88nQb+hSO/
         UIusOuo0v7cQ42SPrMcGM5YXkc8/mEDnb+17fgwlrACiepnNVZBR4D7w/uWyEkr9OvxG
         eejc2ZK82xGpf3A3/sFT5CO+KXQUuC1XXqYV4DXMBhBPqQkAxaY96mRrgxB4AJ0KrKl9
         iK5Q==
X-Gm-Message-State: AFq9FYK+mGGKjfVXCeFCsKyXuKD8MowBXumo+Kf/kuV5rsyRvzwde8Xi
	QZAe3ItmbNF0VYfR8/TkRbBvBzi1MS1XG2pI242bq6z1cffWiwU3ARwrP3lmCEotKNEPtOqVW21
	0UFWYzdy6pmUoiFaUk4dw86mYGG5VEdk=
X-Gm-Gg: AYBFou3e5mw+GXeyGdZEED60Lh9LNYakNuEFG8Mw8h6qsqo8TLj/G5KXkG5q8czuJfN
	IMqQbjO72G/6XRxQC5RdFCZ9DJwYQN+xk2jhrUVoM50b6WAEPg4nc9d/EW4U+wHp+GcJNJSh19K
	QEFZhDUBNNpy+VdvvcTdTleHVc4AGo62s1XtDomHBsFG39A4epxU79w9EkeyY0/u1Nla48be5p5
	J9BxnqjmRWiUhC7w8/lc0ZX0F/oMQI0xUi6dM9E1n3MrM7MyOCKc94HsYsYvrPIMSZIoReZd5i1
	zciXe6OBQ2Jthjx1g4OGcZli3Pzs3gy6PThNGLyxVb/21UqrxUrqQq9Vi/0FVBSZvHF0yD/RS1P
	G3G5wDGZ1t629LLXBmHjvXLI0vOf0hzBFpelb
X-Received: by 2002:a05:6402:1ed0:b0:6b3:d0a0:39c9 with SMTP id
 4fb4d7f45d1cf-6b4b0b1cf11mr2209106a12.6.1793283576657; Thu, 29 Oct 2026
 07:19:36 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20260929100625.50380-1-ayush37735@gmail.com>
In-Reply-To: <20260929100625.50380-1-ayush37735@gmail.com>
From: Ayush Yaduvanshi <ayush37735@gmail.com>
Date: Thu, 29 Oct 2026 19:48:59 +0530
X-Gm-Features: AclHuK8YRd7esRwJwQxXZsuBWfYGyAmxvBoyXjMehkxel03w8u9xNskEzG-b4IY
Message-ID: <CAPgWTUTQti8Z7Kkw+DfTdsYd-SGsq+NpX2vD7TVmfLDdgcAMQw@mail.gmail.com>
Subject: Re: [PATCH net-next] sfc: siena: fix kernel-doc description for efx_ptp_timeset
To: Edward Cree <ecree.xilinx@gmail.com>, Richard Cochran <richardcochran@gmail.com>
Cc: netdev@vger.kernel.org, linux-net-drivers@amd.com, 
	linux-kernel@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Shuah Khan <skhan@linuxfoundation.org>, linux-kernel-mentees@lists.linux.dev, 
	joe@dama.to
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi all,

I'm following up on this patch to check its status.

I found Joe's review in the public archive:
https://lists.openwall.net/linux-kernel/2026/09/29/2834

However, I haven't been able to confirm whether the Siena change was
applied to the maintainer tree. Could you please clarify whether the
patch is still under consideration or whether any changes are needed?

Thanks,
Ayush

On Tue, Sep 29, 2026 at 3:37=E2=80=AFPM Ayush Yaduvanshi <ayush37735@gmail.=
com> wrote:
>
> Remove excess @valid struct member description from
>
> efx_ptp_timeset.
>
> Signed-off-by: Ayush Yaduvanshi <ayush37735@gmail.com>
> ---
>  drivers/net/ethernet/sfc/siena/ptp.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/sfc/siena/ptp.c b/drivers/net/ethernet/=
sfc/siena/ptp.c
> index 0b723a127364..d643e41ae773 100644
> --- a/drivers/net/ethernet/sfc/siena/ptp.c
> +++ b/drivers/net/ethernet/sfc/siena/ptp.c
> @@ -196,7 +196,6 @@ struct efx_ptp_event_rx {
>   * @wait: Number of NIC clock ticks between hardware timestamp being rea=
d and
>   *          host end time being seen
>   * @window: Difference of host_end and host_start
> - * @valid: Whether this timeset is valid
>   */
>  struct efx_ptp_timeset {
>         u32 host_start;
> --
> 2.53.0
>
