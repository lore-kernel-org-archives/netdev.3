Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793682325;
	b=PFbiTfQ0YIMYeRsSwvBnOkAw0g1ncSAiuuOjq23oQhbbqk9tCQECeoGPORGH7H+W0Y+W
	 NMchxkXC+XKOWwvgC0rnGq9G9mrq2CiZVnol0gCYAparsC3Pdz9Os5bhEN0z3oLGnDo1J
	 LIbeU6z8I2cJZjGjJPuvLAdymsdBjKtEPw0OM+AbI0YjE6zPlXvFKGCtmRB4mm54XZ8ix
	 Mgeu9b1s2T0oCC1EmW63oMU+b9foz6UEVJJUPVLaZOGUc9FvF6J4XvsEOsBb9DMuK0ip7
	 HbfYOC/6tc97rr+f6AfzCTr6imJXgL5JnaHXwai1Kmj1yLeGgWYtwtDyIJeprb2FPzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793682325;
	h=Received:DKIM-Signature:From:To:Cc:Subject:In-Reply-To:References:
	 Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=9dX1ycvSZiHfms8oEjo8JLFfyN4bx9q3Sa6CmHeQYCs=;
	b=PJPKQ2O/HguLpvWHnLZnwtbSnP4HL1FQJ3WcS4l/A45njeJyWD7MdAVJt/FRjmOMjKRW
	 nLWMiIKTouyuOZUfaGBwiTWlwFrkrwHl01Ms9EGVEPoSi3em+7ZR30QU3XEzC6NUO3tjr
	 hNpYjVSBD8XEpCUAVIUdtdR7ch11O4eZER52/mPZDCDxr7UWC8lsPZSMTLOeIv6/AAqzr
	 2pfY7BIevsIsQ1XsNVbVmQARD54mTWiNnfPERDRoEbaZqPnoSwQlxewypSX8qVAiY9lUy
	 xAiaSrKPdvzExQm0WyAHMtuMfiPEYdRjQRmGb6wJQMFRsfJsUfLBDkBKw3hGBMe1jZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVh+ivnX;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2EA606A326
	for <netdev@vger.kernel.org>; Tue,  3 Nov 2026 05:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PVh+ivnX
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144781F000C1;
	Tue,  3 Nov 2026 05:05:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793682324;
	bh=9dX1ycvSZiHfms8oEjo8JLFfyN4bx9q3Sa6CmHeQYCs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=PVh+ivnXoceQb68/FNXEvG/Ig6oAxyBFn6bCqOYLqTYCSDUqxF0ju+G0KVwr0sj4r
	 kMjAMGrdprYt5DINljknlgYaOEye66lErssdnbXB4sJlMUChKthblXKk5yrpoF4bzM
	 wCeteLfL+B76S6cx9COxqydXrc1LfvJIxZjTm8w3Tlk0yy6811LLrlmrFHq8tZaR6u
	 PL+EvLcl7NQ3ZOK1/EGXAhu06YW2+DekoTlYp9kNA/O+sErGsf+a8UTWfkcf3FWrX5
	 KgMpfiGfhrDRLr9QrKaIn7NPINqyyXyKdAxmDM1xapLWolMQtWpgJK92K3QmcQig4P
	 RY74AG6LSB4Ug==
From: =?utf-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>
To: Stanislav Fomichev <sdf.kernel@gmail.com>, netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com
Subject: Re: [PATCH net-next v3 4/4] selftests: drv-net: measure devmem
 performance with kperf
In-Reply-To: <20261102190827.989117-5-sdf@fomichev.me>
References: <20261102190827.989117-1-sdf@fomichev.me>
 <20261102190827.989117-5-sdf@fomichev.me>
Date: Tue, 03 Nov 2026 06:05:23 +0100
Message-ID: <87wlqu33os.fsf@all.your.base.are.belong.to.us>
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Stanislav Fomichev <sdf.kernel@gmail.com> writes:

> Add a separate udmabuf-backed devmem performance test using KperfRunner.
> Keep correctness cases in drivers/net/hw. Skip the test when kperf or
> /dev/udmabuf is missing, and fail it when the kperf run fails.
>
> Example metric output:
>
>   # # ktap-metric-json: {"goal":"higher","name":"throughput","value":389.=
127}
>
> Signed-off-by: Stanislav Fomichev <sdf@fomichev.me>

Reviewed-by: Bj=C3=B6rn T=C3=B6pel <bjorn@kernel.org>
