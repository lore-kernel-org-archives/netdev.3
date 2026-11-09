Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794255303;
	b=XFGtPLHuwmeLmz34rj47uFV8HgnrSZCiR06gIODStPwzxqc4as0cAW00DpEtYGY1mr4b
	 HGiKlSS5dqDTxSOsnPZAPwPgtTDkQbK0xgNUzot88dS6HkTiMSeu/NJ6OGP3twnobmQad
	 3JYojTnduUkOoPTMkKZu7Ro+UI29ZcwmGHJmHBOPpdFQZSWjTcavkVeY3RoS81jrWTW/Q
	 1Ynnc5zCILAxwWevWeN+D733Mvnp6GOUok/hXpaHfXu4u9urt7eHtIDPHL9weo4QdR18x
	 g6zeWeeULhDv0fghUSnaAqJSO0+mfcl+48pBcinoo46lpfUL/po/U93MC7xfEdbGDZg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794255303;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=dcA3JlLu3QaK+Vcd+6otPpngHTSFEBthNfyVcNg6yB0=;
	b=kZN7XFVAkBEByOF8lpEbn2tbcTg6mB4msASj+roro+d1ovRRJ83hKO28xdztowKC63Y9
	 kuLTwLmsnDBNUR1X+OVwOlTTTKxPrceFlxxKMLIt5fw+ucexV70ya9GgBihjyqZ3HhC/5
	 sYi2UZYOAz/HV9uYuOoRXAMJ8kzIRHPqSeBvE88I2iaxPAxJHz5nGIfUTdbhYonlSwhLL
	 VWZlaB/1m70oKN2RnYD0e0TcT14ah126JHUmfw3hgJ+Pq6aqOznj5721QZks9yIRVVn/y
	 7FFoKQVGiZrZMkFoYUVZB2GKi5m3IlKqbIVAsjv82qbwr6HXs4G0bvGglsiIA/+p3yA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=JM3aG7UD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.210.177
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E431606A338
	for <netdev@vger.kernel.org>; Mon,  9 Nov 2026 20:15:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4E431606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=JM3aG7UD
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-8b5efadd183so591424b3a.1
        for <netdev@vger.kernel.org>; Mon, 09 Nov 2026 12:15:03 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794255303; cv=none;
        d=google.com; s=arc-20260327;
        b=nZW4clVJGEWHPxe1OelDhg+M0wlKAEF0WbXAKq/4DYKvVZHKLOAl77I1SuAQjfU3TN
         ZXZb2t7pL7+Oow1AkLyjWpl5lK4fd2EZdM73/VGGOlVZxadTLpyPFNYzsuhCFBZH89y9
         2JPOsZgp7fXkx6D2ZoZRfWyKfj/l2IVeWjuhfT/Oh84tnZ04O2EDjz/EuW4wtY4a1kFA
         HYnQjo58lZ8hBX07qIWtEU+BJ1T2dfmcO3n+vCvrEhCzpdC7fARE2YtY/jNB0AKOg/Ih
         SybdfoUHisNmrVjJ+EW3E4+Ogqh8lxgHaUkle3LZGYaWwCrHvnIFiy2m1qTuSVEYZCAa
         jzPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dcA3JlLu3QaK+Vcd+6otPpngHTSFEBthNfyVcNg6yB0=;
        fh=ZKgGYM60J44Co+tTP6pibTVx9aOU+1aIX2v5U0bXuZw=;
        b=rSFSFRTdVj0E6F6RsBNBSwkth3hMfGoujfQgbpp1q1frIdDVj17mpG/Z325Mcu+f8K
         ev+lfJ3ozrZ8jyl4UElU3pVAKzN3oZ6iLQjfQCfNL+sT1N3MaJMxYeala+TS+3x/gOl2
         VOv0bHUatHBXdscNNaYAaxWUfdYkBboJcCxFA7TCncXmi27swYQE4rzSu7C8OOX9zdK8
         c4FMZZKEeyKUv02yeeTgERoogq+2Wn06+4KmPnpgH7XxnZx0yB+8/2oHjZ0ZFuAOLQte
         iey6Eo4cymIaMFXOxC6Xz4dg1rhq5Lqk31Cdr8q02LGVBEaaL4E+DsucSetmbzsHZE5y
         aKVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1794255303; x=1794860103; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dcA3JlLu3QaK+Vcd+6otPpngHTSFEBthNfyVcNg6yB0=;
        b=JM3aG7UDhE3ppbxcli+QQzARg2Kk347vy5ytnvpfinkJQjCez8mFUwcYs8+/PrAO8z
         qQXYwQgzy8NbHr19R7sZA4uRrRbYDLtCZTFfnP5xl9j5o2XEJs++ZuMTq6tvsc8/HEJn
         psFEtb6JYK9B1K2UCYWdaKijgaM/Sq6WoMXKjc08cwsZyhvosTpftZa2yma2RSbfY9xo
         Q3vHnPYquzJjxSmB1OqnqGohXqzBVuNzvCn+GTJhiNm7oW7SLON4wQa1VbC7cxzBbOjC
         DAXh9HTRv9+dK3JjCLtk1lYJ3Sq5ALw0klGRsuHQqUUOUkAIo4X4iR8NKPL5u45oL4wJ
         ht3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794255303; x=1794860103;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dcA3JlLu3QaK+Vcd+6otPpngHTSFEBthNfyVcNg6yB0=;
        b=UH+aQZTVSDwqP/E47dOwReIB2fJASqkm8MIF6fStRGekha41rQvJRdMx3z5TPyFD/V
         ia5aUM/g1AycogWZidRl1q3TP9wlTEihFBq3WtaVRdJej2DFA1lbNGiJigXPA+xZjJmE
         +RhpwPKqKi9gGfDy2cLB4WLcPN2JJUlAG6WrtZ0BJ/DuCzKc2wJjwi2ur3iEg5dVeF/B
         MU7Jhm5SRUXqynFFYqOAVOrNtrnnHPmYNbzKq4PQewHtAH+dIfbbavO1AHaVqJYb5/3R
         gYqvkCMhcpIX+8t0KCG1nce7xEcncUoTPWTzBjHoTe7Uo8JRpMAW+1hkhfg1lRmVCJfz
         E3Yg==
X-Forwarded-Encrypted: i=1; AL+hErET1ZgwUfkiNRy6yrnmEWBE9OGdejtxoaZ1Lle4yvnqZzlmXTMWxyhl5K7rpsd3ATWJQo8b6MI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8iVULPSdZpDP6K7Ybj1/2FYierFwac0c1igGRL0K+z3QiTt8gM
	BZSnhbhLll/tS+jFn5Z+AKq6leCVpmKYo4eF/jjwXspBNn9pw1cC9q1Sy2/Ggva/Kq+MJlhXH9s
	muQi6DXKAUqlg0l0OFY97eyStv9UBo5NSnS2XZTtfNFm5YIc6DFA=
X-Gm-Gg: AYBFou0EtBLowb/KhWfjAFPX00FhHh51YnRR3I71rKAmw5/wasqqqPNfoPble4fxdQH
	/+HILJgwpglJvSCcX0DWzzd+iiRYoC5A4yeudj7UF5NnqxTQqIkZXx06eMM9Rvy9J48zOjalvNi
	mWPpqOJRfDx/nsEEe8LwZlGbZON8TRWFSS791PzS1dP+rd4aQmzoDMY6lAtuTnbTkkDQRBXG3pi
	SPIDtc4Yc3eh265xcvclO9ANRlKlDDQ12WHqCnwsv7BP0U+zXD2CjIWbwPNlNKcu4DdVSo7HuzY
	nMOXlD+9n1yhz3TkCTLPHqVHGwUvALiX6IZ+wEn4iVnaQztDb45Sm4bTsgrI5nv/MaEco+IdeRv
	BEjSuKuXAZAzvGPiY0tbwr8QrJ1wsWFZXXDC09NRkjeQ5vyZWRZgNdLR5HjRoc2z13tsT
X-Received: by 2002:a05:6a21:62c4:b0:3e1:4e53:4e7f with SMTP id
 adf61e73a8af0-3f18f4ac9aamr162563637.27.1794255302075; Mon, 09 Nov 2026
 12:15:02 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261106-cipso-rcuopts-v1-1-31ae931d7a0f@google.com> <CAL4Wiiob6K=Y1ne0G+8L6b8fxNxdCz3z+THgCiCBX_5MjtSzcg@mail.gmail.com>
In-Reply-To: <CAL4Wiiob6K=Y1ne0G+8L6b8fxNxdCz3z+THgCiCBX_5MjtSzcg@mail.gmail.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 9 Nov 2026 15:14:48 -0500
X-Gm-Features: AclHuK-R76EHDsnszW-O6Vgi4DzxwqLyNag33759siqThBnXu2JAqQRN94reBA4
Message-ID: <CAHC9VhQGms7L3EL19tB+TRKvNP3ttSumHOdWcNM2377-fQiEOA@mail.gmail.com>
Subject: Re: [PATCH net] cipso: stop modifying live ip_options_rcu
To: Casey Schaufler <casey@schaufler-ca.com>
Cc: Eric Dumazet <edumazet@kernel.org>, Jann Horn <jannh@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	James Morris <jmorris@namei.org>, "Serge E. Hallyn" <serge@hallyn.com>, Simon Horman <horms@kernel.org>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	netdev@vger.kernel.org, linux-security-module@vger.kernel.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 6, 2026 at 6:06=E2=80=AFPM Eric Dumazet <edumazet@kernel.org> w=
rote:
> Le ven. 6 nov. 2026 =C3=A0 22:40, Jann Horn <jannh@google.com> a =C3=A9cr=
it :
> >
> > cipso_v4_delopt() operates on the ip_options_rcu of a socket or a reque=
st
> > socket, and tries to remove CIPSO options from the middle by moving all
> > subsequent options.
> > That's not allowed - ip_options_rcu can be read locklessly and must alw=
ays
> > be consistent. For example, ip_options_undo() reads trusted offsets and
> > length values from the options buffer.
> > Fix it by doing the modification in a copy.
> >
> > The core change is in cipso_v4_delopt(), the rest is ugly plumbing to
> > propagate memory allocation failures.
> >
> > Triggering this bug requires that the system is configured to use CIPSO=
.
> > (Setting up CIPSO requires privileges in init_user_ns.)
> >
> > Fixes: f6d8bd051c39 ("inet: add RCU protection to inet->opt")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jann Horn <jannh@google.com>
> > ---
> > I've sent a separate mail with a reproducer to Paul Moore.
>
> Reviewed-by: Eric Dumazet <edumazet@kernel.org>
>
> Side note, not for this patch: Smack calls netlbl_sock_delattr()
> and netlbl_sock_setattr() under bh_lock_sock_nested() only, which does
> not exclude a concurrent lock_sock() owner such as
> setsockopt(IP_OPTIONS). Both sides can then kfree_rcu() the same
> old inet_opt. This already exists in the "cipso only" branch of
> cipso_v4_delopt() and in cipso_v4_sock_setattr(), and with this patch
> the copy branch has the same issue.
>
> The rcu_dereference_protected(*opt_ptr, 1) in cipso_v4_delopt() hides
> this from lockdep. Smack should probably use lock_sock() like
> SELinux does in selinux_netlbl_socket_connect().

Casey?

--=20
paul-moore.com
