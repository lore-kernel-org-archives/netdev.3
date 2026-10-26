Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793036103;
	b=iy3SDMq0YEJt/pLZNSpy545sTAbED7kd/cY7BQBHCs4eflbpBcqDAQG84dSenbiwZnoE
	 O9cZmJ5J1pSPVIQKtS2AKEYbo/dfM2Gkfmgpl6xvA/hVi/Yub0gEhYdtt+F9PPeNnPtKV
	 8LC3tXocGuE0tkoY/j7uvn7rmpZi3O5RfEQrket6Gyg/H+IXbDTZIRAAcQJz32fkKaTJ6
	 OlPaqv8f3HZwbyHlNNrMNuyRtewJ0wdRp4U+uP2C75ERxrOobGkNR8JPv4E2AKUtg9M6o
	 i6VCsAbnFiyOGOLRmFHxCyNc319LqJm+oKxzK/wip7QtYiGHSe3QKE3AJGP/U7dPKaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793036103;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=CLltlh6sC7r7rj9wfuAWPf0WXTYFuQ/Kfp/4na9601g=;
	b=0FU6HPumpcuJ2DVdB0mVppvwQ1gJw/yT3Kf+eQmXdw0NoZ7nHiS08Gh1MTrBP/HVIJ/A
	 MliUs3jfBqWvTcihVgcNSfO/1uZ1Uw625J56jTk5x/SZqilig7YkXsK19BIkckjvp7Zcb
	 GhQ8XKArPu+InlvKCJyHDm8SXXJSbXPB5mwcMf0znZgIJnujnGdJtYbfbRYJt8ZOVPY77
	 wjQc+jWalQXrsIUobQIRalYIdwBx3WQ/05b959OEc9b9OpxYrT/SCI+0F/AbznIshpgIs
	 fJhN8XUqE1asXSzfWjMVRHth7AoAp174BcTGTndjTAJwsbPZ96VOQjLWub2PUjI47zg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3lUipxH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29894606A31A
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 17:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y3lUipxH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAE5B1F031E5
	for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 17:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793036102;
	bh=CLltlh6sC7r7rj9wfuAWPf0WXTYFuQ/Kfp/4na9601g=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Y3lUipxHsc+8yOCQKHZ+4WiQg45grQtnp7qpt74q2XZYwgyYUHbh3X8vEaVFcTaE2
	 voniBXnQalcKfhG8h556CcNputTcGJKxBLF5+BciJIkVYUVmzleIQZ9ricR2oxi6Ek
	 /0xN8aubSEFgum5ve4WkXpi3toOZRUPn5kwHJd7N6PugslDqHpn6kNbau2boxAIZpA
	 uxa3b3EeDT5ZpgENbp2gK3PFTgZq6SjsjvR6unVH++XdECtoh/I/vgtnqMI0ka4U3I
	 HFNNH1nGDGUbEQb1zZWtlpoL439wE/dpVEjYPVjZlOUSomnryGjSv0GFMASKahROFw
	 4RPPBLfUKXrkA==
Received: by mail-oi1-f173.google.com with SMTP id 5614622812f47-4c5d8c7f326so1267996b6e.1
        for <netdev@vger.kernel.org>; Mon, 26 Oct 2026 10:35:02 -0700 (PDT)
X-Gm-Message-State: AFq9FYJostMQPyaHtn0SZ1sqN7+Piw/Njv7AOG3vI6paXPeDcvY25uLG
	iE/+by8YzYr/HI2FCdZB3hQXHZi8DCL4E9gz+adrY0vgb9+oq+xw0bsvmCfxxpSO4hSKCwLyNom
	COMn7IJK3UODhN/xYioeCaRZtyfN0e24=
X-Received: by 2002:a05:6808:4f0b:b0:4e7:c6f2:75a6 with SMTP id
 5614622812f47-55c0042ef3fmr5156313b6e.68.1793036102120; Mon, 26 Oct 2026
 10:35:02 -0700 (PDT)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <ACT-N6N4.v3.r0.20261023200137@mojatatu.com> <ACT-N6N4.v3.r0.20261023200137-1@mojatatu.com>
 <ACT-N6N4.v3.r0.20261023200137-2@mojatatu.com> <CAM0EoMnjxmnoZ3a4XCB9YERcCwYhYW8-jKw1UZ79YzhFct9+KQ@mail.gmail.com>
 <CAM0EoMkct9bMMZHPRKh3xZ-L5GTX0SeLdnp_NQd+C_QWspHW8w@mail.gmail.com>
 <CAL4WiirtOb9t7DHTk_bawuhAUeKYTQL_p0DvOZDL-HhuKr+h2w@mail.gmail.com>
 <CAM0EoMmGnxd6s+e_VN734KbbYK5UVZH6yzeU55En2-VqyGkSrw@mail.gmail.com>
 <CAL4WiiovvM9OTbMdN3+-74gSV520ihh1yqevH2T+OoWNiL2k4Q@mail.gmail.com> <CAM0EoM=-JsC1YhodxNUqv95zZST=phXFupg+Z-TSP+UWWeOYxg@mail.gmail.com>
In-Reply-To: <CAM0EoM=-JsC1YhodxNUqv95zZST=phXFupg+Z-TSP+UWWeOYxg@mail.gmail.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Mon, 26 Oct 2026 18:34:51 +0100
X-Gmail-Original-Message-ID: <CAL4Wiiqdts2TKS1QqQmc9wqTGKi2UANF0_NDTFHNLON-ZVO7KA@mail.gmail.com>
X-Gm-Features: AclHuK-UIDM0MyNqU16f8_PXSAAqLu7sH8gcO6JqIb_RJufO5tUQ1IcaIWeiznI
Message-ID: <CAL4Wiiqdts2TKS1QqQmc9wqTGKi2UANF0_NDTFHNLON-ZVO7KA@mail.gmail.com>
Subject: Re: [PATCH net v3 2/6] net/sched: act_mpls: pull the inner Ethernet
 header after POP
To: Jamal Hadi Salim <jhs@mojatatu.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, "David S . Miller" <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Martin Varghese <martin.varghese@nokia.com>, Pravin B Shelar <pshelar@ovn.org>, Vega <vega@nebusec.ai>, 
	Willem de Bruijn <willemb@google.com>, Willem de Bruijn <willemdebruijn.kernel@gmail.com>, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le lun. 26 oct. 2026 =C3=A0 17:02, Jamal Hadi Salim <jhs@mojatatu.com> a =
=C3=A9crit :
>
> My position still hasnt changed at this point - and going even a bit
> further: fix the consumers in "net" and this whole patch series goes
> as net-next "strengthening" patch set independently. If you fix the
> consumers the bug cant happen. I understand your position on
> performance degradation and i empathize with it.... i am curious to
> see what clever thing you come up with (you always do ;->).

OK, let's see what I can do.
I really want to inline eth_type_trans() in the future.
