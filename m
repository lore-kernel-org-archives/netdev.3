Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.176
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793786772;
	b=EocG/l11Xb2JIw40Z9gO9M68/NsvIujm5uIOStLYNA9xNODEH3+OBO1INek+ShyzYS/U
	 yfQPvGeOytGiA47GaiyHg6h/+bcJgJfIbL1AZpR259b1ugqO39vdYrvka7oGDf+cFum6G
	 B9dhzcEFnk1w+bQeIYR5Y6Z8yu2SbH3YsQ0/LLffPJkA2GBzBRtkXMhgGd9rx9U3qWLB4
	 HCoNkphjs1ShjMI0SIO6BsNfDqthm/7B80bj1iqB2YTbiIvJN0FmWLOQVghMdoF5CAXeA
	 mSlaSc73iTaxL5OheHNXZt7924FE4yE2BKDScAXvVlCGiRiy2lPHXE4Et1nAo1kUW9Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793786772;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
	 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=OZ/Lc2atzdlS6PHoKjibJKd8Fm/mT6zblt3N30zwe2A=;
	b=nUwoBnOcpu0FdY199lUEHDIIgu4SosNVBSfBXkDCO2VOfYfb1hvkdJ/WFIRJitCD51JI
	 V+/M8nVV9WYlEGynC2aZOXjPojJcEe52vQfp+mfU+FupIdxsR8Ry/n08JRcjey4uMASep
	 SP+rVSsGV1no2XxfwUfVi89A/ef0QGvSbHj4YGrlpsaxiV9yto7uGRzFmnFaRJfdeuLOW
	 4LRHg7KY1bGQrciYEmZdRCTnPXxAJcFbsVbt0LRXhLt/NZ4om7/MRKJmq6kjcWBy3bGEC
	 6pQ1htlPADe7qu0rfRZbH9kxAJAGdwDF+OpZd9bVSOdZtFdHBHFG255RAymlGhCpO2g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k0B4Gqlt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.167.176
Received: from mail-oi1-f176.google.com (mail-oi1-f176.google.com [209.85.167.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4DC606A31B
	for <netdev@vger.kernel.org>; Wed,  4 Nov 2026 10:06:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CB4DC606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=k0B4Gqlt
Received: by mail-oi1-f176.google.com with SMTP id 5614622812f47-4d7034a99a9so329412b6e.3
        for <netdev@vger.kernel.org>; Wed, 04 Nov 2026 02:06:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793786771; cv=none;
        d=google.com; s=arc-20260327;
        b=qB98CTNz1JN0ANtmxeIwhX5CW4MtX7QURP1oGpT8hbxjAM/sj7B4bBq+wX9NT3s/xC
         K4+or+spRi7fznmFz9QdOM+6ksZ7aa8sJtDStYNLIW0+KffMPRWwlodhloqseKkAEWAz
         QFa6A63LZOaj34MjfitLYT0C0s1rY4m4EvctQY2/ifzE3UjsVykIKmtmn61SEXfItEkt
         d1HxEr9i9jmAtvmae7tDvn+xYpaFnIdKBuc2iVczcZ9eQa12JrtUxSpr0q4rhTLSyQRL
         t1z/aYBwI2C1CUxPRMmdwPZdpkIwzR2VGRNfVuxzJCVGrr6nhme1MrX0zICwb4ygmJzY
         nsZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=OZ/Lc2atzdlS6PHoKjibJKd8Fm/mT6zblt3N30zwe2A=;
        fh=fLCu+dHkWvlUqt8nP8BllfusHc6HRVP3BbZ35Lf58Kg=;
        b=LIBRz8cBF2vF7OpZKtLekViRVlp+7dv8hKYToJFr2Sxp1+URslI6ySDqxt+RkoIDxO
         h4Q3bNuB18XZMpgT25DVBGYiWaCVhIctqIkfVtL2N9dCCIdL2UNnYQ1o+EXDl+6EhwLs
         6vn8M2dK6zzOKsfp4tJ05wLxH2JfI+jy3J4zfsZVWNo09D2kFbNw2cylGWrDSxuh98IZ
         d2pV+8s3qPlmxAXvSQG3zV5km0jmHEmzcszzFYrBgTkSfR+VRiY2poVVNDIy4iU/29OI
         NvxlLg3NjKCAHYF5BPliw1+0m5CuFkBdIXe7hnR526e8bqzOQzhqJZYXziYcEmLITmqD
         CClg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793786771; x=1794391571; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OZ/Lc2atzdlS6PHoKjibJKd8Fm/mT6zblt3N30zwe2A=;
        b=k0B4Gqlt36xOeJNCh6Er/BJuNdWlBdrrfaaeLNnyTxfMkHiJ3LRXBTLYqTW6VnIhWt
         PsFtCAdU9P53J6z7kqMW0sXopm76nPzNU31CoyVfC+Abm4iy5bHp7tkre72ce7bbeBtl
         G+e/PuSzBE/Wrs0uWo+0aplpq21rnDWXZsU6oLzchkOPTdruDGMdJf8PrYem0nxKQeWQ
         oVHhYTzzppP0D9UAOYJj2/o1N7CP8MACdEer+uj+2UcVCondcBbokiDrmSlVJJe0Bzx3
         wmoeUcdWa7euVBeTgSQ8dZAgMPtaWiSnfBfv0homUE5iAsIQMUP8tHlR5DYDSPUBJgLk
         pt0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793786771; x=1794391571;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OZ/Lc2atzdlS6PHoKjibJKd8Fm/mT6zblt3N30zwe2A=;
        b=RfV4U+b5vyWc7ZQSshfHfT29HvSJ6up2alkZjqPOdZ4GWqnMsyDDWmeid6RqTYjL2j
         DucHTgrkKEdkp0B3+X793F0FFnFIoYm1mAl7U3PY8HxPlhDl48ZpNs5ZXbQm+zYeMGOr
         phKZyRHmm8cjroJOki+BymTvrVkkSuX0ox+mu1ixg+YdexOLtteoGKIV5+ZSSIeddQqg
         JPhfesJETxzsZROx/or5INy5Sw0zanWzPTq0yQkEPRhLhj1AAeT08dcASBDlm9/Xz7SA
         J7+8vt7kvsMeigpxi1HDvIc0Nu1e69dgj3lmtsoXgXfZFAhdJT+DtyJvxKNxhpEnXlBG
         CT1g==
X-Gm-Message-State: APuU4Z9qDeQpC411qU64xiizA6ag6jHgvDwfsnJ6MtCixaLtVFzwPjW8
	0Jf/1fzTJaxGRCapR1EgtsZZC3yN/q4pjRupSs0YLNKwfJu4uDHHsTHQi07vNAX+i34XdlaJEWm
	JGMPg81EJV/VNSpwXJXm1I4x8jE3HkqxGdnhK0Vk=
X-Gm-Gg: AYBFou0eCfcEe60XyTbed2cMJq/aAQLiC2WDO+1GzTo7U3MycZS4mhIB8yrvaYCCwY8
	Y5ROkevYlpdNRl6cBAT1aweb1Z/tmRTpSJHHpFhRu61/bGwvX4JgorTqdjfksRZyEG8hJ6rPVUi
	Qgd8Aeay6iz3RVMsEqGw3EBhLeiyhujBPoUb6ghZ3aOFQaD5YxvPBf4Qij2Pg84jXuvr/A9xlv9
	xGJD9Ozne+XFNNlP3Vnbmdm+UQ3Vc7OvC83oSxE5i9mMCxiQ/nGVq3wrxuYmuFZ7ajgIBsCY261
	uf9xFRxeJc3jf50UPFZk8NSbmgl2NUyixoICDoEjSC8nj95gSdWbgUUathz1JFvAPT6fDF7cn2U
	cigyN+3wzAczBgIr4GQR+hmbVaie7obC8xf153abyeXn96HnmHKxNJT2gu55CYyv92ntUom0=
X-Received: by 2002:a05:6808:3a0d:b0:4b9:e6ab:d085 with SMTP id
 5614622812f47-5640dd277b1mr10897713b6e.37.1793786770706; Wed, 04 Nov 2026
 02:06:10 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261102155641.3682626-1-mmyangfl@gmail.com> <20261102155641.3682626-3-mmyangfl@gmail.com>
 <84089fcc-0150-4464-970a-09400f3ec5ca@lunn.ch>
In-Reply-To: <84089fcc-0150-4464-970a-09400f3ec5ca@lunn.ch>
From: David Yang <mmyangfl@gmail.com>
Date: Wed, 4 Nov 2026 18:05:32 +0800
X-Gm-Features: AclHuK_lPVKhdBS5T7TT7NXGuhN1GFF0oSF2CW2k7kB40YvYn0ddad8zYQxOMNE
Message-ID: <CAAXyoMN4ySBtnLjqKcfAa4XwUR14-fjaJh-hcCyumERagmcHvg@mail.gmail.com>
Subject: Re: [PATCH net-next 2/6] net: dsa: motorcomm: Rely on port isolation
 for CPU port
To: Andrew Lunn <andrew@lunn.ch>
Cc: netdev@vger.kernel.org, Vladimir Oltean <olteanv@gmail.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 4, 2026 at 11:59=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> > -     ctrl =3D ~priv->cpu_ports_mask;
> > -     res =3D yt921x_reg_write(priv, YT921X_PORTn_ISOLATION(port), ctrl=
);
> > -     if (res)
> > -             return res;
> > +     if (!(BIT(port) & priv->cpu_ports_mask)) {
>
>         if (!dsa_is_cpu_port(ds, port) ?
>

The next line is ctrl =3D ~priv->cpu_ports_mask, but could change both
if you prefer.
