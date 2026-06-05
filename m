Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B89394781
	for <netdev@vger.kernel.org>; Fri,  5 Jun 2026 18:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780682690; cv=none; b=kqo5+n3hTgR8U2Hz2ZpRKdWKep4mvvcXNMuMUZZkjyOdk8oFERKCtVqA/cLz/wTjuTSt6uyzQLEgHiBd5iFUQTaYuNJeodsau7mWc+oVQHO/UQh/F7qmPVVCwIq8Dd2kGGGxnVmBnmPTAtuB2Dsva4nWAhq1JAYnxLgsOZ6QPio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780682690; c=relaxed/simple;
	bh=uDPXClG26mRl8codStFyXHpgtoT2oAJseE54IApEFz0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iirXapbTuScsPxRuUdNRxUO+GvUxsvJ6cP+oddoixtlxdqcSV2JghRhhIrQEeKhtyeBqypibe6Ai1iWnsq5Ev3gMFG1dbscHXaDZYlVGcJWc53QgL6Fl5ciDMO21OZGWgzfMPvVdeVCd5uvRTBJ1hxyLc7hdB6GlvtnAxl3cJE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LekKrEw9; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LekKrEw9"
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-13810b63a1aso925436c88.1
        for <netdev@vger.kernel.org>; Fri, 05 Jun 2026 11:04:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780682688; x=1781287488; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uDPXClG26mRl8codStFyXHpgtoT2oAJseE54IApEFz0=;
        b=LekKrEw9WAGy/tFBd0BZ3fek2GaPXFE5u2qMWwKks7gySUqjjGbzAtUl9xetvogzDE
         PFw+THltW+hZClna5gYfsACGVBAMIv8gMAVACBblrsotzYBIrBTokXxXG5Dp7xdx0yR/
         PANW/VNBniI7tOqhyJZsSzqRovsAQ6pvZp9inpSd2assXjoRTNdR3BzGaF5qveO6PxUz
         SdwzRm4Yntz2zTzEstziTiIKm1z/Dtj/fMwS3vyvQ6/pd6/YtM3b7SMBJ0d2UUJ9/POs
         T2cGyRDQhKitDoyF7gLEbnUjs5UCAV64H7uywPIItkWl94Hh4lbYBm/poE68zVo71rq9
         dVAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780682688; x=1781287488;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uDPXClG26mRl8codStFyXHpgtoT2oAJseE54IApEFz0=;
        b=GeUTFfVeHgTepB9O4RQM+WA9FnBxgavbS/jklMfz8bAR26sBWNkotkqFtu/8duSlsq
         J0M2tNyLNzn9J0OdMekel0b+/m2HXE/4sYtI+q4eFf5W/qGPGMiP+rbM8mV/aTWndsRA
         kzEAVpI6fp1eY7kPHhIqijrd/qjyv3Xc7QO38Go4lCzMUnwdSVPc2T/xLn4E3Jd0KoDH
         TlI9qnl+zrvRXdONJYZjEwt/KeLIE4cJtRYFJ9dAYcBUtYtqBItz5HUYXCQ8DNP2Us99
         sKHRFTWYuUiUpL/Rb8X0VrretbLbPHSPkycZXWYZ87aSlGSubResQ2EfePX9g54eWibp
         fkvg==
X-Forwarded-Encrypted: i=1; AFNElJ8TK7RvBVebj6cF5mfydQnYW0zEkhpLGPLH1RnUEaWLqaPeiAtNeiZhlTpmGgnJ8D4h1pLxLp8=@vger.kernel.org
X-Gm-Message-State: AOJu0YytiMYnN/6ZZP4aU30UWwqSN8zC2NIWxqw6a7F1x2mBLHllNW7d
	bPg7BAi7Yry6+j860orXRwaUMnT4KXcn9pb4YmkQeyzyF6RTj0CNfyO3
X-Gm-Gg: Acq92OFmETRrbsJirSRQJIUP8ic0XYWnkJqejg3u9O4c5EC71/1Io3XcyAI2Wa0/DHY
	15FDc64+jydh+aHIIWM4TCJU0DNxlKEhqB9XqM/krM5pGR7iXyGFYyIjJQq9YHmqVJNNvuRrMsR
	btYdBaU8+OB3gpdaKwkVh1OLKt4CXL6Cp2oyHBBGa1JuhD0olscQsj8G0+gxiL+felEILkB8gTD
	xHXtM7FjnN6Kygv45COEaLXv92mDPen6QdzLH/ZsYu8ErYvOFKrGTJ9d0a0ARB3/4Nfh6dK6e98
	nmEAqC23HbzTSM2YqWhCWst4Y8SmviAJp8l5f25wHHetwUF7Bd4MyZvRLb7/gkwEcy4o7QWcOcw
	lc/eifTSuJT0QZAp2JmYpXFMVIVp5kEY8O7KZDJe21S0ysVXrjG0CaK9VFfdRgbPOma651Udx0X
	JQBUeaadYm7Ta3gBNxO3tz1P8M34aVVORbsHtHxw7exTjb3qT0N/qSG7RtI5MEmmLLY03JkSgKO
	zsNYrmeujvl9VNFgV4=
X-Received: by 2002:a05:7022:6999:b0:137:e45d:7c4a with SMTP id a92af1059eb24-13806720d38mr2287079c88.29.1780682687836;
        Fri, 05 Jun 2026 11:04:47 -0700 (PDT)
Received: from ?IPv6:2a03:83e0:115c:1:5897:d7ae:d523:2a3f? ([2620:10d:c090:500::2:ccae])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-137f716017esm8936565c88.15.2026.06.05.11.04.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 11:04:46 -0700 (PDT)
Message-ID: <6d86c2fae9be63eb110ebd5b3fc19bc4cf1de2dc.camel@gmail.com>
Subject: Re: [PATCH bpf-next v1 2/3] bpf: Compare parent_id in refsafe() for
 REF_TYPE_PTR
From: Eduard Zingerman <eddyz87@gmail.com>
To: Amery Hung <ameryhung@gmail.com>
Cc: bot+bpf-ci@kernel.org, bpf@vger.kernel.org, netdev@vger.kernel.org, 
	alexei.starovoitov@gmail.com, andrii@kernel.org, daniel@iogearbox.net, 
	memxor@gmail.com, martin.lau@kernel.org, mykyta.yatsenko5@gmail.com, 
	kernel-team@meta.com, ast@kernel.org, yonghong.song@linux.dev,
 clm@meta.com, 	ihor.solodrai@linux.dev
Date: Fri, 05 Jun 2026 11:04:44 -0700
In-Reply-To: <CAMB2axOOG3ptDkWvTDpGut+EmDeroe3GPR3obb-Br_Dg1aGmgw@mail.gmail.com>
References: <20260604220904.1032145-3-ameryhung@gmail.com>
	 <a5988106169c7350f39a4d07b36b679a5fb39cda49ca371cb79c23da7b63971d@mail.kernel.org>
	 <b4302a13ccae77b304a09b47c58565c8ff1970c2.camel@gmail.com>
	 <CAMB2axPLpxk8fh-Qp2sGwtsZBCE42DLo+h8pB+ObffLifP9aZg@mail.gmail.com>
	 <CAMB2axOOG3ptDkWvTDpGut+EmDeroe3GPR3obb-Br_Dg1aGmgw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.1 (3.60.1-1.fc44) 
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2026-06-05 at 10:57 -0700, Amery Hung wrote:

[...]

> Actually, looking at it a bit more. I think I would hold on changing
> check_ids().
>=20
> This patch should not increase idmap usage. parent_id refers to id and
> therefore check_ids(parent_id) will reuse an existing slot.
>=20
> The id_map is indeed more likely to be triggered since there is also
> an intermediate reference for reference dynptr introduce during the
> refactor, but that should still be very unlikely under normal usage.
> check_ids() also already fails in this scenario by returning false. So
> overall, I am not sure if we need to change it.
>=20
> WDYT?

I agree that it should be fine to just return false from check_ids()
if there is no space in the idmap. However, since not all ids
correspond to register/stack slots anymore, I think that
WARN_ON_ONCE(1) should be removed.
