Received: from mail-pz2-f21.google.com (mail-pz2-f21.google.com [74.125.228.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8924B4889
	for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 15:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789487657; cv=none; b=chOZttX+/H8CqrZODGaxd461fvG0F/kiVVLNelcuJG11CFbqIYfR39wXvUtQwPjtZsN29ZMCUfv3lhfaKfsJ6m8J4/Yom/6tzC2CTCjIHW1VZ59kY7oxTV8CVmnEUlCId/3ZhqKDeJmbc0Txxf7SZBkpgZnSVcNRJcFGYzBG5To=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789487657; c=relaxed/simple;
	bh=mJnhaZcB5kMb3f5fzObUYGBa4/RGju3f+hxU/7+kYsU=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:Cc:Subject:From:
	 References:In-Reply-To; b=TzzcBJ345y15vye192u953E3CTm1DqOo0nAo+gmdFBGOrfYVF7XDrHe46QKllR6NAMDyHSRnp6DUa4aINhTLvhLL5W361HymDAcS7Ie8D/IwRsNmdQDWkSh9oGDcZV0qx4NHvyNRGAldRgwlMNQuwROg36UT211PoxeuszquqyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LP4UWICh; arc=none smtp.client-ip=74.125.228.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LP4UWICh"
Received: by mail-pz2-f21.google.com with SMTP id 41be03b00d2f7-cc4cacd3409so395053a12.2
        for <netdev@vger.kernel.org>; Tue, 15 Sep 2026 08:54:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789487653; x=1790092453; darn=vger.kernel.org;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=mJnhaZcB5kMb3f5fzObUYGBa4/RGju3f+hxU/7+kYsU=;
        b=LP4UWIChu3Aw58AeZLJcsAWjCJWB5juhvCA7uZeXjAqx8cT5uoHB3LDLrEYohL3pHK
         jOJdkStYie7Vm7U4r38s30BaSAeSqFJEGFwYc+WNrZ4papZ3yge9eyI2U2EdkjTkKKo3
         VmSXPqiVUEnXauA0EkdawUbvNNygFk6m/TLQvdo4xSHdTDfMYTWr/hgBJxYcgnnjRUHW
         JoGnXSqm4SRLXzfaAQBqaWRtGW0OyQAvG26cP6DNKhMrdN15Wn1ZqFvCsgSYLWIC3gG4
         IpOdq5+rvsQQ+R572kzT7guNyYGO9iDmrqOKl64c8JReAoa9DtJEkOXMltClyqirnMUM
         NuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789487653; x=1790092453;
        h=in-reply-to:references:from:subject:cc:to:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mJnhaZcB5kMb3f5fzObUYGBa4/RGju3f+hxU/7+kYsU=;
        b=JzXxKf8JjrT7NSFEstU70q+v693ygLLGBO+JGn1pOxq11csZdfrxWLunV3T23dTg8V
         owUc1Zxsk9HQrzCFfnhblAwaE7coHWQIQ4C18Dhdt8EPmfJvH1el6ASWCIbbbxBF2jre
         xES0LPWQNEODfzRBHeUhcaHPf8Pk7FeVWZS6JdnFe4CvYvWJvGUuUF6U4HcmELCmAtrt
         7J1FNPw/YDw9zYAlaL6CdbJFdU3k5pQEHXoiUvyiFvjw8Re67U/RY6pSH/fg3bIdytQb
         cSNxp6rlqm91ddSLdY2CmKCJTlnIYlEDDKK9nmaYV2ZaquzPH0IA7TqeZudk6dcTlj3i
         5MlA==
X-Forwarded-Encrypted: i=1; AKwUvBzh298J0Dekhgy6qpihPxgZMxq8GVtdA/L4IXqiMho9WJCVjUgDE06+pKR/oPomNx5LcglUR4E=@vger.kernel.org
X-Gm-Message-State: AFuF++mjMR7KLVM+xzCsy01PNvii3zRYL6QjxLzjCZJnaWKZfo9HsZs+
	IPn7nUYDG77atkzPk6aJuxvqxOEbaDghJMzvQpzxKeN5LRxdtexC0ydw
X-Gm-Gg: AYBFou363+fmVN+dydLRg/t6UykiLGd4/pmksEU+5uyVDCamQuFNeW6RVxIKxU8WMYM
	go25+HqgYIBcnivKg0Qfn5VhjXJ8lC4noRTm+ugRZhPqS+Pv2EEJPhE79uu7VKpLy1C1xNxnwa6
	JGC2kajMhP78g7ZbpkKbPherhdXHceEs3sgOOK1WUYYi6syJtRdtBRr0UoqBjbn+68HcMJZHGh0
	1bJ+0lIe/lklMJImBso1LO90bjExgHbA+DBhdsnZbwzYumt52LxM50RjeAcBZkS4xng4y5OYwNz
	vUtad0gcAD/awGayd03J26+kgvFx4gwZupIID3OBue3aCNHFq+oMARDHIPrbXhmsAKpQxeuBp3J
	PSu/iHueKaKxR4LrKD387O/PvCWPOoS+IepqXkYDuUhRqNb6x0BICBzGyRb7H+58jX0wvei4jb1
	nJ7Vw3SjMyhVQX0Kn6u+P2KiA8XxGhUHKJ1/WYxN7/thf6wu4itF4djYMDngSIeV0IOQmtmZ7ea
	JL+4UIt0ZEHFTqqJCgOex4Ecg==
X-Received: by 2002:a17:90b:4a8f:b0:39d:f254:4173 with SMTP id 98e67ed59e1d1-39e110dc85cmr2590678a91.21.1789487653470;
        Tue, 15 Sep 2026 08:54:13 -0700 (PDT)
Received: from localhost ([13.93.150.60])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdaccc0fsm6012249a91.15.2026.09.15.08.54.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 08:54:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 15 Sep 2026 15:54:11 +0000
Message-Id: <DLG0FI0V6C4U.8PPNEKEU8LBU@gmail.com>
To: "Randy Dunlap" <rdunlap@infradead.org>, "David Ahern"
 <dsahern@kernel.org>, "Ido Schimmel" <idosch@nvidia.com>, "David S. Miller"
 <davem@davemloft.net>, "Eric Dumazet" <edumazet@google.com>, "Jakub
 Kicinski" <kuba@kernel.org>, "Paolo Abeni" <pabeni@redhat.com>
Cc: "Simon Horman" <horms@kernel.org>, <netdev@vger.kernel.org>, "Arun Ajith
 S" <aajith@arista.com>, "Roopa Prabhu" <roopa@nvidia.com>, "Jaehee Park"
 <jhpark1013@gmail.com>, "Jonathan Corbet" <corbet@lwn.net>, "Shuah Khan"
 <skhan@linuxfoundation.org>, "Shuah Khan" <shuah@kernel.org>,
 <linux-doc@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, "Alexander Aring" <alex.aring@gmail.com>,
 <linux-wpan@vger.kernel.org>, <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH net-next v2 0/2] ipv6: update NUD_FAILED neighbors from
 NA messages
From: "Lawrence Lee" <lfqlee314@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1789448374.git.lfqlee314@gmail.com>
 <4169629e-74c1-4a21-a187-6c65d70502fa@infradead.org>
In-Reply-To: <4169629e-74c1-4a21-a187-6c65d70502fa@infradead.org>

On Tue Sep 15, 2026 at 5:26 AM UTC, Randy Dunlap wrote:
>
>
> On 9/14/26 10:01 PM, Lawrence Lee wrote:
> > Testing:
> > - x86_64 current-config and allyesconfig builds with W=3D1
>
> What does current-config mean?
>
Accidentally forgot to reply-all when responding to Randy before,=20
copying my original reply here:

That's referring to my local .config build options. It's essentially=20
just the defconfig target but with VETH and Overlay FS enabled. Sorry=20
for the confusion.

