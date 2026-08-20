Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B6BC3793CE
	for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 16:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787244897; cv=pass; b=XuwUOL3yqDlhotxCsE0lduErc9wJfoTNQVO/fZ8rVWms7Kv283W6fzhYjCp+RG2ZQekH310gTQs6WpifBoFaOp/msAMJ0Wge39GqmtXYfeMphF/7IG1dcYsQwduBqegeSd0DBKEiFwXkjBiT50nJpIazkb+6HMHuXa6Dm9DS4k4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787244897; c=relaxed/simple;
	bh=u1at3T2eHzRuPbZA8sBy6ro2golFnm4OSLJh4yYZXUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l3EgcKMhVCDvGSz5Zls0ahH6d102HeX8mNByHPpimyP54N842yUdcd8wCZ9Y8gOrWBJfzfWkxYEtGIa4y9IWl8/wEAIJkEi8FY28F4Gw8WcYEuHg4QQbQbQQ+Y9OmNCkacDvkxgKCJJ1b4Gv3oA0nPb7hv1u0u1G8tuympUCOe4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com; spf=none smtp.mailfrom=mojatatu.com; dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b=kAjDD8+f; arc=pass smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=mojatatu.com header.i=@mojatatu.com header.b="kAjDD8+f"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8486672f03cso40186b3a.0
        for <netdev@vger.kernel.org>; Thu, 20 Aug 2026 09:54:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787244895; cv=none;
        d=google.com; s=arc-20260327;
        b=hwphQ36XTRRH2hSSdu+LeEzADfpF2gdHzu7zSzopTN5WaOeTTDcVfieUuJqgEsVu0/
         1ShEoWpwkqvI+S5reFTQ+Gw70cp1x03isRQsGH0ijcj9qaV9quTUE7nijkueUBkMTeIm
         9t0MuUdAmHdmW9Gz5fxvxdf0F56A9NhJGsn++UaO7qlPLbyZy7HiubrrfeKkx/UoDH8C
         PLGWJRPGXxQ2N/AmvtLKhzhOnYpfuVGennYHJUnTAHADb3Yg1gjy6I/QEHVBs2aasbLO
         64iHjBR6V+oyAoq3+YEHP81g3zPw+L5pb9t6d7BD0FDRXvk5hf1sU906noqNY/sk4Ucy
         LSuA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=0pwYkzCa91/YloUKrvUo3IjLL3WBBRqjBWwpIrQkVV8=;
        fh=Mo4jABy+Qqpu3ugugQfCi9Eaac8e5YZFLy7xCFbdG2c=;
        b=EQqfrf7FuHPKl834+wdokicm0/zokVs/pMgcj2QxdavPR3kd/fwwxWPTTz8965SwJY
         aidK+NGi42JHo/atPqk2frrROfaiNVG+NvzVNAEPqB4bziJhPa2KF30nFjmVWPedAQas
         MZhLT1RfjORDm24lEq68seqGYcTsDWYf3/gbBrjUtVml7kdwDANITT/ZQYaPPbprvcq3
         XOvLBFVES7mxHbretH0261SznJn7Fc1RiEsv7me3AOyX4aTulQjZGmdoy/b8MaFO9pTH
         scxjMOSrFLQLMg3Aebs2I7KzW1mBle/8YHZkTiTXJU80KXd6Cj3iLqZhamvOtUf5GTo5
         soeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1787244895; x=1787849695; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=0pwYkzCa91/YloUKrvUo3IjLL3WBBRqjBWwpIrQkVV8=;
        b=kAjDD8+fK8+5RgeU/RSTBY3vfWmkVA7xIMzMAszT7JbaE8H3m3KDmXCM4V5HrbG4N5
         qfmrPQcXJ0vTsob+wLJiVwrCxw7geh5Nk0xsoVTwZBKOWLuKN/eqkjTATxuCouBOe+ih
         VZDxOLnuvkd2hpCmWBpMuojf7BgZzVHHRJD3U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787244895; x=1787849695;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0pwYkzCa91/YloUKrvUo3IjLL3WBBRqjBWwpIrQkVV8=;
        b=h7zqP6Po+kxigsnP5FAUkTFzpmNsLRexY77EkcgOJ4hsnpSYg+nDjJ7ahYaini9MsH
         BA6wrLY5DNuMmphSS4LK//Yh0lgE5cpjx1n8epD4sJI0dmOr7uNHAv/pA0tigB7fkt1d
         Ik2UF1e1p4RT50xf9/lXlFHAbIFbZ6SD/E+SXx72TX2+Ns2+zuQpQk9CRVT5Hpn7v+VZ
         yDBiX+65kGvwjCWCzAkaU5yfLHUSzrgqLydPL3C2EC4Ug1ZnlKSi63bSTulqIIdivqpM
         Dmgn9Jik6eLUJcU4w6RdByOJbFPlfpsIIwPgs5a8CTAAHIfDcRXjHsYoLZsxmhG2u44a
         kcOw==
X-Gm-Message-State: AOJu0YxqPSRSGXp0vRQxx3nlrYJ/n8GSPet83szAx36M9zqzJtKuie51
	2s6nFZJ4fCiGOxfae7/pgJLmH/N+xvTdige4yirtcn/2aRf3uwW1Q4lvJS5bfOqLrsWM+PVAlvu
	x4xr4JKKzt+gF1yQZQ5PHBn9VHohZOuXjjC8XNqMj
X-Gm-Gg: AR+sD109t7CW8RfpZoQGRzfhfIdBqaCwE3fCX40RoXz3kJqMFMKAc9ve2SAuiCI7RRh
	rj6ojRONalE+xyYJ0oLWrmDz1CNZvxwYytzgFvo6l/qhiSUDoLkSAu9UzOpNagYWHT7t6m/HC3w
	6P5MsFwtdxy/w7CCHxE517VQI8gWPiMjYw3EuCJHrqrKGf++bQJeRdVAEbs16GG6ZDr+cOLCdCy
	azh1Kq0ppw2f49Oz+mOcU6ru4lgOU1yqfvSjI2aFyOCGctkgUq1rt0cIZg6VWpNHtUPdzUE3u0B
	GsrsXVhp8u3UloYU6YT+NOTDM+W3ickK+Oastm0nvw==
X-Received: by 2002:a05:6a00:1895:b0:83e:b443:965e with SMTP id
 d2e1a72fcca58-851d3808e7amr22045526b3a.3.1787244894734; Thu, 20 Aug 2026
 09:54:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260819204210.23722-1-fw@strlen.de> <CAM0EoMmT7xFtxrVwCm1ohpfVAPBuVBFHB8q_eTQ5taSquKo9og@mail.gmail.com>
 <aoboL020DIcOn2lx@strlen.de> <CAM0EoMnvz6A_v65s=jcdw5nxL6N2+yd7ZBvp78mtt7edkPe-sw@mail.gmail.com>
 <aobuk1osK-Lq-aMk@strlen.de> <CAM0EoMm8G9FaZZfctYKsm4Rkd3RVmVxkWMp6zJ1Gbxge5hdp0A@mail.gmail.com>
 <aob8wQn2EuI2N-BO@strlen.de>
In-Reply-To: <aob8wQn2EuI2N-BO@strlen.de>
From: Jamal Hadi Salim <jhs@mojatatu.com>
Date: Thu, 20 Aug 2026 12:54:43 -0400
X-Gm-Features: AcwNN1UIGe7Is2XcCfEfxdBC11VB-x0SIEimk3MgyyveHG6taAJXwUn-j5H8yJ8
Message-ID: <CAM0EoMnLj_5HQrxSWPhJcks1bedi_OMEr6-_=q2+c_cWDn=8Cg@mail.gmail.com>
Subject: Re: [PATCH net 0/4] net/sched: reset conntrack after packet munging
To: Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, jiri@resnulli.us, victor@mojatatu.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 9:10=E2=80=AFAM Florian Westphal <fw@strlen.de> wro=
te:
>
> Jamal Hadi Salim <jhs@mojatatu.com> wrote:
> > Sigh - couldnt help myself. Attached  fixes the poc from kyle - i know
> > you are hinting there are other scenarios where it wont work.
>
> Yes, e.g. what if pedit inflated th->doff?
> nf_conntrack_in() checked that this was fine, but now the pipeline
> can re-neg on that.

True.
So my question to you then is: what about BPF, OVS, future thingy? Are
you going to fix each individually?
Or is the answer there "these are different" because they require
root/CAP_BPF they are not worth fixing?

cheers,
jamal
