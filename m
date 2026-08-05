Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C343A48CA;
	Wed,  5 Aug 2026 01:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785894773; cv=none; b=CTIGwqKTdv7oLTQKNbdCVj9HUddKIHQVo/f687Ed7ame7QVmq0icnQvo9LOO3O37qn+9jbSTj3ke7aEtCp0zaoBDtnZsN9oODsL3yQOmeR+RI0t4kW25ty4Wf3zOfkgFZLbtJH+OTPGMaoyEJSlaeP5zCETQ+9uLd5IiVAbvEeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785894773; c=relaxed/simple;
	bh=AmCCtjdqpaZpu6rowKYqlHqwqRsMK/4tAeYQMN/s8CE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c/hj9tx4yKYFtnSlSOW8T9kHiT/c6pc9vc8mxL8vwtF2tn4vt3tcf74bpphHutt90I1KjK2ikhPqiTbEfzJTxYJKo3K2Ng8CiVdZkSkVKj7OCeC2/+zXu0XHUx9NajWQX5t7odDqJHE+IsW5C34Fup7Hq2hxFopohxGMXjgPStc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kY4G6RSF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kY4G6RSF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E8CC1F000E9;
	Wed,  5 Aug 2026 01:52:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785894762;
	bh=jFbBtQm/7HHZ2HPO6M2Dc5C/6vMMluZSSPO9xmEvDU0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=kY4G6RSF18f9OEr0l6EN55EohdxUG+VZsmXwZlIcJhqNmZUj6+ebBo0f5Cy+b4xIl
	 YfCDjCiq7/c5ksxddkLJz7XxBSonnrdD3S10D7q9gct2mAF1XyQTNEt+zIf4TfDvE2
	 9eMVdcqZ1YnHlmUbEp/8niqwWOtGs0Hp2TJ+cpI8y01RVqSha58T+80Zq7hAWDxC90
	 DRu+QgNcQ/8McndUJ8Ekl5JSuyzg7aluabCNbwDB97XBmm9KVy+iSH+zARG8473QYP
	 2qSKs7spex/Sl5SJQ71nUfxjafumDsj2WOihmqifNUE/pVGQirAY8sXwxq+ZWr/pwr
	 HFOAzeA+jLBhw==
Date: Tue, 4 Aug 2026 18:52:41 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Qingfang Deng <qingfang.deng@linux.dev>
Cc: Minhong He <heminhong@kylinos.cn>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, Kees Cook <kees@kernel.org>, Eric Woudstra
 <ericwouds@gmail.com>, Felix Fietkau <nbd@nbd.name>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: pppoe: check register_netdevice_notifier()
 error in pppoe_init()
Message-ID: <20260804185241.605ec90c@kernel.org>
In-Reply-To: <fca5745a-dfa4-4e90-99fb-483536c94591@linux.dev>
References: <20260803085957.142386-1-heminhong@kylinos.cn>
	<ae705a66-95b2-4721-9a41-a14f39cbfa92@linux.dev>
	<fca5745a-dfa4-4e90-99fb-483536c94591@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Aug 2026 22:20:53 +0800 Qingfang Deng wrote:
> >> +=C2=A0=C2=A0=C2=A0 err =3D register_netdevice_notifier(&pppoe_notifie=
r);
> >> +=C2=A0=C2=A0=C2=A0 if (err)
> >> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto out_unregister_packs;=
 =20
> >=20
> > You can move the registration above the dev_add_offload(), so that the=
=20
> > unwind path is cleaner.
> >  =20
>=20
> AI-review found a use-after-free. To avoid that, this needs to be placed=
=20
> between register_pernet_device() and proto_register().

SG, but please note that register_netdevice_notifier()
cannot actually fail unless the notifier that's getting
registered fails.

Please do not add the Fixes tag, re-target this at net-next
and add something like:

   This is a future looking check, register_netdevice_notifier()
   only fails on double registration or if the registered notifier
   itself returns an error.

to the commit msg
