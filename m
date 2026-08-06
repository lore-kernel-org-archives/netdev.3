Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A10C8635D
	for <netdev@vger.kernel.org>; Thu,  6 Aug 2026 00:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785974504; cv=none; b=YcL6DQxtw+LXtoG8xXdcpC+A+CrGWTUJoPipT9jZ/CL0voJSaTv1OgY+QdKBdJIIC8TkStkByrqRcfU7Zl7YK9x84DcECIIaO0+tloqb9FxhD87VY5gz7+/HjwxXP+CRvH1B99YLNxF2tKygPipJzCv+7UM51YoT6py0sJK6cHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785974504; c=relaxed/simple;
	bh=Of/Isi8Mx3TWtpHIgadylG0S16dlma+fji39xj2KXZg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/mLhmAmiAJIQSO0qy0RI8gQ38+xhtPx9PeiKJWmZVt/sN13geKtkphJ/UnFviCNqb8saZyXV0IEOrzsbpfWqmsg3SLeiL4b224QE35uefke97q73IZmMf4nl5vwanh41LLEpRxvOva1Ixc0kHr7zAUH0WP1IREq6nn7VTkx4Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UDjyug+i; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UDjyug+i"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1FDA1F00A3A;
	Thu,  6 Aug 2026 00:01:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785974499;
	bh=Of/Isi8Mx3TWtpHIgadylG0S16dlma+fji39xj2KXZg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=UDjyug+iWybk0qic7T6BLZUMZohKyZ64kAsr+5caGXeFpaHqVPEmZmj99vIek8Ay0
	 eXHVVwNTIZr1/rZSgjbAp6VSJyPGiuYmpZ3o9cHRhUl5ZyOHoT9PmNLJODFU5Ngdeo
	 1zGud5E19tuiUS7Bp0Lb2NhkTP1+BVjdzKpk5c+Hsb7MCIXwaNHvhc5Utr+yM2hieZ
	 ft8j8AxPywH02ScI2YOXuH97YVFy01dM7uD/JObDL/DlKkAajpaA/rQuVKtxgS6/TD
	 MV6Rs+iqElsXK+I4KvBycbnW0kfWsla64xNHoAvo6fvAP7o/h5LCdzxia9HLMzbIni
	 jNmVCZ6EVOjsA==
Date: Wed, 5 Aug 2026 17:01:39 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: "=?UTF-8?B?UsOpbmljaA==?= Bon =?UTF-8?B?xIZpcmnEhw==?="
 <renich@woralelandia.com>
Cc: <netdev@vger.kernel.org>, <hramamurthy@google.com>
Subject: Re: [PATCH net/gve] gve: fix early boot deadlock between rtnl_lock
 and service_task_mutex
Message-ID: <20260805170139.2ddb6216@kernel.org>
In-Reply-To: <18c88903de19db1f.df50d089680ca23.c305d6e51002e357@desktop.casa.g02.org>
References: <18c88903de19db1f.df50d089680ca23.c305d6e51002e357@desktop.casa.g02.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Aug 2026 07:18:21 +0000 R=C3=A9nich Bon =C4=86iri=C4=87 wrote:
> We hit a reproducible hard deadlock (AB-BA circular lock inversion) durin=
g early boot on EL10 / RHEL 10 kernels when running Google Cloud Platform V=
Ms with the gve driver:
>=20
> 1. Thread A (NetworkManager): Holds rtnl_lock during __dev_open -> gve_op=
en -> gve_queues_start -> gve_add_napi, and attempts to acquire service_tas=
k_mutex.
> 2. Thread B (gve_service_task worker): Holds service_task_mutex, and call=
s reset recovery which attempts to acquire rtnl_lock.
>=20
> Serial Console Trace:
> "INFO: task NetworkManager:856 is blocked on a mutex likely owned by task=
 NetworkManager:856" at RIP: copy_net_ns+0x1a4 / selinux_netlbl_sk_security=
_free.

You emailed the upstream Linux list.
If the bug exists in the upstream kernel we will happily review the fix
- please post it to the list.
