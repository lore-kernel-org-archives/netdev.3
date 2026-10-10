Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 293901A683D
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 08:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791621274; cv=none; b=hpgclr1OnSb0sGwVaJMRrmHhCLeE7xopU8wyOfpZLhd3VYr7WlfRB/6ETyZvqK5btgAgupkI4J6hz+V+keaMCH+VubD8clfHGPo6y1y1pYqdmaxUeRqiIARPyuEy2zHgyYPYm59TMEAzHscWcPdnFVY3JdSyoNQesReXw1P6rsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791621274; c=relaxed/simple;
	bh=TEwsiz8Ih8v3OgTNM9+K8zciWuPTlmI3xhjKYBAsVxU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DPsxIwl2ya4dW94FOJxw4amqBGwA6JlC9GvhjcNdRku9v0bK5QR05CFvZ+tZznyHpYs/833fIqxH4YVp5HRK6iix2MlpX9Sd8szBl1hGzNok61Gwg0cCdbRyKR3xe/ajGk+fd7gbCRJLT5fHB5Rz+NPV1jJIPs9mg/LJaOg89+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PLwN4DSz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PLwN4DSz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16B01F00899
	for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 08:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791621272;
	bh=TEwsiz8Ih8v3OgTNM9+K8zciWuPTlmI3xhjKYBAsVxU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=PLwN4DSz+MbyaaTzYh3u8g0wC64SUgovp4AoIBMOd9SPEdz6u2hARWRz9WWxijN3W
	 UR/gBhkCVcaoSurICwD6lOfueyQ1oZ2YL/fguByVgHrNnJk273g7XAg5aZpW9gTjAP
	 a52T4c2CYMI19kZmwnwKxgcWLElTYfyoI5JhXNXe97ZJim9HKFspf/2PpjFyGeuGZc
	 6Lpal+n5DI+NdOkG017ggougwllBVdenoN/RA7SgrfWLwQGmCQMNiWZMy4w71z7mhg
	 zMWKPVbWRrldNu0VUOzM10zQDv2XQdVsdPrBQsgr+8WUTi86qtvfBM2y8Jzdev5kQv
	 uSGKriIjhFN7A==
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-48eee44b908so336946fac.1
        for <netdev@vger.kernel.org>; Sat, 10 Oct 2026 01:34:32 -0700 (PDT)
X-Gm-Message-State: AFq9FYJg7v19AhYndM9swJTBnLhYQtCNMzexQL0b22JiyCbrdaKnB3if
	O2//Q3aLYvUcsDb0kQWstlLtOv/nPSw7Xmgh8jUx8vvflFjWL+BBOY0P06+kxqlQq7y0GNeV/ZM
	a+T302Qr8nBDqyOL+ig7L5Zmj/EhLkYA=
X-Received: by 2002:a05:6870:8a08:b0:494:b8f4:9a14 with SMTP id
 586e51a60fabf-4a2a8687b27mr3915629fac.6.1791621272059; Sat, 10 Oct 2026
 01:34:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261008011359.63727-2-kylebot@openai.com>
In-Reply-To: <20261008011359.63727-2-kylebot@openai.com>
From: Eric Dumazet <edumazet@kernel.org>
Date: Sat, 10 Oct 2026 10:34:21 +0200
X-Gmail-Original-Message-ID: <CAL4Wiip1pwoyjOsCV2e9Bx7UJWY2mt+J28F3pc8huPEEVkavvA@mail.gmail.com>
X-Gm-Features: AclHuK9Y16wwCvAHyVouHe-_1ye9UA8IcdE1MMFK7IiU4cuP3BwSdjMWrWJExjQ
Message-ID: <CAL4Wiip1pwoyjOsCV2e9Bx7UJWY2mt+J28F3pc8huPEEVkavvA@mail.gmail.com>
Subject: Re: [PATCH net v2] netlink: avoid hashing the network namespace pointer
To: Kyle Zeng <kylebot@openai.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, davem@davemloft.net, 
	kuba@kernel.org, pabeni@redhat.com, outbounddisclosures@openai.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 8 oct. 2026 =C3=A0 03:14, Kyle Zeng <kylebot@openai.com> a =C3=A9cr=
it :
>
> The netlink rhashtable key includes a raw struct net pointer and a
> user-controlled port ID. Both /proc/net/netlink and socket diagnostics
> expose the table's bucket order. By binding and rebinding chosen
> NETLINK_USERSOCK port IDs, an unprivileged reader can distinguish equal
> buckets and recover the low bits of the Jenkins hash. Its 32-bit seed
> and the limited set of kernel-image slides can then be searched offline
> to recover the address of init_net.
>
> Use the namespace's unique, non-address net_cookie in the comparison
> key instead. It is assigned before the per-net initializers run and
> remains unchanged for the namespace's lifetime. The lookup key and
> object hash are still built by netlink_compare_arg_init(), keeping
> lookup, insertion, removal and rehashing consistent while preserving
> namespace separation. Neither public table walker needs to change.
>
> Reading the socket's namespace cookie in netlink_compare() is safe
> under RCU, including during namespace teardown. netlink_release()
> removes the socket from the hash table and defers its final put with
> call_rcu(). cleanup_net() runs the per-net exit methods and waits for
> outstanding RCU callbacks with rcu_barrier() before freeing namespace
> storage.
>
> Unlike ns.ns_id, net_cookie is also available and initialized during
> setup_net() in older stable kernels, making the change straightforward
> to backport to v5.15 and later.
>
> Fixes: c428ecd1a21f ("netlink: Move namespace into hash key")
> Assisted-by: LLM
> Signed-off-by: Kyle Zeng <kylebot@openai.com>
> ---
>
> Changes in v2:
> - Use net_cookie for compatibility with older stable kernels.
> - Name the key field net_cookie to avoid confusion with netns IDs.
> - Explain the RCU lifetime of the socket and network namespace.

Please next time add a Link to the prior version, and/or maybe give
credits to reviewers ideas,
this is something that humans care for.

Reviewed-by: Eric Dumazet <edumazet@kernel.org>
