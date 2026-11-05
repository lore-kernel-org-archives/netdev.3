Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.remote-ip=209.85.215.174
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=fail;
	t=1793920457;
	b=HKUyH43JKXDUcBMNGSc5psh0ykiHFA9oI5qrCK6IS6K+OlPYdoBCBHpCFDrOJkABFsjw
	 U3B6IUoasg+wp9nc5Jd7qxHwr8Hqc8IyrwijOL6IdiCxF16KmCEMAfd22tvLiHK1+zqQL
	 l/uOX5UuFIsTSGQZhBQy7rKpvlOzJ4Row27PHn+eQpH+eCYnRlEjdthE+Gj2avP/EU8Ud
	 k4oEhibx11I0SBU12eXb8yaTjJ1Fm4zP9/wxe+DCYR4DanI+DQD0F0NYSc/KOcVQloyfi
	 x7IAIZ9XxuB5EQbRMKAyrixyQ1fyBe02VNXQ0y/Wn/e/KI6KP6rsjlXwqFJrjLZrExw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793920457;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
	b=ktCpqzeCTwz7Dd2d8GeauSppjCYPYmdkuqkqr9Dy8riv5H7mtqYt//yioZk2KLk4W2b4
	 Q55KiY8JhpRwWFPUtl3k5/eqOtvSpCBYHOPRtgNM5Wfblu7bM5l0CyfhT+ubu+EcDjMk+
	 dqhW+ICpBFd0fD3j2crAskLAxBAaXrAj5OrKnenV6YT04yObJ9RF2dcEbgxQmzRpIjjUk
	 QZp4xORXt4af3g2Z4uVajWhu883MfPwHJxeg9Xg0OioUGxPyBszn6JeEHhXtbwSI3PLlh
	 gVAMmDZkPtcDUtKshF/xTzBgHY0MTqPKX6/WEwY1SkN+2qKJQACmLDny9+YdJA5w5NA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=paul-moore.com;
	spf=pass smtp.mailfrom=paul-moore.com;
	dkim=pass header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=IU6i1Fwv;
	arc=fail smtp.remote-ip=209.85.215.174
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46F09606A32E
	for <netdev@vger.kernel.org>; Thu,  5 Nov 2026 23:14:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46F09606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=paul-moore.com header.i=@paul-moore.com header.a=rsa-sha256 header.s=google header.b=IU6i1Fwv
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-cc758830601so23317a12.2
        for <netdev@vger.kernel.org>; Thu, 05 Nov 2026 15:14:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793920456; cv=none;
        d=google.com; s=arc-20260327;
        b=R9UxkbzpUxCCHRP44j2y0c6jcRLbd1fENW2Xpsk3lj26qcktkBVhN68VH6njy11IgM
         jrMPE1CMOru5jyq7FoDA7pLhaC5nn+NSaactLVb8Lf0IloC/VDduoY3GJkce76OxvQBZ
         I3B30YCaxSwLitlS4+jOWfP3FdzKwd9Dm0mWRJQ2buK/FBQcCmr23pAN9oev1UsGXPHY
         CsfAVhceGjL6P0Rv+JJKpco0aSp8YGDaW6DlkbZuAUJhWoCXnzxCjlsLkez9UhY7tOvz
         zgkRMHfXXj0BSr6TXXt5KpSVGNyhwEHfCbb/W8HHAk7VmPZd/nH9SspymMUx9qN/2Mgb
         RWgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        fh=LvEpFEHflYRnhRJG4qqEcFkkiYYUQTGkBWjqTRW1uN0=;
        b=Vc1nzNA5INDAFTDVT8oiW8Xxr4JcCp7Pj0xe4Q7JK0Vu3HVEwOVgV/tMfEigrTYNQq
         jKo24d4nElaTwOV3uOVkH1Xv9JuwZPnc5dOWUYjlPfVv2Ewoiuj8kXRQivJER9DOS7/L
         YTu17Eo0DYpW5d/Mwey9z3lfQKLNZkmilAanZ3ePVlFxS+YDXHwylykPvsQTo23BL8f2
         WRTU4Oyn+vEEiLuLjDM8nNxGbuLkdJHIkD4bfW1bntFV+FW9O9H9LIUc7+wG/PeD19lm
         zu9YtbAQj4q563qMtzCYO2rI4Y5Q/A1vwjb1Nx1X4R4QsNpuCsQs2281Qwg32R/ipWoW
         VIcw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1793920456; x=1794525256; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        b=IU6i1Fwv/0w/cks1e2nfs6t6sk022zL/8GvQwys2lPo33xKyfU4+rlcYd/DQAZEHG/
         pOKIazGTVuNB5nr366kMh62Z8mKuK+0wykvjpk6nMnF62dQEPqXhVYv3AiAUQh2yheQg
         Wv57SCnVaPWXfP0Spf5ZrgQ+6Qros/0dGKzT5Ct8KPvTnGxmERS9srU07KlGSKT3u7rc
         WSDGWK1HJ7ZHGpFoQ0kLcdKEj3NsCe6oNqECA6Dmye2YgKsYtmlI/U8g/CwAwltsgKHy
         7lk6f9CpVk0uzXD9qAsG8lDByv90XfisBUHNR3hzhw22DDDhGO8biMGoTBxSg1pPVUNx
         pPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793920456; x=1794525256;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=mGiD8zQqMuzCkGXAZBtgumh8HlT9rNPiWNa35MXqkeQ=;
        b=PzQZ/Ok+BpIPn3twygX3+/6lvnQHUk5wET0+CmWzimFXEiq8abBY7+umt02ATaslWB
         VP2YvGV67a8cF9yqPz0+7CaV/de9axZtwFp0nXfcpD8AGbuwFW+N/im3uBkoKG3ZDs6L
         SocvYvWZ1HHgIEQUcAUSx6diRA8AdsMl4uT/p8LaPf37wVI9vLkmSKe40C1wR1ilIm+l
         gOb2MkIILpk4kR7zYwiyV/ZNyE6NLLSkKDnOmLM+CqSjdZa2ik65pwtWCGcXnp0On1+K
         awbJUubHycHTtu8qE+8DQWZpX+9CdzrtnHHQ9iNLJo5P6kFgb9jH4VBfL5SB5oI6i/Of
         cj8Q==
X-Forwarded-Encrypted: i=1; AKwUvBxDmr07nUnMXM/YP1wMw5wwtqv/dtEaPIfbtjtf50DRscc4AmtuznJajqePFMhLb4yJdawl93s=@vger.kernel.org
X-Gm-Message-State: APuU4Z+IIuT5g0PYZN60bidzoesiNHObpIoFTrJl3Vwf20YoOAXXYrlk
	vJQEXlCs2juNRFkFnbBeyoHbyCg2sYlHHfibmTKCzTZIP4LM+qxuzugzkMFtyz3xPaWvHTLJR/D
	lauiTG74rLyFKyLP+NVVDaq0EB3xY4VNbhEx9Pf/S
X-Gm-Gg: AYBFou0k/VgCXC9SDjI17oZO7HTMXVgjwI1FeDLQzN3Lm1OkCmhYDsBQNskYWdc2ByT
	+8Ai5fU4ZBYKCIsCPCxKrQxNcxaJ4hb/Cx2Kmj1CYDJpE0CMbzH18pRbw0a9MTj3Q9lE+PNKFYd
	qcq3FZyBxeBuLwK7TNFgfTwTCcAc0JGdHzdo9k0nr2E0+Kyz6QoTrXQhUKEuxGN7bp+J7xeCZGy
	sXvaka9MCw58tM16GRPUKTgRgzUPpxRe6qxcKHpWuwB0pawhz0fCrNBA0qFITlyzmsNsMIzDzY4
	/0osocMik89VrckKrn9rkgKAA1tebFr/lP0/jLoIw1EH3m3YoeUyVS1yWDMT9DgBPhP2G4waNAn
	2zcX0e29ORQaVcHntM5jX9+ifat/HIlGV5s6SEhPxhLadtYglTjuEdzfgP9Ki0RkSljqK
X-Received: by 2002:a17:90b:48cf:b0:3ad:a462:f07f with SMTP id
 98e67ed59e1d1-3b0db6e8ca3mr534231a91.45.1793920456567; Thu, 05 Nov 2026
 15:14:16 -0800 (PST)
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Post: <mailto:netdev@vger.kernel.org>
List-Help: <mailto:netdev+help@vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
List-Owner: <mailto:netdev+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261105-late-2026-mmap_prepare-v1-0-c56aadfbab8a@kernel.org> <20261105-late-2026-mmap_prepare-v1-7-c56aadfbab8a@kernel.org>
In-Reply-To: <20261105-late-2026-mmap_prepare-v1-7-c56aadfbab8a@kernel.org>
From: Paul Moore <paul@paul-moore.com>
Date: Thu, 5 Nov 2026 18:14:04 -0500
X-Gm-Features: AclHuK-Yq9Ya_gmjsTlhf760be1vg51BQVbAOtNinoyo6VpZvAmG2k73A1wV2Mc
Message-ID: <CAHC9VhQcmX09Do8BmY-HYJEWKiw7Tf-ZB=EEr9K6t5dBzk0SSQ@mail.gmail.com>
Subject: Re: [PATCH 07/14] selinuxfs: convert mmap hooks to mmap_prepare
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Juergen Gross <jgross@suse.com>, Stefano Stabellini <sstabellini@kernel.org>, 
	Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>, 
	Shrikanth Hegde <sshegde@linux.ibm.com>, Haiyang Zhang <haiyangz@microsoft.com>, 
	Wei Liu <wei.liu@kernel.org>, Dexuan Cui <decui@microsoft.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, 
	=?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Jarkko Sakkinen <jarkko@kernel.org>, 
	Dave Hansen <dave.hansen@linux.intel.com>, Thomas Gleixner <tglx@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Jan Kara <jack@suse.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, =?UTF-8?B?T25kcmVqIE1vc27DocSNZWs=?= <omosnacek@gmail.com>, 
	Joel Stanley <joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>, 
	Ryan Chen <ryan_chen@aspeedtech.com>, Billy Tsai <billy_tsai@aspeedtech.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Abel Vesa <abelvesa@kernel.org>, Jens Wiklander <jenswi@kernel.org>, 
	Sumit Garg <sumit.garg@kernel.org>, Scott Branden <scott.branden@broadcom.com>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Richard Cochran <richardcochran@gmail.com>, 
	David Woodhouse <dwmw2@infradead.org>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@kernel.org>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, xen-devel@lists.xenproject.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	kvm@vger.kernel.org, linux-hyperv@vger.kernel.org, 
	virtualization@lists.linux.dev, linux-sgx@vger.kernel.org, 
	selinux@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-arm-msm@vger.kernel.org, 
	op-tee@lists.trustedfirmware.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 5, 2026 at 4:07=E2=80=AFPM Lorenzo Stoakes (ARM) <ljs@kernel.or=
g> wrote:
>
> Move from the deprecated mmap hook to the new mmap_prepare hook for the
> policy and status files.
>
> The policy file only sets VMA flags and operations. The status file remap=
s
> a single page, so use the PFN remap mmap action to do so.
>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>
> ---
>  security/selinux/selinuxfs.c | 24 +++++++++++-------------
>  1 file changed, 11 insertions(+), 13 deletions(-)

See my comment in the cover letter.  I'd prefer to take this via the
SELinux tree so it can be included in all of our SELinux testing for
v7.5, but if this has to go through a single tree with the rest of the
changes, here is my ACK.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com
