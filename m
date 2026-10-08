Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D1A23E9F7B
	for <netdev@vger.kernel.org>; Thu,  8 Oct 2026 20:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791490244; cv=none; b=JURTrExEU/+zmEQdwBXzgZupfrCe7+Ugi/AParFgBsfesWpnJVLYk07xqM5cq8En5XpiUT00oP6SMNZFBAqXAnz3C0Tqk3arBRfa3sQzlGVsgGdNi89XvfGpPF2gLLgGoBhWgOOM2P31KpUU4qpJCeSiQoVknlrJWI0LphsT8qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791490244; c=relaxed/simple;
	bh=yF3jq0/vOMO/ywfXfijmGEGeer2JbGwa3Sl3cQeG6rg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=ayoOA6OEfMaFmsqwOrs5xlGqCeMPDdVsLnKR9JPoFdeZCdb/ULNNuEvRdSm17fkW6X/xuKuxWcLqaqjf0/EkLo8/9wBw9ppm+wH+nojRsYRMBoJTcC7w4WgHVgBHTAYT6FE2O4Pt/vd3YDoGBWKWrci3bapPpFsew93uJqDTDdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ITVGTowE; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ITVGTowE"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-81ba09a5d23so5585962a34.3
        for <netdev@vger.kernel.org>; Thu, 08 Oct 2026 13:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791490238; x=1792095038; darn=vger.kernel.org;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=yF3jq0/vOMO/ywfXfijmGEGeer2JbGwa3Sl3cQeG6rg=;
        b=ITVGTowEuCGrUhGyQkFFfBAOvx/LzqeZsm73DAy1g3A4EsCiHo37mqaYA5RtA7Vbvk
         Ozk2gG9Mlzg4SA1fBJmePtmZoNgNiY0Zna//6hWjNxe32msLWNvtfl4v0PZe+gVyDpAM
         6SAuv2vZYfR+tPHSDdJoWKAbYQspmL0kSzV+ZVIT19od1ITy3zkDeZRK9ouShZtUPutP
         4LK2U9bIMAOwgU5xqWJuRogo018tE/sp9HoqNUubX3v5iUiqVVaUxuNYuqW9vJccc2Cj
         O48QrYPklp+onThbzOVFvq42/IeHxbOieudBGJ8YjHGeKokxLz68k6H/fkixznBGakVt
         1VtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791490238; x=1792095038;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=yF3jq0/vOMO/ywfXfijmGEGeer2JbGwa3Sl3cQeG6rg=;
        b=jJ2wnKQdjam8AkI06XgKO5fNHh30KYvgm7k48dNRv228zqJmWr+gNj5P9BoXEGOAU6
         Ejue/dAyJX1rbD0tCCNHgIBcnrKNciTlw1c+1FPPJqq1TFm7Ibbip5qyjziug23IAkX/
         PLytZ5eebc3vVX2T4DG74MXVZ2okzcR+ILezjTXorkDV1DEId+rliApa9tbMkwyYFiDW
         D+pdTKiPMN93gVD5aeFzfADH9mpbyyEKy6gqNmzC9K2Wya4eUOxZhaNA57kBI+rM9DKr
         atpJYoKmXH2o+ObQCKk6HLp+n60lgoSQqlFOQQG8o8aqWJPiWXk4KFyTGG7mV3l6JF6F
         JCzg==
X-Forwarded-Encrypted: i=1; AKwUvBy00XH44m/GC296W/OOZY3tIxwhkM3n+0sBZEWjDKO2HVB18BhAWWt8s+xcwKfdvMbbJ0IPoH8=@vger.kernel.org
X-Gm-Message-State: AFuF++lJyTR+dWjZCCnZ8pEj2vlPcqvLJ2QtCwwQy04TTqD6qba3i6Ta
	ocCkS4d/vmavhlwC21ZKXt7GTZXgnZXCuaft9iMkR3KH0bpM9VAp+iUl
X-Gm-Gg: AYBFou3YfmSoAtmy/lYKDFmS/mNyk9u6r1U1Y79CJxv74UfcdsgwHMXsiF3/BV0UF1+
	ysbX5yyTcCEX43WIRSZcPQo6os0Pv+BovhAFxwxlUmoGxgIOw//gDhqEhWdpn34DCGYNVSCFn/e
	s5TDiw1DB1adNihc/0btJDtCcdVaRxrjQWOvX0WD9Qo7ma4DPoVhHTk601EvGuZr/MLpvtei/be
	zR4B1SsTlMNeszXu6iRR4JsQDOF+WSuA9GVkP5P4uHj7kLP3S3T+jf2FP/DA9dbUlShiZW5onJn
	8VyvETXC+3gQ8YzTYoNgHFlwOw/uqJYxfUYBhs9pMbxS+kN7UCX8cDE+Km74GWM7eVZsNaLA3kA
	Pi9TWtZt9wv77S9BP4foiZDp+ici3y79jWeGUA4qNcOaUhMiBrDBCJyoxWAQOPJnaAAzMSX4nwz
	oJ07+NxzKqsCjRWT2WAMvGKyj/Ns15Q02bTMsTc05+ZD0yyL5YC1Ek73B8fFLmQv61Kyd8Crqvf
	tbGIEKXypOI6psS2H+Jj5MxwB0=
X-Received: by 2002:a05:6830:2105:b0:806:9a8d:4b9b with SMTP id 46e09a7af769-82acf49f6a5mr7338564a34.15.1791490237678;
        Thu, 08 Oct 2026 13:10:37 -0700 (PDT)
Received: from smtpclient.apple ([2600:1700:220:4650:f501:3b3:565b:2d79])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-82fc7cc90aasm601054a34.4.2026.10.08.13.10.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 08 Oct 2026 13:10:37 -0700 (PDT)
Content-Type: text/plain;
	charset=utf-8
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.700.51.1.1\))
Subject: Re: [RFC] virtio-net: AF_XDP zero-copy TX checksum offload
From: Azadeh Aftahi <aftahi334@gmail.com>
In-Reply-To: <1791423335.8486545-2-xuanzhuo@linux.alibaba.com>
Date: Thu, 8 Oct 2026 15:10:26 -0500
Cc: magnus.karlsson@intel.com,
 maciej.fijalkowski@intel.com,
 sdf@fomichev.me,
 netdev@vger.kernel.org,
 virtualization@lists.linux.dev,
 bpf@vger.kernel.org,
 mst@redhat.com,
 jasowangio@gmail.com,
 eperezma@redhat.com
Content-Transfer-Encoding: quoted-printable
Message-Id: <5FA6FB0F-51BB-407C-BD2B-A13FC2FC94BF@gmail.com>
References: <9DB6FE89-98AB-47CF-9B57-5F47FBB6DAE8@gmail.com>
 <1791423335.8486545-2-xuanzhuo@linux.alibaba.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mailer: Apple Mail (2.3864.700.51.1.1)

Hi Xuan,

Thank you for the response and encouragement.
I'll proceed with the single-buffer AF_XDP zero-copy TX checksum offload =
work and share an RFC patch for review once the initial implementation =
and tests are ready.

Thanks,
Azadeh

> On Oct 7, 2026, at 8:35=E2=80=AFPM, Xuan Zhuo =
<xuanzhuo@linux.alibaba.com> wrote:
>=20
> On Mon, 5 Oct 2026 17:28:35 -0500, Azadeh Aftahi <aftahi334@gmail.com> =
wrote:
>> Hi all,
>>=20
>> I'm planning to work on single-buffer AF_XDP zero-copy TX checksum =
offload for virtio-net.
>>=20
>> Current net-next's virtnet_xsk_xmit_one() does not consume XSK TX =
checksum metadata and uses the shared zeroed virtio header.
>>=20
>> I found Xuan's 2021 proposal anticipating separate headers for =
checksum support, and the merged 2024 zero-copy TX series, but I =
couldn't find a checksum-specific follow-up implementation.
>>=20
>> The proposed scope is to map the existing XSK checksum metadata API =
to VIRTIO_NET_F_CSUM, using a DMA-safe per-packet virtio header whose =
lifetime extends until TX completion, with corresponding completion, =
reset, and unbind cleanup.
>>=20
>> I would keep the initial scope limited to single-buffer TX: no =
multi-buffer RX, timestamps, launch time, or GSO.
>>=20
>> I'd also add checksum and header-lifetime coverage using the existing =
XSK selftest framework with QEMU/TAP.
>>=20
>> Is anyone already working on this? If not, does this scope and =
per-packet-header approach sound reasonable for a follow-up patch?
>=20
> It seems no one has taken this work forward yet; I would welcome it if =
you were
> to do so.
>=20
> Thanks.
>=20
>=20
>>=20
>> Thanks,
>> Azadeh


