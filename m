Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793574947;
	b=Tmg/4OF7jFdrjEhxzyvqU7DZz/O9x9lA4yMU8E1H07a++r7/gHAxNu0vVmVLMwLboRKb
	 J5iA6NJ3x2dGOSz6Zq0QbdNPu1+IMO1I1J+X2HXeuatYWJq8awoYfTs/rFWA4JOOcOkQF
	 z9jZZuhq5h3nggHFuU5JesdT/bOWFIQ9A6WkjTvmVH8USmFuTTK0kDdTPH5bizR66GoHx
	 jPOxORy/FdEI8Qz3Y076sqNBhCrxBRcUT1gTeGgx2BDQhRMgxZ3gDJXHJaIkSaSDomv+1
	 s8YbeCoYEehfQCQ6LcJh2jTqtm0/HHvo1EqLut1BQTpS7jRcAsD7hTRTfFVtcpQ8oLA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793574947;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=b85SCZUlEMSxM24RW75vmTYnk/54bnSaR4ktiJzCCEI=;
	b=Vq6eAqB+jWfgp3kOv7w+xFXOdyQaXC5FZsUh4JBQ4xcTv5bs0rX6jdNJspUlWERwn6DK
	 Oe5JmPODE/v4Wf5jJIkDfdTiBIgjy6p8SCzKLsMzn7NOPzsa/qaXgi1UQjUogHTp6G5Mg
	 OnCiMkPURC4lUttTXBy0siKW7oSQFDDKNt2N41os1qxq89JPNJwOZk9tYGifknOaC39en
	 s9YWLHDhHncS39BVskZ+haTBX8ShWZPaNtwjmWP/En4GyKHCCer6Z9cuj7rSRDOtgeLtu
	 WAys0pb8N3xnHOLEZ+AKa7uA1lRt7HMVppoULXRDM2gQRuh/8tDyUDu3AEKbjN236ow==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hFbJtLRn;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.208.51
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9770606A327
	for <netdev@vger.kernel.org>; Sun,  1 Nov 2026 23:15:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A9770606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=hFbJtLRn
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6b1aa36fc0eso11282a12.0
        for <netdev@vger.kernel.org>; Sun, 01 Nov 2026 15:15:46 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793574945; cv=none;
        d=google.com; s=arc-20260327;
        b=A5rhD8FauGRG1SZycoYMv5MQrO0Ply4fb6IlWUqnvg627LVfKh4mgzJ+bfxJH29eXJ
         Ut7kEuJZeKvZJG2BQx/OIv3vdC/3Qq4YS1E3s00kCm1nkQeQcJfYCCC6FQhBZRTE78E3
         IlMhQmkX2Sryt5hnyG1WZz9UUDUt/6fTv7ONSqWP+Y11A8EDCY2q/UXIZERiP7y/wpHu
         xA/sZA8lF6HhOvyCtX77vbe7Es2UJIP1BOhK0MpK47HUz6PMXJCxCNPtJAR6loqVMhkG
         hQaWov8lNXqK7Vp/5CGNmIMvyW2tDI73ZLdjQq+Dpq15Ml3wHrzfOcEoUEAmIedmWPWU
         OGHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b85SCZUlEMSxM24RW75vmTYnk/54bnSaR4ktiJzCCEI=;
        fh=c5OtIO9n3Mhvkmz3gjzE6DrMEVP5b0cXHqV69m+1Vls=;
        b=jbcHu+o8cplxhOs84IDB3EqcgZuu5BmECSvm5diix8+WwIRfc9rvDN51D3yc2cWsxO
         +XUzetfUTsIVhTS6yT50gk3FwAkMYCOhwXOHiSm8AQ8tNhl/Bb7M16eyl4sqOk74NrGg
         jYnXUebKiBQ9jzIFL46KY1p+ncJ4/PLOygzPTTe12OFpNGO6qPC6ky4FUaEpsaxGXZW0
         hfl+4YwTc3ftJuMk6PVa4YUPawISkYf9tSJ3INhOguBtx2Infypg/iLpmE1hYymyarMn
         0mUTh2BDhYlSqTPLBHv4zfgvmu8q/TcXShzKLubXG2nTHW4ah8S/0ZYEU55GsxzVVhtA
         obEg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793574945; x=1794179745; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b85SCZUlEMSxM24RW75vmTYnk/54bnSaR4ktiJzCCEI=;
        b=hFbJtLRnNrWh9MczBVUqeHa6U6vBtL5Ropz9byKDoNLVHM87ltQr5NGlVo9+ozlqCE
         zCDbKcJYaT94e1dxw/Tl2UYTrALEmcu44Sdv+omfskaXW9uWk8l+BS5O+UYhaasoezsP
         QmUBkekyhVGcuiLRAHX2bsZXRHnGRLg08Qp+xKModUiXTfY2OCjYIvtANXAdTG0v4TNK
         zRLI7sKCdAUAyM0qQu3FA702xRVGzCQthGPmRzYyviVOrDfcPOzaWtJNM/ZhFIVN763t
         x+PQrfOvRfHZvM5mLxU1/1lHsxnJniaj65ghOzY5FFLgemheiUlWhWVkM5wETrQ0wSFo
         nFKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793574945; x=1794179745;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b85SCZUlEMSxM24RW75vmTYnk/54bnSaR4ktiJzCCEI=;
        b=2Q6p0kY3n2/Wzq37ykYF6ONNjpKs7ty0cNcXZLhLTWMV+WceA/JhIQIjttiP/tTtqc
         qVLmQA1fc3ag70njT9tenJ4ya7cDzoGi3OwTQuSh/BfOr2tGclPbVPKgcsSJIF9KvFG+
         RE5kTMRpTTqM7/KgoZbdIL/pBPbTUI1qqITh6le9GwAMEQzndtz8SYHVRdPWnnh623Y0
         rVqZz3mFqquBSr4dYBeIClLf2X3XZGgvI1NBH9YCbv9Kv8hIjEd8i1bUIesAHvWTz3od
         9Sys4PtXcmUo9PseLil2Mim7n2w8rfDVMk2b/u8Xt7GFdtKBQ3YvPOM1YM+0klicjACd
         BCPg==
X-Gm-Message-State: APuU4Z+A+3nhSwsMiyD0X40+5fqHVQUeiYgQJ4y/g7rskibA//QOztOo
	cR0a0kf4cbyrM3t0TCKk+9GItsJRYEVXK2KHdwIPBCvkugo96kgWv79bLsu3PqT6Vauc//bP7pg
	fPWvCIZMDAV43ZjhDlLhH4QI26rsi84v5HGlP1uTuauUZnpeyRPOJ9Fv7
X-Gm-Gg: AYBFou1LhDR8GwLqXLHDHO312h5cs+rLbhp3ck0se7QKTtOf1ENEuGahiOxR8gKUiAj
	bh8TbvVNAqKxSzbyzWVYwQ4vVZHIj35Nx/dA2pTMnevz4dhGXfXMyOvDQnL128d/77EGffmxWDI
	p3wyvM5eYagBDx+/BWsCAFEXf7GUjiInsh9ikv0bv88Aw40PsishqYxhUqys1+ztYgvl47xnHrh
	uTRpEaB6zCsy5mQayDskVRgpJEYHMRB0orFwp4+V80VJCHcOWU7ugF7kloR2W5iR1rLdvjl02u3
	nSjlxjzvcfiaPdACs3DGRTVpzQaMAb+Znpec06Y9PARok4fY2JaQAf3YFAcaLZD1U/+JvMwEMKW
	CTJZsIX8nj+RlxH0IQNXR4SZ5GtYs7QdYjbCVZH4=
X-Received: by 2002:a05:6402:1a58:b0:6b4:880b:1b61 with SMTP id
 4fb4d7f45d1cf-6b4b3cd2861mr242904a12.12.1793574944562; Sun, 01 Nov 2026
 15:15:44 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261030083539.777877-3-almasrymina@google.com> <179357408360.3131.16098294926514442303@kernel.org>
In-Reply-To: <179357408360.3131.16098294926514442303@kernel.org>
From: Mina Almasry <almasrymina@google.com>
Date: Sun, 1 Nov 2026 15:15:31 -0800
X-Gm-Features: AclHuK-UFMQ382VldDl9mQXawkR9RuLEX9lDNBBCTFPZuNPb5GUS05WDrMHtxpk
Message-ID: <CAHS8izO=-DZzaeFbczj=c5yGszo6parXeQNqqGV8oieZbmMW=w@mail.gmail.com>
Subject: Re: [PATCH net v5 2/4] net: devmem: detach TX bindings on NETDEV_UNREGISTER
To: netdev-bot+sashiko@kernel.org
Cc: netdev@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-media@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, pabeni@redhat.com, sdf@fomichev.me, 
	kaiyuanz@google.com, kuba@kernel.org, bobbyeshleman@meta.com, 
	asml.silence@gmail.com, dw@davidwei.uk, ap420073@gmail.com, 
	davem@davemloft.net, edumazet@kernel.org, horms@kernel.org, shuah@kernel.org, 
	sumit.semwal@linaro.org, christian.koenig@amd.com, phasta@kernel.org, 
	andrew+netdev@lunn.ch, sdf.kernel@gmail.com, hawk@kernel.org, 
	ilias.apalodimas@linaro.org, daniel@iogearbox.net, razor@blackwall.org, 
	tariqt@nvidia.com, kaifengw@google.com, dtatulea@nvidia.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 1, 2026 at 3:01=E2=80=AFPM <netdev-bot+sashiko@kernel.org> wrot=
e:
>
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider.
>
> Critical: 0 =C2=B7 High: 1 =C2=B7 Medium: 0 =C2=B7 Low: 0
>
> If you believe none of the issues are legitimate, please reply to each
> issue of Medium severity or higher and explain why the AI is wrong.
> If any of them are legitimate and you plan to respin, please let patchwor=
k
> know by including "pw-bot: cr" as a separate line at the end of your repl=
y
> (one such reply per series is enough).
>
> - [High] This patch's TX detach is incomplete.

I know about the issues with leased devices. That needs a bit of a
rework, which I have done locally, and would like to send out as a
follow up fix so I don't hold back this series.

--=20
Thanks,
Mina
