Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA6F233920
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 03:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791259177; cv=none; b=hyZRvVCP1CLqVkHmWxvSGR7lcCwPlHkNxBTWbRcMmzEA1NMtFsyNEsmXnBmRfUrgThMo6PTJxpov8FykJ5cDCINlvlVezU78mUwB6VJGkfECJI0eJEe3ihPdqFCxfANfpPGC6m2QjKaDqecu5YwqY9BCxZaNj/+gij85WVjPl00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791259177; c=relaxed/simple;
	bh=WQmFHAI99v1cMif0KgogEHAyCvt3FSObu0aHSWXuIow=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eyQ48dbS9Lll9lCix184qIURw0hbqINu9HyBIHSvzHKFm2UZ5PbAUX38Z/b9dwMn6dBmyDpS/die4W4XaILG8mNl+gCV7VWhTfAYPFhIt1MGsW48e+dSlEHqx13J+aO34apgUdEHNihvZwmIteeDnnMFbOwVfH4FbRzG64qfEYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BXIE6ToJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BXIE6ToJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5C931F00899
	for <netdev@vger.kernel.org>; Tue,  6 Oct 2026 03:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791259175;
	bh=WQmFHAI99v1cMif0KgogEHAyCvt3FSObu0aHSWXuIow=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=BXIE6ToJq8HgWLnSOW+DQp1suuCCFB8XZ6Mce2N2N2Sze2AIF7LWnY4siUzNig++N
	 6R+JHpA5DwFgGNT6/Rnin9rdNK5n2Cv0Xh1mQF+BIUrjd7tEmXUDuAhtZTPkn8lIYb
	 ++fAco1TF6UBlqIQ/WCXZgBpnOLN2Wmgc14HIQX1dEl/UG8VcbLw3ooz4oyfmNKspe
	 632ZU0oQM7CBmh914nNOi+lcfjgU7maLoQeRsWKJkA1WQanvc5dxAzPhsud0wui9Bo
	 YGFt3VPVzwuN9glIRnvGD+/C3qmxaixGVZnSbxSHpD39vOyo46Mc2+Iq28KFS+y/cP
	 3o8RC09BamNLg==
Received: by mail-oo1-f50.google.com with SMTP id 006d021491bc7-6dfc4510440so258987eaf.0
        for <netdev@vger.kernel.org>; Mon, 05 Oct 2026 20:59:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvByuq+QPZVsHfKP6CXQX5BQSJVDzsvQ3KIVyL1cFNHpG+w54qkwoRWQxNWMekAsZlBX5mGJlJS0=@vger.kernel.org
X-Gm-Message-State: AFuF++l2efM+cpjN4ihMIcnGGT8o/eyh6Lb1x+tz/BDP2ccZRc4alyJH
	74aujDBlwdQvcJjjLKSTNvkjVsq1akPWq7wlqZ4CD0yHkpb/xPfR6a/jroD9bXRcKeEgOov1ac3
	EZdp9f4nWApVS7PUxf7UCLncN8o33x08=
X-Received: by 2002:a05:6820:1908:b0:6d3:abd1:9b92 with SMTP id
 006d021491bc7-6e4a7d4ee70mr1048558eaf.56.1791259175300; Mon, 05 Oct 2026
 20:59:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261005023812.130639-1-edumazet@kernel.org> <179123498942.434549.13440734253618262332@kernel.org>
 <CAL4WiiqwLH51iXsqmuUKTeP4Mo5Tv-qZ_D_MzaGK6C81nxQ6SA@mail.gmail.com>
In-Reply-To: <CAL4WiiqwLH51iXsqmuUKTeP4Mo5Tv-qZ_D_MzaGK6C81nxQ6SA@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Tue, 6 Oct 2026 05:59:23 +0200
X-Gmail-Original-Message-ID: <CAL4WiipgggQfFhc2DMTaBF+j0N0A8wg6TDb3gsEfdDAnPLaV_w@mail.gmail.com>
X-Gm-Features: AclHuK-b2Ms5MyWpBUCSQaVi5Vka2572xYI4b5qcUJXxeDvEvRQbYAASAqOr3Jc
Message-ID: <CAL4WiipgggQfFhc2DMTaBF+j0N0A8wg6TDb3gsEfdDAnPLaV_w@mail.gmail.com>
Subject: Re: [PATCH net] bnxt_en: fix DMA mapping length for padded small packets
To: netdev-bot+sashiko@kernel.org
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, 
	netdev@vger.kernel.org, stable@vger.kernel.org, sfle@kth.se, 
	edumazet@google.com, michael.chan@broadcom.com, pavan.chebbi@broadcom.com, 
	andrew+netdev@lunn.ch
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le mar. 6 oct. 2026 =C3=A0 05:56, Eric Dumazet <edumazet@kernel.org> a =C3=
=A9crit :

>
> Looks legit, I am cooking a V2, thanks.

pw-bot: cr
