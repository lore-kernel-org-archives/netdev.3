Received: from mail-lf2-f12.google.com (mail-lf2-f12.google.com [74.125.229.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE55B4A99DC
	for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 09:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.229.204
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789636207; cv=pass; b=uExKDP2gCt/cDjPElAQd4mrQz7SnN2WYZCpIdhmdHSAVqZcSH9Z9ECG+M7dB5ZkOGNmXt9enpy/+KA81S9LhrLfGGXf9JOtiLl9iRvN4QB53DTd0Ht8062KmmopmvNxWzgmUFmmd0jN36H9N2RJJIPzkHE17hcAnN+Gm5QLapm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789636207; c=relaxed/simple;
	bh=udW6TvHFa4OCP2Q24JS5DX140/XFneLVvF+vPzrl6f0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EJKB50oEb/7kSnAhYvehZxQntAbF8AHW8Y0jx6YCZEoeDbcIYUqmDuOI8M9H9mK26m14sQxvjLgOEYBfYC2mnkbQ06Gfx+APCRyWyDHv5f5N1iDHF7zxqyUUu6Sp0Wtln1WESIVVfAv5Tpk25vcdpApWoE5qSSLyFw5KF6GqZUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6Ifo7Jw; arc=pass smtp.client-ip=74.125.229.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6Ifo7Jw"
Received: by mail-lf2-f12.google.com with SMTP id 2adb3069b0e04-5b5e4f15b7aso538483e87.3
        for <netdev@vger.kernel.org>; Thu, 17 Sep 2026 02:10:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789636203; cv=none;
        d=google.com; s=arc-20260327;
        b=Xc6xPVNrjEq9ax6oK9MZXuhPNpY1VgwCexI+dbjrS/OxyHvqMeprG/Yp+w7x2NjLKD
         Edm9h0lwkCHuqlClNDRK/fVyzsKz0dxlb09ayqsy6Wvs0K6xrnOcx4Z8bUtSLu3xFW8a
         QMHWT9Jg0HyDZyf2EpN9NTAY0A9Rl1FhrwzXXzl/ndJlVQd7cCsk7uJVQS17RQH4P8jF
         yAZerzHlfzrgVf9mhWufnPq/Kvx2aAJUVfP3CkRfHx411wq2xd2Moj22xs8ywoR8DGrV
         TTHn/Eqziuurd4L6LuI6fH/bAmS71zG2GA7FsoiSu1FckpJRKtFma8eWmqDh5FpL7sKr
         CDpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=udW6TvHFa4OCP2Q24JS5DX140/XFneLVvF+vPzrl6f0=;
        fh=bTgiJ2fUBLlkn6HIaWjnK7WdUwgLJFmcu01w4uaTTI0=;
        b=tCghAjAzZ0jmrXCseOqJLcLs1UUXpDIHlS9pTSQAn8XguWQUwbfYXtBkSazy2icHyo
         L1BLguqeyrWTwHsBxNouxtij8BvHyPWuIngUVUb/0jl58XwCqjJ0lDk1msfFP1qa7FS3
         TvRL2xfY6dqiKvXQCsqvtyClKWuem11geiQifNJfAvF3/GtS2LvvHnywFq97PKlP+eaN
         flnszq0qMIroajq6vCzkPppwx1TAeF2ikJirs/mAtE8Ggq/LBaYtSflqPxE6FLq00vr8
         4GTeJ5Jgqc3RbfQZh/dTeikM7Cqy/Nqo9meBGTivLNVU/qnL7Qj6gXWQsDVxU0c6wq3U
         1MJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789636203; x=1790241003; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=udW6TvHFa4OCP2Q24JS5DX140/XFneLVvF+vPzrl6f0=;
        b=d6Ifo7Jwc2mDnX064vN3jwGMqKHmX6Ak2vanxFtOvYK4Gz14acxdekb9IoWD1DrJRB
         OA4zxp8XuiTWiHuKOcNC/8GBDaXewWNf3YOfwv4vqVaKVGknqr0f9HTFoWm6m+LZnyuG
         BUysljPeXCM7vHL64dzc/dI9IWph476W1pz8LUjyKlpOvD+WGOnO+j1mQpuB2Y4Y/csv
         Totco+Ppa/2T1hcUwP/DrcEF78SiZ2hYYQD63Hlc9FOVaiWShl4bSb25EZ21RPM/Hv6R
         vVr/gczTOfjb+EwYmMA44QDbOYGhWufYNKc5KqBpoQLEhc3t/iegJPumHvTBHVdi1wUR
         oOQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789636203; x=1790241003;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=udW6TvHFa4OCP2Q24JS5DX140/XFneLVvF+vPzrl6f0=;
        b=lRjQNYGr0ifAS7670ZKWh1xULhXuywtMKWsvAquDcf4C/seSZf7cac/J5HygPAGxbo
         3DesTpSThhZGtIL9iySuLcfv0mxYV75Jjf6ITTOWr41wZa4qQ1ip5cE5LSBIM6o9/XHx
         Q5Xn4NJhhSrBK6uDiOMLd3P3bCSvdgmMjoAzG4/YJYmpoyg+p9EdKg1f886DpdBlP+IA
         uVeyGNGjRWaApU3i2C54TsUB0ahg4PxnF5V0I9+Pr8U1koD3zWDX8tP/Us0UrJL1qQYB
         GHyFUDuLutIRJeBLgYh8CBb8wiShu7HCTZmuZPfYnF7cmIXlgw4m7Fib5HoI//t8FaCn
         6qIQ==
X-Gm-Message-State: AFuF++k3AlfnGffTPaZRO8mzApRqYOwhvjPA6Yxu7yjVEmGO6YyPFH4R
	t+rKOGTrdw/XgVQhNWFARgMDxRaKS/CH2zqLq2DjQmFHY6xjHw/JfqCYy9hONddV5agdmLSpTX6
	s46MEkkAdPphJ4GYwPPnr4l37858IlpY=
X-Gm-Gg: AYBFou06FQqGy7clkCmVyqjPJkvsrVaDj7KmdaWNpsvQ9NSfLlAymM4Lpxl/j7yTdla
	tfQROPeQALjyOMgxORX1fEu/zQlxaSurl9gv3uyw2ONC2pRbxhZuuzluVB2rORk02D6sAYaa2C0
	R1WJpMNAWY5p05Ktb0WkDSQ2DbIDmZrOGU/GuzaGcczEvsU5Mv0Y8DGtj054nsVP9xsvYfHuCuE
	tRVBTEyqSKCi43os9HegKZ40U4yI54sWroyP9NBbDFFcKpXjQQl0z31uHMS35nWhclMpMF9zoA8
	aLEmJWdQ2lo26hL73aCdUdAstLNLkR2M00L4Nny/AudTeq+QrYv1EFNx7P3AWvh4FgmGZJjdvIE
	JmSxjgmC4giUxZFJs3o9iUJ7jUevVr0012lf67JG0F2OFVZ2O30DdAaDZVVxG1EwVUCe3ew==
X-Received: by 2002:a2e:be86:0:b0:3a5:b6af:2973 with SMTP id
 38308e7fff4ca-3a5dc9a775emr21702761fa.5.1789636203298; Thu, 17 Sep 2026
 02:10:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aqPxxX9MeGmAqGy6@boxer>
In-Reply-To: <aqPxxX9MeGmAqGy6@boxer>
From: Jason Xing <kerneljasonxing@gmail.com>
Date: Thu, 17 Sep 2026 17:09:23 +0800
X-Gm-Features: AcwNN1XR4DoliEuKB5ZbfjMKqsAIYGrJKJjFNjGTy5tmlhsxxcCabhbtEPXZn8M
Message-ID: <CAL+tcoBBHQpK5GruVbLJviTFBm8repE=kHt-D+PHWJ9mCwQbYQ@mail.gmail.com>
Subject: Re: [ANN] AF_XDP office hours
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Cc: netdev@vger.kernel.org, bpf@vger.kernel.org, magnus.karlsson@intel.com, 
	bjorn@kernel.org, sdf@fomichev.me
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 11, 2026 at 8:21=E2=80=AFPM Maciej Fijalkowski
<maciej.fijalkowski@intel.com> wrote:
>
> Hi!
>
> We feel that there are efforts on various sides related to AF_XDP
> development so we thought it would be nice to have a mechanism to have
> cross-company syncs or discussions.
>
> Therefore, let us introduce AF_XDP office hours. Plan is to have a meetin=
g
> every Wednesday 9am pacific time. Similar to what BPF did, we're gonna
> have a public spreadsheet where people can put topics for discussions:
>
> https://docs.google.com/spreadsheets/d/16GL6AbdjDyT81cJ3-qUnYvFxqO-RlhtYT=
S68bfQQDbw/
>
> At this point we are planning to meet even though agenda is empty for
> given week, this might change in a future.

Hi Maciej, Bjorn

Big sorry for not attending the meeting. I miscalculated the time
difference. I thought it is today!

Can any meeting notes be shared here so I can catch up with you guys?
I'd appreciate it :)

And I'm wondering how we are going to deal with the fixes (about the
header) I mentioned previously?

Thanks,
Jason

>
>
> Thanks,
> Maciej
>
