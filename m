Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.225.138
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565562;
	b=xshQGZSgoVdoOaRPJC4uLsvbJj2VHGafXb8gc6drtwPkSfa54l7/B7XiQoMVtiFL3XX3
	 NfBySAKJwnQVgVvHYPewm4fcEK5zwgtjXb/sOJ/n/FyZWrzpL/xqLjLQn3672o0B2yMDX
	 ZKiO3FAeQ2ZDQ2S4uMLl9vzMtBzNJDfoRdxMTmR6JEzJKzQi/ppzKUOl4EXndo9a/cCQk
	 991J0pAHeYsFETHQFNI1H5sOia2UG/5yOpmqccDwJtwPR4YrTEx+eSvm6j2U4/Si/BdnJ
	 CXKZyW5gxmQGc5InL0k7DRfkqfVSjS+FAHZ5w7DjLz76tAEz3DHmUZ839LKmOkQZpVg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565562;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:Content-Transfer-Encoding:User-Agent:MIME-Version;
	bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
	b=AKdMVs2Vp2/GRYAYzP7lqjCF4a+5ESntpHSJ3AUyHuJbddfomGjcOMR1hlPTmhoHAI4c
	 2xV4q/rpZx3fK0Qsiiz7Tyqpywj8BDoi0ISxhVeNjFUzZX/pfRztMiSkHYB/d6gruLp9C
	 ruGB9XJxxfnixpYava37SfFridbOIl+q4h0+/WmaKP8ea0Br/9TTQKBp7lhm3Tab+yg6L
	 WbctgqYcOiW9ojVHt7Sbvi17+Gd4cNBmJmTss4g0dsNtGCURDvy+H1my33IjDb15qSGry
	 yKgf1NUUqKqJQq6lnBL066bMdibMd0rvpM8+EE/LKkyC9aYU8YKUHcXqoqneBcw6f5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=amutable.com;
	spf=pass smtp.mailfrom=amutable.com;
	dkim=pass header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EhCy1rjV;
	arc=none smtp.remote-ip=74.125.225.138
Received: from mail-wm2-f10.google.com (mail-wm2-f10.google.com [74.125.225.138])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C93B2606A887
	for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 10:26:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C93B2606A887
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=amutable.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amutable.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amutable-com.20260707.gappssmtp.com header.i=@amutable-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=EhCy1rjV
Received: by mail-wm2-f10.google.com with SMTP id 5b1f17b1804b1-49ff9833fedso1224235e9.0
        for <netdev@vger.kernel.org>; Fri, 13 Nov 2026 02:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amutable-com.20260707.gappssmtp.com; s=20260707; t=1794565560; x=1795170360; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
        b=EhCy1rjVxVdFrlqlBXdnWdhZOgju6UqPO7MHP0T5eDQlLH3bu4fGnJjBmSeu+X4e2W
         fqknndYp9WUsPcSw+hMOJQKeOCVQ26f4CApHOuaHiz0ZnrEcpw06GAGjRX2e/v0KskXR
         kPbczhlJA2JL/E3RYwJYZ55bjMsTqV1bcwrFG/iNBMGzSlTlhWz25UxyOw6nI4axYZSB
         u0krz81cE8qJBpZN+Gj0XIkGJFuZa0vCttP7+3dXPKfvLd7fzcQdMwTNK/JaleYs6P1m
         dJAReh6EvrYwFB4nFlJdvgjX0mrHV5c8k7KozarvFnbaOIXtcKdLHY5nOcL1YTJjLQtf
         x2BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794565560; x=1795170360;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5OyDtStyAeBedN7jaZpmypaL0n4+GQJgji3UYOQMX7Y=;
        b=nFWWwqIazaUEPgXmJ4CEyISfs24q8miQH1jvXes7j86l9M0g3z41bAH/eEpj+yJXOd
         5sSVjM3JBwDn2vSLGg8sa9QtszkYVdLy/5XMjB9dOpL5yyJOMvtKOnH5xfl4nsc+m+qi
         CnLRNVLhSPZdd0/TSOj/y+uc4cbDiMFp6i+lvPaDy76EdJmaaKJgAoi+46oTGzWr/x1O
         4qa+RLttibh5uYeW6vwruSDg4HBoIFXeawH6m+6TztllSW1apvpR36FwciTw3irzO7ey
         nXwVk4o0dbloi5Au58PyOhb8dQp/fLznis5bvAH4fZvX1edt8hwK+DKZgfFfrPh5tUgR
         50pg==
X-Forwarded-Encrypted: i=1; AL+hErGeBy1OoJzlxonfGx4CAOXTdTko4+HoZEEcVgabgSVChyzhguTrRF9mH2D4IXHIuO1VOnNiK7Q=@vger.kernel.org
X-Gm-Message-State: APuU4Z/WC/Fr7lkJjp0RP7y9Pe1owl9zRJIn5ZzKqdvNvRyjDWHotFJz
	yjBPDU+aYD1CbehzpUmkyknTQdowC53LMc5t+kYMfpLNi3rQbRuSzp9P7FlJhhwswFYj
X-Gm-Gg: AYBFou17c0s0/AoPcRvuEdnfpWaJYZdHttEtJ6Mvu+Mhak1kG5M6TFD4SruUcjycahv
	8CfI5ocERfjxVxJa8Cg9orJq37JUiaOHKq2dNqr7lBspTQmadqLdsK5qY2n7/mUaJehFnJrTqGT
	Ea1haLot8z/CVtrz2FcJ4HUof6VrC6AWpH7dRWqMG0bPbQ0An155/yntkh1qq/c34178Ut91ru4
	sgQaoFitItznsyeUVGMgze42d8nljCCscvTaVYZkjyaKKaRHPQKiBJj5p9HdHJmLcW028T45fMe
	fxW9jF26wz/ET4+zoeAF9PsYyCar3GuYtfVHVoJ48PyPasZhT4BbYHZLKVmbwbsqWbT17i8AP4q
	ug6h7XYvBUxC+VUQCuHp5yxrcEo2cMK78y714bM3naSubwG56a6bU85jYQmYzykXQPxkJzBU106
	0x+Rk5gKCWoE3cq/aaxtXwnRQTlL+ylKT/4yHbWGG+aPV5VGBQ+SLNqP/bHod201/JcIEJyOs9C
	LkGvXN/P7vC5sf344Ln49mY837fMCY9w/0MYYE6YizDhmYlNgBcfuCAbegLF/o+JM6QrB0baKG1
	qikDSQSD2O6Rq8KDH+odmp4oCZG+MoWlc2NP/s6IHO6ExcUY7XoSZgB0mfQVFKc=
X-Received: by 2002:a05:600c:4e49:b0:4a1:78c5:79f5 with SMTP id 5b1f17b1804b1-4bb55aa999dmr38995625e9.33.1794565560090;
        Fri, 13 Nov 2026 02:26:00 -0800 (PST)
Received: from [10.0.0.233] (tmo-086-54.customers.d1-online.com. [80.187.86.54])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2538b9sm244439965e9.1.2026.11.13.02.25.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 02:25:59 -0800 (PST)
Message-ID: <fb1d72cf25d10a960da627f6d93a3e041820ed3a.camel@amutable.com>
Subject: Re: [PATCH RFC 38/41] fuse: refuse files on pseudo filesystems as
 passthrough backing files
From: Alexander Mikhalitsyn <alex@amutable.com>
To: Christoph Hellwig <hch@lst.de>, Christian Brauner <brauner@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, Jann Horn <jannh@google.com>, Chris Mason
	 <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-nvme@lists.infradead.org, Alexander Viro <viro@zeniv.linux.org.uk>,
 Jan Kara <jack@suse.cz>, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, 	driver-core@lists.linux.dev,
 linux-mm@kvack.org, bpf@vger.kernel.org, 
	linux-security-module@vger.kernel.org, selinux@vger.kernel.org, 
	apparmor@lists.ubuntu.com, linux-nfs@vger.kernel.org,
 netdev@vger.kernel.org, 	fuse-devel@lists.linux.dev,
 linux-efi@vger.kernel.org, 	xen-devel@lists.xenproject.org,
 ocfs2-devel@lists.linux.dev, 	linux-s390@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, 	linux-usb@vger.kernel.org, Amir Goldstein
 <amir73il@gmail.com>, 	linux-erofs@lists.ozlabs.org,
 linux-kselftest@vger.kernel.org
Date: Fri, 13 Nov 2026 11:25:57 +0100
In-Reply-To: <20261111151202.GA11391@lst.de>
References: <20261110-work-loop-pseudo-v1-0-4c998976c6c7@kernel.org>
	 <20261110-work-loop-pseudo-v1-38-4c998976c6c7@kernel.org>
	 <20261111151202.GA11391@lst.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0

Hi Christoph,

On Wed, 2026-11-11 at 16:12 +0100, Christoph Hellwig wrote:
> I've seen setups where people use fuse to mediate access to sysfs
> sysfs in odd ways.=C2=A0 No idea if that's still around, but if so, this
> patch will break it.


Oh, that's painful. Do they use backing files for that?
It's a relatively new feature in FUSE...

Kind regards,
Alex
